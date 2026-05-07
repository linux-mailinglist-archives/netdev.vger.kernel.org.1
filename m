Return-Path: <netdev+bounces-285180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCgTJ8hJ/GmBNwAAu9opvQ
	(envelope-from <netdev+bounces-285180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0554E4984
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BE5630772BE
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5BD3368A0;
	Thu,  7 May 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="doLNwnGc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2DVBMhc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E433B6F8
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141504; cv=none; b=Foh635bfYFEZADvDARN8cxcVzkZ3f1Lf5aceNW6k28wP6+YUK5mP5rf/kYZc0t7+jEjOX2Y2entJO0m+lYF5p76j9pQBFxSvtudzCUhiyegLq+ajyuOgKsenXAbcOhZpa3mHfUnt3KWzBukQQW9VcQ2eBiWxr04IF0grrqIAYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141504; c=relaxed/simple;
	bh=3ozMjKpppRGvvbTRjdoNYpjkFprFrybNQ7yOdh10jkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfL8F4F/m6kmq/AIolg5zyGLue3dKkMiA0LKz9WqkSopEPuW7pVI5DdqPi27HJQl/FEwtPhPwewTgUsmVGAkjOHMx55hmYYW1Hz21xuSQdSeRaJ8bLnxDbBt4dHoppoN/Q4dYqs2GLZEOYW0ljIJ03Ibn5rRgsPrjD4zWIuny1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=doLNwnGc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2DVBMhc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0ABA140005D;
	Thu,  7 May 2026 04:11:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 04:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778141499; x=
	1778227899; bh=ecvl6UsZ+uzv0jP9MGnDukDCsf+i9MaMhXJB73hjAFw=; b=d
	oLNwnGcGPtriJIQrRlL7ef0FnSYXN1+zq+X12k4y3yhRpOaayX2CnjNnjTeA/+Gt
	b7tytXRPOKPly7T1rEKM2pYUsmLit8oUXYuFXhzoR708L/9HL1JkXcdtY2KzFWwA
	NHLl7xsD1MUdz5WeT8csEZ7kRXqWYpxZUGAXKHynO5gyPFcyFnA01mVDewMD+LX9
	RoiYy1LCAJ/htAYVRQQzlkWdCFjAYquEh1pkqqF69L4JWbI8RKp7xMH2HXaBjpKR
	F+IG4dFXIGDJt1MxMWUT3sOCs13HKbMYyV5ZO2oaHHZMINzBW/aWEJKl5HzVwv8J
	iaEAW0hoCcCt0KjMT2hsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778141499; x=1778227899; bh=ecvl6UsZ+uzv0jP9MGnDukDCsf+i9MaMhXJ
	B73hjAFw=; b=G2DVBMhcOWjjFzkNSGciQj1p6Q2+llvUJ35Q3pdi2lc2LoGp/D0
	9ixzsvGnTTBLzlwRFjg9BS29nijduaqGzyN2OLv9vPavaYeMJgKBJRkSCkos4uC7
	LwwYHd+16rsmBp8bgueGNiEJZdgVqf9CrbhxMzDFjJvTUlB0vXHWt0qcZjxEEEv9
	nNUE+IdU3m2Ixwgm+NK6cDO70s5ddQsgQ0ogzcco4XzAotgtRWOp2wuq+ViarJEK
	n6cJWJ8sOQjTKNYYiy6i9ARBZCqB+oEvf4jiD1RjB22q7VrZv6OVZLAj5iF7+hst
	aoa2/I0W8XwXVc9xTZClX2k7Agsx4nFG9eg==
X-ME-Sender: <xms:O0n8ac93KPrALkUYV_MN0FzR6zQ7ofyD0_QVAaKatIm_idhS0kBQXw>
    <xme:O0n8abu94TY6xUJuPrQ4cU93TikcI1U_hHPdDsNidKqJ-XU3RjZnQrrzx1IyvGHr0
    7eVvfjtwCdjjKKg8VEfrRXH-OGiZNAHN4-hZx2z6lDUFP7Z22ZuKWM>
X-ME-Received: <xmr:O0n8aXDY4a7Tm4LPEBqNU7pxiB_MaGIaBo1J7p2tkzaa9i7gZFMSExsgF_fR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnhiesphhhvghnohhmvgdrohhrgh
    dprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtgho
    mhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopeguvghvvghlsehlihhnuhigqdhiphhsvggtrdhorhhg
X-ME-Proxy: <xmx:O0n8abXV_d51KHLqNIAPgm6QRIrcSVOQS0-mL24tUIVOncNLKiPziQ>
    <xmx:O0n8adDRMabmHpGe6syZZyQElNspcjI6f9-WPW_ozUmLt1AtyFpZ9w>
    <xmx:O0n8aW-DDaAnYL33vTrXHmUDS2YeQS4AKn9wbrIzVSch5Xh0TCMUiw>
    <xmx:O0n8acHDFT6gROaThG1PK-aEWQf71ll2SpJcTV5JQql3e8iigGFPlg>
    <xmx:O0n8ab8P5YWxUphHca4O9lXKqL9aEvelY2JzGfRjTZ35pCOnYehNGZHx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 04:11:38 -0400 (EDT)
Date: Thu, 7 May 2026 10:11:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] xfrm: Use regular error handling instead of
 BUG_ON() in the netlink API.
Message-ID: <afxJOGtMkRK5FrvG@krikkit>
References: <aftnl6d59WUM_Dfm@secunet.com>
 <afwhdRPx-Mko28yM@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afwhdRPx-Mko28yM@Antony2201.local>
X-Rspamd-Queue-Id: 0F0554E4984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-285180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

2026-05-07, 06:21:57 +0100, Antony Antony wrote:
> wHi Steffen,
> 
> Thanks Steffen, I was hit by this in the new XFRM_MIGRATE_STATE I am adding.
> I am glad to see we are addressing this.
> 
> On Wed, May 06, 2026 at 06:08:55PM +0200, Steffen Klassert via Devel wrote:
> > The xfrm netlink API uses BUG_ON() on failures since it exists.
> > However all these error are uncritical and can be handled
> > with regular error handling. This fixes machine crashes
> > in situations where an emergency break is not needed.
> 
> While BUG_ON is an extreme measure for a recoverable netlink error, it does
> have diagnostic value: it leaves a stack trace. The patch trades
> a crash + stack trace for a silent error return, which loses observability.
> 
> Would you consider using WARN_ONCE instead of a bare if (err < 0)?
> 
> -     BUG_ON(err < 0);
> +     if (WARN_ONCE(err < 0, "xfrm: build_spdinfo failed: %d\n", err)) {
> +         kfree_skb(r_skb);
> +         return err;
> +     }

OTOH we already have a bunch of functions doing something similar
without using BUG_ON/WARN_ON, so at least with this patch it becomes
consistent.

xfrm_notify_userpolicy
xfrm_get_default
xfrm_get_ae
xfrm_exp_state_notify
xfrm_notify_sa_flush
xfrm_notify_sa
xfrm_notify_policy
xfrm_notify_policy_flush


(I'm looking into generic ways to avoid this split getsize/fill that
always becomes inconsistent in areas where new attributes are added
frequently, but nothing to share yet)

> Something like the above would preserve the "shouldn't happen" signal with a 
> stack trace on first occurrence, without panicking the machine.
> Or are there better signaling  styles in Kernel?

Maybe DEBUG_NET_WARN_ON_ONCE so that only developers see those messages.

-- 
Sabrina

