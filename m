Return-Path: <netdev+bounces-259530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLunLBRJl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:32:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF20C161393
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCD8E300A589
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E728D34B1B6;
	Thu, 19 Feb 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8sype1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692133D6C0
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522312; cv=none; b=cyX1kXfNovZcZKpe/eImiXKZ9sehuOYrNMgU4bUVcNeX5OHoLokLvlLas41xhhtyja29JiW4X6rIrwe9WhSuHRuz2HLBx9+E7nG9oeagv3A/essTun/WHLX9xvTEA2IdoIpMhMwBoHnEZd4e2xUeKgMLWxPCZY+rF2X5qsdeVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522312; c=relaxed/simple;
	bh=cH3A+hNy82Z3Nr6KCoi3z9+vio0RgXsvawO4HmHjvNA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wf6LtYiJscUzqEP/0+TaRDbxum7C17xwkVXwyh+hW+m2g/ErRmUwznqhiJ2UZuB6LkcKAYkv5S/whYPzsZ3OFD9F8YREdUpLpKlJKOr2/yqGLGnPIte8ufynZQ6cyMqj4wNaa4BQ2G4QDYRYf9V7Gk6veHdJDwm3mETtCYzYU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8sype1B; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a75ed2f89dso12058565ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522311; x=1772127111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+qxRZORX5q6GWWaQwZmJwHUXEeLDsk4PQC2ak6epgo=;
        b=X8sype1B5rI9iYSZxOWHc4l2cJHg0cPoqIgS/P/5WEl9zKGXkxlap0++kabPRCK39j
         VvUGe0SD1d7Gd9LmOmr2Es/+TQ9XdPmoYQN4sLfsJShXoEjFjbMTAPhjXEvfqDJRwGLs
         fv1mWVv+6Mx2WyaRpLINBhBJFZiu3d6PXzmwYLK0CUlH+tKPXYwFbqEKeKY8v8CaUv3Q
         xp7OJZ2oTtdbsYvwAOXLfzV1RQUTsIJ2AcIju87AYMyOQBxRvTAuc9rAtpxw9Sxe2BVh
         1CN29byJK12tXd4MvemwNCcnwik5MFQwS4SbG2QsFC3B7X1YUzN6COTBR230pDUh1tZr
         z7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522311; x=1772127111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+qxRZORX5q6GWWaQwZmJwHUXEeLDsk4PQC2ak6epgo=;
        b=rI0buoq9lSWtgKQhRBIDa2LPnvWIu42lyX8k7CZMS/zzKa+bvqGPIc4c/ikZw5j30S
         svgY1R8B2oFjkZbXTxtX1+LbzqxpTOFI3VXYS/mtMEBmkPxJoLdCTPztuSKr02djnnle
         cn3hnlRkT8DAawNB+9DENiBsuymeR+wlg3TuNHAFH3TSoshsrW6rDjWKR/evib3fwKxy
         D2nt+J6iorojPu02aDUtDzEBpzgtLDjK58UcmN9M0tvsfet3EiPMIQ5ES/9tabCHwieW
         dBWBe2lfU6Qj2qwY4mQBbHnaeNKmJj+CwYLzafymJ1kwlYr+Fw5VgtuHv9aUMOXTZHkX
         +MHg==
X-Forwarded-Encrypted: i=1; AJvYcCU2HV54pPOlqCnNRQKNMl8IP/LZ2QLTaI77XGnrYEMIfKdPluOck3aN5IFmFozEhlI4VCQ06Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0jCwPR7AR/Xkzid8JqfzXYG1Nx7Egb/kx25nJT7nsA9m2N5l
	426kS83G5sHeTKI7nfEADTaspaA4YfEb7B5ilBon0/UEucLzFwp9M/6RNjKzprIe9rMHKmssWr3
	GqbbNJw==
X-Received: from plty7.prod.google.com ([2002:a17:902:8647:b0:2aa:d3db:a8d7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41cc:b0:2aa:e7fe:63b8
 with SMTP id d9443c01a7336-2ad174dd3b7mr183006395ad.33.1771522310614; Thu, 19
 Feb 2026 09:31:50 -0800 (PST)
Date: Thu, 19 Feb 2026 17:31:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173142.310741-1-kuniyu@google.com>
Subject: [PATCH v1 net] udplite: Fix null-ptr-deref in __udp_enqueue_schedule_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259530-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Queue-Id: EF20C161393
X-Rspamd-Action: no action

syzbot reported null-ptr-deref of udp_sk(sk)->udp_prod_queue. [0]

Since the cited commit, udp_lib_init_sock() can fail, as can
udp_init_sock() and udpv6_init_sock().

Let's handle the error in udplite_sk_init() and udplitev6_sk_init().

[0]:
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x151/0x1480 net/ipv4/udp.c:1719
Read of size 4 at addr 0000000000000008 by task syz.2.18/2944

CPU: 1 UID: 0 PID: 2944 Comm: syz.2.18 Not tainted syzkaller #0 PREEMPTLAZY
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 kasan_report+0xa2/0xe0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 __udp_enqueue_schedule_skb+0x151/0x1480 net/ipv4/udp.c:1719
 __udpv6_queue_rcv_skb net/ipv6/udp.c:795 [inline]
 udpv6_queue_rcv_one_skb+0xa2e/0x1ad0 net/ipv6/udp.c:906
 udp6_unicast_rcv_skb+0x227/0x380 net/ipv6/udp.c:1064
 ip6_protocol_deliver_rcu+0xe17/0x1540 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x191/0x350 net/ipv6/ip6_input.c:489
 NF_HOOK+0x354/0x3f0 include/linux/netfilter.h:318
 ip6_input+0x16c/0x2b0 net/ipv6/ip6_input.c:500
 NF_HOOK+0x354/0x3f0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6149 [inline]
 __netif_receive_skb+0xd3/0x370 net/core/dev.c:6262
 process_backlog+0x4d6/0x1160 net/core/dev.c:6614
 __napi_poll+0xae/0x320 net/core/dev.c:7678
 napi_poll net/core/dev.c:7741 [inline]
 net_rx_action+0x60d/0xdc0 net/core/dev.c:7893
 handle_softirqs+0x209/0x8d0 kernel/softirq.c:622
 do_softirq+0x52/0x90 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xe7/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x109c/0x2dc0 net/core/dev.c:4856
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x158/0x4e0 net/ipv6/ip6_output.c:219
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x342/0x580 net/ipv6/ip6_output.c:246
 ip6_send_skb+0x1d7/0x3c0 net/ipv6/ip6_output.c:1984
 udp_v6_send_skb+0x9a5/0x1770 net/ipv6/udp.c:1442
 udp_v6_push_pending_frames+0xa2/0x140 net/ipv6/udp.c:1469
 udpv6_sendmsg+0xfe0/0x2830 net/ipv6/udp.c:1759
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe5/0x270 net/socket.c:742
 __sys_sendto+0x3eb/0x580 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0xf20 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f67b4d9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67b5c98028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f67b5015fa0 RCX: 00007f67b4d9c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f67b4e32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000040000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f67b5016038 R14: 00007f67b5015fa0 R15: 00007ffe3cb66dd8
 </TASK>

Fixes: b650bf0977d3 ("udp: remove busylock and add per NUMA queues")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
I'll remove UDP-Lite entirely once net-next opens next week.
---
 net/ipv4/udplite.c | 3 +--
 net/ipv6/udplite.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index d3e621a11a1a..826e9e79eb19 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -20,10 +20,9 @@ EXPORT_SYMBOL(udplite_table);
 /* Designate sk as UDP-Lite socket */
 static int udplite_sk_init(struct sock *sk)
 {
-	udp_init_sock(sk);
 	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
 		     "please contact the netdev mailing list\n");
-	return 0;
+	return udp_init_sock(sk);
 }
 
 static int udplite_rcv(struct sk_buff *skb)
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 2cec542437f7..e867721cda4d 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -16,10 +16,9 @@
 
 static int udplitev6_sk_init(struct sock *sk)
 {
-	udpv6_init_sock(sk);
 	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
 		     "please contact the netdev mailing list\n");
-	return 0;
+	return udpv6_init_sock(sk);
 }
 
 static int udplitev6_rcv(struct sk_buff *skb)
-- 
2.53.0.345.g96ddfc5eaa-goog


