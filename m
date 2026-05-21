Return-Path: <netdev+bounces-290589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGcPMYBQD2pEJAYAu9opvQ
	(envelope-from <netdev+bounces-290589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C65AB1AA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3473010C23
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDFC385D8A;
	Thu, 21 May 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P93BqW9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E731AF07;
	Thu, 21 May 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386774; cv=none; b=ttaem5hIBGcJPpK7KIiwgFyYoXqdOShW27SIo8LM5ZqOrvtyQxuPv0tkrvny9BEEPDDUdfdHjOTgTbFFofyBs66WfBs0ynP+pjNe0gvhBs1mzV8PiLn2GNRheomC4wl9zEFqQLTtv9pKEQAWOi9KGmztsvr6I8jPg/RizSpF+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386774; c=relaxed/simple;
	bh=WU8jiaEnhroW+bACAfT0zKuVitHmJoxzn31pR+WFdpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vb/20wUk4wJVcKp628vsa8bGCuLiLKhxetX1dKplw43rGBBwYaXGEKx1ZyslNkqRObOKNLyrOxQZ33iEWHhtz0sMx+5+Dep1DSWRjJ4X1mk50ht9CHWhOaYfWKo7p6RC/22uJd57bIUefgtQBUjJP3SELddBFhuxQe9gNXjKHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P93BqW9o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8EF1C1F000E9;
	Thu, 21 May 2026 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779386772;
	bh=LHeGWsl4LQXQ0CMAoJMq7Rs/94mc6QeEQSyrGsJxjtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P93BqW9oqg7QGKNY8KSrLJVhldJM6/r22aW8ljam++DlK0hTtUFwgX4A8yHejXvQa
	 8Pgna3r12raPzyq4SjkVj/1+W02QuivMXJ3mZ33qRRZceJ/WT62UcCw36khaRTPbM/
	 ZZzR2xt//xU7Ty6tuJrTJxlTl3iDZ95pWDZRGWd3aPPwnnE/mHMAhENbZsBbB1JxRI
	 LGmPph8tpcfDgtWH6WYZ4IJmomQ4Pgu+oLtt5GMO/9+1NP1axkaz8xkaC1U23Ve5qo
	 3mUC5PF2VoUH15OU/2d8HeNEncuptMpeRkqzYhsVMaUceMwOR9bIT7jp8fppFTXAJY
	 RGsdyYGGXS0Rw==
From: Thomas Gleixner <tglx@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Harshitha Ramamurthy
 <hramamurthy@google.com>, netdev@vger.kernel.org, Arthur Kiyanovski
 <akiyano@amazon.com>
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com,
 horms@kernel.org, jacob.e.keller@intel.com, yyd@google.com,
 jefrogers@google.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
In-Reply-To: <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com>
 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
Date: Thu, 21 May 2026 20:06:08 +0200
Message-ID: <87tss0vdrj.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290589-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E0C65AB1AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21 2026 at 12:43, David Woodhouse wrote:
> On Thu, 2026-05-14 at 22:58 +0000, Harshitha Ramamurthy wrote:
>> +	if (IS_ENABLED(CONFIG_X86))
>> +		return system_clock_source == CSID_X86_TSC;
>> +	else if (IS_ENABLED(CONFIG_ARM64))
>> +		return system_clock_source == CSID_ARM_ARCH_COUNTER;
>> +
>> +	return false;
>
> Strictly, you could manage to convert to CSID_X86_KVM_CLK here too. The
> x86 kvm_arch_ptp_get_crosststamp() for ptp_kvm does so unconditionally.
>
> For ptp_vmclock we support both; we do the conversion only if the cs_id
> in the snapshot *is* the KVM clock, which seemed a bit more reasonable.
>
> And here you add a third variant which *only* copes with CSID_X86_TSC,
> to complete the set of possibilities :)

Yeah, let's sprinkle that all over the tree so nobody can figure out a
coherent picture anymore. :)

> With PTM and the various virt enlightenments, there are an increasing
> number of "PTP" clocks which literally *just* tell us a cycle count at
> the moment of the corresponding reading, and we don't need the ABA
> sandwich of local clock readings around it any more.

That's what the PRECISE ioctl and ptp::info::getcrosstimestamp() is for,
which utilizes get_device_system_crosststamp() and provides the
translation from PTM, on x86 that's ART which is converted to TSC.

It then correlates the converted system time stamp to CLOCK_REALTIME and
CLOCK_MONOTONIC_RAW.

That has been implemented long ago exactly for that purpose, but people
need to reinvent the wheel over and over just because it makes the
kernel so more maintainable.

> I've got another one waiting in the wings which will literally just
> latch the counter value when a PPS signal comes in, too.

That can use a similar mechanism.

> It might be good to harmonise the way we convert to KVM clock if we're
> going to support that (although I'll accept an argument that any guest
> which chooses to use the KVM clock doesn't *deserve* to have accurate
> timekeeping).

:)

> I'd also like consensus on exposing it to userspace. I think Thomas is
> going to suggest that we should always convert to MONOTONIC_RAW, but
> what I asked Arthur to do in 
> https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazon.com/
> exposes the raw counter values instead.

I'm not against that per se, but that really wants to be a consistent
snapshot and not some pulled out of thin air cycles value.

ktime_get_snapshot() provides that already today, so that can be
arguably used for pre/post timestamp mechanisms, except that it lacks
support for AUX clocks.

get_device_system_crosststamp() does not provide cycles and clock id,
but that's not rocket science to extend.

> From the dedicating hosting point of view, we *only* care about the
> counter, and absolutely DGAF about the host's timekeeping. Migrating
> KVM guests requires getting the guest TSC right (in terms of scaling
> factors and offset from the host TSC), and feeding accurate time to
> guests is done in terms of the guest TSC to realtime relationship.

The offset has nothing to do with the scaling. It's the delta to the TSC
value which the migrated guest saw last when it was packed up for
migration.

The scaling is not required to be cycles based either. You need to know
the frequency ratio of the guest TSC to the new host TSC. cycles are not
telling you that. So you need extra information from the previous host,
i.e. the assumed raw TSC frequency of the guest plus the steered
frequency in your virtual PCH interface.

So sure you can utilize the raw counter values for that, but you can do
the same with CLOCK_MONOTONIC_RAW by exposing the mult/shift factor
which the guest keeps unmodified after boot or a frequency value derived
from that. That's IMO way more sensible than measuring it somehow and
the shift/mult conversion inaccuracy you mentioned is laughable TBH. TSC
usually ends up with a shift value of 24, so the conversion loss of the
TSC to CLOCK_MONOTONIC_RAW is +/- 1ns, which is totally irrelevant in
the larger picture.

> So our ideal state is that we discipline the TSC against real time in
> userspace, and enabling those PHC drivers to *give* us the raw cycle
> counts that they actually measured seemed best.

As I said, I'm not against that per se, but then we want to provide
interfaces which are generic enough so they can be used for your
purposes, but also for the requirements of chrony et al. Looking at the
patch you linked to above:

> +static long ptp_sys_offset_precise_attrs(struct ptp_clock *ptp, void __user *arg)
> +{
> +	struct ptp_sys_offset_precise_attrs precise_offset_attrs;
> +	struct system_device_crosststamp xtstamp;
> +	struct ptp_clock_attributes att = {};
> +	struct timespec64 ts;
> +	int err;
> +
> +	if (!ptp->info->getcrosststampattrs)
> +		return -EOPNOTSUPP;
> +
> +	err = ptp->info->getcrosststampattrs(ptp->info, &xtstamp, &att);
> +	if (err)
> +		return err;
> +
> +	memset(&precise_offset_attrs, 0, sizeof(precise_offset_attrs));
> +	ts = ktime_to_timespec64(xtstamp.device);
> +	precise_offset_attrs.device.pct.sec = ts.tv_sec;
> +	precise_offset_attrs.device.pct.nsec = ts.tv_nsec;
> +	precise_offset_attrs.device.att.error_bound = att.error_bound;
> +	precise_offset_attrs.device.att.timescale = att.timescale;
> +	precise_offset_attrs.device.att.status = att.status;
> +	precise_offset_attrs.device.att.counter_id = att.counter_id;
> +	precise_offset_attrs.device.att.counter_value = att.counter_value;

That's exactly the hackery which is counterproductive. Why?

Where does ptp::info::getcrosststampattrs() retrieve the system counter
value from?

Either it has to convert from the ART based timestamp to TSC magically
by circumventing the core code or it has to use get_cycles() separately
which defeats the whole purpose of a hardware latched combo timestamp.

While this:

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index aee2c1a46e47..43a55f618235 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -296,19 +296,6 @@ struct system_time_snapshot {
 	u8			cs_was_changed_seq;
 };
 
-/**
- * struct system_device_crosststamp - system/device cross-timestamp
- *				      (synchronized capture)
- * @device:		Device time
- * @sys_realtime:	Realtime simultaneous with device time
- * @sys_monoraw:	Monotonic raw simultaneous with device time
- */
-struct system_device_crosststamp {
-	ktime_t device;
-	ktime_t sys_realtime;
-	ktime_t sys_monoraw;
-};
-
 /**
  * struct system_counterval_t - system counter value with the ID of the
  *				corresponding clocksource
@@ -325,6 +312,21 @@ struct system_counterval_t {
 	bool			use_nsecs;
 };
 
+/**
+ * struct system_device_crosststamp - system/device cross-timestamp
+ *				      (synchronized capture)
+ * @device:		Device time
+ * @sys_counter:	Clocksource counter value simultaneous with device time
+ * @sys_realtime:	Realtime simultaneous with device time
+ * @sys_monoraw:	Monotonic raw simultaneous with device time
+ */
+struct system_device_crosststamp {
+	ktime_t				device;
+	struct system_counterval_t	sys_counter;
+	ktime_t				sys_realtime;
+	ktime_t				sys_monoraw;
+};
+
 extern bool ktime_real_to_base_clock(ktime_t treal,
 				     enum clocksource_ids base_id, u64 *cycles);
 extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c493a4010305..11df7e25bdca 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1506,6 +1506,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
+	xtstamp->sys_counter = system_counterval;
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
 	xtstamp->sys_monoraw = ktime_add_ns(base_raw, nsec_raw);
 
Provides the information coherently and without any extra hacks. No?

Extending get_device_system_crosststamp() for AUX clocks is on my todo
list for a long time, but I did not come around to it yet. It's not
really complicated to make that work.

The actual ena_phc_gettimexattrs64() implementation does not provide the
counter value at all despite the fact that it could trivially do so with
a modified ktime_get_snapshot() except for AUX clock IDs, but that's a
solvable problem. See uncompiled PoC below.

I really have to ask why we put a lot of effort into consolidated
infrastructure, when every drivers/foo/ subsystem decides it needs it's
own absymal hacks just because sitting down and extending the generic
infrastructure is asked too much. TBH, that's frustrating as hell and
no, none of these usecases is so special that it would justify a single
one of these hacks.

> Could we do that all on MONOTONIC_RAW, if Thomas insists? Maybe...
> although I like the model of disciplining one *specific* counter, and
> then telling the kernel about *that* counter. If the kernel for some
> reason has randomly switched to the HPET then the kernel is free to
> ignore what we're telling it about the TSC.

Well, if the kernel has switched to HPET for timekeeping, then there is
a good reason especially with the reworked clocksource watchdog, which
is not longer being stupid under load and on big machines. If the
sysadmin thinks it's cool to switch to HPET, then he can keep the
pieces. In those cases the machine has other problems than taming the
TSC for guests....

Thanks,

        tglx
---
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -276,19 +276,24 @@ static inline bool ktime_get_aux_ts64(cl
 #endif
 
 /**
- * struct system_time_snapshot - simultaneous raw/real time capture with
+ * struct system_time_snapshot - simultaneous raw/CLOCK_REALTIME or CLOCK_AUX$N time capture with
  *				 counter value
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
+ * @aux:	Auxiliary system time if selected in ktime_get_snapshot_id()
  * @boot:	Boot time
  * @raw:	Monotonic raw system time
  * @cs_id:	Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
+ * @clock_valid:	The clock is valid
  */
 struct system_time_snapshot {
 	u64			cycles;
-	ktime_t			real;
+	union {
+		ktime_t		real;
+		ktime_t		aux;
+	};
 	ktime_t			boot;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -67,6 +67,7 @@ static inline bool tk_is_aux(const struc
 {
 	return tk->id >= TIMEKEEPER_AUX_FIRST && tk->id <= TIMEKEEPER_AUX_LAST;
 }
+static inline struct tk_data *aux_get_tk_data(clockid_t id);
 #else
 static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
 {
@@ -77,6 +78,10 @@ static inline bool tk_is_aux(const struc
 {
 	return false;
 }
+static inline struct tk_data *aux_get_tk_data(clockid_t id)
+{
+	return NULL;
+}
 #endif
 
 static inline void tk_update_aux_offs(struct timekeeper *tk, ktime_t offs)
@@ -1183,15 +1188,18 @@ noinstr time64_t __ktime_get_real_second
 }
 
 /**
- * ktime_get_snapshot - snapshots the realtime/monotonic raw clocks with counter
+ * ktime_get_snapshot_id - snapshots the monotonic raw clock, the selected clock and the counter
  * @systime_snapshot:	pointer to struct receiving the system time snapshot
+ * @clock_id:		The clock ID to snapshot
  */
-void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
+bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clockid_t clock_id)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk;
+	struct tk_data *tkd;
 	unsigned int seq;
 	ktime_t base_raw;
 	ktime_t base_real;
+	ktime_t base_mono;
 	ktime_t base_boot;
 	u64 nsec_raw;
 	u64 nsec_real;
@@ -1199,27 +1207,56 @@ void ktime_get_snapshot(struct system_ti
 
 	WARN_ON_ONCE(timekeeping_suspended);
 
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+		tkd = &tk_core;
+		break;
+	case CLOCK_AUX ... CLOCK_AUX_LAST: {
+		tkd = aux_get_tk_data(clock_id);
+		if (!tkd)
+			return false;
+		break;
+	}
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	tk = &tkd->timekeeper;
+
 	do {
-		seq = read_seqcount_begin(&tk_core.seq);
+		seq = read_seqcount_begin(&tkd->seq);
+
+		/* Aux clocks can be invalid */
+		if (!tk->clock_valid)
+			return false;
+
 		now = tk_clock_read(&tk->tkr_mono);
 		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
 		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
-		base_real = ktime_add(tk->tkr_mono.base,
-				      tk_core.timekeeper.offs_real);
-		base_boot = ktime_add(tk->tkr_mono.base,
-				      tk_core.timekeeper.offs_boot);
+		base_mono = tk->tkr_mono.base;
+		if (clock_id == CLOCK_REALTIME) {
+			base_real = ktime_add(base_mono, tk_core.timekeeper.offs_real);
+			base_boot = ktime_add(base_mono, tk_core.timekeeper.offs_boot);
+		}
 		base_raw = tk->tkr_raw.base;
 		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw  = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
-	} while (read_seqcount_retry(&tk_core.seq, seq));
+	} while (read_seqcount_retry(&tkd->seq, seq));
 
 	systime_snapshot->cycles = now;
-	systime_snapshot->real = ktime_add_ns(base_real, nsec_real);
-	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_real);
+	if (clock_id == CLOCK_REALTIME) {
+		systime_snapshot->real = ktime_add_ns(base_real, nsec_real);
+		systime_snapshot->boot = ktime_add_ns(base_boot, nsec_real);
+	} else {
+		systime_snapshot->aux = ktime_add_ns(base_mono, nsec_real);
+		systime_snapshot->boot = 0;
+	}
 	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
+	return true;
 }
-EXPORT_SYMBOL_GPL(ktime_get_snapshot);
+EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);
 
 /* Scale base by mult/div checking for overflow */
 static int scale64_check_overflow(u64 mult, u64 div, u64 *base)




