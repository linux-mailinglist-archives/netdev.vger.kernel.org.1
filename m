Return-Path: <netdev+bounces-280569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFOZGlZx6WniZgIAu9opvQ
	(envelope-from <netdev+bounces-280569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D344C05F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4761530058DE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2E27FB2A;
	Thu, 23 Apr 2026 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvSOX0NS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC17D531
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906578; cv=none; b=E0Xd/cVUg2dBXeWA+LsLSm2V0t3mtWV80uaUD6pxW6JADwp7XhPW8zZYF876KUTFMIdBDA0nsb8H8cL1DvyRtbU8vao9xVG9FVimeg8TXGv+wtz5G5Vot/aS+kxbuCoWcT1HWrISWHpgN6W/OdQ5suLp1wWhVuJ56lPnZWMzVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906578; c=relaxed/simple;
	bh=G0fWXcpsumiQWbIF+CRC3d2rl/yp4ny1tPloTWFYEko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oDaY682P2N3lCE99IxguyRc38cgyBuz4DXL5TlE9q5heEz1c4kpeIaQbyIkZaOWLSkitgi+wC1DCEWewLnfGXMGzq85+7PlZrM58f142MxznLGesl6hLfFk3+V/SMgVmdloXdd6ioUeKLI7UkDoFkIhbgAF+5oO21qJRcAOZ8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvSOX0NS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f5f48458eso3595593b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776906577; x=1777511377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDZHDtDqpfzbVV04Qhj+qX0cLthlms0tlhiGlbb7lzM=;
        b=YvSOX0NS+hlaK123L+ucBfeuOBuhUp9wTVpD1I5qC9XWPgnzIWZFaUS9FUG+8DSyWZ
         IgVVkaaMwa58e8z8S6xb6iBCJXO6bz0WtNd3E9n78Rqo2s2dAHvOlbFmE/X5CzQTPjDF
         8xjIAC+Y9WThmWv4C/C/+gaMOiDvq6bWmU9U+EWEiMNukjZnMbX/llDoWp2Q5MdcyDU/
         osTzRXeVWjiUd0vSKw6gBglfX9oRxPj6X5c2glNMgoIbCipojKRm5CoNk7tqlrbgxNtX
         NLyCYtHj+bQPf9HOAuHsSSPFL6on16fgOZsuD+U37Xt9rYmfXXKCqI0rwPW5iqIJ0mjG
         SGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776906577; x=1777511377;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDZHDtDqpfzbVV04Qhj+qX0cLthlms0tlhiGlbb7lzM=;
        b=KWtrxkd6UpOdB4UHVv0n/oG+0+gJbOBQPeiClF6VvQknkZ2LIDhBKro1OZLy1wP5Oj
         JealV3wPUDe8olgrrFlwASSvItpYS5IcaobWIwyAUeBgTiYPzoENT5lxv9Rcpa6ctFzj
         jgDeDuJIkxflVBzAkc37lWgGSv995fAkvsJL7UiEboq0CcgR0F4qPKp8dW4Yx1ooDi9M
         vYCsK/XuOqX3vc6a5GHBXEipY1dIJRxTbi/QRy1+ARBu3rzu0ScMP4dWuS1aqlcbYaPP
         xgkOut3OyVzWG1DepJlgf7PcozhHYyjtUwp76KZsE6i4mljZ9KE5IO7vqoh50Ssi2jQz
         Xu4g==
X-Forwarded-Encrypted: i=1; AFNElJ/3f8IVEX+rQjL0qRXtPIWC18SDSRsL2RWH54WxzVIuvMVZhOhFrTIh+2j/lpqiAkMsmz4Eu78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClLTgFoe0UR7dN3op69BQFsNgGpgEJ/WIuuN6D7cDWKbROejk
	L5Ls2R//CWIdwwly+kQ1VOdXkY/4mLhjZXH7F7F4fLc1okCbFhbINpJBz/88V5ohyqbSpVhCI6E
	b4kjO1Q==
X-Received: from pfbhw5.prod.google.com ([2002:a05:6a00:8905:b0:82f:71fd:3094])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8710:b0:82f:d34c:ccc6
 with SMTP id d2e1a72fcca58-82fd34ccd79mr5805895b3a.10.1776906576633; Wed, 22
 Apr 2026 18:09:36 -0700 (PDT)
Date: Thu, 23 Apr 2026 01:09:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423010933.3899132-1-kuniyu@google.com>
Subject: [PATCH v1 net] udp: Use READ_ONCE()/WRITE_ONCE() for hslot->count.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, David Held <drheld@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280569-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,04905b8b3523856476c0];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF2D344C05F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__udp4_lib_mcast_demux_lookup() and __udp4_lib_mcast_deliver()
reads the number of sockets in the 1-tuple hash table chain
locklessly. [0]

Let's use READ_ONCE() and WRITE_ONCE() for hslot->count.

[0]:
BUG: KCSAN: data-race in __udp4_lib_mcast_deliver / udp_lib_unhash

read-write to 0xffff88810194a9c8 of 4 bytes by task 15107 on cpu 0:
 udp_lib_unhash+0x1f4/0x3e0 net/ipv4/udp.c:2261
 sk_common_release+0x7a/0x230 net/core/sock.c:3990
 udp_lib_close+0x15/0x20 include/net/udp.h:324
 inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:469
 ____fput+0x1c/0x30 fs/file_table.c:497
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x1f4/0x6f0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x249/0x370 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810194a9c8 of 4 bytes by task 15111 on cpu 1:
 __udp4_lib_mcast_deliver+0x9a/0x790 net/ipv4/udp.c:2564
 __udp4_lib_rcv+0x972/0x1250 net/ipv4/udp.c:2749
 udp_rcv+0x4f/0x60 net/ipv4/udp.c:2936
 ip_protocol_deliver_rcu+0x3f7/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x415/0x6a0 net/ipv4/ip_input.c:644
 ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6207 [inline]
 __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6254
 __netif_receive_skb_list net/core/dev.c:6306 [inline]
 netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6397
 netif_receive_skb_list+0x35/0x220 net/core/dev.c:6449
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1397
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4722
 __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 15111 Comm: syz.6.4060 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026

Fixes: 2dc41cff7545 ("udp: Use hash2 for long hash1 chains in __udp*_lib_mcast_deliver.")
Fixes: 63c6f81cdde5 ("udp: ipv4: do not waste time in __udp4_lib_mcast_demux_lookup")
Reported-by: syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69e97093.050a0220.24bfd3.0048.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/udp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..f7e6045f5985 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -323,7 +323,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		sock_set_flag(sk, SOCK_RCU_FREE);
 
 		sk_add_node_rcu(sk, &hslot->head);
-		hslot->count++;
+		WRITE_ONCE(hslot->count, hslot->count + 1);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
@@ -2200,7 +2200,7 @@ void udp_lib_unhash(struct sock *sk)
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_detach_sock(sk);
 		if (sk_del_node_init_rcu(sk)) {
-			hslot->count--;
+			WRITE_ONCE(hslot->count, hslot->count - 1);
 			inet_sk(sk)->inet_num = 0;
 			sock_prot_inuse_add(net, sk->sk_prot, -1);
 
@@ -2471,7 +2471,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	hash2_any = 0;
 	hash2 = 0;
 	hslot = udp_hashslot(udptable, net, hnum);
-	use_hash2 = hslot->count > 10;
+	use_hash2 = READ_ONCE(hslot->count) > 10;
 	offset = offsetof(typeof(*sk), sk_node);
 
 	if (use_hash2) {
@@ -2703,7 +2703,7 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
 	hslot = &udptable->hash[slot];
 
 	/* Do not bother scanning a too big list */
-	if (hslot->count > 10)
+	if (READ_ONCE(hslot->count) > 10)
 		return NULL;
 
 	result = NULL;
-- 
2.54.0.rc2.533.g4f5dca5207-goog


