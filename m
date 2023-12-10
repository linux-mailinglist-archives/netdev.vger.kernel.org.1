Return-Path: <netdev+bounces-55587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A180D80B85B
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 03:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22245B208B7
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372A10E5;
	Sun, 10 Dec 2023 02:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B510C
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 18:02:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Snp601qLRzWh9c;
	Sun, 10 Dec 2023 10:02:00 +0800 (CST)
Received: from kwepemi500026.china.huawei.com (unknown [7.221.188.247])
	by mail.maildlp.com (Postfix) with ESMTPS id 4386018006C;
	Sun, 10 Dec 2023 10:02:04 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 10:02:03 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <ncardwell@google.com>, <yuehaibing@huawei.com>, <weiyongjun1@huawei.com>,
	<netdev@vger.kernel.org>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net] net: Remove acked SYN flag from packet in the transmit queue correctly
Date: Sun, 10 Dec 2023 10:02:00 +0800
Message-ID: <20231210020200.1539875-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500026.china.huawei.com (7.221.188.247)

syzkaller report:

 kernel BUG at net/core/skbuff.c:3452!
 invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc4-00009-gbee0e7762ad2-dirty #135
 RIP: 0010:skb_copy_and_csum_bits (net/core/skbuff.c:3452)
 Call Trace:
 icmp_glue_bits (net/ipv4/icmp.c:357)
 __ip_append_data.isra.0 (net/ipv4/ip_output.c:1165)
 ip_append_data (net/ipv4/ip_output.c:1362 net/ipv4/ip_output.c:1341)
 icmp_push_reply (net/ipv4/icmp.c:370)
 __icmp_send (./include/net/route.h:252 net/ipv4/icmp.c:772)
 ip_fragment.constprop.0 (./include/linux/skbuff.h:1234 net/ipv4/ip_output.c:592 net/ipv4/ip_output.c:577)
 __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:295)
 ip_output (net/ipv4/ip_output.c:427)
 __ip_queue_xmit (net/ipv4/ip_output.c:535)
 __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
 __tcp_retransmit_skb (net/ipv4/tcp_output.c:3387)
 tcp_retransmit_skb (net/ipv4/tcp_output.c:3404)
 tcp_retransmit_timer (net/ipv4/tcp_timer.c:604)
 tcp_write_timer (./include/linux/spinlock.h:391 net/ipv4/tcp_timer.c:716)

The panic issue was trigered by tcp simultaneous initiation.
The initiation process is as follows:

      TCP A                                            TCP B

  1.  CLOSED                                           CLOSED

  2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...

  3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT

  4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED

  5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...

  // TCP B: not send challenge ack for ack limit or packet loss
  // TCP A: close
	tcp_close
	   tcp_send_fin
              if (!tskb && tcp_under_memory_pressure(sk))
                  tskb = skb_rb_last(&sk->tcp_rtx_queue); //pick SYN_ACK packet
           TCP_SKB_CB(tskb)->tcp_flags |= TCPHDR_FIN;  // set FIN flag

  6.  FIN_WAIT_1  --> <SEQ=100><ACK=301><END_SEQ=102><CTL=SYN,FIN,ACK> ...

  // TCP B: send challenge ack to SYN_FIN_ACK

  7.               ... <SEQ=301><ACK=101><CTL=ACK>   <-- SYN-RECEIVED //challenge ack

  // TCP A:  <SND.UNA=101>

  8.  FIN_WAIT_1 --> <SEQ=101><ACK=301><END_SEQ=102><CTL=SYN,FIN,ACK> ... // retransmit panic

	__tcp_retransmit_skb  //skb->len=0
	    tcp_trim_head
		len = tp->snd_una - TCP_SKB_CB(skb)->seq // len=101-100
		    __pskb_trim_head
			skb->data_len -= len // skb->len=-1, wrap around
	    ... ...
	    ip_fragment
		icmp_glue_bits //BUG_ON

If we use tcp_trim_head() to remove acked SYN from packet that contains data
or other flags, skb->len will be incorrectly decremented. We can remove SYN
flag that has been acked from rtx_queue earlier than tcp_trim_head(), which
can fix the problem mentioned above.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/ipv4/tcp_output.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index eb13a55d660c..aa8983e9ef9f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3293,7 +3293,13 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (skb_still_in_host_queue(sk, skb))
 		return -EBUSY;
 
+start:
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
+		if (unlikely(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
+			TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
+			TCP_SKB_CB(skb)->seq++;
+			goto start;
+		}
 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
-- 
2.25.1


