Return-Path: <netdev+bounces-86998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451608A13BB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CDF1C21ACF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C214AD36;
	Thu, 11 Apr 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7xBnF1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F014AD3D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836631; cv=none; b=VJUAAZVhJZ3WfZ5CRzFVc30lnNUtHNAuI+/4HCcdqL5xs9EeWzesAXxSLeolvLspGp4IRqv2E1T6tRDu/ulM6qVpBpSMHmRg4c0yR46J2iYeKOQYsCye5Rxh6qp7vMImofz6aKiUwQxhoRmjxosQxZbCfjCYX3iJhV3hKs9Pbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836631; c=relaxed/simple;
	bh=YYAstX7ppQWMuzdq68g4kGdGP/fDG5Hqbg/nseaU7LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+nu6Iq17+pGkvPk4Dm5o3np6bT/FjTpjE7/rZv7oiMcl+xNEtxE2J9I9O4CzOMvgJatc/ZM4hw2brsVVt46XX7BOyG96fkujkxuvOy/7KJS6c3mnmZUrRzE7nAsMklCCLIBxU6VKLLwNyGE/TCAX4YrXaagzruWmsx4gE3ZSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7xBnF1Y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so4625866a12.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836629; x=1713441429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzPPT37X9CCukMbb90HnYaZ5ZonWT01Ndh8y/YWgYrg=;
        b=i7xBnF1YDkVIeRqSiNJt4JFlVWi9DXD7YxHmfEQvbJP3YCy/UdlB2nC89HGKqrr0ko
         zMqe+MxHvu3KPrR3BLO4YvTdtdheGr81iIZ1LRnfsWLTC7sBAfKZSHcBvAwzMRh3JWM4
         eAVggWhlRwj1/nw45D/zWnw+vB8KE+5frBjW9EXdgXH1jMC5vJZftgfU9tNeCua05geK
         QLIqArgGc11T7XxY+/S2NmMB5wx/OWQI3XbeqogP07aK8oo7BJcohNzv7BYYZiyZDqxR
         Pk0B1SjXgzunhFx220k2qkLt8Bej+MrntlxVBi8/cJXSLl/5TMr574YG54vfGxqmBf3y
         PVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836629; x=1713441429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzPPT37X9CCukMbb90HnYaZ5ZonWT01Ndh8y/YWgYrg=;
        b=ptRF2yusXjBceoc5apsfVzKUC8qOySCJOYEQODZoug5cRu9hDi3DTpGdWDuSLijDFQ
         xYx2OBZuStiKmnpOGkMSkri8M5bG1NOORjbO7Do+bfbmd9eYb0NJOWv7HiLtFsumTAf4
         NA6qDEeJACd8hydgzbOHP7lTPyV1CaJGWlYSd6Sl95YV6ZGA0Z8gAzYuP8KxtOJDo7XK
         TI2dRxSpfMV1WQDtuIUfhPGw5BOWtHwLu4P0kS4hntg3V9AuNAqyJ5ILcMul0rrnypWN
         BBQhrp2FgoFu0LV3QvDb8xSLf6cT6TBnyGtPbUZICNndRNV/w4NDrV1Z5uvALER3Yuo2
         9QBA==
X-Forwarded-Encrypted: i=1; AJvYcCUROUo8WUURuNWdGPpJuk/q396V/wQMVPKDzuxHoFa7BpQNIy/BXOw2/9IO7ipnS/xlh0/DDuN0Fhn2pDN6ugc3AKPZWQJu
X-Gm-Message-State: AOJu0YwEORnMbd6EUZCQufaq9dTMOAfi1f8QuB+j9quJw+oSPq9hA/sL
	dKtzms0/gwY3Bq9mGLaBPfZjmjlPB7fDkjXKF1cLeYUQ1Gmb+IiF
X-Google-Smtp-Source: AGHT+IHka4LqGg39XwLYMiisy6zHtStylD20DZX/IFHR0ajxOiOQ/ecEmfO2dan9iz62T8YrNr1nuw==
X-Received: by 2002:a17:903:1105:b0:1e2:9ddc:f72d with SMTP id n5-20020a170903110500b001e29ddcf72dmr6191779plh.26.1712836629380;
        Thu, 11 Apr 2024 04:57:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:57:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
Date: Thu, 11 Apr 2024 19:56:28 +0800
Message-Id: <20240411115630.38420-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240411115630.38420-1-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we don't need to implement those duplicated reset reasons.
This patch replaces all the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 net/ipv6/tcp_ipv6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 441134aebc51..863397c2a47b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, (u32)reason);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6cad32430a12..ba9d9ceb7e89 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, (u32)reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


