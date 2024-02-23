Return-Path: <netdev+bounces-74343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5C860F45
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3A91C21C09
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF365D48F;
	Fri, 23 Feb 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/NXET+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB95D742
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684179; cv=none; b=pvN7/vLtXw9bHP4fT/dal4+kuZJyfYjkkPEZePJ4CBhlrfCfWWQoYlnhHJT7Ob4dD/6qyZaC7m0wTnLCDW5qWs+P81RRIAvRyg5O58mB7yPfGY/qey+N0MuhENOQLSFwo4Az5qDPoyxzibWRSezx9Q0sEEQQSUoCuUKyvZ4+vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684179; c=relaxed/simple;
	bh=Rgm41UcdXBS07B+ZKVHvQ+vPqWFRLNGFFZv3HOiexsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6XWqkoP2fiVW9zraCXEhn6RN8m4LDNungNuZttoCfxNw/nnRLDIf3r7oWj3+qig+F1OrUr3OU3GRbMSORDRr36sJUgKmQkB6QJnOt7jtLdp/J54x4b61au3V1sCPezIe2KAoZrFnWkDQr6XLHZ0BrEZ7kog0mFoi2ghUyw9k5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/NXET+i; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e44a2e34eeso613518a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684177; x=1709288977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+q9YrFx1+moUKp/BkCodCIUYpDo2u/Zf3Lo0LNX6Yc=;
        b=N/NXET+irE2YQYE6Vzm7iXuTEvh7vUK1jpT7gigg13LpX/RlY2UnO0T5sqUEqIpcdZ
         hijzCkz6IrWwIw8Y1HZGBxeV9VRkWwSCuLNBz0TJ8zxxuhJkFs7+eyOTMKo/agG2sdtY
         HZsMo1EORKcG8ko20LishF8HirMzkesmptuPJ8PUV5qSZEcY+TtSLZahg5+W09vr61XS
         LKSmkU+p+GktmCdBOtL7RzZYnXQYg7YXEjatPUbLqVrcccyQE/JlIwHnTBNLfikRvw75
         W83WvOMj84d4kNvr3wLW4vQIeJD96XudvNZr2Mz3mkEgZiav7Vyu5KzZPnu2nFrDwGYx
         /xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684177; x=1709288977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+q9YrFx1+moUKp/BkCodCIUYpDo2u/Zf3Lo0LNX6Yc=;
        b=ViiaWk1NZQGGTtOoDvMaZhGgpSNxN0sgcrkqFl+Yb5OS/VPKa3MA8CcGNudVEUh9oJ
         S9QL7HjT3n6fbgcVdBjCojv5c0MCe97+Kkje+vgjKxhGP23S9jl+3v4+FW0jtd1+ukpH
         ag8m3VvSe1Rm30HVJdkmbyk7OQvt1QjAmWEh7iLz6SxKPUFZnQWSpkfXgVfZuZqHkFaS
         /M6dE7Hw1LkmeHO/4Ptgk1uiWgf8jiwU+Xu4/VBjADoHEw08vfTK25UD6FznHvpIsZwb
         UkymOsZez+xV6HTZU+kCjchRLZq+5EG6IpKi0Zw1A9oEtIUfspy5lzq9x3dLLc04HQIw
         eroA==
X-Gm-Message-State: AOJu0YxLAo/t82QzmFJGbArdrHX3j7Q2WAxkPQoKkLo19sNyxXMCmwHK
	FFh9ucZPc8c9faLJQj9whsOjghsBVFgxVVX3Yc1YRxpwI3dYYvOD
X-Google-Smtp-Source: AGHT+IEh28HLnoPR53apqrFnDQ8GYdv8W3OQPkLuR5v0LdepxP4X8Hrh3KqRwJx81hca94SG8xATdw==
X-Received: by 2002:a05:6a21:3942:b0:1a0:e179:3889 with SMTP id ac2-20020a056a21394200b001a0e1793889mr1203833pzc.56.1708684177178;
        Fri, 23 Feb 2024 02:29:37 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:36 -0800 (PST)
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
Subject: [PATCH net-next v9 04/10] tcp: directly drop skb in cookie check for ipv6
Date: Fri, 23 Feb 2024 18:28:45 +0800
Message-Id: <20240223102851.83749-5-kerneljasonxing@gmail.com>
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

Like previous patch does, only moving skb drop logical code to
cookie_v6_check() for later refinement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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


