Return-Path: <netdev+bounces-83723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4168938AB
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D931A1F216D7
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6FBA39;
	Mon,  1 Apr 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeDDwe44"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38BBA33;
	Mon,  1 Apr 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956977; cv=none; b=p9VB4vB9OfINcAoKIoXP5dW9NQACNi8AFDfKGfzZB3/Xv2GP2liepV3AKMzpA+fTjIRQd8REDT2TLuVOkE6gKYZSMdCCfxcbYduM13LCe0UPsh3wUTeC/Qu+N/DRRolXNqhKTXBtJSnUKa07zJFCbjapPNkbSUCgZZrn8w88jIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956977; c=relaxed/simple;
	bh=ZWvcJpxwLReV7168mNuVScIJhcpomku2PuedAzO8agI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8L5vwEmkaYirStrHsZiySmG4y6La7h0NTbrCnfXwCz4+ARGkLzIGE+Fq/XHdsB1MHI+G9t/HeHK8sPVP7n+4vXL+UI86w9GgRRX/rOaieSi+PyJYSOVaTYrqeRHFn0HJxBgrm6OK4F0Ex5/PM9tFQS450m+h6OXivDVMKCuEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeDDwe44; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2232e30f4so25215605ad.2;
        Mon, 01 Apr 2024 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711956976; x=1712561776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N3gZYbfNvtr+WeUN0iAA/3FlAVaNrR+T5I2SHhakvg=;
        b=GeDDwe44hM+m9ZF/xT1qDi98b5w3hKaO2PUGPkYwEuiRzzNN3cxBGmCalKpThz2gtC
         DhgTRbHz9Mn5E6a26xg9pWLx9PNlhFpbnP8Y+8CCIKujwMyl4LpIdTj1zWF5t5st1aFU
         oET21v2e5gb/YacgDn5hKsKaQXZBRiulY2c9nHWKUz1uMRc8sMXyFqPvKIhPNktNJAKp
         4BRPKBbaWhFvrDeOI8Sdb0FZwt6U0b1pPQqRjrHduiebV964NaqqV7RQgagWZu3dhy/8
         Ncl7wyr/12wpBSNjxooxUr1StPVi2eToulUU143sGuuSYdKsxrRgMnF/sz9U/dMud3iN
         Fbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956976; x=1712561776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N3gZYbfNvtr+WeUN0iAA/3FlAVaNrR+T5I2SHhakvg=;
        b=kUDC6oCwVdzgZTqY9A5ScULCQwltb86DWSmbpNe2K1lmngXA/U8Uu4v2frnl/RnlBj
         1moXa9tRouVfifRhD3a4zjqUONsH1nLp2UMld1kT983v/+pmAe/Zz96lOrZ46n+Smrgb
         MNAO+1uCgViUlFLVzfl+2aLnWS+6SFWLv7MbySYn1OUQHLySJTElyry/yXHXjZSNKMDd
         svkCwSBMYAIJEFTpCAUdpGxhJgHG9BfMoOocC7eC0HEz7gB1mpTqE34B18kGk7+E4L8Q
         2+XpX42kQvj5ekhvGmHv1W6oR3V1W7ZiAyGZO25EJGT4msZduQicRyNCz6khSWrz94VV
         RHnw==
X-Forwarded-Encrypted: i=1; AJvYcCWrJYVko7Yt86YKa/eMeaRRhRXcNegUtxfXWcV8XDHKoH4xmPF7vlbZYAYOKJKE73BuDO4N0OxuO+ygaLIEtZeA8suV0kywfuqS5Ko/OUmkp9LE
X-Gm-Message-State: AOJu0Yyo8Q9szIXtnLeSZUfKa8wBusHbWEQj1zknWeltukwibpgwkazP
	XMPIbLulkKMY07i9+b3onvVIC/6vGts0ZlREAdBojQli/DNpZSOM
X-Google-Smtp-Source: AGHT+IEO8MIRmVO+hhKSWm8W0eS5R/nvoQdOQmBTQ3/iFA0D+gIwe1aEDkZVUgnBStntAN/yqDOEfA==
X-Received: by 2002:a17:902:db11:b0:1e0:a1c7:571c with SMTP id m17-20020a170902db1100b001e0a1c7571cmr8883969plx.26.1711956975754;
        Mon, 01 Apr 2024 00:36:15 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e0f54ac3desm8363497plb.258.2024.04.01.00.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:36:15 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
Date: Mon,  1 Apr 2024 15:36:04 +0800
Message-Id: <20240401073605.37335-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240401073605.37335-1-kerneljasonxing@gmail.com>
References: <20240401073605.37335-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/trace/events/net_probe_common.h | 20 +++++++++++---------
 include/trace/events/tcp.h              |  2 +-
 include/trace/events/udp.h              |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/net_probe_common.h b/include/trace/events/net_probe_common.h
index 5e33f91bdea3..976a58364bff 100644
--- a/include/trace/events/net_probe_common.h
+++ b/include/trace/events/net_probe_common.h
@@ -70,14 +70,14 @@
 	TP_STORE_V4MAPPED(__entry, saddr, daddr)
 #endif
 
-#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)		\
+#define TP_STORE_ADDR_PORTS_SKB_V4(skb, protoh, entry_saddr, entry_daddr) \
 	do {								\
-		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
+		struct sockaddr_in *v4 = (void *)entry_saddr;		\
 									\
 		v4->sin_family = AF_INET;				\
 		v4->sin_port = protoh->source;				\
 		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
-		v4 = (void *)__entry->daddr;				\
+		v4 = (void *)entry_daddr;				\
 		v4->sin_family = AF_INET;				\
 		v4->sin_port = protoh->dest;				\
 		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
@@ -85,28 +85,30 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)			\
+#define TP_STORE_ADDR_PORTS_SKB(skb, protoh, entry_saddr, entry_daddr)	\
 	do {								\
 		const struct iphdr *iph = ip_hdr(skb);			\
 									\
 		if (iph->version == 6) {				\
-			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
+			struct sockaddr_in6 *v6 = (void *)entry_saddr;	\
 									\
 			v6->sin6_family = AF_INET6;			\
 			v6->sin6_port = protoh->source;			\
 			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
-			v6 = (void *)__entry->daddr;			\
+			v6 = (void *)entry_daddr;			\
 			v6->sin6_family = AF_INET6;			\
 			v6->sin6_port = protoh->dest;			\
 			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
 		} else							\
-			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh); \
+			TP_STORE_ADDR_PORTS_SKB_V4(skb, protoh,		\
+						   entry_saddr,		\
+						   entry_daddr);	\
 	} while (0)
 
 #else
 
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)		\
-	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)
+#define TP_STORE_ADDR_PORTS_SKB(skb, protoh, entry_saddr, entry_daddr)	\
+	TP_STORE_ADDR_PORTS_SKB_V4(skb, protoh, entry_saddr, entry_daddr)
 
 #endif
 
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1db95175c1e5..cf14b6fcbeed 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -295,7 +295,7 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb, th);
+		TP_STORE_ADDR_PORTS_SKB(skb, th, __entry->saddr, __entry->daddr);
 	),
 
 	TP_printk("skbaddr=%p src=%pISpc dest=%pISpc",
diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
index 62bebe2a6ece..6142be4068e2 100644
--- a/include/trace/events/udp.h
+++ b/include/trace/events/udp.h
@@ -38,7 +38,7 @@ TRACE_EVENT(udp_fail_queue_rcv_skb,
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb, uh);
+		TP_STORE_ADDR_PORTS_SKB(skb, uh, __entry->saddr, __entry->daddr);
 	),
 
 	TP_printk("rc=%d family=%s src=%pISpc dest=%pISpc", __entry->rc,
-- 
2.37.3


