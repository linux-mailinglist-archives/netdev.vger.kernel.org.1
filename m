Return-Path: <netdev+bounces-97288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E628CA833
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0992282105
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0B4205B;
	Tue, 21 May 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uEjon8rY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="puLRjV9h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uEjon8rY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="puLRjV9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B083FB88
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274516; cv=none; b=kO3qFdp8nLlwtJ9qWu8xocMpYfwXYxWYXyzCB9ud/MbaXIeHkr44CNG7z8wI+6BIwvlrF9kFeYvWOntdSTI8dnm0vNTd/5Ism79seTY6bgCgIkQyF8daCrIzzvVFJ6EX0oOJ3og0lVy3RnzL/r7pg//WUzdLOD/G0+si7D0WJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274516; c=relaxed/simple;
	bh=XqwfwcpZAtcBNlZbvGqGhSjG4CTjauIoLrLN8PkyHbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDoUYMj5t2sVwpdMX5lkfWBbMQyCBNBSccrzMSIRgSTdKPWQbYFWHQNQmd9ZrdnbJ8yyhsWV5UoyQIPMCKq23Z4eT1MiCi+0lcRXz07dKOOnBtGw2GyS+3OYph88XJF2ptJQUCpZDkpCrt5uADFnT4vGB1J+6O/qlXOKNCH+2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uEjon8rY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=puLRjV9h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uEjon8rY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=puLRjV9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75C3234562;
	Tue, 21 May 2024 06:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716274512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqwfwcpZAtcBNlZbvGqGhSjG4CTjauIoLrLN8PkyHbI=;
	b=uEjon8rYwEtGA1uoEYrvbmgV8AHOSGcThOm0al17vEXKgFEtoloWww7Wb3XBoSsV0gDJp9
	m9lJ9U6z7RFOHzQSXFU5DS+96zWaD2JvYFWNlFChD/mu635RCKQiiB1OGx0kwbjdxOm4Y1
	E+QOHFxCLqz7uLHnjuan56yQQGIj0GM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716274512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqwfwcpZAtcBNlZbvGqGhSjG4CTjauIoLrLN8PkyHbI=;
	b=puLRjV9h2EvZTvdBhsWMzyaIeAkcg7cuPGaRWBYTicvLIzE8LF/5tYropLLrE1U1i1i/zF
	i+TIMRfN5ehYXKAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716274512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqwfwcpZAtcBNlZbvGqGhSjG4CTjauIoLrLN8PkyHbI=;
	b=uEjon8rYwEtGA1uoEYrvbmgV8AHOSGcThOm0al17vEXKgFEtoloWww7Wb3XBoSsV0gDJp9
	m9lJ9U6z7RFOHzQSXFU5DS+96zWaD2JvYFWNlFChD/mu635RCKQiiB1OGx0kwbjdxOm4Y1
	E+QOHFxCLqz7uLHnjuan56yQQGIj0GM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716274512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqwfwcpZAtcBNlZbvGqGhSjG4CTjauIoLrLN8PkyHbI=;
	b=puLRjV9h2EvZTvdBhsWMzyaIeAkcg7cuPGaRWBYTicvLIzE8LF/5tYropLLrE1U1i1i/zF
	i+TIMRfN5ehYXKAw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 6315B20131; Tue, 21 May 2024 08:55:12 +0200 (CEST)
Date: Tue, 21 May 2024 08:55:12 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Vladyslav Tarasiuk <vladyslavt@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="myuzl24qoiqwqr4x"
Content-Disposition: inline
In-Reply-To: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
X-Spam-Flag: NO
X-Spam-Score: -2.69
X-Spam-Level: 
X-Spamd-Result: default: False [-2.69 / 50.00];
	BAYES_HAM(-2.36)[97.03%];
	SIGNED_PGP(-2.00)[];
	LONG_SUBJ(1.56)[208];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-0.99)[-0.995];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]


--myuzl24qoiqwqr4x
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:26:56PM -0700, Krzysztof Ol=EAdzki wrote:
> Hi,
>=20
> After upgrading from 5.4-stable to 6.6-stable I noticed that modern ethto=
ol -m stopped working with ports where I have QSFP modules installed in my =
CX3 / CX3-Pro cards.
>=20
> Git bisect identified the following patch as being responsible for the is=
sue:
> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=3D2=
5b64c66f58d3df0ad7272dda91c3ab06fe7a303

Sounds like the issue that was fixed by commit 1a1dcfca4d67 ("ethtool:
Fix SFF-8472 transceiver module identification"). Can you try ethtool
version 6.7?

Michal

--myuzl24qoiqwqr4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmZMRUoACgkQ538sG/LR
dpWlYQf+Lqo4+YFJPSiXwp3F0EmtKGjMaTkQiL166m2nwFjTjvrkXPzqkJNB+Ex/
EpUrQ2Raztrl2Ef0MaHJHYdth0Ec+hpkaE53hyfVz+1AUgFrNvAVzumajx+7WDgI
UGzL/Med9B29t4Nlr8dmFbB7leQiGyOzivEdPFMSs5DOf9ubHy5kGqqqrLTsyQ9y
rB+pBODbgxPPRaeex7B2lOsZJwvZ9WbRZ3vi2SaXha4qk+eOcafoH7pfYuuacV60
DlliEXkO3ckEPYF+Rckgrl+UeOsYt0Wr0hVj2dy2GAlis8DWrJPRP3vHCKxBlKz7
b3ixO55hQNg8ea1CsVtadsEAXKM1Ow==
=qA1H
-----END PGP SIGNATURE-----

--myuzl24qoiqwqr4x--

