Return-Path: <netdev+bounces-79050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22168779E2
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDF2281423
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 02:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9433017D2;
	Mon, 11 Mar 2024 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX5Kdwyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA15B3;
	Mon, 11 Mar 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124876; cv=none; b=tp9NbSEUi7QYU2gheOTZVefmMvR3rkuzMFqUTD3A434vWNHhIyxSS3s8advT6oK6FWXEeXIG6yAzZxXEs/vtkv/OcyaOE6IMd95txayOEBNnhngKwzjtB9DWjBdH3hfg+otM/lqjIMNZ7M99EW8rj4qdh+QkSegeBP4O25AHOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124876; c=relaxed/simple;
	bh=SUxenl/BwbSsbDrQBUXDykQNYl1Qk7Yq+NkpuENC15k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzW/eDhK0T5+yLjsP4rQ2Ssb/XTC/lyki/BdwHfMY8IQbrckVgSdwu/zPBp2XLFSRGyIGUqdiANihQ1LIEK9xojKV6YrAC4/TWR43Htp3EGK8WohFejnrzfh2Qe3kpfnjZ4+11hRwUU9ZeUnh1hiLh97XoDx37QKCRa7zbYCvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX5Kdwyx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc29f1956cso14735865ad.0;
        Sun, 10 Mar 2024 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710124874; x=1710729674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do+9SHGs1HG4/leaBYvD8jYQHxGGVY9D4dB/P5w6JJM=;
        b=PX5KdwyxKjHSD2yIRAsTopvS6FiVQKEd7wQAGbdcUeIzCew6EgeTnJzYSwN+L4emlY
         aZLd32QhT50Y/UKMrZMqO++bKHApY3XcNYgdtXwrq7G8tUzc7/v/52iX8X0oqMumsTsd
         g7MjstoZWp1oIsWJ9n8bSce6hUSSaqg7i95SykU2ODBde1O8N07On9++GmrAeo2dBFm1
         6Wm3r2seO2QSY0MIWXAOQh8DvueQYlXVsrOKGcPkAU/ykHMAVoXAIZ+zGENstwrPeyI5
         wxf1aaPIWVEVTcn4WEKOzcB3RwNweY1iQ8DPO20qAFyQsh8O7jguSUR3uc7tAC5uD6tt
         KyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710124874; x=1710729674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do+9SHGs1HG4/leaBYvD8jYQHxGGVY9D4dB/P5w6JJM=;
        b=sqvsL23llA5beKkXnIFErvvfnxRkwg1h7QA/580F9hQkXIRNcwsq2gHDwptxiyE7Eo
         GcYhKvZb16mNIJ4wtyAIZK2ArWO91pn2VwPKc3atrfiDbUX8AelauK97Zq9/TUSCCqJz
         u2oMJ4ykHg4hR3fmkihR2bxNCW+xmrJgDIldgXGxpVZAMqDgC6pGtbWS2rrepZ0LZKqz
         CBbg6MZm5ussSsjZa+o+NXyYvN42jzm+QigXs5qB/sRvAm5iDOoI9LWOLumvew90/Gh4
         cPzSq4CFklhtNyPOmkUz+KIIsbRH3dByerjNFlz35FYyfeR+X8Mka4VCZjQYYE6ZscNv
         sVFg==
X-Forwarded-Encrypted: i=1; AJvYcCV1XsS4AYewVjO46UZiaJprbaUFq7rOwRBmsf9PySoSZt0U+uv0gftcf+9Nae+0Xj8XRwaRqbofaHlWipjnkUKpPEQuM20XeSxWHQL3wNUwNm3Z
X-Gm-Message-State: AOJu0YxhZB/+iKKVqT4UsdlihqOXa/hSUOI+X58DIEQHwao61duEZAjG
	Wyb9xFUjuew/WodsDMdaUKyY5ZIWnaZSUaGMm4QmNfJP1nj54Hj4
X-Google-Smtp-Source: AGHT+IH+bMjQvC2UBxBiN2xhwYIu10I4giZQpSbMad8VIzAgx0aRb3ZzhAu+g7oFvNy8vufvWJDg9Q==
X-Received: by 2002:a17:903:2988:b0:1dc:90a7:660b with SMTP id lm8-20020a170903298800b001dc90a7660bmr5420534plb.9.1710124874367;
        Sun, 10 Mar 2024 19:41:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dd98195371sm1135120plg.181.2024.03.10.19.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:41:13 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
Date: Mon, 11 Mar 2024 10:41:03 +0800
Message-Id: <20240311024104.67522-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240311024104.67522-1-kerneljasonxing@gmail.com>
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing entry_saddr and entry_daddr parameters in this macro
for later use can help us record the reverse 4-turple by analyzing
the 4-turple of the incoming skb when receiving.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 699dafd204ea..2495a1d579be 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -302,15 +302,15 @@ TRACE_EVENT(tcp_probe,
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
@@ -318,29 +318,30 @@ TRACE_EVENT(tcp_probe,
 
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
 
@@ -365,7 +366,7 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		TP_STORE_ADDR_PORTS_SKB(skb, __entry->saddr, __entry->daddr);
 	),
 
 	TP_printk("skbaddr=%p src=%pISpc dest=%pISpc",
-- 
2.37.3


