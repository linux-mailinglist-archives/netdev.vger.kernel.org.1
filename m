Return-Path: <netdev+bounces-155199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DEFA01710
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E642118831AC
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D315DBAE;
	Sat,  4 Jan 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dozAWfMD"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345D846D;
	Sat,  4 Jan 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029449; cv=none; b=OnNhGVIkBy4r4Yhpn4ChICmoOO+FHDpegVC3x3fyuTV3zLyQOlVtyufzZNyl+Wo8CrdOgxT5wGlvl2RmwWmp2mDcZU4YYatad5N08aRMUIvN7P9sedYoSjnr9K2RfFTTCuc6TxYhUdiOBCU2GwAf1xjJrC32jXTPX4UxZIWXp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029449; c=relaxed/simple;
	bh=mJP7MmymDvBHuu3GkGqqjffvuPPCe6EPotolqP1uAhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5e25RaTQU2yJ2ZJGPQYOHotXHLtotYGv+IRYRpeyIp9eeUOSbPLXkU/jyZt/7PcCrIHUBgvFf5kGWC3zzN8LGRmLCKFWCi1wD2DH3C4h6RHWdskwX6yrhFMsYWeNEpJufrCfyl7wWBYHt5Ngy16nH/itxCXWii9RGzvBuK6sGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dozAWfMD; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36F0260002;
	Sat,  4 Jan 2025 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czvChNqrTnVqBrG36tMy4XATCviKEogNfCQw5FJmBGs=;
	b=dozAWfMDXRguNqllDMrxQa8OYymXUBIYiRVahigFVYfExjNGvrIpIRVnZat+EQZFoijqZD
	wnNyMFaf+ICZv/iuLiwg7GWT6KphiCRUZt3z7CRUrw8A8GeTYL1/OeShn1QRuyD2ppcDfy
	RyjDFmk9btDc3U542HVWQnCLxKsZswYuVDBB/AHGFigfl2GpPD6YPfg+xk8f6VcYvd3A4y
	AqfB/f53LSSdwIsBpU2IhgQDuK6Q/mJFEFt61eGTdka9xjrvgsVona0e9YTNhAgud+MPkV
	w2qz8QbMVx6N19cG2IkhgWXybXPiMMZCHW9dW8d+2y3uYqiFPXZM0IxCNwUF8g==
Date: Sat, 4 Jan 2025 23:23:59 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <20250104232359.2c7a7090@kmaincent-XPS-13-7390>
In-Reply-To: <Z2hgbdeTXjqWKa14@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
	<Z2g3b_t3KwMFozR8@pengutronix.de>
	<Z2hgbdeTXjqWKa14@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sun, 22 Dec 2024 19:54:37 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

>         transformer {
>             model =3D "ABC123"; /* Transformer model number */
>             manufacturer =3D "TransformerCo"; /* Manufacturer name */
>=20
>             pairs {
>                 pair@0 {
>                     name =3D "A"; /* Pair A */
>                     pins =3D <1 2>; /* Connector pins */
>                     phy-mapping =3D <PHY_TX0_P PHY_TX0_N>; /* PHY pin map=
ping */
>                     center-tap =3D "CT0"; /* Central tap identifier */
>                     /* if pse-positive and pse-negative are present -
> polarity is configurable */ pse-positive =3D <PSE_OUT0_0>; /* PSE-control=
led
> positive pin -> CT0 */ pse-negative =3D <PSE_OUT0_1>; /* PSE-controlled
> negative pin -> CT0 */ };
>                 pair@1 {
>                     name =3D "B"; /* Pair B */
>                     pins =3D <3 6>; /* Connector pins */
>                     phy-mapping =3D <PHY_RX0_P PHY_RX0_N>;
>                     center-tap =3D "CT1"; /* Central tap identifier */
>                     pse-positive =3D <PSE_OUT1_0>;
>                     pse-negative =3D <PSE_OUT1_1>;
>                 };
>                 pair@2 {
>                     name =3D "C"; /* Pair C */
>                     pins =3D <4 5>; /* Connector pins */
>                     phy-mapping =3D <PHY_TXRX1_P PHY_TXRX1_N>; /* PHY
> connection only */ center-tap =3D "CT2"; /* Central tap identifier */
>                     pse-positive =3D <PSE_OUT2_0>;
>                     pse-negative =3D <PSE_OUT2_1>;
>                 };
>                 pair@3 {
>                     name =3D "D"; /* Pair D */
>                     pins =3D <7 8>; /* Connector pins */
>                     phy-mapping =3D <PHY_TXRX2_P PHY_TXRX2_N>; /* PHY
> connection only */ center-tap =3D "CT3"; /* Central tap identifier */
>                     pse-positive =3D <PSE_OUT3_0>;
>                     pse-negative =3D <PSE_OUT3_1>;
>                 };
>             };
>         };
>=20
>         pse =3D <&pse1>; /* Reference to the attached PSE controller */

The PSE pairset and polarity are already described in the PSE bindings.
https://elixir.bootlin.com/linux/v6.12.6/source/Documentation/devicetree/bi=
ndings/net/pse-pd/pse-controller.yaml

I am not sure it is a good idea to have PSE information at two different pl=
aces.

>         leds {
>             ethernet-leds {
>                 link =3D <&eth_led0>; /* Link status LED */
>                 activity =3D <&eth_led1>; /* Activity LED */
>                 speed =3D <&eth_led2>; /* Speed indication LED */
>             };
>=20
>             poe-leds {
>                 power =3D <&poe_led0>; /* PoE power status LED */
>                 fault =3D <&poe_led1>; /* PoE fault indication LED */
>                 budget =3D <&poe_led2>; /* PoE budget usage LED */
>             };
>         };

Maybe the PoE leds should also land in our pse-pis binding.

> In case of PoDL, we will have something like this:
>=20
> pair@0 {
>     name =3D "A"; /* Single pair for 10BaseT1L */
>     pins =3D <1 2>; /* Connector pins */
>     phy-mapping =3D <PHY_TXRX0_P PHY_TXRX0_N>; /* PHY pin mapping */
>     podl-mapping =3D <PODL_OUT0_P PODL_OUT0_N>; /* PoDL mapping: Positive=
 and
> negative outputs */ };

We should do the same for PoDL. Put all information in the same place, the =
PSE
bindings.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

