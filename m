Return-Path: <netdev+bounces-74805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8818668B4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF58281ECE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A168179A7;
	Mon, 26 Feb 2024 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2LhFExo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AC18AF6
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917780; cv=none; b=iHOEprWCmRxRaac3UqexnPh9h3yfGNmTcWsfVwEHAn1pCzKRKWxD9yMl/Vrx7hAgvahPHWSC68sw8peyTWvNhEN4AhlBm9Qu1+v3/mpzLIIzgOiMRXE4ooirm/xsGsURnuWQrq703DIiPwOu4KNHva86aboKTNncqwgIx01bn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917780; c=relaxed/simple;
	bh=RTEfjOJ+/4ucfYlh06t4QOIdeLP8sTi+N1Pj3CXctfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IM0HS8LXJtFnJ5w1R6a9WQFIUqygPzyk5WLpCvJdKm9mFr4pO069hBP2NQAd1vpO2HlSGZ762NR8TK+QRTL05b7fjYaoHgZzoD9521DAJOr/joQFmZm+ZcJ11/E0QcQ8YMnJCuQ5/+oqRO5etgHE4bPSMRm66bzIrRn+kpsNB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2LhFExo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-299a2456948so1600490a91.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917778; x=1709522578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K8MZgEXV+k8WfP9MgcrMCUWIuACApKPPtdyd2KNGTY=;
        b=T2LhFExoDMPkSOB3BOQvf6IgoaqNSVlJjMeRM9pTlA30y4+92x+xArgCZ1fgDvLYtT
         iT9CjZQ27Sz5ZRx1mLZWmaUa8EnnR3ktTB2by5bHnrEwmWqZI9BnxvomzgDpPEudLj0J
         fecbgxAZ0grlMRl17mgfiaX2dJoBYyqBDiKRaXKVpwFIf/K4u0iw3gxTDkrdoj0+9r81
         gPlu2qUu/QE/ok14RXrMD3nSle9hEqqhU1Lsgco99VLKACsJ2OrtkNMvpDwtKTIBqIzw
         hWEx3L3AdVbuCsH0Ik+Yyk4pgJpulXsj0R1WhiekErjRXZzLhG8kb0YwwiA4/rdVLT2N
         lv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917778; x=1709522578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K8MZgEXV+k8WfP9MgcrMCUWIuACApKPPtdyd2KNGTY=;
        b=Db2cpWbsfjPRa2vAHarxQuMGoYzmTRXcXwzwUd5ur+5YTwgm3d3fQ8AJUm64Mzwtet
         2nx3mWhhddNtyPple24PPxLGyWR8suPY9q7OuUJCyslKng3SU+SB1yp9ICMtc0LvCYqC
         xidAVmbQFnWoyef/R7LYnrvktCM/LAI6lBKAstxPj2B74OrBo8iVJbLDe3tYSw4EA1UB
         NgAHDTNgZ4ELFSJ+52OlAjw+UGJooQiO07xFwpV6IMq+Xu1RTc6FWgnvs65XErc3kdNz
         VLbQpBkKQKXtuXXu8jcOiGnXXaJqjJ15teQ8us4Oszu2DB74ry53b55V8ULtyzfgpann
         dj/Q==
X-Gm-Message-State: AOJu0YztuS1OAAsgWouwxsrAlKlX6300FLM4rASPpac6qcvtbpa4HTuy
	WW+N5rW6JsuWAsfWgShs7azY631RzrXOO6wOL8l1cN5ki6cqyzwu
X-Google-Smtp-Source: AGHT+IG3IY0WmzekizlC6IXzXnhFfAZQUPCwScSqEWESRzgVPRA+VDl4vmcU7C4Z1WByvc13uZ3OfA==
X-Received: by 2002:a17:90b:484:b0:29a:638c:620c with SMTP id bh4-20020a17090b048400b0029a638c620cmr4597823pjb.43.1708917777810;
        Sun, 25 Feb 2024 19:22:57 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:22:57 -0800 (PST)
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
Subject: [PATCH net-next v10 03/10] tcp: use drop reasons in cookie check for ipv4
Date: Mon, 26 Feb 2024 11:22:20 +0800
Message-Id: <20240226032227.15255-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


