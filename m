Return-Path: <netdev+bounces-71902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC478558AF
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6444E287E1D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB910F2;
	Thu, 15 Feb 2024 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1wSFLk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1053FEF
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960065; cv=none; b=YhUczkU1FwsQ+lgCR/8wvVgngfawMA0IyJlQrAcbmuv9B7P9fkpDcoQN+GdPPTBCfHga1ek1RHjkP1CrG2azQPtGk1aQ7qVo6tiMxd1I+wx6D4nt+PNDBXkBeCkYwVseMiMMjPgU7c7km5dWOHKgJgmx1QpAf7TbKZysbnRaPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960065; c=relaxed/simple;
	bh=CovTUO/xvMV3iPdJ1lHm/KXdeKdeQvtPvMtmrbhbWAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrZNktXGwJWsQmcxs0Nr5yE16zAg4GQw/lTaqZ0pF0Vxmvr2a4wcrk+pNKgk4puqfAxbtJnsyKIklHcVAn7/PPaCm9CEEMJRBtHZ+RVTkXR03rjfKik+BTqsn0DfOQ3dE2k3WdRRq8uFC8AI4GArDfao2KpzHK+Ju4MkKLG0/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1wSFLk6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so10859675ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960063; x=1708564863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZoCjUeMWYkLR9bqGJSDfc9DpbUuYSQFhBhReQnhSFg=;
        b=k1wSFLk611AIsXgWRKCPR5F/nIZVyvftmUqaI+jk9kcH5sWzejjb9JO8taX55Sjnot
         5Ea5vdqkPsGELZm9nK/LvexO3x0e/oCgFl0OtQGTtui171ZlQtV3uIxlwRSsKOWBuX3n
         uWS0kUjgKE5jtsyxn3JFtp+Ntt7jyOsDh+R+XQRRq6o8A4mpI8FrRRqv6w1mUhFXOSpU
         4rX0Jx6s+BjLC8lbMPQUwYmCq7ohykrk8XhmnVxw600264I1QHDqqfuDgAStfRERv9W4
         EjgnV/JZdJ+IyTbAlR2NYOTo04E7HK8fj5g2q4nGc/kQnNUenRvxrg+ud9aoQ+jX3b1/
         FhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960063; x=1708564863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZoCjUeMWYkLR9bqGJSDfc9DpbUuYSQFhBhReQnhSFg=;
        b=O6vjN+CifEozcAr5vzMNV3c4pg3yyAJHXqufGOXb0tj10jUw4T9fNELMwUItnH6LSi
         v1iKyv95x9DZ/FEjLPlqfohZ3Kvawrf/YyQc0rnS3QqWVYrh5iSJh9KTGQoY+GLtUsAA
         wvMlMUfKWm0SmlQnf4GTj8KI+6jb5GLFLWgaVPsQremsMWZuog7QodzYxzz07R049CKJ
         WI7wCiC741rPMTY6coblGpIfPtLaBgid05O1/pNLTKZJ2Pcf9iEVzYZw6yLLzodnXYbe
         QKHZwJomzLlpWqU3ZBzzOJknTaQ/E95bRQijOp1VKdE5hIsebLKcmem0OxocOaVsfSU1
         7OlQ==
X-Gm-Message-State: AOJu0Yynty1GJVRcTIH1GqLKG0Q2AUO+KCjSYIdTv4jE0BD+YI0wbmcc
	cUu/AitSLCuuIZsVl2tOEzgVt01NASZWPrtOE8Y/sO6JgPSOLQWz
X-Google-Smtp-Source: AGHT+IHq+1dIYKUoFfSmbuSVEwIkQzqYshP7Y8Ni5NKss44lXixV/NjgCbfSEGn9oa5wOevwtj56jw==
X-Received: by 2002:a17:90a:6407:b0:296:94cb:4d02 with SMTP id g7-20020a17090a640700b0029694cb4d02mr471721pjj.1.1707960062729;
        Wed, 14 Feb 2024 17:21:02 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:02 -0800 (PST)
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
Subject: [PATCH net-next v5 05/11] tcp: use drop reasons in cookie check for ipv6
Date: Thu, 15 Feb 2024 09:20:21 +0800
Message-Id: <20240215012027.11467-6-kerneljasonxing@gmail.com>
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

Like what I did to ipv4 mode, refine this part: adding more drop
reasons for better tracing.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5:
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
1. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
2. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
3. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
---
 net/ipv6/syncookies.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ea0d9954a29f..bf51db679bd6 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -190,16 +190,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NOMEM);
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		SKB_DR_SET(reason, SECURITY_HOOK);
 		goto out_free;
+	}
 
 	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
@@ -236,8 +240,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
-		if (IS_ERR(dst))
+		if (IS_ERR(dst)) {
+			SKB_DR_SET(reason, IP_OUTNOROUTES);
 			goto out_free;
+		}
 	}
 
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
@@ -257,8 +263,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
-	if (!ret)
+	if (!ret) {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


