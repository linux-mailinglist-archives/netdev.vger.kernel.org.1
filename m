Return-Path: <netdev+bounces-300943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0dOEIdKiOGreewcAu9opvQ
	(envelope-from <netdev+bounces-300943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D97716AC33E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:49:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=tap6l4BQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300943-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300943-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0317A3021EAF
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A293290BA;
	Mon, 22 Jun 2026 02:45:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA178136358;
	Mon, 22 Jun 2026 02:45:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096322; cv=none; b=f9KZuUdQqw+PZTcmNfNLnp5MfBmwvl+snsq27kx1Kkc4mUHlO1OKtcV4ji4zR835JeCoyAfjxW2wKaFPGABXC7WlsRlrHsqEvCI/n4aSxpJwaSnervSIpAkqjACF4yoctn+NE2FTCzlzyVqLw0uwmw0zGl+NXAam++eig0rwzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096322; c=relaxed/simple;
	bh=cCnB8SHaTELhBMM2vNSo8nome0XmO9U28qrztuN+eZY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Nxt8899l6Xz3lh1bT38/FDB+2EIAwhumPIPUz9sYL0ub4AIQ5J5UQJkO4VpcT2WDphyaW54pqcgKzsiirbyKP4kaUw1Tz9HnCrtc1TxHWpTtxqzuzr1V6whgLE1u/TvSGVcirQQL4PgxqSwL9GLeqNpv696uKSVoWlfKk80PIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tap6l4BQ; arc=none smtp.client-ip=115.124.30.99
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782096313; h=Message-ID:Subject:Date:From:To;
	bh=6l8D54I1qhjeNtbRwIBHC97XmtG0Dd57mu48xVCfLtk=;
	b=tap6l4BQF3pctbMQkK0yhd+dZQVQifrYHOJztpJ83oIAnOZnavwIWe9qoNUFG1gZxDnuYmPWtp2hTm4SGcIiDoA73+wUlj8Yi2io4xi/X7VUBeMgYo/xyEyhBCpwBwdsnH+t7r4VUk25nNm2jW3srV47t/r+d63fTkqGfBMTZEo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X5GhaeY_1782096312;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X5GhaeY_1782096312 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 10:45:13 +0800
Message-ID: <1782096043.3540094-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 10:40:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 eperezma@redhat.com
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260616115912.513183-1-dongml2@chinatelecom.cn>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:eperezma@redhat.com,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300943-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D97716AC33E

On Tue, 16 Jun 2026 19:59:12 +0800, Menglong Dong <menglong8.dong@gmail.com> wrote:
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> in the tx path for example: we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
>
> We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> Otherwise, we will clear the wakeup flag.
>
> Race condition is considered for tx path.
>
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")

This is not a bug, so we do not need this.
And you post this to net-next.


> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - remove the confusing comment
>
> v2:
> - add the Fixes tag
> ---
>  drivers/net/virtio_net.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..6e099edef6e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1440,8 +1440,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtnet_sq_free_stats stats = {};
>  	struct net_device *dev = vi->dev;
> +	int sent, vring_size;
> +	bool need_wakeup;
>  	u64 kicks = 0;
> -	int sent;
>
>  	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
>  	 * free_old_xmit().
> @@ -1451,8 +1452,25 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	if (stats.xsk)
>  		xsk_tx_completed(sq->xsk_pool, stats.xsk);
>
> +	vring_size = virtqueue_get_vring_size(sq->vq);
> +	need_wakeup = xsk_uses_need_wakeup(pool);
> +
> +	if (need_wakeup && vring_size == sq->vq->num_free)
> +		xsk_set_tx_need_wakeup(pool);

You need to comment this.


> +
>  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
>
> +	if (need_wakeup) {
> +		if (vring_size == sq->vq->num_free)
> +			/* we can't wake up by ourself, and it should be done
> +			 * by the user.
> +			 */
> +			xsk_set_tx_need_wakeup(pool);
> +		else
> +			/* we can wake up from skb_xmit_done() */
> +			xsk_clear_tx_need_wakeup(pool);
> +	}
> +
>  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>  		check_sq_full_and_disable(vi, vi->dev, sq);


After fixed above comments, you can add:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.


>
> @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	u64_stats_add(&sq->stats.xdp_tx,  sent);
>  	u64_stats_update_end(&sq->stats.syncp);
>
> -	if (xsk_uses_need_wakeup(pool))
> -		xsk_set_tx_need_wakeup(pool);
> -
>  	return sent;
>  }
>
> --
> 2.54.0
>

