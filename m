Return-Path: <netdev+bounces-281132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t0RuJeBp7WmujQAAu9opvQ
	(envelope-from <netdev+bounces-281132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 03:26:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D04688AF
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 03:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBB0A3006164
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 01:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5171F30BB;
	Sun, 26 Apr 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qClxw5Cq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00714A4F0
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777166811; cv=none; b=UPKnYBYOw5kU05iyaHBIfDmBRzXQzsR8rAPbzLKk2SiqQhmrjxSXi615uY4grJ7VKo5W42izbGuFIl3Biqa8mdzdtCZBjIjZMgWALTzEMLf7swAwZbj1X0ewh679s1iMHWV2neZnyTo2yIFVNQvVYvdgs62WrKMTjsh6vztb5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777166811; c=relaxed/simple;
	bh=Gl+hYW7LqIVC0CINBWs+S5dOrmK6HI24E8dXahLtQBg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lYvUy1H7MbV6fa1yJDNmAlEiFHgUrNlQW98E9p8ywPWUnJEMdc31R1q+BpRA2SCH0g6GL0Cal2UrExUzOnL+IlEtAoou3QUjUCrK0tZFv6kgngKPqOe9L0JobdUgJH0lLYT/q49SlW6DclwJdLayaHVZDQ7n5O5oXLyCfQmy0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qClxw5Cq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso11512515a91.0
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777166810; x=1777771610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ONWQvj5cDHYA8LVXOFm9Whn8axjzb1Wzfxrs7kxCqxs=;
        b=qClxw5CqWVBlDq5F0BQkEUrHoI6yvVpJkJYkCQqtz9szmlT94NLt+kwwF6bwPKrXnV
         yD5W8RS6quyVzTJXr5OgYUHclvnJ9nTiyYHLxlOQImThO3nb306202SExvLxUPrZFMKI
         fYngIj188NaIq3eIsyNDgnQ4uaCugF3/T/LBMvViLYfmu6E+8iGLc7TIFaBvgosXpyPF
         xQR8J87IybIoM49PHewVq9ZiNEKZocuQrJnenOQs+JP/8WhXmnhTCKQNz/QQpDw+vH8/
         MK6G9iZawA/IhNZnXWlV7+OKzhberJDIQAm6Yo151MLksSQNsS8VqoksAi3mExahVebk
         E5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777166810; x=1777771610;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONWQvj5cDHYA8LVXOFm9Whn8axjzb1Wzfxrs7kxCqxs=;
        b=M53KXnupiRB0tibP/TjyD2S17EavhQCvCD+IeLb1leG7y9bYVfmf9uCK8eFMTweDgi
         dLn3DysJUrEGfwxbu679cWqCud9OHPn8bHSjYoVcq4VtbvEc8VUwEd8gS/ehqtePxyVn
         1J6z/Z1PckF2X24rvVh7kU03BG9ChiNg5C9bU4Xii9pKWNHM87ew6iqixT2AW8sXfhIY
         r+4rs6y8u8DpKtqR00BhkJHJc7aaWFej2m2cZt0HdrsuQV3hYnvBsb6M1Xgr6QpD+Pga
         8dK3ImeCxjbV7wxTOcT5RilzOUQh56RxBHeYVJ4verStdQmR6gMukpAyUiXzW0q7Ihvd
         JQ5g==
X-Forwarded-Encrypted: i=1; AFNElJ+YTd2vgg18Vg53rIN3GlWnxqZnTgblohHmsc4UdwdO+PhaLLzss+pEn3mtpDXIvTsqon8wPgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAv38cWPQQKv/Rsko1/nqkHh3EzsxrBr/pK7xfesor9hEZFAt
	EV6nBI3wfw73mN7VG2M3fP9Kgn75CG3+mt6nrm7WE16AZ5KKwrLY0dbVoRYSUJxQl8ujtYp1Lrc
	yAFdaWQ==
X-Received: from pjbgz21.prod.google.com ([2002:a17:90b:ed5:b0:35d:a917:a7bf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dc8:b0:35f:b6a1:8d23
 with SMTP id 98e67ed59e1d1-3614040b34bmr41517619a91.11.1777166809512; Sat, 25
 Apr 2026 18:26:49 -0700 (PDT)
Date: Sun, 26 Apr 2026 01:26:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260426012647.3233119-1-kuniyu@google.com>
Subject: [PATCH v2 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1D0D04688AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,snu.ac.kr];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281132-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Eulgyu Kim reported the splat below with a repro. [0]

The repro sets up a UDP reuseport group with a cBPF prog and
replaces it with a new one while another thread is sending
a UDP packet to the group.

The reuseport prog is freed by sk_reuseport_prog_free().
bpf_prog_put() is called for "e"BPF prog to destruct through
multiple stages while cBPF prog is freed immediately by
bpf_release_orig_filter() and bpf_prog_free().

If a reuseport prog is detached from the setsockopt() path
(reuseport_attach_prog() or reuseport_detach_prog()),
sk_reuseport_prog_free() is called without waiting for RCU
readers to complete, resulting in various bugs.

Let's defer freeing the reuseport cBPF prog after one RCU
grace period.

Note "e"BPF prog is safe as is unless the fast path starts
to touch fields destroyed in bpf_prog_put_deferred() and
__bpf_prog_put_noref().

[0]:
BUG: KASAN: vmalloc-out-of-bounds in reuseport_select_sock+0xedc/0x1220 net/core/sock_reuseport.c:596
Read of size 4 at addr ffffc9000051e004 by task slowme/10208
CPU: 6 UID: 1000 PID: 10208 Comm: slowme Not tainted 7.0.0-geb7ac95ff75e #32 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 reuseport_select_sock+0xedc/0x1220 net/core/sock_reuseport.c:596
 udp4_lib_lookup2+0x3bc/0x950 net/ipv4/udp.c:495
 __udp4_lib_lookup+0x768/0xe20 net/ipv4/udp.c:723
 __udp4_lib_lookup_skb+0x297/0x390 net/ipv4/udp.c:752
 __udp4_lib_rcv+0x1312/0x2620 net/ipv4/udp.c:2752
 ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6181 [inline]
 __netif_receive_skb net/core/dev.c:6294 [inline]
 process_backlog+0xaa4/0x1960 net/core/dev.c:6645
 __napi_poll+0xae/0x340 net/core/dev.c:7709
 napi_poll net/core/dev.c:7772 [inline]
 net_rx_action+0x5d7/0xf50 net/core/dev.c:7929
 handle_softirqs+0x22b/0x870 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x1dd7/0x3710 net/core/dev.c:4890
 neigh_output include/net/neighbour.h:556 [inline]
 ip_finish_output2+0xca9/0x1070 net/ipv4/ip_output.c:237
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x29f/0x450 net/ipv4/ip_output.c:438
 ip_send_skb+0x45/0xc0 net/ipv4/ip_output.c:1508
 udp_send_skb+0xb04/0x1510 net/ipv4/udp.c:1195
 udp_sendmsg+0x1a71/0x2350 net/ipv4/udp.c:1485
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x554/0x680 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x415a2d
Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6bc31e41e8 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f6bc31e4cdc RCX: 0000000000415a2d
RDX: 0000000000000001 RSI: 00007f6bc31e421f RDI: 0000000000000003
RBP: 00007f6bc31e4240 R08: 00007f6bc31e4220 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000212 R12: 00007f6bc31e46c0
R13: ffffffffffffffb8 R14: 0000000000000000 R15: 00007ffc9b0d70b0
 </TASK>

Fixes: 538950a1b752 ("soreuseport: setsockopt SO_ATTACH_REUSEPORT_[CE]BPF")
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Drop unnecessary arg change.
v1: https://lore.kernel.org/bpf/20260424235247.1990272-1-kuniyu@google.com/
---
 net/core/filter.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..c77caebcf4d0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1654,15 +1654,24 @@ int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk)
 	return err;
 }
 
+static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
+	struct bpf_prog *prog = aux->prog;
+
+	bpf_release_orig_filter(prog);
+	bpf_prog_free(prog);
+}
+
 void sk_reuseport_prog_free(struct bpf_prog *prog)
 {
 	if (!prog)
 		return;
 
-	if (prog->type == BPF_PROG_TYPE_SK_REUSEPORT)
-		bpf_prog_put(prog);
+	if (bpf_prog_was_classic(prog))
+		call_rcu(&prog->aux->rcu, sk_reuseport_prog_free_rcu);
 	else
-		bpf_prog_destroy(prog);
+		bpf_prog_put(prog);
 }
 
 static inline int __bpf_try_make_writable(struct sk_buff *skb,
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


