Return-Path: <netdev+bounces-191316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56876ABAC4F
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E506317AF81
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3F218EB7;
	Sat, 17 May 2025 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4i4v5ba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4C21883E;
	Sat, 17 May 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512877; cv=none; b=GEYdFvPSJqLH/bxw7X+dj6XyAGEmOEyTsX2PQmgulz/87RMt9GwE5cituIiXj2XaDQKQHxd1kSUdoVTZyp1BFUhl7l5ViOjRG4z0Rtm+6pVm8ftqpRavy/SZCyBIgJ2QuNnwQ6+v+TRaCxsFupnlv7M7txUhpwj87QfEFTpr13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512877; c=relaxed/simple;
	bh=AXCBl/5hZD5LUHlzciawMj8Ax7ubKl91r7de/X5+Tbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stUImFV/DwPg88KqMzQAjzQTn2F5teNNvvE1foQuRdqRXfYJa2XJtBJA/5hIn/GsEXSjsgI4R2sDcEMFXHSSmknq53D1Cqj5sgZoLFKaipCpo8LjP0mdhbVgRNrLXmBzeGr4qyW2GdL8DleSdDiCQmZhVjOOffyNDMIzlrn3vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4i4v5ba; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso24747865e9.2;
        Sat, 17 May 2025 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512874; x=1748117674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0UbM3f3aiE6Xk9v2x1ninQEe7kuXc+YrE+ZJvHjaik=;
        b=K4i4v5ban/EHpXlXQHyqeUr/dNofr34stnzu34s++ybRPdooue9slBtys3KQo5D4Gx
         NstzWJ7pAw7KxiWX+JFCkCiKPScwhVQUUkJ4xNWuSZ+9kvM6SOZhgSR3EIgBG2etKbsb
         LenT9+VCPkXQvTJ8ZcWSHbiBqwkERfzOgq/xph6usHUy/0UBkf8te0+VrXy/JAMUyMKI
         HLsFp71Yt4cfRkIiscvzxNauDKJCoj7bZm5z3JZTBbb4HGitirhI5NmpRX0ORE4fLdPU
         L9QtYm3jRhJKpQ3lvLCyy6waQ8ctNtbRbdfnd8GPdT0WPDPamHzlkpFJdvzw8FmSGTl0
         hkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512874; x=1748117674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0UbM3f3aiE6Xk9v2x1ninQEe7kuXc+YrE+ZJvHjaik=;
        b=jxxQ6LCrjwaBIT55SOzYH2KKBcLo/5WFpMg980gWQiOcla2kHhBT+aqKVmVRQs/7uk
         fMwy6NZ0sXC1sOImMyCCbQ+IZYVGPLddj6n1jAI1zrAmv8yWSfK3HvH2/kKGoASy8aEl
         RwUZBM4muh02/n7M5uRCNDJy//qKCwq67JTuvO3dlgVd0omPBQiFiWo72LO81mkJdk9T
         sowNkk5XQmGUKSUok1LbN/UmI2t+a/jK/BVqGQzuatwPsHNtBQlrVH5kIJ/xXVw8jyXQ
         cJkJtVFQiuxdmbelumFUGlcUZ1J4FAKPDwC8CgXF5zi7fm7qfX9KZkSiuNNcGfu3ytw0
         IhJA==
X-Forwarded-Encrypted: i=1; AJvYcCU5H2L+gZnDpSPLtAlfq3wAcMjHfHnaX0Hr3ydeQKqZGrer5Bpt9pk155HGQBI+96UyLGq/1cQQwqJ9@vger.kernel.org, AJvYcCVNsX8NgEZb+T6GjePJW/CuIwXPYDB6DHiz+pkbfJPN5nwVnn1nIU2uq9407HBdiskpyxUNA1ED@vger.kernel.org, AJvYcCWrYjxv6lJu+X8orlClsuFqQN1eFEfjEUnuN0xVjmilLuPuVnh65A8w92kUCbtAzVW6fV2CrqRq1Fc3NoK6mBA=@vger.kernel.org, AJvYcCXU98fCt8pcF7wgAtglQBsV2B+gGE+GJgIGgl7b/EaFjEXCH/Bkq/9xwL6M++PQdaUHvKYmQOYHcYVQLD+y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9vH9YDpILZ6UWGYpWy8dHnH1EF8IqnFjkKJruvg5j5yTFfQa
	IAEtZz74V9xkvVG53qW5mXAc93Xphc7Os8A3qDN4FlEi3CDgIVe6m5be
X-Gm-Gg: ASbGncs+nGW3RrlEkyD4pc6HDb6x+090dt/Z4orUc8YBOJJethoi1BdHGQyLPYex3n+
	iGSmJGQr074XXBEL/jE0CN3BUq7InxD3QZKrap/PVaT7lJSsvSbHosoZvYmPYR89GJHNyIgBDDs
	YfZNqK33xcjWCCPtylwqaBYjdgDcQZcBlbY9Lb+az9sQn8qCHfVafhFXq+8OljYUW6ORWGo5zqk
	C9U4ESEnaY05tA+r3obunJz0ZwAo3ozSzulUerPp6F1nB5d8gl5WRf2S3PqtWDn8d28edm0qvcd
	nYwHIm+4iqIlc5rtT7IT8x4EAnctHVZY27doS8EURSCO2n/JjKp4HIgRkHrnMkR2SUWXpdPzzyt
	Lqr2M2zkiubH9dZbiY2cm
X-Google-Smtp-Source: AGHT+IF/u43nVQvGCM1qDWWYaeuX2cnIjZovEACph2cRwcJkpi89NPYD58MOwCg3h//iJvhO/C4amA==
X-Received: by 2002:a05:600c:c8c:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-442fefd5f8dmr76418235e9.4.1747512873836;
        Sat, 17 May 2025 13:14:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm85345445e9.6.2025.05.17.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:14:33 -0700 (PDT)
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
Subject: [net-next PATCH v12 4/6] net: phy: introduce genphy_match_phy_device()
Date: Sat, 17 May 2025 22:13:48 +0200
Message-ID: <20250517201353.5137-5-ansuelsmth@gmail.com>
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

Introduce new API, genphy_match_phy_device(), to provide a way to check
to match a PHY driver for a PHY device based on the info stored in the
PHY device struct.

The function generalize the logic used in phy_bus_match() to check the
PHY ID whether if C45 or C22 ID should be used for matching.

This is useful for custom .match_phy_device function that wants to use
the generic logic under some condition. (example a PHY is already setup
and provide the correct PHY ID)

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 52 +++++++++++++++++++++++++-----------
 include/linux/phy.h          |  3 +++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 96a96c0334a7..9282de0d591e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -543,20 +543,26 @@ static int phy_scan_fixups(struct phy_device *phydev)
 	return 0;
 }
 
-static int phy_bus_match(struct device *dev, const struct device_driver *drv)
+/**
+ * genphy_match_phy_device - match a PHY device with a PHY driver
+ * @phydev: target phy_device struct
+ * @phydrv: target phy_driver struct
+ *
+ * Description: Checks whether the given PHY device matches the specified
+ * PHY driver. For Clause 45 PHYs, iterates over the available device
+ * identifiers and compares them against the driver's expected PHY ID,
+ * applying the provided mask. For Clause 22 PHYs, a direct ID comparison
+ * is performed.
+ *
+ * Return: 1 if the PHY device matches the driver, 0 otherwise.
+ */
+int genphy_match_phy_device(struct phy_device *phydev,
+			    const struct phy_driver *phydrv)
 {
-	struct phy_device *phydev = to_phy_device(dev);
-	const struct phy_driver *phydrv = to_phy_driver(drv);
-	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
-	int i;
-
-	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
-		return 0;
-
-	if (phydrv->match_phy_device)
-		return phydrv->match_phy_device(phydev, phydrv);
-
 	if (phydev->is_c45) {
+		const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
+		int i;
+
 		for (i = 1; i < num_ids; i++) {
 			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
 				continue;
@@ -565,11 +571,27 @@ static int phy_bus_match(struct device *dev, const struct device_driver *drv)
 					   phydrv->phy_id, phydrv->phy_id_mask))
 				return 1;
 		}
+
 		return 0;
-	} else {
-		return phy_id_compare(phydev->phy_id, phydrv->phy_id,
-				      phydrv->phy_id_mask);
 	}
+
+	return phy_id_compare(phydev->phy_id, phydrv->phy_id,
+			      phydrv->phy_id_mask);
+}
+EXPORT_SYMBOL_GPL(genphy_match_phy_device);
+
+static int phy_bus_match(struct device *dev, const struct device_driver *drv)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	const struct phy_driver *phydrv = to_phy_driver(drv);
+
+	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
+		return 0;
+
+	if (phydrv->match_phy_device)
+		return phydrv->match_phy_device(phydev, phydrv);
+
+	return genphy_match_phy_device(phydev, phydrv);
 }
 
 static ssize_t
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 34ed85686b83..48e80f089b17 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1868,6 +1868,9 @@ char *phy_attached_info_irq(struct phy_device *phydev)
 	__malloc;
 void phy_attached_info(struct phy_device *phydev);
 
+int genphy_match_phy_device(struct phy_device *phydev,
+			    const struct phy_driver *phydrv);
+
 /* Clause 22 PHY */
 int genphy_read_abilities(struct phy_device *phydev);
 int genphy_setup_forced(struct phy_device *phydev);
-- 
2.48.1


