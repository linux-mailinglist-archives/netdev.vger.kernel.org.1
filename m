Return-Path: <netdev+bounces-258769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMoWOXilkWmWlAEAu9opvQ
	(envelope-from <netdev+bounces-258769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 11:52:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6713E84A
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0BF300CFC4
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A12DCC01;
	Sun, 15 Feb 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMysdLQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B52DA77F
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152755; cv=none; b=B5GW4VxbQGv1bxB55obwVadHOxKwe+zlKfdJrW0e4ZTlagrKkKuH8A88TEEMvJR8GwZeWVRPMVVSEY7ZGm2sVuFDAZ2jigXnp7s6TfNWRdSv/10gWSJssGWNtrnaDrzKIYxj85W5bvkyg65DCb1D44FYb6oOn3YZLhgVTBkiKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152755; c=relaxed/simple;
	bh=GoqhMJKhaJ1HZGtd8+mstOosyCtSnaRv6aqq7FIKLoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cinPgiiFPVR0CrAVUkdw55t/uS0nU7sQ9zawCWjf1/O5JOTCyLvRxP601tnKu1bfWpioGKa01g8aUe4wX3iTQOawwEFzZ5SQVeRSGsH4YU2BQNJipEluP06qow+3MLCfqoGhzlXG5b+9Kyw03g3e9UG72Yc0zhO7yajMPmuq+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMysdLQB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so1675809f8f.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 02:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152752; x=1771757552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JsuwT0fFKTk/5Y4e+BUZmVtnwD4XLKYci9RQL+AL/4=;
        b=UMysdLQBV3hq0ZuCWODtS/RlmmS6+GheKlgncHHFIpJNitz/UlQKT/bEp++g33JR0q
         t9kg4Zd8pqSllGgchPrObwhDl2sxPA/oHGbJmIZNNwyBv32QlnQHW3HApOxYsiQaNiAA
         wOAt90UDhRSBejHE1XlSvO/6eZT/QSxHz7yALMx1yBZ/BlrS29j5hZM1TybBXw/J8NEU
         +F9lF6Qjy74oIUBSgHsfh86yZ6qTUzxEq6DV2hIkDpqrBPHTmPu6aou37fkIyRZX+WZu
         OjwqrW8WA/oZB+wQiAdVRCrMDHezIa+9hihShgjPmbRH42h/991G55M8dNtLAHnt+Ycx
         RcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152752; x=1771757552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JsuwT0fFKTk/5Y4e+BUZmVtnwD4XLKYci9RQL+AL/4=;
        b=uvivjqzccPfX8DIMfEFBjrgVZEk+//4sYDFd0fscQ1RlH78zJ6vFNyZn4Xg3xW2QgS
         yeKh6Ofab/qusbMWngEIhmCwdkqdT/IT20nJ1F1d0/M48dH/MGNCmHvDBo2hDb7XRNdt
         OqyMOGEX1a6ns7GmtBCBB3LVHiJQuvR1kvGhgl5hiD+2/6ShT8ouM7qso10EDZ/2RaHT
         EM7KhQzRpODfAgHq382f9fYehcdneTWIRqclUzxFm3LxXlfMMuEG08m/2DczLfIMoQ4r
         iaqAx0X87V5gKBWcCEKG/Au4PbDLg//iDOXSeWXbiaHkbLyU5/MLsNxalpFNbjNGazG4
         YlHg==
X-Forwarded-Encrypted: i=1; AJvYcCWGIOXzHQKBmpHUH9QM4ydsMr/tqaVx66li5CXlEEqdd3LAVQpL/rrNjyt1P34D7oVe7Ao1IrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZpB4xGyuseBOAoGPEn4C8lBvaBDKcF05PAgVeiTrpfQSJhO4
	Nwu+aud7URA7Vv4rDpti/mgps2s0Clr4CAzPWHQnJRg1HLLepZrMTCuq
X-Gm-Gg: AZuq6aLapFIK6F8dCzLsEGJ7ki1jd09EbUB3pKD5+UkGWt9BnzsaXMynQ2BJjaKqupQ
	fHnO3a0uybSkqAnea0CNE4imCVRo8Y5+3fer496smKSBxDNgLf0Img5Z5NAUfXfU0ujHx6yxx4n
	cUMIQ1XFeOTV93eCp1HpYCUaCNrHVac4w2gASY5QspNurNgWAxSxbocV9XIowtDXmLMn0PRX6t5
	/8r6RdPDrO3L1vw2o4CS7FGsu3cXPv6g6u+IiN+m8zv/G2avgrKZvAg2fM3VH3o85dzZr/STvBg
	zhKQVCnMP/V3T0CnAkMtphnla5C89egz3+VG/NWqLAZESbHLVbm7YlAH6Z10m9IPp6kYrmKfllt
	tQUPPjkiKWMtcK78k/ocNdwpy2ys64o2NIQIRHXSBJP87SGeLYdAs7pO9xiN0qwQJdGXw3gg4j9
	nlWu7ZV0g0b6LU/j7UWGqaJF6QA73t71n8L8UNMJa0NKlAVa2y
X-Received: by 2002:a05:6000:1447:b0:435:8fd6:5949 with SMTP id ffacd0b85a97d-43797919068mr15171721f8f.46.1771152752220;
        Sun, 15 Feb 2026 02:52:32 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm20044307f8f.0.2026.02.15.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:31 -0800 (PST)
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
Subject: [PATCH v5 1/9] lsm: Add LSM hook security_unix_find
Date: Sun, 15 Feb 2026 11:51:49 +0100
Message-ID: <20260215105158.28132-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258769-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5FE6713E84A
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
 net/unix/af_unix.c            |  8 ++++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 44 insertions(+)

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
index d0511225799b..369812b79dd8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1230,6 +1230,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!sk)
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
 	err = -EPROTOTYPE;
 	if (sk->sk_type == type)
 		touch_atime(&path);
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
2.52.0


