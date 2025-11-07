Return-Path: <netdev+bounces-236760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351DC3FB24
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FC91891750
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4113254BA;
	Fri,  7 Nov 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBEc5ieD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8C3254AB
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514266; cv=none; b=GJcOmRIpo0m87LA1X4SbBrAW5PyHliigrIUB6y63xTa7c7A7pVuzcfmZ9dsWc2AZDa/n0FoiJKHSK21lq7y4M2k5qh/jQfJnh/qDh7ZFXUXQD6aRmJT/FDbBsRyDS6mWf4QqTOga4wqmpC3HvxTvGHf0TGtutHLOQwJpO3RrJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514266; c=relaxed/simple;
	bh=km+Q85CbXoWksNaZ7smPrMgV3IhcwRncYPUgD1dodvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMYGiteUWwaIox4gFhwLSKFC8StWwaWl2gGFY9Tn490rJ7gyo7hd1A4rHBnSYd6NcnATb5wyeeb7zbNvjanQHeJ87zmMQ3h7nkh5swsmXQbzBuuAp2w+vRLTMkdn10+b4Sph/UYlAofSRYKzqMVqgJPc2lwyzyRfVNB6/akiRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBEc5ieD; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso490085a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762514264; x=1763119064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAEkeQ8lL8zgGt9X5ptAhWwpyBVXGyV+fHaoeQsAx0w=;
        b=OBEc5ieDK0iYhyYel57RUAvFd1VF/1+Bgf/e3Ly5KuI0Sm4RJB2Ys+EFeYoa7rj8K1
         0PTBpZe8g59t3RY4ScS6Y73B/VN/u65xMmOslSwfpupiwjXNnlzEGjF84kGQI1n5Z0iM
         W22elwXAbzgdxZqj10mdhri1l14yPZYsdlVIGypBPXplTKkN1Y1+eRDXkunZL39dt+dO
         CSYh4h7EUgdaH7D5Z2b22PwnRLKJkLWzSyaj35kZycfaG8HHrDCvXHpM+LHHENUT8UYd
         RDmBudfWsaKY/CdwT4q0yt95KyYLh6OxrsbrekGUjXe/Xq5UIrT0lg3q25r8XaTyF+WL
         m09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514264; x=1763119064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAEkeQ8lL8zgGt9X5ptAhWwpyBVXGyV+fHaoeQsAx0w=;
        b=w6y9dffewQwNRY3thtNIAStI/BegySi5Y71fDKEKv52BKm5r/RQ13farS8udnZgN8R
         37URswG0gddQmOIcZ+65wowN1/pbhCHs2HrdDaTdKFaGIeSFkQOtAB86w4/BmzA/bLyQ
         vA7NPsMAo9Z3Agjf+X7phN4dJRXfAu5ip1sqhL7nsm3OL2yEiCZLHNUmPFTHHMkxqbLS
         wBGFnvUyayLNi4H9hDVxEy6RPK8j97OefjWA5QzB0QUmwM9mMAjuME/o7O7Ayl2x77Xl
         tbJdQ41WGSnOBzy0cEA7dbmWlD2265zXL0gGrNjUgA5bl58S6u/WSk4do6Jj6XW8jfea
         BYFg==
X-Gm-Message-State: AOJu0YzlqMr5Z3GX4MM+AwKMhoPO5VyqgZi3O7E+6GNhraIuUibP2Hvh
	zIkNtl+no7fBykEHoST87TaXPpojIjVEke/pDJxiMfWRKBxOltAdG8Nb
X-Gm-Gg: ASbGncvaK43s3mGIAQUrWWuMuEebx3e3W/H27bwhTs/DtGZf5bj0GgHOUxCrUZ+0H9a
	mHWOOjCGzitQ3Xx8azGFBBgGu0mWpYQISn1Ll4GijoiMxjEOX+8/ZoJlfj51cKQAI2ZGAufFwGm
	+VRVG2eXs4QWJXRTbkH4ymB2AtWsvH0mzmf6UNGjDpcxp9F7soqw6nW40fZ6t72vz4rxgyLscwm
	DHH/rFYGuzmTHM0pOXnDTw+VJbw13B67PG4l1/pijV4Zl/VNvKig0OvPJN7CYFg3BEWK0V+YT8w
	bxsbB69HVv4YYZB05BqTIFYurmtJIaFT73tLa8aa1jzfbC8uRPP8sz6HMui7ZmPXtRHJiqkZdG6
	OBlR8hQkKAaFfgInRFa4669oNzXtrFQTgdamIvudODHNF16mVwYBC+UmJo0+YikOVAcwAHePpbg
	Y=
X-Google-Smtp-Source: AGHT+IGmhW4l2QYXug4vN9BCUJXlqsiwbMW15g9DF995bQ1tw6dyuhIw+sFYeLzZjXJTBAXyKbUeTA==
X-Received: by 2002:a17:903:1aee:b0:295:9db1:ff2b with SMTP id d9443c01a7336-297c048e371mr36463155ad.57.1762514263694;
        Fri, 07 Nov 2025 03:17:43 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d766efe6sm5186215ad.49.2025.11.07.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:17:43 -0800 (PST)
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
Subject: [PATCH v7 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Fri,  7 Nov 2025 19:17:14 +0800
Message-ID: <20251107111715.3196746-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107111715.3196746-1-inochiama@gmail.com>
References: <20251107111715.3196746-1-inochiama@gmail.com>
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
index 605ca20ae192..0c63e6ba2cb0 100644
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
+ * Return: fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can
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


