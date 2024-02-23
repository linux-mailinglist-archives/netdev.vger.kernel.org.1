Return-Path: <netdev+bounces-74342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C2860F44
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F251028600D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5F5D470;
	Fri, 23 Feb 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLBHrOhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C785D46B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684176; cv=none; b=VgxVQJ2qPfazwYr0rWwmaY/y4AGHbf9aBiMK82mPHWnmnUiO6RYTmI8vrYDYMb8Xsanv/isHNpk6JFsabCAmkttehROyWv2wbOB7RlDstT/cGlSumYGfHtX3BIaM39vdOKvL9yOktRJuEfZVNnVApMZUb66XejgVKyCDtirg62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684176; c=relaxed/simple;
	bh=TGCErkX8iQOMN9LkaELEW8hioL7AtJCV85UQUvVFmFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZb6SnguxIfV7eSrkwz+masO+EKX7Q6Zrc+7qIMNMyMX5uuLGnrsMlk45FpZZW7/VYvMS9kvLxDb2G1hSFEBygj8eyg5ujT3lxAvhT54XeqazGwgbiKPYlzyq3eZSkF/QcE3boBFleSBAOHsS5UJHZsmqDgjCWke6wHo0yZmGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLBHrOhl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc75972f25so70035ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684174; x=1709288974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt7qqkAKaDUJR7/ka49EJkc/2UvYhaHsVUoYcqGxyWY=;
        b=WLBHrOhlW/SczVT8Pbm3zhCVokQGK13uw4J6exiebPKSukjqQc2cHmLHPAXbfIp9BJ
         uklFz5vDNP+RktVGTcmpn9bLlGHg7h/pBHFzgeUP4bbxL4i/fzjDqd0Hm1iPTjtG4h+R
         6S79L0uR4SpZTYZM+mOJcCf2cG1GJQ+VZUUBPSD0XRhWa4BmAqsW2PNlLe1GIM4Rg+b8
         dajGSSS77wAcfluCQcIXObjtrlYVqyF1FPq/7W7ibIhwNq1986eMs0sHNLAP2VTkDli6
         BQY26APOgzmqK+lJQXCDjXNtIU1nHVvfI3CPyIHZCNBIbXqH3Lb8PbEi9+qliS4NwzYO
         nAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684174; x=1709288974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt7qqkAKaDUJR7/ka49EJkc/2UvYhaHsVUoYcqGxyWY=;
        b=NH4+EQtokcDgm2e8K5VqjWRFX+8k8oNKsIz9CCrQWgVrUlR1ZH0u2xICS1hfrze+SN
         8lzrnjAkJJUshH8CsTnfV/L2CgQKI973Lr6wAQajSY6Ipi5Bufz9B/3IfaLYx/J6mJkE
         fUD7l6B8en+3K10mCuxFlRZYno6y+aEncqBJ7tpRevBdFmjofHxbUuLRUZ4n5/6+BzBf
         XOqPDJnuSHHZHArrHGWeHniWf0JMEXATLoTt4SGn/3BYMVhAcmJhQ5P/9v4BkssGgRxQ
         D9PnqovJ8X0e0Wyo1KjiLStoy1HXRgX5EoLFScJTky3SRpVS1dpJWbcqFBQE64qpSTsn
         PiwQ==
X-Gm-Message-State: AOJu0YycIo0Piow1kByLkSscsV9RuVyCDAoYjlKdliyS8592g+v4zKsf
	arbnHM3KcgPX1N/gNA3Gmv8UujI3GNePb7TPvoRManVZJKbi41+m
X-Google-Smtp-Source: AGHT+IHLE0Z7H8GBMNs+xMcrZQfN4v43x1TIeG3zKH7ZDTxTDNZwEQWU+h6XA8EL4iaPWH/EpUfong==
X-Received: by 2002:a17:902:780e:b0:1db:e245:8c35 with SMTP id p14-20020a170902780e00b001dbe2458c35mr1062354pll.30.1708684174254;
        Fri, 23 Feb 2024 02:29:34 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:33 -0800 (PST)
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
Subject: [PATCH net-next v9 03/10] tcp: use drop reasons in cookie check for ipv4
Date: Fri, 23 Feb 2024 18:28:44 +0800
Message-Id: <20240223102851.83749-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240223102851.83749-1-kerneljasonxing@gmail.com>
References: <20240223102851.83749-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to use the prepared definitions to refine this part.
Four reasons used might enough for now, I think.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
Link: https://lore.kernel.org/netdev/CANn89iLOxJxmOCH1LxXf-YwRBzKXcjPRmgQeQ6A3bKRmW8=ksg@mail.gmail.com/
1. add reviewed-by tag (David)
2. add reviewed-by tag (Eric)

v8
Link: https://lore.kernel.org/netdev/CANn89iL-FH6jzoxhyKSMioj-zdBsHqNpR7YTGz8ytM=FZSGrug@mail.gmail.com/
1. refine the codes (Eric)

v6:
Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
an indicator which can be used as three kinds of cases to tell people that we're
unable to get a valid one. It's a relatively general reason like what we did
to TCP_FLAGS.
Any better ideas/suggestions are welcome :)

v5:
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
---
 net/ipv4/syncookies.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 38f331da6677..7972ad3d7c73 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
@@ -434,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		SKB_DR_SET(reason, SECURITY_HOOK);
 		goto out_free;
+	}
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
@@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		SKB_DR_SET(reason, IP_OUTNOROUTES);
 		goto out_free;
+	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -476,10 +482,11 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
-	if (ret)
-		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-	else
+	if (!ret) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
+	inet_sk(ret)->cork.fl.u.ip4 = fl4;
 out:
 	return ret;
 out_free:
-- 
2.37.3


