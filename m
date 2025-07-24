Return-Path: <netdev+bounces-209600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82032B0FF4D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8534E564BC2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52387211A19;
	Thu, 24 Jul 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmSA+19u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5561EDA09;
	Thu, 24 Jul 2025 03:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329210; cv=none; b=lrkJPXwKNjpbeXjuodJs7vX0zKQwotHYU9usXLDDlfnwbu+7qw5zLeXciwoguNoDRzpWoqwfJ94/Kt0DzOIJN61LoxsJ5C8/Xk8p+EkxIeZ9tA1VqmqvkkdN9YMdbKHYss7DXCAa6K37X6pdsgektIrfdKzRy7EFE3UVJxYV/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329210; c=relaxed/simple;
	bh=KFlRWt+1u3NwVHrqIWKszKY4e8o0CB5gmk/nLqM8gn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvJ7f/9jEVm0v2vbC09Z2NZPZCHJ9+hSwn/RrTDL3TYqrQmcGny3dK9F5/jxMv5IZZ8qHixLIUm2STgAJfVnWFq/PbgnN69xLB/ZV8qc01Cij07wwetvwwRyL8x6u0MDfRcEaOHXyT8ryFoI3JKA+m1ol1VZYeccWlZPVu85wRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmSA+19u; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234b9dfb842so4195155ad.1;
        Wed, 23 Jul 2025 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329208; x=1753934008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abs8s1GADOMyP/FNC41zDKRy5tOebd7OE6fWPJb0Oao=;
        b=ZmSA+19ulaMh0QwFKDcEplV5G1QkuQkaXW5blqZ8Hm5oPySx8dCb7x1IATh9yMRUby
         3vhuHcH6MaXjcpI6GQS2Gg0JGvAYqGzsDtcP0Q8OkUAqtughay23ZR29SUZ8mpqlhIz4
         e2I3Y+TTZ05jFGvBxyeS1/REJcQkNtwzUn/QQHTKmLd0Qur429PO3gMa2QrlcunDU3Sa
         WewV1wLR0Wu2vYM/K/dMbNgBbLD0BTKPCD9TSOtlCewZP+6LlpBgfoCVW3KcHE9B33sY
         9sMtKdb4zj0PVAv9PFjv2rCMETwHdJt24NplsPzf5zsxi2z7bfG24iauUQypD2G/G5zZ
         MCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329208; x=1753934008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abs8s1GADOMyP/FNC41zDKRy5tOebd7OE6fWPJb0Oao=;
        b=ay3pnl2kx7KL1VIOS0TYdGYmZgXuW+ruEvEtdt58Tvxkb97VRQggZfRW68OrUGdTRM
         BAdxv6XoGA53l42yzFJUIjBWTp0X7ePg41Of32Zj5CzaXsSj1Xp3dYf1teg1AzXIBAC7
         +1jzERHdTwA3pKkZyqPvL2kV/i4Vd66vQ+ii65dAEJpSD9pJw9AcyH2ZmL96P3UA+b4F
         gNXZ9lIA035Fsc579nliuM5+GomUWN/kNiXSFcGjEF1KvmapEr9RplqEhTWxqwA5eJBC
         I17woFYcDP/E9JffHS8It+j0RkdcQOdsxqiYvy5elL6ExrLxlIjgz7d+ctxLqBB2xtcC
         01yg==
X-Forwarded-Encrypted: i=1; AJvYcCU6VclT8bskBNeKjoC0TwZlObH4IB2qheTdFH5OMXhH03g+BHvFCupnbp1Vt6gEK5g9XxQoXCFE@vger.kernel.org, AJvYcCUP1uR3SvEQldQd4yr1YmjXxDK4yltmHjNNLBBjvbzFzeB+I97Ie1zJWgxkM9BnGnebXoe1OnVzM8giU9OW@vger.kernel.org, AJvYcCVIRt1M5u8bscXWl3e7UbklhSehY6HKDPNaBzDU4Tk9NyX/73+UsYWdqRU9cWV4VelfNWbBqpjOc4KX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4t8X2B6YN7IwPTFGuhylDfwIDcpm72NL9NOY267c4NmKUrbSe
	DPJr3mlHs/UI3BTaNpfLXMp3fVVulxQr4QrlSx5zftI/GuWyLYwTyEmo
X-Gm-Gg: ASbGncsDdVLa3HP6KmaJMe7iwVyG6iT+9N0z32IGjcU9q0YMHMtFmc/VsbE8DBP/Tny
	XlWFKedjPja3PRnMRcNfU3CceQb8M0+qcMsJiz5tLpsxSdGmEapKOW1EsSEu2JxOOipa6LTUUax
	I+Q4yGw54h4gvQSth/Wk5KgoO+iMccsHBNE1ZAyT8Edi8NsDL/UeI/z2C9ghAk7hEmvbmA3O2PF
	PRIP+JrGFHae+YxoK9yUY5SL7wSy4dkun7psEzyDZWcsaYcI4UeKqN/u9TyrFG4qRH9ZbhraRug
	/jBiUxTRHnxD4yt3uK8/yWDncU5K+wGmG+bZCKGSBCLs9Ue2rv3j0V9zwAkXZd43ltZglQTk/g2
	K29BVorWdA4iDbOQxqWDGTaT9p84s4IxW7a9PoUrJ
X-Google-Smtp-Source: AGHT+IFvcxOtOFG6gcdq5uOl0vIOh1mfxbzQE8I2fFtm7zsMDaG+fAlM8c6zRhe/8PFTrsLV3ITjbA==
X-Received: by 2002:a17:903:41cf:b0:21f:4649:fd49 with SMTP id d9443c01a7336-23f981f4378mr92283135ad.49.1753329207074;
        Wed, 23 Jul 2025 20:53:27 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/7] net: dsa: b53: mmap: Add syscon reference and register layout for bcm63268
Date: Wed, 23 Jul 2025 20:52:43 -0700
Message-ID: <20250724035300.20497-5-kylehendrydev@gmail.com>
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

On bcm63xx SoCs there are registers that control the PHYs in
the GPIO controller. Allow the b53 driver to access them
by passing in the syscon through the device tree.

Add a structure to describe the ephy control register
and add register info for bcm63268.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index f97556c6ca2a..35bf39ab2771 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -21,13 +21,32 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/b53.h>
 
 #include "b53_priv.h"
 
+struct b53_phy_info {
+	u32 ephy_enable_mask;
+	u32 ephy_port_mask;
+	u32 ephy_bias_bit;
+	const u32 *ephy_offset;
+};
+
 struct b53_mmap_priv {
 	void __iomem *regs;
+	struct regmap *gpio_ctrl;
+	const struct b53_phy_info *phy_info;
+};
+
+static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
+
+static const struct b53_phy_info bcm63268_ephy_info = {
+	.ephy_enable_mask = GENMASK(4, 0),
+	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm63268_ephy_offsets) - 1), 0),
+	.ephy_bias_bit = 24,
+	.ephy_offset = bcm63268_ephy_offsets,
 };
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
@@ -313,6 +332,12 @@ static int b53_mmap_probe(struct platform_device *pdev)
 
 	priv->regs = pdata->regs;
 
+	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
+	if (!IS_ERR(priv->gpio_ctrl)) {
+		if (pdata->chip_id == BCM63268_DEVICE_ID)
+			priv->phy_info = &bcm63268_ephy_info;
+	}
+
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
 		return -ENOMEM;
-- 
2.43.0


