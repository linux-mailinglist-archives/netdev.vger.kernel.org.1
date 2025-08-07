Return-Path: <netdev+bounces-212106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2FB1DFB0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 01:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D71A161EBA
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC91E7C34;
	Thu,  7 Aug 2025 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9Pd4lBg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FzTsUgUJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QSiR1wIP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oyk/6C+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686635898
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607957; cv=none; b=upDi7ULUWyxeGw8lMbK5tjxTb8LTliwNMCTSPrYEo/Pm7k/HH0UPd7fRL6LV04TMlaO25PnXOMX2Ix2403Zgt6Wg+1Y3Cem/oAp8D+7xdZyr53mSgI6VUs7rkM6sxJ8fSClVfOvvSV59IutDN+3SeV3m+AqIL0gurcKw1hGtTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607957; c=relaxed/simple;
	bh=9YK8BkerrXI3VWUUxFqjvSp5nfYDyPM3moXkjjbENRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c89okWwRnIUuyZmEHMRRmV163Y8fSQ/xz9tBBHoyyWV6+EQZOGtRejMHIdNcoTvKiPgc7X/RVz2vKb1hZZXdZr7Q69gDEr4RHXwsdEkIHgKXBjQWidOF9rK/DFwKeJjM81jamjyVRvL3IBsbBkDrF1LaJtXO7cUEkTgoQ5TCJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9Pd4lBg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FzTsUgUJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QSiR1wIP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oyk/6C+N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E28BC33933;
	Thu,  7 Aug 2025 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754607953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHAzBDvOLrs+7C4wfnIzfgVqikB8GIUwjVOcMVH2lBo=;
	b=s9Pd4lBgq2Yt35L/01eUHenZaXCt9yHgb4gWa8e1DVn+jcSwOuImhkITYeoT9Y76sMaGwy
	+2wBJsd14T9kSbk9Goiz1yVtQtr8EGfwZdQvINttmO5wfnSe2S8fMicOEzeNRpUTWiEEaD
	2W5T+S9xuMJtvvOSVABhDeaLX9NQitE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754607953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHAzBDvOLrs+7C4wfnIzfgVqikB8GIUwjVOcMVH2lBo=;
	b=FzTsUgUJeRw9UCTFOJenbjP4CSahM4pRwy5kWIwDDMYyjcf80pgqOiwiJ6KADwYRfFLu4C
	cNpkSycmUnqRUpCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754607952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHAzBDvOLrs+7C4wfnIzfgVqikB8GIUwjVOcMVH2lBo=;
	b=QSiR1wIPzlG/w3mP6m8Pgksnqzecm89nwZ4u7K1lkQc07zo3+PbFAosydxtwT7HhOjX2tD
	ec9k8FakiK0HchduC6QkdQHLzm2fx0HzGF74e9usIZ4P+0glL+jIscBRUR5gu8D1sWfRhT
	eyOKA0e5nQbzaVZWpXIf558uWbH1vwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754607952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHAzBDvOLrs+7C4wfnIzfgVqikB8GIUwjVOcMVH2lBo=;
	b=Oyk/6C+N1X992IFRkSH+H58A3CnHi7zSJCUfw/fcGQ+N3AXygL7i1eFjQVvGVzDEaKAPxS
	vV3f19GU4sFzjkDg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B425F20057; Fri, 08 Aug 2025 01:05:52 +0200 (CEST)
Date: Fri, 8 Aug 2025 01:05:52 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Michel Lind <michel@michel-slm.name>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: fix print_string when the value is NULL
Message-ID: <lwicuyi63qrip45nfwhifujhgtravqojbv4sud5acdqpmn7tpi@7ghj23b3hhdx>
References: <aILUS-BlVm5tubAF@maurice.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vlrcuo3cj2jpl7oh"
Content-Disposition: inline
In-Reply-To: <aILUS-BlVm5tubAF@maurice.local>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
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
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -5.90


--vlrcuo3cj2jpl7oh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 07:48:11PM GMT, Michel Lind wrote:
> The previous fix in commit b70c92866102 ("netlink: fix missing headers
> in text output") handles the case when value is NULL by still using
> `fprintf` but passing no value.
>=20
> This fails if `-Werror=3Dformat-security` is passed to gcc, as is the
> default in distros like Fedora.
>=20
> ```
> json_print.c: In function 'print_string':
> json_print.c:147:25: error: format not a string literal and no format arg=
uments [-Werror=3Dformat-security]
>   147 |                         fprintf(stdout, fmt);
>       |
> ```
>=20
> Use `fprintf(stdout, "%s", fmt)` instead, using the format string as the
> value, since in this case we know it is just a string without format
> chracters.
>=20
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Michel Lind <michel@michel-slm.name>

Applied, thank you.

It's a bit surprising that I didn't hit this problem as I always test
building with "-Wall -Wextra -Werror". I suppose this option is not
contained in -Wall or -Wextra.

Michal

> ---
>  json_print.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/json_print.c b/json_print.c
> index e07c651..75e6cd9 100644
> --- a/json_print.c
> +++ b/json_print.c
> @@ -144,7 +144,7 @@ void print_string(enum output_type type,
>  		if (value)
>  			fprintf(stdout, fmt, value);
>  		else
> -			fprintf(stdout, fmt);
> +			fprintf(stdout, "%s", fmt);
>  	}
>  }
> =20
> --=20
> 2.50.1
>=20
>=20
> --=20
>  _o) Michel Lind
> _( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7cc=
c04f2
>      README:     https://fedoraproject.org/wiki/User:Salimma#README



--vlrcuo3cj2jpl7oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmiVMU0ACgkQ538sG/LR
dpUxAQgApAEqC/kmzS6c1JcEozLpdc8ElGJwjMkzT+n/zt3G8qkcph/SUBmrR2yE
NkznlKaccAUmPEiNSW6eS74xflRq4/nE0BWgF/A37zzhiVBJY7v1xdcdVAijucNj
fp4j8FyxkH2DP7rCqL4wJVvA+5fEqhqCOxGXUzknDLyzAojsF+uazwfKP8GJYGW0
KgLNeydqpHFilZYmlffJ5zt2Q5JJldzojIPXJmto0s+mh6pt/D1YDf5a+KHCxapp
CaFO9mdbLhONhcBcGRf23/pGftus4YOCO5QR20P7jIOxK0PlIPuI0pXReFNJ7GTG
nULVUG0+WR5jYn72+YnTN8FeG9r8MA==
=8bVf
-----END PGP SIGNATURE-----

--vlrcuo3cj2jpl7oh--

