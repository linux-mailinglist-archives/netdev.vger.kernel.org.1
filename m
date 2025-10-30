Return-Path: <netdev+bounces-234493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC1C21C0A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C6D421EB5
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39836CA86;
	Thu, 30 Oct 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S5LExwFu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="67hFey5E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S5LExwFu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="67hFey5E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4736C248
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848633; cv=none; b=pfPohkrt8HZ6ha+QyIDYgFrZ/1yrIQjpoom/9NjBhWRv5YBancOWEarV995fLUCmuP7FkoOiLlEKVsEhr48MuEW35XeoHZV2+HMA0osing262rc5f9tQi9lLWGkP/SGcpcAl8l/nkoQUkST/b82evL1qTB0hw2pAkm/zOEnEuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848633; c=relaxed/simple;
	bh=Qld2mLu50qe/pyWgBHfnl51lKI0Y1ew1JinZer3T+O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf5nKuog8xAdmyA0kTjXKQ3FZAEXsHg9Bp0dgXYnVKSUyN8W90XxEyH/xC1VjlcLrzVw5kuAaS75ggOOHzmidmRzcv5Lj7MklaHjdik7JhkpScMFze1fQJOS3smFqnfvyPx8Lqc7zoFhIkzVdNkWNGOsDU20r/Cwq2nJN3Ow9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S5LExwFu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=67hFey5E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S5LExwFu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=67hFey5E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 795BA337B3;
	Thu, 30 Oct 2025 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qld2mLu50qe/pyWgBHfnl51lKI0Y1ew1JinZer3T+O8=;
	b=S5LExwFuwGl5kCaV9unvK65K+uBjh54bvw3OcHFQHV2fFakT18ncK+SoGWwuvc5RtrY5l3
	68vZ1JDShcoMMMwwJVvctlXqtBg+nYwgTIvftK1jKqKCJqlyanQ8gJx1Q/MGHx9+xsOIkM
	uSaKsHtUg6FM4yW5oQnyQW+/6heRjC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qld2mLu50qe/pyWgBHfnl51lKI0Y1ew1JinZer3T+O8=;
	b=67hFey5E5c8zl/R42MeFXdQCC+RUQSEFAAGxuQgpu+5bpQjQWCFkfYuQTX59LyU5fCnAAO
	V9X3ibH1tTIk36CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qld2mLu50qe/pyWgBHfnl51lKI0Y1ew1JinZer3T+O8=;
	b=S5LExwFuwGl5kCaV9unvK65K+uBjh54bvw3OcHFQHV2fFakT18ncK+SoGWwuvc5RtrY5l3
	68vZ1JDShcoMMMwwJVvctlXqtBg+nYwgTIvftK1jKqKCJqlyanQ8gJx1Q/MGHx9+xsOIkM
	uSaKsHtUg6FM4yW5oQnyQW+/6heRjC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qld2mLu50qe/pyWgBHfnl51lKI0Y1ew1JinZer3T+O8=;
	b=67hFey5E5c8zl/R42MeFXdQCC+RUQSEFAAGxuQgpu+5bpQjQWCFkfYuQTX59LyU5fCnAAO
	V9X3ibH1tTIk36CA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 5989F20057; Thu, 30 Oct 2025 19:23:50 +0100 (CET)
Date: Thu, 30 Oct 2025 19:23:50 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, 
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <7rnzkle3ekgmfco4rum5zt7ayqkqxspklafpjc5iwsyv7a3la5@uxz54po7u6jh>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
 <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
 <ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
 <zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
 <8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
 <20251029153812.10bd6397@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7hpuf4tjdydwydmu"
Content-Disposition: inline
In-Reply-To: <20251029153812.10bd6397@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -5.90


--7hpuf4tjdydwydmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 03:38:12PM GMT, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 18:53:20 +0000 Vadim Fedorenko wrote:
> > >> Well, yes, it's only 1 bit is supposed to be set. Unfortunately, net=
link
> > >> interface was added this way almost a year ago, we cannot change it
> > >> anymore without breaking user-space API. =20
> > >=20
> > > The netlink interface only mirrors what we already had in struct
> > > ethtool_ts_info (i.e. the ioctl interface). Therefore my question was
> > > not really about this part of kernel API (which is fixed already) but
> > > rather about the ethtool command line syntax.
> > >=20
> > > In other words, what I really want to ask is: Can we be absolutely su=
re
> > > that it can never possibly happen in the future that we might need to
> > > set more than one bit in a set message?
> > >=20
> > > If the answer is positive, I'm OK with the patch but perhaps we should
> > > document it explicitly in the TSCONFIG_SET description in kernel file
> > > Documentation/networking/ethtool-netlink.rst =20
> >=20
> > Well, I cannot say about long-long future, but for the last decade we
> > haven't had a need for multiple bits to be set up. I would assume that
> > the reality will be around the same.
> >=20
> > Jakub/Kory do you have thoughts?
>=20
> hard to prove a negative, is the question leading to a different
> argument format which will let us set multiple bits? Looks like
> we could potentially allow specifying tx / rx-filter multiple
> times? Or invent new keywords for the extra bits which presumably=20
> would be somehow orthogonal to filtering?
>=20
> tl;dr I'm unclear on the exact concern..

My only concern was to make (reasonably) sure we won't have to make an
incompatible change of the command line syntax. But you are right that
there is alwasy an option to have e.g. "rx-filter" and "rx-filters"
(mutually exclusive).

Michal

--7hpuf4tjdydwydmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmkDrTIACgkQ538sG/LR
dpW1iAf9ETDvU5DkDzCBTZV37VpNSUkW6NfR9t4tKmu74F2x1xo91xiRCBiSqo8u
K9LCZWqK8+ZZQ1elsrWBD03bhIrsKVnP47SF1R5CtXIxMm9cPK9v68oR5/A/Rl81
b2HyDYpRgYaGXCOvs7KfIcpoCFJC8Z78sbAB2H3sxYI/t7MX1iJpCMYur+HO6kPF
eqwnSJQ+MFQXYlvaWxXJb5LaYKeeWJI1l3vMp5WyuikhaXf5PK1d8snbLvx2skLs
zJBVVnzNfXATqd5TmO6aOvpG24u/lO7dLOr7ePt/+FtNM4ztCz/MCFheiRvM4h2e
ElSBqX+uWyM6WRIEWK0Gao+nN/Mq/Q==
=oO2m
-----END PGP SIGNATURE-----

--7hpuf4tjdydwydmu--

