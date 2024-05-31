Return-Path: <netdev+bounces-99759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E98D646F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7455281884
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0F1CAB7;
	Fri, 31 May 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="jStJaSaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616251B812
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165485; cv=none; b=R0G8tTERh6FNaj8gyCqYfSHtDy+NqwKzUEtC44O25YrSyffK4wNhJ0pisdsEBkYfQH1T7Tdmlk4ZoMVEVtJdtjzmpTDYAdcnt7GnAFj+gg1TtrQk8qZmGYJNPrludMCQJziSs1dyfn8UzblOjVy/wzfUWwToJ3APB1acscmDLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165485; c=relaxed/simple;
	bh=F/lC81aXVeUBqq3h4uAuT4G8dbDnChzUbZFxu3OH0Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3HEBfT91UWpFj/xL+16GBxX9XCIJppkQwcetHmSgUHjCMmpCPUTxnQ21H7zhtfKr/BK4RQsBY4rw9sQyFr+Fw02EAQIKChI09cwryxnsDZHAIKJSxMTy64xLs1F11Y3EWIvGA8OMYIZOo6KS4fwhKrJ8r1F68BWTNkAVKp6+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=jStJaSaa; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0CA639C34B5;
	Fri, 31 May 2024 10:24:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 4_BuAkUUgsSV; Fri, 31 May 2024 10:24:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0CEC29C32FC;
	Fri, 31 May 2024 10:24:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0CEC29C32FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717165481; bh=LWQF28JPL5s3Fgvw2CqqQV0SIuI0xDj9KUU7AGLLXfw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=jStJaSaaI/cEi/EWuMMCwqwi3U4CcYqzuEuTdk/uDzDHuvjMAED+BtA7PyASPHcLI
	 XC+XzdoT/iEMKB+nEeQjRESYaB0QKxWw41ApRDf6VoyJcYx/Wu1Ibq42kqQYMc0/xd
	 oSY2RtdpCzTdkvpdUFESju8mgoHB2CTOmpLwl0XRnx0heu3DxadrsbK6OGF4jIJhrO
	 w7See49jFFqvdXADWLyfX/5BraVSryXpp+Xr1GThUgyuiLpeAuVusvoyAZK/uN+WTp
	 vlXzEdbdbPlh2Gi+1fmKNqc1H8aEvM2Mz4Gh22VCaJGN27GhtmcZaV9MWZQwD+UgNW
	 8PWi9p2KX6oug==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YDyPLlVayKkQ; Fri, 31 May 2024 10:24:40 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1C36E9C405E;
	Fri, 31 May 2024 10:24:40 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v4 1/5] net: phy: micrel: add Microchip KSZ 9897 Switch PHY support
Date: Fri, 31 May 2024 14:24:26 +0000
Message-Id: <20240531142430.678198-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a DSA driver for microchip,ksz9897 which can be controlled
through SPI or I2C. This patch adds support for it's CPU ports PHYs to
also allow network access to the switch's CPU port.

The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
They weirdly use the same PHY ID as the KSZ8081, which is a different
PHY and that driver isn't compatible with KSZ9897. Before this patch,
the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
link would never come up.

A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
I could not test if Gigabit Ethernet works, but the link comes up and
can successfully allow packets to be sent and received with DSA tags.

To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
stable register to distinguish them. Instead of a match_phy_device() ,
I've declared a virtual phy_id with the highest value in Microchip's OUI
range.

Example usage in the device tree:
	compatible =3D "ethernet-phy-id0022.17ff";

A discussion to find better alternatives had been opened with the
Microchip team, with no response yet.

See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.de-rib=
aucourt@savoirfairelinux.com/

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
v4:
 - rebase on net/main
 - add Fixes tag
 - use pseudo phy_id instead of of_tree search
v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/phy/micrel.c   | 14 +++++++++++++-
 include/linux/micrel_phy.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2b8f8b7f1517..8a6dfaceeab3 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -16,7 +16,7 @@
  *			   ksz8081, ksz8091,
  *			   ksz8061,
  *		Switch : ksz8873, ksz886x
- *			 ksz9477, lan8804
+ *			 ksz9477, ksz9897, lan8804
  */
=20
 #include <linux/bitfield.h>
@@ -5495,6 +5495,17 @@ static struct phy_driver ksphy_driver[] =3D {
 	.suspend	=3D genphy_suspend,
 	.resume		=3D genphy_resume,
 	.get_features	=3D ksz9477_get_features,
+}, {
+	.phy_id		=3D PHY_ID_KSZ9897,
+	.phy_id_mask	=3D MICREL_PHY_ID_MASK,
+	.name		=3D "Microchip KSZ9897 Switch",
+	/* PHY_BASIC_FEATURES */
+	.config_init	=3D kszphy_config_init,
+	.config_aneg	=3D ksz8873mll_config_aneg,
+	.read_status	=3D ksz8873mll_read_status,
+	/* No suspend/resume callbacks because of errata DS00002330D:
+	 * Toggling PHY Powerdown can cause errors or link failures in adjacent=
 PHYs
+	 */
 } };
=20
 module_phy_driver(ksphy_driver);
@@ -5520,6 +5531,7 @@ static struct mdio_device_id __maybe_unused micrel_=
tbl[] =3D {
 	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
+	{ PHY_ID_KSZ9897, MICREL_PHY_ID_MASK },
 	{ }
 };
=20
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 591bf5b5e8dc..81cc16dc2ddf 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -39,6 +39,10 @@
 #define PHY_ID_KSZ87XX		0x00221550
=20
 #define	PHY_ID_KSZ9477		0x00221631
+/* Pseudo ID to specify in compatible field of device tree.
+ * Otherwise the device reports the same ID as KSZ8081 on CPU ports.
+ */
+#define	PHY_ID_KSZ9897		0x002217ff
=20
 /* struct phy_device dev_flags definitions */
 #define MICREL_PHY_50MHZ_CLK	BIT(0)
--=20
2.34.1


