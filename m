Return-Path: <netdev+bounces-203011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660E7AF0146
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44180171F7D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545012797B5;
	Tue,  1 Jul 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lamIdTOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CF1C3306;
	Tue,  1 Jul 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389540; cv=none; b=tQOMGsFQwgvY3rRn4Ci+R0DsFuDa9oEpe5kkGSoXk+bw/Q7aBrK5MGgCg9byd1fo3fgvY1NrcbK08aKkDFjmsjuFbK4JJpmyUgY2FMdhBKAdltLpUlwlo0zAk0OaVm8w+YkxptXGZi8gaYeboDw3WA4BnJKQ2+fN/Dv3ozGLUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389540; c=relaxed/simple;
	bh=3PeqLL7MmBnITYF6ZpWMf/sxV6skJBv/Mia19Fd0wbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DySC2Jeug1MYdsadMzjuWujQu2fjSoZqMej2Bwsd6QD8JOInJelPCxZLJWcsN+2+WMPMwfFGu/Ow6Tu93FtZpKBV1rMm4bpqrSBt3GTqRKqy9bqVlqJ/GQDEXDHjUvx05NyVhibHZ9EtLFsd7IeiPSWxYCyDHYYcTV1reqElgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lamIdTOr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313910f392dso2663830a91.2;
        Tue, 01 Jul 2025 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389538; x=1751994338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14AtEWASDbQcMrRLN/AjV1PxalbKqaf9kxW8P+HdVyM=;
        b=lamIdTOrB3QYln4xt+Ur7mcQ23nKG9sZu22HnNYanUAsB5iB7QUTMVgHflyaOVzv39
         kAZJSgTfDmudIRDP/EbS7O8WOXENJUCmzLMntKzBFKJ0vsvnrc91LMy5Q6iSJ+flRKnK
         rXgyYQiH5kTCVSVeUdTNPxSm5ucsoM1Y1hy/YoKG5vlv458zfmRuFwufK9Js7QsuJcS+
         rEUvrqd+n6kBwRdy8XCBLvk2pgtCmMaGkiDDe70fTQKzrpIZI+8691X6c42IQoysl+gU
         F+ZblP/t5HCH/fQL6FkHPffeX9cGwfj7QiknCjt623lRsjOnjDeHLE+9sSI9l5zX6ZC4
         bgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389538; x=1751994338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14AtEWASDbQcMrRLN/AjV1PxalbKqaf9kxW8P+HdVyM=;
        b=ir9GX0m2RYBobIzrxyTvoDWpkfq9aPcxcSrCnyZ+booBKHV5z2+0ZFMfmJwT720vHl
         6+KUcR0mcAm/9Y4HTyHBFTEbJHKFDbruUm6cQGkNFW94z1ig2lihYFy0XP8Gff8VtMkb
         3D2pRCi8tpzILSapGBB9n2pWaYmdaCq8aZbqjnyXL/avYUAaH/eMy/nrzvEEoN/G15x+
         mp8hqdpNKi1aQitoHkF9gpQM5sVXd5FNH8MYeRULVyR/+LJu8r++BuyC1LmEECXOn+D7
         tVF99yb4qwDUaKiQ8YULlueB1sL8SmCZlkfWZkYytoUqZTlClQWjP7Zm8h+ZFkXU6kl7
         wj7g==
X-Forwarded-Encrypted: i=1; AJvYcCVZbS0fGVt6NvsDDf0kVxRGmzR0B2MGaXfaswef/fhG8tqivotxBEKJYlznR1tBMPNmZoi2CpWP8NTQzcA=@vger.kernel.org, AJvYcCVh99sNIlGsyzl7ckFN2TDCD+AIJaEl7Ch7SG/4rh4TsnWHPRXQY3F4Izd1FdC7JCIPtKFJtEde@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDb/yAch025soXMOwFAj0DxKfeATynwcDFM0zW5AvNpzVm3zi
	zPjmbbfHl0hGxTNUpB76GSbo+EbblZcaKTRZaxBVxifSgPdAZNBmlx8J
X-Gm-Gg: ASbGncs/D6Q1tqHxpVnsuWVvNrQ9GgRYmBCloKXvEGbecthI7nM2KZ5gtx6OevhIXxy
	RAFw5yx3f0G2V2QbF6u4KQrKUwFcaC7SEfNFTeAMsYtPqBKIX+IQ8MO3VA9tdsBbICV1rWjau37
	zJqik9cQlTmlpeztO3uCjy0Nzp2kL82fWTcisC2tF5Ifc0ggLJFgBT3UT88rMJrd81pgsZvnH/r
	CE8+5Q5SlBR3trVPUNKGkWkmoqsEdKkA0fcx+KOoB21OrXvUtyZv0gL+Owk8VBWa9f2Fhvun0mx
	yZnJujs1CbjCKgiR0sqMFDH4MhvjVYnOyXCKBAy7SzENKjeIZ8UxggZyGSTSi1JZKGjbTIJXKwg
	p
X-Google-Smtp-Source: AGHT+IGpbx3xICIFTBJaWCKXAXPyszPU3kpAkEkC3Kx9MGxKXpGrE50T2HK7GgJeTdO7iTngBjisdQ==
X-Received: by 2002:a17:90b:3b47:b0:311:d670:a10d with SMTP id 98e67ed59e1d1-318c92ee549mr22850865a91.26.1751389537753;
        Tue, 01 Jul 2025 10:05:37 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5437a0bsm16039494a91.35.2025.07.01.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:05:37 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net-next] ptp: remove unnecessary mutex lock in ptp_clock_unregister()
Date: Wed,  2 Jul 2025 02:03:53 +0900
Message-ID: <20250701170353.7255-1-aha310510@gmail.com>
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

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
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

