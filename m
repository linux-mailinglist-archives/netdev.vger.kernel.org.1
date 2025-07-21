Return-Path: <netdev+bounces-208698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536AB0CC53
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A06541A33
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 21:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD223F292;
	Mon, 21 Jul 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="STTvNujF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lpkryc8m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="STTvNujF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lpkryc8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125D23D28E
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132610; cv=none; b=m6j8LhpSef1ioZSiQzlFu9F9kxkf7tpDW33mnGcI7uEoyHbREovM2C+yVyILkj8/e13Lf92xaXnhrLcKx73s5rbpf6wYuL3jO0KUXPQJabYGra+6RCj4fijf1qut0jaDi5hDntFuZSsLQMcpCHsOy5ognusND+rzoECGeUOM8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132610; c=relaxed/simple;
	bh=lPvjzaJfg90guiPw84FzWZa0rzWAC2ZLsZwpvPdeUQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoDYfW7i3v5S9DsXgibenCpmFSGAi3hJMyF9VR7+WhKi1dRlUYZwfJGpv38qqVYHc0JeC0+I1p2JOsPAXBWzb6cKmkBVNH7hpfl/2GzZbhRkk30zx5ee/N+CrEvczGdnI7I85vfDCPjPZ88l5Td9QNLK8ZpiiTDw5tWGEmi0B6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=STTvNujF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lpkryc8m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=STTvNujF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lpkryc8m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF45821264;
	Mon, 21 Jul 2025 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753132606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0THK+HZReCx7/RGgq800KwJgGXlLmEWwaCQpKJ4tIq8=;
	b=STTvNujFEdgOWO3/5m9sGQJhNQlpvi+eCV3zEHOVDbGEP/wk1++COQ4UiVHx5+l39mKsdU
	kIWzGixWE7Zh/UMIFxPUy3OqWkhlX+6eBZpN9LDSCPcYUH+f0+au3KzLK9Nw0PW499eNRQ
	kHXjAhJbQHQWtstGDp542+Jr5NTxq/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753132606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0THK+HZReCx7/RGgq800KwJgGXlLmEWwaCQpKJ4tIq8=;
	b=Lpkryc8mlQ5x+C/s4Qc33JGiReAx65U02ALO6YyuGxxhfN3/OZpf8xFi1kGS5pvwZGYj1O
	7ZFHQq++l9IVmbCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753132606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0THK+HZReCx7/RGgq800KwJgGXlLmEWwaCQpKJ4tIq8=;
	b=STTvNujFEdgOWO3/5m9sGQJhNQlpvi+eCV3zEHOVDbGEP/wk1++COQ4UiVHx5+l39mKsdU
	kIWzGixWE7Zh/UMIFxPUy3OqWkhlX+6eBZpN9LDSCPcYUH+f0+au3KzLK9Nw0PW499eNRQ
	kHXjAhJbQHQWtstGDp542+Jr5NTxq/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753132606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0THK+HZReCx7/RGgq800KwJgGXlLmEWwaCQpKJ4tIq8=;
	b=Lpkryc8mlQ5x+C/s4Qc33JGiReAx65U02ALO6YyuGxxhfN3/OZpf8xFi1kGS5pvwZGYj1O
	7ZFHQq++l9IVmbCw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id AEB6D20057; Mon, 21 Jul 2025 23:16:46 +0200 (CEST)
Date: Mon, 21 Jul 2025 23:16:46 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ethtool: fix potential NULL pointer dereference in
 find_option
Message-ID: <bgad547yea4te5v36p3hoanl6o64skilv74gugf6jof2y2kryb@to24utsoxqmz>
References: <20250709104120.74112-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="crxxuvafz4wjhfde"
Content-Disposition: inline
In-Reply-To: <20250709104120.74112-1-ant.v.moryakov@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -5.90


--crxxuvafz4wjhfde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 01:41:20PM GMT, Anton Moryakov wrote:
> Static analyzer reported a possible NULL pointer dereference:
>=20
> - In main(), 'argp' is dereferenced and passed to find_option()
> 	without checking if *argp is NULL.

Not true. This is what the code looks like:

	if (!*argp)
		exit_bad_args();

	k =3D find_option(*argp);=20

On the other hand, there is no such check when find_option() is called
=66rom do_perqueue(). But if we really want to address this, I would
rather do it in a consistent way, i.e. the same way in both places.

However, I'm still not convinced the inconsistency between argc and
argp[] you are trying to prevent can actually happen on Linux. AFAIK all
exec* functions are only library wrappers for execve() which is passed
only the argv[] array and the argc count is determined from it by
finding the first null pointer. Unless I'm missing something important,
this means that argp[i] can never be null for i < argc.

Do you have a scenario (not assuming a serious kernel bug) that would
result in null pointer in argp[] before the argc index?

> Additionally, it improves robustness by making sure that the input argume=
nt
> is valid before passing it to find_option().

The patch does not actually do this, it only changes the code inside
find_option().

>=20
> Found by Svace static analysis tool.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/ethtool.c b/ethtool.c
> index 0513a1a..4250add 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6395,6 +6395,9 @@ static int show_usage(struct cmd_context *ctx __may=
be_unused)
> =20
>  static int find_option(char *arg)
>  {
> +	if(!arg)

Missing space between "if" and "(".

> +		return -1;
> +	=09

You add whitespace on this empty line.


Michal

>  	const char *opt;
>  	size_t len;
>  	int k;
> --=20
> 2.39.2
>=20

--crxxuvafz4wjhfde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmh+rjoACgkQ538sG/LR
dpU0kggAm+xjQzQkjB/Lh6Rv5VFfQR4RjAdL61rRJ983+c0AOKu+bCKMmaoidMZs
enR0qKqOogB/4+hcgySEiKoz1VQr7tLAHCDTe9UzrXXPRziQOx+Vk8MkectLl9Qq
y49rsxbPch+Zq6vE0lvDOzeSBRARqCU+f+vdY6GEVWedjP0cHZTxclZSnvlJMiuV
MMFQMTCumv0nhvTqxLrBF2b61j1PWda08u0XuPiwXfY4XskjPfKUpl/cICFsuTl7
cSqZ1ao4LkCHzESx31vIPKZ3pomQA7vrSdcUiNzQj2nOarw6MPW9O01FLI1QikjK
LTW/k0xZC9mFbr+IzEhiEv4UWBHHsw==
=sVgI
-----END PGP SIGNATURE-----

--crxxuvafz4wjhfde--

