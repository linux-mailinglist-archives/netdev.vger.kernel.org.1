Return-Path: <netdev+bounces-72809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDA9859B03
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703E7B2134A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528844405;
	Mon, 19 Feb 2024 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erPewEET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4CB65A
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313382; cv=none; b=B84amIqOkb5NB7W+S2MEROiWJwg2IC0+Y47fnLY7y6ZXOhKFjixIP4joaWWMp+82nU7ekiYDvFZYcNelanDFlvs2kRZXA8N0VUET9j9eqz2bpaSCsysTVzwjApwKdXRYGZwD20RgFHd1oO0S7mZICJxMXH36DM1zyCmNvSUOJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313382; c=relaxed/simple;
	bh=6mTmBOb4uROpXGJS2NcFyEOv/40wxANTHrkOANPQdDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mkle+b0Iqsux/Or8cn4IgW+rtuVCIdL8KIm5X2tv/vmY/RE3IRpMR/aP9/7ofjp2haPmn43DcTXEYBJO2PTEJ6rFRhIokWipz/BGLdZTpq7RlCsfONwPhb7LM2sKA1lspIc4q8yy2rMI0ad4agGedte+q5zxkFCpnJ22wbQMzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erPewEET; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2909978624eso2279008a91.1
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313380; x=1708918180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSznBAg5sWzc8e0FYpIWDaU80SBF7/I+1BWoCmDRrvw=;
        b=erPewEET5MmlBrVe8GItO3ZX6R9Szmzd/XwVwHpef/yLHBrvE4RzP4qAdG36eOBkEQ
         jDwN3emT2ZwdhSftHClUWTohu7qv0JVd0p2bXbz5Xs6v8ELAnrQMhYEzGHgMPKmGWhKB
         jgHqzpb3SuV7uG117JYtk2UktvE5wBUzdTuybdD3+3riNQX4vkjv3dlvIG9ZSOGvEWi6
         28teTlqSvI+B0ma31F2FDRZWHv989hOanAVt0w06U0HqupvP4SrKofX/DA0WBmvbu2q8
         PQQxnBHuNmtKwCHZRirM4GNe5wDkApBypLHA3wSIgIc2UhoeP+ulFTjM4HwU8FAEt0w1
         3ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313380; x=1708918180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSznBAg5sWzc8e0FYpIWDaU80SBF7/I+1BWoCmDRrvw=;
        b=iBZi/AXw4rmfIM4ShrMV7UsEYu+BJaMRSwdTZi8cngnq/pbFFpWYD9gKOgxvsEFgFA
         gnmvaTMFlF8YsG0DmqMwnHAV6mVyDYMQ8EXF5as/jdJgXPNKSY60p4QsgffJDjV8jS/w
         23CUXwJZL+XTLCkNGr4Ig7ywVbrFHlAh98LR5FMyTiL2st7JtCwCCkeHOIGdlonoRZSS
         OICJC95+F7Bt+GN7O5/ZJyCkx5fCIPYr/Yzo927VPrMto1KmRK6Bcn1+9B7qAFOleR1R
         TrbtKzQdd0tFQ4r432+lPoPSo72f0lshgdpXRaReFV87xtbJVqxDS2PBGuRhPF3MUcgg
         NpTQ==
X-Gm-Message-State: AOJu0Yz3oTNrGV+6L7RwKCfmSgmjPlx/i6hQVeOiXrGU8On9H6TRd0vt
	wMDFQg0Z0ogqOAOe5VY7zZ7jjMdCs+/g4y69IGpHJC4fxb1jbjHy
X-Google-Smtp-Source: AGHT+IEQZiBLWVKZGuNSIxLVcVv9J2vpTX06rpXP7Aaq+tf0tLQ/SI/oI0rkTVo/CF6nxdimPnw+uQ==
X-Received: by 2002:a17:90a:1c17:b0:299:544c:4933 with SMTP id s23-20020a17090a1c1700b00299544c4933mr2606639pjs.14.1708313380114;
        Sun, 18 Feb 2024 19:29:40 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:39 -0800 (PST)
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
Subject: [PATCH net-next v6 10/11] tcp: make dropreason in tcp_child_process() work
Date: Mon, 19 Feb 2024 11:28:37 +0800
Message-Id: <20240219032838.91723-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
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
---
 net/ipv4/tcp_ipv4.c | 16 ++++++++++------
 net/ipv6/tcp_ipv6.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..c886c671fae9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4a5d5c8fbccc..d12a2a3d565a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1654,7 +1654,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
 		if (nsk && nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason)
 				goto reset;
 		}
 		if (!nsk || nsk != sk) {
@@ -1856,12 +1857,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
-- 
2.37.3


