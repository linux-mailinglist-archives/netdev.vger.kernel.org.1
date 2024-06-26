Return-Path: <netdev+bounces-107049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01D91984D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B78E2864A5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB9192B61;
	Wed, 26 Jun 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IDJCtfN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414831922FB
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430455; cv=none; b=uDhfJ+QS9WT2D4tVOZTqPjk+3xd0M/IP5TmQasYmg4Z2UZVZKtbP7TFcM3/pU8x04O543HnLN93LVH44LgOGxUzaEBx1yQM5s6yd+HSPMjDGjO7rN5K1dFIiQe0xb9gInVmiHysQvoUmv9KIt2+O9Eu8FgBX2AtWmnb6rymgzoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430455; c=relaxed/simple;
	bh=FEWr2EERd6GJQ+Iezz/TtEgJb3LtqCl8v9s45kJ6oo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RE51KRmm0AYW4KZDBN4e8XbhP0rbTXAueTUFtYio/14jw9oSHzU3lSpymvcd1MI8QPvSOkESaBa5bD8XAWab+8L7dWLT1dXKQvY+EeK3wbTqDypBYh5IEZi8mPvVT9sQ/no2nJ2j13x3mPpu4UXevwT4y4DUkZnsGlao6xe2S9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IDJCtfN7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b4febddfd3so32682566d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719430451; x=1720035251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4AFgorcTiGvVwLshUYUFIPxmEyC/yndHcuM4/2TN4s=;
        b=IDJCtfN7hslL+RF78o7U03W56M27UYkBsBvq88rU2GJO5luN5ukjWj13SpSq4Wudfj
         YI6nRomU4M9i0QevLrH2/W2sLzE9yKP8x+oSWwPY7H3b1CXpIu4hUoPG+/jAgL++US7y
         ci+cVSgRo7FKZ6zNrk02z8Z6PCcHq/otKkOd7tQKespka/h7e/AZkuaeaRW+eYYVpPXc
         CnwOWwhS4lbfzQNRuk6NNBrRXtvAhV6edJt7cnOOE2XFgI2iXmNlXUQIS+i1QVFTTpGb
         KDgBRlOBJsqjtf5qQWSxAQTNL4wDSbKmBzb6Iy2LbGzHA6XN6viSN38I/Mprk2W8CLdH
         coIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430451; x=1720035251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4AFgorcTiGvVwLshUYUFIPxmEyC/yndHcuM4/2TN4s=;
        b=EWt3AR4k6OYflrutI2oFd5tBrH7A0KNwK1n+vEZibRQ3zmoVWwODopoBtceGOeZj3W
         MFHd6Qg74k4zU0WQT2K7TFKbJPwh/PIQXb1FWEprRNIWWHftkwV3aRe8IZtnLh4PaRGe
         ybMi1im89VbuxcubuSkY/heP3UCQOdS8oOTzMin24qNi7umB/beUZTVWhA2iI3opTmid
         Njo8jhIwqG3nawUCvFDS1kSyha5qdStnRTc6BJ8ygbRVi9FCEBm2Nwz7dLOs1PbBDhKi
         yS7clsvU/nHAbvd7b9A1nrkuxzpeUawfiz0Ar/tqeqaMOkPdkXK0XMUnLEoHgiVqt57k
         ITVw==
X-Gm-Message-State: AOJu0YwShAE5T7h3oat6B0BT2rEB1uXn0SBiFpiMlYWOgvRDNSst4zOO
	nNLz3bzgQkzmutG9DOwkOvnF/h+BD86kuTcDuOrzx52xk4l9P4wQv2zAu75dQslryEKLTixucbP
	u
X-Google-Smtp-Source: AGHT+IEaXmNUcIXz5KNaEjd7nPiH0XLdNTKiPxzOD4W9OzzBbZJL7p3Uj47RxnBHhK4tQ7L2Atxw2Q==
X-Received: by 2002:a0c:e910:0:b0:6b5:4aa9:9682 with SMTP id 6a1803df08f44-6b54aa99d93mr89762796d6.41.1719430451043;
        Wed, 26 Jun 2024 12:34:11 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b53df48dedsm40112286d6.67.2024.06.26.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:34:10 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v6 3/4] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Wed, 26 Jun 2024 19:34:02 +0000
Message-Id: <20240626193403.3854451-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240626193403.3854451-1-zijianzhang@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
However, zerocopy is not a free lunch. Apart from the management of user
pages, the combination of poll + recvmsg to receive notifications incurs
unignorable overhead in the applications. The overhead of such sometimes
might be more than the CPU savings from zerocopy. We try to solve this
problem with a new notification mechanism based on msgcontrol.

This new mechanism aims to reduce the overhead associated with receiving
notifications by embedding them directly into user arguments passed with
each sendmsg control message. By doing so, we can significantly reduce
the complexity and overhead for managing notifications. In an ideal
pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
msg_control, and the notification will be delivered as soon as possible.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/linux/socket.h                |  2 +-
 include/uapi/asm-generic/socket.h     |  2 ++
 include/uapi/linux/socket.h           | 10 +++++++
 net/core/sock.c                       | 42 +++++++++++++++++++++++++++
 8 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..7761a4e0ea2c 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION 78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..89edc51380f0 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION 78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..2911b43e6a9d 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,8 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SCM_ZC_NOTIFICATION 0x404C
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..dc045e87cc8e 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,8 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SCM_ZC_NOTIFICATION 0x0057
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 35adc30c9db6..f2f013166525 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -170,7 +170,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 
 static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
 {
-	return 0;
+	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
 }
 
 static inline size_t msg_data_left(struct msghdr *msg)
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..7474c8a244bc 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION 78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..26bee6291c6c 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SOCKET_H
 #define _UAPI_LINUX_SOCKET_H
 
+#include <linux/types.h>
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
 #define SOCK_TXREHASH_DISABLED	0
 #define SOCK_TXREHASH_ENABLED	1
 
+#define SOCK_ZC_INFO_MAX 16
+
+struct zc_info_elem {
+	__u32 lo;
+	__u32 hi;
+	__u8 zerocopy;
+};
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 4a766a91ff5c..1b2ce72e1338 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2863,6 +2863,48 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_ZC_NOTIFICATION: {
+		struct zc_info_elem *zc_info_kern = CMSG_DATA(cmsg);
+		int cmsg_data_len, zc_info_elem_num;
+		struct sock_exterr_skb *serr;
+		struct sk_buff_head *q;
+		unsigned long flags;
+		struct sk_buff *skb;
+		int i = 0;
+
+		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
+			return -EINVAL;
+
+		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
+		if (cmsg_data_len % sizeof(struct zc_info_elem))
+			return -EINVAL;
+
+		zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
+		if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
+			return -EINVAL;
+
+		q = &sk->sk_error_queue;
+		spin_lock_irqsave(&q->lock, flags);
+		skb = skb_peek(q);
+		while (skb && i < zc_info_elem_num) {
+			struct sk_buff *skb_next = skb_peek_next(skb, q);
+
+			serr = SKB_EXT_ERR(skb);
+			if (serr->ee.ee_errno == 0 &&
+			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
+				zc_info_kern[i].hi = serr->ee.ee_data;
+				zc_info_kern[i].lo = serr->ee.ee_info;
+				zc_info_kern[i].zerocopy = !(serr->ee.ee_code
+								& SO_EE_CODE_ZEROCOPY_COPIED);
+				__skb_unlink(skb, q);
+				consume_skb(skb);
+			}
+			skb = skb_next;
+			i++;
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


