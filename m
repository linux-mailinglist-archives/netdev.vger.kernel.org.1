Return-Path: <netdev+bounces-258332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OQhLc3BjGkmswAAu9opvQ
	(envelope-from <netdev+bounces-258332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:52:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC5126B96
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C9923008C00
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942B34A3D6;
	Wed, 11 Feb 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp96N3p+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA53101B2
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832325; cv=none; b=E9kIEQ7SZ6gDHtESgiNwiiG9iiGc5298xR940w+GkPQ7jdzTg2OUxO2ln/gb2SCZxnDUWxxCGu4e5yzQARyZH58+Xt0Yz/1tNYlWXKxMp2h1nk/D5xaOTVV1hN0Z2homV+bc3ugADAVgUbGbT6hDZ95E6WLUYyrvSfHYA6rkdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832325; c=relaxed/simple;
	bh=IoyGUhKHOwohGOuh4W85C/kZ/NVxAUxSFePDYKsth+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oaEQYvM1M0dikXFCgYbK4hiScZXSQ//AAN2YN3682X4CZlYlCePPUKzckHaXQsOY/HXwdAvnqV/M3IIRDs16Um5106fpPI+wkIarv8/KksvGovQnww4aCP5ZyqM8uBjHBYBUUXUMNaRU+v/lTASfY/D3yl5bXRn98U4fMfH25nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jp96N3p+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad6045810so18848425ad.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770832323; x=1771437123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z7HgZPa2miCYVW2v/gKDume2IN7/1BlZq+GIduUL4MI=;
        b=jp96N3p+M8c63qKa5hdEsgl8TgPt7njqouaUGAjXRcvbIruDpgtb4FBeS+q8U2bPvy
         +m2zNrXvRo0EnzcHAcFM1xFYUR+mdFEfewYBjj/ilQ7dPl+mmJg8HsKmPhkMuxsS8d29
         2xi3jzrRHhyuHsrVcJeiPKNs0WS3DJFFpLlSIIooj0k+XTYJ+E23HnazaT1Bn5XQkLf4
         PX7tPBHynxU8vDCsnhtw6Xw+EeP14cvjnpzSvGC+nSVo5DQLJtHHMFQ6fGDkpndCaFsz
         icsMsbI9i+xV/o3ErkobZ3+oDdR+yv3GnP5vAiXrXtwWe25zx5oiu/P6uEnCnIrhG8C9
         CNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832323; x=1771437123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7HgZPa2miCYVW2v/gKDume2IN7/1BlZq+GIduUL4MI=;
        b=rwe/3O2pe8DlPe/F/eX2DYrlNcqohWYCXNO7H1iiu3KBtRfoUst07MlzWyZN5/QCaC
         qXPplZ/eclum5bgV2HpxCkVB11heY1jl5rKfHOIqauT/1A4e+9SBb6F1Yrvn9SHQyoij
         3NzENztfC42Be4/0yR8el0TZM3MKi8lfGW7jqMBoTXV+cHs+F1mTI/GDGa3G2GwSss79
         7yyhIQy4CzLDDfeKPVvDgtRJbk6+R3pJR92oAiOJegYS9q+KGQoN2eicNMXzGua9Gy4H
         yq9o68dqtShI23uzWyUMFQNnZnL88i8X4zltjlwlKEsV1Nouzi3gc0y0NYyyjuo/6cv4
         G33g==
X-Forwarded-Encrypted: i=1; AJvYcCVmPF92+WTDucgJzwB3GYnllbiTbDFDH266XHaTaEOdfaPHtdakDnlTxVNBYRIq9aVHuOzmsHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3LL7PSI7D1v2h1YsLonybrWMxc1FlWbfaQXgS5g7wQKeQhXE
	gA7ow57j7Z/HpbLcQV3NWHpJiwy18SMjon5GnhKpiQkdxzL7/WQfCdkNF96uTW+8Tmr74IQGnfp
	/uP0jRQ==
X-Received: from plbll16.prod.google.com ([2002:a17:903:910:b0:2a0:8cbb:6431])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf03:b0:2a8:d469:9b2c
 with SMTP id d9443c01a7336-2a95170bd94mr197184325ad.44.1770832323124; Wed, 11
 Feb 2026 09:52:03 -0800 (PST)
Date: Wed, 11 Feb 2026 17:50:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211175133.3657034-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv6: Fix out-of-bound access in fib6_add_rt2node().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,707d6a5da1ab9e0c6f9d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69CC5126B96
X-Rspamd-Action: no action

syzbot reported out-of-bound read in fib6_add_rt2node(). [0]

When IPv6 route is created with RTA_NH_ID, struct fib6_info
does not have the trailing struct fib6_nh.

The cited commit started to check !iter->fib6_nh->fib_nh_gw_family
to ensure that rt6_qualify_for_ecmp() will return false for iter.

If iter->nh is not NULL, rt6_qualify_for_ecmp() returns false anyway.

Let's check iter->nh before reading iter->fib6_nh and avoid OOB read.

[0]:
BUG: KASAN: slab-out-of-bounds in fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
Read of size 1 at addr ffff8880384ba6de by task syz.0.18/5500

CPU: 0 UID: 0 PID: 5500 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
 fib6_add_rt2node_nh net/ipv6/ip6_fib.c:1363 [inline]
 fib6_add+0x910/0x18c0 net/ipv6/ip6_fib.c:1531
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3957
 inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9316b9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8809b678 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9316e15fa0 RCX: 00007f9316b9aeb9
RDX: 0000000000000000 RSI: 0000200000004380 RDI: 0000000000000003
RBP: 00007f9316c08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9316e15fac R14: 00007f9316e15fa0 R15: 00007f9316e15fa0
 </TASK>

Allocated by task 5499:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_noprof+0x40c/0x7e0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x142/0x860 net/ipv6/route.c:3820
 ip6_route_add+0x49/0x1b0 net/ipv6/route.c:3949
 inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF")
Reported-by: syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/698cbfba.050a0220.2eeac1.009d.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index c6439e30e892..cc149227b49f 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1139,7 +1139,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					fib6_add_gc_list(iter);
 				}
 				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT)) &&
-				    !iter->fib6_nh->fib_nh_gw_family) {
+				    (iter->nh || !iter->fib6_nh->fib_nh_gw_family)) {
 					iter->fib6_flags &= ~RTF_ADDRCONF;
 					iter->fib6_flags &= ~RTF_PREFIX_RT;
 				}
-- 
2.53.0.239.g8d8fc8a987-goog


