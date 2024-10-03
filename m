Return-Path: <netdev+bounces-131445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5B98E847
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E51288223
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1943980025;
	Thu,  3 Oct 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vaqd8u2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB16EB7C;
	Thu,  3 Oct 2024 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921509; cv=none; b=QyTZl+4piA8C3/xx+oplMofzW26InmxKKCxMcJDTLfI9rvVfjvlihT/PFDsWs+MJ2foBmfpv/+KWAFr8hwgYrsIaBuU1tL1LrN+JwKg7EnNNMHm16CkJUq6HhEI797zB4rDR7dnNWdCBXLXXWJfda+p6AURG33Bfn/jp+OT4QK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921509; c=relaxed/simple;
	bh=8lBOVvzvGRf+RpMwtTpzh+BQKToFBXpodpfesW9+iz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaqRVIfEZlItKDWJ7vV/m1Oi4no9r2XGxPWdcPsLOyYm3m2sOeUWGE5OIwptN+TGJtaLp9TiExzZqfvbI+XQnhgL9fE1gNtSQ8hNEd+1HzIRtrANvG5TSBcxtktAFrublt0UhXI/T+LFepEAVNtHi+GX+h4IUQ7+zJgLW5MpzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vaqd8u2v; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso309644a12.1;
        Wed, 02 Oct 2024 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921506; x=1728526306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXiaXkjRmxS0jNHUrwUuLitPui/qQi7NdietjnRpv7U=;
        b=Vaqd8u2vMfnud729RLIBWNzS3o33NXSv9XXGG67il6ANDgbyTE0TogjxDA1gdBNNhv
         5/La0ErMXSuJdwiGhRzpRzzlHzi+a9S3ygSGZTNpM3AyFjVtbAcXRK86iZBws477K6Yf
         azR4HA8O1omyLrlZk3WPvxFVbajl4pByzF0q/TUP7uEfALT7Bspp9qUVcQwnbXBXKCzc
         caANi+ajNSl5sBbc6PwtTNyl5DD6psz80APoDnBsL5/LiERiNEpISFE0g1wM2K5h41X4
         F5feEWHdmgdoRq0MZbQ29enbMlHy9Ha6x+mQUZ++JVmp+VfLhnZ+HUumEbCP5d92Mwfc
         Wbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921506; x=1728526306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXiaXkjRmxS0jNHUrwUuLitPui/qQi7NdietjnRpv7U=;
        b=ry9nWg7sZZf68VV4zXOD7xios+wdw+MmZu15g5jQJIV4RfWJtyt8RbUimbnrVPpNgT
         IXqmFQqYfYUqknLaGoh2B0AoZLn83RlElOLcz9Cr4vP4Rcpu82SHt/heYDF7w8Zx0l4z
         ijNrBY9ZG0cjYyJsCVZEoeHlWG/XmWETV33lQm7qa6Cy1L3Dzpq+0wL0aTu9/Il4ZWUT
         tBwiDEDdQdi8aXCKJUnHf/o8zsdQdtBUXS4oL4GT76EJxIyGOWQ1YSsx/dikDpp457N1
         +s1xaz8BN+1NgUllMlph2+yaHLrLxZdq3BHHJkVc+Y8c9rAbNJDOinhMqSZtHXta3ZHG
         Igwg==
X-Forwarded-Encrypted: i=1; AJvYcCVzBQWDWUmnPu5mV/DA0b94JYWm5czwYDJKHeEd8sp9Wwn+13KqrnCPEn9MMPzllqWA8sQ9QMnZgw1CPBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfrtlmnz6cgqhfNZAkHFU6ROTyOeb2ObjQ25akWMxqasMEx/l8
	6kVd0gRa7+PGFD//7sQXzeVW3PQkV+eocSXbZb8cIJlJVhSSnqWT60N31aTT
X-Google-Smtp-Source: AGHT+IGFsS6i+3uSHFMHJrovdIQx0ypzelbIrDNKVMbgXJtBZNCaRMM9fFgkuq5ZTUfNsQex5AZpOw==
X-Received: by 2002:a05:6a20:d74d:b0:1d0:3a28:7589 with SMTP id adf61e73a8af0-1d5e2c65741mr6591593637.24.1727921506495;
        Wed, 02 Oct 2024 19:11:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:46 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/17] net: ibm: emac: remove bootlist support
Date: Wed,  2 Oct 2024 19:11:24 -0700
Message-ID: <20241003021135.1952928-7-rosenp@gmail.com>
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

This seems to be mainly used for deterministic interfaces. systemd
already does this in userspace.

Allows simplifying the driver with a single module_platform_driver.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 117 +++------------------------
 1 file changed, 9 insertions(+), 108 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index a55e84eb1d4d..a4701e2f9f73 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -95,21 +95,6 @@ MODULE_LICENSE("GPL");
 static u32 busy_phy_map;
 static DEFINE_MUTEX(emac_phy_map_lock);
 
-/* Having stable interface names is a doomed idea. However, it would be nice
- * if we didn't have completely random interface names at boot too :-) It's
- * just a matter of making everybody's life easier. Since we are doing
- * threaded probing, it's a bit harder though. The base idea here is that
- * we make up a list of all emacs in the device-tree before we register the
- * driver. Every emac will then wait for the previous one in the list to
- * initialize before itself. We should also keep that list ordered by
- * cell_index.
- * That list is only 4 entries long, meaning that additional EMACs don't
- * get ordering guarantees unless EMAC_BOOT_LIST_SIZE is increased.
- */
-
-#define EMAC_BOOT_LIST_SIZE	4
-static struct device_node *emac_boot_list[EMAC_BOOT_LIST_SIZE];
-
 /* I don't want to litter system log with timeout errors
  * when we have brain-damaged PHY.
  */
@@ -2330,14 +2315,12 @@ struct emac_depentry {
 #define	EMAC_DEP_RGMII_IDX	2
 #define	EMAC_DEP_TAH_IDX	3
 #define	EMAC_DEP_MDIO_IDX	4
-#define	EMAC_DEP_PREV_IDX	5
-#define	EMAC_DEP_COUNT		6
+#define	EMAC_DEP_COUNT		5
 
 static int emac_check_deps(struct emac_instance *dev,
 			   struct emac_depentry *deps)
 {
 	int i, there = 0;
-	struct device_node *np;
 
 	for (i = 0; i < EMAC_DEP_COUNT; i++) {
 		/* no dependency on that item, allright */
@@ -2345,17 +2328,6 @@ static int emac_check_deps(struct emac_instance *dev,
 			there++;
 			continue;
 		}
-		/* special case for blist as the dependency might go away */
-		if (i == EMAC_DEP_PREV_IDX) {
-			np = *(dev->blist - 1);
-			if (np == NULL) {
-				deps[i].phandle = 0;
-				there++;
-				continue;
-			}
-			if (deps[i].node == NULL)
-				deps[i].node = of_node_get(np);
-		}
 		if (deps[i].node == NULL)
 			deps[i].node = of_find_node_by_phandle(deps[i].phandle);
 		if (deps[i].node == NULL)
@@ -2397,8 +2369,6 @@ static int emac_wait_deps(struct emac_instance *dev)
 		deps[EMAC_DEP_TAH_IDX].phandle = dev->tah_ph;
 	if (dev->mdio_ph)
 		deps[EMAC_DEP_MDIO_IDX].phandle = dev->mdio_ph;
-	if (dev->blist && dev->blist > emac_boot_list)
-		deps[EMAC_DEP_PREV_IDX].phandle = 0xffffffffu;
 	err = emac_check_deps(dev, deps);
 	for (i = 0; i < EMAC_DEP_COUNT; i++) {
 		of_node_put(deps[i].node);
@@ -2412,7 +2382,6 @@ static int emac_wait_deps(struct emac_instance *dev)
 		dev->tah_dev = deps[EMAC_DEP_TAH_IDX].ofdev;
 		dev->mdio_dev = deps[EMAC_DEP_MDIO_IDX].ofdev;
 	}
-	platform_device_put(deps[EMAC_DEP_PREV_IDX].ofdev);
 	return err;
 }
 
@@ -2993,8 +2962,7 @@ static int emac_probe(struct platform_device *ofdev)
 	struct net_device *ndev;
 	struct emac_instance *dev;
 	struct device_node *np = ofdev->dev.of_node;
-	struct device_node **blist = NULL;
-	int err, i;
+	int err;
 
 	/* Skip unused/unwired EMACS.  We leave the check for an unused
 	 * property here for now, but new flat device trees should set a
@@ -3003,21 +2971,14 @@ static int emac_probe(struct platform_device *ofdev)
 	if (of_property_read_bool(np, "unused") || !of_device_is_available(np))
 		return -ENODEV;
 
-	/* Find ourselves in the bootlist if we are there */
-	for (i = 0; i < EMAC_BOOT_LIST_SIZE; i++)
-		if (emac_boot_list[i] == np)
-			blist = &emac_boot_list[i];
-
 	/* Allocate our net_device structure */
-	err = -ENOMEM;
 	ndev = devm_alloc_etherdev(&ofdev->dev, sizeof(struct emac_instance));
 	if (!ndev)
-		goto err_gone;
+		return -ENOMEM;
 
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->ofdev = ofdev;
-	dev->blist = blist;
 	SET_NETDEV_DEV(ndev, &ofdev->dev);
 
 	/* Initialize some embedded data structures */
@@ -3029,16 +2990,15 @@ static int emac_probe(struct platform_device *ofdev)
 	/* Init various config data based on device-tree */
 	err = emac_init_config(dev);
 	if (err)
-		goto err_gone;
+		return err;
 
 	/* Setup error IRQ handler */
 	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-		dev_err_probe(&ofdev->dev, err, "failed to request IRQ %d",
-			      dev->emac_irq);
-		goto err_gone;
+		return dev_err_probe(&ofdev->dev, err,
+				     "failed to request IRQ %d", dev->emac_irq);
 	}
 
 	ndev->irq = dev->emac_irq;
@@ -3046,14 +3006,13 @@ static int emac_probe(struct platform_device *ofdev)
 	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(dev->emacp)) {
 		dev_err(&ofdev->dev, "can't map device registers");
-		err = PTR_ERR(dev->emacp);
-		goto err_gone;
+		return PTR_ERR(dev->emacp);
 	}
 
 	/* Wait for dependent devices */
 	err = emac_wait_deps(dev);
 	if (err)
-		goto err_gone;
+		return err;
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
 		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
@@ -3181,9 +3140,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_gone:
-	if (blist)
-		*blist = NULL;
 	return err;
 }
 
@@ -3237,59 +3193,4 @@ static struct platform_driver emac_driver = {
 	.remove_new = emac_remove,
 };
 
-static void __init emac_make_bootlist(void)
-{
-	struct device_node *np = NULL;
-	int j, max, i = 0;
-	int cell_indices[EMAC_BOOT_LIST_SIZE];
-
-	/* Collect EMACs */
-	while((np = of_find_all_nodes(np)) != NULL) {
-		u32 idx;
-
-		if (of_match_node(emac_match, np) == NULL)
-			continue;
-		if (of_property_read_bool(np, "unused"))
-			continue;
-		if (of_property_read_u32(np, "cell-index", &idx))
-			continue;
-		cell_indices[i] = idx;
-		emac_boot_list[i++] = of_node_get(np);
-		if (i >= EMAC_BOOT_LIST_SIZE) {
-			of_node_put(np);
-			break;
-		}
-	}
-	max = i;
-
-	/* Bubble sort them (doh, what a creative algorithm :-) */
-	for (i = 0; max > 1 && (i < (max - 1)); i++)
-		for (j = i; j < max; j++) {
-			if (cell_indices[i] > cell_indices[j]) {
-				swap(emac_boot_list[i], emac_boot_list[j]);
-				swap(cell_indices[i], cell_indices[j]);
-			}
-		}
-}
-
-static int __init emac_init(void)
-{
-	/* Build EMAC boot list */
-	emac_make_bootlist();
-
-	return platform_driver_register(&emac_driver);
-}
-
-static void __exit emac_exit(void)
-{
-	int i;
-
-	platform_driver_unregister(&emac_driver);
-
-	/* Destroy EMAC boot list */
-	for (i = 0; i < EMAC_BOOT_LIST_SIZE; i++)
-		of_node_put(emac_boot_list[i]);
-}
-
-module_init(emac_init);
-module_exit(emac_exit);
+module_platform_driver(emac_driver);
-- 
2.46.2


