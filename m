Return-Path: <netdev+bounces-235479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8AC3139E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D63AB526
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC598322C7B;
	Tue,  4 Nov 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ATQvYgf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UgkXyd1G"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8F31DD8D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262850; cv=none; b=kzSYLMvUoYbrcLekhNuTgjMo21RLr2sN4aa4sjIsEJ/LiVWuC3HBedl1LiqdfWlTkt/vIJ3A0S6B5rRzmri5VBDZEwhkS7CQ+8+BuPWAF3d53rU7w1pNXrEa4mVNGl7DJZo/iOHUif7jkNYe6s9/cgoQrmtp4u3r8R1IVVv5MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262850; c=relaxed/simple;
	bh=N8NrSHxXuDSmXVUGSmRNSYe8R7expbUWkH4lgnyHXt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZCdbPrIn2Ar6pO8FIG0eWtWZc3aKByZXW8SG8dXIGHSOuPmtgSIXbMZg2AxHM8sbABzEHeIxDI+VrFVGSg28549X37v8cvKp/JIddgjA8ZR3KOxuLCqGVuRgBxwuEz/JXgUGPoVXhm2W+avGlDrPr3zuYlIGYBWwanDjmUZ4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ATQvYgf2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UgkXyd1G; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BE6CEEC02B2;
	Tue,  4 Nov 2025 08:27:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 04 Nov 2025 08:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762262845; x=
	1762349245; bh=pNuFFBJJJ7K/njfuppNjxl0XCDWWsX/OX9pfjgs+iDc=; b=A
	TQvYgf2jLXhPES6Yhc/1kmFy3KtdE28IAvRGAzOJtEII6STNnsXFbj8TP/2SF6nI
	9ad5MUUW0FRYZE0ZwnW93/1C0kOwuhxakfHXHD9lVI+1hxSYfNABF/aZ9JrmjME4
	CjfKka4wsHsv0fvS0BvgTdt1SoX14yDSZjgnHOZP2OkCkKmamqDIH71h/Kjtkhfx
	DTvVb2BjnJdr3wZLsvwA/4CBpNHMg7zyvw9r265TCSQlo6B06cclpjSKcZ2oAO8o
	zYKzck5VseJJu4Scopja0N/YGRHXVKQy1Ep7MFGIfrypad7GhzsSVrkTe1vWyUzW
	EGEqL8tsLDlBU3q6iCQcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762262845; x=1762349245; bh=pNuFFBJJJ7K/njfuppNjxl0XCDWWsX/OX9p
	fjgs+iDc=; b=UgkXyd1G9bCcsmbfqeV1f4jSOlV9/LjSTD6v316VdQHCTUDdWk0
	zMmUkf3gjBqIGkUfG5Ii7HrQiL+JjXDR5Jbu1khRomJMR3YS/UsGPWInPsvqrSZ1
	WsVUQpsqrI2La2YZvIXoBXSwQnt1ZJkHUwyV0AOnzq7nWK7X5v+Cs80pqZBzsQmD
	OELbidmY6V72BJQmCB5TIDFvLRcWQ2JE81dKDWkF9OsdgHwT00XcFn7ejk/OkL9T
	qB7bmfmLXOZfTiYOGqsIQZ+CkRHKPKgbEaoCWvNZ8rKxapqFwdy899SKx2GUp89j
	l9SwCOWJ6wCGyce6+jBpBjU6FdDIF9VMKnQ==
X-ME-Sender: <xms:Pf8JaQWh960nkbUl5P6f8Aoxk6I1ziiEclhXrQNCcFlIVewP-5eWXg>
    <xme:Pf8JacAEiAWp6wUzuoDbYrPAUA_inumgH5oBI3tJiuRkLusTFlvZKsfkp8HkoLZlW
    fTTjGzdlTQxNPEvHmPqqjBO-Typ_JAhmZs0C9g01SKSl8DifK2njm4>
X-ME-Received: <xmr:Pf8JaRyOrKS6B5g8gzhPtIDZ8CDZkbubItyqYz2wmVvA5f2An5qUsSQcJS2_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomh
X-ME-Proxy: <xmx:Pf8JaZAtwFe65dHzNsufCa9dl70HsdnmVurz0yt-2GgchFqbPjaSrg>
    <xmx:Pf8JaeZB5FAHST6YAW4QsCLeIOsM9XLvZ8mPjoJW23wT8YDHc4onDQ>
    <xmx:Pf8JaRg0_sLQ5O1aFPFzG-4zmqaoDZwBt8p59FVgL7BFOueoltRijw>
    <xmx:Pf8JaQ7I_Kwr0pAhzwjXe_nul7bFA-bOyOJM5Ar_mismFE8Rk77K-w>
    <xmx:Pf8JaQSCiss_fSi0XV92dn6O1kgdqpPzBlLbNbnZhWHFafPIe1eIOpje>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 08:27:24 -0500 (EST)
Date: Tue, 4 Nov 2025 14:27:22 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Message-ID: <aQn_Om--BOEkVKBL@krikkit>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
 <cb6455d7-a6d5-4a1d-940e-31cb9a4fc486@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb6455d7-a6d5-4a1d-940e-31cb9a4fc486@kernel.org>

2025-11-03, 09:47:09 -0700, David Ahern wrote:
> On 10/29/25 5:06 AM, Sabrina Dubroca wrote:
> > The kernel supports passing the XFRMA_SA_PCPU attribute when creating
> > a state (via NEWSA or ALLOCSPI). Add a "pcpu-num" argument, and print
> > XFRMA_SA_PCPU when the kernel provides it.
> > 
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> >  ip/ipxfrm.c        |  6 ++++++
> >  ip/xfrm_state.c    | 20 ++++++++++++++++++--
> >  man/man8/ip-xfrm.8 |  4 ++++
> >  3 files changed, 28 insertions(+), 2 deletions(-)
> > 
> 
> ...
> 
> > @@ -309,6 +309,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
> >  	bool is_if_id_set = false;
> >  	__u32 if_id = 0;
> >  	__u32 tfcpad = 0;
> > +	__u32 pcpu_num = -1;
> >  
> >  	while (argc > 0) {
> >  		if (strcmp(*argv, "mode") == 0) {
> 
> ...
> 
> > @@ -797,6 +805,7 @@ static int xfrm_state_allocspi(int argc, char **argv)
> >  	struct xfrm_mark mark = {0, 0};
> >  	struct nlmsghdr *answer;
> >  	__u8 dir = 0;
> > +	__u32 pcpu_num = -1;
> 
> 
> iproute2 follows net-next with reverse xmas tree ordering. I realize
> that is a bit hard for some of the code -- like ipxfrm.c.

Right, it wasn't obvious just looking at those functions in isolation.

> I fixed up these 2 to that ordering at least in the local scope and
> applied to iproute2-next

Thanks!

-- 
Sabrina

