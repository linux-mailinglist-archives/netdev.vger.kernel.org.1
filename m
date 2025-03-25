Return-Path: <netdev+bounces-177460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF1CA7042C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425DE16A4DE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981025A322;
	Tue, 25 Mar 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JPF+1mNW"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955B25B66D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914057; cv=none; b=EqU9HhXZcBJSyocfq3FJo8jUnUT2Jn4tnv4liKRJ/ORCoPOdL11UUl66wFbncROoWZHTaGmTxkO/RPdSg/uS0petv1mFA10nUA8baDWgoeDRcJLQNCPIxjlEyDnX7Rlrf4dCcSxp9ZYSdFVHAwsJaU7NbZPrgq4/moV/y5ueySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914057; c=relaxed/simple;
	bh=q2qQFTSe1OkKnGQNlpYQcfnrah8hpzXx6xnjth4cRDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hm8JwYEWWEV9JDxeu23VmlDfV3/SWLZMd3hgM+X7p1SfI5t8nt+BHt2J7IZH0wfRQa+YCL57UwnYtmsgV2jLzVJos389OGASjavgb3+h/tC1CJT+ISdO60XSmlkNX1OJ3gV+0nkGy6z+zfu8Qj4/rcUxKHDAMv/VzuY0PhzeX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JPF+1mNW; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742914053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8X1RuBZ4xu4ElYT522Edj/zRVuiFXsGcUeYWcjQGzGM=;
	b=JPF+1mNWCqPcEyhjDXB7X+aiB80HyW5KziMavpA/fKA8r01fyRGoU3rES9UgCzSmy61KRx
	DCYF6obLrpX6yGHC4m3qP8NL1xAjVMZfVA9+Xl7qk1+hATLKsq/GdCUy5kIx56PKzUM0HM
	l1Ovu94RTt9C++6IfYUx5+wzyJYidX4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	kuniyu@amazon.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH net-next v3 1/2] tcp: add TCP_RFC7323_TW_PAWS drop reason
Date: Tue, 25 Mar 2025 22:47:03 +0800
Message-ID: <20250325144704.14363-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250325144704.14363-1-jiayuan.chen@linux.dev>
References: <20250325144704.14363-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PAWS is a long-standing issue, especially when there are upstream network
devices, making it more prone to occur.

Currently, packet loss statistics for PAWS can only be viewed through MIB,
which is a global metric and cannot be precisely obtained through tracing
to get the specific 4-tuple of the dropped packet. In the past, we had to
use kprobe ret to retrieve relevant skb information from
tcp_timewait_state_process().

We add a drop_reason pointer, similar to what previous commit does:
commit e34100c2ecbb ("tcp: add a drop_reason pointer to tcp_check_req()")

This commit addresses the PAWSESTABREJECTED case and also sets the
corresponding drop reason.

We use 'pwru' to test.

Before this commit:
''''
./pwru 'port 9999'
2025/03/25 22:00:03 Listening for events..
TUPLE                                        FUNC
172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_REASON_NOT_SPECIFIED)
'''

After this commit:
'''
./pwru 'port 9999'
2025/03/25 22:21:46 Listening for events..
TUPLE                                        FUNC
172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_REASON_TCP_RFC7323_TW_PAWS)
'''

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/dropreason-core.h | 6 ++++++
 include/net/tcp.h             | 3 ++-
 net/ipv4/tcp_ipv4.c           | 3 ++-
 net/ipv4/tcp_minisocks.c      | 7 +++++--
 net/ipv6/tcp_ipv6.c           | 3 ++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e4fdc6b54cef..9701d7f936f6 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -40,6 +40,7 @@
 	FN(TCP_OFOMERGE)		\
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_RFC7323_PAWS_ACK)	\
+	FN(TCP_RFC7323_TW_PAWS)		\
 	FN(TCP_RFC7323_TSECR)		\
 	FN(TCP_LISTEN_OVERFLOW)		\
 	FN(TCP_OLD_SEQUENCE)		\
@@ -283,6 +284,11 @@ enum skb_drop_reason {
 	 * Corresponds to LINUX_MIB_PAWS_OLD_ACK.
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK,
+	/**
+	 * @SKB_DROP_REASON_TCP_RFC7323_TW_PAWS: PAWS check, socket is in
+	 * TIME_WAIT state.
+	 */
+	SKB_DROP_REASON_TCP_RFC7323_TW_PAWS,
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_TSECR: PAWS check, invalid TSEcr.
 	 * Corresponds to LINUX_MIB_TSECRREJECTED.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f8efe56bbccb..e1574e804530 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -427,7 +427,8 @@ enum tcp_tw_status {
 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      struct sk_buff *skb,
 					      const struct tcphdr *th,
-					      u32 *tw_isn);
+					      u32 *tw_isn,
+					      enum skb_drop_reason *drop_reason);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race, enum skb_drop_reason *drop_reason);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1cd0938d47e0..396141151530 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2417,7 +2417,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
+					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index fb9349be36b8..27511bf58c0f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -97,7 +97,8 @@ static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq,
  */
 enum tcp_tw_status
 tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
-			   const struct tcphdr *th, u32 *tw_isn)
+			   const struct tcphdr *th, u32 *tw_isn,
+			   enum skb_drop_reason *drop_reason)
 {
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
@@ -245,8 +246,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return TCP_TW_SYN;
 	}
 
-	if (paws_reject)
+	if (paws_reject) {
+		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
+	}
 
 	if (!th->rst) {
 		/* In this case we must reset the TIMEWAIT timer.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c134cf1a603a..e1afb17cf101 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1970,7 +1970,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
+					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
-- 
2.47.1


