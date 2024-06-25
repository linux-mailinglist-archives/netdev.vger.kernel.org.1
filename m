Return-Path: <netdev+bounces-106529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB90916A9A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11381C22CF1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFA16B725;
	Tue, 25 Jun 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZhhl33Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906E16D31C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326172; cv=none; b=qhgz+Z5q7mYgIpPUYAx33rfrSaAa9KdTyByPpXCMqzc3Xe+mIw/g7lBo8oifzBzsLaqet5TV3XZKXvXntezVNqQwNxxwhtqYykIIPsLlN4xE3f4euvlSH3v/GHl3yhwFSPthGzA5lf5Bbkl+hEQSRVd11VEPVfY+LFvZo0RU7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326172; c=relaxed/simple;
	bh=1OnZadhKu9O2cRWddyv59mS+d34XHzKVgb1tPssRrcQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elTDQtpHAkm2loficCpZkYmuV/g8YqlpYWOxGQKlKd4HlmA0y+ZWIzyM25vSdaokNdY4gUL2nca6ZOZo8lsJiGwkyx0rE4QmRsT2dSMPEPup1BzhLhzs5pL44TNymeMn588xCVLqbNYbgiF8oYtvBSN2GnbmDAVAT1iEePhfgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZhhl33Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f65a3abd01so45336345ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326169; x=1719930969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvw6zOS3LipfqlJ0d7VhIdaOri7+qCSPQkwuQyLr53I=;
        b=DZhhl33QmsyT1K82oG+AF+oQLd237X68pJl1DirubeqBaQRgC3FPW0JKeCIu3gEL3I
         Pd2H52PZKukXGUXqJdRI83slSTQr1kJ7BbsG9SwkD3sS62Z9Y6MvF+l6qQlCrLBDkyYZ
         TlgOZzrxG4r+kmWXnpaVSNfaSh/iRpvw3AiQH1xBre1cE4lFwWYpaEej1Q3UDoPrBefl
         8F7lmVnlNRhYsycTyCa/PRPK+1ZJazs/Yc+sRgZPmycYHN6FtLUMzVGO6aGjMemCfvzP
         kj++NISUeN/+CqOgJtOCjICQcV8y6sopK1P0wxkq+o+KyqbJTGBm8xbfUZIShJmUe81V
         4rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326169; x=1719930969;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvw6zOS3LipfqlJ0d7VhIdaOri7+qCSPQkwuQyLr53I=;
        b=abkGDWeHprC0MCdjLlFWBPMygUP0h4P6FRTEo2PEydoKGLfS/rhar9C74k3E7mMmaT
         SegSE8HICdl4GHbV25ifeQYze2cQpfmBxQDEQC8Hl77x1RCki7u2iji4jOM2zWlXqgR7
         MdJQQtr7D62F8Px1+hHCMhJhGEY2qJ59ZCUFcOtVns6j1OgQemWMCRBPlAiKujZmNwd3
         E42GodKeBLRCv3mCSNXrFdkr1f0EoyLFnNf1KGywwS15vD6m/x2Z0C3TB9iJtbqUxJ4X
         9S+aaNdLHoNO1RFNiYg+uSuT5GvN2gXhJQUCcSfO9G7ELX+BQLDkj/mqpWPAdwsgkAmH
         +L3g==
X-Gm-Message-State: AOJu0YzhyvAMi2RvkLWxvxIE3g1N4MIjIuiMqI/hAiR0Xvz0wecPALwf
	C+lZrDPG9dToRRinCoVb4s/RX4sCgghQ0MhAQ8O0w/uiZYEEHCx9qcq8FA==
X-Google-Smtp-Source: AGHT+IHHdcxJZkQijVbshh2W/Uf7O2GwjU/HNvwgs1d4uUxMweFEr7peuF8ZHcKrgOfpNIoDdGwn2g==
X-Received: by 2002:a17:902:d50b:b0:1fa:1599:385b with SMTP id d9443c01a7336-1fa23ecacc9mr113663295ad.22.1719326168332;
        Tue, 25 Jun 2024 07:36:08 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa048c6639sm67093355ad.268.2024.06.25.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:36:07 -0700 (PDT)
Subject: [net-next PATCH v2 08/15] eth: fbnic: Implement Tx queue
 alloc/start/stop/free
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:36:06 -0700
Message-ID: 
 <171932616693.3072535.3443360332489795241.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Implement basic management operations for Tx queues.
Allocate memory for submission and completion rings.
Learn how to start the queues, stop them, and wait for HW
to be idle.

We call HW rings "descriptor rings" (stored in ring->desc),
and SW context rings "buffer rings" (stored in ring->*_buf union).

This is the first patch which actually touches CSRs so add CSR
helpers.

No actual datapath / packet handling here, yet.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |   72 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    9 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |   19 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  429 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   22 +
 6 files changed, 542 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index da1333301d15..db423b3424ab 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -61,10 +61,18 @@
 #define FBNIC_INTR_CQ_REARM_INTR_RELOAD		CSR_BIT(30)
 #define FBNIC_INTR_CQ_REARM_INTR_UNMASK		CSR_BIT(31)
 
+#define FBNIC_INTR_RCQ_TIMEOUT(n) \
+				(0x00401 + 4 * (n))	/* 0x01004 + 16*n */
+#define FBNIC_INTR_RCQ_TIMEOUT_CNT		256
+#define FBNIC_INTR_TCQ_TIMEOUT(n) \
+				(0x00402 + 4 * (n))	/* 0x01008 + 16*n */
+#define FBNIC_INTR_TCQ_TIMEOUT_CNT		256
 #define FBNIC_CSR_END_INTR_CQ		0x007fe	/* CSR section delimiter */
 
 /* Global QM Tx registers */
 #define FBNIC_CSR_START_QM_TX		0x00800	/* CSR section delimiter */
+#define FBNIC_QM_TWQ_IDLE(n)		(0x00800 + (n)) /* 0x02000 + 4*n */
+#define FBNIC_QM_TWQ_IDLE_CNT			8
 #define FBNIC_QM_TWQ_DEFAULT_META_L	0x00818		/* 0x02060 */
 #define FBNIC_QM_TWQ_DEFAULT_META_H	0x00819		/* 0x02064 */
 
@@ -86,10 +94,16 @@ enum {
 #define FBNIC_QM_TQS_MTU_CTL0		0x0081d		/* 0x02074 */
 #define FBNIC_QM_TQS_MTU_CTL1		0x0081e		/* 0x02078 */
 #define FBNIC_QM_TQS_MTU_CTL1_BULK		CSR_GENMASK(13, 0)
+#define FBNIC_QM_TCQ_IDLE(n)		(0x00821 + (n)) /* 0x02084 + 4*n */
+#define FBNIC_QM_TCQ_IDLE_CNT			4
 #define FBNIC_QM_TCQ_CTL0		0x0082d		/* 0x020b4 */
 #define FBNIC_QM_TCQ_CTL0_COAL_WAIT		CSR_GENMASK(15, 0)
 #define FBNIC_QM_TCQ_CTL0_TICK_CYCLES		CSR_GENMASK(26, 16)
+#define FBNIC_QM_TQS_IDLE(n)		(0x00830 + (n)) /* 0x020c0 + 4*n */
+#define FBNIC_QM_TQS_IDLE_CNT			8
 #define FBNIC_QM_TQS_EDT_TS_RANGE	0x00849		/* 0x2124 */
+#define FBNIC_QM_TDE_IDLE(n)		(0x00853 + (n)) /* 0x0214c + 4*n */
+#define FBNIC_QM_TDE_IDLE_CNT			8
 #define FBNIC_QM_TNI_TDF_CTL		0x0086c		/* 0x021b0 */
 #define FBNIC_QM_TNI_TDF_CTL_MRRS		CSR_GENMASK(1, 0)
 #define FBNIC_QM_TNI_TDF_CTL_CLS		CSR_GENMASK(3, 2)
@@ -110,9 +124,15 @@ enum {
 
 /* Global QM Rx registers */
 #define FBNIC_CSR_START_QM_RX		0x00c00	/* CSR section delimiter */
+#define FBNIC_QM_RCQ_IDLE(n)		(0x00c00 + (n)) /* 0x03000 + 0x4*n */
+#define FBNIC_QM_RCQ_IDLE_CNT			4
 #define FBNIC_QM_RCQ_CTL0		0x00c0c		/* 0x03030 */
 #define FBNIC_QM_RCQ_CTL0_COAL_WAIT		CSR_GENMASK(15, 0)
 #define FBNIC_QM_RCQ_CTL0_TICK_CYCLES		CSR_GENMASK(26, 16)
+#define FBNIC_QM_HPQ_IDLE(n)		(0x00c0f + (n)) /* 0x0303c + 0x4*n */
+#define FBNIC_QM_HPQ_IDLE_CNT			4
+#define FBNIC_QM_PPQ_IDLE(n)		(0x00c13 + (n)) /* 0x0304c + 0x4*n */
+#define FBNIC_QM_PPQ_IDLE_CNT			4
 #define FBNIC_QM_RNI_RBP_CTL		0x00c2d		/* 0x030b4 */
 #define FBNIC_QM_RNI_RBP_CTL_MRRS		CSR_GENMASK(1, 0)
 #define FBNIC_QM_RNI_RBP_CTL_CLS		CSR_GENMASK(3, 2)
@@ -219,6 +239,8 @@ enum {
 /* TMI registers */
 #define FBNIC_CSR_START_TMI		0x04400	/* CSR section delimiter */
 #define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
+#define FBNIC_TMI_DROP_CTRL		0x04401		/* 0x11004 */
+#define FBNIC_TMI_DROP_CTRL_EN			CSR_BIT(0)
 #define FBNIC_CSR_END_TMI		0x0443f	/* CSR section delimiter */
 /* Rx Buffer Registers */
 #define FBNIC_CSR_START_RXB		0x08000	/* CSR section delimiter */
@@ -382,22 +404,52 @@ enum {
 #define FBNIC_QUEUE_TWQ1_CTL		0x001		/* 0x004 */
 #define FBNIC_QUEUE_TWQ_CTL_RESET		CSR_BIT(0)
 #define FBNIC_QUEUE_TWQ_CTL_ENABLE		CSR_BIT(1)
-#define FBNIC_QUEUE_TWQ_CTL_PREFETCH_DISABLE	CSR_BIT(2)
-#define FBNIC_QUEUE_TWQ_CTL_TXB_FIFO_SEL_MASK	CSR_GENMASK(30, 29)
-enum {
-	FBNIC_QUEUE_TWQ_CTL_TXB_SHARED	= 0,
-	FBNIC_QUEUE_TWQ_CTL_TXB_EI_DATA	= 1,
-	FBNIC_QUEUE_TWQ_CTL_TXB_EI_CTL	= 2,
-};
-
-#define FBNIC_QUEUE_TWQ_CTL_AGGR_MODE		CSR_BIT(31)
-
 #define FBNIC_QUEUE_TWQ0_TAIL		0x002		/* 0x008 */
 #define FBNIC_QUEUE_TWQ1_TAIL		0x003		/* 0x00c */
 
+#define FBNIC_QUEUE_TWQ0_SIZE		0x00a		/* 0x028 */
+#define FBNIC_QUEUE_TWQ1_SIZE		0x00b		/* 0x02c */
+#define FBNIC_QUEUE_TWQ_SIZE_MASK		CSR_GENMASK(3, 0)
+
+#define FBNIC_QUEUE_TWQ0_BAL		0x020		/* 0x080 */
+#define FBNIC_QUEUE_BAL_MASK			CSR_GENMASK(31, 7)
+#define FBNIC_QUEUE_TWQ0_BAH		0x021		/* 0x084 */
+#define FBNIC_QUEUE_TWQ1_BAL		0x022		/* 0x088 */
+#define FBNIC_QUEUE_TWQ1_BAH		0x023		/* 0x08c */
+
 /* Tx Completion Queue Registers */
+#define FBNIC_QUEUE_TCQ_CTL		0x080		/* 0x200 */
+#define FBNIC_QUEUE_TCQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_TCQ_CTL_ENABLE		CSR_BIT(1)
+
 #define FBNIC_QUEUE_TCQ_HEAD		0x081		/* 0x204 */
 
+#define FBNIC_QUEUE_TCQ_SIZE		0x084		/* 0x210 */
+#define FBNIC_QUEUE_TCQ_SIZE_MASK		CSR_GENMASK(3, 0)
+
+#define FBNIC_QUEUE_TCQ_BAL		0x0a0		/* 0x280 */
+#define FBNIC_QUEUE_TCQ_BAH		0x0a1		/* 0x284 */
+
+/* Tx Interrupt Manager Registers */
+#define FBNIC_QUEUE_TIM_CTL		0x0c0		/* 0x300 */
+#define FBNIC_QUEUE_TIM_CTL_MSIX_MASK		CSR_GENMASK(7, 0)
+
+#define FBNIC_QUEUE_TIM_THRESHOLD	0x0c1		/* 0x304 */
+#define FBNIC_QUEUE_TIM_THRESHOLD_TWD_MASK	CSR_GENMASK(14, 0)
+
+#define FBNIC_QUEUE_TIM_CLEAR		0x0c2		/* 0x308 */
+#define FBNIC_QUEUE_TIM_CLEAR_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_TIM_SET		0x0c3		/* 0x30c */
+#define FBNIC_QUEUE_TIM_SET_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_TIM_MASK		0x0c4		/* 0x310 */
+#define FBNIC_QUEUE_TIM_MASK_MASK		CSR_BIT(0)
+
+#define FBNIC_QUEUE_TIM_TIMER		0x0c5		/* 0x314 */
+
+#define FBNIC_QUEUE_TIM_COUNTS		0x0c6		/* 0x318 */
+#define FBNIC_QUEUE_TIM_COUNTS_CNT1_MASK	CSR_GENMASK(30, 16)
+#define FBNIC_QUEUE_TIM_COUNTS_CNT0_MASK	CSR_GENMASK(14, 0)
+
 /* Rx Completion Queue Registers */
 #define FBNIC_QUEUE_RCQ_HEAD		0x201		/* 0x804 */
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 73f46ede82fc..95ab8ac1cae7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -17,6 +17,10 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		return err;
 
+	err = fbnic_alloc_resources(fbn);
+	if (err)
+		goto free_napi_vectors;
+
 	err = netif_set_real_num_tx_queues(fbn->netdev,
 					   fbn->num_tx_queues);
 	if (err)
@@ -29,6 +33,8 @@ int __fbnic_open(struct fbnic_net *fbn)
 
 	return 0;
 free_resources:
+	fbnic_free_resources(fbn);
+free_napi_vectors:
 	fbnic_free_napi_vectors(fbn);
 	return err;
 }
@@ -51,6 +57,7 @@ static int fbnic_stop(struct net_device *netdev)
 
 	fbnic_down(fbn);
 
+	fbnic_free_resources(fbn);
 	fbnic_free_napi_vectors(fbn);
 
 	return 0;
@@ -121,6 +128,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbn->fbd = fbd;
 	INIT_LIST_HEAD(&fbn->napis);
 
+	fbn->txq_size = FBNIC_TXQ_SIZE_DEFAULT;
+
 	default_queues = netif_get_num_default_rss_queues();
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 8d12abe5fb57..b3c39c10c3f7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -15,6 +15,8 @@ struct fbnic_net {
 	struct net_device *netdev;
 	struct fbnic_dev *fbd;
 
+	u32 txq_size;
+
 	u16 num_napi;
 
 	u16 num_tx_queues;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index e08aa4edeec0..73c96fe2a746 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -129,16 +129,33 @@ static void fbnic_service_task_stop(struct fbnic_net *fbn)
 
 void fbnic_up(struct fbnic_net *fbn)
 {
+	fbnic_enable(fbn);
+
+	/* Enable Tx/Rx processing */
+	fbnic_napi_enable(fbn);
 	netif_tx_start_all_queues(fbn->netdev);
 
 	fbnic_service_task_start(fbn);
 }
 
-void fbnic_down(struct fbnic_net *fbn)
+static void fbnic_down_noidle(struct fbnic_net *fbn)
 {
 	fbnic_service_task_stop(fbn);
 
+	/* Disable Tx/Rx Processing */
+	fbnic_napi_disable(fbn);
 	netif_tx_disable(fbn->netdev);
+
+	fbnic_disable(fbn);
+}
+
+void fbnic_down(struct fbnic_net *fbn)
+{
+	fbnic_down_noidle(fbn);
+
+	fbnic_wait_all_queues_idle(fbn->fbd, false);
+
+	fbnic_flush(fbn);
 }
 
 static void fbnic_service_task(struct work_struct *work)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 372ca95dceb4..52314aac29b9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1,18 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#include <linux/iopoll.h>
 #include <linux/pci.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
+static u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
+{
+	unsigned long csr_base = (unsigned long)ring->doorbell;
+
+	csr_base &= ~(FBNIC_QUEUE_STRIDE * sizeof(u32) - 1);
+
+	return (u32 __iomem *)csr_base;
+}
+
+static u32 fbnic_ring_rd32(struct fbnic_ring *ring, unsigned int csr)
+{
+	u32 __iomem *csr_base = fbnic_ring_csr_base(ring);
+
+	return readl(csr_base + csr);
+}
+
+static void fbnic_ring_wr32(struct fbnic_ring *ring, unsigned int csr, u32 val)
+{
+	u32 __iomem *csr_base = fbnic_ring_csr_base(ring);
+
+	writel(val, csr_base + csr);
+}
+
 netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 {
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
 
+static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_dev *fbd = nv->fbd;
+	u32 v_idx = nv->v_idx;
+
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(v_idx / 32), 1 << (v_idx % 32));
+}
+
 static int fbnic_poll(struct napi_struct *napi, int budget)
 {
 	return 0;
@@ -262,5 +294,402 @@ int fbnic_alloc_napi_vectors(struct fbnic_net *fbn)
 
 free_vectors:
 	fbnic_free_napi_vectors(fbn);
+
 	return -ENOMEM;
 }
+
+static void fbnic_free_ring_resources(struct device *dev,
+				      struct fbnic_ring *ring)
+{
+	kvfree(ring->buffer);
+	ring->buffer = NULL;
+
+	/* If size is not set there are no descriptors present */
+	if (!ring->size)
+		return;
+
+	dma_free_coherent(dev, ring->size, ring->desc, ring->dma);
+	ring->size_mask = 0;
+	ring->size = 0;
+}
+
+static int fbnic_alloc_tx_ring_desc(struct fbnic_net *fbn,
+				    struct fbnic_ring *txr)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	size_t size;
+
+	/* Round size up to nearest 4K */
+	size = ALIGN(array_size(sizeof(*txr->desc), fbn->txq_size), 4096);
+
+	txr->desc = dma_alloc_coherent(dev, size, &txr->dma,
+				       GFP_KERNEL | __GFP_NOWARN);
+	if (!txr->desc)
+		return -ENOMEM;
+
+	/* txq_size should be a power of 2, so mask is just that -1 */
+	txr->size_mask = fbn->txq_size - 1;
+	txr->size = size;
+
+	return 0;
+}
+
+static int fbnic_alloc_tx_ring_buffer(struct fbnic_ring *txr)
+{
+	size_t size = array_size(sizeof(*txr->tx_buf), txr->size_mask + 1);
+
+	txr->tx_buf = kvzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+
+	return txr->tx_buf ? 0 : -ENOMEM;
+}
+
+static int fbnic_alloc_tx_ring_resources(struct fbnic_net *fbn,
+					 struct fbnic_ring *txr)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	int err;
+
+	if (txr->flags & FBNIC_RING_F_DISABLED)
+		return 0;
+
+	err = fbnic_alloc_tx_ring_desc(fbn, txr);
+	if (err)
+		return err;
+
+	if (!(txr->flags & FBNIC_RING_F_CTX))
+		return 0;
+
+	err = fbnic_alloc_tx_ring_buffer(txr);
+	if (err)
+		goto free_desc;
+
+	return 0;
+
+free_desc:
+	fbnic_free_ring_resources(dev, txr);
+	return err;
+}
+
+static void fbnic_free_qt_resources(struct fbnic_net *fbn,
+				    struct fbnic_q_triad *qt)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+
+	fbnic_free_ring_resources(dev, &qt->cmpl);
+	fbnic_free_ring_resources(dev, &qt->sub1);
+	fbnic_free_ring_resources(dev, &qt->sub0);
+}
+
+static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
+				       struct fbnic_q_triad *qt)
+{
+	struct device *dev = fbn->netdev->dev.parent;
+	int err;
+
+	err = fbnic_alloc_tx_ring_resources(fbn, &qt->sub0);
+	if (err)
+		return err;
+
+	err = fbnic_alloc_tx_ring_resources(fbn, &qt->cmpl);
+	if (err)
+		goto free_sub0;
+
+	return 0;
+
+free_sub0:
+	fbnic_free_ring_resources(dev, &qt->sub0);
+	return err;
+}
+
+static void fbnic_free_nv_resources(struct fbnic_net *fbn,
+				    struct fbnic_napi_vector *nv)
+{
+	int i;
+
+	/* Free Tx Resources  */
+	for (i = 0; i < nv->txt_count; i++)
+		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+}
+
+static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
+				    struct fbnic_napi_vector *nv)
+{
+	int i, err;
+
+	/* Allocate Tx Resources */
+	for (i = 0; i < nv->txt_count; i++) {
+		err = fbnic_alloc_tx_qt_resources(fbn, &nv->qt[i]);
+		if (err)
+			goto free_resources;
+	}
+
+	return 0;
+
+free_resources:
+	while (i--)
+		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+	return err;
+}
+
+void fbnic_free_resources(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+
+	list_for_each_entry(nv, &fbn->napis, napis)
+		fbnic_free_nv_resources(fbn, nv);
+}
+
+int fbnic_alloc_resources(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+	int err = -ENODEV;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		err = fbnic_alloc_nv_resources(fbn, nv);
+		if (err)
+			goto free_resources;
+	}
+
+	return 0;
+
+free_resources:
+	list_for_each_entry_continue_reverse(nv, &fbn->napis, napis)
+		fbnic_free_nv_resources(fbn, nv);
+
+	return err;
+}
+
+static void fbnic_disable_twq0(struct fbnic_ring *txr)
+{
+	u32 twq_ctl = fbnic_ring_rd32(txr, FBNIC_QUEUE_TWQ0_CTL);
+
+	twq_ctl &= ~FBNIC_QUEUE_TWQ_CTL_ENABLE;
+
+	fbnic_ring_wr32(txr, FBNIC_QUEUE_TWQ0_CTL, twq_ctl);
+}
+
+static void fbnic_disable_tcq(struct fbnic_ring *txr)
+{
+	fbnic_ring_wr32(txr, FBNIC_QUEUE_TCQ_CTL, 0);
+	fbnic_ring_wr32(txr, FBNIC_QUEUE_TIM_MASK, FBNIC_QUEUE_TIM_MASK_MASK);
+}
+
+void fbnic_napi_disable(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		napi_disable(&nv->napi);
+
+		fbnic_nv_irq_disable(nv);
+	}
+}
+
+void fbnic_disable(struct fbnic_net *fbn)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_napi_vector *nv;
+	int i;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		/* Disable Tx queue triads */
+		for (i = 0; i < nv->txt_count; i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			fbnic_disable_twq0(&qt->sub0);
+			fbnic_disable_tcq(&qt->cmpl);
+		}
+	}
+
+	fbnic_wrfl(fbd);
+}
+
+static void fbnic_tx_flush(struct fbnic_dev *fbd)
+{
+	netdev_warn(fbd->netdev, "tiggerring Tx flush\n");
+
+	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN,
+		    FBNIC_TMI_DROP_CTRL_EN);
+}
+
+static void fbnic_tx_flush_off(struct fbnic_dev *fbd)
+{
+	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN, 0);
+}
+
+struct fbnic_idle_regs {
+	u32 reg_base;
+	u8 reg_cnt;
+};
+
+static bool fbnic_all_idle(struct fbnic_dev *fbd,
+			   const struct fbnic_idle_regs *regs,
+			   unsigned int nregs)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < nregs; i++) {
+		for (j = 0; j < regs[i].reg_cnt; j++) {
+			if (fbnic_rd32(fbd, regs[i].reg_base + j) != ~0U)
+				return false;
+		}
+	}
+	return true;
+}
+
+static void fbnic_idle_dump(struct fbnic_dev *fbd,
+			    const struct fbnic_idle_regs *regs,
+			    unsigned int nregs, const char *dir, int err)
+{
+	unsigned int i, j;
+
+	netdev_err(fbd->netdev, "error waiting for %s idle %d\n", dir, err);
+	for (i = 0; i < nregs; i++)
+		for (j = 0; j < regs[i].reg_cnt; j++)
+			netdev_err(fbd->netdev, "0x%04x: %08x\n",
+				   regs[i].reg_base + j,
+				   fbnic_rd32(fbd, regs[i].reg_base + j));
+}
+
+int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
+{
+	static const struct fbnic_idle_regs tx[] = {
+		{ FBNIC_QM_TWQ_IDLE(0),	FBNIC_QM_TWQ_IDLE_CNT, },
+		{ FBNIC_QM_TQS_IDLE(0),	FBNIC_QM_TQS_IDLE_CNT, },
+		{ FBNIC_QM_TDE_IDLE(0),	FBNIC_QM_TDE_IDLE_CNT, },
+		{ FBNIC_QM_TCQ_IDLE(0),	FBNIC_QM_TCQ_IDLE_CNT, },
+	};
+	bool idle;
+	int err;
+
+	err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle, 2, 500000,
+				       false, fbd, tx, ARRAY_SIZE(tx));
+	if (err == -ETIMEDOUT) {
+		fbnic_tx_flush(fbd);
+		err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle,
+					       2, 500000, false,
+					       fbd, tx, ARRAY_SIZE(tx));
+		fbnic_tx_flush_off(fbd);
+	}
+	if (err) {
+		fbnic_idle_dump(fbd, tx, ARRAY_SIZE(tx), "Tx", err);
+		if (may_fail)
+			return err;
+	}
+
+	return err;
+}
+
+void fbnic_flush(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		int i;
+
+		/* Flush any processed Tx Queue Triads and drop the rest */
+		for (i = 0; i < nv->txt_count; i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+			struct netdev_queue *tx_queue;
+
+			/* Reset completion queue descriptor ring */
+			memset(qt->cmpl.desc, 0, qt->cmpl.size);
+
+			/* Reset BQL associated with Tx queue */
+			tx_queue = netdev_get_tx_queue(nv->napi.dev,
+						       qt->sub0.q_idx);
+			netdev_tx_reset_queue(tx_queue);
+		}
+	}
+}
+
+static void fbnic_enable_twq0(struct fbnic_ring *twq)
+{
+	u32 log_size = fls(twq->size_mask);
+
+	if (!twq->size_mask)
+		return;
+
+	/* Reset head/tail */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_CTL, FBNIC_QUEUE_TWQ_CTL_RESET);
+	twq->tail = 0;
+	twq->head = 0;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_BAL, lower_32_bits(twq->dma));
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_BAH, upper_32_bits(twq->dma));
+
+	/* Write lower 4 bits of log size as 64K ring size is 0 */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_SIZE, log_size & 0xf);
+
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_CTL, FBNIC_QUEUE_TWQ_CTL_ENABLE);
+}
+
+static void fbnic_enable_tcq(struct fbnic_napi_vector *nv,
+			     struct fbnic_ring *tcq)
+{
+	u32 log_size = fls(tcq->size_mask);
+
+	if (!tcq->size_mask)
+		return;
+
+	/* Reset head/tail */
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_CTL, FBNIC_QUEUE_TCQ_CTL_RESET);
+	tcq->tail = 0;
+	tcq->head = 0;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_BAL, lower_32_bits(tcq->dma));
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_BAH, upper_32_bits(tcq->dma));
+
+	/* Write lower 4 bits of log size as 64K ring size is 0 */
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_SIZE, log_size & 0xf);
+
+	/* Store interrupt information for the completion queue */
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TIM_CTL, nv->v_idx);
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TIM_THRESHOLD, tcq->size_mask / 2);
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TIM_MASK, 0);
+
+	/* Enable queue */
+	fbnic_ring_wr32(tcq, FBNIC_QUEUE_TCQ_CTL, FBNIC_QUEUE_TCQ_CTL_ENABLE);
+}
+
+void fbnic_enable(struct fbnic_net *fbn)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_napi_vector *nv;
+	int i;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		/* Setup Tx Queue Triads */
+		for (i = 0; i < nv->txt_count; i++) {
+			struct fbnic_q_triad *qt = &nv->qt[i];
+
+			fbnic_enable_twq0(&qt->sub0);
+			fbnic_enable_tcq(nv, &qt->cmpl);
+		}
+	}
+
+	fbnic_wrfl(fbd);
+}
+
+static void fbnic_nv_irq_enable(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_dev *fbd = nv->fbd;
+	u32 val;
+
+	val = FBNIC_INTR_CQ_REARM_INTR_UNMASK;
+
+	fbnic_wr32(fbd, FBNIC_INTR_CQ_REARM(nv->v_idx), val);
+}
+
+void fbnic_napi_enable(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		napi_enable(&nv->napi);
+
+		fbnic_nv_irq_enable(nv);
+	}
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 4b88f0f76137..77abc15bb0dc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -12,17 +12,30 @@ struct fbnic_net;
 #define FBNIC_MAX_TXQS			128u
 #define FBNIC_MAX_RXQS			128u
 
+#define FBNIC_TXQ_SIZE_DEFAULT		1024
+
 #define FBNIC_RING_F_DISABLED		BIT(0)
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
 
 struct fbnic_ring {
+	/* Pointer to buffer specific info */
+	union {
+		void **tx_buf;			/* TWQ */
+		void *buffer;			/* Generic pointer */
+	};
+
 	u32 __iomem *doorbell;		/* Pointer to CSR space for ring */
+	__le64 *desc;			/* Descriptor ring memory */
 	u16 size_mask;			/* Size of ring in descriptors - 1 */
 	u8 q_idx;			/* Logical netdev ring index */
 	u8 flags;			/* Ring flags (FBNIC_RING_F_*) */
 
 	u32 head, tail;			/* Head/Tail of ring */
+
+	/* Slow path fields follow */
+	dma_addr_t dma;			/* Phys addr of descriptor memory */
+	size_t size;			/* Size of descriptor ring in memory */
 };
 
 struct fbnic_q_triad {
@@ -51,5 +64,14 @@ netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
 
 int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);
+int fbnic_alloc_resources(struct fbnic_net *fbn);
+void fbnic_free_resources(struct fbnic_net *fbn);
+void fbnic_napi_enable(struct fbnic_net *fbn);
+void fbnic_napi_disable(struct fbnic_net *fbn);
+void fbnic_enable(struct fbnic_net *fbn);
+void fbnic_disable(struct fbnic_net *fbn);
+void fbnic_flush(struct fbnic_net *fbn);
+
+int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail);
 
 #endif /* _FBNIC_TXRX_H_ */



