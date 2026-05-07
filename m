Return-Path: <netdev+bounces-285495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKSXJXIA/WmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F84EF269
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5255F30144FF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7023345CCE;
	Thu,  7 May 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3oMN5em"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA85342C93
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188391; cv=none; b=PVHoZ6O57eRqdXNXconnP+zimPcOc7yWZ0XMtWxSTOSYqeGWMMKOmHXt+yoolLLq4x1n3l1TzXotUtxxoS2bu6JGurcPA15kk8dNzkRoEXOgUkh2G4QPSLmG7yvaqJuD0tWCHb/1QMr77VgtQ1kTid5TrFxMsq/p6d6xLS4EnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188391; c=relaxed/simple;
	bh=djka4XUM+nSConmfd3gLZl90M/IV8iCE2NiOJnRo9xU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MhsCdUe+G+e7y3iXHEaMyN1DCMePi10xyHB9NbI+aMtARcQGUV3xjH6tNU8pF+z38KJXvdFOZNQDExsrNRtRvLT1DxWApuWoH39T/QGhQusvxab3W0stSEASWr1A3IpOgyaeTHCO5JSoapLq25mfETHkJOAfG3Av/RHWrM0hbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3oMN5em; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8252a49ffcso1569870a12.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778188389; x=1778793189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQWw1Y0UpqBl/nokhDQ3OAPFYHiDmVUDolYlpCEFvks=;
        b=d3oMN5emfy66VOFhKqUWp6ZW5yh2zUly0C3SoUKlaXoIvHB0VIMClPs6nigg52PBLC
         xUlzx8Ov1PZNzMlHFVroAWSFzjYLgjCtAmSJYu6EfcxeAU+XDby9vf2C7i9mcxXEXUMf
         Z6De/d7DuFTquuhQtbhECZBkdOAmewi2WhAq1ligM/CO1IdwvzYAHRlLKjE82hsL0Zv7
         oUz7LZtb04pOXXlYoqtGURhTbd1zidsWU5K5xHsrZF7zw00hjZte5bmI1aFJ7uEnfLIV
         i0ESQrVD3ErJB4icDjMY/7O5JMEkF2Q+Gs7jh/TNTaw98Rr93/NX4Y3K83cAzyQXkAQG
         YWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188389; x=1778793189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQWw1Y0UpqBl/nokhDQ3OAPFYHiDmVUDolYlpCEFvks=;
        b=L75c75a7Pdhgcvm1nHuDHnpVKdRWxi8ep+Gx6SP+iIQ8MR5bwiU0gzpPeC/nGrCCa4
         GghuJHq9jJ/cPO3WRMo09gH8x80bMqloS18LBnDoijfegcWKPoQd9hRJeV59LwLoBgMT
         OqT12JY2Uxy6x7DRXwJS2ncaYq2wFhUtq4udligTJoW9agsAvJNKqtaSsBmZB+mIn5qb
         0auVB2q179ZN09L9COnQSoNuvB5o3cApTUmxF7JrvsehgV0Q3GmZ8AwSSfEgRbW6wGyd
         wwhRLMD41KS3c0JY9kuC363+PWY0sJYyjsv2n9CYFqJ/OlRfH9NzCbNK89S0/gjgShmm
         YJWA==
X-Gm-Message-State: AOJu0YxL5No30Ika0MqdrEtenwId3eQAiNz7AAutqpdPe4aWJECVvw5d
	1BsMiptu+vD2iOR6SdkO41fWwVtF2Gt1akhpX+u5FUR6tbPZBWpeI7pZ2vI9Djc0hiFCn6bD9Cd
	phwSbmfZLvOS2+pmVIzMROaxF8Ia+3vJc/dgT0MuHDnmMsO9Q64cgLyg0hNnEybKCHFvD5fKWXp
	aHIE8P1/iGC9iHdVLllulas+obPRC+XUv+rWiX3QasfwniBhrMwJ4osW6eyzF2y3E=
X-Received: from pgbfy18.prod.google.com ([2002:a05:6a02:2a92:b0:c79:8740:a0a3])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:394d:b0:398:71e4:6287 with SMTP id adf61e73a8af0-3aa5a830dacmr9966275637.10.1778188388812;
 Thu, 07 May 2026 14:13:08 -0700 (PDT)
Date: Thu,  7 May 2026 21:13:04 +0000
In-Reply-To: <20260507211304.3046526-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507211304.3046526-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507211304.3046526-4-hramamurthy@google.com>
Subject: [PATCH net-next v6 3/3] gve: implement PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3A1F84EF269
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285495-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Action: no action

From: Jordan Rhee <jordanrhee@google.com>

Enable chrony and phc2sys to synchronize system clock to NIC clock.

Two paths are implemented: a precise path using system counter values
sampled by the device, and a fallback path using system counter values
sampled in the driver using ptp_read_system_prets()/postts().

To use the precise path, the current system clocksource must match the
units returned by the device, which on x86 is X86_TSC and on ARM64 is
ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
by default on GCP VMs using Chrony, so we expect the precise path to be
used the vast majority of the time. If the system clocksource is changed
to kvm-clock, it activates the fallback path. Ethtool counters have been
added to count how many times each path is used.

The uncertainty window in the precise path is typically around 1-2us,
while in the fallback path is around 60-80us.

Stub implementions of adjfine and adjtime are added to avoid NULL
dereference when phc2sys tries to adjust the clock.

Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Kevin Yang <yyd@google.com>
Reviewed-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v6:
- Added a fallback to driver-sampled time sandwich that is used when
  the following conditions are not met:
  - The system clock source is X86_TSC or ARM_ARCH_COUNTER
  - The requested clockid is CLOCK_REALTIME or CLOCK_MONOTONIC_RAW
  - The architecture is x86 or ARM64
- Added ethtool statistics to count how many cross-timestamps used the
  precise path versus fallback path.
- Fixed printf format specifier.
- Added stub implementions of adjtime and adjfine to prevent NULL
  dereference when phc2sys tries to adjust clock.
- Moved system time snapshot back to gve_ptp_gettimex64() so we can get the
  current system clock source from it. It is OK for it to not be inside
  the mutex or retry loop because lock contention and retries should be
  extremely rare, and chrony filters out bad samples.

Changes in v5:
- Reformulate retry loop in terms of total timeout (Jakub Kicinski)

Changes in v3:
- Take system time snapshot inside the mutex
- Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
  than x86 or arm64

Changes in v2:
 - fix compilation warning on ARM by casting cycles_t to u64
---
 drivers/net/ethernet/google/gve/gve.h         |   8 +
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +
 drivers/net/ethernet/google/gve/gve_ptp.c     | 237 +++++++++++++++++-
 4 files changed, 243 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 7b69d0cfc0d5..4de3ce60060e 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -880,6 +880,14 @@ struct gve_priv {
 	u32 stats_report_trigger_cnt; /* count of device-requested stats-reports since last reset */
 	u32 suspend_cnt; /* count of times suspended */
 	u32 resume_cnt; /* count of times resumed */
+	/* count of cross-timestamps attempted using system timestamps
+	 * from the AQ command
+	 */
+	u32 ptp_precise_xtstamps;
+	/* count of cross-timestamps attempted using system timestamps sampled
+	 * by the driver
+	 */
+	u32 ptp_fallback_xtstamps;
 	struct workqueue_struct *gve_wq;
 	struct work_struct service_task;
 	struct work_struct stats_report_task;
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
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 4fd7e8a442c5..8a088dcc3603 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
 	"rx_hsplit_unsplit_pkt",
 	"interface_up_cnt", "interface_down_cnt", "reset_cnt",
 	"page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
+	"ptp_precise_xtstamps", "ptp_fallback_xtstamps",
 };
 
 static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
@@ -269,6 +270,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->page_alloc_fail;
 	data[i++] = priv->dma_mapping_error;
 	data[i++] = priv->stats_report_trigger_cnt;
+	data[i++] = priv->ptp_precise_xtstamps;
+	data[i++] = priv->ptp_fallback_xtstamps;
 	i = GVE_MAIN_STATS_LEN;
 
 	rx_base_stats_idx = 0;
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index ad15f1209a83..9711521ce1d0 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -10,28 +10,251 @@
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
+static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_cycles,
+				  cycles_t *post_cycles)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(100);
+	unsigned long delay_us = 1000;
+	int err;
+
+	lockdep_assert_held(&ptp->nic_ts_read_lock);
+
+	do {
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
+	} while (time_before(jiffies, deadline));
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
+	err = gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_cycles);
+	if (err) {
+		dev_err_ratelimited(&ptp->priv->pdev->dev,
+				    "AdminQ timestamp read failed: %d\n", err);
 		goto out;
+	}
+
+	ts_report = ptp->nic_ts_report;
+	*nic_raw = be64_to_cpu(ts_report->nic_timestamp);
 
-	*nic_raw = be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
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
+				    "get_device_system_crosststamp() failed to convert %llu cycles to system time: %d\n",
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
+static bool
+gve_can_use_system_ts_from_device(enum clocksource_ids system_clock_source,
+				  clockid_t clockid)
+{
+	if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC_RAW)
+		return false;
+
+	/* If the system clock source matches the system clock
+	 * returned by the AdminQ command, we can use the system
+	 * timestamps returned by the device, otherwise we have to
+	 * fall back to sampling system time from the host which
+	 * is less accurate.
+	 */
+	if (IS_ENABLED(CONFIG_X86))
+		return system_clock_source == CSID_X86_TSC;
+	else if (IS_ENABLED(CONFIG_ARM64))
+		return system_clock_source == CSID_ARM_ARCH_COUNTER;
+
+	return false;
+}
+
 static int gve_ptp_gettimex64(struct ptp_clock_info *info,
 			      struct timespec64 *ts,
 			      struct ptp_system_timestamp *sts)
 {
-	return -EOPNOTSUPP;
+	struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
+	struct gve_sysclock_sample sysclock = {0};
+	bool use_system_ts_from_device = false;
+	struct gve_priv *priv = ptp->priv;
+	struct system_time_snapshot snap;
+	u64 nic_ts;
+	int err;
+
+	if (sts) {
+		/* This snapshot is used both to query the current system
+		 * clocksource and to convert the cycle counts returned
+		 * by the AdminQ command to ktime. It does not need to be
+		 * taken inside the retry loop because retries and lock
+		 * contention are expected to be extremely rare.
+		 *
+		 * If the system clock source changes between here and
+		 * when get_device_system_crosststamp() is called,
+		 * get_device_system_crosststamp() will fail which will
+		 * cause one failed sample, and the next one will succeed.
+		 */
+		ktime_get_snapshot(&snap);
+		use_system_ts_from_device =
+			gve_can_use_system_ts_from_device(snap.cs_id,
+							  sts->clockid);
+		if (use_system_ts_from_device)
+			priv->ptp_precise_xtstamps++;
+		else
+			priv->ptp_fallback_xtstamps++;
+	}
+
+	if (unlikely(!use_system_ts_from_device))
+		ptp_read_system_prets(sts);
+
+	err = gve_clock_nic_ts_read(ptp, &nic_ts, sts ? &sysclock : NULL);
+	if (err)
+		return err;
+
+	if (unlikely(!use_system_ts_from_device))
+		ptp_read_system_postts(sts);
+
+	if (sts && likely(use_system_ts_from_device)) {
+		/* Reject samples with out of order system clock values.
+		 * Firmware must return valid non-zero cycle counts.
+		 */
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
@@ -50,7 +273,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
 		goto out;
 
-	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
 	if (err) {
 		dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
 				    __func__, err);
@@ -93,7 +316,7 @@ int gve_init_clock(struct gve_priv *priv)
 		goto free_ptp;
 	}
 
-	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
 	if (err) {
 		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
 		goto free_dma_mem;
-- 
2.54.0.545.g6539524ca2-goog


