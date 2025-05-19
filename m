Return-Path: <netdev+bounces-191430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B5ABB785
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E9E18846EC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A96276034;
	Mon, 19 May 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdUe7wne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ft1ugcU/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7D275111;
	Mon, 19 May 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643626; cv=none; b=qjyqWmt0jU5XF1UF43927GAo0u5rmidTdY6XO6sjCqtC/iN63X+HAcpg/dazjsKCgQ32Dvk2oXCBcE2GMLKu52YrF9dLP7Wm61ALBCxUqE4lXD6wWC/+bFQLLVNIQUSBGpg8BrjoQTaqmUw8NfuuXyMFA6Z+dyqCyyJlyCbANQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643626; c=relaxed/simple;
	bh=/yvQ5d85ORUDtBs4xTz9aRwb5nKG4+IlF2ndIStdpeM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HdWDAWcdp4yQiHo6oG8kWO9e/Wz8NiH0WsFtjYFnuppgtnIkQL11O5BFLTho8IjeUow5M7NVAMe8yfRa4GUJRGVgcmJ2Ik+SrdKVyTR0BgXXqFpDdk/D0ckrU+UdBtgpKgR5N8pw8BqnTL2fjbr21rzOzE3oi2+Lit6jHcQzRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdUe7wne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ft1ugcU/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083027.084196985@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xOJpwZxqnxHnJfwGF114Z3PUlwN9EdN52IlzQAPgVbw=;
	b=kdUe7wnevZ4tF5B8BACtqXOdd6UtmQ8bt5lYryDyBJQa8iWxIg6CvbYpIC++PHoX5KxFYb
	tID5a0GqNOoHrylyIFCL3h7i49vwT++qQaTxCXExluzzCkT/nQt03j0GH6U7NSUbHOL/Jp
	uhwjKQyv67hRXub0KDuUKzFCKxHLB2Dd/X1xH5haacHthw0FqQPCdqyjUfr6NXo9dn/zBm
	k3x+fbDfBIeS40cB5yb79s3QQiZEpbBcGpQFgCM93Gz5FqXlVeDzivq64Dln5z5F626gLY
	7OS/YhwgDcYSSizMmWeWbWJc+vbRCxeCqg7S+C5uOjfEeG+KCQSRpx+1IV1KpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xOJpwZxqnxHnJfwGF114Z3PUlwN9EdN52IlzQAPgVbw=;
	b=ft1ugcU/HXbaxmcG2/oXcrJ21nP3iERg88KQ741ZRKEnJHvzbVQP35sMhsz7d+l4pW3tnb
	cWb4JRdHvuQE0rBQ==
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
Subject: [patch V2 24/26] timekeeping: Provide adjtimex() for auxiliary clocks
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:43 +0200 (CEST)

The behaviour is close to clock_adtime(CLOCK_REALTIME) with the
following differences:

  1) ADJ_SETOFFSET adjusts the auxiliary clock offset
  
  2) ADJ_TAI is not supported

  3) Leap seconds are not supported

  4) PPS is not supported

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2860,10 +2860,26 @@ static int aux_clock_set(const clockid_t
 	return 0;
 }
 
+static int aux_clock_adj(const clockid_t id, struct __kernel_timex *txc)
+{
+	struct tk_data *tkd = aux_get_tk_data(id);
+	struct adjtimex_result result = { };
+
+	if (!tkd)
+		return -ENODEV;
+
+	/*
+	 * @result is ignored for now as there are neither hrtimers nor a
+	 * RTC related to auxiliary clocks for now.
+	 */
+	return __do_adjtimex(tkd, txc, &result);
+}
+
 const struct k_clock clock_aux = {
 	.clock_getres		= aux_get_res,
 	.clock_get_timespec	= aux_get_timespec,
 	.clock_set		= aux_clock_set,
+	.clock_adj		= aux_clock_adj,
 };
 
 static __init void tk_aux_setup(void)


