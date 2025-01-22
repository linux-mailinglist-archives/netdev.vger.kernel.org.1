Return-Path: <netdev+bounces-160281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B2A1920C
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88B73A2E85
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274020FABB;
	Wed, 22 Jan 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="byqfqMN1"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2383CC7;
	Wed, 22 Jan 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551260; cv=none; b=PWJbh1ZeYRdQrbdG/o8Gw5kWQRHQbKKQL1yEljCFCURqlbHG6YMqsPG5nz7IRRoVcimOiUDszUpVKNf0mKsfyhnVyowQgFQOlF9fL4jI1S27OTmd2t6mz4F2YoBy2/rrRXpO3BGiKka7rOJQg54SeQBVlGk5W+9eiyy+6KLRalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551260; c=relaxed/simple;
	bh=uNpQDH3ZdTxWWzesSMfekMOxKcdXlUb8vbcpZuD7mSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ+KARsmvT7aEvN2rE9d49KsCFx6V2XqYoLMCBp+ehJC5/V+63b1fF+dv8jktbyHB87qGfy3X103zMcRX9rYQH6zxe7njRc9J/4vcg3lBN9jiYCodffT9DFQfbm6Ym3qvbf6TjHkuGWRs3LEgHf9AIwdy1LwojkwrN3xEHMUWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=byqfqMN1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C05CB24000C;
	Wed, 22 Jan 2025 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737551251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f79sgirNquVrPTw/4uMnu5O9aV6JookXhGIW+QW7GnE=;
	b=byqfqMN1GFCpLrLEJsABHWp1y2JYKg/QAtE0Q6M6RHS7TD+JZcgfWXNEIBC3tb6qNsf/Ei
	zYP76ooYhpJjiRdQAIApQwcemNQj7qhPx+UbX4paP5bHcsiQIFFq8+1ccgCPjDM8Ad0nmA
	pjCMbJCAowxj0vI/6PSX1qNAuGhMTbROkY/WAqVxBukmb2wzeaCDl5UvyJyDdX9UdSLIdl
	f4JfLC2H67dG36Rz2lto95ttWSFY4+IpcU8w7r96mfxYsAnkE2oRp61XjkA3OfEqYWq5Ik
	TOqcpPm14U/eo5UvyWk9tKi3qXHdRLOJzVClLQ09l7cuUt/ZwQCPD6JlRgDzTA==
Date: Wed, 22 Jan 2025 14:07:19 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ninad Palsule <ninad@linux.ibm.com>, Jacky Chou
 <jacky_chou@aspeedtech.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
 <eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
 "robh@kernel.org" <robh@kernel.org>
Subject: Re: =?UTF-8?B?5Zue6KaGOiDlm57opoY6?= [PATCH v2 05/10] ARM: dts:
 aspeed: system1: Add RGMII support
Message-ID: <20250122140719.5629ae57@fedora.home>
In-Reply-To: <0ee94fd3-d099-4d82-9ba8-eb1939450cc3@lunn.ch>
References: <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
	<b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
	<59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
	<SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
	<8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
	<c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
	<c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
	<SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
	<9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
	<81567190-a683-4542-a530-0fb419f5f9be@linux.ibm.com>
	<0ee94fd3-d099-4d82-9ba8-eb1939450cc3@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Fri, 10 Jan 2025 16:38:18 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > Do we need updates on this description. It doesn't talk about external =
PCB
> > level delays?
> >=20
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/net/ethernet-controller.yaml#L77-L90
> >=20
> > This is what you explained:
> >=20
> > MAC driver reads following phy-mode from device tree. 95% of mac driver
> > directly
> > =C2=A0pass it to PHY through phy_connect.
> >=20
> > rgmii - PCB has long clock lines so delay is added by PCB
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On this mode PHY does nothin=
g.
> > rgmii-id - PCB doesn't add delay. Either MAC or PHY needs to add the de=
lay
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add delays=
 in both directions. Some PHY may not add delay in that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MAC n=
eeds to add the delay mask rgmii-id to rgmii.
> > rgmii-rxid - If there is an extra long TX clock line, but not RX clock,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 you would use rgmii-rxid
> > rgmii-txid - When there is an extra long RX clock line on the PCB, but =
not
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 the TX clock line, you would use rgmii-txid =20
>=20
> The documentation is not great, that has been said a few times.  What
> is described here is the view from the PHY, which is not ideal.
>=20
>       # RX and TX delays are added by the MAC when required
>       - rgmii
>=20
> From the perspective of the PHY, this means it does not need to add
> delays, because the MAC has added the delays, if required, e.g. the
> PCB has not added the delays.
>=20
> We have the problem that DT is supposed to describe the
> hardware. Saying the PHY should add the delays, but if the MAC adds
> the delays it needs to mask the value passed to the PHY does not
> describe the hardware, it is Linix implementation details. The DT
> Maintainers don't want that in the DT binding because other OSes might
> decide to implement the details differently.
>=20
> So your description becomes:
>=20
> rgmii      - PCB has long clock lines so delays are added by the PCB
> rgmii-id   - PCB doesn't add delay. Either MAC or PHY needs to add the de=
lays
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0   in both di=
rections.
> rgmii-rxid - There is an extra long TX clock line on the PCB, but not the=
 RX clock.
> rgmii-txid - There is an extra long RX clock line on the PCB, but not the=
 TX clock.
>=20
> It is correct, but leaves so much unsaid developers will still get it
> wrong.

I myself got it wrong, as the kernel doc explicitely says that the "rgmii"
phy-mode is the one to use to get MAC-side delay insertion, whereas the way=
 I
understand it, mac-side delay insertion doesn't really depend on the phy-mo=
de
passed from DT. Ideally we would even consider that these mac-side delay
insertion would have to be ignored in basic 'RGMII' mode, but I think that =
would
break quite some existing setups ?

Can we consider an update in the kernel doc along these lines :

---
 Documentation/networking/phy.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/ph=
y.rst
index f64641417c54..7ab77f9867a0 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -106,14 +106,17 @@ Whenever possible, use the PHY side RGMII delay for t=
hese reasons:
   configure correctly a specified delay enables more designs with similar =
delay
   requirements to be operated correctly
=20
-For cases where the PHY is not capable of providing this delay, but the
-Ethernet MAC driver is capable of doing so, the correct phy_interface_t va=
lue
-should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
-configured correctly in order to provide the required transmit and/or rece=
ive
-side delay from the perspective of the PHY device. Conversely, if the Ethe=
rnet
-MAC driver looks at the phy_interface_t value, for any other mode but
-PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
-disabled.
+The MAC driver may add delays if the PCB doesn't include any. This can be
+detected based on firmware "rx-internal-delay-ps" and "tx-internal-delay-p=
s"
+properties.
+
+When the MAC driver can insert the delays, it should always do so when the=
se
+properties are present and non-zero, regardless of the RGMII mode specifie=
d.
+
+However, the MAC driver must adjust the PHY_INTERFACE_MODE_RGMII_* mode it=
 passes
+to the connected PHY device (through phy_attach or phylink_create() for ex=
ample)
+to account for MAC-side delay insertion, so that the the PHY device knows
+if any delays still needs insertion on either TX or RX paths.
=20
 In case neither the Ethernet MAC, nor the PHY are capable of providing the
 required delays, as defined per the RGMII standard, several options may be
--=20

Thanks,

Maxime

