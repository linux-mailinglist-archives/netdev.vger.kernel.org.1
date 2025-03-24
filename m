Return-Path: <netdev+bounces-177073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63085A6DAF0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133D1163DB5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C825EF8E;
	Mon, 24 Mar 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R3W4Emdm"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AD200CB
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822312; cv=none; b=JlPDvCsxwFT8BFSLOf2ZGd9r3SRpkapKMg9QwYD42dblwzEX1PdSpEK2j/BDl0xWcr1We0ZmBj/LpvDZk+k+EfXKwB9xFSnEF4DKJ8PYnVLO4F9Z9BksIz7DbdoFO0yCZ/bzjWXHGTDERAoaxLIScIt6PcwA0SWsqzsqiuDCxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822312; c=relaxed/simple;
	bh=faIuof2bnzW67oXVuBrYIpaMR6d/9J3/MBt7/pgmqUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqVnD68Kp8fVFjfWOcJYqQ6hDokFldJ1PA32+rTLzR5n3L/Y9U/bG14HsnZawQCVpC1RiD3mk3fAgHE5JGEp60oeNFK78dTN/s6s04RaTXPnd59XYHkXlguT336pyS730gWTVdLYnYz4cZtAwEB4avdT4cA5wfaXH0G35hGbwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R3W4Emdm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742822305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arVVZeeqZTaqIGfn9u6dowfrXYyiC4MWEKz0N9ovA/8=;
	b=R3W4Emdmc9Sid1dh2oAh9Ifw1p9FDGceIqGUczTsswwsFTYpBgK2yjpCjMWXGQTVM1aWSO
	5Oa2zAoGW1LdhqqmVuyDQYgcOutADGJTzLhsHMVgqkHE1PZEW4cr42HntikXmkU4iLX65+
	tjDyEuOhJDo6TYBHG1kbRvJtoWLJX+s=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	edumazet@google.com,
	kuniyu@amazon.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH net-next v1] tcp: Support skb PAWS drop reason when TIME-WAIT
Date: Mon, 24 Mar 2025 21:18:05 +0800
Message-ID: <20250324131805.23103-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the server actively closes a connection and enters the TIME_WAIT
state, if PAWS validation fails, the discarded skb previously lacked a
corresponding reason identifier. This commit assigns the existing
SKB_DROP_REASON_TCP_RFC7323_PAWS as the reason for such drops.

We use 'pwru' to capture drop reason.

Before this commit:
''''
./pwru 'port 9999'
2025/03/24 13:46:03 Listening for events..
TUPLE                                        FUNC
172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_REASON_NOT_SPECIFIED)
'''

After this commit:
'''
./pwru 'port 9999'
2025/03/24 16:06:59 Listening for events..
TUPLE                                        FUNC
172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_REASON_TCP_RFC7323_PAWS)
'''

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
My apologize.
I struggled for a long time to get packetdrill to fix the client port, but
ultimately failed to do so, which is why I couldn't provide a packetdrill
script.
Instead, I wrote my own program to trigger PAWS, which can be found at
https://github.com/mrpre/nettrigger/tree/main
---
 include/net/tcp.h        | 2 +-
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 6 ++++--
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2d08473a6dc0..16e6efef939a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -388,7 +388,7 @@ enum tcp_tw_status {
 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      struct sk_buff *skb,
 					      const struct tcphdr *th,
-					      u32 *tw_isn);
+					      u32 *tw_isn, enum skb_drop_reason *drop_reason);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2632844d2c35..ad168a3a73bb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2406,7 +2406,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
 	}
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn, &drop_reason)) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
 							net->ipv4.tcp_death_row.hashinfo,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b089b08e9617..39e5b55041f1 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -97,7 +97,7 @@ static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq,
  */
 enum tcp_tw_status
 tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
-			   const struct tcphdr *th, u32 *tw_isn)
+			   const struct tcphdr *th, u32 *tw_isn, enum skb_drop_reason *drop_reason)
 {
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
@@ -245,8 +245,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return TCP_TW_SYN;
 	}
 
-	if (paws_reject)
+	if (paws_reject) {
+		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_PAWS;
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
+	}
 
 	if (!th->rst) {
 		/* In this case we must reset the TIMEWAIT timer.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2debdf085a3b..66d30df95f7a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1965,7 +1965,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn, &drop_reason)) {
 	case TCP_TW_SYN:
 	{
 		struct sock *sk2;
-- 
2.47.1


