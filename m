Return-Path: <netdev+bounces-133513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFEF99629B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7147C1C218EF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB5188929;
	Wed,  9 Oct 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhIQdmaw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/rUXg3ja"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11B18871D;
	Wed,  9 Oct 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462558; cv=none; b=Zq0V5n1x+MJreQ7FSi+EUanhlSgubx6+doLKPrvNMV2VDOM5ghmoJBIDnrkZDEhSfz0OcPRIFElUSdUUJM+d19PDMyGNwwKuWQxtIcAsyGyaA/OfxYgQpGKNgnpFC2pHY6fh6F+fvjgw1aybNIwWO7e+n59nckt38MAQpP5qdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462558; c=relaxed/simple;
	bh=Vmv3Ug/H9zP/x9oaSfMaN3Bjme40VaX6S9AQQdUuQbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjqKVfCMZGl0tNHUKV5eK4H95InHTvSS3jyno5wWR/WPqU5mhvcsjzC8CQA45dZMXniUpGqjKuGD8/ub0hqx3PLm2VpYrbHYn2fuzpLjdsSHpw8urxRBsd0eWXyXJKJZLDeWJDJAqEYMIRqY3FPTQ07K9VC72deM56HbQyFL5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhIQdmaw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/rUXg3ja; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4otxVIHP6NRuH18Zefj2/uhmVo7zXK2jePiVQ9Mnwyw=;
	b=GhIQdmawFkoScx06Bu4wJr0dVyZiPNG4DuhRF0NTSDM8uhW5+F7cTZwot4mkpgUzSYIH18
	Y9GfLj3yio93VFda19xql3npI51uovymenMeNqQ/CuB6766IYtjGhwg7GbE1JZOUvBg7t0
	iEzePBsdmb0t8HFC3XridC9cBPfEpHiCNICAgX3HTc7ALfN/7w2O4kwwHxBq7yw/4Z21/3
	i97AqMDZbNAQJvXSvTrNst8FNsVf503Lf6h0iadGYOdGquG5oOGnah8LRDLicQE7PXn8+T
	s/5OE4mJ8L8Pa3bAHtKGd/BOA7pDyMrom7OveCzjoktWAQ6Xps1ikdf2Wb1bIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4otxVIHP6NRuH18Zefj2/uhmVo7zXK2jePiVQ9Mnwyw=;
	b=/rUXg3jaDMmfAE3jz4AWfSmut6UDck7Tj3M+414u7khMv9jFBYEnpgcQC9oDk5iD+bAEiB
	l5uhsQ+yKYz62BBw==
Date: Wed, 09 Oct 2024 10:28:54 +0200
Subject: [PATCH v2 01/25] timekeeping: Read NTP tick length only once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

No point in reading it a second time when the comparison fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409bf311..6acff4cb7b1c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2130,16 +2130,17 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
+	u64 ntp_tl = ntp_tick_length();
 	u32 mult;
 
 	/*
 	 * Determine the multiplier from the current NTP tick length.
 	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	if (likely(tk->ntp_tick == ntp_tick_length())) {
+	if (likely(tk->ntp_tick == ntp_tl)) {
 		mult = tk->tkr_mono.mult - tk->ntp_err_mult;
 	} else {
-		tk->ntp_tick = ntp_tick_length();
+		tk->ntp_tick = ntp_tl;
 		mult = div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
 				 tk->xtime_remainder, tk->cycle_interval);
 	}

-- 
2.39.5


