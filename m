Return-Path: <netdev+bounces-81512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A3E88A0D8
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96B61C37E0D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4819470;
	Mon, 25 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHLCEa40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2F13CFA2;
	Mon, 25 Mar 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348124; cv=none; b=FVa3CfwNJ0FKzdlFCrQK8hf9afqewkoc7M3s4zbd4R6W/GXFl25LkDP+0OrJ+nn4M+Nzs49vf9Q+PyuVsA+NKDcd8l+y4CoNw1vvqxlWO0vCGHnyFyYMTH6LdLNtE43hYif+HxFDX6v2ff+WabyTPCoBgI7sSnUOwjftpWXAbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348124; c=relaxed/simple;
	bh=YIHO2ZzlfKMI78s1ALOdFjQ4kMBvR4jL2Ci5VkvLqmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdFtHrxXL6ti2ocwdcGqJYT2vmiPmrmNN5lA+NYDAL0ATQEIVsv9EgdI0hbSPHFJ6vgZZ41+lACrL+hy0BGfMwIOJ5n7hYyG3lsJEdub+PopddFa9Ns+ycyf8WATidDSkcmoZoD5FyoCmHEPpBt1Qm3SsEHcOgoa2aDeetOLE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHLCEa40; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3d2d0e86dso84725b6e.2;
        Sun, 24 Mar 2024 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348122; x=1711952922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufPZljtHRIDkXlW3FFcbCW4Y/MzuhDcLur+1tqDM7fk=;
        b=gHLCEa40pWStXi+tD9VPdY5o8fiviRZ5ZyLvB+382pP5nUBmWJg0we81ILYCq5z/ve
         z+jYQpGE6qb6kVcA0R2O4FzVunrym4GbZneeFFB8v4h5aRYNwTdb2Ed+UJyGE+m/zF7h
         Kjby4r2O2jwa3QxU2RCgHGjhawOL4qxILTlyK+nDydCa4mIY3Qcn/n8ymZSmuv5nD8kU
         uz3pX1enSPtLwvoiIXPu6cXYzDCTxUdZzYS930OLBXP0ihWjJssccjgYNNMLGtUFlk3u
         EZM+dAAXWLcDuFtR7jCCbTTO6Z4xtzdWOe5B5uHbuzE4WP7TjvOZAMoBJD4bApa9emsO
         NE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348122; x=1711952922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufPZljtHRIDkXlW3FFcbCW4Y/MzuhDcLur+1tqDM7fk=;
        b=qB5dAQbDYba8hoyZZ2fs0/IZPLuzY9AzSxt+HmjL3ToDPHfUE8kN0l2T49KIKrfXRz
         BflRv+cpqsA8mTIFu5gwyeGjk15JswZsSZWX36+fs1OE4XsDOmuREPtSESosTgwfQeJz
         0UcqDmcdTFUnEpmDUklPk7xar5n9THj0AA07AdHu2RdaufX4w8xAYe1syrpPObkmutn5
         RtkaXD1rMcV3K1NoERZ8dZCIBl3u3g4jr7lys3RGURnrC9hU4DXniknBtPeAZyMWraaF
         3IQHHRtOGouF6sgciVc31mJLInG2AijSquJMXOUQSLa2rNSygsRnKFdIfR0g+xSYFN4X
         cyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa4NYBzzbjpXehSiriK2umwYheYfhf+4IKVI23XrrggqJvvMxtHjhxAuaMKb6mCQSrjf8BP1SdMu/NHenNT+3WFSv+HupOgZmPjTit2hu1AY3M
X-Gm-Message-State: AOJu0YwoQLkIYQZUCAGKDTaLjPrhfRlAUvHmvB6elkEjHVP1uoUH0QgB
	TRBOQrgDjfesKJH54UemB1wXi8+FQPbzOhynXCefxAAw4NMrZaM2
X-Google-Smtp-Source: AGHT+IGdfgBngQ8ZGSn+CFhtAM9BcgSrE1Dcc14DwzLZf7qSv5Z78G5BKXqeJI5OJiDcV6zLSuT6tg==
X-Received: by 2002:a05:6808:1b1e:b0:3c3:cb85:2fe5 with SMTP id bx30-20020a0568081b1e00b003c3cb852fe5mr4077097oib.1.1711348121791;
        Sun, 24 Mar 2024 23:28:41 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b006e697bd5285sm3520253pfn.203.2024.03.24.23.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:28:41 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/3] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
Date: Mon, 25 Mar 2024 14:28:29 +0800
Message-Id: <20240325062831.48675-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240325062831.48675-1-kerneljasonxing@gmail.com>
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
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


