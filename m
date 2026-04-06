Return-Path: <netdev+bounces-275781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPOJHZJE1GnPsQcAu9opvQ
	(envelope-from <netdev+bounces-275781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:41:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4863A8344
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2575E305F7DE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDEE3A2540;
	Mon,  6 Apr 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osNL2Te6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8E39FCC1
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518810; cv=none; b=ZheKDFXBjpBv3sGHd2e1VPD7WKW/7FO+CAcjZemrmqokvRVi3DZogajvliMye/BJyzLI0fyhj7NOjkEJzmRy9xwnDNa2Vtw7DeAanaocS2+V/XOGPn0SepvPe33dOvRyRGIXk4Ks3Fv9CBD9zg4aqEZHBez/0tqNNfnZRzgPJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518810; c=relaxed/simple;
	bh=oYuTgHASR13wx51gCN7dp7iKyzHqtjbJmTVztcALf64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l4/aSoMxMInBKymFFa+yHQW8ex644hFC3R27QpIv/exxJlKZ3fZV2EnHotaNO6po4Ih0M4MDt1M3kmahT/SyRiebZIekBpIDLCaXnVuvG/inDAuoYxKYAaZVzWVvJejQ84FlOvo5nq4aV8oVzXPoWbmNPjSTlcvBvPRxkA6JMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osNL2Te6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24af7ca99so58096915ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 16:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775518808; x=1776123608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8l16tATZuU70nyjoOFEBJeX0fkq5enqtuO7E7lUUZk=;
        b=osNL2Te6mnP5n7lsFBeAHx3ITyRloNPZeWO2hzOVnFC5rDGjUqtzIsNlrqM08rFN+g
         TaIqSV1x6PwKmEG5uhgVdltNhd3JYJ26zHwXqucwuGRttlLEbCoLCfWzBrarDrEztTOE
         B9aJmGi4VZmFzEw0aXYBmmYUqtOrh+1S8lCHf8U47WSVWIsXVgymZE1dxbqtTsYcyZ/b
         AKu42vx2EIpjIBqiesObLmBTBDCS4WWMamckBU4aMzT1Gr+mTr5uaNn/J3Jb266upzMf
         cPNXcTo+o7hyJ4ZX2hOF96E50sKeBFF4So7s3OMggko36iKRGw4pU43J0iDSCVKPoAHx
         WAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518808; x=1776123608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8l16tATZuU70nyjoOFEBJeX0fkq5enqtuO7E7lUUZk=;
        b=JMIgrlf647367j4G+lpcElbk8AoFVgzhKJCANtchdTuBEog0+vrBJJcbr5OM4ICprR
         meomXxgC7TmoseVL/gk311jfVhPl28dgP0Bn7d5u1Gc+1RcvzQP71UA97GdBtGaaCM7w
         bo4DoPJwmc/7+CATdDop+3Muh9DPnUiqGIXO8+Xj+ggZjoU+TwYYP/ZOqZ3OwILgtMu0
         k8GGMAwx7alwIUghHmcw2Rm7/bzjVU1V4lZeCSRnT4HjXxPD3EPhSvr+kRGVMvjkeX8U
         awYhUJoVlK/mZf5EREn9dxTeAD8o/rfrmky2IyItR7LmVWWXDpc3YWL9m04VbqCKtctH
         KE5g==
X-Gm-Message-State: AOJu0YxepVGWPqmjqe/H8osbfSNBtj/u6Vx6kUjAlV3VkvAh7f+FkGT1
	/MCiuamJbSO79TZ7xeUY9QtTIOePDIV3wOG4HeXToDy2AYXwE7IDj24rzcQNVV+8/0S7qiOa+HO
	ZOx98lNXg9/TWQ0d/OPKWwIStUihYj0Adp3DOKNOrBn542HiX7/b3z/oQ6w0Oiz6Pz7oMKiviS2
	smsMXI44CMj8LIAfozBJ7g8+sFkvQc0SDG5Eyj1ynh5LWUsbXngFhDzDUehKsPbEc=
X-Received: from plbld6.prod.google.com ([2002:a17:902:fac6:b0:2b0:4b14:f0e9])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c04:b0:2b0:5075:96d1 with SMTP id d9443c01a7336-2b28176a618mr154776505ad.24.1775518807765;
 Mon, 06 Apr 2026 16:40:07 -0700 (PDT)
Date: Mon,  6 Apr 2026 23:40:01 +0000
In-Reply-To: <20260406234002.3610542-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406234002.3610542-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406234002.3610542-3-hramamurthy@google.com>
Subject: [PATCH net-next v4 2/3] gve: make nic clock reads thread safe
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, jacob.e.keller@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21]
X-Rspamd-Queue-Id: CE4863A8344
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0.1213.gd9a14994de-goog


