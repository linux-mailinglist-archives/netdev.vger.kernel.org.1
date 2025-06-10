Return-Path: <netdev+bounces-196365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1FAD4685
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC53A4F6D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477892D5412;
	Tue, 10 Jun 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWyT65AD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rczTYx8W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWyT65AD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rczTYx8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8E2D5402
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597202; cv=none; b=AgLUKbMX+4yfDVNYjnEs496Y+1WMzL+qHWEyxuEwWB5ede6UPGvJm0jFM3rowFNPcQ/7LcudhKJVjskuv6+12CEAdmKvgvfUocOqTRJMQlHPzUIO3A5PgtjQSrtmmdoo0lfwlHDZgVeDdc+hH8tRcmsGeX1yF/of1p3f6APCqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597202; c=relaxed/simple;
	bh=/l7g/NyvFPHhYB9HDgrAtt++8WEwAIk4/iH5ztPVPAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsBkSVT68USOyaKgxERAUKpvI402C1HL+am+lUCmDVdoTXyk16UaXeFJfmNPTWj7fV6AmxeASH0CD9IA3Obr9GKXey7YJiSGbDyo61B/tkjKoUObHFSKl+4mf3PyE3POlAJEgQud+pP9/HG70XgUcvSacUXxc2DGKob16P0PGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWyT65AD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rczTYx8W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWyT65AD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rczTYx8W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFD9A21A1C;
	Tue, 10 Jun 2025 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749597195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0xD5eKXqkxNpg7kWeAfrCbvYyjQgtN5ohGGVuVLR8k=;
	b=lWyT65ADC31xRsFiDp2/Tbd96vUOHDMygxeHHXtFlnc9z9Ln7ekT5e6ANcZbSVKGCOBWux
	nhrbIQrTzDI+UpoS5PDMUa9qQG28EYvcfmZI25TtFpVcdNBDISHqOVIIiZsfqQ3BAFXbed
	9UmvZPYp9fW/rH92r6O65mHZfE/LI7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749597195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0xD5eKXqkxNpg7kWeAfrCbvYyjQgtN5ohGGVuVLR8k=;
	b=rczTYx8WB1XCOHLBj+CLsealv3ZEx66Ovu8E6yADo0U5PbdPHPJvfgcOEyw++eZ06g5ElZ
	CffCDn/mxwiQrhBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749597195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0xD5eKXqkxNpg7kWeAfrCbvYyjQgtN5ohGGVuVLR8k=;
	b=lWyT65ADC31xRsFiDp2/Tbd96vUOHDMygxeHHXtFlnc9z9Ln7ekT5e6ANcZbSVKGCOBWux
	nhrbIQrTzDI+UpoS5PDMUa9qQG28EYvcfmZI25TtFpVcdNBDISHqOVIIiZsfqQ3BAFXbed
	9UmvZPYp9fW/rH92r6O65mHZfE/LI7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749597195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0xD5eKXqkxNpg7kWeAfrCbvYyjQgtN5ohGGVuVLR8k=;
	b=rczTYx8WB1XCOHLBj+CLsealv3ZEx66Ovu8E6yADo0U5PbdPHPJvfgcOEyw++eZ06g5ElZ
	CffCDn/mxwiQrhBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id ACF8620057; Wed, 11 Jun 2025 01:13:15 +0200 (CEST)
Date: Wed, 11 Jun 2025 01:13:15 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: ant.v.moryakov@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] fec: fix possible NULL dereference in fec_mode_walk()
Message-ID: <54af2ah7kfz5kpib75fafbftofbacuaa7hbdinlorngbfwxa2p@gvfjiiw5kiti>
References: <20250518131818.972039-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4tlx5w6iwg3vzqgr"
Content-Disposition: inline
In-Reply-To: <20250518131818.972039-1-ant.v.moryakov@gmail.com>
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
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 


--4tlx5w6iwg3vzqgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dne Sun, May 18, 2025 at 04:18:18PM GMT, ant.v.moryakov@gmail.com napsal:
> From: AntonMoryakov <ant.v.moryakov@gmail.com>
>=20
> Static analyzer (Svace) reported a possible null pointer dereference
> in fec_mode_walk(), where the 'name' pointer is passed to print_string()
> without checking for NULL.
>=20
> Although some callers check the return value of get_string(), others
> (e.g., walk_bitset()) do not. This patch adds an early NULL check
> to avoid dereferencing a null pointer.
>=20
> This resolves:
> DEREF_OF_NULL.EX.COND: json_print.c:142 via fec.c
>=20
> Found by Svace static analysis tool.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> ---
>  netlink/fec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/netlink/fec.c b/netlink/fec.c
> index 6027dc0..ed100d7 100644
> --- a/netlink/fec.c
> +++ b/netlink/fec.c
> @@ -27,6 +27,8 @@ fec_mode_walk(unsigned int idx, const char *name, bool =
val, void *data)
> =20
>  	if (!val)
>  		return;
> +	if (!name)
> +		return;
>  	if (empty)
>  		*empty =3D false;
> =20

I'll apply the patch as it makes the code cleaner and safer against
future rewrites but I don't think actual null pointer dereference is
still possible after your patch "json_print: add NULL check before
jsonw_string_field() in print_string()" as it fixes handling both key
and value being null in print_string().

Michal

--4tlx5w6iwg3vzqgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmhIvAcACgkQ538sG/LR
dpXvzAf+KPp02CJcqkozPUnzUhtdV5htnaWhyoRWb1Nntlu1xY716VMBt71tJUce
RAgX/G/96TWvfzTxviBexP8fVvtnQxhmYJ1Jd8vr+rDs8yh8mbfZ+6wjXxpAkSQ4
1ToNYSrg7tBIZGetQvTbH2Ucz+JBx6X8xs7sTh4jsHxlE0LqRL9jM57gU05XtKbg
i6uBV6rchKROllZBcKmTvzJaHrGNy+QeRynzC3vTwbO/X49GHNBf3XLL3QgFjM+e
fRJCgwCh89BbbBVV1FcNLUKnV+HDtPFAdb+TTjKYCVZ8t0U/NM/rL1puq12PaCRW
yO7JrD4r6LChDO0hc6pEY22dywxlwA==
=wMZZ
-----END PGP SIGNATURE-----

--4tlx5w6iwg3vzqgr--

