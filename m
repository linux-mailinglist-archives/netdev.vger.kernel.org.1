Return-Path: <netdev+bounces-130523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC5D98AB8B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11691F239C8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EB19CC06;
	Mon, 30 Sep 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcyHRdMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325119B5B1;
	Mon, 30 Sep 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719254; cv=none; b=QaQQG8kww1ooWK0297rhMZNA/VTkIzPqSOfmjNJEsQW+AnttR6QsZSawZw3DNnK5V41xorPUvNPeAOxS1ADilnm2ANr7N3wH4LK9HNJgNd/ER5TX00gk/Til15G+4UlpvTILJjTkuyZWZ2BVOmkV5EM5nzuPCdEq+V1A2KwwK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719254; c=relaxed/simple;
	bh=A8gJS6fEP9QvIScx57iYcjbGzw0KGh8cHqIn3dIOJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+ia8aFlhhfIT93eEewSympeuCxLP8lmYYiBtXrACl7B4/tE6k/M45/couBgjshmiBP6fRVDR50133LHnIcQzfi8gUoks3mz9SWlduqNPv1ngVnWFKrK9/fbgwDDqOUAMZ/C1KbDwdliubmomKZ7sIHFwDSWXJQyAuqoV3iLWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcyHRdMH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db908c9c83so2872978a12.2;
        Mon, 30 Sep 2024 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719252; x=1728324052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=LcyHRdMHm2y5Y5Vyn11uVTyLxLikbAluZ1wsVHvS4PZ/02OVFjKATXeFrGYBrCoWXH
         zmbCR9fKNjPcgxFjllWRTTeIU/Z6QP2h3EqvO0Ph7obYPZqTmX6/oQnIXdSfCm+KlgxA
         aTU61ZwR7ZFwyHtYQ5iGkJ9l3PwRBCEl3SzXh8dPkZyHytV9jvz9omsjU4WpqOPItqSc
         WR2im4lSNyx9EkTonISIXi1PWwSZcLE4yv0auyYDI9cQ0SUpxc/8hJz472RNXGK41aDt
         ppNuqBYnd+MrDQgZ256AnfW18h5vqrCTZKaz/nP1EQBdkbDk0JjBbuZLUfodr+6mxJPw
         jWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719252; x=1728324052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=jxwbaraO96Y/ho/ZEIEdnljYyhTdF5HQLvQ6HPiT5XI5scyAnFMlgKxhs976biqNoh
         LJgwfR2yYMJsJhlDV5VnW3AyWP2IYUz2h34raU+KLE7zDvb1wu2dBc5h3cntqkU6b2vn
         bjv3gyEt5UoJdTmkmwKzgfLDgTztY8ATZsHKwV6KsobyYXMk7JO/bTsMfPfEuYoGZ9bG
         9vByenD7fpEOsQs1nquGiqf0S/H6fxGpIPR8H3WU8eqxXxslY9V7yoy4S2hd5rPhYdu8
         H5PeFhQPghQj+Vi2tiUxzFqIhww/316w5+GpOQSCVU3fp333n9m8HHwMG5Xa1hsIG84I
         dy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFaJlA7ZLeV0hUjbHWzSrBkvnfi7/tl/MArjfygtmEvBCR0p59GWVPuLFNYxVObNQlhCBaDeLeOJnfYZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiLk1rRXaoRnbQ6pTO50JoLq08n18osbas82vbSyYuW12B0UO
	W2gP8N8XUE8Srk57nb7aNkXPvMWHLUQf6cyZTPPQUSs0PZuGQwJcTSm2lZd5
X-Google-Smtp-Source: AGHT+IHX2MC+Oa53W5Q5flWNCIn9dgtjGOXK4fqIPn33LqTIPXsl4Vu8cc1Uf5Q+tTXyK61lFXVvbg==
X-Received: by 2002:a05:6a21:3406:b0:1d4:f6c4:8e7a with SMTP id adf61e73a8af0-1d4fa7ae0e3mr17066023637.31.1727719251899;
        Mon, 30 Sep 2024 11:00:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 08/13] net: ibm: emac: rgmii: use devm for kzalloc
Date: Mon, 30 Sep 2024 11:00:31 -0700
Message-ID: <20240930180036.87598-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by removing gotos.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 52f080661f87..8c646a5e5c56 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -219,28 +219,25 @@ static int rgmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct rgmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct rgmii_regs __iomem *)ioremap(regs.start,
 						 sizeof(struct rgmii_regs));
 	if (dev->base == NULL) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	/* Check for RGMII flags */
@@ -266,11 +263,6 @@ static int rgmii_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void rgmii_remove(struct platform_device *ofdev)
@@ -280,7 +272,6 @@ static void rgmii_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id rgmii_match[] =
-- 
2.46.2


