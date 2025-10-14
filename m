Return-Path: <netdev+bounces-229055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F2BD794C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA553BCEC0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737029A31D;
	Tue, 14 Oct 2025 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="uYBg/4EL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPbWCE/6"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582F258EC8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423849; cv=none; b=Zw+ZKWl51pSGtk3k5PZh1fcAb90lzodnFQiYeX6KJypck1bbZk08BQ3dyF+PTGqd8GkcXUhUsvMcn5PtdvjD+T+OSz1r4ZSY00fEm4Hgne+bPLvf9tU+pv9tJDwj4bi8rMOP8fX2BVRlKhswPeX5dCP5MFshfbCqRokhDcRMw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423849; c=relaxed/simple;
	bh=ibQgSkoNKfjEinMbrU1UbHO7wYvQd772aT7SponiIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hge2rBqD8qqmSb6WA8LE61cpt3wBETMQoPiALDy2aNKoWcsIUQatNqu4DIaqwm8hNKfksGEv7B4XK31AbYTfbFnPdChmMsJPYYCpJcVMwRzpeCPywxlmtX5BMd4s7M9mQYg/fZ69EYAUHGuFrQoHHyn7ZCgHoIXBsUGo1dUA1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=uYBg/4EL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPbWCE/6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 30CBCEC0170;
	Tue, 14 Oct 2025 02:37:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Oct 2025 02:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760423845; x=
	1760510245; bh=QmuXo3+ZmKbt3wm+WDptWod43pu/kVhknWh/Wc8Zyes=; b=u
	YBg/4EL6oBmYHNz/esmaCfPdhyNLyKmDBRrcm0rbNkpqapxFmc9FxLUrxND4FxD/
	BawrD3mOsjJEX+iQd1DPcvQAxDeVGjK/fuJbUJXZ9vaG2DJe1V+BeJpAW1QcTjho
	T4DEh/9fQFNbboFyfze2ZQ0owdOz3FglUoJDK18e+Q8qJ906pCeOH/IF/AwUJdRe
	OfpnlmAJM9gg1lRc9H+ONVxQk1Sk6zaAO/9/Hz7rOYsy2nz0VTmA7cLEvGlaMLge
	dijcPe3sCoteSG1AWQZEk36S+jd0HdFnTHuy0+XlE8eGqNM5C5e3sJgnp4LxcN8a
	JzuMXlldUxVIGUIdyyhaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760423845; x=1760510245; bh=QmuXo3+ZmKbt3wm+WDptWod43pu/kVhknWh
	/Wc8Zyes=; b=WPbWCE/6iFXxiW+KakDW2gqSIaNM9hEwPilmAOGA7Wcl8ogsY9q
	8uV701Wr1Z1QkCzsnznB1k0r0GbDi8JbuDfWpfFeV5elBrbMLD3fDfxOHUhgsGpO
	UtVXfkimDo3pifcPbhZpp7MTV9t9tbFaMamCKumoRCOFIhk2OqP8dsvcqm81MEk/
	LYpW8AXr7Z2+fPF0BrLbbWbEDD5eSIaGSVtbenUAke4q71ug+3MyDtN0xNtNY4iT
	7zgGCQcKiT6MRPrWLLGxkJ7UMNIdZnwneAq/zP8QX6BdTWO+4I8oLQHJmDLHEJZF
	RLv5SXtleDeOIYC2n+sKkvgeQzKe9TbCG3A==
X-ME-Sender: <xms:pO_taBM-an_qc60vWOvb9fqhO7ufzpXdA4gtfSicpvr8VXhotJR58g>
    <xme:pO_taGhgOZq7RT07BRaIsA2ugS6WPHwir0l0BZUyHLMODpzI7Dp_KxsBIW8-Ao0Hf
    H7MD5_yukcBOSAUdv0mo8BbBwBSA0Hgl0d8OxwTFqGnnDiUOiVvLzs>
X-ME-Received: <xmr:pO_taD5RCc559DTH-Lj-RGjALDR5kbT0YUBNwiru1KxSsxQpW1lrZ48HrtYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhho
    rhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvghrihgtrdguuhhmrgiivghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhkuhgsvggtvghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:pO_taN0Aqs9flNOPvRhXulLd0_BOTdjEaFQQ2KK4QGk1ziN9FbgfiA>
    <xmx:pO_taOsbZRudy7emKM1dIApD5pbRLQok0imTOhMGGN4djqFyIwaxdg>
    <xmx:pO_taD67Zxnpl2SQNiMvgktJunRXfts0Lc7y_KGkW6nN28Z4ylz3cA>
    <xmx:pO_taKdpky0EYwxPaa4LZfoc6I_RoP2Ur8-9cy_zKzQupHQRGRwZOA>
    <xmx:pe_taInDdE0uVTn8GKBfNgc9IbTtDGnjwFgB8N3ardfTvkN7RM7uQ2iZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 02:37:23 -0400 (EDT)
Date: Tue, 14 Oct 2025 08:37:22 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
Message-ID: <aO3voj4IbAoHgDoP@krikkit>
References: <20251014060454.1841122-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014060454.1841122-1-edumazet@google.com>

2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> Michal reported and bisected an issue after recent adoption
> of skb_attempt_defer_free() in UDP.
> 
> We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6979f
> ("tcp: drop secpath at the same time as we currently drop dst")

I'm not convinced this is the same bug. The TCP one was a "leaked"
reference (delayed put). This looks more like a double put/missing
hold to me (we get to the destroy path without having done the proper
delete, which would set XFRM_STATE_DEAD).

And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
x->tunnel as we delete x").

> Many thanks to Michal and Sabrina.
> 
> Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
> Reported-and-bisected-by: Michal Kubecek <mkubecek@suse.cz>
> Closes: https://lore.kernel.org/netdev/gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/ipv4/udp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..3f05ee70029c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1709,6 +1709,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	int dropcount;
>  	int nb = 0;
>  
> +	secpath_reset(skb);

See also the comment for udp_try_make_stateless:

/* all head states (dst, sk, nf conntrack) except skb extensions are
 * cleared by udp_rcv().
 *
 * We need to preserve secpath, if present, to eventually process
 * IP_CMSG_PASSSEC at recvmsg() time.
 *
 * Other extensions can be cleared.
 */


It looks like this patch would re-introduce the problem fixed by
dce4551cb2ad ("udp: preserve head state for IP_CMSG_PASSSEC").

> +
>  	rmem = atomic_read(&sk->sk_rmem_alloc);
>  	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>  	size = skb->truesize;
> -- 
> 2.51.0.788.g6d19910ace-goog
> 

-- 
Sabrina

