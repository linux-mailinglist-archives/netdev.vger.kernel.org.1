Return-Path: <netdev+bounces-177316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C436A6EE7F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E06A16D233
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF6253F1C;
	Tue, 25 Mar 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tbpw3wRG"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BCEC4
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900646; cv=none; b=Xn42K0SAE6sX/pQzQulzPAm4GX+kc52hWERKBvEdfSodOXA52eRa3sOao3s4XKfzq8EvpcuQ+4IS8FI2SjznmJBcO5u6j4nBcQ7jeSKIPbmID7IJm/yR1jJzUSrvMe4dCcqh2MOPkciat0DG7bbsJW6L0iTQ/RBE/k0fDE86qDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900646; c=relaxed/simple;
	bh=i8JJixI2MZcLhyu3tr5X4dDTYi5eb3d8IJLDCpuIrwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TljcGDBdf2m7VGhKbLo9XclU14DoomHf6A02msOaKlc2aH6D1YNFPHZ/e4Iw+hQykgfErK48huxrjFIBN+8bsYwciJa7Zu2yogbuUf8H7S5e3omF4dHu44fxoIRbo2la//BbsJuqyI191UiWpj0nJLaNPtu11Z8z6y0erTa+avA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tbpw3wRG; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742900631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D6GqUYecqSsNPqXRKXt5Y1rVAIxR6U/XHY2PsJhlFN8=;
	b=Tbpw3wRGAPpLNI5mCZ2BE5gn+PC/lhb791HMWOf7rOVROA8l7jc7dg20nVRUGh5yedT4yy
	HnON3EHOyPz1wawV4UlYTLk9kA/Pn1Fcy3dz0JTxGTd1SVWS9PynlPM6NqqQGqvGeDSrsD
	wBquJsA5NQAzGYczkU8/vE5u/3+D/Ao=
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
Subject: [PATCH net-next v2] tcp: Support skb PAWS drop reason when TIME-WAIT
Date: Tue, 25 Mar 2025 19:03:25 +0800
Message-ID: <20250325110325.51958-1-jiayuan.chen@linux.dev>
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
 include/net/tcp.h        | 3 ++-
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 7 +++++--
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

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
index 1cd0938d47e0..a9dde473a23f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2417,7 +2417,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn, &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index fb9349be36b8..d16dfd41397e 100644
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
+		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_PAWS;
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
+	}
 
 	if (!th->rst) {
 		/* In this case we must reset the TIMEWAIT timer.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c134cf1a603a..8862e315edc5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1970,7 +1970,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn, &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
-- 
2.47.1


