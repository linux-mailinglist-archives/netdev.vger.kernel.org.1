Return-Path: <netdev+bounces-130521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE098AB87
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF96282E92
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCF19AD87;
	Mon, 30 Sep 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy/0bn6V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE719A2A3;
	Mon, 30 Sep 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719251; cv=none; b=eqjZQZ0nG5A7+MOBVmYaYl/0NP9nvL222JCKahUZpgcv3bf7uO5219oNFTpKuPknE4wP3eHqPcufC9KFp9TtFFnGVdSS5YHUiDSbk9kyDJmW3NWHIFqVS0G3ahYhEpzjEOQC7ysjxEXpxENK9ePUMLnQWNRFXBlgi8rLuc7239A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719251; c=relaxed/simple;
	bh=R3/zEAcwhIv1vvXu5eqLy8v9T/QO1blsvg8rxiWDF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc1+MxGg8meO2gIjaOgOJNEFO3OtlardA5PAfSKNQk1neblfeo+7Xw9q0vE8K0y2Zmcun6Pf/FSLP9/XvABEz8smvtLyeOphM8ETH5YybbAQHkh3GoAJlTybXftJxLjmPbDqfYYe8R5hJ8h21NXsfqA8yrM3MzP9VII6kTSJxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy/0bn6V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7198de684a7so3218958b3a.2;
        Mon, 30 Sep 2024 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719249; x=1728324049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=Gy/0bn6V0cBZNZR8Ksih1qf1ft1a+MfObL0hhxajoR/wKhprKjX0QlJPAwFK1HkYmA
         r6F8Gze60Kj03YZtJdws95XKiDylqFRTEnq/RgUsWkvoGFprV9PXePfqLmTbgdnvI0FU
         hHGgpXGk0hgNxMmMKW603aICn5Lc3H6+08R36Co45OfyFdjYuY753vlGSpOkUEeeuM0/
         r0kq4iu8eQKMR3HM4KlcvAbA0OQ8v+mU8QaYMvv96FC5GUmdDUwYWMhRGQGJqE+qVK8c
         NhEGhevjcpveDlFrsKPnCn/oqnq/uojjswk7df5/Qa/WHPAJAG6Bn1ashuL/8KnfP3Qz
         V5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719249; x=1728324049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=j8qRgjoD/W871QZBfLCUSDUUp+9iAHDrEz9GrqGTMTqMzJ3c0wX14IUHDocHd5qjs3
         QLNSuj5kELe2JAIsRKBgGUIQvinceI2omVXe/r+0d7zeIUyj7ZXk7cktuwIsewKbQdAo
         +F4voAHGhvsO1s6tzaU8/q6QwMwdSq/CJHkZTi06JagU7p9EjPyDvk9Pa1bq8G/W7067
         amlcfLMo2RVxStpwzMBFb1znKd50RGZ74gHqeendwal1EtnbiEkfEBiBcsoyTwoaf3C0
         vnn+MbvnMOxI0KKP0jxbf9i3RPFL7qOC63WgdVPB3iZzNBVJ0mKKRFR2qUkZLSqtQlms
         nAmA==
X-Forwarded-Encrypted: i=1; AJvYcCUrwMJLsThgeneaY5P73F7Kk+2EO/gs7wTrQb5OboLL1h45MgCoPUEMLrT0prTWML9xstHRSDy/2iTG2Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9PbswN4TDo+cJ7wW4771BsecOea6CXcBiOZOuVXcELqHlmTf
	nsKTWB2yYwRcp7SNBGP/UgNqie05WZrvTSUykUVnqgu3RPfaq3DAzMVvR22J
X-Google-Smtp-Source: AGHT+IEgds9HZwakhDIm1IWZQClKaaK+cnTjml+XjeD48QSENZjQpoaufg4Qv+n38KO0b6bxp7HdKA==
X-Received: by 2002:a05:6a00:22cc:b0:719:7475:f07e with SMTP id d2e1a72fcca58-71b25f0ab4cmr20222220b3a.4.1727719248770;
        Mon, 30 Sep 2024 11:00:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:48 -0700 (PDT)
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
Subject: [PATCH net-next 06/13] net: ibm: emac: tah: use devm for kzalloc
Date: Mon, 30 Sep 2024 11:00:29 -0700
Message-ID: <20240930180036.87598-7-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/tah.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 8407ff83b1d3..03e0a4445569 100644
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
2.46.2


