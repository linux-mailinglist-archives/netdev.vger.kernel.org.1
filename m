Return-Path: <netdev+bounces-51178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED267F96A9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED35E280D2C
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B8179AD;
	Sun, 26 Nov 2023 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqNDAG4d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB3113;
	Sun, 26 Nov 2023 15:51:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b34563987so20146135e9.1;
        Sun, 26 Nov 2023 15:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701042718; x=1701647518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igZnYyFKrMpXiYvtb+6rWbbtYfx7FdvfY2mFz0zvQMQ=;
        b=aqNDAG4dR+GOEi6nxXyLmhVH+JQKjdL31f+4gCCI/I8HAE5FfJhcTljaqWBuaEts9e
         lCntGbQXiibkWsx/dISe8kjUsfU89QEw42HuS+2mCJdE4o+CME1xsSPoSINn3uUScnFP
         fmKYzB2giv3lsHUp81zlrbvpqPLfBQ013c08k0JtTj3l3Yh7Ad8gUn9oBPDW111JLaxD
         oUKK0xQIRFbUxKRlJND6ieVMnbCbISHd7VY6cVb4nZQXoXYWjZcrbX5BMVyYAdvUwjKc
         QreSiotRrpiOZUTCNIbIfzu1w7YgTafZ42aq5QD/5eBMMK37PbSXcpD8qGNUF36JWFRb
         8V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701042718; x=1701647518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igZnYyFKrMpXiYvtb+6rWbbtYfx7FdvfY2mFz0zvQMQ=;
        b=Jd2TTs10QBI/kjzUJkWieKEW/lznS4ytJ/5FlIo2TrKp4yxdtlBL5+kb81i/bUcCvU
         xv22rRwQYT9yj0IZdPc/tiNy8+xbRZ6X0ymWfwBNmJwibVG+VusBsf+v/ORAvo+MKFBD
         N8+1GtWggmadYdlwWb1gcYL7ucnOVrZVKotjJBb5CN08X9P7+pQ997dedZ+YdxQL5p2V
         zHKHFusqZy3IKCWaiNfYGplY4D+2IOVrovbNot1zZIPcOYLYdt9TsNS79Q8YQbrcA2/h
         Qq/jhSe8Y7yjFmBWOa9lyp/lcGotquXAPMlgfi5iaqfYg5eIFfurHaXwnkF5gJ7fS+p7
         NacA==
X-Gm-Message-State: AOJu0Yyr5emJO39qenHBwDAJaCAy0UhMaMfqcK0wVv1noDmnhUlPWsdR
	OS3c7ni8a3U4oxiv5FD1mEM=
X-Google-Smtp-Source: AGHT+IGD6L6HK5CRxztosRedXkEPAJPvYZxo5tQWQ68zrG+TnQAE5/fkLrmeChD84JeEw7FrVx4/dg==
X-Received: by 2002:a05:600c:4746:b0:405:784a:d53e with SMTP id w6-20020a05600c474600b00405784ad53emr6744788wmo.20.1701042717734;
        Sun, 26 Nov 2023 15:51:57 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m4-20020a05600c4f4400b0040b3dbb5c93sm1202151wmq.1.2023.11.26.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:51:57 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Harini Katakam <harini.katakam@amd.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 4/4] net: phy: add support for PHY package MMD read/write
Date: Mon, 27 Nov 2023 00:51:41 +0100
Message-Id: <20231126235141.17996-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126235141.17996-1-ansuelsmth@gmail.com>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

It's possible to set is_c45 bool for phy_package_read/write to true to
access mmd regs for accessing C45 PHY in PHY package for global
configuration.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Rework to use newly introduced helper
- Add common check for regnum and devad

 include/linux/phy.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 96f6f34be051..3e507bd2c3b4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2085,6 +2085,84 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+static inline int phy_package_read_mmd(struct phy_device *phydev,
+				       unsigned int addr_offset, bool is_c45,
+				       int devad, u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+	int val;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = mmd_phy_read(phydev->mdio.bus, addr, is_c45, devad,
+			   regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+
+static inline int __phy_package_read_mmd(struct phy_device *phydev,
+					 unsigned int addr_offset, bool is_c45,
+					 int devad, u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_read(phydev->mdio.bus, addr, is_c45, devad,
+			    regnum);
+}
+
+static inline int phy_package_write_mmd(struct phy_device *phydev,
+					unsigned int addr_offset, bool is_c45,
+					int devad, u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+	int ret;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	ret = mmd_phy_write(phydev->mdio.bus, addr, is_c45, devad,
+			    regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static inline int __phy_package_write_mmd(struct phy_device *phydev,
+					  unsigned int addr_offset, bool is_c45,
+					  int devad, u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_write(phydev->mdio.bus, addr, is_c45, devad,
+			     regnum, val);
+}
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1


