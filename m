Return-Path: <netdev+bounces-199782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEA2AE1C6B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2847A40C1
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489B2989B3;
	Fri, 20 Jun 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2QTAdM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27A298984;
	Fri, 20 Jun 2025 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426934; cv=none; b=U6P03cDTSphzaTf87niYbMYky25dExbukG0RWswHICR6Z7aJ6G4Q5JDykIIRI2QObz69uatL+gMcb7u44AFdVy6kJYw2DN1XWX6s7CnsQ1aEdErgJmejNhAKPgIfHcBVSahgU967N8vns4VaX2emDFrK5Cr8pG/T5GIvjQ31duA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426934; c=relaxed/simple;
	bh=ABFeL1LM48SG2ww/d54d4OPabMjG33GrF1JFouQGUJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4tPCt4n/YXXXStLuuIXqnMuwHb/Tpl0NuHbRgAj9oFa4FuUzyy1D5MeiAqXAsh2zsTIgetLYgM6+/aCKqfcUwZtctSUluEKp17R1ImimY/h9RXS7wyEOja/5sWLjoCYpXxygrKovKpcDQ52MHDzcXkjgvcUVTS2wWgztY6F3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2QTAdM5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2366e5e4dbaso15179345ad.1;
        Fri, 20 Jun 2025 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426932; x=1751031732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KktFXTrDVATNNZzxTieALU70Rf6coIugRNl40iZdiyg=;
        b=f2QTAdM5wxEzkL0ZID6NYT9oym+EqM70jaemX3ulI/Rn9ntiPgw5OWjFBTe3lKvWCb
         3a21hECs7XQ1uybuZote+senOr1qGAKQrjG/wVYG+gQ4CEAW4+pOwQ2QLWLg4u1sHx9p
         Nbe+4kSBn9hVNjedIJJpOTYbg1cZVA/70eKmaVleldj1Xx1HRYHTkoCz4ZuGAVQeYRan
         Z8PFjhQXJ+OSqOXMpprCoIZxKyp8w9BEMGAwnXlYuiCT67r16Q5W8nAHpF87XUW2tVql
         1Z1KU40OkNmU0kEN3WCWrlI3gYB8v77kGUbRiva6t7JVRCWsAQmJo9Xb9JHZvHX+4G+S
         Qeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426932; x=1751031732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KktFXTrDVATNNZzxTieALU70Rf6coIugRNl40iZdiyg=;
        b=VK13cBCSQFBRHAbW3k31u3m6pQKgv/P2hIkBEW3G+96eCvDXT0DMQmyi19Z9heKtk1
         So44b9RoW2JweP6BsQOlFR28cg2sLZbk1/xYte2g5y5Hq1nbKW/hRYU4H6xxxse6DEP6
         AiXHqA5QSGd+fNsPPlbet+Yv4HEO2vHORyzallcQM+L95CF5N+qka0h719Zi8ZAhynCi
         +rxNMVjqOXia/WTjG321zlNmXY/Z3edNFvTzLg8BEZ1+2AMqcWWTlOhZ9IcznSCh0LZ9
         Q3MVTmUwwApBABYRKjX5vE/WN+nUgNVfPS4q4FdDQGaEpfeyrZ0iMBXyj8u5urncslSG
         m/hg==
X-Forwarded-Encrypted: i=1; AJvYcCW56cnOdlsnX+VkA8pGM8zU4lBVP5eojliI5CQqSw5PifuCM0p5UWRBtCLLp5yafP8X4pmoaXd5@vger.kernel.org, AJvYcCWZzcaxqIuXG4J2uNNSOaX7dlyp8urYfd8Wi2i6AqVGgVMzQ9rkPo7VrOOnZWuDcBo1GYRcXjnO/Hdm@vger.kernel.org, AJvYcCX392xIumfrW78am0pE7XJxvj3L9nBnepKAFnsd0NOZToIU96CFNQx66WmpzpZUsB55tK24nZ7iBfxcyYPg@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnMFSHB/oQwMjQexeBztAsNZyvcGienWMbW16h7wEuv8m06fY
	nZ7UPhR2AMbf4xdtl3zRqMAYjkrLji999DCryM0Vg7/rHrxgOzYvu3CF
X-Gm-Gg: ASbGnctkUYsY7vIhNTscYyGEtGiCUOmNQutIyRdBuocxfcS0NFl7D7BfLYFw/5EPc3m
	ox/61hdPPLqXX8dSemOXnphTqjN4kmS1t11BuwAnilN8pfNoNIa8tOe0SU+/ycKSXImILpUDigA
	mLyYjuQSQerpgZtvlxeNU6pHx0nTnoCy2OjOQEu8uNlZq5L5+H/tEhw14chGkgzMEHriUJJEX7H
	AtOs4cbco+qJoRpTiA7Zhsyl0rOlnStPfB4tvImilXEsuCYD/xNqnQs5fH8lS8V7PAX+URBUzLm
	loRDXRZxm/Ii7ec4MpTP/A7rWakXAxIpdO1dCa68wepwKhZDMfCOg+HE+FGmLXHEICjXi2HUQXk
	3iK08A4nVmvOLwIg=
X-Google-Smtp-Source: AGHT+IEkfNpDp8DfTvJe/U+wjjEbT3Li3d9mEcyRhJ4Nu5pG4ryaYXiA26GJsWY6pgmLirClvvdUNw==
X-Received: by 2002:a17:903:1a90:b0:231:9817:6ec1 with SMTP id d9443c01a7336-237db09947cmr43638435ad.17.1750426932199;
        Fri, 20 Jun 2025 06:42:12 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:42:11 -0700 (PDT)
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
Subject: [RFC PATCH net-next 5/6] net: dsa: b53: mmap: Clear resets on bcm63xx EPHYs
Date: Fri, 20 Jun 2025 06:41:20 -0700
Message-ID: <20250620134132.5195-6-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620134132.5195-1-kylehendrydev@gmail.com>
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the ephy resets aren't being held by setting
lowest bits in ephy control register.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 1bebf5b9826b..a4a2f2965bcc 100644
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
 	u32 chip_id;
 	u32 mask;
@@ -253,6 +256,14 @@ static int b53_mmap_phy_write16(struct b53_device *dev, int addr, int reg,
 	return -EIO;
 }
 
+static void bcm63xx_ephy_reset(struct regmap *regmap, int num_ephy)
+{
+	u32 mask = GENMASK((num_ephy - 1), 0);
+
+	/* Set lowest bits to deassert resets */
+	regmap_update_bits(regmap, BCM63XX_EPHY_REG, mask, mask);
+}
+
 static const struct b53_io_ops b53_mmap_ops = {
 	.read8 = b53_mmap_read8,
 	.read16 = b53_mmap_read16,
@@ -345,6 +356,8 @@ static int b53_mmap_probe(struct platform_device *pdev)
 				break;
 			}
 		}
+		if (priv->phy_info)
+			bcm63xx_ephy_reset(priv->gpio_ctrl, priv->phy_info->num_ephy);
 	}
 
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
-- 
2.43.0


