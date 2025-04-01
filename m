Return-Path: <netdev+bounces-178574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3EA779F8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67E716B319
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2773203703;
	Tue,  1 Apr 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqsu/3LU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B46202F80;
	Tue,  1 Apr 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508014; cv=none; b=p5fj52uvKk/8aIQ1/hrmUaSz5UcyS2acUxpZ5vTZ8XgjRvZum63WE3llsv3V4nR/QVmFJKXXRneu3uIp9lfAANjg4LhhkMXeH96D4nC5TsueU7g7xQ3jeZ2y3raDt+JAw68+2t0SWfc5RLv98hVBSxAyDtqvJVTjchhHHbSFIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508014; c=relaxed/simple;
	bh=Fw8Mhmj4yOddrjW0INHvn2Cdixlrl52m0hiV/iVxoKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDezXqP1GWPVF2pvacWuvPODp/0Yq5F/B3pS5zMwbz3AZWlhLHQ19o6RFEoM1LJp+1myfAuFuKAcSV9zGGvZDyeRSdLHQ9d7N+La41CVYSuH7mrM0gcQwu/74SFnEMuEPW3QYpc4n8FbqC5rouLmPY+QUEZJ+kDU8jfzqu7yb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqsu/3LU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso55247785e9.1;
        Tue, 01 Apr 2025 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743508011; x=1744112811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx5narcbW6eR+BDfyixrGWiCVXRk99KznhKxGWd0deo=;
        b=Aqsu/3LUaVXdGEME65+IvxsV4OOT7yZ+gEJ4q1t0WPbkSSU0BBCIQU960svUu2S/cy
         WX1sZfqpCIdHqihCPaI+PksQu2OZfsqSQ6t2CDu5jUYQnD26SAHct6VEe9QWhvMgzEo7
         yq8cwpLSdn/bXaRiYtB6ymC3k3YQk/8E/kZBAZ9OH60p8ZqojOxCEJM9sDinodaCpg0K
         OfEzrf1OzP/H1vSfuJ3OHEAHsIn8SHL2pQywxDVsss0gOhfrnuBvh1Kr2KHSaROnehm8
         8NSrTMnLhzy6blr7OXiDZrunKIGrUSxdVDInD5fqsAWoL56dTbZs7rLuTaxDUB146SIK
         TnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508011; x=1744112811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx5narcbW6eR+BDfyixrGWiCVXRk99KznhKxGWd0deo=;
        b=BEAN3l43OVYx4q2mLFobaA43mWdAzrcIvOuMvRbZzPaEchnz1anAp11SFVTrP/WuB8
         sR++7SycyIrLZ8y5b/jzekyGw5kAjnUg9WMBy2XEOlw1amsOOq+zg5GnQMIkmdqEBgex
         cZx5+Zt5+c2gBlk1InRH8P/D76eJG9jEZ0GQg+MOGigZGxSrMFpqDSJB2nw3YqodTN9N
         N+fZhnZOYIEC3jtOweZk1uA3T65G3w9UfHBT198nseWhI6qP5Lm99XGnt5V9zrZ5g8dO
         1qVvG5d+ew63gPACgLJvyjaGW70AuJ6utQHkqlCK4tpy0tV7oKxnA7kUXQ1wJdFwEQVm
         0sOg==
X-Forwarded-Encrypted: i=1; AJvYcCVsS9kWDETekxZRpKINpIdzQ9WFFKQ35lB4HhJEFmDYX5hoid+p9XfzUPuVKMfVhb79Oubur6ubZj0g3Lch@vger.kernel.org, AJvYcCWVtwW1U4JXUFbAPjMIGkz3CwNt4HeGKo7iNrJotrdGZH3RhGjTZVurwypqNRFSRoz04kgw3JGPXuA3@vger.kernel.org, AJvYcCXpQzUT+cU5TGGLOZOonOcUqolQwH01wypP4b1vLfYaIOgK1G/Md7FmOvRIBp2GI03z/DEORm8Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5cMZz2ByUhOSMMr+MoMu9rXmYchC4uVwBXlGcHYB9Fgi8sI4r
	bnQcGPYFlxCcIFnvZWxBLKZwKYhYyZ1qMjI5ANn8PqFpSHMAJbuM
X-Gm-Gg: ASbGncsjjNJr5UW+rQdABt+gSpmPFyM+BVOEIzGE+EuJV0KR2SFcijRZs8yKmV2Ka5j
	SwzEgMLYUbkXfQ8PkbpDKh1bKx/jYeh6U1b/TWgUPk9DuMlsmUsmKg9tAJW2fyZdsKluLjbI05I
	BX9gQN96/+nB3E3qaH9CMejoHYjDg9Yth1FI4hsMJyRYvi3cGNSBMsj3VMfpXGacczU4+T2imwB
	wPziXfD3JnYOeTo7xsU3FA2WrbG8FjSq9jccxtQSolFw64Muf/PF04RwN52ZJoLMRtE7l9K/X8+
	pOFAL/M+PEVVfXTDQTOyU+3fXhjkX4INTwFObABde9SyBHNUY1uPvkWVziGKKPKuQMClRZKZ7cL
	bwFa18zGogz1ENA==
X-Google-Smtp-Source: AGHT+IGxJ3CAuBlaCKITRy3TT/JA7UPtomUF1BU1da5+Ly9ilpxXlI0ARBhp65hG7UQHHRPYWeePJQ==
X-Received: by 2002:a05:600c:3ca6:b0:43c:fa0e:471a with SMTP id 5b1f17b1804b1-43db61d9cf5mr128743135e9.5.1743508010946;
        Tue, 01 Apr 2025 04:46:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ead679894sm8148175e9.40.2025.04.01.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:46:50 -0700 (PDT)
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
Subject: [net-next RFC PATCH v5 4/6] net: phy: introduce genphy_match_phy_device()
Date: Tue,  1 Apr 2025 13:46:05 +0200
Message-ID: <20250401114611.4063-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401114611.4063-1-ansuelsmth@gmail.com>
References: <20250401114611.4063-1-ansuelsmth@gmail.com>
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


