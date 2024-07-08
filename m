Return-Path: <netdev+bounces-110014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997692AAE2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4058B219B2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3FA14EC48;
	Mon,  8 Jul 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uw06Bgxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8F14E2D7
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472777; cv=none; b=OBVqlhYy7TN/sUz5oGaAZ7OxJm7fWH2gv4LApd7ue8if/XUEd/syyq0ssRszNSbd69JrZxzePzgDGXdo1xBpBqDPSvBccGdsgXoybKEkF/t1tCHTsjl4dS61aD03TmSyB906xuxv71fXXBeAlb110z1U9MEBa8VdnSLgVtOAhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472777; c=relaxed/simple;
	bh=AGEHkBfuQB3+6zn2ykavACl/xw35qvt9M17BsR63GxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5V2SrVL8g5wvE4utpEy/YYWZhiQpf2q7+b9VbPI2zDGB8hBP18lpgUq8uxH9Fz8Ne7c8fk059wlZ+Cm0pxzW+3lEmjgHAZKMnVAKXeCV+bBP7Bu70K2Vk/DAiW3kb/nifMJryaIl5yvDMuMjthpvdbcmz9GLJGjKMA4afJmfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uw06Bgxr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7036ab4a2acso1102350a34.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720472773; x=1721077573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T81lePJCJIcQm7BHyJTfJJuarqsHs52UTrO/4557dbc=;
        b=Uw06BgxrP7ceWxn5q3ZAfDpoyBlptud0cVyeJSlrJbTX24NcBnsaIrolgOd8rLVXCk
         CTDayk0pYvZVaKXI3XD4C8LJmQ4KfJ3sHQPBjOhIABJUqxR1OO7C1Jn8P6qS8rza4bDn
         UcVlDYHxFx8BBK6TWWk9Y5c2wZhs/fxuCWcRojWY88BMjTHPV2APVdSTySJ098mIr8PB
         elVT0V+ljs2Oscm83mBfoclzBjs+4u63oYFrjl7efYQSgAU6U6y8WnecLrlZ2oE4yxjJ
         /snKRiN6t+63Zh4IA86wV1ns5B2YmXMT0K2vEbVsGP6F6xQbvbZ6kZRvsMv/nmwk5yLM
         kW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472773; x=1721077573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T81lePJCJIcQm7BHyJTfJJuarqsHs52UTrO/4557dbc=;
        b=hWzt4hmGjss5E0MiQG0TFD35dzO8LKrr/mf8ij2/L9V5oLprbb6TueZgiLBVe4m6Aq
         gXP1STrXqpn9b8FFPZcCXXgX6QdZrm0hgK1Brf9rJY6r7R23GQtaK+zp7N+urRrwdMNo
         U6PFhGthH21mGv4Zi+GxGiCjPcv9APPL0kx9grjzaczZp0kTw2Cbk/IaVEZjf5MwQ6XK
         CiPtPaO4BD6e+WajQ0x4FtcADPRu92NtYE1+uH6sR7AU85qx45r2R+/32WcxFKomlYQL
         9oeUnGdpnr4c97YiUMjX1dsbio8UDHrj9TtJN/sUw7Iznux0AXLsKUG+UcnY8aM09RLw
         PhFw==
X-Gm-Message-State: AOJu0Yypg6CrlDH883zDQA72B2dlefKgFo/CLMpmH737fM1+CRvuJyUU
	gy0gLH8H9mwr/2VcjXZBf5uzrX44P2nigDAq+4Rp3Mtvkub02ZG7DBEN/g7/IP6BJNZw6oUe2SP
	8
X-Google-Smtp-Source: AGHT+IGiB1vhwXy9EgH7GAxPlXmZR2ckvyBzt4B/Skj0TdvAunW5H6A3B8em48LbdB42OFMizuLp3w==
X-Received: by 2002:a05:6830:1e32:b0:703:6599:3258 with SMTP id 46e09a7af769-70375a1f0e6mr688174a34.19.1720472773265;
        Mon, 08 Jul 2024 14:06:13 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff82a7sm28212185a.9.2024.07.08.14.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:06:12 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user space in sendmsg
Date: Mon,  8 Jul 2024 21:04:03 +0000
Message-Id: <20240708210405.870930-2-zijianzhang@bytedance.com>
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

Users can pass msg_control as a placeholder to recvmsg, and get some info
from the kernel upon returning of it, but it's not available for sendmsg.
Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
creates a kernel copy of msg_control and passes that to the callees,
put_cmsg in sendmsg path will write into this kernel buffer.

If users want to get info after returning of sendmsg, they typically have
to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system
call overhead. This commit supports copying cmsg from the kernel space to
the user space upon returning of sendmsg to mitigate this overhead.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 include/linux/socket.h |  6 +++++
 include/net/sock.h     |  2 +-
 net/core/sock.c        |  6 +++--
 net/ipv4/ip_sockglue.c |  2 +-
 net/ipv6/datagram.c    |  2 +-
 net/socket.c           | 54 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a1ff91d1914..75461812a7a3 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -71,6 +71,7 @@ struct msghdr {
 		void __user	*msg_control_user;
 	};
 	bool		msg_control_is_user : 1;
+	bool		msg_control_copy_to_user : 1;
 	bool		msg_get_inq : 1;/* return INQ after receive */
 	unsigned int	msg_flags;	/* flags on received message */
 	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
@@ -168,6 +169,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
 }
 
+static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
+{
+	return 0;
+}
+
 static inline size_t msg_data_left(struct msghdr *msg)
 {
 	return iov_iter_count(&msg->msg_iter);
diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..9c728287d21d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1804,7 +1804,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
 	};
 }
 
-int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
+int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc);
 int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
 		   struct sockcm_cookie *sockc);
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..efb30668dac3 100644
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
@@ -2866,6 +2866,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	default:
 		return -EINVAL;
 	}
+	if (cmsg_copy_to_user(cmsg))
+		msg->msg_control_copy_to_user = true;
 	return 0;
 }
 EXPORT_SYMBOL(__sock_cmsg_send);
@@ -2881,7 +2883,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
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
diff --git a/net/socket.c b/net/socket.c
index e416920e9399..6a9c9e24d781 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2525,8 +2525,43 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 	return err < 0 ? err : 0;
 }
 
-static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
-			   unsigned int flags, struct used_address *used_address,
+static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
+				     struct user_msghdr __user *umsg)
+{
+	struct compat_msghdr __user *umsg_compat =
+				(struct compat_msghdr __user *)umsg;
+	unsigned int flags = msg_sys->msg_flags;
+	struct msghdr msg_user = *msg_sys;
+	unsigned long cmsg_ptr;
+	struct cmsghdr *cmsg;
+	int err;
+
+	msg_user.msg_control_is_user = true;
+	msg_user.msg_control_user = umsg->msg_control;
+	cmsg_ptr = (unsigned long)msg_user.msg_control;
+	for_each_cmsghdr(cmsg, msg_sys) {
+		if (!CMSG_OK(msg_sys, cmsg))
+			break;
+		if (cmsg_copy_to_user(cmsg))
+			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
+				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
+	}
+
+	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
+	if (err)
+		return err;
+	if (MSG_CMSG_COMPAT & flags)
+		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
+				 &umsg_compat->msg_controllen);
+	else
+		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
+				 &umsg->msg_controllen);
+	return err;
+}
+
+static int ____sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
+			   struct msghdr *msg_sys, unsigned int flags,
+			   struct used_address *used_address,
 			   unsigned int allowed_msghdr_flags)
 {
 	unsigned char ctl[sizeof(struct cmsghdr) + 20]
@@ -2537,6 +2572,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 	ssize_t err;
 
 	err = -ENOBUFS;
+	msg_sys->msg_control_copy_to_user = false;
 
 	if (msg_sys->msg_controllen > INT_MAX)
 		goto out;
@@ -2594,6 +2630,14 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 			       used_address->name_len);
 	}
 
+	if (msg && msg_sys->msg_control_copy_to_user && err >= 0) {
+		ssize_t len = err;
+
+		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
+		if (!err)
+			err = len;
+	}
+
 out_freectl:
 	if (ctl_buf != ctl)
 		sock_kfree_s(sock->sk, ctl_buf, ctl_len);
@@ -2636,8 +2680,8 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 	if (err < 0)
 		return err;
 
-	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
-				allowed_msghdr_flags);
+	err = ____sys_sendmsg(sock, msg, msg_sys, flags, used_address,
+			      allowed_msghdr_flags);
 	kfree(iov);
 	return err;
 }
@@ -2648,7 +2692,7 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
 			unsigned int flags)
 {
-	return ____sys_sendmsg(sock, msg, flags, NULL, 0);
+	return ____sys_sendmsg(sock, NULL, msg, flags, NULL, 0);
 }
 
 long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
-- 
2.20.1


