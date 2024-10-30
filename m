Return-Path: <netdev+bounces-140538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CA9B6DCF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12DC1C21A64
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA632144DB;
	Wed, 30 Oct 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1CgS6Ml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7AC199FB1;
	Wed, 30 Oct 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320660; cv=none; b=bhtqXEwsHQnob+3zQEfhARe67kHwmYTKe+i+D4JRTM9YFmX18LDXAlKkVcGdtsy+ydDlgZr/hzrH4GTg+h1/VWJNddkxY9I90wk2nAz3/bmFCtZkDJhGXHqQRPhu5ZITNG3K0EAXN8oHEnjHhEbweDjKymDg68p87EZRxvhIXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320660; c=relaxed/simple;
	bh=cJF/r9FSp+IKgOh3m+uNrY4TgV5AxmsrJVO7MLbSC9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDvu7pVHRKzG7zs6+vfEq+mizjmAB8b1aI+o6rU4scEFfuxVBz/+E5n451P8ST5ZQwda820F8ZYgyQijqk9BASFRt1w1bOl1AxW3tfa5MXnMRSlcZvk0yFbYxm1osp8HzJGiJ+6aZTd2rSEYRvR9HkCQo4aFTlHlKyxQw5U1sz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1CgS6Ml; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b5affde14so2138565ad.3;
        Wed, 30 Oct 2024 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320658; x=1730925458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oZNHqXM6KLZf+eEXFCkM1XpVoPkfn5qBUjcN0umbNM=;
        b=I1CgS6Ml2tG4rEPkMXbBfJAJWDai439v48N04YtyYi/tQb1KsP3qNxMJCr7qFC2yNz
         v6z06qTpqJ9jrPdScjCfn5PV2d30E0sa1Euuo242ijGN58bTQ0qrK+C3vTLPJNeKx18I
         IYRm7BWQbCf7kmtZFpA1UN30Wg7NbFJtdMQ8znPsvIbFwO0Atf/8TqFXmUZkfcLW3Den
         15cpETbUwWKJvennLxw42K/YwbhKrTXeQ7ewTzFszH0vWZJx4fJXC+e84PLMNgTNK9ls
         To17bl99SpKvO5GcVX7ZK2pLSjpPitXggvoJq2HK8EmFAuhAIJeFphEOdH9N1aTJnoOU
         bkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320658; x=1730925458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oZNHqXM6KLZf+eEXFCkM1XpVoPkfn5qBUjcN0umbNM=;
        b=UIhUfhkplJEOZPcXv+RHEC7PgYt8Mn8mHQGCcdMiQPA4D3eiCkAAVPRbdaHg5nIHkK
         J33flQ7Y5CN9PJHSZiv5j5jVf132NeVjJqGIU/IZKZU7BYpIMiNfvvz0RxSvGw1mXJjV
         QDylonSOnL5PnMyt3HeMHsavLec744JQUZBa4l2+n1U67I3hUBhanMW3CvDcpNACFNrV
         y4EMg53a/bBMFQ7FMKaqvXSrTqjSv2re37RPgof0rESghRvmXHnm2CpIa0lrx6QR85kC
         ixNrZuIAVzh86fnibYLdWxPKenYq4+IA5OYx+RPwzAL3xw0r5hlxR+qrEU21kDsz9ZvA
         30dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0g3CyUEwBrAZ3NZRVTlyRLeQ6rlUm+prISdyITg8+m2SsqQkk98A70dIYDORZjR8IRjbc/3CA+e0fhik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvNU17cSjd6yMFgUiIWalMQwd81IhU7BT2rbK5f6tMkS2HsW6
	Q5VnNzmtQXFvymeQBB9wz/Tyi0wAjDB5PU5g0bzu96gLqdm5P5Wh6Zdly7y+
X-Google-Smtp-Source: AGHT+IHO6/QY0oKNd96E78XoWzLNYP2UBQWxWGmGxUa+7tNjgfq278EHHzid915c06iCvaCcEwaHjg==
X-Received: by 2002:a17:903:2302:b0:20b:9062:7b16 with SMTP id d9443c01a7336-210c6872d94mr228484595ad.9.1730320657573;
        Wed, 30 Oct 2024 13:37:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:37 -0700 (PDT)
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
Subject: [PATCH net-next 01/12] net: ibm: emac: tah: use devm for kzalloc
Date: Wed, 30 Oct 2024 13:37:16 -0700
Message-ID: <20241030203727.6039-2-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/tah.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index c605c8ff933e..267c23ec15d7 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -90,28 +90,25 @@ static int tah_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct tah_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
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
 	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
 					       sizeof(struct tah_regs));
 	if (dev->base == NULL) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(ofdev, dev);
@@ -123,11 +120,6 @@ static int tah_probe(struct platform_device *ofdev)
 	wmb();
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void tah_remove(struct platform_device *ofdev)
@@ -137,7 +129,6 @@ static void tah_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id tah_match[] =
-- 
2.47.0


