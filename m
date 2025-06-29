Return-Path: <netdev+bounces-202293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D747AED14D
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9596518955D4
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D16242914;
	Sun, 29 Jun 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="awLfPJZZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2430241672
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233239; cv=none; b=qsYI4bd0eDHdjYYZGp3SUaRS1utKTZSs8U9AutEs3jYa5b6OBvBzqLa89d8hX6vp49WueTdHa8vKOHjSe7dqSIV62NxhrBToFTj9q7wzAdUsEkDtFxaQlb8i7XqzaVUp2PZQ/F6vS5szS6CHcK+pkCS4Ley/Gq4EYkEcBOjnlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233239; c=relaxed/simple;
	bh=DZgLuTKQ6FkE/AqtchhZEXS16TEbGGbw+cRTURV4+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V18iiNgx+pueFWu7oqvvIQxGksgIUCYQrq/lF2Ml6JEKPtdEWn0l7421dxzPQOO1VqfXn5Ew8pnS413aeaS2yDDnVkQ56k1/2ZO7qRsMhbdXrVkue7X1BR4y+80kzZlqWKnMMyp6l784wUQtnr6FOx9ckBFSfH/xwzFy88V0qKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=awLfPJZZ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 292983FE20
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233236;
	bh=Tl324YoMVF9U2iaqiQA87hf/uf124Y9qhcfNcjMgLzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=awLfPJZZkb6z7mGzc3DxeCgN7e6PEviinD9CkwumuumfuSHLvEYt/Hawa2w1wl8ho
	 f5fMEwoP3tcrK3pRXPnkyPUY30FmjBPv+fTVl/+5SYkTnySy0wVpsczSnmdsbct0EA
	 R4tnNETgk5HCpzo+yVi2asY8liEYg+qiaFyo8rcmPjiJaT+smxwBe71YQt2WHKoO7J
	 Dd7AkQBXWnF5h87DxP8yVYQdv/E1OUswQiv62AD/5JWmFC5M51vbPC+Y1MV9utuZuc
	 zc+NCqcNIygqewbxr6ZkPh28THas6lUoN9PaqLSmTXM9890mE+YXzBB0FogL95PZJi
	 FQbwRlqmM/XtA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0a0683d6dso127662466b.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233234; x=1751838034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl324YoMVF9U2iaqiQA87hf/uf124Y9qhcfNcjMgLzQ=;
        b=EDOnjngoZEp12dSQRE77SWANo6QHb8lYNdJo/3qRLTsLvpNvJ1iQgp3uzUna/Z04LO
         znrZ0lMgS5oYvXY1klHpemvgbQu62nt0oMsiIUFRMT7oJiuCdukX+c5+YiMwxffWdnit
         oPMAcDSwUmzl4M42v5QI9PsJo8xyI0NJEgX/EniaI4Qtr9ldXNstNV0qUiOPvteCnk8Q
         85ntc/E5G4eurRP/aXT54m/IOwCeDzQVshWc5AO1l0AVQGhq1pcdgvjSdW5bClJrt/It
         H5/xxnQTMKzq3BXGDTCB+qLZoeAks5jyR9ovnBUyfJHsf6W2Zlfl+HsL5EdbkYxBepAE
         t2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUFjy4JCZ4kQl4+0uaXpoXytmNlLSwBpuc+7BNeBOFbe2tkobYSjxq+cuwVsz4Q8iwoWg2pQhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf78VVGccZdUVIj5e3Gs891iTm/fCuUrfFghmKEaBgWcMdrUQQ
	mh+Da+T3IoSqw6pxXcIz1OKMsrykJvUxurfmdJsgXShEwcO9lXdIa/CpGHKFyLtnkEj3Or7iGyC
	3mNtV1f/Hx2VPP2GvcXyx1LA70u0mYTF3vKeO2pUZNt6hwPJl6ez5DdfjHhkxf4FIcmvpNbQ0df
	a+WXPjEo0c
X-Gm-Gg: ASbGnctcn2GvKPeeGeaWiyJG6QkpQzAfnzjY5eGkjEOzmBCLYxFaC7BvR7Ufoktd09M
	w07fMb1JYe3UdYgLVaUFWLVUcaoHHv72GEcXAmxloopSt0U9SelVzy+QjeGAwcqp/Uex4XiLE5Y
	tfedKhiSerxHYkiHmOh/8OgUIQ/4aQ9TDBPGJ4/6tL70/K47B5/2kojKdhq48gFnfAqnmcwjtEI
	xkG1CxU5JHZHwcwOOShLqEXdvRH+ASDLZU7l4KEgCUKo6Fddr59fjOg7q9mWeZoCCuMvSn5IsO7
	64oTWgX5bEFeDLRi8whxLIQkjet5NI5g/9CEryE8UCzVm2jJWA==
X-Received: by 2002:a17:906:f599:b0:ae0:e065:de05 with SMTP id a640c23a62f3a-ae34fd2b394mr958334066b.3.1751233234622;
        Sun, 29 Jun 2025 14:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjdWlHgK+zYjhF9mE4dngqx6K9Qj+r2/9463dOMnUDM/NfueYNa7ewLi4OC121uaz2TDdYAQ==
X-Received: by 2002:a17:906:f599:b0:ae0:e065:de05 with SMTP id a640c23a62f3a-ae34fd2b394mr958332566b.3.1751233234217;
        Sun, 29 Jun 2025 14:40:34 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a754sm557263366b.62.2025.06.29.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:40:33 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
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
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next 4/6] af_unix: stash pidfs dentry when needed
Date: Sun, 29 Jun 2025 23:39:56 +0200
Message-ID: <20250629214004.13100-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
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


