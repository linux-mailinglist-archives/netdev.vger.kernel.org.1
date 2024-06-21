Return-Path: <netdev+bounces-105790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AE912D5A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4721C23B6D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971817BB3F;
	Fri, 21 Jun 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5RXDamO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B417B41C
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995227; cv=none; b=VV5nqwfICMVy3kUiiZ07YHzTvsTeR3RBWjoandsoiohImqGRRxqYBX+IxWE2ypOh3ZtsM1XAco8pSNUEK11ZittGapaP6HDJoFfgcdmZHFX2CKNKNbtZqiS9pehbrpdgOjNdNN9xnFUeqXfAPm+QZakFUFZeoCsbCx7OEgJs9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995227; c=relaxed/simple;
	bh=5wCl1B1i8ji1xA4dADPfV0mjXWvLWyC2722XSPdktnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omOc+wmclacwHlHr+IhBEo1TFm1Ph1e7g5fg+chr5zYizAhxVrhDIbaTTGUymfuJNv38Zh+fTI7KGIoA3sO8Vah3z9+rd7xjc5VeKIbEUrmwrEuFWUEvWMzlCDRhH3QVr2a6EL1JgaYNVd92LGpU48qrr+A7/IAgeEzEb+Qfzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5RXDamO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70665289275so7687b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995224; x=1719600024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dhdHUZpgwd2/wkpVLwdxeMY04zoPfYMfPcgph0II3s=;
        b=S5RXDamOI0rqaMu8bqizaaXCKao3gXywTxPHDrXCD4aan0HWvVHae9+EZVkkKooazQ
         1glWofx2xtyo+XIclRTxfefwhJvkY/tXi/h4teJxR29V4bgWYAGjRGdCpfpbaviu0EeP
         C4P52cAv3bVoGl7P2t/poiqiS+s+IE3qRbNP1coi5Gm1/kVreL0d9+iBoZILIlebXcF5
         JDqGhapG8Q5MzRZSVEG/hJgBPqGFzn9JdNi3+/k67GGCCQ7p3v/c1FbczeZtfWRY/TAp
         JlxZRh6Pva10+sDaz6Gwx4dgSgIc3tMn2N9cEE6fWAkMkdvHaivj20cBiuwgk3Xnl4cF
         ccBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995224; x=1719600024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dhdHUZpgwd2/wkpVLwdxeMY04zoPfYMfPcgph0II3s=;
        b=X6L45FBf6SQe2RPNmZUJTES4CDbAjKmQknKn1U4LFUtKioBhaTgWb71TfNNy12dxnf
         wZWs6ZqyRuwMDS6SUtuUFWf+PGSKSM4oQfuiH1wk3pxn23C9QXvSY1LBd8DCVptYzbTa
         WikcaD+LQhoHebJ/T/gLPIcnqQWy6ivCTk8hq9Q+NatXdcx6/2L3SxowObegctVMUTFA
         Vq/nURIetyLTZtsM5XhPl+TPCWLq7HjgtTPwBfTBz5XUQfXD0VCXDgmtGjRKsPAz0OIP
         Wvj6eK8fYcicAN+Zn8gZv/HrBcrkt2pHzNzTQ6hQkfOtczteh6uojbBYxZb93Ckt3bVu
         1LsQ==
X-Gm-Message-State: AOJu0Yx7y8FTLlrZlnNGW/T2D7DSj1+ej/5xQ12W8HhMFwmwWkLO73Wv
	24p8RdLssEp7h4UumaQgsUtoGhtoZBElYTbawvhSqu9URuzl8OG6UludGg==
X-Google-Smtp-Source: AGHT+IH3cBqM7Rytn+HrC1gYhtEw3b7FlY/tfnWK0G9wRRuEMQA6Khf5LFrF0K0IYxn2ZzEMnNG3KA==
X-Received: by 2002:a05:6a20:975a:b0:1b6:63e8:7839 with SMTP id adf61e73a8af0-1bce645eb5amr711951637.7.1718995224382;
        Fri, 21 Jun 2024 11:40:24 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:23 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 09/15] net: sundance: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:41 -0700
Message-Id: <20240621183947.4105278-10-allen.lkml@gmail.com>
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
APIs throughout the dlink sundance driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/dlink/sundance.c | 41 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index 8af5ecec7d61..65dfd32a9656 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -86,6 +86,7 @@ static char *media[MAX_UNITS];
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
@@ -395,8 +396,8 @@ struct netdev_private {
 	unsigned int an_enable:1;
 	unsigned int speed;
 	unsigned int wol_enabled:1;			/* Wake on LAN enabled */
-	struct tasklet_struct rx_tasklet;
-	struct tasklet_struct tx_tasklet;
+	struct work_struct rx_bh_work;
+	struct work_struct tx_bh_work;
 	int budget;
 	int cur_task;
 	/* Multicast and receive mode. */
@@ -430,8 +431,8 @@ static void init_ring(struct net_device *dev);
 static netdev_tx_t start_tx(struct sk_buff *skb, struct net_device *dev);
 static int reset_tx (struct net_device *dev);
 static irqreturn_t intr_handler(int irq, void *dev_instance);
-static void rx_poll(struct tasklet_struct *t);
-static void tx_poll(struct tasklet_struct *t);
+static void rx_poll(struct work_struct *work);
+static void tx_poll(struct work_struct *work);
 static void refill_rx (struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
 static void netdev_error(struct net_device *dev, int intr_status);
@@ -541,8 +542,8 @@ static int sundance_probe1(struct pci_dev *pdev,
 	np->msg_enable = (1 << debug) - 1;
 	spin_lock_init(&np->lock);
 	spin_lock_init(&np->statlock);
-	tasklet_setup(&np->rx_tasklet, rx_poll);
-	tasklet_setup(&np->tx_tasklet, tx_poll);
+	INIT_WORK(&np->rx_bh_work, rx_poll);
+	INIT_WORK(&np->tx_bh_work, tx_poll);
 
 	ring_space = dma_alloc_coherent(&pdev->dev, TX_TOTAL_SIZE,
 			&ring_dma, GFP_KERNEL);
@@ -965,7 +966,7 @@ static void tx_timeout(struct net_device *dev, unsigned int txqueue)
 	unsigned long flag;
 
 	netif_stop_queue(dev);
-	tasklet_disable_in_atomic(&np->tx_tasklet);
+	disable_work_sync(&np->tx_bh_work);
 	iowrite16(0, ioaddr + IntrEnable);
 	printk(KERN_WARNING "%s: Transmit timed out, TxStatus %2.2x "
 		   "TxFrameId %2.2x,"
@@ -1006,7 +1007,7 @@ static void tx_timeout(struct net_device *dev, unsigned int txqueue)
 		netif_wake_queue(dev);
 	}
 	iowrite16(DEFAULT_INTR, ioaddr + IntrEnable);
-	tasklet_enable(&np->tx_tasklet);
+	enable_and_queue_work(system_bh_wq, &np->tx_bh_work);
 }
 
 
@@ -1058,9 +1059,9 @@ static void init_ring(struct net_device *dev)
 	}
 }
 
-static void tx_poll(struct tasklet_struct *t)
+static void tx_poll(struct work_struct *work)
 {
-	struct netdev_private *np = from_tasklet(np, t, tx_tasklet);
+	struct netdev_private *np = from_work(np, work, tx_bh_work);
 	unsigned head = np->cur_task % TX_RING_SIZE;
 	struct netdev_desc *txdesc =
 		&np->tx_ring[(np->cur_tx - 1) % TX_RING_SIZE];
@@ -1104,11 +1105,11 @@ start_tx (struct sk_buff *skb, struct net_device *dev)
 			goto drop_frame;
 	txdesc->frag.length = cpu_to_le32 (skb->len | LastFrag);
 
-	/* Increment cur_tx before tasklet_schedule() */
+	/* Increment cur_tx before bh_work is queued */
 	np->cur_tx++;
 	mb();
-	/* Schedule a tx_poll() task */
-	tasklet_schedule(&np->tx_tasklet);
+	/* Queue a tx_poll() bh work */
+	queue_work(system_bh_wq, &np->tx_bh_work);
 
 	/* On some architectures: explicitly flush cache lines here. */
 	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1 &&
@@ -1199,7 +1200,7 @@ static irqreturn_t intr_handler(int irq, void *dev_instance)
 					ioaddr + IntrEnable);
 			if (np->budget < 0)
 				np->budget = RX_BUDGET;
-			tasklet_schedule(&np->rx_tasklet);
+			queue_work(system_bh_wq, &np->rx_bh_work);
 		}
 		if (intr_status & (IntrTxDone | IntrDrvRqst)) {
 			tx_status = ioread16 (ioaddr + TxStatus);
@@ -1315,9 +1316,9 @@ static irqreturn_t intr_handler(int irq, void *dev_instance)
 	return IRQ_RETVAL(handled);
 }
 
-static void rx_poll(struct tasklet_struct *t)
+static void rx_poll(struct work_struct *work)
 {
-	struct netdev_private *np = from_tasklet(np, t, rx_tasklet);
+	struct netdev_private *np = from_work(np, work, rx_bh_work);
 	struct net_device *dev = np->ndev;
 	int entry = np->cur_rx % RX_RING_SIZE;
 	int boguscnt = np->budget;
@@ -1407,7 +1408,7 @@ static void rx_poll(struct tasklet_struct *t)
 	np->budget -= received;
 	if (np->budget <= 0)
 		np->budget = RX_BUDGET;
-	tasklet_schedule(&np->rx_tasklet);
+	queue_work(system_bh_wq, &np->rx_bh_work);
 }
 
 static void refill_rx (struct net_device *dev)
@@ -1819,9 +1820,9 @@ static int netdev_close(struct net_device *dev)
 	struct sk_buff *skb;
 	int i;
 
-	/* Wait and kill tasklet */
-	tasklet_kill(&np->rx_tasklet);
-	tasklet_kill(&np->tx_tasklet);
+	/* Wait and cancel bh work */
+	cancel_work_sync(&np->rx_bh_work);
+	cancel_work_sync(&np->tx_bh_work);
 	np->cur_tx = 0;
 	np->dirty_tx = 0;
 	np->cur_task = 0;
-- 
2.34.1


