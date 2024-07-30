Return-Path: <netdev+bounces-113865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3C940265
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B311FB22436
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3869B7E1;
	Tue, 30 Jul 2024 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4PQXFor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA74A11;
	Tue, 30 Jul 2024 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299610; cv=none; b=liVgiXJEgoNIZARHbrXmmjaDq8JCVTNYDaiAalDJNPjkACG6+Td1rWOlshkDL3WePVt1xiZY4ZEl0WPF3qCzV0d+3q25NaK/ZWz2uqqG9mzVZVykv5CeyiknOldU7dxD8jaFtt/VJdcXDfQX+H47/we3LmaWWz3yUDAc+hE5d8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299610; c=relaxed/simple;
	bh=aD7Uq7q7bWaYENFe1iH39MROg+GilYsXWOeCN19O8mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TsFFFYZU0EeLIutmCTjt9KbXHOwda1Qgo0l8PYhPH2aAfIRO0vCL2xbZJO4zJpqu/qJUK6qcUCO0qZkEhtJiSoRU3TH82Kchi2vSOeX97zgwfcHl6Diq7DunDMSJ7BdSzaaWpt3TiCMUD0K0peQS6ym+6joU8y2yotcUnavmeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4PQXFor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7EC2C32786;
	Tue, 30 Jul 2024 00:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722299609;
	bh=aD7Uq7q7bWaYENFe1iH39MROg+GilYsXWOeCN19O8mk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=c4PQXForUMo3i9nsecRw4N8SYM98v5cv29b19+siMnFGsSLGfLQvEA8rx2s6PplHm
	 2DZKOSDqFIddthE/gnSx00v8N5iMok0285Mh390hKBwFzE5qstpVoJWQRX4ZQM5GCt
	 25+LcnPgDDqmsxv++gr4vywveXuIWuJ8g1YX7ndU/1YUlnaX9U7iI2GcZtDSa1+3B0
	 J/wVI8rSi12hAcCPhpIQ6lO5Z00dt5WJ2S7DxtVq8tkkVaXYgksyU2g3v+ngRoZKQB
	 WSGAnbI470MQwF3DMG27eZmHjpgd4xyW6LBmujrw2vEa/Jn8aL+/ME6N4b3mnbub41
	 4DANkqq5qCLtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD83AC3DA4A;
	Tue, 30 Jul 2024 00:33:29 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Tue, 30 Jul 2024 01:33:17 +0100
Subject: [PATCH net v2] net/tcp: Disable TCP-AO static key after RCU grace
 period
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-tcp-ao-static-branch-rcu-v2-1-33dc2b7adac8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMw0qGYC/4WOwQ6CMBBEf4Xs2TVtlaCe/A/DYVsW2EQKaSvRE
 P7dQrx7nMm8mVkgchCOcCsWCDxLlNFnYQ4FuJ58xyhN1mCUOavKlJjchDRiTJTEoQ3kXY/BvfB
 ScsOVPZGmEjI+BW7lvVc/wHOCOpuWIv+grXWgmDhs6V5iGsNn/zHrnfk/OWvUqIxulLpaZtveu
 4HkeXTjAPW6rl8eHCpc3gAAAA==
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722299603; l=5565;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=T/xIiJiV3VMWg9y5cdhZNse5ZjCE54Taq6FnVqtPOCo=;
 b=5XiHFfyrrmNlSprb0oUjxV75ZsnoBO+IKc18+QLpUHvyf4Zt9vS5qGvk3IvVSIs4bIQWDG5St
 AcjRFRr5oFcCJgTOHWLW7DAJ98ZSEhTRrx25t+jVvO22xi+8XRQP6wD
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

The lifetime of TCP-AO static_key is the same as the last
tcp_ao_info. On the socket destruction tcp_ao_info ceases to be
with RCU grace period, while tcp-ao static branch is currently deferred
destructed. The static key definition is
: DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);

which means that if RCU grace period is delayed by more than a second
and tcp_ao_needed is in the process of disablement, other CPUs may
yet see tcp_ao_info which atent dead, but soon-to-be.
And that breaks the assumption of static_key_fast_inc_not_disabled().

See the comment near the definition:
> * The caller must make sure that the static key can't get disabled while
> * in this function. It doesn't patch jump labels, only adds a user to
> * an already enabled static key.

Originally it was introduced in commit eb8c507296f6 ("jump_label:
Prevent key->enabled int overflow"), which is needed for the atomic
contexts, one of which would be the creation of a full socket from a
request socket. In that atomic context, it's known by the presence
of the key (md5/ao) that the static branch is already enabled.
So, the ref counter for that static branch is just incremented
instead of holding the proper mutex.
static_key_fast_inc_not_disabled() is just a helper for such usage
case. But it must not be used if the static branch could get disabled
in parallel as it's not protected by jump_label_mutex and as a result,
races with jump_label_update() implementation details.

Happened on netdev test-bot[1], so not a theoretical issue:

[] jump_label: Fatal kernel bug, unexpected op at tcp_inbound_hash+0x1a7/0x870 [ffffffffa8c4e9b7] (eb 50 0f 1f 44 != 66 90 0f 1f 00)) size:2 type:1
[] ------------[ cut here ]------------
[] kernel BUG at arch/x86/kernel/jump_label.c:73!
[] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[] CPU: 3 PID: 243 Comm: kworker/3:3 Not tainted 6.10.0-virtme #1
[] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[] Workqueue: events jump_label_update_timeout
[] RIP: 0010:__jump_label_patch+0x2f6/0x350
...
[] Call Trace:
[]  <TASK>
[]  arch_jump_label_transform_queue+0x6c/0x110
[]  __jump_label_update+0xef/0x350
[]  __static_key_slow_dec_cpuslocked.part.0+0x3c/0x60
[]  jump_label_update_timeout+0x2c/0x40
[]  process_one_work+0xe3b/0x1670
[]  worker_thread+0x587/0xce0
[]  kthread+0x28a/0x350
[]  ret_from_fork+0x31/0x70
[]  ret_from_fork_asm+0x1a/0x30
[]  </TASK>
[] Modules linked in: veth
[] ---[ end trace 0000000000000000 ]---
[] RIP: 0010:__jump_label_patch+0x2f6/0x350

[1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/696681/5-connect-deny-ipv6/stderr

Cc: stable@kernel.org
Fixes: 67fa83f7c86a ("net/tcp: Add static_key for TCP-AO")
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Changes in v2:
- Use rcu_assign_pointer() in tcp_ao_destroy_sock()
- Combined both ao_info and keys destruction in one RCU callback,
  tcp_ao_info_free_rcu() (suggested-by Jakub)
- Hopefully improved a bit the commit message
- Link to v1: https://lore.kernel.org/r/20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com
---
 net/ipv4/tcp_ao.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 85531437890c..e2ea6b3570e2 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -267,32 +267,51 @@ static void tcp_ao_key_free_rcu(struct rcu_head *head)
 	kfree_sensitive(key);
 }
 
-void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
+static void tcp_ao_info_free_rcu(struct rcu_head *head)
 {
-	struct tcp_ao_info *ao;
+	struct tcp_ao_info *ao = container_of(head, struct tcp_ao_info, rcu);
 	struct tcp_ao_key *key;
 	struct hlist_node *n;
 
+	hlist_for_each_entry_safe(key, n, &ao->head, node) {
+		hlist_del_rcu(&key->node);
+		tcp_sigpool_release(key->tcp_sigpool_id);
+		kfree_sensitive(key);
+	}
+	kfree(ao);
+	static_branch_slow_dec_deferred(&tcp_ao_needed);
+}
+
+static void tcp_ao_sk_omem_free(struct sock *sk, struct tcp_ao_info *ao)
+{
+	size_t total_ao_sk_mem = 0;
+	struct tcp_ao_key *key;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(key, n, &ao->head, node)
+		total_ao_sk_mem += tcp_ao_sizeof_key(key);
+
+	atomic_sub(total_ao_sk_mem, &sk->sk_omem_alloc);
+}
+
+void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
+{
+	struct tcp_ao_info *ao;
+
 	if (twsk) {
 		ao = rcu_dereference_protected(tcp_twsk(sk)->ao_info, 1);
-		tcp_twsk(sk)->ao_info = NULL;
+		rcu_assign_pointer(tcp_twsk(sk)->ao_info, NULL);
 	} else {
 		ao = rcu_dereference_protected(tcp_sk(sk)->ao_info, 1);
-		tcp_sk(sk)->ao_info = NULL;
+		rcu_assign_pointer(tcp_sk(sk)->ao_info, NULL);
 	}
 
 	if (!ao || !refcount_dec_and_test(&ao->refcnt))
 		return;
 
-	hlist_for_each_entry_safe(key, n, &ao->head, node) {
-		hlist_del_rcu(&key->node);
-		if (!twsk)
-			atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
-		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
-	}
-
-	kfree_rcu(ao, rcu);
-	static_branch_slow_dec_deferred(&tcp_ao_needed);
+	if (!twsk)
+		tcp_ao_sk_omem_free(sk, ao);
+	call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)

---
base-commit: 2accfdb7eff65f390c4308b0e9cb7c3fe48ad63c
change-id: 20240725-tcp-ao-static-branch-rcu-85ede7b3a1a5

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



