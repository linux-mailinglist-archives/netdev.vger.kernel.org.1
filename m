Return-Path: <netdev+bounces-145401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6539CF642
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CED1F25008
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1B61E32AE;
	Fri, 15 Nov 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP0iidqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F01E2609;
	Fri, 15 Nov 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703316; cv=none; b=cI97Gd5RNZ9V2p/XI0QdRtAJL+KoiQK38YZbHFW/nc4DJF3n+DLI51Phm1IT+H732yvnjnwp2HJK8EaSYdlRuo5+6xHxSsP39OY6GHljw2uYkd+fsTxgQFbnor/qw1e6AD7/BrBJ+a3kederxu3ZrNggL2FMMJ6ISCZOochKUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703316; c=relaxed/simple;
	bh=XL14k83axPDHYcjLckdEaN0RAzq7HGpUmxCP8iY2EFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkLJuW8yIiVA9O33j2y+w7S3v5tkQvK6dzIVquzimN+cOJ4OYvib3JQiscqmKhZ9ZPLbsWdx6QUNkB8a6i710v68qW6erjRN3weNXeiotOtyAOnlkqAxqWXs4BT8zKgrU458JjwFMr2zo1WwGl0eX7jgsdeGal6fsSCUHITahEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP0iidqT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724455f40a0so1566080b3a.0;
        Fri, 15 Nov 2024 12:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703314; x=1732308114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRRatnkW2FFvyyS1UCowv2cxjzV8z8dktdXmCRcfyfY=;
        b=BP0iidqT2bCCc8hkZz/lk4C2/+6HY7EqBwiS3qM4P3xGgXpt1I2Ks6Apu6iQQaT6z2
         86YndpvzlJAJziFxM0zhyZSZcw6h+gs/bsxqo1QjiO+eSvw3g4S4++rpQC8MVWEktNJh
         OtULNZuL1NFd9h0UNhDok1X/jG9XEVyiy/DXAUMmfxgeve0raR1tJQCXjW4d6nuQIjx4
         91NK0yH+R4mOQnxqtsFfmG6/2g9RxYhw4pFX/T4zwIYsrBbjUNfM0PHXT65SsOm3PWo9
         rMBBCS898VWdnjPkk60eu/9mv2iIag6UTWF80sMcRXXrifCm3Jm0T/pj0ilO/FnmefEM
         zAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703314; x=1732308114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRRatnkW2FFvyyS1UCowv2cxjzV8z8dktdXmCRcfyfY=;
        b=rpLMMxEuQg+/AAW4uOzRO31ZXyUg7WN1naEYBcbFxxJGj7qgKd2DQR0FXOhR/U42ka
         SA5pjdipmo/zBJlalIRZ2M+f+Wa2MakGRi6sYhoz2Xv3/3F7zrie+C79kFIT1INEx7up
         AQeBp+YVw9xkbhV50/VgqJFFOiFwxNuZcFmalC6lEpiIhu/8GiiMv/Hsb6aFGemjIlVc
         KSKAhRAZaT0290hIt31xmgL9GevsaCfnygc0X3y3BclZguwr8/OZSLVddWlq/WrXuD1A
         XKFxxmeVoSy4vcuRaRpDBi9H95lETUYbFgY8R2nbt14rmbRvDOzkxkcw2TpVwbBD0UnL
         uawQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+YkH/RLPojFebXydOR4KecZtb+k6y6DltrCq845PrWdpUrZAT+gRAC5d/LExV3TcoFQYIDHncoIgNII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+16kT/jiJcfEjFxuT5dKIHtJr1lj8qRyylyYgo0ioBOKANE3V
	K17iWMLWzlyYTM9H5Z24Jd1lrzVn1dUcMm/xFD0OQI83ltVwBsPt2ufY9dV9
X-Google-Smtp-Source: AGHT+IHCks4beEhpK3bGBqpmHNgrf7UAru2wqyqk5/Honu4yiUlouf/8lwjaEMHWioI2Mf4QsVKqJA==
X-Received: by 2002:a05:6a00:885:b0:71e:786c:3fa9 with SMTP id d2e1a72fcca58-72476a0cda4mr5059170b3a.0.1731703314091;
        Fri, 15 Nov 2024 12:41:54 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1ffesm1782744b3a.155.2024.11.15.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:41:53 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/5] net: fsl_pq_mdio: use devm for mdiobus_alloc_size
Date: Fri, 15 Nov 2024 12:41:46 -0800
Message-ID: <20241115204149.6887-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115204149.6887-1-rosenp@gmail.com>
References: <20241115204149.6887-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using devm avoids having to manually free. In the case of this driver,
it's simple enough that it's ideal for devm.

There also seems to be a mistake here. Using kfree instead of
mdiobus_free.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 108e760c7a5f..d7f9d99fe782 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -423,7 +423,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	new_bus = mdiobus_alloc_size(sizeof(*priv));
+	new_bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
 	if (!new_bus)
 		return -ENOMEM;
 
@@ -437,17 +437,15 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	err = of_address_to_resource(np, 0, &res);
 	if (err < 0) {
 		dev_err(dev, "could not obtain address information\n");
-		goto error;
+		return err;
 	}
 
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
 		 (unsigned long long)res.start);
 
 	priv->map = of_iomap(np, 0);
-	if (!priv->map) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!priv->map)
+		return -ENOMEM;
 
 	/*
 	 * Some device tree nodes represent only the MII registers, and
@@ -502,8 +500,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	if (priv->map)
 		iounmap(priv->map);
 
-	kfree(new_bus);
-
 	return err;
 }
 
@@ -517,7 +513,6 @@ static void fsl_pq_mdio_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus);
 
 	iounmap(priv->map);
-	mdiobus_free(bus);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
-- 
2.47.0


