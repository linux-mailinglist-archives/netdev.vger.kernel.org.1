Return-Path: <netdev+bounces-74349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A1860F4F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C558EB2791B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CAF5D736;
	Fri, 23 Feb 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmZQykME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1AD533
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684196; cv=none; b=VJVMPxfS2KZ3ZDpQAxTcli6qgD7imUBEOZaafQJ46w+HlzSimthH6IpFWVVkIkOlSLvY9X8TtX2lJ3G+utbbvWNUJrZdgItgkXXi/o39pa1Z3gojgBU4pYxAfudaFApv1hXcra2yetFIbbHNt5dykrhQFFZREyCcohAoCZBo5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684196; c=relaxed/simple;
	bh=yEAllsE96wvEpz2DnJM4KoPvaSqQcx9/yVwsmblksZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NsknFHYd/NmR9glJ62hAgHKcZnKOKW6ZydYqmBsLhQOvQBsw4b6v4r/4x8B2pr2ooxfQQ+FrVa1frjLDXgZ/KanpEwHiDTEwJq77/F+gEkbIg3IJ9UCdLCS14mei6mvfnBumaeKznqRUghbXrSHQRsT3IDmdjqme9r6LEGM4MXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmZQykME; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc5d0162bcso5109875ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684195; x=1709288995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOCFI9RbqeLkjoxApq6ZMHZcBJCyJLiYHOO7IsAZvZI=;
        b=VmZQykMEx7mmkec3VrMc5TqQ9nfAdSBP1XewWnS0rVO8ctw9ZM29IeD6pq+PtRCcGg
         nEwu8V6B0zLim071FFf/etLVUCrf9EZudCahbfZg4YK7C9bRmetuQODB4JTXGMAcERjj
         PUum2e6vdvLuzsvWi4IAWyr6p1LoTtsHuy+CeGdyRnsVkksXzKFQIiUHcqTeoDNcc3mK
         eTBaEsJgTabDrMWB8qnE1JYRXgemzW0hBcZfwlqdxFU0r0CxulookBUPr/cveOpteSJ7
         berMnJWuuBq+JBYLwlJyv8r5pF0U0m7JVzrBtxMF/8AaAxnWQGaDO6XtkflQJlhVjJoI
         cZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684195; x=1709288995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOCFI9RbqeLkjoxApq6ZMHZcBJCyJLiYHOO7IsAZvZI=;
        b=WQKXBsmD5eV4Mjh63PfWaRw7+53xZD02PzSTW8US+9YK2Yej99tPFjRPbjMgaxy1L0
         0cFmlIvOk7HQ7dppjXMV046aVjxYBtuIJxURhcgDTvApZ2LWHIsXBdATQe7g6gNlFEXX
         6N88rfl9LYeublHDQYSdkDyEauF2f/RFr2So9XSKbcAh32VtnViSigYH5ixLCho19Btf
         UHx5jyYvGky1jM4RiKwzmO384/fPicp0zYb8NXiWrnZWQfaFSK0F+5pYlak/NbFXmehT
         W+9toffoKVqbJWcWx/Pe4kNqSUSqkPGsK/dRs7M1Xjuw9FtU8Vwy3rkpIY9+3yYUhvFI
         YNWA==
X-Gm-Message-State: AOJu0Ywd+Fu+KUZdcmKop0eEkXZJTcMH7iGKm65x3xwx8j6vB9jQ+qPA
	ILwVp5f+gVvT07r5D5J/mp1+WS82+s5NsehUfvVvVGbQYkR003kk
X-Google-Smtp-Source: AGHT+IGkVi3r2URNnrN+YiiktEefhgdnvAbpDhVvqfLEpKhPP6GOsRRx6riupDeFvm0dI8Kahvfimg==
X-Received: by 2002:a17:903:247:b0:1db:9fa4:c770 with SMTP id j7-20020a170903024700b001db9fa4c770mr1510914plh.34.1708684194748;
        Fri, 23 Feb 2024 02:29:54 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:54 -0800 (PST)
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
Subject: [PATCH net-next v9 10/10] tcp: make dropreason in tcp_child_process() work
Date: Fri, 23 Feb 2024 18:28:51 +0800
Message-Id: <20240223102851.83749-11-kerneljasonxing@gmail.com>
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

It's time to let it work right now. We've already prepared for this:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
Link: https://lore.kernel.org/netdev/CANn89iKE2vYz_6sYd=u3HbqdgiU0BWhdMY9-ivs0Rcht+X+Rfg@mail.gmail.com/
1. add reviewed-by tag (David)
2. add reviewed-by tag (Eric)

v8
Link: https://lore.kernel.org/netdev/CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com/
1. squash v7 patch [11/11] into the current patch.
2. refine the rcv codes. (Eric)

v7
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. adjust the related part of code only since patch [04/11] is changed.
---
 net/ipv4/tcp_ipv4.c | 12 +++++++-----
 net/ipv6/tcp_ipv6.c | 16 ++++++++++------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..a22ee5838751 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
@@ -1917,7 +1916,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,10 +2276,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			}
 			sock_put(sk);
 			return 0;
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4f8464e04b7f..f677f0fa5196 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1654,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
 		if (nsk != sk) {
-			if (nsk && tcp_child_process(sk, nsk, skb))
-				goto reset;
+			if (nsk) {
+				reason = tcp_child_process(sk, nsk, skb);
+				if (reason)
+					goto reset;
+			}
 			if (opt_skb)
 				__kfree_skb(opt_skb);
 			return 0;
@@ -1854,10 +1856,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			}
 			sock_put(sk);
 			return 0;
 		}
-- 
2.37.3


