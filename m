Return-Path: <netdev+bounces-201569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA587AE9EBE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D118A1890B16
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C42E7F00;
	Thu, 26 Jun 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YRmchcvM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvzwNVKE"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EB2E7196;
	Thu, 26 Jun 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944459; cv=none; b=lCijEpVzESiqk+EyghwJkpW7wu9Y9J4/vqLBrqwCl8/g5xSd0zfvQrWCKHpSCf52eF1XotzkeoUT2AKGczZ4917wS666KShIgCI6yeqAmaiWsq83UqMIcSluRSYlDk8uJrHFkQ5MWTuWewZvS1nQnV0IRFjbebD/TLUDiYX752Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944459; c=relaxed/simple;
	bh=LQCtlrijMtzrLcCN//EaLeGrkvgwl9q1RRfITmiG/B8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=p6Yx9oF3KghzFbojxKkle3pmO0uyLyaroGkMD0ltuzONuiDhkSWUu5raqUXPBAZVXkkoM5cui42tTCdR7huhgRCQL2n+BGohEAGFngtFcCDmtgMYktBYdXYGKGrLhRy8s8830M8C4SEaAqxInt0T5ZselKxHHQfqgO0IoMpv5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YRmchcvM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pvzwNVKE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250626131708.544227586@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750944455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+23L/t+gK242K9oPEMEakcO6Zj9GwQnHSFFMgTm1G8c=;
	b=YRmchcvMjps2ADVLc2TaFrDyPuu15ZB7cri1Wsf7hDlY0q1PORGhE60Q6zjou10sHU2rsr
	Iww9aBaZtelcPeYTtB5egj1FczH0VkkoUXe/fOPOQhc46z7EqTnlyUujo/YXp+Hsi4UUpB
	t6JIxxGnYtGRMjseJfM4X0pUidBK4X7Bj4L0hZVTq7srSL3HCARk8RfDiTUk3fOng3Louk
	ZFDD29CxKE3kCWDXLdXVvLdvJvoc2Mah2durEecNxcZ7kO5Q1hZP7MzucqQeUXb6DrSzU/
	/yKRToHAhIeERxoO5XcBCwRFoTrE6sAB+UH2Zkhm2ks1OQaVPb5mlcrwezHodQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750944455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+23L/t+gK242K9oPEMEakcO6Zj9GwQnHSFFMgTm1G8c=;
	b=pvzwNVKEmDQDkK1zRoegaqYZWFHX7QzZppx2NTRNgkaJN0s8RZe1oNRYByTSrhq1L0hKBo
	g5F5fjvstS0ANoDw==
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
 Antoine Tenart <atenart@kernel.org>
Subject: [patch 3/3] ptp: Enable auxiliary clocks for PTP_SYS_OFFSET_EXTENDED
References: <20250626124327.667087805@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:27:34 +0200 (CEST)

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
---
 drivers/ptp/ptp_chardev.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -325,13 +325,19 @@ static long ptp_sys_offset_extended(stru
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
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	sts.clockid = extoff->clockid;
 	for (unsigned int i = 0; i < extoff->n_samples; i++) {
 		struct timespec64 ts;
@@ -340,6 +346,11 @@ static long ptp_sys_offset_extended(stru
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


