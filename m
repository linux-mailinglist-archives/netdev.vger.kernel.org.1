Return-Path: <netdev+bounces-76061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788B86C2A8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1221C22919
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6973481AF;
	Thu, 29 Feb 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD5F/G7T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013347F50
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192296; cv=none; b=QxqEIo/sNfkIP2SFacQjg5BORDR+a3Mei2XOdb/DfwYd2LaD1C0zBrpjfzDuOxdMS6B3p+3RKP7Z+1iU3beRLh3k9OG+X8KxqtLmxr6XKqiRWW5BqJ8suVe7HBczUOuiDPaxD7lhQhOGoQTxl/qHsUHQid9NHgpY1hMJP3fLmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192296; c=relaxed/simple;
	bh=NMIKz5QHqhYdI3GhBYghiGx1hUtpNs6c9rhQs5JJvg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqn4OGXpZRfeCZ1QwObS1vCsI1jWDndvc3DD0sO8gkWqzK08Lp7PMnOi/VMBOE/FkgMVT7OBym+BZtYS/824yWxtNMe/fwAcUo0vpFVotmwkBij9AryyPOF54xO1AQjmeZ39gE9KlbCl2SSaqvZKBrdJyyibJCPf1PmIAkQ0TrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD5F/G7T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412b99eb5cfso3743505e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709192293; x=1709797093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Tv+NKy6TJEMzt+3qp0qV1SPIb8xvOpI8cA1Tmj+TY=;
        b=SD5F/G7TC8LNGFM1MUntlp4RrSGKxfSwESASjgMH0UTmCNWq6/d+UBrGt03N2JqFo+
         LMtSHEivPpZEPh+BEou5MKuaQr8Ss86/bPmGa3w8pUoDC7r8IFfPt6baWW/dI9rD20AL
         wo88QpwV4qzZH0B4DR+aK/5c/7y53komiXVPNMhhqQfPnYCfEmRblDwJOtJeI59jixsX
         mKhd/GhaSTtNJFhWM85wkg9MZ8VpJICAXTGltB/DZJDju9AL2i6R/pN2zhFE6W5R+of2
         qrmMO1Ls9vbpuH+KOS0dnGS3uqfQZMPrE5w1qjdo0NMZuU/PGF3dRv3BRRgyurCwcpzU
         ml4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709192293; x=1709797093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05Tv+NKy6TJEMzt+3qp0qV1SPIb8xvOpI8cA1Tmj+TY=;
        b=q8sKwn1gPsr/TNkThbtiyCCyfPGSngEbYxlgaN8azBX0GFlmfs3nsVGywpDAtr/EQk
         6CglmhBFzL1nTnB9Uf/jrpNKbOfZDhSQdMShgk6BMcud2QuXShVbbtMLfhu57q1cxWfv
         +jZrOcOIABFAicZsYOKPGTMM+z30aSfi0T7FZvCNch+3OVRBg1A01DzC1yXMa7+rH8Ft
         bUMnUUeBs4wUHSvXYGj4e740YpxBFw3pzH4c3mAjdEZxyp6uLl04/LpRYgHELsYQDnZg
         reGz5dmNwI5e2nA7RnOhaCjVin3WyQqcG5eO4t4mXuNQZyTEElxJb+ltIfIHIoYVd2HG
         rIdQ==
X-Gm-Message-State: AOJu0Yxu6AgzMlO3jN0mmFFHiEYpwR+XjxrCVcvghtE/O3j3Ekl4vceF
	hUHBD48LkaMmDg8CW0LqPXGcZjzq+34IKO0ZVjo8wwwl/14J0/ARMiFYdjof
X-Google-Smtp-Source: AGHT+IHpQV9U/UcSDdOmzV7VrJA13hlpxlWUOP+wyGNb6eNn6fpGLdpAY0B25PT5x5nNZd3JxaCCMQ==
X-Received: by 2002:a05:600c:46ce:b0:412:b7cf:9189 with SMTP id q14-20020a05600c46ce00b00412b7cf9189mr1004988wmo.36.1709192292493;
        Wed, 28 Feb 2024 23:38:12 -0800 (PST)
Received: from localhost.localdomain (92-249-182-64.pool.digikabel.hu. [92.249.182.64])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm945017wru.112.2024.02.28.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:38:12 -0800 (PST)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
Date: Thu, 29 Feb 2024 08:37:59 +0100
Message-Id: <b9b8f2ee80038707f2f237c4910c46e1cbed82cd.1709191570.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709191570.git.balazs.scheidler@axoflow.com>
References: <cover.1709191570.git.balazs.scheidler@axoflow.com>
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


