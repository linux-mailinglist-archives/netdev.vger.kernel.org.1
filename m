Return-Path: <netdev+bounces-131053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4698C723
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFBA1F25BC5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604A1D014D;
	Tue,  1 Oct 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO0rBQNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456C1CFEBA;
	Tue,  1 Oct 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816342; cv=none; b=TbSscmykhoILSWmiP6/nvGpxfidP33UyYXH2dMJ0I1iSERiJ6S3YSvdPPy8o1fprQHe7TnfSH6RbvxEHxZaThGZxOqULKcsGhEr4KO7pzWEP+TTPkX6VZVAaVg1Jw3avteygvoQa920eQj4UchHmA5Fh7s4+fQjJSfN14cGLz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816342; c=relaxed/simple;
	bh=A8gJS6fEP9QvIScx57iYcjbGzw0KGh8cHqIn3dIOJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8ok74GHnMeDhuNB3m66LJ1v7zwZBDDWtSKhEGICLxW4PVB3S/qemplsjwr2GL7xF/NrOgMJTrcWNf0DmFbohhtxYlZy4qrmMdlPGFdKaYYGtUvFyBgLqVLkRq98PHoh0p/XdP1A9ht2YW/8dkt1DKtXqUuS7GFQ5VL2cVo1zCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO0rBQNA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718816be6cbso5081560b3a.1;
        Tue, 01 Oct 2024 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816340; x=1728421140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=EO0rBQNAcDfLplKQ8xS6tMw93MN+4WT+UsKEe0ImAtMbTvNbuxNGDj4cr8F7JP+9Uw
         jQmlVOQ6NkKDWFBf5muzZUZBOCT09COLzNndaumPbYWMAgmx2/urqv1xrSCRavtPRQxv
         0qTaX2IKKIq/R3Il5MM+9gKGNW96jqHenHr82lPxsBkv6scqFxucXEgMgHlExUkKGcAk
         bDBlBPG0WC2SAsM+olMBga8BI80xfcIt2q55A7LDAweaUBWC2g9upA6BRVuaHDJsNfEE
         1W+qJnThnyg78qXBN6FAqS4fCu8IeBVms7CVJ7esxgv6FkO/uwoaFqgfgIyiGV6pn2WG
         t6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816340; x=1728421140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=ThMMKbgZQUAU4KzqekZx1ulhW/J5ZCRh6ZBjtchDZQm6sqVe4DB0VotSWR3aT6U5TT
         IpzeOamsfEZdtlOn9Of1Mj7N2PhmZ2zuhonI6qBOIVjrTKvErGaz92VBiE1sTmBrwHRx
         cBhpoW1kGk23HmWT65Oe1H6YGEnczyPjvwhPftnQqwllCon7jmi9T9Tsh6QWaLmWDS9i
         bmE57lHuKIzAB9AjdytrLfiAFxa8Doj4IYKiqknkQwMbHMc3rh9LTBHoOLIueDc0EpoL
         gfvhoYjCDHotZAklhXo6gKMb1TaukiyqXsSmSXgtCO/Ogmj0araIYiSuFr/phU7A/D1o
         No2g==
X-Forwarded-Encrypted: i=1; AJvYcCXx6IeoL++AAIzEUy5KPDKbiYuSvAVULhcWPpY/UXW/YA5J80kjLKFXf88jeSOZVACjnanHWnGrx4xxjb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4BUIOtkY6ZBcsNBx0vjX3F2f8RWAVj660HlIzQzEq6/spyRl
	UUP4M+ZxhSuOwMjk65gGNI5N2t7qdcB3EZwJtT4zLJiHbVXCCnecyMnFBM0g
X-Google-Smtp-Source: AGHT+IGxV8yw8dGy1HxC4vZs8LyHRKP00v2LFKwzT1j2din20QknoSxr7++3F2aJ3Bo49+gdJv6akg==
X-Received: by 2002:a05:6a20:9f08:b0:1cf:32d1:48f with SMTP id adf61e73a8af0-1d5e2cbf20emr1291574637.36.1727816339704;
        Tue, 01 Oct 2024 13:58:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:59 -0700 (PDT)
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
Subject: [PATCHv2 net-next 09/18] net: ibm: emac: rgmii: use devm for kzalloc
Date: Tue,  1 Oct 2024 13:58:35 -0700
Message-ID: <20241001205844.306821-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
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


