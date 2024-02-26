Return-Path: <netdev+bounces-74896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C3867385
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A501C24D9F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47C1CD1B;
	Mon, 26 Feb 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXC3s54D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DE1DA37
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947605; cv=none; b=MyXlV903IkGJRL7kVJPmOfj8KVRJIHoURJnHTsbar/FKADz1e7mUo+r/XJYcYWIXmmmYGCV8SQdyXeoo4gf8bC1aGTD85CFNDEfTudxG7Mex1H6hVxNrq03AzpxJ93fsC1sry3LJgqIGqlpk5095hl5yNB8vhFmSkuc8SCqgZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947605; c=relaxed/simple;
	bh=BnmMdMHAlEH+x/WqFnPc2GH04rs8IjEIwETpAK+E4jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNY0y4JNHDlBzVNQsp6cfd6QTc6cc8XdkLuCh0fArPkUdrfIzZAbiGLgdDpraFnOdTdF7+KF9PWmg30Gp3sCGCnPBi0Il/AcdDOJteZL10IuoixFvFUW71vWLNx4mmVG05wQKb+mg6IiFAUoXRGEigNbmcldNFObEgIlfal1L5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXC3s54D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708947602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pk1S1hcXRiyLAqKGVaDPZz+GAsi0qdiFZMPKrBdq2ss=;
	b=gXC3s54DCWstElPUSWsQdNP/JXlDwEflJEQ9zYbmCN3GQ9Zxxm+/ISNTf8BH0+dO5BMvFh
	yeuLpsUdXIjwDrEtiQdN4gQJ2y66F0yci5XUTK21BsBiHLVd/6keM312W3WjznglytrSve
	pFKvcslMATLAMlcYivgjm5yeXsJBavY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-djMY0iNOMqSe0OEUpECH_Q-1; Mon, 26 Feb 2024 06:40:01 -0500
X-MC-Unique: djMY0iNOMqSe0OEUpECH_Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d8d208be9so2103924f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947600; x=1709552400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk1S1hcXRiyLAqKGVaDPZz+GAsi0qdiFZMPKrBdq2ss=;
        b=P7zFljTxYh3GDWffPbz1t6QgPoRTP2qEXNUyrRawFU5STqbk95+23fmtwlrcrFkXx5
         3bH6yM3BzpVREhGteFS4SYuMbh83wEQQ3m1iLyjty7iWoz6tWUjmvahw5qYEMRqklWNd
         ySXXq/R+s6FXRgNpKLtMS/HADJjpZZSrBfptEEatZogPPjzQxti3WhA8qK/nDC3fveBN
         SfmM5nlG/X6hiXjaMtystOBpdSe9OpW6jeHhVihMcEvlVHZnZt+DxJXfUM3ToaYbhLjf
         zrimLaMc984p4eqWH/QASYiGfiaGSElxsd4Q5/qFAtgRS/G/G6OctjV1TzJ5qWNp7gbX
         5hGg==
X-Forwarded-Encrypted: i=1; AJvYcCWUyA9Z9YeDLRR4bIo5l0nwPpU0dIW0M+e50ttRVzeWFXU47Yz7nkbWNJC87QqRrkiv2BI7RegY5AGF7s8YucQ01IQXyv8O
X-Gm-Message-State: AOJu0YzrE9HRlKM59G+ekVbmv2uugNsCBj75ShDPyoRWspKnVMHy8e+j
	+svkeWUm0U+kSICd8w+wR3e/oVu8fP2Cltc7MlG6mdV4isb9pWNrpDR3Oj80KuCIc7KEWPNWMZi
	Mg92XTW658pa7jTCb1TT+LsKkXUW0sKf8E/IDM0KKSFgecFHYnd8iSQ==
X-Received: by 2002:adf:fd4e:0:b0:33d:b00f:55d6 with SMTP id h14-20020adffd4e000000b0033db00f55d6mr4360684wrs.11.1708947600397;
        Mon, 26 Feb 2024 03:40:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHck4p3uXeHajw1myMIhKAgNjWkI+m4W92MBSoWHWH8S0POOhphx6vNF8LhEQpBtbRig8bkRA==
X-Received: by 2002:adf:fd4e:0:b0:33d:b00f:55d6 with SMTP id h14-20020adffd4e000000b0033db00f55d6mr4360654wrs.11.1708947599949;
        Mon, 26 Feb 2024 03:39:59 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d4044000000b0033b7ce8b496sm7903763wrp.108.2024.02.26.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:39:59 -0800 (PST)
Date: Mon, 26 Feb 2024 06:39:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226063843-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708939451.7601678-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708939451.7601678-3-xuanzhuo@linux.alibaba.com>

On Mon, Feb 26, 2024 at 05:24:11PM +0800, Xuan Zhuo wrote:
> On Sun, 25 Feb 2024 03:38:48 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Feb 23, 2024 at 04:27:26PM +0800, Xuan Zhuo wrote:
> > > If the xsk is enabling, the xsk tx will share the send queue.
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode.
> > >
> > > cmd:
> > >     sh samples/pktgen/pktgen_sample01_simple.sh -i eth0 \
> > >         -s 16 -d 10.0.0.128 -m 00:16:3e:2c:c8:2e -n 0 -p 100
> > > CPU:
> > >     Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz
> > >
> > > Machine:
> > >     ecs.g7.2xlarge(Aliyun)
> > >
> > > before:              1600010.00
> > > after(no-premapped): 1599966.00
> > > after(premapped):    1600014.00
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 132 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7715bb7032ec..b83ef6afc4fb 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -146,6 +146,25 @@ struct virtnet_rq_dma {
> > >  	u16 need_sync;
> > >  };
> > >
> > > +struct virtnet_sq_dma {
> > > +	union {
> > > +		struct virtnet_sq_dma *next;
> > > +		void *data;
> > > +	};
> > > +
> > > +	u32 num;
> > > +
> > > +	dma_addr_t addr[MAX_SKB_FRAGS + 2];
> > > +	u32 len[MAX_SKB_FRAGS + 2];
> > > +};
> > > +
> > > +struct virtnet_sq_dma_head {
> > > +	/* record for kfree */
> > > +	void *p;
> > > +
> > > +	struct virtnet_sq_dma *free;
> > > +};
> > > +
> > >  /* Internal representation of a send virtqueue */
> > >  struct send_queue {
> > >  	/* Virtqueue associated with this send _queue */
> > > @@ -165,6 +184,8 @@ struct send_queue {
> > >
> > >  	/* Record whether sq is in reset state. */
> > >  	bool reset;
> > > +
> > > +	struct virtnet_sq_dma_head dmainfo;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > @@ -368,6 +389,95 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> > >  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
> > >  }
> > >
> > > +static struct virtnet_sq_dma *virtnet_sq_unmap(struct send_queue *sq, void **data)
> > > +{
> > > +	struct virtnet_sq_dma *d;
> > > +	int i;
> > > +
> > > +	d = *data;
> > > +	*data = d->data;
> > > +
> > > +	for (i = 0; i < d->num; ++i)
> > > +		virtqueue_dma_unmap_page_attrs(sq->vq, d->addr[i], d->len[i],
> > > +					       DMA_TO_DEVICE, 0);
> > > +
> > > +	d->next = sq->dmainfo.free;
> > > +	sq->dmainfo.free = d;
> > > +
> > > +	return d;
> > > +}
> > > +
> > > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq,
> > > +						int nents, void *data)
> > > +{
> > > +	struct virtnet_sq_dma *d;
> > > +	struct scatterlist *sg;
> > > +	int i;
> > > +
> > > +	if (!sq->dmainfo.free)
> > > +		return NULL;
> > > +
> > > +	d = sq->dmainfo.free;
> > > +	sq->dmainfo.free = d->next;
> > > +
> > > +	for_each_sg(sq->sg, sg, nents, i) {
> > > +		if (virtqueue_dma_map_sg_attrs(sq->vq, sg, DMA_TO_DEVICE, 0))
> > > +			goto err;
> > > +
> > > +		d->addr[i] = sg->dma_address;
> > > +		d->len[i] = sg->length;
> > > +	}
> > > +
> > > +	d->data = data;
> > > +	d->num = i;
> > > +	return d;
> > > +
> > > +err:
> > > +	d->num = i;
> > > +	virtnet_sq_unmap(sq, (void **)&d);
> > > +	return NULL;
> > > +}
> >
> >
> > Do I see a reimplementation of linux/llist.h here?
> >
> >
> > > +
> > > +static int virtnet_add_outbuf(struct send_queue *sq, u32 num, void *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (sq->vq->premapped) {
> > > +		data = virtnet_sq_map_sg(sq, num, data);
> > > +		if (!data)
> > > +			return -ENOMEM;
> > > +	}
> > > +
> > > +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> > > +	if (ret && sq->vq->premapped)
> > > +		virtnet_sq_unmap(sq, &data);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> >
> > Mate? The popular south african drink?
> >
> > > +{
> > > +	struct virtnet_sq_dma *d;
> > > +	int num, i;
> > > +
> > > +	num = virtqueue_get_vring_size(sq->vq);
> > > +
> > > +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);
> > > +	if (!sq->dmainfo.free)
> > > +		return -ENOMEM;
> >
> >
> > This could be quite a bit of memory for a large queue.  And for a bunch
> > of common cases where unmap is a nop (e.g. iommu pt) this does nothing
> > useful at all.  And also, this does nothing useful if PLATFORM_ACCESS is off
> > which is super common.
> >
> > A while ago I proposed:
> > - extend DMA APIs so one can query whether unmap is a nop
> 
> 
> We may have trouble for this.
> 
> dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
> 		size_t offset, size_t size, enum dma_data_direction dir,
> 		unsigned long attrs)
> {
> 	const struct dma_map_ops *ops = get_dma_ops(dev);
> 	dma_addr_t addr;
> 
> 	BUG_ON(!valid_dma_direction(dir));
> 
> 	if (WARN_ON_ONCE(!dev->dma_mask))
> 		return DMA_MAPPING_ERROR;
> 
> 	if (dma_map_direct(dev, ops) ||
> 	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
> 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> 	else
> 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> 	kmsan_handle_dma(page, offset, size, dir);
> 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
> 
> 	return addr;
> }
> 
> arch_dma_map_page_direct will check the dma address.
> So we can not judge by the API in advance.
> 
> Thanks.

So if dma_map_direct is false we'll still waste some memory.
So be it.


> 
> 
> 
> >   and whether sync is a nop
> > - virtio wrapper taking into account PLATFORM_ACCESS too
> >
> > then we can save all this work and memory when not needed.
> >
> >
> >
> > > +
> > > +	sq->dmainfo.p = sq->dmainfo.free;
> > > +
> > > +	for (i = 0; i < num; ++i) {
> > > +		d = &sq->dmainfo.free[i];
> > > +		d->next = d + 1;
> > > +	}
> > > +
> > > +	d->next = NULL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> > >  			    struct virtnet_sq_free_stats *stats)
> > >  {
> > > @@ -377,6 +487,9 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> > >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > >  		++stats->packets;
> > >
> > > +		if (sq->vq->premapped)
> > > +			virtnet_sq_unmap(sq, &ptr);
> > > +
> > >  		if (!is_xdp_frame(ptr)) {
> > >  			struct sk_buff *skb = ptr;
> > >
> > > @@ -890,8 +1003,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> > >  			    skb_frag_size(frag), skb_frag_off(frag));
> > >  	}
> > >
> > > -	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > > -				   xdp_to_ptr(xdpf), GFP_ATOMIC);
> > > +	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
> > >  	if (unlikely(err))
> > >  		return -ENOSPC; /* Caller handle free/refcnt */
> > >
> > > @@ -2357,7 +2469,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> > >  			return num_sg;
> > >  		num_sg++;
> > >  	}
> > > -	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
> > > +	return virtnet_add_outbuf(sq, num_sg, skb);
> > >  }
> > >
> > >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > @@ -4166,6 +4278,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
> > >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > >  		__netif_napi_del(&vi->rq[i].napi);
> > >  		__netif_napi_del(&vi->sq[i].napi);
> > > +
> > > +		kfree(vi->sq[i].dmainfo.p);
> > >  	}
> > >
> > >  	/* We called __netif_napi_del(),
> > > @@ -4214,6 +4328,15 @@ static void free_receive_page_frags(struct virtnet_info *vi)
> > >
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >  {
> > > +	struct virtnet_info *vi = vq->vdev->priv;
> > > +	struct send_queue *sq;
> > > +	int i = vq2rxq(vq);
> > > +
> > > +	sq = &vi->sq[i];
> > > +
> > > +	if (sq->vq->premapped)
> > > +		virtnet_sq_unmap(sq, &buf);
> > > +
> > >  	if (!is_xdp_frame(buf))
> > >  		dev_kfree_skb(buf);
> > >  	else
> > > @@ -4327,8 +4450,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  		if (ctx)
> > >  			ctx[rxq2vq(i)] = true;
> > >
> > > -		if (premapped)
> > > +		if (premapped) {
> > >  			premapped[rxq2vq(i)] = true;
> > > +			premapped[txq2vq(i)] = true;
> > > +		}
> > >  	}
> > >
> > >  	cfg.nvqs      = total_vqs;
> > > @@ -4352,6 +4477,9 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  		vi->rq[i].vq = vqs[rxq2vq(i)];
> > >  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
> > >  		vi->sq[i].vq = vqs[txq2vq(i)];
> > > +
> > > +		if (vi->sq[i].vq->premapped)
> > > +			virtnet_sq_init_dma_mate(&vi->sq[i]);
> > >  	}
> > >
> > >  	/* run here: ret == 0. */
> > > --
> > > 2.32.0.3.g01195cf9f
> >


