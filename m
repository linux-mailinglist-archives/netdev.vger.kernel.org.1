Return-Path: <netdev+bounces-89751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B988AB6A0
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 23:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CB21F22F44
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596B13D249;
	Fri, 19 Apr 2024 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YwlKupJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25A13CFA7
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563311; cv=none; b=qFRsFoSPJXTd9ayAboezdClfqaxWeBkhEO/0Nc4dVaYcEHRGDnnYwQa4W10yqEpA/ijlaA3iNM4MgVKsQu+nf0emyyULjJO5CboDVQ9q/axGfcM5OqAq93jmBsk/gyKowDtuqks6a7Aty+PsUG8PhSRABrNJpw9D6ntRM+dK92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563311; c=relaxed/simple;
	bh=27dDV2+hcSergvTkiDbgg6Gzr8j20a9omaPrucnV/KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKTP2fmYdnZxrcmYfB5GFYzwLwBgV2qlXm41PQi1DMzTDUSTX4xjL1j9tJedFoZ0uh1VvL4uKWW/o4HxLpIRvdZYkHIgGShlfYZmpxnCqC2Ve8i8hY9T7DAZndpwi9OelNc0UqPiJS9sA6vrH3AcM4Ye74jBd0F3Po9V2RAwXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YwlKupJ3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74435c428so2729211276.2
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713563308; x=1714168108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ8EyOML5tOe6Fqb/5cPCFDvCIFtk8FIAkixbWgIWbo=;
        b=YwlKupJ3fg0s5HGOINxz1IZeusRC8lnn/OxPM6vYeVWf2z3vNOM68BToFGYueOXsnB
         DwaBcLXh4nnITJQdrBqyVgZb7HMK1Ccg0/3aB2gjvPvMtWFKKl0IPO6gF7T4HUB4UmUo
         +y0x6Sa//XcSqm6ELRwyBA5FIViF16eWaadSx4W2jiHxIwt61QIIpvDG0hty/qUXpKWi
         Twwl61facPVM8074QaBCY5wlXaxvOP11+CkzvIkfiOfqm8jjYZi/ErboRvyMsfohDWcv
         xAhXCWf3ULTiTsEuIkyX2DUKGVjN29JOKd0A2EPvF3/k0NU8m6jTnVQqv9HmU/uw7/Aj
         ITig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713563308; x=1714168108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ8EyOML5tOe6Fqb/5cPCFDvCIFtk8FIAkixbWgIWbo=;
        b=eHWSN4L5z36WSR1YD/d8QBD+bGMHHcol0wqvKFxo4JC7RffOKBlMllvh4km8Qy3MLF
         MCv8lp/iZVimi155bwSCWyxF7Yv9OD9Tase6xEMkfm0rG39yi4a12SlHcUNtDHkKbN3O
         8FLmCfoLuOVvdVVMLud6T1f8LpUa4DtRWPCA2fm/PY6ReHtafKpLZ3Yhb6QEVKI+6gtS
         dILTV9GkNrVaUd3sVd3joSQQ+uVAp2FVoqbqcb9vVpWCRgra1dhKWyppW4EPl5T90RmQ
         qyD6CAUFOlWY66CiE4BrxkiMstgNaiuf22DE6tm6MSVDDxCyoPAyfsUaRAM6NQiiS8Jv
         Bxcg==
X-Gm-Message-State: AOJu0YzUzPUtSpGDt9sSe7Lmal8cU1tf9yl5kmDNjIgr63XRZLbKo061
	9Nxl2018hLKYfthfEok1+dcrodnu/o0FXuFiB89w4BFCZsDLRs02FpQCLAYkxyye0Wbx+8d0JDr
	9
X-Google-Smtp-Source: AGHT+IH/ZoMtsicY1i8XsT8ZGsmAUE9Ytgbki6F6zrC3xFAqrPtcWOzKyC8Je7Ijl2hV3Z6oYIo8Zw==
X-Received: by 2002:a5b:94d:0:b0:dcc:588f:1523 with SMTP id x13-20020a5b094d000000b00dcc588f1523mr3344046ybq.49.1713563308062;
        Fri, 19 Apr 2024 14:48:28 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id n11-20020a0ce48b000000b0069b6c831e86sm1897511qvl.97.2024.04.19.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:48:27 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v2 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Fri, 19 Apr 2024 21:48:18 +0000
Message-Id: <20240419214819.671536-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240419214819.671536-1-zijianzhang@bytedance.com>
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
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
pattern, the user will keep calling sendmsg with SO_ZC_NOTIFICATION
msg_control, and the notification will be delivered as soon as possible.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 +
 arch/mips/include/uapi/asm/socket.h   |  2 +
 arch/parisc/include/uapi/asm/socket.h |  2 +
 arch/sparc/include/uapi/asm/socket.h  |  2 +
 include/uapi/asm-generic/socket.h     |  2 +
 include/uapi/linux/socket.h           | 16 ++++++
 net/core/sock.c                       | 70 +++++++++++++++++++++++++++
 7 files changed, 96 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..b24622a9cd47 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_ZC_NOTIFICATION 78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..638a4ebbffa7 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_ZC_NOTIFICATION 78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..393f1a6e9562 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,8 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SO_ZC_NOTIFICATION 0x404C
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..4fe127b0682b 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,8 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SO_ZC_NOTIFICATION 0x0057
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..acbbbe7ac06a 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_ZC_NOTIFICATION 78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..60e4db759d49 100644
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
@@ -35,4 +37,18 @@ struct __kernel_sockaddr_storage {
 #define SOCK_TXREHASH_DISABLED	0
 #define SOCK_TXREHASH_ENABLED	1
 
+#define SOCK_ZC_INFO_MAX 256
+
+struct zc_info_elem {
+	__u32 lo;
+	__u32 hi;
+	__u8 zerocopy;
+};
+
+struct zc_info_usr {
+	__u64 usr_addr;
+	unsigned int length;
+	struct zc_info_elem info[];
+};
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index fe9195186c13..13f06480f2d8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2809,6 +2809,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc)
 {
 	u32 tsflags;
+	int ret, zc_info_size, i = 0;
+	unsigned long flags;
+	struct sk_buff_head *q, local_q;
+	struct sk_buff *skb, *tmp;
+	struct sock_exterr_skb *serr;
+	struct zc_info_usr *zc_info_usr_p, *zc_info_kern_p;
+	void __user	*usr_addr;
 
 	switch (cmsg->cmsg_type) {
 	case SO_MARK:
@@ -2842,6 +2849,69 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SO_ZC_NOTIFICATION:
+		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
+			return -EINVAL;
+
+		zc_info_usr_p = (struct zc_info_usr *)CMSG_DATA(cmsg);
+		if (zc_info_usr_p->length <= 0 || zc_info_usr_p->length > SOCK_ZC_INFO_MAX)
+			return -EINVAL;
+
+		zc_info_size = struct_size(zc_info_usr_p, info, zc_info_usr_p->length);
+		if (cmsg->cmsg_len != CMSG_LEN(zc_info_size))
+			return -EINVAL;
+
+		usr_addr = (void *)(uintptr_t)(zc_info_usr_p->usr_addr);
+		if (!access_ok(usr_addr, zc_info_size))
+			return -EFAULT;
+
+		zc_info_kern_p = kmalloc(zc_info_size, GFP_KERNEL);
+		if (!zc_info_kern_p)
+			return -ENOMEM;
+
+		q = &sk->sk_error_queue;
+		skb_queue_head_init(&local_q);
+		spin_lock_irqsave(&q->lock, flags);
+		skb = skb_peek(q);
+		while (skb && i < zc_info_usr_p->length) {
+			struct sk_buff *skb_next = skb_peek_next(skb, q);
+
+			serr = SKB_EXT_ERR(skb);
+			if (serr->ee.ee_errno == 0 &&
+			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
+				zc_info_kern_p->info[i].hi = serr->ee.ee_data;
+				zc_info_kern_p->info[i].lo = serr->ee.ee_info;
+				zc_info_kern_p->info[i].zerocopy = !(serr->ee.ee_code
+								& SO_EE_CODE_ZEROCOPY_COPIED);
+				__skb_unlink(skb, q);
+				__skb_queue_tail(&local_q, skb);
+				i++;
+			}
+			skb = skb_next;
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+
+		zc_info_kern_p->usr_addr = zc_info_usr_p->usr_addr;
+		zc_info_kern_p->length = i;
+
+		ret = copy_to_user(usr_addr,
+				   zc_info_kern_p,
+					struct_size(zc_info_kern_p, info, i));
+		kfree(zc_info_kern_p);
+
+		if (unlikely(ret)) {
+			spin_lock_irqsave(&q->lock, flags);
+			skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
+				__skb_unlink(skb, &local_q);
+				__skb_queue_head(q, skb);
+			}
+			spin_unlock_irqrestore(&q->lock, flags);
+			return -EFAULT;
+		}
+
+		while ((skb = __skb_dequeue(&local_q)))
+			consume_skb(skb);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


