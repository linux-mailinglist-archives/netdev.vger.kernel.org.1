Return-Path: <netdev+bounces-170709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FAA49A6F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4B4174080
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E226B973;
	Fri, 28 Feb 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmxXAJE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC226BDBA
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748976; cv=none; b=P4mHhJ2aD82ite6ktfcC5BQjHb0N5YgfVEQBH/AgDahuABXn+eSrNKuP6L7g+kW0yuBgWbZ9/cLDAG76CQl3z6h0PvsWz3WxGvLVtMoirWh9s1rwfCGwZoWvyhlaigg6zIwmWtkMR9XASSbwZWQr1qKfDW15Nbvf6XL6qgEVOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748976; c=relaxed/simple;
	bh=aB13b280MIcVuRc0VxldBo9bZY8SatpOVnXV+GjnvM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GmZ3NfeKXadTAPgDacTw9kb58qKvQr2NmMMEuGVbNaRFcuj35bq7pF+7tO5htV+rImwO8gK/e49mAj/ymJMHDXdoqB3VhgRvkL8lcoK6swrPf5RzECZbaOKgVjVjHBihgHHeHLLS0WTeEqsXuLV12OYey/g0CgiSyi2FQWvFSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmxXAJE4; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4720468e863so57181221cf.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748972; x=1741353772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+sHfABVNcOpkFnI0atmQ4P/qaUHSlV5OBnOnZJOtrk=;
        b=pmxXAJE4WzPQmATN2nl+lNMC/WMDF3Aki4sdCg+iYlKTR72CUn9GnGaQ5ZsydIZ4gv
         BmAsq1/zlww5YScXrCKfHQ2CmpkfswemJhikh+UGx0UJovv0eI12em3szG4o3XUmUeRT
         a3s88GbWBK8FwTzimZmZTYYGRlTdBCgk+1w1yB3Epu27AHK6rssDhIiEjSbmOsCA2UTr
         hocaSJ+wwV4B1PfTkNjrKdDYCOdVJWsc84lf6pqCx3J66kUcbpIcaME2lxcDDDKu7Mwn
         qYBkVYUNYCTR+xS/fNK/LY5anG4UzwS8dyaocojlAdIonkpgoLsSiWl8FHVEe6ELqFZb
         i8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748972; x=1741353772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+sHfABVNcOpkFnI0atmQ4P/qaUHSlV5OBnOnZJOtrk=;
        b=uT8d6dL9xC736dBCacOWrdR/+FnL24bFunozGwMIgkTzzj7gr9/5jy9HBOvYOhC+vM
         L/4gvQtOUcRV45h4hD8x8KqJ1GTIRrViu9/w3vlcctALzxiec3iNvzbs2wU26DP6Wggm
         KRb9aam6+7BM2rqGNs89D7UYLJGQ9Ub9RAEhrc620XBC6RSvfMW+nqnc3gluDITlAqM+
         6XjYYTiRTfO6Hm5dRC6093dbxVkMlIXhr8Fv9gEN9qnU0rn//31iKATjjdjgganTGqjz
         FkYxs4g468UeTvLtQ29DMDBy3SBJXCYXroxFhKknhq1Y/myk9w/3EfGsWs5qESqZ+2Xb
         DPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWRtKlI3Rwjo6pJdMn+XUgNOZN2UkFoSgWDl+AbLDgg2wWw5r8iE3Bmnlo6q67L+UNutpgEQzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6psM/ZBtSoBkS2YBJn9OrUJfOPssQ95YmZUDAkd7jDe+JTdA1
	l5zMhF25A6yrzRgibONpHdE9R3uvjN7DvKfUFj/mBH0mBLE9+zVfx28e/pGyycoI47tMRcyFYek
	vxg95KJX+6w==
X-Google-Smtp-Source: AGHT+IGNhwpDZYXFW186mtVW1hIPqcfXtXXr9aykIaxQ74X6iZdloZfpfOmXWo/Ug/+sR5/G03ei1SDfBBmbYQ==
X-Received: from qtei7.prod.google.com ([2002:a05:622a:8c7:b0:471:7d6a:d806])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fc3:0:b0:472:1289:f88c with SMTP id d75a77b69052e-474bc08ee32mr50845021cf.28.1740748972245;
 Fri, 28 Feb 2025 05:22:52 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:43 +0000
In-Reply-To: <20250228132248.25899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-2-edumazet@google.com>
Subject: [PATCH net-next 1/6] tcp: add a drop_reason pointer to tcp_check_req()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to add new drop reasons for packets dropped in 3WHS in the
following patches.

tcp_rcv_state_process() has to set reason to TCP_FASTOPEN,
because tcp_check_req() will conditionally overwrite the drop_reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h        | 2 +-
 net/ipv4/tcp_input.c     | 5 ++---
 net/ipv4/tcp_ipv4.c      | 3 ++-
 net/ipv4/tcp_minisocks.c | 3 ++-
 net/ipv6/tcp_ipv6.c      | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f9b9377a289740b907594a0993fc5d70ed36aaac..a9bc959fb102fc6697b4a664b3773b47b3309f13 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -392,7 +392,7 @@ enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      u32 *tw_isn);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
-			   bool *lost_race);
+			   bool *lost_race, enum skb_drop_reason *drop_reason);
 enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 				       struct sk_buff *skb);
 void tcp_enter_loss(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d22ad553b45b17218d5362ea58a4f82559afb851..4e221234808898131a462bc93ee4c9c0ae04309e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6812,10 +6812,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
 		    sk->sk_state != TCP_FIN_WAIT1);
 
-		if (!tcp_check_req(sk, skb, req, true, &req_stolen)) {
-			SKB_DR_SET(reason, TCP_FASTOPEN);
+		SKB_DR_SET(reason, TCP_FASTOPEN);
+		if (!tcp_check_req(sk, skb, req, true, &req_stolen, &reason))
 			goto discard;
-		}
 	}
 
 	if (!th->ack && !th->rst && !th->syn) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7900855237d929d8260e65fe95e367345bb3ecd2..218f01a8cc5f6c410043f07293e9e51840c1f1cb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2265,7 +2265,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			th = (const struct tcphdr *)skb->data;
 			iph = ip_hdr(skb);
 			tcp_v4_fill_cb(skb, iph, th);
-			nsk = tcp_check_req(sk, skb, req, false, &req_stolen);
+			nsk = tcp_check_req(sk, skb, req, false, &req_stolen,
+					    &drop_reason);
 		} else {
 			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 29b54ade757231dc264fd8a2c357eff1b2ccbb6b..46c86c4f80e9f450834c72f28e3d16b0cffbbd1d 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -657,7 +657,8 @@ EXPORT_SYMBOL(tcp_create_openreq_child);
 
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req,
-			   bool fastopen, bool *req_stolen)
+			   bool fastopen, bool *req_stolen,
+			   enum skb_drop_reason *drop_reason)
 {
 	struct tcp_options_received tmp_opt;
 	struct sock *child;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index a806082602985fd351c5184f52dc3011c71540a9..d01088ab80d24eb0f829166faae791221d95bf9e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1828,7 +1828,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			th = (const struct tcphdr *)skb->data;
 			hdr = ipv6_hdr(skb);
 			tcp_v6_fill_cb(skb, hdr, th);
-			nsk = tcp_check_req(sk, skb, req, false, &req_stolen);
+			nsk = tcp_check_req(sk, skb, req, false, &req_stolen,
+					    &drop_reason);
 		} else {
 			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
-- 
2.48.1.711.g2feabab25a-goog


