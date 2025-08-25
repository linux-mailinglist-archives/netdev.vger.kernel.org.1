Return-Path: <netdev+bounces-216559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321DB34824
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A075E2D3A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7408301039;
	Mon, 25 Aug 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEDrd/5u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CE25C821;
	Mon, 25 Aug 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141279; cv=none; b=iyVI1afW117dkXl0ED8EXJshnb8piD/sJfQ+Put9mrQe4aQk/23bss+oh+9pTsgd0/AJV4GX8eMPBiOr75lui31lI/YAw8MYad9jwRv9/7XM4/A0Phu5tKf849JFtpUgduM518AHadQlHP5fnBzcWfHMbiD75tvswPcChmANFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141279; c=relaxed/simple;
	bh=IMUW6CVxrGrZJ/WRpVFLGrFRcQ/UhH4rr54AG1fKyVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxkucX4aH6N/vw96UFoUa9jnysHNacMbBq0TljN/3bqgsIzZYKwwGFIVYbxN7lra3bSiHGUnWRf3i1iRirs7T7Fg2lu5VAa11xFnDjhqKJQj0sEwDon7wLEww51UJ3NOSYIxnkeU25tqu9Vc2HGZwMTHlqdLQ84L9UtoNGJVRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEDrd/5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFDC4CEED;
	Mon, 25 Aug 2025 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756141278;
	bh=IMUW6CVxrGrZJ/WRpVFLGrFRcQ/UhH4rr54AG1fKyVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cEDrd/5ulWrDVaellrV3e74HPUec+sxdSqe5093jG76xEtHbSSIFtdHkmtpdyU9OX
	 AcZkR64HmxkeBZu+qrk9rezhGRjdKjYhs9wJcKyhqXbJGDo9rLS13O6p+VfYAdyql4
	 bu3BoWP7Yk9Fj3yIcjatUHReX5U2Q2Gl8l1IUmaXA0V1p+X3TkzVNtVN+eOukoul2O
	 pM6lp14rnSSW4uc1Y3qMQ6Py0hHZhwtpzpu+hplQ75cOn1W3FIhQ2TQGFyUplu6hGJ
	 PAxR3/fxnwRPTL7LcvMYkt7/JFwXjJ7cuT44RXKwrs8/xU5IniSv9EDWuVTgcVMSij
	 6k0n9anUdVkGg==
Date: Mon, 25 Aug 2025 10:01:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@denx.de>, Jonathan
 Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
 Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v3 2/3] net: ynl: add generated kdoc to UAPI
 headers
Message-ID: <20250825100116.4e8a3cd4@kernel.org>
In-Reply-To: <aKrJAzMdgGcNiRUC@pengutronix.de>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
	<20250820131023.855661-3-o.rempel@pengutronix.de>
	<7e948eb9-2704-433e-9b51-fd83716e37d1@oracle.com>
	<aKrJAzMdgGcNiRUC@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Aug 2025 10:10:43 +0200 Oleksij Rempel wrote:
> > > +/**
> > > + * enum dpll_pin
> > > + * @DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET: The FFO (Fractional Freq=
uency
> > > + *   Offset) between the RX and TX symbol rate on the media associat=
ed with the
> > > + *   pin: (rx_frequency-tx_frequency)/rx_frequency Value is in PPM (=
parts per =20
> >=20
> > spacing for clarity (rx_frequency - tx_frequency) / rx_frequency =20
>=20
> Thank you for the review. The comments you refer to are autogenerated
> from the YAML specs. Extending my patch to adjust or clean up those
> generated comments would mean adding side-quests outside the scope of
> the actual change. I=E2=80=99d rather keep this series focused, otherwise=
 I risk
> not being able to complete it.

SG, FWIW.

