Return-Path: <netdev+bounces-229757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D875BE0931
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B6BD4E0FE7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5528BA81;
	Wed, 15 Oct 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SDAlH8RV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejhgGfK3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224624E4A1
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558671; cv=none; b=X04s8NBFxui1VmvAUVuJKZUkH1H9rIaGkX+cGfY7JsG8NLYCiimAzEHHy11on0Po9LbCHBXciSBn/QyZ/Z1F4qXBpq+U3OAr+kVfSmb7MRab7kOd87wEdJ6C/W+rJ6bV9NCOQBceyv2N5luQeUDfEapb8JWUggUhl1jbzY4Koxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558671; c=relaxed/simple;
	bh=PJUJnoYeA5w1Ae58zoEnn6bVrYcrFL0tv61A4SS6iAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEhb3cvU1rLcn/3T8xpNq3CyCWEjivWom0vTm+n1VpfroPwjv+uODUNHaRiHqqMEgl2iDKvyqUIV5M7F8GD33qo0oZzhxHJZKrG02pz/zov0TryGM1py18PASLlLSgLM53iFyn85wUVGNv9S1aW72GEkxhYcZ7HM17Two46Ij54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SDAlH8RV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejhgGfK3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 02C9B1D00154;
	Wed, 15 Oct 2025 16:04:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 15 Oct 2025 16:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760558666; x=
	1760645066; bh=U1j0HZ9G4dvGS60QtFN/2FsItJLixYeAckVtyuncVSk=; b=S
	DAlH8RVk9sQQEPQjYwQNQz8nY6csO67MyrjcGYDgp4niqbEVqoL9kADKiBtOrX56
	z0pdP50DUF8pmwwmezqrzXkzJAISKV672uV3WRlSmqKLNn40gLgkVPrZLyjdeM8a
	Kg4VdXVYob7yrJyhh1lyrYzJpIoyGGQqePNWC+1aA99eArC0e/m4FJRY/LLluhpT
	n7HcwpWvCfgwxxY0Rx3Lot50WD9Xc1J2uK5q2z+aFvALeoyTT/V4+Quo3tY8RN14
	JiCNFTumhwY8w+5Dterlw1nd6Q59ri5lw1YDnaBcEP9bZQ6U/26TaAPQpFTZCL82
	uTVORJSEFqCsaFKANFoEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760558666; x=1760645066; bh=U1j0HZ9G4dvGS60QtFN/2FsItJLixYeAckV
	tyuncVSk=; b=ejhgGfK3b8/UMTJJ+GRVP7F+/wqww7Z88tGGs8tRUxN13fl3FLE
	vOSubfrmXIcs1JcpxAPi5JefkGytdI7RdXQN5NMzBedUvNd4aCv4ixz88KFgc3M5
	AyOJoFgZdDSMgkt1G/X3sRguBPuu0viq9/JAz9tRGsPn+FTOND/MUznypPtpxiqW
	EoOsmmpz+NxAJ2aWYk8kAIBpD9l45g08IM3ZG5AjUViz33cFImwRr5ep8a247u8h
	wbJsLrGNpZVwPe4cHTGfDFYnQi5purXOV39MVlJiW9s2GORNu6O7Jp85LrQpr67B
	ZvnoiOBxjcdnUHU0+gDFSfnxt8ODqfpSFDw==
X-ME-Sender: <xms:Sf7vaGbap5FpGHlZzGBRVl1y9jH2BMrdbpx7IngyPQar9qVUFN4M1w>
    <xme:Sf7vaF-IgxRYLO6NYuDa8WKEPPgxvtomrwRZS1UjFT_ARpwnx5E1bxkEn5Z12nh3C
    zcQWUVbV48qY8T6e0-0SXgeNf5DOiBrSMRJaBvveXOJ4gSg38w6VaY>
X-ME-Received: <xmr:Sf7vaFajwHVJwcYsFL3m3GlRCXCwq-x_EpnrGKVgQsBoigWESXxEayqg6mt7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehh
    ohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhgssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvrhhitgdrughumhgriigvthesghhmrghilhdrtghomhdprhgtph
    htthhopehmkhhusggvtggvkhesshhushgvrdgtii
X-ME-Proxy: <xmx:Sf7vaPfQgY0TxN7QarweDd_2dHCwarHTTnOxjsLPfVqiydv11-_sKQ>
    <xmx:Sf7vaCm71RMtt9kP7ZpadWEk2iTRV30UjJ9Rk3vXHUJ2G1kIXxgR3Q>
    <xmx:Sf7vaP399WgeekRCntomQQ7dvxXx1ZFZJIcXfEAVfwo9XOmW5lRDvg>
    <xmx:Sf7vaLfb6tHQ6QHkXa-zih7R0poel1zgkoP0La-S8x92f0NLY7zssA>
    <xmx:Sv7vaH-ay1AkguXetidaGxAPazS36gW23iDowSPKrimgMJz2bBU-UELJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 16:04:25 -0400 (EDT)
Date: Wed, 15 Oct 2025 22:04:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Michal Kubecek <mkubecek@suse.cz>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v3 net] udp: do not use skb_release_head_state() before
 skb_attempt_defer_free()
Message-ID: <aO_-R4TlViHk_HB7@krikkit>
References: <20251015052715.4140493-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015052715.4140493-1-edumazet@google.com>

2025-10-15, 05:27:15 +0000, Eric Dumazet wrote:
> Michal reported and bisected an issue after recent adoption
> of skb_attempt_defer_free() in UDP.
> 
> The issue here is that skb_release_head_state() is called twice per skb,
> one time from skb_consume_udp(), then a second time from skb_defer_free_flush()
> and napi_consume_skb().
> 
> As Sabrina suggested, remove skb_release_head_state() call from
> skb_consume_udp().
> 
> Add a DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb)) in skb_attempt_defer_free()
> 
> Many thanks to Michal, Sabrina, Paolo and Florian for their help.
> 
> Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
> Reported-and-bisected-by: Michal Kubecek <mkubecek@suse.cz>
> Closes: https://lore.kernel.org/netdev/gpjh4lrotyephiqpuldtxxizrsg6job7cvhiqrw72saz2ubs3h@g6fgbvexgl3r/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Michal Kubecek <mkubecek@suse.cz>
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Florian Westphal <fw@strlen.de>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Eric.

-- 
Sabrina

