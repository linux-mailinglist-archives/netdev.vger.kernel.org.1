Return-Path: <netdev+bounces-126266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23662970461
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC1283215
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407E16B3B6;
	Sat,  7 Sep 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXj9qwVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402416A38B;
	Sat,  7 Sep 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747714; cv=none; b=tn+GmYIVqS/3mkkun8TpeimZyjhPUSrAZ86lVYBSBwI0TItN6hreumTmvcVwoLtqZ2BEX2zP4bOiGNnPz8pKQ/sZfUcXkYPgVUzlfC5J1MClYLqadyRuWNT7bf2Nz4eeHgOL0OLRlXH4WFjOgN0v49LIBIOv1UxZG+SVD+/qyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747714; c=relaxed/simple;
	bh=2zBigd//G5iO+BesE7TX1KWH9iAckaNRR4Wz2TbMkUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFW/2RuznbEeSU5vyQV921RT405TXjP0kp6LkxU81+mGR9SmQotvBa4YDC9ZWABUmIwVb+rRY8NsVBav7iEHgkSm+Tkc3db3oC7fE1GbH9VgnTJhsItdZ6GiJiOx3y2x+0Rp+tgrqGxkcbB3PbMYzZm34HAVIzdhaTcIV0lBNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXj9qwVQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso2491132a12.1;
        Sat, 07 Sep 2024 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725747712; x=1726352512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6aKpbMa8frBMXy12QNcNTsich8eKSzF/iMdpWXYNc4=;
        b=IXj9qwVQ8ai/Adoo1nNhGMHBM0sVODXzx+xk8IQUchlh8gJccpz//eI1nF/K3yQ6we
         iu5cDNeWp/gIQU5NariWKrmhSVou2KnstlNX6f2giKJM3YJcT8VwqfJ4vnlNwWLtPT5Z
         ujSgU/mfELifHMM9O2oJA9jh3o9ZhVZEuckALq4501YIANVrLiYgmqN83/Cx7K+Oasua
         llHYvsa+OyPWdMV0WCK7DnHYcNJ5GJN+Cpsn+yRNPhoKZmZjSJiTAMhCsLZq5J0YOyyC
         erL7f6HOyaKhPyRb1Pqj7kfxschi2Um9w3WzQ/CfpbBY/F3u+GO+XZTMI80O2qs9Nx8g
         3+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725747712; x=1726352512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6aKpbMa8frBMXy12QNcNTsich8eKSzF/iMdpWXYNc4=;
        b=rY3i0EHH3Ztqby6W1HMK0/eSW/aaF2P6WvYvePZ75lDfz3OGvNguCF7fDcisZw0Jcz
         mISJDwqDYWr9CxWRvjqOdfZ470hvclhTwAuskr9eZvYGDGyRFXPAw1NlexK3VVHmSglQ
         700PX/fBdgh2P5xxJfEsn4Cil4fVeqslUl2Ss0IQvCSij/1GkFioqMuV1rwG2UcR/PXi
         ZOGxELva9OAMohbVXzpM/cCCm5NH/AD93SRXx0WO/6sNfyn+ZRRYZRC3bO3uB3rYCDV8
         hJilUqGd0PNSja5XIQ6uIgAiR1wx1mD2PXizo3d5I7s6wgH6ni59NKLJFTYmdeiEIygV
         6hZg==
X-Forwarded-Encrypted: i=1; AJvYcCUaNewEM0gj+7Mlrez983DpZRq1OzQXnjJ8guQkxdJfY2AyCaWkxrNcGn/m7jVku0qkSuD8I/KTvezFzuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iTyhM4WBKd5Be7PTdqCPk+Af0iPQPJAgBo4YXiKjfzr1Ri8W
	+SjKa0TkJ+ONq9r4zoGWI2cLse3V0DKUK2/8llJV1YMFeqku0Cc5E0omx6Df
X-Google-Smtp-Source: AGHT+IFCeoo/WZzK9Sa6bTj4f44C1IwMZFEVD/gvOjmu+FlktDh/R/BOCJ4sym6MpTalk/xZNyZ7Bg==
X-Received: by 2002:a17:903:230f:b0:205:9112:efea with SMTP id d9443c01a7336-2070a578bdemr31392565ad.35.1725747712312;
        Sat, 07 Sep 2024 15:21:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d860a4d202sm1077198a12.85.2024.09.07.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 15:21:52 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] net: ibm: emac: rgmii: use devm and dev_err
Date: Sat,  7 Sep 2024 15:21:45 -0700
Message-ID: <20240907222147.21723-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907222147.21723-1-rosenp@gmail.com>
References: <20240907222147.21723-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the driver by removing manual frees and using dev_err instead
of printk. pdev->dev has the of_node name in it. eg.

RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support

vs.

emac-rgmii 4ef601500.emac-rgmii: initialized with MDIO support

Close enough.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 76 ++++++++++-----------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index e1712fdc3c31..bcf6b7d0dcf9 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -77,17 +77,16 @@ static inline u32 rgmii_mode_mask(int mode, int input)
 	}
 }
 
-int rgmii_attach(struct platform_device *ofdev, int input, int mode)
+int rgmii_attach(struct platform_device *pdev, int input, int mode)
 {
-	struct rgmii_instance *dev = platform_get_drvdata(ofdev);
+	struct rgmii_instance *dev = platform_get_drvdata(pdev);
 	struct rgmii_regs __iomem *p = dev->base;
 
 	RGMII_DBG(dev, "attach(%d)" NL, input);
 
 	/* Check if we need to attach to a RGMII */
 	if (input < 0 || !rgmii_valid_mode(mode)) {
-		printk(KERN_ERR "%pOF: unsupported settings !\n",
-		       ofdev->dev.of_node);
+		dev_err(&pdev->dev, "unsupported settings");
 		return -ENODEV;
 	}
 
@@ -96,8 +95,7 @@ int rgmii_attach(struct platform_device *ofdev, int input, int mode)
 	/* Enable this input */
 	out_be32(&p->fer, in_be32(&p->fer) | rgmii_mode_mask(mode, input));
 
-	printk(KERN_NOTICE "%pOF: input %d in %s mode\n",
-	       ofdev->dev.of_node, input, phy_modes(mode));
+	dev_info(&pdev->dev, "input %d in %s mode", input, phy_modes(mode));
 
 	++dev->users;
 
@@ -213,76 +211,57 @@ void *rgmii_dump_regs(struct platform_device *ofdev, void *buf)
 	return regs + 1;
 }
 
-
-static int rgmii_probe(struct platform_device *ofdev)
+static int rgmii_probe(struct platform_device *pdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct rgmii_instance *dev;
 	struct resource regs;
 	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct rgmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct rgmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
-	dev->ofdev = ofdev;
+	dev->ofdev = pdev;
 
-	rc = -ENXIO;
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+	rc = of_address_to_resource(np, 0, &regs);
+	if (rc) {
+		dev_err(&pdev->dev, "can't get registers address");
+		return rc;
 	}
 
-	rc = -ENOMEM;
-	dev->base = (struct rgmii_regs __iomem *)ioremap(regs.start,
-						 sizeof(struct rgmii_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+	dev->base =
+		devm_ioremap(&pdev->dev, regs.start, sizeof(struct rgmii_regs));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "can't map device registers");
+		return -ENOMEM;
 	}
 
 	/* Check for RGMII flags */
-	if (of_property_read_bool(ofdev->dev.of_node, "has-mdio"))
+	if (of_property_read_bool(pdev->dev.of_node, "has-mdio"))
 		dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
 
 	/* CAB lacks the right properties, fix this up */
-	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,rgmii-axon"))
+	if (of_device_is_compatible(pdev->dev.of_node, "ibm,rgmii-axon"))
 		dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
 
-	DBG2(dev, " Boot FER = 0x%08x, SSR = 0x%08x\n",
-	     in_be32(&dev->base->fer), in_be32(&dev->base->ssr));
+	dev_dbg(&pdev->dev, "Boot FER = 0x%08x, SSR = 0x%08x",
+		in_be32(&dev->base->fer), in_be32(&dev->base->ssr));
 
 	/* Disable all inputs by default */
 	out_be32(&dev->base->fer, 0);
 
-	printk(KERN_INFO
-	       "RGMII %pOF initialized with%s MDIO support\n",
-	       ofdev->dev.of_node,
-	       (dev->flags & EMAC_RGMII_FLAG_HAS_MDIO) ? "" : "out");
+	dev_info(&pdev->dev, "initialized with%s MDIO support",
+		 (dev->flags & EMAC_RGMII_FLAG_HAS_MDIO) ? "" : "out");
 
 	wmb();
-	platform_set_drvdata(ofdev, dev);
+	platform_set_drvdata(pdev, dev);
 
-	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
 	return rc;
 }
 
-static void rgmii_remove(struct platform_device *ofdev)
-{
-	struct rgmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-	kfree(dev);
-}
-
 static const struct of_device_id rgmii_match[] =
 {
 	{
@@ -300,7 +279,6 @@ static struct platform_driver rgmii_driver = {
 		.of_match_table = rgmii_match,
 	},
 	.probe = rgmii_probe,
-	.remove_new = rgmii_remove,
 };
 
 int __init rgmii_init(void)
-- 
2.46.0


