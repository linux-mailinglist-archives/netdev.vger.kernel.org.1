Return-Path: <netdev+bounces-279148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAavHidC4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:10:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F644147AF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B0E3121267
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FC3ED113;
	Thu, 16 Apr 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbN09bNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D13ED5D6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369818; cv=none; b=gpgD8U5Hax5MwPGdki1YTvsOO4mD7EhaNHiYpyFmuY1NCgVMac4yX//e97EqJa1SsFzTuJOZDSgz2e4g9FhIC1AU/TkBnylDtwTJFfYp8KtZK2+unMU8Fah5WUlKjx/q1JOqiu8GXwPnkVOiSk43aAZ+01tE/WYS7TAETnZfq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369818; c=relaxed/simple;
	bh=1deaCbjq1+IHzRUZDdwtpewDJ07l66FtHsRDxG0YFoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J0Tdj0OKyKEN8HTL7P1yjfs0UPNuzblK/wzb/yMkJZlB3secsWaMRNA47GtiwdzjxKVlKq08Ek6T1qfmcVXfOr2S8l7eM/YTEHExiDUPLwzgA6LdEbqzg8VgCE/FctPa+KGA3CtPULi1VET44SYklSxemEfOYj1OppkLJwkzxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbN09bNK; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d58bed44aso249933191cf.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369809; x=1776974609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOJkF8JIJu9h7IWPIZgcERoTnXs8TYUkNj1H8eXXKX8=;
        b=nbN09bNKI0FjsoLxw8NcwewDI0qnHIYY4h6XW/QYgxmU/aDj6qJyan0cgcimmjH8pf
         U9t7pqUzlLaGlPpRZK7DPaLTxYeIBXmEZZVN2hMJnm0leUiHdMsW6OWQ5u+PhnRJqfJy
         rFxqmGtKCDmdIvSn+h0NZTNvwF7QV99IYVbyFACmWq27dHw6DEqAAQgcAr5NLuXMzkoy
         beQL3lXGOrhHDJc+qyyMHlluR6m4C1PfJw/+xSXZ8tyTYThh5ak8oT3AHc/XodDExU+B
         0AMDIE5/ye5X+4r9k57G9F/ON/r+CWbXqWQ5AjgY0vgQe056BTRmEbgC6Qq5rxuWgU7D
         75DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369809; x=1776974609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOJkF8JIJu9h7IWPIZgcERoTnXs8TYUkNj1H8eXXKX8=;
        b=tQpsYwU/SjEBOyex1xJUwnnBmKBS2NmhN+M0qViqG0FThRkr5MYzTfCDZosKOWq+0k
         0d48m/axomlWVT0h7AzijR3LZb5bsacYx6jUbn/sN1o3EeGH4XzfsNKX1f1EPPOsb9kE
         ori94hAEauMGaXC28m/8p4MB5VKtEgOC92oDEvyjs2KzOIHObUnIeL9pE/MHyY6zT/TI
         0KF7oTO7MCVsxJKtZ+Vy/2t4O1io0FiReRl8keVNLBRzw+uBb56XGjP+/UEBvhZjxxyL
         1hTK8GBqYza3VL8NFHXoXCQ+K9b9dAnCsjb4r9JZrFEUOOgwV7bwWeNfoJuXJ+A8Ai2P
         l+aA==
X-Forwarded-Encrypted: i=1; AFNElJ/WicEtKXA972E9MAIAhtFCP1opXpvgKI2qvzVD6NFdnB6vJB9NIQNwFVromp37Y4T9wHPIv2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bSWMD08p4fz9UHOq32cxr8X8aa39IZflg7Trj5CsE55b5As+
	Gn3oBYSks3iCHBr4CxlzWX/eBo6ielr+HNdqYyy8Ulk5ihFRWmNQL3bis1CpywOxIFYel9w9KTq
	hS8KqkhHQgDFfKw==
X-Received: from qtbfj20.prod.google.com ([2002:a05:622a:5514:b0:50b:8994:98e0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5512:b0:50d:6b4e:ea3c with SMTP id d75a77b69052e-50e3492f18bmr10729381cf.4.1776369809281;
 Thu, 16 Apr 2026 13:03:29 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:10 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-6-edumazet@google.com>
Subject: [PATCH net 05/14] tcp: annotate data-races around tp->delivered and tp->delivered_ce
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279148-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6F644147AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: feb5f2ec6464 ("tcp: export packets delivery info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp_ecn.h | 2 +-
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_input.c  | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index e9a933641636e11902a84a595672cd56a551f305..865d5c5a7718dbc7d6db1963261889fd44625bdc 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -181,7 +181,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 		    tcp_accecn_validate_syn_feedback(sk, ace, sent_ect)) {
 			if ((tcp_accecn_extract_syn_ect(ace) == INET_ECN_CE) &&
 			    !tp->delivered_ce)
-				tp->delivered_ce++;
+				WRITE_ONCE(tp->delivered_ce, 1);
 		}
 		break;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 802a9ea05211f8eab30b6f937a459a270476974d..0aabd02d44967dae3e569702f76037beb45e5de8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4453,8 +4453,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 		   READ_ONCE(inet_csk(sk)->icsk_retransmits));
 	nla_put_u8(stats, TCP_NLA_DELIVERY_RATE_APP_LMT, data_race(!!tp->rate_app_limited));
 	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, READ_ONCE(tp->snd_ssthresh));
-	nla_put_u32(stats, TCP_NLA_DELIVERED, tp->delivered);
-	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, tp->delivered_ce);
+	nla_put_u32(stats, TCP_NLA_DELIVERED, READ_ONCE(tp->delivered));
+	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, READ_ONCE(tp->delivered_ce));
 
 	nla_put_u32(stats, TCP_NLA_SNDQ_SIZE, tp->write_seq - tp->snd_una);
 	nla_put_u8(stats, TCP_NLA_CA_STATE, inet_csk(sk)->icsk_ca_state);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c6361447535f0a2b72eccb6fede4618471e38ae5..63ff89210a72fbf5710279c41010d3f6e734e522 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -476,14 +476,14 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
-	tp->delivered_ce += ecn_count;
+	WRITE_ONCE(tp->delivered_ce, tp->delivered_ce + ecn_count);
 }
 
 /* Updates the delivered and delivered_ce counts */
 static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
-	tp->delivered += delivered;
+	WRITE_ONCE(tp->delivered, tp->delivered + delivered);
 	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
@@ -6779,7 +6779,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENACTIVE);
 		/* SYN-data is counted as two separate packets in tcp_ack() */
 		if (tp->delivered > 1)
-			--tp->delivered;
+			WRITE_ONCE(tp->delivered, tp->delivered - 1);
 	}
 
 	tcp_fastopen_add_skb(sk, synack);
@@ -7212,7 +7212,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	SKB_DR_SET(reason, NOT_SPECIFIED);
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
-		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
+		WRITE_ONCE(tp->delivered, tp->delivered + 1); /* SYN-ACK delivery isn't tracked in tcp_ack */
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


