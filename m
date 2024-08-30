Return-Path: <netdev+bounces-123913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1820966CFE
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 01:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F1C28157C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BEB19005F;
	Fri, 30 Aug 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qikOZO8Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AB193
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061520; cv=none; b=eg4ifInSnWvJZD6Vdk9tTB/O0KQNyABhFjzzNf5iSo+a1blf+/AGEyKEIeHO339oWT8u13i9vmpLoPw30ENPvrvM2gTWaQNqt8LLr+ULAyugpRCB6JG6SWYjzsiXzBqf7lTolAmEBb4CUI4FCE7M3c86iwHZzqg6nQVUKUQLLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061520; c=relaxed/simple;
	bh=lXoco0PwtUyQ/652LptVkjdZG2jf8qcAqzfH9KSMzTc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBrl2/B7uCvS68yZZOchAXnX5vcUxKlJW2WoNqWn/5uNzVwHTDS/OCTxQzEmfHD7D7Yr/EplIR+7kBttwbn6NcoJdGBsdqDBkiEXguOjCPX61u2eA/8voBv8VoPAA7tcUM29L57ooDBjWoUg4LXZ57G6T2QwKkC+KVS18koIFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qikOZO8Q; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725061519; x=1756597519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LrN6HZksnW5il5rA32TDz7h3raGY9dMuaw0jXDIT9+g=;
  b=qikOZO8QCgHtNdz73XjWCpkOAbMd6h2oTy/YcdOVuGMWFrJPLk6m1Z/R
   gSF/4Z2dY2t9EbNuDv/8fWTB90+gdfyh6nRyDgX+U5FYTtrxXZ4qQQH+B
   cnBYG2+CLzP26bYbWTji/Ru/nkjJpqenswl78BTJ9krvrNmAZ+OyweOxo
   U=;
X-IronPort-AV: E=Sophos;i="6.10,190,1719878400"; 
   d="scan'208";a="424666551"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 23:44:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:34006]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.120:2525] with esmtp (Farcaster)
 id 8f3d39cb-15f1-4d81-819b-dfad12a1465d; Fri, 30 Aug 2024 23:44:06 +0000 (UTC)
X-Farcaster-Flow-ID: 8f3d39cb-15f1-4d81-819b-dfad12a1465d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 30 Aug 2024 23:44:05 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 30 Aug 2024 23:44:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Tom Herbert <tom@herbertland.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Alphonse
 Kurian" <alkurian@amazon.com>
Subject: [PATCH v1 net] fou: Fix null-ptr-deref in GRO.
Date: Fri, 30 Aug 2024 16:43:48 -0700
Message-ID: <20240830234348.16789-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We observed a null-ptr-deref in fou_gro_receive() while shutting down
a host.  [0]

The NULL pointer is sk->sk_user_data, and the offset 8 is of the protocol
in struct fou.

When fou_release() is called due to netns dismantle or explicit tunnel
teardown, udp_tunnel_sock_release() sets NULL to sk->sk_user_data.
Then, the tunnel socket is destroyed after a single RCU grace period.

So, in-flight udp4_gro_receive() could find the socket and execute the
FOU GRO handler, where sk->sk_user_data could be NULL.

Let's add NULL checks in FOU GRO handlers and use rcu_dereference() in
fou_from_sock().

[0]:
BUG: kernel NULL pointer dereference, address: 0000000000000008
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 80000001032f4067 P4D 80000001032f4067 PUD 103240067 PMD 0
SMP PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.216-204.855.amzn2.x86_64 #1
Hardware name: Amazon EC2 c5.large/, BIOS 1.0 10/16/2017
RIP: 0010:fou_gro_receive (net/ipv4/fou.c:233) [fou]
Code: 41 5f c3 cc cc cc cc e8 e7 2e 69 f4 0f 1f 80 00 00 00 00 0f 1f 44 00 00 49 89 f8 41 54 48 89 f7 48 89 d6 49 8b 80 88 02 00 00 <0f> b6 48 08 0f b7 42 4a 66 25 fd fd 80 cc 02 66 89 42 4a 0f b6 42
RSP: 0018:ffffa330c0003d08 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff93d9e3a6b900 RCX: 0000000000000010
RDX: ffff93d9e3a6b900 RSI: ffff93d9e3a6b900 RDI: ffff93dac2e24d08
RBP: ffff93d9e3a6b900 R08: ffff93dacbce6400 R09: 0000000000000002
R10: 0000000000000000 R11: ffffffffb5f369b0 R12: ffff93dacbce6400
R13: ffff93dac2e24d08 R14: 0000000000000000 R15: ffffffffb4edd1c0
FS:  0000000000000000(0000) GS:ffff93daee800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000102140001 CR4: 00000000007706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? show_trace_log_lvl (arch/x86/kernel/dumpstack.c:259)
 ? __die_body.cold (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420)
 ? no_context (arch/x86/mm/fault.c:752)
 ? exc_page_fault (arch/x86/include/asm/irqflags.h:49 arch/x86/include/asm/irqflags.h:89 arch/x86/mm/fault.c:1435 arch/x86/mm/fault.c:1483)
 ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:571)
 ? fou_gro_receive (net/ipv4/fou.c:233) [fou]
 udp_gro_receive (include/linux/netdevice.h:2552 net/ipv4/udp_offload.c:559)
 udp4_gro_receive (net/ipv4/udp_offload.c:604)
 inet_gro_receive (net/ipv4/af_inet.c:1549 (discriminator 7))
 dev_gro_receive (net/core/dev.c:6035 (discriminator 4))
 napi_gro_receive (net/core/dev.c:6170)
 ena_clean_rx_irq (drivers/amazon/net/ena/ena_netdev.c:1558) [ena]
 ena_io_poll (drivers/amazon/net/ena/ena_netdev.c:1742) [ena]
 napi_poll (net/core/dev.c:6847)
 net_rx_action (net/core/dev.c:6917)
 __do_softirq (arch/x86/include/asm/jump_label.h:25 include/linux/jump_label.h:200 include/trace/events/irq.h:142 kernel/softirq.c:299)
 asm_call_irq_on_stack (arch/x86/entry/entry_64.S:809)
</IRQ>
 do_softirq_own_stack (arch/x86/include/asm/irq_stack.h:27 arch/x86/include/asm/irq_stack.h:77 arch/x86/kernel/irq_64.c:77)
 irq_exit_rcu (kernel/softirq.c:393 kernel/softirq.c:423 kernel/softirq.c:435)
 common_interrupt (arch/x86/kernel/irq.c:239)
 asm_common_interrupt (arch/x86/include/asm/idtentry.h:626)
RIP: 0010:acpi_idle_do_entry (arch/x86/include/asm/irqflags.h:49 arch/x86/include/asm/irqflags.h:89 drivers/acpi/processor_idle.c:114 drivers/acpi/processor_idle.c:575)
Code: 8b 15 d1 3c c4 02 ed c3 cc cc cc cc 65 48 8b 04 25 40 ef 01 00 48 8b 00 a8 08 75 eb 0f 1f 44 00 00 0f 00 2d d5 09 55 00 fb f4 <fa> c3 cc cc cc cc e9 be fc ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffffffb5603e58 EFLAGS: 00000246
RAX: 0000000000004000 RBX: ffff93dac0929c00 RCX: ffff93daee833900
RDX: ffff93daee800000 RSI: ffff93daee87dc00 RDI: ffff93daee87dc64
RBP: 0000000000000001 R08: ffffffffb5e7b6c0 R09: 0000000000000044
R10: ffff93daee831b04 R11: 00000000000001cd R12: 0000000000000001
R13: ffffffffb5e7b740 R14: 0000000000000001 R15: 0000000000000000
 ? sched_clock_cpu (kernel/sched/clock.c:371)
 acpi_idle_enter (drivers/acpi/processor_idle.c:712 (discriminator 3))
 cpuidle_enter_state (drivers/cpuidle/cpuidle.c:237)
 cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
 cpuidle_idle_call (kernel/sched/idle.c:158 kernel/sched/idle.c:239)
 do_idle (kernel/sched/idle.c:302)
 cpu_startup_entry (kernel/sched/idle.c:395 (discriminator 1))
 start_kernel (init/main.c:1048)
 secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:310)
Modules linked in: udp_diag tcp_diag inet_diag nft_nat ipip tunnel4 dummy fou ip_tunnel nft_masq nft_chain_nat nf_nat wireguard nft_ct curve25519_x86_64 libcurve25519_generic nf_conntrack libchacha20poly1305 nf_defrag_ipv6 nf_defrag_ipv4 nft_objref chacha_x86_64 nft_counter nf_tables nfnetlink poly1305_x86_64 ip6_udp_tunnel udp_tunnel libchacha crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper mousedev psmouse button ena ptp pps_core crc32c_intel
CR2: 0000000000000008

Fixes: d92283e338f6 ("fou: change to use UDP socket GRO")
Reported-by: Alphonse Kurian <alkurian@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fou_core.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0abbc413e0fe..1690c50f8f97 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -50,7 +50,7 @@ struct fou_net {
 
 static inline struct fou *fou_from_sock(struct sock *sk)
 {
-	return sk->sk_user_data;
+	return rcu_dereference(sk->sk_user_data);
 }
 
 static int fou_recv_pull(struct sk_buff *skb, struct fou *fou, size_t len)
@@ -233,9 +233,15 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 				       struct sk_buff *skb)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
+	u8 proto;
+
+	if (!fou)
+		goto out;
+
+	proto = fou->protocol;
 
 	/* We can clear the encap_mark for FOU as we are essentially doing
 	 * one of two possible things.  We are either adding an L4 tunnel
@@ -263,14 +269,24 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	int err = -ENOSYS;
+	u8 proto;
+	int err;
+
+	if (!fou) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	proto = fou->protocol;
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
+	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
+		err = -ENOSYS;
 		goto out;
+	}
 
 	err = ops->callbacks.gro_complete(skb, nhoff);
 
@@ -320,6 +336,9 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	struct gro_remcsum grc;
 	u8 proto;
 
+	if (!fou)
+		goto out;
+
 	skb_gro_remcsum_init(&grc);
 
 	off = skb_gro_offset(skb);
-- 
2.30.2


