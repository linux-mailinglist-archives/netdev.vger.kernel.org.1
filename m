Return-Path: <netdev+bounces-190198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3171AB5849
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A213BEEE4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38B2C0872;
	Tue, 13 May 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EFsIKMO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDzjieyh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73E2C0853;
	Tue, 13 May 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149204; cv=none; b=L4W6gar333iIW0/5StvHUQJ1VlN9+tiR1Cpy2+MCDI6f0BHBSeoghIXUxMY4iQ0yN2RZcIh9YRs0BG87LnElrsD3R1wCoXuN388q1Njghjq3ProQJlQmIdFoprsSlMrvJIBz1xj46q4ivWnejpkJZDTmqIcLQ3HVJbv6OrjezTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149204; c=relaxed/simple;
	bh=lB2z5dhrUGj7uJRON5wFn/Mo+auwXxtS7A3p44tVcvI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YGaiFiI3EAC4JJju4L74hDF7Zuau24El01jxornwZYec62xZ/tVZGWfXi/a2OlFGWb4tO0kgIr7AKiTQzJk98yz/FDNpWMuTO/9EQgRcDSi7QeJEzx2psO8b5yZbopOqqh6V3w8kAVqzYmUoRpiLl4HLX/5axud22DOMeL9t8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EFsIKMO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDzjieyh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.505757500@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CMH1qXsCMxTYZXTLpTnot3lsaPnEiJx9oFdezOyQlEI=;
	b=2EFsIKMOilr8dRRjFfxmpyCXUKIjeND4Ov1g3T5gGU8zsaQtJZazTLSb2asmHTFC7IYuHT
	/rdEXSPaG0TogdEdL3YYd5ps+11Q8VHq9MWv6tRZhV4sP2h+0QnIEzDrPseN9Hd50021a2
	qFVtliVvImm26iVZGhylW0GsMWSJGHRuyF7f5uB5814p2EBsIFnWpsVvVaRBXioE4pPjeo
	SvatDu/if4mpEwY6gRi37SSrf6I9ovU4RLISEqclnB6jmsmyy2Y0hO6I0z7KXCv0ia0WKI
	MlowdiIgrH0CqITJ5TBXD4LhahapNNomuBO5R6S3nuPVXy1OpwHSxMmSgTjbsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CMH1qXsCMxTYZXTLpTnot3lsaPnEiJx9oFdezOyQlEI=;
	b=LDzjieyh1OgSfHM2nqPjRGDzplmHIuyRa6DLASA2ge/Dx7kOxSztLvJRpEYQLjx0XRAHGE
	ET/dulurQCJFfoAA==
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
Subject: [patch 14/26] ntp: Use ktime_get_ntp_seconds()
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:20 +0200 (CEST)

Use ktime_get_ntp_seconds() to prepare for independent PTP clocks so that
the readout becomes per timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/ntp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -303,7 +303,7 @@ static void ntp_update_offset(struct ntp
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	real_secs = __ktime_get_real_seconds();
+	real_secs = ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 	secs = (long)(real_secs - ntpdata->time_reftime);
 	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
@@ -710,7 +710,7 @@ static inline void process_adj_status(st
 	 * reference time to current time.
 	 */
 	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
-		ntpdata->time_reftime = __ktime_get_real_seconds();
+		ntpdata->time_reftime = ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 
 	/* only set allowed bits */
 	ntpdata->time_status &= STA_RONLY;


