Return-Path: <netdev+bounces-80650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392B880288
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C6628548B
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BC1118E;
	Tue, 19 Mar 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4zphuio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCB111A8
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866360; cv=none; b=DSegbJ/P8hU9uw0z4pu84j8AR7Cy4X8veoILMNSMNVw8OlSAtTUH45vhlSX3CiMlYO+12jntJTpx6zIiZFScVQIkYfb7ejvzXokQW9uuVynEW2FV/FmFOdApKwckAixUVXEE+K/4Vyu8vugjXd39nLfGNVe5XjHta9IR5rqm/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866360; c=relaxed/simple;
	bh=RODAtEV/ziwf9PTdPPgNU/nHeTo51v04IoWOm+a6b4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJ2+iUb2anWgqrObPjcd3OK//V6eHD6b7f5NjbXa1YzqfD1tYQ9Nk4sUPfonpEetwR3PNtYspONfic1PbUVy5xdOVcxLg/Fb4Nc3WQXDp7v1SX1wPEa0D6ocEYeLG6vPvzPFYnRRSSHG8o+UBNWSmeOUWQtwfUfaaQR0l5jEGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4zphuio; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146703fd2dso5265455e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866357; x=1711471157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFVgseNEkaM5uNHxz1UiSoeXLv9vcea29tejheclZXk=;
        b=N4zphuiouqf9dxibTYt3w750elm3rUSASlX2JcEmdqM5XvJf/v8zLA2egkyJDkSDLM
         sUZoFdaeadFmCYLYO00s2HmAzxPMEQBIvzevSzPPAkTIF9DPvaxdDwVI8WXzvV4dwz9c
         djb5y192GACE0n4xJs6TBQE+XMUBSjBNna9RLCFK/0+dK2vNqrimooVrs7nlhmtpMljg
         GWQFT3NKr/7GZwB0YQ8prJNGCfSY2FC2IHVHG8XZ8iJ2jFVnya/iZQ9FxC6pWE8tyGFN
         mC+Hqxb3Hzl5hq4OsCpTR8ETHZGulxS7GbiIefKZyWVQulOryy+ntfONQqpEx8UsVNq5
         v9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866357; x=1711471157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFVgseNEkaM5uNHxz1UiSoeXLv9vcea29tejheclZXk=;
        b=eS5SCbW3MtqfZFc+zJ7VpbSBB4csvapWN9pHA5mecbc1y4VeSb4pYyKF+BB7Gioksf
         0VSft7AztaJHiEuVinwxUR/LC2zd5fYHsn1Be8Y+Fti7iVoxM/oqEkQ1We6dNAiKaA/3
         yGwVV61GU2GIHbGt55RFEWS57646i4Om5V+s5kSt2gzmJl698XmZkf1wIZDx+zj5QYop
         Tj4qDI3S96ls/DOgDYOUlI5b8p4jj7Y7oa74FbNHYgmC+Qkw3Rsx6TgPA/r8W9v3HsfS
         C5tLluLoiOc3Z5EjlYiMGT3Znlhi6hCJcyeYnRPfB+f4T/DqS9rbD7Q2F0WIXZLckb6l
         lIkg==
X-Gm-Message-State: AOJu0YxBZW47P5LtaxVN9vC7jYsB0688s2fIUhQ998KooV7fp226GxoV
	lXtfY0zEgmOBbWNNsPdOxC4x9U4Q/VhWnlzyonrBa2zMSZv0az/QpLaK8fbbb/E=
X-Google-Smtp-Source: AGHT+IHfO9NQUWScR/3X+YxGq8pOhl3E4TkEXqtGfLWE4cWJ+9WST7+RN/uVel6yvmZlcoKTgWW2aw==
X-Received: by 2002:a05:600c:3ba7:b0:414:3713:e9a2 with SMTP id n39-20020a05600c3ba700b004143713e9a2mr2722676wms.3.1710866356712;
        Tue, 19 Mar 2024 09:39:16 -0700 (PDT)
Received: from bzorp2.lan ([2001:861:5870:c460:31fb:df04:125e:e8c8])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b0041408e16e6bsm11220179wmo.25.2024.03.19.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:39:15 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next v2 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
Date: Tue, 19 Mar 2024 17:39:07 +0100
Message-Id: <1c7156a3f164eb33ef3a25b8432e359f0bb60a8e.1710866188.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710866188.git.balazs.scheidler@axoflow.com>
References: <cover.1710866188.git.balazs.scheidler@axoflow.com>
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
TCP packet, the implementation now uses an argument to the L4 header and
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


