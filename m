Return-Path: <netdev+bounces-202916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C136BAEFAA5
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7883B1885CCB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBFE27877B;
	Tue,  1 Jul 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKBoF8ma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAK9c+19"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775E278165;
	Tue,  1 Jul 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376427; cv=none; b=Pm9vzhUHvJ1HtLycnvH/ktXuD6+B0/9mCtlCe/PwjWWynuAmwBAiRqjAyRa3WLWtDbTzt0bUYNZZl2pPB6FP518t87BmTMm2JIw4y0T2CRdXeW4+gvPD1JSfzzp+B+hQtRqs6Z5MpYUnPSP91doWap2l2pXS1IAN+OoosKoSTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376427; c=relaxed/simple;
	bh=tSPVatUC6106xSY/DkcKqZt7fOsBSjw2UHlC8GqVM/Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZU3B2Yb02Zt9oVI4cOcp5qeecUnkCED5p7/GgUH4Xb19b5KpyqPw43xb9WzTmQH/cFGhnYGwC2PJCAN2foUSh/iI0YDhCKRsmbE7vfUUqEOdcRHHlL1HsDDPShbvppZoDZi9t6NXrTGzTnbNidNzUcoj4EgvWljMQmQUIQIEAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKBoF8ma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MAK9c+19; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250701132628.491315452@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751376423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2FB1ANzWXeMVTJuQeYKJfA0PV4HDi8MoJnwt50Us4sE=;
	b=pKBoF8maFGlctet8tF2icHGXFy+e17xSa/BgecjbHgWVABXkXprFBbf6/YmHzDiuPkDq6p
	KXY9eMnZ53LKw0AaNJDoS6RBbmS0xqFncm7z3/f7cMpno3+/eOUQZz3Al/AhbzLSBREbXz
	E9+efNzSz81Rmr9VatBWqQo/cnq+D5Yse458jRqOMnk8Rx3kmMDKHrQznl5r2ePT7Y0lj/
	g2gpEuQaoj3vql5sPt1WVyAb4LuT5mT1oZMhXcpOCE2Jljz+SdBH+ZX/h4jHbeC4d84keb
	6gfvyEeShId9J2MKC/DmFXUxXSHj3aYNeP1h+es0b17HzRi1/IqlCu02YWdd7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751376423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2FB1ANzWXeMVTJuQeYKJfA0PV4HDi8MoJnwt50Us4sE=;
	b=MAK9c+19xvaHEvrlY0/sf4WYKkautjgVnrNUkQDkqQnOl4VNGlJ1AB+bdFGkfssIzkaz8O
	pOoyJB11nLp07BCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [patch V2 3/3] ptp: Enable auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
References: <20250701130923.579834908@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Jul 2025 15:27:02 +0200 (CEST)

Allow ioctl(PTP_SYS_OFFSET_EXTENDED*) to select CLOCK_AUX clock ids for
generating the pre and post hardware readout timestamps.

Aside of adding these clocks to the clock ID validation, this also requires
to check the timestamp to be valid, i.e. the seconds value being greater
than or equal zero. This is necessary because AUX clocks can be
asynchronously enabled or disabled, so there is no way to validate the
availability upfront.

The same could have been achieved by handing the return value of
ktime_get_aux_ts64() all the way down to the IOCTL call site, but that'd
require to modify all existing ptp::gettimex64() callbacks and their inner
call chains. The timestamp check achieves the same with less churn and less
complicated code all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
V2: Catch CONFIG_POSIX_AUX_CLOCKS=n right at the clockid check
---
 drivers/ptp/ptp_chardev.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -325,13 +325,22 @@ static long ptp_sys_offset_extended(stru
 	if (IS_ERR(extoff))
 		return PTR_ERR(extoff);
 
-	if (extoff->n_samples > PTP_MAX_SAMPLES ||
-	    extoff->rsv[0] || extoff->rsv[1] ||
-	    (extoff->clockid != CLOCK_REALTIME &&
-	     extoff->clockid != CLOCK_MONOTONIC &&
-	     extoff->clockid != CLOCK_MONOTONIC_RAW))
+	if (extoff->n_samples > PTP_MAX_SAMPLES || extoff->rsv[0] || extoff->rsv[1])
 		return -EINVAL;
 
+	switch (extoff->clockid) {
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
 	sts.clockid = extoff->clockid;
 	for (unsigned int i = 0; i < extoff->n_samples; i++) {
 		struct timespec64 ts;
@@ -340,6 +349,11 @@ static long ptp_sys_offset_extended(stru
 		err = ptp->info->gettimex64(ptp->info, &ts, &sts);
 		if (err)
 			return err;
+
+		/* Filter out disabled or unavailable clocks */
+		if (sts.pre_ts.tv_sec < 0 || sts.post_ts.tv_sec < 0)
+			return -EINVAL;
+
 		extoff->ts[i][0].sec = sts.pre_ts.tv_sec;
 		extoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
 		extoff->ts[i][1].sec = ts.tv_sec;


