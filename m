Return-Path: <netdev+bounces-70900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B3850FC1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A501C21AF0
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA54112E58;
	Mon, 12 Feb 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrhRgShZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F61754E
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730186; cv=none; b=bdRTmbGlVby9BJX3WMIl7Eo6fEPasrWjpnmfL2aujPLN0pr8F5gqy6W8ZTHonaN+o9uQzEI6hxjemDNnCLY0eHWKWqOYhgBE+2EPW+BQgaBCZZIMhDxc1Et+dNWs5YSX5IrpiEJPX2PGija1/fyFsmbORZhA2TLzZ6rXelzE6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730186; c=relaxed/simple;
	bh=YGRBws0ozEQI+YF2kX7wkP0n+tjoQ4f/EoxoJ1BSfbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZm9B1c79iy4hgXdXJjn5lpI9qq6GA8F5e+EvMB8GwbF8M8A97aIZwuqhndvf1REbzjwe/mK38nZRfSlkpGViYz0AiIIo5KYZfF0/k08Ir6n1AvFFs+pR4uBQd+mOEnEweNU/SK+qi33Tccc8ELulMikiBpsnmtCqIrQ/cb1HiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrhRgShZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso950483b3a.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730185; x=1708334985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nmPA5Z8Fe3emj9wQJ77Q93CJHoL3XGah4QiULskyFI=;
        b=NrhRgShZCtA9gDQs4Q45RVBicokiG4dGzeF9dZvxk3M64bhLxzyKlQwosSyox8m7O+
         XRlqF8WKjJPA4XhGRllxHLUgwII3q6NiHraCrwDDTow7S9GSiy4SD2vVcuekyJAw2B+K
         J5bcmOafhGPYDC/ZMzBArd6ct/lP33ZHnl5T/qoZRqZadTT5CTWUqmW7bQiqlpiyfEEb
         H+wlAIMJXxuOQdU6dKle7ezXsr0/ZqK+RPZ2VT8CWwIi7aYVmn7HOJCqwGo+WsrfV5GM
         TCftY8EnSKa8OGigyoXn58M/cj0sFg2iflC0AqyTtmh0GhXyAjCljEgfI8XgS2klJvCJ
         w5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730185; x=1708334985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nmPA5Z8Fe3emj9wQJ77Q93CJHoL3XGah4QiULskyFI=;
        b=Pa3epYTWi3b5bQpJlqefuRPjpBSTnarWbVN+Lr/bXDtRRHsa/gJ/GUqxcLBcjmfZCM
         zSON4T4smP9uWnRDZ0M/YjmZ1f1K/0OH+CYCR8/SgNuzqruxKogo1+ag3W8YDtZEoVUx
         Zp7cyQUNFbPgVUa0XDFF/F8XbIoZKsa++FbdwmIdHPsWQxLGeDbxQNpQIUCYa3JhUPo0
         o26pSQqccG8DkEQHxUlUwz0lrJPH15iZniZDFt9TaoVv7EpMlCHyyw9qXnUfW7QQRmy2
         0KWuXtpAy5wWjkFkJNyicMat7naX5H2pH1bEJ2HuEKYC566vNPfl70BCgD4HGdZiGcLi
         7ubg==
X-Gm-Message-State: AOJu0Yz/6kkgz+ulhQ4uJo9ksGO2CMpCR9zdCgO5rxnb8+L9A323you9
	fsiRcckqhYe5ldsYnzYd6+LTBOmfIcMqiF1T2/wjJTyhlZmHKTwk
X-Google-Smtp-Source: AGHT+IFJmRlilaTYEvxwUQQ3W88TCKWOa344jXzJ2YnIYSSodCIIUGWtq4qN2ASgP88kuUm+SDrivg==
X-Received: by 2002:a05:6a20:4e18:b0:19e:c777:5c61 with SMTP id gk24-20020a056a204e1800b0019ec7775c61mr2487551pzb.22.1707730184753;
        Mon, 12 Feb 2024 01:29:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoqiOSyFlD+0ygsj17XbWqp28ntSvwtfCjgFXeNbfQgs+dmdCTlSiPDWIqpTUJtDxo/SHE9pyb5ebhWbhKDWCzdlMAQS9R+g+mHFtoNEXcVfnE2CQOP43cIInDPdV0Jbz/lKp3xpTHsPVAqT9LKPK4d2q+cG6OVhPaBfLo9U9X5jYZlnFAietyx/ocRKSqgT/I607OjehiFNtkGzPzVvW13tiUFpd1y/D6zLizrII=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:44 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
Date: Mon, 12 Feb 2024 17:28:24 +0800
Message-Id: <20240212092827.75378-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212092827.75378-1-kerneljasonxing@gmail.com>
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In this patch, I equipped this function with more dropreasons, but
it still doesn't work yet, which I will do later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..e5af9a5b411b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -348,7 +348,7 @@ void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
+enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bfaf98c1f0ea..d95f59f62742 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6619,7 +6619,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
  *	address independent.
  */
 
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
+enum skb_drop_reason
+tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -6636,7 +6637,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 	case TCP_LISTEN:
 		if (th->ack)
-			return 1;
+			return SKB_DROP_REASON_TCP_FLAGS;
 
 		if (th->rst) {
 			SKB_DR_SET(reason, TCP_RESET);
@@ -6657,7 +6658,8 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			rcu_read_unlock();
 
 			if (!acceptable)
-				return 1;
+				/* This reason isn't clear. We can refine it in the future */
+				return SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE;
 			consume_skb(skb);
 			return 0;
 		}
@@ -6707,8 +6709,13 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				  FLAG_NO_CHALLENGE_ACK);
 
 	if ((int)reason <= 0) {
-		if (sk->sk_state == TCP_SYN_RECV)
-			return 1;	/* send one RST */
+		if (sk->sk_state == TCP_SYN_RECV) {
+			/* send one RST */
+			if (!reason)
+				return SKB_DROP_REASON_TCP_OLD_ACK;
+			else
+				return -reason;
+		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
 			tcp_send_challenge_ack(sk);
@@ -6784,7 +6791,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORTONDATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6793,7 +6800,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORTONDATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6858,7 +6865,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
-				return 1;
+				return SKB_DROP_REASON_TCP_ABORTONDATA;
 			}
 		}
 		fallthrough;
-- 
2.37.3


