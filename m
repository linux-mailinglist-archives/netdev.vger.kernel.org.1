Return-Path: <netdev+bounces-266468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHwLAbT7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:20:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652125C5DA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1879530F6D75
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E465278161;
	Wed, 11 Mar 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4f+MjX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980E1DF736
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206433; cv=none; b=D59zAQ6ZBoww8wMdJwr4KeGXpa6+CTmm1vdVgaowsbI7mg+JTHfq311aQNZh2vZFL8ULdRXHXd2UbBtkv9tCwaF4Dn5kPedh7EqjUjcIA7wBZFPCX6k2Hean9P/7O4LAnDQUEOvXRFTrW4HUFcUVhSccbCdSAVfiPk45dnWMf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206433; c=relaxed/simple;
	bh=LrxvWdgRIHJMniJGkG5ktOZxczbfauXkUsESayct99c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aUScRGtQzTDHXB93sJlazPZBWyLt+HBxDc7Afg41H7pc2zOU4mNf1QACbV7qSeL1n4lrXDDLZyCSFcsS82fszlXL2MmYGqF8U1PujLzAOfOS46Ews0k3hwJF5P4+Md4iErpvbttpirHSGMjaWhw5Yg6AjM20mVHNJU1C7VGhEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4f+MjX9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8299c57642cso28804676b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206431; x=1773811231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4glLDJUU2drdghiYhHJwAgiicPoVmTdv4+Jl0iVHjk=;
        b=P4f+MjX9cXibCwWOvOSrl8WeeNAL9yepOmKXKuDzAaNOrd+nrKZbjjzrxrNIxJViz6
         a+nyBXdYTiSHe2XV30mzIv0L8z7odPBfa4y+mothskf/68Q2+0AFXXxDnT9yWgQHpnGH
         f9XPXki5NiMoGx3Bc7pbWD4P6abgDdnY01niaKPzCQ2DhLuc7Z1zMbQe2Qd6p6j94WdD
         ytuP3OxXEwpceruW9PO5X4AfS/TKqF5vyjcSiEwFfRHDtQS4iopg2DDE3g6bXvCW4yo/
         VcKya/RKM26khCn39j+6wg4IGiThd0w4/kxOWilXLAx80+Cy491o0sZnnyEfiyt2K/EQ
         /nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206431; x=1773811231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4glLDJUU2drdghiYhHJwAgiicPoVmTdv4+Jl0iVHjk=;
        b=VFbhU2d78TQcooKXSKg8FMFsufXhTAybq+Hnjkq3kqi1QAB7gah1dpr5HKMsb1VfBI
         rcwpRmUtoCBWkY/j2Aupn8UnQsyWB5Ne7HU5N04xK29+Ih1e1NC76IevhKP8erLPZ3qz
         L4H6qE5R4XEY3NVNqHd7t5ubaDNmK85fYJNBg5U0Mjk0+H8HofmF5oirLMRIBSHqL99o
         2Nce24QKzKjK65rSM1uqlUY8AdfG4htWbXSptUezn9szYHFAt1q8Oqu9cbWocP243HLY
         qoSYD0XHpYiwB3YN1SjbQIdqwBdzx8PVaZuPnv1E45ZfFtpP2IgdudJmfNhntMYNHRtN
         mLGA==
X-Forwarded-Encrypted: i=1; AJvYcCVfN1Rl5KYE0cK9Yqa9QCu9EHJoyXD+PsRmbPCN94eqwJgWi3Zy2Ubv1WYKGZ4BT/71ZrMPWWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6JuOybd25l4Oimh2o+dGFeoLPsHxYmJx0ZXFW+xPPMcWq+9F
	s97BuhLbswNtp4uNsOEhC6oFPeeOaBIvI2LyfaCdHOHJXry7AmzPLgKMj4e05FsDjfWpE3RQdPk
	sDZdEbw==
X-Received: from pfbcp5.prod.google.com ([2002:a05:6a00:3485:b0:7fb:ed58:5e4b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc7:b0:824:9f22:1e95
 with SMTP id d2e1a72fcca58-829f71037acmr1500454b3a.55.1773206431266; Tue, 10
 Mar 2026 22:20:31 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:50 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/15] ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5652125C5DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266468-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

We cannot create IPv6 UDP-Lite sockets anymore.

Let's remove dead code in IPV6_ADDRFORM.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/ipv6_sockglue.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 02c4cab60c69..b4c977434c2e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -45,7 +45,6 @@
 #include <net/inet_common.h>
 #include <net/tcp.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <net/xfrm.h>
 #include <net/compat.h>
 #include <net/seg6.h>
@@ -563,10 +562,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			if (sk->sk_type == SOCK_RAW)
 				break;
 
-			if (sk->sk_protocol == IPPROTO_UDP ||
-			    sk->sk_protocol == IPPROTO_UDPLITE) {
-				struct udp_sock *up = udp_sk(sk);
-				if (up->pending == AF_INET6) {
+			if (sk->sk_protocol == IPPROTO_UDP) {
+				if (udp_sk(sk)->pending == AF_INET6) {
 					retv = -EBUSY;
 					break;
 				}
@@ -607,16 +604,11 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				WRITE_ONCE(sk->sk_family, PF_INET);
 				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 			} else {
-				struct proto *prot = &udp_prot;
-
-				if (sk->sk_protocol == IPPROTO_UDPLITE)
-					prot = &udplite_prot;
-
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, prot, 1);
+				sock_prot_inuse_add(net, &udp_prot, 1);
 
 				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
-				WRITE_ONCE(sk->sk_prot, prot);
+				WRITE_ONCE(sk->sk_prot, &udp_prot);
 				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
 				WRITE_ONCE(sk->sk_family, PF_INET);
 			}
@@ -1098,7 +1090,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case IPV6_ADDRFORM:
 		if (sk->sk_protocol != IPPROTO_UDP &&
-		    sk->sk_protocol != IPPROTO_UDPLITE &&
 		    sk->sk_protocol != IPPROTO_TCP)
 			return -ENOPROTOOPT;
 		if (sk->sk_state != TCP_ESTABLISHED)
-- 
2.53.0.473.g4a7958ca14-goog


