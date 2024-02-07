Return-Path: <netdev+bounces-69969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9884D246
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8140B2251F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25585953;
	Wed,  7 Feb 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmc21wS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759B823C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334676; cv=none; b=fdFbe3P5mzqj9cbE+X8fAncBiR4T0OhMUmfFe8OiKC9wLGJzq0zO8RBGJKbTzeRnGsXbdQqUhOM9WlXxaO6/vNRzkhtbOrsmGHnhx4adNPmcLylcJekaBGGmJ3OEr1bTI72q6AOujiCYabO6J8PjPZ+ifcjcqowdavARCcdxKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334676; c=relaxed/simple;
	bh=NMIKz5QHqhYdI3GhBYghiGx1hUtpNs6c9rhQs5JJvg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xxk5NL+1Chit+1eGzuy1Jrq3Ve8Wi4OtVJtQ3aaj0DMKbXTXccucxs2Hvxb9KQZ7j/5sjOtllX8pJJzEmb7sshjBIyn+5PSsd6tI4wVSYCHJ7FceoiylzABKYkTkkA+NMAXvv6mctRTDmDqiiBSEyWZS7MNXR062zoTUmQ/5qPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmc21wS7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a271a28aeb4so130211666b.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334673; x=1707939473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Tv+NKy6TJEMzt+3qp0qV1SPIb8xvOpI8cA1Tmj+TY=;
        b=Bmc21wS7xLacs51rpHdOiXn8nPzPYGQr/liWhBw1zOqIRv0xxdc6tXuQdRjK+t2TfW
         7PzY2WK0hXhapo5hqW7HIhxlZ07jtROD04A0NxfJB1z4NOk/gBrOGWzZ92+1UM+uFNDS
         Z9SAs8/ySyNFGrbExL1rHMzIcTx2TJ9w3arS87AkSQq4L1+inqSsptDicRUKxk1VIZRN
         H+fDlaI0JWbp4V+fIiCc3oUKDuJ3icqFp+5C8ZswBrGUoQOF4N5YHCKuYKzeaJJWGE7O
         XL1jqQMkcdGNcUwEzQf/pzmTGOxx9dPIXvR7kPXBv3CxlJo3wRglMIYQLdHvf+r7yA9S
         q47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334673; x=1707939473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05Tv+NKy6TJEMzt+3qp0qV1SPIb8xvOpI8cA1Tmj+TY=;
        b=JDZ73APzEhQJ1Lo80+e2kCPqox88tPp06gnz95xb0y93A9muvOOagle2Te2ymVoqG5
         5RltrKY5BxVC+RsaVpOqOxuXm9QHxoYzdPcj9DnFes7nBvFPcJuLnb+R+tZgE/edoJ+c
         BYWQEaobiuaub9s7kKmQrVoF96IAyhpAaQV/GzGqPUGeWwVfksJyfj4kN3Bqtp/uSY1c
         KHLmpimDIjzLffny6gPmZCtu+e6uCDk6Kx0lUDflIkBga/aANL/A6kLghoXN9KeYN+zO
         soQhgSQYZO79AGEQWvYeRSrva0lOUvhd5VC5BJfsuxr6y5CgfFPDZXwgLEwa4ILCKmFU
         SIyQ==
X-Gm-Message-State: AOJu0YySWZLbJQeIf8pEQc4QGCVraUip9ihIy/hzBu896CYlM0fDvI6O
	UIv1eTXLSxTOE+HH9lSUPDp6EgjfxWjQhusYCQSQyVZZRdTaArPICAE2Y/A3
X-Google-Smtp-Source: AGHT+IE673h+7D+2vNb2g0SOffzBcgaZCsPRy6Jvx8B8xEr5gE+sdN6nL/LcjJFEoASx+uvJtVjbkw==
X-Received: by 2002:a17:906:300b:b0:a38:19d1:cddf with SMTP id 11-20020a170906300b00b00a3819d1cddfmr3669882ejz.0.1707334672757;
        Wed, 07 Feb 2024 11:37:52 -0800 (PST)
Received: from localhost.localdomain (178-164-213-103.pool.digikabel.hu. [178.164.213.103])
        by smtp.gmail.com with ESMTPSA id vw1-20020a170907a70100b00a3896ef417dsm483815ejc.180.2024.02.07.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:37:52 -0800 (PST)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [RFC net-next 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
Date: Wed,  7 Feb 2024 20:37:15 +0100
Message-Id: <0c29dd96b1532a3874f3b48dc3e8a2585bbca5d1.1707334523.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707334523.git.balazs.scheidler@axoflow.com>
References: <cover.1707334523.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves TP_STORE_ADDR_PORTS_SKB() to a common header and removes
the TCP specific implementation details.

Previously the macro assumed the skb passed as an argument is a
TCP packet, the implementation now uses an argument to the L3 header and
uses that to extract the source/destination ports, which happen
to be named the same in "struct tcphdr" and "struct udphdr"

Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
---
 include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/trace/events/net_probe_common.h b/include/trace/events/net_probe_common.h
index 3930119cab08..50c083b5687d 100644
--- a/include/trace/events/net_probe_common.h
+++ b/include/trace/events/net_probe_common.h
@@ -41,4 +41,45 @@
 
 #endif
 
+#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)		\
+	do {								\
+		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
+									\
+		v4->sin_family = AF_INET;				\
+		v4->sin_port = protoh->source;				\
+		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
+		v4 = (void *)__entry->daddr;				\
+		v4->sin_family = AF_INET;				\
+		v4->sin_port = protoh->dest;				\
+		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
+	} while (0)
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)			\
+	do {								\
+		const struct iphdr *iph = ip_hdr(skb);			\
+									\
+		if (iph->version == 6) {				\
+			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
+									\
+			v6->sin6_family = AF_INET6;			\
+			v6->sin6_port = protoh->source;			\
+			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
+			v6 = (void *)__entry->daddr;			\
+			v6->sin6_family = AF_INET6;			\
+			v6->sin6_port = protoh->dest;			\
+			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
+		} else							\
+			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh); \
+	} while (0)
+
+#else
+
+#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)		\
+	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)
+
+#endif
+
+
 #endif
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..717f74454c17 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -295,48 +295,6 @@ TRACE_EVENT(tcp_probe,
 		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
 );
 
-#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)			\
-	do {								\
-		const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
-									\
-		v4->sin_family = AF_INET;				\
-		v4->sin_port = th->source;				\
-		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
-		v4 = (void *)__entry->daddr;				\
-		v4->sin_family = AF_INET;				\
-		v4->sin_port = th->dest;				\
-		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
-	} while (0)
-
-#if IS_ENABLED(CONFIG_IPV6)
-
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)				\
-	do {								\
-		const struct iphdr *iph = ip_hdr(skb);			\
-									\
-		if (iph->version == 6) {				\
-			const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
-									\
-			v6->sin6_family = AF_INET6;			\
-			v6->sin6_port = th->source;			\
-			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
-			v6 = (void *)__entry->daddr;			\
-			v6->sin6_family = AF_INET6;			\
-			v6->sin6_port = th->dest;			\
-			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
-		} else							\
-			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb);	\
-	} while (0)
-
-#else
-
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)		\
-	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)
-
-#endif
-
 /*
  * tcp event with only skb
  */
@@ -353,12 +311,13 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 	),
 
 	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		__entry->skbaddr = skb;
 
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb, th);
 	),
 
 	TP_printk("src=%pISpc dest=%pISpc", __entry->saddr, __entry->daddr)
-- 
2.40.1


