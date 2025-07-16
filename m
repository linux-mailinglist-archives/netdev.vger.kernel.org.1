Return-Path: <netdev+bounces-207332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F1B06A84
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE47B1678
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2F1E0E00;
	Wed, 16 Jul 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG44x1IW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D81DE4E5;
	Wed, 16 Jul 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625799; cv=none; b=g3jVjsJtFK7mIxJ0pkfRvBqSEg+gr/plEi9kVrqiGfLwl3REG3IdBjk9/6Dac6P3IscKWaR/LlO+uL4lON8n6mW1QxsMebmws65kkqawsozdTMbnK5kA9AkT/tykbk6DcwZkihAXrfsyV6eHClfZlxcs3mzANP4bVfo37s8FloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625799; c=relaxed/simple;
	bh=ktfiTtm6vo8ruut5eN/JC6In89YghOq6C8sRNHSyqA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOUmXC/N2X+DB5R/Mfsc9CyUZoeSuTIdKG0RieR692Disml1VTmK9THOK458vwpUOBX7LLwGUUfNuMFiwfLce7wEbmvJFEfWGrE1URTPpnGPHQaCYjfxh8Cqewho8GbU8H8YgmW6WyqBMWZKWibCZNyAHcuEwibWawkh9yI9aOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG44x1IW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so293748b3a.0;
        Tue, 15 Jul 2025 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625797; x=1753230597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmfwBEHD5XzZTAZF/ja/CxWUT4TXnd/eEvL+FaJnMbM=;
        b=FG44x1IW1icB+TSHo0biNrRAODi2ubAz2TTNEm3QQa0z5g/fMRc6RN1Xe24lL10CmC
         IZ/t9/fEtYgj1KzYPUjiRTXy6lYatL7voBDkbuyiMJ5YJQf6XgyA/d6cpHIJqWyzYdnI
         R8D1q11yGBCoAZwNMGHdzxgXZwuTxiVsh+NMPZozoG5k5K2IwWx+fjNyy7h84O367mPB
         OQsF86UksEPPY4Sh1P4ZSyLSwTVCbZ3jQS38T418T23LXvRv7e+UdME1n3tfvxLXGcdt
         pzdEPrGzikzSGyiS9TLLTp/zMatUEZdr1QIuPF+G9jFQ0TQ2QqTES+4pNs8fEOntMVJT
         LulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625797; x=1753230597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmfwBEHD5XzZTAZF/ja/CxWUT4TXnd/eEvL+FaJnMbM=;
        b=a2HLccXMjN/7W/OrJJt+VlH3bZq2M9IbgVmt3FKgQcXMXTU19gmXpaVl+Pq7mF0OLd
         hHi6TDiwk5qmcrta1jahinZUSvfOcg1Dp77pemJ/JUurFrjNlEbd7Pfa4/woaU/ky7Pg
         5sajRGllxY3EOvWAEJpGNgaY20FNtTBKC8e0LnMaBneZCw8NTnCURYQFK8fATE3+lCsO
         1NTGXLdKoDpSDHX+Lyd9ZHGQILDiDj5wsKoME9xvhZcHGRApP7gyM6EY/bX0z2I46Z2z
         CTt8Tf2NbeIUr4bj8LU9Glrpmc0hTU8jIboHQ3a/LwmvMgX+TE4vQcCymLJG1hr8oEqF
         9mBw==
X-Forwarded-Encrypted: i=1; AJvYcCURNL0jG+McoAlRfdeL/CCOnelRhoPMyzousOvsuPUVL5HyvlQuAdpJMkO5IDVNM9C29UMCiN7oMIgH3GUu@vger.kernel.org, AJvYcCV6tD2FcmYykC5xqlDFYiyvDPzHCgpS9PMG4G88oDg/zvSVkbbFaca3L/tZ3HynWih70VYOkHhjFDom@vger.kernel.org, AJvYcCW7IFSAZVM0pOnd4O/jnfcrb0EgIo3cltTVD9ytspddsvuGJe+3N7jheSE1oftNxEVs948t5txF@vger.kernel.org
X-Gm-Message-State: AOJu0YydBLlKIP+IYX2llgwWlwaQSms7ijySRjdOIBZ/NeljaSRDfIiu
	n36a5h4uLJeDQ03/uOAb/GxX9W7Z1vqS7zD+Lk5beevriMYHm7UzAGQ+
X-Gm-Gg: ASbGncvzANI5BS3abAJ8SfgE5xapBm7H/oEyX/pXtNV+vLZBY26OPkMlSpGM9UdrE4z
	yl0cABDEb1jPUqf/SuwXZUVCQax8aehoE/hWss0211MwF81ZqWu5zHRBIDq1J7EgiNqFB9wg+ih
	BdQkT0UWtTXIM115UACuheCsclgKrS08/zdpSemciAdV44JT7waWX2zzdRXwlpkmK2VCjDO25NR
	ughQy5WBZILGwovgNZ0fotnGB0Gip8Ay+mWk/3SYEuf3gLJXzH4NDQBZTPLOhWXMxYuU3xbZcHX
	g3CUCLLBQq9RLu+v4NN3gWdod2Ncit6FqB/h19D9S6BqCeoIXdneNXfnlx4aIzeS+/UVqkgr6qJ
	bQXQW+4YLj4coaJCCnCFYEx4r1mjL0TpfFMR1jdAf
X-Google-Smtp-Source: AGHT+IEId/lysdk98bS0p7XOPZ2jFxsP0iqPZvLbSv6tjaNWGHFpTCiVPIDehQITbNHvZNv2MwVx9g==
X-Received: by 2002:a05:6a20:12cb:b0:225:ba92:447d with SMTP id adf61e73a8af0-237e19630efmr1979168637.9.1752625797409;
        Tue, 15 Jul 2025 17:29:57 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:57 -0700 (PDT)
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
Subject: [PATCH net-next 8/8] net: dsa: b53: mmap: Implement bcm63xx ephy power control
Date: Tue, 15 Jul 2025 17:29:07 -0700
Message-ID: <20250716002922.230807-9-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716002922.230807-1-kylehendrydev@gmail.com>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
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


