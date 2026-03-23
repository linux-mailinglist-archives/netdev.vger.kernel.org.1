Return-Path: <netdev+bounces-270816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLt+OlTSwWk9XAQAu9opvQ
	(envelope-from <netdev+bounces-270816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:52:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512F2FF154
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D448930BFF37
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88403845CD;
	Mon, 23 Mar 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4kxlH6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90938550F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309722; cv=none; b=deQMcpbLKT05j/L1knFsXle3mfpjn9i5wt+/Uu6eQcrTbu9kSQnhEW1i5nBW46wxrkzR0iIB8JWzSOnHLpBjhcPNwIt96m76NAzNW9e7LtADLZEq3Hirbgi2hcQuun7y+QK2xbYbN89adYNsyp2Zo/RJ96QiyiPR4VmQ5aMg948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309722; c=relaxed/simple;
	bh=ipi/hmuzw0I0dIR12Hqh883My688JUPKmeeIE1N+G0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQAJBzVZNhNEahmyl2RgKd43QaGA+mGqGTNJPydfMgCC7sqxwaYB/MECPY2OTaxD0oG4hqb9L231mUJ1XFu5V73mVdvx/XjbrR/su1Xh72ehSSOwxP+m2rpZBfys6DheeiSRgWw5WrG8qRWLUVa0PQEzZ8AcO4ZcO2hyDVHAAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4kxlH6d; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b05d170cadso49317165ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774309717; x=1774914517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw/WcolBOl5E4xg9/GOqX1azVpZAcATB1CeYqZdKYX0=;
        b=r4kxlH6dQ8gNcXqiXUYBvhU2MzB0cmwNJcJpokv7gZI7EuPl8FUR/W8Z32aNNUiSd5
         fSN8ioWCVYNZjqU2K0ahT2hsyfjf/LfoT9zU4z/HbIPmqOkPNhZurfdXOtJqr2/TeY80
         uLbZoYAyMLH5nTD/3LSxZ7v4MxLz/M2BC2+q3+U2r9YrzpP5y/Eym3RVrx5DdcHRBnT6
         VCf2RAygh1kzvtuUjpfkYTYevzhInCjEsgiDXYNOCF717jLKATANV0Ux8VWvrZ79DIUY
         cHljJmEMKCFqHH/7Rf7s88U2EY2c8YZuOTaQcIujfgVPn7YBR/vx/z9sIMxJokJxEsav
         0gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309717; x=1774914517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw/WcolBOl5E4xg9/GOqX1azVpZAcATB1CeYqZdKYX0=;
        b=hovqaX5YczffaFabbnRZXjQiS3f600pBZu5JBWcXgs0DrdK6d2IC0lLksdh1LB0lC0
         1KmH2ZiE/cZkxshY3S/H2HK9L1+sWIzja4K26Cp/pP3nwpyz+ok1o0V27pfmvQ+QIppA
         8//xIu+609u0F6NVtyIg2YMYedTavCtz8q3J2AAdGL9KbGEnsqRPWdBJSVeQv0FfuYCu
         4FPxRv6biHEfMOw3XG3Ea2Ekc5TsvYJEXo+h98SABjuJcnKOeGY0WRGACWWlGT0WFUA5
         TyMViom4IQaQDE5qObb/8XGid2uy/YkGAv+rzdizqsK0bZ3bnF7mMwB7T4tpFZZtLp/B
         +y3w==
X-Gm-Message-State: AOJu0Ywap870PaR71SL+KL9BFE9zzjacVUo0aawfjOvyN91RynYLTbTH
	tDfJzupasXAPlOsP+iq+8IBCC72eeYpYg2PpD6zesxiEUIsMZydNqpXG9YHLpoPzKrFVghHjjhC
	df2ltvzyYggcUs5ep80Q5Shu1H2AuJdgoR2kf2Fg1dL8ZcOMFZAEvUB/rGicE5pibQtWk0aRtCM
	NF9K7la3gZS2UKypyEflmff6EiIlF1SpdnvedOZeD+HNRIKivEchlL1OK2RbBKL9c=
X-Received: from plgc17.prod.google.com ([2002:a17:902:d491:b0:2ae:cd48:3a6f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac7:b0:2b0:7224:a4f3 with SMTP id d9443c01a7336-2b0827eefc7mr135145895ad.48.1774309716791;
 Mon, 23 Mar 2026 16:48:36 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:48:29 +0000
In-Reply-To: <20260323234829.3185051-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323234829.3185051-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323234829.3185051-4-hramamurthy@google.com>
Subject: [PATCH net-next 3/3] gve: implement PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org, 
	Kevin Yang <yyd@google.com>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270816-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5512F2FF154
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
index 140b8fbce4f4..889f0120e1dd 100644
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
+					    sysclock.host_pre_cycles,
+					    sysclock.nic_pre_cycles,
+					    sysclock.nic_post_cycles,
+					    sysclock.host_post_cycles);
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
2.53.0.851.ga537e3e6e9-goog


