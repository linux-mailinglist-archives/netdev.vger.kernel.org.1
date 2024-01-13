Return-Path: <netdev+bounces-63389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D082C92D
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 03:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D4BB2335D
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612A6FC2;
	Sat, 13 Jan 2024 02:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF405CA62
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TBjhZ2KtLz1Q7xG;
	Sat, 13 Jan 2024 10:55:58 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id F25D314011A;
	Sat, 13 Jan 2024 10:57:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Jan
 2024 10:57:32 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dsahern@kernel.org>
CC: <hkchu@google.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net,v2] tcp: make sure init the accept_queue's spinlocks once
Date: Sat, 13 Jan 2024 11:07:39 +0800
Message-ID: <20240113030739.3446338-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)

When I run syz's reproduction C program locally, it causes the following
issue:
pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
RIP: 0010:__pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
Code: 73 56 3a ff 90 c3 cc cc cc cc 8b 05 bb 1f 48 01 85 c0 74 05 c3 cc cc cc cc 8b 17 48 89 fe 48 c7 c7
30 20 ce 8f e8 ad 56 42 ff <0f> 0b c3 cc cc cc cc 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffa8d200604cb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9d1ef60e0908
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d1ef60e0900
RBP: ffff9d181cd5c280 R08: 0000000000000000 R09: 00000000ffff7fff
R10: ffffa8d200604b68 R11: ffffffff907dcdc8 R12: 0000000000000000
R13: ffff9d181cd5c660 R14: ffff9d1813a3f330 R15: 0000000000001000
FS:  00007fa110184640(0000) GS:ffff9d1ef60c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000011f65e000 CR4: 00000000000006f0
Call Trace:
<IRQ>
  _raw_spin_unlock (kernel/locking/spinlock.c:186)
  inet_csk_reqsk_queue_add (net/ipv4/inet_connection_sock.c:1321)
  inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1358)
  tcp_check_req (net/ipv4/tcp_minisocks.c:868)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2260)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
  ip_local_deliver_finish (net/ipv4/ip_input.c:234)
  __netif_receive_skb_one_core (net/core/dev.c:5529)
  process_backlog (./include/linux/rcupdate.h:779)
  __napi_poll (net/core/dev.c:6533)
  net_rx_action (net/core/dev.c:6604)
  __do_softirq (./arch/x86/include/asm/jump_label.h:27)
  do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
</IRQ>
<TASK>
  __local_bh_enable_ip (kernel/softirq.c:381)
  __dev_queue_xmit (net/core/dev.c:4374)
  ip_finish_output2 (./include/net/neighbour.h:540 net/ipv4/ip_output.c:235)
  __ip_queue_xmit (net/ipv4/ip_output.c:535)
  __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
  tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6469)
  tcp_rcv_state_process (net/ipv4/tcp_input.c:6657)
  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
  __release_sock (./include/net/sock.h:1121 net/core/sock.c:2968)
  release_sock (net/core/sock.c:3536)
  inet_wait_for_connect (net/ipv4/af_inet.c:609)
  __inet_stream_connect (net/ipv4/af_inet.c:702)
  inet_stream_connect (net/ipv4/af_inet.c:748)
  __sys_connect (./include/linux/file.h:45 net/socket.c:2064)
  __x64_sys_connect (net/socket.c:2073 net/socket.c:2070 net/socket.c:2070)
  do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
  RIP: 0033:0x7fa10ff05a3d
  Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89
  c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
  RSP: 002b:00007fa110183de8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
  RAX: ffffffffffffffda RBX: 0000000020000054 RCX: 00007fa10ff05a3d
  RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
  RBP: 00007fa110183e20 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa110184640
  R13: 0000000000000000 R14: 00007fa10fe8b060 R15: 00007fff73e23b20
</TASK>

The issue triggering process is analyzed as follows:
Thread A                                       Thread B
tcp_v4_rcv	//receive ack TCP packet       inet_shutdown
  tcp_check_req                                  tcp_disconnect //disconnect sock
  ...                                              tcp_set_state(sk, TCP_CLOSE)
    inet_csk_complete_hashdance                ...
      inet_csk_reqsk_queue_add                 inet_listen  //start listen
        spin_lock(&queue->rskq_lock)             inet_csk_listen_start
        ...                                        reqsk_queue_alloc
        ...                                          spin_lock_init
        spin_unlock(&queue->rskq_lock)	//warning

When the socket receives the ACK packet during the three-way handshake,
it will hold spinlock. And then the user actively shutdowns the socket
and listens to the socket immediately, the spinlock will be initialized.
When the socket is going to release the spinlock, a warning is generated.
Also the same issue to fastopenq.lock.

Add 'init_done' to make sure init the accept_queue's spinlocks once.

Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
---
 include/net/request_sock.h | 1 +
 net/core/request_sock.c    | 7 +++++--
 net/ipv4/tcp.c             | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 144c39db9898..0054746fe92d 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -175,6 +175,7 @@ struct fastopen_queue {
 struct request_sock_queue {
 	spinlock_t		rskq_lock;
 	u8			rskq_defer_accept;
+	bool			init_done;
 
 	u32			synflood_warned;
 	atomic_t		qlen;
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index f35c2e998406..51fe631a4af2 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -33,9 +33,12 @@
 
 void reqsk_queue_alloc(struct request_sock_queue *queue)
 {
-	spin_lock_init(&queue->rskq_lock);
+	if (!queue->init_done) {
+		spin_lock_init(&queue->rskq_lock);
+		spin_lock_init(&queue->fastopenq.lock);
+		queue->init_done = true;
+	}
 
-	spin_lock_init(&queue->fastopenq.lock);
 	queue->fastopenq.rskq_rst_head = NULL;
 	queue->fastopenq.rskq_rst_tail = NULL;
 	queue->fastopenq.qlen = 0;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1baa484d2190..8bc30c0df75f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -454,6 +454,7 @@ void tcp_init_sock(struct sock *sk)
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
 	icsk->icsk_sync_mss = tcp_sync_mss;
+	icsk->icsk_accept_queue.init_done = false;
 
 	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[1]));
 	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[1]));
-- 
2.34.1


