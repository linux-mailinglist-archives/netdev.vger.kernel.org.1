Return-Path: <netdev+bounces-282174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ct0MdJe8WmFgQEAu9opvQ
	(envelope-from <netdev+bounces-282174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368C48DF7F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE646304E53D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1606424A067;
	Wed, 29 Apr 2026 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZ2KQC4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94725BF13
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426109; cv=none; b=N0eF1xrG44OeVETk6Fz1nXjkdXSM0IzwZ9pnl+InPpHu+BzkyH8WU8ZoOyaSnfCdQje2wugZIo5/LUvQCsvxRaTf7CP3iPu0Ty82FQVEkfxzv/C33lAxRyFFiBT9PDWZmpoSG7E/m5150DIZp9lOZnRpRJZub8WeoE5t3ia/448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426109; c=relaxed/simple;
	bh=i9L8XnvSFiPpXIC0LouXBHFGUfPyALs9LPvamcJaDKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEtOISz8WhWlpE2qXIHso+WLG3eyiCvRedReDYaLS9EvTd2z7NOSsH8ETiZzy4ImAEFWWYaq2lh9d8qXpzMvBcGfVPZUlhfgYqflrIpHUIlbV75MZGb7Km1uWZWcsWyje0budpvy7IuEzjOrLzjq3sNMKcHMZLAIttxdXoFh9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZ2KQC4G; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c797efdaa9cso6188551a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777426107; x=1778030907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlzKRi1235IEdxnPrVCGp9XETwfEZvpjn5soN3/viWU=;
        b=XZ2KQC4GGLB3H0htF4O5zmfS29N9LdaoVILKhNgtzKNpT67Nz9UC8Sgp+awQhol5gO
         f1szoMSTnUo8BbI5QkCJFcdvvr/x0zwy8vJEyl/2GvORPVo7hulNxcARiBYctGlbtzNx
         X+h12IrnctV+n/2q9s1ITafwXy/2BVV33KouzS38Ft09bW+/xgLAyayixOvYDA3nIUka
         FGgb966khvw6s7gXo8VgMHcdHIRSyj5Hrms7kc7zxE904SM0Gf5Y66vsErK0abO4zf5t
         FYROPv1oPpah2xWH4/t4/TLULjRbYyK9wgJdFOJKwoMJGaPLj9GN2tBdONJ1+0ARwvzw
         R2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777426107; x=1778030907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlzKRi1235IEdxnPrVCGp9XETwfEZvpjn5soN3/viWU=;
        b=PqDyZkXwheNrkCSAlo+P0grWzufOQ1FOiIUTlQ5I2NrT62hIZq8uRk5Kh5lS0vuOZ+
         AF+DejCj/Y1wDyP6KJVDoRw1o6AUyBkEQXiSjZEzoXi3H1QV6oc7SUnOZILqzmx3uzXi
         azViOJUeFFeugwJgyjJRiegnASDsPDAEnJJvnvugLOZqX0S6ip9/AOdHrLyfRbL8pbnr
         eHctfWZxZeCpx71um2roxqk4fEnNVDMFJzygoN5QlJjlK5UwQXOXYQV6FXXLoEo+b64K
         Fny3v+Cs86mAo/oTG123lt8otebE/Yq5upnF5haFvxj+WRyHgzozRPd4VkYn2N4gAhZC
         syIQ==
X-Gm-Message-State: AOJu0YzfUSfFD4ILuwzFNxy4apWhDT0iezSzx4kw42pF5ZtXi2Ll2bzF
	CXSPJoH8s6vXJC5tAcUpoFKD0jelIj9lcWAoF+mvpOokL9fl4vteVrEcL1HajTTiD0OGKQKyvMn
	kv9jPu/CVgRYQ3R19xVf5wgZUYPGAUqzCY3t90QT2at6AWD7Q/ncGdzZoOgKo/4pdQqgOLJYw7N
	usRRkTUhk2OuNv3B5dER8jzByM/v2EmiXTPPAgJ7He0Fgna7YjLeffSA5F1Z0n6mE=
X-Received: from pfck21-n2.prod.google.com ([2002:a05:6a00:a055:20b0:833:3a86:a8c8])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:ed01:10b0:3a2:e0d3:37ea with SMTP id adf61e73a8af0-3a39c049fcdmr4461147637.11.1777426106594;
 Tue, 28 Apr 2026 18:28:26 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:28:18 +0000
In-Reply-To: <20260429012819.3102675-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429012819.3102675-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429012819.3102675-3-hramamurthy@google.com>
Subject: [PATCH net-next v5 2/3] gve: make nic clock reads thread safe
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7368C48DF7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282174-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


