Return-Path: <netdev+bounces-95255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C078C1C15
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F1428513B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972D137928;
	Fri, 10 May 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J74WtZIa"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1513A3E3
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304316; cv=none; b=uPPm3zFgizo5FSIZJ86A0SnD9UtfCOSNw0HvMK1ZBUjHdAuj8z4cEfIkyWAJhf+Za11XC6K1TeesdHaKpIQWdfSOwfWAvrbi4YdpZLmCQ5nryrkrGsvf2HGsuW9lCG2sDYaTY6aMzNfoBq9KerG43SOdP7MCMKpDj+NjObnrxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304316; c=relaxed/simple;
	bh=Oe5f/zedF4yt+G9FpAe91BUv8KzE6jf5kUtuhsJIRns=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=vFPcX+LiZKkVv9ruLay5MGPt5zp70Hyjaa59/NlolpskR82LibeXBhB9ZddDPH/9Rd2GTtJhW/9nPMDrapofZwhhO1Jit0WFNhNp1wcNxHTBrY7Fs9qt6H5pGA20PEEghP8UrLE+jPjyWRvJFh2C8LJd9TTP0ArgWNC4BuuxV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J74WtZIa; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715304311; h=Message-ID:Subject:Date:From:To;
	bh=c5sALY6ZcbL1IWlcHacdLYDGE+th34wKqm3+Kz6E6/M=;
	b=J74WtZIay50ab/Tegun4CrgmsX30grBdPNelOTbnruz1NM9RJG1PJ/h+g888jEI96aRLQw3bQXXXLTYfY2a7ciAyF6YwhKTE8EI7aJ9y1vj+UAwNEpMEoPpknulzHvqe2MdpBx8o2N/qlLp7HXGlk29nAMsC/Z0fWTX+l+BY1Ec=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W68Tj0F_1715304309;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W68Tj0F_1715304309)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 09:25:10 +0800
Message-ID: <1715304096.399735-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake counters
Date: Fri, 10 May 2024 09:21:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <virtualization@lists.linux.dev>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <jiri@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-3-danielj@nvidia.com>
In-Reply-To: <20240509163216.108665-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 9 May 2024 11:32:16 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Add a tx queue stop and wake counters, they are useful for debugging.
>
> $ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope": "queue"}'
> ...
>  {'ifindex': 13,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 14756682850,
>   'tx-packets': 226465,
>   'tx-stop': 113208,
>   'tx-wake': 113208},
>  {'ifindex': 13,
>   'queue-id': 1,
>   'queue-type': 'tx',
>   'tx-bytes': 18167675008,
>   'tx-packets': 278660,
>   'tx-stop': 8632,
>   'tx-wake': 8632}]
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..df6121c38a1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -95,6 +95,8 @@ struct virtnet_sq_stats {
>  	u64_stats_t xdp_tx_drops;
>  	u64_stats_t kicks;
>  	u64_stats_t tx_timeouts;
> +	u64_stats_t stop;
> +	u64_stats_t wake;
>  };
>
>  struct virtnet_rq_stats {
> @@ -145,6 +147,8 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
>  static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
>  	VIRTNET_SQ_STAT_QSTAT("packets", packets),
>  	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
> +	VIRTNET_SQ_STAT_QSTAT("stop",	 stop),
> +	VIRTNET_SQ_STAT_QSTAT("wake",	 wake),
>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] = {
> @@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>  		netif_stop_subqueue(dev, qnum);
> +		u64_stats_update_begin(&sq->stats.syncp);
> +		u64_stats_inc(&sq->stats.stop);
> +		u64_stats_update_end(&sq->stats.syncp);

How about introduce two helpers to wrap
netif_tx_queue_stopped and netif_start_subqueue?

>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -1022,6 +1029,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  			free_old_xmit(sq, false);
>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_subqueue(dev, qnum);
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.wake);
> +				u64_stats_update_end(&sq->stats.syncp);

If we start the queue immediately, should we update the counter?

Thanks.

>  				virtqueue_disable_cb(sq->vq);
>  			}
>  		}
> @@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  			free_old_xmit(sq, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +			if (netif_tx_queue_stopped(txq)) {
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.wake);
> +				u64_stats_update_end(&sq->stats.syncp);
> +			}
>  			netif_tx_wake_queue(txq);
> +		}
>
>  		__netif_tx_unlock(txq);
>  	}
> @@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	virtqueue_disable_cb(sq->vq);
>  	free_old_xmit(sq, true);
>
> -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +		if (netif_tx_queue_stopped(txq)) {
> +			u64_stats_update_begin(&sq->stats.syncp);
> +			u64_stats_inc(&sq->stats.wake);
> +			u64_stats_update_end(&sq->stats.syncp);
> +		}
>  		netif_tx_wake_queue(txq);
> +	}
>
>  	opaque = virtqueue_enable_cb_prepare(sq->vq);
>
> @@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct net_device *dev,
>
>  	tx->bytes = 0;
>  	tx->packets = 0;
> +	tx->stop = 0;
> +	tx->wake = 0;
>
>  	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
>  		tx->hw_drops = 0;
> --
> 2.44.0
>

