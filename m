Return-Path: <netdev+bounces-63189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549482B919
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D911F24F50
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FFA54;
	Fri, 12 Jan 2024 01:26:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACDA3F
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TB3lZ020zzbbrb;
	Fri, 12 Jan 2024 09:26:18 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 633CC1800BC;
	Fri, 12 Jan 2024 09:26:35 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 09:26:34 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] tcp: do not hold spinlock when sk state is not TCP_LISTEN
Date: Fri, 12 Jan 2024 09:36:44 +0800
Message-ID: <20240112013644.3079454-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

The rskq_lock lock protects only the request_sock_queue structure.
Therefore, the rskq_lock lock could be not used when the TCP state is
not listen in inet_csk_reqsk_queue_add.

Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv4/inet_connection_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8e2eb1793685..b100a89c3d98 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1295,11 +1295,11 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 {
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 
-	spin_lock(&queue->rskq_lock);
 	if (unlikely(sk->sk_state != TCP_LISTEN)) {
 		inet_child_forget(sk, req, child);
 		child = NULL;
 	} else {
+		spin_lock(&queue->rskq_lock);
 		req->sk = child;
 		req->dl_next = NULL;
 		if (queue->rskq_accept_head == NULL)
@@ -1308,8 +1308,8 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 			queue->rskq_accept_tail->dl_next = req;
 		queue->rskq_accept_tail = req;
 		sk_acceptq_added(sk);
+		spin_unlock(&queue->rskq_lock);
 	}
-	spin_unlock(&queue->rskq_lock);
 	return child;
 }
 EXPORT_SYMBOL(inet_csk_reqsk_queue_add);
-- 
2.34.1


