Return-Path: <netdev+bounces-71900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2920C8558AB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB031C22D01
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3431870;
	Thu, 15 Feb 2024 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIWA0i7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4741C0F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960056; cv=none; b=YiSu7BL8M/dAyHO+kInA1u6n4443C8Rn0IjHOk4AZjzGDejFP19zjMy5RnIMGJpPhnk7cu3ic4Gay44KRWayMCfWyjBFey52hdOPTCNYxCYbfKh4B0rAtwoFrixDcCU1+5eALCCjzL+NK2rSffw81o3docFjBr+iPyx4kYyRXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960056; c=relaxed/simple;
	bh=r6j+a2WZGjfHedoPNFiK6lfhvRNmqawuI332kvdSekI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWOsLFFKrgvzPnrNkTAx4VJZ0yV8D6Sv/w8/ymQW2ahicAoUzs4rqo2NsmDcxeOxcyq8W3Dz04AbS3vdOXcSx/bvcK3xyvzHgV9blNT8VIOA9VB+lnHXA1cG1zxyYV8+aIUeF9BsX76+U9BrcstVWZ+JpUzzFgoGptiAkB5LwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIWA0i7F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-298cc60ee66so322862a91.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960054; x=1708564854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNg/mumsbnLlLgbuGQLZQkzF5VbcxQHBWbWV1KN0ow4=;
        b=IIWA0i7FTK4Gu/WEEb+Pr5EBo4943+Ai1S6TqjugqQO2ueu6pxc7K59vdyTccKc2c1
         SkX1DcC9694A2bSIhZJ855p5e4Oo8cqyRDN5eq2Y3wl2Qgqgq3bx9xjJ7ZN+Mn6qHgl4
         5+Nde3oAKcfNXEv8zbM582qWa06i0Qf7eD7ND2JpWZ/pIcYSjuGgo7MhQ3hCmDRpnGFs
         aN4MTcPvKEIKsKKDM8hb/55HcfeGoKf9t6zaSoQjXs9Tl5KpSQFjI5WcZRAY7++iKd4c
         FFrtDXvXcIof6RNd4L+fCjByEWt90Rh8pb9wY3rgEJSiH3qR1ffoGONGQOWU/+rA2nx3
         8+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960054; x=1708564854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNg/mumsbnLlLgbuGQLZQkzF5VbcxQHBWbWV1KN0ow4=;
        b=p/g3LMw12K3HdmdQbpSyEe/yy+IMkLZI5xbkenT5xTI+HXkyqJGN0T9D4ua8I7ksug
         SUevTHMw75BGN075cbuCdi2P5rpkdkVWB3eGt40+JetihLcBZDkssTmYLDCYZpRmg/KP
         LVDS3N8de7GF7PXp9quWhfgUU22EuxSMHm4JhDp3otB5pe8JH1Kz+/xe1r6GSGxJazYH
         FwDeWT2Ncbav7nnGAVtjL6Z/pAT8l1hQYrnX9LqwA5mXa8niIKSBIpBADvmUHheXTqqm
         edV8UPCzr21HwUGIeCxMQ7wOWgxe3zJxGfFC0+F7wXtfEjyu0nYfzUt2zuz5x6XT3Ei2
         nzxA==
X-Gm-Message-State: AOJu0YxsxRw6eZ2gErp6j59wQo8pG4rv+kF+KS8t+ZHmM0Xe+xROVbfZ
	YsRZ2HTACK/YcNaDYB4/AeS5cijolvanfbeqpjuobv8dLT/38vI4
X-Google-Smtp-Source: AGHT+IGjqCRZxOAIiDE6NE+6zktCQn7TK5M1lDBI8TT6eqWQHmev3QSz6ITAWH3tFmuJ6FgVyrJ1pw==
X-Received: by 2002:a17:90b:1d8f:b0:299:471:9713 with SMTP id pf15-20020a17090b1d8f00b0029904719713mr183302pjb.11.1707960054114;
        Wed, 14 Feb 2024 17:20:54 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:20:53 -0800 (PST)
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
Subject: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check for ipv4
Date: Thu, 15 Feb 2024 09:20:19 +0800
Message-Id: <20240215012027.11467-4-kerneljasonxing@gmail.com>
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

Now it's time to use the prepared definitions to refine this part.
Four reasons used might enough for now, I think.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5:
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
---
 net/ipv4/syncookies.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 38f331da6677..aeb61c880fbd 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NOMEM);
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
@@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
-	if (ret)
+	if (ret) {
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-	else
+	} else {
+		SKB_DR_SET(reason, NO_SOCKET);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


