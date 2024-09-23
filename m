Return-Path: <netdev+bounces-129350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F4697EFB8
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5622A1C2125C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A519E99B;
	Mon, 23 Sep 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkTlHD7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CAFC0B
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111014; cv=none; b=WyrwZA70A2zc1NsGcoUgvqsop1qV5UnHMWoQ1KrZyV1WmURHuRvg4dzVDTt3zm+r7muXLHrQoFFCgqN0g/yx3kBH17d4+rubax5SD+1bA9Sl2EGQMjiP/3o9vEJzTlRVfu9vtPJDlYlt+/rlAqzIoUwaqL1z7BsZo/noxfr+UFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111014; c=relaxed/simple;
	bh=3aNOFBvF/NbAz0CadeS2A7YiZuEB85rJnAT+vP2/HWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTm4yC1A8i+/vVJIj4TAgUlB+UMJoiAZBPYHUgYS7vAOyw9jNcOBk5X0RmGrfY0T/cYSD1AOuXjm2ciU6Uef1P1gLLd7iUr2Qpf3id9PAu4T76GuObcBJFOIi7PzDUVnIsuAxyXs8LZ5dKVD91UAfU2UL+231YMs/CxpmHQcsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkTlHD7H; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1d06c728b8so4237433276.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727111012; x=1727715812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQNIimejxutFmxWbZaAHJ4N5RVJZcUaumMS+gZteyC8=;
        b=mkTlHD7HuaqfF1zzNNIEwePqxBR6HIzHMjl0rdnk6EuFCf4pCg3IOCIWNgqq6OipnD
         vD5PnaJoCyBbqW5GT+CtKc32ggyw+32FPa4O99ow+bh0H4wT+/o1kUF6m5g/RCHYUgmN
         E4C+wQkfg0rKerE10EYBi217C50o7OcrBCFOV+KjPydrEKKBqe6Qajyud1yqWx7qRMvY
         tcODPc+8HiDoG3+qaQXNgPQvUlhd8hMbPUmKP1jsvHntw+CI1ZCYy/F8k6O1n8tbKjyA
         xoZMpwwz0iqLQZo5dLSVd9SiR/FXPTMrXfEofC0n3cTYxkHJk8grt3+keNPo7l+ue2V6
         vIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111012; x=1727715812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQNIimejxutFmxWbZaAHJ4N5RVJZcUaumMS+gZteyC8=;
        b=Ua1EmD86Eb0Pc2m694RUxddFaTJCWzH10HrJojHtxfCdEMWOjZhXv3vAecQgZyJu07
         A9iHZYYHmPVJO51EHAxqKd8g3Cizt4K23zGro5Nn+oIZKRWYtfn/nZgTKbgesfGFD/8i
         7xqNnD+j6/fSz8aH8091Oh6tzzpsGdqKb44vmIMJiv0+Otl/WpGXY/WIK+odaLv0L0ei
         l6+ImyUuqb3nWbf7fbuqqFBJ5NF0/8sJj7vk3szsWfB8efl3KADjUYxeBewGhsDSWXAd
         JQ1czfc+mFyCcedv0KmPkQDSlfEzNmZdM8WLMBB647q222JwhZVviRf13p6KzKUypvyo
         sYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMoo2I+EolA1adHFiTQGouddpYScDqj1m3vI0N7F2ijuF3eOqV6PUSMhQMQBp+KkzAU8WtHb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5McrlzDURxZU17BrzZUViAeb9NDDbdlYT6RXGEFWw1xuITHtP
	twVw+7EXShzTEEiMaWvlUpmz7b+OhY0OH3FLKWvvuiyckFfr7PkueoowJk4HY90iFQ==
X-Google-Smtp-Source: AGHT+IHpZJBRarp0oh3hcG+CG8hZJn1QQ3Iy1loojKEaTOLRElLwEhgIl8kHle64yTMb7GNWCeocnQ==
X-Received: by 2002:a25:fc1c:0:b0:e22:5da1:b32a with SMTP id 3f1490d57ef6-e225da1b45amr5057096276.18.1727111011812;
        Mon, 23 Sep 2024 10:03:31 -0700 (PDT)
Received: from sahand-desktop.. ([151.247.221.86])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e225a6f374csm1274635276.65.2024.09.23.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 10:03:31 -0700 (PDT)
From: Sahand <sahandevs@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: sahandevs@gmail.com,
	jrife@google.com
Subject: [PATCH] net: expose __sock_sendmsg() symbol
Date: Mon, 23 Sep 2024 20:33:22 +0330
Message-ID: <20240923170322.535940-1-sahandevs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sahand Akbarzadeh <sahandevs@gmail.com>

Commit 86a7e0b69bd5b812e48a20c66c2161744f3caa16 ("net: prevent rewrite
of msg_name in sock_sendmsg()") moved the original implementation of
sock_sendmsg() to __sock_sendmsg() and made sock_sendmsg() a wrapper
with extra checks. However, __sys_sendto() still uses __sock_sendmsg()
directly, causing BPF programs attached to kprobe:sock_sendmsg() to not
trigger on sendto() calls.

This patch exposes the __sock_sendmsg() symbol to allow writing BPF
programs similar to those for older kernels.

Signed-off-by: Sahand Akbarzadeh <sahandevs@gmail.com>
---
 include/linux/net.h | 1 +
 net/socket.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index b75bc534c..983be8a14 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -258,6 +258,7 @@ int sock_create_kern(struct net *net, int family, int type, int proto, struct so
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
+int __sock_sendmsg(struct socket *sock, struct msghdr *msg);
 int sock_sendmsg(struct socket *sock, struct msghdr *msg);
 int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
 struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname);
diff --git a/net/socket.c b/net/socket.c
index 8d8b84fa4..5c790205d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -737,7 +737,7 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 	return ret;
 }
 
-static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
+int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
 	int err = security_socket_sendmsg(sock, msg,
 					  msg_data_left(msg));
-- 
2.43.0


