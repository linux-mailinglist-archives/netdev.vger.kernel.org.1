Return-Path: <netdev+bounces-105786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23948912D54
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB51C20C5F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF117B4F2;
	Fri, 21 Jun 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABGl51T7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B217B428
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995220; cv=none; b=YP7iFctwo+mCmozcoDR8C0SokYZDUM+KOp3/PkvG7zcLBhlN9P1b5P5/F8ZIyAU2u/LBf/NakK9pkoWOEluEaZLnJho7FJzXCL0ScH9VmvKWKMIqZoPA7ViovMHm+UiDVcyaEI+jyGPC/y/NIVtzyGqqpidLkpOHqc0PrwmppnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995220; c=relaxed/simple;
	bh=gI85TTQP7iKwQXoxekl9V3cWSZJ22aXkG4Y9tecNtfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ej4bAsMrRiIV5nIImQ0kBVfo8SPRVY7fiN+JXW/RkUEEbFhnUYdJQWhct8GBQYHz/7XkkrRKGc61kh1MMrqJbnyzL9mm2i+VD97xzHhugQSrkVwm/jIcybCFW8kZD9DcFVrUzLRMxa05JNLJIpmU7L3NSO1oqfGddtQD/rCp5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABGl51T7; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-376208fbe7bso9043395ab.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995217; x=1719600017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9GhuL189NlsReo3FKcMODlZqu4R4eu4VKJPZNqH5aQ=;
        b=ABGl51T7ukX/NPmu0eCCOKCEt3AymQsmdPMtJ6sWKD1kPNpkbKejCTlvq34QBA+w28
         pBxL7oJzW5yW4cLTrz+ys2LYKg5myY8CU6SDCiO8ZN1PPgJ5Je56xTo1uhxBo5Eo7QlN
         bqxiO9oWLo7h14D1lIAdG7M9SrzddE0cIileSrHx8M3C4b1OVBIm7QNsyp34xtCFm6U4
         jtxfmPebUogCn2fWH6QSoNiue0N2LlyLwV7TdzEgLPJCsrcYoBNYgw5SAsir4UY9TJOO
         GLATid+MMxDUMsaPCMwXJGD5DTuIJbvErGmJwsuDFqqbmePwLhobs+nDFrydzrFYZykO
         OBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995217; x=1719600017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9GhuL189NlsReo3FKcMODlZqu4R4eu4VKJPZNqH5aQ=;
        b=w4Ww5npXRy2Jh6smCqtqMKM/tL/vhXuGV4a49xWtbCfPtPDgonWNAgWPJ9BPAJUHQE
         Z3ZFoIvejBTih6tl93RShjgfqwtxB3SIkXCXqFCxHVF4akSG/Jl681+FkLD00CBSp2kE
         MDWjiUyXcNL4lcVBuM/6upnPXk1Wntxqj89ccfv4HWZDvnpIh6bR9Od8nahHkIiqOUkx
         fQpqemUxmYqBWqlY8piHrv0XGvvo4bZAM7BUdVXxk5FazUgnsYfasIyoemFe76J5jj16
         jzUWwtta08iwazgUsuUUVPOembhgPi/uNcbjZtP+I9yqlEhPf/NML/ZamFexiod6RZvk
         fpDA==
X-Gm-Message-State: AOJu0YwEvmlgUBNkxy11Q0EG+OSPT50DuLaUvj3woLJQCCgoysGUBi/g
	unZ8z5ucFmy/VEXrzgV8AhnjpeAZ9uvV8cpk6W8LjhC/MpWKZm/IpsTtcA==
X-Google-Smtp-Source: AGHT+IE5DsEDgq83QngxdUyAbFoGnYt0+oO+O+pztH0u2LqhTjLhedHnaVCVpLxYGTaC0GLbCUK0iA==
X-Received: by 2002:a05:6e02:1545:b0:375:d832:fa2f with SMTP id e9e14a558f8ab-3761d710508mr96619295ab.21.1718995216960;
        Fri, 21 Jun 2024 11:40:16 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:16 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 05/15] net: cavium/liquidio: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:37 -0700
Message-Id: <20240621183947.4105278-6-allen.lkml@gmail.com>
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
APIs throughout the cavium/liquidio driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 .../net/ethernet/cavium/liquidio/lio_core.c   |  4 ++--
 .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++++++++----------
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 ++++----
 .../ethernet/cavium/liquidio/octeon_droq.c    |  4 ++--
 .../ethernet/cavium/liquidio/octeon_main.h    |  4 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 674c54831875..37307e02a6ff 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -925,7 +925,7 @@ int liquidio_schedule_msix_droq_pkt_handler(struct octeon_droq *droq, u64 ret)
 			if (OCTEON_CN23XX_VF(oct))
 				dev_err(&oct->pci_dev->dev,
 					"should not come here should not get rx when poll mode = 0 for vf\n");
-			tasklet_schedule(&oct_priv->droq_tasklet);
+			queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 			return 1;
 		}
 		/* this will be flushed periodically by check iq db */
@@ -975,7 +975,7 @@ static void liquidio_schedule_droq_pkt_handlers(struct octeon_device *oct)
 				droq->ops.napi_fn(droq);
 				oct_priv->napi_mask |= BIT_ULL(oq_no);
 			} else {
-				tasklet_schedule(&oct_priv->droq_tasklet);
+				queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 1d79f6eaa41f..d348656c2f38 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -150,12 +150,12 @@ static int liquidio_set_vf_link_state(struct net_device *netdev, int vfidx,
 static struct handshake handshake[MAX_OCTEON_DEVICES];
 static struct completion first_stage;
 
-static void octeon_droq_bh(struct tasklet_struct *t)
+static void octeon_droq_bh(struct work_struct *work)
 {
 	int q_no;
 	int reschedule = 0;
-	struct octeon_device_priv *oct_priv = from_tasklet(oct_priv, t,
-							  droq_tasklet);
+	struct octeon_device_priv *oct_priv = from_work(oct_priv, work,
+							  droq_bh_work);
 	struct octeon_device *oct = oct_priv->dev;
 
 	for (q_no = 0; q_no < MAX_OCTEON_OUTPUT_QUEUES(oct); q_no++) {
@@ -180,7 +180,7 @@ static void octeon_droq_bh(struct tasklet_struct *t)
 	}
 
 	if (reschedule)
-		tasklet_schedule(&oct_priv->droq_tasklet);
+		queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 }
 
 static int lio_wait_for_oq_pkts(struct octeon_device *oct)
@@ -199,7 +199,7 @@ static int lio_wait_for_oq_pkts(struct octeon_device *oct)
 		}
 		if (pkt_cnt > 0) {
 			pending_pkts += pkt_cnt;
-			tasklet_schedule(&oct_priv->droq_tasklet);
+			queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 		}
 		pkt_cnt = 0;
 		schedule_timeout_uninterruptible(1);
@@ -1130,7 +1130,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		break;
 	}                       /* end switch (oct->status) */
 
-	tasklet_kill(&oct_priv->droq_tasklet);
+	cancel_work_sync(&oct_priv->droq_bh_work);
 }
 
 /**
@@ -1234,7 +1234,7 @@ static void liquidio_destroy_nic_device(struct octeon_device *oct, int ifidx)
 	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 		netif_napi_del(napi);
 
-	tasklet_enable(&oct_priv->droq_tasklet);
+	enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 
 	if (atomic_read(&lio->ifstate) & LIO_IFSTATE_REGISTERED)
 		unregister_netdev(netdev);
@@ -1770,7 +1770,7 @@ static int liquidio_open(struct net_device *netdev)
 	int ret = 0;
 
 	if (oct->props[lio->ifidx].napi_enabled == 0) {
-		tasklet_disable(&oct_priv->droq_tasklet);
+		disable_work_sync(&oct_priv->droq_bh_work);
 
 		list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 			napi_enable(napi);
@@ -1896,7 +1896,7 @@ static int liquidio_stop(struct net_device *netdev)
 		if (OCTEON_CN23XX_PF(oct))
 			oct->droq[0]->ops.poll_mode = 0;
 
-		tasklet_enable(&oct_priv->droq_tasklet);
+		enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 	}
 
 	dev_info(&oct->pci_dev->dev, "%s interface is stopped\n", netdev->name);
@@ -4204,9 +4204,9 @@ static int octeon_device_init(struct octeon_device *octeon_dev)
 		}
 	}
 
-	/* Initialize the tasklet that handles output queue packet processing.*/
-	dev_dbg(&octeon_dev->pci_dev->dev, "Initializing droq tasklet\n");
-	tasklet_setup(&oct_priv->droq_tasklet, octeon_droq_bh);
+	/* Initialize the bh work that handles output queue packet processing.*/
+	dev_dbg(&octeon_dev->pci_dev->dev, "Initializing droq bh work\n");
+	INIT_WORK(&oct_priv->droq_bh_work, octeon_droq_bh);
 
 	/* Setup the interrupt handler and record the INT SUM register address
 	 */
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 62c2eadc33e3..04117625f388 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -87,7 +87,7 @@ static int lio_wait_for_oq_pkts(struct octeon_device *oct)
 		}
 		if (pkt_cnt > 0) {
 			pending_pkts += pkt_cnt;
-			tasklet_schedule(&oct_priv->droq_tasklet);
+			queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 		}
 		pkt_cnt = 0;
 		schedule_timeout_uninterruptible(1);
@@ -584,7 +584,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		break;
 	}
 
-	tasklet_kill(&oct_priv->droq_tasklet);
+	cancel_work_sync(&oct_priv->droq_bh_work);
 }
 
 /**
@@ -687,7 +687,7 @@ static void liquidio_destroy_nic_device(struct octeon_device *oct, int ifidx)
 	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 		netif_napi_del(napi);
 
-	tasklet_enable(&oct_priv->droq_tasklet);
+	enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 
 	if (atomic_read(&lio->ifstate) & LIO_IFSTATE_REGISTERED)
 		unregister_netdev(netdev);
@@ -911,7 +911,7 @@ static int liquidio_open(struct net_device *netdev)
 	int ret = 0;
 
 	if (!oct->props[lio->ifidx].napi_enabled) {
-		tasklet_disable(&oct_priv->droq_tasklet);
+		disable_work_sync(&oct_priv->droq_bh_work);
 
 		list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 			napi_enable(napi);
@@ -986,7 +986,7 @@ static int liquidio_stop(struct net_device *netdev)
 
 		oct->droq[0]->ops.poll_mode = 0;
 
-		tasklet_enable(&oct_priv->droq_tasklet);
+		enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 	}
 
 	cancel_delayed_work_sync(&lio->stats_wk.work);
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
index eef12fdd246d..4e5f8bbc891b 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
@@ -96,7 +96,7 @@ u32 octeon_droq_check_hw_for_pkts(struct octeon_droq *droq)
 	last_count = pkt_count - droq->pkt_count;
 	droq->pkt_count = pkt_count;
 
-	/* we shall write to cnts  at napi irq enable or end of droq tasklet */
+	/* we shall write to cnts  at napi irq enable or end of droq bh_work */
 	if (last_count)
 		atomic_add(last_count, &droq->pkts_pending);
 
@@ -764,7 +764,7 @@ octeon_droq_process_packets(struct octeon_device *oct,
 				(u16)rdisp->rinfo->recv_pkt->rh.r.subcode));
 	}
 
-	/* If there are packets pending. schedule tasklet again */
+	/* If there are packets pending. schedule bh_work again */
 	if (atomic_read(&droq->pkts_pending))
 		return 1;
 
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_main.h b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
index 5b4cb725f60f..a8f2a0a7b08e 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_main.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
@@ -24,6 +24,7 @@
 #define  _OCTEON_MAIN_H_
 
 #include <linux/sched/signal.h>
+#include <linux/workqueue.h>
 
 #if BITS_PER_LONG == 32
 #define CVM_CAST64(v) ((long long)(v))
@@ -36,8 +37,7 @@
 #define DRV_NAME "LiquidIO"
 
 struct octeon_device_priv {
-	/** Tasklet structures for this device. */
-	struct tasklet_struct droq_tasklet;
+	struct work_struct droq_bh_work;
 	unsigned long napi_mask;
 	struct octeon_device *dev;
 };
-- 
2.34.1


