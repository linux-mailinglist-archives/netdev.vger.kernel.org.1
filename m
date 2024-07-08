Return-Path: <netdev+bounces-110015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6544C92AAE3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882D81C219B2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF114E2F6;
	Mon,  8 Jul 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OmxYzJAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F614E2F9
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472778; cv=none; b=YBLT3QQHsh5doJjDHPWcp4JF9yOPVVYn0OB/fF3lSkVMPHZu/CqYp++4aTdiD9uek85HcXQP6iI+pXMm4Pd4kTJYHFgI1bhphpWR6eqdDeDRPyt5NxjlfVaW9gxYnOSy+SP39QjmUc+nlDuDSlyb75sXrh825tui1kGu/BGti/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472778; c=relaxed/simple;
	bh=HFy0s1s103d+p7gb8OsrS2j+Hy7FEkucKo81DlyGm7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzSRO1/atk+xohhToHTfWCX/eZxOCecHP6ZCYdRW57nLvGK8DAfXd4XcU831P4FYTkBFO9BcPyu+0Maja6VjdHwlElXLodOEcxcSc4T9EXmPnFKwlogiFbcNPJxYHofauRL1LdLiV76bTfQr43XFFD/jqPzLXqskvq1mBRAizJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OmxYzJAP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f190d8ebfso24718085a.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720472775; x=1721077575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QevkCAQsvPXNjVWJix+AsF4hLyLcr1BV78IDym4Fwz8=;
        b=OmxYzJAPrK4mHB30NO3rrRx73VC27+XSOwVKMbfD77K5hZJ/MifvcitV4BYB9NR+DK
         +miG/NaEWxnGYsUG7B+1YkySSFF+TerZ1ZqyQV05VONqjBY9qasDVqSLPRbyYaEk7fNb
         YdEf4oUWqptlmUUWKh6BL2a4rEJurMjwi0ani0tpZ0YEXnoOMHk55M51S5e/q+TgBle2
         B7yVfce+lcbU0EIEB046ZpmltoHlh8qTG64uwmxqdor9tZ6TVFqWFSy2jS8eNN+Ga4v+
         7nKxJPO7lBf+SVx4Fg/dhzUvzqMkQPF+dPznR1tbdhVcOUtMD0iImphL750bOx15plPr
         Q+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472775; x=1721077575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QevkCAQsvPXNjVWJix+AsF4hLyLcr1BV78IDym4Fwz8=;
        b=NZ3M34bq3UfBmvdyIdMQeVnTo5Eg7IT0KdQFM6qtit1tAqSnKd4fM/oNzjyYTJb5RB
         E5xaAKSohr4yHA03CdLLf5sfVsj9K/V0UMJChYT+uguSWhPZOpy1GGW8JZpHlfBMhdql
         qLDY3zzs7AzNY6vw1sK2QE86vfGk2SW9TNEKipzLPuZTh6mS12RA1nWCR6Xv1YKSXfDC
         uJewGRJRHvOLHUNqpYgPKEbQqROPINKkvot+4G30pMwoPqXdzhWmGsXUX03pD/5twxQf
         etOJBq16goL0GtZNE6HRuAGKPkwT615XKivq6Ds5sfX8zUA6Z/13TEpIVDnUOyY7anp/
         92pA==
X-Gm-Message-State: AOJu0YyLbixNMAoV2l/R3pqpZU6aob8Hr/WUze3YSYn19AvjSVZytpSR
	e44Sw9HjxfIc7V35S1QUT9oNmI992ARVwZw1Ujt+kF3ZzLKjVk6/pnwWxe89+L6Vuwuwz4KwQzi
	I
X-Google-Smtp-Source: AGHT+IEwapOFCq9wdvpwYwCDxPNJmJ4sp2dSybtm/oAKoPWYIIUd/j35wNOXZjGBrG1/MlqetFV8og==
X-Received: by 2002:a05:620a:e02:b0:79f:433:6e7f with SMTP id af79cd13be357-79f19a1344bmr72818285a.21.1720472774846;
        Mon, 08 Jul 2024 14:06:14 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff82a7sm28212185a.9.2024.07.08.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:06:14 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v7 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Mon,  8 Jul 2024 21:04:04 +0000
Message-Id: <20240708210405.870930-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240708210405.870930-1-zijianzhang@bytedance.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
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
unignorable overhead in the applications. We try to mitigate this overhead
with a new notification mechanism based on msg_control. Leveraging the
general framework to copy cmsgs to the user space, we copy zerocopy
notifications to the user upon returning of sendmsgs.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/linux/socket.h                |  2 +-
 include/uapi/asm-generic/socket.h     |  2 ++
 include/uapi/linux/socket.h           | 13 ++++++++
 net/core/sock.c                       | 46 +++++++++++++++++++++++++++
 8 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..7c32d9dbe47f 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION	78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..3f7fade998cb 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION	78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..77f5bee0fdc9 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,8 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SCM_ZC_NOTIFICATION	0x404C
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..eb44fc515b45 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,8 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SCM_ZC_NOTIFICATION      0x0057
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 75461812a7a3..6f1b791e2de8 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -171,7 +171,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 
 static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
 {
-	return 0;
+	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
 }
 
 static inline size_t msg_data_left(struct msghdr *msg)
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..02e9159c7944 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION	78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..ab361f30f3a6 100644
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
@@ -35,4 +37,15 @@ struct __kernel_sockaddr_storage {
 #define SOCK_TXREHASH_DISABLED	0
 #define SOCK_TXREHASH_ENABLED	1
 
+struct zc_info_elem {
+	__u32 lo;
+	__u32 hi;
+	__u8 zerocopy;
+};
+
+struct zc_info {
+	__u32 size;
+	struct zc_info_elem arr[];
+};
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index efb30668dac3..e0b5162233d3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2863,6 +2863,52 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_ZC_NOTIFICATION: {
+		struct zc_info *zc_info = CMSG_DATA(cmsg);
+		struct zc_info_elem *zc_info_arr;
+		struct sock_exterr_skb *serr;
+		int cmsg_data_len, i = 0;
+		struct sk_buff_head *q;
+		unsigned long flags;
+		struct sk_buff *skb;
+		u32 zc_info_size;
+
+		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
+			return -EINVAL;
+
+		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
+		if (cmsg_data_len < sizeof(struct zc_info))
+			return -EINVAL;
+
+		zc_info_size = zc_info->size;
+		zc_info_arr = zc_info->arr;
+		if (cmsg_data_len != sizeof(struct zc_info) +
+				     zc_info_size * sizeof(struct zc_info_elem))
+			return -EINVAL;
+
+		q = &sk->sk_error_queue;
+		spin_lock_irqsave(&q->lock, flags);
+		skb = skb_peek(q);
+		while (skb && i < zc_info_size) {
+			struct sk_buff *skb_next = skb_peek_next(skb, q);
+
+			serr = SKB_EXT_ERR(skb);
+			if (serr->ee.ee_errno == 0 &&
+			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
+				zc_info_arr[i].hi = serr->ee.ee_data;
+				zc_info_arr[i].lo = serr->ee.ee_info;
+				zc_info_arr[i].zerocopy = !(serr->ee.ee_code
+							  & SO_EE_CODE_ZEROCOPY_COPIED);
+				__skb_unlink(skb, q);
+				consume_skb(skb);
+				i++;
+			}
+			skb = skb_next;
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+		zc_info->size = i;
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


