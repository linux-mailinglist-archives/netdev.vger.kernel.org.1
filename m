Return-Path: <netdev+bounces-81468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B488A127
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA45BA5126
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE415F40C;
	Mon, 25 Mar 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrdllWo1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168D1FDB20;
	Mon, 25 Mar 2024 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338248; cv=none; b=VFb1gryV8ltd6ZeskCWvyJ9l+avb3VsGRdJDGaAp+CPdyx1ElFOGcp1vX5L8pNsZZBgPuT3hcNTrBjGnAqi4AQx5L6mC6JeP3T5S9zCPDx3dzsLlLNVEEYiFKPaRwQ/Rdpb5Ig7lSj+1EGE9qBk/9JACm+EI+0Xu8PNtJO7fpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338248; c=relaxed/simple;
	bh=5+1pMvjbrz7ZOsXjHVDdej8UfRovESGp7iTDJGatsJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAXA6NuKd4fZh41c60iChZ0gIp8u1kXN1pc9dNih+Inq3/w4vgjF5UgR65b/VFR2Y6gdV/VFeSM0EVg/Zb9iVnXWOdkCNs+x8lPR1wixyU0JThUks7oRqLAeBdenMjb0d+vOxvdTvg/rTgEfP+RTeUt/XTMQ0UkNo3Yj13mEirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrdllWo1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c36f882372so2519801b6e.2;
        Sun, 24 Mar 2024 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711338246; x=1711943046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTvkjhPD1k4Pbk0uH4ni89jBweJPfN7+Q3IAMHIKBKw=;
        b=hrdllWo1eLoAmOSnEkPVZbzaAXDQ6uoByfNeJEUFqtGEpCKeWSvPGb7mYLsD+qsPG7
         zRHR1wIJ/P55HkeTrHqkWvtGiPDNmpXiPlj/0LOI+0LtsLbVIcNxAw1qzUbp1sm02dY5
         aWCHcepVXG0RPEE/USU846dB3oQrZIpD+ALPZcAnpAlZ6R++2Wz3989JP+vL5kQCYhij
         3//cRt4Q0KRVqVXL2kEQe//xgJTmmIlCEwextmLeI9qBSOx+ofTGhrmQUI7WF/0FJMOh
         E7UMU2hqKSL4lJ9yd2UCVUcEOP1Ht762Cj21VE4O75seJIx0DBpM9i+dfdFtL1DZUELQ
         0Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711338246; x=1711943046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTvkjhPD1k4Pbk0uH4ni89jBweJPfN7+Q3IAMHIKBKw=;
        b=PaLce8fhJcJuw0N51mV4PXPsDtrJ6rIzBmBP4noxYaQEIIgrcwxcJHwQNfSfwYffD8
         PzQN7Q5cGxUbjTm2FAHsbiK/qUwusN1xISekDFoxSlt7hqm46lzhq+uRw8+0Zas70Rd7
         1tmA/P/3gfXs8LK1JD8dw2qH8cs25pBxHz5Gl0U3b8jJo/eb/aERWKD6bLjif6RMjL/U
         RCHneHJ25b9nW3gFcRBgAviUnhcRRJwwroa2TcH0aN9AoUdkL4pqxHYpV/mZmGkjmFtN
         4CBibVVcPkBGo3Gi39K2jrUctRi8tbm77KnO0lugahO/TjTzXi8zJNZpVMWZ/3HEpfbN
         an+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqwTUsGRaJy+ArXFH5z+jvXsb4IqZBoQsPqr+B8yBZCvO9D+fy9qI0w0EcNUYXwyCoNjv1LjxCQlkO9YY+rCYXXxUuFiYzv75siG/t3lc4RbFL
X-Gm-Message-State: AOJu0Yzb/mhgmkeumOuAGOsKOpjI2RVxB4GcNADvUI/lqF020lezXRl7
	McEoh8cuiQ45R0MBNQ29aIfuOtH6/WV0aEKIlY3xqE9FbGbmGgXa
X-Google-Smtp-Source: AGHT+IFE88Y01NDpyVnM9dbh09BbehN1C5NKgLuXhQ9nGEMmc/K/v1PhQStdgVBSr4Ah5YC75wymGw==
X-Received: by 2002:a05:6808:b25:b0:3c3:5a02:43e9 with SMTP id t5-20020a0568080b2500b003c35a0243e9mr6634361oij.26.1711338246145;
        Sun, 24 Mar 2024 20:44:06 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056a003a9a00b006e6bf17ba8asm3300045pfb.65.2024.03.24.20.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:44:05 -0700 (PDT)
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
Subject: [PATCH net-next 2/3] trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
Date: Mon, 25 Mar 2024 11:43:46 +0800
Message-Id: <20240325034347.19522-3-kerneljasonxing@gmail.com>
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

As the title said, use the macro directly like the patch[1] did
to avoid those duplications. No functional change.

[1]
commit 6a6b0b9914e7 ("tcp: Avoid preprocessor directives in tracepoint macro args")

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/sock.h | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index fd206a6ab5b8..4397f7bfa406 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -10,6 +10,7 @@
 #include <linux/tracepoint.h>
 #include <linux/ipv6.h>
 #include <linux/tcp.h>
+#include <trace/events/net_probe_common.h>
 
 #define family_names			\
 		EM(AF_INET)				\
@@ -223,7 +224,6 @@ TRACE_EVENT(inet_sk_error_report,
 
 	TP_fast_assign(
 		const struct inet_sock *inet = inet_sk(sk);
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->error = sk->sk_err;
@@ -238,20 +238,8 @@ TRACE_EVENT(inet_sk_error_report,
 		p32 = (__be32 *) __entry->daddr;
 		*p32 =  inet->inet_daddr;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (sk->sk_family == AF_INET6) {
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
-			*pin6 = sk->sk_v6_rcv_saddr;
-			pin6 = (struct in6_addr *)__entry->daddr_v6;
-			*pin6 = sk->sk_v6_daddr;
-		} else
-#endif
-		{
-			pin6 = (struct in6_addr *)__entry->saddr_v6;
-			ipv6_addr_set_v4mapped(inet->inet_saddr, pin6);
-			pin6 = (struct in6_addr *)__entry->daddr_v6;
-			ipv6_addr_set_v4mapped(inet->inet_daddr, pin6);
-		}
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
 	TP_printk("family=%s protocol=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c error=%d",
-- 
2.37.3


