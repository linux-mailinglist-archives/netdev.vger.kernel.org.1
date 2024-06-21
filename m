Return-Path: <netdev+bounces-105784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD6912D52
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70FEB21A37
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6483317B419;
	Fri, 21 Jun 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUq6hkRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB917B428
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995216; cv=none; b=bJmPKEPVGG36ZFSzPZtNaRy4eVmFsET5UNZ/VZMln6pmtIKx8OvV9GiBwkim/KbKqVY0VsfiKbS8ZBJBF+9jhx1EmAE1DE+Zv4SiKn6sZoEoAb3wU1r7afthbsZYmdVXt3GUHg54m8pxcdWFVOGKM3ju7XYQIHa8zJW0tqrtPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995216; c=relaxed/simple;
	bh=0lVjZMbqARbw7gbAYzWGubSXpkB35s6c9hWX6BwHW18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmkzzmXcQicD2FbdXkwK9f21sY7oqjZYCGSb/2f7WnzemZaLpOqOG2jaBGkO67PwqhIOmII217lz/76wcVcKOlYQGqKs/I0eKeozDhkax22EltEEclZB80+73Fz8iA4wJGK+474g3g4YBYZVMyHb8JrT2XtpX7oLFYLmcXciQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUq6hkRd; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-375b2fe7003so9027065ab.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995213; x=1719600013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYc7brdTKERYILuKkf0RRNv0Il2mQiysyxHJxGPSiB4=;
        b=CUq6hkRd6iuO0EPbWqcR3o0L0K0wHwdgK/dmlYLSvuH9jr6QiFEcpJH+78iH3e7fNx
         hkn5fTesvljJ0yNpBBNylldftekh7tdH7UslJJnBowPBKk/12Gcbm0Hon0GNRHfNr4iD
         ygF8V6KzTLA0W4QT76sTGvlRJLN5UVzlp0rophb7r+Fuexj5rCZECBpInRzIFh1Hyg1O
         M0069416AyB3iBg0mBuBhpFG+9VgBpo3vVmJDxGapERR9xPO/rPnYNSIdUUk8ldzZK4I
         3lfd27JLFXzzL98uvEw6ABElEQFi1i7vz36XeAkjwPc/9eAngEq6eQdyGVstyy2tLpHD
         dXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995213; x=1719600013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYc7brdTKERYILuKkf0RRNv0Il2mQiysyxHJxGPSiB4=;
        b=E9YC/6VfpS5CjzFYOqHY/plHRHmjt5TVTiFwgO3rtDRhZMzjfad9XiRZVQxKsoyBUC
         wtC2lt6GrFy/jpkr6WaKvl9kVygTeCY+nAO25vruT6Yyph641pqnpbEUANlc99hXpwwi
         wS2PHB8C3b8B4wNxOXqBh4OkcSsQUu3Uv32fNWRQKmpA+c9Pdre/KssPFzBEShfI34JM
         IXR+CmXqA0hlqYmGYDW7PlmMv9jeK1cp60J5AEEO/tcLdAKn5RF4LORx6ZOqPQay6+qy
         P6vfPV0vV0ZoIeNZ9L4k/PWKmLTuu+Oxl/fdHEjkQ/mxG2lyzM+zLaSwja5Ut4BBDZ1U
         Qynw==
X-Gm-Message-State: AOJu0Yx7GB0/3uxvGoulQwdKvYy5XtUoKOt/12nVqgTtFQe2KEJI4+XV
	yw/6SAfhp2ZRMeC9D9SeT0UqtZbg0Q1zp2Haymx22CHSQNHmWfmGP5MpPw==
X-Google-Smtp-Source: AGHT+IHJkfCkieoldeEyga8SbmaZjT5MvmJfII98djh1j4tZljZ/2qzdRHV4aPnD7Y/8zIrLwhRK+g==
X-Received: by 2002:a05:6e02:1b0a:b0:375:a994:6de0 with SMTP id e9e14a558f8ab-3761d66ed1fmr99006275ab.13.1718995213124;
        Fri, 21 Jun 2024 11:40:13 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:12 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 03/15] net: cnic: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:35 -0700
Message-Id: <20240621183947.4105278-4-allen.lkml@gmail.com>
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
APIs throughout the cnic driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/broadcom/cnic.c | 19 ++++++++++---------
 drivers/net/ethernet/broadcom/cnic.h |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index c2b4188a1ef1..a9040c42d2ff 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -31,6 +31,7 @@
 #include <linux/if_vlan.h>
 #include <linux/prefetch.h>
 #include <linux/random.h>
+#include <linux/workqueue.h>
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 #define BCM_VLAN 1
 #endif
@@ -3015,9 +3016,9 @@ static int cnic_service_bnx2(void *data, void *status_blk)
 	return cnic_service_bnx2_queues(dev);
 }
 
-static void cnic_service_bnx2_msix(struct tasklet_struct *t)
+static void cnic_service_bnx2_msix(struct work_struct *work)
 {
-	struct cnic_local *cp = from_tasklet(cp, t, cnic_irq_task);
+	struct cnic_local *cp = from_work(cp, work, cnic_irq_bh_work);
 	struct cnic_dev *dev = cp->dev;
 
 	cp->last_status_idx = cnic_service_bnx2_queues(dev);
@@ -3036,7 +3037,7 @@ static void cnic_doirq(struct cnic_dev *dev)
 		prefetch(cp->status_blk.gen);
 		prefetch(&cp->kcq1.kcq[KCQ_PG(prod)][KCQ_IDX(prod)]);
 
-		tasklet_schedule(&cp->cnic_irq_task);
+		queue_work(system_bh_wq, &cp->cnic_irq_bh_work);
 	}
 }
 
@@ -3140,9 +3141,9 @@ static u32 cnic_service_bnx2x_kcq(struct cnic_dev *dev, struct kcq_info *info)
 	return last_status;
 }
 
-static void cnic_service_bnx2x_bh(struct tasklet_struct *t)
+static void cnic_service_bnx2x_bh_work(struct work_struct *work)
 {
-	struct cnic_local *cp = from_tasklet(cp, t, cnic_irq_task);
+	struct cnic_local *cp = from_work(cp, work, cnic_irq_bh_work);
 	struct cnic_dev *dev = cp->dev;
 	struct bnx2x *bp = netdev_priv(dev->netdev);
 	u32 status_idx, new_status_idx;
@@ -4428,7 +4429,7 @@ static void cnic_free_irq(struct cnic_dev *dev)
 
 	if (ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX) {
 		cp->disable_int_sync(dev);
-		tasklet_kill(&cp->cnic_irq_task);
+		cancel_work_sync(&cp->cnic_irq_bh_work);
 		free_irq(ethdev->irq_arr[0].vector, dev);
 	}
 }
@@ -4441,7 +4442,7 @@ static int cnic_request_irq(struct cnic_dev *dev)
 
 	err = request_irq(ethdev->irq_arr[0].vector, cnic_irq, 0, "cnic", dev);
 	if (err)
-		tasklet_disable(&cp->cnic_irq_task);
+		disable_work_sync(&cp->cnic_irq_bh_work);
 
 	return err;
 }
@@ -4464,7 +4465,7 @@ static int cnic_init_bnx2_irq(struct cnic_dev *dev)
 		CNIC_WR(dev, base + BNX2_HC_CMD_TICKS_OFF, (64 << 16) | 220);
 
 		cp->last_status_idx = cp->status_blk.bnx2->status_idx;
-		tasklet_setup(&cp->cnic_irq_task, cnic_service_bnx2_msix);
+		INIT_WORK(&cp->cnic_irq_bh_work, cnic_service_bnx2_msix);
 		err = cnic_request_irq(dev);
 		if (err)
 			return err;
@@ -4873,7 +4874,7 @@ static int cnic_init_bnx2x_irq(struct cnic_dev *dev)
 	struct cnic_eth_dev *ethdev = cp->ethdev;
 	int err = 0;
 
-	tasklet_setup(&cp->cnic_irq_task, cnic_service_bnx2x_bh);
+	INIT_WORK(&cp->cnic_irq_bh_work, cnic_service_bnx2x_bh_work);
 	if (ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX)
 		err = cnic_request_irq(dev);
 
diff --git a/drivers/net/ethernet/broadcom/cnic.h b/drivers/net/ethernet/broadcom/cnic.h
index fedc84ada937..1a314a75d2d2 100644
--- a/drivers/net/ethernet/broadcom/cnic.h
+++ b/drivers/net/ethernet/broadcom/cnic.h
@@ -268,7 +268,7 @@ struct cnic_local {
 	u32				bnx2x_igu_sb_id;
 	u32				int_num;
 	u32				last_status_idx;
-	struct tasklet_struct		cnic_irq_task;
+	struct work_struct		cnic_irq_bh_work;
 
 	struct kcqe		*completed_kcq[MAX_COMPLETED_KCQE];
 
-- 
2.34.1


