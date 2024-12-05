Return-Path: <netdev+bounces-149402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECC9E5738
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D8E285901
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942221C161;
	Thu,  5 Dec 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdWg+htl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BB21A43C
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405520; cv=none; b=C4s6n2HmjdPD9ZlS2z2MehMe8fwYyJJaAbLOeeHCKKP6lP8TFgMdVEAsrGueSGn/KGPnCsMOTYGmA/hEDgG47F5f2e9goMymohWTRzPr1hTg4Txg57dG1wRIPCoDpBcqD2GEWyX6V3KaxAl29KzoE/BHcjqEivQIHq4VvPlLdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405520; c=relaxed/simple;
	bh=pnK0GrIz1FMHcguqJbgJkCYwdu8RP/GPCfcJtIY5EoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY3kz7iTh6+5TlXgofL45JlfZ0yf0RM/3yJMZ0yCnUHCqhPNDjoUazcRJWz5/1po/BAiaqVqiaHudN/2QWzKeRzkGg2ffnVHnGfOEynwWvNhrbmL59KDlwJn5w9v+mfXfedd72qLgXwhQy/V8yELUvs62uApaFuFbpvlqq19yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdWg+htl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434aa222d96so10437235e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405516; x=1734010316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwKWQ5+9YFIJcuWjk96iuJPnMhE/dQhD2eAjqiRGLCA=;
        b=HdWg+htlF2qrOERMNt/f+TaVTNE4B2kmoDwB4r+6kt2RXRsJwnr4ByuaDGp0ySJRRB
         jOHjKq7HF682eH50xLkIfkowTNzW7F4WdXnQsm/w5bgPDAgiBUV+J0SdUlNVxx2FTFdA
         G4yU/WAlys9N/iMtEww78C7DoXm98iu3EmujsvQOASjoiEPmwCa5xBiCDwJ7mQqvB50/
         cSzVLh+AF0P/7nQSlN79Tj2v627q2+xeOd6cROI51bcIrJLogkyNz9HGDWnPC0J0W1mA
         iEmp7WA/omJbidlWj9LLWT/NI4G3NI58s51pA0Z+Due5JjFZA7r6uF54qGJ3f+7OV/WK
         kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405516; x=1734010316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwKWQ5+9YFIJcuWjk96iuJPnMhE/dQhD2eAjqiRGLCA=;
        b=lgi35DJYwTVMifr8G8UIoVFQRFokpwixaA3mVx6v9HcEAuRTLtSoUxVm+/uoT+EH2T
         3c8xPmoBnrTVJ9u3foa9xEog2POXeT0+EnwSGCsb8JQ00NL8yY7zP2de9anu+44nhivr
         zTmwa6LSkGaAm8fl2rQDaantR5kmhCYj6P+ovso/vbQX1FVZoqwhyhfzM7UaSXgivXlp
         KjLwbHDlO2jNJxuFFVpqhssRK3mi/UzQOPzab/kBSVZiW14BmWvO38K32P0wlKttvf6C
         FLW+KFzPq8jVcAu4SMSjBS6O3kOshOef9Z+DFumgkUUYPip5trE+3xEFjteb6UvU3qEJ
         hc6g==
X-Gm-Message-State: AOJu0Yyv5wRsbxua0GRRjf3zuRGSFjPdtrIyuzm4VHVbpmkZjjoXm4WO
	6vdc+oiAuke6tm+venIXM+Nw6bD+eol9isoPoY+S2vND5qTGVmSbMmcLpnl+jGk=
X-Gm-Gg: ASbGncucac1U68gMFSyFTYVWIRHyDIj2ZKmrHrHkqW+iEkaSmT6z+GWYCFYEEoXClxC
	HdmeBeqx6bgKZb3/O6WvrJyCgkSoIuSdEKmfj/SdAOhNeUNxRzzu+0xWFVdKzate2VlV9OOD+TY
	Wzit21+jRTpjAbPQ9tnSX1eKws2nGa+pf3cO9OOVDNmGHsfwmFkihapjlxjY7zP3zb18f3rxrTH
	xlpSjNTLFP4Fc4Pcy/66ip7V63f58i40a55988UfeUtXPDioJnnWGaldQlxzQSHPHQMvRXqNcem
	cxgCAK+WOTiSauSTtUF7Wh5zoXhxr7HfLoOsQ5QHrlApGBiBFeVWZSNzQA==
X-Google-Smtp-Source: AGHT+IHslG3Dx933n1j1dbznTUxGHlm/FLrepi+RIm6DYH8F1Dsk/tSojEJ5oN2wEAMI7Gf6h/KmSQ==
X-Received: by 2002:a05:600c:1911:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-434d09d1c0emr111648805e9.17.1733405516202;
        Thu, 05 Dec 2024 05:31:56 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C700ABF575982C3B3E76.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:abf5:7598:2c3b:3e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm60852465e9.24.2024.12.05.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:31:55 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v5 4/4] sock: Introduce SO_RCVPRIORITY socket option
Date: Thu,  5 Dec 2024 14:31:12 +0100
Message-ID: <20241205133112.17903-5-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205133112.17903-1-annaemesenyiri@gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new socket option, SO_RCVPRIORITY, to include SO_PRIORITY in the
ancillary data returned by recvmsg().
This is analogous to the existing support for SO_RCVMARK, 
as implemented in commit <6fd1d51cfa253>
("net: SO_RCVMARK socket option for SO_MARK with recvmsg()").

Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 arch/alpha/include/uapi/asm/socket.h    |  2 ++
 arch/mips/include/uapi/asm/socket.h     |  2 ++
 arch/parisc/include/uapi/asm/socket.h   |  2 ++
 arch/sparc/include/uapi/asm/socket.h    |  2 ++
 include/net/sock.h                      |  4 +++-
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         |  8 ++++++++
 net/socket.c                            | 11 +++++++++++
 tools/include/uapi/asm-generic/socket.h |  2 ++
 9 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 302507bf9b5d..3df5f2dd4c0f 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -148,6 +148,8 @@
 
 #define SCM_TS_OPT_ID		81
 
+#define SO_RCVPRIORITY		82
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index d118d4731580..22fa8f19924a 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -159,6 +159,8 @@
 
 #define SCM_TS_OPT_ID		81
 
+#define SO_RCVPRIORITY		82
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index d268d69bfcd2..aa9cd4b951fe 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
 
 #define SCM_TS_OPT_ID		0x404C
 
+#define SO_RCVPRIORITY		0x404D
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 113cd9f353e3..5b464a568664 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -141,6 +141,8 @@
 
 #define SCM_TS_OPT_ID            0x005a
 
+#define SO_RCVPRIORITY           0x005b
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 316a34d6c48b..d4bdd3286e03 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -953,6 +953,7 @@ enum sock_flags {
 	SOCK_XDP, /* XDP is attached */
 	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
+	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
@@ -2660,7 +2661,8 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 {
 #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)			| \
 			   (1UL << SOCK_RCVTSTAMP)			| \
-			   (1UL << SOCK_RCVMARK))
+			   (1UL << SOCK_RCVMARK)			|\
+			   (1UL << SOCK_RCVPRIORITY))
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index deacfd6dd197..aa5016ff3d91 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -143,6 +143,8 @@
 
 #define SCM_TS_OPT_ID		81
 
+#define SO_RCVPRIORITY		82
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index a3d9941c1d32..f9f4d976141e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1518,6 +1518,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_RCVMARK:
 		sock_valbool_flag(sk, SOCK_RCVMARK, valbool);
 		break;
+
+	case SO_RCVPRIORITY:
+		sock_valbool_flag(sk, SOCK_RCVPRIORITY, valbool);
+		break;
 
 	case SO_RXQ_OVFL:
 		sock_valbool_flag(sk, SOCK_RXQ_OVFL, valbool);
@@ -1947,6 +1951,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sock_flag(sk, SOCK_RCVMARK);
 		break;
 
+	case SO_RCVPRIORITY:
+		v.val = sock_flag(sk, SOCK_RCVPRIORITY);
+		break;
+
 	case SO_RXQ_OVFL:
 		v.val = sock_flag(sk, SOCK_RXQ_OVFL);
 		break;
diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f..79d08b734f7c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1008,12 +1008,23 @@ static void sock_recv_mark(struct msghdr *msg, struct sock *sk,
 	}
 }
 
+static void sock_recv_priority(struct msghdr *msg, struct sock *sk,
+			       struct sk_buff *skb)
+{
+	if (sock_flag(sk, SOCK_RCVPRIORITY) && skb) {
+		__u32 priority = skb->priority;
+
+		put_cmsg(msg, SOL_SOCKET, SO_PRIORITY, sizeof(__u32), &priority);
+	}
+}
+
 void __sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		       struct sk_buff *skb)
 {
 	sock_recv_timestamp(msg, sk, skb);
 	sock_recv_drops(msg, sk, skb);
 	sock_recv_mark(msg, sk, skb);
+	sock_recv_priority(msg, sk, skb);
 }
 EXPORT_SYMBOL_GPL(__sock_recv_cmsgs);
 
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index 281df9139d2b..ffff554a5230 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -126,6 +126,8 @@
 
 #define SCM_TS_OPT_ID		78
 
+#define SO_RCVPRIORITY		79
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.43.0


