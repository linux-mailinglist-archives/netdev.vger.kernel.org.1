Return-Path: <netdev+bounces-267105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIO8DEHQsmnrPwAAu9opvQ
	(envelope-from <netdev+bounces-267105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:40:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A98273841
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455CE3064D83
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C437755B;
	Thu, 12 Mar 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AKNi02/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7vTSxZ2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017F3750B5
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326190; cv=none; b=WWz8cxBhwh9WpqLH/io1yjt8gXmd6kujGJJjRtZoLZFbENUOXpZBSayohLnepJ4HovGdWjrMRhycY7kwnfsNZab/CsiKRVzIzjmGG3OUQyQzoSDRxbSwSkz7e2oqsrC/JVooBH1NEazthq1B2jSLvj7vv3TdXAVmOzm2jTzmVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326190; c=relaxed/simple;
	bh=A3V8OpwOzCe0BY10Acyv/ngFsbTr+1i4YCqzcG6H3+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8oszPdqHvXP4t6H+wNgUBtPnLWd4iNmx7ut+xgx7q1JzZ2eBkWcWEWsFzEDJQCIhmfPqoHG6+tXsayBJuPnFCY5908+r0fx3VTuTqllV8JAtGW8bc8BW+NjdnSh9exosicmWUadXd1oel0xOcLD2bXG8zH59TrTKpJNtsL7ibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AKNi02/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7vTSxZ2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B36D7A01A6;
	Thu, 12 Mar 2026 10:36:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 10:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773326185; x=
	1773412585; bh=fg/YChO0KtNDnpjTWabektRbJ4lnU5lXR2RoltovU8o=; b=A
	KNi02/u2+rWUlo/ZbJtquZ2O6ZaYBVpWyON9qcMR57Dn0ngoMOG09ap7bXknSeg2
	Exw1wXPE/D57ncELeYwg553g7yWLAK8KWTU4BPqp/fUzrVJkzzPv7mNVwEAsB4sL
	2mdOGAOLy1+43Z+kBDMHLlWTn/1bMledh54vhEQqzm4c8DiU86VEPnNw5ZEeYtk0
	JpZL1jNFupKte5gcwPS4LqxHIvPmIIql7y6NNJcMNXcOZi4WHN2EWtJoyoxd1P+4
	5GsQB9KgZjkzvJGY+iNa4AsEVKD4nh42Y5MTVbTOg8TqArXJWoqhBt70EoBAJGoo
	mtB2RL0JhBzhM+GEsVukw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773326185; x=1773412585; bh=fg/YChO0KtNDnpjTWabektRbJ4lnU5lXR2R
	oltovU8o=; b=F7vTSxZ2CrjKL5oan21x7zuGtwnNeUjTXD2GwrtB4t9Sc8X3dnc
	VM36/R2/aPLHxqNghBg4Na1unxVYpZ2NrfsmQl7OdllW5T9rVkkfBYbVo1iv03jv
	/a9mdc5fxi/xQiaHXNLz71jkpPvE3xPCRqPT0zIcHrXMpWOCTyFSy2gsYXOZ+pJq
	uAWcSoATLi1sGv4q/mTMqrIwUSCeZ5hqvOljijpfzKg2DEN2fiv92Vd39N8FO8hb
	kPHig3wURPpqcMdLmJC4qDT/nPgR0o6bP89Rfixr3hszPCLYwxCWVurE2FtJELzr
	u520yo4wk15bxLoSrSNrpM8nW5Tk3Syi9DQ==
X-ME-Sender: <xms:Z8-yaTw81COGXHmsSIKnPSjIREckRdcXo4tSA3EAyLau05FcR-HVlA>
    <xme:Z8-yaWOs-w3DPuGJFEB8zt1geI8iHIMJIZFcsUtd52oUQzykDz_WHG8_O6OSThNm6
    Fqz_hGGzZyNm_FCynEwG7ATIm3mgst07eCqsJDWfi8JY6eWM6uHFQ>
X-ME-Received: <xmr:Z8-yacXOVeSIp9a-zSgOjdafPBeDMOYrTP734nOFMJObzIfzBG-R7jK9zoNK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhifsehsthhr
    lhgvnhdruggvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgt
    ohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrd
    gruh
X-ME-Proxy: <xmx:Z8-yaS0MuMJ30Jg3Jaie1MKOu1TAWhuv5vJ7byBTeeOR0-Oif3o2gw>
    <xmx:Z8-yaSp5DW4EivNmFPvGxgMe5QJh9YGX66opVInnjUlUm9w8gg4-qw>
    <xmx:Z8-yaRXB_6OAG2UvldMIx06FwobMCVaE8oAqkRd1OXuMhLHgl1QUeg>
    <xmx:Z8-yaVbobhiV3NiM4Y5voJDwpeD8LjjNekl7atJX6hUtlRcknB886A>
    <xmx:ac-yaT-fCq5hYUVv7s___QcrdMGfijiWp3w4gxgMK4k1R4RMYfLwn2Od>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 10:36:23 -0400 (EDT)
Date: Thu, 12 Mar 2026 15:36:21 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <abLPZa7HNFFE4QXo@krikkit>
References: <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
 <abB12Ae769OivuYB@strlen.de>
 <20260310201021.GP12611@unreal>
 <abCQGh5Ce9uDbOo9@krikkit>
 <20260311073635.GR12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311073635.GR12611@unreal>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267105-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 88A98273841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-11, 09:36:35 +0200, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 10:41:46PM +0100, Sabrina Dubroca wrote:
> > (adding Simon: maybe you can help with the "comment wording" issue here :))
> > 
> > 2026-03-10, 22:10:21 +0200, Leon Romanovsky wrote:
> > > On Tue, Mar 10, 2026 at 08:49:44PM +0100, Florian Westphal wrote:
> > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > You can only use xfrm_state_hold() if the refcount is already > 0.
> > > > > > xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> > > > > > if this assuption doesn't hold true.
> > > > > 
> > > > > I know it, the thing that bothers me is that it is unclear how
> > > > > xfrm_state_hold_rcu() can have refcount equal to 0.
> > > > > 
> > > > > xfrm_state_put() decreases refcount and when it is zero, it calls
> > > > > to __xfrm_state_destroy(). The latter assumes that the state was
> > > > > already removed from various hlists.
> > > > 
> > > > Yes, insertion in the table means refcount is 1, but userspace
> > > > can zap states at any time, e.g.:
> > > > 
> > > > xfrm_del_sa -> xfrm_state_delete -> __xfrm_state_delete (which
> > > > unlinks from hash lists).
> > > > 
> > > > The last xfrm_state_put() in that function may cause 1 -> 0
> > > > transition.  Parallel lookup can still observe that state,
> > > > so it has to pretend it wasn't there to begin with.
> > 
> > Thanks Florian.
> > 
> > 
> > > Yes, this is possible scenario and this is what is worth to document.
> > 
> > 
> > We could add something like:
> > 
> > /* Take a reference to @x, when we know the state has a refcount >= 1.
> >  * In this case, we can avoid refcount_inc_not_zero and the error
> >  * handling it requires.
> >  * In contexts where concurrent state deletion is possible and we
> >  * don't already hold a reference to that state, xfrm_state_hold_rcu
> >  * must be used.
> >  */
> > 
> > Though it may not make much sense to refer to xfrm_state_hold_rcu
> > (implemented in net/xfrm/xfrm_state.c) from include/net/xfrm.h.
> > 
> > And if we consider the hashtables to be private to
> > net/xfrm/xfrm_state.c, nothing outside of it should ever see a state
> > with refcount=0, since they will only ever see states that already
> > have one reference held by whatever gave them the pointer.
> > 
> > So maybe it's more xfrm_state_hold_rcu that needs a mention of
> > "concurrent state deletion could bring the refcount to 0 while we're
> > doing the lookup"? I don't know, for me it's pretty obvious with the
> > _rcu suffix that RCU -> unlocked -> could be deleted in parallel.
> 
> It was the case when xfrm_state had __rcu marker, it is less obvious
> now. I agree with you that xfrm_state_hold_rcu() needs to be documented
> and not xfrm_state_hold().

Ok. Would that work for you?

/* Take a reference to @x.
 * This must be used (and the error handled) for unlocked lookups
 * where concurrent state deletion could bring the refcount to 0.
 *
 * When we know that the state has a refcount >= 1, xfrm_state_hold
 * can be used.
 */

If not, what other information do you need?
Then I can send the patch separately, as Steffen said.

-- 
Sabrina

