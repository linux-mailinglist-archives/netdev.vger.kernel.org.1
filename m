Return-Path: <netdev+bounces-88971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2368A920F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B5B282B23
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76122548F6;
	Thu, 18 Apr 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eb4jWVY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404E4F1F1
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414436; cv=none; b=Jrc3jl6GZKjmJfW/3ST/g/FDls3nAqXtFrIVT0IN5w1DSsPftIuQftujyvV566Yv+4aUbybB8TkZM8Qe42cXjNfRYmv0fTBW7t2lU7V/ezNoUnbvktIrwmG8XZCmHuu/diRV2c+Rbw/wUJWD3ncIlYxVtOzSVdpYzIVeVTxNLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414436; c=relaxed/simple;
	bh=fxBFAfnk9DG3kGeKzl4RerRDhFBCIyK0a6Nkiud1tuo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q35GohpddC4ozpNumz0H2STYtViSNgF7bEPSB+bR8EE1jvqDg9ZkP1J8Rqz8Kcsh68asxnBB7gQHDx8bqQRd+wJpuSVP2iNn+LNLXfqxz1l7qPOKf1CcUoxCH25fZ+mA0PwgcjwlLau8Pmz7ACuXCOfaRVbrFm+JJygAYwB3yaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eb4jWVY2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so1036585276.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 21:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713414433; x=1714019233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tc809RCyafetIWadLe3Tgnd+xgeZ5RhYmPyMCye3oC4=;
        b=eb4jWVY2FKsSzdVmIm2PE/l22HjzEGIgKtC+yJ2L+WWw1tpnpprvlhUWKXT+j8Fy0J
         V4Uzlk1YogHUmKn68vvdVVWmkPgNNF53em58H/rnBMhcR6sIcxW7nGn9sgB6hSceZJVR
         my2Gehy6pLYGYcX9QB812djOnwAkacJE84Yxk/A8W3Ax3NUylabIirFz0RlJ0xP9R8Xh
         2KjqAmgEKBua5qkR7WblUQ7XQVK9DbDMMrhRl0wLLBZrkpgGz5TdhpPHUe/S9mqkplIs
         NpCjzEkri+h7FoARTUxU+hRBMpOhkg//m9siHr3fRC9VcoGnLm0x/UzX9mxkdqZR5Zfm
         WnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713414433; x=1714019233;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tc809RCyafetIWadLe3Tgnd+xgeZ5RhYmPyMCye3oC4=;
        b=I362dVnIenjWB/4ry+Efmh/Lb0IlnCn3Woiu6rHQfBnDc8aJaVEK9LlEDDbAkPy/yp
         UF8gVc8uGqe/ynTLYhvL2vyPxzCrBbe+ynkBD2pBHWGHeY2CABJrh1ZdyaI3bWoPMCtm
         kssMWLdeiTRa8a1Bo/s8iyKp1EGWXtWceBmUY36tfZ6w7gUTwqlGytc1+nRqCgcbGFhq
         hE/NNS2z7zEpqiimFpODAm5mzaeccb3s6h1DLkPFn4aG29YGRrS02AqpDI9MQ+W8MOGU
         g0cV6Pi+oz0MzWsZH2mlPz6Flt2u+nIQ9ZV23xkwBm+4kS5aMR/scSjG7BsOokA6g8L6
         tyrA==
X-Gm-Message-State: AOJu0YwHXLDV+1WshjS37xB6ljpgf0iD8IBlVNhiAvz60NyLF+2plT8F
	sQsDwmfYlgm8pfBLLZ2CKGLCLISY75COok0TYU8QxvXsw6yxOHVGqyL5dmpjGBUDhEXwal71Diu
	kUQPNffqcSkG2QqniDpLsCUniSnvvyQQsARoMMUBsQAkV7ndRbQ/M5iKkEMUpfEe8WWw46Qmbel
	GE3lwrnTsQAqbat7DHFdOWksSON998rDu9NS71/Q==
X-Google-Smtp-Source: AGHT+IFUqJcrXeHW8AFE7zoO2fridZVDQsHOl97XvpPOySGvZJBKF0EQ6Pub/RS+BsDsGczoK5UNZsKcuexe
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:6902:18d5:b0:dcd:5e5d:458b with SMTP
 id ck21-20020a05690218d500b00dcd5e5d458bmr424732ybb.3.1713414433248; Wed, 17
 Apr 2024 21:27:13 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:27:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418042706.1261473-1-maheshb@google.com>
Subject: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally in
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
~# testptp -d /dev/ptp0 -x 3 -y real
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
v1 -> v2
   * Code-style fixes

 drivers/ptp/ptp_chardev.c        |  7 +++++--
 include/linux/ptp_clock_kernel.h | 30 ++++++++++++++++++++++++++----
 include/uapi/linux/ptp_clock.h   |  7 ++++++-
 3 files changed, 37 insertions(+), 7 deletions(-)

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


