Return-Path: <netdev+bounces-147264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F06D9D8CD4
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11BE168E02
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903A1B87E1;
	Mon, 25 Nov 2024 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8Phw636";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8hPoSL7K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8Phw636";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8hPoSL7K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C51AF0CE
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562974; cv=none; b=g9iuKIaVJNMCVq0G41wo6+2rWii368o8VLvhIYMbPQW9na3c+uDyKE1+mTOMRt2rygGJDPQWXVAFlejNuAslOWxRuKx+SAkezC/bnmQymCvv74qjvCNxv5S8MH4jVlbT2ztNeApCquCS8YuKop4iXSMgrHKYTfU8P9nmO/K+x2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562974; c=relaxed/simple;
	bh=ZQYUWyU8CxxO1V2LrrcSrvzYIhtRDVhiIyTAAiaqE7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksEtVYMRSR09fjQmLmlhJ7ixVeiMcIIflgB5QYI3C7HXnzG9wPL8fMFfxqKzBxbW299AYhLiwrlwPyAzMEip9+7VT5dePdkrSANqr/+syiKhyuj9xv9PrnGH/1ijsQLdbvk0RG61m+8ypQYVR8ekFvIxqX+4GJLLJAEPpwAgMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8Phw636; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8hPoSL7K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8Phw636; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8hPoSL7K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 627A921114;
	Mon, 25 Nov 2024 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732562970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gi002pgisGg4G7GukPWmJSsL3tqpos9pFqchM5DJVEg=;
	b=v8Phw636fMcsom8C4KH/LysCyz5IKjwsI+x1C5p8l9kp1h0GAEG65lq2ShXvxrKMYY+zUe
	9eITE5kSUq0/xFTIy7QNRSiIMFvBkzvsukMWXHKfnEgaU2qzs7ncbtLeixPYHov+NxTZ+p
	ZhG7V7ek1Hrl2boAl7olC2RH3pDdxQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732562970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gi002pgisGg4G7GukPWmJSsL3tqpos9pFqchM5DJVEg=;
	b=8hPoSL7K4Zv7DBEU/+XCHVJAP8bskAiKqjWvfG3BOojPhVhmAQ4K9Ob1wHRJXmonexuah3
	Newfeyxhc8zNU5Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732562970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gi002pgisGg4G7GukPWmJSsL3tqpos9pFqchM5DJVEg=;
	b=v8Phw636fMcsom8C4KH/LysCyz5IKjwsI+x1C5p8l9kp1h0GAEG65lq2ShXvxrKMYY+zUe
	9eITE5kSUq0/xFTIy7QNRSiIMFvBkzvsukMWXHKfnEgaU2qzs7ncbtLeixPYHov+NxTZ+p
	ZhG7V7ek1Hrl2boAl7olC2RH3pDdxQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732562970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gi002pgisGg4G7GukPWmJSsL3tqpos9pFqchM5DJVEg=;
	b=8hPoSL7K4Zv7DBEU/+XCHVJAP8bskAiKqjWvfG3BOojPhVhmAQ4K9Ob1wHRJXmonexuah3
	Newfeyxhc8zNU5Aw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 4D8422012C; Mon, 25 Nov 2024 20:29:30 +0100 (CET)
Date: Mon, 25 Nov 2024 20:29:30 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v1 1/1] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <dkfesntoylodx2xm65frikdhm6gslddp6xj2mcidxwbpjtklsv@cwfxiuywrysg>
References: <20241119131054.3317432-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6icaa3dgrtwyuwmk"
Content-Disposition: inline
In-Reply-To: <20241119131054.3317432-1-o.rempel@pengutronix.de>
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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


--6icaa3dgrtwyuwmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 02:10:54PM +0100, Oleksij Rempel wrote:
> diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
> index 5c0e1c6f433d..97a994961c8e 100644
> --- a/netlink/desc-ethtool.c
> +++ b/netlink/desc-ethtool.c
> @@ -252,12 +252,14 @@ static const struct pretty_nla_desc __cable_test_re=
sult_desc[] =3D {
>  	NLATTR_DESC_INVALID(ETHTOOL_A_CABLE_RESULT_UNSPEC),
>  	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_PAIR),
>  	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_CODE),
> +	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_SRC),
>  };
> =20
>  static const struct pretty_nla_desc __cable_test_flength_desc[] =3D {
>  	NLATTR_DESC_INVALID(ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC),
>  	NLATTR_DESC_U8(ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR),
>  	NLATTR_DESC_U32(ETHTOOL_A_CABLE_FAULT_LENGTH_CM),
> +	NLATTR_DESC_U8(ETHTOOL_A_CABLE_FAULT_LENGTH_SRC),
>  };
> =20
>  static const struct pretty_nla_desc __cable_nest_desc[] =3D {

AFAICS both new attributes are U32 so that NLATTR_DESC_U32() should be
used here. Looks good to me otherwise.

One question: the kernel counterpart seems to be present in 6.12 final,
is there something that would prevent including this in ethtool 6.12
(planned to be wrapped up at the end of this week)?

Michal


--6icaa3dgrtwyuwmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmdE0BUACgkQ538sG/LR
dpUCwgf/S+Zs26v1SHmCa62NritpO5RZpOmB/SOROV16itI4ToRE5XZsELeQK/VX
VeD7vkVpj3cePnZzSIht99ZD4W0ulkjLwcaLQEkf4X0SWwmE443UfJWhreBnGxMP
Iyv9cG5M2iLFKMWy+Zelu5yvJDkOD/5rXWK4gs3phexeF2WkcLvBedVeFAAA3ojk
rCcPYiWfsqBFGxe8T7Fs3iJv5b2m2ZKvbhMDKgZ3T/rfaxkK4qIVsM2fWvMU6rC+
keaE/WDnTa4bh8629kD6HMJIuTaY1CfTyGAcnxqCjjWtNhPQDuvN+Flv6PBYH+OX
/eU/xFjR8kE35amq+uWoD5mlUkSziw==
=db31
-----END PGP SIGNATURE-----

--6icaa3dgrtwyuwmk--

