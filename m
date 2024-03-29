Return-Path: <netdev+bounces-83165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EFA891221
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7510C1F22C27
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912D39ADB;
	Fri, 29 Mar 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKTNbrf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D6381B8;
	Fri, 29 Mar 2024 03:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683782; cv=none; b=W7bSJc3j/VBtIERf8KScQhN2OAm5MLLFnwlMnAn+Ov6u7vX5X+aJwhvEUnKJIuZP4Nr3r2SPmIi2yZIxJ6XIVf2qAmg01KJ7X4knuSoSx+NLwWJHsSqLcnNH0ptBJ39B87FtmedrAlPeKrJxOnR3DhSjkKXZjotCHfCxjg8m22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683782; c=relaxed/simple;
	bh=WoOVAXHWn3OP0rKgSk1H7gxQ88IVvYEXv3eHvhL+ZrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgQ3gMR9Rnc2/CYmZKYGLc4Ej8OKjlt8UffD46RpcIKcQJbTHsTQyz6qtaxvuLQnG6cZHHLt2pwH9raMwnN7ywYsCCzgpIX8RY0GQdMBvu4J+Wji7zjkeP9EZYR6G4HEUU9OiaQfiY3N8l8MLMKfCqgpGZz+wOexhFKZOMULiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKTNbrf9; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so953583b6e.3;
        Thu, 28 Mar 2024 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711683780; x=1712288580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b6IMuYrhVB4jD9fdDZvMGJ3817fYLBenZOf5ZhNTZk=;
        b=WKTNbrf9mxBvzf2PSvIJJ26WP7erplpLLC+S/Mvu3zI/cq+x/59oeBBz5vbUVUV6sN
         CKJMKmsCdbVQwvgXXzH0DtCHI95iuaXOATn1OOvmTO6H/TSSaGQH/MXfmxZnv2CDHLnr
         Oq7rJp1CZjrtDoFXZyByHOx9S0AXVNRzkxs6Es29qrWxAczhOPpQxHughww092X8P/tt
         2SarZ+NN6j/ElvvRK4Web6anHWTQQioGRMnNUaHu3YwE3cT2qMzgP9AvrbN55QmvUbpp
         McoLKzUNuK1oNbdkwu7bWQwhWViLE6vZ/lpVCCf+6+XYxAV1imlKgF2IqtRwI7KYdhFu
         heBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711683780; x=1712288580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b6IMuYrhVB4jD9fdDZvMGJ3817fYLBenZOf5ZhNTZk=;
        b=OJT29fV1JJFSNiqW2gEuk/rxT5sY1oSQr//6HpfKuBDXY/yzymIJjqneGCg56jquNY
         K4Wed1gNSiXNb4pd1TseVC2GziS6/dhZyT8q6vOMpaasEikUdDrZklO2xXRcURsfI8AU
         fgBB1FO40xX1/j5lDWU51+o8hcL4g1i9nnLPZJbooPb/9H8rIkvDZWjgQMz7RSqR2pe1
         /sQGjO1rXxGW3vQff3lLvkVu1FTOJxadY1wAi3e2IXQ1Fg1jablfN2k9eVEFA/sjNDWI
         K8LuMmtbo2+KDgeEcJHrILp9LA1O6jFzWImeJekZNDQhlKCEekMBt7Bc9AbrCvzoJ4dw
         uIJw==
X-Forwarded-Encrypted: i=1; AJvYcCWw/b11KmzDlQHEahdXvlr/NQDokIIjMA8+mcKdjRw/JIzWccbqdI3MOnRxFBOANko+8sJVB04bH3o0t3J+gZzeh59Pl2Aswx5shcDv1K+7dAIM
X-Gm-Message-State: AOJu0YzHA6PK2ALRHBDQlJjVfF6bC+jSeP2lrR51ZzVTYkvVcS92Lj8s
	ovh4AvCUGHIqpX9QTergGgFpNzYegDPniUvxCy92CmJzc6T7SZ6+
X-Google-Smtp-Source: AGHT+IGzA/DBG72KvBfCxRlu1b3h0LVPXvtscswFBPPzvMA94jJJpLPmwhJGGrPtgC/dZy8O/VyADA==
X-Received: by 2002:a05:6808:2083:b0:3c3:dfbc:14e3 with SMTP id s3-20020a056808208300b003c3dfbc14e3mr1299732oiw.50.1711683779754;
        Thu, 28 Mar 2024 20:42:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78e92000000b006e6c0080466sm2201854pfr.176.2024.03.28.20.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:42:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/3] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
Date: Fri, 29 Mar 2024 11:42:41 +0800
Message-Id: <20240329034243.7929-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240329034243.7929-1-kerneljasonxing@gmail.com>
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing entry_saddr and entry_daddr parameters in this macro
for later use can help us record the reverse 4-tuple by analyzing
the 4-tuple of the incoming skb when receiving.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 3c08a0846c47..194425f69642 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -273,15 +273,15 @@ TRACE_EVENT(tcp_probe,
 		  __entry->skbaddr, __entry->skaddr)
 );
 
-#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)			\
+#define TP_STORE_ADDR_PORTS_SKB_V4(skb, entry_saddr, entry_daddr)	\
 	do {								\
 		const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
+		struct sockaddr_in *v4 = (void *)entry_saddr;		\
 									\
 		v4->sin_family = AF_INET;				\
 		v4->sin_port = th->source;				\
 		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
-		v4 = (void *)__entry->daddr;				\
+		v4 = (void *)entry_daddr;				\
 		v4->sin_family = AF_INET;				\
 		v4->sin_port = th->dest;				\
 		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
@@ -289,29 +289,30 @@ TRACE_EVENT(tcp_probe,
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)				\
+#define TP_STORE_ADDR_PORTS_SKB(skb, entry_saddr, entry_daddr)		\
 	do {								\
 		const struct iphdr *iph = ip_hdr(skb);			\
 									\
 		if (iph->version == 6) {				\
 			const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
+			struct sockaddr_in6 *v6 = (void *)entry_saddr;	\
 									\
 			v6->sin6_family = AF_INET6;			\
 			v6->sin6_port = th->source;			\
 			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
-			v6 = (void *)__entry->daddr;			\
+			v6 = (void *)entry_daddr;			\
 			v6->sin6_family = AF_INET6;			\
 			v6->sin6_port = th->dest;			\
 			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
 		} else							\
-			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb);	\
+			TP_STORE_ADDR_PORTS_SKB_V4(skb, entry_saddr,	\
+						   entry_daddr); \
 	} while (0)
 
 #else
 
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)		\
-	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)
+#define TP_STORE_ADDR_PORTS_SKB(skb, entry_saddr, entry_daddr)		\
+	TP_STORE_ADDR_PORTS_SKB_V4(skb, entry_saddr, entry_daddr)
 
 #endif
 
@@ -336,7 +337,7 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		TP_STORE_ADDR_PORTS_SKB(skb, __entry->saddr, __entry->daddr);
 	),
 
 	TP_printk("skbaddr=%p src=%pISpc dest=%pISpc",
-- 
2.37.3


