Return-Path: <netdev+bounces-200858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4DAE71AB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADE55A5D0A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CC25B1DC;
	Tue, 24 Jun 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NOC7mjqF"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9325A2C7
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801174; cv=none; b=VrN4VPrvtCZttqJumqVPv6sSsQhKA9XM8uHovMrWuY7aHqQtyvJ61Efmpw80Fzh9vP0WF0OkbPyg6Kvpr3CLVgZ4NyJYL/GJQvSU9lp9kCtx2DqRPDtVBoV1nQmOFDVt6vzKZ2bQselB5xYnt7A6khtEYK11IQx5I59niJ/Rwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801174; c=relaxed/simple;
	bh=LBjTkVfZHOIoYvkEjwdSDxb6FlCrdr7PeQnMu3LOab8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Ex0T2fUxDtFRYNMYfnBIoSbhofhr04hzWiq9JoVq+9z7Vk8/aVWITPvYUeybzp512fCuvAsp43iOYoH40mReb5fM46Hw9RELaoH+99GIplQW2fR2cLqXAF6TY9eUuodJPe0CfA+2lJK9tU+j0VoU7725jwOfrtqiwIh6bkB1Ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NOC7mjqF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A07FA41DE2;
	Tue, 24 Jun 2025 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750801164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XCQkd2T7xk+eqw+Bu/0GUJGYz4SsjK58fhVl1L9rqjM=;
	b=NOC7mjqFTz+fp7EsZ1Q8WtvGgpwXC815ZnBegWflrXUrf4OVFI5EVOcQnT9dzWOUWvM5Ii
	M0Bk54uT7RIkd9eeNRmIPoolY89VFroovxuhCN3U2rNzU/gUDdJ90ieJ80+0z5vgDXUgoo
	sjjbbl7RvMZvw0fNPuBG7VJdPE5RL02jzXoGLDmUKDu1PfPe8b9ratJu1sRkBaqeN8okiK
	9Yyslmq5QCcD/dZPkADdY4sHY3zINN5AfBikuH4mMIQOiZ7lBwWS5j6YZEojq85LyllCYy
	h2NFAqC0VWIYvagib13T5AizLATNqLfG5S/gALHQFI5wInfPe1I2eDlePoBavw==
Date: Tue, 24 Jun 2025 23:39:22 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Tao Ren <rentao.bupt@gmail.com>
Subject: Supporting SGMII to 100BaseFX SFP modules, with broadcom PHYs
Message-ID: <20250624233922.45089b95@fedora.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhoofggtgfgsehtqhertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffejiefhuefhtdehtdeugfffieehueegueetgfdtheefjeetheffteejhfejgfeknecuffhomhgrihhnpehfshdrtghomhenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnu
 higrdhorhhgrdhukhdprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtohhmpdhrtghpthhtohepkhgrsggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhhrghntghotghksegtrghlihgrnhdrtghomhdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopehrvghnthgrohdrsghuphhtsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

I'm reaching out to discuss an issue I've been facing with some SFP modules
that do SGMII to 100FX conversion.

I'm using that on a product that has 1G-only SFP cage, where SGMII or 1000B=
aseX
are the only options, and that product needs to talk to a 100FX link partne=
r.

The only way this can ever work is with a media-converter PHY within the SF=
P,
and apparently such SFP exist :

https://www.fs.com/fr/products/37770.html?attribute=3D19567&id=3D335755

I've tried various SFP modules from FS, Prolabs and Phoenix Contact with
no luck. All these modules seem to integrate some variant of the
Broadcom BCM5641 PHYs.

I know that netdev@ isn't about fixing my local issues, but in the odd chan=
ce anyone
has ever either used such a module successfully, or has some insight on wha=
t is
going on with these Broadcom PHYs, I would appreciate a lot :) Any finding =
or
patch we can come-up with will be upstreamed of course :)

Any people with some experience on this PHY or this kind of module may be
able to shed some lights on the findings I was able to gather so far.

All modules have the same internal PHY, which exposes itself as a BCM5461 :

	ID : 002060c1
=09
I know that because I was able to talk to the PHY using mdio over i2c, at
address 0x56 on the i2c bus. On some modules, the PHY doesn't reply at all,
on some it stalls the i2c bus if I try to do 16bits accesses (I have to use=
 8 bits
accesses), and on some modules the regular 16bits accesses work...

That alone makes me wonder if there's not some kind of firmware running in
there replying to mdio ?

Regarding what I can achieve with these, YMMV :

 - I have a pair of Prolabs module with the ID "CISCO-PROLABS     GLC-GE-10=
0FX-C".

   These are the ones that can only do 8bits mdio accesses. When the PHY is
   left undriven by the kernel, and you plug it into an SGMII-able SFP port=
, you
   get a nice loop of 'link is up / link is down / link is up / ...' report=
ed
   by the MAC (or PCS). Its eeprom doesn't even say that it's a 100fx module
   (id->base.e100_base_fx isn't set). It does say "Cisco compatible", maybe=
 it's
   using some flavour of SGMII that I don't know about ?
  =20
 - I have a pair of FS modules with the ID "FS     SFP-GE-100FX". These beh=
ave
   almost exactly as the ones above, but it can be accessed with 16-bits md=
io
   transactions.
  =20
 - I have a "PHOENIX CONTACT    2891081" that simply doesn't work
=20
 - And maybe the most promising of all, a pair of "PROLABS    SFP-GE-100FX-=
C".
   These reply on 16bits mdio accesses, and when you plug them with the PHY
   undriven by the kernel (so relying only on internal config and straps), I
   get link-up detected by the MAC through inband SGMII, and I can receive
   traffic ! TX doesn't work though :(

On the MAC side, I tested with 3 different SoC, all using a different PCS :
 - A Turris Omnia, that uses mvneta and its PCS
 - A dwmac-socfpga board, using a Lynx / Altera TSE PCS to drive the SGMII
 - A KSZ9477 and its variant of DW XPCS.

The behaviour is the same on all of them, so I'd say there's a very good ch=
ance
the modules are acting up. TBH I don't know much about sourcing SFPs, they
behave so differently that it may just be that I didn't find the exact refe=
rence
that for some reason happens to work ?

The link-partner is a device that only does 100BaseX.

On all of these modules, I've tried to either let the PHY completely unmana=
ged
by the kernel, no mdio transactions whatsoever and we leave the default PHY
settings to their thing. As nothing worked, I've tried driving the PHY thro=
ugh
the kernel's broadcom.c driver, but that driver really doesn't support 100F=
X so
it's also expected that this doesn't work. Unfortunately, I don't have
access to any documentation for that PHY...

The driver does say, for a similar model :

	/* The PHY is strapped in RGMII-fiber mode when INTERF_SEL[1:0]
	 * is 01b, and the link between PHY and its link partner can be
	 * either 1000Base-X or 100Base-FX.
	 * RGMII-1000Base-X is properly supported, but RGMII-100Base-FX
	 * support is still missing as of now.
	 */

Not quite the same as our case as it's talking about RGMII, not SGMII, but
maybe the people who wrote that code know a bit more or have access to some
documentation ? I've tried to put these persons in CC :)

In any case, should anyone want to give this a shot in the future, I'm usin=
g the
following patch so that the SFP machinery can try to probe PHYs on these
non-copper modules - that patch needs splitting up and is more of a hack th=
an
anything else.

Thanks a lot everyone, and sorry for the noise if this is misplaced,

Maxime

-------x8---------------------------------------------------------------

=46rom 101b7cc3c343f6b28e49aa11ed6e759797a1c2b5 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 19 Mar 2025 16:13:58 +0100
Subject: [PATCH] net: sfp: Allow using a range of SGMII to 100BaseX SFP mod=
ule

SGMII to 100BaseX modules are useful to support 100M links on a 1G
capable SFP port. These modules have an internal PHY, but none of the
tested modules appear to work.

This patch allows selecting SGMII as the host serdes interface for these
modules, as well as to try and drive the internal PHY from linux as a
last-effort attempt to get them to work, unsuccessfully.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp-bus.c |  7 ++++++-
 drivers/net/phy/sfp.c     | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index f13c00b5b449..3ea062a66f37 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -120,6 +120,9 @@ bool sfp_may_have_phy(struct sfp_bus *bus, const struct=
 sfp_eeprom_id *id)
 	if (id->base.e1000_base_t)
 		return true;
=20
+	if (id->base.e100_base_fx)
+		return true;
+
 	if (id->base.phys_id !=3D SFF8024_ID_DWDM_SFP) {
 		switch (id->base.extended_cc) {
 		case SFF8024_ECC_10GBASE_T_SFI:
@@ -213,6 +216,7 @@ void sfp_parse_support(struct sfp_bus *bus, const struc=
t sfp_eeprom_id *id,
 	if (id->base.e100_base_fx || id->base.e100_base_lx) {
 		phylink_set(modes, 100baseFX_Full);
 		__set_bit(PHY_INTERFACE_MODE_100BASEX, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
 	}
 	if ((id->base.e_base_px || id->base.e_base_bx10) && br_nom =3D=3D 100) {
 		phylink_set(modes, 100baseFX_Full);
@@ -378,7 +382,8 @@ phy_interface_t sfp_select_interface(struct sfp_bus *bu=
s,
 		return PHY_INTERFACE_MODE_2500BASEX;
=20
 	if (phylink_test(link_modes, 1000baseT_Half) ||
-	    phylink_test(link_modes, 1000baseT_Full))
+	    phylink_test(link_modes, 1000baseT_Full) ||
+	    phylink_test(link_modes, 100baseFX_Full))
 		return PHY_INTERFACE_MODE_SGMII;
=20
 	if (phylink_test(link_modes, 1000baseX_Full))
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5347c95d1e77..03ba78d71b51 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -476,6 +476,19 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp=
_eeprom_id *id,
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, modes);
 }
=20
+static void sfp_fixup_sgmii_to_100base(struct sfp *sfp)
+{
+	sfp->mdio_protocol =3D MDIO_I2C_MARVELL_C22;
+}
+
+static void sfp_quirk_sgmii_to_100base(const struct sfp_eeprom_id *id,
+				       unsigned long *modes,
+				       unsigned long *interfaces)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, modes);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
+}
+
 #define SFP_QUIRK(_v, _p, _m, _f) \
 	{ .vendor =3D _v, .part =3D _p, .modes =3D _m, .fixup =3D _f, }
 #define SFP_QUIRK_M(_v, _p, _m) SFP_QUIRK(_v, _p, _m, NULL)
@@ -543,6 +556,15 @@ static const struct sfp_quirk sfp_quirks[] =3D {
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
+
+	SFP_QUIRK("CISCO-PROLABS", "GLC-GE-100FX-C", sfp_quirk_sgmii_to_100base,
+						     sfp_fixup_sgmii_to_100base),
+	SFP_QUIRK("PROLABS", "SFP-GE-100FX-C", sfp_quirk_sgmii_to_100base,
+					       sfp_fixup_sgmii_to_100base),
+	SFP_QUIRK("FS", "SFP-GE-100FX", sfp_quirk_sgmii_to_100base,
+					sfp_fixup_sgmii_to_100base),
+	SFP_QUIRK("PHOENIX CONTACT", "2891081", sfp_quirk_sgmii_to_100base,
+						sfp_fixup_sgmii_to_100base),
 };
=20
 static size_t sfp_strlen(const char *str, size_t maxlen)
--=20
2.49.0

