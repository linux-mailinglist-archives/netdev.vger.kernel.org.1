Return-Path: <netdev+bounces-294210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SD9HMAbSHmrnVQAAu9opvQ
	(envelope-from <netdev+bounces-294210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2462562E2C8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=I+aYXULR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294210-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294210-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FDE13017256
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C8938911E;
	Tue,  2 Jun 2026 12:51:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913942EBDFA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:51:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404702; cv=none; b=cXAZ7jEACbXoOZa+KOyBKULgq3BtbxzheeQjX0noVJ8WjfA0TPobHDCOP1U7Q7srLTZvaHgZH3FpklkZEOcV7t+p4x2lIu+iY0kB+NFbtg2HqdTKLC7Hr/3F9Xlx3nbjmbaKZxwjT57fs/MSJgHkDbaaKoC/QDpj3rpfKpLrZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404702; c=relaxed/simple;
	bh=KaSqOeg6uCoksrgxvOBfu79BpBdU+VfgppqUi114iQ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QPGDg+tU83Smp21ZHPPmXUH1cYm+w7NcAZTQqtveYMET44zGXxlul3YD8MvOrztHKyKbgRrQO2dKrM8vxflCI0XdfQc5z9q5UK2tiH+7x5llCwVqoYxfBaJQ9HDgIuBeU+/SaXRpf+LATW2b4IHJ0QBmY1GdEPBvCrDXRnO44DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+aYXULR; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516e0846095so53758441cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780404700; x=1781009500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4Sd1yluzf5+pkQDXeiHB4+StABKX6sm4yQ5y0Up3hk=;
        b=I+aYXULRbJb4e3k6CVQ8cS8O9UIZnrK73yFFlIAxoq/7DxN/sFfpv1SZKCCvGywJ5J
         PEoQpkQQRZUTsuoG0KmpU5yCyReyJ+ojtLAci2XNXHM30ziBJJ0nzOoBvxgujSzaY0jy
         ceTT+nu1aoXfD8Z6Fho1TzAozVKuUZpjqDo+Q8mgpFj0suRCPzYSNLsKExw3LBVtXs/g
         H1IDXpJC3R4QGo7JqJ/8w584e/m7GZh5VpJ0sdREaOj+cRuQps0FsQoWbhVI5Q7kLhx+
         9kG3p9anQogUXG4N4TYkqkoO81ElgNALEdo7gzndkPKntwLq9SwUCVlm68G6+nD7chL6
         Dnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780404700; x=1781009500;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4Sd1yluzf5+pkQDXeiHB4+StABKX6sm4yQ5y0Up3hk=;
        b=Rk/FiJSjVKnKgLY/XxdxANNL8EbWu6hNSRFVvJ8nT42uRCW64DeINTPvfSXQEKXBc8
         pmhywPtLT5I5ihVRRthnv43o7D9sfUauJQT2ES/tNSyEOGiH02DAbNXA13HjUI6DjYLp
         rK4d6WScNzl+meOPefCNTbLAjNJSQd43c8Fts7yNV/QeRt54VgqHqcfavkmjw5lPHTmA
         wDGqg4XC+BdllgqE8gxHgdVTnshXqH1McUrUJEqZ7BjgGB6SnjeJ1+Hl7N9RP3s9wy80
         bkHW/te6GFgVS5Xf9eYr/Z7Hsj+UNk3vFiW3g3v8BIoIzfWQECQl2w48FmWLIT+XUJE/
         +PvA==
X-Forwarded-Encrypted: i=1; AFNElJ/Aw3MuE7pUct1jTf13O+XsBFoxNdrheoa8DThIlVPYVDv4J4pHBtQd/czNVUnRcbCSzk41LQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32W95KBVhX6yPt8ucSMGPn9iSePQhxo5v1dUwBDhuMnMty/Of
	Zkqdat9PNi61hKPulzOXUg2whBx0nSgQnhUfSdg+dBiTOk/Df+I6nRGL1bITc5arIyVYc0eD40s
	OavEO2P47V8Pgdw==
X-Received: from qtvx5.prod.google.com ([2002:ac8:4d45:0:b0:50b:4726:f15a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2511:b0:516:d812:c35e with SMTP id d75a77b69052e-5173a62be60mr219302021cf.21.1780404700318;
 Tue, 02 Jun 2026 05:51:40 -0700 (PDT)
Date: Tue,  2 Jun 2026 12:51:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602125138.2317015-1-edumazet@google.com>
Subject: [PATCH v2 net-next] mptcp: change mptcp_established_options() to
 return opt_size
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294210-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2462562E2C8

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
v2: fixed the !CONFIG_MPTCP case (Matthieu Baerts and various kbuild bots)

 include/net/mptcp.h   | 17 ++++++++---------
 net/ipv4/tcp_output.c |  7 ++++---
 net/mptcp/options.c   | 31 ++++++++++++++++---------------
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e40b507257c3720cc2d78d37357d6d..27225c68a388f1e4cfd1e77e464d5dc4307f87c9 100644
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
@@ -266,13 +266,12 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
 	return false;
 }
 
-static inline bool mptcp_established_options(struct sock *sk,
-					     struct sk_buff *skb,
-					     unsigned int *size,
-					     unsigned int remaining,
-					     struct mptcp_out_options *opts)
+static inline int mptcp_established_options(struct sock *sk,
+					    struct sk_buff *skb,
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
2.54.0.929.g9b7fa37559-goog


