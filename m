Return-Path: <netdev+bounces-131448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C5598E84D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58E21F2581E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA7126C0D;
	Thu,  3 Oct 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNjuHRql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EA84A50;
	Thu,  3 Oct 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921512; cv=none; b=NnM789s19szJO0qKr5hHvusbE3HEkJ+PF8CnliE09togo5U28qL2b4JzkoE89GU7gDkgeVhzjKCf8rgmuX29jnBtgI34jJSGQN2GleQ9ghF7kgL2aPxADPhPo/WwvsHnLhueZhvG3gH7xc4EM1mjg36mGfM7j8MlZu8RvOUqM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921512; c=relaxed/simple;
	bh=A8gJS6fEP9QvIScx57iYcjbGzw0KGh8cHqIn3dIOJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS6r/EXsMxvgWabuWAo9n24hU+w9WQslKQxTRiNvLQKU+Dkv/nq6aXl/0ohH5RFFSyPJtDCl5XiJs6tEUg3MOr2t8Sx7jr7F85y7Pdnaa/DDjSO8mA3jYlzznDiWhKq0S7hokkcJ3mmlM6ZXdHBI4xZaYXWZQiFeyy0vTNRZ5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNjuHRql; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d704704aso459251b3a.3;
        Wed, 02 Oct 2024 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921510; x=1728526310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=WNjuHRqlS4jdjasA5iWAfmTz4Ik9yxssXQKkb8dd2keWvqDiKSlFJPeckCVjAQpKBX
         2jTBaBFew6hk4tBlWyQVXFCB5Lku0BiIk8DMFc2oRGNvLpE/gf9nVsxUAJqUk27zm/qR
         3IT7XywMFd02xrnKeKPOBOwAymcDXVGUiMAjUfELnUxVfkKudd6EwLMbp2Ss/PlT1dgO
         rJtuD0zxR/8Gy0QRxZ5Xtl/KQYu1yO/FtxJ/hJ44eamjum2w5Wy5+axr633sOeg+LzyU
         SKVpGiZFmD8tPzFjkSMi6fEkLSV9wmXaa2Odu95i0Elmd19C0QgT5vypUxNoA6D+m5H6
         i/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921510; x=1728526310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1fHxwhP5+cPvxE4VxQE/C0xITWVI3wQQyc3orisuY=;
        b=hEDL1Nfp0OuZaGJggzBBdtjAmbFUFn3KNCTsehKa9DvFZ5qXmACmkd8/zoDQoVh0VS
         dpRZv0Ks0MyJFhroELcAZdfwpNpuLGVxec1efO7b2QTS5ekdlETWclMsAalz3jerYPnY
         M7zmagFJTMRqZ5iZJoqmXfv+sjTzPCgdcfKxye+Ln+9FUdNL3JqZb3Z/v3+NCe/5TMRZ
         3B24ChvP58N9U4nQoab+cl4Iyw7FhUM8XUjYdmrALkdCTjyQE0Dr2vGUsiaR06JJaFnk
         eDD2AzvRc00dNZlD8x35QGPcBzF8u8OwUxKX+g5miH+Do9Vfr/+symhhKVU/Wwd+4gDY
         U1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdgJKp1SQ3q9jBlQPDjBYf6kdDWLvLz56kODU778J3A0YcNxljROpLrULIjr9gPM1kT4K8ruLpkrmdLnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWd3VedGJFRFnmhVDg4OhlftBXcoHXIYbB51oTGTs73XGNfiT
	FiNGdQzFyMWkLS0pGthyRu82D9OjRKcX/Nd7nKgmsQKbTQ9mUO9qKhCTFnME
X-Google-Smtp-Source: AGHT+IFSoofh/lnpCdFBexu1AKGYGORYJn/eUq5y0qer3JY0wKRLp6VUMVoio9CFoISOpDQ27v8fSQ==
X-Received: by 2002:a05:6a00:2d0f:b0:718:d942:3475 with SMTP id d2e1a72fcca58-71dc5c6751amr8574141b3a.7.1727921510524;
        Wed, 02 Oct 2024 19:11:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:50 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/17] net: ibm: emac: rgmii: use devm for kzalloc
Date: Wed,  2 Oct 2024 19:11:27 -0700
Message-ID: <20241003021135.1952928-10-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/rgmii.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 52f080661f87..8c646a5e5c56 100644
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
2.46.2


