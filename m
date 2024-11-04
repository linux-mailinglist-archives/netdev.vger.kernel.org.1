Return-Path: <netdev+bounces-141382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF249BAA10
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 02:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF861F212F2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF75757EB;
	Mon,  4 Nov 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTZV4vl+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gKaZLbzh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHZGksrK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AISwnlk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF5EAD0
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730682345; cv=none; b=gtq+FB/26ECUtSyPEP6HlGmwjtstITsT3uyzM40HDBoumld9Q+uJrfQucqefF+FOpVdfdCufppVa8DR4aKpHCd/JKmqWKxNHOyZ0bVv86IGo6QZvUnP1uJdMLRYRysSCGbMGCXa7z5tIYkhErWm6oIf7IaxWBsh/T0z2ky7T9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730682345; c=relaxed/simple;
	bh=mySv+AoLldC1jNd8zhNxrRGjLDllAz+VoN6BYj2Z7Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROzwwsvCQaQI1z+GNsZVpncltGKCIWKkO2sqlscdGMhFFqLXbpmO8XtqC4mGQFRnaMEZjBiFXsI+u++a07m/JR3A8c4F8DcpA+5TkdaUfHsuxfKK4Bpz8oGSnTfAEqmcMLjOWWShlnMLguhsfoQWNP8V4ZdwO1epnYS42RWF0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTZV4vl+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gKaZLbzh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHZGksrK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AISwnlk7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E03F621B5E;
	Mon,  4 Nov 2024 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730682336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxR/pbsE/vwpayzK9lXM9E8DI2m+5l2hfflq2foVBI=;
	b=jTZV4vl+NUNuXW35OPapntPPth3zNUsNT26PNDM5Ja8PO9VdJ3AToypfEhnAq04JQ9Tann
	q8V3YVsUEx72xPnjiTaceL1Prz3MNquIswv6fHfbFdX9dqEdepWeVlFr1Pz//Easn5KLKL
	IGVrWHuPqsnBdjuOMs1c4iKAUr8d4Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730682336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxR/pbsE/vwpayzK9lXM9E8DI2m+5l2hfflq2foVBI=;
	b=gKaZLbzhSftLxoahzqMjCFhcs8r/ZhU9Wi/GvGgSYYBPioVFFLx4lUkvOXz/vNs2CxePZb
	rqUqZvreadq+zpBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730682334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxR/pbsE/vwpayzK9lXM9E8DI2m+5l2hfflq2foVBI=;
	b=xHZGksrK9291ddLiw1ge/pv6cb0NPbyOZGZbjYnO0HQtGzgvu3lBvtaq/CK4bQkkEMwAQR
	cQC1PJCHBlh/LZ/tV+FXDQf5okA09ivtzrZBYYSunOGAvH2+Q9Fq8fg2oZ5M6JD6oFRUPC
	KbRNgf9n4LrelSrWbrwO2tqw861jhVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730682334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxR/pbsE/vwpayzK9lXM9E8DI2m+5l2hfflq2foVBI=;
	b=AISwnlk7NxuT/3OlNO6yo2htMMZAhG13am5fhilO2SJoqysQ0MZsoENyk9ol/l0kKVPA+Z
	KIqu9XP/f6qXGLAA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B4B402012C; Mon,  4 Nov 2024 02:05:34 +0100 (CET)
Date: Mon, 4 Nov 2024 02:05:34 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Mohan Prasad J <mohan.prasad@microchip.com>
Cc: f.pfitzner@pengutronix.de, netdev@vger.kernel.org, 
	kory.maincent@bootlin.com, davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch, 
	Anbazhagan.Sakthivel@microchip.com, Nisar.Sayed@microchip.com
Subject: Re: [PATCH ethtool] netlink: settings: Fix for wrong
 auto-negotiation state
Message-ID: <uzwfeeltnozvbdxigpu2mshrr7yjxgkbyrjeyfeavasue63cgn@w3ju2lpjq2ln>
References: <20241016035848.292603-1-mohan.prasad@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5u2gasxlfmibzwdc"
Content-Disposition: inline
In-Reply-To: <20241016035848.292603-1-mohan.prasad@microchip.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.72 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.02)[-0.086];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo,microchip.com:email]
X-Spam-Score: -5.72
X-Spam-Flag: NO


--5u2gasxlfmibzwdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 09:28:47AM +0530, Mohan Prasad J wrote:
> Auto-negotiation state in json format showed the
> opposite state due to wrong comparison.
> Fix for returning the correct auto-neg state implemented.
>=20
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>  netlink/settings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/netlink/settings.c b/netlink/settings.c
> index dbfb520..a454bfb 100644
> --- a/netlink/settings.c
> +++ b/netlink/settings.c
> @@ -546,7 +546,7 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, =
void *data)
>  						(autoneg =3D=3D AUTONEG_DISABLE) ? "off" : "on");
>  		else
>  			print_bool(PRINT_JSON, "auto-negotiation", NULL,
> -				   autoneg =3D=3D AUTONEG_DISABLE);
> +				   (autoneg =3D=3D AUTONEG_DISABLE) ? false : true);
>  	}
>  	if (tb[ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG]) {
>  		uint8_t val;

The fix looks correct but isn't

	(autoneg =3D=3D AUTONEG_DISABLE) ? false : true

just a more complicated way to say

	autoneg !=3D AUTONEG_DISABLE

(and harder to read)?

Michal

--5u2gasxlfmibzwdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmcoHdgACgkQ538sG/LR
dpXeqggAq3MH34Ddq/a+dg4tBV1PKiUx52FfM43yUIQafjKQFLj4Xn7kDhM+94eS
0YOwFALPBQwbr3cjCmSRfIGZoxsTUf/EF4ne4ctBuVjwiNw0de2R+3sjxwF72SUR
BJSa1EanrxRywXEGxP3t6uJ6+UG42ewEhNm1tAOD8TDOO23+udhXbMIK4AwEKn4X
c+FuZmcjS68ppV1L3NtJJ5Gt2aL81e1FdRz05BtXqR5kdf0aAV/vM3zHaxb68YCR
xBO7AJUSExH2Kr585HlED055Xy1uJx9sAU3c/Eh2x1rjHum/KyMtiPvU7JIcuvcA
iQWOGcvHnesZJkwAV7AhoJXswkf2HA==
=Ljx3
-----END PGP SIGNATURE-----

--5u2gasxlfmibzwdc--

