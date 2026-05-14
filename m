Return-Path: <netdev+bounces-288094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPhiG/9TBmqnigIAu9opvQ
	(envelope-from <netdev+bounces-288094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:00:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A095479F7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C07E306AD32
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53493D412D;
	Thu, 14 May 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8QRTkzv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70153D25D3
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799529; cv=none; b=AESOyMsnJkRSNMAKdjizvu69u11BGjLM0kkCNPc5DkugzSMRLuyTfh5lwQz1nzSKeF3y5tgvjuPO1yNRP+mTl9RGBnnZM66xz0oDFT8TGFLEelJc6Rj+gmuNIW0pbZth11obWbfVV091geJPudqKc/Cx7wHXFXO/BspFrZhn2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799529; c=relaxed/simple;
	bh=HnPIWITbVx46lbmF3xkUIS+AK4W+i+oMIbG1ffVF8wk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJkXJx01ATfzAgeIRL8viI64VHhqTXiZjYzyEjAgliFS0jQFCrOWENSFuzud/w9LT5GkTKG5tpAMbojBoRNenM8Bf5lvM4aSXezQXD0dSubiHo+Od2uwKTRYz2ZCwMuQhmmiNY+a4DDheH65AelTFGjoKzylAUKEMdYH0GWIycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8QRTkzv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b458add85aso89365325ad.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778799527; x=1779404327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abIcwKxAmTfom6lVWHyjSZQ9OP14krWhDE8oMpgBa1U=;
        b=s8QRTkzvGb/bje/RowCg+N/rAbI3lPdHUB29fEbxnQxLsVzY5jMQ0KRtPcXNeT49+q
         LJRXNrLr+iXdtMB5vQjsl4s9SqprEFWWbrQL8OsuQn/3IyfUjCvTjgFI/Sxy/oD3gqdJ
         bqsH9kD+Zvv5YmWtYZCGiUSnkBNDF8O8VMzQmO9C2FegAyL8NKDukFykP6deTUhx2fkB
         LF37qjec+4IbMFKjoUKNJElqyjxRmsnYnyZrG79g57VLXUDOuAy4+BoMITZNtPyZHWtF
         JK3rF2Fsp+OKM66QpXavKJywlJn67Q9rIwbu+vCmA5iVKXRdHO1nntvKhv44T5qHa38A
         U30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799527; x=1779404327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abIcwKxAmTfom6lVWHyjSZQ9OP14krWhDE8oMpgBa1U=;
        b=gv9lICh6K4b4k/66goSwbXNE81miU/mLVWTPPXzrXN818ET4vmoGJLrDV3hhYIj6eW
         n1Rn9/fD3tH4slZlLK/uYRfM+I/J+YCFs/wKBuXp3SWdQRA6Sa+5nsl0thGZcwUcFnnW
         1Haj7/1/04qu214ae908XSDLWZXup3PTP+l0ZNnhb/vXr2wpWW4fkuO727yXEy/lqCBg
         l6GIyHA1/bOR9nq0aidg78dXo8H89XP8du2hEhm0QPEc+7sRGKDbdXWTSI3CnwuBDc1b
         Ry1uYEKz9mJiIu1nQkfPu67Z26WfpPDpCAwv3mfD/ioXuASTu89pPLZ8Mjj+67U69V2y
         fEnQ==
X-Gm-Message-State: AOJu0YzOofDcTcZylz6+qq4zaNkYEAUdBJF2Ba+yW7spZU8UW8d71kDF
	dm5CCs9Q0a7kZJGx5cfkYxV7w92PeCnR955ISsbz7dn57LfoCdFcrfkSKfHX67CQS10PRBp35pK
	HPOWv9rsmuI97Jm1utPsRrkcwzINCWp0Aw+0T9I+E04E0BHM0o0bjrQdvkXBgJiGJ4UZgwH6fJl
	GaXDea3hIH08Ga7Id98i4oP8zgQdgf3+yX1/TbPUHq2/VuXnENuWSwm1lAQ4A30cY=
X-Received: from plrc11.prod.google.com ([2002:a17:902:aa4b:b0:2ba:b55d:2457])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:7c0e:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2bd7e8acabcmr9396365ad.12.1778799526592;
 Thu, 14 May 2026 15:58:46 -0700 (PDT)
Date: Thu, 14 May 2026 22:58:42 +0000
In-Reply-To: <20260514225842.110706-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514225842.110706-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260514225842.110706-4-hramamurthy@google.com>
Subject: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
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
X-Rspamd-Queue-Id: D7A095479F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Kevin Yang <yyd@google.com>
Reviewed-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v7:
- Actually committed the stubs for adjtime and adjfine. (Sashiko)
- Picked up Jake Keller's review tag

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
---
 drivers/net/ethernet/google/gve/gve.h         |   8 +
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +
 drivers/net/ethernet/google/gve/gve_ptp.c     | 249 +++++++++++++++++-
 4 files changed, 255 insertions(+), 9 deletions(-)

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
index ad15f1209a83..bc230e68eb1d 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -10,28 +10,261 @@
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
+static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int gve_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
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
@@ -50,7 +283,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 	if (gve_get_reset_in_progress(priv) || !gve_get_admin_queue_ok(priv))
 		goto out;
 
-	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
 	if (err) {
 		dev_err_ratelimited(&priv->pdev->dev, "%s read err %d\n",
 				    __func__, err);
@@ -65,6 +298,8 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
+	.adjfine	= gve_ptp_adjfine,
+	.adjtime	= gve_ptp_adjtime,
 	.gettimex64	= gve_ptp_gettimex64,
 	.settime64	= gve_ptp_settime64,
 	.do_aux_work	= gve_ptp_do_aux_work,
@@ -93,7 +328,7 @@ int gve_init_clock(struct gve_priv *priv)
 		goto free_ptp;
 	}
 
-	err = gve_clock_nic_ts_read(ptp, &nic_raw);
+	err = gve_clock_nic_ts_read(ptp, &nic_raw, NULL);
 	if (err) {
 		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
 		goto free_dma_mem;
-- 
2.54.0.563.g4f69b47b94-goog


