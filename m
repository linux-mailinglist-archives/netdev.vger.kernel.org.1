Return-Path: <netdev+bounces-259840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BynBdVAmmlXaAMAu9opvQ
	(envelope-from <netdev+bounces-259840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:33:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CD16E3FA
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B05304DC97
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66E31619C;
	Sat, 21 Feb 2026 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrX60xnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438B3093C3
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716764; cv=none; b=iJzHT/wW1fiCyQvRGvLxEOSxomms/vs5k6fsasSKn2znrlwYbBMS2AKEdhPF7msIl8U7TxB9ArEow2UgFIumn3Fe3e4/mb0nrkp4uxYLMBxYjqM7eGLjl78CNO7avkc6B+GYHXPnia/bY3ibaisaA3iPjMz8wMDSVA+D7vvBIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716764; c=relaxed/simple;
	bh=ZtFK/yC3hdTsPK+be6lCjLsbn+fSGVW7wabU5dyoOMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ujQm8l9ZUYjxIIbqsQFISLRQva4ydKxM/B4jDqIpcUNh4yJwqxd8ubISiMh3GGrgAB9Jz+usSxpTl4y2C/hpGqUdXqS1lGO/4IFpMLK9PyLGNDMsMX64t7EvS8tuhlVvE0WAeSDoba4voQ/GKp7KEf50UxUdyVf7GVOurRvZ8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrX60xnP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3569ceeb335so2993453a91.2
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716762; x=1772321562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX/drHU1f8Nu0uTkyf1VGMNVKPo+Ic7lbpffvpHPw+4=;
        b=vrX60xnP/r0ZrlltyRcsWlHcndM5l8eBD4PqyDrnqIKQRFarsaoosSgxtKG1vZj8Md
         4N7wdFv4zz+xj+pw2znmjzr8OMOYKRLoGnimeZsN2qa+geH/6NVOf65atS4lLiCBRLYR
         XDScsNgg7JGjqnz2djLcOBxCo82PNbanqS7BeyyQiIM8eCcAuMypGn2KX3JLt9sTxUDg
         W05ZDzzNVp74P8iNSQGSBxG0D8TK6Qn7CgP+feaGgfdlzltMII78hC4xggKKL4QQ52sv
         wvbc1Vz8AVRcP8jdVSpkQLOJHLDOdkrMJNRDj3ZVPEOXDWiaLQe37LXiLHkzcXHI28GN
         WvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716762; x=1772321562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TX/drHU1f8Nu0uTkyf1VGMNVKPo+Ic7lbpffvpHPw+4=;
        b=sNAyqKx0cIV0vqexgtFCQiOCAGP29Lc/QaiyMbi0YHdeltgn7NaHJzLDBfy5pfsWZy
         jrnYcOmwodOO3Cd4qCGiJSGHZgPFD/mVsCttmTz0o6WByN037KDvEoPvsjZI0sCkfb0Q
         zh5m+2fSU+1AFpy32uyu7wnVsjZqpHEpoPDQUzPQe1EVGlgPRsrug5s/VVyIWJ/qdb7C
         TbQRHEGqgyPY9tcQ5A/eg8NRJ1ABXNzrIbgawgM/xm9uYhPS/3KNj4SFhgPmYIeDLsg7
         ofFBuobjRwjVLInrneZw8c52B3YYj33ainetaeqC08XL3C4/N4FdATacobjKyjt6QuXp
         6nSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0vFpSmXjSmNO92tUrnDZCFnC3yvz6a3txRbDA72AdohPI8SwVeu39eBRk9ZZRCIV4Fmdxk7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRWpcV/R3RhKIhRoHBJ/BKPxkZIt4jcvbRM/AT9fwdwROv4Pt
	raOqTBMD72hfZwkEqdcZOxAdLTClAS6oSD95HUGI/ZLQ/JUNl2/0Esf2TJgbMDSi7UvXP+rpNAt
	MjAkx3g==
X-Received: from pjwo2.prod.google.com ([2002:a17:90a:d242:b0:354:7baa:9ee6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc7:b0:343:7714:4caa
 with SMTP id 98e67ed59e1d1-358ae7ba72fmr3638100a91.3.1771716762052; Sat, 21
 Feb 2026 15:32:42 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:50 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-4-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in udp_bpf_recvmsg().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,9307c991a6d07ce6e6d8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 6F1CD16E3FA
X-Rspamd-Action: no action

syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0]

sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
but its processing is lockless.

Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
multiple threads could touch the same sk_msg.

For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock.

Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
commit accidentally removed it.

Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().

Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
an option due to copy_page_to_iter() in sk_msg_recvmsg().

[0]:
BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020

CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
 udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
 inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x1a8/0x270 net/socket.c:1100
 ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
 ___sys_recvmsg+0x215/0x590 net/socket.c:2854
 do_recvmmsg+0x334/0x800 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb319f9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb31ad97028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fb31a216090 RCX: 00007fb319f9aeb9
RDX: 0000000000000001 RSI: 0000200000000400 RDI: 0000000000000004
RBP: 00007fb31a008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000040000021 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb31a216128 R14: 00007fb31a216090 R15: 00007ffe21dd0a98
 </TASK>

Allocated by task 6019:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 alloc_sk_msg net/core/skmsg.c:510 [inline]
 sk_psock_skb_ingress_self+0x60/0x350 net/core/skmsg.c:612
 sk_psock_verdict_apply net/core/skmsg.c:1038 [inline]
 sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1236
 udp_read_skb+0x73e/0x7e0 net/ipv4/udp.c:2045
 sk_psock_verdict_data_ready+0x12d/0x550 net/core/skmsg.c:1257
 __udp_enqueue_schedule_skb+0xc54/0x10b0 net/ipv4/udp.c:1789
 __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
 udp_queue_rcv_one_skb+0xac5/0x19c0 net/ipv4/udp.c:2475
 __udp4_lib_mcast_deliver+0xc06/0xcf0 net/ipv4/udp.c:2585
 __udp4_lib_rcv+0x10f6/0x2620 net/ipv4/udp.c:2724
 ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 dst_input include/net/dst.h:474 [inline]
 ip_sublist_rcv_finish+0x221/0x2a0 net/ipv4/ip_input.c:584
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x5c6/0xa70 net/ipv4/ip_input.c:644
 ip_list_rcv+0x3f1/0x450 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
 __netif_receive_skb_list_core+0x7e5/0x810 net/core/dev.c:6242
 __netif_receive_skb_list net/core/dev.c:6294 [inline]
 netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6385
 netif_receive_skb_list+0x54/0x410 net/core/dev.c:6437
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x1946/0x1cf0 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x81c/0x1160 net/bpf/test_run.c:1396
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6021:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1be/0x650 mm/slub.c:6882
 kfree_sk_msg include/linux/skmsg.h:385 [inline]
 sk_msg_recvmsg+0xaa8/0xc30 net/core/skmsg.c:483
 udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
 inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x1a8/0x270 net/socket.c:1100
 ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
 ___sys_recvmsg+0x215/0x590 net/socket.c:2854
 do_recvmmsg+0x334/0x800 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/udp_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 779a3a03762f..b07774034a91 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -52,7 +52,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	ret = udp_msg_has_data(sk, psock);
 	if (!ret) {
+		release_sock(sk);
 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
 		ret = udp_msg_has_data(sk, psock);
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -81,6 +83,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 	}
 
+	lock_sock(sk);
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
@@ -92,11 +95,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (data) {
 			if (psock_has_data(psock))
 				goto msg_bytes_ready;
+
+			release_sock(sk);
+
 			ret = sk_udp_recvmsg(sk, msg, len, flags, addr_len);
 			goto out;
 		}
 		copied = -EAGAIN;
 	}
+
+	release_sock(sk);
+
 	ret = copied;
 out:
 	sk_psock_put(sk, psock);
-- 
2.53.0.371.g1d285c8824-goog


