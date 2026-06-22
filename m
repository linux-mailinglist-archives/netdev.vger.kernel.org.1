Return-Path: <netdev+bounces-301199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZqdDEuimOWoQwAcAu9opvQ
	(envelope-from <netdev+bounces-301199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:19:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437F6B2753
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:19:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=DSnKZln0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301199-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31CB0303A24B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7E368D7C;
	Mon, 22 Jun 2026 21:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348B27A476;
	Mon, 22 Jun 2026 21:18:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163120; cv=none; b=QZSAZjXkuuZEvE4/7D/jXNaoGnRkKWQi6dbGaX0EqiCpSMKPC93R3mqcveAO1ZoSnP2laG6kAiNKRcABEXSHORNP6X2vDwLDQR17XNfQlE/md7xAPGPbKKQA4b2LHgHbHhi/tCsZvnusowtVD2Yyxq402i7eAi36ZXhXBI6HNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163120; c=relaxed/simple;
	bh=GVfni0ePwGjTWhtxgSi9BxJqIvO3OEb/a9UnYHhFYiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot8BjWyRsMkgtuoui17ukr+A9m34PaSAG89Lhp/1JR7Qtdvxbg6E9B28jKf2JpmdIzeOUOwnFWO5KFtl5PPmAg/BN4F/XcPmS3PViPMp3tlvvXhgJZXafSuASJxhTYhySxHAI9ZaYv8k5uPf8gI5DIY5G92pkqK2CgKSE5MxQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DSnKZln0; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pQg6lPJiqM10o//28i/X+S7XzB0xXeOHiH4Zr042zrE=; b=DSnKZln0zdLo4yQ2wD2J+3u22v
	n9YVZWaWGy9x2iou5fiA5cANPZSy3lAVFoCW5wgX6fgvYqnLBDH0/oEY35j38/QBhqc84gA6eQIMi
	Wv3ESOymDkA27BiPGnGMj8wX6UMwj/99nRUaPN8M4T6rqZ3NQU6Y/y2BxctTOqyGU7tn4XA0Wl77S
	h0DLjPzLggAJYHcvT5L6sLvZHFYiomOrlQKhzhfX3KCcq4YZRBvTx5ZGhlBzOkJVYWcHxfhy/kt8t
	SxPMDjNzA+wviNcxeVb3RuTC3CQLxF2+sPplO7dqDDpIm1SfzmGVobt37+oTfwVo4ym0vqBOT2DkQ
	TMmBrDGg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbm2D-00000004x8K-065h;
	Mon, 22 Jun 2026 21:18:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2D-00000004R5F-12Et;
	Mon, 22 Jun 2026 22:18:25 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v3 4/4] [DO NOT MERGE] ptp: ptp_vmclock: Add simulated 1PPS support
Date: Mon, 22 Jun 2026 21:36:21 +0100
Message-ID: <20260622211822.1056437-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622211822.1056437-1-dwmw2@infradead.org>
References: <20260622211822.1056437-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301199-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[enneenne.com,infradead.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:giometti@enneenne.com,m:dwmw2@infradead.org,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jstultz@google.com,m:tglx@kernel.org,m:sboyd@kernel.org,m:mlichvar@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:agordeev@linux.ibm.com,m:dwmw@amazon.co.uk,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,amazon.co.uk:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9437F6B2753

From: David Woodhouse <dwmw@amazon.co.uk>

Before the timekeeping_set_reference() work, the simplest way to
synchronise the kernel against vmclock was to simulate a 1PPS signal.
Restore that hack here, for testing CONFIG_NTP_PPS in NOHZ mode.

Set up an hrtimer to fire at each vmclock second boundary, and teach
vmclock_get_crosststamp() to return the cycle counter and the
corresponding { systime, monoraw } at the *start* of the current second,
because hardpps() expects the timestamps it is given for phase and
frequency adjustment to be the kernel's clock readings at the moment the
true time is at the top of a second (i.e. when the pulse arrives).

The timer feeds a PTP_CLOCK_PPSUSR event; with PTP_ENABLE_PPS, the PPS
source bound to the in-kernel hardpps() consumer and STA_PPSTIME/PPSFREQ
set, the kernel disciplines CLOCK_REALTIME directly from vmclock. The
second-boundary cycle is recovered from get_device_system_crosststamp()
using a history snapshot for interpolation.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 drivers/ptp/ptp_vmclock.c | 196 +++++++++++++++++++++++++++++++++++---
 1 file changed, 185 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index eebdcd5ebc08..1f56c29b3d6b 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -51,6 +52,10 @@ struct vmclock_state {
 	enum clocksource_ids cs_id, sys_cs_id;
 	int index;
 	char *name;
+	struct hrtimer pps_timer;
+	bool pps_enabled;
+	struct system_time_snapshot history_snap;
+	bool history_valid;
 };
 
 #define VMCLOCK_MAX_WAIT ms_to_ktime(100)
@@ -98,10 +103,13 @@ static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
 static int vmclock_get_crosststamp(struct vmclock_state *st,
 				   struct ptp_system_timestamp *sts,
 				   struct system_counterval_t *system_counter,
-				   struct timespec64 *tspec)
+				   struct timespec64 *tspec,
+				   bool on_second)
 {
 	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
 	uint64_t cycle, delta, seq, frac_sec;
+	uint64_t period_frac_sec;
+	uint8_t period_shift;
 
 #ifdef CONFIG_X86
 	/*
@@ -154,11 +162,46 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 
 		delta = cycle - le64_to_cpu(st->clk->counter_value);
 
+		period_frac_sec = le64_to_cpu(st->clk->counter_period_frac_sec);
+		period_shift = st->clk->counter_period_shift;
+
 		frac_sec = mul_u64_u64_shr_add_u64(&tspec->tv_sec, delta,
-						   le64_to_cpu(st->clk->counter_period_frac_sec),
-						   st->clk->counter_period_shift,
+						   period_frac_sec, period_shift,
 						   le64_to_cpu(st->clk->time_frac_sec));
-		tspec->tv_nsec = mul_u64_u64_shr(frac_sec, NSEC_PER_SEC, 64);
+
+		/* For simulated PPS, adjust to the most recent second boundary */
+		if (on_second) {
+			uint64_t delta_cycles;
+			int frac_shift, shift_remain;
+
+			if (tspec->tv_sec == 0)
+				return -EAGAIN;  /* No second boundary crossed yet */
+
+			/*
+			 * Roll the counter back to the top of the current second.
+			 * frac_sec == 0 means we are already exactly on the
+			 * boundary (and __builtin_clzll(0) is undefined).
+			 */
+			if (frac_sec) {
+				/* Shift frac_sec left until top bit is set */
+				frac_shift = __builtin_clzll(frac_sec);
+				frac_sec <<= frac_shift;
+
+				/* Shift period right by the remaining bits */
+				shift_remain = period_shift - frac_shift;
+				if (shift_remain > 0)
+					period_frac_sec >>= shift_remain;
+				else
+					frac_sec >>= -shift_remain;
+
+				delta_cycles = frac_sec / period_frac_sec;
+				cycle -= delta_cycles;
+			}
+			tspec->tv_nsec = 0;
+		} else {
+			tspec->tv_nsec = mul_u64_u64_shr(frac_sec, NSEC_PER_SEC, 64);
+		}
+
 		tspec->tv_sec += le64_to_cpu(st->clk->time_sec);
 
 		if (!tai_adjust(st->clk, &tspec->tv_sec))
@@ -193,7 +236,8 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 					    struct ptp_system_timestamp *sts,
 					    struct system_counterval_t *system_counter,
-					    struct timespec64 *tspec)
+					    struct timespec64 *tspec,
+					    bool on_second)
 {
 	struct pvclock_vcpu_time_info *pvti = this_cpu_pvti();
 	unsigned int pvti_ver;
@@ -204,7 +248,7 @@ static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 	do {
 		pvti_ver = pvclock_read_begin(pvti);
 
-		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec);
+		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec, on_second);
 		if (ret)
 			break;
 
@@ -240,10 +284,10 @@ static int ptp_vmclock_get_time_fn(ktime_t *device_time,
 #ifdef SUPPORT_KVMCLOCK
 	if (READ_ONCE(st->sys_cs_id) == CSID_X86_KVM_CLK)
 		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
-						       &tspec);
+						       &tspec, false);
 	else
 #endif
-		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec);
+		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec, false);
 
 	if (!ret)
 		*device_time = timespec64_to_ktime(tspec);
@@ -280,6 +324,98 @@ static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
 	return ret;
 }
 
+static int ptp_vmclock_get_time_fn_pps(ktime_t *device_time,
+				       struct system_counterval_t *system_counter,
+				       void *ctx)
+{
+	struct vmclock_state *st = ctx;
+	struct timespec64 tspec;
+	int ret;
+
+#ifdef SUPPORT_KVMCLOCK
+	if (st->history_valid && st->history_snap.cs_id == CSID_X86_KVM_CLK)
+		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
+						       &tspec, true);
+	else
+#endif
+		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec, true);
+
+	if (!ret)
+		*device_time = timespec64_to_ktime(tspec);
+
+	return ret;
+}
+
+/*
+ * Generate simulated PPS events for feeding __hardpps(), which expects to be
+ * given both CLOCK_REALTIME and CLOCK_MONOTONIC_RAW values for when a 1PPS
+ * signal actually happened (i.e. at the top of a second).
+ *
+ * vmclock_get_crosststamp(..., on_second=true) reads the vmclock and both
+ * system clocks from the same TSC value, then rolls the TSC back to the value
+ * it would have had at the start of the current second so the timestamps line
+ * up with a real pulse. The hrtimer reschedules itself for the top of the next
+ * second according to *vmclock*, not necessarily CLOCK_REALTIME.
+ */
+static enum hrtimer_restart ptp_vmclock_pps_timer(struct hrtimer *timer)
+{
+	struct vmclock_state *st = container_of(timer, struct vmclock_state, pps_timer);
+	struct system_device_crosststamp xtstamp = { .clock_id = CLOCK_REALTIME };
+	struct ptp_clock_event event;
+	ktime_t next, now_rt;
+	s64 delta_ns;
+	int ret;
+
+	if (!st->pps_enabled)
+		return HRTIMER_NORESTART;
+
+	/* Only report PPS if we have a valid history snapshot to interpolate from */
+	ret = -EINVAL;
+	if (st->history_valid) {
+		ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn_pps, st,
+						    &st->history_snap, &xtstamp);
+		if (!ret) {
+			event.type = PTP_CLOCK_PPSUSR;
+			event.pps_times.ts_real = ktime_to_timespec64(xtstamp.sys_systime);
+#ifdef CONFIG_NTP_PPS
+			event.pps_times.ts_raw = ktime_to_timespec64(xtstamp.sys_monoraw);
+#endif
+			ptp_clock_event(st->ptp_clock, &event);
+		}
+	}
+
+	/* Capture a snapshot to bound the next interpolation */
+	ktime_get_snapshot_id(CLOCK_REALTIME, &st->history_snap);
+	st->history_valid = true;
+
+	/*
+	 * Schedule the next timer for the top of the next second according to
+	 * vmclock. If we reported a PPS event, xtstamp.sys_systime is already
+	 * at the second boundary, so just add a second; otherwise read the
+	 * current vmclock time and work out when it next hits a boundary.
+	 */
+	if (!ret) {
+		next = ktime_add_ns(xtstamp.sys_systime, NSEC_PER_SEC);
+	} else {
+		struct timespec64 ts;
+
+		if (vmclock_get_crosststamp(st, NULL, NULL, &ts, false))
+			return HRTIMER_NORESTART;
+
+		delta_ns = NSEC_PER_SEC - ts.tv_nsec;
+		next = ktime_add_ns(st->history_snap.systime, delta_ns);
+	}
+
+	/* Never reschedule in the past, or the timer tight-loops */
+	now_rt = ktime_get_real();
+	if (ktime_compare(next, now_rt) <= 0)
+		next = ktime_add_ns(now_rt, NSEC_PER_SEC);
+
+	hrtimer_set_expires(timer, next);
+
+	return HRTIMER_RESTART;
+}
+
 /*
  * PTP clock operations
  */
@@ -306,12 +442,43 @@ static int ptp_vmclock_gettimex(struct ptp_clock_info *ptp, struct timespec64 *t
 	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
 						ptp_clock_info);
 
-	return vmclock_get_crosststamp(st, sts, NULL, ts);
+	return vmclock_get_crosststamp(st, sts, NULL, ts, false);
 }
 
 static int ptp_vmclock_enable(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on)
 {
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		st->pps_enabled = !!on;
+		if (on) {
+			struct timespec64 ts;
+			s64 delta_ns;
+
+			/* Snapshot to bound the first interpolation */
+			ktime_get_snapshot_id(CLOCK_REALTIME, &st->history_snap);
+			st->history_valid = true;
+
+			if (vmclock_get_crosststamp(st, NULL, NULL, &ts, false))
+				return -EIO;
+
+			/* When will vmclock next reach a second boundary? */
+			delta_ns = NSEC_PER_SEC - ts.tv_nsec;
+
+			hrtimer_start(&st->pps_timer,
+				      ktime_add_ns(st->history_snap.systime, delta_ns),
+				      HRTIMER_MODE_ABS);
+		} else {
+			hrtimer_cancel(&st->pps_timer);
+		}
+		return 0;
+	default:
+		break;
+	}
+
 	return -EOPNOTSUPP;
 }
 
@@ -320,7 +487,7 @@ static const struct ptp_clock_info ptp_vmclock_info = {
 	.max_adj	= 0,
 	.n_ext_ts	= 0,
 	.n_pins		= 0,
-	.pps		= 0,
+	.pps		= 1,
 	.adjfine	= ptp_vmclock_adjfine,
 	.adjtime	= ptp_vmclock_adjtime,
 	.gettimex64	= ptp_vmclock_gettimex,
@@ -356,6 +523,10 @@ static struct ptp_clock *vmclock_ptp_register(struct device *dev,
 	st->ptp_clock_info = ptp_vmclock_info;
 	strscpy(st->ptp_clock_info.name, st->name);
 
+	hrtimer_setup(&st->pps_timer, ptp_vmclock_pps_timer, CLOCK_REALTIME,
+		      HRTIMER_MODE_ABS);
+	st->pps_enabled = false;
+
 	return ptp_clock_register(&st->ptp_clock_info, dev);
 }
 
@@ -637,8 +808,11 @@ static void vmclock_remove(void *data)
 					   vmclock_acpi_notification_handler);
 #endif
 
-	if (st->ptp_clock)
+	if (st->ptp_clock) {
+		st->pps_enabled = false;
+		hrtimer_cancel(&st->pps_timer);
 		ptp_clock_unregister(st->ptp_clock);
+	}
 
 	if (st->miscdev.minor != MISC_DYNAMIC_MINOR)
 		misc_deregister(&st->miscdev);
-- 
2.54.0


