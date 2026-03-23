Return-Path: <netdev+bounces-270815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLDMNQ3SwWk9XAQAu9opvQ
	(envelope-from <netdev+bounces-270815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:51:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318472FF145
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F36F83066891
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735B3859F9;
	Mon, 23 Mar 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDhytLtw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31B37EFF7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309717; cv=none; b=oGiSPLuBK0jeye7VEGrsVoTx+acOJE03gauVyOWS6jteGYUP6gf8AthZ31PzWiDsVB3U4ed74Om5v2KqdyLWyZnHlQozb37NAIWsRqkju72ndGc/RnTLU+8ZD9myX7S8B0Ym4D35RJqASF5hQCsPTS3cyqNOGhbtDnMjl4dX3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309717; c=relaxed/simple;
	bh=7/XClCIKuqaz4B/y9XGkHL4iLFN4AY0RrT6DNg4CO08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jf8lMf8Q3v+bW2A6l2/sZ0+bsAVdzRVVwnf29wlUENia/h5RYn4EmU8odkGz4UCgZlhn/PJrxcxCgERLroyyugnOv2T0ly2PCNvyq4E6Oudv11c1F4GLCxeuBaAGb/i+M3uAR9fjwMNImSlTOO7IuiqCR/8ABO2drYthCxkRqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDhytLtw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so329980a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774309716; x=1774914516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1dqDyNUHXc6mREjK3mFIuS408AytwQMk1N/EEfOEG8=;
        b=MDhytLtwm2nUU12h4N6CC0VgCSstCG38CYFaUSsFDc3Pi7uix/+W8Nhhpqt4kGEPGU
         LBlOsevAsaAJT+e/RUeG/COS5GPs8zLG5O8UpoZDTCUrE0D8MOj1+91AoObLNwuiWHhG
         bZ+qdBcnspLStaZubaWy4DXWP7Wi5RpQcqWpe9KpI4vV6vXiiLkrzyDZDGEP8PAF0tep
         5/RASjdwKFgmnKxe8Msa89wweLmzlgZzhj7Vjgt166vx7rL2VDcMUQa+hcTgG0VySqU3
         fGDFiEX+murQy+VsmVBriC4D4XARE6KkFVFBcAR367lBJbR0mUkZSprxYGz8KxEuGSr6
         +ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309716; x=1774914516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1dqDyNUHXc6mREjK3mFIuS408AytwQMk1N/EEfOEG8=;
        b=rrmYWHbacRcC85ZzN6eHU8QtIxRDnVkQBJqSPREaEctSyVrki9zSmIDgpHvCWXWKy+
         dyz46IrHHkS716E8RDzSEVBboGDCDBIexw22GOVW1i6/sWy49CI09XeOUzC0YkZgUpcL
         Yga6FOSvIDowgSDk72GxX5vkIUkH0nFqqP5q5W+p3zTb9D/oTYoqDRTayAJgxkbtCmFR
         vEYF5RJJXShLDPBqpoc8bMBVUUOj2qPMQpbogZLAt06c8YC5cTHq3AJhTYoc5BuKy6Tm
         ohA+xGmmGCHUw7Qqu9/exdpxkdmQonvLdW876dDFPp3VS15jvjBGMK0gPReq0wFwJmPn
         jYig==
X-Gm-Message-State: AOJu0Yw4FwRj2mrmtuLmj+l9QTfHWBNRGURWztksQnEf7WQ2Y6or1THq
	CjUucHK2HXq5AQli3z1Vat935mFh+j4t3nOhQDyN6oCZKABQc/2RfTUr7qraMxBtOMLyOgFAI0w
	pmWEou4X6ceupOgL8miLObXNn9pU7gPDmB++q2DEN9W69v1d9VU+HLXTPj90adI3CMuAIzBE2QX
	akne4zmQ7gprLM8TbLYkkmt/g3CiQ2h5HHhwDDWDMX5n7diJntu/CdJheij44loRw=
X-Received: from pgbda10.prod.google.com ([2002:a05:6a02:238a:b0:c6e:21b7:bfd0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a514:b0:398:9301:b9ae with SMTP id adf61e73a8af0-39bcec7ee66mr9257986637.52.1774309715434;
 Mon, 23 Mar 2026 16:48:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:48:28 +0000
In-Reply-To: <20260323234829.3185051-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323234829.3185051-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323234829.3185051-3-hramamurthy@google.com>
Subject: [PATCH net-next 2/3] gve: make nic clock reads thread safe
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270815-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 318472FF145
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
2.53.0.851.ga537e3e6e9-goog


