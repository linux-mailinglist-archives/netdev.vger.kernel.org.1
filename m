Return-Path: <netdev+bounces-74807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE018668B6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CECB21728
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0461A1B275;
	Mon, 26 Feb 2024 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQTlvY3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6B1A58E
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917785; cv=none; b=WFl5lxxY5SG8SjtgrB6DjtdcFbHya0UJ/YXhluSNOH1Qli+EBXBdMpq+15b1JuTF7AwOnMCzwYTmbTKSXx05jPXA+Psj1lG4qUiyOQgfSVOKtVF4TpqxpbP8g9XjuuXk03p7DP0zw1yMgx6uQ1N/6gbhoqRwkI0GJuCdwmcKxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917785; c=relaxed/simple;
	bh=9KWQNBOVxs5AW+n0JZ7U/B4coXteYFG+kqt6SSvxAqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdP20jSANPYCYDJ/QqHzkfxLqfs0bR6cp5EAWWnvAeqB79g37kq6Jt3Qodhk4zdCyFeuNWtJ6Ao6uu1BL2ZZhIm0bhHFCJ/+1na9LgCQjN1WoN0FkDr2SWrq9tHySpkqHBYXMRL3KjoFY4g4CMChMIJgS7dIdpins7hAAsFaNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQTlvY3X; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1538605a12.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917784; x=1709522584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfIkNQoYOjYRtCpb4caKAYJhlb1RDFwgkt9PcU2LcSA=;
        b=OQTlvY3Xi8sNYUreOlpe/aS9MbcL2BFE7YPUwB6x82ZHRPx/RKsEuCSc8KfCIWJ0/j
         wQ4y0Q3hXMMACC7OCZnJ2yOavHrVuRnjH8yHs7YNqGa9faDCmw6oR/Vyjx8K/RFe/25x
         YVNpAvDjXSMw43HLRyUIvRfnMMVI92DQxCAZlqzK3h3a6vevgjB7P4GTKsavkjZ3zcNq
         xLSzmlLWDQrrxw2afFShTU9XCk3zoWH+28Db44omp0sp3+RPejF3Y14SCmcB4kJ3SN8a
         ScCQNCttFKChLclewM0k+pyiZWLHulN8cSz1u8UxiI4KAXbSXurOoQ9cy4mKlaDd3KTo
         rPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917784; x=1709522584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfIkNQoYOjYRtCpb4caKAYJhlb1RDFwgkt9PcU2LcSA=;
        b=psKiTAXovfJHK1VckrJ2r24VMsH1TDEPfP8s/zC+vepdX2IwlwEagUXi80PTE1226A
         eNN5tf/s/zdRcr34Ycu9xX1ASXla9hFYvdpi611VFmJpf5BMstXBlKEndPxH++HGZU6f
         3xzoYYCONNphLs4U81thRVipLfuexlIsNxQKiGE59S3ubXU7YeK+IQSHXdy+aBBIkmdX
         DjIAkLCDcr7txrdXeXjBS4AaWX8Tov4cUDy9LI0BO20gadKVUMSrx6WWkEA21JHQP4f6
         yYOSsBaHxsSI8B7HThCkTgfFeAYKp3FwCZeSxLni/YlUebP3k//DXPD64nmq0Qd+bo/g
         Kj3g==
X-Gm-Message-State: AOJu0YxmFUnWz/6uFJt2zUnzjC+lebHknxmQfUAQxg2SH5qCeHylE5Nk
	erxnaS/sKcWMQektFZ3lw3jIcO1UumMwlz0dUomKmSsW6e80PG0/
X-Google-Smtp-Source: AGHT+IHVhjBRllcYV4FMfHNnk6kah5wjRAJQF3DQYQmn/8OBqZvfMtcD5NVJbcNpi+12hvDOw0xHQg==
X-Received: by 2002:a17:90a:c20d:b0:29a:4f60:3f94 with SMTP id e13-20020a17090ac20d00b0029a4f603f94mr7347161pjt.1.1708917783814;
        Sun, 25 Feb 2024 19:23:03 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:03 -0800 (PST)
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
Subject: [PATCH net-next v10 05/10] tcp: use drop reasons in cookie check for ipv6
Date: Mon, 26 Feb 2024 11:22:22 +0800
Message-Id: <20240226032227.15255-6-kerneljasonxing@gmail.com>
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

Like what I did to ipv4 mode, refine this part: adding more drop
reasons for better tracing.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


