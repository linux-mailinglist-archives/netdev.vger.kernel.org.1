Return-Path: <netdev+bounces-124705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F31C96A7AD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FABB237E1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B681DB938;
	Tue,  3 Sep 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elNm8rla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DE1D58AA;
	Tue,  3 Sep 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392607; cv=none; b=ogomeFu0ah9VEifdDWu+Xjfu/m9p6j/TKrlhhSFeQ3PBySJ2YmfxRq97NEP90GTb0e1h0gja5N74HPurMq90eBQBLEYtmxp6ETthxKuOvl2X7S2VxbOI1cC3xUFNYLXFSMj7J4fVlKyl0i4LBa7VMTi6gdi48JPkXjjDgKRqTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392607; c=relaxed/simple;
	bh=ak/7Xp3m4pxkz2pP3Zn59wCuaBHPoWVar2RPr0X1K24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COJC0iCJ5rwqlph3raFubQn+QclqcipW05UGGThK8GWBKGhcR9MDxVCHfUk0ZAg/HEbYbQkfC2Bxav/FIzabcew04oIagmmxebMOT8SFOwMa8vHnRReVj35R+9l75LoB+GSCp0TNIyngpHIbR8OTXXFF2hGdkHyDoqII5vtbGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elNm8rla; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201d5af11a4so50055405ad.3;
        Tue, 03 Sep 2024 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392605; x=1725997405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XV8JTTrQ+n17koZUnnvATzf/oJhYK0EfQN8SyVUPyk=;
        b=elNm8rlaP/sq4ewlh9jBGpchrh4PcTSzTyC61P9/nZ3elvHFl8Hi/3yeDjJPrqp/5z
         QqvDB1TjvPPuMWFokAYeOi5PR88HE6VWH7E6eYeA0sdruSvmj0Iuc5yIp0ogAHNfXCSw
         Q2JTpQ4UlrF6AvCVe4MRiSzwui9O8MILRYtpf2yJ622UNQNyY6B3IFw7MD9qeiX/0kWL
         yqG28xn/ylFQgZf4JNFKFKzSxQq6w0/KJiQaz02eg2omC3+1UXXD1tkkm06Q6oQgE9vE
         n/9JWDW6mbHB+pLDzDubLezxt31VOGRfq55kkU3ZTpuTlzeqDae++LGf386manK3VSaO
         YLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392605; x=1725997405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XV8JTTrQ+n17koZUnnvATzf/oJhYK0EfQN8SyVUPyk=;
        b=YJjUV1wzZOE+wTm/1rQFMm3euZtRNAgVkIvYKf9Rbmhkib71Wig6Ax1EqopU378QZA
         dihZgjRG8evegIZaePZBdBdMm4V2jfn7q+DgfR0zvcwYU4xcaCVbBDxEdSVjFo7VpeZm
         dp2yw+foMnITQ7ln/xN34GQEuvLRCdQfoSK7poQU9TFKIlX6OKIaoKTUD+RSsX02iUG2
         u0ZbiCcKZOLgFEsm3eWlQGszu6Zn6Of1aBgffbGjwOyX5SlDrY/C0MwD333W5v4MuNDG
         +gORhlcuEb59MUYBy1+ldC0KS5SjO5QevYYfnWkhSZfgu1XD1jHw+rseW/ITmVbF0PbH
         CV+A==
X-Forwarded-Encrypted: i=1; AJvYcCU29XP4DsDIPuqj529UdBtU2ifgwF9xoLVZD6MBCzj1ON5C1OEm+i3SWMWyXFaznbkvm6kbajiCOqql9A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLe9aMixjsfGlH+ZFcvJDzhjgStdLgNSaXUisV7O0AtajBfbO8
	ZjWml38IMewiyVSAtX4KrXEENfCO6ADKefg0PcHI7AVH9MwcYHigI7I8L5DG
X-Google-Smtp-Source: AGHT+IEji7zv5bJzaMjoJngvtD/kqPauLyrBVTIfFanCQoj6bha8Dh72TzqSsKeF9y+TMSZyla5IJA==
X-Received: by 2002:a17:903:2c7:b0:206:aac4:b844 with SMTP id d9443c01a7336-206aac4ba88mr22123545ad.6.1725392605437;
        Tue, 03 Sep 2024 12:43:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:25 -0700 (PDT)
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
Subject: [PATCHv2 net-next 8/8] net: ibm: emac: remove all waiting code
Date: Tue,  3 Sep 2024 12:42:44 -0700
Message-ID: <20240903194312.12718-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/core.c | 77 ++++++++--------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 6db76eeb4d9b..21401a8cb32c 100644
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
@@ -2419,26 +2397,25 @@ static int emac_wait_deps(struct emac_instance *dev)
 		deps[EMAC_DEP_MDIO_IDX].phandle = dev->mdio_ph;
 	if (dev->blist && dev->blist > emac_boot_list)
 		deps[EMAC_DEP_PREV_IDX].phandle = 0xffffffffu;
-	bus_register_notifier(&platform_bus_type, &emac_of_bus_notifier);
-	wait_event_timeout(emac_probe_wait,
-			   emac_check_deps(dev, deps),
-			   EMAC_PROBE_DEP_TIMEOUT);
-	bus_unregister_notifier(&platform_bus_type, &emac_of_bus_notifier);
-	err = emac_check_deps(dev, deps) ? 0 : -ENODEV;
+
+	err = emac_check_deps(dev, deps);
+	if (err)
+		return err;
+
 	for (i = 0; i < EMAC_DEP_COUNT; i++) {
 		of_node_put(deps[i].node);
-		if (err)
-			platform_device_put(deps[i].ofdev);
-	}
-	if (err == 0) {
-		dev->mal_dev = deps[EMAC_DEP_MAL_IDX].ofdev;
-		dev->zmii_dev = deps[EMAC_DEP_ZMII_IDX].ofdev;
-		dev->rgmii_dev = deps[EMAC_DEP_RGMII_IDX].ofdev;
-		dev->tah_dev = deps[EMAC_DEP_TAH_IDX].ofdev;
-		dev->mdio_dev = deps[EMAC_DEP_MDIO_IDX].ofdev;
+		platform_device_put(deps[i].ofdev);
 	}
+
+	dev->mal_dev = deps[EMAC_DEP_MAL_IDX].ofdev;
+	dev->zmii_dev = deps[EMAC_DEP_ZMII_IDX].ofdev;
+	dev->rgmii_dev = deps[EMAC_DEP_RGMII_IDX].ofdev;
+	dev->tah_dev = deps[EMAC_DEP_TAH_IDX].ofdev;
+	dev->mdio_dev = deps[EMAC_DEP_MDIO_IDX].ofdev;
+
 	platform_device_put(deps[EMAC_DEP_PREV_IDX].ofdev);
-	return err;
+
+	return 0;
 }
 
 static int emac_read_uint_prop(struct device_node *np, const char *name,
@@ -3084,12 +3061,8 @@ static int emac_probe(struct platform_device *ofdev)
 
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
@@ -3189,10 +3162,6 @@ static int emac_probe(struct platform_device *ofdev)
 	wmb();
 	platform_set_drvdata(ofdev, dev);
 
-	/* There's a new kid in town ! Let's tell everybody */
-	wake_up_all(&emac_probe_wait);
-
-
 	printk(KERN_INFO "%s: EMAC-%d %pOF, MAC %pM\n",
 	       ndev->name, dev->cell_index, np, ndev->dev_addr);
 
@@ -3225,14 +3194,8 @@ static int emac_probe(struct platform_device *ofdev)
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


