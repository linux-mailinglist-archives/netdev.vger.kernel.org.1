Return-Path: <netdev+bounces-117314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3B94D8FE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0840B1C20FFA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2817557;
	Fri,  9 Aug 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gz3K1PZv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0zuE0fc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gz3K1PZv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0zuE0fc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196D62171
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244809; cv=none; b=XwHOCeenCMgqV8HrrpU1ddfVud5D40K/NfhdWj+oUhQOthTKUZluCXa0rptn9J6bjUOmHfG4EC59Fj1SQIfWyNObNJyBVnyyPYRuw9+c+aFgLbd/AF2S5Mj3WT8Lel9lCDE+YJYlTaNUo+IgTt/u436qGOT3pw1ynIXwslNX2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244809; c=relaxed/simple;
	bh=nbKrTmI9hwI6cNrvdvXBpwynhPa16hO7N4LnoY3GLzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2nKR01U1vUl4kn/d5rCvPPqDuGmREYP31SqEiP6mMYlILgzicRJFGVtkXyWsJM7W/aQiwfFZtn9mP/twfxQegd4deBxMDEpW9Kdtm0x0XYSDSOr6DsTV2wIAK6IZ0zI4LOKWSEmCIODovzU62X8jfRgqVYvc22+FwM6OCqLzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gz3K1PZv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0zuE0fc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gz3K1PZv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0zuE0fc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04C892200B;
	Fri,  9 Aug 2024 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723244805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQn72XIgT1iLJT0izYrGsbOzMCeXXltzFN7uMKEmALw=;
	b=Gz3K1PZvVJI43gfaBQrGxdA2bA0Zau2aGqxEGAexmAgyK5X/B/Wtl3MnP30Sog/WrpHF9O
	hUXdAz+8ZDr9FgQc6Dv3dJM3kF37qPnMZDrmbvlVoJuCz3Fvf1iVvYHwTmcVKbS1Ezq+SO
	xSRlrdq54vnzauEo2ShlJwzsqKb5Y5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723244805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQn72XIgT1iLJT0izYrGsbOzMCeXXltzFN7uMKEmALw=;
	b=e0zuE0fc1GJvHL1kPms0zQQqBu+RO+ebnMtd0Wf0qhpwH6IIc2Nw/niif718zOFQbtKKf6
	lPgIFFfo/rW5VzCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723244805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQn72XIgT1iLJT0izYrGsbOzMCeXXltzFN7uMKEmALw=;
	b=Gz3K1PZvVJI43gfaBQrGxdA2bA0Zau2aGqxEGAexmAgyK5X/B/Wtl3MnP30Sog/WrpHF9O
	hUXdAz+8ZDr9FgQc6Dv3dJM3kF37qPnMZDrmbvlVoJuCz3Fvf1iVvYHwTmcVKbS1Ezq+SO
	xSRlrdq54vnzauEo2ShlJwzsqKb5Y5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723244805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQn72XIgT1iLJT0izYrGsbOzMCeXXltzFN7uMKEmALw=;
	b=e0zuE0fc1GJvHL1kPms0zQQqBu+RO+ebnMtd0Wf0qhpwH6IIc2Nw/niif718zOFQbtKKf6
	lPgIFFfo/rW5VzCA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id E25D32012C; Sat, 10 Aug 2024 01:06:44 +0200 (CEST)
Date: Sat, 10 Aug 2024 01:06:44 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, mlxsw@nvidia.com
Subject: Re: [PATCH ethtool-next 0/4] Add ability to flash modules' firmware
Message-ID: <tlni4jwvaznasghpjnhuy5zgq67f2bwisqopl2axda6mc6d77f@6uc7wbzm2djg>
References: <20240716131112.2634572-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6i7bq4wq4hat6vds"
Content-Disposition: inline
In-Reply-To: <20240716131112.2634572-1-danieller@nvidia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
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
X-Spam-Score: -5.90


--6i7bq4wq4hat6vds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 04:11:08PM +0300, Danielle Ratson wrote:
> CMIS compliant modules such as QSFP-DD might be running a firmware that
> can be updated in a vendor-neutral way by exchanging messages between
> the host and the module as described in section 7.2.2 of revision
> 4.0 of the CMIS standard.
>=20
> Add ability to flash transceiver modules' firmware over netlink.
>=20
> Example output:
>=20
>  # ethtool --flash-module-firmware eth0 file test.img
>=20
> Transceiver module firmware flashing started for device swp23
> Transceiver module firmware flashing in progress for device swp23
> Progress: 99%
> Transceiver module firmware flashing completed for device swp23
>=20
> In addition, add some firmware and CDB messaging information to
> ethtool's output for observability.
>=20
> Patchset overview:
> Patches #1-#2: adds firmware info to ethtool's output.
> Patch #3: updates headers.
> Patch #4: adds ability to flash modules' firmware.

Hello,

this series seems to be based on slightly different version of the kernel
counterpart than what was merged into mainline. One difference I noticed is
that this series uses ETHTOOL_A_MODULE_FW_FLASH_PASS while kernel headers
use ETHTOOL_A_MODULE_FW_FLASH_PASSWORD; but I'm not sure if it's the only
difference.

Could you please check it and update what is needed?

Michal

--6i7bq4wq4hat6vds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAma2oPkACgkQ538sG/LR
dpVhEAgAsVsDooVyaZIw1Lif2fw3e9AAU0BxJVjZwLIV0YfnGVPG3vt+pqJdDvJ/
+00d+ekpt4GA0mpLTIZ/nGtidifRtHgcBLRmEEhiKozT/vBZ+Vsvf35TKy8sysum
f4KCQdJRpdP91hJxeMR/zjkBu7trs7NMEZAPmaY/DXb+z/bTApLv9SWtDB/8f1uH
QgW2ZJVnFLlb8mAIraogXD/2DnbjULyrvEr8jF76eLuKHyRnl4DFR1VKVvtLJeeO
XJTF6/0Tih3LBxU99CTXpN14LDj5o2cXWpuwzdIdjOltBNCvhdTvEmxYzJ/I/Ese
37PrNSJ9f7kNWsNW3J8MLlK7VfwxUQ==
=Eedn
-----END PGP SIGNATURE-----

--6i7bq4wq4hat6vds--

