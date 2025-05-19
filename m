Return-Path: <netdev+bounces-191406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A560CABB745
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4173A165F4E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D618269AFA;
	Mon, 19 May 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b9DPsI0B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+zizoG2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56322AE5E;
	Mon, 19 May 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643599; cv=none; b=QEb+IysEYG/XGTwJaVBuGGD25mRobqSdjFeuQQR8F7JeYRD8m9Fj7yUnZFhRiajwjmP3WsL70/8/Q43RYnXDIPTLutC+hMF1V94HjlU2w7b1fkSu09F+mMbVDLNtUFu63oDV7Na0kcGpbvi7p2f0HQ4eByYm9JpwgjFlipxTWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643599; c=relaxed/simple;
	bh=H5LZ7r0BO9UJwvNwXDzJW1WeWZKHWrNuAEaUA+3FKfU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Wm0u6Pqz07Rhy8BixSbgA9IXSUuORmQ/IdgYRcF1LbV/DSEdfyXX2jGa+ReceraY55+kXRADthBZqcEoinNGiosYYX+29FjsU+fRVuJBwafLyIu9RvjA6GrGgqxRwsGv5o+tL4wE+Fd6uu3+70rqJQ1/mGj/hOqPCor3Y19dYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b9DPsI0B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+zizoG2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083025.652611452@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L4D9JRJvf/qDRslz7xOrYCaTiKUlQohZZE5tQ+PqCuE=;
	b=b9DPsI0BJ2Xs31QO5b3Kbpw+2wNdxYc+iCGmpuYq/BErwvTLjUImW5lE3z02uFtd/hXXz9
	2zv11Ht+4PCMGIRkOTuPSaUEi4GtI9ik8faT3fxbHqQp4KEGkeBmXdR6DGQ5Oq3vH/rxdS
	E0gHYd/RH3nPe24n8zFiTLeh7qPVMJ1IbVHLvdxYvt/ZQ98kGGU+vnTrOghuHsaVjV2wbX
	yC1zrEhaVgwQ26vbNOBqaSqv+YbM+xArYaUnq0oGtCSfkd2czQmDB9Xn2v+Pxl7A3hqbzk
	dGyYBK5k36/avVUVikvKWPCNtXvpiRFGf9eSeuZ1seoI+yDyHF5/OarXIrd+EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L4D9JRJvf/qDRslz7xOrYCaTiKUlQohZZE5tQ+PqCuE=;
	b=q+zizoG2VwQjhUVyzxmMJhM18LH66zqBww+UTPZb6k7Ej/XqJWRATlQyAf/dx03U4Ljdph
	zG4kBGoCZbwx3XDg==
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
Subject: [patch V2 01/26] timekeeping: Remove hardcoded access to tk_core
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:15 +0200 (CEST)

This was overlooked in the initial conversion. Use the provided pointer to
access the shadow timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -663,7 +663,7 @@ static void timekeeping_restore_shadow(s
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
 {
-	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+	struct timekeeper *tk = &tkd->shadow_timekeeper;
 
 	lockdep_assert_held(&tkd->lock);
 


