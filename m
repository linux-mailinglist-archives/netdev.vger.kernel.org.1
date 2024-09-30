Return-Path: <netdev+bounces-130527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54098AB93
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8FB282E99
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9F199230;
	Mon, 30 Sep 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs3B4aTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADD19DF40;
	Mon, 30 Sep 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719262; cv=none; b=JMD6W3Lj+ddxuQmYg4saBGfg618QejFIeoEQGGuuNIDEr057IpXFPblt7s4dqR/0LlFa2c5vEgHuMzS7B3yDvFc2IYNsdpkmFRXWc8iC/bp63e7VRvn01BTkmeOj9NpChBNnwhbJ7PQpdqcIbD3ayIvx/g14jBg4sPKa5pCPyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719262; c=relaxed/simple;
	bh=kih75HuZ1ZXc3JQHkzwuj//sPN9nSONeRe7im09vADU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gcff/x7Ss025cwR6xU8pjLW9ulrZZkh9wAxS1+F5Bqkgkp1/Osd+GHCbiEGu06Zak2zludiqZ1yA7ZHbAgqe2TVYYpOja5d6Az3flI1SywY9b7+xBeNrqDGydAEm4qEcPVjbfDxxi0zQzZOyg9KSQx1WdD7TWG50+T1bt4SftkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs3B4aTV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso3976932a12.3;
        Mon, 30 Sep 2024 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719259; x=1728324059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=gs3B4aTVYoetG63PlToRv1ehZKmk9Z4VRAWbe74ahKVqyf/SJ6/1kpJ54DU/JACVKQ
         9rSTQQtpzR1JdZ+RbaT9N4ySHjIxBpdmIWfMwwNgqI6WG7Q89id1In6wnUSDIrOTokxC
         1/cwKg58T1Mken3/f0N/eVU0SWAaNNBc2K57Rex/S8iSNwvfIFWIeu5pkR8jGvn6P0+K
         /STOV8hmWhAg9sywOjnpMR22XUQY0wDv8amtGrpMTPS3JwOOsknLsq/BrwCVA6LUniO2
         rTdzu9qeupARVf5EJjOhAWa3zrfSWgaV5UB1ppTDBbx/JagPnYQjFWbwHRvCa/reKtCE
         Yacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719259; x=1728324059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=FlSf+BEdJE8pzmvkOwFU5H8EYi5GYa7CjlulgXda3WCmQlwZYC+P3k6wpPlnfLLYaX
         YeZl6UmsQpeIRYkfQu/YzIN2xjusFVpDLAApCgs3Ray2NicgYE7N0f0ZadUAIb4Jamue
         yqD7vmhcalkDmpirLOedk8i5UMQEqeLn9MkxR+ZHlw34ASrZOxcjCydadlomHydJdWX4
         DBN317RgKIeC1Uy0Cqc2HtdkvN3NWlDP7lBJ2942EPLGpWFjl2OGy18D+h96lqrb5795
         hMJmvv7mPE5NJkwcln3nLnb7zc6QeCmaDiTPg2cmT3nQMGOaGtA52M1f3gToNds0FVkA
         w1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlrGkUmUWpMYR2T0+UWZ21sWd2WWyv4pnraGQbuQghqWcyf+6e6ymkArK5xs6dDdROUpWReg7kAffBvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtl1B1cAx8qE3fVHSTfeigQeIJ9MdytQSArFkZdHH/+vRtNGL
	FQ/SqCkr5FpWTdfoHGPuvlQAUnomDwwd/X9KfjqTX4lM5wuZUwh7cK3e8pfM
X-Google-Smtp-Source: AGHT+IEcgwhtOpx1Oynnb+DLLdS5yPI+qqFyS+sMQ/xuGcZjH4DMqhjo44SIeURueUn5WmZ+71uL7Q==
X-Received: by 2002:a05:6a21:3414:b0:1cf:2901:2506 with SMTP id adf61e73a8af0-1d4fa663e54mr17152879637.14.1727719258796;
        Mon, 30 Sep 2024 11:00:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:58 -0700 (PDT)
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
Subject: [PATCH net-next 12/13] net: ibm: emac: mal: use devm for kzalloc
Date: Mon, 30 Sep 2024 11:00:35 -0700
Message-ID: <20240930180036.87598-13-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/mal.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index a632d3a207d3..70019ced47ff 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -524,7 +524,8 @@ static int mal_probe(struct platform_device *ofdev)
 	unsigned long irqflags;
 	irq_handler_t hdlr_serr, hdlr_txde, hdlr_rxde;
 
-	mal = kzalloc(sizeof(struct mal_instance), GFP_KERNEL);
+	mal = devm_kzalloc(&ofdev->dev, sizeof(struct mal_instance),
+			   GFP_KERNEL);
 	if (!mal)
 		return -ENOMEM;
 
@@ -539,8 +540,7 @@ static int mal_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "mal%d: can't find MAL num-tx-chans property!\n",
 		       index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	mal->num_tx_chans = prop[0];
 
@@ -549,8 +549,7 @@ static int mal_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "mal%d: can't find MAL num-rx-chans property!\n",
 		       index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	mal->num_rx_chans = prop[0];
 
@@ -558,15 +557,13 @@ static int mal_probe(struct platform_device *ofdev)
 	if (dcr_base == 0) {
 		printk(KERN_ERR
 		       "mal%d: can't find DCR resource!\n", index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	mal->dcr_host = dcr_map(ofdev->dev.of_node, dcr_base, 0x100);
 	if (!DCR_MAP_OK(mal->dcr_host)) {
 		printk(KERN_ERR
 		       "mal%d: failed to map DCRs !\n", index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
@@ -577,8 +574,7 @@ static int mal_probe(struct platform_device *ofdev)
 #else
 		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
 				ofdev->dev.of_node);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 #endif
 	}
 
@@ -711,9 +707,6 @@ static int mal_probe(struct platform_device *ofdev)
 	free_netdev(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
- fail:
-	kfree(mal);
-
 	return err;
 }
 
@@ -744,10 +737,9 @@ static void mal_remove(struct platform_device *ofdev)
 
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
-			  (NUM_TX_BUFF * mal->num_tx_chans +
-			   NUM_RX_BUFF * mal->num_rx_chans), mal->bd_virt,
-			  mal->bd_dma);
-	kfree(mal);
+				  (NUM_TX_BUFF * mal->num_tx_chans +
+				   NUM_RX_BUFF * mal->num_rx_chans),
+			  mal->bd_virt, mal->bd_dma);
 }
 
 static const struct of_device_id mal_platform_match[] =
-- 
2.46.2


