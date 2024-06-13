Return-Path: <netdev+bounces-103422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427AA907F69
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFB71F23CD7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895F156863;
	Thu, 13 Jun 2024 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T/p00Dgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC815539A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321505; cv=none; b=LWrjzUhq9+uzGH2PloL3Diow1YtetXryDDh49WrVRaHrs+Onw+tsUVoBEDoxYhvQYTTHcTyVkr/AogthfAzlVt/w3rSAHL4uYO+EuopoTClaTvlolmk+35T9cGeQgM9x0nj2EhsdkcX839bSc02Tc6pN6Y5BLGxE7wbnvdp9rBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321505; c=relaxed/simple;
	bh=WzlwFsEv9w7LqbUcSSdQX4ToDtf6xWdluWXCCxpla5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnlRflsvUxcMQq7wU3hvqhUNNQ4y77CpyucAoJgzIxd5WXXnws3oam1m5VGS8XBYcaL9HgbDn3g6oxBe0HRzExKJHIWf7I6J5h3COlfou8P2J4zGv7SMNjptA1x1OhPVMuSPhL990VzwZ0bNlMwDSv+LnIW9T7XKJ6XzV4i2/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T/p00Dgp; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a08092c4dso16809817b3.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718321502; x=1718926302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaVZORN1j0nvMl4WsYSKuVepgrGQPkpPHhBQuRfTtcQ=;
        b=T/p00Dgpwzo3juyIKh34jQHGfjBKdg8lG6jf2VskWLYHLBu8hvQUzS+mU2NV/rklDf
         6+/2EatHyUIsnM9U7hXlfyQcg+nio9RH61fZKKVBkuWYv+/CWUagCthwJMKHmlGQMkim
         GK/wxgeqSk4DHtSjsNiPnDpDlPrnJnI0PBGA84cA2AZ75pFKs7o0r4X9sePMCrkVV5tT
         lowqjkerNHoG3hrlkmHKpNm15hOUd/8Kqq3ds7//VlHcDe6RRz6g7ZbCmdoqMglxV3ua
         wEgnhDCbrCLZBArJkIIDzAvewo1hcxP9bSoHCFGYp282BfiYvjDFTqHa3q8A/2HD9sAk
         /bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321502; x=1718926302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaVZORN1j0nvMl4WsYSKuVepgrGQPkpPHhBQuRfTtcQ=;
        b=efh3u3P2IVDLTfUzYq7vPHHKMJfUk9lX9I4pkIWypsJBZ4di7J/Vigpdb9QW/3XKz9
         GTqRbQot1MplBCQid3gLTGbhcguctpLWmI46f5Hvgs1VTlehdhvx9Y/Gi5m4E/xwjavj
         on5lT0kX6jaAqBECuGt6yNA6ePpE57uzz6HogAOSTuRfpSAZhvS+D90EG/tAF7d3rTJ3
         /rvniHSGuGUmKuPCedo2ekKbF35Is3Dp577ExzCum4NlJUYpGWAIICs+ylt+GqzEgWd+
         dcDCqvw+YepbdhnvIalVn4yHZIkwkxd6u54Lhokv8CgnWs1CvVf1JC3inIHnX58b++5B
         1tQw==
X-Gm-Message-State: AOJu0Yxb1HKrlYsXU8lDcVG5BwjvHPZCJpJPju7RAiMC/EUKFsL4QWTe
	wrQCBujqGh66rgAeI9cpOqD7jecrd/nmVBZtWcadHhDPizqVHabAbFI79PpkleuJ0onw1KMjgV9
	v414=
X-Google-Smtp-Source: AGHT+IG78J8xgX2rJKMezh3c7CSxiQaKoHZ+wjp20/3COi96NO9K2DHe7xnuYyU7iTp9b+u7e3jS5w==
X-Received: by 2002:a81:f90d:0:b0:627:de70:f2f8 with SMTP id 00721157ae682-63222956691mr8997837b3.14.1718321501736;
        Thu, 13 Jun 2024 16:31:41 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d8b62sm10586731cf.11.2024.06.13.16.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:31:41 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v5 3/4] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Thu, 13 Jun 2024 23:31:32 +0000
Message-Id: <20240613233133.2463193-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613233133.2463193-1-zijianzhang@bytedance.com>
References: <20240613233133.2463193-1-zijianzhang@bytedance.com>
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
 arch/alpha/include/uapi/asm/socket.h  |  2 +
 arch/mips/include/uapi/asm/socket.h   |  2 +
 arch/parisc/include/uapi/asm/socket.h |  2 +
 arch/sparc/include/uapi/asm/socket.h  |  2 +
 include/net/sock.h                    |  2 +-
 include/uapi/asm-generic/socket.h     |  2 +
 include/uapi/linux/socket.h           | 10 +++++
 net/core/sock.c                       | 63 ++++++++++++++++++++++++++-
 net/ipv4/ip_sockglue.c                |  2 +-
 net/ipv6/datagram.c                   |  2 +-
 10 files changed, 84 insertions(+), 5 deletions(-)

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
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index b30ea0c342a6..f31c67d15c35 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1799,7 +1799,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
 	};
 }
 
-int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
+int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc);
 int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
 		   struct sockcm_cookie *sockc);
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
index 69baddcfbd8c..d7d029f9aa0a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2826,7 +2826,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 }
 EXPORT_SYMBOL(sock_alloc_send_pskb);
 
-int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
+int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc)
 {
 	u32 tsflags;
@@ -2863,6 +2863,65 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_ZC_NOTIFICATION: {
+		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
+		int cmsg_data_len, zc_info_elem_num;
+		struct sk_buff_head *q, local_q;
+		struct sock_exterr_skb *serr;
+		unsigned long flags;
+		struct sk_buff *skb;
+		int ret, sz, i = 0;
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
+		skb_queue_head_init(&local_q);
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
+				__skb_queue_tail(&local_q, skb);
+				i++;
+			}
+			skb = skb_next;
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+
+		if (i == 0)
+			break;
+
+		sz = i * sizeof(struct zc_info_elem);
+		ret = put_cmsg_user_tx(msg, SOL_SOCKET, SCM_ZC_NOTIFICATION, sz, zc_info_kern);
+
+		if (unlikely(ret)) {
+			spin_lock_irqsave(&q->lock, flags);
+			skb_queue_splice_init(&local_q, q);
+			spin_unlock_irqrestore(&q->lock, flags);
+			return -ret;
+		}
+
+		while ((skb = __skb_dequeue(&local_q)))
+			consume_skb(skb);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -2881,7 +2940,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
 			return -EINVAL;
 		if (cmsg->cmsg_level != SOL_SOCKET)
 			continue;
-		ret = __sock_cmsg_send(sk, cmsg, sockc);
+		ret = __sock_cmsg_send(sk, msg, cmsg, sockc);
 		if (ret)
 			return ret;
 	}
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..6360b8ba9c84 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -267,7 +267,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 		}
 #endif
 		if (cmsg->cmsg_level == SOL_SOCKET) {
-			err = __sock_cmsg_send(sk, cmsg, &ipc->sockc);
+			err = __sock_cmsg_send(sk, msg, cmsg, &ipc->sockc);
 			if (err)
 				return err;
 			continue;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..c9ae30acf895 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -777,7 +777,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 		}
 
 		if (cmsg->cmsg_level == SOL_SOCKET) {
-			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
+			err = __sock_cmsg_send(sk, msg, cmsg, &ipc6->sockc);
 			if (err)
 				return err;
 			continue;
-- 
2.20.1


