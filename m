Return-Path: <netdev+bounces-99586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5088D564F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4258828446E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF6417C7B0;
	Thu, 30 May 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeMWqy/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD555896;
	Thu, 30 May 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112185; cv=none; b=GMZcU6ZZKXzDE40BWw4RsuiV8bc7M6uG/afJO4ECEhzNhDeWSA7W4ple8FlGI8WsZ17dsoFtBDMiMT8wH/I/Y6FhVPRSyawWi7s6VZDJgcRT4kV4bycKVr3YmBWkrHVYu/xcqvwrO8bIKXwpshxcbe7XVBWYT/JjnP7w3szQrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112185; c=relaxed/simple;
	bh=7vmH6yCpl8nIABl2n0tr/dfno3/kdI3WWJlSpv9XZTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRlf5JgKrqChg8Qb31/aTi4M4c2rMJ9fHp1yiXoSFZU+SbtG+7wFKkTScc2eEXU8m4tDKd8+eFJAv+szOrfrkNALbWmB1kScFnKWyqjjv+M69Oyn82pMij1Spa9bCkuKzcUXrGY6QpbSR8irYJd05fWBCCCAF2JLiy5kV+unTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeMWqy/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E74EC4AF09;
	Thu, 30 May 2024 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717112185;
	bh=7vmH6yCpl8nIABl2n0tr/dfno3/kdI3WWJlSpv9XZTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeMWqy/1Yl0oVNzzDbjsoqUbobQiYv7VvAojosHA3h4RZJfaoJRxvtNVEf2AEjU4e
	 o1j9rOYl4hGE/0B2nAJQKNs+x6RpODXoB1h7zt4wxeC2Z4GbEiV7RkjxyhYJVCrXK7
	 Fv4aiaEQLc/C61Gs5x72Fq3y+RlLdfgmlquVYC2c2A/Rw7YPpKWEQw0ri7Uq8LpXRS
	 po1WyjyNBnSs1M8dMPd+IVfS5tkIP30hQ3xN/0LSfMOWhio0yLLST6fj0bLrbMumrF
	 06+gv8BIDn6dGzBboi993qUMOLyM9BY/moerCU5fmQZ6D7sB1lbBd8PCUs9WkGYb76
	 5XzjLGb7I62xg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	borisp@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
Date: Thu, 30 May 2024 16:36:14 -0700
Message-ID: <20240530233616.85897-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530233616.85897-1-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_skb_can_collapse() checks for conditions which don't make
sense on input. Because of this we ended up sprinkling a few
pairs of mptcp_skb_can_collapse() and skb_cmp_decrypted() calls
on the input path. Group them in a new helper. This should make
it less likely that someone will check mptcp and not decrypted
or vice versa when adding new code.

This implicitly adds a decrypted check early in tcp_collapse().
AFAIU this will very slightly increase our ability to collapse
packets under memory pressure, not a real bug.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/tcp.h    |  7 +++++++
 net/ipv4/tcp_input.c | 11 +++--------
 net/ipv4/tcp_ipv4.c  |  3 +--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 32815a40dea1..32741856da01 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1071,6 +1071,13 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 		      skb_pure_zcopy_same(to, from));
 }
 
+static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
+					   const struct sk_buff *from)
+{
+	return likely(mptcp_skb_can_collapse(to, from) &&
+		      !skb_cmp_decrypted(to, from));
+}
+
 /* Events passed to congestion control interface */
 enum tcp_ca_event {
 	CA_EVENT_TX_START,	/* first transmit when no packets in flight */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5aadf64e554d..212b6fd0caf7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4813,10 +4813,7 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (TCP_SKB_CB(from)->seq != TCP_SKB_CB(to)->end_seq)
 		return false;
 
-	if (!mptcp_skb_can_collapse(to, from))
-		return false;
-
-	if (skb_cmp_decrypted(from, to))
+	if (!tcp_skb_can_collapse_rx(to, from))
 		return false;
 
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
@@ -5372,7 +5369,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 		}
 
-		if (n && n != tail && mptcp_skb_can_collapse(skb, n) &&
+		if (n && n != tail && tcp_skb_can_collapse_rx(skb, n) &&
 		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq) {
 			end_of_skbs = false;
 			break;
@@ -5423,11 +5420,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				skb = tcp_collapse_one(sk, skb, list, root);
 				if (!skb ||
 				    skb == tail ||
-				    !mptcp_skb_can_collapse(nskb, skb) ||
+				    !tcp_skb_can_collapse_rx(nskb, skb) ||
 				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
 					goto end;
-				if (skb_cmp_decrypted(skb, nskb))
-					goto end;
 			}
 		}
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 041c7eda9abe..228de0c95a9d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2049,8 +2049,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
-	    !mptcp_skb_can_collapse(tail, skb) ||
-	    skb_cmp_decrypted(tail, skb) ||
+	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
-- 
2.45.1


