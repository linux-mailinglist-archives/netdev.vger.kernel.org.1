Return-Path: <netdev+bounces-195825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE670AD25CB
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB453B20F5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C8220F4D;
	Mon,  9 Jun 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHiis1m8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189212206B2
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494443; cv=none; b=KVKIuy0fOQgn6c/FcApeP5x3i1zC1RaCY9LZ2Y4SXbMUxQgcfxdGojo6A5Xzo0PIKzoVOHtOa+6q6+ACvNEGOkM7lzseHUA9SlEiflMMQSkBrkTmEPSNIr8G7BnqO5ti9ZTilY4lOa8Bofh0uMcP3GXJ2P9aukEWXzBQhCFJ+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494443; c=relaxed/simple;
	bh=YQvevirhrMBBhVBJpz0R5UNpqVI/DpvbzZONT42/8qA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cO81C/Xds2JZyxBerefviXvWtPFeuNWgPjx6b3kZY3kiDrq0bLQPUPpfNQ+fSNW+iAk8R+WsOgJZx6pzsv29iZNAPyvcI8JGhG8/f3qDnxCSW4ayQO1sy21v8doTM6Yzy8W1N8n70hqc2t5v46RTfe4kkTjSXUs27NWIsBpNctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHiis1m8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-745e89b0c32so7271530b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 11:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749494441; x=1750099241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyIiE0DA8YOamFQPV3OD2HjNkzHWrf5ibVavvJjs3RE=;
        b=OHiis1m8jiMdABzmorvqjnXwLiJxAko4Pys9D59wUm4l/DTREvxvE2wV8GZXyt/iBs
         rxdj/5QZ+6Btvfi5eqSVYvwt1aRRvRbZAVAdIxQMmMW3OmZ/LeSgoqp2mzeNUbwwwjNp
         Y5XoARYg83bn/Ry+LjbRhkhJYGOwMvaYMl5iqLUHJ9cxtCrPqvISEbc8Rnm1w3IRLcAf
         WAGz9GxbYN+XgCLNWKAfsgE3TZWi897DbeANooImjQvNOYM0F+3XvU5JDSZdxv/cfUIa
         zYs1BYmSenvg4FvzmBGk5C2lBnZW99ONlykMdRRyGL51dmmiGZ9llBuuwYQ+k3C2fCCt
         mZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749494441; x=1750099241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyIiE0DA8YOamFQPV3OD2HjNkzHWrf5ibVavvJjs3RE=;
        b=jGp+1yh4J7/Wx7buaeGTzNwHqsT9Nzv6r7i/dxyitiOd5jWT20KV+b0bCXkFCKnwlf
         3QPLvFLJVm71u4czATcKXcwRQn8/f0fNyYYv+ma2V4FH5+8hTDwnrm8LU8LnL+Uxwy7l
         kGvQSdIcuSdc3Flk7pFj1CkZC7kMgTjrv7ayrtJjzA+D2JlU4V1x5LcAaJTDWM2jzHRi
         GtbTiMf9oWgWohafrd4QsMIbz1M5yHdPCOKPj8PJd7DLYtozy8Gq+hqCR5nFCPUUIbyq
         LMi4Eu8rvJotfA1bEBnrNA99/kZwkS5vQ3559wS0bAR2B22YNT91Wn6TYYyEb7v8MyRn
         x8MQ==
X-Gm-Message-State: AOJu0YwUnj1bvfiw9JL4q+O9hdndF6xQg3JKw0p6mKVyOdspRQg042Js
	cvqflZyzyKueroK9HshHLQSzdpzoUwFIo+qqRnN/T6M1aQyzHP0jF0nQAEXM/7z3fgYh0cDsflW
	NF8GwtQjo+yrcpkcEH+BbvL9b1R8txS/s1olZouvH1oD6EVHNAcjZyiFSkl5/PtWKoT52+zMx1x
	M/ueS5tpjXPpwUtDn6Ttc+HGE2llm1JHqcR+b7u+e1JFJtdVkVGWXaOoHMOj+0Z8s=
X-Google-Smtp-Source: AGHT+IFD+lKhjQdB5n7ncbcQTai6HQswJDodJXuYgc65s40F3A5QoMI6DDz8flLiC3Lf+7WGt/HvkeeWxfVkA4p6uA==
X-Received: from pfl4.prod.google.com ([2002:a05:6a00:704:b0:746:2d5e:7936])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1492:b0:736:3be3:3d76 with SMTP id d2e1a72fcca58-74827f15a3emr17443454b3a.17.1749494441232;
 Mon, 09 Jun 2025 11:40:41 -0700 (PDT)
Date: Mon,  9 Jun 2025 18:40:26 +0000
In-Reply-To: <20250609184029.2634345-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250609184029.2634345-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250609184029.2634345-6-hramamurthy@google.com>
Subject: [PATCH net-next v4 5/8] gve: Add support to query the nic clock
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
 Changes in v4:
 - release the ptp in the error path of gve_init_clock (Jakub Kicinski)

 Changes in v2:
 - Utilize the ptp's aux_work instead of delayed_work (Jakub Kicinski,
   Vadim Fedorenko)
---
 drivers/net/ethernet/google/gve/gve.h     | 15 +++++
 drivers/net/ethernet/google/gve/gve_ptp.c | 82 ++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8d2aa654fd4c..97054b272e40 100644
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
@@ -1261,6 +1264,18 @@ int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_flow_rules_reset(struct gve_priv *priv);
 /* RSS config */
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
+/* PTP and timestamping */
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+int gve_init_clock(struct gve_priv *priv);
+void gve_teardown_clock(struct gve_priv *priv);
+#else /* CONFIG_PTP_1588_CLOCK */
+static inline int gve_init_clock(struct gve_priv *priv)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void gve_teardown_clock(struct gve_priv *priv) { }
+#endif /* CONFIG_PTP_1588_CLOCK */
 /* report stats handling */
 void gve_handle_report_stats(struct gve_priv *priv);
 /* exported by ethtool.c */
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 293f8dd49afe..fe7e37d6f6b7 100644
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
 
@@ -57,3 +96,42 @@ static void __maybe_unused gve_ptp_release(struct gve_priv *priv)
 	kfree(ptp);
 	priv->ptp = NULL;
 }
+
+int gve_init_clock(struct gve_priv *priv)
+{
+	int err;
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
+	ptp_schedule_worker(priv->ptp->clock, 0);
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
2.50.0.rc0.604.gd4ff7b7c86-goog


