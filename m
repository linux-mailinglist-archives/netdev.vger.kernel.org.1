Return-Path: <netdev+bounces-166316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92376A35755
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB857A3067
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2AD202C4C;
	Fri, 14 Feb 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiBROJAd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B11FFC63
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515382; cv=none; b=XvMUUpVK5s8aMGdhLCQWbTy3ebiQ0DWzHQZUf6541Z/vBQMIqguKe99C6KvIKHIAnxmTInA7Vdse6y2WNly7ZHf71yPCfiULVjETtMW45JEBgMR+2FLlYnPaJiKUVuchT7ezbRIXcQkfHB4xcVRQ68Jfphz7cshdBrGkLVL5qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515382; c=relaxed/simple;
	bh=PtyoGLGw8IVrBKEWpULXxxcFvaXaePzgliOlCu2oe2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLmICAQ3G7sfXXEqSTmqaX4deIGajmAJch8pw/OjwPAt4QNLiHByg7MpsIVZZBKN8oEAbBPTY0a0czmab19ZEjfg7aCmxHG7vSQa3sGCHXfQcP/72oCbfsuoFYjExvsz9ExXxa8sJshw78xquVTB+RJxc8PSArbQ1v6bFzzq740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiBROJAd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220ec47991aso6959805ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739515380; x=1740120180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41iHSWGkTEHehrErTs64VtqmmrQo94r4ocjInjarKdQ=;
        b=JiBROJAd+K3GlyTywlCYh3KpsmmEjSku0jh40O3KFMR3IJvgYtmzyqpAd4VW1/OzjV
         cMjkpIYbe74P7PCoGZ8yq+SHNBznMGljs2IOShy2sAGN/FJnoZHy2eYFQz2njDcty48y
         CS2F6OoVqFL/8DnA9+yjrv34FpYxSQjbuVqcHLZ756SdsrFrEeiJpntLppAMZM1LBI3R
         NJDts1BS7m8viiwVyj1o570VMJtqUXDNk5fNaOUPCj7u31ruGDwyYQWb7rNao4rxEFJD
         GJ4ykNKjXXXI5QMr53Auy5lTrsMntNyV/26C2zBbkoB4z4te7faf1af/0X97fcSv7sBV
         hCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515380; x=1740120180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41iHSWGkTEHehrErTs64VtqmmrQo94r4ocjInjarKdQ=;
        b=S68L1A6Wepme4KCimCblrf15ioWQi26Um+sz/yl0j6XpeHcGc3syXqYdl3vPcXHHyN
         DVv6q+UFobZD+eUwBbcp84J1HnBWxr/KB9R4J08x94AYkxmyPYWjE6AdPe//IdIPb4WV
         LNOKKR2vp6Lv9xujmHEGa+jpGJ/QB9jW//sFHtUm/CkzxjNGrfppogNf7St/t8/rutqN
         1CUA5U8/mtOvXNIzbaJrNjWPkx72fFBOyUv2JUNEzCFCNMoApDsYfYYO27GhYMGdCHcG
         7/tjINkb8LD+9sc8gRdTaGqIJea7+W+VfUonYR/6Sy+Yb4GgKkrK6ggjELFdTHrCkb8p
         Gtog==
X-Gm-Message-State: AOJu0YzRjxLMfnPCsztJeRQqaPQiTa7RCKLpvSRpEOGcVNuU04Tlbzso
	1pextLl3gMSD3GVJibtlY/0CerCFsOIR6d94r5wXRR5aOx2AjSeH
X-Gm-Gg: ASbGncv7jXgOV+8fDLv++7AHaKy9oNjVpfSGbyFJ9Zkma+ffEQXJqGesFxh23rHt7pl
	dCmu4XF3a0zvfdJ/j1LvOSRwFQ4283fDdEDUG5JW4KahzzRtubSR01Gc8L6J2Jp9fAOzV7bC3KH
	hsOXIROrkTPrqh4MBRCZ3cg7tlGP6gzZMadS7oVDqWqRw+QL9Tz9lIWx732vO1cWZE3hsJZS6Jd
	HpLLpRBjoJRgSotmkWC4gWvs1H5TXs+9Hky5MFidgBESMnoRtRIowunZh8FJbXyW5CWiUjZ5g7d
	si0OGmYYAvQIXbUT3/EjLB2gKLJqqrWbdqoqWVUlHEgJuAaUty2/JEHatKqe7lM=
X-Google-Smtp-Source: AGHT+IEY+kkIUBHUWrkm+YxVmVVosNPoYo9fR6Fh1CS1VlYmEQyYpRrfSJuDXlpQq7iCFVDGyliTog==
X-Received: by 2002:a05:6a21:9d48:b0:1ee:69c8:8d04 with SMTP id adf61e73a8af0-1ee69c88da3mr14480184637.40.1739515379748;
        Thu, 13 Feb 2025 22:42:59 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273eac4sm2380444b3a.113.2025.02.13.22.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:42:59 -0800 (PST)
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
Subject: [PATCH net-next v3] page_pool: avoid infinite loop to schedule delayed worker
Date: Fri, 14 Feb 2025 14:42:50 +0800
Message-Id: <20250214064250.85987-1-kerneljasonxing@gmail.com>
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
v3
Link: https://lore.kernel.org/all/20250213052150.18392-1-kerneljasonxing@gmail.com/
1. remove printing warning even when inflight is negative, or else
it will cause panic.

v2
Link: https://lore.kernel.org/all/20250210130953.26831-1-kerneljasonxing@gmail.com/
1. add more details in commit message.
2. allow printing once when the inflight is negative.
3. correct the position where to stop the reschedule.
Suggested by Mina and Jakub.
---
 net/core/page_pool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1c6fec08bc43..acef1fcd8ddc 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 * in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
 		return;
 
 	/* Periodic warning for page pools the user can't see */
-- 
2.43.5


