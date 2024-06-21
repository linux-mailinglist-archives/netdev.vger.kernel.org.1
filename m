Return-Path: <netdev+bounces-105792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C52912D5C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D771C20DE2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA417C214;
	Fri, 21 Jun 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFovGnmi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D317B51A
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995231; cv=none; b=D9jC+bt+xTfw5PZ8c7ri1Gn5ENUCTGZK6nAq3Z1zeVoSRWQAq7XkapTmnplxQkL7iGuqAec4NQDvFVB1rLJnHVaKmMUTcEt85O9lk5XH6id6yza6HG6tVc+f+4U9eobJrzHGy2QU+1RvgX6UQJpNkcLZoP2rweKeAIvoX5E95ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995231; c=relaxed/simple;
	bh=5fDJtwutEEA5fJCM51lQrlFtqk5iBeZOuS616CxfH8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVt0s/71WXoVfXfRoDN6CaMrhgVXISTdjKac9C3FJdq91HY1wrJqP1CxkpBedZlEwRAWD3cIg9U+Uhd/goRBPN05jBnHxgcbMAMVXucvr8sKavHbZqi9KF9ID2PeHAP+mQ6IiLxeoxn6KnJvBtzHcGqEkFhfW9neWcrQEbnyUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFovGnmi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706524adf91so754015b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995228; x=1719600028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEA7niYFvLj2PrS7r2T7s19npKTXpaxvDJNgOhJ1Ngk=;
        b=QFovGnmiNB06s7Ij3CAhI1MlEw4PHbo7Vl3UZ7vXpaBqj8ciagkAq53bz/SHvJCPkI
         P59XnLmqi2bz9CmnAtPpdKkR400itKuJwKa0DtYIt3uV0vp1ggavi3oUT2VIDSHT4SqQ
         +vOHmn1iMKh4yhaJwd5LV5/lQz3VXxLo9gzmsxlpU/9jznSXfNSToXsoWPMeX0mhscrZ
         sXcR33m7javzvymqifxARXsbE7GWfjr9YG2uY+VS8GnvWpJTGL0wVFbiSmoVGjLM+kaL
         rdN0TCnZ8kJX33PwykljJlIouH58t99o6s+sWmx+i+or3fs6XdYfQCa9aoasvetxmm4N
         8cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995228; x=1719600028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEA7niYFvLj2PrS7r2T7s19npKTXpaxvDJNgOhJ1Ngk=;
        b=cmGA6TBZNDwVSMOXn45SM3VYc+/Fo6OYJQEohm+PsDLZVjJdzK+u/GKexxg0H3ZhBE
         TXB09Fsc27ZcOvxijTKLsezyC00bYN8Tj92IorAgYKv0PFPjx455bkaADwPhDNWzaQds
         U3sXABGtx/8BxrZOQUW01wJl0di4pWkpycp+kppoeiwhqZUSTK5VfPJcrguWcGgb4N8w
         MkkOR4YCbYCMc85tA+s64sKF8km5rdOtx/NLMQhIE2otLYAsFvSpJ9zGIcAiyMJt/WQU
         zPwjUp6RzdcEjd18lC0nT6r58uOJnYH3mUxSJZPUo3XA6p9wgQ+tHCKE3XsjYm6RYZn0
         7CTg==
X-Gm-Message-State: AOJu0YyxDFJ+4vvaOj4PNNMr/TzaTsoYIR8C6ESUWba2kuz5sYwBUtiC
	BgyV0ycgt1jvb2tN+5KGAkbtdvjJKyA9ti0ue9e+JfqOlI3Se4dJkqZPqg==
X-Google-Smtp-Source: AGHT+IF+NBvxW9HpXjMSod12uuC1+w9voO4tV30eJc0iEwZziNYyCvIq19rGwFmeAi084MD3xD/fYw==
X-Received: by 2002:a05:6a20:a128:b0:1b8:c2b0:fda2 with SMTP id adf61e73a8af0-1bcbb5d35abmr12392580637.43.1718995228196;
        Fri, 21 Jun 2024 11:40:28 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:27 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 11/15] net: ehea: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:43 -0700
Message-Id: <20240621183947.4105278-12-allen.lkml@gmail.com>
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
APIs throughout the ehea driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/ibm/ehea/ehea.h      |  3 ++-
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea.h b/drivers/net/ethernet/ibm/ehea/ehea.h
index 208c440a602b..c1e7e22884fa 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea.h
+++ b/drivers/net/ethernet/ibm/ehea/ehea.h
@@ -19,6 +19,7 @@
 #include <linux/ethtool.h>
 #include <linux/vmalloc.h>
 #include <linux/if_vlan.h>
+#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
 #include <asm/ibmebus.h>
@@ -381,7 +382,7 @@ struct ehea_adapter {
 	struct platform_device *ofdev;
 	struct ehea_port *port[EHEA_MAX_PORTS];
 	struct ehea_eq *neq;       /* notification event queue */
-	struct tasklet_struct neq_tasklet;
+	struct work_struct neq_bh_work;
 	struct ehea_mr mr;
 	u32 pd;                    /* protection domain */
 	u64 max_mc_mac;            /* max number of multicast mac addresses */
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 1e29e5c9a2df..6960d06805f6 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -976,7 +976,7 @@ int ehea_sense_port_attr(struct ehea_port *port)
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	/* may be called via ehea_neq_tasklet() */
+	/* may be called via ehea_neq_bh_work() */
 	cb0 = (void *)get_zeroed_page(GFP_ATOMIC);
 	if (!cb0) {
 		pr_err("no mem for cb0\n");
@@ -1216,9 +1216,9 @@ static void ehea_parse_eqe(struct ehea_adapter *adapter, u64 eqe)
 	}
 }
 
-static void ehea_neq_tasklet(struct tasklet_struct *t)
+static void ehea_neq_bh_work(struct work_struct *work)
 {
-	struct ehea_adapter *adapter = from_tasklet(adapter, t, neq_tasklet);
+	struct ehea_adapter *adapter = from_work(adapter, work, neq_bh_work);
 	struct ehea_eqe *eqe;
 	u64 event_mask;
 
@@ -1243,7 +1243,7 @@ static void ehea_neq_tasklet(struct tasklet_struct *t)
 static irqreturn_t ehea_interrupt_neq(int irq, void *param)
 {
 	struct ehea_adapter *adapter = param;
-	tasklet_hi_schedule(&adapter->neq_tasklet);
+	queue_work(system_bh_highpri_wq, &adapter->neq_bh_work);
 	return IRQ_HANDLED;
 }
 
@@ -3423,7 +3423,7 @@ static int ehea_probe_adapter(struct platform_device *dev)
 		goto out_free_ad;
 	}
 
-	tasklet_setup(&adapter->neq_tasklet, ehea_neq_tasklet);
+	INIT_WORK(&adapter->neq_bh_work, ehea_neq_bh_work);
 
 	ret = ehea_create_device_sysfs(dev);
 	if (ret)
@@ -3444,7 +3444,7 @@ static int ehea_probe_adapter(struct platform_device *dev)
 	}
 
 	/* Handle any events that might be pending. */
-	tasklet_hi_schedule(&adapter->neq_tasklet);
+	queue_work(system_bh_highpri_wq, &adapter->neq_bh_work);
 
 	ret = 0;
 	goto out;
@@ -3485,7 +3485,7 @@ static void ehea_remove(struct platform_device *dev)
 	ehea_remove_device_sysfs(dev);
 
 	ibmebus_free_irq(adapter->neq->attr.ist1, adapter);
-	tasklet_kill(&adapter->neq_tasklet);
+	cancel_work_sync(&adapter->neq_bh_work);
 
 	ehea_destroy_eq(adapter->neq);
 	ehea_remove_adapter_mr(adapter);
-- 
2.34.1


