Return-Path: <netdev+bounces-297894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Ey2IXEdKmrZiwMAu9opvQ
	(envelope-from <netdev+bounces-297894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74866DD41
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=ixzaoqVl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297894-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297894-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06123160141
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538DA2DB78C;
	Thu, 11 Jun 2026 02:19:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587012D3A75;
	Thu, 11 Jun 2026 02:19:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144376; cv=none; b=E4hsqw6IVC8MfmAhAqeJSnUEmWOaZpqj/wbo0BlThFH13glbKSd4Mz4Smeyc3Xx0zeQblX8dj3BIzerGzz77OinXCyASJi6aUbhd5QlQjhWr1ayPOT8xMuMOoI2o3Q6s6EXFPmwLL+OxNOWBQvmJzFtLBsK/Oq9Cb5YCvbcK3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144376; c=relaxed/simple;
	bh=ohBD7T1JgaazoP0A4h0fIVfGYj8iyEv0bobf5aak09Y=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ctgAQcbsq7KlpD0h8T+Wff78Kv8BwppAWZBVel2d2/8i+Cn5O2F0f0EN9MwCvObq46UQqaxvHpu1GgAWkWuZbHBWOU3T/QS0VTgi1A6Dun+71wZHV1nwHAq2KcD0GXPkGLXF8NrwzroM0x6L3cPcrP35WhuBixUgjNbcl9BPHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ixzaoqVl; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781144365; h=Message-ID:Subject:Date:From:To;
	bh=3+YL61YLNP1oJQZrFdy9vPrItM3azFHydrfA78eswbw=;
	b=ixzaoqVlh5e2FRtE3OXHSaUP/vTN46+c1hEBkbboDzgsDLvXLB1XrueFmeHDudAAx7SCnMf52O4Ma3SJG9dETZNTKyR+57F8sNNVgYAW/ID2K3nSHTO1IDhrpNGIbDYn2LNstaij98fU/LTXevv1iMhNhRyTEEww5Ik++EfjVbM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4c0N2Y_1781144364;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4c0N2Y_1781144364 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 10:19:25 +0800
Message-ID: <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet frag loop
Date: Thu, 11 Jun 2026 10:18:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 minhquangbui99@gmail.com,
 bestswngs@gmail.com,
 Xiang Mei <xmei5@asu.edu>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20260610232936.1176094-1-xmei5@asu.edu>
 <20260610232936.1176094-2-xmei5@asu.edu>
In-Reply-To: <20260610232936.1176094-2-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297894-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB74866DD41

On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> This is a robustness hardening patch. The slow-path frag loop in
> page_to_skb() walks the page chain via page->private until the
> device-reported len is consumed, implicitly trusting that len fits the
> chain. It does not stop when the chain is exhausted (page becomes NULL
> at the tail), nor when nr_frags reaches the end of the static
> skb_shinfo()->frags[MAX_SKB_FRAGS] array.
>
> Both bounds are needed: the chain length is big_packets_num_skbfrags + 1
> pages, which for an MTU-driven configuration can be well below
> MAX_SKB_FRAGS, so neither guard implies the other.
>
> Make the loop self-defending so it no longer relies on the caller having
> validated len: stop once the chain is exhausted, and never index past
> MAX_SKB_FRAGS. No functional change for well-formed input.

At this point, we are assuming that len represents the correct packet length. If
there is a bug in the validation, it can be fixed, just like in your previous
patch. Indeed, not checking nr_frags is also based on the overall design.
However, I do not recommend adding this kind of enhancement. If we follow
this logic, we would end up adding similar code in many other places, which
doesn't make much sense.

Thanks.

>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: robustness patch
>
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index afe73eda1491..518c22fa1b68 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	}
>
>  	BUG_ON(offset >= PAGE_SIZE);
> -	while (len) {
> +	while (len && page) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> +
> +		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
> +			break;
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>  				frag_size, truesize);
>  		len -= frag_size;
> --
> 2.43.0
>

