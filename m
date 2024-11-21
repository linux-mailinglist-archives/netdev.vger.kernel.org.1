Return-Path: <netdev+bounces-146643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7B9D4D47
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CB52810C7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6E1D5CD4;
	Thu, 21 Nov 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LDJUu0N6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116F1D319B
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193892; cv=none; b=TeWRxHYOORpYss/jSXDY3x7sQYhYJUW9aK+YExbffcMgm5sTtiQjdmvAtzXRl51UqU3tk9hQyPEoptg1JqoxdR76gSQG756wt3uU//EnWnlQ5A1I2mDXZrSMqq+aCEZvG4j6c7oqgi8m3O7HmgpCJX+05UVk02Czpid0fUYN7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193892; c=relaxed/simple;
	bh=NGrZcFdcWSOdG64B42aeCuurKwAqveVQiGFal6pomAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm20HBNhhkGIXtH6m6qAtE6TBIzWltaDY11V0OlkdS+7TuOdCotUMV33vpdsYAUdVNwo3R621+ElUX1cGGy6jg6ZOaSBxtysQV3sg3G2Vx7vPtk/rqavgRyliNUIal8zAyCx13Fu6Uu9XkJSOotbGMnQJX5zmGcIJ6xE8LN2xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LDJUu0N6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3087402F0
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732193881;
	bh=NkMGboeB4JllcdtLoKopzE3i3ZmHlvAh51JdixnLmTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=LDJUu0N65U98bOEpPAIpZ+CAKie5LBKZkcRoOLSfDvccrjjmFyCOGZigxUubltkfM
	 JI06qxv8EMxzR099kGZX19lsCpJ6LTVGuNVb/ctnpfBWxWL+KaGWlkwuHu8iLPUqPA
	 xE6RJuyOG/p1NPVfATqWIQhKJUq3k75yQnHqkvcaW0st0MaV/+oYMR/BNHGt7vgIoP
	 kscArUcoEemFxOCpuQJ0Xw29ae5Y45SaY7MzbmetyHbHQsjMEMo7XxJ2M0KwyeAth8
	 4d2LYWjEZyKfavLbT1WCEv2ChrhpCYqnHycnOQj3cLJD8888bheacbcx9qbfCTW0CQ
	 andGz7nbGdNdg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a2a81ab82so73670666b.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 04:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193881; x=1732798681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkMGboeB4JllcdtLoKopzE3i3ZmHlvAh51JdixnLmTg=;
        b=mN3b6Pkuex1rEFnA7Hq6Hw6yZDcLCtOW8AC2scCyhCk038AYES+5gOApgcWvqoxUFS
         ZuietkSgeO48QkustD+H4Zjel6MAvKntC8KtwurseHF94Pwos8NhZwI4qUQYL1ANYm7q
         SQFhYKNqjc/krcPfGah+l+ZRcO0vcEzBa4ZuO52HYT9k+cRQF4KwAyMo1rAXknC+2zVW
         wp3MZexRJjiHKXMIaXw/0F8nXNNoMxelLypG/FhZaqIpMxrcIre5UENueptd5IUeOGc8
         M/Jfh0YcA0gYqWJtqkgHng8GByJana0PQhEBA0UHmAJjZ0FyDZ/JIoa/bAe0YxMulwQA
         z2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT645qVfPBdbFpYYbMMjsrMDLOz2d5DEWAY9EfplpvXbHsPaBlNLjdomYyMiFsD/1RY8gwkqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWcpZQoEpIt7x1MNshFz1MIqU2uT3qB42TscPCVpZCt7XY81J
	Swf5WaOIycOv/ONWmGfCttuXmS+n34vKHK9plHXTHdJPgcghXuQNcxMj0y8zSZTw/Q92AdFJ3h7
	lmW1tefkgYBkc25jSKLYPl2jIB9TgP668BWuQWf1II0efvJ9byEyF0xUM1JxzgvOOw91TOg==
X-Gm-Gg: ASbGncsxR1XXAs9vaJvfkt0Ch+JXdD5yJmZXd/GwTWS7lX2IqBH6/uT9dSbpVTDzaRF
	Y52hHRcizZyiGwZP4gFhuEWoYxQqicvP09Zgk+13++zFYqe9aw0f0zz07Deoo2DNkFxspHyMK9a
	CLa5jgAwAdRdRw2Pz8nATyH8b+SAw1loDT5D67u2NcP2u45Uo/60SJTEdIz1+9+D66U3sgOawOB
	ORmoEx1+Gg9aQjIPt/a06BJCFBPYQYNDm28xhosWvYrIChB7PDuDkhlsPU9SLpdzJdtjSEihG8G
	tg==
X-Received: by 2002:a17:907:9720:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-aa4dd50a642mr542207466b.8.1732193880872;
        Thu, 21 Nov 2024 04:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG6g7C3BDAlHohQX+vhiU+W2yyBeHXfdlriO8FaVjmCQHY0iBTKt6Ed0Pjpw0u8D6j+3lBRA==
X-Received: by 2002:a17:907:9720:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-aa4dd50a642mr542204066b.8.1732193880498;
        Thu, 21 Nov 2024 04:58:00 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d3109sm78221766b.132.2024.11.21.04.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:57:59 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: stsp2@yandex.ru
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	davem@davemloft.net,
	edumazet@google.com,
	gouhao@uniontech.com,
	horms@kernel.org,
	kees@kernel.org,
	krisman@suse.de,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	oleg@redhat.com,
	pabeni@redhat.com,
	quic_abchauha@quicinc.com,
	shuah@kernel.org,
	tandersen@netflix.com,
	viro@zeniv.linux.org.uk,
	willemb@google.com,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH net-next v3] af_unix: pass pidfd flags via SCM_PIDFD cmsg
Date: Thu, 21 Nov 2024 13:57:32 +0100
Message-ID: <20241121125732.88044-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116101120.323174-1-stsp2@yandex.ru>
References: <20241116101120.323174-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Currently SCM_PIDFD cmsg cannot be sent via unix socket
>(returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
>The created pidfd always has flags set to 0.
>
>This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
>can be used to send flags to SO_PASSPIDFD-enabled recipient.
>
>Self-test is added for the propagation of PIDFD_NONBLOCK flag.

>This is mainly needed for the future extensions, like eg this one:
>https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
>where it was suggested to try solving the supplementary groups
>problem with pidfd.
>
>Changes in v3: specify target tree in patch subject
>Changes in v2: remove flags validation in scm_pidfd_recv(), as
>  suggested by Kuniyuki Iwashima <kuniyu@amazon.com>
>
>Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

...

>diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
>index 75bdf9807802..c4c5c1a0c2ad 100644
>--- a/include/linux/pidfs.h
>+++ b/include/linux/pidfs.h
>@@ -2,7 +2,16 @@
> #ifndef _LINUX_PID_FS_H
> #define _LINUX_PID_FS_H
> 
>+#include <uapi/linux/pidfd.h>
>+
> struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
> void __init pidfs_init(void);
> 
>+static inline int pidfd_validate_flags(unsigned int flags)
>+{
>+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
>+		return -EINVAL;
>+	return 0;
>+}
>+
> #endif /* _LINUX_PID_FS_H */
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index d18cc47e89bd..ee27d391e5aa 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -178,7 +178,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
> #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
> #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
> #define SCM_SECURITY	0x03		/* rw: security label		*/
>-#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
>+#define SCM_PIDFD	0x04		/* r: pidfd, w: pidfd_flags (int) */
> 
> struct ucred {
> 	__u32	pid;
>diff --git a/include/net/af_unix.h b/include/net/af_unix.h
>index 63129c79b8cb..4bc197548c2f 100644
>--- a/include/net/af_unix.h
>+++ b/include/net/af_unix.h
>@@ -62,6 +62,7 @@ struct unix_skb_parms {
> #ifdef CONFIG_SECURITY_NETWORK
> 	u32			secid;		/* Security ID		*/
> #endif
>+	u32			pidfd_flags;
> 	u32			consumed;
> } __randomize_layout;
> 
>diff --git a/include/net/scm.h b/include/net/scm.h
>index 0d35c7c77a74..1326edcacacb 100644
>--- a/include/net/scm.h
>+++ b/include/net/scm.h
>@@ -48,6 +48,7 @@ struct scm_cookie {
> #ifdef CONFIG_SECURITY_NETWORK
> 	u32			secid;		/* Passed security ID 	*/
> #endif
>+	u32			pidfd_flags;
> };
> 
> void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
>@@ -154,7 +155,7 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
> 	if (!scm->pid)
> 		return;
> 
>-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
>+	pidfd = pidfd_prepare(scm->pid, scm->pidfd_flags, &pidfd_file);
> 
> 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
> 		if (pidfd_file) {
>diff --git a/kernel/pid.c b/kernel/pid.c
>index 2715afb77eab..b1100ae8ea63 100644
>--- a/kernel/pid.c
>+++ b/kernel/pid.c
>@@ -629,10 +629,12 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
> SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> {
> 	int fd;
>+	int err;
> 	struct pid *p;
> 
>-	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
>-		return -EINVAL;
>+	err = pidfd_validate_flags(flags);
>+	if (err)
>+		return err;
> 
> 	if (pid <= 0)
> 		return -EINVAL;
>diff --git a/net/core/scm.c b/net/core/scm.c
>index 4f6a14babe5a..3bcdecdacd7e 100644
>--- a/net/core/scm.c
>+++ b/net/core/scm.c
>@@ -23,6 +23,7 @@
> #include <linux/security.h>
> #include <linux/pid_namespace.h>
> #include <linux/pid.h>
>+#include <linux/pidfs.h>
> #include <linux/nsproxy.h>
> #include <linux/slab.h>
> #include <linux/errqueue.h>
>@@ -210,6 +211,19 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
> 			p->creds.gid = gid;
> 			break;
> 		}
>+		case SCM_PIDFD:
>+		{
>+			unsigned int flags;
>+
>+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(flags)))
>

Hi Stas!

Hmm, it is a bit unusual that SCM_PIDFD message format is different in case
when you send it and when you read it.

I mean that when you read it (on the receiver side) you get pidfd file descriptor number,
while when you write it (on the sender side) you are only allowed to send one integer and this time it's
a pidfd file descriptor flags. I personally have nothing strictly against that but just found this
a bit unusual and probably confusing for userspace programmers.

Compare it with SCM_CREDENTIALS, for instance, where we read/write the same structure struct ucred.

>+				goto error;
>+			memcpy(&flags, CMSG_DATA(cmsg), sizeof(flags));
>+			err = pidfd_validate_flags(flags);

pidfd_validate_flags allows PIDFD_THREAD, but what's the idea behind this if
scm->pid is always a thread-group leader? (see maybe_add_creds() function).

Sorry if I misunderstand something just want to ensure that we are on the same page.

Kind regards,
Alex


