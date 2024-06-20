Return-Path: <netdev+bounces-105154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172EA90FE19
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E7A1F23A2D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A050279;
	Thu, 20 Jun 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bzPZ+SsJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381774CDE0;
	Thu, 20 Jun 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870260; cv=none; b=N98r40+/ktxT1pWRiKrPuEDbZvxxmLumFSXMmR62QV2briWwssTcD5oe8rRNAsTnYuCDgBJby4eG15l8EuhIiXebkReywA092XmWOHyxaT7d0GyLgxRxfQyKVMHpTJWH1Q3BYbx/8tR6vS3419dN+tgQB7F9prJfI1YS/SCYv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870260; c=relaxed/simple;
	bh=36ksXXCoUERjDciqyomYjJO46lVtpFe9wPdrAkpcBis=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD/NzCv0p0JWyQ5PJka+B/EGPxKBFI4sJeKG2zGRqne8cTXthKLdhUEmKMG63l6NICqllRA7UdFoH0FGb3S+B70uuLiEY4Pnd8n3otyqnovzzYDNbmGhz7vhLHEw5yCy2vUWj+ShJ8c7kDfvLYObq6JvLTdCllBTTa5jucWfTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bzPZ+SsJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718870259; x=1750406259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36ksXXCoUERjDciqyomYjJO46lVtpFe9wPdrAkpcBis=;
  b=bzPZ+SsJ1jJkDw6xwdmlSQ+/nanJvrZmwDV7qeVAbWJDRqCJ+oiKlmIC
   0nyvfoPn8s9gAzP974G13nC2Vj5V0ShKtZsBqoFnlcDiA1f2e98FVi5DH
   1y1g6I9DrfnLnKGYGTdOPzEwZPQg7bkQCLGHb1LlxSZ+TzjPPXwmnF2Yp
   HQ0/QDMvFqJjiwq/xX4fUUouehyf3QJiJrwNpfbHD3dyekh/IP+059i8n
   TMGGXBNVpS8vCfksP6zW3Tf1xEZ/98o+9AAFdmkwNkVTxYG8+VFnqKzXs
   uPE5TVQ38OJTBeBGh/CWDraK15JyWuul+VmHIfM1a2oOheVxpg/rn6WS/
   A==;
X-CSE-ConnectionGUID: 0IakRMRFTkalAgulpU58WA==
X-CSE-MsgGUID: Zp8ATRj5TgmP6rT6IGHEBg==
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="asc'?scan'208";a="28280635"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2024 00:57:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 20 Jun 2024 00:57:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 20 Jun 2024 00:57:18 -0700
Date: Thu, 20 Jun 2024 08:56:59 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>, Conor Dooley
	<conor@kernel.org>, <florian.fainelli@broadcom.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240620-eskimo-banana-7b90cddfd9c3@wendy>
References: <20240619150359.311459-1-kamilh@axis.com>
 <20240619150359.311459-4-kamilh@axis.com>
 <20240619-plow-audacity-8ee9d98a005e@spud>
 <20240619163803.6ba73ec5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V6XhR9n98oENxy/Y"
Content-Disposition: inline
In-Reply-To: <20240619163803.6ba73ec5@kernel.org>

--V6XhR9n98oENxy/Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 04:38:03PM -0700, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 18:36:16 +0100 Conor Dooley wrote:
> > > Signed-off-by: Kamil Hor=E1k - 2N <kamilh@axis.com> =20
> >=20
> > Please fix your SoB and from addresses via your gitconfig as I told you
> > to in response to the off-list mail you sent me. You also dropped my Ack
> > without an explanation, why?
>=20
> +1, possibly repeating what Conor already said but the common
> format if 2N is your employer or sponsor of the work would be:

The explanation I was given was that Axis is the parent company of
2N.

>   Signed-off-by: Kamil Hor=E1k (2N) <kamilh@axis.com> =20

> --=20
> pw-bot: cr

BTW Jakub, am I able to interact with the pw-bot, or is that limited to
maintainers/senior netdev reviewers? Been curious about that for a
while..

--V6XhR9n98oENxy/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnPgvwAKCRB4tDGHoIJi
0rIOAPwOpz7uD4Wx4/+KNK7iRAV0YSft1SA0VMjBuPsib5LhSgD+KwLQ/s3HGXbp
ubQwIM6/G6JafosTasrGN1m2W4UAywA=
=q30j
-----END PGP SIGNATURE-----

--V6XhR9n98oENxy/Y--

