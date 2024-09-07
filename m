Return-Path: <netdev+bounces-126265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105A97045F
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 00:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA9283279
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0416A920;
	Sat,  7 Sep 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgca2a6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF3157E9F;
	Sat,  7 Sep 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747713; cv=none; b=LY6gC5aiOK0TpF00SCISt7pNSYMxbKYMRZ4R4TxLDfYHOm3qJfibe49+hB8zOABUNTXRds7Y7L3ci9VTdVZ9ZmFRJn6n1/gS2LZLr1yNu85X3bpBNCFDdMASsHCgcoyI/Bmd355sG7el2ENBUltE+aYMyG93OluT3tIJZhYAXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747713; c=relaxed/simple;
	bh=02yYXdvDx31Qs4Dj8pQC42UZW21KEG4h3gy4Rhlut7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7scGVkaf5PLiD4/xvEPbwh7nExas/5VOwdIr7Dmz/bFXfA7nH9yAzkjFTUoQiPABi9i5X4B8IInYo2kQtVTyBUbH3SI1FNCy2aQbMT9JbSxSddJMX+g4+IVYG7dNlrNV0obUc9m1GQ9p4PTxaewWEzKNqM/8+HnvXMTghW41IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sgca2a6u; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d6ad6050so1435735b3a.0;
        Sat, 07 Sep 2024 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725747711; x=1726352511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0E/gFh6bgM5JAxun4jikcDPrvGdw7HEaUT/qNC5C78=;
        b=Sgca2a6uJVAQCgavBY1mGRjPBEZMj+ahq2on61yQXbn04mbEmH/PUfGxvtbnRYuWtO
         1QiWs8szC01H3il4TcwfWiTS41Vs8WiWPKkWTM94SAYRNAzv0UdP6aKdKZGA2rkEc5Y7
         P/wnupU3wbA+1GorxnK7RNqedUTuYq/a+XiHyTCq0SrR20wCsMZcJBCeRR5ZlZVW3Vez
         zGNs2qA7/vkjC4HzH6eH9fSF52EM9Mnf+Xr5a8B+Nvqgh95ysfDrGW3JutDzWyzNfGny
         3kz5npmXZlyvMf0QpQmACf9iu6NY3k3Lxlj5WbhFsLseXS79vtslqgCh2hkQphI09KHT
         fsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725747711; x=1726352511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0E/gFh6bgM5JAxun4jikcDPrvGdw7HEaUT/qNC5C78=;
        b=ZBUAkcy2fe4Dtrh5+EsnuHZBsXHEpS1tTihEqWeHeY1HkaZnucU0RkMrjoRx/+pbWp
         Ti2tkI28A1ULtfEg8Y1l/KJ5ijghu8WBlky/bkHEEyEVKjR5pw+CV1+Har3IXokgy712
         PXKHCpvVWBWFUHeaMvZwz/jSNaq/cQxNjqquuMJ8EpJCzcbc3biQCGLXckeaePd94pdw
         tiDq164xmxk9dlG9PRWzg1i/mAv2YlP1qFPGlTop69h/mq5GJUB28G64GNmay1aFNHFS
         ECR53esd8XZhUnMHdSz3hWfzE8MmQd9H1XfvxXYnQekQhMfZ8Bug5SkbJe/MrD58Z6H0
         hgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxSGJEtRm2D2euCowHfmNvDcx/5zVRunZdDiznSGI5PPlM04SuU0pQsbQ88SSkClcNdEr45pftk4g0ZY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3onpKec0ouJnqI+wK1qyCNQ/UoHFzk2KiGDHM2xnKHs6vPBxq
	K24Gu+Xnm7OUe0zYxyyb0UuFbtHSj0Sfoi3qrDQC3bNvJ27oxuvwm8gxNeL7
X-Google-Smtp-Source: AGHT+IFx/TqZURwFbSBWwIWPNoCcrr7MZdj4GmgQ1l4OgP/SKPpo0LUYxkZDv5TiVQcXAWOa6hwkgA==
X-Received: by 2002:a05:6a20:c6ca:b0:1c0:e997:7081 with SMTP id adf61e73a8af0-1cf1d1396e7mr7671240637.29.1725747710802;
        Sat, 07 Sep 2024 15:21:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d860a4d202sm1077198a12.85.2024.09.07.15.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 15:21:50 -0700 (PDT)
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
Subject: [PATCH net-next 1/4] net: ibm: emac: tah: use devm and dev_err
Date: Sat,  7 Sep 2024 15:21:44 -0700
Message-ID: <20240907222147.21723-2-rosenp@gmail.com>
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

TAH /plb/opb/emac-tah@ef601350 initialized

vs

emac-tah 4ef601350.emac-tah: initialized

close enough.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 60 ++++++++++-------------------
 1 file changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index fa3488258ca2..84e2091c193a 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -43,9 +43,9 @@ void tah_detach(struct platform_device *ofdev, int channel)
 	mutex_unlock(&dev->lock);
 }
 
-void tah_reset(struct platform_device *ofdev)
+void tah_reset(struct platform_device *pdev)
 {
-	struct tah_instance *dev = platform_get_drvdata(ofdev);
+	struct tah_instance *dev = platform_get_drvdata(pdev);
 	struct tah_regs __iomem *p = dev->base;
 	int n;
 
@@ -56,7 +56,7 @@ void tah_reset(struct platform_device *ofdev)
 		--n;
 
 	if (unlikely(!n))
-		printk(KERN_ERR "%pOF: reset timeout\n", ofdev->dev.of_node);
+		dev_err(&pdev->dev, "reset timeout");
 
 	/* 10KB TAH TX FIFO accommodates the max MTU of 9000 */
 	out_be32(&p->mr,
@@ -85,61 +85,44 @@ void *tah_dump_regs(struct platform_device *ofdev, void *buf)
 	return regs + 1;
 }
 
-static int tah_probe(struct platform_device *ofdev)
+static int tah_probe(struct platform_device *pdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct tah_instance *dev;
 	struct resource regs;
 	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct tah_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct tah_instance), GFP_KERNEL);
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
-	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
-					       sizeof(struct tah_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+	dev->base =
+		devm_ioremap(&pdev->dev, regs.start, sizeof(struct tah_regs));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "can't map device registers");
+		return -ENOMEM;
 	}
 
-	platform_set_drvdata(ofdev, dev);
+	platform_set_drvdata(pdev, dev);
 
 	/* Initialize TAH and enable IPv4 checksum verification, no TSO yet */
-	tah_reset(ofdev);
+	tah_reset(pdev);
 
-	printk(KERN_INFO "TAH %pOF initialized\n", ofdev->dev.of_node);
+	dev_info(&pdev->dev, "initialized");
 	wmb();
 
-	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
 	return rc;
 }
 
-static void tah_remove(struct platform_device *ofdev)
-{
-	struct tah_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-	kfree(dev);
-}
-
 static const struct of_device_id tah_match[] =
 {
 	{
@@ -158,7 +141,6 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove_new = tah_remove,
 };
 
 int __init tah_init(void)
-- 
2.46.0


