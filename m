Return-Path: <netdev+bounces-177506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E3A7061B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCA13A4E83
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83671A23B0;
	Tue, 25 Mar 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CVA05s6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdpxsQGL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184B1990AB
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918961; cv=none; b=Z5HH+Or0LGIlHp/oKyWzwhOXSC25ip6jMBlXv1BPaicAZlWHkar8LUWrzGRdl6rc5VYeUE/gjwkQkEza7JsXgTIMrZ5Ur/tlEG2gJgQ3aojKYrTgDqQVpXPoGDmR+6ki0nLmVZJUsk63JmZjjtTXXsrOhOVQK1hd5og/LX1p6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918961; c=relaxed/simple;
	bh=baRaR0+5vJHHgE22T8Y0a4aIiQdCYnxz+TLrZboWH3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUSIni+34pDtIsKLHOTZtOrlMjBua1bdVHhYTgyUg4FOT+vmL7dEpxLOBBEeQTEAjXupwNpv6HsGDA3lr0p8yM4aiWFPEUsW9eQXNowDQAU1uoH9ucwCLd5dxYWAwbRcdFGk6qHPQovzMeTWl+b0YQwYTPEN+a6SnboEv8jAAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CVA05s6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdpxsQGL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAC0B1140212;
	Tue, 25 Mar 2025 12:09:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 12:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742918957; x=
	1743005357; bh=OVStg6MTlXqpkKBdUalJE1t5DHidQxBywguS5zNckmc=; b=C
	VA05s6imqwr+rTboeqb0f0HCTFfoAuJG5ohaSvplcKZ9iI5+3hiJazSSmBA8Bqur
	d74CV5SlSpQhSspV4lkDRI159UuLQctVVBs67eqIcELkTyX+mxmW7OBXPISlP3r6
	Wlmz/r1FnI/rnDeV6AqOtESkjgCFnSw/PXetK12ZMzvpPhcRQiDVdbTnBgcK+wEa
	u5+pfqY1SbEqYfxhjjQgtVld8DN+Im5cRlQ05Vgl9IyqKwfFfvQ00ZvwO6HYszU3
	5/m75mVNajXbYNUUbZeNEKzqlsPelzyjXfYGeP3+QaEsbHudvGrzCCmDTgmfgTu2
	cAhTRpWGAOU0T8sTce2Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742918957; x=1743005357; bh=OVStg6MTlXqpkKBdUalJE1t5DHidQxBywgu
	S5zNckmc=; b=tdpxsQGL1wvYcGjPCyS+ubG96+j+1CzR9kLu54AQcOuma1ve4mo
	iSzcSmXWZPdPSpSqZZxaKj/ZGXcfy1zkjwnfjzCus2398iT67MIL8IzeMmwUu1Pn
	+fVZesBavHK9F6BuEKzB+7ShkuAs8Z4aINuGfy0wlEAsiJbiQkdGLMPAM1yufG2r
	LYUsdUYPBLr4AI1akCp4ZhfyYnb2cL+rcwJkRg8IQkIXqNC9vLF/6yG6VrotcUYz
	9KrK11uvmlfO5267i5ND8a3SbmgqJmuu+R3TTkxDXM0PyeFMe9J78r78PH79yWzu
	Ycbg13cRJWFzDltGWkFJdQ3Fm2Mkl8pzU9A==
X-ME-Sender: <xms:LdXiZyAzdzr3kZbFAKvY0GzRIEgvza1XuXjnzKJsDzTuhKF6PakD4Q>
    <xme:LdXiZ8igJSZLqw2lZFrB6nz46OZzQIHmlTVUedR8mHykUB8BR9eL4yw0w-DjOF986
    BJ5tky1bEuj1JFgeNI>
X-ME-Received: <xmr:LdXiZ1l9OawcpzYuJo4peHyMF1XCp3SxmeQYt14-_RyhNKXleRfGwBatZDy_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgefhffdtvedugfekffejvdeiieel
    hfetffeffefghedvvefhjeejvdekfeelgefgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivght
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    vghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhope
    gushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LdXiZwzBB_xY44Gs21BIQasybeec5o4nR1Vcjdir5-YjAfJ7Qe3K_w>
    <xmx:LdXiZ3S-EeK4LGs9weaI2Uox8BfDPFMUa3RZQJEvEX2La8lfzKAJ1w>
    <xmx:LdXiZ7brgN6yv143WXTFsABVe489tI3dj1SELAKYTRm9uCrPCRo1mw>
    <xmx:LdXiZwRyDyOtB_6w9jHQpICkf4N4zx55hPImM91-GIBn3ySCemDvOQ>
    <xmx:LdXiZ888_yMKr7taCyhL1Fx4r8s08j9b0JOpKY7BgkKgk3Z5JfnWnAbn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 12:09:16 -0400 (EDT)
Date: Tue, 25 Mar 2025 17:09:14 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 2/5] udp_tunnel: fix compile warning
Message-ID: <Z-LVKpVcH_epgV9B@krikkit>
References: <cover.1742557254.git.pabeni@redhat.com>
 <5c4df4171225ab664c748da190c6f2c2f662c48b.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c4df4171225ab664c748da190c6f2c2f662c48b.1742557254.git.pabeni@redhat.com>

2025-03-21, 12:52:53 +0100, Paolo Abeni wrote:
> Nathan reported that the compiler is not happy to use a zero
> size udp_tunnel_gro_types array:
> 
>   net/ipv4/udp_offload.c:130:8: warning: array index 0 is past the end of the array (that has type 'struct udp_tunnel_type_entry[0]') [-Warray-bounds]
>     130 |                                    udp_tunnel_gro_types[0].gro_receive);
>         |                                    ^                    ~
>   include/linux/static_call.h:154:42: note: expanded from macro 'static_call_update'
>     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
>         |                                                 ^~~~
>   net/ipv4/udp_offload.c:47:1: note: array 'udp_tunnel_gro_types' declared here
>      47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
>         | ^
>   1 warning generated.
> 
> In such (unusual) configuration we should skip entirely the
> static call optimization accounting.
> 
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/cover.1741718157.git.pabeni@redhat.com/T/#m6e309a49f04330de81a618c3c166368252ba42e4
> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

