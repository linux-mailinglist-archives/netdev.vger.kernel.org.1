Return-Path: <netdev+bounces-190698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C9AB84DA
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C7B7A822B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D704C29A311;
	Thu, 15 May 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWy4AxWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FB29993B;
	Thu, 15 May 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308478; cv=none; b=bxz25cWoNKxhXls22LFXC/ynUISc71A1wOe2HGtMcHmHlq4BF3zrhzoPI9vERqoj1jkktCUzcaEGXZsbo6ZCJ9jHsnPw5cSIvRwW2rg4BrzCJQtc3HtTBdFAm/7jILoExXPS+JZZNlCKDc6kpK56Mpuo1dubHd3JhP4UMRwTgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308478; c=relaxed/simple;
	bh=AXCBl/5hZD5LUHlzciawMj8Ax7ubKl91r7de/X5+Tbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvrX4usX9Y1k6JDIqsumEpuz+hJhEGWwKsTiLmgvkF724obmlf/Lrl0YD/gV7HiZXyKPpY5/5W5NpHIRPare4LKHdUpm9Dk5bUtmsyFTkoY44bgaJk9cGmA8niVODw2wkMnMP7chZ2kWvfWfJeLbpXwIeUp6Its/hQIu2Xh5Um8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWy4AxWp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso5025845e9.1;
        Thu, 15 May 2025 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308475; x=1747913275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0UbM3f3aiE6Xk9v2x1ninQEe7kuXc+YrE+ZJvHjaik=;
        b=lWy4AxWpiy2plUdCe9TdLzY/K+lqCOckzhRGZeY7AVNpFX2La5PsQupWp4ib03AGcw
         0RbZMP1gC0vCHmD5keh+A1R1KqFJ7W2gMtqbPaP9/AsQpCxtG5Dnmx6bMud9hTauNzZR
         iOLu1e0LcmxessL9GeapycXHWM2d/ZQGTvzkCJmR2B+h4YBh6U75JiYmBEe4hbeOTHYD
         0WOlbPC/PwhM7EJO216yrH2mUvhnnaLbtC8MAEzIqKtG7AtYH0ik0wyhI+lQGpGVC5bu
         7DIW8SiLtFVQkVlQCYW1mVGUN39CwoCclKFmDVsDUeOeQDyetbBabCA4TEnadwmxczgy
         +ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308475; x=1747913275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0UbM3f3aiE6Xk9v2x1ninQEe7kuXc+YrE+ZJvHjaik=;
        b=xSavDXG1SmqEzxKjYrjiMp+zauqE77JIgwmP+7NhyIMXFTEjKz/c9hWPWSRKsIl0u9
         uIwavGUCNY3tOyIPai0k0uh4MwkS+z9XdlTX8lq0hn+POhnIHI/g0rs82dNENZtXQsA8
         HhG7Eh2/zyvCPrTC+n0tdNv45dBNbbY+YL0a4O/EUmHap0URpoVQrj2LumK8CZ6vW31n
         01Ii6w5WRptGb2zBm7Vyxs4y114GLplTWQEwCSGC+E1LKdVrGw13BgplPcG+7DDDYqMm
         Jb94TCLYFH0kP/dQHFCPEcSwDr3U+fEl3YGv6Xm+AjynwC1A5+EH/2ZwkQAc1SJq3Vxy
         zJmg==
X-Forwarded-Encrypted: i=1; AJvYcCUpiUyVsbqollsdCNEprgN8+2Zmyqm0bvfSWyqHLc9jKQavaGfMxKXIFJMfiW0+WlhTFhbdshsNVXLC@vger.kernel.org, AJvYcCWGU0A6MTCjJRIjE82IqRz8wkBHqYB457UhmdlAQ3Q1qNVPR693NxHATYnXjpvVuOAqkquQbEpu@vger.kernel.org, AJvYcCWN6oU/UxSs/49jdr5OxEmS7Y1iwGbsintyK59PqCXlhpaDpKZApNRB0ZZHeBOmm0bPgt+i+8BThSs46Wk0@vger.kernel.org, AJvYcCXAUGmQTQM3NU8ASldexEP5owWR9/2PA5WaO/pz6nE5wn3n8qkQDD40XlB34lxT8NC9yynTWL0M2wXo59tE+W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKNGV8ALzZ7UMbvKf3XjSRkgolKL9ytXnZ+vuFiyd3otRjoSO
	KsStPZ1zgdkwtuY5POKdVcVPsFKu86vyqV6d8K2G2k+bgNOqzdSa
X-Gm-Gg: ASbGncubXpc+f+K5TadykgFZbKCjyFvHcC87/OvNeDqVhj1a2qdJccJTQ675Dn9iiO+
	Wk49PKDvm6X63I0CpnG3eebZAJ5tIto2JsydpSx8U58tpXgFi5ZBFKehNG42/GUxw0Vm6im3y6b
	0EBpxi//rrY5eP2AlyYvOYt2e2OclGjyo4cH1QHZsuLUj+aB642mOdsSbz+Scgwd2LZTXS4fmRb
	HtxezfZm2VhkJDqTuNgBbBtIM1BkAg70s3az6qSLDIuX2ExqT2uYfkLqbatfLTpBfBzhxO3KUXH
	91USiOL83QgCBms31HeyY3LyMcWjaIyTWZs8bZH06cz8qZGuUE/9fXXI1YGETz1oImgVOpEu4gr
	Bc+sN+fRtVE+3R/DawUQC
X-Google-Smtp-Source: AGHT+IHGqUnuI5GQl4wJvEvxOfAnIg2ziU0WdoLYNQJCQpABLjC5SCYgvGKV4wMJQiLTrKdZYmpSJQ==
X-Received: by 2002:a05:600c:818f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-442f96e54camr19913695e9.6.1747308474831;
        Thu, 15 May 2025 04:27:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm64497795e9.20.2025.05.15.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:27:54 -0700 (PDT)
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
Subject: [net-next PATCH v10 4/7] net: phy: introduce genphy_match_phy_device()
Date: Thu, 15 May 2025 13:27:09 +0200
Message-ID: <20250515112721.19323-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250515112721.19323-1-ansuelsmth@gmail.com>
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
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


