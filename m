Return-Path: <netdev+bounces-201297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4BAE8CAC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538D45A174D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2B2DF3D7;
	Wed, 25 Jun 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SS9nX4Oo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jGv6I14O"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B92DCC12;
	Wed, 25 Jun 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876718; cv=none; b=kWL16rIflJeber8Lyy7cS+tDTATKoa+SvdrvBjxV278s/nLnHSy3nMxpkuMZy7lSsZdTo5+s/HOMkr+eaS/gTygylmmJ/KxP4tpf6KtkPMo8C8aB4Dx4qVVapcn16i+ATvNCxYlu9KHJeVPxKqhnLW6qM4pNKamtLdVfV4mlTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876718; c=relaxed/simple;
	bh=P1gaIoRZW7JVP2+pj+bnWWNN0mZJt23YZ78CspdTUtA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rhv3WyOaVx/ZDBRdkT3wj2Ln/gKBHzz4y467OdUzrLQyHTMLaKVXQasw9fydhN3uHAn+ZMDWjpQkLhzA7Vm/74W+vj1b8tHD9Oe9h4TEe6efe301MtiiNjQeVSBmuMuq4IGls6ukwg7TRtRqCjSDHLcG7rTjRoBL0o2poU9Z8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SS9nX4Oo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jGv6I14O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183757.995688714@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0vRDZIPNBxbAaM5DrnSkm/14tGEp0N2O3kxgSR8yJBk=;
	b=SS9nX4OonfLY5825F33wK4iGe8fu66uOu6Y8yMSc+nlKdtAnzf/XAu7yoHOhHVjAk5A/q7
	gkpjNJnNd2GUsMpD8ZH5GyzrRH/304eLxlvL1pzRcRZKwRIQV7kcDXsdOFMq7SO1N6TZi1
	QUQfgz0dyXob//s7z8GRywMKziAowASlc8l2+vY1IXCNn8C9/ClMLVDsp++CjqQBB6Cocz
	31adtYou+vvP5/jBQft3PqBtqIVN3TTAXErWOga03TelyDSFJGxE5Ion7xrP4ThjR/K8S4
	cYXVHvU0BK2iEhyZhALGMcIhK8bmwGSgQEO3OOrUmEEyqbLRUyVG3S4E9xMzQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0vRDZIPNBxbAaM5DrnSkm/14tGEp0N2O3kxgSR8yJBk=;
	b=jGv6I14OSdBlJAM8JUoespWckVAgPsR7o0BpJwVtaI2hRcCar0jbVtB4D+h8VmCY4zquPD
	pVpTWM8s6VOsbACg==
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
Subject: [patch V3 04/11] timekeeping: Provide time setter for auxiliary
 clocks
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:34 +0200 (CEST)

Add clock_settime(2) support for auxiliary clocks. The function affects the
AUX offset which is added to the "monotonic" clock readout of these clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2757,9 +2757,48 @@ static int aux_get_timespec(clockid_t id
 	return ktime_get_aux_ts64(id, tp) ? 0 : -ENODEV;
 }
 
+static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
+{
+	struct tk_data *tkd = aux_get_tk_data(id);
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
+	/* Calculate the new AUX offset */
+	tks->offs_aux = ktime_sub(timespec64_to_ktime(*tnew), tnow);
+
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	return 0;
+}
+
 const struct k_clock clock_aux = {
 	.clock_getres		= aux_get_res,
 	.clock_get_timespec	= aux_get_timespec,
+	.clock_set		= aux_clock_set,
 };
 
 static __init void tk_aux_setup(void)




