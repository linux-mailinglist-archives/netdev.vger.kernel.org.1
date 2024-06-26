Return-Path: <netdev+bounces-107048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38AE91984C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A5B2864BD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4341922ED;
	Wed, 26 Jun 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZhR07o6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BB19149A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430452; cv=none; b=LMzg6qwjQwCHPdkZ2tlxpjEHOZIFR21jeHQ9ZDj/1MKxwpCGph1+AFpmyRYyHFoB4qRXq82wTlQq/6xmCWFqDgf7xj+bupF02DbTkvlcqQ8Bg8RE6OEdouhPvtbhoQ6blYRCQ1UdlkHl1CPXiVr42FOzRz4VpuFTdU1l0MmJ9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430452; c=relaxed/simple;
	bh=QvsyaMOFCyqiKKN4mxhDmXGb9oJ+DFav1kcdjknZmMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb1HgQ63C0a8Q8kdptS8gcjxl7LSXXwbYhhVVysQp8wsqXd63z8o8Nv1TcRFuAXHL5ooGPK8yT/9L+rYY9pB7IgHRJKYy6uYBPfEIXsw8TGYLWw07Ba3D+R2eKan0TiZTiYacjEGHZt6i9g1R53JmyLePJ0bEKxJDGP1615xqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZhR07o6w; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f9a4f9923aso3838966a34.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719430449; x=1720035249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU2+TnVnaRnjEbMWnSevTqs6sTsVoRAJHOXUXgLcrc4=;
        b=ZhR07o6wEQWbGaeSIn17rzoUAuX3jaTSHENyT2+SMbGcosssDEYlGCo9rf1aHsyJnK
         to9v8x4ij2AhweMhi5ElotkU3z9/mznBpkLuZqm+KEJGYNGrLulktjHuZ446yrc0EgZf
         VWt3H6TmcVhHW4W1mCzAumMwEk60xg0VQkqWIfSgAqorxkW3voNlLZHY1j/09IEHRtzo
         ZbhaZBJ1ganUhiczta+pdRoOO+2uPQQatBLyf9s21LGHHpGvJDCnlpL56YXPIHjOmm93
         cpCTqYy6hDidD05c9UHCYSymxBznZkpUUdTX63nnO/URuc/81E06zNK7LZI/MvYN4yc9
         k59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430449; x=1720035249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU2+TnVnaRnjEbMWnSevTqs6sTsVoRAJHOXUXgLcrc4=;
        b=HAe4EPM1f4M4UNeZ9TE/v3hFyX7UqPwVAoiGTdow/fGrIOQqX+0B5VBzzjTbHECjy2
         RwD2Nxpky3DLxNE4kPOUTzEYl1LtRSSUCRP8d6QsqN88ISE2OZBoLBgxKoxb80qtqPyb
         fGt0euRTWsmpCHsLccU5idJ66kmYi6khHOSz6oWyEgbh3lj+JyP5onSVGczieBlIJRRA
         +LFkoGXIgglDdyuTfmZJVUtVXcCF1hpcttUIHJAcx3XKonB4gNTIbKiJP+5bRysNyhh2
         QeztpCQJ6g8PIkAQTkTS7hkNwtpEnIoPs+REXZfDTyrqrY1Ww8VAqgNrXSjIP3A5jD7t
         WbNw==
X-Gm-Message-State: AOJu0Yz7lcpAp6N2RpAusxsEILEUY4osCjytIj3nrittjJxsrhwXWs+m
	WSMLWHFBtJQflg5tJM69mV2X0y+uAeTlJT+nAMyffSnjZnN6CO8Baibx8PBMQFKTwh5XD4vwaz1
	f
X-Google-Smtp-Source: AGHT+IH2lMBNsKrXm2dzagRmjTycs4dJ65V2hTmwp51cUNRCgQFXqTZqcA45S9hYNCqK5duhqt9hZg==
X-Received: by 2002:a9d:6b03:0:b0:700:d67c:9bc8 with SMTP id 46e09a7af769-700d67c9e6bmr2039484a34.10.1719430449477;
        Wed, 26 Jun 2024 12:34:09 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b53df48dedsm40112286d6.67.2024.06.26.12.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:34:09 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v6 2/4] sock: support copy cmsg to userspace in TX path
Date: Wed, 26 Jun 2024 19:34:01 +0000
Message-Id: <20240626193403.3854451-3-zijianzhang@bytedance.com>
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

Since ____sys_sendmsg creates a kernel copy of msg_control and passes
that to the callees, put_cmsg will write into this kernel buffer. If
people want to piggyback some information like timestamps upon returning
of sendmsg. ____sys_sendmsg will have to copy_to_user to the original buf,
which is not supported. As a result, users typically have to call recvmsg
on the ERRMSG_QUEUE of the socket, incurring extra system call overhead.

This commit supports copying cmsg to userspace in TX path by introducing
a flag MSG_CMSG_COPY_TO_USER in struct msghdr to guide the copy logic
upon returning of ___sys_sendmsg.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 include/linux/socket.h |  6 ++++++
 net/core/sock.c        |  2 ++
 net/ipv4/ip_sockglue.c |  2 ++
 net/ipv6/datagram.c    |  3 +++
 net/socket.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 89d16b90370b..35adc30c9db6 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -168,6 +168,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
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
@@ -329,6 +334,7 @@ struct ucred {
 
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
+#define MSG_CMSG_COPY_TO_USER	0x10000000	/* Copy cmsg to user space */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..4a766a91ff5c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2879,6 +2879,8 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
 	for_each_cmsghdr(cmsg, msg) {
 		if (!CMSG_OK(msg, cmsg))
 			return -EINVAL;
+		if (cmsg_copy_to_user(cmsg))
+			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;
 		if (cmsg->cmsg_level != SOL_SOCKET)
 			continue;
 		ret = __sock_cmsg_send(sk, cmsg, sockc);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..464d08b27fa8 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -249,6 +249,8 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 	for_each_cmsghdr(cmsg, msg) {
 		if (!CMSG_OK(msg, cmsg))
 			return -EINVAL;
+		if (cmsg_copy_to_user(cmsg))
+			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;
 #if IS_ENABLED(CONFIG_IPV6)
 		if (allow_ipv6 &&
 		    cmsg->cmsg_level == SOL_IPV6 &&
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..b0341faf7f83 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -776,6 +776,9 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 			goto exit_f;
 		}
 
+		if (cmsg_copy_to_user(cmsg))
+			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;
+
 		if (cmsg->cmsg_level == SOL_SOCKET) {
 			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
 			if (err)
diff --git a/net/socket.c b/net/socket.c
index e416920e9399..6523cf5a7f32 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2621,6 +2621,39 @@ static int sendmsg_copy_msghdr(struct msghdr *msg,
 	return 0;
 }
 
+static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
+				     struct user_msghdr __user *umsg)
+{
+	struct compat_msghdr __user *umsg_compat =
+				(struct compat_msghdr __user *)umsg;
+	unsigned long cmsg_ptr = (unsigned long)umsg->msg_control;
+	unsigned int flags = msg_sys->msg_flags;
+	struct msghdr msg_user = *msg_sys;
+	struct cmsghdr *cmsg;
+	int err;
+
+	msg_user.msg_control = umsg->msg_control;
+	msg_user.msg_control_is_user = true;
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
 static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 			 struct msghdr *msg_sys, unsigned int flags,
 			 struct used_address *used_address,
@@ -2638,6 +2671,18 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 
 	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
 				allowed_msghdr_flags);
+	if (err < 0)
+		goto out;
+
+	if (msg_sys->msg_flags & MSG_CMSG_COPY_TO_USER) {
+		ssize_t len = err;
+
+		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
+		if (err)
+			goto out;
+		err = len;
+	}
+out:
 	kfree(iov);
 	return err;
 }
-- 
2.20.1


