Return-Path: <netdev+bounces-246468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6415CEC960
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 22:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59252301339C
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F9309F1D;
	Wed, 31 Dec 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLQTD+gV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E52E7180
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767216806; cv=none; b=iE+KG3tghAe6VrhjZA4l9OYdodbSa+kig6ZerG/aD+9oYt1Dcyjc1dLShXd9oHkq23WEZvGJ7IZEp9qzTiRkP4TGa1WH9qFmmBuKTP//733qxhxHzK0aPWuqPEmxw14U/IrNtIA/LR0p1Fo/11J/shRNa0xhfztmT2fSxWqFJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767216806; c=relaxed/simple;
	bh=EhqLjMwXPLeEJ4n7ChdBRJacqyLNc3Tb0coR8c9b9u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdPfAQK7s+Bav7QNN+7inCjrGKwMvzTaNrd83LiNGmER3mocDUPww1bFO68kMgR6U5xd3FGr9wWZtVvxajC5+efNGn3qY8AVvNdv5a4pZgsiFuMsTVGB1Q1VprYTSK1S6ocGxXRloRbcpM/0vCyS1US/dWYI0eDyX7Rxqtn1sWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLQTD+gV; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7904a401d5cso16630847b3.3
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767216803; x=1767821603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdQ4Ki/hB7454VTZhQIuEANOg0xMVfdUwOztEZZg/uI=;
        b=FLQTD+gVLtUThFcmYFgGFXsWmPccfLm/MiLCpKbdc+GugIR/O1ieLSJAX2sO3ZYnPo
         HTdT+PAWvLd/w4xPe8YYji/3oTrbpBt9Ltw4F6AERLS273BzWYYnG6poij0vHuTtsrQn
         fCmj6tRSPZRJC7JYuE03xpEfyPW+e/fsVSb+BDkiU+Dus7XJjyGslv3GYuTMO1z/kkiJ
         9DpR3JLzr1XyJYY87asdR05hL5og+Z5TZ0rCT3R+Qa9WrFHs6g6XIGhrLJdyOzIPcbcQ
         PoXKAXUbWqv07ew+mlHC1t6aMQu1bqIulT/nmYt1MZwu8AskngVkZwCwUYn1yR/X5GZm
         g/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767216803; x=1767821603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdQ4Ki/hB7454VTZhQIuEANOg0xMVfdUwOztEZZg/uI=;
        b=wnHFB0QJ8IUO5rnrZq+b6U8Iw7IsoMP8Q2CDOEZFoehIPFZFtWFpuU5Q9Xi9mNDXJT
         i6AYzIxrfuqvLetW9VKUJK4sTm0NrE4k2u3JYwYyP/8hA44NZ7thG7bfM7VfbbQp3HTn
         fOrSsYqzA9lerJDYD5bDbIuUuYDih0rxR59kjyQygqnR+f5lp7WkI2vHMIBysjuSeIS6
         5WHV071wz5XHKLw7AIhoHOxeuliXieP3DZHbJb3MieQRuA4asy90/05SQ9JhPRJsIBMA
         Zs04s+NYN000Znq5JeP3cUuRZb0VvcFIkfag3alamG88DAyx4O67I52Q/p/zpwtSdUts
         2pMg==
X-Forwarded-Encrypted: i=1; AJvYcCWiWxVYXI+TqwyOKL7mfJn6dPPPQQd6shDmEhdUtG7js+pPK+bNoX2ZTohgSMjrqoty9xp98dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKG57R7XLT00ZXEjNKXV9XO6vz7LcZ6foClWGVTLoVfSwDEW9
	Y0GQIUelAYIrWnwDez4dtaF8yY94kE1ADb6JdX8ooK4oMtJiqP2UYtT6
X-Gm-Gg: AY/fxX7C8+xfIUCk3M/gannzI3+RcFDDa6oCypghuYTCbXW0LmNyn2suAlHoSdJHNHP
	DYiv0vsvsYWKCOycNqDJvOi885W9GqwyUzQf7rsHGoJOsw6zffWYpLNCwsOty8Glge4kgq3P17U
	G6Itbfsuq9Zn9MXYLzOIunZYbP36VnSZAoELnXPnXD5drfeVnJb8tTn2AIYBRwMmAQdqyFlJuLY
	6ZDprL9gc9vMmHvkkTwsj4qMgUiDEvLWhXgdT/wC/9pkQs0syv+ZMAwphf+NsIyJrvykboY+Esv
	65yhtfhU8JpBn61bf/vB9hY6mhiOtlNFL0yoyx7M3eCoad9MlEkhn3pG7Hm8OqEd5dl4j9ITqzy
	2v64Bi7lMoXLVKZj+fvJYKR9S5JGdsuQC48BUJbITBmXEicNaMO00KFRIGkaB7q6WWReI2k8tup
	uDmwC3bg6GlygoNdibna7NYvkt4MhccmJjF6JqL7Si6mla3nYAvpjugjPXa1XZ
X-Google-Smtp-Source: AGHT+IEdusLGE/9/tYJjOpucGEwzEt42su1oHuLD40MTV7i9u7v4JsyOmbp4eLlg/vvddqvexFXOVg==
X-Received: by 2002:a05:690c:6181:b0:78e:6176:2c8b with SMTP id 00721157ae682-78fb406345cmr285864317b3.49.1767216803523;
        Wed, 31 Dec 2025 13:33:23 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0d57sm141931647b3.31.2025.12.31.13.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:33:23 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 1/1] lsm: Add hook unix_path_connect
Date: Wed, 31 Dec 2025 16:33:14 -0500
Message-ID: <20251231213314.2979118-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds an LSM hook unix_path_connect.

This hook is called to check the path of a named unix socket before a
connection is initiated.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Cc: Günther Noack <gnoack3000@gmail.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 net/unix/af_unix.c            |  8 ++++++++
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..a42d1aaf3b8a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -318,6 +318,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
+LSM_HOOK(int, 0, unix_path_connect, const struct path *path)
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
 LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..ab66f22f7e5a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1638,6 +1638,7 @@ static inline int security_watch_key(struct key *key)
 
 #ifdef CONFIG_SECURITY_NETWORK
 
+int security_unix_path_connect(const struct path *path);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
 int security_unix_may_send(struct socket *sock,  struct socket *other);
@@ -1699,6 +1700,11 @@ static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static inline int security_unix_path_connect(const struct path *path)
+{
+	return 0;
+}
+
 static inline int security_unix_stream_connect(struct sock *sock,
 					       struct sock *other,
 					       struct sock *newsk)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..af1a6083a69b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,6 +1226,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket
+	 * and we hold a valid reference to it via the path.
+	 */
+	err = security_unix_path_connect(&path);
+	if (err)
+		goto path_put;
+
 	sk = unix_find_socket_byinode(inode);
 	if (!sk)
 		goto path_put;
diff --git a/security/security.c b/security/security.c
index 31a688650601..17af5d0ddf28 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4047,6 +4047,22 @@ int security_unix_stream_connect(struct sock *sock, struct sock *other,
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
+/*
+ * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
+ * @path: Path of the socket being connected to
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket. This is necessary because it was not possible to check the
+ * VFS inode of the target socket before the connection is made.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_path_connect(const struct path *path)
+{
+	return call_int_hook(unix_path_connect, path);
+}
+EXPORT_SYMBOL(security_unix_path_connect);
+
 /**
  * security_unix_may_send() - Check if AF_UNIX socket can send datagrams
  * @sock: originating sock
-- 
2.51.0


