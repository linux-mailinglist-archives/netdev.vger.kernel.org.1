Return-Path: <netdev+bounces-131452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52698E855
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93B71F218B7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251013DDAA;
	Thu,  3 Oct 2024 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIdZGiY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333113D278;
	Thu,  3 Oct 2024 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921519; cv=none; b=JdnXfIFQBmT4GuBwtX0Z1xYgKy7PFJSCJVDjI9lizbBa0uag3Lfh9nT+7ZDgrP7Tv9GCUZF/WwWZH4wH98nJxbq7CGBm4qlJD48v0k//OCdoL32lTjFiPhJjcCuoQ9gz9hracbzflz/sLp3uxdmr7kAzcFNbLpwYEiXKIjSqq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921519; c=relaxed/simple;
	bh=kih75HuZ1ZXc3JQHkzwuj//sPN9nSONeRe7im09vADU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxuSLwTmhPWFpzCbuTIPXAncQPjWYz24Dx3nxNby5eCBPShOFpi0keNRNuPqYd+jQt5XjXPXj3lxkmfGNU2WYpFzyYDYO+IZfAZxYz1AZeRIG/6efunFQUWnCs2rSXi1wWGb9elz1+A0Lozsuh7NAw0xExgJFryqaOCWeyCF6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIdZGiY/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9b2449fd1so332071a12.1;
        Wed, 02 Oct 2024 19:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921516; x=1728526316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=UIdZGiY/sJ75tnNbPfgsvL5PsVo98IidP/umEsuSOZ2HltzY8s3+WH79OCyoX/51vI
         KSXY7WMxxw1DZhFnWdkRR0LBi1/o/7t6HT+lF+Izj4cjsxFKcWxnZe4AKPEk/4LB0IFR
         oIB0CwlCQzLHRFCGK6eOYk4ag1JYSDNouYKEU4c9jG2LQlgDSj4nXmpFd/6zflz6uQ7p
         91os//deSW/7wxWjPXOCzQEFEknN8C+/7CrWoFSvOtrfhLAr8aL2XSLTJWBbK1XuT0qp
         SVbpfmm+BIX90j4iIIfGzEhGe555307vfGilvVQMOHQpeMZyENpyjgiCPmnFJsodwnnS
         O5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921516; x=1728526316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=g0qwTqjfCqdM0e+A4F/F8OEr03REo5AyjiAav7vyUK73TZRsyvyZMl1DZrdSw1PaQ6
         hhkAvtPqMyqq1SPGmQcuial1gpTi0SR34ia7canHNSpL9urc6uWSusgPodd7Sy/2TMYC
         yHAYr6Xj8LcBbG8i4GtbVlrFTtfk5BKgn2H9wFy/bV2hND2xK7exLXpF3FKcAmlYnpIR
         Lm2L/meS02UKxqXbOeLY1ef3UuABiWRwPwHBmQYz8aoDAyjVsWe8JuqKLfBUcVfmR+Fv
         BZnig8xaJVzLYPEU3U8Svno5NZV0FF2rKdJl7A5M/mSyBgiCKCKpy9Mx0lW2K77Ex7PC
         SQTA==
X-Forwarded-Encrypted: i=1; AJvYcCVpjfdrS370SrxQxBmxA6UMo66VG/nrI8Rxq7HUSROUnz+RANh8Pv9AAYqta2kbY3gpvzWI+rZsDsMFrYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw206DXPREMKyt1VWEqdliLxQktdozBg0W4SJLdT14/lfAVhGn6
	ARFNrTxYj7kOoKcXRDyq9FaPSUxFQPIjgG6xN2fmCXDnWsAAbhtOQamkFay+
X-Google-Smtp-Source: AGHT+IFgniBy5CEEUKA5nE3PVz4GHW89zb7AIBIkBwVuv8ev2zcn0p/U6rKeH1pHjR1g7Qb9jXvHMA==
X-Received: by 2002:a05:6a20:6f08:b0:1d3:293d:4c5a with SMTP id adf61e73a8af0-1d5db176d8dmr7412040637.22.1727921516347;
        Wed, 02 Oct 2024 19:11:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:56 -0700 (PDT)
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
Subject: [PATCH net-next v3 13/17] net: ibm: emac: mal: use devm for kzalloc
Date: Wed,  2 Oct 2024 19:11:31 -0700
Message-ID: <20241003021135.1952928-14-rosenp@gmail.com>
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


