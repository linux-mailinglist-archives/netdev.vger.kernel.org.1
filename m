Return-Path: <netdev+bounces-191313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D030AABAC45
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510659E29C5
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F72153C9;
	Sat, 17 May 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MECB8zkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5222147F0;
	Sat, 17 May 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512871; cv=none; b=adBk8dBzNTJu1uD8bdx7baDI1xFjAAt2No/489RYb4T5eVy6HFkLcaA+XEkYDeYkbDVVPK/h3N8x0qEq+6I5CL5/Wdsmy7X1OXMDxD1ag7E/7YjDWjpwiwBT9c9X54gQfu6FR5sCvlp7nG7ys8JJoWq6+rKXwDxMoJ3rQZK/Q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512871; c=relaxed/simple;
	bh=UeyHDMn4bp1Ui/bLDmpa/rWmqfFSNF//Lkq0ecvZZMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jD+rQTejFfy4GQ7IIQ+IYwyM1MrjgZLT6cHKORzbmnTH6mnnJZaHWZD1oMMumvPdw3hj2uJH/ZZathU/Pghy2IVnX7gjeMxO0tzZ9D+Qy1pVu5cJq9N+Oe1QDKPRykTU1m4KmDACMSSyNWLhoW124cbBmQupyW0Ua+vBlvRF8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MECB8zkv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso31135475e9.0;
        Sat, 17 May 2025 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512867; x=1748117667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjrKJJQ/alu21U0CaUScGyKXWxRO2mZ0HkmMBCRud/g=;
        b=MECB8zkvx4xhFcBPm8/50xL6F3Bw463DNllkufK3J8V06QYsFjk9dqk5sxzFXTeAm1
         tQfSfb57SJ8U18N5qdJjwz/7OeLRBTArw179Vioze3givfKZpPHH1kzB91sskfV2QWs6
         gigeXcb/QK9MOimT1c229SyZNTdgpUmbV4VxrGfmAvQsZUldHjaKZWqLry17ZtHr7Foj
         7wRIpCkSKs1w9SO4dGUpGIFil3Jc05uXwiM5HKu5NexwYlyZcq/t+R3a1YdKaBomfMub
         sgXatVfnoWTXlzs3p6LZwN2YmfY0rCsddP1hmQPD30nKXRhfeJpMIXYfEbd20x0dMNOk
         b/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512867; x=1748117667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjrKJJQ/alu21U0CaUScGyKXWxRO2mZ0HkmMBCRud/g=;
        b=gb75mVGFYdurWXgpTMIGFzXmq3nDjog9NQXWsCUeDxUk0e1BbqXAFUiwox/O8H4dnT
         rNXCvlp59uX4hrA4D/QRAjSJGCi0vTlMIiYylVgvfr7huI0oWIk0z5U+VG2LMSW60KE+
         sJcSqVyKJkcVmf+PviTqLkxbB6g6nPQpgJ+nX8mQ7hf1CPY5hYYajvmOQWHKaPP+9FaP
         Tah+XbCyhTit0i42ju/QaatQcMquxEFFr/NeJI2aYN0G5f11kypdMDawGyXM4tAzlec/
         ZkgLYohF4/TRlsU5APyWymN89y2Aual6giMxh6cbWPb0bpx8iAO/2vCGT+4frthbqi9o
         9opg==
X-Forwarded-Encrypted: i=1; AJvYcCU/3zDBnkPMEP2ZycJkwNAodBaxoTAq4a3ec5pnwKVMFqPM7KuEEOxoKaePWexW4eQuw1oNaLuKuPNtg15M@vger.kernel.org, AJvYcCVVvi6coZvZo4XSmjj2lHoRFO0NIYWiMbMSjw8OphTXzn1hgFsLqC/uMyvQuc3FPpf02ztHSp0QD+b65bnkArQ=@vger.kernel.org, AJvYcCWRlCS/olGGEiNFok4rN61jKtVbXON7RmWWjFLuuboG5fv1jNIM6jGMYXdNLcPZvSFvfXOUXHy0mie0@vger.kernel.org, AJvYcCWxwv6UJwJHcO1haZPBcxH+GH1TnUqKBZRcffkzz2xFt1j4yDbSuysAMVUA3VraREUEuwHkT9n9@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNOzuDVpUGl0/9N+OPpD/cH6oZdWY2UFSk8LgsdzDL6FQfJml
	JmMcafVfvwfZfF31Fru4Z3/wLdIu3L3nyMakTC+hCJChym6h+N/KjXqy
X-Gm-Gg: ASbGncsH3hQuMBF8DR8XiFqbgbqztlIFmebKh43QXoirzWNOEJ23HiRb3aFr1L9oAvz
	4HnzvrIwd10EZP0wPEhh2EDg698XXKTd/CnTepXA8BE4YKA2RchJkHiMvHB5Ownzk4ESwPO3vrh
	6/nGTDP4vfGyZ0cMcksqvCBDeo1WCr9VXlVB92cGCmz+CxIbNf/oRFtqUBteKOWjmudDCeh5WX8
	JUjwNge8VbmtVYvKZBOeXabRCyoKO5kNhBNqNJCBalMJ4dwLB3+sB/ibDIyDkv246nKRrGsAyfx
	I/FYGG5vuDv5i2lfP1GSMrFdiaJfIIAuIg2x6VMWS+ucFYawlLBvzbo2C2Sc8c8QyA/pzZ78KGf
	bScAxbnXv9GAmlUVprwEp
X-Google-Smtp-Source: AGHT+IEf84+aSQcfL21XHVBcjwGl0PxF1NE0XvvkKVkpZyv5o+O/CXk7Ibk/uD1u5HjeibRu+2tRbQ==
X-Received: by 2002:a05:600c:4fd4:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-442fd606ce9mr86895945e9.2.1747512867367;
        Sat, 17 May 2025 13:14:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm85345445e9.6.2025.05.17.13.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:14:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v12 1/6] net: phy: pass PHY driver to .match_phy_device OP
Date: Sat, 17 May 2025 22:13:45 +0200
Message-ID: <20250517201353.5137-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250517201353.5137-1-ansuelsmth@gmail.com>
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
Having access to the PHY driver struct might be useful to check the
PHY ID of the driver is being matched for in case the PHY ID scanned in
the phydev is not consistent.

A scenario for this is a PHY that change PHY ID after a firmware is
loaded, in such case, the PHY ID stored in PHY device struct is not
valid anymore and PHY will manually scan the ID in the match_phy_device
function.

Having the PHY driver info is also useful for those PHY driver that
implement multiple simple .match_phy_device OP to match specific MMD PHY
ID. With this extra info if the parsing logic is the same, the matching
function can be generalized by using the phy_id in the PHY driver
instead of hardcoding.

Rust wrapper callback is updated to align to the new match_phy_device
arguments.

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm87xx.c              |  6 ++++--
 drivers/net/phy/icplus.c               |  6 ++++--
 drivers/net/phy/marvell10g.c           | 12 ++++++++----
 drivers/net/phy/micrel.c               |  6 ++++--
 drivers/net/phy/nxp-c45-tja11xx.c      | 12 ++++++++----
 drivers/net/phy/nxp-tja11xx.c          |  6 ++++--
 drivers/net/phy/phy_device.c           |  2 +-
 drivers/net/phy/realtek/realtek_main.c | 27 +++++++++++++++++---------
 drivers/net/phy/teranetics.c           |  3 ++-
 include/linux/phy.h                    |  3 ++-
 rust/kernel/net/phy.rs                 |  1 +
 11 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index e81404bf8994..1e1e2259fc2b 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -185,12 +185,14 @@ static irqreturn_t bcm87xx_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int bcm8706_match_phy_device(struct phy_device *phydev)
+static int bcm8706_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8706;
 }
 
-static int bcm8727_match_phy_device(struct phy_device *phydev)
+static int bcm8727_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8727;
 }
diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index bbcc7d2b54cd..c0c4f19cfb6a 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -520,12 +520,14 @@ static int ip101a_g_match_phy_device(struct phy_device *phydev, bool ip101a)
 	return ip101a == !ret;
 }
 
-static int ip101a_match_phy_device(struct phy_device *phydev)
+static int ip101a_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return ip101a_g_match_phy_device(phydev, true);
 }
 
-static int ip101g_match_phy_device(struct phy_device *phydev)
+static int ip101g_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return ip101a_g_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 5354c8895163..13e81dff42c1 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -1264,7 +1264,8 @@ static int mv3310_get_number_of_ports(struct phy_device *phydev)
 	return ret + 1;
 }
 
-static int mv3310_match_phy_device(struct phy_device *phydev)
+static int mv3310_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	if ((phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] &
 	     MARVELL_PHY_ID_MASK) != MARVELL_PHY_ID_88X3310)
@@ -1273,7 +1274,8 @@ static int mv3310_match_phy_device(struct phy_device *phydev)
 	return mv3310_get_number_of_ports(phydev) == 1;
 }
 
-static int mv3340_match_phy_device(struct phy_device *phydev)
+static int mv3340_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	if ((phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] &
 	     MARVELL_PHY_ID_MASK) != MARVELL_PHY_ID_88X3310)
@@ -1297,12 +1299,14 @@ static int mv211x_match_phy_device(struct phy_device *phydev, bool has_5g)
 	return !!(val & MDIO_PCS_SPEED_5G) == has_5g;
 }
 
-static int mv2110_match_phy_device(struct phy_device *phydev)
+static int mv2110_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return mv211x_match_phy_device(phydev, true);
 }
 
-static int mv2111_match_phy_device(struct phy_device *phydev)
+static int mv2111_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return mv211x_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 71fb4410c31b..4d8460c93078 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -768,7 +768,8 @@ static int ksz8051_ksz8795_match_phy_device(struct phy_device *phydev,
 		return !ret;
 }
 
-static int ksz8051_match_phy_device(struct phy_device *phydev)
+static int ksz8051_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return ksz8051_ksz8795_match_phy_device(phydev, true);
 }
@@ -888,7 +889,8 @@ static int ksz8061_config_init(struct phy_device *phydev)
 	return kszphy_config_init(phydev);
 }
 
-static int ksz8795_match_phy_device(struct phy_device *phydev)
+static int ksz8795_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f11dd32494c3..22921b192a8b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1966,25 +1966,29 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
 	return macsec_ability;
 }
 
-static int tja1103_match_phy_device(struct phy_device *phydev)
+static int tja1103_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
 	       !nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1104_match_phy_device(struct phy_device *phydev)
+static int tja1104_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
 	       nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1120_match_phy_device(struct phy_device *phydev)
+static int tja1120_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
 	       !nxp_c45_macsec_ability(phydev);
 }
 
-static int tja1121_match_phy_device(struct phy_device *phydev)
+static int tja1121_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, PHY_ID_MASK) &&
 	       nxp_c45_macsec_ability(phydev);
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 07e94a2478ac..3c38a8ddae2f 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -651,12 +651,14 @@ static int tja1102_match_phy_device(struct phy_device *phydev, bool port0)
 	return !ret;
 }
 
-static int tja1102_p0_match_phy_device(struct phy_device *phydev)
+static int tja1102_p0_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
 {
 	return tja1102_match_phy_device(phydev, true);
 }
 
-static int tja1102_p1_match_phy_device(struct phy_device *phydev)
+static int tja1102_p1_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
 {
 	return tja1102_match_phy_device(phydev, false);
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2eb735e68dd8..96a96c0334a7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -554,7 +554,7 @@ static int phy_bus_match(struct device *dev, const struct device_driver *drv)
 		return 0;
 
 	if (phydrv->match_phy_device)
-		return phydrv->match_phy_device(phydev);
+		return phydrv->match_phy_device(phydev, phydrv);
 
 	if (phydev->is_c45) {
 		for (i = 1; i < num_ids; i++) {
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 301fbe141b9b..6b655d3c7e1c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1314,13 +1314,15 @@ static bool rtlgen_supports_mmd(struct phy_device *phydev)
 	return val > 0;
 }
 
-static int rtlgen_match_phy_device(struct phy_device *phydev)
+static int rtlgen_match_phy_device(struct phy_device *phydev,
+				   const struct phy_driver *phydrv)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
 	       !rtlgen_supports_2_5gbps(phydev);
 }
 
-static int rtl8226_match_phy_device(struct phy_device *phydev)
+static int rtl8226_match_phy_device(struct phy_device *phydev,
+				    const struct phy_driver *phydrv)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
 	       rtlgen_supports_2_5gbps(phydev) &&
@@ -1336,32 +1338,38 @@ static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
 		return !is_c45 && (id == phydev->phy_id);
 }
 
-static int rtl8221b_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_match_phy_device(struct phy_device *phydev,
+				     const struct phy_driver *phydrv)
 {
 	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
 }
 
-static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
 }
 
-static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
 }
 
-static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, false);
 }
 
-static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
+static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev,
+					       const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
 }
 
-static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
+static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev,
+						const struct phy_driver *phydrv)
 {
 	if (phydev->is_c45)
 		return false;
@@ -1379,7 +1387,8 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);
 }
 
-static int rtl8251b_c45_match_phy_device(struct phy_device *phydev)
+static int rtl8251b_c45_match_phy_device(struct phy_device *phydev,
+					 const struct phy_driver *phydrv)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8251B, true);
 }
diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index 752d4bf7bb99..46c5ff7d7b56 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -67,7 +67,8 @@ static int teranetics_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-static int teranetics_match_phy_device(struct phy_device *phydev)
+static int teranetics_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
 {
 	return phydev->c45_ids.device_ids[3] == PHY_ID_TN2020;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c29d346d4b3..34ed85686b83 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -990,7 +990,8 @@ struct phy_driver {
 	 * driver for the given phydev.	 If NULL, matching is based on
 	 * phy_id and phy_id_mask.
 	 */
-	int (*match_phy_device)(struct phy_device *phydev);
+	int (*match_phy_device)(struct phy_device *phydev,
+				const struct phy_driver *phydrv);
 
 	/**
 	 * @set_wol: Some devices (e.g. qnap TS-119P II) require PHY
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..32ea43ece646 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -421,6 +421,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn match_phy_device_callback(
         phydev: *mut bindings::phy_device,
+        _phydrv: *const bindings::phy_driver,
     ) -> crate::ffi::c_int {
         // SAFETY: This callback is called only in contexts
         // where we hold `phy_device->lock`, so the accessors on
-- 
2.48.1


