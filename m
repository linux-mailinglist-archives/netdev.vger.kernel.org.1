Return-Path: <netdev+bounces-280394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBuvOEu36GmgPAIAu9opvQ
	(envelope-from <netdev+bounces-280394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:55:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 184AE4459CD
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7864E3011C6A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDE3CCFA0;
	Wed, 22 Apr 2026 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="WJru6VUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1xonv6m"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783035838E;
	Wed, 22 Apr 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776858952; cv=none; b=K/H510pabDR1tALaex4sjj19c+IPvvZtbDN9AgdwkzQTta7Dr/aGJ/ipqOinWFMaUeJl4U4b8NSgJvTWkLN58yKjKRRi7ZPo9+ylpbbuWmRcrrJkR7MDmmJODJkP5swECQBPy4BY893Hba/fiyyrMpbcqoVswxDf/1Rsh8ZNZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776858952; c=relaxed/simple;
	bh=G1+1EQSsWNcnUTrKLfjMERb26pauuO/yoKGxa4AFBGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge6+ppr+7e13DThDt3UQdkFLsYYbSru2qSQC0lHeOQnpGpFGMVWInKUhitqAYycjI/kpOJQkTMT7v34H5/vUBq/Uuo3WPsu3NXKVrH+4zAD5Cb/SC4rsffdXJ+R8lUq3op6dbeTEv9SZWuiPpB+Vu3sfrlWwTMbCEDqnp/5hqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=WJru6VUu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1xonv6m; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 711A514001A0;
	Wed, 22 Apr 2026 07:55:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 07:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1776858948; x=
	1776945348; bh=cE6qcalI4NpH2XIxc43jgp9IZurXmeMV3OvDy2KSTjc=; b=W
	Jru6VUucQcYO9dGABgMn6RzEV+u9BgWFLWwB3s0eJa7Au4dc/WfCzlk1HT0eFy7v
	o6sltQK8uRH346p+YOryPOmXBexKTJSeQ4XBJT35nHzkZfEBD4Ql0CjKGZlNTbrm
	/ipAhmi+Ry3Bbo8VtVLRTYrTnPS6Hgb+JRYE98o9wWijprJ7flr0oKIaZscpiYUd
	sIsOkk18F3xRuXLO3d8NhtGBDktApyn2dlANv3KhmPAiOysYLyrYs916SZjVcKG1
	jneHol380BEIQJUlZvh1s8hkqruXIZG3TaPTXLDw689Iw/zV85S1QmDsXxoiLo3t
	2kRKvMJ9iyj6Q1uQMlgBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776858948; x=1776945348; bh=cE6qcalI4NpH2XIxc43jgp9IZurXmeMV3Ov
	Dy2KSTjc=; b=K1xonv6mLeHYpilEIh6E+roXoqcV5YZeVVqYYKKB8nayRULepqx
	LSiPLc/n6R1wszd30Gn4jvwO1M5cGRWMd4dwD/rI+kfV1v3MG+FUBemKq25dpJXN
	lTcdDH1uM2VxogBvLTTAsQA9mQffNfimFpdTt/4hlFpIs8eaN0cXRURwI6dKbchK
	y4BoDm0XwB724OJ9omsaqP7KGb9R6ytgZFGbPL1jKwiI77MHoIhoxidqvr8BtsCj
	PPwiAS3IWpwonWTSnvYm9rNj4k3fUUGiEFeBGu2ztwCYVNlF6rU6vUARF0DcOMM3
	LMbnsit5KdUth2a5uX2NstzheHsyOgmPGXg==
X-ME-Sender: <xms:Q7foaXLgYPqv78waucHhJpyzaGIkdsV9i_JVZhyOws2izOKAKie2lQ>
    <xme:Q7foaTUNcCxwinVSgClhWyNrisYS5O_UJVhXODjRZiD2BH1LIAREQjoEydrSYeAbq
    O05YrG8JBzj98XmtgFc96BupC6aebdOc3JhtZEdGb-D4o02addC3gfu>
X-ME-Received: <xmr:Q7foabT_6UNofQ-LQiqn8AgqHdp485ffQxr3HeCXFUVdHw10tEtZs7qIsFoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshih
    shhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepueeuleevieefveefjeevhfeule
    efvefgveegkeffvdeugeduffevueekleelueejnecuffhomhgrihhnpehtrghgrdhnvght
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshguse
    hquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvdehudekuddvudegvddujeesshhtuhdrgihiughirg
    hnrdgvughurdgtnhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhn
    vghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfth
    drnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvth
    guvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q7foabAdxlp4yk15caD8Gbfd77Fa_T6tfcsILkLX3p63JBzRuDqOGQ>
    <xmx:Q7foaaIHlZqV306bDap2dDjiVv2z_NPJThDPSssgXsaT0611BwAh_g>
    <xmx:Q7foaeCejDIxxrnmv46SKZu09X2-tEmsupibsKXPmSiW5Ltp_xeCxQ>
    <xmx:Q7foaXsA6GIqGqJq6oQyKxb6ZTNVSO6JyqG0nh4zxyCEqjzr3fjTaw>
    <xmx:RLfoaQrTJuVlugQvxffolX1mRxtNN4wOrJ5uNCNIVFi8w7Nt3_LeJe5g>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:55:46 -0400 (EDT)
Date: Wed, 22 Apr 2026 13:55:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: udp: fix memory leak in udpv6_sendmsg error path
Message-ID: <aei3QDpiToAcYfR1@krikkit>
References: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280394-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.267];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xidian.edu.cn:email,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 184AE4459CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-22, 18:58:02 +0800, Mingyu Wang wrote:
> During fuzzing with failslab enabled, a memory leak was observed in the
> IPv6 UDP send path.
> 
> When sending via the lockless fast path (!corkreq), udpv6_sendmsg()
> calls ip6_make_skb() and assumes that the routing entry (dst_entry)
> reference has been stolen by the callee. However, if ip6_make_skb()
> fails early (e.g., due to an ENOMEM from memory allocation failure),
> it returns an error pointer without consuming the dst reference.

Not in all cases? If ip6_setup_cork() fails, we call
ip6_cork_release() which will release the dst. The MSG_PROBE path also
releases the dst. __ip6_flush_pending_frames() also looks like it does
that.

> Since udpv6_sendmsg() unconditionally jumps to the 'out_no_dst' label,
> the unconsumed dst_entry is never released, resulting in a memory leak.
> 
> Fix this by explicitly calling dst_release(dst) when ip6_make_skb()
> returns an error.
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

And this is missing a Fixes tag.

>  net/ipv6/udp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 15e032194ecc..b83ecfd729af 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1706,8 +1706,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  				   dst_rt6_info(dst),
>  				   msg->msg_flags, &cork);
>  		err = PTR_ERR(skb);
> -		if (!IS_ERR_OR_NULL(skb))
> +		if (!IS_ERR_OR_NULL(skb)) {
>  			err = udp_v6_send_skb(skb, fl6, &cork.base);
> +		} else {
> +			dst_release(dst);
> +		}
>  		/* ip6_make_skb steals dst reference */

This comment becomes really confusing after your patch.

>  		goto out_no_dst;
>  	}
> -- 
> 2.34.1
> 
> 

-- 
Sabrina

