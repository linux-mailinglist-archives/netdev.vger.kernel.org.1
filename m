Return-Path: <netdev+bounces-79022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2CF87768B
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393B21C20C51
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B852554B;
	Sun, 10 Mar 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJMNfdS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D320DCB;
	Sun, 10 Mar 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710072865; cv=none; b=KMIjRGL8t70UfjY017hmFvfk3CgoxAiesAm5QV14LDV+U3a8jYE9ie7U62BDuiNb8L4dSiUEJBM5abSBe4tt9yEyshaKDOe5vZ3jRyvKXGQTG8gLHUYC8JFmNWxJBfyuFIkWf9KtEDIiXwiX3VwG5shwTDmwv2NxxgWRj5CuYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710072865; c=relaxed/simple;
	bh=zdcY5soF9BXG2lTs8P71BAAJR2cSoF7tMC4SEYlkG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1QdnLKiXniAW5KUZBI9O4jz8O3FaaDajAtgktYfiEt9e2VfiFnEZ2oNdGxm2pWSZoLyYAaFbWK94dcxVhV+qIPuuESHnvkM6UFcqVXb4n/UtpqQCcYT66VTJHfB5+PoSqMiu3Mp7lYnREItEanZxl2Z77uFen76ShrIFaINsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJMNfdS6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2761130a12.2;
        Sun, 10 Mar 2024 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710072857; x=1710677657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqoWsOzzwSicKy0P4YX659czjlZonHpQhh++FcV33Zc=;
        b=XJMNfdS6/M439o+Eo2IuxVByXZZG4ENEJphuita+5GbUkCeZYJQTwxmen2R9kwcgdx
         rDoIYTM+6orJHt32my3coyMSUa3rpmvbPb78+mkkPGhBz1VGgGo7nHwntjCluDeGC+A+
         mc/GI8zIsnAZGPK7lXiYWYA4nVemDFv6Hk7XL8hsSipZyUtRijPEnEUCmIvpqwgf8Usb
         eUtwKTobX4bDg61QXyiez+pwt0b+mwhWGS/Pz+on+v1haDeBnAqjkS50KT2CdCx67zis
         Fb6fcHYC/z9oHu5fFgjXNK4kgkogD4k6ix/jF7Td5K4FV7GaGIRjQQEYPkhjkgJFslGY
         9DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710072857; x=1710677657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqoWsOzzwSicKy0P4YX659czjlZonHpQhh++FcV33Zc=;
        b=uTpIX+TASq1wgHtajrzNOdHiyAQ4JA9aA1Xy9jB2dtGs/KfevzljET463cWFIaryOk
         yi661yIzaDQNF5T3ngedLOCc+kxC4YDNYzLVImpimKQh1uWBBOvJiCQSTJ3rHh0w3zu6
         fwupJ2nsHg/UCNdOfp0qT+rboUGDYsQNed45+R933TOWSyNIlCyWpWJR3sU5v6xGu12h
         KR+JPYOb2KSP+6ekjhVPwD3KX2yGNam7Xqa1O6d40FhYJ5strCEFXjCIirmhfUKjjQmV
         /PTVvugVxp0QyV51rqg2XDwLDiyE4+nAZ6KEfGMZTPOMA5Zssel+pjaz+Tf4QvDyLWc7
         P9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU0M4D6CXm/RFi6WwW0Dj8Qbi6lA1mQcGvko7/e6f6uYtzbHflv1wN358zORuYfUtcyJUOHJvP94a/WkPMmTCqQ8m2USIFolg67bXGGvyPQTu5m
X-Gm-Message-State: AOJu0Yxun0BSTlbHTIdQztDzc6oJ5GuOOQr5lF54DJSMK1LgjmZPXdFN
	ESCMj3kU8EHRVoIMZ55zQX/WrNSOD+z9O82bacDMmopRe8kDugn7
X-Google-Smtp-Source: AGHT+IE9gyTLI3hvSucH9kpqweThamKgZPjO4tOuwfpZ4AbBG3yg8/bS/6e7WVieZUDfPxK+pYqBqA==
X-Received: by 2002:a05:6a00:a13:b0:6e6:1f10:9ead with SMTP id p19-20020a056a000a1300b006e61f109eadmr4107503pfh.27.1710072856599;
        Sun, 10 Mar 2024 05:14:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.38.90])
        by smtp.gmail.com with ESMTPSA id y30-20020aa793de000000b006e5a99942c6sm2485330pff.88.2024.03.10.05.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:14:16 -0700 (PDT)
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
Date: Sun, 10 Mar 2024 20:14:04 +0800
Message-Id: <20240310121406.17422-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240310121406.17422-1-kerneljasonxing@gmail.com>
References: <20240310121406.17422-1-kerneljasonxing@gmail.com>
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


