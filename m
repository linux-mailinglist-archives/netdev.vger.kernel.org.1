Return-Path: <netdev+bounces-217722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA62B39A0A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D115622FA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC430AD0B;
	Thu, 28 Aug 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9Qm4I6o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F04301030
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377202; cv=none; b=tTazEDEVH8MoOalfdwjajvlfo2QbEUeo9QJr0n/psn0emXa2k6jiS7ojysMZk0SibXI4Fn2skPR397dNbeIil9S4if+yKTxQtMhxIzUZ50pOQmzhK3UCn4qU8cRkstv0hoCChzjKVVCpRqSwKA+Bxp7+iJ8W58duzjCY9q6aCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377202; c=relaxed/simple;
	bh=dIUVxVMzmwpa1a2rCoWXW2RPF3FWP0eRAv58vpf/V0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrpH484yJQqzpzHAmvJUh6UFxwAnEX2mvb2DRHvCCDNTQrtSmWiP13F/SQSRcj1wbsWqxmAJQ/pRhK+DWn39XHIFcKkdly+hBWpYUkqrnNuERtlTrWq9FIA5IlOn8JKUpPqzkPJglNjzt1BCQqE3bXO1iiqKmxaBoU9vww9Aluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9Qm4I6o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VtzDgvYgWjaoaH4GyXIIcrtS3Xq5vrAA6ErTxI6Q5oA=;
	b=X9Qm4I6oAQDMkg60GSK5PiEIS5zzTx89Zzt8eNxWYtHYdofyBkX4xkLsLgJ6IpkgJI93J8
	3m4rYFBfGZ8/UtnQ462ftBBThos4DXNx8EErqV7o5Fd0kVnj7Fu55fls144/LqwSYz00R4
	ajNViCU5ZIe44X9uYE1bgXMFNE2A8Lc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-iwu4oLdnPk--TnBjyKk0Og-1; Thu,
 28 Aug 2025 06:33:12 -0400
X-MC-Unique: iwu4oLdnPk--TnBjyKk0Og-1
X-Mimecast-MFC-AGG-ID: iwu4oLdnPk--TnBjyKk0Og_1756377191
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9958419560B6;
	Thu, 28 Aug 2025 10:33:11 +0000 (UTC)
Received: from queeg (unknown [10.43.135.229])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 914D1300019F;
	Thu, 28 Aug 2025 10:33:09 +0000 (UTC)
From: Miroslav Lichvar <mlichvar@redhat.com>
To: netdev@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 net-next] ptp: Limit time setting of PTP clocks
Date: Thu, 28 Aug 2025 12:32:53 +0200
Message-ID: <20250828103300.1387025-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Networking drivers implementing PTP clocks and kernel socket code
handling hardware timestamps use the 64-bit signed ktime_t type counting
nanoseconds. When a PTP clock reaches the maximum value in year 2262,
the timestamps returned to applications will overflow into year 1667.
The same thing happens when injecting a large offset with
clock_adjtime(ADJ_SETOFFSET).

The commit 7a8e61f84786 ("timekeeping: Force upper bound for setting
CLOCK_REALTIME") limited the maximum accepted value setting the system
clock to 30 years before the maximum representable value (i.e. year
2232) to avoid the overflow, assuming the system will not run for more
than 30 years.

Enforce the same limit for PTP clocks. Don't allow negative values and
values closer than 30 years to the maximum value. Drivers may implement
an even lower limit if the hardware registers cannot represent the whole
interval between years 1970 and 2262 in the required resolution.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---

Notes:
    v2:
    - leave tv_nsec validation separate (Jakub)

 drivers/ptp/ptp_clock.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1cc06b7cb17e..3e0726c6f55b 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -100,6 +100,9 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 		return -EBUSY;
 	}
 
+	if (!timespec64_valid_settod(tp))
+		return -EINVAL;
+
 	return  ptp->info->settime64(ptp->info, tp);
 }
 
@@ -130,7 +133,7 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 	ops = ptp->info;
 
 	if (tx->modes & ADJ_SETOFFSET) {
-		struct timespec64 ts;
+		struct timespec64 ts, ts2;
 		ktime_t kt;
 		s64 delta;
 
@@ -143,6 +146,14 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
 			return -EINVAL;
 
+		/* Make sure the offset is valid */
+		err = ptp_clock_gettime(pc, &ts2);
+		if (err)
+			return err;
+		ts2 = timespec64_add(ts2, ts);
+		if (!timespec64_valid_settod(&ts2))
+			return -EINVAL;
+
 		kt = timespec64_to_ktime(ts);
 		delta = ktime_to_ns(kt);
 		err = ops->adjtime(ops, delta);
-- 
2.51.0


