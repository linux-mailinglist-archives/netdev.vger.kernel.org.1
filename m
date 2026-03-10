Return-Path: <netdev+bounces-266030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMe7KBkFsGlAegIAu9opvQ
	(envelope-from <netdev+bounces-266030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:48:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E724B93F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8623832EE5C8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC333A9C6;
	Tue, 10 Mar 2026 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CS8ahMP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yYG3ZgIR"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA636D9F9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142410; cv=none; b=CZ7pyE16gAtiFDxW4u1H8wT/Mpeuj4f8QPqgQxw80P8yjmIRMGGy7J7eKdh0ByMpZBJjuwcoargCsh1C8tH1YXP+/gco8hSwoo/aWq0PAkU0VlIJnJz9mDZml8RA6mtQ2Z66bln7aYheVcrpEshFg6Y+vOJaL/ILCxcaj7wsFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142410; c=relaxed/simple;
	bh=dIHsjmlfilCKFM1gyzDkRiDzOI5BIWQZ4elQ+zQMFRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoDa/kpLr2ZtKSRyrkCNtbECWMMqzhtXtcOnNuPv6hPQ6HDH0lRN0LpFx7PSF2h9seoUe67UDOD+veYdP7lihXa6Uielk6hkgWGlCVyU91Hzx22l5ffHCGWKuFJOGOwNhpdeCVxC+J5dRsOT4mMgGCTOurdxINDVV4WuqiQm3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CS8ahMP3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yYG3ZgIR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D015EC0AFD;
	Tue, 10 Mar 2026 07:33:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Mar 2026 07:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773142406; x=
	1773228806; bh=a3pOdCIsDCr8yHAeXd52SfT4lXsZnq72VO7z4DbHxcY=; b=C
	S8ahMP3E2DAEuiWObGeWVdUaeEzm8qvTCKANmP4r7T6ab2TuEVFavD/ZsNwgK18X
	H9FSa+wA+1rEl7cORWOKKq+82HyNKpIfYApzqeK//yvOXd/gvlk8Oz6RtPGLFeLe
	ze+reQ6/MXhwwOqte5PuwUA9RPoAVifAHIM+k5j5wXJkTM/sli6si70Polz7GcAZ
	WLIugYrST3/JdM7AYX5hNmA++aXm7oyiSLDFEyMI+ycwFfRmNo1FFteknKZXRk/w
	+HOzqelBVuXolzJLg0W+o09d0wQ3loP+MdKwiEbAQm5Hjitqr1+y/RAhWteMCxCf
	cwJ04Jf51gfJe8YwfzPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773142406; x=1773228806; bh=a3pOdCIsDCr8yHAeXd52SfT4lXsZnq72VO7
	z4DbHxcY=; b=yYG3ZgIRTlZfLmBVXywN+MKZDT6b3gm1TtEQGN/iNUwKzBbaIOx
	9X6QqKUdZsSAabJUa6pBPxsoAgaztG2uj7Tz2ruk6hDpwAbaFKtje2PpzC7uWCn5
	zHPAtannyp0FQBASdIOQGGWMET42Z8Ei2gX+r1X3MtbmA8OS31SANhsRiK1zGoGZ
	vsG9a+lSZbIQWeT6FoPX/dlwGwZN9VORc4avFPzPoarTYrgnPoGtSnn0xUDdpCTA
	cHxstr/aBgHiRkqMsci4Z1JuhN+bFGFlGhKLvbdoQxRvuWlDfm95pXqTsGMnpKrX
	7yJipyziuZ/qz26PhNDOtET9dwi6+3hS/xA==
X-ME-Sender: <xms:hQGwaXne1RFjU38How2Gi54DmERCLk6EgaMW4yWG35W45BdbiKn0Yg>
    <xme:hQGwaWS9EhKwCrSLEmZ7pPFtpEPoOuK0uWs341VbZD27skUjJdxUtBQrOHay2k_6K
    m9II1GBHxLDGpUriGf0ZR9HAbr6c6Z6Wu73mmsI1FKJYOTRjOfiUKM>
X-ME-Received: <xmr:hQGwaRKPPWDpK-ksQah_3ftjgnSl5DvzNI3J5neLcT9tNLHyGEPrMWuorOGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrth
    esshgvtghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdr
    rghprghnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:hQGwaUD9hORWRSA2Jjc8wLfVEzbuJKPHtCU3XzbnzCMLoeAfbTohhA>
    <xmx:hQGwaSDnOWJH7wRR7E_R8vTnEwOi8liXMlKAgl7pr5B8Pi4vosgF-Q>
    <xmx:hQGwaeBSby-3Ubx8JmPiLWzWCnDyPwdhXAC-SrBi-dtiEw5rM1UusQ>
    <xmx:hQGwaVpGcRJ1tpLD9BgzfTpx--Ae6wJkAF02O1NJFtR9S88XCsvZsg>
    <xmx:hgGwaWMIm6od4En-ybucwPDJ9r4dqN_nQ78ZIvUbSmUvb1OYfVSlrQr3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 07:33:25 -0400 (EDT)
Date: Tue, 10 Mar 2026 12:33:23 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <abABg6aO9twGIk7F@krikkit>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310103135.GB12611@unreal>
X-Rspamd-Queue-Id: 1E3E724B93F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266030-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-03-10, 12:31:35 +0200, Leon Romanovsky wrote:
> On Mon, Mar 09, 2026 at 11:32:34AM +0100, Sabrina Dubroca wrote:
> > In all callers, x is not an __rcu pointer. We can drop the annotation to
> > avoid sparse warnings:
> > 
> > net/xfrm/xfrm_state.c:58:39: warning: incorrect type in argument 1 (different address spaces)
> > net/xfrm/xfrm_state.c:58:39:    expected struct refcount_struct [usertype] *r
> > net/xfrm/xfrm_state.c:58:39:    got struct refcount_struct [noderef] __rcu *
> > net/xfrm/xfrm_state.c:1166:42: warning: incorrect type in argument 1 (different address spaces)
> > net/xfrm/xfrm_state.c:1166:42:    expected struct xfrm_state [noderef] __rcu *x
> > net/xfrm/xfrm_state.c:1166:42:    got struct xfrm_state *[assigned] x
> > (repeated for each caller)
> > 
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> >  net/xfrm/xfrm_state.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 98b362d51836..7a68c594ce37 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -53,7 +53,7 @@ static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
> >  static HLIST_HEAD(xfrm_state_gc_list);
> >  static HLIST_HEAD(xfrm_state_dev_gc_list);
> >  
> > -static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
> > +static inline bool xfrm_state_hold_rcu(struct xfrm_state *x)
> >  {
> >  	return refcount_inc_not_zero(&x->refcnt);
> >  }
> 
> This change makes me wonder why we need both xfrm_state_hold_rcu() and
> xfrm_state_hold().

Commit 02efdff7e209 ("xfrm: state: use atomic_inc_not_zero to
increment refcount") and the series around it [0] introduced the
possibility of that refcount increment failing.

I can't tell you why a 10-years-old commit made some choice, but
keeping both variants has the benefit of documenting that one
increment is expected to never fail (because we already hold a ref on
the object on that path) and we can skip the error handling. We don't
want to add error handling that will never get reached, it always goes
wrong (because it's untested) and it adds uneeded complexity to the
code.

So I wouldn't get rid of xfrm_state_hold.

[0] https://lore.kernel.org/netdev/1470737769-30438-1-git-send-email-fw@strlen.de/

-- 
Sabrina

