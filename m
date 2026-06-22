Return-Path: <netdev+bounces-301202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ywtdIcqmOWoKwAcAu9opvQ
	(envelope-from <netdev+bounces-301202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 768456B274B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:19:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b="c0Fdfd/C";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301202-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A016300B9EC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FB35A387;
	Mon, 22 Jun 2026 21:18:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993435DA68;
	Mon, 22 Jun 2026 21:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163135; cv=none; b=Z+5AoYFIiAplg3RLbVWeopqpU5WVPA/KmBv0b/0NnbCRm0Gdbpitp7Def65wowI5MuhHQG9KYSbOOKyvnfQrVqcO/cq8zgS0bbExuIBOsPWlNAfANlzU2TcMnplzLfDl1V1b2cg58FV8v9xIVowViAwKXQbnquhi1dcRQWv2iNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163135; c=relaxed/simple;
	bh=UDWIdd1TUol6dMX6zWpXmyd0xr31snyQDGhdtowSWGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crCTgqDh3HtZiD1kYSiK6Guve5E2+u2+NS7oYhtPa1rfhDeTSmgIPIEQv8MhpKhxJJdFvY0I4b7PhudjSSV1c1MOGdb9r2Zf+uC5Gcm+yHsLNAQ6yh7qwzOshAQdsdrS5lGgCAZvebcj/iMYzqiVp/CKf8uFE/RPe5+PZB1WYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c0Fdfd/C; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=I2qTUyviPYv8p6dVIJL6NSZELvogb65Re/m0Fr/IDco=; b=c0Fdfd/CcpPthRfTzVCKplez6A
	XArtTi0AVECmGJC4in1j3qU0YmdMBnGxRhFiE1LDGeiRt2BWNWXZIpIeQCUv+09wb89hrAbOZr0NZ
	4l/+/bnuGX78d/8rcBX0nAdUro1nXX++9Om29P9Ha6G5vhtmRJWUeCJ47kskFwbynrN5UyeaG6zPe
	dhjb1AOk1loLSy66q0P58/g68s3qkJb3fuisSU0wzrTD4OLfbHjvM4WFhKPfAllgm/831UDQeW2+Z
	RXm7AELkW2Cinws20Lby1TDUdU+ksreCt3duN9J0d543q6dte6El0CQD/iFGIMZsDrOsu7y1sbDYO
	mPPokf4w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2G-00000000KDt-0UMc;
	Mon, 22 Jun 2026 21:18:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2D-00000004R53-0PHy;
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
Subject: [RFC PATCH v3 1/4] timekeeping: Apply extrapolated ntp_error to clock snapshots
Date: Mon, 22 Jun 2026 21:36:18 +0100
Message-ID: <20260622211822.1056437-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622211822.1056437-1-dwmw2@infradead.org>
References: <20260622211822.1056437-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[enneenne.com,infradead.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.ibm.com];
	FORGED_SENDER(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:giometti@enneenne.com,m:dwmw2@infradead.org,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jstultz@google.com,m:tglx@kernel.org,m:sboyd@kernel.org,m:mlichvar@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:agordeev@linux.ibm.com,m:dwmw@amazon.co.uk,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,amazon.co.uk:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 768456B274B

From: David Woodhouse <dwmw@amazon.co.uk>

The time reported in ::systime of a system_time_snapshot is known to be
slightly inaccurate because of the way that the reported realtime clock
sawtooths around the *intended* time series, limited by the integer mult
value used to calculate the inter-tick times, and designed to ensure
smoothness and monotonicity for its consumers.

It is particularly inaccurate in a tickless kernel, where ntp_err_mult
is not adjusted on each tick, allowing the reported clock to diverge
from the intended time for a large number of ticks before re-converging.

This appears to be the reason why CONFIG_NTP_PPS is not enabled on
tickless kernels — because at that scale of precision, the realtime
snapshot at the time of the pulse bears little relation to the time the
kernel *actually* believes it to be, thus introducing random errors into
the PPS phase correction.

It would be better for callers of get_device_system_crosststamp() and
ktime_get_snapshot_id() to receive the *accurate* time, not the
sanitized version provided to gettimeofday().

Compute the deviation in snapshot_ntp_error() and add it to the returned
::systime so the snapshot lands on the ideal line. It sums four terms in
ns << NTP_SCALE_SHIFT before converting to signed ns:

  - tk->ntp_error, the deviation as of the last update;
  - (cycle_delta * ntp_err_frac), the fractional-mult drift accrued
    since then (cycle_delta is at most a tick on a tickful kernel, but
    many ticks' worth under NO_HZ);
  - (cycle_delta * ntp_err_mult), subtracting the applied +1 mult dither
    over the same span;
  - the sub-nanosecond fraction dropped when the read was truncated to
    whole ns (low shift bits, exact despite the multiply overflowing).

The helper uses the timekeeper selected for the requested clock id, so
all NTP-disciplined clocks are corrected, including the AUX clocks (each
has its own NTP instance); only CLOCK_MONOTONIC_RAW is undisciplined and
gets no correction. The residual is then a single clocksource cycle, the
same bound as a tickful kernel.

Note that this *unconditionally* changes the ::systime returned by all
snapshot and cross timestamp consumers (PTP SYS_OFFSET_PRECISE/EXTENDED,
etc.): it is now the ideal NTP-disciplined time rather than the raw
accumulated clock.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 include/linux/timekeeper_internal.h |  6 +++
 kernel/time/timekeeping.c           | 71 +++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index fb37a736ec1c..bc05d52a5f96 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -97,6 +97,11 @@ struct tk_read_base {
  * @ntp_error_shift:		Shift conversion between clock shifted nano seconds and
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
+ * @ntp_err_frac:		Fractional part of the per-cycle NTP-ideal mult that the
+ *				integer @mult truncates, as a fraction of 2^32 in
+ *				clock-shifted nanoseconds per cycle. Used to
+ *				extrapolate @ntp_error to an arbitrary cycle count in
+ *				the lockless snapshot readers (ktime_get_snapshot_id).
  * @cs_tick_adj:		Per-second adjustment handed to NTP via ntp_clear()
  *				accounting for the difference between the nominal
  *				NTP interval and the real time taken by the
@@ -187,6 +192,7 @@ struct timekeeper {
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
+	u64			ntp_err_frac;
 	s64			cs_tick_adj;
 	u32			skip_second_overflow;
 	s64			skew_delta;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index eb94ec99d503..1c989e5ebe84 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -422,6 +422,7 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 	tk->tkr_mono.mult = clock->mult;
 	tk->tkr_raw.mult = clock->mult;
 	tk->ntp_err_mult = 0;
+	tk->ntp_err_frac = 0;
 	tk->skip_second_overflow = 0;
 	tk->skew_delta = 0;
 
@@ -1226,6 +1227,51 @@ static inline u64 tk_clock_read_snapshot(const struct tk_read_base *tkr,
 	return clock->read(clock);
 }
 
+/*
+ * snapshot_ntp_error - record how far a snapshot's ::systime is from the
+ * ideal NTP-disciplined time at @now, in signed nanoseconds, so a caller
+ * can land exactly on the ideal line by adding it to ::systime.
+ *
+ * The value is summed in ns << NTP_SCALE_SHIFT from four parts:
+ *
+ *  - tk->ntp_error, the deviation accumulated as of the last timekeeping
+ *    update (tkr_mono.cycle_last);
+ *  - (cycle_delta * ntp_err_frac), the fractional-mult drift accrued over
+ *    the cycles read since then -- at most a tick on a tickful kernel, but
+ *    potentially many ticks' worth under NO_HZ;
+ *  - (cycle_delta * ntp_err_mult), subtracting the applied +1 mult dither
+ *    over the same span;
+ *  - the sub-nanosecond fraction that ::systime dropped when the read was
+ *    truncated to whole ns (the low @shift bits, exact even though the
+ *    multiply overflows).
+ *
+ * CLOCK_MONOTONIC_RAW is not NTP-disciplined and carries no error. Every
+ * other clock id uses its own timekeeper @tk -- including the AUX clocks,
+ * which each have their own NTP instance.
+ */
+static s64 snapshot_ntp_error(const struct timekeeper *tk, clockid_t clock_id,
+			      u64 now)
+{
+	u64 cycle_delta;
+	u32 nes;
+	s64 tmp, err;
+
+	if (clock_id == CLOCK_MONOTONIC_RAW)
+		return 0;
+
+	cycle_delta = (now - tk->tkr_mono.cycle_last) & tk->tkr_mono.mask;
+	nes = tk->ntp_error_shift;
+
+	err = tk->ntp_error;
+	err += ((s64)mul_u64_u64_shr(cycle_delta, tk->ntp_err_frac, 32) -
+		(s64)(cycle_delta * tk->ntp_err_mult)) << nes;
+
+	tmp = (s64)(cycle_delta * tk->tkr_mono.mult + tk->tkr_mono.xtime_nsec);
+	tmp &= (1ULL << tk->tkr_mono.shift) - 1;
+	err += tmp << nes;
+
+	return (err + (1LL << (NTP_SCALE_SHIFT - 1))) >> NTP_SCALE_SHIFT;
+}
 
 /**
  * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
@@ -1238,6 +1284,7 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
 {
 	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero = 0;
 	u64 nsec_raw, nsec_sys, now;
+	s64 ntp_error;
 	struct timekeeper *tk;
 	struct tk_data *tkd;
 	unsigned int seq;
@@ -1300,10 +1347,12 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
 
 		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
+
+		ntp_error = snapshot_ntp_error(tk, clock_id, now);
 	} while (read_seqcount_retry(&tkd->seq, seq));
 
 	systime_snapshot->cycles = now;
-	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys);
+	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys) + ntp_error;
 	systime_snapshot->monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*
@@ -1552,6 +1601,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 	unsigned int seq, clock_was_set_seq = 0;
 	ktime_t base_sys, base_raw, *offs;
 	u64 nsec_sys, nsec_raw;
+	s64 ntp_error;
 	u8 cs_was_changed_seq;
 	bool do_interp;
 	struct timekeeper *tk;
@@ -1617,9 +1667,10 @@ int get_device_system_crosststamp(int (*get_time_fn)
 
 		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
+		ntp_error = snapshot_ntp_error(tk, xtstamp->clock_id, cycles);
 	} while (read_seqcount_retry(&tkd->seq, seq));
 
-	xtstamp->sys_systime = ktime_add_ns(base_sys, nsec_sys);
+	xtstamp->sys_systime = ktime_add_ns(base_sys, nsec_sys) + ntp_error;
 	xtstamp->sys_monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*
@@ -2447,6 +2498,7 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
 	u64 ntp_tl = ntp_tick_length(tk->id);
 	s64 skew = ntp_get_skew_delta(tk->id);
+	u64 dividend;
 	u32 mult;
 
 	/*
@@ -2465,8 +2517,19 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 		 * scale it back up to the full per-tick rate for the mult bias.
 		 */
 		skew *= NTP_INTERVAL_FREQ;
-		mult = div64_u64((tk->ntp_tick + skew) >> tk->ntp_error_shift,
-				 tk->cycle_interval);
+		dividend = (tk->ntp_tick + skew) >> tk->ntp_error_shift;
+		mult = div64_u64(dividend, tk->cycle_interval);
+		/*
+		 * Stash the fractional part of the per-cycle ideal mult that
+		 * the integer @mult discards, scaled by 2^32, in clock-shifted
+		 * ns per cycle. The lockless snapshot readers use it to
+		 * extrapolate @ntp_error forward over the cycles accumulated
+		 * since the last tick (which on a NO_HZ kernel may be many
+		 * ticks' worth).
+		 */
+		tk->ntp_err_frac = div64_u64((dividend - (u64)mult *
+					      tk->cycle_interval) << 32,
+					     tk->cycle_interval);
 	}
 
 	/*
-- 
2.54.0


