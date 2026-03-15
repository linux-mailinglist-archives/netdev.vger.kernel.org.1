Return-Path: <netdev+bounces-267978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLh2NU4xt2myNgEAu9opvQ
	(envelope-from <netdev+bounces-267978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 23:23:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F357292D5F
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B42B302411E
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03137AA9C;
	Sun, 15 Mar 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWfANPRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6C371872
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613374; cv=none; b=brH4JAsxg1WO9iheyAJSuopYr7yPTj1MTfQVRaTN5RTAHVrIOeJiAv113r7lwcxvCNa6bWmXvKRxCsw90/mabiU7Jq3hsnj3QwF7jsfQvOHk8Nndb8zmS6cbwfxBhjXtpD6zB2pMg5LaF4vipkQo6qIzGejDYovHsJbJa4fboyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613374; c=relaxed/simple;
	bh=a5clCKlVVaQsoPp19uxbvBmg6L1SRgS0j6aD/5JG0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwUndJw+D6AJJqt5CUZDEORrVXZVyfbHwtXhC6FaHpQaodBfCkqFiHVqNqwukeZD7YGLuh2sKHM0Pm3gKqguBMasfjJxWqWX/CbrZbNpniaFQxU0h97jQm4ApvoT9O8rKCzJafhd3EACyDvijmkBP8dR3yClzcO8sXSClPuQ4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWfANPRz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so32922355e9.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613371; x=1774218171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vYb8zk77RJeTsnuwNyjP2YHLld02/2ZSGp8Cefi3f4=;
        b=hWfANPRzVQwHvuEGVysRPXAOjzMgqW+cED4k4G1hceQZSNSIC0GzYYRjPlO7VOjwTY
         7bEfvxxFc/fTFMUHl16/zmES+LG7ayuIIIv/pettHZ/8JUPzsyRZFZvNh8PO9lXEIx3S
         gJbQuXtOV/QcKmj8qmBSAy0WqLGC95A9jmZCr4sXL+hZ9U0hxa7upC9BwR8OblniJXi6
         S/E2alp2GBMGTUEPWPm1CRA/2hgkUIk/SMDf92xiYGOHNILC3Rx6p4k0/K91iCLGyEFJ
         3ZxL2vpAW1HVthr6IlgAkTn+Ohofv9HpkLZW6yys5x96oYN21eciXkJzD+ejQ0lJ+t0p
         fsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613371; x=1774218171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vYb8zk77RJeTsnuwNyjP2YHLld02/2ZSGp8Cefi3f4=;
        b=hHV0oK0JWlVc+GGz7FGUmygAhlPvN0aJUJZt1/+Gjjugkn6MEshz/+LTPWVypV3xzw
         IbZWhYBu6VH3PGbzvCzEa8GCpGa/pswC35pEyNYc7cRk9TZ8UvUz7hTN4K/IHA+4nLUD
         VHa5uQFPDJwHAgnC3eer2yC7uxjn9KzFgvBgxBm/iNcPNw7LlcT/gIG4CirpCt5hNHBd
         +8dcAOqAQdsw7ZGfHUipuSxws4vzfyILHhjYv/PbEwHy+aYU4s6wWKBeuiMEkDGTbdiw
         lbnspzlBB/YdMDnKgcFCdoS+1GRmmyxJPmXw5JdvJg/L1hnSckg59wlbkmTW+3AVoyMh
         bmiw==
X-Forwarded-Encrypted: i=1; AJvYcCUOw/u9UR0eHFLkGiH/6FngoJ6O+7FJwzonC/JYMgPvYgnY5jUW1NgpgLdTKic1wKQmhItvc3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdclYtwb5DIatAKxC3Qm5azF9DGL/IDZezIS5JKPfSW1qqnxTZ
	3RcFoayjLlORBB6fB6xLuNqE/vuYUhpsXU+wgyxsI3LVXtXvgMIj47yU
X-Gm-Gg: ATEYQzw6YROcten5LWB0WnfzZVuePniX/IBdiyf8vNHUBByRx5+kByrG7PoMlcAgXfv
	9gKhxLZ9GsQfQH4KhBDnTiAsQKLCKNFVu44c5nww5xCIDT2oYu9WBWAUS3dCkzN7XndkV2tqm3A
	grWgfTlashRr8M0aslX3/P6VF8TU11dBDyYqSLNzzpO9GOt+8+3otQHRQDHaMUGLS0Sskd6G7KL
	mSw1OBo9+9GZqbL6wAXEuIsMBsBAV+ERV1fMzxjw3XrM1bhKqycNtviwh31Wzvn+To+4FR4nWSK
	JOuplBv0O5Ah+UJxoOF6raIST4jKErqRZFMo57ZdCYddaQYTcfc/X+8s1HuxmL8tC64DvmDtBxT
	qyTsal68Huzzd31PGNmsMv2/0ZBGa7q9pxelKW5x46cbaO3WkB/L//29XHEI/h3jTF+oqw6YUzN
	rtHPHicb8KyxEyTcfZm50xU9q2s5oo/npndaw7cXGgtCFlCSA/
X-Received: by 2002:a05:600c:3b14:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-485566d94afmr156892115e9.13.1773613371161;
        Sun, 15 Mar 2026 15:22:51 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6e25bsm74817505e9.27.2026.03.15.15.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:22:50 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>,
	"Paul Moore" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Date: Sun, 15 Mar 2026 23:21:42 +0100
Message-ID: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-267978-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maowtm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F357292D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Suess <utilityemal77@gmail.com>

Add a LSM hook security_unix_find.

This hook is called to check the path of a named unix socket before a
connection is initiated. The peer socket may be inspected as well.

Why existing hooks are unsuitable:

Existing socket hooks, security_unix_stream_connect(),
security_unix_may_send(), and security_socket_connect() don't provide
TOCTOU-free / namespace independent access to the paths of sockets.

(1) We cannot resolve the path from the struct sockaddr in existing hooks.
This requires another path lookup. A change in the path between the
two lookups will cause a TOCTOU bug.

(2) We cannot use the struct path from the listening socket, because it
may be bound to a path in a different namespace than the caller,
resulting in a path that cannot be referenced at policy creation time.

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h |  5 +++++
 include/linux/security.h      | 11 +++++++++++
 net/unix/af_unix.c            | 13 ++++++++++---
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..7a0fd3dbfa29 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
+	 int flags)
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..99a33d8eb28d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+
+int security_unix_find(const struct path *path, struct sock *other, int flags);
+
+#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
 int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63a..aced28179bac 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1231,11 +1231,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -EPROTOTYPE;
-	if (sk->sk_type == type)
-		touch_atime(&path);
-	else
+	if (sk->sk_type != type)
 		goto sock_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+	touch_atime(&path);
+
 	path_put(&path);
 
 	return sk;
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..c73196b8db4b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/**
+ * security_unix_find() - Check if a named AF_UNIX socket can connect
+ * @path: path of the socket being connected to
+ * @other: peer sock
+ * @flags: flags associated with the socket
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return call_int_hook(unix_find, path, other, flags);
+}
+EXPORT_SYMBOL(security_unix_find);
+
+#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 /**
  * security_ib_pkey_access() - Check if access to an IB pkey is allowed
-- 
2.53.0


