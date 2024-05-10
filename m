Return-Path: <netdev+bounces-95532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB58C285E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867A01C2275A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A16174ECD;
	Fri, 10 May 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TtkxjV33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AD173354
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356772; cv=none; b=ReTQqB66U2h44yy1s48ik5r5KqKa+R/O2E9PKPxOyQT/VZgZY0puNm6PKwCvgUXrBFwknT8Ju5gN89kzqNMk9xx36JXaw2HR39rXo5dv2SUpL/Qw/k0/r3AAso3oK+WGxXyffcet5GyGJgu6uWn+DPbigE+gE8ZEMJleVMFRM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356772; c=relaxed/simple;
	bh=18S9LTZioOr8vyhuZZFKi/3v1ZpLd/o3kZArFfN2lZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVQDvYBMbOoGH7+xkrIoLEk92ZRvCCBjaPdv4g7wThEXGyocLB1RBTlSBxUUSfEtvYtRyTavTShGHNPS9khbnNciMvlESaKq94CczezV66Ql8EjSqmk7zKLsjzlZqbVnuJGvcTVX9yZSV47ZXVMRNBGMZLZym00sp2Adt7CrjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TtkxjV33; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de60a51fe21so2186819276.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715356769; x=1715961569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnnGsDOk+brIvVnCkoZvqvDB9cWsR4hPxVXZ4DrMfqo=;
        b=TtkxjV3319DiHv6UnNjzikbuncXmpnttsnRYOllW8++D238Umua0iaZDkIO8KJkz4x
         HK6Bu4vYDBa9MnS2qdXDtiHNDk6YnzXMWZgLwIraoV7Z+nHVyBNnjhpPvSbTus6djjW5
         wVHkxB2Urlyi2UueIWbZkokJ1MDMlMASJXA8mOzfXndQhQKkKMWq9aXwBSassIhe04U5
         QPWHkXaiWLX4uBguoeF3iurYH4RxP8UvWA3txcsxrudFEWibfAHhKrUikZKdV9M/eZEr
         JpByh0Gz53rpV00XaUQGOzTuRt9D2qHRSFfHgaJqRDSCJcv1hxokF3PBML50mGFZfezN
         2pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715356769; x=1715961569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnnGsDOk+brIvVnCkoZvqvDB9cWsR4hPxVXZ4DrMfqo=;
        b=HuwcawYncPreGT7hA+Zmi2qHRiIeSh+zeu6xMp0gcWym3PcJFbDlhOeTGKP3eMsSDi
         aCGPadD9HtB6f9aaVuAcnjrp0GCQ/jQ8uHCwEiS9fqImbpRJwyi0o1EqNRKhtjblxuNU
         2noR9JUxUoTxV7oT5114OUtLpfnVNoq1vrbn2OjfyIZRc2/vVsrPf1NFtF9MN/asNZca
         sLqPWrQl6hbeBxWL8dl6nq2JsSC8OnaFVRA2Pg/GBz2J3TYcaRcZL/vJvT7eif0241dO
         U3UE21nC7hJgyGy6fRFfascMNHUbqhh7R7dX+KkykNvALu8WG3XCVXQ8M+hHnfXeFPfY
         TT+w==
X-Gm-Message-State: AOJu0YyyP+loKIgTjT6q2RTQPy1YSCsitLHXuvbWUszkUE1y5CLPj0Na
	27dzEMibIlBnJ5HRJg2HsymcXdJmbvduLQk5oGfFuDOaAQOitE2ukG5HgksCmsHF4lhuQDJhVSk
	+
X-Google-Smtp-Source: AGHT+IHR8aPK7+kLeSbsBqLWkzGkVp2IJ64uGTZVGpGZV/8RfC4VyZn86gv6ZoFLCWcbmmNW/xcqjw==
X-Received: by 2002:a25:dc87:0:b0:dc6:d87c:fc73 with SMTP id 3f1490d57ef6-dee4f35b7c8mr3549191276.35.1715356769069;
        Fri, 10 May 2024 08:59:29 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf32e705sm191553285a.124.2024.05.10.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:59:28 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v3 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Fri, 10 May 2024 15:58:59 +0000
Message-Id: <20240510155900.1825946-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510155900.1825946-1-zijianzhang@bytedance.com>
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
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
 include/uapi/linux/socket.h           | 10 ++++
 net/core/sock.c                       | 68 +++++++++++++++++++++++++++
 7 files changed, 88 insertions(+)

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
index d3fcd3b5ec53..15cec8819f34 100644
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
 
+#define SOCK_ZC_INFO_MAX 128
+
+struct zc_info_elem {
+	__u32 lo;
+	__u32 hi;
+	__u8 zerocopy;
+};
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 8d6e638b5426..15da609be026 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2842,6 +2842,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_ZC_NOTIFICATION: {
+		int ret, i = 0;
+		int cmsg_data_len, zc_info_elem_num;
+		void __user	*usr_addr;
+		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
+		unsigned long flags;
+		struct sk_buff_head *q, local_q;
+		struct sk_buff *skb, *tmp;
+		struct sock_exterr_skb *serr;
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
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


