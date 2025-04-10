Return-Path: <netdev+bounces-181170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A299A83F88
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1770189370A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309426B941;
	Thu, 10 Apr 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3ylXd2M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8E204F81;
	Thu, 10 Apr 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278926; cv=none; b=chrBBqNqxwBeG1LuY5Fm8FcM+wbDC1tWLGlKFywFP9T1+LB7rq0THUh+oi7FyDP38iTV5Hhk/TkFUTk8i5zpqO/ign690QRGUm6UXZLGNqGzGv3sE8vLquwP+hxaxlFtztSswsjIRyATBHQmYq0SQlJxEExdVzHFCgyUw9TzQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278926; c=relaxed/simple;
	bh=dx9PVc5YU//su1hkWzSG1YoET9U0TvgQXEigv6hP5Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTk8jzTJfyuwJfXZKUuVyjLGeNPfBaccef5fyZcRW/afTo2H2b2a8VPdhUhD76CK0+MCET0I5SLuv5RBQzZJR8+NjjVb+eoceypae8QQY26Td4uyhxrEjiwobLhC0IexHRy1rDaKUr546zbewN/moolN1yKN8Ud+ZZgg3hHb7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3ylXd2M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391342fc0b5so375045f8f.3;
        Thu, 10 Apr 2025 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278923; x=1744883723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPkuPJhDQNeNfNnsVYZ0vASsQVFDCqr4rUSrxemwlbE=;
        b=A3ylXd2MAjbusiF7rSmR2wPrxzX/zKBOcGeB7J800pNkNB4n5LtIbBYzzKwvNC6mRS
         OrnZ6kyiQdLvdm12XT/Qspk6/Qei4Ec/kB7tK1oCmPVVPpod/jUcsQsd9lsfVIYDy+u4
         dxI1+6Km53FaE3650fDFORtvpNA+m/mDOHoiGutkZ+pOVU7icMvdwWxFMRPE2Pj3Lb2z
         vesENf2wlRf4VBIyE4UCr6Q29f8pyBbo3yZSnjf7BArH4HHtFz1fKAYe8vswGxYhh51l
         u4jfn8YkWJdVhc4xb4CrcbhSvgs0ilEGDVlCKQDyjgdebz9n0EZ0oauW7NgN9vNwT32M
         hx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278923; x=1744883723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPkuPJhDQNeNfNnsVYZ0vASsQVFDCqr4rUSrxemwlbE=;
        b=iOtG2ptmPcbUBLrvlf7k6c8ne+TIWgEJi3hBbhs/X0LkG5ClOGlRxfUxcWEbDg+3R9
         t9uxkNkI1pH2ol4HuAOWcegdxjnt0mCNpVRL9LGqDWbpEO27EGa4DHPEtea2qimJyZVd
         ygTGI5kh8nWEpX6hmk3ac4E6azGbLpMcdIS8T67QYMaGvH7nFAeTzIZhWeH9uD9/wtsm
         sstxZbmEe7406S23EHJzDWpO1gnIYbtGlDJteXbfJ3wA2TQNs2eHiz9HtcV/aHbVZ0Ol
         oifcDMS7vOVrUsoBXaohieCyJpacw+UjPvLyih4AcIu7Pq/WDA/7MvAwKcszJLV06FmG
         Fy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUxeypeAlNo4sD0djsduBSnasPR6Qrz7aluyYh8mVjIyApX32UlrDq9pI2q2eZafllU/LXx4ugzN18@vger.kernel.org, AJvYcCX3Zec8EnwNO/pPTsMRvVujYbktNwea2Sbq3HzeAArib+9G+an5yzTLuRA8gwyuG9E0U1D4NAOS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7iHVtO0AcekLwClFYJ2kKfdaULEOc37zmXMlrPJuNDlaI/Az
	lfVaUiQ9Y6A99eWgsVFQtgn5rCkvKCselLJ8sZFAsx8SaZsMj6W3
X-Gm-Gg: ASbGncuAbCl8PegDMNxJdP5ZTsooF2SwNCQUDGyamdotNI24+nzDhttP4x9PrYztGyG
	E9DXF1XigjbeucWehMhOQHZNp3/Qc9eYjoszpxdOM0X+WFnPh9d0QujJLhMR905vRkVwcD6jBDa
	IqqqRHvC84nUCBTpQzEP/DoraaM7fRd0xBmcoEFIvillLmZWj5ZiGOaPe6aDxAF0Eu1xLP7W+0n
	Qs09slq0X0MqPz7AYYfcw4+jmbOM1EKTyjNrQ0C8cQ7EPkSbuTXZ4hhsw04Q2lFLi/i3IEzTr/x
	rORivSHaHO+2yXHzxpcgoVTqcr5gpGmbzzuc21BT1atIofJelCWEW5nmoDTwBF14MxswPhkR52u
	2dsTcrbRpRw==
X-Google-Smtp-Source: AGHT+IEB8hq7C9Dat/6z/ZmSfB8cD7JqTeTIhKh9EvpvDRRsNwSzH0sX0e/nuvGGao9FdJvo0B0RbQ==
X-Received: by 2002:a05:6000:420d:b0:39c:1f10:c74c with SMTP id ffacd0b85a97d-39d8f4733c4mr1803845f8f.35.1744278923194;
        Thu, 10 Apr 2025 02:55:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm45404425e9.15.2025.04.10.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:55:22 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.or
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v7 4/6] net: phy: introduce genphy_match_phy_device()
Date: Thu, 10 Apr 2025 11:53:34 +0200
Message-ID: <20250410095443.30848-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410095443.30848-1-ansuelsmth@gmail.com>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
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


