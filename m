Return-Path: <netdev+bounces-196363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0013AD4674
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470FA189EACF
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3826E708;
	Tue, 10 Jun 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JyoXyh48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jfiBBGCv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JyoXyh48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jfiBBGCv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234526E702
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596702; cv=none; b=cDvpVITA6drgntFmF4DyUeSj1OMqTwLFC2VbqrcPSqAQ0LL57udjIwbZ0v2drFzy0SNc+s85iyY5acduzwUsUsu1A76E0SddXml2oouG9H8YunN6ssZG30atrRh0yk8n2sQoYZiX6sGq9YOP7Sbse27N+gk7dxwYbDZwDBUV4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596702; c=relaxed/simple;
	bh=fAPQMc7YMnGSZ4ojVFikBnrMJI4H8yiGfOWGtN2pFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifYNJ9BgPI6qXy708PFvS6rsH002x4sh+lZzcP9lCf6srIkYQkdIcx4h4a6rQPhdqEfsXqdfvZBx4aWknwWv0um+WcQFyKM6xAy8f6kaOTH+/sCHuz8GYrCHPRu2gThFykRVuTGIzTWzgf4pOq9tAfiWH0cj/wICTpR0SAjmT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JyoXyh48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jfiBBGCv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JyoXyh48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jfiBBGCv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87E66211D2;
	Tue, 10 Jun 2025 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749596698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFrMTfHVvblww9CkZYtp6NNFPPInT+87iyLA39J5fNk=;
	b=JyoXyh48KAY2wSKhmLQVhd+aiqTosqOGFp2ILrBJ2I/E7B6KyyGDCgoHJM6wf10xgMF9CT
	Mm4asdH/GLTpPVH3Id7UMeR8HVDpW0tlKL+Ud47Xl8wKAVVOxRx0Ig6d/TuYImgCpL0jP0
	Pni4ncdfN+qZveY+ZGgx9xB3T3pudvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749596698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFrMTfHVvblww9CkZYtp6NNFPPInT+87iyLA39J5fNk=;
	b=jfiBBGCvNPDT2hnMxLW/rcyLtMbR83COIfUAkGrpOfoWCIOA022VMXMdJy8gm3HD6qfcoC
	Yr5FZbGBvS0NyQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749596698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFrMTfHVvblww9CkZYtp6NNFPPInT+87iyLA39J5fNk=;
	b=JyoXyh48KAY2wSKhmLQVhd+aiqTosqOGFp2ILrBJ2I/E7B6KyyGDCgoHJM6wf10xgMF9CT
	Mm4asdH/GLTpPVH3Id7UMeR8HVDpW0tlKL+Ud47Xl8wKAVVOxRx0Ig6d/TuYImgCpL0jP0
	Pni4ncdfN+qZveY+ZGgx9xB3T3pudvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749596698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFrMTfHVvblww9CkZYtp6NNFPPInT+87iyLA39J5fNk=;
	b=jfiBBGCvNPDT2hnMxLW/rcyLtMbR83COIfUAkGrpOfoWCIOA022VMXMdJy8gm3HD6qfcoC
	Yr5FZbGBvS0NyQBw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 5D4D920057; Wed, 11 Jun 2025 01:04:58 +0200 (CEST)
Date: Wed, 11 Jun 2025 01:04:58 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: ant.v.moryakov@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ethtool: fix possible NULL dereference in main() via argp
Message-ID: <ddc6kqji5zcv2tw6ssmbdbhgeuffjwayj224rb2de22yfz6ycr@wgqkwoxqeohy>
References: <20250518131332.970207-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t2tg5vfwehj24ud2"
Content-Disposition: inline
In-Reply-To: <20250518131332.970207-1-ant.v.moryakov@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -5.89
X-Spamd-Result: default: False [-5.89 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.19)[-0.975];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~]
X-Spam-Level: 


--t2tg5vfwehj24ud2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dne Sun, May 18, 2025 at 04:13:32PM GMT, ant.v.moryakov@gmail.com napsal:
> From: AntonMoryakov <ant.v.moryakov@gmail.com>
>=20
> Static analyzer (Svace) reported a possible null pointer dereference
> in main(), where the pointer 'argp' is dereferenced without checking
> whether it is NULL. Specifically, if 'argc' is 0 or reduced to 0 by
> parsing global options, then '*argp' would cause undefined behavior.
>=20
> This patch adds a NULL check for 'argp' before calling find_option().
>=20
> This resolves:
> DEREF_AFTER_NULL.EX.COND: ethtool.c:6391
>=20
> Found by Svace static analysis tool.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> ---
>  ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ethtool.c b/ethtool.c
> index 327a2da..4601051 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6634,7 +6634,7 @@ int main(int argc, char **argp)
>  	 * name to get settings for (which we don't expect to begin
>  	 * with '-').
>  	 */
> -	if (!*argp)
> +	if (!argp || !*argp)
>  		exit_bad_args();
> =20
>  	k =3D find_option(*argp);

This doesn't seem right. First, the ISO C standard guarantees that
argv[argc] is a null pointer and if argc > 0, then the array members up
to argv[argc - 1] are pointers to strings. This IMHO implies that the
value of argp here cannot really be null.

Second, even if we wanted to be protected against such incorrect
implementation, there would be no point doing it here, after we already
worked with argp through all the block processing global options. It
would IMHO make much more sense to check it right at the beginning.

Michal

--t2tg5vfwehj24ud2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmhIuhUACgkQ538sG/LR
dpWEiwf+J5Yh6AurWIM9VIhItfuybFuO9uqlfeM/5lGaN+TAxCaTTuVrFrq099MP
zw1wnF8Q9B5RHM9gKQgwm7mJ3goS60m/rivNqICOH+AO+u0dlMm4BU19oN8592H0
bQ3Z8KQMMTSC/frRS/a3jOSCskQQ2pmU9AU0NcfqTsUPXNoolATYCSTjZ9Qq1Upj
LcrkO7KZg4oDRIhUCY18Spz38pZ149KNRv+Z498hO6udM5w81kGTiBwrIzsds9f0
bLv0k9ZGVIf5mJdQfsvpbk6oZYTENwuNlMWJDMT3lpIJx1M4Kdsrkotj2sSPH5gP
PAkFT6mwpxsvCljm56Tryb5ki2WS3w==
=ZqHA
-----END PGP SIGNATURE-----

--t2tg5vfwehj24ud2--

