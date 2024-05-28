Return-Path: <netdev+bounces-98774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64168D26FD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154E11F249FA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206D17BB1D;
	Tue, 28 May 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H4Ldzn/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF317B4F0
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931296; cv=none; b=nTJ6sKx4j9YMWkJS3M8gVFLr0qalqLNvVIXs0V8wfB7aJrdu1b4qNIngtY37qf3hkdL6BjngJ8U7zbhc73BmtG70rQ+pqh/Z8lk2LDIYIvUyzZZCb7vnfB/7Cn+/yoqgv2FKx5VoQ/WjBu9pv6UOAnMow0UMpHLfTJl6lR13pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931296; c=relaxed/simple;
	bh=ta0Px17Ekd/qP7jcVxp/V+NAEtF2Mcebxi90oqCLlHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iw9PvRqHEZ1q2OVpStde7ihcMO/ycfTTiddthP9qJi1prgG9QC46ILEN4/Kx5Fl5WEvEqISZdMpu7CeGuWBfMv/+PYmqs7P61nMBS6aBsYAJ7MJWladVQzAkFHnzBxhyZ/j/KeTWFFJUwq3qzjiirBsyZZNjngFR5RNmAlAhLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H4Ldzn/E; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-794ba2d4d82so58676485a.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716931293; x=1717536093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+9mokwG2vctTP/n+qmcoDSQAN6t/8AkrkgDXrIIePk=;
        b=H4Ldzn/Eg5lb1JpYTUg5JFIVGAX+hKg80tvPkZ9DPLbVBlSOp4PbpwS1Hhe7NxXpBJ
         wLHUzJmzwbkNDAf8n0TZd8p2fdfobf8CNwbas0EXFNIm1Fjb8AKJWfiHtmoU1oulGi5N
         ulUIuI8L0DuYbR8cyki2o4zl9tCI8YOlsQcHw1Jz7HPrW29zYX0HXDQGoFN3kpOdOnHc
         dmthprSeLJpJKWXIpX2ZRa4tw0bK7kLar4lws3G1y+WmhGiay5DlMO61NrSCkLRUEsjg
         gj/3OlPuhA7g1zgqLniwSPSgUb72sjz1NxEj8aKdaLwJTw1jVVb4538QPs1hQFJHOyoL
         3LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931293; x=1717536093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+9mokwG2vctTP/n+qmcoDSQAN6t/8AkrkgDXrIIePk=;
        b=X6nx+sPPcLGjUAcJeXtdLq1MEq+gM5lXsNnSZrgRaIRrHHRjywXgAecQUJV/RUHlCN
         YAu+q4Ym1E3DMEgtkYrtcDkWGfykUiwZD9mJ2/j4Ze9buYqmTty+CCVDpRoVOERIV6Mv
         guj0qvMP2WI9NzH6qnZ2/FjVh6EDnX0ZMCXV3r39bsYWi3qFyW1W372qLQNSI9430EV+
         /DzlxHg8QdTrfO1aOM848xSEPJNhEZ9C/zUK/wgt3E6q4ac8fXOIp4xlNcFEsriJChuK
         Txh7TAMkvi5/z3ICz8rNz1kODZRR4BTGVYBRXbjOaiJcaAMye6jZv+nt1iVxENu0a3MT
         4Ibw==
X-Gm-Message-State: AOJu0Yz1FMT+np5s8s5E3kA5rfbbVq9hGLjVVGRDHi0Lbmzrd++VhY+Z
	ithgg8bxpiDsLovmJbJxBVTLodacB3VemPD9rrJhHGCIeki39ke4FmeSzf4pTT4aWV8BBPKlbiX
	l
X-Google-Smtp-Source: AGHT+IGdfK8CGwIbHLkW9liW8S9yD7fsowGh2BQZyMBeiXKEAPmRO95MKlfqcKmcSiwf74gmdCKCAw==
X-Received: by 2002:a05:620a:7299:b0:793:29:7fdd with SMTP id af79cd13be357-794ab04a366mr1528609685a.1.1716931292582;
        Tue, 28 May 2024 14:21:32 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca80a7sm412619485a.17.2024.05.28.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:21:32 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Tue, 28 May 2024 21:21:02 +0000
Message-Id: <20240528212103.350767-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240528212103.350767-1-zijianzhang@bytedance.com>
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
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
index 521e6373d4f7..21239469d75c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2847,6 +2847,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
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


