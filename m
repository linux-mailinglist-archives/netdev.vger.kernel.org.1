Return-Path: <netdev+bounces-111400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E872930CD0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 04:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A81B20C99
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 02:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465D79F3;
	Mon, 15 Jul 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pbZAsAVi"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730A847A;
	Mon, 15 Jul 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721011541; cv=none; b=raeBY6qUEx8FlappKze1DoRb4yLHvl2pOzwBfqKllZgA6Se0z7ASwbbLU+SD4FnOog4/EgMXOCFZdz2c+1B8ahEJEKKcp5+JRvl+7mFTCUPPT8Xv/G89JqJHnWs4RJnWebpAkMN5VXGQ7uGK3HdIzIGoLE0zaV5naXk91pSQNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721011541; c=relaxed/simple;
	bh=ctGWsdO0ej5tPQjRZHOPvi6pJHzhlFIKiR3w9xWi2hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3xNwIEcOX7A8UGqtac2tddU8bj6ZD7gYTggmk6Nerqlix0pCBVs+ZaocfKDB1ci8qkSl/ksL3eurT7uscF/ZvT1Ctm+vrnrI2rghHuNejU3BMDXZb2me/3oa9q6xm+7PmyA/Mm3X0No1JSo8MCo6ZFVlBIkiLd8DGd32CQpa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pbZAsAVi; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721011528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aFJAiJacnHMlZNMvKXDirjWe+OPAnESCR9uHIfCE5gE=;
	b=pbZAsAViEERhM5NVqoAQ8zgwkUQm0rB1wWYNplh50ruEo2jQ8bIylVA4yUg2kcutwZPqkJOHEuGsoJPitOKJyN1UJNxs/Un9gjLfHOqWtlxmy68eC0zAdeO1+cciiEPtz2hLYKRFsl7B8xf37xpw0QnXaoN8CkVFaVPIaRkxSiw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WAUnIPg_1721011527;
Received: from 30.221.148.126(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WAUnIPg_1721011527)
          by smtp.aliyun-inc.com;
          Mon, 15 Jul 2024 10:45:27 +0800
Message-ID: <dfd6b17e-ada5-41ce-8922-d97dd192ddb3@linux.alibaba.com>
Date: Mon, 15 Jul 2024 10:45:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, horms@kernel.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240712115325.54175-1-leitao@debian.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/7/12 下午7:53, Breno Leitao 写道:
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
>
> 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
>
> 	  __warn+0x12f/0x340
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  report_bug+0x165/0x370
> 	  handle_bug+0x3d/0x80
> 	  exc_invalid_op+0x1a/0x50
> 	  asm_exc_invalid_op+0x1a/0x20
> 	  __free_old_xmit+0x1c8/0x510
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  __free_old_xmit+0x1c8/0x510
> 	  __free_old_xmit+0x1c8/0x510
> 	  __pfx___free_old_xmit+0x10/0x10
>
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
>
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
>
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/virtio_net.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0b4747e81464..fb1331827308 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2341,7 +2341,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>   	return packets;
>   }
>   
> -static void virtnet_poll_cleantx(struct receive_queue *rq)
> +static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>   {
>   	struct virtnet_info *vi = rq->vq->vdev->priv;
>   	unsigned int index = vq2rxq(rq->vq);
> @@ -2359,7 +2359,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>   
>   		do {
>   			virtqueue_disable_cb(sq->vq);
> -			free_old_xmit(sq, txq, true);
> +			free_old_xmit(sq, txq, !!budget);
>   		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>   
>   		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> @@ -2404,7 +2404,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>   	unsigned int xdp_xmit = 0;
>   	bool napi_complete;
>   
> -	virtnet_poll_cleantx(rq);
> +	virtnet_poll_cleantx(rq, budget);
>   
>   	received = virtnet_receive(rq, budget, &xdp_xmit);
>   	rq->packets_in_napi += received;
> @@ -2526,7 +2526,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>   	txq = netdev_get_tx_queue(vi->dev, index);
>   	__netif_tx_lock(txq, raw_smp_processor_id());
>   	virtqueue_disable_cb(sq->vq);
> -	free_old_xmit(sq, txq, true);
> +	free_old_xmit(sq, txq, !!budget);
>   
>   	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
>   		if (netif_tx_queue_stopped(txq)) {

