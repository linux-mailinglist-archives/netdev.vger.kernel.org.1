Return-Path: <netdev+bounces-192225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE28ABEFFA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B37A3582
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358B23C505;
	Wed, 21 May 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O8986z6W"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903B248195;
	Wed, 21 May 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820048; cv=none; b=c4PxbYF72u39VIyxSfhu9pzcPTWjUDpLDNsmTUuhsIRkodhy4nC9XMGxPekW7iB1akKK077l5+TpEbAjeYK73rxNsOczNHjLoNukrvGH/sxwvgjjyD5zAaoZhqVS61cVMSERQixJjLG6gW02qdV5L3JFq6OaByPPmvRyG3v1g4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820048; c=relaxed/simple;
	bh=6MklwD4j40E48FymB+qMAWubmyldDoIUnAjfIwDOqsw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oUVKiNIRbGoZYF/PiqjVbHw+spLW5LBe5ihreVEmLNX2SPXgUPXXvm/OXx2LpnxxyFkJQPV0uCYf68z0Aop70tVkU9g6NudkYqejidsDvgPtg2MpJKYqJE6zZU8vBlHdkLsHQu8QNt2KCLdPLDPc1swN/aGfjl+Ndubb+1WNRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O8986z6W; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747820042; h=Message-ID:Subject:Date:From:To;
	bh=4klK27j5BAbxyRg1TaacVwZnbxVU14qKElYWcSUrg+E=;
	b=O8986z6W+X7UU0fNpOkrLePsJ1mfbhy2wFikFR/XXAGLWu8xQIUzeiQ6T56FjLbpJiDWhxWjsiZSrjQ1do0jTie4pkf2VqZ/9pjrnrseAzCa7IWEXfept4Cu25IP1ghE8EmhW2oZEr+fAiO6TcXyZz66744XJZMc8zJ/fMSubso=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WbRDZA._1747820041 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 May 2025 17:34:01 +0800
Message-ID: <1747820036.241548-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Cleanup '2+MAX_SKB_FRAGS'
Date: Wed, 21 May 2025 17:33:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250521092236.661410-1-lvivier@redhat.com>
 <20250521092236.661410-3-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-3-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 21 May 2025 11:22:35 +0200, Laurent Vivier <lvivier@redhat.com> wrote:
> Improve consistency by using everywhere it is needed
> 'MAX_SKB_FRAGS + 2' rather than '2+MAX_SKB_FRAGS' or
> '2 + MAX_SKB_FRAGS'.
>
> No functional change.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..ff4160243538 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1084,7 +1084,7 @@ static bool tx_may_stop(struct virtnet_info *vi,
>  	 * Since most packets only take 1 or 2 ring slots, stopping the queue
>  	 * early means 16 slots are typically wasted.
>  	 */
> -	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> +	if (sq->vq->num_free < MAX_SKB_FRAGS + 2) {
>  		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>
>  		netif_tx_stop_queue(txq);
> @@ -1116,7 +1116,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>  			/* More just got used, free them then recheck. */
>  			free_old_xmit(sq, txq, false);
> -			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> +			if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
>  				netif_start_subqueue(dev, qnum);
>  				u64_stats_update_begin(&sq->stats.syncp);
>  				u64_stats_inc(&sq->stats.wake);
> @@ -2998,7 +2998,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>  			free_old_xmit(sq, txq, !!budget);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
>  			if (netif_tx_queue_stopped(txq)) {
>  				u64_stats_update_begin(&sq->stats.syncp);
>  				u64_stats_inc(&sq->stats.wake);
> @@ -3195,7 +3195,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	else
>  		free_old_xmit(sq, txq, !!budget);
>
> -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +	if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
>  		if (netif_tx_queue_stopped(txq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			u64_stats_inc(&sq->stats.wake);
> --
> 2.49.0
>

