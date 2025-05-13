Return-Path: <netdev+bounces-190203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7FAB5854
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B0719E2976
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9B2C1E12;
	Tue, 13 May 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NMZXkrIO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGc7tcpW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3672C1E00;
	Tue, 13 May 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149214; cv=none; b=koBUdH2ZtLBabN32pNGZuUlilAaEXYlNcVZh9MYq3TzAOG+k11bA8IVtg/25GkOZXkC5xMHRcN5o+p3htEV4D7jmGEDUus12oAyrfqVN0RvNZer60s5Q2r4dd6l6ZGxSAv7aGA9NsFQnzryPdeUvlhj0zidirmZ7w1/Z06hzMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149214; c=relaxed/simple;
	bh=Z3OeIgNNvf+8U8VB8QsiVfDcY9uW7DIKl84gjExM2zY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OsiLTtFpZ5jKbQjGBPKKoIBMYbFjaciWCvb/doBNXDPYQ8hvAFptS/vyySc78rUsZGxIbP46Vq5v6lKpKmYeovtNr2ugbntRK3ByKGegiK4yq5Ogm1oHLanYlXQlDEJcaRYLiaUHOO/xk8NQwzdurCjIoLHmpkBn1s79pZEuvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NMZXkrIO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGc7tcpW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.799907954@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/YoB2Y/szX/3aLjPyHcg6yaHtAbNxEpl5yLobOxiZKI=;
	b=NMZXkrIO0c/JypbhWv9LrorjGB3VdMX1Q3X/aIFmrmiYhgPsBN2l/bCZChg43HmtHnSPXg
	casq8pmhPQaoDqjAAXYeayP99ILpHy6/VLrC/NPMWW3ZOK+OYaeieYHKqUEw8Zo3T9lBh4
	/6DG9Svjq7GCWHJownNtEwOee1UgtwziRT2Niy5Ohrmpu8mc33ADcQmPxBFBtvx2IciIv/
	nyMAP848DlkT1EjLIossoSOJ2w4olP/+sVon+2eWGfi2gxV2sg0GY/qMwJzWnMC7VhbnTj
	Rf14P+i/i5Mqmko5NpoUqYFzBJebOiKjb/OZerbuoT5OsYwS3M3Ga7c3/uETew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/YoB2Y/szX/3aLjPyHcg6yaHtAbNxEpl5yLobOxiZKI=;
	b=VGc7tcpWniRriVVr83N+/ev9FzqjDYtEhbsqBMaRD8At6ikrxN4ecX3G2LZJJvPbFOqKBz
	J6ZPH1VohS/iUNBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
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
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 19/26] timekeeping: Provide time setter for PTP clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:30 +0200 (CEST)

Add clocK_settime(2) support for PTP clocks. The function affects the PTP
offset which is added to the "monotonic" clock readout.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2759,9 +2759,48 @@ static int ptp_get_timespec(clockid_t id
 	return ktime_get_ptp_ts64(id, tp) ? 0 : -ENODEV;
 }
 
+static int ptp_clock_set(const clockid_t id, const struct timespec64 *tnew)
+{
+	struct tk_data *tkd = ptp_get_tk_data(id);
+	struct timekeeper *tks;
+	ktime_t tnow, nsecs;
+
+	if (!timespec64_valid_settod(tnew))
+		return -EINVAL;
+	if (!tkd)
+		return -ENODEV;
+
+	tks = &tkd->shadow_timekeeper;
+
+	guard(raw_spinlock_irq)(&tkd->lock);
+	if (!tks->clock_valid)
+		return -ENODEV;
+
+	/* Forward the timekeeper base time */
+	timekeeping_forward_now(tks);
+	/*
+	 * Get the updated base time. tkr_mono.base has not been
+	 * updated yet, so do that first. That makes the update
+	 * in timekeeping_update_from_shadow() redundant, but
+	 * that's harmless. After that @tnow can be calculated
+	 * by using tkr_mono::cycle_last, which has been set
+	 * by timekeeping_forward_now().
+	 */
+	tk_update_ktime_data(tks);
+	nsecs = timekeeping_cycles_to_ns(&tks->tkr_mono, tks->tkr_mono.cycle_last);
+	tnow = ktime_add(tks->tkr_mono.base, nsecs);
+
+	/* Calculate the new PTP offset */
+	tks->offs_ptp = ktime_sub(timespec64_to_ktime(*tnew), tnow);
+
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	return 0;
+}
+
 const struct k_clock clock_ptp = {
 	.clock_getres		= ptp_get_res,
 	.clock_get_timespec	= ptp_get_timespec,
+	.clock_set		= ptp_clock_set,
 };
 
 static __init void tk_ptp_setup(void)


