Return-Path: <netdev+bounces-240362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BFC73C6B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003914E68EF
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39932BF21;
	Thu, 20 Nov 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TnpMXkKR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPGF8y4Q"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F13002A8
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638585; cv=none; b=Q7chUSIgigCkkbfXmbo3d01bCNbcTHrqEWjCJj5AGE5IS4tBfquQW9f+f+f9xjJes4wmNPFAPiLTaWw0CvK/EEYBZuhOSnTIw7Q7lJSvmdAA/oW7R0JpN4Me9BuE9flGacn3Dbi0lO8zB0pdV3rhZpImaUgpGtAfQc1g8jlK9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638585; c=relaxed/simple;
	bh=kgXlwnzmYFsXTZ8lHcA5mi62tkQY8RwrDdQ1rYh+2g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guGOgXcqlJ7qcgwM1C95onu0a+nIdY7UgRfW5vMs3s157U01bqpDeG645nDT4l1UC+JwQjvRa019YxNOPXDONiZHE5Qc5f3MUsWLm50SiqibRoXCwQ9aQFr2XIEKMYW6JrKjY0ZCIsuKPoB8iVYNCmqOlOdV/oLk7euGIQThDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TnpMXkKR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPGF8y4Q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 37C14EC0370;
	Thu, 20 Nov 2025 06:36:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 06:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1763638581; x=1763724981; bh=duJmX5HHOziadQf5q4kEyZjSRR1LrD50
	zaH8pVR/GKo=; b=TnpMXkKRYM2qwcsuVgkhBt00zkAurS4vLdp3QkC4fmCXIT8p
	VIYY8ffTUffInnEBvWvX6FQAfLFtPQMSgdSIl+ggAU9W43Zrixhvo47P656funMP
	cFfAA/ZY/AIN3gQDKyskJkNAh4XSYrYrHD4u/ToYnYo8yvLEofDwkM2YUUGfK9al
	Tb/OjpwEl0Gd1dlMX/uyf0/xOYomWmBo7cRk/Xa9yP9mQH2pNG6Sxk0ldIhymoaK
	OTg2ADNujbDpeGMQifcmiRHCCjkQtwPeuVSTtySc10YbrtLmj7/KLWPF11eaMTew
	9FEU0uMHB5Rt1NRPK21NMtfinUHPhnKb/Yn7xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763638581; x=
	1763724981; bh=duJmX5HHOziadQf5q4kEyZjSRR1LrD50zaH8pVR/GKo=; b=L
	PGF8y4QMGXARiehHOCHCVjnxv/MqLtLMFTdvUjJ1snuciB3Mf2F0Xfpdlybnx0TH
	KQ9UZQsxu6dfdb9TC6Zm86QwS7m7WXb2NkjRSElJ6bJVOXsvU1U6Crjrr04ZuuyQ
	/tTgXiLHhXC0ImcUiWs1WSlgOAyvqYjZULajfhfFboDh5+s4OTDXduCGlgnDGT3x
	lJC0jN3Ao2uT5lXQqSvJb7fTmqqMYpuvu0zsNz+xOjj24AgrqCBeAO5XV5dDr2pS
	6T3f7q6i8ltr1SmxwXra9br1KOg1vaBWCMeJSkOWnpBRcHyIFbCXschNeAlwIrA+
	vK2Ig6kC/+Ol3TT3R37Pw==
X-ME-Sender: <xms:M_0eaTAPy6Ibub7ljrF2YpHCkMX3nK23QZll07BEYCt02dLgvUYTpA>
    <xme:M_0eaeEq1kLbcdvRDq5zcG1UW6rsV8hCxzBnx0C1D1tLCEY4DqS5TA5jPKjyE212x
    GKxXYwBZS1_6IQsmwk3tJiBo-IoKTjoL_6nbxvR4qaYJN1PrreXLyc>
X-ME-Received: <xmr:M_0eabvnAsZe6yfwXdMUcCNMNDcbjAmvhFjWWzE2Pwq2tYmtobO3_44sHIBC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgt
    ohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghpgedv
    tddtjeefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguoh
    hrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehlvghonhhrohesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M_0eack9jvi8s4dHgeyq0efMSJExsmKPNOebbdeuO8t8b9NdNqEs2A>
    <xmx:M_0eaWP5k2ooxb-jlZe5Vw1svEVfWdQxlw7WQbtYWlPT5GaU_oLF1A>
    <xmx:M_0eaQzBGsHNolWjO98G4GUi8ArMX_qAa-J0_p23Rz1hnp8u-rpv0A>
    <xmx:M_0eaTseTLwensuJCbCT6KDYLBUnKLhXQv4VRR89DmSHj2KdrzD4zA>
    <xmx:Nf0eaWkgsYby_ZfrB-0WCISvgSFwCC2dAdXqdRN4a1svqsAzx8pfcmA4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 06:36:18 -0500 (EST)
Date: Thu, 20 Nov 2025 12:36:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>, steffen.klassert@secunet.com
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"ap420073@gmail.com" <ap420073@gmail.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leonro@nvidia.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH ipsec v2 1/2] bond: Use xfrm_state_migrate to migrate SAs
Message-ID: <aR79MCBdyx2oTcp2@krikkit>
References: <20251113104310.1243150-1-cratiu@nvidia.com>
 <aRcnDwyMn11TfRUG@krikkit>
 <88f2bf5ef1977fcdd4c87051cd54a4545db993da.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88f2bf5ef1977fcdd4c87051cd54a4545db993da.camel@nvidia.com>

2025-11-17, 12:48:20 +0000, Cosmin Ratiu wrote:
> On Fri, 2025-11-14 at 13:56 +0100, Sabrina Dubroca wrote:
> > 2025-11-13, 12:43:09 +0200, Cosmin Ratiu wrote:
> > > The bonding driver manages offloaded SAs using the following
> > > strategy:
> > > 
> > > An xfrm_state offloaded on the bond device with bond_ipsec_add_sa()
> > > uses
> > > 'real_dev' on the xfrm_state xs to redirect the offload to the
> > > current
> > > active slave. The corresponding bond_ipsec_del_sa() (called with
> > > the xs
> > > spinlock held) redirects the unoffload call to real_dev.
> > 
> > 
> > > Finally,
> > > cleanup happens in bond_ipsec_free_sa(), which removes the offload
> > > from
> > > the device. Since the last call happens without the xs spinlock
> > > held,
> > > that is where the real work to unoffload actually happens.
> > 
> > Not on all devices (some don't even implement xdo_dev_state_free).
> 
> You're right. Looking at what the stack does:
> xfrm_state_delete() immediately calls xdo_dev_state_delete(), but
> leaves xdo_dev_state_free() for when there are no more refs (in-flight
> tx packets are done).
> xfrm_dev_state_flush() forces an xfrm_dev_state_free() immediately
> after deleting xs. I guess the goal is to clean up *now* everything
> from 'dev'.

Yes, see 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
(though I'm not sure it's still needed, now that TCP drops the secpath
early: 9b6412e6979f)

> All other callers of xfrm_state_delete() don't care about free, it will
> be done when there are no more refs.
> 
> So right now for devices that implement xdo_dev_state_free(), there's
> distinct behavior of what happens when xfrm_state_delete gets called
> 
> So right now, there's a difference in behavior for what happens with
> in-flight packets when xfrm_state_delete() is called:
> 1. On devs which delete the dev state in xdo_dev_state_free(), in-
> flight packets are not affected.
> 2. On devs which delete the dev state in xdo_dev_state_delete(), in-
> flight packets will see the xs yanked from underneath them.
> 
> This makes me ask the question: Is there a point to the
> xdo_dev_state_delete() callback any more? Couldn't we consolidate on
> having a single callback to free the offloaded xfrm_state when there
> are no more references to it? This would simplify the delete+free dance
> and would leave proper cleanup for the xs reference counting.
> 
> What am I missing?

I don't know. Maybe it's a leftover of the initial offload
implementation/drivers that we don't need anymore? Steffen?


[...]
> > > With the new approach, in-use states on old_dev will not be deleted
> > > until in-flight packets are transmitted.
> > 
> > How does this guarantee it? It would be good to describe how the new
> > approach closes the race with a bit more info than "use
> > xfrm_state_migrate".
> > 
> > And I don't think we currently guarantee that packets using offload
> > will be fully transmitted before xdo_dev_state_delete was called in
> > case of deletion. 
> 
> Apologies for leaving this part out, yeah, it's pretty important.
> I changed the descriptions for the next versions, here's what happens:
> In-flight offloaded tx packets hold a reference to the used xfrm_state
> via xfrm_output -> xfrm_state_hold which gets released when the
> completion arrives via napi_consume_skb -...-> skb_ext_put ->
> skb_ext_put_sp -> xfrm_state_put.
> 
> But this doesn't work on devices which do the dev state deletion in
> xdo_dev_state_delete(), because those might get their SAs yanked from
> the device during the xfrm_state_delete() added in this patch. I guess
> this ties to the previous point: Shouldn't there be only
> xdo_dev_state_delete which touches the device when refcount is 0?
> 
> 
> > But ok, the bond case is worse due to the add/delete
> > dance when we change the active slave (and there's still the possible
> > issue Steffen mentioned a while ago, that this delete/add dance may
> > not be valid at all depending on how the HW behaves wrt IVs).
> 
> I am aware of that issue, I am not trying to change any of that. Just
> trying to improve bond from a security perspective.

Sure. But I'm not sure we can make it really trustworthy...

> I don't think it's
> ok for it to send out unencrypted IPSec packets.

Agree.


> > > It also makes for cleaner
> > > bonding code, which no longer needs to care about xfrm_state
> > > management
> > > so much.
> > 
> > But using the migrate code for that feels kind of hacky, and the 2nd
> > patch in this set also looks quite hacky.
> 
> It's less hacky than the manual xfrm state management done so far. At
> least bonding no longer needs to care so much about the semantics of
> the xfrm dev state operations. And it no longer needs to acquire the
> xs->lock (what does bonding have to do with an internal xfrm_state lock
> anyway?)

To me, it's hacky in the sense that we're hijacking the migrate code
that isn't intended for that, and triggering core xfrm operations from
inside a driver (and without proper locking). But true, the current
code is also hacky.

I think a better solution might be to find a way to use the
"per-resource" SA code for bonding (currently implemented for
"per-CPU" SAs, but a resource could be a lower device). Then we don't
have to worry about moving states from one link to another, but it
requires userspace cooperation.


> > And doing all that without protection against admin operations on the
> > xfrm state objects doesn't seem safe.
> > 
> > Thinking about the migrate behavior, if we fail to create/offload the
> > new state:
> >  - old state will be deleted
> >  - new state won't be created
> > 
> > So any packet we send afterwards that would need to use this SA will
> > just get dropped? (while the old behavior was "no more offload until
> > we change the active slave again"?)
> 
> This is not ideal, I agree. Perhaps instead of giving up on the failed
> xs there could be an alternate migration path where we call
> xdo_dev_state_free+xdo_dev_state_add like before? Ick, I don't really
> like that.
> 
> Alternatively, I have implemented another fix to these races, which is
> to change xs.xso to be able to be offloaded on multiple devices at the
> same time (nothing fancy, just parameter changes to xdo ops) and
> changing the bonding driver to maintain a single offloaded xfrm_state
> on *all* slaves (using bonding data structs). Changing the active slave
> then becomes as simple as updating the esn on the new device (to get
> that device state up to speed).
> Leon and I discussed about that and he suggested it would be better to
> use xfrm_state_migrate, since that is an existing well-understood
> workflow.
> Do you think that approach is worth pursuing instead? I could send them
> patches as RFC for discussion.

You can go ahead and share them if you want, but the short description
above kind of puzzles/scares me.

This whole feature is really a mess :/

-- 
Sabrina

