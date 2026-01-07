Return-Path: <netdev+bounces-247895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A449D0050C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8A73052A87
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEC2F5A10;
	Wed,  7 Jan 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="QxArX4nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19323373D;
	Wed,  7 Jan 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824977; cv=none; b=uzg1eYXV/8npH4RuYaSAwGQIF1LEaltBnBf7Yc2s4d8ot/+LW9ygS0xfZx3pDCbXzTHp3LE4ruwDnuoRCa2iB0T2Q7kOu4WbHCLRLgqyuXzWtrhQAHnwdCV44gthUVIZXDd9o0vh3WDsMZM7sC1EYzOUA+OC6V9loa/1m8zitcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824977; c=relaxed/simple;
	bh=v7cguJJjw8kGDKhzeGobXtNltPLb8EIGsm0DDBWtMq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRlBgJUoVwkAw6aJrQwBdxVAItlY8+x0t0uXq06TOQ/ZKvyshgY/sDASSYCONLBdxbadVcicV8fmOZSygimvY7/BgWrk2oGGyhJ5J6SM6oxhNVegetk3F33FRpjRUCZooimTWmH2PKc3LATP14gzcg6xh58oK8nFp1AezqBkVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=QxArX4nl; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F2FAB3D85335;
	Wed,  7 Jan 2026 17:19:54 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CKMmVaTAb4lg; Wed,  7 Jan 2026 17:19:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 257AE3D853F3;
	Wed,  7 Jan 2026 17:19:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 257AE3D853F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1767824394; bh=2JLgAqk//SWAkx4RNqA4BsihOspg9ahHxm+FH9xgCIk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=QxArX4nlJB8AklH9d1233lX8yZIO+rdW05O7GTNo3wNKVhNpI9zPQThAAXqvMlFzS
	 JLBT0T8W9MZ82al6AbkVy85OQepXRpTYf1sfhhyAvCIfUxBSMmnURA22xTiSFu4oKC
	 obS9tVVuiZ8SWvzn7acKy3NW7l9Uuu22IVJ188HiraN5i6hBamt70c1qu+a0uZAvte
	 GTDaG8mwPNC1RR9DZgHxsjN+TOtmCwwOagcPLfbZ8hSEx8jiYuZmpCjewMNoUTRO4r
	 WD8RsMa65evxG/k8UnGVSbEBYlIEa7KOmO0mGV1jHpViGQ5Xghl08ISwUtvzuR/v31
	 drbJkKBkdQLEQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EYAUcBo9IFQV; Wed,  7 Jan 2026 17:19:54 -0500 (EST)
Received: from oitua-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0292F3D85335;
	Wed,  7 Jan 2026 17:19:54 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: [PATCH v3 2/2] net: phy: adin: enable configuration of the LP Termination Register
Date: Wed,  7 Jan 2026 17:16:53 -0500
Message-ID: <20260107221913.1334157-3-osose.itua@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
References: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ADIN1200/ADIN1300 provide a control bit that selects between normal
receive termination and the lowest common mode impedance for 100BASE-TX
operation. This behavior is controlled through the Low Power Termination
register (B_100_ZPTM_EN_DIMRX).

Bit 0 of this register enables normal termination when set (this is the
default), and selects the lowest common mode impedance when cleared.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 drivers/net/phy/adin.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 7fa713ca8d45..3a934051b574 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -89,6 +89,9 @@
 #define ADIN1300_CLOCK_STOP_REG			0x9400
 #define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
=20
+#define ADIN1300_B_100_ZPTM_DIMRX		0xB685
+#define ADIN1300_B_100_ZPTM_EN_DIMRX		BIT(0)
+
 #define ADIN1300_CDIAG_RUN			0xba1b
 #define   ADIN1300_CDIAG_RUN_EN			BIT(0)
=20
@@ -522,6 +525,19 @@ static int adin_config_clk_out(struct phy_device *ph=
ydev)
 			      ADIN1300_GE_CLK_CFG_MASK, sel);
 }
=20
+static int adin_config_zptm100(struct phy_device *phydev)
+{
+	struct device *dev =3D &phydev->mdio.dev;
+
+	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
+		return 0;
+
+	/* clear bit 0 to configure for lowest common-mode impedance */
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					  ADIN1300_B_100_ZPTM_DIMRX,
+					  ADIN1300_B_100_ZPTM_EN_DIMRX);
+}
+
 static int adin_config_init(struct phy_device *phydev)
 {
 	int rc;
@@ -548,6 +564,10 @@ static int adin_config_init(struct phy_device *phyde=
v)
 	if (rc < 0)
 		return rc;
=20
+	rc =3D adin_config_zptm100(phydev);
+	if (rc < 0)
+		return rc;
+
 	phydev_dbg(phydev, "PHY is using mode '%s'\n",
 		   phy_modes(phydev->interface));
=20

