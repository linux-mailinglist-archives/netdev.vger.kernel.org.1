Return-Path: <netdev+bounces-73534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E897D85CE66
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D08B2160D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743B2B9D5;
	Wed, 21 Feb 2024 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjxAasTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29522B9CC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484286; cv=none; b=YVSFOGja1yR4VWbBzKIv5EFgqZNa4qzfTTyyksqNrp4o+maAlHeCzSoj/x8jNgq6IGRgT6dFw4yh8IXT1Mz4ehG4aWlvhvgFatxSaFpDHp2H4YSrGcTuEaFkq+3CtgApeeWwmP08jk+m7LouM4oL8vFap4eD8rVvRWnHF3rIro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484286; c=relaxed/simple;
	bh=vrwHOQrkYWZJHHyBK1czZNZtq4kCFj/6UeI03PC/L4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eK4Sr7G5cwb3Wj6ogO/HAd9i1DdXMtzxv6TRka5HtkRvBxLE8OegidEWAdFlkHZ6sei+pGA4qxboD+muXZJg0qIHYbqgkSNjSEx3HXpPSInwXBz4lor+N3fT5tKGApsh9YoxEwosyh6jKFJmJcXEOssXtt6k4BJuacoA8sK+n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjxAasTg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c66b093b86so5171927a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484284; x=1709089084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8iqFTRpqy3PRXp8DiJCTCYAi+UJa4eByPGTpJmMuc4=;
        b=DjxAasTglPJUtTw8XlqEOfZFcrfPAgoG3xKoN9fOV8b2ScuvXAstNEpEzjP7E0ogSz
         s/UaeTLZP9VrzgGMuftc8mLkugqMiwHuh5z6QAVNJrSajEHKlkJWnBGShuMN3+bIBmyC
         QX59fSLhYEDBrdUnM2XXWv4iuBBU6fLHtuRGuasUVV0q7lUndTT33avQY59RjO0hWSem
         9l7Z7v11OCvXLNrtP70OPqHjPVtvUNpqvmfVGTwR/zbhVOLPOCrhqdRgo+XgHIrSb/tf
         g2b95rwWsCSfJPNmMktSZcmC37pUEKT2F4bgOqnLABj6Ky6/Otq55+65mhYbqFz6G+hn
         Rr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484284; x=1709089084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8iqFTRpqy3PRXp8DiJCTCYAi+UJa4eByPGTpJmMuc4=;
        b=FiMMZFA1e0oMaouvYuZAwE6JlLE3hoGWUn3Lvomyelp40ZMPEFDzd/82emUUtG7LXK
         H/hVEPnQ/at2MKyaF3l4vyTce5piZLEqo80T60IDWtJke9VLGeTw0D6Fv450xiNp95Pz
         aJMixNRnmpGpNyMYNplK+vgQhyZG33qxzMX3iBAik5pxWQOXHhK8Ians6pQ5sRbTzGnf
         c8+tVHWsmM+YCC+9cXgGLKFi5+MWPGm9Zo6mwrziYDCkm+69z909MEyRym3M1YzZJEQw
         DKvVjT3hzW5SGI1GU552A18HK4M+ytWxQVJxjg+AWpwTIdPKcBFXifKgGL5PgSvPiNAV
         jhcw==
X-Gm-Message-State: AOJu0Yyuh0IwU1klYbCWig+W7FwNwtr2CQqituJQMXH3+PGGSzThtZ78
	6gbXXfLXyFKoIyEsjclxezw1lVyzxfM0IxdQlEYfkU0SdSPYtz1c
X-Google-Smtp-Source: AGHT+IFKbJhFUXpsjpdJM+KXp7FdH5uze13dy9eguGfaFcmgJ+mNICTKfMd/Buu4ubUj6poxN4Qv2Q==
X-Received: by 2002:a17:90a:bf13:b0:299:a5a7:7579 with SMTP id c19-20020a17090abf1300b00299a5a77579mr9475642pjs.10.1708484284062;
        Tue, 20 Feb 2024 18:58:04 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:03 -0800 (PST)
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
Subject: [PATCH net-next v7 05/11] tcp: use drop reasons in cookie check for ipv6
Date: Wed, 21 Feb 2024 10:57:25 +0800
Message-Id: <20240221025732.68157-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
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


