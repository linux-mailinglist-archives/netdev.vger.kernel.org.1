Return-Path: <netdev+bounces-102075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB31590158B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FAB1C20A38
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C864224EF;
	Sun,  9 Jun 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="abVBjozx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457F1CD13
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929436; cv=none; b=gYZ5ISzB1wv8FRJCSxLTQi7ZXJeyOK3eoZyOko38YBXMxE2/lPtvufjo769uGwZdy6pEA/wGs7/6YDbB+G3z1/NJpIiuVafkj91B87xlXi97v4DzX/F4IY/8Kmvk6nsC58PFpn9YzzDHVKXtOT2McZ9D7U6gqXY3cH0FuA24fGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929436; c=relaxed/simple;
	bh=L2s03dhFeMytPwGmI5YvhNUtbDtRRLCjBJwQDgtWHJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOVa3QW2H8XvUQLMAe47CaXWzZz3OJoQQzRQZXRnZPemEDCfALJi/+uEXzkhp3aM61OBdE8JD1DqhzLUt+XXhkE8oRcHZSxs71H5iMr68ue2nNfWuZ4mumAc31EbbcAjahiV6EN/cNk9KUXn4F3kdUR7hr803JgfTkLTUG0Hw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=abVBjozx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f09b457fdso85097966b.2
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717929432; x=1718534232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUIEGxGg8eY95ds7QR7Av+9t23TMyKmwO6BqnjfUYo4=;
        b=abVBjozxbmtndiS2t0F62p6TrVXcx3FgoaoaoLtCZzF0ttosRY1co+lRRpFm64Rpm1
         f7t/bKlOXb6wVPRiFgIM9zatikNg4jB97/KD2Xr6H3QnMVEEYEpz4HJM43x7teo3JVxI
         +0HIBJpokjvUtU3Qxy7dhX82wlW6+DrBS4EHGm4caNNcLMUiu8VSzbDVggmZIe2SC7P+
         sfVWGnPFJprB9xnJuJybL6+kigBWrpO4w9iLRyhmwJEjBubVhaIu6YbW5ms8ielGoxzd
         +/bfV6H1uxsTHTZFFQnvewIhxVNs63hQCxbh31IxNggqQujy0w5qM84Ui46ySZ1fYECp
         4zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717929432; x=1718534232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUIEGxGg8eY95ds7QR7Av+9t23TMyKmwO6BqnjfUYo4=;
        b=e1uWhOHL+imHw832we/zmr6e6mgfT7Ru7JQJZx9R9ZsizPD61lGfLaVFqMDgRK8WWs
         pGHH7JCE2U79SFl0cBUjU30S6hW6UYAW+/lb5+TSufZF5JkVjUEV+7yzyRShYIGOou+D
         L0A0xH+ocbRJ07nzuDwO9hSQHdZKhfq8hNWtmCkYhBsjfH2wqyc2SoxAg0/R9gWMF3Kp
         acQxDyEdZ8FyZ/RhmppErKDHDP6bRmI2G6tcIB9c9IeSl82pKHoW1DKuSgpb9k1W5VSB
         RgzUy1sI0mE+g9f7ATEyRSYw+enjxVSsw7ImsiFoYD2zyMdlVJtdkom/i3WviOjSevPk
         AgUg==
X-Gm-Message-State: AOJu0Yw3uhfNuhjHf6Rjsw2XiXay9ySVUwg0wN6ZEgNO2UICiV0zv3Ht
	OXzYvG2GOs51N/kuPCOCjhV+/jPbWQx22MMOx4Wk642RynIuY9ckMLwz/PhxE8E1tvRmgFjcAHp
	wnz+DKg==
X-Google-Smtp-Source: AGHT+IGfArVuUpG9mwzGQ2LT7Rw4nAR48CIY/0eQnNI4FvUnHk8G0KF+1MZKIWsjivMpclNzBucKbQ==
X-Received: by 2002:a17:906:5ac7:b0:a68:cf56:aaed with SMTP id a640c23a62f3a-a6cdc0e4ac5mr465844766b.74.1717929432294;
        Sun, 09 Jun 2024 03:37:12 -0700 (PDT)
Received: from dev.. ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8c01579sm259579966b.155.2024.06.09.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:37:11 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: mst: fix suspicious rcu usage warning
Date: Sun,  9 Jun 2024 13:36:52 +0300
Message-ID: <20240609103654.914987-1-razor@blackwall.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
This set fixes a suspicious RCU usage warning triggered by syzbot[1] in
the bridge's MST code. After I converted br_mst_set_state to RCU, I
forgot to update the vlan group dereference helper. Fix it by using
the proper helper, in order to do that we need to pass the vlan group
which is already obtained correctly by the callers for their respective
context. Patch 01 is a requirement for the fix in patch 02.

Note I did consider rcu_dereference_rtnl() but the churn is much bigger
and in every part of the bridge. We can do that as a cleanup in
net-next.

Cheers,
 Nik

[1] https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0 Not tainted
 -----------------------------
 net/bridge/br_private.h:1599 suspicious rcu_dereference_protected() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 4 locks held by syz-executor.1/5374:
  #0: ffff888022d50b18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
  #0: ffff888022d50b18 (&mm->mmap_lock){++++}-{3:3}, at: __mm_populate+0x1b0/0x460 mm/gup.c:2111
  #1: ffffc90000a18c00 ((&p->forward_delay_timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x650 kernel/time/timer.c:1789
  #2: ffff88805fb2ccb8 (&br->lock){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  #2: ffff88805fb2ccb8 (&br->lock){+.-.}-{2:2}, at: br_forward_delay_timer_expired+0x50/0x440 net/bridge/br_stp_timer.c:86
  #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
  #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
  #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: br_mst_set_state+0x171/0x7a0 net/bridge/br_mst.c:105

 stack backtrace:
 CPU: 1 PID: 5374 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
 Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
  nbp_vlan_group net/bridge/br_private.h:1599 [inline]
  br_mst_set_state+0x29e/0x7a0 net/bridge/br_mst.c:106
  br_set_state+0x28a/0x7b0 net/bridge/br_stp.c:47
  br_forward_delay_timer_expired+0x176/0x440 net/bridge/br_stp_timer.c:88
  call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
  expire_timers kernel/time/timer.c:1843 [inline]
  __run_timers kernel/time/timer.c:2417 [inline]
  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
  run_timer_base kernel/time/timer.c:2437 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
  </IRQ>
  <TASK>

Nikolay Aleksandrov (2):
  net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
  net: bridge: mst: fix suspicious rcu usage in br_mst_set_state

 net/bridge/br_mst.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.45.1


