Return-Path: <netdev+bounces-124062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD1967C7C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 00:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B91C204F6
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D413A41F;
	Sun,  1 Sep 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="io5H2sGx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ErlRmza";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="io5H2sGx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ErlRmza"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB717C;
	Sun,  1 Sep 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228480; cv=none; b=Gcx1tDHRY5GbfjlB60X4QVhJ0Wj86f9M25Sq0f5XVy/OgtgZGVPMST/4vgUXTqNAChFtueHzHWe79FVfCneH5/dip1D7JOuN59MJWx60pIK5JQczd98O3J46tcFTumV9sQXiYoldiCOHTSR7vdg02W811TEHQMg5BZJqoJL+jmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228480; c=relaxed/simple;
	bh=DYhB9DuBmz7IOGvvFQm2ewICfZouiWtSYLY3fgb8eKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odktfZMvw6HzbCbJpCuSkWMv90GgXdF6QnHIanUh2tp5jwYdL06emBjT5P4DQrc4odaYHkJrX7yGyC0jssFAKBkJRcRlolmob6GUkne5padbw+8BQ1G1RaarJQxsBwR0fwmAV3qGyaxVTxr3q+H91aH65wVfeXBWLUttFhnGSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=io5H2sGx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ErlRmza; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=io5H2sGx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ErlRmza; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1135C21ACC;
	Sun,  1 Sep 2024 22:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725228477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu8AVE5JK8t78/PrT5tmJbP6bMcIjQZtHefYruXnozE=;
	b=io5H2sGxGTAb4ZeKt7XOb19d12K/ij3A1okuvB+dBeBZ7FZi0WhzyWL0X6tKt4WfYMRk44
	iEx/jCLRetG/DL94SyliaRT7UtkIB1dHpb26rMrp5m5KOukCWuoumwL6kyK5+8DXQ3dkR6
	0rt8RgNcMTIj21ogM6au5bI5379jMz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725228477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu8AVE5JK8t78/PrT5tmJbP6bMcIjQZtHefYruXnozE=;
	b=0ErlRmzazEXLsjSTBsipLos2c5O97tdjt6smpyzaj+SMbt5LKd+xxSj9l4MrBvnmG9W+xd
	ycmc3CIQLwECiqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725228477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu8AVE5JK8t78/PrT5tmJbP6bMcIjQZtHefYruXnozE=;
	b=io5H2sGxGTAb4ZeKt7XOb19d12K/ij3A1okuvB+dBeBZ7FZi0WhzyWL0X6tKt4WfYMRk44
	iEx/jCLRetG/DL94SyliaRT7UtkIB1dHpb26rMrp5m5KOukCWuoumwL6kyK5+8DXQ3dkR6
	0rt8RgNcMTIj21ogM6au5bI5379jMz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725228477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu8AVE5JK8t78/PrT5tmJbP6bMcIjQZtHefYruXnozE=;
	b=0ErlRmzazEXLsjSTBsipLos2c5O97tdjt6smpyzaj+SMbt5LKd+xxSj9l4MrBvnmG9W+xd
	ycmc3CIQLwECiqBA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id E8CAD2012C; Mon,  2 Sep 2024 00:07:56 +0200 (CEST)
Date: Mon, 2 Sep 2024 00:07:56 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ethtool-next v2 3/3] ethtool: Introduce a command to list
 PHYs
Message-ID: <7fpbxztptolcuz4ppppkmpmblel7mv4nh4jgkjqbdedo4hrcjc@6oo6acqfejas>
References: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
 <20240828152511.194453-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="evcqqksds2rs6c5y"
Content-Disposition: inline
In-Reply-To: <20240828152511.194453-4-maxime.chevallier@bootlin.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,bootlin.com,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,lists.infradead.org,csgroup.eu,gmail.com,nxp.com,lwn.net,pengutronix.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo,bootlin.com:email]
X-Spam-Score: -4.40
X-Spam-Flag: NO


--evcqqksds2rs6c5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 05:25:10PM +0200, Maxime Chevallier wrote:
> It is now possible to list all Ethernet PHYs that are present behind a
> given interface, since the following linux commit :
> 63d5eaf35ac3 ("net: ethtool: Introduce a command to list PHYs on an inter=
face")
>=20
> This command relies on the netlink DUMP command to list them, by allowing=
 to
> pass an interface name/id as a parameter in the DUMP request to only
> list PHYs on one interface.
>=20
> Therefore, we introduce a new helper function to prepare a interface-filt=
ered
> dump request (the filter can be empty, to perform an unfiltered dump),
> and then uses it to implement PHY enumeration through the --show-phys
> command.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
[...]
> diff --git a/netlink/extapi.h b/netlink/extapi.h
> index c882295..fd99610 100644
> --- a/netlink/extapi.h
> +++ b/netlink/extapi.h
> @@ -56,6 +56,7 @@ int nl_set_mm(struct cmd_context *ctx);
>  int nl_gpse(struct cmd_context *ctx);
>  int nl_spse(struct cmd_context *ctx);
>  int nl_flash_module_fw(struct cmd_context *ctx);
> +int nl_get_phy(struct cmd_context *ctx);
> =20
>  void nl_monitor_usage(void);
> =20

Please add also a fallback to !ETHTOOL_ENABLE_NETLINK branch, similar
to other netlink handlers, so that a build with --disable-netlink does
not fail.

Michal

--evcqqksds2rs6c5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmbU5bcACgkQ538sG/LR
dpVJ2Qf8DGGY24yCgNhGpnmPlfv1tRX6emTG3LvB8oOHGngRoMyylyXvpnrpWAr3
7rhlowlNOzXuXzKfQZPEcDmtO9XyH7rxIokopIZWSw5w8IjzLF5s/ZMydl7pVR8l
BfYvpP1EaZyi9/18oEBAQ3AhXVCXW2vai9lArLtT3ZJgf9E2AsM/cZoIO8sNTiGS
nneX7pCXn6JhFor/ykm9Llg40z//rU54g2bWsaKQF/BFxGjQ3nm3ene20HyUnZVu
MUtK3oSvf7SzUfWZtEcf/epnQ/9Fcw6BmmSenY9U9qNbcaQULuHqwCR/jxGsIgzH
8YEv1scgIUJkQ61JmN4Asl8hrbNZdQ==
=ASEQ
-----END PGP SIGNATURE-----

--evcqqksds2rs6c5y--

