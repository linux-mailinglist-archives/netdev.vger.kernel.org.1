Return-Path: <netdev+bounces-285494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKikEqAA/WmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E14EF27F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D0EB304F2EA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF85344D95;
	Thu,  7 May 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiXnkU7C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92733F58C
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188390; cv=none; b=bRIXdQWvfr983itgNZCC2olqGWHYaToKxz0PLiXCxpV0OUDqp5lQa2saf62JflE5eorChKhmgyKKEb1PIH8JrgatJy7rpinXowurjKixfOGyEStJJoZlM5Ua+BGFR6eztOmW04r371PNI5AgoAiQEVYU+/qfXyHmeTOIlUnB78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188390; c=relaxed/simple;
	bh=i9L8XnvSFiPpXIC0LouXBHFGUfPyALs9LPvamcJaDKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDCJo1HfvvTqyR2Isap85QEebK9vo/350ikGpNcs4ntTMmOlYV5ap6X8HYTfXjY83wRR1CvpM9sSZhZBIB0Qs7IjRs+UAIxp5QbHnuN3FdJA+ziRW5ANuUHcaff+X4LIZvys1Kdv5Vkoq7SrSlgulRS1d1kb15WvRynieC3RLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiXnkU7C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36531a0f95bso1555734a91.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778188388; x=1778793188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlzKRi1235IEdxnPrVCGp9XETwfEZvpjn5soN3/viWU=;
        b=IiXnkU7C06qlvaOn220HCJVHjIAvDr4kuhqK7Ax9vjlqi+atNoEixNfptafZkNSujJ
         L9HVImUqkIz9aX09x8fUiikxWqh6ShmXue5f5d9Pkd91JpZxHdcpnUTH6A3Vp18nklIu
         EQuQXVvjZ5j5jC34oqHe1ks3dFgXzQyjo0CFeBkla1ztNDvCKt2islhsscdQyxZuv8Ws
         ql9DzsEJrw6FNC8scHpjUokbOv2Nkdq/n5KsxuF+Wpr+q12HZCuUg7BHtl8EjsNlkgwJ
         sktPe8KQLehOPzI5cw96F9ng+gF375LcXRXduU8M8+yJDNnXpR4BO+8agDpqHFj5GRRS
         hYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188388; x=1778793188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlzKRi1235IEdxnPrVCGp9XETwfEZvpjn5soN3/viWU=;
        b=n9uzxNxUweAaW8JHoIKIPr/dNMp+XEQOfct/aooZOm5Rw8uMShChqR7oGaCvceHuz+
         zPhKH67VDIkIbisxEJHV6HkVdHVdDJa+0MAPxnqMqjqWtD2P6+p3YxH94m/t4rK20RVR
         00mZlq+dNm6Bvd0zBizT5Kd1/yExQYKcmyYLyI6CH//RZ6JrMUkUtfsRs+ROtm0UxRYJ
         Do+w/NgHFffX9L0ULpMx9TTjOV7Wk3hgh1Z2hlqJ3wg19Po0pvYSMAuObOFvze6R+fE5
         2XHbXoULCXfZBvBbq58k5IDY+3DX3AE+K7sOuFZrNcbVQvvpNz45vFx3t8dDDL+o35OS
         cpLg==
X-Gm-Message-State: AOJu0YzgwDl93wxFxIDK2jDHBs0VoIu3968HcFD6vLsjakDfa/2ismRE
	14WRCBWC5QbkV/ZvDF+rztQmCsHtYUyIC2S3yc6lS2krF6HMAEB9Bfvc/0JTcq5VObfGo1804Rn
	5VAVMlv3XbvBBRikv8d61xYoq8ZYuj0QwUTawVUtoXsQGFOY/HAVw725K35rOTX2GbUlL/yU8Po
	O8M31jk2uhipnKYFAgm0ef6upHFC+g2OzexMTwbnZ2tsWMqsiDV7Ai2b6hEuIJeI0=
X-Received: from pgbcp3.prod.google.com ([2002:a05:6a02:4003:b0:c82:2dd8:9d49])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3c90:b0:3a1:90fd:dcd6 with SMTP id adf61e73a8af0-3aab16e9e2bmr24266637.31.1778188388016;
 Thu, 07 May 2026 14:13:08 -0700 (PDT)
Date: Thu,  7 May 2026 21:13:03 +0000
In-Reply-To: <20260507211304.3046526-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507211304.3046526-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507211304.3046526-3-hramamurthy@google.com>
Subject: [PATCH net-next v6 2/3] gve: make nic clock reads thread safe
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9F4E14EF27F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

Add a mutex to protect the shared DMA buffer that receives NIC
timestamp reports. The NIC timestamp will be read from two different
threads: the periodic worker and upcoming `gettimex64`.

Move clock registration to the last step of initialization to ensure
that all data needed by the clock module is initialized before
the clock is exposed to usermode.

Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Ankit Garg <nktgrg@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v3:
- Reorder init/teardown to register PTP clock last, and simplify code
- Move ptp-related members from gve_priv to gve_ptp
- Only assign priv->ptp after ptp module is successfully initialized
---
 drivers/net/ethernet/google/gve/gve.h         |  12 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 134 ++++++++----------
 3 files changed, 63 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1d66d3834f7e..7b69d0cfc0d5 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -792,6 +792,9 @@ struct gve_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct gve_priv *priv;
+	struct mutex nic_ts_read_lock; /* Protects nic_ts_report */
+	struct gve_nic_ts_report *nic_ts_report;
+	dma_addr_t nic_ts_report_bus;
 };
 
 struct gve_priv {
@@ -923,8 +926,6 @@ struct gve_priv {
 	bool nic_timestamp_supported;
 	struct gve_ptp *ptp;
 	struct kernel_hwtstamp_config ts_config;
-	struct gve_nic_ts_report *nic_ts_report;
-	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
 };
 
@@ -1201,7 +1202,7 @@ static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
 
 static inline bool gve_is_clock_enabled(struct gve_priv *priv)
 {
-	return priv->nic_ts_report;
+	return priv->ptp;
 }
 
 /* gqi napi handler defined in gve_main.c */
@@ -1321,14 +1322,9 @@ int gve_flow_rules_reset(struct gve_priv *priv);
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
 /* PTP and timestamping */
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
-int gve_clock_nic_ts_read(struct gve_priv *priv);
 int gve_init_clock(struct gve_priv *priv);
 void gve_teardown_clock(struct gve_priv *priv);
 #else /* CONFIG_PTP_1588_CLOCK */
-static inline int gve_clock_nic_ts_read(struct gve_priv *priv)
-{
-	return -EOPNOTSUPP;
-}
 
 static inline int gve_init_clock(struct gve_priv *priv)
 {
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index dc2213b5ce24..4fd7e8a442c5 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -972,8 +972,7 @@ static int gve_get_ts_info(struct net_device *netdev,
 		info->rx_filters |= BIT(HWTSTAMP_FILTER_NONE) |
 				    BIT(HWTSTAMP_FILTER_ALL);
 
-		if (priv->ptp)
-			info->phc_index = ptp_clock_index(priv->ptp->clock);
+		info->phc_index = ptp_clock_index(priv->ptp->clock);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 06b1cf4a5efc..ad15f1209a83 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -11,19 +11,20 @@
 #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
 
 /* Read the nic timestamp from hardware via the admin queue. */
-int gve_clock_nic_ts_read(struct gve_priv *priv)
+static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
 {
-	u64 nic_raw;
 	int err;
 
-	err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
+	mutex_lock(&ptp->nic_ts_read_lock);
+	err = gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bus);
 	if (err)
-		return err;
+		goto out;
 
-	nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
-	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
+	*nic_raw = be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
 
-	return 0;
+out:
+	mutex_unlock(&ptp->nic_ts_read_lock);
+	return err;
 }
 
 static int gve_ptp_gettimex64(struct ptp_clock_info *info,
@@ -41,17 +42,21 @@ static int gve_ptp_settime64(struct ptp_clock_info *info,
 
 static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 {
-	const struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
+	struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
 	struct gve_priv *priv = ptp->priv;
+	u64 nic_raw;
 	int err;
 
 	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
 		goto out;
 
-	err = gve_clock_nic_ts_read(priv);
-	if (err && net_ratelimit())
-		dev_err(&priv->pdev->dev,
-			"%s read err %d\n", __func__, err);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	if (err) {
+		dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
+				    __func__, err);
+		goto out;
+	}
+	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
 
 out:
 	return msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS);
@@ -65,94 +70,71 @@ static const struct ptp_clock_info gve_ptp_caps = {
 	.do_aux_work	= gve_ptp_do_aux_work,
 };
 
-static int gve_ptp_init(struct gve_priv *priv)
+int gve_init_clock(struct gve_priv *priv)
 {
 	struct gve_ptp *ptp;
+	u64 nic_raw;
 	int err;
 
-	priv->ptp = kzalloc_obj(*priv->ptp);
-	if (!priv->ptp)
+	ptp = kzalloc_obj(*priv->ptp);
+	if (!ptp)
 		return -ENOMEM;
 
-	ptp = priv->ptp;
 	ptp->info = gve_ptp_caps;
-	ptp->clock = ptp_clock_register(&ptp->info, &priv->pdev->dev);
-
-	if (IS_ERR(ptp->clock)) {
-		dev_err(&priv->pdev->dev, "PTP clock registration failed\n");
-		err  = PTR_ERR(ptp->clock);
-		goto free_ptp;
-	}
-
 	ptp->priv = priv;
-	return 0;
-
-free_ptp:
-	kfree(ptp);
-	priv->ptp = NULL;
-	return err;
-}
-
-static void gve_ptp_release(struct gve_priv *priv)
-{
-	struct gve_ptp *ptp = priv->ptp;
-
-	if (!ptp)
-		return;
-
-	if (ptp->clock)
-		ptp_clock_unregister(ptp->clock);
-
-	kfree(ptp);
-	priv->ptp = NULL;
-}
-
-int gve_init_clock(struct gve_priv *priv)
-{
-	int err;
-
-	err = gve_ptp_init(priv);
-	if (err)
-		return err;
-
-	priv->nic_ts_report =
+	mutex_init(&ptp->nic_ts_read_lock);
+	ptp->nic_ts_report =
 		dma_alloc_coherent(&priv->pdev->dev,
 				   sizeof(struct gve_nic_ts_report),
-				   &priv->nic_ts_report_bus,
-				   GFP_KERNEL);
-	if (!priv->nic_ts_report) {
+				   &ptp->nic_ts_report_bus, GFP_KERNEL);
+	if (!ptp->nic_ts_report) {
 		dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func__);
 		err = -ENOMEM;
-		goto release_ptp;
+		goto free_ptp;
 	}
-	err = gve_clock_nic_ts_read(priv);
+
+	err = gve_clock_nic_ts_read(ptp, &nic_raw);
 	if (err) {
 		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
-		goto release_nic_ts_report;
+		goto free_dma_mem;
 	}
-	ptp_schedule_worker(priv->ptp->clock,
+	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
+
+	ptp->clock = ptp_clock_register(&ptp->info, &priv->pdev->dev);
+	if (IS_ERR(ptp->clock)) {
+		dev_err(&priv->pdev->dev, "PTP clock registration failed\n");
+		err = PTR_ERR(ptp->clock);
+		goto free_dma_mem;
+	}
+
+	priv->ptp = ptp;
+	ptp_schedule_worker(ptp->clock,
 			    msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS));
 
 	return 0;
 
-release_nic_ts_report:
-	dma_free_coherent(&priv->pdev->dev,
-			  sizeof(struct gve_nic_ts_report),
-			  priv->nic_ts_report, priv->nic_ts_report_bus);
-	priv->nic_ts_report = NULL;
-release_ptp:
-	gve_ptp_release(priv);
+free_dma_mem:
+	dma_free_coherent(&priv->pdev->dev, sizeof(struct gve_nic_ts_report),
+			  ptp->nic_ts_report, ptp->nic_ts_report_bus);
+	ptp->nic_ts_report = NULL;
+free_ptp:
+	mutex_destroy(&ptp->nic_ts_read_lock);
+	kfree(ptp);
 	return err;
 }
 
 void gve_teardown_clock(struct gve_priv *priv)
 {
-	gve_ptp_release(priv);
+	struct gve_ptp *ptp = priv->ptp;
 
-	if (priv->nic_ts_report) {
-		dma_free_coherent(&priv->pdev->dev,
-				  sizeof(struct gve_nic_ts_report),
-				  priv->nic_ts_report, priv->nic_ts_report_bus);
-		priv->nic_ts_report = NULL;
-	}
+	if (!ptp)
+		return;
+
+	priv->ptp = NULL;
+	ptp_clock_unregister(ptp->clock);
+	dma_free_coherent(&priv->pdev->dev, sizeof(struct gve_nic_ts_report),
+			  ptp->nic_ts_report, ptp->nic_ts_report_bus);
+	ptp->nic_ts_report = NULL;
+	mutex_destroy(&ptp->nic_ts_read_lock);
+	kfree(ptp);
 }
-- 
2.54.0.545.g6539524ca2-goog


