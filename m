Return-Path: <netdev+bounces-288093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMjfL8xTBmr1igIAu9opvQ
	(envelope-from <netdev+bounces-288093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:59:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C165479DF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0B213056625
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742C3D3319;
	Thu, 14 May 2026 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBaBlTzj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74023D1CB4
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799528; cv=none; b=NVAnbtNCCknIm4HxOn8iTabNTVI6wRw18KzjfjMX8kdW1mmmMq78XaaI8rSlb9/Htj6ykcC/dTuRlUOKafwF4DsLCGD05ZYDsGwHXJm03YHbs0ONgvl3XHk1Unr4OQMVDNfqQETS1YwKywjg8Q0/g90IDlY2pokfk+Fl3I1P60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799528; c=relaxed/simple;
	bh=0DD9rjB5GTNjQluYl02Y1Z4bepFZsnNsAI8j7hj5U4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CPdTmZ78tRe0M0FIVdCuSgA4GdthcsuEx+pzl4BqHO9j5IAJCkKCE8J07YiYE+uY3F1vYiFRerzN5tVSlNyusw+RH/nolykwl6IF9Sga3wqjULxnVWjtiTVliWekroDYzQ5wIiu6wBoI4/4hSywowVai0Q/fxnL40e6aiFh9EAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBaBlTzj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3684cb22502so6135278a91.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778799526; x=1779404326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Be9n0TSFV63sL8pFxNb1gfZ5SE9OhS6w+nQSdYprDos=;
        b=SBaBlTzjFJt9Uk8Zr+YbeKF0glFAuvRuKvYpCDZq6d2B852ogaAObHcskYLWlqKS9i
         W8GX/1kXawcZAh2Fq06KD4IHPtgHi3YpBMaPwuigjFVF6Ir33QFmOasGTt1f5EAeNnBs
         OOR4gLWxDbxVFyUv4VmGZDNYHiWKyPNgqeCtCQaCvBZvIYjrbsjltcWK5UbSSG+HPsaO
         fNFOfZvorhfVmLIMBLQkEfQk4HKn2gsioMcWuIXh7CYAYGBNjrhlAMKOohjfmXMX/uu1
         7XkkRg9OloLgyMn25iyfOCUneIKqAS/lep1DnArG0seAqfvl0o8LA9m/WWnJwtNPfgI9
         CYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799526; x=1779404326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be9n0TSFV63sL8pFxNb1gfZ5SE9OhS6w+nQSdYprDos=;
        b=lHdRWvhEinU9MlQOy0TuHndTh2moRWyWkwS/VMKiL6twxYDlgEEQZMQs2w0d1eESs9
         vebLx0KFvCHtEWEwG9xjsGNQF4KbeIrXjm/F+DplIomfZA2Sv2qyQ4UD9lgMOGTsU6HT
         3ehJnvnnrayEB95ORK68Ovs/EZAauKDAPLEWMa0eV5am2yCgOl3CcqlBjKBpRiOUjZSf
         G83wnH6rzANkSyUIEVwnWtlWwlPwvZSayuDFtivElLwXtCWTrxZaNuh319RkThjv2JAA
         1QAsHB31tBd2yBLorPiNu2ys/w0EVuOb61ofTzeL2qp7o+03wnjjbNlv0qVucjKTwtxk
         +KDA==
X-Gm-Message-State: AOJu0YwY+vcrxnnqrmcGFDJmyHFyUIxlYVOY64dBPfm3xDpT8K8QC93r
	ki+13UH/xmC20beNv/mbBSHG1TtxyFjGrE8+duMxQgrhXhX0WRD/V9ODqHRQLgGlTT1NpmjohY0
	RmZaNellQX+h1kPgCTtYWHuOCu6vX0ovDiSKT+Curou3r72mX4K6r0LbHKeR8gZ3u1aVibYeJpn
	M2jRPMZiqOw9afj+EEuHFYCHKmHpzK6kjiIaqNAKJowAh/cxvbjkCKXz+mw+cu2nE=
X-Received: from pjbgt11.prod.google.com ([2002:a17:90a:f2cb:b0:366:755:eae1])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d88b:b0:368:65bc:e32b with SMTP id 98e67ed59e1d1-36951b96e21mr1089329a91.15.1778799525785;
 Thu, 14 May 2026 15:58:45 -0700 (PDT)
Date: Thu, 14 May 2026 22:58:41 +0000
In-Reply-To: <20260514225842.110706-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514225842.110706-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260514225842.110706-3-hramamurthy@google.com>
Subject: [PATCH net-next v8 2/3] gve: make nic clock reads thread safe
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
X-Rspamd-Queue-Id: 46C165479DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288093-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

Add a mutex to protect the shared DMA buffer that receives NIC
timestamp reports. The NIC timestamp will be read from two different
threads: the periodic worker and upcoming `gettimex64`.

Move clock registration to the last step of initialization to ensure
that all data needed by the clock module is initialized before
the clock is exposed to usermode.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Ankit Garg <nktgrg@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v7:
- Picked up Jake Keller's review tag

Changes in v3:
- Reorder init/teardown to register PTP clock last, and simplify code
- Move ptp-related members from gve_priv to gve_ptp
- Only assign priv->ptp after ptp module is successfully initialized
---
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
2.54.0.563.g4f69b47b94-goog


