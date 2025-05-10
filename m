Return-Path: <netdev+bounces-189490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F7AB258B
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 00:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6651B65DE2
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 22:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC8221F1B;
	Sat, 10 May 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJbVuzhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7D21B9C6;
	Sat, 10 May 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914797; cv=none; b=geX09kk2uh60U+60rV5h+D/Y2tlBlr/PsTA37AwRm+p8OSC2jbU4JiFRBxgz4+1TdxqNcflUGVAZvxsmL+KSiSF98LI9QxP/Ts9wR16FeygvPslMraVyr82dnMs3piBV0Qo6SERW0N0DIYgKeZML5ToJHPIZ2joi7Q5Kit+oR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914797; c=relaxed/simple;
	bh=kW1rAjVyXUckn0dcQM5p/iQemZPuxBVrdIvHlZvSnfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kftsrGrv8xVF6f2OlTg+q+O8wM03ora3YGj9l4KI1ClzbNg6R0y2Cw60Pz7X6hBEPRCH8ctseuMagZr52ZnPILngGaVcfwR62w0kNViiaUFqzDRoz0fM9VBjzkHiiViXLcPpGhTuaMwbZrwUA1FraKoy/JHYZDgm9TAzwWIIeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJbVuzhL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b933f214so1255738f8f.0;
        Sat, 10 May 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914793; x=1747519593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBOXtLmY3i+TUAFPIrzedUySgsNtLLxnleQj5jKUdg4=;
        b=YJbVuzhL4GBU4MioEngrWNCjv5W3y5o9cZP8tSNiXug3nOUVxP94rx37DHcKw5B7N1
         CXB7PdoKpn6MlRrCY14AhAFQwkF15mX/fMldgBqKtd3460c1hsmiSSdSixvcLxRJaHYK
         iyyZL9r7ReDSBbiqARbcNTvlFmoQ+YHQEMpJn2Fi0mdU3reHDE5+pwwI4WQsaaRv00Qp
         0Mf+ls9iN11w+vqZ3fn8HPV1hI4qwAJPf5nmo4v4oc3zoWmUyGBUIPNXuMkv/zugaij9
         6DVALxlUD6h5EOF7stPQC96jFQzsX9JQcF2E6nmAxVzRNRRwz/qyz4ESly+adhSK12fu
         v7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914793; x=1747519593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBOXtLmY3i+TUAFPIrzedUySgsNtLLxnleQj5jKUdg4=;
        b=L5K6DxpzazNjyDWGbAzSeqXYwTS9NqqzYPr344DRkq6cKrETisQENVDnXy9WlhdGns
         f2H1Qec5rCb4TF4mdIGDjd1yavcICzk9CqnU8v+rGAIsaUKg6VpKByvT4xiu2FbCVm4u
         aQg2mGJzz77Qsxehu+qbX0UgaeNZ2y6txGuRU+W2+DVVfhKZVCikm04LzjzEZXBOh/fT
         RkXzZzUs3Sq9EblVMwyLr6PRInBY3t/qoswyfiWBSqcVucy6HiqHcX4+puvwew6B4CHI
         DnrpXVXbYwTAalYZmtTcAwULmQT7E/f3370iy6fjyjooPngPQaq+t8bOIFh7xnfenwDr
         kXaA==
X-Forwarded-Encrypted: i=1; AJvYcCU6AZQNzoGb3rwow1AlG2ZgeV2hzoQrdQkh6yGZTAklB4Ki0nxT6VGRVs8HVS7OEj7wZcoYZaiIGASTvIaX@vger.kernel.org, AJvYcCURPXJtKLGx0uSl6duA+VmjMhtzahfyXsiRGGTzL5wBOfixcog6rJg7E1uHdKYtsxoejPYLV+gYOwuL@vger.kernel.org, AJvYcCUleSACifUyRaPrSW6y6+ooO93dOkxsTAMEa1QQaTWQ6CeOHCMDuQ9wx7IcKmr64Hi6ZkDvgIaa@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7+zSlaj8I+ywdzF1rmKQN4Mo1LB0Irel55t3hsL9DAPcFYdf
	Hk7vfECkpgm9tBjIl4mDxC4wOX6544cYdyvFbDkiK3scXbC+ANFZ
X-Gm-Gg: ASbGnct+P24swPfa3C0pezWusf8pj2cYfywfr9oAm0xpfIty64ZfNKIssnqCIZwMr/C
	0xJHgpFo3ULf9OA9H4rpl1fgR46noXrEo+Rb7ecouxX/6SFTnrhORhb18wfDfuvY9I7WCh6s9Ok
	FgQHLNgldwbyj3FkDgWuQaxPb2JrVXVGGAav+RTf84E6gA9ZLCBGvxwUCPayzsT/hPbtvlJ2yTW
	Z+Nk8UZ9hDk/lrNO4GqXf+jvaB//nKc76jSpYA7/Vt/yuzdhcGpDaCmp87F3O4sYacxjfEHHNL7
	NgAMSCdPZLqFXReWuHgcxfNuMQMowurKwsbqiLVXtSn74IWPRd0zSA0yz1byGM576bOO/OSqmW6
	Wjc+YlSiKTdxbOyyFtHsF
X-Google-Smtp-Source: AGHT+IEgH4r1KmnMjgetEWTA1Xxtcx2zXL4uub027Ewac8eMJxfJAtGwDGM4lKjBilxy7bgFEROPwA==
X-Received: by 2002:a05:6000:3113:b0:3a0:b308:8427 with SMTP id ffacd0b85a97d-3a1f6482d31mr6682657f8f.37.1746914792970;
        Sat, 10 May 2025 15:06:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm7477940f8f.75.2025.05.10.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:06:32 -0700 (PDT)
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
Subject: [net-next PATCH v8 4/6] net: phy: introduce genphy_match_phy_device()
Date: Sun, 11 May 2025 00:05:46 +0200
Message-ID: <20250510220556.3352247-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510220556.3352247-1-ansuelsmth@gmail.com>
References: <20250510220556.3352247-1-ansuelsmth@gmail.com>
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


