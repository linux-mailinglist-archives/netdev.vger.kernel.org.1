Return-Path: <netdev+bounces-74806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E6E8668B5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64149281842
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8DF18E25;
	Mon, 26 Feb 2024 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3CEX4+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA719BCA
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917782; cv=none; b=NCenIdUsEiqfcflt2+zPkXG9go0FMMx0i/hARg/xLdemb5X62s7f770moW9vYRcNQCZ1iWDwuvDhxL35OYSR2xYj0EKJLs23QmKUDSmAcTKz0dOK5xzl1zaX4/cgnAr26YMSCFnTjqUhUipLiWeeInZR6HJlX011fDogeh0TA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917782; c=relaxed/simple;
	bh=gH/hkyJfT6zdVSdzb7cr6no12htyjX3oawFQPbDyKbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtF2enuAmOhqZtXqqGbFuz0y5woRyp1ltYvuzbUyCElgJbgmdiDhRX1pxKnP2XtAd0ejSmmAtq2SiqcAM216FEQB3S4ZHYBjED5AH90Bl3PnnYDUH7g5eBxmyqOzILGsiJmkZBj9UDZKnUW90zsFmlOKIDif9D7iSo/fq8K/nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3CEX4+V; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-299a2456948so1600501a91.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917781; x=1709522581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2vlajGrlnwSJ/SyaM2EvXqgpQHHf+iBOrg05aAk/GY=;
        b=l3CEX4+VEvz07rmqc3BdfHOv408J+wbHPIGNvnRXOmn67GeY3iOgQINOXfmoXARUHk
         2LSHVML35FPP5VpiU78swxy/UsTHDXsk5IH9FHYJUHIlIIi4IYUgl9S6oVWNFk4xVoUm
         yea8iRVuNJDn84gGe6j7F6zdR+yoIgQ1MUYNY1M6yTdlkA5MBGLZ6arbbI3bikNVLS9y
         svRo8Kg4bfKlph0VbR6VRB2nDHG+DrmrLyDZnoT4jd3JJrXa6bGD+/wYTWxe7cjBttNy
         EX6/tRhE/Tf4fDpLAf2D4m+7M3XguBfVIA6jNpC9EuttJDmzDSo6h7rX/yu/Sarl1+dn
         SQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917781; x=1709522581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2vlajGrlnwSJ/SyaM2EvXqgpQHHf+iBOrg05aAk/GY=;
        b=EoBCVoXd/eWk+s9mBIuj5Uv1Yk+jLu4rWWsEYzY2mSdvgAP2z31KlilpGMUcNk8hpI
         5YVZP7hm8+mz3oaTGYs7GQG43wrslvf8liEp+dOydCdNUbnLPq22NCEp0FW/dfsm+E1/
         E6TXppXMZ3w7rl13VIL3sqOjVOnNEdgE0CFrJnC/EeKK9W+VlytwFNTKHhzzrYyzLVdM
         sH/+X1zaGnI9/iYG26TQGgP/aZ/NMVmyLZyz1fOBlJbAJzp+bVMBEkX2qmZwOsf4KSyI
         OVyUnvcm76ezYodcH9Ui9DJ+FexBb0w5TCZKn4wGkM51VfDizk2BEN2M04d+SWyRWsVP
         WNSw==
X-Gm-Message-State: AOJu0YyCriUlNy8nhobGA26knhXk8koV7ZnroSoqqWoTbq/ukz57Rg5X
	09jGUgQibaYBBxLwshHYA+37lop48lvMX0T5adzVE0nvfODan1Te
X-Google-Smtp-Source: AGHT+IHgvMN0c9DJQ4zE2VOi3vGPi1ZTeMZF1HKAp4TY5U2i3T6gFB92GppqXpIVTAdls5ax8Nl/lQ==
X-Received: by 2002:a17:90b:3652:b0:29a:ce3f:e26f with SMTP id nh18-20020a17090b365200b0029ace3fe26fmr119141pjb.21.1708917780836;
        Sun, 25 Feb 2024 19:23:00 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:00 -0800 (PST)
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
Subject: [PATCH net-next v10 04/10] tcp: directly drop skb in cookie check for ipv6
Date: Mon, 26 Feb 2024 11:22:21 +0800
Message-Id: <20240226032227.15255-5-kerneljasonxing@gmail.com>
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

Like previous patch does, only moving skb drop logical code to
cookie_v6_check() for later refinement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89iL8M=1vFdZ1hBb4POuz+MKQ50fmBAewfbowEH3jpEtpZQ@mail.gmail.com/
1. add reviewed-by tag (Eric)

v7:
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. refine the code (by removing redundant check), no functional changes. (Kuniyuki)

v6
Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
1. take one case into consideration, behave like old days, or else it will trigger errors.

v5
Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
1. avoid duplication of these opt_skb tests/actions (Eric)
---
 net/ipv6/syncookies.c | 4 ++++
 net/ipv6/tcp_ipv6.c   | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index 57b25b1fc9d9..0c180bb8187f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,11 +1653,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
-
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			if (nsk && tcp_child_process(sk, nsk, skb))
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
-- 
2.37.3


