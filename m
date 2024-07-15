Return-Path: <netdev+bounces-111537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FCC9317D3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48CF1C218EA
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CED20EB;
	Mon, 15 Jul 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PLB1v4QM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zM5Xqro1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PLB1v4QM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zM5Xqro1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188879F3
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058311; cv=none; b=Iutvo7JxSfNnZIAUeAFgVu+57ketTDsXQlihzvXDKSqjuKhB6/j35ntAhCMNuTx5KHX7MdfalxKP61v+MVu7ljwO1MGiF55GulsOJSvGJEasFSEhtJ7VPE18R6WL/DalT2nZA11ORQKXwR8CP1bLzTac23L0xrEXAcaINQdovVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058311; c=relaxed/simple;
	bh=H10ktSOFGnKqmfAVekeHrEmlUNxi9Lm6oLdyp9yZBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL7sFZX9sESykdVqGGcOyDsRlbjoBWKn01NVfmgqGEY7WP/3hKH676PpOIJvY21j+XC7gurxRd/m0++C/MuxgnvejBbWH/fiQQ7/YTi2SSKim+PJfsd6gD+3r2JjQUaS2ZEfe4XvhM8sMjJAx4q6f224k5BurTrccxIWBMUo/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PLB1v4QM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zM5Xqro1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PLB1v4QM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zM5Xqro1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82D572197C;
	Mon, 15 Jul 2024 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721058307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H10ktSOFGnKqmfAVekeHrEmlUNxi9Lm6oLdyp9yZBk4=;
	b=PLB1v4QMSwM7AN0OIK+Qq5dXMXRZxeTJ+AMDfi4RGGRCEX5SyRvjXUXczzedkBOSiyw5DU
	kAjM3Pv84S34Tb+fvMyCl4yJ7LxCNcbWxe4BZ4vxUdK1O/R1rNdgR7qNLAS8JOWsRQjzo3
	Bp2oUvTAZyHwlC12MydIScJNfppQtkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721058307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H10ktSOFGnKqmfAVekeHrEmlUNxi9Lm6oLdyp9yZBk4=;
	b=zM5Xqro1wQIZb0Ov7cRr/X64soT4KOypjCU8iQySHW7wMl/ZiMjKifcTfxT/vIZONT/wDl
	+Xy2vjQ4LSV3sqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721058307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H10ktSOFGnKqmfAVekeHrEmlUNxi9Lm6oLdyp9yZBk4=;
	b=PLB1v4QMSwM7AN0OIK+Qq5dXMXRZxeTJ+AMDfi4RGGRCEX5SyRvjXUXczzedkBOSiyw5DU
	kAjM3Pv84S34Tb+fvMyCl4yJ7LxCNcbWxe4BZ4vxUdK1O/R1rNdgR7qNLAS8JOWsRQjzo3
	Bp2oUvTAZyHwlC12MydIScJNfppQtkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721058307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H10ktSOFGnKqmfAVekeHrEmlUNxi9Lm6oLdyp9yZBk4=;
	b=zM5Xqro1wQIZb0Ov7cRr/X64soT4KOypjCU8iQySHW7wMl/ZiMjKifcTfxT/vIZONT/wDl
	+Xy2vjQ4LSV3sqBA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 6DF732012C; Mon, 15 Jul 2024 17:45:07 +0200 (CEST)
Date: Mon, 15 Jul 2024 17:45:07 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
	"Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Wei Fang <wei.fang@nxp.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <sh7guaacuwvah2rm7xz4g2zeips6weu4bxmnxv677njcfmyrkh@eyx7g4ueovxz>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
 <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240715115807.uc5nbc53rmthdbpu@skbuf>
 <20240715061137.3df01bf2@kernel.org>
 <20240715132253.jd7u3ompexonweoe@skbuf>
 <20240715063931.16bbe350@kernel.org>
 <20240715150543.wvqdfwzes4ptvd4m@skbuf>
 <20240715082600.770c1a89@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xa6pcw754gyuuwv3"
Content-Disposition: inline
In-Reply-To: <20240715082600.770c1a89@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -1.90
X-Spamd-Result: default: False [-1.90 / 50.00];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Level: 


--xa6pcw754gyuuwv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 08:26:00AM -0700, Jakub Kicinski wrote:
> On Mon, 15 Jul 2024 18:05:43 +0300 Vladimir Oltean wrote:
>=20
> > Semantical differences / lack thereof aside - it is factually not the
> > same thing to report a number retrieved through a different UAPI
> > interface in the netlink handler variant for the same command.
> > You have the chance of either reporting a different number on the same
> > NIC
>=20
> They can provide a different number? Which number is the user
> supposed to trust? Out of the 4 APIs we have? Or the NIC has
> a different ring count depending on the API?

This is IMHO the most important question. My understanding was that
those two APIs provide just two different ways to query the same value
and the existence of both is rather result of evolution than intent.

Michal

--xa6pcw754gyuuwv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmaVQ/8ACgkQ538sG/LR
dpWnVQgAmp6R+3xtFOO4ickUdozwI8QmKB0gSk0I0XWiS1bgRH+CI/J3dovIcB9O
8R62sNl70l2U9AThBoT0QukGZXtfoDK6t4LLJrseVUr9HyykkV7qQAsjCOQ42C0k
itYUvypA/JpiDkbZ2k3sJ4In1ffno/KSd8gwjGr53w97JjXrOQRkfwpvlwHQCFAK
lY8XknuUqQ8rwfEjnVENw9Pqb50pDmIGZBb92dFeEH4RO3k0vzqohtoIFvgbWk38
eAs1TaafAZy3Wqu0Xt9dGcTbURpTAYSLCPVTXgZhG7By59PMalhVOLb8z4WeUyNz
WDqieQ/9+Z54hBQLez0V0GaGt3+SYg==
=6tX4
-----END PGP SIGNATURE-----

--xa6pcw754gyuuwv3--

