Return-Path: <netdev+bounces-178035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F8A74117
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CBD16B786
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C071F0985;
	Thu, 27 Mar 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpjFkT0+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F01EDA0C;
	Thu, 27 Mar 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115569; cv=none; b=cWlYUtHdrrg81p+kE8VehiVSSZVO1q2fzSyWVrbszIn7CQ04OCMnaqIyA1Fub8nM/ul6LNRbbxgZDqBM9TnLjPfjhVMr5gCMrT4ynEKJt3vF2oTMmtCdtF9RAxQSF98m1GXW/FitOuvxR5rpF+QSOOR6DnBePqKCa8fvW+oY15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115569; c=relaxed/simple;
	bh=Fw8Mhmj4yOddrjW0INHvn2Cdixlrl52m0hiV/iVxoKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq+ae56PZWSt2aWSkd2OoVCZEbiYPlXLEUZECo34viL49D6vtlYGwisG+fOoVSDJh0vOy/YdlOHD0huUwJFxTEjugzOAgsLPgYI4gc0tgG5M2srsumb5KhV4DjF5pOB8BMqWJ0SGeCitla6X2kyr8XAe5BL3IivWKi00f0TwR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpjFkT0+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3996af42857so1740666f8f.0;
        Thu, 27 Mar 2025 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115566; x=1743720366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx5narcbW6eR+BDfyixrGWiCVXRk99KznhKxGWd0deo=;
        b=DpjFkT0+FPqRARChCBju0RqurQoiyXukKZofiFkQi5HOvpToKG1tc+8aMBYpUingaL
         kVf7APvaz83BYY6NcYUMlDjBGH6NvLbOuD9aFEvlig0lyE1SCqyrDtE8U48yJppS3pcu
         qUvDnQhvjOHdOXUcJbIcZAet5OQR+drzNy2M/BBHzDORtDuP7bXoM8JtRMyC2p/OwCw6
         a4tvdk2Q5GNNiLrQklMFBGU1oyr/8FiJACi6YKBb5GE64Hs7Tpl+MCqsCt4Qb3XCKcHt
         IDB7VFyHUYuODuNOcTZGAWMAPtcPRgnOo+iahZvth+sRnfQrVs1zbIUfE8vhktvxIvR4
         PCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115566; x=1743720366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx5narcbW6eR+BDfyixrGWiCVXRk99KznhKxGWd0deo=;
        b=bEUITu5NocFZp4SXbLiX++TQa0/H1u6xM2F9xHf1e5JkEFspE46V/ZYt8pbXvRgcN/
         GzBZ8iBqUDShWZ3jUwXtPrTOccAlJeunHkTed8w0u3tUMQZs+S6ruAUDMwWd5mkbe5dm
         jszA4w/VZUa2tWN7fTHpbErtaFN95MYhAZSRvnzVTC9m3rv39qbZ3V6+ZdOdziIC7gBx
         to/dGKwDVT5jKUdBWqGlYlnyxUxCdpyNCDAlfS1LbgpRAC81Wdi2ttfmwNIVvGBozQtT
         tOOc6OAZok3VCsadMILrQXO+lYYIVC7UZIoYv6GZvEaChegzW45tK/MdtTGC/cqCntF4
         4Ncw==
X-Forwarded-Encrypted: i=1; AJvYcCUE9lbX2mzb588tgGkT3Gb/i1dgpuZXMRfJfhIdqVGmhCg4zBHER+1AbTajf+AUGLaO56MMTQlAas9O7Mj5@vger.kernel.org, AJvYcCUgujlB1qmN/YnkGcUX9i5NgUhq+jmilqETIYZ1WXEp+vEgH4sSOc6DfprmTgDfyy6J08987RYO2nCp@vger.kernel.org, AJvYcCW0l0DWBs2SktLnhAOhIfV1tqTaO8EL97WI1mIy6rSuVDtJeax6e3EQy65CqYRg+yH0HK0A4bBR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyws3XAkBIoPHwRuj6ge3sLtYpvuOKOM9covLnBkH0YYe5E/IGw
	3o9ik+/W13e0iW2ZWoQoHAzclJNHM8c+Uk2OXn36HWdDaxiv0c+8
X-Gm-Gg: ASbGncu2o/F2J6qzmcQGSbgu/npQsLxNptKPSSuMRJ11EUZ8eeRP8hIgssTR7N9hSq7
	VtB8K+95ibdNv0R7E05BB9bEXwxCczHrWDX1HsHQvkiRmHJXASQTHigg6+L6LA35icfULGviPEa
	+tOgLC/1JKeKfrB/GHmDHx4nHMD2OL4ngN5Mxi9zV8SahXB2VbQ1rmE7YoNDNsjT9Zou1M74t7b
	I23Mhq4lpqekrW7De8FCPcMDn88KXSJM0Ige83DzPF4WbJyyFwwsxHcnzOuOC3mcVKGxHEqss+j
	iTekzJsL+XpzwI1i7TbF8KUk3hMCAaFcYmafiJN2F4zMGo2QBiiRs8HpsJqflKFEHAxUXeTSeVy
	/it3r7AYMiJzHng==
X-Google-Smtp-Source: AGHT+IFCfcEWeTvNykcCAc7+KeBhUDLP3oeZPuEw1qgzXACrRrJhbmwLxtY7BfZZhaF2pMjE8WitCA==
X-Received: by 2002:a05:6000:4284:b0:39b:32fc:c025 with SMTP id ffacd0b85a97d-39c0bf23245mr402415f8f.2.1743115565571;
        Thu, 27 Mar 2025 15:46:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b6588dbsm789476f8f.2.2025.03.27.15.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:46:05 -0700 (PDT)
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
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v4 4/6] net: phy: introduce genphy_match_phy_device()
Date: Thu, 27 Mar 2025 23:45:15 +0100
Message-ID: <20250327224529.814-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327224529.814-1-ansuelsmth@gmail.com>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 52 +++++++++++++++++++++++++-----------
 include/linux/phy.h          |  3 +++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2d6ceacb2986..ead9a047043a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -503,20 +503,26 @@ static int phy_scan_fixups(struct phy_device *phydev)
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
@@ -525,11 +531,27 @@ static int phy_bus_match(struct device *dev, const struct device_driver *drv)
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
index 7042ceaadcc6..b7aa805e0ad6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1911,6 +1911,9 @@ char *phy_attached_info_irq(struct phy_device *phydev)
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


