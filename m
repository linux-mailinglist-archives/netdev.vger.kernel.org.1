Return-Path: <netdev+bounces-179928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C0A7EEEA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F354411C8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F503226193;
	Mon,  7 Apr 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViHU42Id"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151C21B9D6;
	Mon,  7 Apr 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056613; cv=none; b=BL0MwgpfO5fD2Tvtal9TwUPn1ywFaDA9eLIiniM3b2LeB6lqdc2Fanu/RFeloQQD1GD48xO8R+arMUBuU/Gkx6ZgSysYGDuRsPaMaEVjVSDb6H79G5jG1z+PSf2vgZ0nP4tMLSWmkfdaXQsvcEzrDBmVyA/dY7sISP9Js4J6MkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056613; c=relaxed/simple;
	bh=dx9PVc5YU//su1hkWzSG1YoET9U0TvgQXEigv6hP5Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OITr6DKH6kLR0bVLebtreGeTEIFJOY+p93IqaOBabDVSDVv/8v+SJ24FaDPb2WCe0YPLuJv0UvRkG41UBwQh0WtzIyBMj+T1wp0ETjHkXeGbb9Zh56kt5WBV+0rJlEmzIzj8gjSf0fKIZz75Jz9T0CCRrIQNy+6y3ONMtuqfjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViHU42Id; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso30811505e9.0;
        Mon, 07 Apr 2025 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056609; x=1744661409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPkuPJhDQNeNfNnsVYZ0vASsQVFDCqr4rUSrxemwlbE=;
        b=ViHU42IdunXunZRnBl2GMigqu1PlwW9jFnu2MRQkOGSq4wGXZ0rpHK41aCZX2pRSKr
         vtpAymSeMJUjFrcONR3fWyfnldN2nQlvfzOVcyt2ZNhXWmNfS8L6ojribDVj5zWJLdx4
         il/zRLYoA5FWnDMijIi6IMBUKe3PUjfBXdX+s9E6hPS9Rq2kiNMUUrVUkrcZqsM0rDzC
         bM/cnXyuCP36VG0JMAxBLYFF4YtNY6ri3TdbHTcJR2/qeDye9nfDHP/oI/ljcorlLw74
         A+xziS8EkC02OP/YILrwjrlXHzOvUWERE9NfCDuu3iq9gM1dmBQy53gZoTXuRQzpRPm2
         YRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056609; x=1744661409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPkuPJhDQNeNfNnsVYZ0vASsQVFDCqr4rUSrxemwlbE=;
        b=h+My0/mDqSa1cQqDwv5bDMPLtapsjAwTBu1dBfHwKyQfCv0INvQfwGgJBHgmHgXmIw
         RpxzwKkcoM/i1ZYeWDCBnuN0kxyx9Qi/qAJCH5Xv76ZXOjf3KWzzapO+wEiomB8LFJsW
         jVXwFai/9OTSOkeHj99jpnhRtQahi6LWxZFJ0Pw8i1wkq67TPhPRo/SYfJzv8ykurXrD
         hR/4ztjfh7bfRcy1v9JQESlVVJDLkVr22HECpOlrruY6kTicLvXCMx9wrPmlQrPRuQw1
         GkBW7N6WRDA1uEH/bVag8XYM3RrALVt1tbGwQVSqD/APKbs01vwo3zJhfrd6XP0xtm7L
         mMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUew7oxevgCo4FwYy5n75Yh4CA5wpEHnHkQ6PPDFYu3gYF35JiRPeABWCB3YmyLuEzVCvW6lcKY7JqsrkHc@vger.kernel.org, AJvYcCVKMT9gkW8Qhb4z7wSJA2T29IBNZxOj2TF4GO12z822Ovyz3OLGNarAffgI+RZkO22eDZKY82fk@vger.kernel.org, AJvYcCX2UeMGFNynnojosyBTphPZGUZztEfobpapcYI5gsTe0AG0yzVMNBrlo4mDjFMpk3+NDGPcUhXD/Nfi@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsX8EBk2nbBaJobTN0J6gK6zSPnNYdtEAYv0UJaTVDBFE8qAl
	bJRPoR58K0mC65+RwYFkNzyHAy2M2TetdkpWsBkIvZNyaGOHXOBg0f8+GQ==
X-Gm-Gg: ASbGncuQzcLZpEsnMKdLLxqfmpBMTspejZBrzGfbfgWMb8URxRQOAdtVEUdWNQRaN4P
	9wN7dp4h4k7ZEZDsyze+aErdgW+Gt9gmkvqBiY4DBTDjwI8fHZjbDL/eNH8QP0Ecy5Q/i1D8tq6
	Bibo1AVomt7Kvj7Iddp/Jqp9gFusxSyliFKi4XfE18VrmcbVIGRi15X2xwl+oAQKq13wn2UDnr7
	u0y1q7D8EP33UVz0VzzM33JKEi0lRDTpA7iIsT4+D+UL9cEkBpv6pk5A+5IhvSqdfo5GMmHyShh
	KrbMK2ulw9xKB83WRk9BF9srO8T3XtwrbC6Aze38AyNgpQ3523DkoB5HP7Y8vJFaOPm/inkRQLS
	YlwljmpVmhii6sw==
X-Google-Smtp-Source: AGHT+IF9pttysQVZNJTgTX41QxqZgkIrlkFuaiWO4kkUgp52qOZFGlcTaVCCOHBrV9hA6FTXzzXZ/g==
X-Received: by 2002:a05:6000:250a:b0:391:2dea:c984 with SMTP id ffacd0b85a97d-39d07db55b9mr12747028f8f.11.1744056609236;
        Mon, 07 Apr 2025 13:10:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm139605995e9.18.2025.04.07.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:10:08 -0700 (PDT)
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
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v6 4/6] net: phy: introduce genphy_match_phy_device()
Date: Mon,  7 Apr 2025 22:09:24 +0200
Message-ID: <20250407200933.27811-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200933.27811-1-ansuelsmth@gmail.com>
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
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


