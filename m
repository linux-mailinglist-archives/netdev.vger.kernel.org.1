Return-Path: <netdev+bounces-257871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPqaJxwYiWkd2gQAu9opvQ
	(envelope-from <netdev+bounces-257871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 00:11:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B710A920
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 00:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C0953001FFA
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 23:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C624341AB6;
	Sun,  8 Feb 2026 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNvttg/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91696303CA0
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592281; cv=none; b=EHeXW8pMujjDsupYQ67p5Yg6CMO2cFrlfCOxFmn5SnxOOlQr+q0+13XX2BAXTsDspUFz0Arjm/iV1QyohpVrVwt8CNylQGbARSTXqqbjNMma0ewgm5grH35UE3BAADLuB565AnTQJdBO8JIqCnoQlm59jMi/gWX4/du/4smo7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592281; c=relaxed/simple;
	bh=cNt5CUg+QKY5vJPuqYDNNo/2PhXuTN/ysasTKNiRRjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uns1CQrW7TXgwmJPKB2hQMe4W+k7gzbPFuUUZmLc5Kv8wazuMiZKlguWyUNeNXtawbQmwyw9RKDkk73kihZlzwqocCCt0kOgiqh06tAUACX2C81DsVl2O4oXEj6JK4MapTgq85ah1ft/1mQyUJRIZAG2EUaC0KHmCY0/6PWc5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNvttg/N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so59414565e9.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592280; x=1771197080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOB4dYixsjnFCU7RCtCj08R/1mgwYw7mAEm9A45N/uY=;
        b=UNvttg/N1a+zZbozh8XhzU0IJYblaRiQP6rGmEqHxF3Wvgn+P2W1DQhtqkYnHNbqgb
         hlD2BMVbthaR12mPWHL5YVfkte7VZTHOyBDI0fL5RP5mnCNvBPkf85B9jmUuGB01PwsD
         YfSbGVV2BnwllCHIZSbjC2FFzR9qYBAnAXqj/5/QAlkshyyiBN1ocDrDScDAx5GuKeZ4
         /xHTVKMvT5fJ4+VsRSAlq57RRGhWyDX9MUMJ92i34sKQp0zPxslP/qOZA3HzEJA8UNgC
         AiSNTFbuU46LtVIA5WEzPUEOWPq4FduMeSRIwFRkhC+eHws3WRtLT99Duzcw3LKZEKlg
         UNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592280; x=1771197080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOB4dYixsjnFCU7RCtCj08R/1mgwYw7mAEm9A45N/uY=;
        b=fnMEnXHkzHdXu1RqeFwazyOODtixd0OTKDg/yBMEPigDRqq4wnnerh9QHEILlrLcRC
         k6txpk7gVC3V+WtJ1MfhHGqM5AWAJ85lnt0Bz35TwdKesMj9bLA62Cp/igerJppExbrk
         Az4b+GYHcZGJiThFifgujJVApIW/+uNiOMO/wAhnZimF5HuQv8H6MESJ62R0aZ6gxo2K
         Gd+ErruSX9JStyNO2QStoQulhsbnpKrY51oj6TH5WbA8wXWIh0noCX0oT7Ve2Z5RL1z/
         UAUbMTXaw2ZX7aUIOU5EepIBdluJCq639xH51fX84QCnFt/eiJIS4QJQAhI3VRO/OkYd
         t/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUsa58j9/KbjEZj5IqLNj5eYL6zX4Kx4nIT+iy+s8h3mDUZ9EMWbpuFDPOsZZZlo3y57V9fZGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqte9CRE57Cqv+lJXHQ8G1xPXnl10Bc6Ijs862VtbTZMdRxvi
	2APZqI6Oabqq+ZvVRAbwaO8soxt+nYYYV2riIRAgNguQu2wWbZbSumnB
X-Gm-Gg: AZuq6aIYl6whwGu70Fc1LHwtaG2SNcQbtQmkJQU5eu+WzJg7AyvIWR6pwhYaA4tNkU9
	N6u/WV585JmymYWbtdVi/NTLvqAAJTEvnv+nFZovN4IcNG94BK7iX67rsZqTQzEgWDouOPJOtj5
	I8i6Bs9cwOG9dIUS4DfTroWl3amncA3dFQddsSodP2F8dMOJXSJouODrqEh+zHIEntNQvFqxvTt
	/UrkGK+lOCoTdLHsZu9/x3J6E44vcKR418+RYhPc9IS39uLZE6wD4nlj6hoyEGPgAv6yCB6VfV7
	idGp22JF0dBBv9JObX4D50WUYJoUxVD56PyDfLSMoz8xBzfuU4re5pcJfoiJYil6Kheof3/DzF/
	0yuMQrDpL+G8NgVGjJ2ojYqDDgRGa/uqTEomS6ZR7rRWKuaX82Z7HaRGdqS4jb/Ts3PLSDCXGvp
	YvPvcNqiy7pgmXvZJzLUnynP92Ap2E5ctsAQKJ
X-Received: by 2002:a05:600c:8b56:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-483201fff35mr127058665e9.4.1770592279741;
        Sun, 08 Feb 2026 15:11:19 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm200490325e9.1.2026.02.08.15.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:19 -0800 (PST)
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
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 1/6] lsm: Add LSM hook security_unix_find
Date: Mon,  9 Feb 2026 00:10:11 +0100
Message-ID: <20260208231017.114343-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-257871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,maowtm.org:email]
X-Rspamd-Queue-Id: 118B710A920
X-Rspamd-Action: no action

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
 net/unix/af_unix.c            |  9 +++++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 45 insertions(+)

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
index d0511225799b..db9d279b3883 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,10 +1226,19 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
+	err = -ECONNREFUSED;
 	sk = unix_find_socket_byinode(inode);
 	if (!sk)
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket
+	 * and we hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
 	err = -EPROTOTYPE;
 	if (sk->sk_type == type)
 		touch_atime(&path);
diff --git a/security/security.c b/security/security.c
index 31a688650601..9e9515955098 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/*
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
2.52.0


