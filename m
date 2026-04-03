Return-Path: <netdev+bounces-275180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHyNKBIa0Gl33QYAu9opvQ
	(envelope-from <netdev+bounces-275180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:50:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16423397E18
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99D2330E3BB1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ADF3D6CB7;
	Fri,  3 Apr 2026 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcqBt3rf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419133D8121
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245477; cv=none; b=AvwgTXCniFh1Rxu4ylel9koq+uhs46/1yYylcRPkHkbGYJXiD6NxGrnsirWls6xU0U3qtQqCBU7eYKZVAqp4zho23wE2DNa7GXnDoqiegRlNOLCKz8AgetIjIrflCpkztSmAtx/lou09TXIAqtw+JneyrHWAIFdFb3ATmspyyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245477; c=relaxed/simple;
	bh=zbVO+/uKzWp3V26unzK5UegIowqeHaYb7SZADTWLtNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZD7P9NYeDZuCuSX1lMGsMXMzWewXGZeB3YD9bUx4hKKpdpUiZqRLI9dJo/QRl1vI54DnizsQR2NC5zwXoIY/eU5r+wkWfGU3NeGW8UlCiBbnuCg61P/40p6yc2tGWJOip13mGOTzHAyC/TA3H6qdOyo1qOXV5jJyrJwCv6KKa5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcqBt3rf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso20700425ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775245476; x=1775850276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUmfSFbuewsi7zWjpTFHijFvzTe2sEQVHv4e9dzHUbg=;
        b=UcqBt3rfmrONNAXzkGRVKlDOesIc2crsOKuYxAjJuCGuT4I0eT83LFNO3DiqBM0Pr1
         EVmO5N63hbRUxCVIpvIBVYNeTdD+VxRVVBNU6HPOiJ3tcGjyK/9nx8FRs3XHfkJiymnL
         M9rO8ZiDtf9Gxtd77ev+jLWu/hyeZf04hjsXxbo4FduW5YDo2MCTq3Y82vgFq4YdgbWH
         vyNo1GgerqSJ5W0AnNYv53M0xeRsD0KOIomNBWssDnADfVnAtdX2yiGpnh6bNBkRSS8F
         2VLpB2Jh/4ZIji7YoNqw+tn6EFeHS0DmWHmXzphrtDdGXfsC7ImnDw9BbIapePz98LMD
         3pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245476; x=1775850276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUmfSFbuewsi7zWjpTFHijFvzTe2sEQVHv4e9dzHUbg=;
        b=qquuUOMKvU9sOz3trSh6IVjTo8Y3nlPfe3S6qnnyxuKQqeAV6tHec3NPRzWAK3Z1fD
         j3mabXxtyrdPoIQzXdsv+s0tOg4aFY0ex1WxNAAk1bae8piwGOtmsdbc3DMwHwEqhAbD
         1yQ+gFmjbKj6HjgIfFZsjzwkxZcF/PwJ5t/IYfjkSHGV+noVv3nn5ihVNyfV4OUQJ5zC
         /t8pKARQpJxkauOUe/iv4IGiPPnXXFIb9uH9DzgVKl+l4Bvln5I56qKrOoYqpNszTD0k
         oZ+MN8W1X4Oj6zvkKeiAWS1zOU+lDHtaOaUYr1ioy1f4m/azNu8aqMQxWT0j91UMwFAJ
         jJYA==
X-Gm-Message-State: AOJu0Yywok11NqV8lf5/Xm+8bk+8AN6UIN9qYqQ/tOHKzPCqq2fLS5Vu
	0claqShPlR6/HgXEFYYynD2D9FA6xH4hJs6PlMBCm9C8ERwm0qv/tTtr3UBJjZBIop9cK1T2ios
	LZajWeJO00qKc/SHPqahH4BBbFIwoQ4HVVEhSt5/xlGaZ3bQ5K2+Ad44hJPx6fGJqeWGK53s/9N
	mgtnwFJTWmTvC9k3hre5PF4c2xnlBxFyru4WaAcqoxWRjr9smMsde1+kJ8ieIFbRI=
X-Received: from pgcv14.prod.google.com ([2002:a05:6a02:530e:b0:c73:9264:56a5])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918a:b0:39b:d6e0:2d4 with SMTP id adf61e73a8af0-39f2f32352fmr3945752637.48.1775245475128;
 Fri, 03 Apr 2026 12:44:35 -0700 (PDT)
Date: Fri,  3 Apr 2026 19:44:27 +0000
In-Reply-To: <20260403194427.1830609-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403194427.1830609-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403194427.1830609-4-hramamurthy@google.com>
Subject: [PATCH net-next v3 3/3] gve: implement PTP gettimex64
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275180-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16423397E18
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


