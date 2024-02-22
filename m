Return-Path: <netdev+bounces-73958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28385F6E8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BCD1C2301C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC147793;
	Thu, 22 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfx39W93"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB346549
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601426; cv=none; b=XYSOL+5jIR646RAQYHNDI1VjLwQVfEe0x0USypdT2PXo/s8vOENOlXnv8GZPfsmuyodILTfhtLyHXT4R8hsjiKE8lUQuPtmh1kT49/+PbiuH+QwWPnK+tyYl/YMD+YghmoxLcwCnapoRosPgS0ttknTbCsxqx/QhMhoQ/1uYiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601426; c=relaxed/simple;
	bh=owFC83ze/ayZK+Cyv+NZOOKWAKTXJs2Ueuovwxzirhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvMKvagNdngG7IoZlw2Uz6kiZqlKciR9olI0H1+dH6b6uRco3goolAlkvWsCZXXznNx/jYr3c+tx/MVcdyoa4sK25kBD8hIpZ2mq7PfSHEk5LOKEGeHxbXdcGBCJt2EolIJQa8pUw+R7gFYdsapk82JyPYI2v3CKYTkZf5bXf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfx39W93; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d918008b99so64657065ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601424; x=1709206224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQUWfbOp2Ls4pqPY5WRmEaamNhEJ00My7kwA2zz2tTY=;
        b=Kfx39W939zqOLFrbQuvH2lX4Qo5ATsqqYoNOp6lu2PA6dVP32+EoNYExhCBSe92Xki
         o8QtuitBdaJe/Yp7t+AR0Id6JFA2XY/9uRcEnbrFjee3X2+9H0AJ2EBgw7Lid8eEwPVT
         P8PeEmXZRi5Q/cCtzTSLZ9D/DahBvpEllnC7SZdhmvVICrCBSxCQtcC8YehJYM0EH5uJ
         e5ZzGD0oFttpUMKoTLOd/ijnDfEFXgnGn00Nx2Q30EBWWxCNZzl5ihrTSUl77+vox8On
         GZ8q32eleGbPvIxL7HhXDZnBIGXGrnhCTMY+bKAp5oFU72sL1URzmGUneuAcsaaTc8vC
         hEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601424; x=1709206224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQUWfbOp2Ls4pqPY5WRmEaamNhEJ00My7kwA2zz2tTY=;
        b=Px82P4NJH32hIm/Gj16pPFVpSnlYa1z7x1fV8E7ogoGJRvct0q9ZAY2n/2RYAbgGQS
         0qebkHZl/XPWKFbfT/h82chSFBr9pMMq1j07Hgk4Vgcj6Mb+UJ0bfuTWu/nDlpMHnxv1
         9SkJowCmiigIJHf7zPOASZi4esDTo73zupbGssWyTM0L7YmiJiTHUqRiZyudE7ufvJsz
         K+F/Hgsvd80Qg4sX9edwSKs+bZ2gKkFjKKoympV9nioA1mTZuK3hk0zDhc5YT+YZHpxQ
         Ue2LKPEgA+lDbYngDNi9zOKceQjxED4hsQ9vxbmZgUMHsQwJ2HwIaqUCLiIa4kcW74ma
         ntjw==
X-Gm-Message-State: AOJu0YwMa5e75T58zsXxD+laeckbwWB5bl0j3D0SX5f5IQG+ZgBY0XXw
	qbvKkBcu5itSEFThNWDpUhk/JkBy9A2LqNOIkCnWygwa/pN3ZMcbNv20Aryxz30=
X-Google-Smtp-Source: AGHT+IER2/+mgWbOai0GbbiT8DwIwJHxG6phwXA/IyJ37SA/qHqB1sF+bJGCui/EtByV3MU9dNsZHw==
X-Received: by 2002:a17:902:c402:b0:1db:3a22:1fd6 with SMTP id k2-20020a170902c40200b001db3a221fd6mr23669575plk.66.1708601424353;
        Thu, 22 Feb 2024 03:30:24 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:23 -0800 (PST)
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
Subject: [PATCH net-next v8 05/10] tcp: use drop reasons in cookie check for ipv6
Date: Thu, 22 Feb 2024 19:29:58 +0800
Message-Id: <20240222113003.67558-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
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
--
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


