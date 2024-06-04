Return-Path: <netdev+bounces-100498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B28FAEAC
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93F71F21BFA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1114431B;
	Tue,  4 Jun 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Zs4uX0be"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE447143C6D
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493036; cv=none; b=Qael4VUKfC/P8xGXYjM7+eTKEFA77Bz6xbLJes5W/9hU2nVCUEzBzt7s5RP/WaQ8R9FpbzwaIO2oJB5jFqeDnB+y8qzWRrlrzSyBJ5ekQE36HX2NvZzyrtGmksgyS+gnp6Y7ydPlrUWCTDOV4jhLjJUOIjMV7D4usYieiZ2l8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493036; c=relaxed/simple;
	bh=FbiDYHiAZMg1oLor7STj3OLDQvg7Xmj4ZDUEudmaG/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8fkPHhenEWAUjdnbqUPON3UtmGqN/dkPJ8pxVwjmpK00UJC7ZNEpB9iyMlNmDS3bvNcdOBpwQYUwKSVDdeyDWP5ycgExt5EbsUDSrKmdSqXGUE+5Z01Va1QAvtkrkVbXXuqlKKruMeN8eYXgeUd5sbzfweMuv4YsYig/bnJ77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Zs4uX0be; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BED6C9C56AC;
	Tue,  4 Jun 2024 05:23:47 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LnxfDvlhN5EZ; Tue,  4 Jun 2024 05:23:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B1CD39C58AE;
	Tue,  4 Jun 2024 05:23:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B1CD39C58AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717493026; bh=YzkGacBzMhkfGZlgJ56eJ9U6kh+NQEFa7a2Yr7L5ObI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Zs4uX0beiv8BLiqG26G8M18vdZN+3gZL3kL3BRUXCT629bjmb8NNeuNCmBCwjujAJ
	 0H6u+mtTGelmlmdjKO665NG7rj4JwYR9hIUXnKvXmyiDA5nE5waSsYaa73XnlpSt7Q
	 zYkdNweByeKEfx0Rek+fb+ZSXpHS28+Nq7ovVqwO94n/RJ6RxVKw+Nw2t+O45Gg7FL
	 lvQ4q3EQYGuTB31BAdbIs9W+b38QhMPxNGQE9MmrmK8yahzHvX4S6NWXusAoeTPuqE
	 GqG6k39TeaWI+Cl65j52E/PD+i6m2pG6bAVrgMcf5paqpYKNVgC5t35qrDo7Ni4jvZ
	 LXrdjTu5CiRPw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id rbANpnpTVUHk; Tue,  4 Jun 2024 05:23:46 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 560DC9C56AC;
	Tue,  4 Jun 2024 05:23:45 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897 Switch PHY support
Date: Tue,  4 Jun 2024 09:23:02 +0000
Message-Id: <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
v5:
 - rewrap comments
 - restore suspend/resume for KSZ9897
v4: https://lore.kernel.org/all/20240531142430.678198-2-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - rebase on net/main
 - add Fixes tag
 - use pseudo phy_id instead of of_tree search
v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/phy/micrel.c   | 13 ++++++++++++-
 include/linux/micrel_phy.h |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 8c20cf937530..11e58fc628df 100644
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
@@ -5545,6 +5545,16 @@ static struct phy_driver ksphy_driver[] =3D {
 	.suspend	=3D genphy_suspend,
 	.resume		=3D ksz9477_resume,
 	.get_features	=3D ksz9477_get_features,
+}, {
+	.phy_id		=3D PHY_ID_KSZ9897,
+	.phy_id_mask	=3D MICREL_PHY_ID_MASK,
+	.name		=3D "Microchip KSZ9897 Switch",
+	/* PHY_BASIC_FEATURES */
+	.config_init	=3D kszphy_config_init,
+	.config_aneg	=3D ksz8873mll_config_aneg,
+	.read_status	=3D ksz8873mll_read_status,
+	.suspend	=3D genphy_suspend,
+	.resume		=3D genphy_resume,
 } };
=20
 module_phy_driver(ksphy_driver);
@@ -5570,6 +5580,7 @@ static struct mdio_device_id __maybe_unused micrel_=
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


