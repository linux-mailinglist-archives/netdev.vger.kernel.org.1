Return-Path: <netdev+bounces-257413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPVfCoNYhWkhAQQAu9opvQ
	(envelope-from <netdev+bounces-257413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:57:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6BF97AE
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA5C300FB40
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCD299923;
	Fri,  6 Feb 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARm6MA9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3A2A1AA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346623; cv=none; b=l7gnZMvjtNiG1OIoCjecu02PUmQ44rlY4sVuZP7+CZnhcKDQxhnJUg+sgi8KULlYI7O3HYhmU4ocjvvIENr3vUfDrTxr7hqUEcHcVGU/PnJZLWoKswlLkAQUyq3oVbbrpEzBKDXC0O22cBqMB9KXja9kJI3SMFpLEPHKcngtcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346623; c=relaxed/simple;
	bh=btvddpMCo+POrysRwjiHNzityRdAyxgMpjYo/qxXATk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot7JsSEi/ub7kALZlmdmFghH70kCkqHggGxDE84dYnzshrm37iFDs0hhOTjwJR3TT//R/AGKTSyqnNclmLL01bKWbohZoLS32plquqQUdq3PqsPmBCxnnMv59x7zSw0renywD7Dj+MP8mBQo+Xnt7PVB56JO1OwrWmve5Jrbbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARm6MA9w; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b7da62b487so3104623eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 18:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770346622; x=1770951422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TO5bxIMT3fTMREZKwhQ6bquMxzdY7Tp+3iN2NbRfN0=;
        b=ARm6MA9wQsBHvhsNdm7PR8z3/Kz7nl/sf+dVC0axS1ED0PGZ++ODtOU+zZz05cN+Ym
         WzVwihSJ93keHtnj0hdO1Za2/BCQ6TJPMkIxObdyNfprQ9t+6UbyG2fase6rWAoseX8l
         +bPNhWJnPkjLPc87meSWyQh+PTTnp9oEvoik0ZMdE+B+CY7Bpp1Twzzz5vfHt9CZLBUG
         B7ZQv5l2wwwiFv3YCq3gwEzev5/LSbLyYzc2ytm14DVHFq93SitjJRGzog6f+TdUQg6V
         0cHb0pVtai0Js6Yi4wS3MLd1JCxTZZyaJB/2K7Szx/ofjUz3sxBBa4g9MdL5gEKe/J/R
         5TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770346622; x=1770951422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TO5bxIMT3fTMREZKwhQ6bquMxzdY7Tp+3iN2NbRfN0=;
        b=KxNR9goj5NjHL9lL+Na/CyiExZalWMlt4EJUUHtSlcskFOCldO5Kx8+GzYdWHYY7oz
         9utp2njvBdv/lawvIf7DhpfwLPP34JoiqEYvdRz7uQL6bX6JwoPLFXa2ZERVMK455WaF
         uzBZVP0QUwwXKijNh3Ql3FTK7nqahe7MbaUm2P4GyeHxU0Eh4oLEGiKvxgF0NiA6bITe
         amfcZZYc7mnAd5XEDdxX/yQE7t2EKXdnRCrseMXhodCvNsTOGcgaqUtLfg3TfDvy59VW
         lDFgvtIFWz6KsYMTGfOkJ63eB2/5KAchdfPpi/64R12qaFLlYr/fh2fhk+M/+AfrfWZz
         2cfw==
X-Gm-Message-State: AOJu0YzqZhfzqyqrddvKtbZAiznW4s+fmeHUz6H9yYSJIce68BoJedks
	RIVOI3A2xsHw8dXH7VRh1ITye9WUwZbYg2tL6hw/WuV5aVgrbf+dR6vy
X-Gm-Gg: AZuq6aKRb/HfMoPvYcadg6oZittaRMVFyy/7Rrb67iTFaqljnZwaaF/BxHrYeDvU9wK
	wtAGSQpY7scz9DM6g/7i6F5q2wY6yDKHSWC/Xgyw59u85shXSFHBVpP6qw+JofWPmm1Ar5oKBU4
	2NHF9JXQd1UpkVue1tkeeMSfM4mouRT4PHip/vFlKkTlSGX4o/HQXBXoexxZ3salffXwi4rWYxa
	3PmCVVp/Bt+ylll6lKnNmfSrhAQKbsO6zityMIbGS/OJl2X2D7WJftJA3HRTQ4NCOKjD7K626wQ
	ZSgvHIHYJTOMR1wV9hO1kShpeVpszMhqz14APafKQj9qbSksJJwm6iBPmfpKbjanBLt7sxq+cbB
	+qjHwiehmMiYnKB1CVpAxQIFZRxIXkT+qruJIlsFxqQoG2N9yOTc/rDaVrc6pEUkU4IAr8UP6yr
	geDGb0f7Y=
X-Received: by 2002:a05:7300:230a:b0:2a4:3593:9697 with SMTP id 5a478bee46e88-2b8564cd5famr649623eec.20.1770346621920;
        Thu, 05 Feb 2026 18:57:01 -0800 (PST)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855ad8da2sm981019eec.5.2026.02.05.18.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 18:57:01 -0800 (PST)
Date: Fri, 6 Feb 2026 10:56:54 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Add dependency on HSR
Message-ID: <aYVYdqmyzBnTOZAV@pek-khao-d3>
References: <20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com>
 <20260205100315.134766d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c9cg0aXFcFFRHxpa"
Content-Disposition: inline
In-Reply-To: <20260205100315.134766d7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95B6BF97AE
X-Rspamd-Action: no action


--c9cg0aXFcFFRHxpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 10:03:15AM -0800, Jakub Kicinski wrote:
> Looks like there are appropriate static inlines in place to handle
> HSR=3Dn in the driver the only problematic case is if HSR is m and
> drivers is y, no?
>=20
> 	depends on HSR || HSR=3Dn
>=20
> is likely more suitable.

Yes, the icssg-prueth driver can still be built with HSR disabled. Therefor=
e,
this should be an optional dependency. I will update it to:

  depends on HSR if HSR

as this is the recommended way to express optional dependencies according to
kconfig-language.rst.

Thanks,
Kevin

--c9cg0aXFcFFRHxpa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmFWHYACgkQk1jtMN6u
sXHZkwf/SByWh1vNr3xcUG8JWzd31gxjuA758RZefHCoIca3s+pQw92UbkUzZFdv
UphvBbiHqnGetSg6JuwOIEVg+GDvYo5WWZQoRkufJ3qz7RHeiHVYnVutf1pthjYn
nIl5IyE64H4J8iiec7YCVcLs0Fjqy3zkfFSKoQe2uynDsxIMBVFWGW4saWoVznvo
iIxpD8s6XLGrKBfdIgpWQR7KdHJ0niv5PmUwozH//Tzr2IXqX6q1y3ZPTKF929Bi
ce05orKnLxvHT1v7CS8K9oKyp8a6dxS4MMRBnnEeLXSAOSb0bw4sZEvTozJgo+3c
FKdy5mq7L2wdIGn3Day4tvq1YDN2Bw==
=jZyM
-----END PGP SIGNATURE-----

--c9cg0aXFcFFRHxpa--

