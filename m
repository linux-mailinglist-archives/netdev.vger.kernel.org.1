Return-Path: <netdev+bounces-105781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCB912D4F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1A01F2176F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E51684AA;
	Fri, 21 Jun 2024 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvvVw2pN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26C8820
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995211; cv=none; b=dwILw3t/VW09Z3swhRMud2OvBfQOwMZdjyVEQshHPXr2OA3Ud2ljn9rXwaG1ytMoN8S4WKkyfdNGLLF/7mvXGPodoQ8cmm8q/TSxgkFMAkQ7JOIroo+Nd3qbs8CrdsammvXu4a7DPMnfQkjCwSZhRxlr3r8w8aG9oEyVSzDQwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995211; c=relaxed/simple;
	bh=KdYeKBr4GE3XLiqNm9PoEa7iY9lF/A9jXufuvajDY0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdGIHIqjBFxHB4CN9XnjRXl7gO1Nd59Cg6gHhih91wbVrX/eeiWRHeENfhLKNzWLgNhoClEleriUz1w/9kv4z/dJyaLPemv0vbEuRDGutWGZREwDFdIKSLGL8RwCm6JcY+G4F3kcSnFvfkyfxrIVhyXYGCBro9rysEvXJloWMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvvVw2pN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70664eaa14aso32511b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995209; x=1719600009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P3Gdc0qfrmDJeJXUl6nP3lBuuq2/4cAEsXf9G6JMHY=;
        b=dvvVw2pNXL8FYa46lhJlAJlC+I/dKhBMUuZuIhtU/rD5f8qXdA7LoTjX+1WMyoES5R
         MsNuGy4LPg+5cQyVj8ZjZP8O5heLSK1l0UDZU0y5qkc6F17MmI655q/7mmBFre21yp/B
         2a/bU5XwOP+tBk6Zu+lepf4kpYzUWMn9MIKx0t1wUeeYlllvMfWlM7zSuqZ4UEb0xBVI
         BR1haV5d9nS3GzFCPielgYzk+dleJc6DFEp1sFmbbhVhNpEkVA7dCgj6RQTUoe+ostmG
         xfO6egrlVrUq4Tn9VQA6wsN1Tkm6D11r5Bo/343JBSh5SHX8zhd69rNsmyUuNzdHzlrz
         +wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995209; x=1719600009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P3Gdc0qfrmDJeJXUl6nP3lBuuq2/4cAEsXf9G6JMHY=;
        b=QQlFxRhewa/Y6zTexHZKxaYE2+W2Zz3UEOyBn62ooTJ2MVQ+hysCBA4uiU1nmPyMBi
         A7SCKA3vujSjwhX6ohrEoBPLMjPB75RmsAr8CKlEph5N/NegYupNjp/b78rC+s57KuFC
         wweC5cAXbS8RglfHM1059PJHbFwWjzeTppNwuEktGANkBh1Ghb0gr+1EVCLCwCcd5BFG
         kOwYmGbvzE3ZugbO2i3QIvy9UyIuMVdikk5pPWjoszlJ1mLk7ADwGvjfTicyFjX3jEQe
         UlAuUBWjKSb5RSCZxW+wuJo7pq386AVrK+wfZn1yxUGWKINCh1Iq5CCzuMkYZPVLxJg5
         jfxQ==
X-Gm-Message-State: AOJu0Yw1BDQeHV7HdoY/GD3GnVjrB5A3ASjVFsPex6kFjRlU0uQShZ2B
	hXcMa0jHOKTpTqs6dsE01dE/ID1cX0Xvzf5NFIyTSvxSWCg1j03obiHXDQ==
X-Google-Smtp-Source: AGHT+IFbIKXN5a1z73zw7UaGiDxe2V+RM1hIsn2p0D/nwx2DRSQyLdE0qlSuE0SZ3HWLhEX9PhXSuA==
X-Received: by 2002:a05:6a20:6702:b0:1b2:b3a5:22b2 with SMTP id adf61e73a8af0-1bcbb6abebdmr8873886637.60.1718995208856;
        Fri, 21 Jun 2024 11:40:08 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:08 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 01/15] net: alteon: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:33 -0700
Message-Id: <20240621183947.4105278-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621183947.4105278-1-allen.lkml@gmail.com>
References: <20240621183947.4105278-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the alteon driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/alteon/acenic.c | 26 +++++++++++++-------------
 drivers/net/ethernet/alteon/acenic.h |  8 ++++----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 3d8ac63132fb..9e6f91df2ba0 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -1560,9 +1560,9 @@ static void ace_watchdog(struct net_device *data, unsigned int txqueue)
 }
 
 
-static void ace_tasklet(struct tasklet_struct *t)
+static void ace_bh_work(struct work_struct *work)
 {
-	struct ace_private *ap = from_tasklet(ap, t, ace_tasklet);
+	struct ace_private *ap = from_work(ap, work, ace_bh_work);
 	struct net_device *dev = ap->ndev;
 	int cur_size;
 
@@ -1595,7 +1595,7 @@ static void ace_tasklet(struct tasklet_struct *t)
 #endif
 		ace_load_jumbo_rx_ring(dev, RX_JUMBO_SIZE - cur_size);
 	}
-	ap->tasklet_pending = 0;
+	ap->bh_work_pending = 0;
 }
 
 
@@ -1617,7 +1617,7 @@ static void ace_dump_trace(struct ace_private *ap)
  *
  * Loading rings is safe without holding the spin lock since this is
  * done only before the device is enabled, thus no interrupts are
- * generated and by the interrupt handler/tasklet handler.
+ * generated and by the interrupt handler/bh handler.
  */
 static void ace_load_std_rx_ring(struct net_device *dev, int nr_bufs)
 {
@@ -2160,7 +2160,7 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 	 */
 	if (netif_running(dev)) {
 		int cur_size;
-		int run_tasklet = 0;
+		int run_bh_work = 0;
 
 		cur_size = atomic_read(&ap->cur_rx_bufs);
 		if (cur_size < RX_LOW_STD_THRES) {
@@ -2172,7 +2172,7 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 				ace_load_std_rx_ring(dev,
 						     RX_RING_SIZE - cur_size);
 			} else
-				run_tasklet = 1;
+				run_bh_work = 1;
 		}
 
 		if (!ACE_IS_TIGON_I(ap)) {
@@ -2188,7 +2188,7 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 					ace_load_mini_rx_ring(dev,
 							      RX_MINI_SIZE - cur_size);
 				} else
-					run_tasklet = 1;
+					run_bh_work = 1;
 			}
 		}
 
@@ -2205,12 +2205,12 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 					ace_load_jumbo_rx_ring(dev,
 							       RX_JUMBO_SIZE - cur_size);
 				} else
-					run_tasklet = 1;
+					run_bh_work = 1;
 			}
 		}
-		if (run_tasklet && !ap->tasklet_pending) {
-			ap->tasklet_pending = 1;
-			tasklet_schedule(&ap->ace_tasklet);
+		if (run_bh_work && !ap->bh_work_pending) {
+			ap->bh_work_pending = 1;
+			queue_work(system_bh_wq, &ap->ace_bh_work);
 		}
 	}
 
@@ -2267,7 +2267,7 @@ static int ace_open(struct net_device *dev)
 	/*
 	 * Setup the bottom half rx ring refill handler
 	 */
-	tasklet_setup(&ap->ace_tasklet, ace_tasklet);
+	INIT_WORK(&ap->ace_bh_work, ace_bh_work);
 	return 0;
 }
 
@@ -2301,7 +2301,7 @@ static int ace_close(struct net_device *dev)
 	cmd.idx = 0;
 	ace_issue_cmd(regs, &cmd);
 
-	tasklet_kill(&ap->ace_tasklet);
+	cancel_work_sync(&ap->ace_bh_work);
 
 	/*
 	 * Make sure one CPU is not processing packets while
diff --git a/drivers/net/ethernet/alteon/acenic.h b/drivers/net/ethernet/alteon/acenic.h
index ca5ce0cbbad1..0e45a97b9c9b 100644
--- a/drivers/net/ethernet/alteon/acenic.h
+++ b/drivers/net/ethernet/alteon/acenic.h
@@ -2,7 +2,7 @@
 #ifndef _ACENIC_H_
 #define _ACENIC_H_
 #include <linux/interrupt.h>
-
+#include <linux/workqueue.h>
 
 /*
  * Generate TX index update each time, when TX ring is closed.
@@ -667,8 +667,8 @@ struct ace_private
 	struct rx_desc		*rx_mini_ring;
 	struct rx_desc		*rx_return_ring;
 
-	int			tasklet_pending, jumbo;
-	struct tasklet_struct	ace_tasklet;
+	int			bh_work_pending, jumbo;
+	struct work_struct	ace_bh_work;
 
 	struct event		*evt_ring;
 
@@ -776,7 +776,7 @@ static int ace_open(struct net_device *dev);
 static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev);
 static int ace_close(struct net_device *dev);
-static void ace_tasklet(struct tasklet_struct *t);
+static void ace_bh_work(struct work_struct *work);
 static void ace_dump_trace(struct ace_private *ap);
 static void ace_set_multicast_list(struct net_device *dev);
 static int ace_change_mtu(struct net_device *dev, int new_mtu);
-- 
2.34.1


