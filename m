Return-Path: <netdev+bounces-253700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCXWDZ1AeGlXpAEAu9opvQ
	(envelope-from <netdev+bounces-253700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:35:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E78FDD1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB03F3029A47
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796A1DE8BB;
	Tue, 27 Jan 2026 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTpN3G6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCC14A91
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488535; cv=none; b=Bo/RQGOQOMCBOSBZLLJdyM7G/B/Mpr0TUxYXJDiquB8WFhXJABXXeq4yZje1hwQZafUFrWWJ/5x0wWiQLMcGKpr2pGY2PBb7PaptkSS7LPaFxB3fXwXB8sTgTfOmArre/L5hMyprcI8z94vDZzi2jZ5jKSOhsiVCEeqYzFJ2kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488535; c=relaxed/simple;
	bh=LpT4UqmQSHxaEBmEOk+HPdu0WT3mQPh+bx9mVn+nTTE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nufh+SBz2Rayi6aX9VZMVh8b0f3yaCVwgFj5NQD8ZB28CTd74XfXHpwZKGpJZn/KWCSgr3Q8TVNtOg80juXKWCB2hiBbbKnoAbxbv2Z0Rd3L8zfDdAGSCVj9lr4QGUegpQA+EhSKA6ILNNd8uVVJWMPFjaEal2xC7yaSJXkSAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTpN3G6E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso5607916a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769488534; x=1770093334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ziEifKkiuPs337en0hAfF5pGfm0tXpcONkUMyhpEC04=;
        b=gTpN3G6ERA5cGC9AiwUv/EsRRJXrwpwkOsOI1/H71VpUQ77Gqrhnlk08GX5xR6fMhl
         Wqoq61bHL0rBGbZ7BYR2/DkOYkTT34bASJFEScoxlPmiLgCY18xlhT40nwYfZeP2aH7X
         V+3IBY8wbEXQ130MILDQBNxg3zouiKeLXHTBsysvMDUqZHENdDgDY8tRpbU4KO+62fYt
         0JnkxZ6m231pfYQ7kS1IDVz0Wkd2PEQQR1encLRW0mBWDTW1AMqNn9E+E1o/Q/ogihCA
         eieWP4cFlbhdHg6aQM9RTLvus/cldWjGN981Tj638FTDJrq3gj6iyRemdGdxzVMTkz0a
         NUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769488534; x=1770093334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziEifKkiuPs337en0hAfF5pGfm0tXpcONkUMyhpEC04=;
        b=t6dW/u9b8T8geJ4gM2vHHhFR+J0bjy0w4Uo2HmG7fbzAyj1K6SI9UAW1FtnZIvN6X8
         qs2QfeLZy/zEzHYRJM4Ut4y8KM/ywJMnq+4XXhvj3Q6xPaGPCo7U68YwucDssFXLuGi/
         LCgckStvPqeGSuWtZlbELOKM0qJMeeB5SxYedUKyvl0ZoG5Ub4595R8bZOd769uLSWcE
         GXEItik7we6FYk49ORg2U5A0Sj5FPZtALrB5X8PhygTsIkyysEZ5JAt1L8rHTdYzOZ/x
         KixwtiSnC7+zxb/41W9r5XOVQuijdBy6MP8KnEmF2Q541TwrOE/1tiRTrI0BdGfkTKBl
         9E2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW32mGUVRQVdLO+zV9toEYbCCaKc/XO0dJ+YgucNkuIWPpxTIwfWyy8IfawOb1bQnKQMXfqPVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLaqw5DCgNL2S4vTsNKQm1tMYs17SRK8zPYBVl3bmgTUc88WtT
	I3cQzv6rZW9iCNbGyPiOKKhlyyUPCYYsDXVRInr8DLT4h8dL3hAAGRao++XQymZUO6CO+ozBu1/
	B5aYilA==
X-Received: from pghi9.prod.google.com ([2002:a63:e909:0:b0:c1d:67e2:834])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3948:b0:38b:d93f:b409
 with SMTP id adf61e73a8af0-38ec5e7b317mr418419637.25.1769488533721; Mon, 26
 Jan 2026 20:35:33 -0800 (PST)
Date: Tue, 27 Jan 2026 04:35:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127043528.514160-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] ipv4: fib: Annotate access to struct fib_alias.fa_state.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253700-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,d24f940f770afda885cf];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 877E78FDD1
X-Rspamd-Action: no action

syzbot reported that struct fib_alias.fa_state can be
modified locklessly by RCU readers. [0]

Let's use READ_ONCE()/WRITE_ONCE() properly.

[0]:
BUG: KCSAN: data-race in fib_table_lookup / fib_table_lookup

write to 0xffff88811b06a7fa of 1 bytes by task 4167 on cpu 0:
 fib_alias_accessed net/ipv4/fib_lookup.h:32 [inline]
 fib_table_lookup+0x361/0xd60 net/ipv4/fib_trie.c:1565
 fib_lookup include/net/ip_fib.h:390 [inline]
 ip_route_output_key_hash_rcu+0x378/0x1380 net/ipv4/route.c:2814
 ip_route_output_key_hash net/ipv4/route.c:2705 [inline]
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x65/0x110 net/ipv4/route.c:2932
 udp_sendmsg+0x13c3/0x15d0 net/ipv4/udp.c:1450
 inet_sendmsg+0xac/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x53a/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmmsg+0x185/0x320 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2759
 x64_sys_call+0x1e28/0x3000 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811b06a7fa of 1 bytes by task 4168 on cpu 1:
 fib_alias_accessed net/ipv4/fib_lookup.h:31 [inline]
 fib_table_lookup+0x338/0xd60 net/ipv4/fib_trie.c:1565
 fib_lookup include/net/ip_fib.h:390 [inline]
 ip_route_output_key_hash_rcu+0x378/0x1380 net/ipv4/route.c:2814
 ip_route_output_key_hash net/ipv4/route.c:2705 [inline]
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x65/0x110 net/ipv4/route.c:2932
 udp_sendmsg+0x13c3/0x15d0 net/ipv4/udp.c:1450
 inet_sendmsg+0xac/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x53a/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmmsg+0x185/0x320 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2759
 x64_sys_call+0x1e28/0x3000 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4168 Comm: syz.4.206 Not tainted syzkaller #0 PREEMPT(voluntary)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025

Reported-by: syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69783ead.050a0220.c9109.0013.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_lookup.h | 6 ++++--
 net/ipv4/fib_trie.c   | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_lookup.h b/net/ipv4/fib_lookup.h
index f9b9e26c32c1..0b72796dd1ad 100644
--- a/net/ipv4/fib_lookup.h
+++ b/net/ipv4/fib_lookup.h
@@ -28,8 +28,10 @@ struct fib_alias {
 /* Don't write on fa_state unless needed, to keep it shared on all cpus */
 static inline void fib_alias_accessed(struct fib_alias *fa)
 {
-	if (!(fa->fa_state & FA_S_ACCESSED))
-		fa->fa_state |= FA_S_ACCESSED;
+	u8 fa_state = READ_ONCE(fa->fa_state);
+
+	if (!(fa_state & FA_S_ACCESSED))
+		WRITE_ONCE(fa->fa_state, fa_state | FA_S_ACCESSED);
 }
 
 /* Exported by fib_semantics.c */
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 7e2c17fec3fc..1308213791f1 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1280,7 +1280,7 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 			new_fa->fa_dscp = fa->fa_dscp;
 			new_fa->fa_info = fi;
 			new_fa->fa_type = cfg->fc_type;
-			state = fa->fa_state;
+			state = READ_ONCE(fa->fa_state);
 			new_fa->fa_state = state & ~FA_S_ACCESSED;
 			new_fa->fa_slen = fa->fa_slen;
 			new_fa->tb_id = tb->tb_id;
@@ -1745,7 +1745,7 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	fib_remove_alias(t, tp, l, fa_to_delete);
 
-	if (fa_to_delete->fa_state & FA_S_ACCESSED)
+	if (READ_ONCE(fa_to_delete->fa_state) & FA_S_ACCESSED)
 		rt_cache_flush(cfg->fc_nlinfo.nl_net);
 
 	fib_release_info(fa_to_delete->fa_info);
-- 
2.52.0.457.g6b5491de43-goog


