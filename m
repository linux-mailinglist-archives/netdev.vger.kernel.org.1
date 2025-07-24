Return-Path: <netdev+bounces-209603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CCB0FF57
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46DC583ECD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932222CBEC;
	Thu, 24 Jul 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hta2AdqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C341F2C34;
	Thu, 24 Jul 2025 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329218; cv=none; b=ltBJwMYN4y86ut1JSosB1T62FafOWA8tsoRQpnLJHrmvSf2Wf/W1FxNUydMX1kDYOZxIvZHXQPiURdN+iEVEgKzUWyuyPX9RckXBW6jvvkW3QjpMh2hTMXoyI4gZYoIvQEZ9SCU9g3Iolt+sitNFb6Ts1i3eo4rVF+KQ9yNdABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329218; c=relaxed/simple;
	bh=ktfiTtm6vo8ruut5eN/JC6In89YghOq6C8sRNHSyqA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nnd+XXwaWx5ColgNMRvqPIptzjEroyaFYNUnHM9iiJyBIKRdayRJveQnTZHldD14ormPtp7K4UCp0Iuz5L2f1S04jbDEyi0HFnPLuqursqdWfnY+tWEJLaXcPQXS7d6Geyz4mKTTAg5trPLy+s4lD39Iw7baG2mV69EtC6wNYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hta2AdqJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b271f3ae786so460661a12.3;
        Wed, 23 Jul 2025 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329217; x=1753934017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmfwBEHD5XzZTAZF/ja/CxWUT4TXnd/eEvL+FaJnMbM=;
        b=hta2AdqJSTYgVUq8QJ1mCboTMTrrJ0Ia7JEqwybynwHGjxUQSo0koRkpl6jDE6Vgnd
         g8+JyYwa4pRxTnPyqV8mhOV9jaKC8A8O0wKKF7tWVuAP+3DQELxFaviNqv1ZIQwjE9CW
         URtCFmZq1cmg9wHcA52QG7LFkM6zTQ8yRiJffGblqhYzALBqKmkggmOUFHyLDqJ0E59y
         3vcK+YITPW2C1PK1TBxsFqXlW33MlWJqjmWhIIhjb4RXBlhVROPdWawGHntwyUNUV2dv
         mT/hoPJOxWIFs3drgrlsbRJE1TChrA/JYvMrAyqEx908Bv5jRM9xig3YSKnT50PM5d0+
         SGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329217; x=1753934017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmfwBEHD5XzZTAZF/ja/CxWUT4TXnd/eEvL+FaJnMbM=;
        b=dlCbGLba5se/4vksr6IK6/pETCrX2Cp7vkHd4TI7sJiPOiIz6wZKio3AufZarcwnrr
         HHTWm+dzneeESHIGnjJ62+JxF4Vxbk/a49EmcX93Tlz0czFmD4x5eot8mW2aYaps4YOs
         f+W4keU9g3PBRKZTNYgGpAq+1RrIOR/HCph+QEZLf6kg1Y3zjGUd3vVvX6lq1t97quFX
         9Crae3LKir0qlAcxQ4wJEQ+lyUOzGXU6UEa6kKplNwLz3nAtoHUgJhArAHjb5LUWgNjK
         WwrjZKAV+bKJTILJSrzgJ3CmsTRgnTI/PNc39tANQRyEl29+eFgpxqs5DHTSKavL0VoS
         SNvg==
X-Forwarded-Encrypted: i=1; AJvYcCVCG/qX/75/DMX7zya/HoAsCVOkf7RTOiS/1fkuWEaoCmBpsu9L9zVJ4aaBo1n4mJKWlIpp6DVv8jtq@vger.kernel.org, AJvYcCVz3s6QpdfU3Lun4qo96M0NK6aevEzEvI0HWL3WVp4eXnqar/wpAWW0lZhhULF2wLnIpfvh4lYa@vger.kernel.org, AJvYcCXZnyxYxUJScUgl9C5ClmLp3cEOxVGzxtWMjCU2HHh93ZunoFWG8ls6PaZqauQjX3m9edUUbgmq6S4VSKDA@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMUKQTCVfn4aZLxv3pxAbYbSM8El7ekdLbUtJE5sC7H1iI9n6
	6QIcHTBT4C5G4RJquWE0uMz01TGwUUcdiLOLqd6Xz8L8XgzxcV6MhEsFWDlfPA==
X-Gm-Gg: ASbGnct7xInteUFBr+SVHVmdQVRSvmwpYhWU90XupX9q0XXI7vuZYFxNUetLvKAkj5/
	RF4YZAiXuPkfb2gRfGroGMKKqKoI4VcQfkt4YTZLjE0OCTwen6S4TKOnpZMrlGo4q72r5x7zpKT
	IDUnYX435l6QaxW8hWIiw0S9kyqFHML58aH1EOGRIqmwg37edDhxNHNFzHAU16N/kkur3VDrPEX
	u0Qfhsj5lpO1SHwa6MkSSPx71z36YVV4N4GEDB8nIH+7hhiTEbJ8ky39s18NrK7gid4lDF6eJzk
	MWXrFAIXuSN0BwMwqoqnzh8K+l8bRarISuJkJ7N4rx+iTDKPCJ2cfqRasEEe5WwYEImYI4xhnMv
	EXECxw3yZb0INH51ocgq94/eQ9SH/GXGh/+2ra2sxpuoM7N7cGZ0=
X-Google-Smtp-Source: AGHT+IGce8HrwZ/c2jA/2OLou1LVuCopW1m8FrFPsJedZdTV/U9Bv6S3DZBTo2SuSS6dcRyw7zpKkA==
X-Received: by 2002:a17:903:285:b0:234:c8f6:1b11 with SMTP id d9443c01a7336-23f9821e3aemr69679565ad.44.1753329216736;
        Wed, 23 Jul 2025 20:53:36 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:36 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] net: dsa: b53: mmap: Implement bcm63xx ephy power control
Date: Wed, 23 Jul 2025 20:52:46 -0700
Message-ID: <20250724035300.20497-8-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724035300.20497-1-kylehendrydev@gmail.com>
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the phy enable/disable calls for b53 mmap, and
set the power down registers in the ephy control register
appropriately.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 8f5914e2a790..f06c3e0cc42a 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -24,9 +24,12 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/b53.h>
+#include <linux/regmap.h>
 
 #include "b53_priv.h"
 
+#define BCM63XX_EPHY_REG 0x3C
+
 struct b53_phy_info {
 	u32 ephy_enable_mask;
 	u32 ephy_port_mask;
@@ -38,6 +41,7 @@ struct b53_mmap_priv {
 	void __iomem *regs;
 	struct regmap *gpio_ctrl;
 	const struct b53_phy_info *phy_info;
+	u32 phys_enabled;
 };
 
 static const u32 bcm6318_ephy_offsets[] = {4, 5, 6, 7};
@@ -266,6 +270,50 @@ static int b53_mmap_phy_write16(struct b53_device *dev, int addr, int reg,
 	return -EIO;
 }
 
+static int bcm63xx_ephy_set(struct b53_device *dev, int port, bool enable)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+	const struct b53_phy_info *info = priv->phy_info;
+	struct regmap *gpio_ctrl = priv->gpio_ctrl;
+	u32 mask, val;
+
+	if (enable) {
+		mask = (info->ephy_enable_mask << info->ephy_offset[port])
+				| BIT(info->ephy_bias_bit);
+		val = 0;
+	} else {
+		mask = (info->ephy_enable_mask << info->ephy_offset[port]);
+		if (!((priv->phys_enabled & ~BIT(port)) & info->ephy_port_mask))
+			mask |= BIT(info->ephy_bias_bit);
+		val = mask;
+	}
+	return regmap_update_bits(gpio_ctrl, BCM63XX_EPHY_REG, mask, val);
+}
+
+static void b53_mmap_phy_enable(struct b53_device *dev, int port)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+	int ret = 0;
+
+	if (priv->phy_info && (BIT(port) & priv->phy_info->ephy_port_mask))
+		ret = bcm63xx_ephy_set(dev, port, true);
+
+	if (!ret)
+		priv->phys_enabled |= BIT(port);
+}
+
+static void b53_mmap_phy_disable(struct b53_device *dev, int port)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+	int ret = 0;
+
+	if (priv->phy_info && (BIT(port) & priv->phy_info->ephy_port_mask))
+		ret = bcm63xx_ephy_set(dev, port, false);
+
+	if (!ret)
+		priv->phys_enabled &= ~BIT(port);
+}
+
 static const struct b53_io_ops b53_mmap_ops = {
 	.read8 = b53_mmap_read8,
 	.read16 = b53_mmap_read16,
@@ -279,6 +327,8 @@ static const struct b53_io_ops b53_mmap_ops = {
 	.write64 = b53_mmap_write64,
 	.phy_read16 = b53_mmap_phy_read16,
 	.phy_write16 = b53_mmap_phy_write16,
+	.phy_enable = b53_mmap_phy_enable,
+	.phy_disable = b53_mmap_phy_disable,
 };
 
 static int b53_mmap_probe_of(struct platform_device *pdev,
-- 
2.43.0


