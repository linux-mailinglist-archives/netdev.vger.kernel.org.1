Return-Path: <netdev+bounces-131050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766098C71D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B769C284765
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839A1CF7B9;
	Tue,  1 Oct 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjnLrBlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEE1CF5D8;
	Tue,  1 Oct 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816337; cv=none; b=d4lVhBbFktjarW1mzb+iSRCHmHe80kpATKQdtE8LZd0JJ22YlB9RRFqJguTGs/hGPW5URaP1CZ8GDCfv811MWk1mzhV9M7xg1xkEsmtoABFmhLMzwImPvozJAKtn+AXJETXugxZppRSt01DiugAxkZF3BiSgRxQMaqb2etA0VAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816337; c=relaxed/simple;
	bh=8lBOVvzvGRf+RpMwtTpzh+BQKToFBXpodpfesW9+iz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHFjknaeUwrncM7BllfiCAFuDcTiYfc5Yb3BGoA9DLRt6Ib2ZjKmF2Wr6WwWbUJ2GdnS3zM7x1WgyFkI+DZzSK3veAgtW6DvzPMhSgRA40p7IT5tYAWj0XH48MMem6Bbt2qhX0rqFCm4OMnuUXrOQD9Nw+tJIDv/sPTmsipsyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjnLrBlE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7198de684a7so4220062b3a.2;
        Tue, 01 Oct 2024 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816335; x=1728421135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXiaXkjRmxS0jNHUrwUuLitPui/qQi7NdietjnRpv7U=;
        b=CjnLrBlEi1Y0CXWudvWHehfJQw78rbp6bctY+i/AcbyfaULV8qEyX8sx4Zn36kjEVd
         rwRo4svb/WqYvM7tJ/zdrIfn8uCEZs7ycDO1VjFV1T14O/93LSrMt0Ebmf8XWqmOteLm
         zUmd5IQ5rvVeNSGStfoGCOB/6WjyrWqg8l55UnVRF5LkmyuWBdPQyHcdkv33UFPecF5b
         cr50zaN3iABFmKbHbbs/OSahgrhfj/FeSI2kcuv3p/LjLkB7+XaNMKbXSRERWRje/z7J
         z15vrUwfz0QPC/sfN+N4ObZVn7Sl3bXeOKc58AklHErZP/Cd07IdxIr9IZUffwjGazdT
         aPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816335; x=1728421135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXiaXkjRmxS0jNHUrwUuLitPui/qQi7NdietjnRpv7U=;
        b=F2ZoeMGh1bVCsVoU68aY7YtFOWT++q1PfFjo1AXPk2O+8lQi1VPmE3xgdpw4t+AEkU
         ZZse6HUrZTFRUnlMspvgFpFIguRlO6AcIld8et7ML7old33pwNYzwXnqKpydHtyi5zZm
         2mdRIc1POcameKJn444J0Y1NZ504WeOE1l5esXxuAgCxrxiqS/Gbp5EWFScCpThF++qM
         mwZMUtRuSYIw6UB7fUos5BetFAEEkmv6bR9W2j3LG/+lwZCmJa1fGM+6gTlQcPaqedq3
         m4GkR2uvz6lgU0Elzxt5j+WeL7ZT3ZIPtmqNH+fPO3pxp2Vk9dbt/vEB2dV93yIaQ7E6
         DlRw==
X-Forwarded-Encrypted: i=1; AJvYcCX36dcPsfwOS7thXzVTfC85coZ3Xtfnpwtt7M1pWuOQRd2g9n7jkL+5U9KZK/WoYLMVUQNq1BW6t07xBag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXix1i/oHFWSfyVZ6743LhPITxxIF3D5su0iqCe1f1UCg/zd/i
	XiB/VwPj8aRzGVX7PID8neFv8S+L3ARZs21vcEKtiWWjYQWDJFwAOaF8Y4/p
X-Google-Smtp-Source: AGHT+IHw1Dz6EJChxmKwmosEiggoeMOWXKv3rXqOM8l95wzH+XBEQeYHac1io9tfpWa5jz5lVs+ydg==
X-Received: by 2002:a05:6a00:b8d:b0:70d:1b48:e362 with SMTP id d2e1a72fcca58-71dc5d6adcemr1218182b3a.26.1727816335164;
        Tue, 01 Oct 2024 13:58:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:54 -0700 (PDT)
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
Subject: [PATCHv2 net-next 06/18] net: ibm: emac: remove bootlist support
Date: Tue,  1 Oct 2024 13:58:32 -0700
Message-ID: <20241001205844.306821-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
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


