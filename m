Return-Path: <netdev+bounces-70863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF9850D63
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 06:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407A31F245E9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD5613A;
	Mon, 12 Feb 2024 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOEIb8hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F35C9A
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715564; cv=none; b=moXFtqGxexKFkYEJsslcK2kMtwB0q1Gg3Rvpg7uoaopIBcWlyjaBtw/E0s8Qk19Vr17JANzwC/6OgLnG3qdfmGYpYo00XyUh9EcXPXft+EA8nKqJ04SA8hiuIQlH11nSMZ/i2UHQQUfiv8/YXFloFSepE1rad8d35M9fRYTjiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715564; c=relaxed/simple;
	bh=tBBpCX1d2PEb9XWT8hX3Z997z59wdwOgyuiSWDYJPhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQJlC8UUVdsPhcSaVEOhFsVhC6vAtPEp3wOowptkOpqv/Ox8mK+PRZt4D13JWKzFXjsC+J979R9B12LDXNltl2DW1GklcufXresg3wEMaiEwKHA3CqYTkhYJ2c+FahJDcl5qYho6yUHQdvmGcDCSGGzT3WNfjWHpP3BgnjPgGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOEIb8hw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so7638b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707715562; x=1708320362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcnR3wwRFZ0uVl2rER3U5hYQXkGCv0h0x2STc3oL9yU=;
        b=mOEIb8hwyiNaMvH6Ehvv/6w/4kWHG2QsW7CSiczthcUfjSs+nSYn4XZe7L1rs6aKMZ
         YXbFvDdCBHJegeYl4em73WSz4xKx9t1cwv1/8cqQM4jAFgsrFbEeGAqkwyl+b1Z8wuZk
         E4YNL5Vycnwd9bqvePK5a3dvOC++drmMksOGZG9Uv1wt1scf2X8SFaAqVoe7dN6JHk/L
         Ruu3pcptqUk864dPSothW5RoHja7vFio0YOL+XPJnmcZIu2CBx3w5YTJymYb1RImVV61
         bIZYr3LTCTD6QLlf0FQKxf0aYzI+OH0LzU32was1AThqTjDvgIu2iUiFb9wvSdND84Ax
         BVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715562; x=1708320362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcnR3wwRFZ0uVl2rER3U5hYQXkGCv0h0x2STc3oL9yU=;
        b=TrOC1ijs1Iw2326AqBXXlF5oxDNv7wTCZcd8gTob2ePh+16AzUggMdHgleJ+FKTzF1
         jz0+DzZyEppENTAhhelMxssGzbVz6KxjKlT2VVmyubQMJVExhI7JPEb8Ps7T7HX0Tejy
         P0Hqon3G1YlMmh5bzYBEQm17R8atJMhYM4Pqqy80kC/U79g/kflooeQh7ENzKc7+k21C
         j4zON4JuA1yTsZa4Q+CDFFfbGHJajJ5doN782jfaA1PgcQSs65zzF4wUUyhgEq071VWg
         TgqIXqmo07DF0kLdQitNOMqxkXu1j42PKaWj/tg/VFtMnV0fYIWRHkIxUsAOJhAc9WDt
         MDDQ==
X-Gm-Message-State: AOJu0YzE7xXIpzFeRZuORvpvG8IkG6EyC+s8CHysP0KDX1halRD6leK2
	ukLKows76A5XMopei666N/wac8eVuxBlySb3c9oosabx5cYaMKvQ
X-Google-Smtp-Source: AGHT+IFvqRu7SNAC7okXsRO/ARAOMnUywAGcAQhYvX9rflP8o8jtKF1qbkc8D3qMyUQ7nyrjUtNrKA==
X-Received: by 2002:a05:6a00:1251:b0:6dd:8767:2fa1 with SMTP id u17-20020a056a00125100b006dd87672fa1mr6022979pfi.0.1707715562501;
        Sun, 11 Feb 2024 21:26:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUH7wPrTZYtxGontbUlAY4XQZ2h8ukOkEVSMbbDYKCG7inK1wNXEdkx9f14Jttf/A0udmITg8VN4kX9JPe3b3949XpniyBBECVf+zeCJVbaJR+cYGJWe1+GwCwmWIcqjDcszdeagkbTGhdqawiRg7jSW6n/N+saLwigHRgCM5TluFGTWt5ZtyvldjVWDof/DXnROsSyE/ThtD+s/7VYcu8wVP0opnybw4LCx+XRYww=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm4725291pfv.176.2024.02.11.21.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:26:02 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 5/5] tcp: use drop reasons in cookie check for ipv6
Date: Mon, 12 Feb 2024 13:25:13 +0800
Message-Id: <20240212052513.37914-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212052513.37914-1-kerneljasonxing@gmail.com>
References: <20240212052513.37914-1-kerneljasonxing@gmail.com>
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


