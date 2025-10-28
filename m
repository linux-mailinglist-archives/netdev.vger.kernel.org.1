Return-Path: <netdev+bounces-233349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CCC1234D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4458054A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDBD218AA0;
	Tue, 28 Oct 2025 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsCefpb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC242135AD
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611956; cv=none; b=AMDyM9X29Z4dgPp5dbDMSGwg0H+cef0AZuPbyykibn9kLpgdSw+zFkM0ovYkUT8fYQ95chk8g+Jz5LL8YEELPq5fUydAM8vv1WdvgI+7vmO8fiCW9sKNuyvOvrFgPgGbWrnisVZYoN86QYg1rXrkUBrRjCJX7txc/7mNdRW7Src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611956; c=relaxed/simple;
	bh=WFJsAwSAfBll4rXsUKTECSFABgQcDyDelT5akN/S2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpzjTZ7HsjfW7qwM23JB4meP9EI1F1HbbY6BYmAlaF6bvanWEIkJjyDzbfKcb5KpPl4YbiMourEXU/IvkatIFJn9VxBmzfSl9Scyoj+5MqAIa4S/MXvaCjNcyW6lWT9oSbBK3zZpXsx/Xsozi2LZncuuajnYeshABCPDaDYXiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsCefpb3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33292adb180so5385162a91.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611954; x=1762216754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=CsCefpb3iNpm9bqI3uYHzcetXexj+rkkWvVHVtfbY9kWU9Z0YkQ5mI2m65+wIx2fku
         nQs5Z2upHq6ZgZz+4tiLwp8zi9yK2UynJaXi9u8V+DG2JKDzBxsvw7+J687MdzwahPV3
         RWURvFMFzWNPwlsZ9R+Dh3hbpwrCNOswJ6nJ9UQ0rrZlwaXVmAYx1JQZe1z/XGV+Z88V
         tYJVLIc9LJCHW7scip83S2WFusEXJ46RcpGGWRzvKUgFV4UZaVxQeup/ELammo5ndYQ+
         ZKTNz2ZtsIIdOBoyQ6NquZv27VySxMcRMfjLmS9kIWqkdpCkJxJkdZwAJ9oC8Hx5E35W
         2RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611954; x=1762216754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=lK/AkvYvQagidguHWQh4u4aqLipsJA/qYZUfhdww4hWZwoZAz4RLh23oVclhMBXYZN
         XksRKg4kZmZasRMJgJEgnUU+msuKNkAcT2KImjuEGcjAfiNLTZgydx8i3+VhE4nrwIMS
         o3ds8uetYgLK9DXwkag1jM3mCGUcEqmDD3JyHZieU8hXvLYzWuFFdfbTpmp3D4muedfK
         UfmngcOQYbERbU2d0uVYtVukauMiigcrIIwook2T/KkPuer7fT0/4NEBRq32GW+wBriY
         PTFbQqoFTP/bcwu334j98/jTKOW5S6pMt+nd+G0RJjB7+k6G3rmG4jARh1M0RkJEKHcz
         Peew==
X-Gm-Message-State: AOJu0YzFsxZRycAzgPiGq6jlGOO+J8JsaU25fzWE3i94w+inY+gg21MW
	/czZAzd3zcwnrmThFFyuhhD1538GkNd0oHS2Q8QfoPpEBmbKeJoM6DGY
X-Gm-Gg: ASbGncvtiDEkMViAilQZKGPx4TPLQb47nkvWfc0ziCOT9s0SF/bQz4WNzgzTLh8+num
	H15BMmDsGqUf6z/Z3fmgbOY6rIDwJxTgZCUPheCzLrZWrBk8MSUz/z+kAZYubPlsS0wg8Es91CX
	lbKUxJXcW9B2Nc1lXQLcnoMtbR4mj2s/Py47+JejBVMDGWRR3dFGrUIadLx+BUob1cK9XwWYetS
	+ZK2ASZmmc/dHfa618m1JzofhblcMW+tKxdvL0w+s6zNlZLYeqOx46hrtOKeaGbyIpkFeqyYJ0t
	nyzCdZRvRDhb9Z2NIVneWtN4IEbv/S9O3+srLHtCfPOhZw2Tra603ypnM4LwShdlsIzjpDNGTgx
	O8MwYgXrnzFZldP49uzciE4NAP4iOvb596usYieJl0CvatySvl5jMOn5Nc1su5R/sfvsyKUcegY
	LwPeHKrAm6fg==
X-Google-Smtp-Source: AGHT+IGlGdHwoHvvWJbSfq7fs7gWWYLvmYXWrIA0qO3xj1Qshht6xEIpI7sww7p68LXdI3n1iXEunw==
X-Received: by 2002:a17:90b:3882:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-340279e3fa7mr2149486a91.7.1761611953610;
        Mon, 27 Oct 2025 17:39:13 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414034661sm9665148b3a.26.2025.10.27.17.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:39:13 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Tue, 28 Oct 2025 08:38:57 +0800
Message-ID: <20251028003858.267040-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028003858.267040-1-inochiama@gmail.com>
References: <20251028003858.267040-1-inochiama@gmail.com>
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
2.51.1


