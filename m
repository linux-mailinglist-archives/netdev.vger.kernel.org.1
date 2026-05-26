Return-Path: <netdev+bounces-291489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO+BDAT5FGo6SAcAu9opvQ
	(envelope-from <netdev+bounces-291489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217B5CF744
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92344301724E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A7274B37;
	Tue, 26 May 2026 01:36:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A37083C;
	Tue, 26 May 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779759361; cv=none; b=Klgq946YlD9iEQ7plrHZWSf2650Dgbcxs4vXXNHdHPi1pNh/5cdteMA3qkBQ0HisClEL2Hl9NhJC11/zOS6I6Q9qcJt12KWrMuJJoZK/dPkSXwND3aM+CwgxHwGRyN2fCsh684VAreBTR753pFyOHWfWMpYBnOuozyp3SJ1pTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779759361; c=relaxed/simple;
	bh=tmGmHPRMOZDPMLhxxEPM06fVqwAHMbnBlQP6LZ214P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqwsmcjdnU36Q8xNpu6FMngpLdIAiLp1u+jniVCMUGIRz+cpaYhq9VrajChD5J9fyMDqI+8Jcd9MyWJ+dsACZmOKQJHgYmic75/GwG2Fs6ElhZjH3YKeJ4wWtGVmoRGNbcMqPHKlcxkeXxJwX2Xt8SFpZAOj4IYTVUrIKGAeZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnCt7v+BRqgKNzEQ--.3143S2;
	Tue, 26 May 2026 09:35:43 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] llc: Fix NULL pointer dereference in llc_conn_state_process() when sk_socket is NULL
Date: Tue, 26 May 2026 01:35:41 +0000
Message-Id: <20260526013541.796307-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnCt7v+BRqgKNzEQ--.3143S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryDGrWxCrW3Ar4kGr1xXwb_yoW7CFWfpF
	45AF17GF4vqrnxXFWxtrs5Cr1DJr15Aa43Kr47JrnxAF1kKw1rJ398trW2kFZ8tryvkw47
	Jr1DXay0ga1kJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr
	0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUS1v3UUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ucas.ac.cn:email,mails.ucas.ac.cn:mid]
X-Rspamd-Queue-Id: 8217B5CF744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk->sk_socket can be NULL when a socket has been orphaned by sock_orphan()
and a pending LLC timer fires afterwards. The timer callback chain is:

  llc_conn_ack_tmr_cb() -> llc_conn_tmr_common_cb() ->
  llc_process_tmr_ev() -> llc_conn_state_process()

llc_conn_state_process() unconditionally dereferences sk->sk_socket
at four locations when handling DISC_PRIM and CONN_PRIM confirm
primitives to update the socket state (SS_UNCONNECTED / SS_CONNECTED).

Add sk->sk_socket NULL checks at all four sites so that when the
socket is gone, the state update is simply skipped rather than
triggering a kernel page fault.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 net/llc/llc_conn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248f..de65c452f6e68 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -101,7 +101,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 	case LLC_DISC_PRIM:
 		sock_hold(sk);
 		if (sk->sk_type == SOCK_STREAM &&
-		    sk->sk_state == TCP_ESTABLISHED) {
+		    sk->sk_state == TCP_ESTABLISHED &&
+		    sk->sk_socket) {
 			sk->sk_shutdown       = SHUTDOWN_MASK;
 			sk->sk_socket->state  = SS_UNCONNECTED;
 			sk->sk_state          = TCP_CLOSE;
@@ -136,7 +137,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		break;
 	case LLC_CONN_PRIM:
 		if (sk->sk_type == SOCK_STREAM &&
-		    sk->sk_state == TCP_SYN_SENT) {
+		    sk->sk_state == TCP_SYN_SENT &&
+		    sk->sk_socket) {
 			if (ev->status) {
 				sk->sk_socket->state = SS_UNCONNECTED;
 				sk->sk_state         = TCP_CLOSE;
@@ -149,7 +151,7 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		break;
 	case LLC_DISC_PRIM:
 		sock_hold(sk);
-		if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSING) {
+		if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSING && sk->sk_socket) {
 			sk->sk_socket->state = SS_UNCONNECTED;
 			sk->sk_state         = TCP_CLOSE;
 			sk->sk_state_change(sk);
-- 
2.34.1

Found by fuzzing. Here is the report:

Unable to handle kernel paging request at virtual address dfffffff00000000
Current syz-executor pgtable: 4K pagesize, 57-bit VAs, pgdp=0x000000012bf0c000
[dfffffff00000000] pgd=000000005fffe401, p4d=000000005fffe001, pud=0000000000000000
Oops [#1]
Modules linked in:
CPU: 2 UID: 0 PID: 3127 Comm: syz-executor Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : llc_conn_state_process+0xcea/0x1408 net/llc/llc_conn.c:141
 ra : llc_conn_state_process+0xcdc/0x1408 net/llc/llc_conn.c:141
epc : ffffffff856171e0 ra : ffffffff856171d2 sp : ff20000000027900
 gp : ffffffff8a395420 tp : ff6000008a3e3580 t0 : ff6000008fd27a60
 t1 : ffebffff128ef628 t2 : ff600000ffa73728 s0 : ff200000000279b0
 s1 : 0000000000000000 a0 : 0000000000000001 a1 : 0000000000000000
 a2 : 0000000000f00000 a3 : ffffffff856171d2 a4 : 0000000000000000
 a5 : dfffffff00000000 a6 : 0000000000f00000 a7 : ff6000009477b143
 s2 : ff6000008c2abe00 s3 : 0000000000000002 s4 : ffffffff87a68fc0
 s5 : 0000000000000000 s6 : ff6000009477b000 s7 : 0000000000000000
 s8 : ff6000009477b000 s9 : dfffffff00000000 s10: 0000000000000000
 s11: ff6000008c2abe2d t3 : 38177e0100000000 t4 : ffebffff128ef628
 t5 : ffebffff128ef629 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: dfffffff00000000 cause: 000000000000000d
[<ffffffff856171e0>] llc_conn_state_process+0xcea/0x1408 net/llc/llc_conn.c:141
[<ffffffff8560bd82>] llc_process_tmr_ev net/llc/llc_c_ac.c:1448 [inline]
[<ffffffff8560bd82>] llc_conn_tmr_common_cb+0x278/0x81c net/llc/llc_c_ac.c:1331
[<ffffffff856141c6>] llc_conn_ack_tmr_cb+0x1e/0x28 net/llc/llc_c_ac.c:1356
[<ffffffff8041b658>] call_timer_fn+0x208/0xcc4 kernel/time/timer.c:1748
[<ffffffff8041ca3c>] expire_timers kernel/time/timer.c:1799 [inline]
[<ffffffff8041ca3c>] __run_timers+0x928/0xe38 kernel/time/timer.c:2374
[<ffffffff8041d082>] __run_timer_base kernel/time/timer.c:2386 [inline]
[<ffffffff8041d082>] __run_timer_base kernel/time/timer.c:2378 [inline]
[<ffffffff8041d082>] run_timer_base+0x136/0x1b6 kernel/time/timer.c:2395
[<ffffffff8041d11e>] run_timer_softirq+0x1c/0x52 kernel/time/timer.c:2405
[<ffffffff80172cb2>] handle_softirqs+0x4ca/0x1564 kernel/softirq.c:622
[<ffffffff801742de>] __do_softirq kernel/softirq.c:656 [inline]
[<ffffffff801742de>] invoke_softirq kernel/softirq.c:496 [inline]
[<ffffffff801742de>] __irq_exit_rcu+0x44e/0x8cc kernel/softirq.c:735
[<ffffffff801763fc>] irq_exit_rcu+0x10/0xf8 kernel/softirq.c:752
[<ffffffff866f79a8>] handle_riscv_irq+0x40/0x4c arch/riscv/kernel/traps.c:432
[<ffffffff8672696e>] call_on_irq_stack+0x32/0x40 arch/riscv/kernel/entry.S:396
Code: faf2 80e7 c240 07b7 e000 17fd d713 0034 1782 97ba (8783) 0007 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	faf2                	fsw	ft8,116(sp)
   2:	c24080e7          	jalr	-988(ra)
   6:	e00007b7          	lui	a5,0xe0000
   a:	17fd                	addi	a5,a5,-1 # 0xffffffffdfffffff
   c:	0034d713          	srli	a4,s1,0x3
  10:	1782                	slli	a5,a5,0x20
  12:	97ba                	add	a5,a5,a4
* 14:	00078783          	lb	a5,0(a5) <-- trapping instruction

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


