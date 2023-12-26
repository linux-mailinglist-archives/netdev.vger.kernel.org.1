Return-Path: <netdev+bounces-60232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF981E560
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 06:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B78F1C213C9
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 05:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF574BA80;
	Tue, 26 Dec 2023 05:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035244B5D6
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VzGemBJ_1703570365;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzGemBJ_1703570365)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 13:59:26 +0800
Message-ID: <1703570229.7040236-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio_net: fix missing dma unmap for resize
Date: Tue, 26 Dec 2023 13:57:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20231212081141.39757-1-xuanzhuo@linux.alibaba.com>
 <20231212032514-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231212032514-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 12 Dec 2023 03:26:41 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Dec 12, 2023 at 04:11:41PM +0800, Xuan Zhuo wrote:
> > For rq, we have three cases getting buffers from virtio core:
> >
> > 1. virtqueue_get_buf{,_ctx}
> > 2. virtqueue_detach_unused_buf
> > 3. callback for virtqueue_resize
> >
> > But in commit 295525e29a5b("virtio_net: merge dma operations when
> > filling mergeable buffers"), I missed the dma unmap for the #3 case.
> >
> > That will leak some memory, because I did not release the pages referred
> > by the unused buffers.
> >
> > If we do such script, we will make the system OOM.
> >
> >     while true
> >     do
> >             ethtool -G ens4 rx 128
> >             ethtool -G ens4 rx 256
> >             free -m
> >     done
> >
> > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >
> > v1: rename to virtnet_rq_free_buf_check_dma()
>
> The fact that we check does not matter what matters is
> that we unmap. I'd change the name to reflect that.


Hi Michael:

I see one "[GIT PULL] virtio: bugfixes". But this is not in the list.

So I hope this is your list.

Thanks.


>
>
> >
> >  drivers/net/virtio_net.c | 60 ++++++++++++++++++++--------------------
> >  1 file changed, 30 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d16f592c2061..58ebbffeb952 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -334,7 +334,6 @@ struct virtio_net_common_hdr {
> >  	};
> >  };
> >
> > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> >
> >  static bool is_xdp_frame(void *ptr)
> > @@ -408,6 +407,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> >  	return p;
> >  }
> >
> > +static void virtnet_rq_free_buf(struct virtnet_info *vi,
> > +				struct receive_queue *rq, void *buf)
> > +{
> > +	if (vi->mergeable_rx_bufs)
> > +		put_page(virt_to_head_page(buf));
> > +	else if (vi->big_packets)
> > +		give_pages(rq, buf);
> > +	else
> > +		put_page(virt_to_head_page(buf));
> > +}
> > +
> >  static void enable_delayed_refill(struct virtnet_info *vi)
> >  {
> >  	spin_lock_bh(&vi->refill_lock);
> > @@ -634,17 +644,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> >  	return buf;
> >  }
> >
> > -static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> > -{
> > -	void *buf;
> > -
> > -	buf = virtqueue_detach_unused_buf(rq->vq);
> > -	if (buf && rq->do_dma)
> > -		virtnet_rq_unmap(rq, buf, 0);
> > -
> > -	return buf;
> > -}
> > -
> >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> >  {
> >  	struct virtnet_rq_dma *dma;
> > @@ -744,6 +743,20 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  	}
> >  }
> >
> > +static void virtnet_rq_free_buf_check_dma(struct virtqueue *vq, void *buf)
> > +{
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	struct receive_queue *rq;
> > +	int i = vq2rxq(vq);
> > +
> > +	rq = &vi->rq[i];
> > +
> > +	if (rq->do_dma)
> > +		virtnet_rq_unmap(rq, buf, 0);
> > +
> > +	virtnet_rq_free_buf(vi, rq, buf);
> > +}
> > +
> >  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> >  {
> >  	unsigned int len;
> > @@ -1764,7 +1777,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >  		pr_debug("%s: short packet %i\n", dev->name, len);
> >  		DEV_STATS_INC(dev, rx_length_errors);
> > -		virtnet_rq_free_unused_buf(rq->vq, buf);
> > +		virtnet_rq_free_buf(vi, rq, buf);
> >  		return;
> >  	}
> >
> > @@ -2392,7 +2405,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
> >  	if (running)
> >  		napi_disable(&rq->napi);
> >
> > -	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
> > +	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_buf_check_dma);
> >  	if (err)
> >  		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
> >
> > @@ -4031,19 +4044,6 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  		xdp_return_frame(ptr_to_xdp(buf));
> >  }
> >
> > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > -{
> > -	struct virtnet_info *vi = vq->vdev->priv;
> > -	int i = vq2rxq(vq);
> > -
> > -	if (vi->mergeable_rx_bufs)
> > -		put_page(virt_to_head_page(buf));
> > -	else if (vi->big_packets)
> > -		give_pages(&vi->rq[i], buf);
> > -	else
> > -		put_page(virt_to_head_page(buf));
> > -}
> > -
> >  static void free_unused_bufs(struct virtnet_info *vi)
> >  {
> >  	void *buf;
> > @@ -4057,10 +4057,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
> >  	}
> >
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > -		struct receive_queue *rq = &vi->rq[i];
> > +		struct virtqueue *vq = vi->rq[i].vq;
> >
> > -		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
> > -			virtnet_rq_free_unused_buf(rq->vq, buf);
> > +		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > +			virtnet_rq_free_buf_check_dma(vq, buf);
> >  		cond_resched();
> >  	}
> >  }
> > --
> > 2.32.0.3.g01195cf9f
>

