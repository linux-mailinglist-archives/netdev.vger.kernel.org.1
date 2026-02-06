Return-Path: <netdev+bounces-257631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEDYCF8mhmlSKAQAu9opvQ
	(envelope-from <netdev+bounces-257631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D110122C
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BF783015C9F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED0425CFB;
	Fri,  6 Feb 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqXX94dz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7C421EE2
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399287; cv=none; b=Zmr9uNU5oQFcvme8LVNIQ28r/4EJ8pf/3ySUeRDk8m+nVFNXJC0nDEskCp6FyAuWmVRl8kIJEykP1U8tapkryqLKYPgaRfAB4BJtl6yAy0ml2lmZksca+pLBqsiyK/78VvRzeUxQWhxAZjqtNrxvF30g77/co3TxtIcKeD8STnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399287; c=relaxed/simple;
	bh=bMU1ep9O4ZYqH5gfC+jzzbfhACfY2OFs3ODQ1j0Jrkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y3WWvIJBBkPsZICLnCev8NnsIBcB25w6p9EpsxKN7E9ndHS+NSCHbWJRhcZ8R016/Z547koV/HhodST2o3TxIF+d33Oys77RffJhX2Z/jlqjUaHBaB31Sv2fZ29bC0qLhWIsa3+IfQdIfpHfLZudafvLZ3G0uZs6r3mPfYlE6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqXX94dz; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c52f89b415so595514685a.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399286; x=1771004086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/I4hsckXYo5L71oKtQ+jZ8N6RpJRxgmu54Wm4j8Ho0=;
        b=dqXX94dzW/Frij0Tv57h89zx3vS5Hn45Hhfh2lEb4in9QBKTSdDJrdZxmwCJAp1LKc
         Q3OS3NmoOgVznEm/dTsZXqT9Onkwr8wwUGKNfe0V9LVIMEKnN0wH1dgqkGQ9iS2kggXC
         oIift/21w7ZYyNDfJwWium22GKxYieKJgadFBD673LSUnh9HFVEXUElzFmh8zN3GO6JN
         sB/S53yB34mrh5FBv/ZE7dfwp19Ji1XeAi5zDHtrATnnzWGe5JxIJhOd2/HlFiW6DBWR
         MNMqF174pJruoa1ak2+C0yJgid28AAD3t/AWy1LqYqfgZgrJSlsEuqmv/2mXkOfzJfag
         7mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399286; x=1771004086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/I4hsckXYo5L71oKtQ+jZ8N6RpJRxgmu54Wm4j8Ho0=;
        b=wf+oCBNl0BGXYsgZwsNBSkLUC26uogozaaQbJ6ahtKr51EDVYeoKP5enPrwA3G/YxF
         m31fqFHBDnZFNDjCEssvQp6fklVGxohU78RcmPbqXOpSbIpug1OmsHLSM7KLLCwMfJIY
         UVObvGhGmwaicjV3m+YJfxuMci4n8Xxr5vlvy4Uic1zC0fKov/m5xvBiXNBkPZzPRkFg
         STU3WcBIW6zJBF4y4lHEAVa6jNS/SB/n2QkixN30O5fXW1c9cBp1Wk8V0NZRBGu36Afb
         yRo0N1xdTeOT8jiEExNo2qX6//in2gt0KMeSSjNiYCH8t72nl9W0nJksiKVKOe2HNvCU
         xn1w==
X-Forwarded-Encrypted: i=1; AJvYcCXntmbEdijXfChfkGZyxh8x5aY9k6OuoAyhvHPQJkLx43JJ1gYIesFNUVv7S7y9/xyi2CzXynU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/aDwFdoWjpP/ofnAO3booZ9tu+xldRnxbWF7YSXOJb+c+THMz
	o1UAIiwHOkthw0szQQY9oz/n0M0+2WX8VPnMgkrNv2zyfSMLkt+rPS6tMB0sIFzU99A6jkSrkK4
	bZgMnbh+xKYBwuw==
X-Received: from qvad27.prod.google.com ([2002:a0c:f11b:0:b0:894:5d62:d45e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:700d:b0:8be:6733:92ab with SMTP id af79cd13be357-8caec1bf257mr445775985a.0.1770399286273;
 Fri, 06 Feb 2026 09:34:46 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:22 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-4-edumazet@google.com>
Subject: [PATCH net-next 3/7] ipv6: use inet->cork.fl.u.ip6 and np->final in ip6_datagram_dst_update()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257631-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D94D110122C
X-Rspamd-Action: no action

Get rid of @fl6 and &final variables in ip6_datagram_dst_update().

Use instead inet->cork.fl.u.ip6 and np->final so that a stack canary
is no longer needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/datagram.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 83e03176819ce940b3a84b2dd91f273490fcc017..c564b68a056268c7cbc81b5f29f60289ea9e09eb 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -72,12 +72,12 @@ static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 {
 	struct ip6_flowlabel *flowlabel = NULL;
-	struct in6_addr *final_p, final;
-	struct ipv6_txoptions *opt;
-	struct dst_entry *dst;
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct flowi6 fl6;
+	struct ipv6_txoptions *opt;
+	struct in6_addr *final_p;
+	struct dst_entry *dst;
+	struct flowi6 *fl6;
 	int err = 0;
 
 	if (inet6_test_bit(SNDFLOW, sk) &&
@@ -86,14 +86,15 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 		if (IS_ERR(flowlabel))
 			return -EINVAL;
 	}
-	ip6_datagram_flow_key_init(&fl6, sk);
+	fl6 = &inet_sk(sk)->cork.fl.u.ip6;
+	ip6_datagram_flow_key_init(fl6, sk);
 
 	rcu_read_lock();
 	opt = flowlabel ? flowlabel->opt : rcu_dereference(np->opt);
-	final_p = fl6_update_dst(&fl6, opt, &final);
+	final_p = fl6_update_dst(fl6, opt, &np->final);
 	rcu_read_unlock();
 
-	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
+	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
 		goto out;
@@ -101,17 +102,17 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 
 	if (fix_sk_saddr) {
 		if (ipv6_addr_any(&np->saddr))
-			np->saddr = fl6.saddr;
+			np->saddr = fl6->saddr;
 
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr)) {
-			sk->sk_v6_rcv_saddr = fl6.saddr;
+			sk->sk_v6_rcv_saddr = fl6->saddr;
 			inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 			if (sk->sk_prot->rehash)
 				sk->sk_prot->rehash(sk);
 		}
 	}
 
-	ip6_sk_dst_store_flow(sk, dst, &fl6);
+	ip6_sk_dst_store_flow(sk, dst, fl6);
 
 out:
 	fl6_sock_release(flowlabel);
-- 
2.53.0.rc2.204.g2597b5adb4-goog


