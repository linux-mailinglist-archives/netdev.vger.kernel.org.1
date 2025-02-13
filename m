Return-Path: <netdev+bounces-165823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92365A33734
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D27188BA69
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C41DB375;
	Thu, 13 Feb 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjGJYa9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149D1E48A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424143; cv=none; b=Ri/avYH8CRt8Me51c4yH9Ijwkqy1/e4gLvb90AldjVy6s4TVzx4e1pe2YkQK1Jf6KAb1sfNkFFuDG/U6EM3+QpQkr+BMV7MFLWS1HbvEZIQsZYt4NhyI+b9ZmjVF9fDBA20rrzsvnNx02ONI/JWh6UK7TBaenjZQ8l9QuCF/3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424143; c=relaxed/simple;
	bh=DVue2WP0B1H4wtQi9xUqEWep4mDrRrzuBpAWdVIvAXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fBl/3Lj/B6QsDyO7YUkuYO+0gkv3og48A/jXeVgFoTpPq9sRhZsvU0UZRIkDuUAPzmJ8IGCWkZyB6GR+0j4tSfi2gtXJckvZ6pf47g6WIXirHAwnP0xHfKdlqlufynmYdSazdePJP6FPb7yIhgPHxEWP+tqqEedQAyMM23bKQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjGJYa9k; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d132f16dso6063075ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 21:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739424141; x=1740028941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfOFzmJTomQrST1nXX1vPXO64UQnOtlJ7IWFbu5xl+U=;
        b=LjGJYa9kQE2EdDLSLrV2fgmIsCJ9YRydiS6BFxsBXI/ZZpWfFtDnSUmpzmijrpwxBR
         imkBnvDvp12C9ad1bb3JfP6ZM9x35dd6oOJ/ZJtALUg02mbqHssBhObgVKikpj0DeMEi
         vwA73HBZxf38oK5MHfv9y2SoNcLaB5A4w30xROmpUhqaTPlnDBD2ZwiY2aC6/hW0L8t4
         gugj3zfhghfJlzNuJpG5SAWXmugln59fT7cgphPbjbYlY/KgdVWjcmpdhunmpyjQDG8i
         iEuHmsnhcWyTmC1VUz8mSlL2PBPs3R+bZmKo4Kdkjus42RCejH2c+gxBZZ9oDUEnJjCM
         iNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424141; x=1740028941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfOFzmJTomQrST1nXX1vPXO64UQnOtlJ7IWFbu5xl+U=;
        b=TmoWx/cHTzqSra7w01MGn9fALBIvi6M98hl4y0UI7ugnEkv/dtQONbNQ2eSMMAapCd
         Rd+ZaCDo0ZfPD9um3Izo10mUx8Y6vl4Muwx7X6ih0yb5Yru7P3NXINpOCetmOgaRvMVn
         VU+0adzNz+a3czIIA8MW0qs2fHQnQfOQpxB8zrrmpeE3FLCsqxmbELJZQ0rv8IU8uWcn
         rdJFm3SbaOINroc+2GIOot27BQbs3bDyxp32BqLjSMSezZh4/kG6SlU8qGu87iPdMcC2
         frlUrQknCWxtprhK4s++++8mRj1csD/k+GW6RVPtLc8u5rX9bv+WCeVvAgTTi69KDgMm
         xHFw==
X-Gm-Message-State: AOJu0Yzr0Of1cgAT/3fUqHeI6jvoFQvv1zNH0DiLlF2uE2YfqeBppen6
	wH3Rk5fLCfBAJ7K+XsOKx/jjo6cyN4glRNITTFndGq5jjU0yLMMP
X-Gm-Gg: ASbGncvTpaZNLDpDvVTWQ5ZeBihc2FOGOLCSblaV33qQma++xyqMadNOaV1lQ/o9XCm
	4raSDpMCeHPcjA1S24s7NlUp6ztHG+89elQsrykqrhjZkNQGhXDsMWziDvkb7yOB3JK8jIa2Dcf
	rKThzTjjyn/rC2TxmhAIOdTaVRsDXJ6BDBgXbetgCmm6joEgRwdlFKheDXk78LARzS9QZxf/mjI
	2ThJLoAKiKJlWpVAILBB4hFZv7XuZqndmiC+RI40XfL/EL9Glx+aFlvqW48jlJeMYL7L+AU1PtX
	KbYdMPLYw9Ma+sqdVmxtq0iXJCBRtCb1X7smp5wSzSRmcGr+MPeeMzwft8gyumw=
X-Google-Smtp-Source: AGHT+IGgRRjy9GjNSFoMj2XCaQ4PCMRbO3ZTBb45L7ugoDcYpw9D9vusp6B3CE5b7MEpJjKU+k6Bmw==
X-Received: by 2002:a17:903:46c5:b0:220:c2bf:e8c6 with SMTP id d9443c01a7336-220c2bfec1dmr82243995ad.53.1739424141184;
        Wed, 12 Feb 2025 21:22:21 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm4228625ad.7.2025.02.12.21.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 21:22:20 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	almasrymina@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule delayed worker
Date: Thu, 13 Feb 2025 13:21:50 +0800
Message-Id: <20250213052150.18392-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We noticed the kworker in page_pool_release_retry() was waken
up repeatedly and infinitely in production because of the
buggy driver causing the inflight less than 0 and warning
us in page_pool_inflight()[1].

Since the inflight value goes negative, it means we should
not expect the whole page_pool to get back to work normally.

This patch mitigates the adverse effect by not rescheduling
the kworker when detecting the inflight negative in
page_pool_release_retry().

This patch allows to pr_warn() once in page_pool_release_retry()
in this case.

[1]
[Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
[Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
...
[Mon Feb 10 20:36:11 2025] Call Trace:
[Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
[Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
[Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
[Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
[Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
[Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
[Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
[Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
Note: before this patch, the above calltrace would flood the
dmesg due to repeated reschedule of release_dw kworker.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
v2
Link: https://lore.kernel.org/all/20250210130953.26831-1-kerneljasonxing@gmail.com/
1. add more details in commit message.
2. allow printing once when the inflight is negative.
3. correct the position where to stop the reschedule.
Suggested by Mina and Jakub.
---
 net/core/page_pool.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1c6fec08bc43..e1f89a19a6b6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1112,13 +1112,12 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
-		return;
 
 	/* Periodic warning for page pools the user can't see */
 	netdev = READ_ONCE(pool->slow.netdev);
 	if (time_after_eq(jiffies, pool->defer_warn) &&
-	    (!netdev || netdev == NET_PTR_POISON)) {
+	    (!netdev || netdev == NET_PTR_POISON) &&
+	    inflight != 0) {
 		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
 
 		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
@@ -1126,7 +1125,15 @@ static void page_pool_release_retry(struct work_struct *wq)
 		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
 	}
 
-	/* Still not ready to be disconnected, retry later */
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 *   in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
+		return;
+
 	schedule_delayed_work(&pool->release_dw, DEFER_TIME);
 }
 
-- 
2.43.5


