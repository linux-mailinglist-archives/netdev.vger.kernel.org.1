Return-Path: <netdev+bounces-259532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGqwNZNKl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2A1614C6
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF403044B9F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14334FF73;
	Thu, 19 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQueTOBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3C34FF79
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522682; cv=none; b=P1FahEparENlOxdQdw73sADxxV317QOFgREm/0J2BweAujBhS3vfiWzrUTN8MDpiMaQjzIU3a+MDSSNpiI0tRKu4zHhujJ2etKgxFJV2cNzbaZksVOMT7WrFPznt/9c3PezE3AqPXHiGbnufkFkF3J1AHx8NRdbD27u6fFL8e5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522682; c=relaxed/simple;
	bh=q9eoXsGL4Phd0QvNlo0V47mIYWafDsZKZ3igjeBI88U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWjpdGA2pmvmuG60iiYdX33/Pmw/slM0Z9tjRP2BqqV518QDiHtjB274bPi5cucg7CRD1cXucEcYV5qXksA7c0PsDJmnqBjrP1RW8s0pl/8zf+e9qSXjB2ez1uyTMAFRrbbe/viaxL39r8T1LpfG4hCpYu/JNS2feJotsQHUnTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQueTOBl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e1919fb7bso781391a12.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522681; x=1772127481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxpQulCkcPzWMVLaSJ90BHh3dwdUU2dr0shVxabI+us=;
        b=QQueTOBlcYQ1vIFFdW0Xhu9clN7jEHGM/sMiFfBgFffrUUc4CWQ5YQ2iHNs9izaA1B
         gK3vCqzxulMhr20mhR/PfZS1L5nnWb1BqLu70rLFgs3bFJmqz3qpvkczVga99O8u9uoV
         ajtFdYIt8UeGyo9997yESKiJGtlWMptI+qwzhYH77eI/YbTcHjFbup5eeun5xHGyqZNd
         44BbApLGakCHCHzSlqF0AfldcJdLT+BK2zrxxX/5GKdtmDynOdr2hePKTkWRutI+jc0R
         OyxZI/Xf9WIah/d3a04GDoK8JQP3o25W2FJIF6AxMGrA0skv+g67zr0aLr9wlnvx8Bx4
         fH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522681; x=1772127481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxpQulCkcPzWMVLaSJ90BHh3dwdUU2dr0shVxabI+us=;
        b=Dr/sOTVhfnUN6JKJj1KXncpfan5z/lMCoqGSP9JuowfIqcLYByQsPsklsY9VduDrPX
         N2q4kDRIstZ4F14JNwEiNaZJFdgmVAwI01hJWel7UiqtRgqPD69Wg1S3HoOUxWZIzTqO
         +QKKlwuFQUVdc8ydsD8LTrlJ8slTdLInUyxBRwQ2HHdSmgQ2lIcPw/zYPUhBCC9Iep4b
         PKSXj+ZEDX6UcXIFXvb76a0u9oGDjF5eD8z9lEs4CVBje+8OOmDq8sYcaMZenAjxKa2h
         rHOZ5IxqANnfLfViAVTk3I6oy8c8AK76dqtL7afV+7Q5MgCjmhIs5eQ//yJVhbLeZrMM
         /Gww==
X-Forwarded-Encrypted: i=1; AJvYcCVVmV8i18XxIZwSl1yA4fj+IUjigeSSu0v9r7Wbc0THa+swdAvH7PpHMqSZZmcpDuf2+1K70lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nk7Oeo1uxxFgkgMgg2udrPFNkauaDFUziffTz+bZdhF/Ly7D
	vYKIXXcN1g2oagolGOmKrVABnSvzYwDqvD6TWjl8CxfDuYV3/wLTU3RVE2W3ahA/0NHuAt2+GpW
	oVYZzdA==
X-Received: from pgbcq6.prod.google.com ([2002:a05:6a02:4086:b0:c65:e8e7:d481])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3301:b0:38e:54b8:60a1
 with SMTP id adf61e73a8af0-3946c7985a0mr19647106637.4.1771522680551; Thu, 19
 Feb 2026 09:38:00 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:24 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-2-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 1/6] sockmap: Annotate sk->sk_data_ready() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com
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
	TAGGED_FROM(0.00)[bounces-259532-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,113cea56c13a8a1e95ab];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 5CB2A1614C6
X-Rspamd-Action: no action

syzbot reported data race of sk->sk_data_ready(). [0]

UDP fast path does not hold bh_lock_sock(), instead
spin_lock_bh(&sk->sk_receive_queue.lock) is used.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_data_ready().

Another option is to hold sk->sk_receive_queue.lock in
sock_map_sk_acquire() if sk_is_udp() is true, but this is
overkill and also does not work for sk->sk_write_space().

[0]:
BUG: KCSAN: data-race in __udp_enqueue_schedule_skb / sk_psock_drop

write to 0xffff88811d063048 of 8 bytes by task 23114 on cpu 0:
 sk_psock_stop_verdict net/core/skmsg.c:1287 [inline]
 sk_psock_drop+0x12f/0x270 net/core/skmsg.c:873
 sk_psock_put include/linux/skmsg.h:473 [inline]
 sock_map_unref+0x2a5/0x300 net/core/sock_map.c:185
 __sock_map_delete net/core/sock_map.c:426 [inline]
 sock_map_delete_from_link net/core/sock_map.c:439 [inline]
 sock_map_unlink net/core/sock_map.c:1608 [inline]
 sock_map_remove_links+0x228/0x340 net/core/sock_map.c:1623
 sock_map_close+0xa1/0x340 net/core/sock_map.c:1684
 inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:468
 ____fput+0x1c/0x30 fs/file_table.c:496
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0x1f7/0x6f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x1d3/0x2a0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d063048 of 8 bytes by task 23117 on cpu 1:
 __udp_enqueue_schedule_skb+0x6c1/0x840 net/ipv4/udp.c:1789
 __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
 udp_queue_rcv_one_skb+0x709/0xc20 net/ipv4/udp.c:2475
 udp_queue_rcv_skb+0x20e/0x2b0 net/ipv4/udp.c:2493
 __udp4_lib_mcast_deliver+0x6e8/0x790 net/ipv4/udp.c:2585
 __udp4_lib_rcv+0x96f/0x1260 net/ipv4/udp.c:2724
 udp_rcv+0x4f/0x60 net/ipv4/udp.c:2911
 ip_protocol_deliver_rcu+0x3f9/0x780 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:474 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
 ip_sublist_rcv+0x42b/0x6d0 net/ipv4/ip_input.c:644
 ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
 __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6242
 __netif_receive_skb_list net/core/dev.c:6294 [inline]
 netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6385
 netif_receive_skb_list+0x31/0x1f0 net/core/dev.c:6437
 xdp_recv_frames net/bpf/test_run.c:269 [inline]
 xdp_test_run_batch net/bpf/test_run.c:350 [inline]
 bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1396
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x4c0/0x7b0 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6272
 x64_sys_call+0x28e1/0x3000 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffffffff847b24d0 -> 0xffffffff84673410

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 23117 Comm: syz.8.5085 Tainted: G        W           syzkaller #0 PREEMPT(voluntary)
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025

Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
Reported-by: syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e1.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 4 ++--
 net/ipv4/udp.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ddde93dd8bc6..75fa94217e1e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1296,7 +1296,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 		return;
 
 	psock->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_verdict_data_ready;
+	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
 	sk->sk_write_space = sk_psock_write_space;
 }
 
@@ -1308,6 +1308,6 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	if (!psock->saved_data_ready)
 		return;
 
-	sk->sk_data_ready = psock->saved_data_ready;
+	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
 	psock->saved_data_ready = NULL;
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2..422c96fea249 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1787,7 +1787,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		 * using prepare_to_wait_exclusive().
 		 */
 		while (nb) {
-			INDIRECT_CALL_1(sk->sk_data_ready,
+			INDIRECT_CALL_1(READ_ONCE(sk->sk_data_ready),
 					sock_def_readable, sk);
 			nb--;
 		}
-- 
2.53.0.345.g96ddfc5eaa-goog


