Return-Path: <netdev+bounces-100738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDD8FBCA8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED01DB2344A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDF14AD38;
	Tue,  4 Jun 2024 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOBSxfk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402114A61E
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529756; cv=none; b=poGIH43BIAGBVov9otTigVN2Yo2DqKWEypw8mtqDH3OWd0nTay/Hd5XbRPITxokklIXg/S/nZWv9eBS54SXAkYeW1p3uZTiRcWd08U4xk7+7HrD2og+XgYGfqA3c0iHjb1dV6T72OLO8JqU0SUM68U8T6WZuldp3Ayho2Eq4r0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529756; c=relaxed/simple;
	bh=SUlpJ4Ie3E6ubwzaEryF6duZc9PkPKhykWyw3xL4TDk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dKUErzvCwQacf4IrvV/TZVDssyVdfjPYnSQQIIKEgiuW8eHTBExpxbs5jFLfi4Tsd/NfXOmHNWG/GenZEuBB73oJFGLQJFiKF/6ludKqOVva/rt4yD/3AOHxoSIDnRZr6n/JDqjU+cNaytq9tYZLYWBl9aclOVLqILQmGnpfTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOBSxfk+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62c823393a4so21535317b3.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717529754; x=1718134554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9WOBL52HJg6TXH1BfhWA/UA5z2mlFyT6mdWDfI72r6s=;
        b=TOBSxfk+ZesqatDyuRgD2Dbud90mm1GMX7mYQDhMn+I8/S9sB0HmKtb8kISG78MLex
         AvURRWY9XXYFWQpoW5KltBKzpojW4v3DxrlQINUp5KBBV7MKXjxKbM97FGkvE6mMloth
         DJcRv1aVjMj7RIzofl3YF9HK8cfu63rBc7eerFVu+LaHbNy2LMdEgXuiJFmMyU7lfrVp
         LuVSpMj7M95RHsHiwXbdHAOzoJTCqdH5LsxnHLkYslcqltdp8wtyH/aeevmIRIgZeUg5
         A6Y6mR+TqkmZMX48dr4pvrznuZRhmaansFwMZaGB4osuM1eD5Mfe+J/O8n/6EMBNEQgk
         8cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529754; x=1718134554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WOBL52HJg6TXH1BfhWA/UA5z2mlFyT6mdWDfI72r6s=;
        b=aaIL40VSVlEGFvHuV6bSIHyVm7RI/Y/R/B+g6KerrFU80RYzxQCTvBhe95UNuA0ZfN
         UvvBsStz29/sGuLBXvVkr8EyB5FLDQpuluGckyNDZeqEFYErPGOsA7coPzmqxwsEIiBR
         jCQ3wQoJNXaZC0ZFkZBZUOSwV3xONsBj8pAe8DvdDnwLoojXCrQtS6m+U78Z1cPIk7/o
         ESqwTE6RP08zd92BIfvlolFIpZ9vjwY04/VokHTk6NpTmH5pV6Vr2PtVxJMB5nQI+4ws
         rEG21tH3SLqjv4lVvNMN4Ks65d9KI8Z47SHY2POSw8o6gpBwztLYaxQuvqUyi+e3cdAR
         idrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp/x6kNzRUvYru+KgLHRtA1MmWuf0qQH4RBiUyxg06G6rOCUIXIAvTSnRlKDyJ1R/ORt/zzdUCh3UpD95lyAGhmFILFiv0
X-Gm-Message-State: AOJu0Yxx8HZxwJmrIjzvsxnRTWKDvDTL+APQeR37X7gbV9AUR9xD247I
	WfDUUGN3LCbyjAjFt/ngcBF4iaD8STKkhNvKAiirddnc/9XclyNPa1RudzRzVcaOCdkqFSC1XME
	XEt+2Gd9z0w==
X-Google-Smtp-Source: AGHT+IH3g3RBtdH7n16BXjSvs9YVaM2Ak+fKyM4u23NhbFkasV1eTnIkrerJg6otNhxBZKUiZW+gf1UqB9YPAQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1504:b0:dd9:2a64:e98a with SMTP
 id 3f1490d57ef6-dfacacff7c0mr43196276.9.1717529754132; Tue, 04 Jun 2024
 12:35:54 -0700 (PDT)
Date: Tue,  4 Jun 2024 19:35:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240604193549.981839-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix possible race in __fib6_drop_pcpu_from()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found a race in __fib6_drop_pcpu_from() [1]

If compiler reads more than once (*ppcpu_rt),
second read could read NULL, if another cpu clears
the value in rt6_get_pcpu_route().

Add a READ_ONCE() to prevent this race.

Also add rcu_read_lock()/rcu_read_unlock() because
we rely on RCU protection while dereferencing pcpu_rt.

[1]

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 0 PID: 7543 Comm: kworker/u8:17 Not tainted 6.10.0-rc1-syzkaller-00013-g2bfcfd584ff5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: netns cleanup_net
 RIP: 0010:__fib6_drop_pcpu_from.part.0+0x10a/0x370 net/ipv6/ip6_fib.c:984
Code: f8 48 c1 e8 03 80 3c 28 00 0f 85 16 02 00 00 4d 8b 3f 4d 85 ff 74 31 e8 74 a7 fa f7 49 8d bf 90 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 1e 02 00 00 49 8b 87 90 00 00 00 48 8b 0c 24 48
RSP: 0018:ffffc900040df070 EFLAGS: 00010206
RAX: 0000000000000012 RBX: 0000000000000001 RCX: ffffffff89932e16
RDX: ffff888049dd1e00 RSI: ffffffff89932d7c RDI: 0000000000000091
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000001 R11: 0000000000000006 R12: ffff88807fa080b8
R13: fffffbfff1a9a07d R14: ffffed100ff41022 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32c26000 CR3: 000000005d56e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  __fib6_drop_pcpu_from net/ipv6/ip6_fib.c:966 [inline]
  fib6_drop_pcpu_from net/ipv6/ip6_fib.c:1027 [inline]
  fib6_purge_rt+0x7f2/0x9f0 net/ipv6/ip6_fib.c:1038
  fib6_del_route net/ipv6/ip6_fib.c:1998 [inline]
  fib6_del+0xa70/0x17b0 net/ipv6/ip6_fib.c:2043
  fib6_clean_node+0x426/0x5b0 net/ipv6/ip6_fib.c:2205
  fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2127
  fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2175
  fib6_clean_tree+0xd7/0x120 net/ipv6/ip6_fib.c:2255
  __fib6_clean_all+0x100/0x2d0 net/ipv6/ip6_fib.c:2271
  rt6_sync_down_dev net/ipv6/route.c:4906 [inline]
  rt6_disable_ip+0x7ed/0xa00 net/ipv6/route.c:4911
  addrconf_ifdown.isra.0+0x117/0x1b40 net/ipv6/addrconf.c:3855
  addrconf_notify+0x223/0x19e0 net/ipv6/addrconf.c:3778
  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1992
  call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
  call_netdevice_notifiers net/core/dev.c:2044 [inline]
  dev_close_many+0x333/0x6a0 net/core/dev.c:1585
  unregister_netdevice_many_notify+0x46d/0x19f0 net/core/dev.c:11193
  unregister_netdevice_many net/core/dev.c:11276 [inline]
  default_device_exit_batch+0x85b/0xae0 net/core/dev.c:11759
  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
  cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
  process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
  process_scheduled_works kernel/workqueue.c:3312 [inline]
  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
  kthread+0x2c1/0x3a0 kernel/kthread.c:389
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Fixes: d52d3997f843 ("ipv6: Create percpu rt6_info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv6/ip6_fib.c | 6 +++++-
 net/ipv6/route.c   | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 31d77885bcae..6e57c03e3255 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -966,6 +966,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 	if (!fib6_nh->rt6i_pcpu)
 		return;
 
+	rcu_read_lock();
 	/* release the reference to this fib entry from
 	 * all of its cached pcpu routes
 	 */
@@ -974,7 +975,9 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 		struct rt6_info *pcpu_rt;
 
 		ppcpu_rt = per_cpu_ptr(fib6_nh->rt6i_pcpu, cpu);
-		pcpu_rt = *ppcpu_rt;
+
+		/* Paired with xchg() in rt6_get_pcpu_route() */
+		pcpu_rt = READ_ONCE(*ppcpu_rt);
 
 		/* only dropping the 'from' reference if the cached route
 		 * is using 'match'. The cached pcpu_rt->from only changes
@@ -988,6 +991,7 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 			fib6_info_release(from);
 		}
 	}
+	rcu_read_unlock();
 }
 
 struct fib6_nh_pcpu_arg {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a504b88ec06b..f083d9faba6b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1409,6 +1409,7 @@ static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
 		struct rt6_info *prev, **p;
 
 		p = this_cpu_ptr(res->nh->rt6i_pcpu);
+		/* Paired with READ_ONCE() in __fib6_drop_pcpu_from() */
 		prev = xchg(p, NULL);
 		if (prev) {
 			dst_dev_put(&prev->dst);
-- 
2.45.2.505.gda0bf45e8d-goog


