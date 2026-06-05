Return-Path: <netdev+bounces-295759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /vHxC6qcImrBawEAu9opvQ
	(envelope-from <netdev+bounces-295759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:53:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540964711D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GFruvWfo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295759-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295759-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19BA43025C21
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D523DA7C8;
	Fri,  5 Jun 2026 09:50:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C63B71BD
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 09:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653007; cv=none; b=QAH8LtpBQEuu85G5atf4YUhL92iY7WrXsyIFro54eUUfjSQ+uWqCBARlcI4YsvCYOvn5Vpj5DZFVnLFJt61DGdvoslZbAUcb9Kp54KYAF8RMHIq3+saDpI1uUc7rrNHNUf0mPIQrSv229GKSwD3s2YNQYIYPpH9AYeX3ockPvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653007; c=relaxed/simple;
	bh=G4+yJM6zWYuFGgB8T+z7rO6dkHqePIEw7sogic09p8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MY6qSxaqqJkxWVWCqQD1BRWWkhGjfbuhagiMp/18kNvEnl7coZ8/oNYO3LyGMRuOlR3FpczaDHyNDbuWdi1R1TBIpjx/+CwnpYtb21rZC+OJ1OH8rvUVyZaJPEB0n6k8geSLe7rSnJ7GfzQsuUspI2DMXsziy0jFPUyCd5hbHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFruvWfo; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf18c30bb2so11758105ad.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780653004; x=1781257804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCw22FSssd23IT7H44f6S6FFYK8geV9IkF2RFmfa8jU=;
        b=GFruvWfo+dp7EsRy4+nRSnuq74EZN6Ha1zJSmsbBP35U1Yf2FuytBzFrg8cfB8l2TP
         p3V8c6PGIhgJSEzOdaAse8eVxHHWZKu0v7dmZqf44hejGbU+eHwfobF0UczXS5WvgWC3
         DuASqOxZ2THzC24qKdQfccjyiMTON4v+94KIWECcDYsqQ+SrzP/kvIks+9hxfJ5WFuvy
         DbhT6DeXz1ttovBhGQb2osb92VD/AtVj+WYNqQdUl6HzJUVsgwFJS2qDf1PKZZT3esBT
         TNrNUZBwXefw5gLYh7XgLHgPRkePH6fQUoj4QK9iY2cW4jD4rhCIMntDR16whrWw1TP7
         XBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653004; x=1781257804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCw22FSssd23IT7H44f6S6FFYK8geV9IkF2RFmfa8jU=;
        b=hdTpXBIiS0XXvX4uMaJfud32ZzXiBZ+UgRLt4jbgYsD2vGGzV4SEouy53y7A5uBeOn
         ArvUSHU4PAPKdK46X2bOvsl8L2TJZsfgWuaWaqi/HlmKKB4n+SVC8x75s3itsanQf1wq
         /xIpDbTbNqoYe70+LNU9R+jjGQCXp4CdDs831oOl4Mu8zginzO5cEaN52ozIgL55Y/lA
         ui6p09IkBrNCkYFKc1ePjFBUxefYrxCb2V+5sbLChHsCghq1tI51V5+jKtcoNmP1TiAl
         tiPfXm52X4g66u2yimnNs/N/+bRtTipuG0BGrmQ1evPf1Kw5s0nzeTe47HPHCvZtRiNu
         JsJQ==
X-Forwarded-Encrypted: i=1; AFNElJ98NbK2SpLcI+aKhPX7Od4m6ZeGhT9tsXNt8lykoOY9Q1REFiuQdh1iWD+QVrwI23w8/j/bUA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNTuIX537CZLhlR0Zul0hvvCOdZictkClcyD7BqLcScuIs1s4
	6l2HhJRZWOo9KlcTFf6zr4SyhiQzRfI1RV1w17pRYb0ha1igAG2L3OvJfZq1qU9G
X-Gm-Gg: Acq92OFkQlYFQ637sC1KUkWZZj4BMosLnmUWu86p2X0zofkuAss+eqEK9tpR6NEoQV8
	QiC2tCx2768Dt+gtgX/YXdm6KtiHxqhdFbdoD1rhu8i6YfiGDYaUfQFcGBelS9UHYKwu4I5lMux
	MumlzsAm48f5m6IRDFzbp9Y3oyjz/zv//t1qKtHYjmWh9SxxTaKRmwBGBSM4MJuY7D1DmZmVBg8
	6tCDRllCA+EKsIF3eWfKL9fLX+bYd05AG9d2NCZfRfdqCabvZxo3Q+Yqdv/Dt3UYoV4tv4syg62
	mqT5koxAol9AdJZATmNHYIaTYPFsbWpgEbcqqWjrMmyhGfWnFKq6qbT8zLRkHZomo3ixqb0RxbC
	qmV8hLe1FthuU4GbkImzT/AwEbL3b9C/kbwW8UQ3HBnEv9jbgsiuIuly66Pf1aQx39jcn/djsNh
	t4SxXzgutOvw1WQCQMcWv+iU7hb2RPDU6YqHUZql1LGYGqTsUYnVfRJAmHnGBoDzBRlKAoTORf
X-Received: by 2002:a17:903:18c:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c1e881fefemr29151715ad.20.1780653003681;
        Fri, 05 Jun 2026 02:50:03 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm115871285ad.65.2026.06.05.02.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:50:03 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Fri,  5 Jun 2026 09:49:46 +0000
Message-ID: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-295759-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:horms@kernel.org,m:brakmo@fb.com,m:ast@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9540964711D

A child socket inherits the listener's bpf_sock_ops_cb_flags via
sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
without it.

If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():

  WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
  RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
  Call Trace:
   <IRQ>
   tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
   tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
   tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
   tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
   </IRQ>

The child is freed before it is ever established, so it should run no
sock_ops callback. Clear its cb flags before the forced close.

Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 include/net/tcp.h   | 7 +++++++
 net/ipv4/tcp_ipv4.c | 1 +
 net/ipv6/tcp_ipv6.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 98848db62894..97eac5fa341c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fdc81150ff6c..7748668dba82 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1783,6 +1783,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	return NULL;
 put_and_exit:
 	newinet->inet_opt = NULL;
+	tcp_clear_sock_ops_cb_flags(newsk);
 	inet_csk_prepare_forced_close(newsk);
 	tcp_done(newsk);
 	goto exit;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 36d75fb50a70..493477b786db 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1531,6 +1531,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_listendrop(sk);
 	return NULL;
 put_and_exit:
+	tcp_clear_sock_ops_cb_flags(newsk);
 	inet_csk_prepare_forced_close(newsk);
 	tcp_done(newsk);
 	goto exit;
-- 
2.43.0


