Return-Path: <netdev+bounces-197678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF9AD98EF
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882923BEB69
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2381741;
	Sat, 14 Jun 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTPdiPzh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECA46447
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859693; cv=none; b=YJPNFNcMmWzFzRo6E4CYzu4yWQFFwlIjZWzMLaKbb05cVTCnkauw983TvxQjRWs4ZSUODNKMRYiYpmcmFe74lStwakN+13/Ha0FBjFavyyALsOLo1GH/Uh4/bq/CvjpJ+sZkwH1UeJcyHoO8TWH8o1AiWVDW5JAnuKDz2id9IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859693; c=relaxed/simple;
	bh=0eGNS+WVUNN50Z5AiPai93dnMlivgIU5IZZ4O2qFo7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sYvHaC0ccIN0TzBTxWQAJX8RUmsWSUdHFP87EfjwAZ38H/LC6bxlbbMWZHcGUSQWqTlp8oRRgnM3hzeROaahcRKOuh348+iKbORAgt+ZB0TtPRFvEgKn3byTCQE21Hil0hxGjs7wgmlUO97vd8uHE+ZFrS9z0+UAQuGwdgapSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTPdiPzh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747cebffd4eso2014720b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859689; x=1750464489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGKQOvqZ0hMp+QDpneOSk7DbvBFQMDy0XsSuv6X7spE=;
        b=fTPdiPzhz2R2WUI4yUbB+qXWN0junA8YEMdP+K1xGf6/l3cHJE92wZJZsCQOhEX9lF
         UQKBcFq3afJ3loJzfAVMo1du8RIGTTIxAlia/gAMg5BmjgPq32Q9V5zQHrB6F3IZaMpu
         zuoC74qUjV7MHDRXaVKanUXXVx9e7HwZFmki1xgytJkoGhTCkxIYVTWIlLGSBNjBUS3S
         L3n3MnVDqUtw96oMoLBWT+8AhQsOIB5//DkB78Q9VNsz+TIL39rDuRaJ6vlXcUmzSF9b
         AIQeMBaCox48l/NUl1jiCjEeCMJASfdlIf4CycdH2iYTHXFbcSj10h1qS5Yn2gJP0OWN
         SEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859689; x=1750464489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGKQOvqZ0hMp+QDpneOSk7DbvBFQMDy0XsSuv6X7spE=;
        b=iXn2kkGohHvzmtACvqPheaIAYF7WrNCQawscQ6XiKOrr0bTGmWAwSIA9ptpUJlGg3X
         nnxprzuH4xsM4u0UV52eD4BGJU8umzoRimCaKgpQsONSUADINodhQeQuOwOgv0BQ4dJc
         BSN+vxdwm90T3+bbTngEgFFeagpnbHt6Tkhh7yqsxP9htqAjvbdONlE+0sh3fUTMdJFu
         CxXpEHizp0PY1dZkXbKBupyWT5dLnjOUEbzzbVYh/wX4qa1ngyJE2K9c+E1YZQFlZYkQ
         exClcjTE9FpnM+Za2X11IzxkUTPt+zxslfAS14ridP/79t3+HCREADRy5SVHvcMbIgI1
         tJQA==
X-Gm-Message-State: AOJu0Yy2I5DCLtsZldK+uKdmsuo9vWbO1tuWxp3jM12nHCLWRtnDd8OH
	LZiz/57uWR8uisYeRKy3NvgzyX4qhvNhv1CHuEdFM4r95xF4blNHYEP9IXVGZ7wI17ST5qNKot/
	g3Sam8N547jE+0Fd9NdTIygHexgBFwV3cnKV1It95ZK8wv7CwQX4VO9SR2zlb82SPuH47LlTIra
	OeTjpFXiYmW2yzhJjM1GQDo8OpjOUfGUsvltQ6VEKPJytSzR1FNpS20Rh6EvwY424=
X-Google-Smtp-Source: AGHT+IEK16tVj5NCDJ1XkyqiOhYgV10WppbBSvcx/r1gSqLmEz4YxeEz72s6Ow1PPZWTj9XFuLo5Ez4jw2TaMeyjlg==
X-Received: from pfva6.prod.google.com ([2002:a05:6a00:c86:b0:746:3244:f1e6])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:430d:b0:1f5:7cb4:b713 with SMTP id adf61e73a8af0-21fbd55995cmr1545169637.19.1749859688859;
 Fri, 13 Jun 2025 17:08:08 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:51 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-6-hramamurthy@google.com>
Subject: [PATCH net-next v5 5/8] gve: Add support to query the nic clock
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kevin Yang <yyd@google.com>

Query the nic clock and store the results. The timestamp delivered
in descriptors has a wraparound time of ~4 seconds so 250ms is chosen
as the sync cadence to provide a balance between performance, and
drift potential when we do start associating host time and nic time.

Leverage PTP's aux_work to query the nic clock periodically.

Signed-off-by: Kevin Yang <yyd@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v5:
 - Change to register PTP when initializing the driver and keep it
   alive until destroying the driver. (Jakub Kicinski)

 Changes in v4:
 - release the ptp in the error path of gve_init_clock (Jakub Kicinski)

 Changes in v2:
 - Utilize the ptp's aux_work instead of delayed_work (Jakub Kicinski,
   Vadim Fedorenko)
---
 drivers/net/ethernet/google/gve/gve.h      | 21 ++++++
 drivers/net/ethernet/google/gve/gve_main.c |  7 +-
 drivers/net/ethernet/google/gve/gve_ptp.c  | 84 +++++++++++++++++++++-
 3 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8d2aa654fd4c..527e17da60bc 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -882,6 +882,9 @@ struct gve_priv {
 	/* True if the device supports reading the nic clock */
 	bool nic_timestamp_supported;
 	struct gve_ptp *ptp;
+	struct gve_nic_ts_report *nic_ts_report;
+	dma_addr_t nic_ts_report_bus;
+	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
 };
 
 enum gve_service_task_flags_bit {
@@ -1261,6 +1264,24 @@ int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_flow_rules_reset(struct gve_priv *priv);
 /* RSS config */
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
+/* PTP and timestamping */
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+int gve_clock_nic_ts_read(struct gve_priv *priv);
+int gve_init_clock(struct gve_priv *priv);
+void gve_teardown_clock(struct gve_priv *priv);
+#else /* CONFIG_PTP_1588_CLOCK */
+static inline int gve_clock_nic_ts_read(struct gve_priv *priv)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int gve_init_clock(struct gve_priv *priv)
+{
+	return 0;
+}
+
+static inline void gve_teardown_clock(struct gve_priv *priv) { }
+#endif /* CONFIG_PTP_1588_CLOCK */
 /* report stats handling */
 void gve_handle_report_stats(struct gve_priv *priv);
 /* exported by ethtool.c */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index dc35a23ec47f..bc2f36962ee8 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -619,9 +619,12 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_alloc_counter_array(priv);
 	if (err)
 		goto abort_with_rss_config_cache;
-	err = gve_alloc_notify_blocks(priv);
+	err = gve_init_clock(priv);
 	if (err)
 		goto abort_with_counter;
+	err = gve_alloc_notify_blocks(priv);
+	if (err)
+		goto abort_with_clock;
 	err = gve_alloc_stats_report(priv);
 	if (err)
 		goto abort_with_ntfy_blocks;
@@ -674,6 +677,8 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_free_stats_report(priv);
 abort_with_ntfy_blocks:
 	gve_free_notify_blocks(priv);
+abort_with_clock:
+	gve_teardown_clock(priv);
 abort_with_counter:
 	gve_free_counter_array(priv);
 abort_with_rss_config_cache:
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 293f8dd49afe..e96247c9d68d 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -5,13 +5,52 @@
  */
 
 #include "gve.h"
+#include "gve_adminq.h"
+
+/* Interval to schedule a nic timestamp calibration, 250ms. */
+#define GVE_NIC_TS_SYNC_INTERVAL_MS 250
+
+/* Read the nic timestamp from hardware via the admin queue. */
+int gve_clock_nic_ts_read(struct gve_priv *priv)
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
+static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
+{
+	const struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
+	struct gve_priv *priv = ptp->priv;
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
+	return msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS);
+}
 
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
+	.do_aux_work	= gve_ptp_do_aux_work,
 };
 
-static int __maybe_unused gve_ptp_init(struct gve_priv *priv)
+static int gve_ptp_init(struct gve_priv *priv)
 {
 	struct gve_ptp *ptp;
 	int err;
@@ -44,7 +83,7 @@ static int __maybe_unused gve_ptp_init(struct gve_priv *priv)
 	return err;
 }
 
-static void __maybe_unused gve_ptp_release(struct gve_priv *priv)
+static void gve_ptp_release(struct gve_priv *priv)
 {
 	struct gve_ptp *ptp = priv->ptp;
 
@@ -57,3 +96,44 @@ static void __maybe_unused gve_ptp_release(struct gve_priv *priv)
 	kfree(ptp);
 	priv->ptp = NULL;
 }
+
+int gve_init_clock(struct gve_priv *priv)
+{
+	int err;
+
+	if (!priv->nic_timestamp_supported)
+		return 0;
+
+	err = gve_ptp_init(priv);
+	if (err)
+		return err;
+
+	priv->nic_ts_report =
+		dma_alloc_coherent(&priv->pdev->dev,
+				   sizeof(struct gve_nic_ts_report),
+				   &priv->nic_ts_report_bus,
+				   GFP_KERNEL);
+	if (!priv->nic_ts_report) {
+		dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func__);
+		err = -ENOMEM;
+		goto release_ptp;
+	}
+
+	return 0;
+
+release_ptp:
+	gve_ptp_release(priv);
+	return err;
+}
+
+void gve_teardown_clock(struct gve_priv *priv)
+{
+	gve_ptp_release(priv);
+
+	if (priv->nic_ts_report) {
+		dma_free_coherent(&priv->pdev->dev,
+				  sizeof(struct gve_nic_ts_report),
+				  priv->nic_ts_report, priv->nic_ts_report_bus);
+		priv->nic_ts_report = NULL;
+	}
+}
-- 
2.50.0.rc1.591.g9c95f17f64-goog


