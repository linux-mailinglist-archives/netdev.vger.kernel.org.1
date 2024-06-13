Return-Path: <netdev+bounces-103421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE115907F66
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F396A1C2208D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4CB155C8F;
	Thu, 13 Jun 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Df9bi79x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B514F106
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321503; cv=none; b=cXzzsjljAdTjX9GembygwyKEUzWkHN47URWClLVTrTVjMi8ed851NT6VFIX/gaBfffLuywx5PmmvAFIOI7/Fvb1SF4mwygJMuc12kUNGlZ/BHL31sXBjJzdCNbxMYdmQSOgiL7wPg1MxkrC6JzHOoGHuSpAQVRn0AtsJVC8EIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321503; c=relaxed/simple;
	bh=f+ZE2jdRVU4Jef4nDk8OnP+i+LGYjL2HF3ZUt3YHpk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXj3ki0vKo7GBaAm+PPjv8AMVeoMAF2FmqlflfA7nGHUQ1Kyaa3LR++wH54+nFoJ+mkXiduVaBCxI5zT3IVOaADbMWC7iCkA/ZZLzVN1tEz+yRr0LJpNwMb89BjCp9O1J4aYYTBycIO1Y9xPp9KBdVUTloLu/oHF35y108I9u4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Df9bi79x; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-63267c30eaaso813097b3.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718321500; x=1718926300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3MAm54IjrMNFmR87QYhCBvb1F7SoQWln+56mCe2/YE=;
        b=Df9bi79xMJKg75qa1Fwm2WYu130nAt9mSjRxIPoo5JcUFWxfiY8mj8zcdvX2/iWRt4
         E1Yaz97f9VMFw6yKMWhl796EQftGkM0+tvvuiANkMd56urABnRi4qsH+YYHLxU7C0k6d
         t60IBZV3P9pBvYQWXpJmL8t1BilqX22QKPcdkPop0u4wfOG7OKLxfMHKfNRUobdxunto
         FUfnu2BMdTZfFc48lIAJA4XgOu1yxSjfsu9Iml91UNXKxSGQmjD3O9E5cOQOtmykYdSx
         q9jp1ikX++RJJjbioGrCzYKsj6hZ4CfgYIi3FjIiuZuCIOFhNAx8fC6xIMMg3EYTQ7U2
         slmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321500; x=1718926300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3MAm54IjrMNFmR87QYhCBvb1F7SoQWln+56mCe2/YE=;
        b=AjvkUIHZFSy2YPl1a8TsKC5uLm4K/FkAaeoxBQRxxI+YcGmBG14fMPPcjqY2fXCRdL
         Y0660mW3MUIjpLRFbdmYOWqzshtjRqnsXNq7kGOsf1Y+SCOp1Hq733RqamMmW86CsM9o
         jPam/pJYy5pCWDEMcmz4gD0DsIMPJfeA4Ty9e4jLRFX+aGJj6EMHTXyqmvR7ltY4H4P0
         AoyyPSnHAQQlwlS5dWdG6b+Y6WuEBJnRHZfnyuxDlkHjeY62BhdEpGDGxlXBjFfoyT1L
         y3B898L8wq1G+kEDJABpNCBlTkahNuoVNh/8D4jBnS1aFEN5lcWMK3KcUghA6AeTsu8E
         xyWg==
X-Gm-Message-State: AOJu0Yyr5PhDClsy8s3ewV84mkoAIq0JpG02lNm/CrVYMXzLbsJRU+eS
	KkgZFKj5zs94a8znYTlRcHbhBRNfuFGa+s1XLteMRYwI2NOmgEOZ3gnlWiX6KbWA4fRb+XXd+m1
	h0fs=
X-Google-Smtp-Source: AGHT+IGGEWTVn7zGcCjZIpDHbXLwahqM1ktZfo1E63xoFF1noNGdJF7AnRbX58OmiCIUyB9oCeLnVQ==
X-Received: by 2002:a0d:d752:0:b0:630:8c74:eab8 with SMTP id 00721157ae682-63224a0a50amr8451007b3.42.1718321500344;
        Thu, 13 Jun 2024 16:31:40 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d8b62sm10586731cf.11.2024.06.13.16.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:31:39 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v5 2/4] sock: support put_cmsg to userspace in TX path
Date: Thu, 13 Jun 2024 23:31:31 +0000
Message-Id: <20240613233133.2463193-3-zijianzhang@bytedance.com>
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

Since ____sys_sendmsg creates a kernel copy of msg_control and passes
that to the callees, put_cmsg will write into this kernel buffer. If
people want to piggyback some information like timestamps upon returning
of sendmsg. ____sys_sendmsg will have to copy_to_user to the original buf,
which is not supported. As a result, users typically have to call recvmsg
on the ERRMSG_QUEUE of the socket, incurring extra system call overhead.

This commit supports put_cmsg to userspace in TX path by storing user
msg_control address in a new field in struct msghdr, and adding a new bit
flag use_msg_control_user_tx to toggle the behavior of put_cmsg. Thus,
it's possible to piggyback information in the msg_control of sendmsg.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 include/linux/socket.h |  4 ++++
 net/compat.c           | 33 +++++++++++++++++++++++++--------
 net/core/scm.c         | 42 ++++++++++++++++++++++++++++++++----------
 net/socket.c           |  2 ++
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 89d16b90370b..8d3db04f4a39 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -71,9 +71,12 @@ struct msghdr {
 		void __user	*msg_control_user;
 	};
 	bool		msg_control_is_user : 1;
+	bool		use_msg_control_user_tx : 1;
 	bool		msg_get_inq : 1;/* return INQ after receive */
 	unsigned int	msg_flags;	/* flags on received message */
+	void __user	*msg_control_user_tx;	/* msg_control_user in TX piggyback path */
 	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
+	__kernel_size_t msg_controllen_user_tx; /* msg_controllen in TX piggyback path */
 	struct kiocb	*msg_iocb;	/* ptr to iocb for async requests */
 	struct ubuf_info *msg_ubuf;
 	int (*sg_from_iter)(struct sock *sk, struct sk_buff *skb,
@@ -391,6 +394,7 @@ struct ucred {
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+extern int put_cmsg_user_tx(struct msghdr *msg, int level, int type, int len, void *data);
 
 struct timespec64;
 struct __kernel_timespec;
diff --git a/net/compat.c b/net/compat.c
index 485db8ee9b28..ae9d78b1c18b 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -211,6 +211,8 @@ int cmsghdr_from_user_compat_to_kern(struct msghdr *kmsg, struct sock *sk,
 		goto Einval;
 
 	/* Ok, looks like we made it.  Hook it up and return success. */
+	kmsg->msg_control_user_tx = kmsg->msg_control_user;
+	kmsg->msg_controllen_user_tx = kcmlen;
 	kmsg->msg_control_is_user = false;
 	kmsg->msg_control = kcmsg_base;
 	kmsg->msg_controllen = kcmlen;
@@ -226,13 +228,22 @@ int cmsghdr_from_user_compat_to_kern(struct msghdr *kmsg, struct sock *sk,
 
 int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *data)
 {
-	struct compat_cmsghdr __user *cm = (struct compat_cmsghdr __user *) kmsg->msg_control_user;
+	struct compat_cmsghdr __user *cm;
 	struct compat_cmsghdr cmhdr;
 	struct old_timeval32 ctv;
 	struct old_timespec32 cts[3];
+	compat_size_t msg_controllen;
 	int cmlen;
 
-	if (cm == NULL || kmsg->msg_controllen < sizeof(*cm)) {
+	if (kmsg->use_msg_control_user_tx) {
+		cm = (struct compat_cmsghdr __user *)kmsg->msg_control_user_tx;
+		msg_controllen = kmsg->msg_controllen_user_tx;
+	} else {
+		cm = (struct compat_cmsghdr __user *)kmsg->msg_control_user;
+		msg_controllen = kmsg->msg_controllen;
+	}
+
+	if (!cm || msg_controllen < sizeof(*cm)) {
 		kmsg->msg_flags |= MSG_CTRUNC;
 		return 0; /* XXX: return error? check spec. */
 	}
@@ -260,9 +271,9 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
 	}
 
 	cmlen = CMSG_COMPAT_LEN(len);
-	if (kmsg->msg_controllen < cmlen) {
+	if (msg_controllen < cmlen) {
 		kmsg->msg_flags |= MSG_CTRUNC;
-		cmlen = kmsg->msg_controllen;
+		cmlen = msg_controllen;
 	}
 	cmhdr.cmsg_level = level;
 	cmhdr.cmsg_type = type;
@@ -273,10 +284,16 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
 	if (copy_to_user(CMSG_COMPAT_DATA(cm), data, cmlen - sizeof(struct compat_cmsghdr)))
 		return -EFAULT;
 	cmlen = CMSG_COMPAT_SPACE(len);
-	if (kmsg->msg_controllen < cmlen)
-		cmlen = kmsg->msg_controllen;
-	kmsg->msg_control_user += cmlen;
-	kmsg->msg_controllen -= cmlen;
+	if (msg_controllen < cmlen)
+		cmlen = msg_controllen;
+
+	if (kmsg->use_msg_control_user_tx) {
+		kmsg->msg_control_user_tx += cmlen;
+		kmsg->msg_controllen_user_tx -= cmlen;
+	} else {
+		kmsg->msg_control_user += cmlen;
+		kmsg->msg_controllen -= cmlen;
+	}
 	return 0;
 }
 
diff --git a/net/core/scm.c b/net/core/scm.c
index 4f6a14babe5a..de70ff1981a1 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -228,25 +228,29 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 }
 EXPORT_SYMBOL(__scm_send);
 
-int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
+static int __put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
 {
 	int cmlen = CMSG_LEN(len);
+	__kernel_size_t msg_controllen;
 
+	msg_controllen = msg->use_msg_control_user_tx ?
+		msg->msg_controllen_user_tx : msg->msg_controllen;
 	if (msg->msg_flags & MSG_CMSG_COMPAT)
 		return put_cmsg_compat(msg, level, type, len, data);
 
-	if (!msg->msg_control || msg->msg_controllen < sizeof(struct cmsghdr)) {
+	if (!msg->msg_control || msg_controllen < sizeof(struct cmsghdr)) {
 		msg->msg_flags |= MSG_CTRUNC;
 		return 0; /* XXX: return error? check spec. */
 	}
-	if (msg->msg_controllen < cmlen) {
+	if (msg_controllen < cmlen) {
 		msg->msg_flags |= MSG_CTRUNC;
-		cmlen = msg->msg_controllen;
+		cmlen = msg_controllen;
 	}
 
-	if (msg->msg_control_is_user) {
-		struct cmsghdr __user *cm = msg->msg_control_user;
+	if (msg->use_msg_control_user_tx || msg->msg_control_is_user) {
+		struct cmsghdr __user *cm;
 
+		cm = msg->msg_control_is_user ? msg->msg_control_user : msg->msg_control_user_tx;
 		check_object_size(data, cmlen - sizeof(*cm), true);
 
 		if (!user_write_access_begin(cm, cmlen))
@@ -267,12 +271,17 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 		memcpy(CMSG_DATA(cm), data, cmlen - sizeof(*cm));
 	}
 
-	cmlen = min(CMSG_SPACE(len), msg->msg_controllen);
-	if (msg->msg_control_is_user)
+	cmlen = min(CMSG_SPACE(len), msg_controllen);
+	if (msg->msg_control_is_user) {
 		msg->msg_control_user += cmlen;
-	else
+		msg->msg_controllen -= cmlen;
+	} else if (msg->use_msg_control_user_tx) {
+		msg->msg_control_user_tx += cmlen;
+		msg->msg_controllen_user_tx -= cmlen;
+	} else {
 		msg->msg_control += cmlen;
-	msg->msg_controllen -= cmlen;
+		msg->msg_controllen -= cmlen;
+	}
 	return 0;
 
 efault_end:
@@ -280,8 +289,21 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 efault:
 	return -EFAULT;
 }
+
+int put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
+{
+	msg->use_msg_control_user_tx = false;
+	return __put_cmsg(msg, level, type, len, data);
+}
 EXPORT_SYMBOL(put_cmsg);
 
+int put_cmsg_user_tx(struct msghdr *msg, int level, int type, int len, void *data)
+{
+	msg->use_msg_control_user_tx = true;
+	return __put_cmsg(msg, level, type, len, data);
+}
+EXPORT_SYMBOL(put_cmsg_user_tx);
+
 void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
 {
 	struct scm_timestamping64 tss;
diff --git a/net/socket.c b/net/socket.c
index e416920e9399..2755bc7bef9c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2561,6 +2561,8 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 		err = -EFAULT;
 		if (copy_from_user(ctl_buf, msg_sys->msg_control_user, ctl_len))
 			goto out_freectl;
+		msg_sys->msg_control_user_tx = msg_sys->msg_control_user;
+		msg_sys->msg_controllen_user_tx = msg_sys->msg_controllen;
 		msg_sys->msg_control = ctl_buf;
 		msg_sys->msg_control_is_user = false;
 	}
-- 
2.20.1


