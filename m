Return-Path: <netdev+bounces-272277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C3tD3C3xWnxAwUAu9opvQ
	(envelope-from <netdev+bounces-272277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:47:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A133CC20
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29B93304F6C6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697D634D4EC;
	Thu, 26 Mar 2026 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYSNvvuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B834C981
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565139; cv=none; b=DCd0CeSBHIyyvHCy5VZXKNfXhd0/tNgTG+T+hEyrotcq7CoBE7EQOQqKsgb+rQenYNIEF/v5sCvGQo4H0nfBDNnfnAeN/d032YbuKLmVI1lgvGBciSKQDUFNi0+ITUFhrQMoqgG4BHxHyTKoHV3jFxw4rS5BywrPoV/r4bnNrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565139; c=relaxed/simple;
	bh=zF9ZSuygMLZDE5w3B0M+2FQ0B1fwuBNYwWZg+W0KJl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gCSgpwfqhtkap9OaQpoups13V4iCiqtp1ihdlY6Xcj7apkzW0rKuUtWQv82243j6kF+/fgXZ67smuFhmLGo2jsMFzJnL9PRrZrX+Z08sUQguvUuCrINqOtx5BT9tezN1WdUDudkAb5EZABI12XTB3n+JEFE/4PSE0Oa2qLNlez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYSNvvuy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c69a734a4so1197548b3a.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774565137; x=1775169937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7bKIh/7T7RPEt2Wwiu9b1ishS0moS3CmH7Dh0I7XDo=;
        b=GYSNvvuyh0WRrnnpkIE2+J4+kiFp5e9wRhIWqTgxFIGSdBGRqvPx8i5BfY7NasQJz4
         oRGf45dkumCr7dAPmZbkMjx1a+3iw/1qBaS0V7w24M1brrc6jpnAHdEbDZWk/qcSQ2XK
         7VHjnrwch34c3AHL9fqWLSAG8HAairLPddKAE5VPSs/Z1oR/F1exeKSeCIuHcAUUyGPb
         chvLk7jEWMc6MRKoJHlND29NoIKG4BjO3gnL0hc6JaQAJqdT12qFYoJWXmf9SinR3o5j
         44SHN8luQe5p/EfrLHJei/WSMemL1HOPfHnKI6h8IdbNsbq+mXar3Tn588/YaGVrgS4y
         NYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565137; x=1775169937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7bKIh/7T7RPEt2Wwiu9b1ishS0moS3CmH7Dh0I7XDo=;
        b=cjRNWj3FKi1Z/hsgzITp9z/pItWbfdsu6BHPOiTSkH+Y1q1iUv/CtLEf8s4DxmWPjc
         4qaD3e9Lxnh7gtQekd7g4JgCSvk9xhmN/WxPPS6omoT+okpAeQb4fBLMXARWZYklCoLe
         ZpRtiMW3pcVw4P5/Sc7ebd4Idau6IBbJ9ABn4PswVRmQc37ODSYRWWdxdwe8fSMeH9GJ
         qPMmYUUTg6fQZOrnPoLXjDDuAn64XvUariUg+aTQnRWug0YzYkqKAg8IvuNr3ieSdJd5
         ztD+lcRLxhJPKFuLuBoXkSlWxnOB8/9OxK6PA0YyuNxrngydWxbhnMUCSf4WvBfoV2NJ
         Fikg==
X-Gm-Message-State: AOJu0Yy12R4NyanblEc5r8e0nKTI6xWdUezkv7r8ihqeQcvbbp8T7w5+
	QM6aCp+KYi8t5yEG1vKgthH+ihb3Y4Xm/WSgeX5ivZldcIa/uCQWWhlTYbwZf+/pv6aw0MC02dt
	BvEes3cWqrMnBadxIPdfq3CKLsGTZ5JA710Jq5++q7qUIQq58IL7+c0YBWsLkjdHFk5ixl11+e2
	id8z2MfhVW3EJhTk4+QtOpiivExZKk5hOV3lQ+lKzjfRYsuOC/W7AreqsTynR5gxY=
X-Received: from pfbdo1.prod.google.com ([2002:a05:6a00:4a01:b0:829:7f86:623])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:440d:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-82c95d4fbddmr187720b3a.18.1774565137050;
 Thu, 26 Mar 2026 15:45:37 -0700 (PDT)
Date: Thu, 26 Mar 2026 22:45:27 +0000
In-Reply-To: <20260326224527.1044097-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326224527.1044097-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326224527.1044097-4-hramamurthy@google.com>
Subject: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D37A133CC20
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
Changes in v2:
 - fix compilation warning on ARM by casting cycles_t to u64
---
 drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
 drivers/net/ethernet/google/gve/gve_ptp.c    | 189 ++++++++++++++++++-
 2 files changed, 184 insertions(+), 9 deletions(-)

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
index 140b8fbce4f4..bea794541f30 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -10,28 +10,203 @@
 /* Interval to schedule a nic timestamp calibration, 250ms. */
 #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
 
+/*
+ * Stores cycle counter samples in get_cycles() units from a
+ * sandwiched NIC clock read
+ */
+struct gve_sysclock_sample {
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
+static int gve_adminq_read_timestamp(struct gve_priv *priv,
+				     cycles_t *pre_cycles,
+				     cycles_t *post_cycles)
+{
+	unsigned long delay_us = 1000;
+	int retry_count = 0;
+	int err;
+
+	lockdep_assert_held(&priv->nic_ts_read_lock);
+
+	do {
+		*pre_cycles = get_cycles();
+		err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
+
+		/* Ensure cycle counter is sampled after AdminQ cmd returns */
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
-static int gve_clock_nic_ts_read(struct gve_priv *priv, u64 *nic_raw)
+static int gve_clock_nic_ts_read(struct gve_priv *priv, u64 *nic_raw,
+				 struct gve_sysclock_sample *sysclock)
 {
+	cycles_t host_pre_cycles, host_post_cycles;
+	struct gve_nic_ts_report *ts_report;
 	int err;
 
 	mutex_lock(&priv->nic_ts_read_lock);
-	err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
-	if (err)
+	err = gve_adminq_read_timestamp(priv, &host_pre_cycles,
+					&host_post_cycles);
+	if (err) {
+		dev_err_ratelimited(&priv->pdev->dev,
+				    "AdminQ timestamp read failed: %d\n", err);
 		goto out;
+	}
 
-	*nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+	ts_report = priv->nic_ts_report;
+	*nic_raw = be64_to_cpu(ts_report->nic_timestamp);
+
+	if (sysclock) {
+		sysclock->nic_pre_cycles = be64_to_cpu(ts_report->pre_cycles);
+		sysclock->nic_post_cycles = be64_to_cpu(ts_report->post_cycles);
+		sysclock->host_pre_cycles = host_pre_cycles;
+		sysclock->host_post_cycles = host_post_cycles;
+	}
 
 out:
 	mutex_unlock(&priv->nic_ts_read_lock);
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
+	struct system_time_snapshot snap;
+	u64 nic_ts;
+	int err;
+
+	/* Take system clock snapshot before sampling cycle counters */
+	if (sts)
+		ktime_get_snapshot(&snap);
+
+	err = gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
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
+		err = gve_cycles_to_timespec64(priv, sts->clockid, &snap,
+					       sysclock.nic_pre_cycles,
+					       &sts->pre_ts);
+		if (err)
+			return err;
+
+		err = gve_cycles_to_timespec64(priv, sts->clockid, &snap,
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
@@ -50,7 +225,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
 		goto out;
 
-	err = gve_clock_nic_ts_read(priv, &nic_raw);
+	err = gve_clock_nic_ts_read(priv, &nic_raw, NULL);
 	if (err) {
 		dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
 				    __func__, err);
@@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
 		goto release_ptp;
 	}
 	mutex_init(&priv->nic_ts_read_lock);
-	err = gve_clock_nic_ts_read(priv, &nic_raw);
+	err = gve_clock_nic_ts_read(priv, &nic_raw, NULL);
 	if (err) {
 		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
 		goto release_nic_ts_report;
-- 
2.53.0.1018.g2bb0e51243-goog


