Return-Path: <netdev+bounces-47773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2E7EB578
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815FD281319
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8E2C196;
	Tue, 14 Nov 2023 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NP2Cqp49"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9462C18A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 17:23:49 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15CF1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:23:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daf6c1591d5so2197600276.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699982627; x=1700587427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUkDREpvnPGXIq+muWkYhdTXd+teuC8g8pb7QYn5qX4=;
        b=NP2Cqp49hsT+6lTkvg5/cdDi3hHscaqBmd1thbH+OnQ1qCIboVMSUdeS4xdHIZeS8O
         T8UsLE4W7bPS2Tsd49zEm5tcqOFX+g/cjwNYWI7D8pHtbBNLOPthr98pAzsZs4RMo1d6
         Rr6e6LF+9LXngrLR5cFKmQHNcZTB4vkGmBzPZmtWVxMwAyMPUzcomim8D9EGCTlXio5U
         U2BRS1W63AporyAGYc1WWp4fXkPOKoB5qTghAH+eTwe6LuijVV3J9w8PNZXqWSo3oSrF
         V0ik69nOqGFKEQ9xmEROMOsJx7dKQrlO3EMypGLzoBUt+aYqIyUJXVF1gyG77u1egMFU
         WLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982627; x=1700587427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUkDREpvnPGXIq+muWkYhdTXd+teuC8g8pb7QYn5qX4=;
        b=TmFKfHgAD4BcCWb9bY9+55Kxz4wOvx+cQH2ZRf7BJYlo9dZlyGAHZciEDaOBgV1g1m
         Kxkl0e6M6WRTx/EPB4aXEZut8E+MQa/dwvibpAJVFom6Ft2+6XACqYNka0n0PxR+4YGm
         T2QQ3Oy74ddDqvkVjdZ5M/gy4Qcgxn/OqZJ9D+Kxc430rFur6U1q2nNleZ+Qkl6f6oMc
         RPfV0jDr546PJ8VJwILjRDhQUG5Qw988VxC6iRSZz0h7MMzwZHLJYv5HepUrEbQHjT0v
         4ceHnMGRIVgH5Y9BLIG425g+pBqmQdfXkEwBD4qk4/OHGqMHJ45wftJyJ6wEFHgviuLe
         IaMw==
X-Gm-Message-State: AOJu0Yy1JOpVdxsrsNY/vhnh+e9LdCd2QXGwLgqryBErKPMA+fQt/+s0
	r0BuwpTPmv9wDVusOcQoZSbYpXpYR71RQg==
X-Google-Smtp-Source: AGHT+IG8Z9o48pH6RXZanf6JC6wetwZf9RrfuUSh9UnI66oKdoV5qnMbnzp837IECufwCZ/V4BvmJAciQhPQ+A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:694:b0:d9a:ff08:e090 with SMTP
 id i20-20020a056902069400b00d9aff08e090mr236080ybt.5.1699982627133; Tue, 14
 Nov 2023 09:23:47 -0800 (PST)
Date: Tue, 14 Nov 2023 17:23:41 +0000
In-Reply-To: <20231114172341.1306769-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114172341.1306769-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231114172341.1306769-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: no longer abort SYN_SENT when receiving
 some ICMP
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	David Morley <morleyd@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, non fatal ICMP messages received on behalf
of SYN_SENT sockets do call tcp_ld_RTO_revert()
to implement RFC 6069, but immediately call tcp_done(),
thus aborting the connect() attempt.

This violates RFC 1122 following requirement:

4.2.3.9  ICMP Messages
...
          o    Destination Unreachable -- codes 0, 1, 5

                 Since these Unreachable messages indicate soft error
                 conditions, TCP MUST NOT abort the connection, and it
                 SHOULD make the information available to the
                 application.

This patch makes sure non 'fatal' ICMP[v6] messages do not
abort the connection attempt.

It enables RFC 6069 for SYN_SENT sockets as a result.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Morley <morleyd@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
---
 net/ipv4/tcp_ipv4.c | 6 ++++++
 net/ipv6/tcp_ipv6.c | 9 ++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5f693bbd578d2261b78aa0be6bf69499bbd5117e..86cc6d36f8188ec6a761c3a949382c03e74c91f8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -482,6 +482,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	const int code = icmp_hdr(skb)->code;
 	struct sock *sk;
 	struct request_sock *fastopen;
+	bool harderr = false;
 	u32 seq, snd_una;
 	int err;
 	struct net *net = dev_net(skb->dev);
@@ -555,6 +556,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		goto out;
 	case ICMP_PARAMETERPROB:
 		err = EPROTO;
+		harderr = true;
 		break;
 	case ICMP_DEST_UNREACH:
 		if (code > NR_ICMP_UNREACH)
@@ -579,6 +581,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		}
 
 		err = icmp_err_convert[code].errno;
+		harderr = icmp_err_convert[code].fatal;
 		/* check if this ICMP message allows revert of backoff.
 		 * (see RFC 6069)
 		 */
@@ -604,6 +607,9 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 
 		ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
 
+		if (!harderr)
+			break;
+
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 937a02c2e5345390ed592b19faa661cd703a23f0..43deda49cc521278f0bd869135e70bbe7aed6d35 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -381,7 +381,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	struct tcp_sock *tp;
 	__u32 seq, snd_una;
 	struct sock *sk;
-	bool fatal;
+	bool harderr;
 	int err;
 
 	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
@@ -402,9 +402,9 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return 0;
 	}
 	seq = ntohl(th->seq);
-	fatal = icmpv6_err_convert(type, code, &err);
+	harderr = icmpv6_err_convert(type, code, &err);
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
-		tcp_req_err(sk, seq, fatal);
+		tcp_req_err(sk, seq, harderr);
 		return 0;
 	}
 
@@ -489,6 +489,9 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 		ipv6_icmp_error(sk, skb, err, th->dest, ntohl(info), (u8 *)th);
 
+		if (!harderr)
+			break;
+
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
 			sk_error_report(sk);		/* Wake people up to see the error (see connect in sock.c) */
-- 
2.42.0.869.gea05f2083d-goog


