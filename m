Return-Path: <netdev+bounces-251977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN25GHUTcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-251977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:57:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520D5AD95
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA4AE5954
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6304285404;
	Wed, 21 Jan 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTqgUHKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1697356A2C
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011562; cv=none; b=ksiu7YEE1qUAmoyA8SsL6SzghNU6EDeQfrcIv3iiFnAXfIQV1WLP8NECm6Q2n2kGVv3ldL6B3hHyzqLw6+hTNCxQQaW11BZfLzuMMbnMv8mi4JXYWQPU3OO1xWG6v4S/aYyedjVQcTfU6yz8MiRoJM/QlpUfKPJgvfNU9J7AORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011562; c=relaxed/simple;
	bh=q7b53ga4B1uxww4xSDCsiuaiVrjbLiVdrrZZWrMjEt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GQXi5V2fcphrNlUeOXYy1puQE+EOKZG2ALgR/wDuEDkR95Aunep70Vq5BmDnGdlzQeUZ1swPMp78ztcijJP+IygFFjB9Z1tp2HM1pnRnN8rz+fE33hPpiSQeK+u4b27NABu90d7UMIODUSIEfIV/1JeKMuCC9Ce+lzL9/iALIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTqgUHKk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-790afc07667so75286607b3.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011560; x=1769616360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXQ83PlSIz3DTpL5wTDZcSfCmq2D6iQrWU78TfdP+oE=;
        b=DTqgUHKkg9cr823JtrA+EjAJeGrDkbIDuNy10qKDxMTslgOhUmpNsxX9KcwxEQN9c3
         jhUMFW1G9UNAiZ39GDB2UpeKmi7erU3A+erG3r9c5jQwr+9+aikuJoIuvmc3XTkIX6wE
         3HizgYXOFj3g4tRdb8dCPseK3kK6mRF1H+NR4+Xb/4fluhv15x0q47oIvVd36WGV/FYd
         6LWK2iZJ/gHxGHepcjMF2uiM7IOYrPuh9SQKBcl2FPjaa5dBJD7hM9zD28Uui2W4jujO
         HcQ3S3+i5FIeh+6ZqXCOQN222dZX/tarWKgZhLtepwR5A90ecb+GXduZU6QYy3TW1WP/
         6Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011560; x=1769616360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXQ83PlSIz3DTpL5wTDZcSfCmq2D6iQrWU78TfdP+oE=;
        b=mcC44Au8U4SCtLoz0/5HYPW2cbob1qrA6VcDldYK30WAy7pgj3kLm6gD67PfNR2TIM
         L2/zaY4YIdOHzY+8yOZvnCXPLj9LP+BjE6DQezK1gUlAOlbzX59tqzRnnu/GjMH96qHl
         rST7Ic6U//b0deCPlUM3LhXitRiDaJ9EOjkTE8abWO1ujYafXW50T20g2+/ZdDEBj6IQ
         9zB9z5irqXaHuiRJZ8Z1oMX4cQ9CUnsch2OzLCMMolVNpcYpN3ZMo8NgZnvVQyvW5W9O
         IrmFYrZ18k7iv4FkdIKxS2C/i/CySHa8/eQX6FVwTVtCrd65ssdiCze9siuQFvrBVPAd
         sR/w==
X-Gm-Message-State: AOJu0YwbZat4qI8g8qy3iqcZhYbn2RyTEtbH/4OUQob1UxRS4gyr0ODc
	BOM0kEy0Yqyh2WkbBXsfbxn+J5Gsg/mu4gtEnFC5BWEZYmqO6py5/UFpkM4H2PUINZjQAg==
X-Received: from ywbkc5.prod.google.com ([2002:a05:690c:4f05:b0:78f:8957:3fb8])
 (user=yyd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:e3cb:b0:78c:2c4d:3dfd
 with SMTP id 00721157ae682-793c525d183mr163128357b3.4.1769011559673; Wed, 21
 Jan 2026 08:05:59 -0800 (PST)
Date: Wed, 21 Jan 2026 16:04:58 +0000
In-Reply-To: <20260121160458.990785-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121160458.990785-1-yyd@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121160458.990785-3-yyd@google.com>
Subject: [PATCH net-next v2 2/2] gve: implement ndo_get_tstamp
From: Kevin Yang <yyd@google.com>
To: Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, yyd@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,engleder-embedded.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyd@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ts_real.cc:url]
X-Rspamd-Queue-Id: 9520D5AD95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/google/gve/gve_ptp.c    | 107 ++++++++++++++++++-
 4 files changed, 143 insertions(+), 3 deletions(-)

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
index c42640da15a5a..c44b4526ccced 100644
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
+	if (type == NETDEV_TSTAMP_PHC)
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
index 073677d82ee8e..dfe353ae75fb1 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -10,10 +10,92 @@
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
+	u64 nic_delta = priv->last_sync_nic_counter - prev_nic;
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
+	if (prev_nic && nic_delta) {
+		const u64 lower = GVE_HWTS_REAL_CC_NOMINAL * 99 / 100;
+		const u64 upper = GVE_HWTS_REAL_CC_NOMINAL * 101 / 100;
+		u64 numer = real_ns - priv->ts_real.last_sync_ns;
+		u64 mult, quot, rem;
+
+		quot = div64_u64_rem(GVE_HWTS_REAL_CC_NOMINAL, nic_delta, &rem);
+		mult = (quot * numer) + div64_u64(rem * numer, nic_delta);
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
@@ -21,7 +103,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
 		return err;
 
 	nic_raw = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+	prev_nic = priv->last_sync_nic_counter;
 	WRITE_ONCE(priv->last_sync_nic_counter, nic_raw);
+	err = gve_hwts_realtime_update(priv, prev_nic);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -57,6 +143,14 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
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
@@ -89,6 +183,17 @@ static int gve_ptp_init(struct gve_priv *priv)
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


