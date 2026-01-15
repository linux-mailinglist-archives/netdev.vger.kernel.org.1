Return-Path: <netdev+bounces-250329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4ABD29006
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59CE2301458C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2B327BEC;
	Thu, 15 Jan 2026 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpVhqMpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73A320A1A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515827; cv=none; b=F/O64kBhByNAeFMO/nLPypSVQFyy07GNylmbIW0BQTPDVB7YN3L+bg1Ut0l0qVxQz8RDsqBDx4cSDVCeRjAE9mwm/qIMl4BYxOTJWmrB81yeX4Xv7qiPqJ5rOKDxqU1L9I+iEvdWfu0GPqJoF0OXVO5vAipPQ06WmgrYGE5i8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515827; c=relaxed/simple;
	bh=fDJP42lW9gpk6FWW89FMF7VSnQZOI3y90HN2JTsof7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iU6PgoNrl4IDlw3EZEVwCMyHjCbWVeVioziAuBn1Un/zLuZQO7qo11xVd/uH5E3jKrfyJ1ezBYfxGNsJhBPnuEl3CaHOSJYgNTvVkUEVfYezCXpDByyZlCPCNhzYyeU/7mFOMnptoopBQoKdQsxEyH1XDHxql3owrY0w4J7M5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpVhqMpG; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6a87029b6so9876685a.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768515825; x=1769120625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ua18wpmfPdr+0GKOF5nrtTwAkOqbH3SKTA8BQ5ivfqA=;
        b=KpVhqMpGeBmXOmqfhuF7ZG1e2cKa7PCEfHLYBXv8d01B29ijUJnkhLDbSwYeJedvNq
         OctZ+Mu8By0HLwY45guklI8SLx5/GzYTsuuQtjcdMLdG8TefwP8VhIGeVJ98vSmn/igE
         BDxYJUMLRK14Y4ixAiFyX/+mm+CdupdEOSPxOALG09l1meyVcVKAl4sqpgckmR7ulzZW
         a6FLwcmO4bOtqD95ptXGsT8sTDOIt0zvMk+8EzPKVzR5c8bpP3jcdE8vkxyVJZ1ENcz6
         z/3PCdbPrjMm8c6NFEF3eeLPtFg/pl0IQU85Yu0NLb1Sv7VNWO4uxgbwWmItWN1H4+bB
         UnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515825; x=1769120625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua18wpmfPdr+0GKOF5nrtTwAkOqbH3SKTA8BQ5ivfqA=;
        b=TIB9/ES6+6WtnniVbGjN9AuX22eVytFYgR5+ITJ5puW0rjgySwx7WpM03x5rF1tOJz
         ezgf9vV7H5U0Ot9cLh1QI3DWkvGKR24h7zWy8ZfScqGAfezBXX691l/PH9yqE0HENy//
         tU/g+XPpu77QV/6bZ5/5nDEjho4+NYLf9rfsGdxY7qcVaSO7EqeC08MUL43jQNDuIXr8
         riLiv8OiZkf+gPMh6up4IF1rwUkNQhyUqEqDRPIMFHXQ5q3l5LpgVl6UMMrx5te2S46w
         TxFHWNajiczdX8PISvnvklNyovEke/RTCEn41PplUxKtVeBfUW0dyAvwH9Ak23ULnKvH
         7qsw==
X-Gm-Message-State: AOJu0YxUmiJs7M2PesOykIF6M38kd3B3EAxxejOmv1JpeWe3QnJajBXZ
	d444RZKbsMtj40rUCnxybT6kEct0f3nss0ceaHFTFiiplg5ACpVi4/vh5WGFTKKPdGZ9Sw==
X-Received: from qkww27.prod.google.com ([2002:a05:620a:95b:b0:8c6:a2f2:26e8])
 (user=yyd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:29d3:b0:8b2:f090:b167
 with SMTP id af79cd13be357-8c6a670434fmr154195185a.24.1768515824929; Thu, 15
 Jan 2026 14:23:44 -0800 (PST)
Date: Thu, 15 Jan 2026 22:23:00 +0000
In-Reply-To: <20260115222300.1116386-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115222300.1116386-1-yyd@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115222300.1116386-2-yyd@google.com>
Subject: [PATCH net-next 2/2] gve: implement ndo_get_tstamp
From: Kevin Yang <yyd@google.com>
To: Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, yyd@google.com
Content-Type: text/plain; charset="UTF-8"

This patch implements ndo_get_tstamp in gve to support converting a
hwtstamp to the system's realtime clock.

The implementation does not assume the NIC clock is disciplined,
in other word, the NIC clock can be free-running. A periodic
job, embedded in gve's ptp_aux_work, updates the offset and slope
for the conversion.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |   8 ++
 drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   |  27 +++++
 drivers/net/ethernet/google/gve/gve_ptp.c    | 106 ++++++++++++++++++-
 4 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 970d5ca8cddee..13a4c450e7635 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -774,6 +774,13 @@ struct gve_flow_rule {
 	struct gve_flow_spec mask;
 };
 
+struct gve_tstamp_conversion {
+	u64 last_sync_ns;
+	seqlock_t lock; /* protects tc and cc */
+	struct timecounter tc;
+	struct cyclecounter cc;
+};
+
 struct gve_flow_rules_cache {
 	bool rules_cache_synced; /* False if the driver's rules_cache is outdated */
 	struct gve_adminq_queried_flow_rule *rules_cache;
@@ -925,6 +932,7 @@ struct gve_priv {
 	struct gve_nic_ts_report *nic_ts_report;
 	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
+	struct gve_tstamp_conversion ts_real;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 22a74b6aa17ea..812160b87b143 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -411,8 +411,8 @@ static_assert(sizeof(struct gve_adminq_report_nic_ts) == 16);
 
 struct gve_nic_ts_report {
 	__be64 nic_timestamp; /* NIC clock in nanoseconds */
-	__be64 reserved1;
-	__be64 reserved2;
+	__be64 cycle_pre;
+	__be64 cycle_post;
 	__be64 reserved3;
 	__be64 reserved4;
 };
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 7eb64e1e4d858..2acc1a3d85838 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2198,6 +2198,32 @@ static int gve_set_ts_config(struct net_device *dev,
 	return 0;
 }
 
+static ktime_t gve_get_tstamp(struct net_device *dev,
+			      const struct skb_shared_hwtstamps *hwtstamps,
+			      enum netdev_tstamp_type type)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	unsigned int seq;
+	u64 ns;
+
+	if (type == NETDEV_TSTAMP_RAW)
+		return hwtstamps->hwtstamp;
+
+	if (type != NETDEV_TSTAMP_REALTIME)
+		return 0;
+
+	/* Skip if never synced */
+	if (!READ_ONCE(priv->ts_real.last_sync_ns))
+		return 0;
+
+	do {
+		seq = read_seqbegin(&priv->ts_real.lock);
+		ns = timecounter_cyc2time(&priv->ts_real.tc,
+					  hwtstamps->hwtstamp);
+	} while (read_seqretry(&priv->ts_real.lock, seq));
+	return ns_to_ktime(ns);
+}
+
 static const struct net_device_ops gve_netdev_ops = {
 	.ndo_start_xmit		=	gve_start_xmit,
 	.ndo_features_check	=	gve_features_check,
@@ -2209,6 +2235,7 @@ static const struct net_device_ops gve_netdev_ops = {
 	.ndo_bpf		=	gve_xdp,
 	.ndo_xdp_xmit		=	gve_xdp_xmit,
 	.ndo_xsk_wakeup		=	gve_xsk_wakeup,
+	.ndo_get_tstamp		=	gve_get_tstamp,
 	.ndo_hwtstamp_get	=	gve_get_ts_config,
 	.ndo_hwtstamp_set	=	gve_set_ts_config,
 };
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 073677d82ee8e..df32735fa940f 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -10,10 +10,91 @@
 /* Interval to schedule a nic timestamp calibration, 250ms. */
 #define GVE_NIC_TS_SYNC_INTERVAL_MS 250
 
+/* Scale ts_real.cc.mult by 1 << 31. Maximize mult for finer adjustment
+ * granularity, but ensure (mult * cycle) does not overflow in
+ * cyclecounter_cyc2ns.
+ */
+#define GVE_HWTS_REAL_CC_SHIFT 31
+#define GVE_HWTS_REAL_CC_NOMINAL BIT_ULL(GVE_HWTS_REAL_CC_SHIFT)
+
+/* Get the cross time stamp info */
+static int gve_get_cross_time(ktime_t *device,
+			      struct system_counterval_t *system, void *ctx)
+{
+	struct gve_priv *priv = ctx;
+
+	*device = ns_to_ktime(be64_to_cpu(priv->nic_ts_report->nic_timestamp));
+	system->cycles = be64_to_cpu(priv->nic_ts_report->cycle_pre) +
+			 (be64_to_cpu(priv->nic_ts_report->cycle_post) -
+			  be64_to_cpu(priv->nic_ts_report->cycle_pre)) / 2;
+	system->use_nsecs = false;
+	if (IS_ENABLED(CONFIG_X86))
+		system->cs_id = CSID_X86_TSC;
+	else if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
+		system->cs_id = CSID_ARM_ARCH_COUNTER;
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int gve_hwts_realtime_update(struct gve_priv *priv, u64 prev_nic)
+{
+	struct system_device_crosststamp cts = {};
+	struct system_time_snapshot history = {};
+	s64 nic_real_off_ns;
+	u64 real_ns;
+	int ret;
+
+	/* Step 1: Get the realtime of when NIC clock was read */
+	ktime_get_snapshot(&history);
+	ret = get_device_system_crosststamp(gve_get_cross_time, priv, &history,
+					    &cts);
+	if (ret) {
+		dev_err_ratelimited(&priv->pdev->dev,
+				    "%s crosststamp err %d\n", __func__, ret);
+		return ret;
+	}
+
+	real_ns = ktime_to_ns(cts.sys_realtime);
+
+	/* Step 2: Adjust NIC clock's offset */
+	/* Read-side ndo_get_tstamp can be called from TCP rx softirq */
+	write_seqlock_bh(&priv->ts_real.lock);
+	nic_real_off_ns = real_ns - timecounter_read(&priv->ts_real.tc);
+	timecounter_adjtime(&priv->ts_real.tc, nic_real_off_ns);
+
+	/* Step 3: Adjust NIC clock's ratio (when this is not the first sync).
+	 * The NIC clock's nominal tick ratio is 1 tick per nanosecond,
+	 * scaled by 1 << GVE_HWTS_REAL_CC_SHIFT. Adjust it to
+	 * (ktime - prev_ktime) / (nic - prev_nic). The ratio should not
+	 * deviate more than 1% from the nominal, otherwise it may suggest
+	 * there was a sudden change on NIC clock. In that case, reset ratio
+	 * to nominal. And since each sync only compares to the previous read,
+	 * this is a one-time error, not a persistent failure.
+	 */
+	if (prev_nic) {
+		const u64 lower = GVE_HWTS_REAL_CC_NOMINAL * 99 / 100;
+		const u64 upper = GVE_HWTS_REAL_CC_NOMINAL * 101 / 100;
+		u64 mult;
+
+		mult = mult_frac(GVE_HWTS_REAL_CC_NOMINAL,
+				 real_ns - priv->ts_real.last_sync_ns,
+				 priv->last_sync_nic_counter - prev_nic);
+		if (mult < lower || mult > upper)
+			mult = GVE_HWTS_REAL_CC_NOMINAL;
+		priv->ts_real.cc.mult = mult;
+	}
+
+	write_sequnlock_bh(&priv->ts_real.lock);
+	WRITE_ONCE(priv->ts_real.last_sync_ns, real_ns);
+	return 0;
+}
+
 /* Read the nic timestamp from hardware via the admin queue. */
 int gve_clock_nic_ts_read(struct gve_priv *priv)
 {
-	u64 nic_raw;
+	u64 nic_raw, prev_nic;
 	int err;
 
 	err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
@@ -21,7 +102,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
 		return err;
 
 	nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+	prev_nic = priv->last_sync_nic_counter;
 	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
+	err = gve_hwts_realtime_update(priv, prev_nic);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -57,6 +142,14 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 	return msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS);
 }
 
+static u64 gve_cycles_read(struct cyclecounter *cc)
+{
+	const struct gve_priv *priv = container_of(cc, struct gve_priv,
+						   ts_real.cc);
+
+	return READ_ONCE(priv->last_sync_nic_counter);
+}
+
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
@@ -89,6 +182,17 @@ static int gve_ptp_init(struct gve_priv *priv)
 		goto free_ptp;
 	}
 
+	priv->last_sync_nic_counter = 0;
+	priv->ts_real.last_sync_ns = 0;
+	seqlock_init(&priv->ts_real.lock);
+	memset(&priv->ts_real.cc, 0, sizeof(priv->ts_real.cc));
+	priv->ts_real.cc.mask = U32_MAX;
+	priv->ts_real.cc.shift = GVE_HWTS_REAL_CC_SHIFT;
+	priv->ts_real.cc.mult = GVE_HWTS_REAL_CC_NOMINAL;
+	priv->ts_real.cc.read = gve_cycles_read;
+	timecounter_init(&priv->ts_real.tc, &priv->ts_real.cc,
+			 ktime_get_real_ns());
+
 	ptp->priv = priv;
 	return 0;
 
-- 
2.52.0.457.g6b5491de43-goog


