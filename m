Return-Path: <netdev+bounces-282638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IIXCgnN8mmWuQEAu9opvQ
	(envelope-from <netdev+bounces-282638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B435149CE9F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 731413089DBC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8034A3BC;
	Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z9f8Lxm1"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2E364E85;
	Thu, 30 Apr 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519563; cv=none; b=IFC/lk+MWdao9NtaNuw1V87r2qqnBlxkyr7rkpoPtH0rALmQmnPwHZWrU87f1pTSepSj0fIhQj2qVsi8jPagNM46PQzSjq2ql2lrpAVNQgKsoj3bc9qNi8DUjRpw7u2MtPuVtVy6hefVwWGnMc0N4uBsf6was3ZHBrC5iP8Wrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519563; c=relaxed/simple;
	bh=BHTt+he5N9a+zLLU83GpIHXc8tF3BhLNKLWAQBLisCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf0y1zWUCDIFDXyyyp1EG6nF4FBvKGIqJRY1R7y176COVSUeSLOo8F4v40TkTeg0I885yb2EgjZ0rwWkdOnQ+JBaDS7Tqpn1zRzB/W1QjWImzSIRo+F4Tmzec+qtGwDChcxS9jWrnrIRQX52sg131gqccuh60w/e2UZ3djRIBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z9f8Lxm1; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777519561; x=1809055561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGX5QNwZzInt+kB82jPHt8Xpn2CTP9L9elkuHkUDpdw=;
  b=Z9f8Lxm1iFtq9/h+ZnwgOy7ItCMREM2NC5hVedEtxodxGuV2PVTeM3ED
   ziLgKbJlNy8nKfSchrCAsBKJSRFyH6fhdKVahRfyQGo4ENtA+PMYzLgng
   o2koZZyrdniWomBzYEr2mBOT8WoZP9iwnD4VEB6lcoJvGKmiYogYAUBK4
   WEMzol57C3aFikxU9CBJ4eeaFbGuOq2ALSA146Qbat8PJMpWYz/kBamMB
   N3gBByDSLXHS8qDzRg88/3wKIYEvXJaBm7IrCI+LJvTW083A3sZQQzGFq
   e0JjHoAxWY4/KDM0uB2o87K+mzAaWv0nD7ytWad6wOhwjnfbW4eWqDW/z
   w==;
X-CSE-ConnectionGUID: /sqeT6HnSRC5RIjhOGVEeA==
X-CSE-MsgGUID: 5ZCupAJ8T72aKl8085g7lg==
X-IronPort-AV: E=Sophos;i="6.23,207,1770595200"; 
   d="scan'208";a="18525235"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:25:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:31005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id 98aadf95-df1e-404b-acdf-a9c6edd29f49; Thu, 30 Apr 2026 03:25:55 +0000 (UTC)
X-Farcaster-Flow-ID: 98aadf95-df1e-404b-acdf-a9c6edd29f49
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:25:55 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:25:50 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v2 net-next 4/8] ptp: ptp_vmclock: Implement attributes ioctls
Date: Thu, 30 Apr 2026 03:25:01 +0000
Message-ID: <20260430032507.11586-5-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430032507.11586-1-akiyano@amazon.com>
References: <20260430032507.11586-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: B435149CE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282638-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Implement the gettimexattrs64 and getcrosststampattrs callbacks in the
ptp_vmclock driver to provide clock quality attributes through the new
PTP_SYS_OFFSET_EXTENDED_ATTRS and PTP_SYS_OFFSET_PRECISE_ATTRS ioctls.

The ptp_vmclock device exposes:
- error_bound: Derived from time_maxerror_nanosec, accumulated with
  counter frequency error (counter_period_maxerror_rate_frac_sec) over
  elapsed counter ticks
- clock_status: Mapped from the device's clock_status field
- timescale: Determined from time_type (UTC, TAI, monotonic, etc.)

The legacy ioctls return -EINVAL when clock_status is UNRELIABLE since
they have no way to communicate clock state to userspace. The attrs
ioctls have a status field for this purpose, so they treat UNRELIABLE
as success and let userspace check the status field.

To avoid a race where the hypervisor could update clock_status between
the timestamp call and the UNRELIABLE check, the clock state is captured
inside the seq_count loop for a consistent snapshot with the timestamp.

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/ptp/ptp_vmclock.c | 195 ++++++++++++++++++++++++++++++++++----
 1 file changed, 179 insertions(+), 16 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 8b630eb..5657c06 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -53,6 +53,17 @@ struct vmclock_state {
 	char *name;
 };
 
+/**
+ * struct vmclock_crosststamp_ctx - context for get_device_system_crosststamp()
+ * @st: vmclock device state
+ * @attrs: optional output for PTP clock attributes, populated inside the
+ *         seq_count loop for a consistent snapshot with the timestamp
+ */
+struct vmclock_crosststamp_ctx {
+	struct vmclock_state *st;
+	struct ptp_clock_attributes *attrs;
+};
+
 #define VMCLOCK_MAX_WAIT ms_to_ktime(100)
 
 /* Require at least the flags field to be present. All else can be optional. */
@@ -95,14 +106,109 @@ static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
 	return false;
 }
 
+static uint8_t vmclock_get_ptp_timescale(uint8_t vmclock_time_type)
+{
+	switch (vmclock_time_type) {
+	case VMCLOCK_TIME_UTC:
+		return PTP_TIMESCALE_UTC;
+	case VMCLOCK_TIME_TAI:
+		return PTP_TIMESCALE_TAI;
+	case VMCLOCK_TIME_MONOTONIC:
+		return PTP_TIMESCALE_MONOTONIC;
+	default:
+		return PTP_TIMESCALE_UNKNOWN;
+	}
+}
+
+static uint8_t vmclock_get_ptp_status(uint8_t vmclock_status)
+{
+	switch (vmclock_status) {
+	case VMCLOCK_STATUS_UNKNOWN:
+		return PTP_CLOCK_STATUS_UNKNOWN;
+	case VMCLOCK_STATUS_INITIALIZING:
+		return PTP_CLOCK_STATUS_INITIALIZING;
+	case VMCLOCK_STATUS_SYNCHRONIZED:
+		return PTP_CLOCK_STATUS_SYNCED;
+	case VMCLOCK_STATUS_FREERUNNING:
+		return PTP_CLOCK_STATUS_FREE_RUNNING;
+	case VMCLOCK_STATUS_UNRELIABLE:
+		return PTP_CLOCK_STATUS_UNRELIABLE;
+	default:
+		return PTP_CLOCK_STATUS_UNKNOWN;
+	}
+}
+
+static void vmclock_populate_ptp_attributes(struct vmclock_state *st,
+					    struct ptp_clock_attributes *att,
+					    uint64_t delta,
+					    uint64_t cycle)
+{
+	uint64_t maxerror_ns = UINT_MAX;
+
+	if (!att)
+		return;
+
+	/* Only calculate if the base error is flagged as valid
+	 * by the hypervisor.
+	 */
+	if (VMCLOCK_FIELD_PRESENT(st->clk, time_maxerror_nanosec) &&
+	    (le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_TIME_MAXERROR_VALID)) {
+		maxerror_ns = le64_to_cpu(st->clk->time_maxerror_nanosec);
+
+		/* If frequency error is also valid, accumulate it
+		 * over the delta.
+		 */
+		if (VMCLOCK_FIELD_PRESENT(st->clk, counter_period_maxerror_rate_frac_sec) &&
+		    (le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_PERIOD_MAXERROR_VALID)) {
+			uint64_t maxerror_rate, err_hi, err_frac, growth_ns;
+
+			maxerror_rate = le64_to_cpu(st->clk->counter_period_maxerror_rate_frac_sec);
+			err_frac = mul_u64_u64_shr_add_u64(&err_hi, delta,
+							   maxerror_rate,
+							   st->clk->counter_period_shift,
+							   0);
+
+			growth_ns = (err_hi * NSEC_PER_SEC) +
+				    mul_u64_u64_shr(err_frac, NSEC_PER_SEC, 64);
+
+			/* Guard against overflow */
+			if (U64_MAX - growth_ns < maxerror_ns)
+				maxerror_ns = U64_MAX;
+			else
+				maxerror_ns += growth_ns;
+		}
+	}
+
+	/* PTP UAPI error_bound is 32-bit nanoseconds */
+	att->error_bound = (maxerror_ns > UINT_MAX) ?
+		UINT_MAX : (uint32_t)maxerror_ns;
+	att->timescale = vmclock_get_ptp_timescale(st->clk->time_type);
+	att->status = vmclock_get_ptp_status(st->clk->clock_status);
+
+	att->counter_value = cycle;
+	switch (st->cs_id) {
+	case CSID_X86_TSC:
+		att->counter_id = PTP_COUNTER_X86_TSC;
+		break;
+	case CSID_ARM_ARCH_COUNTER:
+		att->counter_id = PTP_COUNTER_ARM_ARCH;
+		break;
+	default:
+		att->counter_id = PTP_COUNTER_UNKNOWN;
+		break;
+	}
+}
+
 static int vmclock_get_crosststamp(struct vmclock_state *st,
 				   struct ptp_system_timestamp *sts,
 				   struct system_counterval_t *system_counter,
-				   struct timespec64 *tspec)
+				   struct timespec64 *tspec,
+				   struct ptp_clock_attributes *attrs)
 {
 	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
 	struct system_time_snapshot systime_snapshot;
 	uint64_t cycle, delta, seq, frac_sec;
+	uint8_t clock_status = VMCLOCK_STATUS_UNKNOWN;
 
 #ifdef CONFIG_X86
 	/*
@@ -122,9 +228,6 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 		 */
 		virt_rmb();
 
-		if (st->clk->clock_status == VMCLOCK_STATUS_UNRELIABLE)
-			return -EINVAL;
-
 		/*
 		 * When invoked for gettimex64(), fill in the pre/post system
 		 * times. The simple case is when system time is based on the
@@ -163,6 +266,18 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 		if (!tai_adjust(st->clk, &tspec->tv_sec))
 			return -EINVAL;
 
+		/*
+		 * Capture clock state inside the seq_count loop for a
+		 * consistent snapshot with the timestamp. The attrs path
+		 * reports it to userspace via the status field; the legacy
+		 * path saves it for the UNRELIABLE check after the loop.
+		 */
+		if (attrs)
+			vmclock_populate_ptp_attributes(st, attrs, delta,
+							cycle);
+		else
+			clock_status = st->clk->clock_status;
+
 		/*
 		 * This pairs with a write barrier in the hypervisor
 		 * which populates this structure.
@@ -186,6 +301,17 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 			sts->post_ts = sts->pre_ts;
 	}
 
+	/*
+	 * If attrs is set, attributes were already populated inside the
+	 * seq_count loop. Return success even for UNRELIABLE — the attrs
+	 * ioctl can report the status to userspace.
+	 */
+	if (attrs)
+		return 0;
+
+	if (clock_status == VMCLOCK_STATUS_UNRELIABLE)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -198,7 +324,8 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 					    struct ptp_system_timestamp *sts,
 					    struct system_counterval_t *system_counter,
-					    struct timespec64 *tspec)
+					    struct timespec64 *tspec,
+					    struct ptp_clock_attributes *attrs)
 {
 	struct pvclock_vcpu_time_info *pvti = this_cpu_pvti();
 	unsigned int pvti_ver;
@@ -209,7 +336,8 @@ static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 	do {
 		pvti_ver = pvclock_read_begin(pvti);
 
-		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec);
+		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec,
+					     attrs);
 		if (ret)
 			break;
 
@@ -238,17 +366,19 @@ static int ptp_vmclock_get_time_fn(ktime_t *device_time,
 				   struct system_counterval_t *system_counter,
 				   void *ctx)
 {
-	struct vmclock_state *st = ctx;
+	struct vmclock_crosststamp_ctx *vctx = ctx;
+	struct vmclock_state *st = vctx->st;
 	struct timespec64 tspec;
 	int ret;
 
 #ifdef SUPPORT_KVMCLOCK
 	if (READ_ONCE(st->sys_cs_id) == CSID_X86_KVM_CLK)
 		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
-						       &tspec);
+						       &tspec, vctx->attrs);
 	else
 #endif
-		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec);
+		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec,
+					     vctx->attrs);
 
 	if (!ret)
 		*device_time = timespec64_to_ktime(tspec);
@@ -256,12 +386,11 @@ static int ptp_vmclock_get_time_fn(ktime_t *device_time,
 	return ret;
 }
 
-static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
-				      struct system_device_crosststamp *xtstamp)
+static int ptp_vmclock_do_getcrosststamp(struct vmclock_crosststamp_ctx *vctx,
+					 struct system_device_crosststamp *xtstamp)
 {
-	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
-						ptp_clock_info);
-	int ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn, st,
+	struct vmclock_state *st = vctx->st;
+	int ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn, vctx,
 						NULL, xtstamp);
 #ifdef SUPPORT_KVMCLOCK
 	/*
@@ -278,13 +407,23 @@ static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
 		    systime_snapshot.cs_id == CSID_X86_KVM_CLK) {
 			WRITE_ONCE(st->sys_cs_id, systime_snapshot.cs_id);
 			ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn,
-							    st, NULL, xtstamp);
+							    vctx, NULL, xtstamp);
 		}
 	}
 #endif
 	return ret;
 }
 
+static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
+				      struct system_device_crosststamp *xtstamp)
+{
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+	struct vmclock_crosststamp_ctx vctx = { .st = st };
+
+	return ptp_vmclock_do_getcrosststamp(&vctx, xtstamp);
+}
+
 /*
  * PTP clock operations
  */
@@ -311,7 +450,29 @@ static int ptp_vmclock_gettimex(struct ptp_clock_info *ptp, struct timespec64 *t
 	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
 						ptp_clock_info);
 
-	return vmclock_get_crosststamp(st, sts, NULL, ts);
+	return vmclock_get_crosststamp(st, sts, NULL, ts, NULL);
+}
+
+static int ptp_vmclock_gettimexattrs(struct ptp_clock_info *ptp,
+				     struct timespec64 *ts,
+				     struct ptp_system_timestamp *sts,
+				     struct ptp_clock_attributes *att)
+{
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+
+	return vmclock_get_crosststamp(st, sts, NULL, ts, att);
+}
+
+static int ptp_vmclock_getcrosststampattrs(struct ptp_clock_info *ptp,
+					   struct system_device_crosststamp *xtstamp,
+					   struct ptp_clock_attributes *att)
+{
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+	struct vmclock_crosststamp_ctx vctx = { .st = st, .attrs = att };
+
+	return ptp_vmclock_do_getcrosststamp(&vctx, xtstamp);
 }
 
 static int ptp_vmclock_enable(struct ptp_clock_info *ptp,
@@ -329,9 +490,11 @@ static const struct ptp_clock_info ptp_vmclock_info = {
 	.adjfine	= ptp_vmclock_adjfine,
 	.adjtime	= ptp_vmclock_adjtime,
 	.gettimex64	= ptp_vmclock_gettimex,
+	.gettimexattrs64 = ptp_vmclock_gettimexattrs,
 	.settime64	= ptp_vmclock_settime,
 	.enable		= ptp_vmclock_enable,
 	.getcrosststamp = ptp_vmclock_getcrosststamp,
+	.getcrosststampattrs = ptp_vmclock_getcrosststampattrs,
 };
 
 static struct ptp_clock *vmclock_ptp_register(struct device *dev,
-- 
2.47.3


