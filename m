Return-Path: <netdev+bounces-242550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B798C92074
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2996B4E033F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A02328B65;
	Fri, 28 Nov 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFkpub1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D81CFBA;
	Fri, 28 Nov 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334548; cv=none; b=feHTADcEj5ANY5nDmUCOVv+HW9hkVZGgX00O/qmZNrJ9K71/ZhOIIvDBrPn39Tk8ALKR7jcDEhARTiir4LnCDpx0xs5iGhiqZGkZpLCKX/JMspHMJEB1EyNsQHgZ650PqQ9HCM4YzvXUFz6aGZvHTuQGL7pBZ8pNvw/FhKrbHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334548; c=relaxed/simple;
	bh=6wZkwIximqeenLXShq2pcWLLFXz3o3ua5rrlN1psIpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSrw30vvT62t25fJbr+MeQXGGvZsbcXlKQ2AnMi/22ZhrsBrdtZ5ZvJV+wQcnFDqixCTSwZXF7FwAIefqHW0xd1zg/Hikjd+YmLUFKMzQYHDIWBB27in8B/G7rQiFuNg0Wex0VAWnys5La/hhR9a1DYCUeAVwB1FnXcz1/p50iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFkpub1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F35C116B1;
	Fri, 28 Nov 2025 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764334548;
	bh=6wZkwIximqeenLXShq2pcWLLFXz3o3ua5rrlN1psIpY=;
	h=From:To:Cc:Subject:Date:From;
	b=gFkpub1QAAdeqP3kbsSOq77Z4Gmd9ceo/mkOezdvQuvkTwJHvMCwhRXEYk5kbLAg2
	 gn8984LtJTfQJCbDj4WXtpULcNJMVfke7vfoqkyFs4ydIa8jXhAlS+QaiqchdG1L2D
	 GImwFv2hh0rIB6BOxNyvJMpxWMByHeWzw2i92Hg4EeyEdPfMmGxEhK5bN7XXFlQvYA
	 7qClsP96lFGJGMHWDv+9j+MyTW+SeTU/3Rd357EFq7Bekxg4DRz2lEuJ8BEA+mauNd
	 +3DEBHnC8EKpu9exOzr1WWGDCloUvkZ7Ui1stXWh7V7dcEX0/gIoI6BeOiwCACVt/b
	 B0eBzSL8mRPyA==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH net-next] tls: check return value of strp_load_anchor_with_queue
Date: Fri, 28 Nov 2025 20:55:17 +0800
Message-ID: <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In tls_strp_load_anchor_with_queue(), when first is null, strp->anchor is
not successfully initialized. Accessing strp->anchor afterward will result
in a memory access error (for example, BUG: KASAN: slab-use-after-free in
skb_copy_bits).

This patch adds a bool return value to tls_strp_load_anchor_with_queue()
to indicate whether initialization was successful. It also adds checks for
this return value in both tls_strp_msg_load() and tls_strp_read_sock().
If the initialization fails, the functions will return immediately,
preventing invalid memory access.

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
I encountered the following error while developing MPTCP TLS support [1][2]:

'''
[ 2054.086130][T15666] ==================================================================
[ 2054.086450][T15666] BUG: KASAN: slab-use-after-free in skb_copy_bits (net/core/skbuff.c:3039)
[ 2054.086763][T15666] Read of size 4 at addr ffff8881224c9550 by task test_progs-cpuv/15666
[ 2054.086871][T15666] 
[ 2054.086912][T15666] CPU: 18 UID: 0 PID: 15666 Comm: test_progs-cpuv Tainted: G           OE       6.18.0-rc6+ #36 PREEMPT(full) 
[ 2054.086915][T15666] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 2054.086916][T15666] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 2054.086917][T15666] Call Trace:
[ 2054.086919][T15666]  <TASK>
[ 2054.086920][T15666]  ? skb_copy_bits (net/core/skbuff.c:3039)
[ 2054.086922][T15666]  dump_stack_lvl (lib/dump_stack.c:122)
[ 2054.086927][T15666]  print_address_description.constprop.0 (mm/kasan/report.c:379)
[ 2054.086931][T15666]  ? skb_copy_bits (net/core/skbuff.c:3039)
[ 2054.086932][T15666]  print_report (mm/kasan/report.c:483)
[ 2054.086933][T15666]  ? __virt_addr_valid (include/linux/rcupdate.h:981 (discriminator 3) include/linux/mmzone.h:2197 (discriminator 3) arch/x86/mm/physaddr.c:65 (discriminator 3))
[ 2054.086937][T15666]  ? skb_copy_bits (net/core/skbuff.c:3039)
[ 2054.086939][T15666]  kasan_report (mm/kasan/report.c:221 mm/kasan/report.c:597)
[ 2054.086943][T15666]  ? skb_copy_bits (net/core/skbuff.c:3039)
[ 2054.086946][T15666]  skb_copy_bits (net/core/skbuff.c:3039)
[ 2054.086948][T15666]  ? __lock_release.isra.0 (kernel/locking/lockdep.c:5536)
[ 2054.086950][T15666]  ? trace_lock_acquire (include/trace/events/lock.h:24 (discriminator 33))
[ 2054.086953][T15666]  ? mark_held_locks (kernel/locking/lockdep.c:4325 (discriminator 1))
[ 2054.086955][T15666]  tls_rx_msg_size (net/tls/tls_sw.c:2464)
[ 2054.086960][T15666]  ? tls_strp_load_anchor_with_queue (net/tls/tls_strp.c:472 (discriminator 1))
[ 2054.086962][T15666]  ? __pfx_tls_rx_msg_size (net/tls/tls_sw.c:2444)
[ 2054.086965][T15666]  tls_strp_check_rcv (net/tls/tls_strp.c:538 net/tls/tls_strp.c:562)
[ 2054.086967][T15666]  ? __pfx_mptcp_read_done (net/mptcp/protocol.c:4486)
[ 2054.086971][T15666]  ? __pfx_tls_strp_check_rcv (net/tls/tls_strp.c:558)
[ 2054.086972][T15666]  ? __pfx_tls_rx_one_record (net/tls/tls_sw.c:1803)
[ 2054.086975][T15666]  ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2))
[ 2054.086977][T15666]  ? tls_strp_msg_done (net/tls/tls_strp.c:608)
[ 2054.086979][T15666]  tls_sw_recvmsg (net/tls/tls_sw.c:2160)
[ 2054.086982][T15666]  ? __lock_acquire (kernel/locking/lockdep.c:5237)
[ 2054.086985][T15666]  ? __pfx_tls_sw_recvmsg (net/tls/tls_sw.c:2038)
[ 2054.086988][T15666]  ? lock_acquire.part.0 (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870)
[ 2054.086989][T15666]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[ 2054.086992][T15666]  inet_recvmsg (net/ipv4/af_inet.c:891 (discriminator 7))
[ 2054.086994][T15666]  ? __fget_files (include/linux/rcupdate.h:341 (discriminator 1) include/linux/rcupdate.h:897 (discriminator 1) fs/file.c:1072 (discriminator 1))
[ 2054.086997][T15666]  ? __pfx_inet_recvmsg (net/ipv4/af_inet.c:883)
[ 2054.087000][T15666]  ? security_socket_recvmsg (security/security.c:4774 (discriminator 15))
[ 2054.087003][T15666]  sock_recvmsg (net/socket.c:1078 (discriminator 15) net/socket.c:1100 (discriminator 15))
[ 2054.087006][T15666]  __sys_recvfrom (net/socket.c:2296)
[ 2054.087008][T15666]  ? __pfx___sys_recvfrom (net/socket.c:2271)
[ 2054.087012][T15666]  ? trace_rseq_update (include/trace/events/rseq.h:11 (discriminator 33))
[ 2054.087016][T15666]  ? xfd_validate_state (arch/x86/kernel/fpu/xstate.c:1499 arch/x86/kernel/fpu/xstate.c:1543)
[ 2054.087019][T15666]  __x64_sys_recvfrom (net/socket.c:2309 (discriminator 1) net/socket.c:2305 (discriminator 1) net/socket.c:2305 (discriminator 1))
[ 2054.087021][T15666]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4473)
[ 2054.087024][T15666]  ? do_syscall_64 (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/entry-common.h:124 arch/x86/entry/syscall_64.c:90)
[ 2054.087027][T15666]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[ 2054.087029][T15666]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[ 2054.087031][T15666] RIP: 0033:0x7f309edf1772
'''
This patch can fix it.

[1]
https://github.com/multipath-tcp/mptcp_net-next/issues/480
[2]
https://patchwork.kernel.org/project/mptcp/cover/cover.1763800601.git.tanggeliang@kylinos.cn/
---
 net/tls/tls_strp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..48bd64f103ec 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -458,7 +458,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 	return true;
 }
 
-static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
+static bool tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 {
 	struct tcp_sock *tp = tcp_sk(strp->sk);
 	struct sk_buff *first;
@@ -466,7 +466,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 
 	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
 	if (WARN_ON_ONCE(!first))
-		return;
+		return false;
 
 	/* Bestow the state onto the anchor */
 	strp->anchor->len = offset + len;
@@ -479,6 +479,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	strp->anchor->destructor = NULL;
 
 	strp->stm.offset = offset;
+	return true;
 }
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
@@ -496,7 +497,8 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 			return false;
 		}
 
-		tls_strp_load_anchor_with_queue(strp, strp->stm.full_len);
+		if (!tls_strp_load_anchor_with_queue(strp, strp->stm.full_len))
+			return false;
 	}
 
 	rxm = strp_msg(strp->anchor);
@@ -523,7 +525,8 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 	if (inq < strp->stm.full_len)
 		return tls_strp_read_copy(strp, true);
 
-	tls_strp_load_anchor_with_queue(strp, inq);
+	if (!tls_strp_load_anchor_with_queue(strp, inq))
+		return 0;
 	if (!strp->stm.full_len) {
 		sz = tls_rx_msg_size(strp, strp->anchor);
 		if (sz < 0)
-- 
2.51.0


