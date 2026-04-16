Return-Path: <netdev+bounces-279157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDWAEapC4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:12:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3F4147EB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADAD431B3BEC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC8A3EE1E6;
	Thu, 16 Apr 2026 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqVl5f5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A383EDAD6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369832; cv=none; b=czjuZz7W1bJ5mECKfodxfi6G8PQIMP4/oubp71LtXgR+HKqsrfw7i284eLOJfxrqUZlLBnVToLr2MFHwPsywu8xK4Ak4eOlcYz8LuBFoQLZwXJ8fiyTAZhXrfhUpVJrcDskWgfTIZ51FTQ5rZ17fqgZz/50at39Net13YWHzny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369832; c=relaxed/simple;
	bh=47bC2gWZRJarybm8PAXj9bSC53ZfL2IFpNCin24kwMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IWkc1Cv0cQ6LcRbtGLwe81kFqFPjp3OF6aFsZeey/3K8jtvEhsYUtDUExbzxu4UweHZkBCLsQVumtV5xRnSbzwSIVvl7XWjLxlxIp5G4/m3KPW8MlA2yEK++R5boeHh8VwHPtvyfUnd1Y2stO32YYPexZ/XTo3jzuDHfiGvF3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AqVl5f5n; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50df4c130dbso30368581cf.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369824; x=1776974624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP5P199RD8Y7sfP0xfHmdzIt/OGXTGt+t6OoheVbGgE=;
        b=AqVl5f5nPUjUjBfAAv/99tBX1Xi563Gmjyapis6IVPC9wbJTvyEQ32857H7H1PmV1w
         h9modybCSZg0GlkEqA60AqMkWJW2tKn5mPo2ts0tpcxFI3ppVg/EFCL63D3vUKk960cP
         Fqxkmj1jU9jMHfSiJfjmmXfoUxwjZAh/EmyaQNWk5wRfOl3e2wQ7J7koGF5kmlJPY7kZ
         RtmLtN4bB8Mw9mlKL2bOn5iyJn4jUPZxltB2gO+I6BRMAlEqsvezGEHzBMIHljEDU4o4
         tKDEHkb1kvgUcMlg77U1PBqBhQBJrQZTxwIzXXgxv1SXotU2+n/FGXfBdmzFeH1Hx4Hk
         fQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369824; x=1776974624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yP5P199RD8Y7sfP0xfHmdzIt/OGXTGt+t6OoheVbGgE=;
        b=oKvS4o6AS7sJ7XOEXmH9i59K/XbRvav+hNBQdNTMV+NYtfyMixjkmaU7EligoU1WFE
         80pYvS9E/QCbYpRHqx1aOLnvmuXyipkxv0bBQYPqKqDCV+RIqlV7syUUen/6j+YUP4mG
         NGAk2w2Vi2BvXwzAfrN7DApngOWD9a7oEcdQRP2Bna5GlQNYkcQqkrxGBh8nm/6IDX4J
         tMbMU2wn+8ZiaaKR78Xxo0yDgopaEDnF3/wjOdBLCgyX74oZyqj/Q4+SKeMzKNW+d5mQ
         rnG0Wfdq0tLmltjctjqxgx+3tX/iG+ZHmomurj3y4KETTmCzuYEpaf/8oTPly3k6ynnX
         oxvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DjU0NuiL4RBTMZnd4ZPZm+rYldm0461/lH0l5WGjWwAhuKQQXkCpBT7u9FBBllSbMQv+Gwak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSmMmoeEraA9uKetk8ZnPfhBoN90AipcV6Lc2Oxejf37zwqX3
	nSow5gPd60oDOkHUchqimHQQDpzuiGK0tVAaqW9l3vr6LIpAKvzHB7SoZULx805vzHF9TekRBRN
	ID2W4u9GbYjANXw==
X-Received: from qtwj16.prod.google.com ([2002:ac8:4f90:0:b0:509:3336:c0bd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15cc:b0:506:baf9:5dd9 with SMTP id d75a77b69052e-50e3448f3ecmr10759951cf.17.1776369824229;
 Thu, 16 Apr 2026 13:03:44 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:19 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-15-edumazet@google.com>
Subject: [PATCH net 14/14] tcp: annotate data-races around tp->plb_rehash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279157-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AB3F4147EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 29c1c44646ae ("tcp: add u32 counter in tcp_sock and an SNMP counter for PLB")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c     | 3 ++-
 net/ipv4/tcp_plb.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 68894c03f2622d1a08fd747ff4c5e32be8579d2c..7fbf2fca5eb2c63763231d4d55b770b85a7cbdbf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4480,7 +4480,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 		nla_put_u8(stats, TCP_NLA_TTL,
 			   tcp_skb_ttl_or_hop_limit(ack_skb));
 
-	nla_put_u32(stats, TCP_NLA_REHASH, tp->plb_rehash + tp->timeout_rehash);
+	nla_put_u32(stats, TCP_NLA_REHASH,
+		    READ_ONCE(tp->plb_rehash) + READ_ONCE(tp->timeout_rehash));
 	return stats;
 }
 
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index 68ccdb9a54127632b6b764b5cbb18e1589ab1aa7..c11a0cd3f8feb004150a4056f5ca57f90d2cb2b8 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -80,7 +80,7 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 
 	sk_rethink_txhash(sk);
 	plb->consec_cong_rounds = 0;
-	tcp_sk(sk)->plb_rehash++;
+	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
 }
 EXPORT_SYMBOL_GPL(tcp_plb_check_rehash);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


