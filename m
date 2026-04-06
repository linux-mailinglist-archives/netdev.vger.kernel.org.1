Return-Path: <netdev+bounces-275782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIauD9BE1GnVsQcAu9opvQ
	(envelope-from <netdev+bounces-275782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B513A835A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D71E93082A98
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4153A0E95;
	Mon,  6 Apr 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUq8Jy1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301A3A255F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518812; cv=none; b=EeGOfgEYaYmJgq1s0MEIgnG4ZPJecX7Ml8KNrzzvQLHYSa2UCG6FbBApX5Gxkap3K++iZ3uRAN+2CYri5YcVns/7DL4L1oSanobuehEmNEawW7OMAeLJFjMWtOLAoRpbDYQWszGStrDQM7DdunA7QUPl57kfHzSWBGAVV9cfqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518812; c=relaxed/simple;
	bh=zbVO+/uKzWp3V26unzK5UegIowqeHaYb7SZADTWLtNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jc5Eu+kNYRS52nJVMiAeDcAf35tQ4GYnG5eGXu6rcMe/d3AT/lDQXeAFBrRf0fI7IID4hNlxfLeqZR3TUzE7T8RcaSeMSJa3uBSITdwsLZIWA2dBLbg1qpKW7Hq3JwAtbKHe6pDvyowPbyCLZwQ6rlSy4SHknhi22Ne+LOEE6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUq8Jy1g; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2471321dcso128319715ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 16:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775518810; x=1776123610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUmfSFbuewsi7zWjpTFHijFvzTe2sEQVHv4e9dzHUbg=;
        b=GUq8Jy1grjg7IyqKW4rpaJa+Hyf8swd/9VxQpdIJq/1UyphN+vVhik3DDjt3ZY8dQy
         z4RdvGcOJAUaFEbyG4LoLx7/CbCFPXhntEHKX5ehMPZDBPUD+N0mvm1QnIuL2/25bZFX
         mKFrMm2vLzePhxZJtg2EFG1dKJ3B7o67EQZTgGnCgUEE7J8d9JHU7ZgAlzFPmvwBgj4+
         wXzE068WrwR1vwNkM29G2LlfLzrxzDJXRDzsniEY85/PvhRH8hgxFoiP6H+7FOW6tQ4s
         nHQ7c+43cHbgqlZdCxwqHadjezY/VSAqs11r0E4X4h+aKydCf4I0xGnFNzWG6cnSOLZ5
         4lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518810; x=1776123610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUmfSFbuewsi7zWjpTFHijFvzTe2sEQVHv4e9dzHUbg=;
        b=V51Rn8aeUWK/11NSfVxeNjp+pyKE+sz2SGw7Y5yPv2CZLuSgsknZeBgI1JCz620wxq
         9p8B8Z3wNytGHoQInfQFWNoFuGb5+o5jBOM95+lruVH+fL36zcSmqDTYS8g25ymVatLl
         A2tCv7M8MN1n40AW5eYtnq1Tlrmx5SlCcKkZG3hhFI0f2SaK91ddfv0FAe1OiTBjnPY5
         L9yL6Rd4t38vFDWgMu4GaOAeDteg3EXND+afGAYnC/kESWqOG+vC/rJqKDcmQlDO4uUO
         NlZpzKP5y9BFk5gJgUaRL+/Lwd+yX5NVnoVCuYbjx7/pfE+S4RTwvTt1JrdgUjADh9qP
         hAQg==
X-Gm-Message-State: AOJu0Yx/KT2KAGieGHb9Nt9KPUE2aGJwCAN0SktCSqDy4dVVpgx9hRXR
	mEaTvtycuZCYK4IsM5uu1JDyzh49zMpQ2ATO9ZcIXtowRnxYAZ7pbEwkLMFDg/EdXTA39R5VV1o
	I4c4Nthh2kPpltD2sH6oKMEuC/RewjKvLZPZJ6YFq10wDY83EL6VUxHHSyX56P3kW9yxcrxpD5X
	ZwmyzWs0U3jIzfQTinKs9YwX94DmX855iLFfbxwLXoX4BR4lxRLMTARJmo2OvW0bY=
X-Received: from pgcv14.prod.google.com ([2002:a05:6a02:530e:b0:c73:9264:56a5])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210d:b0:39b:e789:7d0c with SMTP id adf61e73a8af0-39f2f118e2cmr14452432637.48.1775518809439;
 Mon, 06 Apr 2026 16:40:09 -0700 (PDT)
Date: Mon,  6 Apr 2026 23:40:02 +0000
In-Reply-To: <20260406234002.3610542-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406234002.3610542-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406234002.3610542-4-hramamurthy@google.com>
Subject: [PATCH net-next v4 3/3] gve: implement PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, jacob.e.keller@intel.com, 
	linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D5B513A835A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jordan Rhee <jordanrhee@google.com>

Enable chrony and phc2sys to synchronize system clock to NIC clock.

The system cycle counters are sampled by the device to minimize the
uncertainty window. If the system times are sampled in the host, the
delta between pre and post readings is 100us or more due to AQ command
latency. The system times returned by the device have a delta of ~1us,
which enables significantly more accurate clock synchronization.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Kevin Yang <yyd@google.com>
Reviewed-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v3:
- Take system time snapshot inside the mutex
- Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
  than x86 or arm64

Changes in v2:
 - fix compilation warning on ARM by casting cycles_t to u64
---
 drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
 drivers/net/ethernet/google/gve/gve_ptp.c    | 197 ++++++++++++++++++-
 2 files changed, 192 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 22a74b6aa17e..e6dcf6da9091 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -411,8 +411,8 @@ static_assert(sizeof(struct gve_adminq_report_nic_ts) == 16);
 
 struct gve_nic_ts_report {
 	__be64 nic_timestamp; /* NIC clock in nanoseconds */
-	__be64 reserved1;
-	__be64 reserved2;
+	__be64 pre_cycles; /* System cycle counter before NIC clock read */
+	__be64 post_cycles; /* System cycle counter after NIC clock read */
 	__be64 reserved3;
 	__be64 reserved4;
 };
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index ad15f1209a83..530f8d00e51a 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -10,28 +10,211 @@
 /* Interval to schedule a nic timestamp calibration, 250ms. */
 #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
 
+/*
+ * Stores cycle counter samples in get_cycles() units from a
+ * sandwiched NIC clock read
+ */
+struct gve_sysclock_sample {
+	/* system time snapshot taken just before issuing AdminQ command */
+	struct system_time_snapshot snapshot;
+	/* Cycle counter from NIC before clock read */
+	u64 nic_pre_cycles;
+	/* Cycle counter from NIC after clock read */
+	u64 nic_post_cycles;
+	/* Cycle counter from host before issuing AQ command */
+	cycles_t host_pre_cycles;
+	/* Cycle counter from host after AQ command returns */
+	cycles_t host_post_cycles;
+};
+
+/*
+ * Read NIC clock by issuing the AQ command. The command is subject to
+ * rate limiting and may need to be retried. Requires nic_ts_read_lock
+ * to be held.
+ */
+static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_cycles,
+				  cycles_t *post_cycles,
+				  struct system_time_snapshot *snap)
+{
+	unsigned long delay_us = 1000;
+	int retry_count = 0;
+	int err;
+
+	lockdep_assert_held(&ptp->nic_ts_read_lock);
+
+	do {
+		if (snap)
+			ktime_get_snapshot(snap);
+
+		*pre_cycles = get_cycles();
+		err = gve_adminq_report_nic_ts(ptp->priv,
+					       ptp->nic_ts_report_bus);
+
+		/* Prevent get_cycles() from being speculatively executed
+		 * before the AdminQ command
+		 */
+		rmb();
+		*post_cycles = get_cycles();
+		if (likely(err != -EAGAIN))
+			return err;
+
+		fsleep(delay_us);
+
+		/* Exponential backoff */
+		delay_us *= 2;
+		retry_count++;
+	} while (retry_count < 5);
+
+	return -ETIMEDOUT;
+}
+
 /* Read the nic timestamp from hardware via the admin queue. */
-static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
+static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
+				 struct gve_sysclock_sample *sysclock)
 {
+	cycles_t host_pre_cycles, host_post_cycles;
+	struct gve_nic_ts_report *ts_report;
 	int err;
 
 	mutex_lock(&ptp->nic_ts_read_lock);
-	err = gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bus);
-	if (err)
+	err = gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_cycles,
+				     sysclock ? &sysclock->snapshot : NULL);
+	if (err) {
+		dev_err_ratelimited(&ptp->priv->pdev->dev,
+				    "AdminQ timestamp read failed: %d\n", err);
 		goto out;
+	}
 
-	*nic_raw = be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
+	ts_report = ptp->nic_ts_report;
+	*nic_raw = be64_to_cpu(ts_report->nic_timestamp);
+
+	if (sysclock) {
+		sysclock->nic_pre_cycles = be64_to_cpu(ts_report->pre_cycles);
+		sysclock->nic_post_cycles = be64_to_cpu(ts_report->post_cycles);
+		sysclock->host_pre_cycles = host_pre_cycles;
+		sysclock->host_post_cycles = host_post_cycles;
+	}
 
 out:
 	mutex_unlock(&ptp->nic_ts_read_lock);
 	return err;
 }
 
+struct gve_cycles_to_clock_callback_ctx {
+	u64 cycles;
+};
+
+static int gve_cycles_to_clock_fn(ktime_t *device_time,
+				  struct system_counterval_t *system_counterval,
+				  void *ctx)
+{
+	struct gve_cycles_to_clock_callback_ctx *context = ctx;
+
+	*device_time = 0;
+
+	system_counterval->cycles = context->cycles;
+	system_counterval->use_nsecs = false;
+
+	if (IS_ENABLED(CONFIG_X86))
+		system_counterval->cs_id = CSID_X86_TSC;
+	else if (IS_ENABLED(CONFIG_ARM64))
+		system_counterval->cs_id = CSID_ARM_ARCH_COUNTER;
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/*
+ * Convert a raw cycle count (e.g. from get_cycles()) to the system clock
+ * type specified by clockid. The system_time_snapshot must be taken before
+ * the cycle counter is sampled.
+ */
+static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t clockid,
+				    struct system_time_snapshot *snap,
+				    u64 cycles, struct timespec64 *ts)
+{
+	struct gve_cycles_to_clock_callback_ctx ctx = {0};
+	struct system_device_crosststamp xtstamp;
+	int err;
+
+	ctx.cycles = cycles;
+	err = get_device_system_crosststamp(gve_cycles_to_clock_fn, &ctx, snap,
+					    &xtstamp);
+	if (err) {
+		dev_err_ratelimited(&priv->pdev->dev,
+				    "get_device_system_crosststamp() failed to convert %lld cycles to system time: %d\n",
+				    cycles,
+				    err);
+		return err;
+	}
+
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		*ts = ktime_to_timespec64(xtstamp.sys_realtime);
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		*ts = ktime_to_timespec64(xtstamp.sys_monoraw);
+		break;
+	default:
+		dev_err_ratelimited(&priv->pdev->dev,
+				    "Cycle count conversion to clockid %d not supported\n",
+				    clockid);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int gve_ptp_gettimex64(struct ptp_clock_info *info,
 			      struct timespec64 *ts,
 			      struct ptp_system_timestamp *sts)
 {
-	return -EOPNOTSUPP;
+	struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
+	struct gve_sysclock_sample sysclock = {0};
+	struct gve_priv *priv = ptp->priv;
+	u64 nic_ts;
+	int err;
+
+	if (sts && !(IS_ENABLED(CONFIG_X86) || IS_ENABLED(CONFIG_ARM64)))
+		return -EOPNOTSUPP;
+
+	err = gve_clock_nic_ts_read(ptp, &nic_ts, sts ? &sysclock : NULL);
+	if (err)
+		return err;
+
+	if (sts) {
+		/* Reject samples with out of order system clock values */
+		if (!(sysclock.host_pre_cycles <= sysclock.nic_pre_cycles &&
+		      sysclock.nic_pre_cycles  <= sysclock.nic_post_cycles &&
+		      sysclock.nic_post_cycles <= sysclock.host_post_cycles)) {
+			dev_err_ratelimited(&priv->pdev->dev,
+					    "AdminQ system clock cycle counts out of order. Expecting %llu <= %llu <= %llu <= %llu\n",
+					    (u64)sysclock.host_pre_cycles,
+					    sysclock.nic_pre_cycles,
+					    sysclock.nic_post_cycles,
+					    (u64)sysclock.host_post_cycles);
+			return -EBADMSG;
+		}
+
+		err = gve_cycles_to_timespec64(priv, sts->clockid,
+					       &sysclock.snapshot,
+					       sysclock.nic_pre_cycles,
+					       &sts->pre_ts);
+		if (err)
+			return err;
+
+		err = gve_cycles_to_timespec64(priv, sts->clockid,
+					       &sysclock.snapshot,
+					       sysclock.nic_post_cycles,
+					       &sts->post_ts);
+		if (err)
+			return err;
+	}
+
+	*ts = ns_to_timespec64(nic_ts);
+
+	return 0;
 }
 
 static int gve_ptp_settime64(struct ptp_clock_info *info,
@@ -50,7 +233,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
 		goto out;
 
-	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
 	if (err) {
 		dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
 				    __func__, err);
@@ -93,7 +276,7 @@ int gve_init_clock(struct gve_priv *priv)
 		goto free_ptp;
 	}
 
-	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
 	if (err) {
 		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
 		goto free_dma_mem;
-- 
2.53.0.1213.gd9a14994de-goog


