Return-Path: <netdev+bounces-71385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF66F853227
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B621283ACF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3C57861;
	Tue, 13 Feb 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuL4YeWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8256B65
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831778; cv=none; b=QTkxLH18RKY1KWBZTGkJfGUfJlZ3nKonvFAtHx4I5T/Q5xYuEgzEsebkaeOSxLMxnMfaMiEXUC6vBz/1s75CaZUhh1QIAMGg7EpRYqZxmgdk1wtnlKQTniNSKwn9URwG43AS1DQpN9KFXkFRfRNuc+dZZp1Ac/4xxRpck+3bTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831778; c=relaxed/simple;
	bh=tBBpCX1d2PEb9XWT8hX3Z997z59wdwOgyuiSWDYJPhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8Exrnz6iD/rY2+iRbVdTs7/PTHCubDS5/Gvmve7YIGd6/Ztej01C3MfBiqJ2RJiFzALwm4bHpB5R/Shlogs+bD8nGsWN64uZYz6F70eB28lSfi6TofuBbGY9YMBXcnzEL9OA5c2OhMsAZDhyT+0Ibfvf3wNEqjUNchl+4U6wBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuL4YeWv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e06c06c0f6so3078141b3a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831776; x=1708436576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcnR3wwRFZ0uVl2rER3U5hYQXkGCv0h0x2STc3oL9yU=;
        b=NuL4YeWv9qvxZs/hgwD4UzPN4Y0iIse42zGQ3apqLwDwrtNeWPkgrWGp7BgAyfmBHW
         GM5CUiQPSJn5opmz9oSuJMXbcv8qfMDhwP7/Wlx7TFWlUdqnb2piwfE8CiVKjnrMQEa6
         S+hlx7dIehlJtXL1hb2xLTGXY4RcGyRsz34Qb6ZqqPtUE7i8NLLU/wo94V9wQJAsX3IJ
         WPfwMcuZBJA9/T20+urVpRCpQmUTaQQMic5pZShFWNSTIP3ZypCKyAh4ICNyNFJrzM7/
         dIbce+MIGYFonOE9z9eIcOmLnWbG2XCNrkCS2BIOqhl1xyu7vvn8uslKwTQDyKUZRPSu
         wiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831776; x=1708436576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcnR3wwRFZ0uVl2rER3U5hYQXkGCv0h0x2STc3oL9yU=;
        b=LGKzcpcvKBJv+ghz8hZxdzDZkXgSuk4+to/Xn4eAQPR/lPrLAohZ3a8Rz1wHVYGhHf
         EtoRevcm7XaS+6uISrRgUsIKTJodPROBmjqTsAlnKSiw3ZgVQpbK7nwR2OJRhvSNYCAb
         0gX3DPCohqswDiFgi/F8UJmpHS05ZqJ/lgZ4zjTP6oIbStS3sBRX1ByG6BWvPnXdOl1W
         VRx5M7apPjKpGSUTzz0Dfr6LZJkebvP3BIigNk/Jt0aGFKyWFRydA6EpYuUic4ajSgC1
         1xkQWw6fxtz3oUMTf1LOGJrHTXUIbT9OOQqF0WS32xZNMjyFSpojCnU7CJIDq1wZWMQh
         NMpw==
X-Gm-Message-State: AOJu0YwNMmK2I4oLPl2Q1eY5PNvj2MGKy6N0+Oy8gVR0lNY07kvyo5ZG
	qVkbSIAshYZRC4ocrhy38RKInkYGe2FSVRCfH2gpARPsvd5PtlPo
X-Google-Smtp-Source: AGHT+IF7O3zLSQa0oaAcD7XybobgNwL90vUAT1P0QCfqroPWUs7uGP5n+kL5RP1ITbb5UpyWV4vBlg==
X-Received: by 2002:a05:6a20:9585:b0:19e:5e0c:3bb8 with SMTP id iu5-20020a056a20958500b0019e5e0c3bb8mr4177752pzb.7.1707831776463;
        Tue, 13 Feb 2024 05:42:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoBvygFNmKUjykj1h+8lesQ2cYYpd9EqyG+BhFDka0+HCe5fvdhgIGTUxMdzc43qjfvQ0IOiIjynSiZMt0XPngAaFYVLAaev0kwEOeBiVsb7YFG8Nwk4yFpgKTpUUBFYNDqNrjes7enEjm50UFAbuCSxiIJDUVekZCKvhSpfut4uHIIm2rFFxUd5u9Vec4BBlzxhDJHtOpAPL3KDEiq1/dxbX7KiXs/LIViFGLm4hhFcqMx7r0qeH5ZRbPLZ5Ugtg6
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e042e15589sm7323041pfb.133.2024.02.13.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:55 -0800 (PST)
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
Subject: [PATCH net-next v4 5/5] tcp: use drop reasons in cookie check for ipv6
Date: Tue, 13 Feb 2024 21:42:05 +0800
Message-Id: <20240213134205.8705-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213134205.8705-1-kerneljasonxing@gmail.com>
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
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
---
 net/ipv6/syncookies.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ea0d9954a29f..f5d7c91abe74 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -190,16 +190,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_REQSK_ALLOC);
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
+			SKB_DR_SET(reason, INVALID_DST);
 			goto out_free;
+		}
 	}
 
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
@@ -257,8 +263,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
-	if (!ret)
+	if (!ret) {
+		SKB_DR_SET(reason, COOKIE_NOCHILD);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


