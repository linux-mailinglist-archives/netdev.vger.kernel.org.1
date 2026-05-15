Return-Path: <netdev+bounces-288371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BbkLq5OB2p3xwIAu9opvQ
	(envelope-from <netdev+bounces-288371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:49:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD6553FC4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4FF305CFB1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEB3D3311;
	Fri, 15 May 2026 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DEym8JwE"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1273CC334;
	Fri, 15 May 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863272; cv=none; b=GVbZV2wC5n3QtRmxPJmCZLJMictqPyk0nL17jPP3ihyy992XUjgwlR9JRFwTw/KCnH5FahR4x8LBORXpMVtJQKs+dC9HRk8hsFozb5SXVALXHgfofGZwz5Qmm/eVV0lx7wKBi838Lt/jcBYTHA+agD52tnPzjz8WUt76mRqOnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863272; c=relaxed/simple;
	bh=vImMas7nAaxanTtTahmuIv56lew5cvSxOjirUAlWHBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQvEy94CIdqHa4DkhLgdeP/PhMvovzLsgxIHQb8tLZ+BUWb4+J5ha+TGZHNN3w5REjDl8y9yq5qnWYNXvyCk07f6SHFnVC56P/ygYzUXc0bWEj8OtGjiXrJlFRWHcbbFm20Whgt4x4/NJKaZsSkQyxQEP2MxOWMTO7Q5yOvJ0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DEym8JwE; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778863268; x=1810399268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tMvWIVTLhN2Lmwx0VqbiViodsvxVyi+xH0xabeAZW3I=;
  b=DEym8JwEbljVHhCIQEKyqfWlxP7va5g1fELy3mpCSTP4Ag4nkt6ln5G/
   FcCwbEqa0TbmYrobeH9AFBAIw9JRcpGnSNP0KxkSaOwOqB7msmGS2Syhl
   3UNaVGkRkZ5cZOltyVlQx7WSGuKjaPzMjROZf8vyIsW6Ca0F1XHCTeIvp
   QOXFiP1jNjq9xkXZw/sfyeMnu7LUmyjKfsPR8CWCFNGx8T0g1JYflKrDI
   SGRusGitKKo4dszOIen9ivWqmpKtypB2/T/WJm4HDL2x64lHNjXyg5xfA
   1K1yAJkpY8IRMBra1eobei8nK3Fw6GyGuZ80JsFKUQMRakQ7GxhbGb7/4
   A==;
X-CSE-ConnectionGUID: NIvu0USFR1a58Zn2JOOKdQ==
X-CSE-MsgGUID: R17zrjI0T4OTXAGlY3gtew==
X-IronPort-AV: E=Sophos;i="6.23,236,1770595200"; 
   d="scan'208";a="19252796"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:41:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:14148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.132:2525] with esmtp (Farcaster)
 id 86cf66c2-f5d1-4d8d-943e-bee9716bcb9b; Fri, 15 May 2026 16:41:03 +0000 (UTC)
X-Farcaster-Flow-ID: 86cf66c2-f5d1-4d8d-943e-bee9716bcb9b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:41:00 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:40:55 +0000
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
Subject: [PATCH v3 net-next 1/7] ptp: Add ioctls for PHC timestamps with quality attributes
Date: Fri, 15 May 2026 16:40:21 +0000
Message-ID: <20260515164033.6403-2-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515164033.6403-1-akiyano@amazon.com>
References: <20260515164033.6403-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: BEBD6553FC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288371-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Introduce two new ioctls that extend existing PTP timestamp interfaces
with clock quality information:

- PTP_SYS_OFFSET_EXTENDED_ATTRS: Extends PTP_SYS_OFFSET_EXTENDED
- PTP_SYS_OFFSET_PRECISE_ATTRS: Extends PTP_SYS_OFFSET_PRECISE

These ioctls provide quality attributes alongside timestamps:

1. error_bound: Maximum deviation from true time (nanoseconds), based
   on device's internal clock state
2. clock_status: Synchronization state (unknown, initializing,
   synchronized, free-running, unreliable)
3. timescale: Time reference (TAI, UTC, etc.)
4. counter_value: Raw hardware counter (e.g. TSC ticks) at the time of
   the PHC reading, for feed-forward calibration use cases
5. counter_id: Identifies the hardware counter type (enum ptp_counter_id)

This supports three use cases:

1. Managed PHC devices (e.g., ENA, vmclock) that maintain their own
   synchronization and can report quality metrics directly to userspace
   without requiring ptp4l

2. Applications that need complete time quality information in a single
   call, regardless of how the PHC is synchronized

3. VMMs that need raw hardware counter values paired
   with PTP timestamps for feed-forward clock calibration, avoiding the
   feedback loop inherent in NTP-style synchronization

Timescale definitions use a Continuity/Discipline framework to describe
timeline properties and steering behavior consistently across all
entries.

This implementation is based on the RFC discussion linked below.

Link: https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon.com/
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/ptp/ptp_chardev.c        | 130 ++++++++++++++++--
 drivers/ptp/ptp_clock.c          |   4 +-
 include/linux/ptp_clock_kernel.h |  30 +++++
 include/uapi/linux/ptp_clock.h   | 225 ++++++++++++++++++++++++++++++-
 4 files changed, 374 insertions(+), 15 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index c61cf9e..1898775 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -190,6 +190,8 @@ static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
 		.cross_timestamping	= ptp->info->getcrosststamp != NULL,
 		.adjust_phase		= ptp->info->adjphase != NULL &&
 					  ptp->info->getmaxphase != NULL,
+		.clock_attrs		= ptp->info->gettimexattrs64 ||
+					  ptp->info->getcrosststampattrs,
 	};
 
 	if (caps.adjust_phase)
@@ -343,15 +345,69 @@ static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg,
 	return copy_to_user(arg, &precise_offset, sizeof(precise_offset)) ? -EFAULT : 0;
 }
 
+static long ptp_sys_offset_precise_attrs(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset_precise_attrs precise_offset_attrs;
+	struct system_device_crosststamp xtstamp;
+	struct ptp_clock_attributes att = {};
+	struct timespec64 ts;
+	int err;
+
+	if (!ptp->info->getcrosststampattrs)
+		return -EOPNOTSUPP;
+
+	err = ptp->info->getcrosststampattrs(ptp->info, &xtstamp, &att);
+	if (err)
+		return err;
+
+	memset(&precise_offset_attrs, 0, sizeof(precise_offset_attrs));
+	ts = ktime_to_timespec64(xtstamp.device);
+	precise_offset_attrs.device.pct.sec = ts.tv_sec;
+	precise_offset_attrs.device.pct.nsec = ts.tv_nsec;
+	precise_offset_attrs.device.att.error_bound = att.error_bound;
+	precise_offset_attrs.device.att.timescale = att.timescale;
+	precise_offset_attrs.device.att.status = att.status;
+	precise_offset_attrs.device.att.counter_id = att.counter_id;
+	precise_offset_attrs.device.att.counter_value = att.counter_value;
+
+	ts = ktime_to_timespec64(xtstamp.sys_realtime);
+	precise_offset_attrs.sys_realtime.sec = ts.tv_sec;
+	precise_offset_attrs.sys_realtime.nsec = ts.tv_nsec;
+
+	ts = ktime_to_timespec64(xtstamp.sys_monoraw);
+	precise_offset_attrs.sys_monoraw.sec = ts.tv_sec;
+	precise_offset_attrs.sys_monoraw.nsec = ts.tv_nsec;
+
+	return copy_to_user(arg, &precise_offset_attrs,
+			    sizeof(precise_offset_attrs)) ? -EFAULT : 0;
+}
+
 typedef int (*ptp_gettimex_fn)(struct ptp_clock_info *,
 			       struct timespec64 *,
 			       struct ptp_system_timestamp *);
 
+static int ptp_validate_sys_offset_clockid(__kernel_clockid_t clockid)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		return 0;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+			return 0;
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+}
+
 static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 				    ptp_gettimex_fn gettimex_fn)
 {
 	struct ptp_sys_offset_extended *extoff __free(kfree) = NULL;
 	struct ptp_system_timestamp sts;
+	int err;
 
 	if (!gettimex_fn)
 		return -EOPNOTSUPP;
@@ -363,23 +419,13 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 	if (extoff->n_samples > PTP_MAX_SAMPLES || extoff->rsv[0] || extoff->rsv[1])
 		return -EINVAL;
 
-	switch (extoff->clockid) {
-	case CLOCK_REALTIME:
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		break;
-	case CLOCK_AUX ... CLOCK_AUX_LAST:
-		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
-			break;
-		fallthrough;
-	default:
-		return -EINVAL;
-	}
+	err = ptp_validate_sys_offset_clockid(extoff->clockid);
+	if (err)
+		return err;
 
 	sts.clockid = extoff->clockid;
 	for (unsigned int i = 0; i < extoff->n_samples; i++) {
 		struct timespec64 ts;
-		int err;
 
 		err = gettimex_fn(ptp->info, &ts, &sts);
 		if (err)
@@ -400,6 +446,58 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 	return copy_to_user(arg, extoff, sizeof(*extoff)) ? -EFAULT : 0;
 }
 
+static long ptp_sys_offset_extended_attrs(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset_extended_attrs *extoffattrs __free(kfree) = NULL;
+	struct ptp_clock_attributes att = {};
+	struct ptp_system_timestamp sts;
+	int err;
+
+	if (!ptp->info->gettimexattrs64)
+		return -EOPNOTSUPP;
+
+	extoffattrs = memdup_user(arg, sizeof(*extoffattrs));
+	if (IS_ERR(extoffattrs))
+		return PTR_ERR(extoffattrs);
+
+	if (extoffattrs->n_samples > PTP_MAX_SAMPLES ||
+	    extoffattrs->rsv[0] ||
+	    extoffattrs->rsv[1])
+		return -EINVAL;
+
+	err = ptp_validate_sys_offset_clockid(extoffattrs->clockid);
+	if (err)
+		return err;
+
+	sts.clockid = extoffattrs->clockid;
+	memset(extoffattrs->ts, 0, sizeof(extoffattrs->ts));
+	for (unsigned int i = 0; i < extoffattrs->n_samples; i++) {
+		struct timespec64 ts;
+
+		err = ptp->info->gettimexattrs64(ptp->info, &ts, &sts, &att);
+		if (err)
+			return err;
+
+		/* Filter out disabled or unavailable clocks */
+		if (sts.pre_ts.tv_sec < 0 || sts.post_ts.tv_sec < 0)
+			return -EINVAL;
+
+		extoffattrs->ts[i][0].pct.sec = sts.pre_ts.tv_sec;
+		extoffattrs->ts[i][0].pct.nsec = sts.pre_ts.tv_nsec;
+		extoffattrs->ts[i][1].pct.sec = ts.tv_sec;
+		extoffattrs->ts[i][1].pct.nsec = ts.tv_nsec;
+		extoffattrs->ts[i][1].att.error_bound = att.error_bound;
+		extoffattrs->ts[i][1].att.timescale = att.timescale;
+		extoffattrs->ts[i][1].att.status = att.status;
+		extoffattrs->ts[i][1].att.counter_id = att.counter_id;
+		extoffattrs->ts[i][1].att.counter_value = att.counter_value;
+		extoffattrs->ts[i][2].pct.sec = sts.post_ts.tv_sec;
+		extoffattrs->ts[i][2].pct.nsec = sts.post_ts.tv_nsec;
+	}
+
+	return copy_to_user(arg, extoffattrs, sizeof(*extoffattrs)) ? -EFAULT : 0;
+}
+
 static long ptp_sys_offset(struct ptp_clock *ptp, void __user *arg)
 {
 	struct ptp_sys_offset *sysoff __free(kfree) = NULL;
@@ -535,11 +633,17 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 		return ptp_sys_offset_precise(ptp, argptr,
 					      ptp->info->getcrosststamp);
 
+	case PTP_SYS_OFFSET_PRECISE_ATTRS:
+		return ptp_sys_offset_precise_attrs(ptp, argptr);
+
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:
 		return ptp_sys_offset_extended(ptp, argptr,
 					       ptp->info->gettimex64);
 
+	case PTP_SYS_OFFSET_EXTENDED_ATTRS:
+		return ptp_sys_offset_extended_attrs(ptp, argptr);
+
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
 		return ptp_sys_offset(ptp, argptr);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d6f54cc..849aef8 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -112,7 +112,9 @@ static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *tp)
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	int err;
 
-	if (ptp->info->gettimex64)
+	if (ptp->info->gettimexattrs64)
+		err = ptp->info->gettimexattrs64(ptp->info, tp, NULL, NULL);
+	else if (ptp->info->gettimex64)
 		err = ptp->info->gettimex64(ptp->info, tp, NULL);
 	else
 		err = ptp->info->gettime64(ptp->info, tp);
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 8843645..489e21b 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -122,11 +122,34 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimexattrs64:  Reads the current time from the hardware clock and
+ *                    optionally also the system clock with additional clock
+ *                    attributes.
+ *                    parameter ts: Holds the PHC timestamp.
+ *                    parameter sts: If not NULL, it holds a pair of
+ *                    timestamps from the system clock. The first reading is
+ *                    made right before reading the lowest bits of the PHC
+ *                    timestamp and the second reading immediately follows that.
+ *                    parameter att: If not NULL, it holds the maximum error
+ *                    bound for the returned PHC timestamp in nanoseconds,
+ *                    the timescale for the returned PHC timestamp and the
+ *                    clock's qualitative synchronization status.
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
  *                   where system time is realtime and monotonic.
  *
+ * @getcrosststampattrs:  Reads the current time from the hardware clock and
+ *                        system clock simultaneously with additional data on
+ *                        hardware clock accuracy and reliability.
+ *                        parameter cts: Contains timestamp (device,system)
+ *                        pair, where system time is realtime and monotonic.
+ *                        parameter att: If not NULL, it holds the maximum error
+ *                        bound for the returned PHC timestamp in nanoseconds,
+ *                        the timescale for the returned PHC timestamp and the
+ *                        clock's qualitative synchronization status.
+ *
  * @settime64:  Set the current time on the hardware clock.
  *              parameter ts: Time value to set.
  *
@@ -208,8 +231,15 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimexattrs64)(struct ptp_clock_info *ptp,
+			       struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts,
+			       struct ptp_clock_attributes *att);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
+	int (*getcrosststampattrs)(struct ptp_clock_info *ptp,
+				   struct system_device_crosststamp *cts,
+				   struct ptp_clock_attributes *att);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
 	int (*getcycles64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*getcyclesx64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 46d45f9..83dc668 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -79,6 +79,137 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+/*
+ * Clock status values for struct ptp_clock_attributes.status
+ */
+enum ptp_clock_status {
+	/* Clock synchronization status cannot be reliably determined */
+	PTP_CLOCK_STATUS_UNKNOWN      = 0,
+
+	/* Clock is acquiring synchronization */
+	PTP_CLOCK_STATUS_INITIALIZING = 1,
+
+	/* Clock is synchronized and maintained accurately by the device */
+	PTP_CLOCK_STATUS_SYNCED       = 2,
+
+	/* Clock is drifting but remains within acceptable error bounds */
+	PTP_CLOCK_STATUS_HOLDOVER     = 3,
+
+	/* Clock is drifting without adjustments or synchronization */
+	PTP_CLOCK_STATUS_FREE_RUNNING = 4,
+
+	/* Clock is unreliable, the error_bound value cannot be trusted */
+	PTP_CLOCK_STATUS_UNRELIABLE   = 5
+};
+
+/*
+ * Clock timescale values for struct ptp_clock_attributes.timescale.
+ *
+ * These definitions describe the mathematical properties and reference
+ * epochs of the timescale provided by the PHC.
+ *
+ * Discipline: Describes the frequency/phase steering behavior.
+ * Continuity: Describes whether the timeline is uninterrupted.
+ */
+enum ptp_clock_timescale {
+	/* Unknown or unspecified timescale */
+	PTP_TIMESCALE_UNKNOWN = 0,
+
+	/********************* Absolute Atomic Timescales *********************
+	 * These timescales are continuous, monotonic standards based on atomic
+	 * physics. They do not experience phase jumps.
+	 **********************************************************************/
+
+	/**
+	 * International Atomic Time (TAI)
+	 * Epoch: 1958-01-01 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Primary atomic reference; no phase jumps.
+	 */
+	PTP_TIMESCALE_TAI = 1,
+
+	/**
+	 * Terrestrial Time (TT)
+	 * Epoch: 1958-01-01 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Defined as TAI + 32.184s constant offset.
+	 */
+	PTP_TIMESCALE_TT = 2,
+
+	/**
+	 * Global Positioning System (GPS) Time
+	 * Epoch: 1980-01-06 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Defined by the GPS constellation; fixed offset from TAI.
+	 */
+	PTP_TIMESCALE_GPS = 3,
+
+	/****************** UTC-Based Timescales (Civil Time) *****************
+	 * These timescales are derived from TAI but adjusted to align with
+	 * the Earth's rotation, primarily through leap seconds.
+	 **********************************************************************/
+
+	/**
+	 * Coordinated Universal Time (UTC) - Wall-clock (CLOCK_REALTIME)
+	 * Epoch: 1970-01-01 00:00:00 (Unix epoch).
+	 * Continuity: Discontinuous; subject to 1-second leap second
+	 *             phase jumps.
+	 * Discipline: Frequency steered; incorporates leap second corrections.
+	 *
+	 * Note: Leap-smeared UTC MUST NOT be advertised as PTP_TIMESCALE_UTC.
+	 * Smear algorithms are not standardized and the resulting timescale
+	 * is ambiguous. Implementations using smeared UTC MUST advertise
+	 * PTP_TIMESCALE_UNKNOWN or PTP_TIMESCALE_PROPRIETARY instead.
+	 */
+	PTP_TIMESCALE_UTC = 4,
+
+	/**
+	 * POSIX Time (Unix Time)
+	 * Epoch: 1970-01-01 00:00:00.
+	 * Continuity: Discontinuous; leap seconds handled by
+	 *             repeating/skipping values.
+	 * Discipline: Follows UTC frequency steering and phase jumps.
+	 */
+	PTP_TIMESCALE_POSIX = 5,
+
+	/****************** System-Relative Monotonic Clocks ******************
+	 * These timescales are relative to a system event (like boot)
+	 * and are not synchronized to an external atomic standard.
+	 **********************************************************************/
+
+	/**
+	 * Monotonic System Clock (CLOCK_MONOTONIC)
+	 * Epoch: Arbitrary (System boot time).
+	 * Continuity: Strictly monotonic; no leap seconds.
+	 * Discipline: Frequency steered to match system reference;
+	 *             does not advance during suspend.
+	 */
+	PTP_TIMESCALE_MONOTONIC = 6,
+
+	/**
+	 * Raw Monotonic System Clock (CLOCK_MONOTONIC_RAW)
+	 * Epoch: Arbitrary (System boot time).
+	 * Continuity: Strictly monotonic; no leap seconds.
+	 * Discipline: Raw hardware oscillator; no frequency steering
+	 *             or discipline.
+	 */
+	PTP_TIMESCALE_MONOTONIC_RAW = 7,
+
+	/**
+	 * Boot Time System Clock (CLOCK_BOOTTIME)
+	 * Epoch: Arbitrary (System boot time).
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Frequency steered to match system reference;
+	 *             advances during suspend.
+	 */
+	PTP_TIMESCALE_BOOTTIME = 8,
+
+	/********************** Vendor-Specific Timescale *********************/
+
+	/* A proprietary or vendor-specific timescale with custom rules. */
+	PTP_TIMESCALE_PROPRIETARY = 9,
+};
+
 /*
  * struct ptp_clock_time - represents a time value
  *
@@ -94,6 +225,61 @@ struct ptp_clock_time {
 	__u32 reserved;
 };
 
+/*
+ * Hardware counter identifiers for struct ptp_clock_attributes.counter_id
+ */
+enum ptp_counter_id {
+	/* Counter value not available or type not specified */
+	PTP_COUNTER_UNKNOWN = 0,
+
+	/* x86 Time Stamp Counter (TSC) */
+	PTP_COUNTER_X86_TSC = 1,
+
+	/* ARM Generic Timer virtual counter */
+	PTP_COUNTER_ARM_ARCH = 2,
+};
+
+/*
+ * struct ptp_clock_attributes - describes additional data for a PTP clock
+ *                               timestamp
+ *
+ * @error_bound:   The maximum possible error (in nanoseconds) associated with
+ *                 the reported timestamp, this value quantifies the inaccuracy
+ *                 of the clock at the time of reading. A value of UINT_MAX
+ *                 indicates that the error bound is unknown or unavailable.
+ * @timescale:     Clock timescale for timestamp interpretation
+ *                 (enum ptp_clock_timescale).
+ * @status:        Qualitative synchronization status of the clock
+ *                 (enum ptp_clock_status).
+ * @counter_id:    Identifies the hardware counter used to produce
+ *                 counter_value (enum ptp_counter_id).
+ *                 PTP_COUNTER_UNKNOWN (0) means no counter is available.
+ * @rsv:           Reserved for future use, should be set to zero.
+ * @counter_value: Raw hardware counter value (e.g. TSC ticks) captured at
+ *                 the time of the PHC timestamp reading. Zero with
+ *                 counter_id == PTP_COUNTER_UNKNOWN means not available.
+ */
+struct ptp_clock_attributes {
+	__u32 error_bound;
+	__u8 timescale;
+	__u8 status;
+	__u8 counter_id;
+	__u8 rsv;
+	__u64 counter_value;
+};
+
+/*
+ * struct ptp_clock_time_attributes - PTP timestamp with its associated
+ *				      attributes
+ *
+ * @pct: PTP clock timestamp value.
+ * @att: PTP clock timestamp attributes.
+ */
+struct ptp_clock_time_attributes {
+	struct ptp_clock_time pct;
+	struct ptp_clock_attributes att;
+};
+
 struct ptp_clock_caps {
 	int max_adj;   /* Maximum frequency adjustment in parts per billon. */
 	int n_alarm;   /* Number of programmable alarms. */
@@ -106,7 +292,9 @@ struct ptp_clock_caps {
 	/* Whether the clock supports adjust phase */
 	int adjust_phase;
 	int max_phase_adj; /* Maximum phase adjustment in nanoseconds. */
-	int rsv[11];       /* Reserved for future use. */
+	/* Whether the clock supports attrs ioctls */
+	int clock_attrs;
+	int rsv[10];       /* Reserved for future use. */
 };
 
 struct ptp_extts_request {
@@ -180,6 +368,30 @@ struct ptp_sys_offset_extended {
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
+/*
+ * ptp_sys_offset_extended_attrs - data structure for IOCTL operation
+ *				   PTP_SYS_OFFSET_EXTENDED_ATTRS
+ *
+ * @n_samples:	Desired number of measurements.
+ * @clockid:	clockid of a clock-base used for pre/post timestamps.
+ * @rsv:	Reserved for future use.
+ * @ts:		Array of samples in the form [pre-TS, PHC, post-TS].
+ *		Each sample consists of timestamp in the form [sec, nsec],
+ *		while the PHC sample also includes clock attributes in the form
+ *		[error_bound, timescale, status].
+ *
+ * Starting from kernel 6.12 and onwards, the first word of the reserved-field
+ * is used for @clockid. That's backward compatible since previous kernel
+ * expect all three reserved words (@rsv[3]) to be 0 while the clockid (first
+ * word in the new structure) for CLOCK_REALTIME is '0'.
+ */
+struct ptp_sys_offset_extended_attrs {
+	unsigned int n_samples;
+	__kernel_clockid_t clockid;
+	unsigned int rsv[2];
+	struct ptp_clock_time_attributes ts[PTP_MAX_SAMPLES][3];
+};
+
 struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
@@ -187,6 +399,13 @@ struct ptp_sys_offset_precise {
 	unsigned int rsv[4];    /* Reserved for future use. */
 };
 
+struct ptp_sys_offset_precise_attrs {
+	struct ptp_clock_time_attributes device;
+	struct ptp_clock_time sys_realtime;
+	struct ptp_clock_time sys_monoraw;
+	unsigned int rsv[2];     /* Reserved for future use. */
+};
+
 enum ptp_pin_function {
 	PTP_PF_NONE,
 	PTP_PF_EXTTS,
@@ -252,6 +471,10 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED_CYCLES \
 	_IOWR(PTP_CLK_MAGIC, 22, struct ptp_sys_offset_extended)
+#define PTP_SYS_OFFSET_PRECISE_ATTRS \
+	_IOWR(PTP_CLK_MAGIC, 23, struct ptp_sys_offset_precise_attrs)
+#define PTP_SYS_OFFSET_EXTENDED_ATTRS \
+	_IOWR(PTP_CLK_MAGIC, 24, struct ptp_sys_offset_extended_attrs)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occurred. */
-- 
2.47.3


