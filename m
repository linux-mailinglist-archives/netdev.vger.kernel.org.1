Return-Path: <netdev+bounces-184243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82929A93FBF
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3973F1B61360
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A8253B57;
	Fri, 18 Apr 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLm/tZuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C32522B0
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014384; cv=none; b=qjA3aybqEauWZ3c5hD8lk1q4aNQgHMzKcWXTAtYycQdjf7oX84c/HxNzeGA2pn6IDDZ20Y70ajCRejYFCmpdrieD7cdcX942fceMN0jm+QBy9+vY+BliAEEK3VL6LAdd5ctIA9My1oQ3kv0YnGI8hkaiq/OTyFkWRGY01pTOEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014384; c=relaxed/simple;
	bh=fzExnUxA0ISyhzT30/stIovGDCvMqxhEMRnUGa9MSFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SntDrfKmtNUFbem2VukwZcum8dVmzVxF2/Vs1UzSkl7SvF6Sp7LUEeF7auYRAiAufzkmIFbpW7yVnW0piHEz6XUKwcyjwpwmmLOIoCDTH6YCDqHhvJTdTBycVwpi9wuFwBt0ld3eVeA5Ax2GAgYUG7CYfOhxL3TTTtnJdYM2ByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLm/tZuE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso1350730a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745014382; x=1745619182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVDzcEVYfKe2XKNLs+lKXeA6Y6i2Guq3xjb1EYfIjrY=;
        b=uLm/tZuEJC2R7Np/FPXsxP+fXlArqnks4JexpbCtjsE7rdGJEEXODViIksbNEX2cDg
         oU0KLeXtwnvLrqU0USet/PBxz+BKRvCuoefpiSX6k/I2h9CJ5go9BCkFS82xYZFyQlct
         /fMSKIIyPZKWev2srKe1YRJ+I3zghxD5CO7r+KMpGdQTYT4gZuBealW8Bf5CWPT0JTk0
         zmjrGz36OgJfNnepezynDsFevELa3FwasYeDt/Fd0gUE9GRfYEmmfruBQvFKMt8zJJhn
         Y3gqfrm2u4KBxCnU2K1elxTYz1xdzrqLw2rdMq6AIdU48d4qArEd1wL5BHAq6fvhelBc
         VNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014382; x=1745619182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVDzcEVYfKe2XKNLs+lKXeA6Y6i2Guq3xjb1EYfIjrY=;
        b=U8jAE8Hb0XaugDbaVitYx7Y8WgZ4F7pFQhAo1iF9ca8EI8wFMDFS0PqvE2NOLnOIXF
         lMA5kVG8kU/bVV4a6yxZgbt0PD6ndvRppBvG/ABq6nv9iIAqeMOBDH+M23iZcGBvq2DD
         9r/0v8azbDbowYgFQpxru58M+1fygmRSk6MAgDTq51hcvUsYPIJ/6BExVbp6KLFd+f0G
         frMR8SumPNjxf0GxcJ+YeYwl7YNwBBLNrfy87lFypPFrIm6UsgW3z55PjwwGXyZRgxp/
         N3aj0RiCV7Y8iCdwHHBXrunf59XkLPhfzjJfLKgpw64BHyj4gqdjOd4gp2N3KZzpkljh
         3btg==
X-Gm-Message-State: AOJu0Yzu7zNFoNe/X2oIhiBt+RKylo/Xma39OA0/pdTOXZ67Xlngycds
	PjNCIg5D0WwSB6JjaHXYqUVgu8d10TcM+cg6Pg0n7mwIc6DSnYhKZhhQbzu6UcxxQH7hDOcYFnq
	lVO9gZOAllsJqBuDlsfM0LHK7/+eUhpDM+wuUQFEADdyVRhgikpAYmb7RysZxbThjmmq26EtA3N
	Le4jEJ4w1U5irSNmzxyKEd2+0sG/qSamehcjOvzIupk3da9BKa0n8S39mhqKE=
X-Google-Smtp-Source: AGHT+IGtYSnqYirJdhGczaNALEr4XGlPgu41IjcJLHoAc7hU2KFh0TP56sIMAUxO7Rvj70QlX+bykpvSwomB2m58RA==
X-Received: from pjx11.prod.google.com ([2002:a17:90b:568b:b0:305:2d2a:dfaa])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:394f:b0:2fe:afa7:eaf8 with SMTP id 98e67ed59e1d1-3087bb49233mr6164139a91.13.1745014382268;
 Fri, 18 Apr 2025 15:13:02 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:12:51 +0000
In-Reply-To: <20250418221254.112433-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418221254.112433-4-hramamurthy@google.com>
Subject: [PATCH net-next 3/6] gve: Add initial gve_clock
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kevin Yang <yyd@google.com>

This initial version of the gve clock only performs one major function,
managing querying the nic clock and storing the results.

The timestamp delivered in descriptors has a wraparound time of ~4
seconds so 250ms is chosen as the sync cadence to provide a balance
between performance, and drift potential when we do start associating
host time and nic time.

A dedicated ordered workqueue has been setup to ensure a consistent
cadence for querying the nic clock.

Co-developed-by: John Fraker <jfraker@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Co-developed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kevin Yang <yyd@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/Makefile    |   2 +-
 drivers/net/ethernet/google/gve/gve.h       |   8 ++
 drivers/net/ethernet/google/gve/gve_clock.c | 103 ++++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_clock.c

diff --git a/drivers/net/ethernet/google/gve/Makefile b/drivers/net/ethernet/google/gve/Makefile
index 4520f1c07a63..c8fae2c03f2b 100644
--- a/drivers/net/ethernet/google/gve/Makefile
+++ b/drivers/net/ethernet/google/gve/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_GVE) += gve.o
 gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o \
-	    gve_buffer_mgmt_dqo.o
+	    gve_buffer_mgmt_dqo.o gve_clock.o
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index cf6947731a9b..5a141a8735d6 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -873,7 +873,12 @@ struct gve_priv {
 	struct gve_rss_config rss_config;
 
 	/* True if the device supports reading the nic clock */
+	struct workqueue_struct *gve_ts_wq;
 	bool nic_timestamp_supported;
+	struct delayed_work nic_ts_sync_task;
+	struct gve_nic_ts_report *nic_ts_report;
+	dma_addr_t nic_ts_report_bus;
+	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
 };
 
 enum gve_service_task_flags_bit {
@@ -1255,6 +1260,9 @@ int gve_flow_rules_reset(struct gve_priv *priv);
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
 /* report stats handling */
 void gve_handle_report_stats(struct gve_priv *priv);
+/* Timestamping */
+int gve_init_clock(struct gve_priv *priv);
+void gve_teardown_clock(struct gve_priv *priv);
 /* exported by ethtool.c */
 extern const struct ethtool_ops gve_ethtool_ops;
 /* needed by ethtool */
diff --git a/drivers/net/ethernet/google/gve/gve_clock.c b/drivers/net/ethernet/google/gve/gve_clock.c
new file mode 100644
index 000000000000..464ce9a6f4b6
--- /dev/null
+++ b/drivers/net/ethernet/google/gve/gve_clock.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Google virtual Ethernet (gve) driver
+ *
+ * Copyright (C) 2015-2025 Google LLC
+ */
+
+#include "gve.h"
+#include "gve_adminq.h"
+
+/* Interval to schedule a nic timestamp calibration, 250ms. */
+#define GVE_NIC_TS_SYNC_INTERVAL_MS 250
+
+/* Read the nic timestamp from hardware via the admin queue. */
+static int gve_clock_nic_ts_read(struct gve_priv *priv)
+{
+	u64 nic_raw;
+	int err;
+
+	err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
+	if (err)
+		return err;
+
+	nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
+
+	return 0;
+}
+
+static void gve_nic_ts_sync_task(struct work_struct *work)
+{
+	struct gve_priv *priv = container_of(work, struct gve_priv,
+					     nic_ts_sync_task.work);
+	int err;
+
+	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
+		goto out;
+
+	err = gve_clock_nic_ts_read(priv);
+	if (err && net_ratelimit())
+		dev_err(&priv->pdev->dev,
+			"%s read err %d\n", __func__, err);
+
+out:
+	queue_delayed_work(priv->gve_wq, &priv->nic_ts_sync_task,
+			   msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS));
+}
+
+int gve_init_clock(struct gve_priv *priv)
+{
+	int err;
+
+	if (!priv->nic_timestamp_supported)
+		return -EPERM;
+
+	priv->nic_ts_report =
+		dma_alloc_coherent(&priv->pdev->dev,
+				   sizeof(struct gve_nic_ts_report),
+				   &priv->nic_ts_report_bus,
+				   GFP_KERNEL);
+	if (!priv->nic_ts_report) {
+		dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func__);
+		return -ENOMEM;
+	}
+
+	err = gve_clock_nic_ts_read(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "%s read error %d\n", __func__, err);
+		goto free_nic_ts_report;
+	}
+
+	priv->gve_ts_wq = alloc_ordered_workqueue("gve-ts", 0);
+	if (!priv->gve_ts_wq) {
+		dev_err(&priv->pdev->dev, "%s Could not allocate workqueue\n",
+			__func__);
+		err = -ENOMEM;
+		goto free_nic_ts_report;
+	}
+	INIT_DELAYED_WORK(&priv->nic_ts_sync_task, gve_nic_ts_sync_task);
+	queue_delayed_work(priv->gve_ts_wq, &priv->nic_ts_sync_task,
+			   msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS));
+
+	return 0;
+
+free_nic_ts_report:
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(struct gve_nic_ts_report),
+			  priv->nic_ts_report, priv->nic_ts_report_bus);
+	priv->nic_ts_report = NULL;
+
+	return err;
+}
+
+void gve_teardown_clock(struct gve_priv *priv)
+{
+	if (priv->nic_ts_report) {
+		cancel_delayed_work_sync(&priv->nic_ts_sync_task);
+		destroy_workqueue(priv->gve_ts_wq);
+		dma_free_coherent(&priv->pdev->dev,
+				  sizeof(struct gve_nic_ts_report),
+				  priv->nic_ts_report, priv->nic_ts_report_bus);
+		priv->nic_ts_report = NULL;
+	}
+}
-- 
2.49.0.805.g082f7c87e0-goog


