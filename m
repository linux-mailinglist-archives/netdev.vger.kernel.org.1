Return-Path: <netdev+bounces-203653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08754AF69EF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEEC4A4629
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC31F419B;
	Thu,  3 Jul 2025 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpp584M9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF6225D6;
	Thu,  3 Jul 2025 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522041; cv=none; b=Pe4ZHY7kMoQtRlQXJCRp9SHJT+/xpWJXrvTaG2OinA1bFGRjZdLMsLcD8QyoAfpiA7rLL4B6fKbsopiLVi1Q83VqiCEm0sIDX41OTvmK/2n4Dgc0Tfzq/BPZcJLljM0eYyQsasfVD01nKKk01z21vm3XzJrRsWhcUspcj7eX2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522041; c=relaxed/simple;
	bh=rT1y8nJt0iqw2xQ3Yvtq1xi+G9ngpKC67/tgoQ9J76s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Di1brGJSxsUKbR/FaTHwUQJLI4o2fuSKOKTT0l3Qq5YJzhTjkEBVe9FtgLtWMwAnJD335l0WzYy2RUtpcrcLbzzIpmBsuJaXAx+6CRatdoQK/nu5jxxSfSGCnv8C1Z+lcwGXWB/mLVUruHfimXpAZ3ucI6VRmdN41VSzuScI0Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpp584M9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so6353392a12.2;
        Wed, 02 Jul 2025 22:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751522039; x=1752126839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk6iQBYp7da4sAqERoGPXU7LoCezRk4qLu7CPqFiG6A=;
        b=Zpp584M9NlDIveIDP64UFk4xHwyX1m2FT1BI4GOS0TZmbT6Eeoy6RrKQ5mfeg2ZZq4
         o3aeiByctLKVQOprxhkw73nmnSmhLBoBaoX+aVSnSUHxXJEqKXC/PLWXLKHSYXvmjfu3
         71KCmULOIvfnbNZr1Dp2A6lIKYoebCDpZzs9Vj666lhKfF1EbiDk6YmSfBtenaJA+D6V
         7GWr491KLFhaO2p7p3WxUaea0UE2fAGjeRCbc3Oz6S4fGIMHFsH6rMAawid2agJ1aBav
         CiL9CA6Ru8/c797NwT8gUHn3SZ9NNT2hYP5o7BMSmi3VeKRIA2C70Siav/Sl6Cs4SyOB
         a8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751522039; x=1752126839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk6iQBYp7da4sAqERoGPXU7LoCezRk4qLu7CPqFiG6A=;
        b=GYqAmMWjgCcuoL63COIyyx3DafNm6p6jKODpu0l6JhyQ+gECEtSgUuENxBm/xLP63d
         RHfCVe1QCVhvL8xs6i2C4Z0waLD6bd2boTX0VajeHs9Q4t0wGUSAHt3wZ7LvpqI4eMdQ
         MBVz7+zr2Pddy0Va0vNE0dw5RVoxb0f/2xgo8hS3FT/Ec8FpzC0qxrHOg9DOdo0yT3Aq
         SbTowY6ldHC8Q+T3iaHpFSh7J8IcvhQ4lNWBu2RyIIDqlx4VVjngVHIvmr260IV4jGcR
         PSy3uTtr/d0Dpl3o676Z/PMvEvvG6NW/LSKRAcYk9hQSFpGbqVBcKJVku/+gs+oIkDnZ
         dBIw==
X-Forwarded-Encrypted: i=1; AJvYcCUu2HaL0xJtMmGlHux46sERKa5covhSWJXxcXWM8FkQboKZyOq5rQLr1M3pB7PxxFxzFPUWTNHM/z8XXJ8=@vger.kernel.org, AJvYcCXB6Wzm34URxXl9AIk3K7Rl/PUeZR6qragvS+2JJhBcQrJrxabv3RHL69a60xxHj3fUJVkRUaAI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/smv01F7gWSPy3jwcFWB5sNHn4HHuTQ/MUoHOOWQPOIQ+BCw
	X/cQ6vvpN9pG/XFKnSRP0bdxIqHajNdvPipQ8aGr4oAvjH6YPyuAGoNB
X-Gm-Gg: ASbGncsH5OLbXkJrP/bS9gyak8IxYDzP2auZaAreK9iTrSG6DJGpNIAwV5iOryriw29
	nWeqfs6oBf3e+DNQT7RwB2KJarzW4Sh6AcfshQmjSLz6ciNIflam9NriuYgeXERgHeuAptxw9pV
	CD/cK2/gMiAZO4vvmg8+lfy8Qt2HV6Qqzjp+/XTCotBekCkXCL0duva58Sm4qhlFD5LzIRmKdv2
	SlNBPZD/kIn9GIgT5ZT5bpuZTkuUTw6eMFuymQjqzDsw24+++F8jYmd1gBJDUg99JnE0BAyDOv8
	CkKXUa7pwlXmNQkXo/JnW6T85DoR5Mxzc1OtXopdjmjfWFuxss/lCuAoyXGO9NcB5ZrT/x66Rg=
	=
X-Google-Smtp-Source: AGHT+IFwzAIRKev4yN/fyxXsQI9UaFX18Mxi3WY67LlEdxZa9cA5kZnhm721nDzdQR/ClMYdJQUw5A==
X-Received: by 2002:a17:90b:2d8f:b0:312:e76f:5213 with SMTP id 98e67ed59e1d1-31a9df94cacmr2237024a91.28.1751522039143;
        Wed, 02 Jul 2025 22:53:59 -0700 (PDT)
Received: from localhost.localdomain ([118.46.108.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc4e102sm1457252a91.3.2025.07.02.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 22:53:58 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net-next v2] ptp: remove unnecessary mutex lock in ptp_clock_unregister()
Date: Thu,  3 Jul 2025 14:53:40 +0900
Message-ID: <20250703055340.55158-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_unregister() is called by ptp core and several drivers that
require ptp clock feature. And in this function, ptp_vclock_in_use()
is called to check if ptp virtual clock is in use, and
ptp->is_virtual_clock, ptp->n_vclocks are checked.

It is true that you should always check ptp->is_virtual_clock to see if
you are using ptp virtual clock, but you do not necessarily need to
check ptp->n_vclocks.

ptp->n_vclocks is a feature need by ptp sysfs or some ptp cores, so in
most cases, except for these callers, it is not necessary to check.

The problem is that ptp_clock_unregister() checks ptp->n_vclocks even
when called by a driver other than the ptp core, and acquires
ptp->n_vclocks_mux to avoid concurrency issues when checking.

I think this logic is inefficient, so I think it would be appropriate to
modify the caller function that must check ptp->n_vclocks to check
ptp->n_vclocks in advance before calling ptp_clock_unregister().

Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v2: Add CC Vladimir
- Link to v1: https://lore.kernel.org/all/20250701170353.7255-1-aha310510@gmail.com/
---
 drivers/ptp/ptp_clock.c   |  2 +-
 drivers/ptp/ptp_private.h | 34 +++++++++-------------------------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 36f57d7b4a66..db6e03072fba 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -413,7 +413,7 @@ static int unregister_vclock(struct device *dev, void *data)
 
 int ptp_clock_unregister(struct ptp_clock *ptp)
 {
-	if (ptp_vclock_in_use(ptp)) {
+	if (!ptp->is_virtual_clock) {
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
 	}
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index a6aad743c282..9b308461fcc8 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -95,39 +95,23 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 	return cnt < 0 ? PTP_MAX_TIMESTAMPS + cnt : cnt;
 }
 
-/* Check if ptp virtual clock is in use */
-static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
+/* Check if ptp clock shall be free running */
+static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
 {
-	bool in_use = false;
-
-	/* Virtual clocks can't be stacked on top of virtual clocks.
-	 * Avoid acquiring the n_vclocks_mux on virtual clocks, to allow this
-	 * function to be called from code paths where the n_vclocks_mux of the
-	 * parent physical clock is already held. Functionally that's not an
-	 * issue, but lockdep would complain, because they have the same lock
-	 * class.
-	 */
-	if (ptp->is_virtual_clock)
-		return false;
+	bool ret = false;
+
+	if (ptp->has_cycles)
+		return ret;
 
 	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
 		return true;
 
-	if (ptp->n_vclocks)
-		in_use = true;
+	if (!ptp->is_virtual_clock && ptp->n_vclocks)
+		ret = true;
 
 	mutex_unlock(&ptp->n_vclocks_mux);
 
-	return in_use;
-}
-
-/* Check if ptp clock shall be free running */
-static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
-{
-	if (ptp->has_cycles)
-		return false;
-
-	return ptp_vclock_in_use(ptp);
+	return ret;
 }
 
 extern const struct class ptp_class;
--

