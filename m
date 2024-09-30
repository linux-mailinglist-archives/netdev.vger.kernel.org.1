Return-Path: <netdev+bounces-130525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621FA98AB8F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C81F23798
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30419D096;
	Mon, 30 Sep 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltd1RkW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569919D070;
	Mon, 30 Sep 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719258; cv=none; b=YVI8O1t69lFlwwU64GC6UlmFXLXbky5e3s4QVSu/fFpbyjHtPOgvsb5MzdIwLs87GIdhUAD8yfOLWPUR1vlKHXNKQQFNrxOwgz9sy+h1Lh2G/jZNB0qQ8dqzSD0+jRU7EgKdmjciAREOBp1wVIAuVcJFryip/2Cy7RfCFOVgWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719258; c=relaxed/simple;
	bh=jcEPPiC20NiN9gN9PQRjLJGI4IFmPIwO1pV6PvaDEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8kwKG/fBcz25QNBxMTVKfMGgtL/Sc8Tjzb5j9uWhAhELHOpBpPkVrtxr6e9BaQaMlwvxlRUh/YdDiGOUtcc9VI+Oc802sogvIMV48ZO/LwUIrSAcW4RneGujhGlFRnEs1jLFiPaQah7i4VrEG0l7cCtu0TMeyWgBPVsnFcCJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltd1RkW1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71798a15ce5so4333356b3a.0;
        Mon, 30 Sep 2024 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719256; x=1728324056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=Ltd1RkW1Yt3W89QMjtfPDxoZOcOWXqo6IQ2XA3TceO/I0g40wKnsHMtViog3ybu8YO
         1KH4AAS9AdgG7prh9GHT5WlYFoJxyoyXNoXhVemiLIzpk/XJAYLh4hMNbofJY1pn0I0R
         1iY6VdsdUcTgBVD6ZySVI78jbnWY+z96fAQvLtBnurrUdAA1oo25dnMt0YdI5uxCA8op
         4soaSY2tdureanL/fJprmst9i3Ps3tfk7kCcqfT6EPxFRUW5zgS39+4DVkKD5aJB7Jpi
         Uj7KCV+rQ+FlTYuCeiFQ3xmkuLqaIl906GnqczVVjamJTXIks9//BmbmPwDuN/CqY8Qb
         UnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719256; x=1728324056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5PeKEFZjGrSAzWG8C4rr3WYbWfyAh6vUs2OEDpSIRE=;
        b=FlN9wTkP8NcY6hLrejOJA3cffCv2YHieXpVmbORSM/d3J5z71JvrkgmzCSAiycLzGy
         xt4jn136x+3XRjA+Y4t7uaw2bEuYSjpiG2//YQtV5xfNTy5byHqK5lds5hP6bRp3bl5L
         5bdx1cDx9gRkgq36K6D6ssBhan4OCtIrCHgrf8IJ6pnllnBrN4O56dYxjhYGhlPPs2ld
         6ots0ueht2GNJsg/bjSTh0EuzNxx1sh3d6sO6pEmvnykUiZOmfLbkt7d9YY3BVXWs5JA
         uHKJZwYkXRxkdLmmm/gtmk6whP5LtRb61Du/x5p9Th+EYrlwpaoqGMFdvU2OGcU91rA9
         YrqA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZMRIRpC5czokdzm2PhJL6KVH90UhkrVKuLCpSi08EcLCMvRywVh+6pqwtmAV0IXCDqpAxa/W0rTZLlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhpBIXiFqfLfVXfjInVFcutWDj9620nQ8IfTJksdbF2R+UseP
	a/32tr+Lj8JFquzyZmx+jVOAx3SP5Sz8bvhsEOpHaySn6EY+5SlnJyRfyz1Q
X-Google-Smtp-Source: AGHT+IEdLqQ4UkXrKrNas8xzJBn/q8LOUC+fDCZxwwifudkAI3IO/bBZWxAeNQipKKh0FHyb9SlBhQ==
X-Received: by 2002:a05:6a20:4308:b0:1d2:e8f6:7f3 with SMTP id adf61e73a8af0-1d52d10a231mr820620637.11.1727719255655;
        Mon, 30 Sep 2024 11:00:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:54 -0700 (PDT)
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
Subject: [PATCH net-next 10/13] net: ibm: emac: zmii: use devm for kzalloc
Date: Mon, 30 Sep 2024 11:00:33 -0700
Message-ID: <20240930180036.87598-11-rosenp@gmail.com>
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


