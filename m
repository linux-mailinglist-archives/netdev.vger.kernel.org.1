Return-Path: <netdev+bounces-95327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A48C1E65
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7D8283C19
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539741487F7;
	Fri, 10 May 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iZXNPv6z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF41361
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323814; cv=none; b=u0OMHjqPTzjyvwL58ku2QQjXirPsCurZraEX/xd90mYwZDfLpBsn1RGa5SuCYCaFj3pxS6z28i7bwikR7CJT9GEVFuv0t6e04ZLLdtXWmZEjllf93D/H4rDSJ6yE0ykDoaO1FQ1nvjkJpzlbSxwy0+JE257ftg5C0qPXKjlViaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323814; c=relaxed/simple;
	bh=at2lnNgiXNrdTa5JV/yNDZYavo9jvs+VSjr7gNOeMQ8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=i9pD1b67ChxK/iZA26P5UIMh/LMxtIbsT2wDbGDllD446khGwNZElv1IxIawDirIfL+DXIEQhfxScHHO+cEpaaHJqHskQFDcxXhjO0GBSZiGiwNArJnoY93iIQCoX0z4ynyQJbS7L6Snh59goI5+zgCVvPMF+iurnkvvMM1ibT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iZXNPv6z; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715323803; h=Message-ID:Subject:Date:From:To;
	bh=rV8GXyrJ07GSYwwl1SJfRsZvo+s7i6qK5asbBHBEaKM=;
	b=iZXNPv6z1LPEYuza8niG9XxC+Iuu0gSgmZX065Rt9izdZWiCFQKCsyeEhasYyChQPPGEt1MmFuGZjKmWQJCm9SdP1bUGtiPPQQEGJ/kMMnObSh+5NBLdTPOw9VYXpYGzPVzFmqCViHvhL3hyrix7r5BowvGunW9uyfdMRcc/xk8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W69bk6G_1715323801;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W69bk6G_1715323801)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 14:50:02 +0800
Message-ID: <1715323692.749715-1-xuanzhuo@linux.alibaba.com>
Subject: Re: RE: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake counters
Date: Fri, 10 May 2024 14:48:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 Jiri Pirko <jiri@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-3-danielj@nvidia.com>
 <1715304096.399735-3-xuanzhuo@linux.alibaba.com>
 <CH0PR12MB858086B1DEB3F5D4015D937EC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB858086B1DEB3F5D4015D937EC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 10 May 2024 03:35:51 +0000, Dan Jurgens <danielj@nvidia.com> wrote:
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, May 9, 2024 8:22 PM
> > To: Dan Jurgens <danielj@nvidia.com>
> > Cc: mst@redhat.com; jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
> > virtualization@lists.linux.dev; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jiri Pirko
> > <jiri@nvidia.com>; Dan Jurgens <danielj@nvidia.com>;
> > netdev@vger.kernel.org
> > Subject: Re: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake
> > counters
> >
> > On Thu, 9 May 2024 11:32:16 -0500, Daniel Jurgens <danielj@nvidia.com>
> > wrote:
> > > Add a tx queue stop and wake counters, they are useful for debugging.
> > >
> > > $ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \ --dump
> > > qstats-get --json '{"scope": "queue"}'
> > > ...
> > >  {'ifindex': 13,
> > >   'queue-id': 0,
> > >   'queue-type': 'tx',
> > >   'tx-bytes': 14756682850,
> > >   'tx-packets': 226465,
> > >   'tx-stop': 113208,
> > >   'tx-wake': 113208},
> > >  {'ifindex': 13,
> > >   'queue-id': 1,
> > >   'queue-type': 'tx',
> > >   'tx-bytes': 18167675008,
> > >   'tx-packets': 278660,
> > >   'tx-stop': 8632,
> > >   'tx-wake': 8632}]
> > >
> > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > ---
> > >  drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
> > >  1 file changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > 218a446c4c27..df6121c38a1b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -95,6 +95,8 @@ struct virtnet_sq_stats {
> > >  	u64_stats_t xdp_tx_drops;
> > >  	u64_stats_t kicks;
> > >  	u64_stats_t tx_timeouts;
> > > +	u64_stats_t stop;
> > > +	u64_stats_t wake;
> > >  };
> > >
> > >  struct virtnet_rq_stats {
> > > @@ -145,6 +147,8 @@ static const struct virtnet_stat_desc
> > > virtnet_rq_stats_desc[] = {  static const struct virtnet_stat_desc
> > virtnet_sq_stats_desc_qstat[] = {
> > >  	VIRTNET_SQ_STAT_QSTAT("packets", packets),
> > >  	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
> > > +	VIRTNET_SQ_STAT_QSTAT("stop",	 stop),
> > > +	VIRTNET_SQ_STAT_QSTAT("wake",	 wake),
> > >  };
> > >
> > >  static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] =
> > > { @@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct
> > virtnet_info *vi,
> > >  	 */
> > >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > >  		netif_stop_subqueue(dev, qnum);
> > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > +		u64_stats_inc(&sq->stats.stop);
> > > +		u64_stats_update_end(&sq->stats.syncp);
> >
> > How about introduce two helpers to wrap
> > netif_tx_queue_stopped and netif_start_subqueue?
> >
> > >  		if (use_napi) {
> > >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > >  				virtqueue_napi_schedule(&sq->napi, sq-
> > >vq); @@ -1022,6 +1029,9 @@
> > > static void check_sq_full_and_disable(struct virtnet_info *vi,
> > >  			free_old_xmit(sq, false);
> > >  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > >  				netif_start_subqueue(dev, qnum);
> > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > +				u64_stats_inc(&sq->stats.wake);
> > > +				u64_stats_update_end(&sq->stats.syncp);
> >
> > If we start the queue immediately, should we update the counter?
>
> I intentionally only counted the wakes on restarts after stopping the queue.
> I don't think counting the initial wake adds any value since it always happens.

Here, we start the queue immediately after the queue is stopped.
So for the upper layer, the queue "has not" changed the status,
I think we do not need to update the wake counter.

Thanks.


>
> >
> > Thanks.
> >
> > >  				virtqueue_disable_cb(sq->vq);
> > >  			}
> > >  		}
> > > @@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct
> > receive_queue *rq)
> > >  			free_old_xmit(sq, true);
> > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > +			if (netif_tx_queue_stopped(txq)) {
> > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > +				u64_stats_inc(&sq->stats.wake);
> > > +				u64_stats_update_end(&sq->stats.syncp);
> > > +			}
> > >  			netif_tx_wake_queue(txq);
> > > +		}
> > >
> > >  		__netif_tx_unlock(txq);
> > >  	}
> > > @@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct
> > *napi, int budget)
> > >  	virtqueue_disable_cb(sq->vq);
> > >  	free_old_xmit(sq, true);
> > >
> > > -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > +		if (netif_tx_queue_stopped(txq)) {
> > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > +			u64_stats_inc(&sq->stats.wake);
> > > +			u64_stats_update_end(&sq->stats.syncp);
> > > +		}
> > >  		netif_tx_wake_queue(txq);
> > > +	}
> > >
> > >  	opaque = virtqueue_enable_cb_prepare(sq->vq);
> > >
> > > @@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct
> > > net_device *dev,
> > >
> > >  	tx->bytes = 0;
> > >  	tx->packets = 0;
> > > +	tx->stop = 0;
> > > +	tx->wake = 0;
> > >
> > >  	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
> > >  		tx->hw_drops = 0;
> > > --
> > > 2.44.0
> > >
>

