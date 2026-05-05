Return-Path: <netdev+bounces-284479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMCPDt0P+mntIgMAu9opvQ
	(envelope-from <netdev+bounces-284479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:42:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DEC4D0666
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD4E33038E96
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445D48C8D2;
	Tue,  5 May 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4k5JqbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55048C8BF
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995573; cv=none; b=j4PhQXtcddk79s/4kQ6SvS3MK1nZRQcerjTXoGtvjcaUUvko9wmH8LW4QTXswo1H6hDJgOSZw3CpGkRNKeCL0pPhKK/ItcheNi76LmbHrmtSqkI+SzvkiqKzvQoXrDOUzAIgt+i8yW/ujz9LFZ+TDlrAqDnbJDiEo6B99f+c3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995573; c=relaxed/simple;
	bh=f3Xn5ZlsSHT0ZqSjvlA2MEyNAT+dH2wUeiKXvswljxM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZMEc1GTmS1MU/94cBbCAhEaVJUFVIPHAQNwYmXO4E8EUslI2lMQwIZ6g0xaBZCLIKE8tiziKVkXlVBMPOoHYUxg2rfPLzqT/BAmnsHZ7eqssdw9C9BIJa8ET896EK98BmwcP1wAQVpWMN1hGJDdKNBehcsG3gaqXWzLLq9U1QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4k5JqbC; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ba9baef44cso21097096d6.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777995570; x=1778600370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKH8TXwqQrIhYDxDUsRH6fiP46nbERsKcJC1rrF0x8w=;
        b=T4k5JqbC3+fj5NahXv/fcu8xW3/gzhBhgiyLWgASuVFrJNUYk9aUvEKw4Olrwb4PpX
         f/ZaQLOJlHGMNShbLIcWipmtpFOpfoo9ah0B3Hf0/yyRCunvlagWB9wxvnEpJfB+eN2R
         cgMmRrIdp4NTUbbvdQ2ha2dUrB3/sfd39VtLM0G+synhyinRg1zmqHZ4h4CoRRgw85rW
         t+OkIhtRLZq6sTahAMZ/wweHwvu0pxiRx/kRIbQrgwN8s+Gwa7/+CJUbjKciYmN+H8Zo
         y0yRRWIkuevteTEmLdxJiUE4/hAHEVpHYEFYbYVnPRyjATzY16vKTl6e3hWa2XXvJR2h
         4o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995570; x=1778600370;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKH8TXwqQrIhYDxDUsRH6fiP46nbERsKcJC1rrF0x8w=;
        b=Do5mk1l+ULlINVqF8eAgmq+pyBmSpv+xG+wbMeGc2GbqhKtBFj0hOphf4Io8pX41+X
         RXggjEiLo+0StHZ25otFMj3/uslr8COtZZ4IgUqXyn67/hRKgS79hQs8xc4mad8I++2r
         WNbtTDZa2ad0j5EIx0IaEkhoPnVYBUoUG5VG6dygJnhXep/ha0hyCHplKv0vYnO5ehvr
         FqqHjDg2aJoYTLMDgpjKddQrDcBb4rTKJZnEIOnh3mNys5Fdh7Ro+e5hp2GSE5RyAeGo
         S0+JmyY2pHoG1Aw/GV+jH9AREd3bBtUn2yGGlkBKY5Kh0qE1kbELlVc7wr+FBcOdT/Dw
         SENw==
X-Forwarded-Encrypted: i=1; AFNElJ9k664BkeUbQ7mZqN6gEYaWTs1IM2hUfyzumjpqRR+7bs8TsYRmP4dtLh7iQIK7m9F4e1CNFfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2p+pEeLSDRbHHXEQsKrEHj0YUsfDZSckWehAXOskUYra/f75
	UETyAKItb6SQ+r8X8FXXWhsi5djV4dvFWzicvIJQmHWgGWjTwxVYBP6IBoS6Rvam2cWnA5klmyR
	7Mc6eIp+TxU1MFg==
X-Received: from qvc12.prod.google.com ([2002:a05:6214:810c:b0:8b5:5cb:8601])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:598c:b0:8ac:a6f7:8a72 with SMTP id 6a1803df08f44-8b6696db683mr251051966d6.43.1777995568949;
 Tue, 05 May 2026 08:39:28 -0700 (PDT)
Date: Tue,  5 May 2026 15:39:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505153927.3435532-1-edumazet@google.com>
Subject: [PATCH net] tcp: tcp_child_process() related UAF
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D4DEC4D0666
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284479-lists,netdev=lfdr.de];
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

tcp_child_process( .. child ...) currently calls sock_put(child).

Unfortunately @child (named @nsk in callers) can be used after
this point to send a RST packet.

To fix this UAF, I remove the sock_put() from tcp_child_process()
and let the callers handle this after it is safe.

Remove @rsk variable in tcp_v4_do_rcv() and change tcp_v6_do_rcv()
so that both functions look the same.

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c      | 14 ++++++--------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      | 13 ++++++++-----
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8fc24c3743c5f905f8e07a26fb0edb40fb6ab767..c0526cc0398049fb34b5de20a1175d54942e80cd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1827,7 +1827,6 @@ INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason reason;
-	struct sock *rsk;
 
 	reason = psp_sk_rx_policy_check(sk, skb);
 	if (reason)
@@ -1863,24 +1862,21 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 			return 0;
 		if (nsk != sk) {
 			reason = tcp_child_process(sk, nsk, skb);
-			if (reason) {
-				rsk = nsk;
+			sock_put(nsk);
+			if (reason)
 				goto reset;
-			}
 			return 0;
 		}
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
 	reason = tcp_rcv_state_process(sk, skb);
-	if (reason) {
-		rsk = sk;
+	if (reason)
 		goto reset;
-	}
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
+	tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	sk_skb_reason_drop(sk, skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2193,8 +2189,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 				rst_reason = sk_rst_convert_drop_reason(drop_reason);
 				tcp_v4_send_reset(nsk, skb, rst_reason);
+				sock_put(nsk);
 				goto discard_and_relse;
 			}
+			sock_put(nsk);
 			sock_put(sk);
 			return 0;
 		}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 199f0b579e89cf25689e74a8d37bb0c022a6c92d..e6092c3ac840bdc1f62d4435c414e7f79edc10c2 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -1012,6 +1012,6 @@ enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 	}
 
 	bh_unlock_sock(child);
-	sock_put(child);
+
 	return reason;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709d7b89f376f79b71173e5f2d8e64e..51583aef0643e92c961fc00f48f1192184d087ed 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1617,12 +1617,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
+		if (!nsk)
+			return 0;
 		if (nsk != sk) {
-			if (nsk) {
-				reason = tcp_child_process(sk, nsk, skb);
-				if (reason)
-					goto reset;
-			}
+			reason = tcp_child_process(sk, nsk, skb);
+			sock_put(nsk);
+			if (reason)
+				goto reset;
 			return 0;
 		}
 	} else
@@ -1827,8 +1828,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 				rst_reason = sk_rst_convert_drop_reason(drop_reason);
 				tcp_v6_send_reset(nsk, skb, rst_reason);
+				sock_put(nsk);
 				goto discard_and_relse;
 			}
+			sock_put(nsk);
 			sock_put(sk);
 			return 0;
 		}
-- 
2.54.0.545.g6539524ca2-goog


