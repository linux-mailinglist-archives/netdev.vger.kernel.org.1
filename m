Return-Path: <netdev+bounces-216463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1761DB33DBE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73183BB7A0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8513429BDBE;
	Mon, 25 Aug 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSljBp30"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46651E9B2A
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120293; cv=none; b=JUpJDV1immlY/Th+YSrdoNoA2mlsKnT10HpkNydVZ+fcrNZjl8uXdNA9SbIQ1+N8XCF5YwqHdPDhvmSgEYZW2q3i8N4iQZDDS+3674p1AkU0ynQNDAmJcRCtylgDlVWMBrZtHvV3atLlceE90KNcQSyLLX84rowKJC0REtgKO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120293; c=relaxed/simple;
	bh=S/AVvkNGBd6Gm8v/g7yHzl+7AikAnvCVwRBdnYj5GLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYem+OcA0NLkDuroToi5SSM/akJN3IhlLxCKHEwasqk9PKbHFnLkwFJTKoMIpYEysqCnSiY5SFwzUSyURscMKW+qUubDsV/8t64pLuWSK5sRmDi5Bd5p20+lVT1pIA9g+ossFGxDhoovXawHSRre66YyirGCxgl7rwlySqwyadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSljBp30; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756120290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W239AlvnODs74e/fid8BQsKhtn+64cB0NifVKNxUMOk=;
	b=XSljBp30tUbRe6/+j7KG/hqNzLRusctGKdg3yh6btKXnQQRWPLE4i3Xyy2W5uVhgpZMYdh
	M59NKNApXhDlTDFSFpeoAZtqMtK9QnAzcjBScqmU12FvuQR+TaiM3MbzbTsncDo795fT3Z
	U+hipH/dt1CIGm8w9MDlIinLCq2co5s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-QMvEvE3CNVmE1Fg4jkIGgg-1; Mon,
 25 Aug 2025 07:11:27 -0400
X-MC-Unique: QMvEvE3CNVmE1Fg4jkIGgg-1
X-Mimecast-MFC-AGG-ID: QMvEvE3CNVmE1Fg4jkIGgg_1756120286
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6F71956089;
	Mon, 25 Aug 2025 11:11:26 +0000 (UTC)
Received: from queeg (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6163218003FC;
	Mon, 25 Aug 2025 11:11:24 +0000 (UTC)
From: Miroslav Lichvar <mlichvar@redhat.com>
To: netdev@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RESEND net-next] ptp: Limit time setting of PTP clocks
Date: Mon, 25 Aug 2025 13:11:13 +0200
Message-ID: <20250825111117.3846097-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
    Original submission: https://lkml.org/lkml/2024/9/9/999

 drivers/ptp/ptp_clock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1cc06b7cb17e..72cf00655391 100644
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
 
@@ -140,7 +143,14 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		if (!(tx->modes & ADJ_NANO))
 			ts.tv_nsec *= 1000;
 
-		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
+		/* Make sure the offset is valid */
+		err = ptp_clock_gettime(pc, &ts2);
+		if (err)
+			return err;
+		ts2 = timespec64_add(ts2, ts);
+
+		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC ||
+		    !timespec64_valid_settod(&ts2))
 			return -EINVAL;
 
 		kt = timespec64_to_ktime(ts);
-- 
2.50.1


