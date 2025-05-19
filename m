Return-Path: <netdev+bounces-191421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D4ABB76F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1473D3B93E4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A2270EC3;
	Mon, 19 May 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmV0e4Uh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXYVZJ+b"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05C27054E;
	Mon, 19 May 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643615; cv=none; b=AosxhD0xzFJzPLDZkRTLzSzRCgRsIwqUKlNSMDvuzck/bKoLXjDGwXsNWT0ZZI2DF+XcrGp627Dz6/ErZKQCB8zOizrk7bqKi8ouUI+iKuPAzuq5UorvBCmkGQN1iJ9cZq38JkAqRzRtTDz0VGfEfyoMBJ5npEYmwtpz0T3EYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643615; c=relaxed/simple;
	bh=imEIHk/EPAtoQkxPLF4zSpQlLZtLGmQXx7lY6KkYsEY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LKsO2tiBTmxQGYDzyVQmHmYd2608rtNeEMIJgOolb1+UIjIf75Sr5aDYKozsfifiRcv0e2nCa4V+ehFFvyjTglv0px+vT5IHDeHM+W2kf+e1cnCO84wbZW6Lv72zdn8CHHHbRJvJC1TVBtDDDk7w6c5mRYzo1eSJv6jqr9mzISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmV0e4Uh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXYVZJ+b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.533486349@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rlC+rFNEoM7UPzOHkW+/tvvtNAKD9S1u+ELe68/TTuI=;
	b=wmV0e4Uh9fdijt6SSytVnFzVYRLeMfY6fDOwVnB7OcGnt8BbF6yN8CC7EVB3OwiQG3F5xP
	0AuZQbRCLJpq1rxIb2cxNXzsXnxTeyEiHq+KjZ1yWj/tfsi2kx9FUvm/88UtB6XJScxd4e
	BRfcUTnMJVXbftXsCSuNGt+jHbCdgWQu3j5yYHzmKLgxu+HhkbR5ITriUzdckg4d3RhE3i
	XuhabMW/aMZjSikfwvvohBPBc+xa6g3q0UT0jtdaB2ZsFZbwS+1siCcLI9ip8B9vazhWvp
	43kf8z+KrCTKriOkLT/UMf2BSLZcWmfHF2ljbXMtTk5veD6+QPNqQMYsaUbYtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rlC+rFNEoM7UPzOHkW+/tvvtNAKD9S1u+ELe68/TTuI=;
	b=dXYVZJ+bTydoz5XwCxVi2vZFt7ahUJig9uUd3rUe4XD/qFe6f8ZMjMNseeQv3Cz9QIwc1u
	gPpHz3nlr6JWSWAw==
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
Subject: [patch V2 15/26] timekeeping: Add AUX offset to struct timekeeper
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:32 +0200 (CEST)

This offset will be used in the time getters of auxiliary clocks. It is
added to the "monotonic" clock readout.

As auxiliary clocks do not utilize the offset fields of the core time
keeper, this is just an alias for offs_tai, so that the cache line layout
stays the same.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeper_internal.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -67,6 +67,7 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
+ * @offs_aux:			Offset clock monotonic -> clock AUX
  * @coarse_nsec:		The nanoseconds part for coarse time getters
  * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
@@ -139,7 +140,10 @@ struct timekeeper {
 	struct timespec64	wall_to_monotonic;
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
-	ktime_t			offs_tai;
+	union {
+		ktime_t		offs_tai;
+		ktime_t		offs_aux;
+	};
 	u32			coarse_nsec;
 	enum timekeeper_ids	id;
 


