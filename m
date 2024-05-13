Return-Path: <netdev+bounces-96166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8C8C48B8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373951F23532
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AE839F5;
	Mon, 13 May 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CkR3ZXeu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106F8287E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635088; cv=none; b=DZpznBWQWc8X3mzQEoAdkW4eB8UFZR3q1NcbBO71S1CC5N1J5ptX5c/Kg4OhYpXVqtk8AcBQ0vkchpRQ0gh97LjEWqpd+KIU8MGLiiIw8eFfpSqbr58cGktERtCrXteHBUI7BCvmkNPz1KxbkybcV/4cYlYXHc6yQYYIGimQ3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635088; c=relaxed/simple;
	bh=D5CwM1zLihZr1ncMejfbrURfB0Wr3nGe8hLOMwDf2F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kelvje/fOztzdsxsnWMSi9kkhJio8KEYlN2Q1zy7Ohqi3E7BBeKidhs4rJBTaVXccAF8Z9U5twB7Lp973mjB4H0zIhm/bPLwBbDS0NR/FwsonkcDWL+L56avLG+S+ZurG4+o1X6y0w+N5tJH3pi0+YZ8BylyaT5WneiWyZ2JIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CkR3ZXeu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61bed738438so49546657b3.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715635084; x=1716239884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xrJ0Hjkib/Aqyz9aStozV3dkl0zmuhlShNv7pOvhE0=;
        b=CkR3ZXeuUTRd7B5HXr4wrpoZZ/WqOXZiMhGG2SA5znVWpp2cSw32Zdianxju6ozurE
         LSDi+wNe9oPCrptKhicZ+eJsIUyz2/gH4CrT1YlXDte3TjYtBwwaQ4gVqpt1W4USygBK
         zoLgAYa1qFnQwZ86kP4Fk4X7nLILPJwO0BP7ICPd2W/xEMD5Y07Ly4bYnczyEceXaG1m
         3xSzs/daNiJ89OzPgUj70pJa021MxQCcYZMV+LsWy2bcS9J1p+NGqPSUfgE+vwuhRm0p
         y91WeF0x/7dVQM+oyJuRspKQAahn7qy+E4AVUz8/D0pfuqjqTzsf5T52kEOGXrtItcWB
         jMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635084; x=1716239884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xrJ0Hjkib/Aqyz9aStozV3dkl0zmuhlShNv7pOvhE0=;
        b=lGw6oq4gyh4UjWBff31Me4KNSCFSUtqmRmFICrIxp4zHE1qXByWf/oOMM51z1NZBnj
         LJTbQq0Np3hegze75hw8zM9rVnhGL2MohsHkMSk/EBl3wNbKrPFyPY9t8ZPzqauRXYhD
         gxuudMfzBkrHLkMgiYyM/g5rUsnfVr0d7c12fwh8Z361Gt2G5OskKDp1dOuu9zZcftpY
         C4hSSovdAY8mRqE5v3vz9ELLpevc64SIKZyfhXCuYK1jlDnL99DoTvuEcpFbQ9MyrgTN
         ORDWD2TMCIb+FeVptaPTN6hmSM51CKWMybwWMTlwQlcdfbTRYMuihOOJA5xceDgcb8pN
         74dA==
X-Gm-Message-State: AOJu0Yya2VRVlvq5SzRe9Iwrn45XQnnVbJLnwFswXpZZLuh+tFyORDsW
	jMLdRyBDke/CNet2rVUaL8nbiKYJsODzYcaTHconCPqmiOLFTmTU8TE7z3VFWQKPREapXPV2xrg
	/
X-Google-Smtp-Source: AGHT+IHkaJdGtVBzdPjvRQSowjlaIJy1cUAS9MjWidrEesguJV0ywL3x//oO9s67GnH8pUb9CnvdsA==
X-Received: by 2002:a05:690c:b18:b0:614:8185:2946 with SMTP id 00721157ae682-622cf345ef1mr63555977b3.42.1715635084518;
        Mon, 13 May 2024 14:18:04 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e184af783sm18340811cf.17.2024.05.13.14.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:18:04 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Mon, 13 May 2024 21:17:54 +0000
Message-Id: <20240513211755.2751955-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513211755.2751955-1-zijianzhang@bytedance.com>
References: <20240513211755.2751955-1-zijianzhang@bytedance.com>
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
 include/uapi/asm-generic/socket.h     |  2 +
 include/uapi/linux/socket.h           | 10 +++++
 net/core/sock.c                       | 65 +++++++++++++++++++++++++++
 7 files changed, 85 insertions(+)

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
index d3fcd3b5ec53..16911bca45f3 100644
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
 
+#define SOCK_ZC_INFO_MAX 64
+
+struct zc_info_elem {
+	__u32 lo;
+	__u32 hi;
+	__u8 zerocopy;
+};
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 8d6e638b5426..eafa98c70d9a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2842,6 +2842,71 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_ZC_NOTIFICATION: {
+		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
+		int cmsg_data_len, zc_info_elem_num;
+		struct sk_buff_head *q, local_q;
+		struct sock_exterr_skb *serr;
+		struct sk_buff *skb, *tmp;
+		void __user	*usr_addr;
+		unsigned long flags;
+		int ret, i = 0;
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
+		if (in_compat_syscall())
+			usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
+		else
+			usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
+		if (!access_ok(usr_addr, cmsg_data_len))
+			return -EFAULT;
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
+		ret = copy_to_user(usr_addr,
+				   zc_info_kern,
+					i * sizeof(struct zc_info_elem));
+
+		if (unlikely(ret)) {
+			spin_lock_irqsave(&q->lock, flags);
+			skb_queue_splice_init(&local_q, q);
+			spin_unlock_irqrestore(&q->lock, flags);
+			return -EFAULT;
+		}
+
+		while ((skb = __skb_dequeue(&local_q)))
+			consume_skb(skb);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


