Return-Path: <netdev+bounces-178240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08305A75D68
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 01:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3C87A32D6
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C31A7264;
	Sun, 30 Mar 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vd0E/tfE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0mSkC1Yg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vaLh+k8T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FX/hch+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B11876
	for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743379163; cv=none; b=c11hRBVRunVYBNJQtkdqHND7zPQSScH+OY4bVUAHWKaM1XAvAEWZWxcG0aKjJvocPJ/83hX43WxpZuX4ytBRF5wbj670IwvI864DJuJaipw/LgNW83ZoPAvdvlMk3FvcX8jzAglnDkKs8kC+kX5wG686TEGby8wzi2P26FdWyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743379163; c=relaxed/simple;
	bh=qU3cFpA6EvKqIXF9C2ONe3DLpE0PdrxRDyoNK755y/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgTPXRKQGog5vHT+gc5VEI8rtJ0eWeLUV+nH9QUNjFc4pmpwzRoz37lkn7wtifxdEvFFgYSAzJ+hNhryshQGCOq5jX1+q7yLy4zPg8BS/+dW7ganaIFC3OEkvKvQuzMwaH5K2HeCk3Df+ildkPWa+jkpgsNc74D+qtVF3JM0zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vd0E/tfE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0mSkC1Yg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vaLh+k8T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FX/hch+4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D52D121114;
	Sun, 30 Mar 2025 23:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743379160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb3Fitni+pHvKvVooqnw/bGrNakmJWYHtWJAaZ/6qVg=;
	b=Vd0E/tfEYkojPxIPaLdBUxftMB5hjg/0C+qh17ywCtTiGlbqN1UeHceuS+/btEaa96PwcJ
	QKZdITlYGWFtujBNb8toSYiOGJlnz6+Rr9bYyShAofWdAUNsYNgYju9YgrRY7kjGlEn430
	f0zqduNeEHorPvydb8qj2IpbauWjx00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743379160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb3Fitni+pHvKvVooqnw/bGrNakmJWYHtWJAaZ/6qVg=;
	b=0mSkC1YgUyQQgLZf1i44ednngPj7oPfh+c3WPtza3PWMzet+5ju9wHUwDNfQinRTDaSPFj
	VhlUptSNCRx24yAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743379159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb3Fitni+pHvKvVooqnw/bGrNakmJWYHtWJAaZ/6qVg=;
	b=vaLh+k8TeqC8Rld4o4V8PyQjWPlA/wlDHVx0J/rIx4WEENYcdsWkVnJcL8fC9St2+hQd70
	yi8swrupzRK7VG3eQRTO18G/4e/F0mWGis+U/6q1vcxtq0ZL5InBd3ftETA9jFedpiCqav
	7fF2ngcgPv5+dwFfH20oEkX6y6aB4FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743379159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb3Fitni+pHvKvVooqnw/bGrNakmJWYHtWJAaZ/6qVg=;
	b=FX/hch+42tcZAQj9rVlLXkfuqrzC6TQNucut4BnTlzGrhTgB1I2NpDRSoWG4L10SjBioVE
	9SRWst8iOOyMhiAA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id BBD8720057; Mon, 31 Mar 2025 01:59:19 +0200 (CEST)
Date: Mon, 31 Mar 2025 01:59:19 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool v1 1/1] ethtool: fix incorrect MDI-X "Unknown"
 output for MDI mode
Message-ID: <xnvoptvzs4ikkrvsyu77tgbtstoupoin4mttuyz5qaljgd4vg4@xqmpvzrvirpt>
References: <20250324135310.113824-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vnoy7vgw3d33hn4l"
Content-Disposition: inline
In-Reply-To: <20250324135310.113824-1-o.rempel@pengutronix.de>
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 


--vnoy7vgw3d33hn4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 02:53:10PM +0100, Oleksij Rempel wrote:
> Add a missing case to handle the MDI mode correctly when showing the
> current MDI/MDI-X status. Without this, the code may show "Unknown" even
> when the status is valid. This regression was introduced in commit
> bd1341cd2146 ("add json support for base command").
>=20
> The logic assumed that `mdi_x =3D false` was already set at function start
> and omitted the `case ETH_TP_MDI:` branch in the switch statement. Howeve=
r,
> without an explicit `break`, the code continued into the default case,
> resulting in "Unknown" being printed even when the mode was valid.
>=20
> This patch adds a missing `case ETH_TP_MDI:` with an explicit `break` to
> avoid falling into the default case. As a result, users will now correctly
> see `MDI-X: off` instead of `Unknown` when the resolved state is MDI.
>=20
> Fixes: bd1341cd2146 ("add json support for base command")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  common.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/common.c b/common.c
> index 4fda4b49d2fd..1ba27e7577b4 100644
> --- a/common.c
> +++ b/common.c
> @@ -171,6 +171,8 @@ void dump_mdix(u8 mdix, u8 mdix_ctrl)
>  		mdi_x_forced =3D true;
>  	} else {
>  		switch (mdix) {
> +		case ETH_TP_MDI:
> +			break;
>  		case ETH_TP_MDI_X:
>  			mdi_x =3D true;
>  			break;
> --
> 2.39.5
>=20

Hello,

I applied the same fix submitted earlier by Michal Schmidt as commit
c4874fb88660 ("fix MDI-X showing as Unknown instead of "off (auto)"").

Michal

--vnoy7vgw3d33hn4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmfp2tIACgkQ538sG/LR
dpXowwf/fhGajdbrGn5vheGHB+krDElnsmLTvu6DJSqM3ddglHRlWSAREIzKZirX
Kn+JkCnKIFzUfMnpONSnr+WJ3niwFwCy769S9ITzb3dpu9fXlND9YIKP6JsicHl/
azT0osNvFWtn0c6nL5w6Wj02NCLHSxoDYvt18w6K1hRysL4DtXxnSf47RhTIB2AU
uqroCFjwvWbBhRy09uxq1I9Kr0zHDIlrGxMfqg4txVDq+hcLOr7Bqhqc+nX+yaoC
xeOYiIkfMpKXaT/8a/vpbmH6B/hHUKHftMATWx9sXW3TmEpEhPutlN9hmVA55m+e
y5dO08zNc7Ru4gCnmKfw0mHIysxKtQ==
=g+Ra
-----END PGP SIGNATURE-----

--vnoy7vgw3d33hn4l--

