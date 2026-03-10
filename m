Return-Path: <netdev+bounces-266349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GqgBD6QsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:42:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C82586B9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7552309AD55
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085353EC2F8;
	Tue, 10 Mar 2026 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gAQSVwCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IO94g7GS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F135DA76
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178915; cv=none; b=Ik8//lOMIvNgR7/zw9Vwt8IJoCbxFXdCjzI3hSmrcWvzarR0uA1RmRLrc4KcyK9ALnoK/8v0t8UMFzlKGs9Cnk7ieqMO1wsyHL9jYInSSAcjJe3fhKmM7rxLR6W1Q/TJ3hHI8QAk5cSNJAbfRwguar11gWknsZ8Sv7s91qHeuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178915; c=relaxed/simple;
	bh=csVF0dbCcZINYltDaiwgfMVbKXo+dr6xAlnTP7yv+Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqa1Nd7pmTQCcPppw/lXfsRtkcADO3xfjAzJTounSwlkRfF/yTqt72txkcpyWve/jDpNCTeA0SIQhdCchmiARywOOeEXd9HaDT+MyhLgTis7ObADKlmbjV8XS3vH4pvhp650AO99xhm1k5n+ZRhVNky+PaDzroM4Rdkh231tUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gAQSVwCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IO94g7GS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D8ED61D00053;
	Tue, 10 Mar 2026 17:41:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 17:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773178910; x=
	1773265310; bh=0s/WSV8iEx6p/YfF8w1ZB7livVXhDrlA4KSzvA6yTH0=; b=g
	AQSVwCrTvY3JjodQW8AkgXKv/uRkrp9XHPZXqcuAiOrnmOCSvZJ/KnCTRmid4/02
	EWk+eJGX0fsihmNC0yFXXH5B+oDXBzZ/g3Wo2FGz7ElfFmcG4E/Dz/TGIQ3m8QsS
	87CWvr7q7Oqj3fuW49n7o8SGItoKy40iS61WR4vozYYtUMvTgte/+bRQ0C4CSeeH
	3XPw1j45nEMTFxrm8ODNf9+P65Es6bKfttWfqHYeFwJ6qdzKILUzgVzFhBOE22Tp
	y1Q05KRBIa7nXyGlU49DuLbMrU/x86X3yKrz1J8DzR1qZ1+Br/shICZeoMXaLhJz
	UtCqJhc4RomplYisMG7qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773178910; x=1773265310; bh=0s/WSV8iEx6p/YfF8w1ZB7livVXhDrlA4KS
	zvA6yTH0=; b=IO94g7GSrwUcWCgvKGTxwLcGF9BeNEx9owf2dubgOt201sDvedB
	ImAFqXFV0J5t6/4nMVwoS4UsWNMC0Shof3IjfL3ZmYgt4jGvECe61T0PR/Ye5AGM
	eXydfx9BJyCgPKzGqjHYcZJeJQK+GvQyOD/r9JWF1qbFS27ho3gIP+ndCVGxAbsf
	rRxUFqFjGZE71a2FcbprGSR4tPowERIWjjg8UPzVZQsQ7SWWp7rF5+EYdYkjKlCf
	2xWx53+20zP6MH+/a/u53cnLQ3+gXeXT5WatcsKrCJ6Ye4jxTaIBy6oIbtXk7Xwm
	0VxixBm1d0SPP4TZ8MG8Mv6H1JCljztyOPw==
X-ME-Sender: <xms:HZCwaYHOGMJizzfDI1sEW-e8T3XwyNGfSveT1E39uLMfVQwQ6O_kcw>
    <xme:HZCwacTxM7qBorpXqYoFPsw_IMCQ9ipErNi0vg36V1UCCyADZ1tyi2gvtPJX4mo2K
    jOATPck71qh-PDoVjb42LBzte7DsTFevscG9Sd9VjeYZ-QGtYb1TaBZ>
X-ME-Received: <xmr:HZCwaRJ_DNoL-jZEp5AALMJku9wh2ajE-2E3Mjf64jbTjUdhkZW8UfWLhPLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:HZCwafZK4tD5k-p7iAmH_BjLSGPb_HP5cs7R0UlX36nBtMC_05b4OA>
    <xmx:HZCwab_KvpkbYA0Ud51d_1nc9YX-0jod0UC_XHN68ejZxJOusmmhTw>
    <xmx:HZCwaYZbJ_lRLIq7a_-42JtWQpg2L3mCPg3oQldXfMdRz29tqntUjw>
    <xmx:HZCwaXMwOU16bxqXGlm5sO3E-5N-g1aTvQo_OTjO6mWjKji9g4k1Kw>
    <xmx:HpCwaVzMrjQZlBFqwQVVARJkz43kh3uNPxsq8CEzTEEAZBtxmK5Sw8aF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 17:41:48 -0400 (EDT)
Date: Tue, 10 Mar 2026 22:41:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <abCQGh5Ce9uDbOo9@krikkit>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
 <abB12Ae769OivuYB@strlen.de>
 <20260310201021.GP12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310201021.GP12611@unreal>
X-Rspamd-Queue-Id: 4C5C82586B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266349-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

(adding Simon: maybe you can help with the "comment wording" issue here :))

2026-03-10, 22:10:21 +0200, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 08:49:44PM +0100, Florian Westphal wrote:
> > Leon Romanovsky <leon@kernel.org> wrote:
> > > > You can only use xfrm_state_hold() if the refcount is already > 0.
> > > > xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> > > > if this assuption doesn't hold true.
> > > 
> > > I know it, the thing that bothers me is that it is unclear how
> > > xfrm_state_hold_rcu() can have refcount equal to 0.
> > > 
> > > xfrm_state_put() decreases refcount and when it is zero, it calls
> > > to __xfrm_state_destroy(). The latter assumes that the state was
> > > already removed from various hlists.
> > 
> > Yes, insertion in the table means refcount is 1, but userspace
> > can zap states at any time, e.g.:
> > 
> > xfrm_del_sa -> xfrm_state_delete -> __xfrm_state_delete (which
> > unlinks from hash lists).
> > 
> > The last xfrm_state_put() in that function may cause 1 -> 0
> > transition.  Parallel lookup can still observe that state,
> > so it has to pretend it wasn't there to begin with.

Thanks Florian.


> Yes, this is possible scenario and this is what is worth to document.


We could add something like:

/* Take a reference to @x, when we know the state has a refcount >= 1.
 * In this case, we can avoid refcount_inc_not_zero and the error
 * handling it requires.
 * In contexts where concurrent state deletion is possible and we
 * don't already hold a reference to that state, xfrm_state_hold_rcu
 * must be used.
 */

Though it may not make much sense to refer to xfrm_state_hold_rcu
(implemented in net/xfrm/xfrm_state.c) from include/net/xfrm.h.

And if we consider the hashtables to be private to
net/xfrm/xfrm_state.c, nothing outside of it should ever see a state
with refcount=0, since they will only ever see states that already
have one reference held by whatever gave them the pointer.

So maybe it's more xfrm_state_hold_rcu that needs a mention of
"concurrent state deletion could bring the refcount to 0 while we're
doing the lookup"? I don't know, for me it's pretty obvious with the
_rcu suffix that RCU -> unlocked -> could be deleted in parallel.


We also have __xfrm_state_put, the commit message that introduced it
states:

    We often just do an atomic_dec(&x->refcnt) on an xfrm_state object
    because we know there is more than 1 reference remaining and thus
    we can elide the heavier xfrm_state_put() call.

so we could add:

/* Drop a reference to @x, when we know there is more than 1 reference remaining.
 * In this case, we can avoid refcount_dec_and_test and just decrement refcnt.
 */

but maybe someone has a better suggestion.


-- 
Sabrina

