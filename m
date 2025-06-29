Return-Path: <netdev+bounces-202301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23EFAED161
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B851894F07
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCA245033;
	Sun, 29 Jun 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vspX2djn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A423BF96
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233524; cv=none; b=IZyOD9tbq7K7jdbfUOadjzVYHwizjIXC6Lsyg7C9at5u1+lYCOEohu3U+bIeMlDpwSlCDz0ur3Oy6HBDh+2LgZ+BXmuLBn2Bo/hy1uBV5Z9ekzoGoqYtij+M/28lfxE9wNHjEuhozX35fAEUhhcG5w8EFx5811nPZa9uy/K3Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233524; c=relaxed/simple;
	bh=NzVgcHKoOIUZwVOYDvnzpsp4Ixb3PiP6jwJB7yn9Lm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCQ/z1DLpgmfoxZ4cl62zHoIZFV7C6gPhgUpuIbJcw0zpH89noi/GfUOX+t/twWfVmZUKvhFDwQJvefTJExJD3KyviUOz8bzc/1QNpVvQLwsa+mPFqxZa/GbfZnBnYYKvEexvU6ilZvPSdFolryReh35+SuERLIV9b+DSJds/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vspX2djn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 42F4A3F948
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233512;
	bh=jNbt7oyKjScEoIBZYdPyzN9axx/Wf/C6cCg96ND4tZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=vspX2djnWGvLkHB4vgktoocWeEEIWR6pX2ejrfWKqAMg7+i4mbDJmTXpa0BkvbMjp
	 5jj83HNW8XIaV9imRnHFbpMNPfYaE29KHmEOgEbU1ZSsONFfu4P/eIpvW4SByABOpv
	 e3Hpp5S+MJRkfjJUoG7zwQ34Tbgh9/29kpF2locLvXJ1uP4w7rhwCYobqdIbQj2jIG
	 A9sO0LqUs8M+RSu7j3uMXsiX/7r6X0E/e+P0koyZ6uzDIXsZfEvsHAZIfLZCodop6d
	 I0VldhUTT5bIzIJpeh8gfYLB8+PhhlHlLRszbe0hNX4HHjpi01bPV0nurA/rnTFxOn
	 oELJbyg7/pwPQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6098216df4eso4187779a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233509; x=1751838309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNbt7oyKjScEoIBZYdPyzN9axx/Wf/C6cCg96ND4tZ8=;
        b=lDIs8Alw7l1cD9obb7NNL3pidENppWfOb/QFW5O384ycd0Q3HUdGdvk1rpyPOO6uc3
         2C+HADrGi3W+vc2RMHECXrjJrtWxG42Iuh6DqA91ZXF+aTs9edmbmPgPxoLleQuTas8L
         pU9JWYtY3cVLShwygQ9nnPFg1MvmR6TNHAcq2iW388h/5dxuksSaXvTWBQjFMCbjn0bm
         UnYtAN4NJNtSYthRR2QVz4E+Oq5ZIv8AVDBi49/egEDVJYSKYEhPoL6pv4Hkmlk/UwgV
         fFsa0J/FvMp2JlzLSKiHh5IIIEeSrk5TbT7OC4TzKc8cULMt+UsDHvjo2jyiKjxHk8Gw
         MCqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQy3G28SAtbtLssuCkhiHP3Vmho0p8Tkh7KTxWwPk3H5tXJ0AACbFKmk7k4n7g1NefHIbkVFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkiCUxMGiJ5Sl/q5uSafB9moBU7tmlJf+x1WXsdywvUgoFRTf7
	/WAVQ6yTQmurJaOaiV6jU19TShYmn2R3fo2V6TewwtK014u4Bmne2LedcWWSHv37p+rENAvt6v3
	CWXf3ZGkPiuNJg2IGxm7v9dHBzL/g6nEfq9DZD/XZGxOYVnYZIUxTX6Kw+9oI1YdszlLMwJrqQe
	65+mjhvfSV
X-Gm-Gg: ASbGncuF5qgH0tW23gAaYQjWwOGX5r/5JvEeWMCj16a3/H5LskNluq1/ClOFk0Y5gnk
	aD3G9nHpv65SSnhqxinQ6QUU3Ba8A6pL3ovmj2+xeLnm8JBbMMWmedXKp5ZIfEln/8UrNd4sYqi
	u/6U0ywoTyTqLSR1KCzcT6hLdaeDSEOtDNsp/sTNXmdZOTkpMmj7B5/bmS9le31/1Uxwx/PbrWd
	QxnfG/y87depYFMfFyupFdU/Ma7YpcAiP1YlCmVUNTuWQlQ3spEbqgAeJhYN1KPV+CGdBgw7AHP
	Q+B5qzXSYGcbE3++Cqi4SwrORI5eqGMA5mpGbfEGPn3NXY2rcA==
X-Received: by 2002:a05:6402:50cc:b0:601:d0ec:fea0 with SMTP id 4fb4d7f45d1cf-60c88eb1c90mr9129611a12.5.1751233509012;
        Sun, 29 Jun 2025 14:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4uKLPcGCI7v0Uifs9eHQmntR5QIGSGL+oic23vZukTBXZ3gZ43gYtsuo5c4s6dBF0o4jh2Q==
X-Received: by 2002:a05:6402:50cc:b0:601:d0ec:fea0 with SMTP id 4fb4d7f45d1cf-60c88eb1c90mr9129595a12.5.1751233508641;
        Sun, 29 Jun 2025 14:45:08 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm4712037a12.19.2025.06.29.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:45:08 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [RESEND PATCH net-next 4/6] af_unix: stash pidfs dentry when needed
Date: Sun, 29 Jun 2025 23:44:41 +0200
Message-ID: <20250629214449.14462-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to ensure that pidfs dentry is allocated when we meet any
struct pid for the first time. This will allows us to open pidfd
even after the task it corresponds to is reaped.

Basically, we need to identify all places where we fill skb/scm_cookie
with struct pid reference for the first time and call pidfs_register_pid().

Tricky thing here is that we have a few places where this happends
depending on what userspace is doing:
- [__scm_replace_pid()] explicitly sending an SCM_CREDENTIALS message
                        and specified pid in a numeric format
- [unix_maybe_add_creds()] enabled SO_PASSCRED/SO_PASSPIDFD but
                           didn't send SCM_CREDENTIALS explicitly
- [scm_send()] force_creds is true. Netlink case.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h  | 35 ++++++++++++++++++++++++++++++-----
 net/unix/af_unix.c | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 856eb3a380f6..d1ae0704f230 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/pid.h>
+#include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
 #include <net/compat.h>
@@ -66,19 +67,37 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
 { }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-static __inline__ void scm_set_cred(struct scm_cookie *scm,
-				    struct pid *pid, kuid_t uid, kgid_t gid)
+static __inline__ int __scm_set_cred(struct scm_cookie *scm,
+				     struct pid *pid, bool pidfs_register,
+				     kuid_t uid, kgid_t gid)
 {
-	scm->pid  = get_pid(pid);
+	if (pidfs_register) {
+		int err;
+
+		err = pidfs_register_pid(pid);
+		if (err)
+			return err;
+	}
+
+	scm->pid = get_pid(pid);
+
 	scm->creds.pid = pid_vnr(pid);
 	scm->creds.uid = uid;
 	scm->creds.gid = gid;
+	return 0;
+}
+
+static __inline__ void scm_set_cred(struct scm_cookie *scm,
+				    struct pid *pid, kuid_t uid, kgid_t gid)
+{
+	/* __scm_set_cred() can't fail when pidfs_register == false */
+	(void) __scm_set_cred(scm, pid, false, uid, gid);
 }
 
 static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 {
 	put_pid(scm->pid);
-	scm->pid  = NULL;
+	scm->pid = NULL;
 }
 
 static __inline__ void scm_destroy(struct scm_cookie *scm)
@@ -90,9 +109,15 @@ static __inline__ void scm_destroy(struct scm_cookie *scm)
 
 static __inline__ int __scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
 {
+	int err;
+
 	/* drop all previous references */
 	scm_destroy_cred(scm);
 
+	err = pidfs_register_pid(pid);
+	if (err)
+		return err;
+
 	scm->pid = get_pid(pid);
 	scm->creds.pid = pid_vnr(pid);
 	return 0;
@@ -105,7 +130,7 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 	scm->creds.uid = INVALID_UID;
 	scm->creds.gid = INVALID_GID;
 	if (forcecreds)
-		scm_set_cred(scm, task_tgid(current), current_uid(), current_gid());
+		__scm_set_cred(scm, task_tgid(current), true, current_uid(), current_gid());
 	unix_get_peersec_dgram(sock, scm);
 	if (msg->msg_controllen <= 0)
 		return 0;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5efe6e44abdf..1f4a5fe8a1f7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1924,12 +1924,34 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
 }
 
+static int __skb_set_pid(struct sk_buff *skb, struct pid *pid, bool pidfs_register)
+{
+	if (pidfs_register) {
+		int err;
+
+		err = pidfs_register_pid(pid);
+		if (err)
+			return err;
+	}
+
+	UNIXCB(skb).pid = get_pid(pid);
+	return 0;
+}
+
 static void unix_destruct_scm(struct sk_buff *skb)
 {
 	struct scm_cookie scm;
 
 	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
+
+	/* Pass ownership of struct pid from skb to scm cookie.
+	 *
+	 * We rely on scm_destroy() -> scm_destroy_cred() to properly
+	 * release everything.
+	 */
+	scm.pid = UNIXCB(skb).pid;
+	UNIXCB(skb).pid = NULL;
+
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
 
@@ -1943,7 +1965,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 {
 	int err = 0;
 
-	UNIXCB(skb).pid = get_pid(scm->pid);
+	err = __skb_set_pid(skb, scm->pid, false);
+	if (unlikely(err))
+		return err;
+
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
@@ -1976,7 +2001,12 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 		return 0;
 
 	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
-		UNIXCB(skb).pid = get_pid(task_tgid(current));
+		int err;
+
+		err = __skb_set_pid(skb, task_tgid(current), true);
+		if (unlikely(err))
+			return err;
+
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 
-- 
2.43.0


