Return-Path: <netdev+bounces-189569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C491AB2A64
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786FE173436
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57A2627E7;
	Sun, 11 May 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdhKKdDj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDC2620FC;
	Sun, 11 May 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988829; cv=none; b=HssMSQ39EzrjdmyMkz1I/S6OSzwXySH8ERxlYvOjcTLoEHC4udvPjUT7RsPUfSAe+/fh+xcGGAbmvBzkueO/cVZ7TnH+ZNtI7ScR15rcQ+3QamofcxljFF0sVTrAhIeZQ/Qlcf1pY8Sqp5K8FBvaJrXlXaK/qidYW1nkuki0YQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988829; c=relaxed/simple;
	bh=kW1rAjVyXUckn0dcQM5p/iQemZPuxBVrdIvHlZvSnfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZASsra1ryVJZ3UghV8V7AG+ya96Dkmsfl1CPZBM7kYACXxI8WKWaKkMQZTIHqhDEh2S9V1RKq7oRUtSY3+wHfSHdiEU7Leq6aTsIA5+i/5NUblQLN39BVJ8F4jhiN8Csc1N2xuZKr/f+FzzLiuyKXgIm5QiS4FBx/3cIqutqXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdhKKdDj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so41142215e9.3;
        Sun, 11 May 2025 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988825; x=1747593625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBOXtLmY3i+TUAFPIrzedUySgsNtLLxnleQj5jKUdg4=;
        b=BdhKKdDjn2bbQljRe4L3bnLVv9QUMswRuclbw5X60h2HIsWCRdWlz7ie8wEAZfmsP2
         olVATTH3XrsvVTJ9bUMYgmiNbR3R3bmQ/psKaQhtTNkYlu7LJhNB8bDx4eU/OywxQ5Bo
         MXqabjBJQPMUS+ce/+E+2VcptY4ruu80fw3vHnFpGMBke//frXkbyEYt2u8x4KvjjlLc
         rA+hCMFNeI6l8KZwfKyPA7hDpT+ICFwfOkVS9HYjK7cFhH7GerrscjIrbeufmTQz75lY
         rU73YHXu45q06DJ0AdNgnNjOwmFYNkMY5Qt5pbOKIAuEOSdwwWYKtt+/dWRhXVhrBhAz
         nvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988825; x=1747593625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBOXtLmY3i+TUAFPIrzedUySgsNtLLxnleQj5jKUdg4=;
        b=lzAXCKrv+a1bW7MuGYe0aL2aEnD9Spc68bZX2+yfexMV9bSeAohSBMJwqEC3+XaN47
         VRj2+W7W2LBQT5qxqG6JuUVgI+j4t0BHW/JX/RX9/LpRkKh6ZdhJFwafN3XMdH9OWlGU
         u8Tyz7fwhft+T4pWO33KefCZFcv1u2p4+qKhSUHSu0lYjRHZa5UyHbdRrLvW4QpysSWB
         Uvxr35XuSQ6A9T+Epw5lhtD2bB5xpAJeDexPmvsas5ArNJB57a9tqFNIgngknLfpkht5
         RTX++AYeL9k/RLQ+xoUc/wq7BTIj6GxTPAEMMM/hXSetDrIL97Y0SskAfTbnxwqE0cYy
         4NiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpgn/SJ9/QvhdLeZC7FIs0N92lmBvIpY7pQrmLSo0E1jo7xo0fT8VzhjRX+9TMv7Js01yD537T@vger.kernel.org, AJvYcCVkPSaB5u9Qkt4392ACiMuxquXR9mO+LRgbgQo3b29RIkWecWqy8VFBY/M0XrnFW+xOWgrJCp1WDL/jP/Os@vger.kernel.org, AJvYcCXp5CaDygcYdjaJTUdbvNNpHfVic/PbtrDdIBq9iKaYJCeIgrmEmX47QZwfUosG4M3LvWfjqaNbL5gZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0LJADgF8PacZfd/Aov+fYcFdsIj7DzGlc6aZtGHoHbWiUhRr
	DCwcDzk1hhG/z96jlpAVt8l0fyRM34J26Mhy7Fda2WmWtb6bBx+4
X-Gm-Gg: ASbGnctQiNaSJYdY+5nBHHcReM1QUmj7G4vZntG+E7rAjkWsn0zrSotUYQcIfqkuXXP
	aI9Zjksp2u8J/hZvoZoyqFKhKCWm8vyvLAWOZvTbK480TFmgqH8KoykVRb0WFLSibhVKq7aW2w8
	KYG+HIvRXNzsDP3v3xrk3gpVcV4oAK18lF+0hbBnzxujCQ9oS2fQ6o4xnb7/tlXJkTZRfqV+1SX
	BkAL/GdXWQBLWjiXeZkzmUTcMvzEqEoBJM0qDS7gPFWB6Yv6HmP4uqY6mKwN7/Xy+BwEPhb7rIm
	LpjoqWtRFWSuPJg881pajHzugoWsaD91FhO5VQgHrY5qa/atcbHunrBFcFP2H5sdim55JclEyL7
	LT1Yf7MYvremtp1D8DD2c
X-Google-Smtp-Source: AGHT+IHGdhRiurFYBD9DlR0S1fAMB571C1ZhGga0UQNCNk/2gbVMXoe1nKkd0v7BLiA5zz5X5J4NTg==
X-Received: by 2002:a05:600c:3482:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-442d6d1fb46mr101706555e9.12.1746988824958;
        Sun, 11 May 2025 11:40:24 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm61020615e9.0.2025.05.11.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:40:24 -0700 (PDT)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v9 4/6] net: phy: introduce genphy_match_phy_device()
Date: Sun, 11 May 2025 20:39:28 +0200
Message-ID: <20250511183933.3749017-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511183933.3749017-1-ansuelsmth@gmail.com>
References: <20250511183933.3749017-1-ansuelsmth@gmail.com>
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
index cafac4f205d8..6afe295dac01 100644
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


