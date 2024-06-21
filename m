Return-Path: <netdev+bounces-105788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5D912D58
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3911C23987
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2AF17BB1F;
	Fri, 21 Jun 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xazx26av"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E617B51A
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995223; cv=none; b=chp1kBo1uCkw4hP6p0U5mNzeLi4r13toN1LxrShg8P2MzDuVQxF45ogLEbzbga/J18eZkGAMZeHUld8FoLf1gy0N0bMPyFt9Hdg9w2XBD+dUhLv8W1PS5rx4+q6v61UgtkqZkcPi8ZhfW42NkALP/epniAaGt9cKr6P58vcD8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995223; c=relaxed/simple;
	bh=RHIQ1ZK7HhrkITryP32SV1M7i6oMh9uMx3UMrh72w6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANxVk32jqZI/GzClcOc7qM00qTlRGD+OFtYWZKMm5lmlnuVl+AS6BknUEMLpyAgd6wI3dduZN4bc2LtS5Mtlh5+YZg8ldOc8GC3AL5Hi/YgLqaD9Lpf/svpDuspTCdj3Qv0cL60cSLEXa7IE4z6rRso8RBBx7xkMk/8270yQ1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xazx26av; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so90265239f.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995221; x=1719600021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7B644WJji2EeDQXIp+qb+T3U50yFIygDXuUoanjxuY=;
        b=Xazx26avEoZAsRg4afAk1gH9NvjEWj1F4b32CzKAvNF7tGCiPOg/eH+n24qGziSGqs
         4a+0OeQXjYi5jw56lZ0SUWckAtgJ5su5xoXn/84CSBdpfwguZcpH41qbtDNTymtqhF9/
         typXd5dy9m1LSNRR1FWzXGbTPQzgjsnyM+QN2RLYg/vH5eOulO8FT2RJlbJTGlRmFKU2
         mzH/2GajrhKZrioDduZl7OncMgLmwLvjww+kfeAIhjzgX2j4Ppg5BK+lN3PQazokIpdo
         JWuosBrnkkx5NXwiwetbdJ9xtc2TGHA48T9uDemRof4WoIarh8328UUG/1e6FRQzJ2yE
         MzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995221; x=1719600021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7B644WJji2EeDQXIp+qb+T3U50yFIygDXuUoanjxuY=;
        b=V618q4taGxmtiiBropTqEyWJEqyALpVAceUtX5qhwLVyZKlyZ/aeY4Xus0RggUgTcr
         W7ZstYLguvqlmLB0ycVwbjRHasnT9gX0lcW23nO06AxP59mPZ86lIvRnbqJgiHjN9/6Q
         m2zAQUSX2ivnH7u07m6vp+esiIyAUwhU4GkSNRyr9hn6dD8ABORfeTKiavPySwwSrM4S
         AxAGMrpVFUv2aFs8KhpglamUlJ1AkKM5PeH7qx5Yl1CHZmkAhAxKd1jvT59I38Px1PeB
         0XG/BAtd2y6A4IxTL3sgxq3wDRFGM2UQH6QvX4w3s8wuSUjkp3lei50Beh5TIJyJNpf2
         aSWQ==
X-Gm-Message-State: AOJu0YynzhGb5+jttV6XnWeqjleG38bdn0SvLmDWv6lQhlgv/kjjL26A
	2N+MuMZSarN9G/wTSWnfb4+5K1FzpuKH1QiowPYyLgzF0+CzGAfcUjYB4w==
X-Google-Smtp-Source: AGHT+IERU6khjfCJbSPgbCVfuW+x488ywSI/a0GaRqOXQGsnp+dQGGthepN+hkrbbZkAtfgEPZPFiA==
X-Received: by 2002:a05:6602:1685:b0:7eb:8015:3ee1 with SMTP id ca18e2360f4ac-7f13ee0ab6fmr1072692639f.1.1718995220798;
        Fri, 21 Jun 2024 11:40:20 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:19 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 07/15] net: thunderx: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:39 -0700
Message-Id: <20240621183947.4105278-8-allen.lkml@gmail.com>
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
APIs throughout the cavium/thunderx driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h     |  5 ++--
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++++++++----------
 .../ethernet/cavium/thunder/nicvf_queues.c    |  4 ++--
 .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 090d6b83982a..ecc175b6e7fa 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -8,6 +8,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <linux/pci.h>
 #include "thunder_bgx.h"
 
@@ -295,7 +296,7 @@ struct nicvf {
 	bool			rb_work_scheduled;
 	struct page		*rb_page;
 	struct delayed_work	rbdr_work;
-	struct tasklet_struct	rbdr_task;
+	struct work_struct	rbdr_bh_work;
 
 	/* Secondary Qset */
 	u8			sqs_count;
@@ -319,7 +320,7 @@ struct nicvf {
 	bool			loopback_supported;
 	struct nicvf_rss_info	rss_info;
 	struct nicvf_pfc	pfc;
-	struct tasklet_struct	qs_err_task;
+	struct work_struct	qs_err_bh_work;
 	struct work_struct	reset_task;
 	struct nicvf_work       rx_mode_work;
 	/* spinlock to protect workqueue arguments from concurrent access */
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6e..b0878bd25cf0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -982,9 +982,9 @@ static int nicvf_poll(struct napi_struct *napi, int budget)
  *
  * As of now only CQ errors are handled
  */
-static void nicvf_handle_qs_err(struct tasklet_struct *t)
+static void nicvf_handle_qs_err(struct work_struct *work)
 {
-	struct nicvf *nic = from_tasklet(nic, t, qs_err_task);
+	struct nicvf *nic = from_work(nic, work, qs_err_bh_work);
 	struct queue_set *qs = nic->qs;
 	int qidx;
 	u64 status;
@@ -1069,7 +1069,7 @@ static irqreturn_t nicvf_rbdr_intr_handler(int irq, void *nicvf_irq)
 		if (!nicvf_is_intr_enabled(nic, NICVF_INTR_RBDR, qidx))
 			continue;
 		nicvf_disable_intr(nic, NICVF_INTR_RBDR, qidx);
-		tasklet_hi_schedule(&nic->rbdr_task);
+		queue_work(system_bh_highpri_wq, &nic->rbdr_bh_work);
 		/* Clear interrupt */
 		nicvf_clear_intr(nic, NICVF_INTR_RBDR, qidx);
 	}
@@ -1085,7 +1085,7 @@ static irqreturn_t nicvf_qs_err_intr_handler(int irq, void *nicvf_irq)
 
 	/* Disable Qset err interrupt and schedule softirq */
 	nicvf_disable_intr(nic, NICVF_INTR_QS_ERR, 0);
-	tasklet_hi_schedule(&nic->qs_err_task);
+	queue_work(system_bh_highpri_wq, &nic->qs_err_bh_work);
 	nicvf_clear_intr(nic, NICVF_INTR_QS_ERR, 0);
 
 	return IRQ_HANDLED;
@@ -1364,8 +1364,8 @@ int nicvf_stop(struct net_device *netdev)
 	for (irq = 0; irq < nic->num_vec; irq++)
 		synchronize_irq(pci_irq_vector(nic->pdev, irq));
 
-	tasklet_kill(&nic->rbdr_task);
-	tasklet_kill(&nic->qs_err_task);
+	cancel_work_sync(&nic->rbdr_bh_work);
+	cancel_work_sync(&nic->qs_err_bh_work);
 	if (nic->rb_work_scheduled)
 		cancel_delayed_work_sync(&nic->rbdr_work);
 
@@ -1488,11 +1488,11 @@ int nicvf_open(struct net_device *netdev)
 		nicvf_hw_set_mac_addr(nic, netdev);
 	}
 
-	/* Init tasklet for handling Qset err interrupt */
-	tasklet_setup(&nic->qs_err_task, nicvf_handle_qs_err);
+	/* Init bh_work for handling Qset err interrupt */
+	INIT_WORK(&nic->qs_err_bh_work, nicvf_handle_qs_err);
 
-	/* Init RBDR tasklet which will refill RBDR */
-	tasklet_setup(&nic->rbdr_task, nicvf_rbdr_task);
+	/* Init RBDR bh_work which will refill RBDR */
+	INIT_WORK(&nic->rbdr_bh_work, nicvf_rbdr_bh_work);
 	INIT_DELAYED_WORK(&nic->rbdr_work, nicvf_rbdr_work);
 
 	/* Configure CPI alorithm */
@@ -1561,8 +1561,8 @@ int nicvf_open(struct net_device *netdev)
 cleanup:
 	nicvf_disable_intr(nic, NICVF_INTR_MBOX, 0);
 	nicvf_unregister_interrupts(nic);
-	tasklet_kill(&nic->qs_err_task);
-	tasklet_kill(&nic->rbdr_task);
+	cancel_work_sync(&nic->qs_err_bh_work);
+	cancel_work_sync(&nic->rbdr_bh_work);
 napi_del:
 	for (qidx = 0; qidx < qs->cq_cnt; qidx++) {
 		cq_poll = nic->napi[qidx];
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 06397cc8bb36..ad71160879e4 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -461,9 +461,9 @@ void nicvf_rbdr_work(struct work_struct *work)
 }
 
 /* In Softirq context, alloc rcv buffers in atomic mode */
-void nicvf_rbdr_task(struct tasklet_struct *t)
+void nicvf_rbdr_bh_work(struct work_struct *work)
 {
-	struct nicvf *nic = from_tasklet(nic, t, rbdr_task);
+	struct nicvf *nic = from_work(nic, work, rbdr_bh_work);
 
 	nicvf_refill_rbdr(nic, GFP_ATOMIC);
 	if (nic->rb_alloc_fail) {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index 8453defc296c..c6f18fb7c50e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -348,7 +348,7 @@ void nicvf_xdp_sq_doorbell(struct nicvf *nic, struct snd_queue *sq, int sq_num);
 
 struct sk_buff *nicvf_get_rcv_skb(struct nicvf *nic,
 				  struct cqe_rx_t *cqe_rx, bool xdp);
-void nicvf_rbdr_task(struct tasklet_struct *t);
+void nicvf_rbdr_bh_work(struct work_struct *work);
 void nicvf_rbdr_work(struct work_struct *work);
 
 void nicvf_enable_intr(struct nicvf *nic, int int_type, int q_idx);
-- 
2.34.1


