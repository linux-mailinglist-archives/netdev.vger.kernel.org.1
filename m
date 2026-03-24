Return-Path: <netdev+bounces-271124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PdJAq+uwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:33:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB9D31816F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51503178866
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACD4035D7;
	Tue, 24 Mar 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="NobIAK46";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RkcFpcaZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029C30C60D;
	Tue, 24 Mar 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365518; cv=none; b=HSoKfxOnzTu8zELHbhZTQ4Sj4l8/t1/HgzyEMI+9g8Chu2lWxD3boQ6bpEXNQ9OOJPT/22Lpsy3aUhJ2MPVOT0nicWprn2g+6GDr6GUlaikIOsz8mxJc2jvDHGhUZ6uNubgHKAY5yNWrjWptGI5nm3vpO+XuISREML5UkKmPNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365518; c=relaxed/simple;
	bh=/3qMzl/kZ/3/MVIJaJoHytPt7GaNFhIrkE6OT1EEc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM1COHohqT1aLpAV+xXNMi625gkEPWR1ABkZJVVV6DYM+VdYo/skTYWrJag0nya8a77jIO3+dFHsx/kYCFZGMRaja8fbtVhEcLSa/jVljfM5ERXl8I2xoS1snQ94d4lrv1SrsQ/4D0dMYJqWUNWfpKYMMKww8ka9z4P06d6yhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=NobIAK46; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkcFpcaZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D8604EC00F2;
	Tue, 24 Mar 2026 11:18:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 24 Mar 2026 11:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1774365513; x=1774451913; bh=ErBmFVYHUC5AXjJ+G+Rf0z7n5tVs9tAz
	GlgWab9PfFY=; b=NobIAK46k3w1MAU6sXxLqwLg0CIkB1kpjVy9bDgGFq8+OwXA
	XND5h/ba5pxolewDr0RWWw6q/ARbWHYJpkft6KAiMYbX9ZcLwCPxFfxOSUM3IVGV
	Y9OCYzFagIMk14IGQTMKxS5Q+FvTepYJ6wShLfdfcdMoh4pijdaYXTiFuUceQpf7
	dIx+hnPxcMAfxeTfxI/Z4rQ8fzJbqaftocI6WftK6MdVfVhZPrxYzMlAXnYZOj1V
	COKCZCRvhV2SZwFtJcnHhnGr0PoSHyLuuhfo0CTV/QL9fCvAfNNNjn56sfJOp59f
	mhMNy0ZwvgABi5Ol3oPfWx4jzTbU6TxG22Y39g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774365513; x=
	1774451913; bh=ErBmFVYHUC5AXjJ+G+Rf0z7n5tVs9tAzGlgWab9PfFY=; b=R
	kcFpcaZgZanoFt/iOYDWVZW31nTBUpeCLlp1m25jOU3Qt1MAzkpSi8jjW2NO6Suy
	bKnD7OLwlDllsnxDpLQZaCWyAjSlmSoDTP7Wm7gBaLR6fdiyewf8XIAcGHR1iUgT
	oVmCBX/r2wg31z/aRJSv02Dx3ZvC5iIr16m8kZG27eKBxN84aj27/3wP7CcLGNkU
	VjcllUujsoA8AUxGHKGXDxlfPS8Ap8wuAOqzuxeEHWqJwd9HVD5mGJE2IUYBnohx
	edW1V4ipDB929RkaBTdN3GIjnEeXlLeOKqiQUErfujyaM76/6EZ5oFqM5yLAEGE0
	hqnLF1DLCa5E6sLRgXbig==
X-ME-Sender: <xms:SavCaQttukMMb4yhj8MfcYd4ChKZJlMsJKw0qGuWO2QmVndp_AxNOA>
    <xme:SavCaQhR8ZSN2asOCzX00THBIKv-kiqObZn00641gRxZ9m7h0oV8LYtiZv_TrYljR
    mxRK0WIL6CbllaYtfdGaOqs-CTGWqD3tLSGVI_A0XBq8CYz59zVyw>
X-ME-Received: <xmr:SavCaWaICjk_Cn-AP4If2So1M0DBONuAAtu2Z4LR5T8RcSGUK5zX1ZMKHcPW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgu
    rhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughtrghtuhhlvggrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:SavCafYuEst8soI7cHGORGjRp0PUhqM4ipxJF4f1iTsZ6di79WscQw>
    <xmx:SavCabxrd_8k8x6ucTSQXEHS1eYIfseMaRvd0Yvq3kgl_zQcinQsMA>
    <xmx:SavCabfXZSz7e7DUzhPfOCM5fmQ_3mQr_gtJjTJ2FE5N4bP8LBDJmw>
    <xmx:SavCaQ4FWn9ukjd04ggKGfvng4fg7ENOxb_riXrI5CRvJBR0Bg2WwQ>
    <xmx:SavCafWeWtHmzHJj4ZAE1s8BYytQxbIc8pGUJ4ASyD5oxOkFl-4ukrzy>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 11:18:32 -0400 (EDT)
Date: Tue, 24 Mar 2026 16:18:30 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <acKrRrOG0v9KDk_J@krikkit>
References: <20260323123633.756163-1-cratiu@nvidia.com>
 <acFODtfaa8LCKX4r@krikkit>
 <5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
 <acFWIxzM-GxpAhjH@krikkit>
 <20260323093243.17c14edb@kernel.org>
 <acF1jeGLpq7qDKgY@krikkit>
 <62b3b47291879328a868aa15fb7319b5ff13a20e.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62b3b47291879328a868aa15fb7319b5ff13a20e.camel@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271124-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 8EB9D31816F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-24, 14:27:12 +0000, Cosmin Ratiu wrote:
> On Mon, 2026-03-23 at 18:17 +0100, Sabrina Dubroca wrote:
> > 2026-03-23, 09:32:43 -0700, Jakub Kicinski wrote:
> > > On Mon, 23 Mar 2026 16:02:59 +0100 Sabrina Dubroca wrote:
> > > > 2026-03-23, 14:42:00 +0000, Cosmin Ratiu wrote:
> > > > > On Mon, 2026-03-23 at 15:28 +0100, Sabrina Dubroca wrote:  
> > > > > > Why not? Being able to test without accessing real HW is
> > > > > > still
> > > > > > useful.
> > > > > >   
> > > > > The tests now send macsec traffic over VLANs and nsim, it's
> > > > > just that
> > > > > nsim doesn't deal with VLAN filters at all and there are no
> > > > > stubbed
> > > > > vlan filters in debugfs, since real hw doesn't have that
> > > > > interface.  
> > > > 
> > > > Since netdevsim doesn't deal with VLAN filters at all, the "tests
> > > > should be written so that they can run both against ``netdevsim``
> > > > and
> > > > a real device" bit of the docs doesn't fully apply here?
> > > > 
> > > > Anyway, I think the original tests had value, even if they're
> > > > more
> > > > limited in some ways than traffic tests. HW/driver behavior could
> > > > be
> > > > hiding problems in the stack with VLAN propagation, those simpler
> > > > tests don't have that risk.
> > > 
> > > To be clear running the HW test without NETIF= should provide
> > > similar functionality to what the old tests could do. It's entirely
> > > okay to add netdevsim-specific subtests/test cases or asserts.
> > > 
> > > Is there anything specific that you'd like to be tested?
> > 
> > In v2/v3, nsim was exposing a debugfs file that contained the list of
> > VLAN filters on that interface, and the selftest was grepping through
> > that file to check if the correct entry was added/removed after each
> > operation. I see that as testing the actual propagation of filters,
> > while the traffic tests check the visible behavior of
> > stack+driver+HW,
> > which may not be correlated to actual propagation.
> > 
> > > Let's not make this about HW tests vs nsim-only tests.
> > 
> > That was not my intention. But since nsim doesn't currently implement
> > VLAN filters, it seems running the HW test on nsim doesn't test
> > anything at all.
> > 
> 
> The problem with using the nsim-only VLAN filter debugfs is that it's a
> test-only interface for figuring out a property of the stack.

That's the whole point of netdevsim.

> Real HW
> doesn't have that interface and thus the tests actually have to
> generate traffic to ensure VLANs are propagated.
> 
> The new VLAN tests don't actually ensure anything on nsim, given that
> it doesn't support VLANs. But on real HW they do - without the last
> patch, the new tests fail on any hw supporting VLANs and MACsec.

Well, they ensure that something in the stack+driver+HW combination is
doing something that lets traffic go through. It's useful, but we can
learn something extra from netdevsim.

> Adding back the nsim debugfs file and test assertions guarded by "if
> cfg._ns" would ensure filter propagation correctness, but would feel
> non-Pythonic and a little hacky given that the same assertion can't
> work on real HW.

I think that's fine. The tests are anyway python wrappers around
iproute commands, it's neither "Pythonic" nor pretty.
Jakub, any objection?

> So what would you like to happen? Bring back nsim patches + nsim-
> specific test assertions?

Yes, IMO that would be best.

-- 
Sabrina

