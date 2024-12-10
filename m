Return-Path: <netdev+bounces-150811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D199EB9E4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAC91677A6
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0E214231;
	Tue, 10 Dec 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTmG0vJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E972214225
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858033; cv=none; b=VMmQunyH+R1H8nKpKMZ5W4aWrhqH8wGidWi47S8YTEFdc37kpbmwximvjMfVbAamKoHxe87KIQMVRaFa0ejl8LMNWty+UIep1Lvsh8VxnJlZj/MpqA0gPnrxP0svch+YkX4ZALOtnnNcXyS7clHmcYEj0H1BVvWXoalOAfbbGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858033; c=relaxed/simple;
	bh=bKHfseLrLFam+t0l4K7cSgf5MpnHwyP6kMNZLJ8EnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LegNJXdfFZ79S16zD6Gpw9q4E4Xick+fqseL4erkzBnW6iW4mcluF/ROElwy8skdhb9z29cO9fnnh/061tQTIhHkY4gDX6QnKWFi2TZgPMNy99dnbcjfg/9Rax14Hr8L65LVpJiSTYON8+OtSGDUaeY13s3D5JGL9PEsNey0woA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTmG0vJH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434f09d18e2so34288605e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733858030; x=1734462830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wy+YHf2E614t23hlQRqaAuPuP0RfmetGDSjCxDtFm8=;
        b=TTmG0vJHHMpGu5Yog/Anu638YCoNFSosDNch4FXnEaLAMZiyZqzOXXvvEqbmNrYfM6
         d3b/wUdhu3sw/g/PkbriRcUvpv4yZNp3lYSWE2BkMELbBtQlH92eZnX/AMHQ6OYyeSyx
         oWGptkOKEVPsbvp6NaxP2Q7UK3HltVlnMTgwnCpnmv3jHEzebkrmT/KtTonJ7+FNXcXt
         49Blg8sGnre1Wlxcg3f2dR1M2YCYqY6KA5citGeWTr1Nx4yPkeIURYphYnowANP+mqGo
         56HWYGejv3/b3vq7AEJGy+P+vGK5E4TvKjlD979kLaHgh5JRgkOQIcJIaaQhCrhRbxrM
         cwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858030; x=1734462830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wy+YHf2E614t23hlQRqaAuPuP0RfmetGDSjCxDtFm8=;
        b=LjjDy3fRrcLmT0uAENtJaZM6/SoMawC0s13rhZ4FShRuyT6V3wBst7N2yuzWlY7QqT
         jc/Xefg1C5OL7OwnZ5ulkr7/NvJagT910GWBO0PZliFSi7aenAUBN/m1ysJgjoNkEWVx
         OYF1n5Dh7ugn+BuU0u3CpZIawZ2svDm2pNRqqI0C3YmUWGD+ZDKzh17TiY50IQrwGknQ
         ERsJvE/qDU1QzcXdytkHHqQq4hp/RByUvHeeddyqt5zS4/LSbny14bhNFLoL3Iv1Xkyc
         QWiE1jLJ3gj4o07jLFrUbcsT1Hj5kEtsD+CObzwhy8op4t5M+YKBkAIoFc+QXN4Ixvpe
         OnOg==
X-Gm-Message-State: AOJu0YwguksEjW+iNFBiJ8/KFZJdXMYB7WpiY68t8ucj+3/eA/kDlA7F
	fWzR9EPWgunjifkTEg1KBXB0ij7N070G3i7AJ0Zpnf7uu0mPxVR8Bk+nkc7RES0=
X-Gm-Gg: ASbGncvRghgkvOHOjprIpOKWYi5PgFpYoOmqQrga0XKFapk4JtnvsfE6Tl9h3RKHGHp
	V2sivr2f4odhVJpxOSTrtni8k5/y8rds7jcOBDm9LrxnpWDxsTcI47o8xdchw3tNDOgF2qiLQXt
	19RJ8lr9ea9uV7bf6AkxQPoA0siHHw6vYZribd4aXeEscpEhEl0oiAhVVs5KBsuu0fuFqztx3uX
	mGrWkctdAx19bUrNb6i/z3OFSonfjCJR/EvXGp8USJmJyKwgnpWVcGUTlvbJiZx+qF7T9/H3cjh
	ft/mtxoEn1DVDQLeESCFlzLxAqn8RuiaZDE9DTeglPCr+NNbP+zRZLMcWGjr8Q==
X-Google-Smtp-Source: AGHT+IGqyygePq7AWxbGdP2on+xJnc/3BqHNzcKO/J87G2iyLWdSSTHylNPnue+AQC8ep2xHKPBeVg==
X-Received: by 2002:a05:6000:440b:b0:386:3825:2c3b with SMTP id ffacd0b85a97d-3864ce96b85mr167776f8f.18.1733858030082;
        Tue, 10 Dec 2024 11:13:50 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C7006406573B5E53AD5C.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:6406:573b:5e53:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13310345f8f.108.2024.12.10.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:13:49 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v6 4/4] sock: Introduce SO_RCVPRIORITY socket option
Date: Tue, 10 Dec 2024 20:13:09 +0100
Message-ID: <20241210191309.8681-5-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210191309.8681-1-annaemesenyiri@gmail.com>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

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


