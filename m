Return-Path: <netdev+bounces-293631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDtUKU1QHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92561C65C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF980308B7AE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC538F65C;
	Mon,  1 Jun 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIiccJmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4324201004
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305501; cv=none; b=nMXASBHAVECLzF+CRM5QCoc5MscDgC1ql+B1itcGCUn4S6p8iaE4jsy4wWYAC8pL2TitO7q4tUbHdVEguaSKol//Jorzz/E3KYOuXIPLosvJ7XzQe59Ivek+tD3zn1hPstncFx1Mf8YYTl8k/NbBhUw9MGN+wOxqzM97wy3p3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305501; c=relaxed/simple;
	bh=yAnIuIPW6bgr7GNewpLtx74zv46gDD9gKqJDj8TJGxE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f6mbsmDTleGyNv/aX8lSY7utpBEx8tWfvSJD592nShUoZ9cWqDTX7mN5nJ9kKamkAGU7Czz24tU4i0T6w+2hqzyf9scN7FWnu/stoloTymDIXpyY+jcqAy4L4TRw5alXkG1N0UNR7khpz5AJ4yjHYESktYEI/grDRR7t90C48BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIiccJmv; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-914b5249bf6so1867287985a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780305499; x=1780910299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+EMjoMJukK2L6kFVJX3+Oxh4XT/xOq7sLXPdrf2ZlVU=;
        b=LIiccJmvaZHQn+/bwYi3UIgYZVRMoyP9f8ENY0Zlm28Jjj/85ke2togeLYrOriR3Vu
         h20stZ9Hk762jRyiqOmKeojXaEhdi1XsgXWq7YX3BL/5XblUJzWHMLd8+wVBUAHwISCM
         bmzYHxLBN5kv7xy5nCl4CQlofDtcxBJyXb+m0PFiIJ0iAR84XysN3xnUge4eX6MV7vWq
         bMKUypZ2yCp0tCB/Cxq8rfi+BuO4D0VfTx0LFU3ZPxOmg6/5ddMN+2wufRfedSal8JqH
         lynGowkCMqqzOyV17763oiGRsYAHrFHP1x6CsSZVzptKNtl8LLlMF802/eRD1P9pY9nx
         Z9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780305499; x=1780910299;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EMjoMJukK2L6kFVJX3+Oxh4XT/xOq7sLXPdrf2ZlVU=;
        b=gjEKTKYxzQNGy4IIUFGWs4C73K7KpZRqDAes1sKSbxNddD8AmhobwLIiFn3BlNfdQO
         VnL+xBxUG1v4TObljzF19/V913pAgK1V5+5OAWNtcUuv0y++d1VpNNtyAbuTCF9hUJtN
         utybTm3yI7nPRXHSjvFYG72NSVu77R2/ESt6375tDyLHOjfDSF3mxLqitR0tKTRRN4ri
         KFpBw94NZy4nHBogRuXqswkGGKJeJ0d7ib3d8vUgxZ4IdlwUI0Iqq1wsEE2ZO04m4ItS
         Qt0MrQEq2YNqV3LWajfj7y1OoaVt+2uqhzvXucysyuWo6TogRN4R1aoXtVHtnFCCkLpy
         BdXg==
X-Forwarded-Encrypted: i=1; AFNElJ+6m6fgl8WWJBEag09BFzTeLPTlTSB4DcxOVCRe/rNl6cHcL6VhcmyptbPrPIeZFMgCta3XSoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp42Uliel0Zj/ZATHhqR08ceOb10NYGAooR2ifkyVG6pMRvWrx
	dGRnoHxqqSypa1Npjbr9fRDhGCcbLHFHPbJxf/7rxYdCQM2nEFL2m/X1ZOHGfxsWbswbAx2Ebwp
	xuUxntfGiav/Zrg==
X-Received: from qkee25-n2.prod.google.com ([2002:a05:620a:2319:20b0:914:ab43:2e46])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:26a4:b0:8cd:9033:1724 with SMTP id af79cd13be357-9153d938381mr1668818785a.9.1780305498443;
 Mon, 01 Jun 2026 02:18:18 -0700 (PDT)
Date: Mon,  1 Jun 2026 09:18:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601091816.444738-1-edumazet@google.com>
Subject: [PATCH net-next] mptcp: change mptcp_established_options() to return opt_size
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: 0B92561C65C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of passing opt_size address to mptcp_established_options(),
change this function to return it by value.

This removes the need for an expensive stack canary in
tcp_established_options() when CONFIG_STACKPROTECTOR_STRONG=y.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
Function                                     old     new   delta
tcp_options_write.isra                      1423    1407     -16
mptcp_established_options                   2746    2720     -26
tcp_established_options                      553     503     -50
Total: Before=22110750, After=22110658, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/mptcp.h   | 18 +++++++++---------
 net/ipv4/tcp_output.c |  7 ++++---
 net/mptcp/options.c   | 31 ++++++++++++++++---------------
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e40b507257c3720cc2d78d37357d6d..cd4639beceaa53c573135ddaeb7528a80b4ca824 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -149,9 +149,9 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
-bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			      unsigned int remaining,
+			      struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -266,13 +266,13 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
 	return false;
 }
 
-static inline bool mptcp_established_options(struct sock *sk,
-					     struct sk_buff *skb,
-					     unsigned int *size,
-					     unsigned int remaining,
-					     struct mptcp_out_options *opts)
+static inline int mptcp_established_options(struct sock *sk,
+					    struct sk_buff *skb,
+					    unsigned int *size,
+					    unsigned int remaining,
+					    struct mptcp_out_options *opts)
 {
-	return false;
+	return -1;
 }
 
 static inline bool mptcp_incoming_options(struct sock *sk,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef0c10cd31c71ff585a937fde37f2b08b1214b5a..31b459ecbe8307a8660623038fea6fa7b0860f7f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1181,10 +1181,11 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		unsigned int opt_size = 0;
+		int opt_size;
 
-		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &opts->mptcp)) {
+		opt_size = mptcp_established_options(sk, skb, remaining,
+						     &opts->mptcp);
+		if (opt_size >= 0) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
 		}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983cff3082d68290626dd8f1e044527f..53528301394d70072dde6614feca6128ea949436 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -836,13 +836,14 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	return true;
 }
 
-bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			      unsigned int remaining,
+			      struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	unsigned int opt_size = 0;
+	int total_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
 
@@ -852,20 +853,20 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	 * option space.
 	 */
 	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
-		return true;
+		return 0;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
-			*size += opt_size;
+			total_size += opt_size;
 			remaining -= opt_size;
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
-			*size += opt_size;
+			total_size += opt_size;
 			remaining -= opt_size;
 		}
-		return true;
+		return total_size;
 	}
 
 	snd_data_fin = mptcp_data_fin_enabled(msk);
@@ -877,9 +878,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		ret = true;
 		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,
 						      remaining - opt_size, opts)) {
-			*size += opt_size + mp_fail_size;
+			total_size += opt_size + mp_fail_size;
 			remaining -= opt_size - mp_fail_size;
-			return true;
+			return total_size;
 		}
 	}
 
@@ -887,27 +888,27 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	 * TCP option space would be fatal
 	 */
 	if (WARN_ON_ONCE(opt_size > remaining))
-		return false;
+		return -1;
 
-	*size += opt_size;
+	total_size += opt_size;
 	remaining -= opt_size;
 	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
-		*size += opt_size;
+		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
-		*size += opt_size;
+		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
 	}
 
 	if (mptcp_established_options_mp_prio(sk, &opt_size, remaining, opts)) {
-		*size += opt_size;
+		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
 	}
 
-	return ret;
+	return ret ? total_size : -1;
 }
 
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
-- 
2.54.0.1013.g208068f2d8-goog


