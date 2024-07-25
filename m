Return-Path: <netdev+bounces-112907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A893BBEC
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B45B22661
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839B18E2A;
	Thu, 25 Jul 2024 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghzVUJ59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDE4C9F;
	Thu, 25 Jul 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883614; cv=none; b=stRuDqJ8exBsJDfHMIB+X+Q2zrCn0Spl9b0kASShbmR4Ed1lKhaZVudNsyYyHtybqzl+6574EPlTVWdvxvXp7WNF5fzSqhpNM5RFFphmhV9JKWhV9VxAVtXBJ3bvfcDtzil7/ywjlt1+2qTpunomSyGAYGHJOSnZrhQJMc1sMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883614; c=relaxed/simple;
	bh=a6nXzcOH/sqL5vgm70Jqbu3ApyPGZZS4T1IWUSXxbuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OjduzLLc0djc7C0EoTsWl5GLso8imBrPwjf9S0FsIzubT4XZt5MbhzBIsb04EuwPUXWKK45t2esttYqXZ1ZvxCQmWplGM9hdEJCbboV3v2lla5vfAmbN5MlP+zf/C4GOF/ifpo/R0twKsPw300yEtnq61dY/sF83XSBmCYE+y94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghzVUJ59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B46C116B1;
	Thu, 25 Jul 2024 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721883613;
	bh=a6nXzcOH/sqL5vgm70Jqbu3ApyPGZZS4T1IWUSXxbuY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ghzVUJ59SdeUVq9zMhveEn2ZclyersY4QKGxmoukWZja+GA/FhnuKhLVejSo4GkqO
	 HMyNpGgDFJAePRfIT5jfE7yl/n4ZBrwBxV2naEPhs1UYaW68p1s2LHJnw8RbYVAIP7
	 EB42lt2aGu6d1R7KZ/l/trgJXKN9kndnWzCaMPcLOLWvXC+VLdbNeDsbLTMgNHs9sd
	 mH7K22TWoQu8boy2oEIpCGQe8i5b9EYn6OhYWGvy+01EjZ43l+XEtX2XAflHsEECZY
	 NlnswD6PxZqyyFbozYmUsn1V4I/476aU91/Akkyy4abhfV2xkdxn6JSfTmQ3YRaDfC
	 7gVTD2rw8hZ5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6BC3DA49;
	Thu, 25 Jul 2024 05:00:13 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 25 Jul 2024 06:00:02 +0100
Subject: [PATCH net] net/tcp: Disable TCP-AO static key after RCU grace
 period
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com>
X-B4-Tracking: v=1; b=H4sIANHboWYC/y2MQQrCQAwAv1JyNtCuXSp+RTxkt9Hm4LYkqQilf
 3crHmdgZgNjFTa4Nhsov8VkLhW6UwN5ovJklLEyhDb07RAiel6QZjQnl4xJqeQJNa94iTzykM7
 UUYSaL8oP+fzWNyjscK8ykfE/Oq4vMmeFff8CTXt6QIgAAAA=
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721883612; l=3165;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=2VxC9EwCda1UYyzjKL3hCQeLFDKGZqGsvoyebrKwuJg=;
 b=bRV/3thrTrwofrcdBVEl5EV6EzzBMzOKZsDjmC2skvB/XdH8yqyWETm4f8tlFYrEu2IZS6cri
 L1GgotweV6wAzubtbYLK4XbrVDgzHQ8GQRwgSy8nWnCIimTjZgb5cS7
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
---
 net/ipv4/tcp_ao.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 85531437890c..5ce914d3e3db 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -267,6 +267,14 @@ static void tcp_ao_key_free_rcu(struct rcu_head *head)
 	kfree_sensitive(key);
 }
 
+static void tcp_ao_info_free_rcu(struct rcu_head *head)
+{
+	struct tcp_ao_info *ao = container_of(head, struct tcp_ao_info, rcu);
+
+	kfree(ao);
+	static_branch_slow_dec_deferred(&tcp_ao_needed);
+}
+
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 {
 	struct tcp_ao_info *ao;
@@ -290,9 +298,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 			atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
 		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
 	}
-
-	kfree_rcu(ao, rcu);
-	static_branch_slow_dec_deferred(&tcp_ao_needed);
+	call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)

---
base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
change-id: 20240725-tcp-ao-static-branch-rcu-85ede7b3a1a5

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



