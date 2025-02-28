Return-Path: <netdev+bounces-170713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA22A49A73
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933111897178
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3526E16B;
	Fri, 28 Feb 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIpPpT4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6826E15A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748980; cv=none; b=PhWJRwqsJh7U1rxRh7N238wH6PqcPCmxYn7jH6GoI/ZLQFDQJDu3ulO9PzO5cu/R7gU7CK0fC8LLIy1/1GiOIKQ6aVgDFGc6r+gB4iG//Q9yrygar0lovYhl0W+Bl7WJZJIDcD2XM1Y5j9mq3uv7tfWIA/ZqYcFChEPYpxDLBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748980; c=relaxed/simple;
	bh=7cS9lozPjGK6CJDB0rbF/JsDu7ljNWKuNdAb8/+05tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PzdZf4bBypX/A6Dg+agXC085UTiLEqtuU7o2BOQNrfSy4OOUWN88KreJvIjynV4OW9AwOojFJuTW41oDTT71TS3m2q9Dxm082hVnlePXf4xePC6cLaiCyTIGPhVOVD3llXcXuV7+u2JAYGnN4hzVCEh6xvD/Wr7U6buGvG/7ve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIpPpT4V; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4720468e863so57182421cf.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748978; x=1741353778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOQFszIdy08TjK2quwg21U1oq4H1pENWDe9muSGOA0Q=;
        b=LIpPpT4VE/j40vChgGbkeJIcxvIbXjBaK9X6wD5L2hJnVG2XPOSz35CX5Wmo7kDZlW
         GMQDtYu9kWba7UtmMst6jmiMCk579OUu34VFwsS300qR6ngVksRtvGa0LMEwcmkC72kN
         IYPLkmN8JXI6WdbUvSZPoQPKk2/tPti6fWsbf+uOeRR8z5hnN+2McynZdZoAiLHW3xV3
         HaraAkRFwPmkAkDl1DucHinP4m7BiwU4QY88rXPLHV9PgxFZOL/xMqvqboO0SyKUAFzH
         5TwXJFEO7Z9xmi/otNsAtCqnigwZm1/M4+Yxlmikfua3rA64l46gshi2mXXTZcO4ki/E
         bAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748978; x=1741353778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOQFszIdy08TjK2quwg21U1oq4H1pENWDe9muSGOA0Q=;
        b=jVhm4LDhmREv+1u49j4Gp/dWISFKCi28doRKQgAX6HXMmwsU357utjLv7m8YG89HKp
         jMQOiAUpv6+Wz+LmFNzRm8pY41zOmese45BCHtxHhVbkPKSKZm4tOUhU7IzwPpJBNXlo
         vPayRAKNC0JLhegZJrAE588U48F0rfkQ54dll/JeI5/pJuCkXnafpf2qAbZu3bRIfB+o
         Kv4xBFShaNmcRlVhipZY1/E/qJZWb4BykhBrn+OSZAcjjHTK063W8cR7tdaUgYlsAagu
         ZesqzmNrt7kdCJEpZrY5SMBSoEl57B/Hc6oylIJnWo+sIrD3qxAKcXMAnfR2OY6m3VGY
         AKHA==
X-Forwarded-Encrypted: i=1; AJvYcCXVZ9iuKhzbdIgQxaSG3es934GOnUDm5+4SF5ixIDSnEm7JScBwSOICzCpCiTlr9g8xw8DjHBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmG4N6wj+Zw0haX2kN1AQ/xUe+mn7DBr7rWSJ1Y4HiPXRrLjsq
	ltXKFetQ9vD/KDfmJu9IdhwI1PcD45Tq95mDejeV9+yK8bhwt/eDombAZTn00EY5Zp2SOsE8ho3
	iqcnHFEptAQ==
X-Google-Smtp-Source: AGHT+IGeU3/C54Ivok3ZVkCLjuYXF1hcfsKxRR6gvyEvDs1jN7PO3Zy42pixlFRDcjWq/CnppDm+8tt0fYwgHA==
X-Received: from qtbbl3.prod.google.com ([2002:a05:622a:2443:b0:471:ffa7:6963])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f04:0:b0:473:8c05:2b5b with SMTP id d75a77b69052e-474bc0f2da1mr44242381cf.47.1740748978093;
 Fri, 28 Feb 2025 05:22:58 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:47 +0000
In-Reply-To: <20250228132248.25899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-6-edumazet@google.com>
Subject: [PATCH net-next 5/6] tcp: remove READ_ONCE(req->ts_recent)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Wang Hai <wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"

After commit 8d52da23b6c6 ("tcp: Defer ts_recent changes
until req is owned"), req->ts_recent is not changed anymore.

It is set once in tcp_openreq_init(), bpf_sk_assign_tcp_reqsk()
or cookie_tcp_reqsk_alloc() before the req can be seen by other
cpus/threads.

This completes the revert of eba20811f326 ("tcp: annotate
data-races around tcp_rsk(req)->ts_recent").

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wang Hai <wanghai38@huawei.com>
---
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 4 ++--
 net/ipv4/tcp_output.c    | 2 +-
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ae07613e4f335063723f49d7fd70a240412922ef..d9405b012dff079f7cafd9d422ff4445a27eb064 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1155,7 +1155,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
-			READ_ONCE(req->ts_recent),
+			req->ts_recent,
 			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ba4a5d7f251d8ed093b38155d9b1a9f50bfcfe32..3cb8f281186b205e2b03d1b78e1750a024b94f6a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -585,7 +585,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	if (newtp->rx_opt.tstamp_ok) {
 		newtp->tcp_usec_ts = treq->req_usec_ts;
-		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
+		newtp->rx_opt.ts_recent = req->ts_recent;
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
@@ -673,7 +673,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
-			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
+			tmp_opt.ts_recent = req->ts_recent;
 			if (tmp_opt.rcv_tsecr) {
 				if (inet_rsk(req)->tstamp_ok && !fastopen)
 					tsecr_reject = !between(tmp_opt.rcv_tsecr,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0a660075add5bea05a61b4fe2d9d334a89d956a7..24e56bf96747253c1a508ddfe27ebd38da7c219e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -949,7 +949,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 			tcp_rsk(req)->snt_tsval_first = opts->tsval;
 		}
 		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
-		opts->tsecr = READ_ONCE(req->ts_recent);
+		opts->tsecr = req->ts_recent;
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
 	if (likely(ireq->sack_ok)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index fe75ad8e606cbca77d69326dc00273e7b214edee..85c4820bfe1588e4553784129d13408dea70763a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1279,7 +1279,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
-			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
+			req->ts_recent, sk->sk_bound_dev_if,
 			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
-- 
2.48.1.711.g2feabab25a-goog


