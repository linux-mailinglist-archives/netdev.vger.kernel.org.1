Return-Path: <netdev+bounces-213463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D1B2525B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FD38876A0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DBD28D8E7;
	Wed, 13 Aug 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GJwDFovg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3685303CB7
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107185; cv=none; b=WKvpaeX3lnnhNikMp/V5h0edBjycaldebjBsAVV4Bt8GMAmMEG/H+iU72oljl7GEqT1nnuISN7j/s9o8d9tdRzwReA2M7Xu0gG/l2ImsSEy1PVTAJVGONhNN+iu5j46ePb2Y6azeuHXlVgGfHIZhE+dZqnmkfVnZNM65oGoifXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107185; c=relaxed/simple;
	bh=qwwZFHDTzf6l+hWDSupGS2PGTkZT1ApGYDl6IxkP218=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyg5bWgOYtMpJnGd8vMO3A5/Xh97NLgTDhiM0y5QziHNGU/s88C2ViEkOKp865t8wePxATD2/HHPmFsSH/835GmbhD1W8fi/0m79sflYnZWGnE7qa5skGwe3o4YBt/DQPPO1t5jKzFYYepI4FqFjUPtfbaE6+jScqUQCYbVl97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GJwDFovg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so162647b3a.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755107183; x=1755711983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8b/RpXbbAh6n+UgjU7ELkW8wjlkX+I6pp4QNwhoxzw=;
        b=GJwDFovgi3zTdkn3Z7T4lMWC7xd4q/UFfohSqvM7HW8OxQvMXE1loVHXQnBppa7P5C
         /9S8RfqGubDbw/pvAU99X+b647wS/kRizQtOxYGQujV+t7/ctEZZGrHvW1Wkc/QTXr8B
         YwCHxZbvuzzOCwj1SdRJpB6Y8ytRxzsCmoTR4wrU95HQLTYiJZ5qRLL74WB/g+ybW0Tc
         MuEXy5CYGQhPGAtQbLNnvtRbceMkrbBp+RdY0R4Yxwm0LiQ1vXKMCum1Gvkoo+9D84Qs
         st6hOWuOtynOtQ2gPac9KXBDL2+GDorucvpmkb2TdWgdiGf68MH3z9mHGFL/jTr8OSUW
         iqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107183; x=1755711983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8b/RpXbbAh6n+UgjU7ELkW8wjlkX+I6pp4QNwhoxzw=;
        b=a0VU2iCdDMFj4K3YIccR7Pw/IZz7VcSAEUpTRj+a93QyvqOXFCxgHOTSWZlSlFhSVV
         7w1DolT14COse9bdVCG7nEnvAgDSicFHk3RA2zjmm5SCrhRIY0Jo5mo5eju/++wz/kqY
         h0hCQ9Efx18No6uK3exxBFevqNmDcgOnBiyTrv/BEan/H1X8Ms5fezRlZX99JqTFbX9T
         QuzxmK7pM+XWBco0F3bRyT282Fb5e2XoffM3P1AUrksV2Jr5MVzTf7/licbYa6cCMOJb
         EysFJqh0ICLVUX3bWNlhvJzb5magWpvpjAS+RL5bfnYyl1hTbmJIrVeQuW82pnhJu3dE
         1DEg==
X-Gm-Message-State: AOJu0Yw1SMKZROPCtBSLZMhsEJv/0LzESEjCoM83LvKIqcCSgbfVpQFl
	laSe0I+qtMYHiNvFdp0WmBUZ7GLZwT2uLQZeUkjqMV2khKWTTW+r91rtWkIXl40xMw==
X-Gm-Gg: ASbGnctlGdEz7I17NETynx6no6Y1dZuiX1CjbH/d6lqn2R+r9F0ETC93Zy9WaVapKPt
	GzjRDNiGHyqhWzU2EghCmFYsKiZdDeauulyFoPofWx2brlmwath34MKkyk2n0cAnXqJZCCtDSd4
	Ogt3dndVFSWngAwL5Wf9+7vAbwefCnrTucA6hFynDIENPgMxDlcOVoBrjG7A5rEH9dIdcyLoe9U
	DTEjyg/d3pOAJXvEASkInMd7q62DxH/ILvCS6jo98jyWAFEZWbVdmpvpHcs3ifn/B5t1PyQEoVS
	+rwCim1Z2bYzDvX550P4IrHAoXe8+rZKSro44Hnldrf+a/0ArzcTjxxWI/9Ux3/w7Qnps/FgaQN
	JzhOGpeKx1hPps4P18Qa7IpC6eigdtckOKuL0T01WSBGYwd8CK5HX0E/n
X-Google-Smtp-Source: AGHT+IGY2D0vhWng2S4GtJz79S7/eOD/xTFIJBemp2tgSH1mFs1vNiR3zfEFsi1j8ClHbnxMNkJoYg==
X-Received: by 2002:a17:902:ea09:b0:240:9ff:d546 with SMTP id d9443c01a7336-2430d0b4c7cmr53179235ad.6.1755107182976;
        Wed, 13 Aug 2025 10:46:22 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24303d5e705sm45314575ad.14.2025.08.13.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:46:22 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	koen.de_schepper@nokia-bell-labs.com
Subject: [RFC PATCH net] net/sched: sch_dualpi2: Run prob update timer in softirq to avoid deadlock
Date: Wed, 13 Aug 2025 14:46:17 -0300
Message-ID: <20250813174617.257553-1-victor@mojatatu.com>
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
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
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
2.34.1


