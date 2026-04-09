Return-Path: <netdev+bounces-276924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFMeDH1712mXOggAu9opvQ
	(envelope-from <netdev+bounces-276924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:12:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56263C903C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63BCF300C324
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70FA394795;
	Thu,  9 Apr 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WN9v1pK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199639527A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729511; cv=none; b=GarbAcqrUHvrLfPC8nudaZ9KABTUx7mxaqBnZL1EG5J2kiTyxuHEtjCEDdvBbtMucvIMRDF4C1efZWZVCGrJte4zPVFfvXwjUyhkn7HpTkgdgLy7GZRqJz7BS7cJ2HVbQHL80PhA3nm/0d1RG1hsito2W/cgBHrHnUfIl3CGrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729511; c=relaxed/simple;
	bh=nIPqjGkG6TQu79i6M/x5vlhg6SHXJOSsigN0FTYlxa0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cGprIfjIEsea/LLkNhyRaZ233+Cw9H6fmfcYwz9FWE9OROn2x1NCUajDlRxg7LmUwU7//Xd/1n57DJNyZ+VccvdAxRofxFZzyU6YrBYwv0WBx74WDfWFrP+fkxH2m+u9tJ/uvRB8M0/Dkg0AOQ9nocMkayGB0UklBcTAUgQKnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WN9v1pK1; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d68dbb77bso16073751cf.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775729509; x=1776334309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W4smQAEcqLSJsw172+o+NwZaU/uAra093pBg7Pxg5K4=;
        b=WN9v1pK10JUA7wB1fy74V/RPrQWIj+dxoMvP8X1yrdZF48c3BRgKzQrhsStVgDROYg
         6EjdpUyxQKi1s5nQCof30lJyou1EesZEfEJ1CbuYofByUgceSZlj6WieC0dmfe9PDlrv
         YDAgRgP/i175heixUE63uiDG1jk+8MuYy0OcG/SMfMNXkBbFYE/WDQsdZ6DReTu2EXwt
         Sb0llCMV9sX8eWn1DTwQiKuVj7kcs8463WY8pv5d0bdnhYYZnMIxLMyQbebhbqpyJLAJ
         3DBnoGpeFA7aluUNTrtlQjXqU9eRdYqwwPqjIBXImLmJRlWUG+Vba6X03lxJgGA63hHc
         W0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775729509; x=1776334309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4smQAEcqLSJsw172+o+NwZaU/uAra093pBg7Pxg5K4=;
        b=mTYwrjf4p4IJ05/qtpOyjsWYWuKzIUfC3Us6xz09H4OLIM4Wb32DIsD3oaLcPZ46l0
         evAd5Fq9Nf5iIgLAbBxEZ09a0XaFbHnjnToBpq/iwSdb6bGTdKcT0QDoV+y39GPCCM8z
         tnNVGg1m4nV591NIHW/Zg/7V+wX6z7y20c0VPb7pbnmBq6n0GhBtE2zrzWR7bn90y6sl
         v5T20Risb5ijT1WiJOpTN5OJlxrOGNpARMkMQlXoRspsCrcssMpDtlRS8ASodMvtYEwG
         6aELNENky8VsQq5vhdSL6UcoLBocNnZyyioFqmLzQtCaen6CutMDgeLwgz6fXHiUMlUJ
         T5xw==
X-Forwarded-Encrypted: i=1; AJvYcCXl8mBFP51nzgFQ5T3+IH7MTqQE/YB9tkUkcV/8vfy28KhbFQ5YcOk3MREpuL2ASrA7MF1TYMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGqau+ZKD+Ol5T832Y3PIOvSVRo5NT44cBIauFA4bNu8w8V1W
	plG/+JDpnDxm4jJK7VrjaNfq2CrJK3o+lBKrQOpp3sQ7Ic6lUgRVJqlLGdP2rc9+4ulTXaPKkp2
	JzoGEr/T56DVg1g==
X-Received: from qti6.prod.google.com ([2002:a05:622a:8346:b0:509:17b9:4bbb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6906:0:b0:50b:3d9f:384e with SMTP id d75a77b69052e-50d62cbf981mr353487361cf.44.1775729509089;
 Thu, 09 Apr 2026 03:11:49 -0700 (PDT)
Date: Thu,  9 Apr 2026 10:11:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409101147.1642967-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: return a drop_reason from tcp_add_backlog()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276924-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C56263C903C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Part of a stack canary removal from tcp_v{4,6}_rcv().

Return a drop_reason instead of a boolean, so that we no longer
have to pass the address of a local variable.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-37 (-37)
Function                                     old     new   delta
tcp_v6_rcv                                  3133    3129      -4
tcp_v4_rcv                                  3206    3202      -4
tcp_add_backlog                             1281    1252     -29
Total: Before=25567186, After=25567149, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h   |  3 +--
 net/ipv4/tcp_ipv4.c | 21 +++++++++------------
 net/ipv6/tcp_ipv6.c |  3 ++-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6156d1d068e142f696ec9dfff63e3aaebb0171bc..fce4b653c23ec790f561d577fcd6160d3d92e3c0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1680,8 +1680,7 @@ static inline bool tcp_checksum_complete(struct sk_buff *skb)
 		__skb_checksum_complete(skb);
 }
 
-bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
-		     enum skb_drop_reason *reason);
+enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb);
 
 static inline int tcp_filter(struct sock *sk, struct sk_buff *skb,
 			     enum skb_drop_reason *reason)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 69ab236072e7142d5ca9d0703d99f02c1e17c738..c9bbbf32364827d341b4c1fd77617031b0739c50 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1900,8 +1900,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_do_rcv);
 
-bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
-		     enum skb_drop_reason *reason)
+enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
 	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
@@ -1929,10 +1928,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(tcp_checksum_complete(skb))) {
 		bh_unlock_sock(sk);
 		trace_tcp_bad_csum(skb);
-		*reason = SKB_DROP_REASON_TCP_CSUM;
 		__TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
 		__TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
-		return true;
+		return SKB_DROP_REASON_TCP_CSUM;
 	}
 
 	/* Attempt coalescing to last skb in backlog, even if we are
@@ -2006,7 +2004,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		__NET_INC_STATS(sock_net(sk),
 				LINUX_MIB_TCPBACKLOGCOALESCE);
 		kfree_skb_partial(skb, fragstolen);
-		return false;
+		return SKB_NOT_DROPPED_YET;
 	}
 	__skb_push(skb, hdrlen);
 
@@ -2031,15 +2029,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(err)) {
 		bh_unlock_sock(sk);
 		if (err == -ENOMEM) {
-			*reason = SKB_DROP_REASON_PFMEMALLOC;
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
-		} else {
-			*reason = SKB_DROP_REASON_SOCKET_BACKLOG;
-			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+			return SKB_DROP_REASON_PFMEMALLOC;
 		}
-		return true;
+		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+		return SKB_DROP_REASON_SOCKET_BACKLOG;
 	}
-	return false;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static void tcp_v4_restore_cb(struct sk_buff *skb)
@@ -2247,7 +2243,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sock_owned_by_user(sk)) {
 		ret = tcp_v4_do_rcv(sk, skb);
 	} else {
-		if (tcp_add_backlog(sk, skb, &drop_reason))
+		drop_reason = tcp_add_backlog(sk, skb);
+		if (drop_reason)
 			goto discard_and_relse;
 	}
 	bh_unlock_sock(sk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8dc3874e8b9252da60f21ad77a5ca834532e650a..1d37826e8480f203846e963418cfe2085131adfa 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1877,7 +1877,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	if (!sock_owned_by_user(sk)) {
 		ret = tcp_v6_do_rcv(sk, skb);
 	} else {
-		if (tcp_add_backlog(sk, skb, &drop_reason))
+		drop_reason = tcp_add_backlog(sk, skb);
+		if (drop_reason)
 			goto discard_and_relse;
 	}
 	bh_unlock_sock(sk);
-- 
2.53.0.1213.gd9a14994de-goog


