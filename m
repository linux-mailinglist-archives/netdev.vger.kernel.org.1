Return-Path: <netdev+bounces-140541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC289B6DD6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C739B22297
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7831F4713;
	Wed, 30 Oct 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4tDvtjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0263217640;
	Wed, 30 Oct 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320664; cv=none; b=RJnSxa5B5MHRLFaE8fiADB+9Psi8TDkL5g9xdvXC3XvUgn4i1SuLEqT5wSegOY+/m880ByLm5eHJzJByzxNm0lVbgDbATjGv+/60z6EiBfmxfeADYdGZY+ahUt7K69C+9xU7+liMl0sI8FB7z5xHMq3mxp5TcJYg9eqo+FN8a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320664; c=relaxed/simple;
	bh=/AyfdLsc4FboZTScYL4z+M7CyC+1MlkGFgvrkEtv8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+WfMyW70rQWU/evpwZ8lCSqEd+htO9UlxCxwpvjLNpAk5HbgEO18OdxKTA3If3K8IAnyjsUqntW/0XxABZCTYf1aGjAnItY1uOP++lG7/upC48jt2x++iZplG6CmBl5rVNSQSs1L/7pq/SMp7efgsNmiG4C7kLlPN7tOfEgBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4tDvtjx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so2666175ad.1;
        Wed, 30 Oct 2024 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320662; x=1730925462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4hNqSoXogKVl9LYR/Mqj/g1unmfokChedKgYC3ItUk=;
        b=Q4tDvtjxSRX6SaBvT0xD4yJSl+u8MkGfQN96MkJsIkLcv/5WynloLeR9sw6213f+DY
         vzwoTOOTApHwDaFyjw+Kdk4u9bZZYW3MODkz+O4zh15Z5UWpETTlZ1wmRrgHj/7s3IBE
         cOOXlZnesW+RYDWUTNSmys5pKA86SnNOw2lzZFdm5fQHYvLMNVHwkp/Zbk2sBoVMKMSd
         BqsXK8qVyJcoKBgamxd9VkX/fxVbIAEUqo/a9xxSI2W6pf2899iWVv2i3J/DEl8TUQRp
         KACPM2D3/R8s+XtlY+yD285ndMdM49irOAhh3UAJDLeR6WqD8sHhWRcTQgLOqh2/uyw2
         PBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320662; x=1730925462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4hNqSoXogKVl9LYR/Mqj/g1unmfokChedKgYC3ItUk=;
        b=MW/EHcnVVj1rZNh8vWwNtkPeJihqFx/MvW6GbrBPvaMbObBpS7bGRqT1nK9KgVRcHI
         opZNd5Sk4Ah5amHpK0SOFHWui3XfCBuWuOTykd8VjDRsYtiiWGQLdJHA/nvnRxuOk5B7
         95ZuygB2T/5L6nos4d3bex3Uo4Izz1rxY9jL6L48Gpg1wPpJ6YD4q2xBhI/b8lA0+koY
         E3bVuG3qlgPzVcN6texlaHaxQ09p+agjgRWwlhcJmhGl4v7f1aj2tCjRH3MKXiXAO8iW
         Wgg9cWwhq9gbQ7MBLRU3NjgvEwoOBdy9DKgh4XadMeM8942IYpPnxr5X1HNsWNfVL3dZ
         s4zg==
X-Forwarded-Encrypted: i=1; AJvYcCW9tG5b/1kifEmiaIwHn4bqMUn+2QKRaflsJv/pY8LOZCnAuWmyHgM39YqsXrseKlEJaU9QfgTYEmMpGzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaGEJcyosBKY1Ggdsu++EikmGSVnOTX7wkTJNAaChWoUHXHDE
	lorVf4zYmQMkQ3kxaqjnnuGNmsw7Raaamhvab6hsLXPdHH482swOVA5eb1an
X-Google-Smtp-Source: AGHT+IHjsHLUmxVu1UxOIRcoo/yQk04XRdvaSISDcPg2PKTem4MjkrUo8cfIT6qLJC0y6uw6tJv9+A==
X-Received: by 2002:a17:902:e888:b0:20b:4f95:932d with SMTP id d9443c01a7336-210f74f6f4bmr62398505ad.3.1730320661624;
        Wed, 30 Oct 2024 13:37:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 04/12] net: ibm: emac: rgmii: use devm for kzalloc
Date: Wed, 30 Oct 2024 13:37:19 -0700
Message-ID: <20241030203727.6039-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
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
index 317c22d09172..7bafe2edfc50 100644
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
2.47.0


