Return-Path: <netdev+bounces-272276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHx1GVu3xWnxAwUAu9opvQ
	(envelope-from <netdev+bounces-272276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:46:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D279D33CC0A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4CF305D4C4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA234BA59;
	Thu, 26 Mar 2026 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7hmAYUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23934B183
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565137; cv=none; b=Kt9RXqCHvzKbtvp1aFNVg7QhBYxFqHSNiYudfYFMzKOUJaWLbl6gFznZH4MDJL7NUTureSz2dCaA8ewPOWMbkwoC6eJvd5GNklc52UNU5sJoqM0uUYZmamWqUWqiFtFqwoQV5aKMnEzg4w3fBPxptrmp3YjMVUfDUqkrhj1/FD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565137; c=relaxed/simple;
	bh=5Txi5dwhnQhZbwtiLFvwxvxiOL2+dETMit3sCsC05fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eN7SxbVeww2vA2jWRHK5863EElCwIyy5h+/12huQXtEBE3Hpq3MsM3oeeUJDcQ/L9oWwyCWqQgwNb1EdI/RRNgn7Xj6vsz3kpPqmZsOZEdHmZm4oxM68osCHNcxXiG3TKdFETxoYlTld4QQxfs6VuVe9t/LtvlIHTzE3vroUoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7hmAYUf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b059ab124dso19637865ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774565135; x=1775169935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBqjipqe1hWrqGUrEp4FoAUnPSZh4H54A4uK3kM6Occ=;
        b=k7hmAYUf/SkMqVS5ApGgaNZy+iSJvnwxBRUnsWNe82Grv3xHSG0djWyB+k9AzELHPo
         7EbrUmLYfSiKlJaQIK5JZ4yoaq+eFnJi02RSq5His1isYkZQrwzfg45Yn7AGjmhHesDv
         X+rEaw+mwS1qCsAUe0xBUO9lIMfr2Pr8TMMpjmFx+8Pn/Z1IhBuMtd8msg8Cb2f1YBaj
         8zb8KxYfvNtKCquCbkTXAXR6P2w+GXyau5bOC1HRNLpXWG2eROvCYb7ed+Zd6r8BTYAe
         MUzH6vqvE7+mOD/cHjHdnYdei41eElm0/KJM1CDvso0pSX4ueI77ya/NXD172tdJHW2+
         UaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565135; x=1775169935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBqjipqe1hWrqGUrEp4FoAUnPSZh4H54A4uK3kM6Occ=;
        b=dkmcU5Zg6Kmox6eaDE71r3Ar2angKqZhLPFh+6J7QhqrIwx8109Y5vr82Y0Yp8vhVu
         DMNb9EZKDvVvqPgCiJHuGfmv7OM9uvZXCOovoX8GTrf8PuSGjOjGyj3KSOSKgfGPLHoS
         EMfbcaM1kvfPr9FIhhXzRjoMAKRSQ3/6/45FQNPViAZADz4OJmOWerLLfmW1Ea9KIwTZ
         56e65mqhyAsgE0YAYIcnOH0CiZKp7qCxf/qb++k0liuxh8Wkj/6XhGJ2Kb41+ZcGUIwR
         fBcKXRcXKYMIQ2cKTC2+DI01hf0eq9do/ijlP4jtXOV+VIzhl8ITNVG/7E1VQG8+sON3
         Xe9A==
X-Gm-Message-State: AOJu0Yym02xwiK3IJU6f7AgWGICV13G+4BpCzGta0ezRw4E8Z99elx4U
	fMXeBy71URBdH/WB+m2T7WMSnv3PDmHKBcoNei9UcMYRsCtk6AAVjms61g9z08FbBAI8LD0nCxF
	6pg60FwsWQAH3T0L96bV6RQQviUSnHDuWLGtX0vTlCRvVnXCYqowDp9U92aTmvtO4iScwwHamwS
	TR6tS8Mp0JXSIGwPpTl9x6Y2uVwTIcsXkCGqUMuvVC0kVUZNuOGQUsIw9Nwi2a/oE=
X-Received: from pgvf17.prod.google.com ([2002:a65:6291:0:b0:c73:97d4:afe0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:432b:b0:39b:8b8b:39ed with SMTP id adf61e73a8af0-39c87c0179fmr368442637.68.1774565134419;
 Thu, 26 Mar 2026 15:45:34 -0700 (PDT)
Date: Thu, 26 Mar 2026 22:45:26 +0000
In-Reply-To: <20260326224527.1044097-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326224527.1044097-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326224527.1044097-3-hramamurthy@google.com>
Subject: [PATCH net-next v2 2/3] gve: make nic clock reads thread safe
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272276-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D279D33CC0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ankit Garg <nktgrg@google.com>

Add a mutex to protect the shared DMA buffer that receives NIC
timestamp reports. The NIC timestamp will be read from two different
threads: the periodic worker and upcoming `gettimex64`.

Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Ankit Garg <nktgrg@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h     |  6 +----
 drivers/net/ethernet/google/gve/gve_ptp.c | 32 +++++++++++++++--------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1d66d3834f7e..7b8f78bd1968 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -923,6 +923,7 @@ struct gve_priv {
 	bool nic_timestamp_supported;
 	struct gve_ptp *ptp;
 	struct kernel_hwtstamp_config ts_config;
+	struct mutex nic_ts_read_lock; /* Protects nic_ts_report */
 	struct gve_nic_ts_report *nic_ts_report;
 	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
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
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 06b1cf4a5efc..140b8fbce4f4 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -11,19 +11,20 @@
 #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
 
 /* Read the nic timestamp from hardware via the admin queue. */
-int gve_clock_nic_ts_read(struct gve_priv *priv)
+static int gve_clock_nic_ts_read(struct gve_priv *priv, u64 *nic_raw)
 {
-	u64 nic_raw;
 	int err;
 
+	mutex_lock(&priv->nic_ts_read_lock);
 	err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
 	if (err)
-		return err;
+		goto out;
 
-	nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
-	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
+	*nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
 
-	return 0;
+out:
+	mutex_unlock(&priv->nic_ts_read_lock);
+	return err;
 }
 
 static int gve_ptp_gettimex64(struct ptp_clock_info *info,
@@ -43,15 +44,19 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 {
 	const struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
 	struct gve_priv *priv = ptp->priv;
+	u64 nic_raw;
 	int err;
 
 	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
 		goto out;
 
-	err = gve_clock_nic_ts_read(priv);
-	if (err && net_ratelimit())
-		dev_err(&priv->pdev->dev,
-			"%s read err %d\n", __func__, err);
+	err = gve_clock_nic_ts_read(priv, &nic_raw);
+	if (err) {
+		dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
+				    __func__, err);
+		goto out;
+	}
+	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
 
 out:
 	return msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS);
@@ -109,6 +114,7 @@ static void gve_ptp_release(struct gve_priv *priv)
 
 int gve_init_clock(struct gve_priv *priv)
 {
+	u64 nic_raw;
 	int err;
 
 	err = gve_ptp_init(priv);
@@ -125,17 +131,20 @@ int gve_init_clock(struct gve_priv *priv)
 		err = -ENOMEM;
 		goto release_ptp;
 	}
-	err = gve_clock_nic_ts_read(priv);
+	mutex_init(&priv->nic_ts_read_lock);
+	err = gve_clock_nic_ts_read(priv, &nic_raw);
 	if (err) {
 		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
 		goto release_nic_ts_report;
 	}
+	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
 	ptp_schedule_worker(priv->ptp->clock,
 			    msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS));
 
 	return 0;
 
 release_nic_ts_report:
+	mutex_destroy(&priv->nic_ts_read_lock);
 	dma_free_coherent(&priv->pdev->dev,
 			  sizeof(struct gve_nic_ts_report),
 			  priv->nic_ts_report, priv->nic_ts_report_bus);
@@ -150,6 +159,7 @@ void gve_teardown_clock(struct gve_priv *priv)
 	gve_ptp_release(priv);
 
 	if (priv->nic_ts_report) {
+		mutex_destroy(&priv->nic_ts_read_lock);
 		dma_free_coherent(&priv->pdev->dev,
 				  sizeof(struct gve_nic_ts_report),
 				  priv->nic_ts_report, priv->nic_ts_report_bus);
-- 
2.53.0.1018.g2bb0e51243-goog


