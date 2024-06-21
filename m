Return-Path: <netdev+bounces-105794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C25912D5E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E3D1F24A9D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1117B43D;
	Fri, 21 Jun 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXucRANH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728FD17C228
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995236; cv=none; b=WJ6zYhLYVBBjIjFMlgrlVa+zIkUy8+ainZzVgMAwVz9E8wF03k2qT7y2hgm3Ixxq2J6UnKmlb2Ne1ANDo3TUV1Fe6ba1MDy3FWCRVT9zi+F1HjzEfK3oorxSkAtmCTrmhzK8XhEG/poaiwVCPVuMo91+UBbEYifx0+vEcCr/LX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995236; c=relaxed/simple;
	bh=ZDz2LhFLQz9qCiesFC2yTihbYdhNV6oWS3LIkrpVToI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWuIJNVVD81+a6/LHN+4DH9jHvPhO3PVhgMagzQ0AlulvLrRyTmOGV+cpZUQ/8ZdlI7vEbGtFuYLlwFEQl7hDgNoCvMlQANUs70FS0vcJu13o1wQReNQmvUzf5kFBbLHTUaJVgaQNYYC59WpL+ripzxKgo/oRiVcA0B5nkrzs/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXucRANH; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b9706c84e5so1321431eaf.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995232; x=1719600032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbaKAp4rBypUxqcKQTtYdGFIU8vf1Ad+mxOnv6tDJnw=;
        b=GXucRANHkYR05DEb/K0CMLw89QLDrVWdxrkh8CdiYVhWnD/XlDYVNun4aoXYYcivrC
         NfjtnsE/7bJ5ZHFdBuJ/Xu1yzoTM8QGNxsJB7ILP9elq003hmhJAb0WnF5452Hags/Bc
         sdfBiDnm+8X6VJmGzuyRtZcKJpDEKmaHO8WinCZt7EjOLiwtxQA9TuogkuCOT/moyssU
         8ZnexpzTXNfkEuBDvjHjmH93FH5vzZvmQA2f0VWqaqN8mj086qaNp5gErT5U6W5klo8G
         AZj1SmBfvIEtY29ss52BQWdWzK5Kr0DYcp/qB2NAjDrFRhIetCQgw50bVncumfcN5zfm
         ftgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995232; x=1719600032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbaKAp4rBypUxqcKQTtYdGFIU8vf1Ad+mxOnv6tDJnw=;
        b=Ah6xVEIvvG63vZfGi0ZFKAyy4VOr61FLTYNI5in7o8A9ZorVy9S2s9pduj9EtS7P23
         127oBdbq3wTPDfhoUXo9dpNp2ZhrUkNnE7NTxKu81w78GpGMnXHTFPIfrL1b7u2/6OMS
         Op3uVOlRrQqSXDViZ8/Ts8K0zm4ctUgS3dqSgyP7u2mEaXs8eGAwqfj4dDVcgkBXYTTA
         i8ahpKOn8zJKmdBYwpv/jNUY07SqgacHlQGAAklv1ruFK6Nxl1hSrCzYwHXUKYNPa1b8
         EsHRcL8RXPjTeEWmF8nHPSlYfjRrdN7598o+SPZhJz4TRmBMLHTfIqqhEk0Ix1X9C/OI
         vlHw==
X-Gm-Message-State: AOJu0YzvC8So5okcWU5r5EK7rJj9SynSi7AlV+A/btrhvu29fI2TUbRg
	oIVsjYGRtR5bU23SlTMyzBPIVRx0oS4sGPnVs1u6YPsBf9FWx5/onqI35A==
X-Google-Smtp-Source: AGHT+IHAQ7Fke2ZSicPvJuVUoZ+eANTekKCxjLsgIoOIL/wXh/X5S46B9l7Pim8cGSvFSZK6TjHnaw==
X-Received: by 2002:a05:6358:7f01:b0:1a2:ada:2afe with SMTP id e5c5f4694b2df-1a20ada3140mr796735655d.11.1718995232319;
        Fri, 21 Jun 2024 11:40:32 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:31 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:45 -0700
Message-Id: <20240621183947.4105278-14-allen.lkml@gmail.com>
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
APIs throughout the jme driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/jme.c | 72 +++++++++++++++++++-------------------
 drivers/net/ethernet/jme.h |  8 ++---
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..b1a92b851b3b 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1141,7 +1141,7 @@ jme_dynamic_pcc(struct jme_adapter *jme)
 
 	if (unlikely(dpi->attempt != dpi->cur && dpi->cnt > 5)) {
 		if (dpi->attempt < dpi->cur)
-			tasklet_schedule(&jme->rxclean_task);
+			queue_work(system_bh_wq, &jme->rxclean_bh_work);
 		jme_set_rx_pcc(jme, dpi->attempt);
 		dpi->cur = dpi->attempt;
 		dpi->cnt = 0;
@@ -1182,9 +1182,9 @@ jme_shutdown_nic(struct jme_adapter *jme)
 }
 
 static void
-jme_pcc_tasklet(struct tasklet_struct *t)
+jme_pcc_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, pcc_task);
+	struct jme_adapter *jme = from_work(jme, work, pcc_bh_work);
 	struct net_device *netdev = jme->dev;
 
 	if (unlikely(test_bit(JME_FLAG_SHUTDOWN, &jme->flags))) {
@@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct *work)
 		jme_stop_shutdown_timer(jme);
 
 	jme_stop_pcc_timer(jme);
-	tasklet_disable(&jme->txclean_task);
-	tasklet_disable(&jme->rxclean_task);
-	tasklet_disable(&jme->rxempty_task);
+	disable_work_sync(&jme->txclean_bh_work);
+	disable_work_sync(&jme->rxclean_bh_work);
+	disable_work_sync(&jme->rxempty_bh_work);
 
 	if (netif_carrier_ok(netdev)) {
 		jme_disable_rx_engine(jme);
@@ -1304,7 +1304,7 @@ static void jme_link_change_work(struct work_struct *work)
 		rc = jme_setup_rx_resources(jme);
 		if (rc) {
 			pr_err("Allocating resources for RX error, Device STOPPED!\n");
-			goto out_enable_tasklet;
+			goto out_enable_bh_work;
 		}
 
 		rc = jme_setup_tx_resources(jme);
@@ -1326,22 +1326,22 @@ static void jme_link_change_work(struct work_struct *work)
 		jme_start_shutdown_timer(jme);
 	}
 
-	goto out_enable_tasklet;
+	goto out_enable_bh_work;
 
 err_out_free_rx_resources:
 	jme_free_rx_resources(jme);
-out_enable_tasklet:
-	tasklet_enable(&jme->txclean_task);
-	tasklet_enable(&jme->rxclean_task);
-	tasklet_enable(&jme->rxempty_task);
+out_enable_bh_work:
+	enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
 out:
 	atomic_inc(&jme->link_changing);
 }
 
 static void
-jme_rx_clean_tasklet(struct tasklet_struct *t)
+jme_rx_clean_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, rxclean_task);
+	struct jme_adapter *jme = from_work(jme, work, rxclean_bh_work);
 	struct dynpcc_info *dpi = &(jme->dpi);
 
 	jme_process_receive(jme, jme->rx_ring_size);
@@ -1374,9 +1374,9 @@ jme_poll(JME_NAPI_HOLDER(holder), JME_NAPI_WEIGHT(budget))
 }
 
 static void
-jme_rx_empty_tasklet(struct tasklet_struct *t)
+jme_rx_empty_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, rxempty_task);
+	struct jme_adapter *jme = from_work(jme, work, rxempty_bh_work);
 
 	if (unlikely(atomic_read(&jme->link_changing) != 1))
 		return;
@@ -1386,7 +1386,7 @@ jme_rx_empty_tasklet(struct tasklet_struct *t)
 
 	netif_info(jme, rx_status, jme->dev, "RX Queue Full!\n");
 
-	jme_rx_clean_tasklet(&jme->rxclean_task);
+	jme_rx_clean_bh_work(&jme->rxclean_bh_work);
 
 	while (atomic_read(&jme->rx_empty) > 0) {
 		atomic_dec(&jme->rx_empty);
@@ -1410,9 +1410,9 @@ jme_wake_queue_if_stopped(struct jme_adapter *jme)
 
 }
 
-static void jme_tx_clean_tasklet(struct tasklet_struct *t)
+static void jme_tx_clean_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, txclean_task);
+	struct jme_adapter *jme = from_work(jme, work, txclean_bh_work);
 	struct jme_ring *txring = &(jme->txring[0]);
 	struct txdesc *txdesc = txring->desc;
 	struct jme_buffer_info *txbi = txring->bufinf, *ctxbi, *ttxbi;
@@ -1510,12 +1510,12 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 
 	if (intrstat & INTR_TMINTR) {
 		jwrite32(jme, JME_IEVE, INTR_TMINTR);
-		tasklet_schedule(&jme->pcc_task);
+		queue_work(system_bh_wq, &jme->pcc_bh_work);
 	}
 
 	if (intrstat & (INTR_PCCTXTO | INTR_PCCTX)) {
 		jwrite32(jme, JME_IEVE, INTR_PCCTXTO | INTR_PCCTX | INTR_TX0);
-		tasklet_schedule(&jme->txclean_task);
+		queue_work(system_bh_wq, &jme->txclean_bh_work);
 	}
 
 	if ((intrstat & (INTR_PCCRX0TO | INTR_PCCRX0 | INTR_RX0EMP))) {
@@ -1538,9 +1538,9 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 	} else {
 		if (intrstat & INTR_RX0EMP) {
 			atomic_inc(&jme->rx_empty);
-			tasklet_hi_schedule(&jme->rxempty_task);
+			queue_work(system_bh_highpri_wq, &jme->rxempty_bh_work);
 		} else if (intrstat & (INTR_PCCRX0TO | INTR_PCCRX0)) {
-			tasklet_hi_schedule(&jme->rxclean_task);
+			queue_work(system_bh_highpri_wq, &jme->rxclean_bh_work);
 		}
 	}
 
@@ -1826,9 +1826,9 @@ jme_open(struct net_device *netdev)
 	jme_clear_pm_disable_wol(jme);
 	JME_NAPI_ENABLE(jme);
 
-	tasklet_setup(&jme->txclean_task, jme_tx_clean_tasklet);
-	tasklet_setup(&jme->rxclean_task, jme_rx_clean_tasklet);
-	tasklet_setup(&jme->rxempty_task, jme_rx_empty_tasklet);
+	INIT_WORK(&jme->txclean_bh_work, jme_tx_clean_bh_work);
+	INIT_WORK(&jme->rxclean_bh_work, jme_rx_clean_bh_work);
+	INIT_WORK(&jme->rxempty_bh_work, jme_rx_empty_bh_work);
 
 	rc = jme_request_irq(jme);
 	if (rc)
@@ -1914,9 +1914,9 @@ jme_close(struct net_device *netdev)
 	JME_NAPI_DISABLE(jme);
 
 	cancel_work_sync(&jme->linkch_task);
-	tasklet_kill(&jme->txclean_task);
-	tasklet_kill(&jme->rxclean_task);
-	tasklet_kill(&jme->rxempty_task);
+	cancel_work_sync(&jme->txclean_bh_work);
+	cancel_work_sync(&jme->rxclean_bh_work);
+	cancel_work_sync(&jme->rxempty_bh_work);
 
 	jme_disable_rx_engine(jme);
 	jme_disable_tx_engine(jme);
@@ -3020,7 +3020,7 @@ jme_init_one(struct pci_dev *pdev,
 	atomic_set(&jme->tx_cleaning, 1);
 	atomic_set(&jme->rx_empty, 1);
 
-	tasklet_setup(&jme->pcc_task, jme_pcc_tasklet);
+	INIT_WORK(&jme->pcc_bh_work, jme_pcc_bh_work);
 	INIT_WORK(&jme->linkch_task, jme_link_change_work);
 	jme->dpi.cur = PCC_P1;
 
@@ -3180,9 +3180,9 @@ jme_suspend(struct device *dev)
 	netif_stop_queue(netdev);
 	jme_stop_irq(jme);
 
-	tasklet_disable(&jme->txclean_task);
-	tasklet_disable(&jme->rxclean_task);
-	tasklet_disable(&jme->rxempty_task);
+	disable_work_sync(&jme->txclean_bh_work);
+	disable_work_sync(&jme->rxclean_bh_work);
+	disable_work_sync(&jme->rxempty_bh_work);
 
 	if (netif_carrier_ok(netdev)) {
 		if (test_bit(JME_FLAG_POLL, &jme->flags))
@@ -3198,9 +3198,9 @@ jme_suspend(struct device *dev)
 		jme->phylink = 0;
 	}
 
-	tasklet_enable(&jme->txclean_task);
-	tasklet_enable(&jme->rxclean_task);
-	tasklet_enable(&jme->rxempty_task);
+	enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
 
 	jme_powersave_phy(jme);
 
diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index 860494ff3714..73a8a1438340 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -406,11 +406,11 @@ struct jme_adapter {
 	spinlock_t		phy_lock;
 	spinlock_t		macaddr_lock;
 	spinlock_t		rxmcs_lock;
-	struct tasklet_struct	rxempty_task;
-	struct tasklet_struct	rxclean_task;
-	struct tasklet_struct	txclean_task;
+	struct work_struct	rxempty_bh_work;
+	struct work_struct	rxclean_bh_work;
+	struct work_struct	txclean_bh_work;
 	struct work_struct	linkch_task;
-	struct tasklet_struct	pcc_task;
+	struct work_struct	pcc_bh_work;
 	unsigned long		flags;
 	u32			reg_txcs;
 	u32			reg_txpfc;
-- 
2.34.1


