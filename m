Return-Path: <netdev+bounces-126267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1F970463
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 00:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21A41C210F4
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3916BE04;
	Sat,  7 Sep 2024 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz5lHLxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5216B39C;
	Sat,  7 Sep 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747716; cv=none; b=P7cHlPGyqotcaQuaRSVMSnIT2Xyz2kmL+whoXFQrh2lydoo3DE6meI2tnigoM3gzOo/UeD7QLQAvk8ifYC6q6mGSUiG+5RHIW5zH2V0Ohnbl1HSmH3vJAf7v8ROMchtXEWljheF/Ld6MqEKWkO3mQBJaoJLDx6QNZRCzk1Omrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747716; c=relaxed/simple;
	bh=zascTxCSTeDJYFuG2ES4XtW1ZqJ6eDTFndx7BFMyFCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqxbsaxki3idUmkcdDjitVuY3ESvKkDIVNPXaBp1bpjOfLERHCrVY0IAA7y8n5oJGO31iFxRELh2KVqEb5sTK9XCsCFrVERXtpub+nm2dLbeQh8ZuAIQo3NQNjs7+mk3rMGFxBH6AkKXPIIfvv/hZCFUM1y/JWJrucO6Fcucxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz5lHLxi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e11e4186so1166335b3a.2;
        Sat, 07 Sep 2024 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725747714; x=1726352514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P7s/b/ONveiPzs1KvreGYULcOsjJGg/ShVezWj3vsk=;
        b=Zz5lHLxiZeNDKUzolSofjdEnM5nistw7GSYJsefNHrD5MFhkfSFstk7wbVjHH3Oa9D
         aUmZPilSt1I1asTks8CwFwN/hx3dxh2vdOUXe0TeKW4kNnFRlvJgbs88N9wOXsDlmkF7
         nH9CfLcwbxkw01HcjGWDiubHEeGr0ZDoq8o+pGhmRozxL5xCQqZG7977jRXyASGxSvoY
         Rt/ekphI3EeKb02q24KcP6P7PRZGcbkkWylp2n62V6LtW5A5XBy7J3kwpyD2qX84/JP1
         b9J5CIUca4AO5CvWIVO2k7NV591p4jGK5dg1M0DLAzDyeYOwSA5ecaK4d84BJtSl4uo5
         DJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725747714; x=1726352514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P7s/b/ONveiPzs1KvreGYULcOsjJGg/ShVezWj3vsk=;
        b=ZcetU3/UMORgdb1yJzn513YrdlUGIEx60AJ7UEltJWYRYQyxc4ae8A3tNExWZtXB5u
         JIYKF+Bl06EwP1rR4RiqlZ2BbVwHXnfH76yX3GdGAe27g6KNACU6nMxvDXeiBtSJdDnQ
         RxsrLbM4SM50JOBx1wYSal+gXHLWUzSxLa5iP5TiMuowYlDcwXQF/lcggkjrbcX0leCC
         pH6b5eE9bdVgq57qGql9J8JHn05ywcuzoNaFREvn8jaDcek2Eph3pH3iw5o+uvaZEUFi
         0R+LSniv8pPm1Q7Iy/fdGldlmqOnN11YJzNPcIub2ZBUpIOqx3lILyxZmcXP3i2R/lgy
         TPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQDZfo+6leAO5RO1T2oxqwWz5o2Cy1T55ARVJQEW3Ps2sZ3uZw32+OGUo5vWv8KbVQXvQ/QNiqAPm9qmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+sCljPn4I/Zb2jmbDAZmrusde9hIYvTf4vnq2TqKzTKUF8TE
	KP5ES+hfNr+nRehSoG9SEEBrkJlZEhoDJR3cboX0ARv1o485z90lP7UsvJrj
X-Google-Smtp-Source: AGHT+IHtaxbB9xjXF+OsFijtRXgkWnvRTxJ3PuzLwTtvoERC1BWc1GnySDL6YyR4Y/QxBqCr5amjdA==
X-Received: by 2002:a05:6a00:14c6:b0:714:2533:1b82 with SMTP id d2e1a72fcca58-718e3455a65mr4888316b3a.23.1725747713742;
        Sat, 07 Sep 2024 15:21:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d860a4d202sm1077198a12.85.2024.09.07.15.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 15:21:53 -0700 (PDT)
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
Subject: [PATCH net-next 3/4] net: ibm: emac: zmii: use devm and dev_err
Date: Sat,  7 Sep 2024 15:21:46 -0700
Message-ID: <20240907222147.21723-4-rosenp@gmail.com>
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
of printk. pdev->dev has the of_node name in it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 53 ++++++++++------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 26e86cdee2f6..1e6c3169ee4d 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -230,34 +230,33 @@ void *zmii_dump_regs(struct platform_device *ofdev, void *buf)
 	return regs + 1;
 }
 
-static int zmii_probe(struct platform_device *ofdev)
+static int zmii_probe(struct platform_device *pdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct zmii_instance *dev;
 	struct resource regs;
 	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct zmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct zmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
-	dev->ofdev = ofdev;
+	dev->ofdev = pdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
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
-	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
-						sizeof(struct zmii_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+	dev->base =
+		devm_ioremap(&pdev->dev, regs.start, sizeof(struct zmii_regs));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "can't map device registers");
+		return -ENOMEM;
 	}
 
 	/* We may need FER value for autodetection later */
@@ -266,28 +265,13 @@ static int zmii_probe(struct platform_device *ofdev)
 	/* Disable all inputs by default */
 	out_be32(&dev->base->fer, 0);
 
-	printk(KERN_INFO "ZMII %pOF initialized\n", ofdev->dev.of_node);
+	dev_info(&pdev->dev, "initialized");
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
 
-static void zmii_remove(struct platform_device *ofdev)
-{
-	struct zmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-	kfree(dev);
-}
-
 static const struct of_device_id zmii_match[] =
 {
 	{
@@ -306,7 +290,6 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove_new = zmii_remove,
 };
 
 int __init zmii_init(void)
-- 
2.46.0


