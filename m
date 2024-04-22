Return-Path: <netdev+bounces-90282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6E8AD719
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 00:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456D6284095
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9B1D54F;
	Mon, 22 Apr 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCbuPCVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7157208C7
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823636; cv=none; b=iwO/OXUDYJpUppP2IjieSOWjrXv0w9EIevkt0uMVzXAxS/AGF7ytU/GgJEEO7T6Md+AYxSDfKvxCd669UWtwsJxu3vj1Tx2rPoNPrMHcb1vcgFrqPZO8I4NTXtj5VEhOsW3hz8sgIslXKq/JrTijso/dI0Kp2DowdBLQzxtrsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823636; c=relaxed/simple;
	bh=hgxYVB5gsQzHSWZ1yqm8jOmRL3pkwC76kyby2jLAmlM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jvi/zRvbfEOaWU4NfjhrFRstlpndy1tXLsKJCqZi9XAh4Ij3MbYnwtzhpMVy2tVZi5VxyVX2PWRrhEs5jbVgE5ybZjhk+dfbCSLXE/rRj7fdqPBjnGxNTox+xxiMXJRgG2IErlCUJSC88HFHfdmZS0RTMLBREh+glYmd/+UjgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCbuPCVZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de549a4ea65so552628276.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713823633; x=1714428433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QhIuTeQ4b/V8Y8odbgjn2k8qbJdlep6wbUyfYlchvs4=;
        b=sCbuPCVZBqjNDWUuszFdCMzUzuZ4u9pYrffZ6B1pgf6DqvUHse242ARuB+bKtOYJJu
         DG1Demmvh30/DH4XLFU/wNJfwBIsStCq6CPL96XZLM0Cqj8OFcDOnD7jWk7Xv8/DCpgv
         xJladbtb06pDRmShaBpjT1fKnfuLWHiN0AoO9P8B6TEotFkldrgoJ9lCxA20nGn+ak+n
         Cbi8zPqI5Ql6MyF+uy1fdJwX0lYKHF8b4knVT3BgfB56EhyVqOvrSN2LYI4Nan/08j/r
         RglOqzLhIm/+DjyMHNLoWWB1Wg6kP6+nuOQYMQ22KOeprN/LC/tf9VwIaXPjd6q7KqlH
         4U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713823633; x=1714428433;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhIuTeQ4b/V8Y8odbgjn2k8qbJdlep6wbUyfYlchvs4=;
        b=jdF062eeddWjTRXVgyHqMsifkC+WNAOHXBWqPFrsv58+lJOzGWN3gwyCXOulA0kn/b
         GzNjIXNeRu/VCjg98CKqG11NblkGQ2RRuDDnVASZzRpkGSguW9FEmKMVSfH1moyj9RZr
         sTfs2qEkL1QrZCHTX+6n8P54hlqIcM3lZmL644GgS7DIzgkOTxwcFUd23iYZ/VSDHXXq
         aZWyQ2+rlDJPchGfqNRNpn7AvTTBm/X+bfKyiQ9pV0KeLlIz+V6P91GR4iIFeluSynRb
         oJ7T8kWdZ0d8DxjSSB4bPAjm+HaCGcR7lKQMo0thzXtHYojRpJ8U+7cBd5IO7ac0TsVL
         h0yw==
X-Gm-Message-State: AOJu0YyLYpxQVV9v7PHIyE85EPEICef3UiCkPP8c0Q7A8iNjJy4OB5yc
	0nBtgaXUdO3m7HedcIXDPvFEOvBbAA5JsnpOMSlrKTXdtC61Y/+kwNWi1QT1fsWFNdF6bA8sANo
	cnvgZqMoTjLixw42AJoF4hVOvw/H+CJ24zU3Uso2Ig6Mv7Yh1y1BIPY6JLYJHpPZhmFiWNx0hsj
	HwOR7y0aH2nxoS0k1laDx9FfpkHi3nI1BUFnz8vA==
X-Google-Smtp-Source: AGHT+IEUdq9055CxbT7gmjPP6foVQFDN8saEsDcUMgzMRfWoMeN+wA2VW4uBJTdqGMu5/O6zNxjcwvzpp6yR
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:6902:f88:b0:de5:3003:4b7b with SMTP id
 ft8-20020a0569020f8800b00de530034b7bmr1121893ybb.1.1713823632802; Mon, 22 Apr
 2024 15:07:12 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:07:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422220707.162146-1-maheshb@google.com>
Subject: [PATCHv3 next] ptp/ioctl: support MONOTONIC_RAW timestamps for PTP_SYS_OFFSET_EXTENDED
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
v1 -> v2
   * Code-style fixes
v2 -> v3
   * Reword commit log
   * Fix the compilation issue by using __kernel_clockid instead of clockid_t
     which has kernel only scope.

 drivers/ptp/ptp_chardev.c        |  7 +++++--
 include/linux/ptp_clock_kernel.h | 30 ++++++++++++++++++++++++++----
 include/uapi/linux/ptp_clock.h   | 26 ++++++++++++++++++++------
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 7513018c9f9a..c109109c9e8e 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -358,11 +358,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			extoff = NULL;
 			break;
 		}
-		if (extoff->n_samples > PTP_MAX_SAMPLES
-		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
+		if (extoff->n_samples > PTP_MAX_SAMPLES ||
+		    extoff->rsv[0] || extoff->rsv[1] ||
+		    (extoff->clockid != CLOCK_REALTIME &&
+		     extoff->clockid != CLOCK_MONOTONIC_RAW)) {
 			err = -EINVAL;
 			break;
 		}
+		sts.clockid = extoff->clockid;
 		for (i = 0; i < extoff->n_samples; i++) {
 			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
 			if (err)
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..74ded5f95d95 100644
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
@@ -457,14 +459,34 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->pre_ts);
+	if (sts) {
+		switch (sts->clockid) {
+		case CLOCK_REALTIME:
+			ktime_get_real_ts64(&sts->pre_ts);
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
index 053b40d642de..02684d7e00e6 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -155,13 +155,27 @@ struct ptp_sys_offset {
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
+ * History:
+ * v1: Initial implementation.
+ *
+ * v2: Use the first word of the reserved-field for @clockid. That's
+ *     backword compatible since v1 expects @rsv[3] to be 0 while the
+ *     clockid for CLOCK_REALTIME is '0'.
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
2.44.0.769.g3c40516874-goog


