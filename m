Return-Path: <netdev+bounces-79021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6D87768A
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 13:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1181C20A5F
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE1D22618;
	Sun, 10 Mar 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpnlrMNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19E22323;
	Sun, 10 Mar 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710072864; cv=none; b=nXflJsTkk4/iM+aAr8Ywt9xcsOAmRMbLTgFwgWNXlpUCoRg18WKf163VLJA4h/kI4skaNzDVOuQARXUrV/n6rMzs0Mm3NngZE3rSJjLF4Svv/RbJbVT8+s9thmDmZGYTVFTJxUnkWZrRYyQmIWuIQKfhs1qpyWhwozkhh2F4Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710072864; c=relaxed/simple;
	bh=5+1pMvjbrz7ZOsXjHVDdej8UfRovESGp7iTDJGatsJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgAHPBmt+41521jt0WMf2pqPY9ytoNsaxMJvtJ05+8OqtzSROEnQQYwq7Gd53xEgopb9vEc+KciP8COGzMYWQMU/Via9w6bAY4rwfl5FlYRFirHOQYGyafJLqlHvvZcyeQPnDeez5kTZDfrIzlcOtI5Z5MTIJ6SJcorlCflKsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpnlrMNW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6872ce492so461336b3a.2;
        Sun, 10 Mar 2024 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710072860; x=1710677660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTvkjhPD1k4Pbk0uH4ni89jBweJPfN7+Q3IAMHIKBKw=;
        b=bpnlrMNWS0K74hQstEmvHoxglIyPRvlM437msZ641BD8Q625GNRzc6Isu7kdmex8oo
         2AeNfDr5XN56PNqqT3IzLoICVg/w/XHf7jZYQM+K+Xxm2xOqqWnzUv4hA2TMewFcWaM8
         t2LCZHrqj94ZNlStDzAvjZ67A7dQtZzIcYH2MdwHK3NDgtTbCF0dEjmUhptL2Ur3DJUR
         xPxTTSvXu2A1nF3jzUoCHMJuFFhn6/jc7i4u7bj6r13ouvX7JrNNp8wTh8uFZPAYZzGS
         NjY2papvA8XcrXw9hVR+iijtNBXGoaPEWzFHiN+9kHL/IqyXMG0rsuObu0vv3FZMbeZk
         8UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710072860; x=1710677660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTvkjhPD1k4Pbk0uH4ni89jBweJPfN7+Q3IAMHIKBKw=;
        b=Led4f1T0J8prLiph+DsOV5/DMs2FLzGqohrai2mV/wl35fIM2EBbG/L8DAOUSjTh/J
         fMw5nO7ji/gvTOVoSw+UMCcxNyhpdaIzz8csxbSzxfL4Esz9c+7KGU/jRS0N7jjjRbgJ
         HIR7mw5tzo+WVHjFFOXqaJ8ktmML2winJxPTaXDrIZt/TS05D7I5VgZdJ6wWQJCoXEOV
         iktHreTjPqOJWczZ9M4FghbFFtXj0GiLbkLqc5BsaKq+44Mri1WY6I4el/8LTAzBcwGf
         +qJ9eMiX89lgLSvLP3yzRC/0Z6Dqrgmj6HWgMXpvMX85n0v6aY4Zfs1hRN08UzHazJzi
         jcqA==
X-Forwarded-Encrypted: i=1; AJvYcCXfCPnnz85e6UkUMqeDG0x+QbMGM4SmkfOoZEeJDlxl57WrE/dBsUmwHrp6tKnktg2gJ0SNEG5ETtoT+ArnmSSJD4XbUrkhmP5DoCHS83LQpvqo
X-Gm-Message-State: AOJu0Yyxt9iE0rdQS18DSyWJ5Pp/vAQa31lWcqPajcjRUwn+cyf26Df2
	/8kXSBi3FTcQ2BGRhC71adHvBEFYP0a2k1wmf4b0PoM/dPM//1O4
X-Google-Smtp-Source: AGHT+IEliJ9WoaUNhHucP4o/94ZvdGirYfiSJEdJlm5LR16oyWlSegfIrLq8PJIGExR7o09SIjApbg==
X-Received: by 2002:a05:6a20:932f:b0:1a1:4957:ec19 with SMTP id r47-20020a056a20932f00b001a14957ec19mr1487965pzh.62.1710072859902;
        Sun, 10 Mar 2024 05:14:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.38.90])
        by smtp.gmail.com with ESMTPSA id y30-20020aa793de000000b006e5a99942c6sm2485330pff.88.2024.03.10.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:14:19 -0700 (PDT)
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
Date: Sun, 10 Mar 2024 20:14:05 +0800
Message-Id: <20240310121406.17422-3-kerneljasonxing@gmail.com>
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


