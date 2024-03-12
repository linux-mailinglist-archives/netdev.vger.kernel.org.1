Return-Path: <netdev+bounces-79496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA50E879865
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E7AB21EC4
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701507D06B;
	Tue, 12 Mar 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xsnH4DzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911507CF22
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258951; cv=none; b=YlM1itb3ONW1s++4+76QtUYt0cyEZvKtXRxQjEh4A3bDOWzlJ8PRmEX3Uixg/kaGzMEVk51kN7JYlS9+Kdgnf5Qwj4ooP+voyF6U3esWN+wg7oO4EvyrVUx4BMdustP2i89VmBYt/2wPXkQ8c0YGLF5TEjph3eIqnfJaziGnQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258951; c=relaxed/simple;
	bh=oMAecsQogzvcRdSBjC1PtFk518Pu8pE5LdlObt/wZZA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=WX7vrB5SIc+oQDtK5xNU5s+W0/DS/L6vMn/hIKhL5RFq1shJ8ChZf/ot/rPyZbFPS8hS1ucG2HZeeNNe0xj500OR2nVQ/kkBISlUq23VQdvFhfS0E+NQw7tylJ0UE5AIATzxzwnpVDvX0ZgpZfUUY4TYxD1MTaAd2zMWS6U8G8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xsnH4DzT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd6dbcc622so14238845ad.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710258947; x=1710863747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TvpHj8UhMHUayRSd3+O1yIo2FF8vJLG6JTSQFHJq8o=;
        b=xsnH4DzTb6WB+c6WGxm2JDEdCYbrxw+6k2yM/kxC7268I9HbtxivJtSBDOV+QX1f51
         NVAFh1/n3VG+G/ttGHwPxMB7+vUvodG4Oal/R96ygL0h9Yjizw0CsygERUfzmpVjTbUC
         Kl9pYRbs/3FVZWWb4EVSwexb/OcdDn8TjnXWZa8F+wwwi0cOZnLXl6xTbqXUQLoLQCTC
         3+bTpeXb2VFcSGhe0EwqCJJWepX09N5Jk0m8l2QufuavMf4+f7HwHP9tbTn8HctdE4OG
         q9MeH+SrhZWitKGDI27Nix2t3KxdMJ8TZrjU3yYOCDKM35mBaFGeCxgdGJuGgzaLdKPu
         MODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710258947; x=1710863747;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/TvpHj8UhMHUayRSd3+O1yIo2FF8vJLG6JTSQFHJq8o=;
        b=bwBytGWUjduR8KwcX3Ah3s1pgYts4ONugTpFYC+YKlKzAUs+7LnXwMMEn/eyYLYDTK
         VKyOqqlPVfKRhluUobaaGiVKrSek9hAympcM/srJJtHbqwx9PCcpP+AJOkFuSrnqq65p
         aA3QNtNJZui5ledPOSQNC0/fz68fx6QxtpcWJI1ZxDDOoGQOswHkEpT+wYqktwnHox8a
         5ibGHhymj2KZs6MocMl3eZpTzXsRKsDpLDJC/5cGqqn+51pdYGPfrrSq0VR5hEoOaS7U
         yu7dYFEK0XuTr+b3qXFuvpZzcdi4GO7JUy/zSpJYv5ZPo+pLot4iBg8kaU+s82vKmOBT
         IzJA==
X-Gm-Message-State: AOJu0Ywk4quozpszzbH0rRs/uSQjYABdY+xZqe47Y8mYIUNYL/LmpDK8
	vEvjC4n7WYrtVUg+C00YFFjTq4bQ/p/xhrrbd7KF8nRn0hTltMPhAB5ZCb3MeBMht3Ahd8etY7I
	n
X-Google-Smtp-Source: AGHT+IFLtbIvGLg8HZOYCRtCs8esM+1tJlHntp8XbHW4vs0BwJsCb28SeFcWTLjg4wIIUwpApdmwCA==
X-Received: by 2002:a17:902:bb8c:b0:1dc:df03:ad86 with SMTP id m12-20020a170902bb8c00b001dcdf03ad86mr11295293pls.2.1710258946997;
        Tue, 12 Mar 2024 08:55:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001db8f7720e2sm5973947plf.288.2024.03.12.08.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 08:55:46 -0700 (PDT)
Message-ID: <1b6089d3-c1cf-464a-abd3-b0f0b6bb2523@kernel.dk>
Date: Tue, 12 Mar 2024 09:55:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] net: remove {revc,send}msg_copy_msghdr() from exports
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The only user of these was io_uring, and it's not using them anymore.
Make them static and remove them from the socket header file.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

recvmsg_copy_msghdr() hasn't been used in a while, sendmsg_copy_msghdr()
went away in this merge window.

diff --git a/include/linux/socket.h b/include/linux/socket.h
index cfcb7e2c3813..139c330ccf2c 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -422,13 +422,6 @@ extern long __sys_recvmsg_sock(struct socket *sock, struct msghdr *msg,
 			       struct user_msghdr __user *umsg,
 			       struct sockaddr __user *uaddr,
 			       unsigned int flags);
-extern int sendmsg_copy_msghdr(struct msghdr *msg,
-			       struct user_msghdr __user *umsg, unsigned flags,
-			       struct iovec **iov);
-extern int recvmsg_copy_msghdr(struct msghdr *msg,
-			       struct user_msghdr __user *umsg, unsigned flags,
-			       struct sockaddr __user **uaddr,
-			       struct iovec **iov);
 extern int __copy_msghdr(struct msghdr *kmsg,
 			 struct user_msghdr *umsg,
 			 struct sockaddr __user **save_addr);
diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..0f5d5079fd91 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2600,9 +2600,9 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 	return err;
 }
 
-int sendmsg_copy_msghdr(struct msghdr *msg,
-			struct user_msghdr __user *umsg, unsigned flags,
-			struct iovec **iov)
+static int sendmsg_copy_msghdr(struct msghdr *msg,
+			       struct user_msghdr __user *umsg, unsigned flags,
+			       struct iovec **iov)
 {
 	int err;
 
@@ -2753,10 +2753,10 @@ SYSCALL_DEFINE4(sendmmsg, int, fd, struct mmsghdr __user *, mmsg,
 	return __sys_sendmmsg(fd, mmsg, vlen, flags, true);
 }
 
-int recvmsg_copy_msghdr(struct msghdr *msg,
-			struct user_msghdr __user *umsg, unsigned flags,
-			struct sockaddr __user **uaddr,
-			struct iovec **iov)
+static int recvmsg_copy_msghdr(struct msghdr *msg,
+			       struct user_msghdr __user *umsg, unsigned flags,
+			       struct sockaddr __user **uaddr,
+			       struct iovec **iov)
 {
 	ssize_t err;
 
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index cfcb7e2c3813..139c330ccf2c 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -422,13 +422,6 @@ extern long __sys_recvmsg_sock(struct socket *sock, struct msghdr *msg,
 			       struct user_msghdr __user *umsg,
 			       struct sockaddr __user *uaddr,
 			       unsigned int flags);
-extern int sendmsg_copy_msghdr(struct msghdr *msg,
-			       struct user_msghdr __user *umsg, unsigned flags,
-			       struct iovec **iov);
-extern int recvmsg_copy_msghdr(struct msghdr *msg,
-			       struct user_msghdr __user *umsg, unsigned flags,
-			       struct sockaddr __user **uaddr,
-			       struct iovec **iov);
 extern int __copy_msghdr(struct msghdr *kmsg,
 			 struct user_msghdr *umsg,
 			 struct sockaddr __user **save_addr);

-- 
Jens Axboe


