Return-Path: <netdev+bounces-232319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004AC040F2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D373B7C80
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7EC21D011;
	Fri, 24 Oct 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0JEdVFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBF2192F9
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270945; cv=none; b=sPTpYyle0fTJWJiVvKnCM5HSKkxhUTKjTsW0tck1dxywZoI4BW2HOy4PNv+mXBhNth1UdxBpSgc4jH70TnpqHVwSCJ/TOApyppt3zBVhZHG/7KFw2BTKezZCEYvj5/bb1U0IBtsnAVlTU9QLekBakGgmeupr9gSfP4gDVzG0778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270945; c=relaxed/simple;
	bh=WFJsAwSAfBll4rXsUKTECSFABgQcDyDelT5akN/S2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulsmISapCQa6ZwK6vQ1FUTxiZn8yEA6dTTiUbGci+Bn2gUg/2z4XsZJT8ao93Lc5kpuZMZirK20DdLrSRhaX7ndQnuBkXONmxowJ+GK4m79UMV5GYAHKpcYoIer+v4a33//dHCO1/4a9q0QaHgaO1itZwCPtEEPshIC11D0VSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0JEdVFF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eceb38eb1so17038565ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270943; x=1761875743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=I0JEdVFFZZLjGhpK53kHTJesKjplW0ZcPj5dXfL4L3dHv/viXeOZAXs795ZhGFx6qp
         aQicd83fppSexV7khmgli08VrLnLuHLlEyb1EltiIkNA68jQ2BwP4r7aPdL2Ru1+f1dO
         TOowP+8CTW/YLeNGIhpfMsyqhbKZXXtW/0Mq5zIhf4Inl6qvJbu+t/AxLL2Y+L5U2QPw
         YQAQLCgSpBhN4SyyU0TEdCHWBfF44iXjJvjOmu/h9zLoDI+bbBdyIU62a/arkz/Tz+iT
         vMko20ZbQcdDSMGGExz+oN+mQZrhGQqpSvfmwSo82C9OtzLJWxROVHQUhakd9v0NcU7o
         nPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270943; x=1761875743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=NvgvLPbD5TIXrABZehwy8zba5quy1jboPuQE3+fg8kK/DvDDRpQmTdJjLKzkrRlVPd
         F2SXkB5+VkOepO6q3c+z3jNc7ut4yJvSpixIhE/u+hJfDNkTy++yI2ZEiH+873IDW7MR
         /wga3JZyXrRR65PlTeJazqU6yhd8sCS6UXGQcjOm3ITAlySgvqj9Wojlm/YI3F75uJOR
         ISPanAvJcK6bGVRB0ICxa9XIBLy9jEF94ex7WGnQP66T3hPhbgZ05Kh7smy09ylF1S3s
         KzGK6q7INuXWaAPCeMncKC9f2mcbtVHXRkWb6qKMi4H3rs/WpwBuPwKAzKVza5iDtS8S
         +F3A==
X-Gm-Message-State: AOJu0YyRZgm+glFy0PrUQMVkP6MfexX6Lsw4RGCqXGChDcT9VXXKGYSY
	g3Bp5dKjYGULW9kYCzgaBPGkj3i1vPdscFxCygFYowmuIS/P5ZzjXPcF
X-Gm-Gg: ASbGncvGhXFtNQUkTTUXbB8MPRumpPqV/qJqKkdcp7yMrmLGnEdaiYwJxTfCCCr80Cx
	seCQk/alDf/aEqJkrtOTMiRa1w1Ga/GjKN0d1QM0Ck7bMTJUBd4kjHbghWhvoldUksF/rrO64Ob
	KHxJ+plycvhKTFF/wwpqDsVOqFFpmtaSMpWesKhlnN3DD1LB2epV12T10tkjI43/UT9EGKng+Ye
	XJr8GOsyprGw4TVPs1SEM+l8VGXKdyXw64jriGgTELt8yDcieC6bVX0b8hhondG8kyGAWG0f807
	CH8qpNJfiFF3Q2GLcdGlo9xVs0Z8bMFWG25YwHYzPCmAi1xSadefBLzwJKlK7/4Qx4UO6W/fjpV
	FqMQswJ/mkLbUfRIUiN2XbJXESmS9wsgBaU7ZPXAR+2xpCLLSu5ApYUNpDIleDDj4eo5viXKN+M
	M=
X-Google-Smtp-Source: AGHT+IHkeRksmcYTcot27my+cABGgXJy6A76mmDUaCFMyxR7nPEFIYROl81koFxsnVclUBArcvfVMw==
X-Received: by 2002:a17:902:d2d0:b0:254:70cb:5b36 with SMTP id d9443c01a7336-290c9cf37b2mr241881045ad.8.1761270943405;
        Thu, 23 Oct 2025 18:55:43 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm37638255ad.34.2025.10.23.18.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:43 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Fri, 24 Oct 2025 09:55:23 +0800
Message-ID: <20251024015524.291013-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024015524.291013-1-inochiama@gmail.com>
References: <20251024015524.291013-1-inochiama@gmail.com>
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


