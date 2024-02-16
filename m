Return-Path: <netdev+bounces-72420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520E857FE0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD5F28ABD6
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBE12F36E;
	Fri, 16 Feb 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sOlvpWEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9qcZeYv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sOlvpWEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9qcZeYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B991292F4
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095476; cv=none; b=HomFpcluz2geVoJNrGrsCp4sm1gNiCQPRqfFGt1+hxBH5J88++24zDyqrteOKNcYajBPEHOJ3YZhfhA013FixIMPJcywjWL5IRNO1VTzXvlE/3Xc6lvPCX8wRuiFdjdQlikYabKijMXun+rAo74NL5a8VwdfQZMtxACkjbpidOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095476; c=relaxed/simple;
	bh=V+c51SFFJ8LbyRiibC6WsTcCgjwVv4aa0UIQtzoC+JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulhaF36UqWsGyYnIcOmmi/CgjEU1Gp3mNCEGmPbVlQDMpdqsi3vUEqy2dwXoY6ny+iLy7OuXcbAowxwGHp5+YBOh2Z/ftvMgmo7sG9yTzzDITdoFdNKxBxiqBewGk9mHYx/6o4x/EEp4v7pSc9J/0yy596jStRqSx8Egi3ifZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sOlvpWEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9qcZeYv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sOlvpWEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9qcZeYv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD122228A;
	Fri, 16 Feb 2024 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708095472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYBdoFJavKkcRO/dbhSNFteRlHhSdTQSLKCeAc/bjqk=;
	b=sOlvpWELaEGgs+fqHP1G7PZX4Kkdd79HvXxkpRyHeCz6wr/xZRd1SfNXJlnalzB5hW4epd
	+V0CImwOuT4icbs//WbGovPf6h3FoS9pPeMuT/SAhHSsKXXKWDpCF5dYelhI4FntDUwCrC
	p+K6pf4LODMXlSI1t+TSMauA2nhb3Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708095472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYBdoFJavKkcRO/dbhSNFteRlHhSdTQSLKCeAc/bjqk=;
	b=f9qcZeYvJWHNJtWj3H/K1O6Gv6KYxz8GjnwVtfk6VAS1/Hda05IcNtOHG+nUX9F4AjWkkq
	djWVdzaEMGpaXRAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708095472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYBdoFJavKkcRO/dbhSNFteRlHhSdTQSLKCeAc/bjqk=;
	b=sOlvpWELaEGgs+fqHP1G7PZX4Kkdd79HvXxkpRyHeCz6wr/xZRd1SfNXJlnalzB5hW4epd
	+V0CImwOuT4icbs//WbGovPf6h3FoS9pPeMuT/SAhHSsKXXKWDpCF5dYelhI4FntDUwCrC
	p+K6pf4LODMXlSI1t+TSMauA2nhb3Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708095472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYBdoFJavKkcRO/dbhSNFteRlHhSdTQSLKCeAc/bjqk=;
	b=f9qcZeYvJWHNJtWj3H/K1O6Gv6KYxz8GjnwVtfk6VAS1/Hda05IcNtOHG+nUX9F4AjWkkq
	djWVdzaEMGpaXRAQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 8900D20147; Fri, 16 Feb 2024 15:57:52 +0100 (CET)
Date: Fri, 16 Feb 2024 15:57:52 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH ethtool] move variable-sized members to the end of structs
Message-ID: <20240216145752.aihdclrz6o53tgl2@lion.mk-sys.cz>
References: <20240216140853.5213-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqq4a2xzyanawtyi"
Content-Disposition: inline
In-Reply-To: <20240216140853.5213-1-dkirjanov@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.20 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SIGNED_PGP(-2.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.20


--eqq4a2xzyanawtyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 09:08:53AM -0500, Denis Kirjanov wrote:
> The patch fixes the following clang warnings:
>=20
> warning: field 'xxx' with variable sized type 'xxx' not at the end of a s=
truct
>  or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>=20
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>

Have you checked if this does not break the ioctl interface? Many of
these structures (maybe even all of them) are directly passed to kernel
via ioctl so that rearranging them would break the data block format
expected by kernel.

AFAICS at least in the cases that I checked, the outer struct member is
exactly the data expected as variable part of the inner struct.

Michal


> ---
>  ethtool.c  | 18 +++++++++---------
>  internal.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/ethtool.c b/ethtool.c
> index 3ac15a7..32e79ae 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -1736,8 +1736,8 @@ get_stringset(struct cmd_context *ctx, enum ethtool=
_stringset set_id,
>  	      ptrdiff_t drvinfo_offset, int null_terminate)
>  {
>  	struct {
> -		struct ethtool_sset_info hdr;
>  		u32 buf[1];
> +		struct ethtool_sset_info hdr;
>  	} sset_info;
>  	struct ethtool_drvinfo drvinfo;
>  	u32 len, i;
> @@ -2683,8 +2683,8 @@ do_ioctl_glinksettings(struct cmd_context *ctx)
>  {
>  	int err;
>  	struct {
> -		struct ethtool_link_settings req;
>  		__u32 link_mode_data[3 * ETHTOOL_LINK_MODE_MASK_MAX_KERNEL_NU32];
> +		struct ethtool_link_settings req;
>  	} ecmd;
>  	struct ethtool_link_usettings *link_usettings;
>  	unsigned int u32_offs;
> @@ -2752,8 +2752,8 @@ do_ioctl_slinksettings(struct cmd_context *ctx,
>  		       const struct ethtool_link_usettings *link_usettings)
>  {
>  	struct {
> -		struct ethtool_link_settings req;
>  		__u32 link_mode_data[3 * ETHTOOL_LINK_MODE_MASK_MAX_KERNEL_NU32];
> +		struct ethtool_link_settings req;
>  	} ecmd;
>  	unsigned int u32_offs;
> =20
> @@ -5206,8 +5206,8 @@ static int do_get_phy_tunable(struct cmd_context *c=
tx)
> =20
>  	if (!strcmp(argp[0], "downshift")) {
>  		struct {
> -			struct ethtool_tunable ds;
>  			u8 count;
> +			struct ethtool_tunable ds;
>  		} cont;
> =20
>  		cont.ds.cmd =3D ETHTOOL_PHY_GTUNABLE;
> @@ -5224,8 +5224,8 @@ static int do_get_phy_tunable(struct cmd_context *c=
tx)
>  			fprintf(stdout, "Downshift disabled\n");
>  	} else if (!strcmp(argp[0], "fast-link-down")) {
>  		struct {
> -			struct ethtool_tunable fld;
>  			u8 msecs;
> +			struct ethtool_tunable fld;
>  		} cont;
> =20
>  		cont.fld.cmd =3D ETHTOOL_PHY_GTUNABLE;
> @@ -5246,8 +5246,8 @@ static int do_get_phy_tunable(struct cmd_context *c=
tx)
>  				cont.msecs);
>  	} else if (!strcmp(argp[0], "energy-detect-power-down")) {
>  		struct {
> -			struct ethtool_tunable ds;
>  			u16 msecs;
> +			struct ethtool_tunable ds;
>  		} cont;
> =20
>  		cont.ds.cmd =3D ETHTOOL_PHY_GTUNABLE;
> @@ -5494,8 +5494,8 @@ static int do_set_phy_tunable(struct cmd_context *c=
tx)
>  	/* Do it */
>  	if (ds_changed) {
>  		struct {
> -			struct ethtool_tunable ds;
>  			u8 count;
> +			struct ethtool_tunable ds;
>  		} cont;
> =20
>  		cont.ds.cmd =3D ETHTOOL_PHY_STUNABLE;
> @@ -5510,8 +5510,8 @@ static int do_set_phy_tunable(struct cmd_context *c=
tx)
>  		}
>  	} else if (fld_changed) {
>  		struct {
> -			struct ethtool_tunable fld;
>  			u8 msecs;
> +			struct ethtool_tunable fld;
>  		} cont;
> =20
>  		cont.fld.cmd =3D ETHTOOL_PHY_STUNABLE;
> @@ -5526,8 +5526,8 @@ static int do_set_phy_tunable(struct cmd_context *c=
tx)
>  		}
>  	} else if (edpd_changed) {
>  		struct {
> -			struct ethtool_tunable fld;
>  			u16 msecs;
> +			struct ethtool_tunable fld;
>  		} cont;
> =20
>  		cont.fld.cmd =3D ETHTOOL_PHY_STUNABLE;
> diff --git a/internal.h b/internal.h
> index 4b994f5..e0beec6 100644
> --- a/internal.h
> +++ b/internal.h
> @@ -152,12 +152,12 @@ struct ethtool_link_usettings {
>  	struct {
>  		__u8 transceiver;
>  	} deprecated;
> -	struct ethtool_link_settings base;
>  	struct {
>  		ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
>  		ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
>  		ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
>  	} link_modes;
> +	struct ethtool_link_settings base;
>  };
> =20
>  #define ethtool_link_mode_for_each_u32(index)			\
> --=20
> 2.30.2
>=20

--eqq4a2xzyanawtyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXPd+oACgkQ538sG/LR
dpVrsQgAjEOmz2JD7UAlURlFqhGny1uwbQ12YRGFyLhmmD5agpKZNUmBiRMuYn/U
dIBBwk5feOs4Ws4LBIxrSYuzWwaHfg53GF9TRXkiavprO9aF0cpRGuKHCk65uGCO
yyUqh/7NsyWh+u7PUZTWMCSF77j9mfBJ7E0MZ3KrRLVQ75RR3nPX4l8ajsWRXfDV
eUZysh2DD2yuYmBQz4NSCggUWwuX0Bc0o3iCDJIvNAGCRi3yuoV+BrrhB3U95RCK
ls2LUOHoVgwJDVIdK2hTgHMskC5UDtp5DfZls3JQf4k31l/5Lhy35aQ5v0373pVc
JIgjXq1sBpePmik5xNEkSO6c/3uLiQ==
=NwTO
-----END PGP SIGNATURE-----

--eqq4a2xzyanawtyi--

