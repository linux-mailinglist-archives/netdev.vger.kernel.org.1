Return-Path: <netdev+bounces-282975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO0uNumj82kQ5gEAu9opvQ
	(envelope-from <netdev+bounces-282975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B14A724D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D17030A3F2B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688147D95D;
	Thu, 30 Apr 2026 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiIvaBQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A747D93A
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574654; cv=none; b=ijMkVpaMIawqueEJL9GBtoBuNkfNqAQ/Do3kS0deVkRwvgqyiIvDjqGnxmVp780ceQskZFzmGKc0362XWjIXK03HD9PYbRpp5bXP2dsmMleJfYBkn/gmnMCFYLpKKv7qAVd1c9pRCXssIFrD2LsuQUnZr2Z6DcD9M1f2hqKtOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574654; c=relaxed/simple;
	bh=5cfjlg3GQ6sMGcsFREj82Hbpq0DXadM7BwJqf7Dy09Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yp61s6TJwzb/Tbr36Cru27j6I9iB+fTMm4cJ93DlDIWJeDc9ndEpozw3/8iaKhs+DnXq+uJEDuFTgIzzDorka9wD/nYkCrAzfaqRDjdy9ffbZstP83huDsSIABIzzpKEy25r399ihvG2EfiORROGuEHJzl7gaUrneGPdokrV2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MiIvaBQr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f70ae35c0so735565b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574650; x=1778179450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8OenfZCy+qWu1Qhs0vDlZYR6b4P/Y7vHqJjLORFF7s=;
        b=MiIvaBQrLzQjIpuU0GRioKi1QceZY2ut0QurdSc8V8FrF2E7ZNVdcXGo1qiL58XT57
         RuJWyVsvTovbbT5OAmUdLa1Aj+RhLFmol6fVue/qLiTV7x7WZmpEn21FGHRDeEx1V/QU
         snad2RBESDl9ggAZdwCGCtH/8jiOickhfKXiPu8sJnXssIQhiQDOeaYOId0Y8fRYZqTn
         qm4VfyhMrZ0dWpC51TzyK+i9sU++1KDsgCzouoLbfRuniqF3uJfnZWR4Es9hBl4OcW3u
         vvKvK7UA1+dpwMn8ECcPEwpKy+X4kqvwHuLAMOiDJvuJd8JaT261EsmgUo58HIeDAMcW
         iiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574650; x=1778179450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8OenfZCy+qWu1Qhs0vDlZYR6b4P/Y7vHqJjLORFF7s=;
        b=eC8bZK9x8Co4XSHM4sFnIGLxDgJWSzkaN/f3soi9q6HIqixCAMSwJwuTtiwCgo/Jzk
         6TCRlSwgS0/LKNmgAHAO8LnDufp4LvyFXzD99eizY6O4RcQro1hStIp/OqhtDHON97FV
         hIc0n5cRvN1sS0Y9XxL+me+ddIrtSnwlahiLT3/AjDhQiflkvBsZVFLEebyMWnCbTT65
         rpVLQLPQd02c9cuaZmGbOZSDbhntEORm4PL4eCyFp+7m8Q9k8s88rRrUSiObiXqv6v6d
         Arfb2BpWJ8mkIr9VQm5acwNt5xIAgLhdZuVjuE4N7uipnS66ItXZTSmEAswb9EaHveuf
         +fOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tAog5LHgCZQx/T9u1+mIYBJsLDa/ZU3AhltIOVmq1idmla85ivoYSp8wKuPV8qo0fRMH9dJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYsAL8imbp5mUMAzcRrLG5nu7CTGzaSoIW3LLRTpRZ0eHPgQ7
	lxc4cyW1LWr9CgxuiEL+O4iybaNr6sXiqwPdkXLnyTREpsPQ7xIjETXTQw5Q2nh1eROOyskeMj3
	Nu2bEag==
X-Received: from pfr21.prod.google.com ([2002:a05:6a00:94d5:b0:82f:b8b3:900f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4005:b0:82a:ea3:c172
 with SMTP id d2e1a72fcca58-834fdc92504mr4452770b3a.46.1777574650172; Thu, 30
 Apr 2026 11:44:10 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:43:51 +0000
In-Reply-To: <20260430184405.1227386-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430184405.1227386-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430184405.1227386-2-kuniyu@google.com>
Subject: [PATCH v1 bpf 1/2] bpf: tcp: Fix type confusion in bpf_tcp_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 485B14A724D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282975-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Calling bpf_setsockopt() in SOCKOPT prog triggers out-of-bounds
access to another slab object. [0]

Let's use sk_is_tcp().

[0]:
BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt (net/core/filter.c:5519)
Read of size 8 at addr ffff88801083d760 by task test_progs/1259

CPU: 1 UID: 0 PID: 1259 Comm: test_progs Tainted: G           OE       7.0.0-11175-gb5c111f4967b #1 PREEMPT(full)
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:595)
 sol_tcp_sockopt (net/core/filter.c:5519)
 __bpf_getsockopt (net/core/filter.c:5633)
 bpf_sk_getsockopt (net/core/filter.c:5654)
 bpf_prog_629ba00a1601e9f2__setsockopt+0x86/0x22c
 __cgroup_bpf_run_filter_setsockopt (./include/linux/bpf.h:1402 ./include/linux/filter.h:722 ./include/linux/filter.h:729 kernel/bpf/cgroup.c:81 kernel/bpf/cgroup.c:2026)
 do_sock_setsockopt (net/socket.c:2363)
 __x64_sys_setsockopt (net/socket.c:2406)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
RIP: 0033:0x7f85f82fe7de
Code: 55 48 63 c9 48 63 ff 45 89 c9 48 89 e5 48 83 ec 08 6a 2c e8 34 69 f7 ff c9 c3 66 90 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 e1
RSP: 002b:00007ffe59dcecd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f85f82fe7de
RDX: 000000000000001c RSI: 0000000000000006 RDI: 000000000000000d
RBP: 00007ffe59dcef20 R08: 000000000000003c R09: 0000000000000000
R10: 00007ffe59dcef00 R11: 0000000000000202 R12: 00007ffe59dcf268
R13: 0000000000000003 R14: 00007f85f9da5000 R15: 000055b2f3201400
 </TASK>

The buggy address belongs to the object at ffff88801083d280
 which belongs to the cache RAW of size 1792
The buggy address is located 1248 bytes inside of
 allocated 1792-byte region [ffff88801083d280, ffff88801083d980)

Fixes: 655a51e536c0 ("bpf: Add struct bpf_tcp_sock and BPF_FUNC_tcp_sock")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..cd88633f8dc1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 
 BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
 {
-	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
+	if (sk_fullsock(sk) && sk_is_tcp(sk))
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.54.0.545.g6539524ca2-goog


