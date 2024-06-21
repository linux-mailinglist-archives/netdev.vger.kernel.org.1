Return-Path: <netdev+bounces-105795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D76912D5F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64951C238E8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293F17C202;
	Fri, 21 Jun 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjh5DWTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BB17B4E0
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995237; cv=none; b=k6caRCmR1vzLclJ51fVDZPJkyH7M4BNM9ouvFb5y3eIAMV9M48yYbQKiwKiRg3RxkOJMqRdd7yrrmDcQFfTWpRZcSFAB4v1MBWsDz1D+L7HygzzdNH3PIQR2801KRgCI6SOd1O6A39i1lFhkPaQpvTjyOKUvcKd37nF1qJKcExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995237; c=relaxed/simple;
	bh=x/RfIjlwpumUmDOu4Tf2V/YAEWwgje+MYgVG2elP/Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bri8qIAv2xQdj6B3Wa9UZI8XdD6De1IxPqBkwO1VZ6IaW9ysZviRUkJw9LYhQUL9jZeqvS+j0+0Pi0kEw324J/96bPlzex9+rdEKTTUPDRHM+UdSbUZHXFKIqbmIhp0rUINjvp0eM0nM4qVC+IQxtxnCq9HMsXY0CPqXUo42l14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjh5DWTk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-375fb45f465so8262885ab.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995234; x=1719600034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb9G2dJ7OPjt/ejkd8tb2g/z5QKcxicC+1X1lii3BoE=;
        b=bjh5DWTkEeHGH2lls/wy344iK1q/7irznb9xkyAjnuEB1X8tQAXe2hxnqGHv9M/r8l
         u/qlGZP6PwpmOpB1KmNK8QQSZ831hNGei0yFrEW8hnfSOYis9ApZJKnt0PC/AiEuaW9l
         GTB7rA3xYrZQTg3MtICWtl7BLAOPZDmTTuXZj/KkcswD7ByRBWQbSuMWhhyoZUJm9mp1
         DJ2mG2Dp3IU6hMpxX5iXfnPuwUsdbw96c6LlZ7/MlLdZrb8qbI0Nd9TwD4PwcpMTfD9i
         /YMCQC6jLcLRtRxhotMj0r3OnSB/4q3t/lngLc6TrT3O2L0ESOeZgnCt3EwKam8EExEQ
         d2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995234; x=1719600034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb9G2dJ7OPjt/ejkd8tb2g/z5QKcxicC+1X1lii3BoE=;
        b=CSytBXuJ7H0hXQ7KMA9sllTbtX53zZdgTmqpZZqwYNZCezlSRBNC5PAptIXzqZJ5GC
         1YuZP7wtXVvyIGZxyHUlMaaJ1Wtz1teRR8H1/B8IhrCLCB2B5GkxcYmhtLQHeYwYvESQ
         q8XkXmw7nJZoSPPYLMBtArld50GHttyxzTbj/OLRyVQdhuI4xsiHW8BviYnEFWzrejZ7
         mZIG1nwl6MpSsgIq9ChNhk+OV35Jla7N0eM35TPiqRjBAuKjWUCz6WxrmkOEBHXD3gjE
         fQ5hSpsnKUPnVOlpfcvVFt5yotp2zudOK/7GtV5c8M630BT+nzOKk0s3yWihDhjrPxqe
         P5ZA==
X-Gm-Message-State: AOJu0YxXnLysBjdeT0gNKfDJh8/pPWCjHsp/pn1iu9xxHaNbYYtfaHwI
	SqI2cIdv7SlZbRSWMvsEdUeL9kykNoc3iuSPN0r3PjTwsy4osqdn2qXPvw==
X-Google-Smtp-Source: AGHT+IH7PrcfRAxqAV1OyFW2pvCfaaedAQDXNoJmfVX7A4oO7V6fKUwVPLAHnOZ/xQNN2LHvWrqtGQ==
X-Received: by 2002:a92:c26c:0:b0:375:9e20:beef with SMTP id e9e14a558f8ab-3761d5023f3mr105030065ab.0.1718995234330;
        Fri, 21 Jun 2024 11:40:34 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:33 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 14/15] net: marvell: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:46 -0700
Message-Id: <20240621183947.4105278-15-allen.lkml@gmail.com>
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
APIs throughout the marvell driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  4 +---
 drivers/net/ethernet/marvell/skge.c             | 12 ++++++------
 drivers/net/ethernet/marvell/skge.h             |  3 ++-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 671368d2c77e..47fe71a8f57e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2628,9 +2628,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, __be16 l3_proto,
  * The number of sent descriptors is returned.
  * Per-thread access
  *
- * Called only from mvpp2_txq_done(), called from mvpp2_tx()
- * (migration disabled) and from the TX completion tasklet (migration
- * disabled) so using smp_processor_id() is OK.
+ * Called only from mvpp2_txq_done().
  */
 static inline int mvpp2_txq_sent_desc_proc(struct mvpp2_port *port,
 					   struct mvpp2_tx_queue *txq)
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index fcfb34561882..4448af079447 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3342,13 +3342,13 @@ static void skge_error_irq(struct skge_hw *hw)
 }
 
 /*
- * Interrupt from PHY are handled in tasklet (softirq)
+ * Interrupt from PHY are handled in bh work (softirq)
  * because accessing phy registers requires spin wait which might
  * cause excess interrupt latency.
  */
-static void skge_extirq(struct tasklet_struct *t)
+static void skge_extirq(struct work_struct *work)
 {
-	struct skge_hw *hw = from_tasklet(hw, t, phy_task);
+	struct skge_hw *hw = from_work(hw, work, phy_bh_work);
 	int port;
 
 	for (port = 0; port < hw->ports; port++) {
@@ -3389,7 +3389,7 @@ static irqreturn_t skge_intr(int irq, void *dev_id)
 	status &= hw->intr_mask;
 	if (status & IS_EXT_REG) {
 		hw->intr_mask &= ~IS_EXT_REG;
-		tasklet_schedule(&hw->phy_task);
+		queue_work(system_bh_wq, &hw->phy_bh_work);
 	}
 
 	if (status & (IS_XA1_F|IS_R1_F)) {
@@ -3937,7 +3937,7 @@ static int skge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->pdev = pdev;
 	spin_lock_init(&hw->hw_lock);
 	spin_lock_init(&hw->phy_lock);
-	tasklet_setup(&hw->phy_task, skge_extirq);
+	INIT_WORK(&hw->phy_bh_work, skge_extirq);
 
 	hw->regs = ioremap(pci_resource_start(pdev, 0), 0x4000);
 	if (!hw->regs) {
@@ -4035,7 +4035,7 @@ static void skge_remove(struct pci_dev *pdev)
 	dev0 = hw->dev[0];
 	unregister_netdev(dev0);
 
-	tasklet_kill(&hw->phy_task);
+	cancel_work_sync(&hw->phy_bh_work);
 
 	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask = 0;
diff --git a/drivers/net/ethernet/marvell/skge.h b/drivers/net/ethernet/marvell/skge.h
index f72217348eb4..0cf77f4b1c57 100644
--- a/drivers/net/ethernet/marvell/skge.h
+++ b/drivers/net/ethernet/marvell/skge.h
@@ -5,6 +5,7 @@
 #ifndef _SKGE_H
 #define _SKGE_H
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 /* PCI config registers */
 #define PCI_DEV_REG1	0x40
@@ -2418,7 +2419,7 @@ struct skge_hw {
 	u32	     	     ram_offset;
 	u16		     phy_addr;
 	spinlock_t	     phy_lock;
-	struct tasklet_struct phy_task;
+	struct work_struct   phy_bh_work;
 
 	char		     irq_name[]; /* skge@pci:000:04:00.0 */
 };
-- 
2.34.1


