Return-Path: <netdev+bounces-71901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7E8558AE
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8236CB277A1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CB1109;
	Thu, 15 Feb 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYhd+cOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B96539A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960060; cv=none; b=HP9eqy3EpDo3wh4H40wcCyWlTc/6++CU2C5kUUs/4beGqH7oe0xWTvRny8U2vfeHcxmwS+iFMORVfUhdc7G4omHHIFBkIFGFGvbh2NYZRHDsYa3puIdh3U2pJ2Mazc31VRR8GE7E0B5azr25cL8nLIygbfwhXFKpZqUq1xHQFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960060; c=relaxed/simple;
	bh=0Lbmqyy24+MoTt8X9lgfhH4tzRMKYG/AQoX9agorMbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBCvEaHf+y76WJAiLZOxlH6q9hzTEIdb6XYsBHNUhFbEnpNEJxzKs+1jnc7UAGoZ3sL59dQPLAbaTdMzhrex9wLRujOCchtEw4EGaEaEvEd9BYDjK4T2J4QcrBE/GDUauDHtaiPzrsNgiCKwthzGGu07BG+KdSrl0zVsX0Rwysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYhd+cOK; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so951815a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960058; x=1708564858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8x85gIKmkaVSOh7Ia3AV6e6qpXLl1ZM81pA0XxL+BE=;
        b=DYhd+cOKWrIQRABUqL8++n4yZQV72KvPmF9bpGeTN2QfAC9ptLrg+EU9vhfVY4yfuN
         eDl062Kbi74U8jKDVaHVuH87DIVSoACPGlPoKNjazvq7qbSTKfj2o/xs6M5S8lJJ64Hr
         qAOUoUBkxWP6xte1RSaPdEg8w0YiTpjp4UN89KSJP9nQSrogoj5iOv49wbN3V2jQBGTW
         Y9uVv+ONrmeXg5K+nDkZH9Om4IoQ9HirD7OOM3i/vbOP4cKmqI/y6j1/o3vQIVvzqRDR
         asRUYJgGXFkDOc6/o78oDbn6slRZHa60RwvBp1Vqf5wnaq1S28V39c8c9vKRqTMfSYWi
         GI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960058; x=1708564858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8x85gIKmkaVSOh7Ia3AV6e6qpXLl1ZM81pA0XxL+BE=;
        b=Kzf5a1fqopzcmvKyupkzGaD07g8dwj19pa1DzTeQg6/+vK9MNHzI/GwBA77vln6CGi
         we2Zc+m55tBFxv1q5Zp/Lzm2A78asM8VUZ1QggWEQ9b50VriiI2XeoFHHo/do/HLDWuP
         8WVaM2L5fdnjbRY9LxHzWquKr8UewTVU5/dVwU1/iKBwK0yRzlVhEDO/U8MxZUvoRIsi
         Rg8OmMfKEc9GhowSptCM139XcgEuJ4LDJxwjTyGIYgDdJPd0+iYZ2OT826ABlAwClAMR
         XtmtBSOoVqkoQAbxtCvAqL6KGNMqzCRCdIyPdtK7omDzp6U6SojMoH7HX4eHd/TpuFUP
         uCyg==
X-Gm-Message-State: AOJu0YzoRSC7PMC5oRsIFX3/1GHGVnjyUJGYtjvUb7L6e4UFZIQaSMue
	09wCHwjlmhytu4gH4++lwbTW11Giq/gbB6g22MSW8hfMmPui51VI
X-Google-Smtp-Source: AGHT+IHuDdOcdYIGRpsOV+bWVCpcMw5mmrWg/+/MjI9sylSqdEoFiGEwkqvGN8xNprLbj4+HkWedlw==
X-Received: by 2002:a17:90a:6407:b0:296:94cb:4d02 with SMTP id g7-20020a17090a640700b0029694cb4d02mr471495pjj.1.1707960058417;
        Wed, 14 Feb 2024 17:20:58 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:20:57 -0800 (PST)
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
Subject: [PATCH net-next v5 04/11] tcp: directly drop skb in cookie check for ipv6
Date: Thu, 15 Feb 2024 09:20:20 +0800
Message-Id: <20240215012027.11467-5-kerneljasonxing@gmail.com>
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

Like previous patch does, only moving skb drop logical code to
cookie_v6_check() for later refinement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5
Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
1. avoid duplication of these opt_skb tests/actions (Eric)
---
 net/ipv6/syncookies.c |  4 ++++
 net/ipv6/tcp_ipv6.c   | 11 ++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 6b9c69278819..ea0d9954a29f 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct sock *ret = sk;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
+	if (!ret)
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..1ca4f11c3d6f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,16 +1653,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
-
-		if (nsk != sk) {
+		if (nsk && nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
 				goto reset;
-			if (opt_skb)
-				__kfree_skb(opt_skb);
-			return 0;
 		}
+		if (opt_skb)
+			__kfree_skb(opt_skb);
+		return 0;
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
-- 
2.37.3


