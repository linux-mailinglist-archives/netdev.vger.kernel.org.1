Return-Path: <netdev+bounces-209601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8EB0FF55
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D851888815
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59F21C16E;
	Thu, 24 Jul 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFiggIlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707C217F33;
	Thu, 24 Jul 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329212; cv=none; b=G28/PzjLLm1FEAYpVjuc98Y2XPZeYJDhtkpVwufGCN4gOvL7/qRjZeKqT6WDN97hWRN7g76MtyDiBbUO1olPRc0x8sUB1GHCWRIPwMn5WSciNPDLo6tocg4TKXxgZU47EHBpNdtWTg8Dr0HYzaCzD5a+3Q3VNbWa0iACIQMpIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329212; c=relaxed/simple;
	bh=b5exiPper4j3NqPaYMcACUGi6QpRWGD4v3ngfhawrmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJTN4DxmHtCeNi9a0uskaxdHvKPAFCAy6P+C4HcozVkj16OmhUL4XX9cTYNxLUOfzRHMJOc8YTk0KIfjP1FQwP2vNuYth7yxImitApd25eN0ZS3rP9Q3IFtMLnvbb94+BFOv37ZxoTwYdQ5i5gU5KJCPG9Z8drUdYOGLsiHw87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFiggIlI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31d489a76dso645542a12.1;
        Wed, 23 Jul 2025 20:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329210; x=1753934010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC/7o+oTeJeB8efXE3ue0IvOfpjdPkkA7L4afw/mfVI=;
        b=SFiggIlIP3W4Z07mdAlh2nVXzmqCzoBovOTSgGBaa2kPJgJ3osK0/GKDVnAf39rpYX
         erqcyRyrXhbbCqOWVFcZOWXLGVPtNOPG5yqx+JliG8UXtQEiDwgcPI6mq9zE/NCVN0fI
         J/k0+uLGM63xDkxarnTP+opZtMuU6RzWgr4g64Ub5sc3bTVX4f0cIJtdGz1WtaHXnlIg
         UPbxXYBzR5iYmwU9PoljMdz5Q29+IMWFXPhMcviRTg6zRAktk7mtA5/VSLrJTs85USJy
         XaGpO7cnnAZxsS+hmSDfU+YK5PsuGXHUzE4FTe6LSOO52zVBExALqGuIVhhDHCJzXHvV
         GhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329210; x=1753934010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC/7o+oTeJeB8efXE3ue0IvOfpjdPkkA7L4afw/mfVI=;
        b=Vf0kSdTDvhD3VQ8855506OYLR2z/8CzjDH7INfq4qG7iE+inDPp1tX28LgZBLcxzVr
         mnlcy4x7IzaNLUvfvF+ZYLVkuJ+s1Ul8I2pW835EbBAVtNpGib8Xu+BKdpn6Lt5dTwA/
         xlcLPgk3x0Jv/fziSqUpmQPnz2vxfalPPuDRjQjZStwv4lr59kx57laxvBMd0uknY4BC
         Nx2Fu1J26o2d8nLOJSExwMNP26oWc8r5AP+MM+z3k/TFkXEBDUkeg74ti1UD4oW13RP9
         qUn2aK8ILjYV64KoFHx8SUyH8V9t/t+xPQnsq2vUcvzgqtotAO+qLfMa6vz1cGvMvMSY
         qbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB7LHz2pLkDZr3nY1mx4K0jUGyDuf6s5F84f2ECqVWHRVjTWa9KvcKN26ziJ7UAMYOnHry1+M0a4qf@vger.kernel.org, AJvYcCUj8vAhRysj0VVPrWtVZJSCFhuhWpzU6LJiOkwpiJzNOYaLMFoeNPD/FQxYKcrXpZUig88q2j9J@vger.kernel.org, AJvYcCVoKsvhpwc3ZXtmtNJjMff2457U9XKu5Gt7yTubdYjiZur0wS/reihbUF/cLFH7NNvYwHQMCYUtXAhDB+6j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rSLcl02G0PezMIrTJ1Mpk7ZK9WQhzB+joD0tA3G/lZK96OtX
	o8J7vojmxbHw/7aIeD1/lzwMbP/rOp/Zfptdho0YJ0Omih28KA4og6wb
X-Gm-Gg: ASbGncsWtBmX1jnQiGVfbA184RgnYSKydfFacGO2Yx9GB7jCL4AbZbZROo9WuyxnDAE
	KVB/PxA4OiDP9RskqmbEGj7e9rWyBMYQ69QMkxWzDMseUj7JYydDXl2NX23tZp7HmcPPLNS4rZZ
	kMiNcy0FEg1BAs7oVSgOfKIGP1aWJAkqYoLbtI5l7bvM+hIDWQi5zhUSe8TYnLkzv5Gaz8O/rzr
	W81HCRdGJiP0NZhCayeQhxGzAMbyp5ipQq9qaGzf8IpNna8phUJTZZpYjTY6ADj93NbUGH0oNxq
	XBaVaQyYWHBUeJihLe+HwhXhhQIWEqSaFG3HEB6UN15ZqHZu2wdpdQifQA/UWfjkKz/G4xZYZV/
	MBZHJS/bW0a+QJHBMgux9/T0R9pUbdO6X894zHjHG
X-Google-Smtp-Source: AGHT+IHf9jyduE9VW2fwbgBotJDUes+NHHFEWz6q9JsiYfsoAXTIdiHALWoPuDuALz74HnsAFDQROw==
X-Received: by 2002:a17:903:46c6:b0:23d:ed96:e2b6 with SMTP id d9443c01a7336-23f981d24f0mr69035295ad.44.1753329210437;
        Wed, 23 Jul 2025 20:53:30 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:30 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/7] net: dsa: b53: mmap: Add register layout for bcm6318
Date: Wed, 23 Jul 2025 20:52:44 -0700
Message-ID: <20250724035300.20497-6-kylehendrydev@gmail.com>
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

Add ephy register info for bcm6318, which also applies to
bcm6328 and bcm6362.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 35bf39ab2771..51303f075a1f 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -40,6 +40,15 @@ struct b53_mmap_priv {
 	const struct b53_phy_info *phy_info;
 };
 
+static const u32 bcm6318_ephy_offsets[] = {4, 5, 6, 7};
+
+static const struct b53_phy_info bcm6318_ephy_info = {
+	.ephy_enable_mask = BIT(0) | BIT(4) | BIT(8) | BIT(12) | BIT(16),
+	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm6318_ephy_offsets) - 1), 0),
+	.ephy_bias_bit = 24,
+	.ephy_offset = bcm6318_ephy_offsets,
+};
+
 static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
 
 static const struct b53_phy_info bcm63268_ephy_info = {
@@ -334,7 +343,11 @@ static int b53_mmap_probe(struct platform_device *pdev)
 
 	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
 	if (!IS_ERR(priv->gpio_ctrl)) {
-		if (pdata->chip_id == BCM63268_DEVICE_ID)
+		if (pdata->chip_id == BCM6318_DEVICE_ID ||
+		    pdata->chip_id == BCM6328_DEVICE_ID ||
+		    pdata->chip_id == BCM6362_DEVICE_ID)
+			priv->phy_info = &bcm6318_ephy_info;
+		else if (pdata->chip_id == BCM63268_DEVICE_ID)
 			priv->phy_info = &bcm63268_ephy_info;
 	}
 
-- 
2.43.0


