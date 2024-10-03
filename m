Return-Path: <netdev+bounces-131450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4098E851
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF911F262F2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685913A26B;
	Thu,  3 Oct 2024 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1lL0+59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16812F5A5;
	Thu,  3 Oct 2024 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921515; cv=none; b=UDxKvtpm+J1bqqVR5nxfVTpZNON3b8Y5WYfIXaa/uNeO1imGtyNSsSABXYyijZrS0CVHJfhioQ/sLoyJ9UZwmnBKONeDz2rFM7zZrBfo/oWCuhVdg+/NTRhW0FUlzj4mBaQIxuXBIWM+xGToq6uACk9TrEkmBhMBDnhXzh9Z7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921515; c=relaxed/simple;
	bh=jcEPPiC20NiN9gN9PQRjLJGI4IFmPIwO1pV6PvaDEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHurZqcjP2XiCMIk0xm3yXLr7k/dMYPZB34qO2bY1zMimpioItUhQ8+KHlOWwvxwhr/sQVzBGvKEwsWys5d9eDqlxKFR8kkgTWESrYAGHtI/rckkKv0d5/O0kV6ah6b5W3mYtnV0dLGadmvJGGrGSN40lIqkWLwbp4mbs/ucBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1lL0+59; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1112937a12.1;
        Wed, 02 Oct 2024 19:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921513; x=1728526313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=B1lL0+598z8EgxP4xnya73ClGIwl6eUmCOJxQI3FH+nkKKfemKhO9WzdOH7FEK/OLK
         njtOopgP3vdW1vzkkuXQAIH+FGSLLk6l/EDL5ddUWjvoSgywQTahdmFaFSGoTIlT0uj7
         i6BiZOU3W7S+Leeqlks5LSPabV5Tm2pyQb7JfeVvpXWZjfWoSfvE37rKD5epzPwYVXh4
         RmgrlS3R2XBRxdfb7wNkwT3VZnfjJLFshJF+z7msiSuJjcqUNGvLqgvBpCyp2FxhTPXz
         KbpBYchLw5poy1tn7535Kbdfskxi4o0OTp9jMJPb2vSoRbP24KD4MW3hWtQ8PYUeozW8
         spaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921513; x=1728526313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=hIpRn5oG7uGQ3jK1bHZcUuy2uiNWZucQNrLqYirXe3L7gLDyTSX2WvShqIMUo9okit
         ssVsj3kKVGXcGwwtk6pUkVaHEcMg4EFZd66X4TzdqId3mUcHHE3AiVI4O+rhpC3voZ3t
         TyXcHwpF7qqcYlabCy1EyS+c4VOaq8nb7hiwAvzJ4M4sOTmB5FL+7sRepXUinpOdllUG
         NmdFT474Byt08ZfMw+CS6oXhRfymjTSHisy5r+3iCjcfQ26XsXY31rYsM5OHKl6mUfZj
         O0QKmwbjWzDfwm3pU3oBKNRt2GWGZmYh4sxBmUNjPe0VXAxo33HnkrOVbEQ1JhHVA6C0
         ApJg==
X-Forwarded-Encrypted: i=1; AJvYcCU6wnFQk5Gl6V8RC2Vz/gihx+nhNaiMKrM6Uh+tF2/uyK54bL7ArghvHLdUMpYNH6XjJ+NOA94RmOiIv7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mETRTP8qbd+x9ZudbOSS3pxkaf/Q97Vws+gNXG+gnKMCPtTo
	C2sck3oN0Ejp7vMNJNTWjjffLHgw/uXa4gFjYYTre8GzcSczc3e9oUkODXQT
X-Google-Smtp-Source: AGHT+IHExFlcE7tNqpTJwJrTc2jBAZ4k4Y0HHQFxbyjsGm76BduNFtGzaWkipi6ei3+CJvscALU/JQ==
X-Received: by 2002:a05:6a21:2d84:b0:1d2:e90a:f4aa with SMTP id adf61e73a8af0-1d6d3a7925dmr2162644637.13.1727921513473;
        Wed, 02 Oct 2024 19:11:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:52 -0700 (PDT)
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
Subject: [PATCH net-next v3 11/17] net: ibm: emac: zmii: use devm for kzalloc
Date: Wed,  2 Oct 2024 19:11:29 -0700
Message-ID: <20241003021135.1952928-12-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
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


