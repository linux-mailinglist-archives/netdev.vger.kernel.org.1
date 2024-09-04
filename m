Return-Path: <netdev+bounces-125129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B696BFC5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F728275D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBE1DA610;
	Wed,  4 Sep 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CQBGNABx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60E1CCEFC
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459223; cv=none; b=lyqlgPkDfToyOokfjFH+8gEApTtlPAkEx3QA0JfoqdNiFoNwKjPtYVuI15CcSol76bpZxUHuAhZz1DlFshudN7ZOa5Dykb4sYZi4o8IKwoq2lxVcF+Z/qxUDXvsBgRBSXmcN1NDbOk/0/GALiEXfE9ccJ/ZRAz2Xrn6XVH5XE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459223; c=relaxed/simple;
	bh=tCVW13UPtGXMnpc7N2fKYDYF7fU7lE8QuTiP3brNcnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KuR9d4r2kp/sOKqz7BTeCM4pWxXhzsTHb0zWaZckm8lxZNyP1ntQ+vSZp0dObHXf5P0JykjybzNqbVh77+aGGXR2V4a59GzHLhDDkbPfPW0/JQfuyLqB+tmiedSuIoofObLUaQjiyRU00bpcg06f1l+iyPqbR5MMvShZxLxqF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CQBGNABx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849UN5r022625;
	Wed, 4 Sep 2024 07:13:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=FlG
	uNesJ+Fc9fcZttk3ylx4pR5JWMkdVAW2Up8l7ces=; b=CQBGNABxRD4kzHpbthA
	nMDUaj1Netk5la1iZ3y1SuAMdcNaJuNZcbUqKXYmNSNhpRgLcEdMfwsl5bXWyMsZ
	laNFY/HR1J6IWcN6HCrALMsyYI+m2PPuUAsBiqxihs6WLWOWCTvewqCk6lFN93oy
	fciSpq0ldAoSYkqS3Llqp999R5PxPWn70oGBtsc9vgQ1vADiN9QpLghTf/aN4mBK
	zyMDRddirh1c0XXRLYErTId5XrTeVTxutDLhrSoX3h/q1QjAORCy7gnS1azqL8PL
	PBMNmvGK3twJBtQ/dpJXG+Y+oBUoIpbDQ5omOVk1bdSraG9FbqN2uIenSQVFsBdl
	+rA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1d68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 04 Sep 2024 07:13:14 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 4 Sep 2024 14:13:12 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
CC: Mahesh Bandewar <maheshb@google.com>, <netdev@vger.kernel.org>,
        "Vadim
 Fedorenko" <vadfed@meta.com>
Subject: [PATCH net-next v5] ptp/ioctl: support MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED
Date: Wed, 4 Sep 2024 07:13:05 -0700
Message-ID: <20240904141305.2856789-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Dal_yOWFkTRiX0SSBBTU-tZ9aLWPaji4
X-Proofpoint-ORIG-GUID: Dal_yOWFkTRiX0SSBBTU-tZ9aLWPaji4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01

From: Mahesh Bandewar <maheshb@google.com>

The ability to read the PHC (Physical Hardware Clock) alongside
multiple system clocks is currently dependent on the specific
hardware architecture. This limitation restricts the use of
PTP_SYS_OFFSET_PRECISE to certain hardware configurations.

The generic soultion which would work across all architectures
is to read the PHC along with the latency to perform PHC-read as
offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
timestamps.  However, these timestamps are currently limited
to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
by NTP (or similar time synchronization services), it can
experience significant jumps forward or backward. This hinders
the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
is designed to provide.

This problem could be addressed by supporting MONOTONIC_RAW
timestamps within PTP_SYS_OFFSET_EXTENDED. Unlike CLOCK_REALTIME
or CLOCK_MONOTONIC, the MONOTONIC_RAW timebase is unaffected
by NTP adjustments.

This enhancement can be implemented by utilizing one of the three
reserved words within the PTP_SYS_OFFSET_EXTENDED struct to pass
the clock-id for timestamps.  The current behavior aligns with
clock-id for CLOCK_REALTIME timebase (value of 0), ensuring
backward compatibility of the UAPI.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
As Mahesh is not responding for more then a week, and there were no
new versions from May 2024, I decided to continue the work as we
found this feature useful in our case too. I'll keep previous change
log as is, but put the latest on top:

v4 -> v5:
- rebase on top of current net-next
- add CLOCK_MONOTONIC as another option (suggest by Richard)
- adjusted comment about changes in the ptp_sys_offset_extended
- reasoning explanation is done by Yuliang Li, link:
https://lore.kernel.org/netdev/CADj8K+M9qjLGAKcsV_9YoPQ5SGXe3vmi69Y65m1RUyLOMrJeHg@mail.gmail.com/

Original changelog:

v1 -> v2
   * Code-style fixes.
v2 -> v3
   * Reword commit log
   * Fix the compilation issue by using __kernel_clockid instead of clockid_t
     which has kernel only scope.
v3 -> v4
   * Typo/comment fixes.

 drivers/ptp/ptp_chardev.c        |  8 +++++--
 include/linux/ptp_clock_kernel.h | 36 ++++++++++++++++++++++++++++----
 include/uapi/linux/ptp_clock.h   | 24 +++++++++++++++------
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 2067b0120d08..ea96a14d72d1 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -359,11 +359,15 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			extoff = NULL;
 			break;
 		}
-		if (extoff->n_samples > PTP_MAX_SAMPLES
-		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
+		if (extoff->n_samples > PTP_MAX_SAMPLES ||
+		    extoff->rsv[0] || extoff->rsv[1] ||
+		    (extoff->clockid != CLOCK_REALTIME &&
+		     extoff->clockid != CLOCK_MONOTONIC &&
+		     extoff->clockid != CLOCK_MONOTONIC_RAW)) {
 			err = -EINVAL;
 			break;
 		}
+		sts.clockid = extoff->clockid;
 		for (i = 0; i < extoff->n_samples; i++) {
 			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
 			if (err)
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..c892d22ce0a7 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -47,10 +47,12 @@ struct system_device_crosststamp;
  * struct ptp_system_timestamp - system time corresponding to a PHC timestamp
  * @pre_ts: system timestamp before capturing PHC
  * @post_ts: system timestamp after capturing PHC
+ * @clockid: clock-base used for capturing the system timestamps
  */
 struct ptp_system_timestamp {
 	struct timespec64 pre_ts;
 	struct timespec64 post_ts;
+	clockid_t clockid;
 };
 
 /**
@@ -457,14 +459,40 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->pre_ts);
+	if (sts) {
+		switch (sts->clockid) {
+		case CLOCK_REALTIME:
+			ktime_get_real_ts64(&sts->pre_ts);
+			break;
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&sts->pre_ts);
+			break;
+		case CLOCK_MONOTONIC_RAW:
+			ktime_get_raw_ts64(&sts->pre_ts);
+			break;
+		default:
+			break;
+		}
+	}
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->post_ts);
+	if (sts) {
+		switch (sts->clockid) {
+		case CLOCK_REALTIME:
+			ktime_get_real_ts64(&sts->post_ts);
+			break;
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&sts->post_ts);
+			break;
+		case CLOCK_MONOTONIC_RAW:
+			ktime_get_raw_ts64(&sts->post_ts);
+			break;
+		default:
+			break;
+		}
+	}
 }
 
 #endif
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 053b40d642de..18eefa6d93d6 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -155,13 +155,25 @@ struct ptp_sys_offset {
 	struct ptp_clock_time ts[2 * PTP_MAX_SAMPLES + 1];
 };
 
+/*
+ * ptp_sys_offset_extended - data structure for IOCTL operation
+ *			     PTP_SYS_OFFSET_EXTENDED
+ *
+ * @n_samples:	Desired number of measurements.
+ * @clockid:	clockid of a clock-base used for pre/post timestamps.
+ * @rsv:	Reserved for future use.
+ * @ts:		Array of samples in the form [pre-TS, PHC, post-TS]. The
+ *		kernel provides @n_samples.
+ *
+ * Starting from kernel 6.12 and onwards, the first word of the reserved-field
+ * is used for @clockid. That's backward compatible since previous kernel
+ * expect all three reserved words (@rsv[3]) to be 0 while the clockid (first
+ * word in the new structure) for CLOCK_REALTIME is '0'.
+ */
 struct ptp_sys_offset_extended {
-	unsigned int n_samples; /* Desired number of measurements. */
-	unsigned int rsv[3];    /* Reserved for future use. */
-	/*
-	 * Array of [system, phc, system] time stamps. The kernel will provide
-	 * 3*n_samples time stamps.
-	 */
+	unsigned int n_samples;
+	__kernel_clockid_t clockid;
+	unsigned int rsv[2];
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
-- 
2.43.5


