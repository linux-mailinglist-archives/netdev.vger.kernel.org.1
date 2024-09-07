Return-Path: <netdev+bounces-126250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32119703AD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FA31C22024
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076D16BE3D;
	Sat,  7 Sep 2024 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W07b9MvX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205116B753;
	Sat,  7 Sep 2024 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734745; cv=none; b=ZpoEvfsstowSL6LPV2e7RSyq339V3nkeFPXEUUdQ6LstLf/NjX0xSTapssX22Z2dLsqaTTMXdn/Y3ThXIcPYc/VHZkijr8W0+q/4Te24uv60/KjEyybwAvdi80JSwDwuHo6pM9qcFGMTRy582TfXe4IkFsJqHOZmX/ujnd8Wd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734745; c=relaxed/simple;
	bh=htFJczQBC5rEtS7kPHsKmvPAnNb8//6juyMT8SK6VOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avB+KJe01/4Ywvv4cm6T9FmVKDi3OIZl5eqrnGXi2qmPDAKsxgTzollzNqZVqyRUcmv4RqpJ9J6NCu0fm9VwtW7YrriHSxv3coIi2xhda9uk7nbdVRZsp/tFADsB4bvDTAQ8yH6X8jhCBg9zlXIM2Q816qjFIKqX6TORkWefCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W07b9MvX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20573eb852aso27880865ad.1;
        Sat, 07 Sep 2024 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734743; x=1726339543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5q8e8n9KsYoPsMGj6nbgya2hNhp7CeYD/WbpHI448E=;
        b=W07b9MvXFn7zm3DoYeRCA0Iyt74C34YHp5F4WsjbUUTkERj0Ml3y5AkZB3EIjpzriO
         sbX/geSm9MRaaLX0joRN0+/s8LCQTJEbJ/tNcpHB85SRO4iWOLH23bDlxeLbFXBnFWQz
         U8mP3LMhzOzqAXym8H3e3TWNu7C64pvnErYQKhy9gMV+aeia553VelDx26NfoPy5nn0/
         SJNNM8Doknrbs2Kl1DBq8Q+1lLGfGkIBzWYlaXTAutU3mJotqURY/1mNNoKxf49he68h
         g96RQdyOW8TBnSPMWTmz5Yrk23N+WmZVV2U192lH9ZRPzrbbm+P256yqoXFg2gXB3ISm
         xPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734743; x=1726339543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5q8e8n9KsYoPsMGj6nbgya2hNhp7CeYD/WbpHI448E=;
        b=b+Ip0Cy3ROcEC32+NH6kN8V+neFvA63M6t//MaHWD2iHf2JwjsgZLK0nFKsypgNbvd
         +XNm9KMZ6wh60cySlYMn6sVoSYu2Isg2INI5qGZ9U8tc13+wqlz/RdZ7EukfE+e8zChB
         zxXdWwje/hd8yEUFT2p2EXtZwveqPqRAFqRjvBXmAF7Dutt85bRNLhO6oa8NqSwEGt7J
         8i05wJ5nWyCcewM2XZ1+ukgTPzau+c2nh1yIL3IF13cKtHT4Z0A2a8me1uFeGEHVu0px
         JsBRUrwYSrOdyRZi2cBWuWjmN3vabC4fOlkE1+q8EN1gdfjMvZBqAIr0QXoiIPjSQUK+
         C6JA==
X-Forwarded-Encrypted: i=1; AJvYcCV2QaKKS7u0yE7BYlJYjXOsR7lqF/9UrYL3tFV3TEMgpjr4lvmrhpuAPm8IiEAusGXe9zbVqzYfC3UOq6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXc+iPfEt/bDUMIUDAOD5+UWBJG3W6zvKQffhgKMLmilkv9gd
	lIIHhRUoGBNKTS2StPcpiNfjfWg+xk6ZKLRW0ghN3Bn9+eGF1G90mgR8wr+I
X-Google-Smtp-Source: AGHT+IE6nlPUY/0W+5uQtFTAQLojtcqVvX1Va+CfWhAzdhVlwLn8feN0Olk/Elp8W8UJdTXu2l0aWQ==
X-Received: by 2002:a17:903:98b:b0:1fd:8dfd:3553 with SMTP id d9443c01a7336-206b8372f27mr205793085ad.18.1725734743073;
        Sat, 07 Sep 2024 11:45:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:42 -0700 (PDT)
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
Subject: [PATCHv4 net-next 7/8] net: ibm: emac: remove all waiting code
Date: Sat,  7 Sep 2024 11:45:27 -0700
Message-ID: <20240907184528.8399-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
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
index 7270d7d07350..57831583ebde 100644
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


