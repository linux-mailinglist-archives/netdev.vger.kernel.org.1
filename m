Return-Path: <netdev+bounces-293870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULX7HDLIHWrgdwkAu9opvQ
	(envelope-from <netdev+bounces-293870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:58:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A28623965
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0124D3026A59
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCAD3E9C12;
	Mon,  1 Jun 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K17xjKNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8E3E5EC2
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336492; cv=none; b=NRqtsAhDDbpGXoUsjy2fa1WCjkMjQVOPpPdSnqZZAcbbkS7aT5lW3FsL9fmY7bb0GRAshQY80KtpvDvHAM8C4Q8c0NvGrAqMAw+NTxzHOFyg67N464d8f91Rx0/AQk/qk9KfIuXsPMtzt1eAaQ8x03JNS0LSqIvuNQM75j7y/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336492; c=relaxed/simple;
	bh=ATqgyjDFElJdBHpYVK7mOY0mtUPm3ws0D5+guz+bzBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FMkWfsmSUdLS/9e9eVtHPBMi67nPbqCfnWREbXL9dDBHOyo3MkYprpJF86xCFqgmY4Et1DGLQsWs1+bfH+nZu3peAXpcAoXcDFXRLhqX1k/AL6OZ6GMpcZGIqDL+FhCF4xnjogJsr2h2KAikWp/ctdxhwQ4OKXkEhi9SqsdWkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K17xjKNF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842688fa7b8so210451b3a.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336487; x=1780941287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pvQv+tEdMdx2J/S27ciDR/KIgnJ8vs2dvnZ0oHevHs=;
        b=K17xjKNFu/2LRT3W+Fipe6poYKLRvEj1uvYFZfDz9ZGdLvPJ2mjsq3OCRNGe19giwW
         1rUxIimdOuMnN9eR6Jmn9wNpFOpWgDmbKSW0U5eibHZeheqf+p6xcwIhj0WISZeVCgVY
         prdGTiBbiSb3ePuBV7gUEXnCU04ZMqOGfPsJOiV0lW0MJd1sAlhb4VQn3ql+veFel4vH
         0lo7dN6MjbIB2mmORKTknyK2Pj4rxFyinrSIbA65DLMX662OhvFMC6MCt5hn1zh2OLw4
         22Lf6y9epceWlZHpeoyNkxrN5/xOf56SBrl11AfCq0nh+s8fgJjXIm5KVhXe9TkysTaf
         I4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336487; x=1780941287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pvQv+tEdMdx2J/S27ciDR/KIgnJ8vs2dvnZ0oHevHs=;
        b=dZqKDwrI68Uz2EFIBczoXZnOBdRoCGE2NXaIYyf64xouDFw1vNBGdIkzAmrPPGb3/M
         2TXIkRP8fkhknenfkTjkD9KtB5beYx/3bLPERJQdeqi2kiShme/1/PZxeCWjSL/jzmf5
         a0uDoMSIRFwNPTN/V6dAeCfXoyYlJxkiijgIOpRmWTgQb55Qc58385PifWtZ/EpOnrgz
         IQvGy9LebZL1HLlG2kZT+qa2XqK9r1bejE5f3YkhhS3NVd6f5Y0r1bHyPsj6JsuPdKfe
         8sPUJaXfZAErXVLEb0bRwfowDd23QeIAw8sJ6qL17vC5TrUh2FdP+TLRepqiko43GfrL
         BGFA==
X-Gm-Message-State: AOJu0YxFulQl80BWnMqYm82bR9Yeq88gewRW+wKW9IoRUodxGYC8M8C7
	Ni4nBjMq3GA17DCQpRSM4G+rvNBAQGy2JGAswQhTdA5H9c4I+wgp9o2jI98Jl4trK3JV1Gk+AJa
	e2UT1Mofzjyc9aT+nYypSBtiYPA4Ca645Hv2kGdLi3kJsqQ6St9d0+7rj5rJMfa0YFkLoSZU56k
	GXFbGe4g46SjG67qL6TJh0hbl5QBASLll1Lr0SegQqlvfJg/wtzAt3hKhgvZ6xkaw=
X-Received: from pgbcz11.prod.google.com ([2002:a05:6a02:230b:b0:c79:7975:38ca])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6005:b0:3b4:661d:8405 with SMTP id adf61e73a8af0-3b47886ce87mr438403637.4.1780336486576;
 Mon, 01 Jun 2026 10:54:46 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:31 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-10-hramamurthy@google.com>
Subject: [PATCH net-next 09/15] gve: simplify reset logic
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293870-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76A28623965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joshua Washington <joshwash@google.com>

Current GVE reset logic is quite complex, with a number of methods with
similar names and functionalities. This complexity has allowed a number
of bugs to enter the reset/recovery path, including the potential for
reset loops if an operation fails during teardown.

Simplify the reset path by doing the following:
1) Removing recursive resets. Recusive resets have two major issues.
   First, there is the potential for stack overflows if resets are
   invoked too many times in a row. Second, long recursive calls mean
   that GVE never gives up the RTNL lock, or at the very least holds it
   for too long. If a reset must occur anywhere during the
   reset/recovery path, it should be scheduled as a separate task.
2) Removing resets during teardown. This is partly covered by removing
   recusive resets, but the primary goal in this case is to ensure that
   the driver is capable of actually executing a hardware reset if
   something goes wrong with a control plane operation. As it stands, if
   `deconfigure_device_resources` fails, for example, GVE will pre-empt
   its reset with another reset without actually invoking a hardware
   reset, which could actually help with recovery.
3) Decompose allocation/de-allocation and setup/teardown. Performing
   allocation and setup for each control plane system (RSS, ptype map,
   etc) leaves many more error conditions to handle, causing teardown in
   the case of failures to be much more complex than they need to be.
   This will also be useful to better align a major behavioral change
   in mailbox mode, which will use separate response buffers instead to
   get data from the device instead of a pre-allocated shared memory
   region.

With the new reset functionality, shared resources between the device
and driver are not freed until after the hardware reset has completed
in the event that `deconfigure_device_resources` fails, meaning that the
device could potentially still be holding on to shared memory.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |   2 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |   5 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   1 -
 drivers/net/ethernet/google/gve/gve_ethtool.c |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 338 +++++++++---------
 5 files changed, 167 insertions(+), 181 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index bebdb38ef3bb..442e4622ab76 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1356,7 +1356,7 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
-int gve_reset(struct gve_priv *priv, bool attempt_teardown);
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3e450f174aae..8f3a4e63cf37 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -363,7 +363,7 @@ int gve_adminq_init(struct gve_priv *priv)
 	return gve_adminq_alloc(priv);
 }
 
-void gve_adminq_release(struct gve_priv *priv)
+static void gve_adminq_release(struct gve_priv *priv)
 {
 	int i = 0;
 
@@ -392,7 +392,6 @@ void gve_adminq_release(struct gve_priv *priv)
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
-	gve_clear_admin_queue_ok(priv);
 }
 
 void gve_adminq_free(struct gve_priv *priv)
@@ -1402,7 +1401,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 
 	if (err == -ETIME) {
 		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
-		gve_reset(priv, true);
+		gve_reset(priv, false);
 	} else if (!err) {
 		priv->flow_rules_cache.rules_cache_synced = false;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index efa4997a1cec..953da0f2b0e4 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -621,7 +621,6 @@ static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_init(struct gve_priv *priv);
 void gve_adminq_free(struct gve_priv *priv);
-void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
 					  dma_addr_t counter_array_bus_addr,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 8a088dcc3603..1a54bbd2cbf6 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -654,7 +654,7 @@ static int gve_user_reset(struct net_device *netdev, u32 *flags)
 
 	if (*flags == ETH_RESET_ALL) {
 		*flags = 0;
-		return gve_reset(priv, true);
+		return gve_reset(priv, false);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 746ff69a28dd..f8289f478e5b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -591,7 +591,22 @@ static void gve_free_notify_blocks(struct gve_priv *priv)
 	priv->msix_vectors = NULL;
 }
 
-static int gve_setup_device_resources(struct gve_priv *priv)
+static void gve_free_control_plane_resources(struct gve_priv *priv)
+{
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
+
+	kvfree(priv->ptype_lut_dqo);
+	priv->ptype_lut_dqo = NULL;
+
+	gve_free_stats_report(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_counter_array(priv);
+	gve_free_rss_config_cache(priv);
+	gve_free_flow_rule_caches(priv);
+}
+
+static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
@@ -600,16 +615,42 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
 	if (err)
-		goto abort_with_flow_rule_caches;
+		goto abort;
 	err = gve_alloc_counter_array(priv);
 	if (err)
-		goto abort_with_rss_config_cache;
+		goto abort;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
-		goto abort_with_counter;
+		goto abort;
 	err = gve_alloc_stats_report(priv);
 	if (err)
-		goto abort_with_ntfy_blocks;
+		goto abort;
+
+	if (!gve_is_gqi(priv)) {
+		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo,
+						   GFP_KERNEL);
+		if (!priv->ptype_lut_dqo) {
+			err = -ENOMEM;
+			goto abort;
+		}
+	}
+
+	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
+	if (!priv->xsk_pools) {
+		err = -ENOMEM;
+		goto abort;
+	}
+
+	return 0;
+abort:
+	gve_free_control_plane_resources(priv);
+	return err;
+}
+
+static int gve_setup_control_plane_resources(struct gve_priv *priv)
+{
+	int err = 0;
+
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
 						    priv->num_event_counters,
@@ -619,20 +660,15 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev,
 			"could not setup device_resources: err=%d\n", err);
 		err = -ENXIO;
-		goto abort_with_stats_report;
+		return err;
 	}
 
 	if (!gve_is_gqi(priv)) {
-		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo);
-		if (!priv->ptype_lut_dqo) {
-			err = -ENOMEM;
-			goto abort_with_stats_report;
-		}
 		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto abort_with_ptype_lut;
+			goto deconfigure_device;
 		}
 	}
 
@@ -647,7 +683,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto abort_with_clock;
+		goto teardown_clock;
 	}
 
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
@@ -659,67 +695,61 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 	return 0;
 
-abort_with_clock:
+teardown_clock:
 	gve_teardown_clock(priv);
-abort_with_ptype_lut:
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-abort_with_stats_report:
-	gve_free_stats_report(priv);
-abort_with_ntfy_blocks:
-	gve_free_notify_blocks(priv);
-abort_with_counter:
-	gve_free_counter_array(priv);
-abort_with_rss_config_cache:
-	gve_free_rss_config_cache(priv);
-abort_with_flow_rule_caches:
-	gve_free_flow_rule_caches(priv);
-
+deconfigure_device:
+	gve_adminq_deconfigure_device_resources(priv);
 	return err;
 }
 
-static void gve_trigger_reset(struct gve_priv *priv);
-
-static void gve_teardown_device_resources(struct gve_priv *priv)
+/**
+ * Request the device to release any allocated shared resources.
+ *
+ * If any part of the teardown step fails, the failure is documented, but is
+ * otherwise ignored. It is expected that a device reset is triggered
+ * immediately after tearing down device resources, which would clear any
+ * lingering state on the device.
+ */
+static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
 		err = gve_flow_rules_reset(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to reset flow rules: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
 		/* detach the stats report */
 		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
+		gve_teardown_clock(priv);
 		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Could not deconfigure device resources: err=%d\n",
 				err);
-			gve_trigger_reset(priv);
-		}
 	}
 
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-
-	gve_free_flow_rule_caches(priv);
-	gve_free_rss_config_cache(priv);
-	gve_free_counter_array(priv);
-	gve_free_notify_blocks(priv);
-	gve_free_stats_report(priv);
-	gve_teardown_clock(priv);
 	gve_clear_device_resources_ok(priv);
 }
 
+static void gve_teardown_device(struct gve_priv *priv)
+{
+	gve_teardown_control_plane_resources(priv);
+	gve_adminq_free(priv);
+	/*
+	 * Free any resources shared with the device only after we have a
+	 * guarantee that the device will not try to access such resources.
+	 * Device commands in gve_teardown_control_plane_resources can fail, in
+	 * which case, device resources won't be relinquished until
+	 * gve_adminq_free is called to trigger a device reset.
+	 */
+	gve_free_control_plane_resources(priv);
+}
+
 static int gve_unregister_qpl(struct gve_priv *priv,
 			      struct gve_queue_page_list *qpl)
 {
@@ -1160,8 +1190,6 @@ void gve_schedule_reset(struct gve_priv *priv)
 	queue_work(priv->gve_wq, &priv->service_task);
 }
 
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up);
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
 static void gve_turndown(struct gve_priv *priv);
 static void gve_turnup(struct gve_priv *priv);
 
@@ -1272,11 +1300,12 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 	return err;
 }
 
-
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
 	int i;
 
+	if (!priv->rx)
+		return;
 	for (i = 0; i < priv->rx_cfg.num_queues; i++)
 		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
@@ -1419,10 +1448,11 @@ static int gve_queues_start(struct gve_priv *priv,
 reset:
 	if (gve_get_reset_in_progress(priv))
 		goto stop_and_free_rings;
-	gve_reset_and_teardown(priv, true);
-	/* if this fails there is nothing we can do so just ignore the return */
-	gve_reset_recovery(priv, false);
-	/* return the original error */
+
+	/* Attempt to reset. If reset is successful, gve_queues_start was
+	 * successful.
+	 */
+	err = gve_reset(priv, false);
 	return err;
 stop_and_free_rings:
 	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
@@ -1438,6 +1468,12 @@ static int gve_open(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
+	if (!gve_get_device_resources_ok(priv)) {
+		dev_err(&priv->pdev->dev,
+			"Attempting to open netdev without resources. Device must be reset.");
+		return -ENODEV;
+	}
+
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -1454,41 +1490,18 @@ static int gve_open(struct net_device *dev)
 	return 0;
 }
 
-static int gve_queues_stop(struct gve_priv *priv)
+static void gve_queues_stop(struct gve_priv *priv)
 {
-	int err;
-
-	netif_carrier_off(priv->dev);
-	if (gve_get_device_rings_ok(priv)) {
-		gve_turndown(priv);
-		gve_drain_page_cache(priv);
-		err = gve_destroy_rings(priv);
-		if (err)
-			goto err;
-		err = gve_unregister_qpls(priv);
-		if (err)
-			goto err;
-		gve_clear_device_rings_ok(priv);
-	}
-	timer_delete_sync(&priv->stats_report_timer);
+	gve_turndown(priv);
 
 	gve_unreg_xdp_info(priv);
+	gve_drain_page_cache(priv);
+
+	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 
 	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
-
-	priv->interface_down_cnt++;
-	return 0;
-
-err:
-	/* This must have been called from a reset due to the rtnl lock
-	 * so just return at this point.
-	 */
-	if (gve_get_reset_in_progress(priv))
-		return err;
-	/* Otherwise reset before returning */
-	gve_reset_and_teardown(priv, true);
-	return gve_reset_recovery(priv, false);
 }
 
 static int gve_close(struct net_device *dev)
@@ -1496,12 +1509,28 @@ static int gve_close(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = gve_queues_stop(priv);
-	if (err)
-		return err;
+	gve_queues_stop(priv);
+
+	/* Surrender to reset if the queue destroying adminq cmds fail. Reset
+	 * will not re-enable the interface.
+	 */
+	if (gve_get_device_rings_ok(priv)) {
+		gve_clear_device_rings_ok(priv);
+		err = gve_destroy_rings(priv);
+		if (err)
+			goto reset;
+		err = gve_unregister_qpls(priv);
+		if (err)
+			goto reset;
+	}
 
 	gve_queues_mem_remove(priv);
+	priv->interface_down_cnt++;
 	return 0;
+
+reset:
+	err = gve_reset(priv, true);
+	return err;
 }
 
 static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
@@ -2420,25 +2449,17 @@ static int gve_setup_device(struct gve_priv *priv)
 {
 	int err;
 
-	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
-	if (!priv->xsk_pools) {
-		err = -ENOMEM;
-		goto err;
-	}
-
 	gve_set_netdev_xdp_features(priv);
 	if (!gve_is_gqi(priv))
 		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
 
-	err = gve_setup_device_resources(priv);
+	err = gve_alloc_control_plane_resources(priv);
 	if (err)
-		goto err_free_xsk_bitmap;
-
+		goto err;
+	err = gve_setup_control_plane_resources(priv);
+	if (err)
+		goto err;
 	return 0;
-
-err_free_xsk_bitmap:
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
 err:
 	return err;
 }
@@ -2513,30 +2534,7 @@ static int gve_init_priv(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_teardown_priv_resources(struct gve_priv *priv)
-{
-	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-}
-
-static void gve_trigger_reset(struct gve_priv *priv)
-{
-	/* Reset the device by releasing the AQ */
-	gve_adminq_release(priv);
-}
-
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
-{
-	gve_trigger_reset(priv);
-	/* With the reset having already happened, close cannot fail */
-	if (was_up)
-		gve_close(priv->dev);
-	gve_teardown_priv_resources(priv);
-}
-
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
+static int gve_recover(struct gve_priv *priv, bool setup_queues)
 {
 	int err;
 
@@ -2549,54 +2547,52 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
 
 	err = gve_setup_device(priv);
 	if (err)
-		goto err_free_adminq;
-	if (was_up) {
+		goto err;
+	if (setup_queues) {
 		err = gve_open(priv->dev);
 		if (err)
-			goto err_free_device;
+			goto err;
 	}
 	return 0;
 
-err_free_device:
-	gve_teardown_device_resources(priv);
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-err_free_adminq:
-	gve_adminq_free(priv);
 err:
-	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
-	gve_turndown(priv);
+	dev_err(&priv->pdev->dev, "Recover failed! !!! DISABLING ALL QUEUES !!!\n");
+	gve_teardown_device(priv);
 	return err;
 }
 
-int gve_reset(struct gve_priv *priv, bool attempt_teardown)
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
 {
 	bool was_up = netif_running(priv->dev);
 	int err;
 
+	if (gve_get_reset_in_progress(priv))
+		return 0;
+
 	dev_info(&priv->pdev->dev, "Performing reset\n");
 	gve_clear_do_reset(priv);
 	gve_set_reset_in_progress(priv);
-	/* If we aren't attempting to teardown normally, just go turndown and
-	 * reset right away.
-	 */
-	if (!attempt_teardown) {
-		gve_turndown(priv);
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* Otherwise attempt to close normally */
-		if (was_up) {
-			err = gve_close(priv->dev);
-			/* If that fails reset as we did above */
-			if (err)
-				gve_reset_and_teardown(priv, was_up);
-		}
-		/* Clean up any remaining resources */
-		gve_teardown_priv_resources(priv);
+
+	if (was_up) {
+		gve_queues_stop(priv);
+		gve_destroy_rings(priv);
+		gve_unregister_qpls(priv);
 	}
 
-	/* Set it all back up */
-	err = gve_reset_recovery(priv, was_up);
+	/* Reset the device by releasing the AQ. Rings and other resources
+	 * within the NIC are implicitly destroyed if commands fail.
+	 */
+	gve_adminq_free(priv);
+
+	gve_queues_mem_remove(priv);
+	gve_teardown_clock(priv);
+	gve_free_control_plane_resources(priv);
+
+	err = gve_recover(priv, was_up && !skip_queue_setup);
+	if (err)
+		dev_info(&priv->pdev->dev,
+			 "Failed to recover in reset: %d\n", err);
+
 	gve_clear_reset_in_progress(priv);
 	priv->reset_cnt++;
 	priv->interface_up_cnt = 0;
@@ -2928,7 +2924,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup device: err=%d\n", err);
-		goto abort_with_wq;
+		goto abort_teardown_device;
 	}
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
@@ -2936,7 +2932,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = register_netdev(dev);
 	if (err)
-		goto abort_with_gve_init;
+		goto abort_teardown_device;
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
@@ -2944,8 +2940,8 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
 
-abort_with_gve_init:
-	gve_teardown_priv_resources(priv);
+abort_teardown_device:
+	gve_teardown_device(priv);
 
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
@@ -2977,8 +2973,8 @@ static void gve_remove(struct pci_dev *pdev)
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
-	gve_teardown_priv_resources(priv);
 	destroy_workqueue(priv->gve_wq);
+	gve_teardown_device(priv);
 	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
 	pci_iounmap(pdev, reg_bar);
@@ -2996,13 +2992,9 @@ static void gve_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 }
@@ -3017,13 +3009,9 @@ static int gve_suspend(struct device *dev)
 	priv->suspend_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	priv->up_before_suspend = was_up;
 	netdev_unlock(netdev);
 	rtnl_unlock();
@@ -3040,7 +3028,7 @@ static int gve_resume(struct device *dev)
 	priv->resume_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	err = gve_reset_recovery(priv, priv->up_before_suspend);
+	err = gve_recover(priv, priv->up_before_suspend);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 	return err;
-- 
2.54.0.669.g59709faab0-goog


