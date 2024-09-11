Return-Path: <netdev+bounces-127403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1197541C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203D21C22977
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD61B532C;
	Wed, 11 Sep 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h5VWUM0Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LEKMwav+"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8D1AD3E1;
	Wed, 11 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061414; cv=none; b=qMLGS1TwyiGL9PkFlZ/tmPmrbSbg1Ox/oJpnphvKwEY5MJnIbO3Kon/DTsmrkw9T4t8GvxLc1T0tx5nC/tSeZKHJySQGuO5SLHRHvpb4EXbgCF81GB0gEFYU0tld7qPQHTUxYu+ftBRVWBpIb1+JeP6u0CA86O8sDR2oU/aOd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061414; c=relaxed/simple;
	bh=WJCbDopLz7Y/MGb+lX6DAG9uYE7sOy1FNUCeNdZnvNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3LqUcfABzWQpahaGxVmPSZiY8n3bwxeVSuHsKOt+M3NxOVibu9SMFdJFbOYG7wNwGnaaYc2cUNN+Px4ZwWgS+tKcVcw6flsJxnvruqzPH2OC6icexnQUp8DF4lih3YHcZBk0Nrmcajwf2GIRiw8Db8SaGbHv0w141k9jqoaWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h5VWUM0Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LEKMwav+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8CKPlfztLygrQgJmf1fIFEFAx796WpVuqoacpeXwfo=;
	b=h5VWUM0ZzJHCoQLt59tCScuC1/GosL6znGQ7dGlIaSMkgNuz7K30yJf8OiWzQtRJ5iS6nU
	AX3+d6h63qM6cKxlBOsKiCm2EHU/x18eo835ZycJIAz0yBJFwhhufACBiIdTJLTOShMyYK
	WVfhnp8acZC3hTsWfBxV9jq8sLOYgIr9Ppu9+Et3y/3rpiaBkwcL6PHrXFtLMTXuGyg3RG
	uqy/Y4gML6f8RLFxQka00DclOzQz0YoZEsUza+6FEPDz8vQ9fQuZxaFN+Kp+O75omc9ZzG
	kuyrRgBgmgI0xGVWQF7ZlIwm9uXyutf0XNjbmzOXGeMVl0KKHfPolD8jtTStoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8CKPlfztLygrQgJmf1fIFEFAx796WpVuqoacpeXwfo=;
	b=LEKMwav+iUSADNN3Y42GxMJnWdsR1/5JxaQmKdN/lA1AEJjXii0dr6TrSxv5iN7/ti2Zp4
	Vuc57XUhS+4U5cDQ==
Date: Wed, 11 Sep 2024 15:30:07 +0200
Subject: [PATCH 23/24] timekeeping: Remove TK_MIRROR timekeeping_update()
 action
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-23-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

All call sites of using TK_MIRROR flag in timekeeping_update() are
gone. The TK_MIRROR dependent code path is therefore dead code.

Remove it along with the TK_MIRROR define.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cbca0351ceca..6aa77cec23f8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -30,8 +30,7 @@
 #include "timekeeping_internal.h"
 
 #define TK_CLEAR_NTP		(1 << 0)
-#define TK_MIRROR		(1 << 1)
-#define TK_CLOCK_WAS_SET	(1 << 2)
+#define TK_CLOCK_WAS_SET	(1 << 1)
 
 #define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
 
@@ -797,13 +796,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-	/*
-	 * The mirroring of the data to the shadow-timekeeper needs
-	 * to happen last here to ensure we don't over-write the
-	 * timekeeper structure on the next update with stale data
-	 */
-	if (action & TK_MIRROR)
-		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)

-- 
2.39.2


