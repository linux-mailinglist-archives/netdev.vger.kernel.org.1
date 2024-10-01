Return-Path: <netdev+bounces-131055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA298C727
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009F11C23AA1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981181D0417;
	Tue,  1 Oct 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmkngTzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4181CFED6;
	Tue,  1 Oct 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816344; cv=none; b=Q0JAPdOaBLzswAgv6h9QLZ5KCvTD8YhW7i58ST9KIy2KhFvIWithi7A8F2RzmsGfsqdCHENUds0JIamKutKJZLbuUxkIBoXCgd6ElUN6j6I3dFmEOAl58mYSPXGPP5JM6MKa/RqOERRCkWnS1sbn3OvmnPTx1tmeQDTyCY6nNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816344; c=relaxed/simple;
	bh=jcEPPiC20NiN9gN9PQRjLJGI4IFmPIwO1pV6PvaDEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7LRpWrdT5qYBTKBU0TRwLmZ7jI4mxeQliUUqeoWjXk3HZvlAo+obQdDvH2SG94u7FuAgfeKZl4on0cVa3jdLObShFOq0rCSKP0hZhauEqPKWUTy43WecRCVP7oGhidUuPV2PT4RWJnlS4aIpAOtBcADRFqey4McgVZSeY2vKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmkngTzK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7179069d029so4352760b3a.2;
        Tue, 01 Oct 2024 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816342; x=1728421142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=KmkngTzKSOz1gy50cOolKn57ITeBke85nBPP9BvOEiCSRFDev/K6LV0isf9i9dYdwn
         QSz7sJDWFhm16egqFcpNgwV1sB6L4ogIPPGxxfvR9w5zsWBLWCDGvm/d4XbHgbqY1hB0
         WlSUYatjJ/FYiyFNwoKL52Km6LXkqsg1RLiZ3jgiaCeOeNVUzgvkdsBC3Av+XtIEXhKY
         nsBb5Ac7x6/edM8aoYPByBlD0wymEgovYWOLPTmXLHX4YGuydibXTc1/sGW8ZswrQygl
         Yo0q0MbGqZMOVJMRxcUPFWROrOdYwBf2vWpF+T1DOGcKQfkSt8MqXDMvsTIsKvSiJZN1
         apmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816342; x=1728421142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=RdkrEtUIr7FQQJHQbavhVvF24sJyz0fDJwYSPstar9QYvNwgvKvA2FWmhrGwnkphV1
         ypzicxxHx9hfiKITnzwQTyCHcAKhLk3pVtLAGR6z/GfjyIvM/VVdWHF456CYkQQGEdSx
         GC1f+p5CSJl3t16ra/HHTVJUQTN9rbI3ECQN5YwybUpritsccg5ZoXSCTAtJOg9leTXw
         kd5ZAojxTH1QsFQZn4z0D6OUKWrSty6DOl4k+jcbm066MU2Mz8Gh1NTv+xpbLkFEYUGx
         KmDkaBi/xQqRHIUTGQFTNo9TU1m6k57h9TPGOYy52qJxQmhdB63xAwJjvr+nNA1qHfbW
         nCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZGqQTNytlTQ4jlWxQLwMre7ykluohtfI3gZOog9nl3C5H69RqROAbhFnFZOXnVCVihINi8TbEQnHyD6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoChc2gVytEtNw7Tr34Z1Nz1Ih+p0KR/OAqe9y6G6cpNgjAYfS
	e4dC1WngpTZs4tkq8m/i7cH1MlPDOHTsggN73GgGwuUXYylQfSIb1wPEYsVj
X-Google-Smtp-Source: AGHT+IEJl9jp7E0wfRjiQJ4HhJobY59MYo5IrBRZ+mLg1s3hkFrFO+DP+EpyMmIbl3dBTOYi8fmlvQ==
X-Received: by 2002:a05:6a00:1812:b0:718:dd1e:de1a with SMTP id d2e1a72fcca58-71dc5d6ee67mr1457606b3a.28.1727816342509;
        Tue, 01 Oct 2024 13:59:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:02 -0700 (PDT)
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
Subject: [PATCHv2 net-next 11/18] net: ibm: emac: zmii: use devm for kzalloc
Date: Tue,  1 Oct 2024 13:58:37 -0700
Message-ID: <20241001205844.306821-12-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/zmii.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 97cea64abe55..c38eb6b3173e 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -235,29 +235,26 @@ static int zmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct zmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
 						sizeof(struct zmii_regs));
-	if (dev->base == NULL) {
+	if (!dev->base) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	/* We may need FER value for autodetection later */
@@ -271,11 +268,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void zmii_remove(struct platform_device *ofdev)
@@ -285,7 +277,6 @@ static void zmii_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id zmii_match[] =
-- 
2.46.2


