Return-Path: <netdev+bounces-95033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F48C1476
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B6028260D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26597710A;
	Thu,  9 May 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AnFgzATt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18271738
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277994; cv=none; b=KTL5ShAhp21FqeLhFa3exjYTL9axlEb10Z99Uj1BJXwVXhZ59Wa+l50ykQXp/r3+LrPb8CcZWKAocaTiavcBiGHJCFuOTbPIhZKwVf7A/gwZRfG09yS2cV0Zy9eNXZPGcQu0Lx9aIa6ZunCyTOExAuFp102OYa0i8ib8ItuRc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277994; c=relaxed/simple;
	bh=5G8wlDU4Q5nXpj6Hek5PPNIOlfH219bchEfK+vR0h5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZxsHXH/GAllTIBFtoeiAM5pMei2MNs4BSIOQyFsUfOEOuRiyjjRQ3iKRl5a0lXn/vXkOrynGF3JX/fmi4tyb6HvoJawd2wcAT96saiyj5Cj+x7yBKH0082S2qluBDoLf3sUFB0lh5CkYYBRintTdbfN7tNW9+DfTR3txtfzp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AnFgzATt; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e1b520812fso1655739f.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715277992; x=1715882792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqllJzeOXhUEagqvpltJ2K0MlG6IY9kSvg59yPcLJX0=;
        b=AnFgzATtwJpUowTLTzhzpnX+3lXCWZ+hJuTWZjmwKDuCwFbZzhUj6/iM4vHIcQzB7R
         pzyuAhtoBL5HzlX+JfI/eZQeBQYvHE2H50vJrz7sRXgo+tMeH3qIhEIKL8JfFTEFVATR
         7o6O8fVXUB0Olkkv81zVI0Yl/icPGhJ0vuRRIFfj1L5riHFTsT7oCBmS3rGjyk8F2XsU
         xT0MNFalrqm4nScyADA3zaNYHdLAU9YBGFm/+m76m5Faio+rga/OZzhFj/N9JHsxKNjI
         halB9qwk/JeOHAYys+1C6C6UWNjobtQpuroblKFppMY5RoUXpE05yjG8MjP0GmN6i9ve
         T3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277992; x=1715882792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqllJzeOXhUEagqvpltJ2K0MlG6IY9kSvg59yPcLJX0=;
        b=rz7lVIN9NSFE6s2on2xlsM0JnI31//UkYMtaCQ+/wqS/L6XAnrluyJL1FK0mWHJh7k
         4nZCB9YxGVqywJqPL75XG+YW3CjHyThX7RICTeFAGDL3Ee/RQKu5cQd5d6b4AHUPZIVI
         Waa2WbibP5GEJnAJhTh5CWp4DPxb/3V1afzxPn5xkgirsresd6cwDBhr5HcKexTaFcz6
         NUteMjH8WZmjD4upPwfkwS8PUeF7mQgR42M7MXbG+1bUA7zwLz0ZhYkOE9RYe5yi4iw9
         dJMtIL7eK2VRw/th8mLD4AXp0y4iuQRIXygQK9j/mI6EgyNfzWhkX4VFUluqU1cx0N2Q
         ccRg==
X-Forwarded-Encrypted: i=1; AJvYcCXp9KfSt5U7G0fwHa7JdN9RJ3OIvvYUkgmbT8i0u2zm/dV/XrGZ4AkEnJyKbJItJWty1ft4D0GUHRYltKGdFyAzq02b5cxJ
X-Gm-Message-State: AOJu0Yy9hvdmb+r7pVYwb6CQUx7cIsAhiMadE0Ct1G+Z9lUhqcQ7olG9
	JHRmicDHZhkXS0cT6nopxkJ7K1lQ0gMKWZE/ThB42Kt3QLYVwAoRROyZEuuyuCQ=
X-Google-Smtp-Source: AGHT+IGgSt7v3GanopZiHgXNA3366pVyUJp4kiw5FzZV7zwUi2DuyI5Y6WEpxg8GMq0WBFLuJ+UfWg==
X-Received: by 2002:a5d:8d88:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7e1b51fb987mr48980039f.1.1715277991984;
        Thu, 09 May 2024 11:06:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1b23ab4f6sm19468739f.50.2024.05.09.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:06:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] net: have do_accept() take a struct proto_accept_arg argument
Date: Thu,  9 May 2024 12:00:27 -0600
Message-ID: <20240509180627.204155-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509180627.204155-1-axboe@kernel.dk>
References: <20240509180627.204155-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for passing in more information via this API, change
do_accept() to take a proto_accept_arg struct pointer rather than just
the file flags separately.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/socket.h |  3 ++-
 io_uring/net.c         |  6 ++++--
 net/socket.c           | 12 +++++-------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 139c330ccf2c..89d16b90370b 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -16,6 +16,7 @@ struct cred;
 struct socket;
 struct sock;
 struct sk_buff;
+struct proto_accept_arg;
 
 #define __sockaddr_check_size(size)	\
 	BUILD_BUG_ON(((size) > sizeof(struct __kernel_sockaddr_storage)))
@@ -433,7 +434,7 @@ extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 extern int __sys_sendto(int fd, void __user *buff, size_t len,
 			unsigned int flags, struct sockaddr __user *addr,
 			int addr_len);
-extern struct file *do_accept(struct file *file, unsigned file_flags,
+extern struct file *do_accept(struct file *file, struct proto_accept_arg *arg,
 			      struct sockaddr __user *upeer_sockaddr,
 			      int __user *upeer_addrlen, int flags);
 extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
diff --git a/io_uring/net.c b/io_uring/net.c
index 070dea9a4eda..d4d1fc93635c 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1528,8 +1528,10 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_accept *accept = io_kiocb_to_cmd(req, struct io_accept);
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
-	unsigned int file_flags = force_nonblock ? O_NONBLOCK : 0;
 	bool fixed = !!accept->file_slot;
+	struct proto_accept_arg arg = {
+		.flags = force_nonblock ? O_NONBLOCK : 0,
+	};
 	struct file *file;
 	int ret, fd;
 
@@ -1543,7 +1545,7 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 		if (unlikely(fd < 0))
 			return fd;
 	}
-	file = do_accept(req->file, file_flags, accept->addr, accept->addr_len,
+	file = do_accept(req->file, &arg, accept->addr, accept->addr_len,
 			 accept->flags);
 	if (IS_ERR(file)) {
 		if (!fixed)
diff --git a/net/socket.c b/net/socket.c
index 6ff5f21d9633..e416920e9399 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1890,7 +1890,7 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
 	return __sys_listen(fd, backlog);
 }
 
-struct file *do_accept(struct file *file, unsigned file_flags,
+struct file *do_accept(struct file *file, struct proto_accept_arg *arg,
 		       struct sockaddr __user *upeer_sockaddr,
 		       int __user *upeer_addrlen, int flags)
 {
@@ -1898,9 +1898,6 @@ struct file *do_accept(struct file *file, unsigned file_flags,
 	struct file *newfile;
 	int err, len;
 	struct sockaddr_storage address;
-	struct proto_accept_arg arg = {
-		.flags = file_flags,
-	};
 	const struct proto_ops *ops;
 
 	sock = sock_from_file(file);
@@ -1929,8 +1926,8 @@ struct file *do_accept(struct file *file, unsigned file_flags,
 	if (err)
 		goto out_fd;
 
-	arg.flags |= sock->file->f_flags;
-	err = ops->accept(sock, newsock, &arg);
+	arg->flags |= sock->file->f_flags;
+	err = ops->accept(sock, newsock, arg);
 	if (err < 0)
 		goto out_fd;
 
@@ -1956,6 +1953,7 @@ struct file *do_accept(struct file *file, unsigned file_flags,
 static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_sockaddr,
 			      int __user *upeer_addrlen, int flags)
 {
+	struct proto_accept_arg arg = { };
 	struct file *newfile;
 	int newfd;
 
@@ -1969,7 +1967,7 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 	if (unlikely(newfd < 0))
 		return newfd;
 
-	newfile = do_accept(file, 0, upeer_sockaddr, upeer_addrlen,
+	newfile = do_accept(file, &arg, upeer_sockaddr, upeer_addrlen,
 			    flags);
 	if (IS_ERR(newfile)) {
 		put_unused_fd(newfd);
-- 
2.43.0


