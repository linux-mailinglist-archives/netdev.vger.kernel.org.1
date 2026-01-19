Return-Path: <netdev+bounces-251300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39867D3B87F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1342D301D963
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992622F0C67;
	Mon, 19 Jan 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6GvQDN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7B26C3A2
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854930; cv=none; b=L+Uak6ENnwyekxi8Qu+jATNBOPW5b3z4e8GBrFPPWY6g+f3yI8Zh6r1i8guiSvJJ0aNy9aYbbMKeIi/R01FEudjRfK5BwwC//LrJ3qpp4C5vSU1c/e53naUJRsZQEmcXNOKUrKz7j8GAAfNstQzAbq4ChE29cucAq6ucmvjX+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854930; c=relaxed/simple;
	bh=KiRGfmtJ4xUORikJFIRr3lEouO0LztQOKa4NgjykoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoxrfcOyDP2D9hiIV0dAwywj91C0sOc3qyvFpfDWdACAp+/XXo4ipfjGiWM7b/ZjI3gYEm8g6r4+4FHGgwBM5DFQbqrikHxgkPpJxEe1YzhoilFVHxHsPbHMorUPVAct39TJ3ju3tBx2VeyOTK+ywW508kxV/xExlhrXsiDZAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6GvQDN8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b87dba51442so206153966b.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854927; x=1769459727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xlYL6kWRNZ/QxSa4T4clVFBoNXQcapC5L3Qa5qrbgU=;
        b=R6GvQDN8vtvgeshcETCbfLkuyLo+rWvdi9wWH4dH/eB+yzgXbR2TpsUh+Xzf0Uau5I
         1jbwwNorzzGEs+kD/zZ1vktpFaLyXFeqXv464XQyLsC747xiQFCI8DkmW5ev3DQBmPbv
         gfU8GjQpEQgPbPbOb/6NBt0K3QWRUVfVrnZsOxcNNJn+R38t395/ed9I97j+nrmwznuX
         J9suWFS4Bo8Mh/Us84J+2UByaG5aiLTwSx1FymdW0U4DEr4pde/3UVl28qGivZ6aLTGD
         kah9QE9JIRGjJzqXZK9lHx24JdIvW8MLLlkuzABRP49jjHN0wBn30JYU8kYDDxUqb5Tv
         oHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854927; x=1769459727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xlYL6kWRNZ/QxSa4T4clVFBoNXQcapC5L3Qa5qrbgU=;
        b=N7ppRqPeQ9AVjalnSA3Fi3CjeFeeN/OIXZRjzqfjqiYljixq8/xyO9Dei1t6ZoHdY5
         1VffLa6/lfR6rlYvatpqmucZrlbfKjqm3tXjesX6ip0E5z8J4aGvpfoCduD6MUIwNcVA
         y3K9PnpbZrr8AUfwitS2/dSqyCBGMdHyweEZS0+SEDHa4oTAUDU/tIPNZbdPgbQrpnl4
         nDliJ443GFB5fQin8bm0S41y6ZpbAzyrsfQR8PlVWiK1Y0cwfmsODF/16RfZ/xJKTKBw
         EyFI/x1FppvU96nEzslwOOxcCI5g3vudqwGiank9fVQ1Jrlxe5y0BnrOE61I9jAj1Aau
         9r2w==
X-Forwarded-Encrypted: i=1; AJvYcCWMj5BhDmnnn55IR+j6kPbd5gksUUszE7iMZvibk+v+xmg6vKdP/hej0LTnT0kHzRubWo0RibI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGvMjrGhTb/qPCvHF9+CJrE7aPPW5uO3geu4SjyDuf+N5lYCd
	qs8bfo8XoBuzaFxRmLtMjD1BaGqLWDbwyi0NpvGqyGoVTTuPXyzO2lSq
X-Gm-Gg: AY/fxX4songwaLdLHeDyVIW+4o5IkcR7Bp0TMHB47cEoN8cwCV8/GqFYtBT284A8Ots
	gWLUnP8su+sn794rNSxExaj5b9lin3plZBLSdwF6+RVT65eosn+E25gzBMfV61M8L+uLARVN60N
	H4YSBBheivCKYUCMeanxR1uqWW1FQVtUHCMz2QXKoYTesfOxRkBUCxc1MP/swc/ClIx2tv8s6EA
	pBybyLmfzyaQzCSXxw+fw7JnEzkduCL3LG2+bUSLm22ov01/HjySkOzFbBmAsoKvMtNikyo/tYU
	cX8o8AZWHMHUbafemgTOjCC1sb0tT4xcsAIkYd/LT9tI9ujXoZT3/KtYt8+Qo9nntkh2kS63XxV
	/13KGDQZsOEGp5S8yvnx/R2kHYukNGhN7pIQtbsX44773DHegImiLzgQPatkgkF/wKqLQWg9XyX
	zhIufYixnHyrwOb05fO+cYm3wSFZ6C7PBR3Fkf
X-Received: by 2002:a17:907:1ca9:b0:b87:35fc:ae5f with SMTP id a640c23a62f3a-b87930381c7mr1176671566b.52.1768854927147;
        Mon, 19 Jan 2026 12:35:27 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654535c4b8csm11421204a12.35.2026.01.19.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:35:26 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>,
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
Subject: [PATCH v3 1/5] lsm: Add hook security_unix_find
Date: Mon, 19 Jan 2026 21:34:54 +0100
Message-ID: <20260119203457.97676-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203457.97676-2-gnoack3000@gmail.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

Add an LSM hook security_unix_find.

This hook is called to check the path of a named unix socket before a
connection is initiated.

Existing socket hooks, security_unix_stream_connect(),
security_unix_may_send(), and security_socket_connect() don't provide
TOCTOU-free / namespace independent access to the paths of sockets.

Why existing hooks are unsuitable:

(1) We cannot resolve the path from the struct sockaddr in existing hooks.
This requires another path lookup. A change in the path between the
two lookups will cause a TOCTOU bug.

(2) We cannot use the struct path from the listening socket, because it
may be bound to a path in a different namespace than the caller,
resulting in a path that cannot be referenced at policy creation time.

Cc: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 11 +++++++++++
 net/unix/af_unix.c            |  9 +++++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..84c1fac3ada6 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -317,6 +317,10 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+LSM_HOOK(int, 0, unix_find, const struct path *path, int type, int flags)
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..cdcd340b085c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+
+int security_unix_find(const struct path *path, int type, int flags);
+
+#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+static inline int security_unix_find(const struct path *path, int type, int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
 int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d0511225799b..227467236930 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket
+	 * and we hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, type, flags);
+	if (err)
+		goto path_put;
+
+	err = -ECONNREFUSED;
 	sk = unix_find_socket_byinode(inode);
 	if (!sk)
 		goto path_put;
diff --git a/security/security.c b/security/security.c
index 31a688650601..df4e3f99de7d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/*
+ * security_unix_find() - Check if a named AF_UNIX socket can connect
+ * @path: path of the socket being connected to
+ * @type: type of the socket
+ * @flags: flags associated with the socket
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_find(const struct path *path, int type, int flags)
+{
+	return call_int_hook(unix_find, path, type, flags);
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


