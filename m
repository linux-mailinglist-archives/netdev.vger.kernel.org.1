Return-Path: <netdev+bounces-248703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78743D0D787
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A79E9300AFF1
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD728751B;
	Sat, 10 Jan 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUqxzCJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60272046BA
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055674; cv=none; b=Sug69tit39gk6E48XxYAgXeb6urkyGoXi6AkCx/0PefEEXVY4yDi7Q82fquNCRn8Uv/gPMm+SECo+IfslZlTHbFt0Zm+TYfEeKCCpDz+be9rUcLM3wN9oyw3f359TmUhD6CznT6qEUfSjismJZGsRTrgQ5Q/2dLGAuiwHfu1Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055674; c=relaxed/simple;
	bh=/p1VbN6nG07QPsZrCTJvZLzYmNZLIDOLoWsTzdzhHKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLY2k6B21n4BrrDYX+viMxUFq6Qcijjr17q+/Dv5sc5nlFj2+MfwokX23yuMZxzpoQhj+Q4EsV0kpB0D43AK3S1IG/rwmKQDk/oQyqEMdu1V+ST5HGtP8IfTnELrdEeYxL6fxmy/7/mmSLLrSlpwvJiLNXQw9gMkRq0e5fniogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUqxzCJM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so9128821a12.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055670; x=1768660470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wo/YIkbelmV6FA4SKOGcNkJM9mvKN+FOz8CqB+Y22k=;
        b=UUqxzCJMzfVe6pkRG5yGeos3/F7FUHM9OB9Ia1KBeuhY+LbtBy3cAFy+Es336gaa4H
         bcSZ+qfISKnq49dsaRF1CeZ0QZuwyQhAycezhi04/CbvtIM6yq+nouM+9LUOZaS6p6kR
         +fceBCXyMWBAaun8bfLQyB9u9mGdSxrjGtDwhT9AqXwhpRKrL2OGCkYwdedwhzgixpnE
         wccM+ETUCKbO7XmhTSHkFBAt9WHSYuj3C+hmZqbBLpLg8Zq85QGWS5anYU2u9UHEm5MV
         dw9desmNvOzuOglzBkiuzl8m5x37v7ib+hdxF3pYJcJK7WsiV0S58ePLi9hw+TWHwhe/
         csoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055670; x=1768660470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wo/YIkbelmV6FA4SKOGcNkJM9mvKN+FOz8CqB+Y22k=;
        b=ZXT3/qOyEp73+fZE2iQjAmQYaqX8f4LAAx1+DhKxUgVBRo8UKzdjZ3ZHpTGz8RAESC
         vIAWImh9KK4PQ+Vo83ifQJzhnzZJws9EzEvP5Tkx7njsqAYyM0maeylEilIIbUTO7Wls
         z9fpWPbTWzZhRlFiddUafREygC9bU5T89/1JgLCvMiDsZJcFH4AbLYRVrsqoZnJdVW4j
         7YlVRQW+xUb16j0ge31PlQu8Tx7Wawat76bzBBrXlRdY2hndMiBAoWBFFdWALLfNVsu6
         oLe/xMHT3qRu1l6i3o8zSDjxq2lp5QRrLuWgnRR9d/Pn5AWBax+elUzMS9dkz9miUPEf
         BAsg==
X-Forwarded-Encrypted: i=1; AJvYcCXalCbDcdOa3zGb63rhPp3WDBSIisatWuEA0KIy+x3i5Vg4QjuJ7fY1og0jk5Ctm2mGiNq7ORI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2rZTBxpcs9slXxu4F3SOUF2YmUb0wh0R0DVWZm5Go9fV58Qr
	BWWIkHXh0U4/82v5EHJeDVf3v+u9hjrAkeJNZS9+TJjpM02QLCiZ606d
X-Gm-Gg: AY/fxX6jCA/RLwBTN13raTdiMv4afe9W9pz+uZUpxBVPnJlniexPCfSpFc2br8O87cP
	5LyDvKyV2sL4+eb/Thp5H7NMejA0DzqSYeQValRjaWHOyzsD2/uEEc69AMouIGPXEhedKeyHOKF
	XCtGBlli9v39hGaRQuRtwjopYTdqMMEOSvvIoYx8/Zfx/NyQctXq7IAcpExqz9AMQOXKfxdwRna
	oeNbt3bLW70UCsPCx/QNYUsJANvA2fP7FdaH0xOQ5gmBlQuoCdIMcQ/G80oaLPgWwB4/UMllkvz
	kJJyc6upgA0ztq1/zuA5NfNZhS7wqBeZs+zJKuq4WjCAlAAZQIPpAC1rP3RETzsKI431x+0QdDW
	TsGSJiLGX4dsX17OYq0OkfS66LDJaFZcZre3CkBpKYn4dHMR6xcrYcPBl+BJRDZu/xZO5M6n+IX
	9T470iwQunw6bZUxNWVnUVy/wq1l+/p2ea2HtL
X-Google-Smtp-Source: AGHT+IHO9Q/Df/iXU72DbJL9Ky3HfCfxGLLpzRBeBwC5mygtDa80lVRMhr065JbDYAexMcmrwnDYFg==
X-Received: by 2002:a17:907:a49:b0:b7c:e4e9:b13f with SMTP id a640c23a62f3a-b8444f4e435mr1319406666b.39.1768055669949;
        Sat, 10 Jan 2026 06:34:29 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86faa6be37sm124615066b.36.2026.01.10.06.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:34:29 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Paul Moore" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 1/5] lsm: Add hook unix_path_connect
Date: Sat, 10 Jan 2026 15:32:57 +0100
Message-ID: <20260110143300.71048-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110143300.71048-2-gnoack3000@gmail.com>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

Adds an LSM hook unix_path_connect.

This hook is called to check the path of a named unix socket before a
connection is initiated.

Cc: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 11 +++++++++++
 net/unix/af_unix.c            |  9 +++++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..1dee5d8d52d2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -317,6 +317,10 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+LSM_HOOK(int, 0, unix_path_connect, const struct path *path, int type, int flags)
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..382612af27a6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+
+int security_unix_path_connect(const struct path *path, int type, int flags);
+
+#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+static inline int security_unix_path_connect(const struct path *path, int type, int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
 int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..3aabe2d489ae 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket
+	 * and we hold a valid reference to it via the path.
+	 */
+	err = security_unix_path_connect(&path, type, flags);
+	if (err)
+		goto path_put;
+
+	err = -ECONNREFUSED;
 	sk = unix_find_socket_byinode(inode);
 	if (!sk)
 		goto path_put;
diff --git a/security/security.c b/security/security.c
index 31a688650601..0cee3502db83 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/*
+ * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
+ * @path: path of the socket being connected to
+ * @type: type of the socket
+ * @flags: flags associated with the socket
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_path_connect(const struct path *path, int type, int flags)
+{
+	return call_int_hook(unix_path_connect, path, type, flags);
+}
+EXPORT_SYMBOL(security_unix_path_connect);
+
+#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 /**
  * security_ib_pkey_access() - Check if access to an IB pkey is allowed
-- 
2.52.0


