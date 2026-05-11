Return-Path: <netdev+bounces-286708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CZ7OHb3AWqcmwEAu9opvQ
	(envelope-from <netdev+bounces-286708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:36:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D115114D7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5049131A608D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35F3C5536;
	Mon, 11 May 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxTuApMP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D130ACEE
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512563; cv=none; b=EZcHKPmx7Xnl3Bc/Dj8gG/6kL/sKUrfgpN1xEvnvp3/JgKxDo0szHhHYWVuWbumiw14bSt1MERYssJx2+Uo9fD0QAc+SrwHsCtejHkfMSoZrW6rdNFu3nJuBCTsUFd13GGX5fLrqAVlfcA1g8/yqHKfinCaKpoIst9dPGdGYvSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512563; c=relaxed/simple;
	bh=VXlooWNppfL2ll9NFP8EA0T6EXdc5P6oVpolKunpd7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S1XHe0tt9y1oKdKgSOLcisoDuDMMhoI5MpujqZQvQTllOpUO/t7aM8vI71h5P7THz9VoCaOdYwTQM7dzjBHgXoudIVHv0ys757j1GZB9u+kIu3CMB7XvNaUzYZC8YjwA6/y1GZrKxTrfIo96kroBmMfjHxuw9q5wq6a1g6qKnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxTuApMP; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-65c41a9bc15so4635837d50.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778512561; x=1779117361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p8rebT/DTPMHWzhiu951i4v7Ko0S0eIrN9ALwkGkciw=;
        b=bxTuApMPnNkQ++Lqz4mSVAUTIGO7npgCbN4+cemsJ4VVjGr1oM9UnS2cZC2ua1Q/kB
         fNHRMqfA4tuyLTn+PFVSBlTfaImqeFFErgwXuchpM7SGV+HpCGXSod6ral9BTTb9WXZc
         yHwcNXEeBbDIKX1N744Jt+c0Qfi23RJjOJYVbaLWt1hptjdnPr1idGO7NDahEfU8F/CV
         pPykSOz55MVJv6DFBPj6jF/Kn397odTg/Cc3GNa9aeBYby9mAQbxeidxpPbAqjAmKs4Z
         joTSPUX1rT8+lBPfi0RkSTmX9UhYzt0M5n+nx/YDwovgzOggNzSSWd4PWpZdNQgo7+02
         ie0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512561; x=1779117361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8rebT/DTPMHWzhiu951i4v7Ko0S0eIrN9ALwkGkciw=;
        b=UhldtHWNQXRck1pR1Hpi9r+Ud86KLtOjJMqIODqAWTS6t/L/VpaskCdbOHRBl9oxDh
         oQTp02F2W7vIICHCqEHW9VCr30H0PTwYEXfqGHT+GlEAoaU8/+WQF4h0hyFP0I3fpswL
         LHg3jUfu+R+3sbA6j8pZSBOaVHOBwglvnVtWb3HxAa9OG8MKfvrKH+Tg4WJSwHERnfQU
         Ws0KIcNC+2NzkMSHteZKFMb18RKENpGZa/TIj5rFMuypP45hwHvbH7AMExh+VjZFoQnZ
         vzhZwijPaH4GnscOTyJdSbzg6fYuoeU27hqavotlTI9Oy1unZYKqEt5CPdTjRr3mEYM2
         W6Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+KB0QQZOP3Id92wWIrRp+Bd0GgRAAm0JzxY9xxgEDUADqMUmyXzFAmOwMT9Zmff3T8M9fVAZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cWspjOPCOe7yI8ErCK1/usQuqjEupQHRnmcgqZ9DV6dgMCXW
	IqsAK483SRWji7/U4KC7HiQsX0P+WfHuUlhxujSC6pSDlgndVWyaB7U9cH/PIGU/e0wJLqYdfhl
	TNJ4eM1HKTpMWfQ==
X-Received: from yxuj14.prod.google.com ([2002:a53:cd8e:0:b0:653:62c:b57])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:c944:0:b0:651:c160:1c06 with SMTP id 956f58d0204a3-65c79a2c909mr17795361d50.58.1778512560288;
 Mon, 11 May 2026 08:16:00 -0700 (PDT)
Date: Mon, 11 May 2026 15:15:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511151559.1916614-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 75D115114D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Blamed commit moved the TIME_WAIT-derived ISN from the skb control
block to a per-CPU variable, assuming the value would always be consumed
by tcp_conn_request() for the same packet that wrote it. That assumption
is violated by multiple drop paths between the producer
(__this_cpu_write(tcp_tw_isn, isn) in tcp_v{4,6}_rcv()) and the consumer
(tcp_conn_request()):

 - min_ttl / min_hopcount check
 - xfrm policy check
 - tcp_inbound_hash() MD5/AO mismatch
 - tcp_filter() eBPF/SO_ATTACH_FILTER drop
 - th->syn && th->fin discard in tcp_rcv_state_process() TCP_LISTEN
 - psp_sk_rx_policy_check() in tcp_v{4,6}_do_rcv()
 - tcp_checksum_complete() in tcp_v{4,6}_do_rcv()
 - tcp_v{4,6}_cookie_check() returning NULL

When a packet is dropped on any of these paths, tcp_tw_isn is left set.

The next SYN processed on the same CPU then consumes the non zero value in
tcp_conn_request(), receiving a predictable ISN.

We could fix this by clearing tcp_tw_isn at tcp_v{4,6}_do_rcv() start,
at the expense of slower fast path.

This patch clears tcp_tw_isn only when drops are happening.

It also adds two DEBUG_NET_WARN_ON_ONCE() to detect if any drop paths
are missed in the future, as they check the state of tcp_tw_isn at
the beginning of processing a packet that could potentially be a new SYN.

Fixes: 41eecbd712b7 ("tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 3 +++
 net/ipv6/tcp_ipv6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c0526cc0398049fb34b5de20a1175d54942e80cd..529f10a768183f74b85fcfdbee94d35c88c55122 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1878,6 +1878,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 reset:
 	tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
 discard:
+	__this_cpu_write(tcp_tw_isn, 0);
 	sk_skb_reason_drop(sk, skb, reason);
 	/* Be careful here. If this function gets more complicated and
 	 * gcc suffers from register pressure on the x86, sk (in %ebx)
@@ -2198,6 +2199,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 	}
 
+	DEBUG_NET_WARN_ON_ONCE(__this_cpu_read(tcp_tw_isn));
 process:
 	if (static_branch_unlikely(&ip4_min_ttl)) {
 		/* min_ttl can be changed concurrently from do_ip_setsockopt() */
@@ -2274,6 +2276,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	}
 
 discard_it:
+	__this_cpu_write(tcp_tw_isn, 0);
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
 	/* Discard frame. */
 	sk_skb_reason_drop(sk, skb, drop_reason);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d13d49bfef19457cc5902cb556605a80f4c0ab2c..079f2324a3a777cfe30dd59777c9d3d6d9a6bae0 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1641,6 +1641,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 reset:
 	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
 discard:
+	__this_cpu_write(tcp_tw_isn, 0);
 	if (opt_skb)
 		__kfree_skb(opt_skb);
 	sk_skb_reason_drop(sk, skb, reason);
@@ -1839,6 +1840,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 	}
 
+	DEBUG_NET_WARN_ON_ONCE(__this_cpu_read(tcp_tw_isn));
 process:
 	if (static_branch_unlikely(&ip6_min_hopcount)) {
 		/* min_hopcount can be changed concurrently from do_ipv6_setsockopt() */
@@ -1913,6 +1915,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	}
 
 discard_it:
+	__this_cpu_write(tcp_tw_isn, 0);
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
 	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
-- 
2.54.0.563.g4f69b47b94-goog


