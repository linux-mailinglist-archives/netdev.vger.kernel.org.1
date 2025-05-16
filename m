Return-Path: <netdev+bounces-191178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FEABA516
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D4D7AEF6E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD44281515;
	Fri, 16 May 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaBgb+6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA628135F;
	Fri, 16 May 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430673; cv=none; b=dbAQI2O6Sc54dze/Rr/7hOsZTS0D4+6ov3MHrPI8bvFjDPcXgcDhJYB4as3klyxAeWIpyqpQYTxhUlaIy6Xw858D3OsBNT6ZqWQbKxv3xVDlnpKffbMH+kycY1xQfj1fivrl9nLLhr+wTr1kr3arj1b9R9RpQyP+PYXgulWPRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430673; c=relaxed/simple;
	bh=AXCBl/5hZD5LUHlzciawMj8Ax7ubKl91r7de/X5+Tbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCczhMTkThSnaHCQTC0ibosctEsa5/haH5ucYx6/DoOWbAz7eAvwaQkjMXCZEzCABthfBKIqrw9oZcB9On1M5q6Rcid2wOgA4MtBacBl/d28GI48s5ZaRC1jwzINr6XvUFQT1Ai0SRfjK8cQz9tuGIFhaJmtgM/Nof6r7SSmKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaBgb+6W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a36748920cso19376f8f.2;
        Fri, 16 May 2025 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747430670; x=1748035470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0UbM3f3aiE6Xk9v2x1ninQEe7kuXc+YrE+ZJvHjaik=;
        b=GaBgb+6WTqDxOTvAi7q0Q9cVN1QdnDslOoJCHxNb46f5xz1oE5YL+A6xEwVCvtZIhr
         r1+xH5vOZy+/w1Q7szSs45GxL6JBt/nCJ4b61hYc/wfCrbB8Ex+zRQzh7tu2TSKLBt2z
         2vWM3p0tZDHOHbTqUR2cwly8VLbQvv8MvLZCmeu6kPM4OduhYeh9Dr887NHc3XbleCpo
         j7fZmZZTt8aZ7DRlPoQ8eDi/2srxamXRbfncrNip63j58IHjKOB+KqlYQARZeWcE5OYO
         XNl23dtjG2JGBz/sLY1XBDZRD3jNp8KDQ2PrTipldYrGZc6dGf92114nNMaJck7Y3vjN
         3oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747430670; x=1748035470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0UbM3f3aiE6Xk9v2x1ninQEe7kuXc+YrE+ZJvHjaik=;
        b=WPFf8bwVtsw5W6rC7wVk9bTnsMdormJ66mgQhHl/nErjWhTHaDIzUqmpQSRHdLZUpC
         I42KS6m6QFQ471qNy2wl+iyol1RjSW2Q4T+QKrHJvvk6vI5OyaydBVkW6f/82ROkS54n
         l255ADP+aoNSm1jHR8PvgY3Bx51zRK6OjM+GDVCF2JM16WK7ZNhc088YL0EQf9cZjaGe
         O66YuTfo7Z1PePb4z//lvtQH+vccx7r3bcxmlGH6HANkUo5uTddtWGUQbyxJgfCMXC5e
         NWXCitJOmtWFlgYYVmOESi0WGTadvgyn4OpX7U/pzaQru5WptjYgPg0Dzp1AmeaGbOuo
         ccrw==
X-Forwarded-Encrypted: i=1; AJvYcCVPM6P1oQ7iL54Jz0pM7JG5AIOOwY4FebPSWd8OrCrAlYWoOAKAwFT0M8KIDM2ttUmOGFvFIKYZ@vger.kernel.org, AJvYcCWhbyHYHG0WrkW28ualzUuU/FRgcEgjiPK0C+qS9U4tZdeA6utXduSQ/U6CwJ4CtSifrYjhNizCA+nU5jB0lIE=@vger.kernel.org, AJvYcCX/t4f1+nbEGP3iOB93TEyDLDRMvq0/b6HbCyLNdmlcTuM2SN1hjv4GYel/RwEAdWooCBUlexSnVZpM@vger.kernel.org, AJvYcCXWvufska1yJx2avvgav5xbLoyXMgusORonl+zb0ankjMufnLLtVWW3gmOw6MXIMkF/wkFQ6r4NqNWBWAyz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iq1WkGIeBXgsSrsPjfwTGA/GM72HB3ehaKRBKXCniNsOsZKL
	qFh9KnLYE2esSRqdzGWQniBC1YYRTIZ4KuD6XnBrTuoWJ0luYbH7V+bq
X-Gm-Gg: ASbGncv3NA/qv78mcdgadxxbhXol1ZfbtmEJQ8imB35ZRIQG/VcRvbUoLwijf+fRiAl
	dCtdcj/aaU5mjPVirKXQNu8xRd6gn8IkgyEZ9fGLM41HbonC01AsDszUtGI22d7lWn1tpgH8syB
	5S2PkgsFmgURYaUah0+bOvhCW3bye+parxzFuJGtq1gIt31NYznbR25nYXHSPcrez/Nvqy7Q+ks
	allyjjE7XwWPLj4JGeB04nVpfUKbTQI7XhB4KxrU/EoEQURyLF1rx0R2etlsJ8lfsmrZNRa07R3
	Lqd9ZkIT0KMVe7q2YrvnHw7yzzM1jVBykCqS8tgveIZzrM3L9XVp9jvHaf7Oj681TL0FDEs3ysm
	YdZxklVHFwln8JgTUX8qz
X-Google-Smtp-Source: AGHT+IGXO5dJpvHyowm+30fO6xPcDR8z7vkxaerw+7dVGIA3k47hHDpW1CY1juTBOB1d4iHSu/VNMw==
X-Received: by 2002:a05:6000:40d9:b0:3a1:fa9e:7cef with SMTP id ffacd0b85a97d-3a35fe67723mr3650070f8f.20.1747430669744;
        Fri, 16 May 2025 14:24:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm126293555e9.32.2025.05.16.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:24:29 -0700 (PDT)
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
Subject: [net-next PATCH v11 4/6] net: phy: introduce genphy_match_phy_device()
Date: Fri, 16 May 2025 23:23:29 +0200
Message-ID: <20250516212354.32313-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516212354.32313-1-ansuelsmth@gmail.com>
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
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


