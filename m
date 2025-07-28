Return-Path: <netdev+bounces-210431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B723B134E0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75C07A842F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FE2206B2;
	Mon, 28 Jul 2025 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFO0kElp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F51922C0;
	Mon, 28 Jul 2025 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684025; cv=none; b=HTirLhaPXAdwqKiJGdaVmFtckzCb3iwjhlw5U+7u1FQ/wi1YzqL4Hmv6Bcsl3vhAqWbicuxG4JX3Ift7nn3JCNt1sRHist/oaiJIY8UDmojXg9NpzZGb2zEL3ruIF8UGxJSumYiqXJ4n9WIgnE9Hl1KrFGAzWB5PwB/4YNo3ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684025; c=relaxed/simple;
	bh=PulKr2wj6t/QYlFD3SK90J02qBu3DB0x6RzoCozSKoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+Gs8WGDaG/qQLwFXrH0TbRdsYEdWa146xiPTNk2vssuoKUYX2kXl3rW7FVfhpKc9043HbUm7kQ4Ohc9eLm8gaSsCLKAcuWAD2tJCdJagwSoZOIinZNHZKo/yGY+rGN4kBCY93aj3M+2zN6wbPCUKBNUxyd//s4GK/HeeEiMjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFO0kElp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-749068b9b63so2683406b3a.0;
        Sun, 27 Jul 2025 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753684024; x=1754288824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKFWnhdu2qeWnQOHWgzpVj2hderL4bRCYnhTpD8a3pM=;
        b=MFO0kElpe2GAEP3wJnj4tscjxbGqBbrinWWpGqSda1JLm2bZXDkC4FcJhowsgKt/FT
         QNbWwGNo06ij7BVDkQoGSTecuPe2Y3XVXT+aB0s3Qk5QTFEEGGJQOkwaAL9l7Cp5AW9n
         hoKxfWn0g3Cc8J4vnFwQs2mYcAvKXQy1zMmm+0YenWTSqPOVLmPWfiPUsLZKQfUyupqx
         X+Tf0VHaaEKYAC+P3MI73UYtQhEBuk3awJYf3t9nzOjOcM6c26HYUIyDD5yPBSGY+LnL
         lDbcDV1KvRjLb3iEQaW599IQD+Y+l2hR8UMGLublK/R1vWQ20fcpO3NgLXg0P5i6EVaM
         KfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753684024; x=1754288824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKFWnhdu2qeWnQOHWgzpVj2hderL4bRCYnhTpD8a3pM=;
        b=m3TYcGN0gdV5G7Lu+1mzQkD81shTydcm+rAi+NuGn4RFqGD9mjhdutWNwvxio9UR0f
         4ENCluGV8uzf4infPJUFEP8HUFAWkpAv3EtV5C/xIUbKLYb3/aEHX8BlmCYjnX2vAAIv
         65f6f7wk9DrDNC0IWk6C6kuSJZGXdWCKxzFHJUOfntB7EUiz6fIW9i4JZlrgDre+B+X8
         Q6lXRx9DS4P2ag5yTqFpa93acm8xvRRMzz2bxXrwIPqmr+V9FLp22fD6JxwSuyuZPM6L
         EUjcDYXoq7/jQJz4PMBwsOZ/luN8N6sid0Jwhup275pWDsxu1wAkq5/HHRtE1idfYrHK
         vJjg==
X-Forwarded-Encrypted: i=1; AJvYcCUMIJjFm05iGIKcdJkHoEaN3Bom21Z4h7HzyefQ11Fwb1vAZCmOeRLTJ+hfPOxfB8IEwH+fo76MITof7PI=@vger.kernel.org, AJvYcCUPi3Nfw5Sw8plBs8eUCnnKrDden9M/Y1mNTcWMbPmV4WNiD5KH6VE46gSg5PVOPRYTYSuZYHhJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2hf1QUNBK+Xga8pj1OlqnmG+5Kri1OGrmEWLoq7d2pw1Mw4R
	Zdo4idWnEQq/zVjapkjjVfXX+uZ6nvzFlk9wxbutlwBcNxdY3vtek1GI
X-Gm-Gg: ASbGnctzAt9AWPPSecqDxecULAgGAULe/ir4Y5fX8W3a6snCbqt3rnOLssGXuZHdFX6
	e//FyOnA9//LCEhXsx1+MlXLRYtbBjvDTS9jTeHJONcuMVyzX59n6Y4qPPU82xpFoNTbp2vhL1l
	HaTjNc9jpwd7Ebjp4Ccbi4ixiou0pMnsZXxbDtpbGPQBhyobEAyKvBFuN/KMWj4lXVRxlotZM8g
	FGXyVvccjIP/6YPqgCVFAF0Tn2c6X3Kx6ZTA7GeRXUWoH0QhSxVKo0KO/1RSJ/4dAakQuzEEpzD
	n5n8znkJvf3YvmxFq17Nl6xvWB2R1ceBpf+CSZikqjxCOYexe2ZYTIGBrCRMO9J1SUKObmgvrUZ
	W1C498jr53JjSVLUd4KXqZe+BEDemYI//kAjw4gFzTZ3jcaaajA==
X-Google-Smtp-Source: AGHT+IEVtxsdIMH8xLIszjuppcyttoOjKpE7dKr7Fxe7/nTjeyAUlUVVn86h52QICu7seUIQPij0ag==
X-Received: by 2002:a05:6a20:2445:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-23d701f8204mr19020742637.40.1753684023541;
        Sun, 27 Jul 2025 23:27:03 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8695sm4310177b3a.116.2025.07.27.23.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 23:27:03 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yangbo.lu@nxp.com,
	vladimir.oltean@nxp.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net v4] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
Date: Mon, 28 Jul 2025 15:26:49 +0900
Message-Id: <20250728062649.469882-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following ABBA deadlock:

       CPU0                           CPU1
       ----                           ----
  n_vclocks_store()
    lock(&ptp->n_vclocks_mux) [1]
        (physical clock)
                                     pc_clock_adjtime()
                                       lock(&clk->rwsem) [2]
                                        (physical clock)
                                       ...
                                       ptp_clock_freerun()
                                         ptp_vclock_in_use()
                                           lock(&ptp->n_vclocks_mux) [3]
                                              (physical clock)
    ptp_clock_unregister()
      posix_clock_unregister()
        lock(&clk->rwsem) [4]
          (virtual clock)

Since ptp virtual clock is registered only under ptp physical clock, both
ptp_clock and posix_clock must be physical clocks for ptp_vclock_in_use()
to lock &ptp->n_vclocks_mux and check ptp->n_vclocks.

However, when unregistering vclocks in n_vclocks_store(), the locking
ptp->n_vclocks_mux is a physical clock lock, but clk->rwsem of
ptp_clock_unregister() called through device_for_each_child_reverse()
is a virtual clock lock.

Therefore, clk->rwsem used in CPU0 and clk->rwsem used in CPU1 are
different locks, but in lockdep, a false positive occurs because the
possibility of deadlock is determined through lock-class.

To solve this, lock subclass annotation must be added to the posix_clock
rwsem of the vclock.

Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v4: Remove unnecessary lock class annotation and CC "POSIX CLOCKS and TIMERS" maintainer
- Link to v3: https://lore.kernel.org/all/20250719124022.1536524-1-aha310510@gmail.com/
v3: Annotate lock subclass to prevent false positives of lockdep
- Link to v2: https://lore.kernel.org/all/20250718114958.1473199-1-aha310510@gmail.com/
v2: Add CC Vladimir
- Link to v1: https://lore.kernel.org/all/20250705145031.140571-1-aha310510@gmail.com/
---
 drivers/ptp/ptp_private.h | 5 +++++
 drivers/ptp/ptp_vclock.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index a6aad743c282..b352df4cd3f9 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -24,6 +24,11 @@
 #define PTP_DEFAULT_MAX_VCLOCKS 20
 #define PTP_MAX_CHANNELS 2048
 
+enum {
+	PTP_LOCK_PHYSICAL = 0,
+	PTP_LOCK_VIRTUAL,
+};
+
 struct timestamp_event_queue {
 	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
 	int head;
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 7febfdcbde8b..8ed4b8598924 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -154,6 +154,11 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
 	return PTP_VCLOCK_REFRESH_INTERVAL;
 }
 
+static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
+{
+	lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);
+}
+
 static const struct ptp_clock_info ptp_vclock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "ptp virtual clock",
@@ -213,6 +218,8 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 		return NULL;
 	}
 
+	ptp_vclock_set_subclass(vclock->clock);
+
 	timecounter_init(&vclock->tc, &vclock->cc, 0);
 	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
 
--

