Return-Path: <netdev+bounces-88492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB48A771D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD191C20B63
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1386EB56;
	Tue, 16 Apr 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFlN6AQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FA39AF2
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304789; cv=none; b=PbBpMDPPeC1oX5xv7khC13ECacdPMJHu+WF3PjjBpZuhWljKte8r01qFMK0jNzmy41PaNFYcvpzkEIVpGHZwL+uAfflDHcq57SNpHlvUQtJgkhT2Ipct/QM56BVosS8SsOFK2+U+QAf/0m1gfpn+OAVScj21nV3h+4G4Svldi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304789; c=relaxed/simple;
	bh=Us+8KZ2CVWtRVwH8+WDa/l+o8PJUgogpdqZsE1fj8a4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OcM+zY7SkuMi/zyE8tAYOMfTR2CR3ktSytqxtMk57xbQq31B3f6sdX1NuWx4ubFmoYCy955xJAR4kymVBM2Cpj1JuETaYdEqwXgJ/KQbTjjPmTg0QkgBoPPvCaJ4I8JyDeMsunN/jhBlMhMfdM6gMmxqsT0pbTv0qNu6Ry7X2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFlN6AQY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe93b5cfso74355037b3.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713304787; x=1713909587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e69wuLO8fARq/X2wQ5SgFqJQevGNwrRmMu/JkYZ/qlY=;
        b=jFlN6AQY3Hen51QVnT/6K2ElBBTQm1XVzJisPSJ9Hwif/GC4Bs53y1OqF/JbX7LOvK
         Y+pWLTevKRmtmRmMtH8ckZAQEB5QxceFA7vA9h4BL1ztQUhnUfV1snaCnRstQA1fzczH
         jOqgBrZJe7tP8DAaY9iYC82Z156ft9s+ah0H1rf9/b8QmTiQt4UUzjOwFVmW1lkCceQY
         eKcjrvOB7+lY7Es6zTc1Oj7Tx1BPC5fKdcTzDA7elYwFRmTSCXp5a7M6MwGQN+ZW819f
         9I6HjUmAsIQPaAm9p8QrxoANCvd41oLNGnBWduwRh7ceUwQvNJ9tEg+hCYATCWIMTIpT
         /h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713304787; x=1713909587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e69wuLO8fARq/X2wQ5SgFqJQevGNwrRmMu/JkYZ/qlY=;
        b=loFFAdrdIxq9lWslrPLbR5q2ae66QJsjwgzGRURfSDzPSnckJ2bWMHwRC+8cuRMuz5
         rOYKBKmKQRCfM0XodvTQptsDykuRLeuqNXHXXCklUk2+djEAbjCthy1Mkk6Yah/K5OnZ
         neVW8cuFHuDPlzVgVDLppsoYHf2NZpwvq9tLtoEs5hDgWnVwaz4aIZQ844I3yECYiOn8
         SVHtoCsvgeB2OfCJ0BsC53JWqzWnFPznhbMWKvDRrlSTRmV8ap36yUOj1f52kDXCi4gB
         VQtaG41OfzA8aMlH0gzwfoeO6JaCKW19KH+40AOQYmdDMMWR/awflAy59jXh3kE3lew2
         M6Cg==
X-Gm-Message-State: AOJu0YztqHDZpkAxVW7pReTYV90+MHeEfISwKPI6Er0b/yzH9ksJ2H8e
	+B41d7YvO1ltzcPQ/GV3JBh6TdLaAgvK9gBmEFobDBBcEXxJxSe3nZf5lKmAOVRtGGm/zXzfCME
	EyUFJWekNGu+Nw59e0NIe2WGcRDMYJ33ZTb1f8sxf3njygmhghxNF6Z2dpYwms8ideTJnNd1ek4
	yhl2NDbFX+CAeGO+t+wuDrXpK1B7DYZZP63p6xPQ==
X-Google-Smtp-Source: AGHT+IESUA3BK8b9jgNOg0C7qhV2ZE92zst3SnbszP+3VfW70IOwr+vC/GkD+8k5Jnf4uzw+JG6TZgKPIYS9
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a0d:d402:0:b0:618:3b78:a851 with SMTP id
 w2-20020a0dd402000000b006183b78a851mr3397571ywd.6.1713304786582; Tue, 16 Apr
 2024 14:59:46 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:59:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416215942.150202-1-maheshb@google.com>
Subject: [PATCHv1 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

The current implementation of PTP_SYS_OFFSET_EXTENDED provides
PHC reads in the form of [pre-TS, PHC, post-TS]. These pre and
post timestamps are useful to measure the width of the PHC read.
However, the current implementation provides these timestamps in
CLOCK_REALTIME only. Since CLOCK_REALTIME is disciplined by NTP
or NTP-like service(s), the value is subjected to change. This
makes some applications that are very sensitive to time change
have these timestamps delivered in different time-base.

This patch updates the gettimex64 / ioctl op PTP_SYS_OFFSET_EXTENDED
to provide these (sandwich) timestamps optionally in
CLOCK_MONOTONIC_RAW timebase while maintaining the default behavior
or giving them in CLOCK_REALTIME.

~# testptp -d /dev/ptp0 -x 3 -y raw
extended timestamp request returned 3 samples
sample # 0: mono-raw time before: 371.548640128
            phc time: 371.579671788
            mono-raw time after: 371.548640912
sample # 1: mono-raw time before: 371.548642104
            phc time: 371.579673346
            mono-raw time after: 371.548642490
sample # 2: mono-raw time before: 371.548643320
            phc time: 371.579674652
            mono-raw time after: 371.548643756
~# testptp -d /dev/ptp0 -x 3
extended timestamp request returned 3 samples
sample # 0: system time before: 1713243413.403474250
            phc time: 385.699915490
            system time after: 1713243413.403474948
sample # 1: system time before: 1713243413.403476220
            phc time: 385.699917168
            system time after: 1713243413.403476642
sample # 2: system time before: 1713243413.403477555
            phc time: 385.699918442
            system time after: 1713243413.403477961
~#

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
---
 drivers/ptp/ptp_chardev.c        |  5 ++++-
 include/linux/ptp_clock_kernel.h | 30 ++++++++++++++++++++++++++----
 include/uapi/linux/ptp_clock.h   |  7 ++++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 7513018c9f9a..34cd0ab79b10 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -359,10 +359,13 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			break;
 		}
 		if (extoff->n_samples > PTP_MAX_SAMPLES
-		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
+		    || extoff->rsv[0] || extoff->rsv[1]
+		    || (extoff->clockid != CLOCK_REALTIME
+			&& extoff->clockid != CLOCK_MONOTONIC_RAW)) {
 			err = -EINVAL;
 			break;
 		}
+		sts.clockid = extoff->clockid;
 		for (i = 0; i < extoff->n_samples; i++) {
 			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
 			if (err)
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..7563da6db09b 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -47,10 +47,12 @@ struct system_device_crosststamp;
  * struct ptp_system_timestamp - system time corresponding to a PHC timestamp
  * @pre_ts: system timestamp before capturing PHC
  * @post_ts: system timestamp after capturing PHC
+ * @clockid: clockid used for cpaturing timestamp
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
index 053b40d642de..fc5825e72330 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -157,7 +157,12 @@ struct ptp_sys_offset {
 
 struct ptp_sys_offset_extended {
 	unsigned int n_samples; /* Desired number of measurements. */
-	unsigned int rsv[3];    /* Reserved for future use. */
+	/* The original implementation provided timestamps (always) in
+	 * REALTIME clock-base. Since CLOCK_REALTIME is 0, adding
+	 * clockid doesn't break backward compatibility.
+	 */
+	clockid_t clockid;	/* One of the supported clock-ids */
+	unsigned int rsv[2];    /* Reserved for future use. */
 	/*
 	 * Array of [system, phc, system] time stamps. The kernel will provide
 	 * 3*n_samples time stamps.
-- 
2.44.0.683.g7961c838ac-goog


