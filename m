Return-Path: <netdev+bounces-74344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A47860F46
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28333B27708
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6545D496;
	Fri, 23 Feb 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVHV6KDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A205D742
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684182; cv=none; b=AbCL1VLGxRCCH8BJGVRN0Xa35ofRisqwtnODiUhieEKRmqSj0xpncDqBAC7cFLyUJbceMHOXmtTYDgijxrnU9zlnzlgr3hf79DjRI/eUaBQEY0tlZNytQZcNCDm43KDVZfuSfrw7yrIp0nN7jWWFuX6iYr2pIzUv30k4agvHjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684182; c=relaxed/simple;
	bh=1XTETACOo9PjIiHhJnzTywZhbd9iulkh3w2XrlviGeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtx3Pctx2pae6pbNVDGt9Qm4/kLPXzn7EnwHCCzYR/dyMtbG2NlCB4du3GPlGIypZJNuS5aI5DLTHPzvCSRfyy8lxZ+2bjMRgfxoJ8b3+nRu5+C+9rsxFTKRAYt0qKbXXxOdQx53jFLdjck4WLJgB6KTJm3ZZmhTZwyg9XHAAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVHV6KDc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d918008b99so749735ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684180; x=1709288980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCaZ25K8kIjaFoMB5t9hG/x40yLesoIIfEeGnKZtbpc=;
        b=TVHV6KDcMBUClitQz6UezBw5DzpkW4lxNMSYpzfejqatbxgqkQDfjX4lIb8iam6o1G
         nNmfDU3z9ge4HNrDktfYCy3fUiyj3HDH7YkaHZK4lyjIgMStQLkUCa9t8IxHPG7sUlKg
         /6orAYiMsDpYxw7WhOEpcuS0jIB82syqzlR5LqByR/2hk9tWips8WG8iTaXFcNg4rJWb
         l8oBNcMcGejxd4GsxNoSYlobmgbdFH3gDueLo+Rk+V7bWvdMpBgE8IGSNeLr9KlvN0s1
         hYjUcxgPrgs2gM3xxvVM+P22GtX9BNx2GONvIwIR9Ktk/DHCa7+nWkOyiQpKzwus5oE0
         JJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684180; x=1709288980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCaZ25K8kIjaFoMB5t9hG/x40yLesoIIfEeGnKZtbpc=;
        b=PlZvYlbdv0mh5fghTRu7Dr4xglH9THlftmJs2AM+fBaBrVnOJVqowM7xawRvIeTlPX
         toC1iabL6QVSGXQvWVcR373t2fUs4b0UJjTobrVizj5/5TCrpam++gq+TjntUvPhEEad
         IJ+LaX2KEblqK8ujWEkRer6awCHJWwX9A4Q5XUQ8FioAYyrO7Ht8Q173m5yVPyP8YIU3
         Y3aON7uTFaBT345ThZjJqmwRDo7T/2TbSxXmo7CeyZi95m555iN8ShXLojx0uVUlMHrW
         cv+AJmbk8bqTaZkOYJzpQdXv6oMUsUns6J3/iagTKnh4/I9lGfgC4zq5SFk1dU6ZhLNP
         7peg==
X-Gm-Message-State: AOJu0YyjSKLbsrLtBL8DBXFWMuCukpVYJyyomyTxv8+52R9/1YLE8wHj
	xyEEfgXxvG0I1w68zpyjwm52ZhuQ2x5i67iC8xM7qnj6NPHG5Mwv
X-Google-Smtp-Source: AGHT+IG8oYcb/dDTveFmroYN0rrDgAz0QMJsj7IKoBIFI5MuEVWaWgLQDtBCUlczcJLmyMKMlsdtNw==
X-Received: by 2002:a17:903:230f:b0:1dc:248:28d2 with SMTP id d15-20020a170903230f00b001dc024828d2mr1532872plh.39.1708684180193;
        Fri, 23 Feb 2024 02:29:40 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:39 -0800 (PST)
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
Subject: [PATCH net-next v9 05/10] tcp: use drop reasons in cookie check for ipv6
Date: Fri, 23 Feb 2024 18:28:46 +0800
Message-Id: <20240223102851.83749-6-kerneljasonxing@gmail.com>
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

Like what I did to ipv4 mode, refine this part: adding more drop
reasons for better tracing.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89i+b+bYqX0aVv9KtSm=nLmEQznamZmqaOzfqtJm_ux9JBw@mail.gmail.com/
1. add reviewed-by tag (Eric)

v6:
Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
an indicator which can be used as three kinds of cases to tell people that we're
unable to get a valid one. It's a relatively general reason like what we did
to TCP_FLAGS.

v5:
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
1. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
2. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
3. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
---
 net/ipv6/syncookies.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ea0d9954a29f..8bad0a44a0a6 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -190,16 +190,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_SOCKET);
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


