Return-Path: <netdev+bounces-194347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7A8AC8D02
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 13:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1942D1C01198
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD193225788;
	Fri, 30 May 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rSCvCGaR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2VHRIx2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rSCvCGaR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2VHRIx2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020C219311
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604928; cv=none; b=dgW61Iks0g3XgBnBZNIq+iSn5sCSa/ddF1kf9DrjzB5gvrG49m9qiregB10S1174f1Ta0ONHZbVWiLTP+AngoCIk9dVRvISCVTtOMgwAExbpgBRpCgOIZ+k/fEJyAsthq4z0XNsM7yegeiqKgC/RRdtUMzAdpPDyRm71OpFIrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604928; c=relaxed/simple;
	bh=y/stC4K9i4vO2OpsS6fwAjNL1GTdcA2/F1F1thf7ZQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bix0ydmn3ww3u2RNtjUR2QQEJpuv+QfN+hFLZTYwMPGx/58qT9/EAQ5GcTiMuaTOtKcym9QXYsM5mQFLKzQo7PMVmSZe/u5QVJdTtXs840Mfgsd8xluBnJGwjbcubeVWEeYw74rcbpGvvbozl4JkJaLaQRGJnxcsvPDSuXuIDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rSCvCGaR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2VHRIx2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rSCvCGaR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2VHRIx2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2581221ADF;
	Fri, 30 May 2025 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748604925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O6eTYLoY4I6lNn0GpzPc9oy0aeZmEDNu7+vaZx1OLUs=;
	b=rSCvCGaRGNDAumMahBi0xrlcFkSBTOiIPjJUhdcmgTubLsgDsCdz1fiuwEmlnUIjBuwmMy
	2nTfhImw0XQbH2YmduuzSGU4Hvv/CpukdtGjn6EZGZYmtZR+WV18M9Ib7W75zIC2jENY53
	SXdep0JqnM/z/ni4t2gUJ0/rih9LfRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748604925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O6eTYLoY4I6lNn0GpzPc9oy0aeZmEDNu7+vaZx1OLUs=;
	b=W2VHRIx2AivA/iQww6ktS/Tmy31Wc/oc2MYarL++3FDMtAAOQroz8scvCQI/QMxc7W+NhZ
	WmL3Yvv8wvyLpbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748604925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O6eTYLoY4I6lNn0GpzPc9oy0aeZmEDNu7+vaZx1OLUs=;
	b=rSCvCGaRGNDAumMahBi0xrlcFkSBTOiIPjJUhdcmgTubLsgDsCdz1fiuwEmlnUIjBuwmMy
	2nTfhImw0XQbH2YmduuzSGU4Hvv/CpukdtGjn6EZGZYmtZR+WV18M9Ib7W75zIC2jENY53
	SXdep0JqnM/z/ni4t2gUJ0/rih9LfRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748604925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O6eTYLoY4I6lNn0GpzPc9oy0aeZmEDNu7+vaZx1OLUs=;
	b=W2VHRIx2AivA/iQww6ktS/Tmy31Wc/oc2MYarL++3FDMtAAOQroz8scvCQI/QMxc7W+NhZ
	WmL3Yvv8wvyLpbDQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 14CAF20057; Fri, 30 May 2025 13:35:25 +0200 (CEST)
Date: Fri, 30 May 2025 13:35:25 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: danieller@nvidia.com, idosch@idosch.org, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 0/2] module_common: adjust the JSON output for
 per-lane signals
Message-ID: <tby3ld5penbfzrpvlbocwrmnyyahtjrocejelqfhfcrryz3uzq@24fixhzgipcl>
References: <20250529142033.2308815-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2t5znddz73v7zxl"
Content-Disposition: inline
In-Reply-To: <20250529142033.2308815-1-kuba@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Level: 


--b2t5znddz73v7zxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 07:20:31AM GMT, Jakub Kicinski wrote:
> I got some feedback from users trying to integrate the SFP JSON
> output to Meta's monitoring systems. The loss / fault signals
> are currently a bit awkward to parse. This patch set changes
> the format, is it still okay to merge it (as a fix?)
> I think it's a worthwhile improvement, not sure how many people
> depend on the current JSON format after 1 release..

It's unfortunate that the format already got into 6.14 but thankfully
it's been only about six weeks since so hopefully there won't be many
(or perhaps none if we are lucky).

I wonder if it would make sense to also release 6.14.1 with the format
change to make it more apparent for those using 6.14 that the change
should be backported. SLE16 (and Leap 16.0) is going to be one of the
distributions with ethtool 6.14 but there I can add the patch myself.

Michal

>=20
> Jakub Kicinski (2):
>   module_common: always print per-lane status in JSON
>   module_common: print loss / fault signals as bool
>=20
>  module-common.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.49.0
>=20

--b2t5znddz73v7zxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmg5l/gACgkQ538sG/LR
dpW0QAgAjLRaQ4PmmJjhiA2p1sgno8XUDCWMoQSaAWCOjOJzJFtb4+K0allVRqYJ
oqLUNa4J1ldm9hSrM//0CwaN3ouDScWEF0N8AKYfeX45wuTp8p0v42PKZuCjwTjH
LICQLzYDvw2/Nc/4zaGo/peu7MWcKBLMYUvcyIEXSSAjruyBZQrTBtvKALaI3qi/
yeKUD5tLTALs6cRSxS9YMlur7VD3HCeU44TGFKqbMbEyEJEH5J8Ch2XKmfJA7MRz
KBddk1XK1YTlbVQUB9qP4gH0Jc0wF7gFLS2BMCUBNgxIzOk95+yUOxAezrH59d5d
q6kDJ6w17mt5scVzMJ5c8fEqjmNcaw==
=SVAL
-----END PGP SIGNATURE-----

--b2t5znddz73v7zxl--

