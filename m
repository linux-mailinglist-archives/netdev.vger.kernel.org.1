Return-Path: <netdev+bounces-214066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C030EB280EE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A841CE748A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE2244693;
	Fri, 15 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cA06NQdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4429D05
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266009; cv=none; b=mKuTofFZ5ecdVVhHHE8mbg2UkhSbmvz6+FTvDR5pYeC3Hq70G1nOG2QR8Vp++QGT8r0iId+hxs64+svBiJ1EZe03jNGQQOKM67E/vkq8z4mXkRNsnfkgpCHaiM7ldJJtvBRiiY+9tv4IkEJuGYWUiJpxJxHlk/63edAqL1qlB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266009; c=relaxed/simple;
	bh=HG+cWHwtovOATn+2du+M7+HGevmbPTVDf2DFl761cSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJkIPtfG4YnGIPe8TgTGrm8jq105ITDvm1ZTtjF4iqtDny20y2nVsM5wvW2fEjgGmOBzhqgdR75CKlXcslqjabVVA7wsBOnOgoeV86dEigZv2H8i4ldFlAEaNG03gC6iJ6qBknYhOUPMv9loT6849fwyJGObhheS1xpDuDDZFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cA06NQdT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso1898534b3a.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755266007; x=1755870807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe7xsr8AkmmZfL1Wx/80kR1XNyW0n8qQxpLkG5EB4c8=;
        b=cA06NQdThZCNjdRoY4P4E2wZ27zXV0AegPv6F+0qgLQu8wONGJsE6TZ0zfGX0LIZkd
         9JXbeuN1PkIt0h6K3pk9IdBrSvWciGXXXuqxGubEuCqJehjyZ4Byra3iPixSSka6BXqO
         ObdR+e1wHYVOOmEYaS5HFrNNe2rrMgZdf1fX2OE+YaBGl71NtkdsmDYtCY6+GkeS2EJP
         332KgjVk5QC+aoKWjrq5iGPPzUYgsEBaY9Fot3K37JvVXWHM8GfSXpiecUaLyhcO3CWL
         U06j6J075nWXxmBuOZ6MYAA2hv7uGwzkPk1hq/rXHzY6NehYtilSxbHopvQs/fjcC2wA
         3EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266007; x=1755870807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe7xsr8AkmmZfL1Wx/80kR1XNyW0n8qQxpLkG5EB4c8=;
        b=b+adzODRp1bogoxrJaFT+zk+XRJ7ZrYOgcvRB6ILv4MXuDUr5NJ6XQkZ61aN9pOYPP
         B+cwkSiDvC/S715WpdTiCElUM7Dol9nUjynteGL4uMLnPCjmYjyHPQNb+EQKAq9KStdO
         95Sd0AJlLCnB5xMUH16p/YY2nJulRavHmCQXbCP+0aOdVDa03ym1E4lgfY5fWTBEWw7T
         /j/dYmHZ4g6LAVanyAsBzgxMvIqvOQ+pPpODABHx02HyNyjVwVFOIy8+Ns7zy6p+6U6/
         gwLF8YiruRCfP/mBfdWkaKM6Wwpbp0VJ7sP/r2mDNwJv2OOGc9IUGq8C83VTWpNoZBCG
         +Vhw==
X-Gm-Message-State: AOJu0YxJuhCvTShCvy6X35D0eH8rqjNN5Ue2ATtiAkGfcYbJVu4LklH4
	BzOW6ueZUy6W7nRIkUX8oQ0Ch6xrqMl9FDSiRkj2qNh9gRTiGNA8FCP+pl3tPxG4WgbDkFL6xPH
	eZmg=
X-Gm-Gg: ASbGnctrQSsa01jGkYOg3fOYsTLu23lq0yA0WyPYkix6qj4sFKwTpM/RUzcVQtSdBxO
	bVWAcHFdCzSPxU9ohW+YAC4N5bja9XM6JVWAVs5IMgQaUbmxmXewjpRIeEn7fR+lQcuX6wQxgcN
	3ptIIPEfaD11gSQaH+XQdWQAAO66prE/WB3vUW69f1i0wjBgfE9PrQ+GVKnDtOhkp8HvZ/DjzwB
	fjMI/XLl3SAlwet5TMEDvlF/G4MRYjBfSa6/LxBnbvzc8Ymbt/wd2ImERpyVtmgLUgNval7oNrX
	ASRa5HJexBGBgt7T+qfANpltcgAoblEl42hLJ0wQIlDZ0+QYLcH+6Q2goOr8j2KNpSJ0WCXKMer
	TT7QDt7W+T1UZ/kBpKhLMNmw=
X-Google-Smtp-Source: AGHT+IFK5hs8tUPef6MrAb6GPwjdDzGDhuxVJNEYqauV9GDz0YJh1xaB99dbhHzejLd+3r1AhAw9Cw==
X-Received: by 2002:a05:6a00:928c:b0:730:9946:5973 with SMTP id d2e1a72fcca58-76e446aa90dmr2913580b3a.5.1755266007436;
        Fri, 15 Aug 2025 06:53:27 -0700 (PDT)
Received: from exu-caveira ([2804:7f1:e2c3:cb0a:ff2a:bbeb:28bd:bcb0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45289544sm1222957b3a.27.2025.08.15.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:53:26 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	koen.de_schepper@nokia-bell-labs.com,
	olga@albisser.org,
	olivier.tilmans@nokia.com,
	henrist@henrist.net,
	research@bobbriscoe.net,
	ij@kernel.org
Subject: [PATCH net v2] net/sched: sch_dualpi2: Run prob update timer in softirq to avoid deadlock
Date: Fri, 15 Aug 2025 10:53:17 -0300
Message-ID: <20250815135317.664993-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user creates a dualpi2 qdisc it automatically sets a timer. This
timer will run constantly and update the qdisc's probability field.
The issue is that the timer acquires the qdisc root lock and runs in
hardirq. The qdisc root lock is also acquired in dev.c whenever a packet
arrives for this qdisc. Since the dualpi2 timer callback runs in hardirq,
it may interrupt the packet processing running in softirq. If that happens
and it runs on the same CPU, it will acquire the same lock and cause a
deadlock. The following splat shows up when running a kernel compiled with
lock debugging:

[  +0.000224] WARNING: inconsistent lock state
[  +0.000224] 6.16.0+ #10 Not tainted
[  +0.000169] --------------------------------
[  +0.000029] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[  +0.000000] ping/156 [HC0[0]:SC0[2]:HE1:SE0] takes:
[  +0.000000] ffff897841242110 (&sch->root_lock_key){?.-.}-{3:3}, at: __dev_queue_xmit+0x86d/0x1140
[  +0.000000] {IN-HARDIRQ-W} state was registered at:
[  +0.000000]   lock_acquire.part.0+0xb6/0x220
[  +0.000000]   _raw_spin_lock+0x31/0x80
[  +0.000000]   dualpi2_timer+0x6f/0x270
[  +0.000000]   __hrtimer_run_queues+0x1c5/0x360
[  +0.000000]   hrtimer_interrupt+0x115/0x260
[  +0.000000]   __sysvec_apic_timer_interrupt+0x6d/0x1a0
[  +0.000000]   sysvec_apic_timer_interrupt+0x6e/0x80
[  +0.000000]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  +0.000000]   pv_native_safe_halt+0xf/0x20
[  +0.000000]   default_idle+0x9/0x10
[  +0.000000]   default_idle_call+0x7e/0x1e0
[  +0.000000]   do_idle+0x1e8/0x250
[  +0.000000]   cpu_startup_entry+0x29/0x30
[  +0.000000]   rest_init+0x151/0x160
[  +0.000000]   start_kernel+0x6f3/0x700
[  +0.000000]   x86_64_start_reservations+0x24/0x30
[  +0.000000]   x86_64_start_kernel+0xc8/0xd0
[  +0.000000]   common_startup_64+0x13e/0x148
[  +0.000000] irq event stamp: 6884
[  +0.000000] hardirqs last  enabled at (6883): [<ffffffffa75700b3>] neigh_resolve_output+0x223/0x270
[  +0.000000] hardirqs last disabled at (6882): [<ffffffffa7570078>] neigh_resolve_output+0x1e8/0x270
[  +0.000000] softirqs last  enabled at (6880): [<ffffffffa757006b>] neigh_resolve_output+0x1db/0x270
[  +0.000000] softirqs last disabled at (6884): [<ffffffffa755b533>] __dev_queue_xmit+0x73/0x1140
[  +0.000000]
              other info that might help us debug this:
[  +0.000000]  Possible unsafe locking scenario:

[  +0.000000]        CPU0
[  +0.000000]        ----
[  +0.000000]   lock(&sch->root_lock_key);
[  +0.000000]   <Interrupt>
[  +0.000000]     lock(&sch->root_lock_key);
[  +0.000000]
               *** DEADLOCK ***

[  +0.000000] 4 locks held by ping/156:
[  +0.000000]  #0: ffff897842332e08 (sk_lock-AF_INET){+.+.}-{0:0}, at: raw_sendmsg+0x41e/0xf40
[  +0.000000]  #1: ffffffffa816f880 (rcu_read_lock){....}-{1:3}, at: ip_output+0x2c/0x190
[  +0.000000]  #2: ffffffffa816f880 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0xad/0x950
[  +0.000000]  #3: ffffffffa816f840 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x73/0x1140

I am able to reproduce it consistently when running the following:

tc qdisc add dev lo handle 1: root dualpi2
ping -f 127.0.0.1

To fix it, make the timer run in softirq.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2: 
- Remove RFC tag
- Add Jamal's reviewed-by
---
 net/sched/sch_dualpi2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 845375ebd4ea..4b975feb52b1 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -927,7 +927,8 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->sch = sch;
 	dualpi2_reset_default(sch);
-	hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_SOFT);
 
 	if (opt && nla_len(opt)) {
 		err = dualpi2_change(sch, opt, extack);
@@ -937,7 +938,7 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	hrtimer_start(&q->pi2_timer, next_pi2_timeout(q),
-		      HRTIMER_MODE_ABS_PINNED);
+		      HRTIMER_MODE_ABS_PINNED_SOFT);
 	return 0;
 }
 
-- 
2.50.1


