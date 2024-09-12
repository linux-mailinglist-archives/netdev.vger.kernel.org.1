Return-Path: <netdev+bounces-127648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB8975F34
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4871F23FE2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13D186E30;
	Thu, 12 Sep 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFkOecj2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056D18454E;
	Thu, 12 Sep 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109360; cv=none; b=Vsr0H1QJaZcM94dO2fVy4KlGoYbwSqwmmgHzpWoLijn5kIQD2a6bT73MkuHI1MINZ/QTRehXDMK5c4EiTwPOtPqBQICUEk/lmQZYbgsE/M9FAgIub4TUzQLDD1EOSxa33go73HxD0KK4AuUh8pcDE1aSRsjNIPiWZEmhSWDR7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109360; c=relaxed/simple;
	bh=MpKQum0tr3BS9RUq7x1/3dRFKuJ8n1B3Rp374A6OKCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRbjeOLiAG0s+q1gpH5el/iLNKfQcbnfxO1MvVCxddaYXYtlFY9qHD/lySvEKRzJA9NrqnsOltfeaDISVHLPL6kkYfIh5peoOvbWB9XUL+yA4OS+2qRV7VvFqtVLLdmkG5Y2iKhxF9LHi4YP//uptin1ehrDfQDGvtqebVyk52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFkOecj2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so293398a91.1;
        Wed, 11 Sep 2024 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109358; x=1726714158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHbY3iXU6oTg8xBbw7cLs3EtU4xaU9OWnxt/k7vTmRI=;
        b=PFkOecj28E/q0kjUOlVTeJzeOx90LC096Fm7QaBCN/4joIZh0VMAu4jG1rPC2u2pGw
         DNrRQVLRgyJ6biehDx0q9iLDbLscaZzaFicRTMD/bEf07kOOeEWJCR3RKzMWaqgfAs3N
         o2ulqkUjqRC5wQoCHJURKniGpZ80Sc9pzy+Lmy1nif4y3Pp4ABLDpHjTzW96deEDx4bD
         kuDsu1ICheXqNbEQnaOTwnJnN663qkS3cctxsnnJLc4eKWtr4reixCgHZMewb4gg/7dv
         hdXVoAuDT30HzsFNuaa3EiaWcy9bySHTSxQViBL+tRonaOs8HD0AimyMJaP3hodxbUFX
         ZcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109358; x=1726714158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHbY3iXU6oTg8xBbw7cLs3EtU4xaU9OWnxt/k7vTmRI=;
        b=C15C/KBa5WOYc+5YxvImx+szXHpVnGD8C0Ef00xYe3viUfpfpMwIlcpxyIV976+Ddd
         vonVfwA0u97g1s3JW8LEhfi9ZvtHnsC9nYbPsuuH6G1eu/O3t47IEOX5WDJM6G0lEoWc
         Y9dWPBK9X6y5oOOMIngj5z7QEEDCx3e+XRkM3rfxEjZKpigWy5dedsr190NdEllRvCKx
         h9OnZhWYy4gLwPh+EGZWEfGMuTLQpSj0enqwf7VcVLUD+dUUMEm8upFInV7vdllqgWv3
         AZv2dnGEbJ/Yzgd8hmhxC+CvrSfBksBetW32VzmRL1nAaf6c4hzwVpVJwWHI4WRNAeNg
         PCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0lgOUm+zvnnP7dZJwHGTWXq31MLDyE8Yxwe5bn2Gy1TOUDWikphb1pc9eqNyAvfMSnDqS9DSQ7BYGQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauLLbPj3OyExHZAFYBqwSwXErN/UWatUxsLF8cxxi2d/kQVFH
	OMyxlxVl6NX8GaXcshqJnQbLdu5K4roLdxhWRh0MPMwFIp54bKsssFdulZEk
X-Google-Smtp-Source: AGHT+IFHI+tv4FqYFefd5/J4FcwpjjrphiiIcuVrtRcQN9xJFjQCoJV00A1NFHST+OPRYnYBesqcjQ==
X-Received: by 2002:a17:90a:ee86:b0:2d8:719d:98a2 with SMTP id 98e67ed59e1d1-2db9fc5416bmr2016564a91.7.1726109358136;
        Wed, 11 Sep 2024 19:49:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:17 -0700 (PDT)
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
Subject: [PATCHv5 net-next 8/9] net: ibm: emac: remove all waiting code
Date: Wed, 11 Sep 2024 19:49:02 -0700
Message-ID: <20240912024903.6201-9-rosenp@gmail.com>
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

EPROBE_DEFER, which probably wasn't available when this driver was
written, can be used instead of waiting manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 55 ++++------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 6556f9b2b48f..60c4943ca09d 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -32,7 +32,6 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/bitops.h>
-#include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -96,11 +95,6 @@ MODULE_LICENSE("GPL");
 static u32 busy_phy_map;
 static DEFINE_MUTEX(emac_phy_map_lock);
 
-/* This is the wait queue used to wait on any event related to probe, that
- * is discovery of MALs, other EMACs, ZMII/RGMIIs, etc...
- */
-static DECLARE_WAIT_QUEUE_HEAD(emac_probe_wait);
-
 /* Having stable interface names is a doomed idea. However, it would be nice
  * if we didn't have completely random interface names at boot too :-) It's
  * just a matter of making everybody's life easier. Since we are doing
@@ -116,9 +110,6 @@ static DECLARE_WAIT_QUEUE_HEAD(emac_probe_wait);
 #define EMAC_BOOT_LIST_SIZE	4
 static struct device_node *emac_boot_list[EMAC_BOOT_LIST_SIZE];
 
-/* How long should I wait for dependent devices ? */
-#define EMAC_PROBE_DEP_TIMEOUT	(HZ * 5)
-
 /* I don't want to litter system log with timeout errors
  * when we have brain-damaged PHY.
  */
@@ -973,8 +964,6 @@ static void __emac_set_multicast_list(struct emac_instance *dev)
 	 * we need is just to stop RX channel. This seems to work on all
 	 * tested SoCs.                                                --ebs
 	 *
-	 * If we need the full reset, we might just trigger the workqueue
-	 * and do it async... a bit nasty but should work --BenH
 	 */
 	dev->mcast_pending = 0;
 	emac_rx_disable(dev);
@@ -2378,7 +2367,9 @@ static int emac_check_deps(struct emac_instance *dev,
 		if (deps[i].drvdata != NULL)
 			there++;
 	}
-	return there == EMAC_DEP_COUNT;
+	if (there != EMAC_DEP_COUNT)
+		return -EPROBE_DEFER;
+	return 0;
 }
 
 static void emac_put_deps(struct emac_instance *dev)
@@ -2390,19 +2381,6 @@ static void emac_put_deps(struct emac_instance *dev)
 	platform_device_put(dev->tah_dev);
 }
 
-static int emac_of_bus_notify(struct notifier_block *nb, unsigned long action,
-			      void *data)
-{
-	/* We are only intereted in device addition */
-	if (action == BUS_NOTIFY_BOUND_DRIVER)
-		wake_up_all(&emac_probe_wait);
-	return 0;
-}
-
-static struct notifier_block emac_of_bus_notifier = {
-	.notifier_call = emac_of_bus_notify
-};
-
 static int emac_wait_deps(struct emac_instance *dev)
 {
 	struct emac_depentry deps[EMAC_DEP_COUNT];
@@ -2419,18 +2397,13 @@ static int emac_wait_deps(struct emac_instance *dev)
 		deps[EMAC_DEP_MDIO_IDX].phandle = dev->mdio_ph;
 	if (dev->blist && dev->blist > emac_boot_list)
 		deps[EMAC_DEP_PREV_IDX].phandle = 0xffffffffu;
-	bus_register_notifier(&platform_bus_type, &emac_of_bus_notifier);
-	wait_event_timeout(emac_probe_wait,
-			   emac_check_deps(dev, deps),
-			   EMAC_PROBE_DEP_TIMEOUT);
-	bus_unregister_notifier(&platform_bus_type, &emac_of_bus_notifier);
-	err = emac_check_deps(dev, deps) ? 0 : -ENODEV;
+	err = emac_check_deps(dev, deps);
 	for (i = 0; i < EMAC_DEP_COUNT; i++) {
 		of_node_put(deps[i].node);
 		if (err)
 			platform_device_put(deps[i].ofdev);
 	}
-	if (err == 0) {
+	if (!err) {
 		dev->mal_dev = deps[EMAC_DEP_MAL_IDX].ofdev;
 		dev->zmii_dev = deps[EMAC_DEP_ZMII_IDX].ofdev;
 		dev->rgmii_dev = deps[EMAC_DEP_RGMII_IDX].ofdev;
@@ -3087,12 +3060,8 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Wait for dependent devices */
 	err = emac_wait_deps(dev);
-	if (err) {
-		printk(KERN_ERR
-		       "%pOF: Timeout waiting for dependent devices\n", np);
-		/*  display more info about what's missing ? */
+	if (err)
 		goto err_irq_unmap;
-	}
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
 		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
@@ -3192,10 +3161,6 @@ static int emac_probe(struct platform_device *ofdev)
 	wmb();
 	platform_set_drvdata(ofdev, dev);
 
-	/* There's a new kid in town ! Let's tell everybody */
-	wake_up_all(&emac_probe_wait);
-
-
 	printk(KERN_INFO "%s: EMAC-%d %pOF, MAC %pM\n",
 	       ndev->name, dev->cell_index, np, ndev->dev_addr);
 
@@ -3228,14 +3193,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
  err_gone:
-	/* if we were on the bootlist, remove us as we won't show up and
-	 * wake up all waiters to notify them in case they were waiting
-	 * on us
-	 */
-	if (blist) {
+	if (blist)
 		*blist = NULL;
-		wake_up_all(&emac_probe_wait);
-	}
 	return err;
 }
 
-- 
2.46.0


