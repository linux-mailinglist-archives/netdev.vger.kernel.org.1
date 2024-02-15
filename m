Return-Path: <netdev+bounces-71905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8D8558B4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6211F2156D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D54A02;
	Thu, 15 Feb 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js8K/d1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BDB652
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960078; cv=none; b=mPSTRlqa2Jnb19BKqI25jSOGOw1hPW2TfgFO/ecgN5z52k+2eftUUuc5Y32L6oyvdnuAhXKgP5En+afhyT29OOqajDqAt6wJiKQISAUHODluLWSwhxFBJ0PcIC6eS++bZwyW/3JFatbZ6T8ZSX8Z/kuZPkKUymN6OTT3LiCILeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960078; c=relaxed/simple;
	bh=u3YmXNrW93kPgX9sghnKjoVX+BGPHBpGQ3MVKeC0XQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEPAfD15/fEBsNftGR6Em7OSjeN4tSPlOdlxI8CJIOYyJwRQBy2MTxtfJyQ2S90wZatACJgv2VQbPHQGPwdU2r6gp/DbH+/uoeh/kn2lB0a+Xadgjfa/ewvzgpglCm1JdGYjPg8913Xqj6EdDDGRHZWKaazfZITfOFVTo5s5d/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js8K/d1/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so339775a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960076; x=1708564876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d5Kb/gnzILyt+JOW+mmzeySwA4csZkwZSsQg4g0JGw=;
        b=Js8K/d1/ukm2YhGCbCOBAgJ95N5MMLt+oRgqXasYNeKy5acUEzJMufHNZRKR05FERB
         SSz0Fnebn6XPOPsIuMfefwIOvLPcRw+H9ztWVR0iFxa7rSsVh5tg7TWZu4Th7tAxO3gb
         4eTYkowE/Z5b21tZG6ESNdiQI97tb6rw8Vg0HhEpuGNJxDdWAGL6bYsrZALvBE3z4uM/
         XrSEjE6IBUmafRyLRX6VuRGAfBEQfsjhVZ0eoelDjZOBerXwsKZbzrtgya4fSsWEzYfi
         /wvU843YUZFZzvoWHb2/fs7pj6MLJWhbopXRjxwtQiogHKpYlu5nb8wpdctWXd0Qevcq
         IyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960076; x=1708564876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d5Kb/gnzILyt+JOW+mmzeySwA4csZkwZSsQg4g0JGw=;
        b=UybNU2KmiUpgtKowhuNCyT+4O9Mg7DNR0ehwoe54arVNSLMIlPNhnNf03A7PpTNRdO
         6uXEiX7C/w2dmglgujujHxm68C+x/FVqZcNsTr603OV0QdyWyf8iJYK4P0z3Hmjys3bl
         Ey8LCvo67ALUPk02syDkZ4kv5syGAS47myylAz62ZFpx/S6wphv8ah5EiVwH6YQyHCaU
         WMTAo0d3XlFIXF/YHh5QkJpM8/XDQwNUc4V3gpDQ3Z+pifagI1rPoXvbyZF2oDjwDfJ4
         xN5BMljVLsn5jF0PaJxwk4+JHhkkaPZe+WtRI7e0Z4WB//lXD5kgTPz4EemjKmlDjR3B
         x+OA==
X-Gm-Message-State: AOJu0YwxqZPGXDN3dg6Oe8w8+Pdpf3hLh/XxMQzh+5Qttob2RCytmeBp
	Cv6tL02pqBOa5zxO788iVg57xXik4lsxGOhictdEuECx1+nkV3bc
X-Google-Smtp-Source: AGHT+IFUO+XqFHTSWUSlk9a82yLI9ywklShRmwaIiaYp9uInZOsrTahoep+zK1LKcvH870dG3qNwNQ==
X-Received: by 2002:a17:90a:6bc3:b0:298:afe1:5811 with SMTP id w61-20020a17090a6bc300b00298afe15811mr377635pjj.17.1707960075713;
        Wed, 14 Feb 2024 17:21:15 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:15 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 08/11] tcp: add dropreasons in tcp_rcv_state_process()
Date: Thu, 15 Feb 2024 09:20:24 +0800
Message-Id: <20240215012027.11467-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
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
--
v5:
Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

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
index 43194918ab45..f89af858dfae 100644
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
@@ -6635,7 +6636,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 	case TCP_LISTEN:
 		if (th->ack)
-			return 1;
+			return SKB_DROP_REASON_TCP_FLAGS;
 
 		if (th->rst) {
 			SKB_DR_SET(reason, TCP_RESET);
@@ -6704,8 +6705,13 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
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
@@ -6781,7 +6787,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6790,7 +6796,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6855,7 +6861,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
-				return 1;
+				return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 			}
 		}
 		fallthrough;
-- 
2.37.3


