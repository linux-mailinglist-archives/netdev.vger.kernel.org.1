Return-Path: <netdev+bounces-130522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F0698AB89
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6AF1F23C00
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1916D19B5BB;
	Mon, 30 Sep 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqPJio2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821251990CF;
	Mon, 30 Sep 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719253; cv=none; b=o/MQDUlUT7VoPIo64l9UU+DU7d0l5EVk7kg046mbyxjpDS0Hp7iYORnNrwFpXRuaV0aJVpZfqxmMGHyVp48FQzgiUHEHHgkXqBRUkUcqsA2GiKdhlGsQNVMP4/YqUDYk43CHw03RDa8mieHkb72GZYWBwxMPfI0gB+rmPOuOHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719253; c=relaxed/simple;
	bh=2IYzVGZB/me91vV9GKAMx/UOKfRS26DvtY0el6//X54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yos4JY58ZRyIkXBGt+uQYTO2Ybo6NDBpEAQNqJlgPsZLtwV0YbRf95CPQ9t2KuXXrMStTPBMWVdJh+ipAdJKjiryEkkZloqopnNFLlr8qp8SYQ52T0j8ViBxbbPEgBDPuzb05sTOC+Ps10F/bimHx/dL5xvJW6QJFiqkkO08gJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqPJio2; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-710d8cab1c3so3386536a34.0;
        Mon, 30 Sep 2024 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719250; x=1728324050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGWXvjbdkPp+9wytWEPAL2W2KtxouZqemO4TuRcnCl0=;
        b=gAqPJio2KPJygOLA4wF3/XLl6Zd7VumT2nz6RErC8vzbr9tnwJ0GsPPfKJuKFne763
         3X4Ro995M7MysDmUtw94G4GcKN80HWATbga/0A69y1ZvU/1a764kG1K0DC7oAHaANS/g
         Bje7/glch6WI6XsnJ3MjKVDRDvzaC70qg+b8cWV5dD40JYaNDU4I2xm8U5HnNJHvBl+f
         PvNW09mzMEv55cT9BZhusND2mvhhNyuvpiJAtNQKJA2EE9WEjVlJPQHXYq/vcnqmOnCy
         OMa6xQhXroGNc5zTQ9ZBFLejrHrTWYBA0h9gLDzLVj526zB4U5rjrVeAXWGB+gQh7Kke
         mh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719250; x=1728324050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGWXvjbdkPp+9wytWEPAL2W2KtxouZqemO4TuRcnCl0=;
        b=ig9+NbUD7InRz1fmrEYopQNzp5AxZHop7ByOCrrDjkYWSWq1V7aGzdHYsNz6MY6ZDE
         wVigqL1YVpwkBNIjZaNphsTjaJwehU+zwYYSazp5bQcpaehyvQ25Q4shzrMerWSnfceu
         EwLzGNOIaPuEGykndT7ynJiC2puANWVmSty6gCokR1dvxJ3eOnKG6SBoLZV1WtoqpFpI
         iOpmqdWvoj6/8nbde8wbEQkVs00KGT+ebAIEF+zXYE9FpVKVnCO571KSQbHPQCX/cd+i
         TT4wg9MdDH6ompd7coeoolceJyEZMIM5dc3z676/QWg642HNS9e41iFQ8CcxUWEdCg8/
         nROQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjCw4xIShlqRud1+3LmKsxnezPnobs4RjiZ8MRyiL/nxcR+N/uLLS4u/c+EHKUuSVZfoFUcHekj9G9ux0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtFXzzyjV/tAyH75ooRTo9rTK3wVU54ZgzLgllEP6LP4c83FB
	XxC2LthDQXvYjBM5CQUFB7VTVaeSOzYuQSK1y/vegE9z8ddtA4w2xOMI7YwO
X-Google-Smtp-Source: AGHT+IGZot+/JUHGiiHQMSsd+QSufVIvSt5CtIgE32V7Kxsuzp904usSCQPJpII8GWn1HQUY71yP6w==
X-Received: by 2002:a05:6830:6282:b0:713:7e24:6151 with SMTP id 46e09a7af769-714fbf0ba08mr9482432a34.25.1727719250346;
        Mon, 30 Sep 2024 11:00:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:49 -0700 (PDT)
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
Subject: [PATCH net-next 07/13] net: ibm: emac: tah: devm_platform_get_resources
Date: Mon, 30 Sep 2024 11:00:30 -0700
Message-ID: <20240930180036.87598-8-rosenp@gmail.com>
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

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 03e0a4445569..27c1b3f77125 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -87,9 +87,7 @@ void *tah_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int tah_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
 			   GFP_KERNEL);
@@ -99,16 +97,10 @@ static int tah_probe(struct platform_device *ofdev)
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
-					       sizeof(struct tah_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	platform_set_drvdata(ofdev, dev);
@@ -122,15 +114,6 @@ static int tah_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void tah_remove(struct platform_device *ofdev)
-{
-	struct tah_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id tah_match[] =
 {
 	{
@@ -149,7 +132,6 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove_new = tah_remove,
 };
 
 module_platform_driver(tah_driver);
-- 
2.46.2


