Return-Path: <netdev+bounces-209727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58FB109BD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED653BE6B0
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267702BE7D7;
	Thu, 24 Jul 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IF4kwmL8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E822BD5AE
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358263; cv=none; b=iaCNLzwLFOlfgXgnUgJaS8fpdiExxuTxT4OWmZZRuxVfZZ0YsLI51ttuq6YNGENEjoYvdEz7hvZ6ezDdmYtUlyL8qw3CeMbBOcfSYKWiVvR+Y6PMSj9W61wed+1o37V5J+rGygY+WXGKIC+iCNQ/BwmJJdkkmvtrPv+VkfZ1pLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358263; c=relaxed/simple;
	bh=PXAaSGeqVNYNn8e4DCba78VFBxRA8o5pOLOmwd1XveE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1Km+B9TLmQZzf9vc2pOrUYPiWp9x3O2UDoYZaowUeoh8divnGC/6FfkjP0FrUzyZKwbTG1kEn5jF6EYfal0/b3fTs6E+8IBovbM//o3G79plgKcOZhMnPPuClMEfewlwUPobXA/k3et0u1sEBzRFZ3rwtXwLluTJXuoT2VaS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IF4kwmL8; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1753358261; x=1784894261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AjoTGoKPkqEjda74IL8s096Eu2LGy2RqKJzK1/6pDmM=;
  b=IF4kwmL8vCeFn3XPiuOUvbGWxsaH91rdCik89reUTgbt1u3v3Hk74ioH
   9GgnDXNL9jiBgn/9JOR2Zn3sIC7PP6l9wiT5wWQ5QSmv3IernLp5WydQG
   uUuBAlxiEcMOqmnPtoo0cqE/Dx2eAytr3y5sEDjaPR7hHen+DTVfUVFqS
   7iayoUKMugVOF/SlGuJmF7F9KyhJMKaw1IC1gqd03/feiBvWGEv/IN60v
   SVGzFHv4Ft+ePcxMMwkLeRzeQDeUHmsZ1Td3MGr3YNob3562PZrJsSYmu
   3AOZ8olLES0IFoeBUpa/NbYmquGcQMxBkXNqxkSrqoBdaxAp2Zkbat7nW
   w==;
X-IronPort-AV: E=Sophos;i="6.16,337,1744070400"; 
   d="scan'208";a="512558216"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:57:38 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:40578]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.44:2525] with esmtp (Farcaster)
 id 5b4b165d-403d-48c8-a92c-1d3a34a12aad; Thu, 24 Jul 2025 11:57:36 +0000 (UTC)
X-Farcaster-Flow-ID: 5b4b165d-403d-48c8-a92c-1d3a34a12aad
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Jul 2025 11:57:36 +0000
Received: from HFA15-G9FV5D3.ant.amazon.com (10.85.143.175) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Jul 2025 11:57:25 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.com>, Andrew Lunn <andrew@lunn.ch>, Miroslav Lichvar
	<mlichvar@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, <netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Julien
 Ridoux" <ridouxj@amazon.com>, Josh Levinson <joshlev@amazon.com>
Subject: [RFC PATCH net-next] ptp: Introduce PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Date: Thu, 24 Jul 2025 14:56:56 +0300
Message-ID: <20250724115657.150-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

This patch introduces a new ioctl command,
PTP_SYS_OFFSET_EXTENDED_TRUSTED, to the Linux PTP subsystem.

The existing PTP_SYS_OFFSET_EXTENDED ioctl enables user-space
applications to correlate timestamps between system and PTP clocks
using raw measurements. These timestamps are used, for example,
by applications such as phc2sys to synchronize the system clock
from a PHC device.

The existing PTP APIs lack information about the synchronization
status and the quality of time offered by the PHC device. This
limitation is commonly circumvented by user-space tools such as
ptp4l. These tools implement the synchronization logic and can
export their measurement of clock accuracy and report on
synchronization status, and possible failures.

The proposed PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl offers the
same timestamps as the PTP_SYS_OFFSET_EXTENDED ioctl, but extends
it with a measurement of the PHC device clock accuracy and the
synchronization status. This supports two objectives.

The first objective focuses on the use case where the PHC device
is fully managed. The ENA driver, for example, exposes a PHC
device, whose synchronization status and quality is maintained
without any user-space application. This new ioctl reports on the
clock accuracy and status of the PHC device to user-space
applications, where ptp4l and similar are not available.

The second objective is to provide user-space applications with a
complete view of the current time and associated quality of the
PHC device in one-single call. This objective benefits the
consumers of time offered by the PHC device, independent from how
it is kept in sync (using ptp4l or being a managed device).

The proposed PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl fulfills both
objectives by extending each PHC timestamp with two quality
indicators:

- error_bound: a device-calculated value (in nanoseconds)
  reflecting the maximum possible deviation of the timestamp from
  the true time, based on internal clock state.

- clock_status: a qualitative state of the clock, with defined
  values including:
  1. Unknown: the clock's synchronization status cannot be
     reliably determined.
  2. Initializing: the clock is acquiring synchronization.
  3. Synchronized: The clock is actively being synchronized and
     maintained accurately by the device.
  4. FreeRunning: the clock is drifting and not being
     synchronized and updated by the device.
  5. Unreliable: the clock is known to be unreliable, the
     error_bound value cannot be trusted.

Note that the value taken by the clock status aligns with the
definition of the ptp_vmclock device and has the same semantic.
The status value are meant to be vendor-agnostic, and generic
enough to be mapped to specific protocols, including the
clockAccuracy and clockClass concepts defined within the IEEE
1588 standard.

This ioctl enables applications to directly obtain clock quality
metrics from the device, reducing the need for indirect inference
and simplifying clock monitoring.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/ptp/ptp_chardev.c        | 61 ++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 19 +++++++++
 include/uapi/linux/ptp_clock.h   | 73 ++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 4ca5a464..12fef95c 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -365,6 +365,64 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg)
 	return copy_to_user(arg, extoff, sizeof(*extoff)) ? -EFAULT : 0;
 }
 
+static long ptp_sys_offset_extended_trusted(struct ptp_clock *ptp,
+					    void __user *arg)
+{
+	struct ptp_sys_offset_extended_trusted *extofftrst __free(kfree) = NULL;
+	struct ptp_system_timestamp sts;
+	struct ptp_clock_attributes att;
+
+	if (!ptp->info->gettimextrusted64)
+		return -EOPNOTSUPP;
+
+	extofftrst = memdup_user(arg, sizeof(*extofftrst));
+	if (IS_ERR(extofftrst))
+		return PTR_ERR(extofftrst);
+
+	if (extofftrst->n_samples > PTP_MAX_SAMPLES ||
+	    extofftrst->rsv[0] ||
+	    extofftrst->rsv[1])
+		return -EINVAL;
+
+	switch (extofftrst->clockid) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		break;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	sts.clockid = extofftrst->clockid;
+	for (unsigned int i = 0; i < extofftrst->n_samples; i++) {
+		struct timespec64 ts;
+		int err;
+
+		err = ptp->info->gettimextrusted64(ptp->info, &ts, &sts, &att);
+		if (err)
+			return err;
+
+		/* Filter out disabled or unavailable clocks */
+		if (sts.pre_ts.tv_sec < 0 || sts.post_ts.tv_sec < 0)
+			return -EINVAL;
+
+		extofftrst->ts[i][0].pct.sec = sts.pre_ts.tv_sec;
+		extofftrst->ts[i][0].pct.nsec = sts.pre_ts.tv_nsec;
+		extofftrst->ts[i][1].pct.sec = ts.tv_sec;
+		extofftrst->ts[i][1].pct.nsec = ts.tv_nsec;
+		extofftrst->ts[i][1].att.error_bound = att.error_bound;
+		extofftrst->ts[i][1].att.clock_status = att.clock_status;
+		extofftrst->ts[i][2].pct.sec = sts.post_ts.tv_sec;
+		extofftrst->ts[i][2].pct.nsec = sts.post_ts.tv_nsec;
+	}
+
+	return copy_to_user(arg, extofftrst, sizeof(*extofftrst)) ? -EFAULT : 0;
+}
+
 static long ptp_sys_offset(struct ptp_clock *ptp, void __user *arg)
 {
 	struct ptp_sys_offset *sysoff __free(kfree) = NULL;
@@ -503,6 +561,9 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	case PTP_SYS_OFFSET_EXTENDED2:
 		return ptp_sys_offset_extended(ptp, argptr);
 
+	case PTP_SYS_OFFSET_EXTENDED_TRUSTED:
+		return ptp_sys_offset_extended_trusted(ptp, argptr);
+
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
 		return ptp_sys_offset(ptp, argptr);
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 3d089bd4..cd74e32f 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -120,6 +120,21 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimextrusted64:  Reads the current time from the hardware clock and
+ *                      optionally also the system clock with additional data on
+ *                      hardware clock accuracy and reliability.
+ *                      parameter ts: Holds the PHC timestamp.
+ *                      parameter sts: If not NULL, it holds a pair of
+ *                      timestamps from the system clock. The first reading is
+ *                      made right before reading the lowest bits of the PHC
+ *                      timestamp and the second reading immediately follows
+ *                      that.
+ *                      parameter error_bound: If not NULL, it holds the maximum
+ *                      error bound for the PHC timestamp in nanoseconds.
+ *                      parameter clock_status: If not NULL, it holds
+ *                      qualitative clock states indicating its synchronization
+ *                      status and reliability.
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
@@ -200,6 +215,10 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimextrusted64)(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts,
+				 struct ptp_clock_attributes *att);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 18eefa6d..bb22ed61 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -76,6 +76,26 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+/*
+ * Clock status values for struct ptp_clock_attributes.clock_status
+ */
+enum ptp_clock_status {
+	/* clock synchronization status cannot be reliably determined */
+	PTP_CLOCK_STATUS_UNKNOWN      = 0,
+
+	/* clock is acquiring synchronization */
+	PTP_CLOCK_STATUS_INITIALIZING = 1,
+
+	/* clock is synchronized and maintained accurately by the device */
+	PTP_CLOCK_STATUS_SYNCED       = 2,
+
+	/* clock is drifting and not being synchronized by the device */
+	PTP_CLOCK_STATUS_FREE_RUNNING = 3,
+
+	/* clock is unreliable, the error_bound value cannot be trusted */
+	PTP_CLOCK_STATUS_UNRELIABLE   = 4
+};
+
 /*
  * struct ptp_clock_time - represents a time value
  *
@@ -91,6 +111,33 @@ struct ptp_clock_time {
 	__u32 reserved;
 };
 
+/*
+ * struct ptp_clock_attributes - describes additional data for a PTP clock
+ *                               timestamp
+ *
+ * @error_bound:   The maximum possible error (in nanoseconds) associated with
+ *                 the reported timestamp, this value quantifies the inaccuracy
+ *                 of the clock at the time of reading.
+ * @clock_status:  Qualitative state of the clock (enum ptp_clock_status)
+ * @rsv:           Reserved for future use, should be set to zero.
+ */
+struct ptp_clock_attributes {
+	__u32 error_bound;
+	__u8 clock_status;
+	__u8 rsv[3];
+};
+
+/*
+ * struct ptp_clock_time_trusted - PTP timestamp with its associated attributes
+ *
+ * @pct: The PTP clock timestamp value.
+ * @att: PTP clock attributes about the timestamp
+ */
+struct ptp_clock_time_trusted {
+	struct ptp_clock_time pct;
+	struct ptp_clock_attributes att;
+};
+
 struct ptp_clock_caps {
 	int max_adj;   /* Maximum frequency adjustment in parts per billon. */
 	int n_alarm;   /* Number of programmable alarms. */
@@ -177,6 +224,30 @@ struct ptp_sys_offset_extended {
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
+/*
+ * ptp_sys_offset_extended_trusted - data structure for IOCTL operation
+ *				     PTP_SYS_OFFSET_EXTENDED_TRUSTED
+ *
+ * @n_samples:	Desired number of measurements.
+ * @clockid:	clockid of a clock-base used for pre/post timestamps.
+ * @rsv:	Reserved for future use.
+ * @ts:		Array of samples in the form [pre-TS, PHC, post-TS].
+ *		Each sample consists of timestamp in the form [sec, nsec],
+ *		while the PHC sample also includes clock attributes in the form
+ *		[error_bound, clock_status],
+ *
+ * Starting from kernel 6.12 and onwards, the first word of the reserved-field
+ * is used for @clockid. That's backward compatible since previous kernel
+ * expect all three reserved words (@rsv[3]) to be 0 while the clockid (first
+ * word in the new structure) for CLOCK_REALTIME is '0'.
+ */
+struct ptp_sys_offset_extended_trusted {
+	unsigned int n_samples;
+	__kernel_clockid_t clockid;
+	unsigned int rsv[2];
+	struct ptp_clock_time_trusted ts[PTP_MAX_SAMPLES][3];
+};
+
 struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
@@ -231,6 +302,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 8, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED \
 	_IOWR(PTP_CLK_MAGIC, 9, struct ptp_sys_offset_extended)
+#define PTP_SYS_OFFSET_EXTENDED_TRUSTED \
+	_IOWR(PTP_CLK_MAGIC, 10, struct ptp_sys_offset_extended_trusted)
 
 #define PTP_CLOCK_GETCAPS2  _IOR(PTP_CLK_MAGIC, 10, struct ptp_clock_caps)
 #define PTP_EXTTS_REQUEST2  _IOW(PTP_CLK_MAGIC, 11, struct ptp_extts_request)
-- 
2.47.1


