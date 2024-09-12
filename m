Return-Path: <netdev+bounces-127642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25449975F28
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39B028574D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EB913D503;
	Thu, 12 Sep 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGqnJAij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A4126C0F;
	Thu, 12 Sep 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109351; cv=none; b=dY1Mb6rBc/EpIW09k5gcWj+VfxpcdISkYkXlvlVq64wADqWdATtVI/88GokR53Lu8gobkGJLWxgAUpyILTh1pEL7VtfvyjFu4GoiMPjpVKX/xyMObwqbygC8iWlDDLk5HyB5K2yrKbameXC67xCy7JdWBpVhocy/TKjd13EBxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109351; c=relaxed/simple;
	bh=sp7upOnKj9BWAZsQm3OTJSA5cb9EWu67dP5FR9B4uhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2oRp5XzR6FUUCk8aYeEGzOBWQ7EWsVk2HBlOy35X6aQHkYxO6bL10GLyAtF1oKhfFLFMAK4/YZGgiESIg597nLbnqCCCSYEdJsWtB+fmRY7fq6IQRm/tWU/GDDzxaPRDMw8fskE6c4dSk2s7R0bycZ5GfvibrTwOSlObQCijUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGqnJAij; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d88690837eso368346a91.2;
        Wed, 11 Sep 2024 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109349; x=1726714149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3Oz5YgiTX6XCFX9x34lSE/cTVjBYyM6D2G16QhUEzs=;
        b=RGqnJAijxjdo8/Kd4SrIvZTe/POI9anZvMdz3GyipEs62WFCiBNYBwKIrLpY/4gDBq
         JqqenFFyKtMlSJ1R4EfnWGNuj32/sz8CBoTCq+AbuwfoKN1Bn40ggLWGhjA7aaVUO9lK
         gV3TVZMg4gcfEn1Ykrhd18lBztKfEKXaabe8GcKsittDrtMC8Ybo6EvUknzL8YqQS7ua
         Cq0p/XuNDz+GmLLQJ0Hk5pvp+ecHZ8iOacH7lodabgjUNxacu6tJYhOWAb3nw+r/Rssj
         Psa293RSOyhzJ7FHZ2zK7xWyb7OVcmQ1ueMdwO4AdytzdRY8WZPimTrXcIrbVtxr9d8Y
         Bweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109349; x=1726714149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3Oz5YgiTX6XCFX9x34lSE/cTVjBYyM6D2G16QhUEzs=;
        b=j7G9hiZdY9DUGxmKGl3F9A23EqDn0LTni+0/jaU1a6XfqcYWvysnHyyqN/mlDbt+OI
         Zq2Vk96POGSvm51ORUQpfOU5YZ5I4jkwkZ0KGLioN7DF9N+J6T7U8yLpCy53elq5Vs+Z
         eYTHge91uWdTvLWf5US79je4QBIdqmIWGWkVirl6CuIaaYZiU1eia2USkFGXnzfPs63K
         mS6CrW4xLn0PAncORzdVqiQsRKtRetrW9XYwlmrcQ2mzLWbVdjMONv2uhQFZpHjvlA/f
         OPY38JCQZpjA4ls6wk0FyrOs8cBPU/Gf7ulx7RJqyxaPzt1HnP3ppSBI5wSfh4TOef8O
         jkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXef7V1CmvCDsXkjVZWfOTTULqGXkUcsgD5u8vJhazzecx0kwOGp3KZ7Y6Tkpe5e5fqoLLZvVSoqk79XXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5JcNTCl7grGF9DNeR3i2iweLqHxP24oLjRw2V65xNBIaAGhn
	sbkfdo3Fs4B6s40MOYrjxVMBgHavYuunD2+Y4E6co045RCZYNiM6CKuNaufW
X-Google-Smtp-Source: AGHT+IHnWZN3AMSyuf/njAe1gCegnP+9DEVmh3IonoUthg+YU0l/AxMvBDYDKsxNOmBk/UsHCwKOkA==
X-Received: by 2002:a17:90a:d903:b0:2d8:840b:9654 with SMTP id 98e67ed59e1d1-2dba007e059mr1398504a91.34.1726109349122;
        Wed, 11 Sep 2024 19:49:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:08 -0700 (PDT)
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
Subject: [PATCHv5 net-next 2/9] net: ibm: emac: manage emac_irq with devm
Date: Wed, 11 Sep 2024 19:48:56 -0700
Message-ID: <20240912024903.6201-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the last to go in remove. Safe to let devm handle it.

Also move request_irq to probe for clarity. It's removed in _remove not
close.

Use dev_err_probe instead of printk. Handles EPROBE_DEFER automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 29 +++++++++++-----------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 0e94b3899078..d1e1b3a09209 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1228,18 +1228,10 @@ static void emac_print_link_status(struct emac_instance *dev)
 static int emac_open(struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
-	int err, i;
+	int i;
 
 	DBG(dev, "open" NL);
 
-	/* Setup error IRQ handler */
-	err = request_irq(dev->emac_irq, emac_irq, 0, "EMAC", dev);
-	if (err) {
-		printk(KERN_ERR "%s: failed to request IRQ %d\n",
-		       ndev->name, dev->emac_irq);
-		return err;
-	}
-
 	/* Allocate RX ring */
 	for (i = 0; i < NUM_RX_BUFF; ++i)
 		if (emac_alloc_rx_skb(dev, i)) {
@@ -1293,8 +1285,6 @@ static int emac_open(struct net_device *ndev)
 	return 0;
  oom:
 	emac_clean_rx_ring(dev);
-	free_irq(dev->emac_irq, dev);
-
 	return -ENOMEM;
 }
 
@@ -1408,8 +1398,6 @@ static int emac_close(struct net_device *ndev)
 	emac_clean_tx_ring(dev);
 	emac_clean_rx_ring(dev);
 
-	free_irq(dev->emac_irq, dev);
-
 	netif_carrier_off(ndev);
 
 	return 0;
@@ -3082,6 +3070,16 @@ static int emac_probe(struct platform_device *ofdev)
 		err = -ENODEV;
 		goto err_gone;
 	}
+
+	/* Setup error IRQ handler */
+	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
+			       dev);
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "failed to request IRQ %d",
+			      dev->emac_irq);
+		goto err_gone;
+	}
+
 	ndev->irq = dev->emac_irq;
 
 	/* Map EMAC regs */
@@ -3237,8 +3235,6 @@ static int emac_probe(struct platform_device *ofdev)
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3284,9 +3280,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
-
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


