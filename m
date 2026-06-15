Return-Path: <netdev+bounces-299293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aj4YKrJqL2ptAAUAu9opvQ
	(envelope-from <netdev+bounces-299293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:00:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D9682F4C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:00:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=i+3MDgXc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299293-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299293-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90B31300565C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FABE26738B;
	Mon, 15 Jun 2026 02:59:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B91A683A;
	Mon, 15 Jun 2026 02:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492399; cv=none; b=DnNs9tl6dp7HmF6UnaPj+uiDu1TFIMYnZlIZ2DH1fUSst9vjrCTtRNa9o2mxJfuCx74+vY4OxEeZ8SIwZAld4E5f5iLV7LMkKwtlVwjnJuJMThUB2QFRz4L+1AgAIzORWKSreuCw/+4OwaDSpQkcEX4FNURvorecwbnw4mFfacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492399; c=relaxed/simple;
	bh=57yKZQz0buXNFzXkhUqk+nu0gQIuDjIWbyAXCJFgNMg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=XfpLb07nyouVV+dITcBdpeXrWmHwuFJrSJUZamwG58FOg4cyMekZhn2UkGwxSiQ1xXOhdpYslmDOt6uXjZF2qosuBJ1/6bhLlUYh60R7gedj9sHGP8roCLX7BsZ2PRyS6XTe/KyiSgpw2I68nfwKZs3bCnOPatNCZz7/Dyxwh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i+3MDgXc; arc=none smtp.client-ip=115.124.30.118
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781492389; h=Message-ID:Subject:Date:From:To;
	bh=Hs9gJmaIt2CsoVnPgGPaU+fHX1gP7oID7IO1t/2Ii+o=;
	b=i+3MDgXcu7D9CtgePdbfrNuTg00XC/XNEFjyKLgsGxWlGKo0hZvL1wYsbfzCP8+D94QEM8T+YL1PHdKPDCCH3sxcSpTQQtjPpDoDwFE0VhmPi6WFrlbBNPP8i6it6iWdDZw/ZS3/dYtJ5OEQcv4N8HIJyBwTWdSvw5u05tpIA00=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4ooTfR_1781492387;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4ooTfR_1781492387 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 10:59:48 +0800
Message-ID: <1781491685.0613394-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Mon, 15 Jun 2026 10:48:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: menglong8.dong@gmail.com
Cc: mst@redhat.com,
 jasowang@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 minhquangbui99@gmail.com,
 kerneljasonxing@gmail.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 eperezma@redhat.com
References: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260611025644.2431148-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299293-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:minhquangbui99@gmail.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:eperezma@redhat.com,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 145D9682F4C

On Thu, 11 Jun 2026 10:56:43 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dongml2@chinatelecom.cn>
>
> During packet receiving in virtio-net, the rq can be empty, which means
> "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> can be empty too, which means we can't allocate anything from
> xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
>
> However, if the user clean all the data in rx ring and fill the
> "fill ring" and check the XDP_RING_NEED_WAKEUP flag after
> xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
> napi will never be scheduled: the rx ring is empty, which means we will
> never receive a packet to trigger the further recv fill. The rx ring is
> empty now, so the user will not check the flag too.
>
> Fix this by set the XDP_RING_NEED_WAKEUP flag before
> xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.
>
> Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
> rq->vq.
>
> Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..4b5b3fa62008 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  				   struct xsk_buff_pool *pool, gfp_t gfp)
>  {
>  	struct xdp_buff **xsk_buffs;
> +	bool need_wakeup;
>  	dma_addr_t addr;
>  	int err = 0;
>  	u32 len, i;
>  	int num;
>
> +	need_wakeup = xsk_uses_need_wakeup(pool);
>  	xsk_buffs = rq->xsk_buffs;
>
> +	/* If both rq->vq and fill ring are empty, and then the user submit
> +	 * all the chunks to the fill ring and check the wake up flag
> +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> +	 * we will lose the chance to wake up the rx napi, so we have to
> +	 * set the need_wakeup flag here.
> +	 */
> +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> +		xsk_set_rx_need_wakeup(pool);

Is Condition A here too strict? We should trigger the wakeup under a wider range
of scenarios.

> +
>  	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>  	if (!num) {
> -		if (xsk_uses_need_wakeup(pool)) {
> +		if (need_wakeup) {
>  			xsk_set_rx_need_wakeup(pool);
>  			/* Return 0 instead of -ENOMEM so that NAPI is
>  			 * descheduled.
> @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  		}
>
>  		return -ENOMEM;
> -	} else {
> -		xsk_clear_rx_need_wakeup(pool);
>  	}
>
>  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  			goto err;
>  	}
>
> +	if (need_wakeup) {
> +		if (rq->vq->num_free)
> +			/* We have free buffers, so we'd better wake up the
> +			 * rx napi as soon as possible.
> +			 */
> +			xsk_set_rx_need_wakeup(pool);

Is the purpose of waking up RX NAPI to invoke try_fill_recv? However,
virtnet_poll does not call try_fill_recv directly. it is done
conditionally.

Thanks.


> +		else
> +			xsk_clear_rx_need_wakeup(pool);
> +	}
> +
>  	return num;
>
>  err:
> --
> 2.54.0
>

