Return-Path: <netdev+bounces-125680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77296E3C9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9061C22D90
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BA1A42C8;
	Thu,  5 Sep 2024 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRn/Mjvp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020A1A2570;
	Thu,  5 Sep 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567315; cv=none; b=EQF/59Ub1Gyg6hOhPIFEhwDqPKoaNqVmKBkYYmMz+OypNidVuaL87rLR56OYU5Ri3oNOU2NJUThmf2/ID2Wi8f4TqHnQOGcB9xczwT09meRfAGab5zw1ylVMIZYAEXqhM/I5ft3GpS3kqT/9oZdMcxVN5pIdyulJjyEVhsrm3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567315; c=relaxed/simple;
	bh=NMFwqK9P8DdVP/XR1YebegPCUBcEds6Hmqj33CwL7Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTjk1Y+wn8MvDyDDOA5jMI10FdQeQMtRNtU2U+lTMJAoXEQ+YSqIzIxIg+ubgIMjFzuACE/OU7oJwn5Nxwd+W1eXTht49Xhb/VDFgHbcW7N0tqBmdGmq7FQgVbcd/54mn36XYMi5WrgyTpt6bgK5/r461pVfGf4t3cnRlvTfVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRn/Mjvp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068acc8a4fso13624585ad.1;
        Thu, 05 Sep 2024 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567313; x=1726172113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8fL6/bDG5C4dR8XEsWsmydQA+3xhydB/w8ADOktWUI=;
        b=VRn/Mjvpq/kVGjUcF2KD6lmoGnWVtmZ3aVyLDTLCvI/5kEms1gzYhW/eGEdDG1agKq
         LamfKbYVhrKtZxYwXLRfd4ErNZSEONtASdWO7SiFslLYFXGtEsFhCiA8SI42ZZTaCe2l
         1Pdjfka1kYwGix5CswShBaSCZC2i50rhCHDjhWsrx6zy1MfmGZsgwZTuW3CrgJt52lGq
         gNQbQOGtOZIpx20pFBnb9fjQacC6lqfQOQh773drJ/EJzinBlJlr+Cp8sdI3mAhSl67f
         /w36efb6PMGqZk4SfezTk5n+Ot8DvgkDbm6RDAlSs4qs++K2/+pzGjYR+Lz2CA9rJxkW
         MplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567313; x=1726172113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8fL6/bDG5C4dR8XEsWsmydQA+3xhydB/w8ADOktWUI=;
        b=EABfbYc/Ux385M9PGfk0AeaEs52kt/SotXXlBcIjXGaGVzGbkZAt+HsZa1mtR7NWTF
         0pwwj5P7bZ1XSiyuJgenxZ5kobCLnRZ5Sfo96H5uKlMFlcHAlekveGznEj7/3Jjmg1xt
         vSfKZUX2UIVEf18VY1DMmlewEPpNBbFjFaLo78CUFDvaflBP9o8nv4YffThADMjFUJF2
         ZmsPd3Ybpa52497t0rw9Gyuk+InG3fx9ay6wrVjulcyVVc6zHf2+pgjr3FGxm5i9lrh/
         +/jxzGACdVFilDBBjjzmZ1dAos2vrv4kpynzlBJBYGphpN9k5INKFo2Gm1faUD/0BhxN
         gYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT6DWeJF4wJjA2GDMJwVHjqv/BDrhoTci3EOCUlRnOI71nEDIr9cZEAGeiPjbB9BL8N0gv7TGpu/jRua8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyND0tWIuF0VrbcN+i5Q/AIXmCB1E/ryP5BL0uk9pFbA1hb+mHr
	0wIZNp++IHLEEpAe50ma1zCg4LuoTTQ6u1KKW4Vd05Q85DQ7cXXGx3MHCb+n
X-Google-Smtp-Source: AGHT+IHS0rye7cxPWMkcywFbMLAAFeBhLyiPr6lbBCsHiJ/zAp4A+qq1e8uWMjs6mV4qC9fQey4IpQ==
X-Received: by 2002:a17:902:dace:b0:205:8b9e:965f with SMTP id d9443c01a7336-2058b9e9b17mr149871485ad.31.1725567313053;
        Thu, 05 Sep 2024 13:15:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv3 net-next 2/9] net: ibm: emac: manage emac_irq with devm
Date: Thu,  5 Sep 2024 13:14:59 -0700
Message-ID: <20240905201506.12679-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
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
---
 drivers/net/ethernet/ibm/emac/core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 348702f462bd..4e260abbaa56 100644
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
@@ -3082,6 +3070,14 @@ static int emac_probe(struct platform_device *ofdev)
 		err = -ENODEV;
 		goto err_gone;
 	}
+
+	/* Setup error IRQ handler */
+	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC", dev);
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "failed to request IRQ %d", dev->emac_irq);
+		goto err_gone;
+	}
+
 	ndev->irq = dev->emac_irq;
 
 	/* Map EMAC regs */
@@ -3237,8 +3233,6 @@ static int emac_probe(struct platform_device *ofdev)
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3284,9 +3278,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
-
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


