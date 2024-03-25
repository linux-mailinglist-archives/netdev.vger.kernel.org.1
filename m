Return-Path: <netdev+bounces-81467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F1889F29
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E87C1F38090
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2915F406;
	Mon, 25 Mar 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7HwJLgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BD187872;
	Mon, 25 Mar 2024 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338245; cv=none; b=p1DQIa0+bFSxIGP1dm4st8Y1m6n5DcZV1tJD4ACsuEzwI70bsMNxLDWwIolSE7F8relGAuQoZc4DaawDB5OBbI4fq8KY+mWuwKOK9QLjzU9JqOEk+S8P9FG4h+Mc88EbOYNDVqrd/XNoxxWsBlN5TiJnC/JOYJVYsPMNO5le5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338245; c=relaxed/simple;
	bh=zdcY5soF9BXG2lTs8P71BAAJR2cSoF7tMC4SEYlkG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdsVWX2gSSEoo++dPWiChn7NmYXGkBtN90mlQ7Az7Ks/GoYNPJ+IBNBoMFen0XzoUfzKgU5nkxgIOparU9SRPiBjiz5JGrV2ynC7DN8vqQHNMXZcLKQwVf3PPbhf3k12Jh9dbNkfyKFjkpIBTw79ToGcYSv6Wd/zEIQNShsfazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7HwJLgp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso2603094b3a.1;
        Sun, 24 Mar 2024 20:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711338243; x=1711943043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqoWsOzzwSicKy0P4YX659czjlZonHpQhh++FcV33Zc=;
        b=f7HwJLgpEkZnjH6Xf1MM1jvzttNloJVA+qthIeUmF1NO2W1gsuACotfhTXUIifO7TY
         zHvzefI8Dj6vXoO/Lgd9NwRK5/uhW97TLuSyI8V+Ha2mndcJ5j0Skhe33pj70qkT9ecn
         NKSqbzBq+iUHUOUJiELH571Y7lGDq88ZFJxrwP2aH7W7sLTAkClm2PAc5mskcsPIN5oF
         VwVW43a+UWsb7AwAueyz+A2PVYQXV4/CJumVk1SqW1ZoKZ9i1nnpsDefXnZpISZMAj1c
         xK1BX6QTcC8dGFtn+vcIIZo7LOS7VIGem3SvkaM2bvMAM5WYP9i3z4YLSHdpsHEphrqI
         t/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711338243; x=1711943043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqoWsOzzwSicKy0P4YX659czjlZonHpQhh++FcV33Zc=;
        b=rW81FQMKDS8zfb/XhMr5BOXYDav3Mh7pm5qygz+elHjMZZs2LeKrSpUmQuWkum/fMw
         Khc97EZC5RdzJ9jz4eSy4tJtaPVrxa7qCuMt3/WL7kpap2SsDZXsJddVvGgwgZm8pqdt
         HYLu64Ksjn16j+tKHPz+qnBWhtptQKBTXjQtr4NiVuuuJJNRRt5Heri+OqlWlL29r6LJ
         37uDJjhZD/ILQrYCg941j+zfiQ2L77yYVD/jXoeuPZor8g5yKo7c/b/JPVo5PCkmtNvL
         e6iACZ3d0wn40NRh07dgoZr9/ClIoHra/1mekEvpnenu5tPDxXv2275Tp4D/MlFbgqHK
         EyAw==
X-Forwarded-Encrypted: i=1; AJvYcCX5V8wVv5bpNa5B65gnOl0eMwPwBY34rNjyUslmgOsLaq4znH0WtOQ7QahZmc7EQ8RQzE/IjbdNuoZT3jU1Qh2AVVHGQv6bFpCSVC/v1hcdoIuL
X-Gm-Message-State: AOJu0YwW2sB/l9r6Sz/ZRyJtUyi/Xki9oxM+SPzUHTpZH92Hq9j6WDp7
	pfxlyEBlDS9YaHoZWfETOIdFfGdA5ojuLIg0H0Uniff+KqArmawHKUQ3Ux63
X-Google-Smtp-Source: AGHT+IF2VV2YJlij1DrYmlsAl41QH/8CeXSo/eILZA1VGJV70d076KHfUFCWFIBWcNaWlVu/fybr8w==
X-Received: by 2002:a05:6a00:14c6:b0:6ea:74d4:a00d with SMTP id w6-20020a056a0014c600b006ea74d4a00dmr7504774pfu.5.1711338242856;
        Sun, 24 Mar 2024 20:44:02 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056a003a9a00b006e6bf17ba8asm3300045pfb.65.2024.03.24.20.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:44:02 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
Date: Mon, 25 Mar 2024 11:43:45 +0800
Message-Id: <20240325034347.19522-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240325034347.19522-1-kerneljasonxing@gmail.com>
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Put the macro into another standalone file for better extension.
Some tracepoints can use this common part in the future.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/net_probe_common.h | 29 +++++++++++++++++++++++++
 include/trace/events/tcp.h              | 29 -------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/net_probe_common.h b/include/trace/events/net_probe_common.h
index 3930119cab08..b1f9a4d3ee13 100644
--- a/include/trace/events/net_probe_common.h
+++ b/include/trace/events/net_probe_common.h
@@ -41,4 +41,33 @@
 
 #endif
 
+#define TP_STORE_V4MAPPED(__entry, saddr, daddr)		\
+	do {							\
+		struct in6_addr *pin6;				\
+								\
+		pin6 = (struct in6_addr *)__entry->saddr_v6;	\
+		ipv6_addr_set_v4mapped(saddr, pin6);		\
+		pin6 = (struct in6_addr *)__entry->daddr_v6;	\
+		ipv6_addr_set_v4mapped(daddr, pin6);		\
+	} while (0)
+
+#if IS_ENABLED(CONFIG_IPV6)
+#define TP_STORE_ADDRS(__entry, saddr, daddr, saddr6, daddr6)		\
+	do {								\
+		if (sk->sk_family == AF_INET6) {			\
+			struct in6_addr *pin6;				\
+									\
+			pin6 = (struct in6_addr *)__entry->saddr_v6;	\
+			*pin6 = saddr6;					\
+			pin6 = (struct in6_addr *)__entry->daddr_v6;	\
+			*pin6 = daddr6;					\
+		} else {						\
+			TP_STORE_V4MAPPED(__entry, saddr, daddr);	\
+		}							\
+	} while (0)
+#else
+#define TP_STORE_ADDRS(__entry, saddr, daddr, saddr6, daddr6)	\
+	TP_STORE_V4MAPPED(__entry, saddr, daddr)
+#endif
+
 #endif
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 699dafd204ea..3c08a0846c47 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -12,35 +12,6 @@
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
 
-#define TP_STORE_V4MAPPED(__entry, saddr, daddr)		\
-	do {							\
-		struct in6_addr *pin6;				\
-								\
-		pin6 = (struct in6_addr *)__entry->saddr_v6;	\
-		ipv6_addr_set_v4mapped(saddr, pin6);		\
-		pin6 = (struct in6_addr *)__entry->daddr_v6;	\
-		ipv6_addr_set_v4mapped(daddr, pin6);		\
-	} while (0)
-
-#if IS_ENABLED(CONFIG_IPV6)
-#define TP_STORE_ADDRS(__entry, saddr, daddr, saddr6, daddr6)		\
-	do {								\
-		if (sk->sk_family == AF_INET6) {			\
-			struct in6_addr *pin6;				\
-									\
-			pin6 = (struct in6_addr *)__entry->saddr_v6;	\
-			*pin6 = saddr6;					\
-			pin6 = (struct in6_addr *)__entry->daddr_v6;	\
-			*pin6 = daddr6;					\
-		} else {						\
-			TP_STORE_V4MAPPED(__entry, saddr, daddr);	\
-		}							\
-	} while (0)
-#else
-#define TP_STORE_ADDRS(__entry, saddr, daddr, saddr6, daddr6)	\
-	TP_STORE_V4MAPPED(__entry, saddr, daddr)
-#endif
-
 /*
  * tcp event with arguments sk and skb
  *
-- 
2.37.3


