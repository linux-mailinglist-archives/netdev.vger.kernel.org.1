Return-Path: <netdev+bounces-103802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9B9098C5
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8071F2179D
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A549644;
	Sat, 15 Jun 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPK76sVL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DF2233B
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464499; cv=none; b=ue1Y8YHLKGuuYxNo5ZupqifwAkVpxFWgLL97bya3A4/yAm0A+20m1RAWpHahXrN8Fh0ASrYHkdlbYo9NFGMCxeHUBI68Oq9rQy8WBT9oAgMjH4j1jjQ6daixzOx2aq1qIYLR7mdyUu0wnMMdLEAXiMVAXaYAekuyw6VlAunyp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464499; c=relaxed/simple;
	bh=ArWjij78tRruuvdNTfNgX7iLfpQ05s+rZxaHUYLD/fM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mH+ojGBC+faSdjA/7D/Aj2pwVE1wAD6nZB3uy8bMY7pvgmrTGRN7RkUJyyuWPHFLP4l+9RvprVmtl0RaSBKMyfJN/9map+NecKSAoEyPHGNAuCh/Q+zCAQrvTWELQvOQvzbtNbt4uFINS6FOFOAe7jLHsrXwMmBz84xLFyW/h88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPK76sVL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfedfecada4so6582369276.1
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718464496; x=1719069296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0tgxOn8BeKGNcoBs+Bo+kqrI4GwUiLxm/zLTF+uF9b0=;
        b=zPK76sVLZed1ZXAXXyHgYPzLC1aLRRuz3LdPiGdk+4TUeSA0mNdyDi1yPEef+P63KM
         J6FVM1mNc/3ZKW0aPj61OHuGe/V+osQIj5C0C6xldtKv//YxBh5bd4zT1EhIk8cLPgus
         G+e+CZ70AnV3qbpPcm76u53C5oIrA+qTiXDfzbMb0dcdKpHWcrnaSCJgPAieXxhpkxg9
         142QfyB2447qi8nLDKpkAD7yQXgXj7HpF4LxCEgIZcfLRpc8GeVw8I4muZgF9J/RTp6Z
         ZGuQorsc7zzl5ciWecDOE9nbAXjOaTZZQp5N0m+pCuW7dbQpkoqmgLRqVH8gxOY+Za2F
         P+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718464496; x=1719069296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tgxOn8BeKGNcoBs+Bo+kqrI4GwUiLxm/zLTF+uF9b0=;
        b=R5auumFuKn/cQ7L5dtuFYql+Qj3KKxjokce04fRQWD0k7DkQ30tNpfbC4K3dGi0SLj
         nYM3f1MVc6dWHfzyzktfu0sQVKlXnQjMRvNsTlHZ7Tdc1jiJl9586ZCVhmcVU+eMeJQM
         a3rj0BvniRRZDeJEwqzG5GwO0+74jleKtsXpMIY2ZTJ0x/vY++ZnfWk2IDG1iIu4IK4t
         Z/vrZ9XUCMISj/ZzJ7m++zzarI71ygFWJfJsv4m5z7J57AkvBK1nAFeJlfVQU0NB6GwV
         ulwmAADHIO9GPUyyMN9AddiLLeGlTEmb3YMEmJT5xzrh2mfAan7FzLCpeUoVVQVxoaF/
         T5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWc5mDo95/BD3P07ZPJo9OqzIk7+8f7k4XVmmXCH0lb/UguKuiWiGv+llFvmlVYZrSd6wW4gQYd+CXMHflYHKcfVZy9qCoh
X-Gm-Message-State: AOJu0YzbTRfqc4WhNnsx1WikUNJRQ9RAvwa2R6jsgnZnfEJvBSR/EeR8
	TNICqd6BlBHg3KvOjVCbQrNOPtJOl40pgYoR61dMCvY8E7lUI8r4tUM9HKhq7mj+hin7Yq+kPcO
	hChVAY+Dl/Q==
X-Google-Smtp-Source: AGHT+IGDyMkYzKnbWgGkkDN/5y6zhfyOn+nkpm3sHLrWzw6ceNiorfMOjWJR60ZAo8uUw4WkyeULb9+zEiFThA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f09:b0:df7:d31b:7a29 with SMTP
 id 3f1490d57ef6-dff1547ddabmr744793276.12.1718464496540; Sat, 15 Jun 2024
 08:14:56 -0700 (PDT)
Date: Sat, 15 Jun 2024 15:14:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240615151454.166404-1-edumazet@google.com>
Subject: [PATCH net] ipv6: prevent possible NULL dereference in rt6_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot caught a NULL dereference in rt6_probe() [1]

Bail out if  __in6_dev_get() returns NULL.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000cb: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000658-0x000000000000065f]
CPU: 1 PID: 22444 Comm: syz-executor.0 Not tainted 6.10.0-rc2-syzkaller-00383-gb8481381d4e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
 RIP: 0010:rt6_probe net/ipv6/route.c:656 [inline]
 RIP: 0010:find_match+0x8c4/0xf50 net/ipv6/route.c:758
Code: 14 fd f7 48 8b 85 38 ff ff ff 48 c7 45 b0 00 00 00 00 48 8d b8 5c 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 19
RSP: 0018:ffffc900034af070 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90004521000
RDX: 00000000000000cb RSI: ffffffff8990d0cd RDI: 000000000000065c
RBP: ffffc900034af150 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 000000000000000a
R13: 1ffff92000695e18 R14: ffff8880244a1d20 R15: 0000000000000000
FS:  00007f4844a5a6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31b27000 CR3: 000000002d42c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  rt6_nh_find_match+0xfa/0x1a0 net/ipv6/route.c:784
  nexthop_for_each_fib6_nh+0x26d/0x4a0 net/ipv4/nexthop.c:1496
  __find_rr_leaf+0x6e7/0xe00 net/ipv6/route.c:825
  find_rr_leaf net/ipv6/route.c:853 [inline]
  rt6_select net/ipv6/route.c:897 [inline]
  fib6_table_lookup+0x57e/0xa30 net/ipv6/route.c:2195
  ip6_pol_route+0x1cd/0x1150 net/ipv6/route.c:2231
  pol_lookup_func include/net/ip6_fib.h:616 [inline]
  fib6_rule_lookup+0x386/0x720 net/ipv6/fib6_rules.c:121
  ip6_route_output_flags_noref net/ipv6/route.c:2639 [inline]
  ip6_route_output_flags+0x1d0/0x640 net/ipv6/route.c:2651
  ip6_dst_lookup_tail.constprop.0+0x961/0x1760 net/ipv6/ip6_output.c:1147
  ip6_dst_lookup_flow+0x99/0x1d0 net/ipv6/ip6_output.c:1250
  rawv6_sendmsg+0xdab/0x4340 net/ipv6/raw.c:898
  inet_sendmsg+0x119/0x140 net/ipv4/af_inet.c:853
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  sock_write_iter+0x4b8/0x5c0 net/socket.c:1160
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0x6b6/0x1140 fs/read_write.c:590
  ksys_write+0x1f8/0x260 fs/read_write.c:643
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 52e1635631b3 ("[IPV6]: ROUTE: Add router_probe_interval sysctl.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 952c2bf1170942d411392b5bd5994cb057d3a983..3dc66cfb3d0726366679b67b0ac22663209fa9b7 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -638,6 +638,8 @@ static void rt6_probe(struct fib6_nh *fib6_nh)
 	rcu_read_lock();
 	last_probe = READ_ONCE(fib6_nh->last_probe);
 	idev = __in6_dev_get(dev);
+	if (!idev)
+		goto out;
 	neigh = __ipv6_neigh_lookup_noref(dev, nh_gw);
 	if (neigh) {
 		if (READ_ONCE(neigh->nud_state) & NUD_VALID)
-- 
2.45.2.627.g7a2c4fd464-goog


