Return-Path: <netdev+bounces-234934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F06C29EA4
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 04:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C74EBC14
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C928B4F0;
	Mon,  3 Nov 2025 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvo8UHVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4152877C3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139152; cv=none; b=aDzM1w8S7kNl0uhGIVOPIdBRZpLs8lIp/ZiUJYwZS3xcLew9j12iIVBEa2BCbw7LK1Cvytbn0rdP6sYx1Arjor3rzyxxfaxfEf4ocCOvx9CKL3AVHqPKGqc/MGQLdZWz2uFkpL296VswtdIHF2XcaXjOwtL0X+qzA+doBopsp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139152; c=relaxed/simple;
	bh=g1gjey22aj0deXr/Rxp5x8gbHU/r8O1Vjh1tF746E4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFLhaV3IdHSzs/7K2d+jnembxyih8YfiDHqQCt6+yCOPy8EmOv6YqQlJE3eDq9JyfkGgpJCLHKV/zJtMwzv08gGUJqQ0AMa6FYHENq9AtH9AEC0IPd58RjwD9OXtozIEGiI0pE48SYbFnRXQ3T+ezqqoA2dU7oeiwLJZZ71DRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvo8UHVq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2701828b3a.2
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 19:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762139150; x=1762743950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4QTOT55+/ql6/pjv059GwSZ6Db5fZXYVpPWy9XubXk=;
        b=Bvo8UHVq6e3de225ALyFSiXW4frvs1o1QwmRDv/kIUjBU3KCFBJArZg948DlXvgH0e
         cIPOnsHAVrPDiitBmYZtfWD5plF0J+coDICJq5+0h5BPKrrZZ98Cpp+EFlcpxEddT2jl
         xRNWDAs4qFbkVCOZCt6S+1bv3PLejq4j7MoPaBCzPt/pDLPZi7zPBagHWxWCRjBg7pTS
         YCo6F07+KkOXF97rXEtnOSpg35rqFxj1gSRGDux56eeC3RqkJJ5JR7BOSyR8GQRCfMz7
         D4008t6jJG1Al9r4mFYMM6cJcMkMeP5EyH8N9RSj7m4jl72Fnmoa/l7Xh74A9R/YcvLu
         c9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139150; x=1762743950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4QTOT55+/ql6/pjv059GwSZ6Db5fZXYVpPWy9XubXk=;
        b=pIo++41LXVqyL+pBcWEMKLFOO8oW3WXPUQnGtZfwbck+XvPDRUdgWXpnGm7kQCzjvP
         1zaB6HFw/Jy4+ANJQNPmo4cAllQ8U5NKT7BC8ett4C/z02EKvG7sUB0BVNcFQW45Jx7q
         J6vN8bnsbFLUkNUBm3Y5yipMk83Z11fPzsFa2uUVfLokWr3d94iGlMm3Y/0+ZggeN+yI
         Fe5/6ucOaFIFXsP9q2bqOb9xCHbynr6cynWUsOnNItOwUWLyqGzowX6XzN0mEkRCf/5o
         L1SycsMWfAp5c2fFM/y3TIy2PDAxRsJmwV3tnct1z3hpbH4dkBUEy6oB3DrqY7aqV2OQ
         HbvA==
X-Gm-Message-State: AOJu0YxPVmu96yiejFpGwijrPEGa56fl+jfvNQJn1qgfcPa8BEqFqHF5
	w4xqC3WFyC3Z3Zsf6lSglfZRZP9k5bHBfK70zhdB5+r/HBvbM1swRlpJ
X-Gm-Gg: ASbGncu7DQ/38Yz4PTXZ59tGco7rAknp7LXu99udXgdjMSW9OAZ20Lrvo/RuZfIlIjw
	Stn7WdYo1AW09R7m2ADPP3IjhbilLaazVNJfLg4hPMTYrhHhkofM5HbXzyY0Oqt2ROmgF5w1rOf
	lBXyX+mlLYl15trj6Po+5ufg/WX8XZzlXcpLQhtI/6YXjpECBjCFZ5fKWZ3vk00PDrB+zVp2FsS
	7oPlClECtkUssq1VC4R7xzv3/QvwYmoJCisaWEzNJXC6yH30irNTkYVxumfQR2Yke8arKsDjf2a
	GmHc9xvM77FTuMDvaIYzvwawOR5U1kEXgsTEMP9yHa3vsdyR2i9tY/GC8cU4K6Qpw3O+XnWQgd1
	LeKw6yD6rL6ZkHGpwzqUPSvMqRpKtseO4ITV4M4xE3j/iFUNpm7pRn4SrDAVUg0N7iIPZEWmrk2
	0=
X-Google-Smtp-Source: AGHT+IHUj0n47h7V6n+yPrS3AH7Tk+MT/zDMbn/+1x+Z1nt4DmkG8sgKVizJiB0cJZx6/5G2TiyAow==
X-Received: by 2002:a05:6a00:398e:b0:776:1c49:82f8 with SMTP id d2e1a72fcca58-7a777a489f7mr12266459b3a.8.1762139149548;
        Sun, 02 Nov 2025 19:05:49 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db197335sm9410788b3a.47.2025.11.02.19.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:05:49 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v6 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Mon,  3 Nov 2025 11:05:25 +0800
Message-ID: <20251103030526.1092365-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103030526.1092365-1-inochiama@gmail.com>
References: <20251103030526.1092365-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "phy-mode" property of devicetree indicates whether the PCB has
delay now, which means the mac needs to modify the PHY mode based
on whether there is an internal delay in the mac.

This modification is similar for many ethernet drivers. To simplify
code, define the helper phy_fix_phy_mode_for_mac_delays(speed, mac_txid,
mac_rxid) to fix PHY mode based on whether mac adds internal delay.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-core.c | 43 ++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..4f258fb409da 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -101,6 +101,49 @@ const char *phy_rate_matching_to_str(int rate_matching)
 }
 EXPORT_SYMBOL_GPL(phy_rate_matching_to_str);
 
+/**
+ * phy_fix_phy_mode_for_mac_delays - Convenience function for fixing PHY
+ * mode based on whether mac adds internal delay
+ *
+ * @interface: The current interface mode of the port
+ * @mac_txid: True if the mac adds internal tx delay
+ * @mac_rxid: True if the mac adds internal rx delay
+ *
+ * Return fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can
+ * not apply the internal delay
+ */
+phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
+						bool mac_txid, bool mac_rxid)
+{
+	if (!phy_interface_mode_is_rgmii(interface))
+		return interface;
+
+	if (mac_txid && mac_rxid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	if (mac_txid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_RXID;
+		if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	if (mac_rxid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_TXID;
+		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	return interface;
+}
+EXPORT_SYMBOL_GPL(phy_fix_phy_mode_for_mac_delays);
+
 /**
  * phy_interface_num_ports - Return the number of links that can be carried by
  *			     a given MAC-PHY physical link. Returns 0 if this is
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c7634482356..0bc00a4cceb2 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1813,6 +1813,9 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
 	return phydev->is_pseudo_fixed_link;
 }
 
+phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
+						bool mac_txid, bool mac_rxid);
+
 int phy_save_page(struct phy_device *phydev);
 int phy_select_page(struct phy_device *phydev, int page);
 int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);
-- 
2.51.2


