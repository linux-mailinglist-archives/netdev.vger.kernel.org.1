Return-Path: <netdev+bounces-125686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4096E3D6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7C3287C5A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA621B81D3;
	Thu,  5 Sep 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFGaNdTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2F1B3F0A;
	Thu,  5 Sep 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567323; cv=none; b=pvD7izO21w6zyf0qjTu0PmrpKYZFOBO7q3mPFGPSUhTn/oW4BrPU8sOSpfZX+ysj/hQ5CaAoJ4BBqp8PNWBXvrusW1rR2AIDv+EE8Y0sqj/tHBTr2mDsjvCXd2GAnc1eaPQVuDynKnfcxtg9YnX/6Zu03/p9sHs4UMq2ku/GQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567323; c=relaxed/simple;
	bh=Izcm9WXuBSSAe9duMn6Eqyxy90GSfOeOTQxkNKg9EOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGM7yGHKV9O3sBgw9l7K3Yw87Am/iiiqXG/dTktQ3jQQI/RuOh+w2tsWcqhTua6X0XW1ZPv6xur8ypv04Jy9gg7steFOPvSU4+/++aCvNEKJAyWZcvJTrVxgMDaBS76bIdR2UnR7qHUUZz0iSGorF1ugst4hKudZx6yRjgJE8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFGaNdTE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso999967a12.1;
        Thu, 05 Sep 2024 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567321; x=1726172121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcjsOY959gV8Wql2beVgE2GRTWuYaOOOZlS0zc4YxNg=;
        b=PFGaNdTE/TOY2IQqt48vPLOl3fsN9SsX/opKoMU43FPL3g+Rls4ZCQzj2Ysm9MvRXA
         9ZbpqLbbZgKV21FJWiulITkdhD9Vqv6D/9iw8nd5IgXrWvr7guEWnlrY6rujvCifBJ0G
         sVhxihb5M5Wc3qjHe7OQAOFJMKzcc3COgh44ZtIU63BW12q3+9mk4zgVEMWXhH6KV9oK
         gFvBO1906UeCj109AYPmpq0CsG1RYrYO0+LHgIwdqR9MkZIAWU47wEieTTtT4RQZlhih
         j+1Clvcr0AsSqeOlzWu5btLXkF1xFFh6FwxGkLs9wHxvt1GDSs8n2wNn/S2RL3Rpl9ob
         BVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567321; x=1726172121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcjsOY959gV8Wql2beVgE2GRTWuYaOOOZlS0zc4YxNg=;
        b=ZESd3Qy9C67hLaXbVOvQqvgwFWgsjSB9EcILUGKCkdw52D6lW0CowBoErVuxYlqGtA
         k8rf2+UCV3SCCV2MarTIJ00C3sY+FHQ9zyXcC3fo9Ag72GXNZ/KScFbsDK/lxuAIp4Kx
         qMPpLiiUg4aLRAgRRPdCxPj8zemqIwfZ4OxaY+LucvKjfcLGDPS4oxJUPWV600HCjFOx
         Akw52nDWMrUYoZcqSsOiXfBS91TNhony85aTZUC+nBbRepJDAFy7kKhBzrT2NhhOPE3w
         mjZKS81bp4x4jBr3T0TjFcYcscFziZ9KbvJ3U1jRhZu0spGZsNCG6corcAgfKoPBdTq1
         5vVg==
X-Forwarded-Encrypted: i=1; AJvYcCXUKz8Vq2kk24wIw24EtAdbRRo3U+rJ0+cg/CJCqHuHuyx6hCqqai4wY+k0h0MVv3WyBhkxix1Mz1fA47w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIW2FoIW1Aqw/lDTuVC1EDdN1xGhjVpWSVZImlSh+ct9Whf/h
	kAqVdNtwkIkjCI5gvbppyCIFYAslpJN+dFGGTVRIQBJsBUYi9NhGxqSU8hYy
X-Google-Smtp-Source: AGHT+IGNXUyyf48sKzCqJnaGrN3KvCSxrJAsw+mag1+WvcQRokRgjCibmO6EYfsJ4m3JLa/oPzqIBg==
X-Received: by 2002:a17:902:e543:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-206f0535d23mr3464905ad.33.1725567320945;
        Thu, 05 Sep 2024 13:15:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:20 -0700 (PDT)
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
Subject: [PATCHv3 net-next 8/9] net: ibm: emac: remove all waiting code
Date: Thu,  5 Sep 2024 13:15:05 -0700
Message-ID: <20240905201506.12679-9-rosenp@gmail.com>
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

EPROBE_DEFER, which probably wasn't available when this driver was
written, can be used instead of waiting manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 55 ++++------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index f4126a1f1fff..c643e99e77d9 100644
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
@@ -3084,12 +3057,8 @@ static int emac_probe(struct platform_device *ofdev)
 
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
@@ -3189,10 +3158,6 @@ static int emac_probe(struct platform_device *ofdev)
 	wmb();
 	platform_set_drvdata(ofdev, dev);
 
-	/* There's a new kid in town ! Let's tell everybody */
-	wake_up_all(&emac_probe_wait);
-
-
 	printk(KERN_INFO "%s: EMAC-%d %pOF, MAC %pM\n",
 	       ndev->name, dev->cell_index, np, ndev->dev_addr);
 
@@ -3225,14 +3190,8 @@ static int emac_probe(struct platform_device *ofdev)
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


