Return-Path: <netdev+bounces-268813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC8BGeHiuWmnPAIAu9opvQ
	(envelope-from <netdev+bounces-268813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:25:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22732B44FF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CA21300E25C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEF37C0FA;
	Tue, 17 Mar 2026 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMN4JKsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4E304BBC
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789718; cv=none; b=Y1JpeZTOykmmEZx5IIsF94BNBho+M9V6/Ae3XFSGi6PAjX384glDmPVZ7z3JG723kAzq3wtmqGYpqfOaLPbKtRhecpWxjRePiiJVLqnQ4UiWPT/jL9oUgbffkwcgSjPtfzBSrTabSDGhM2P7TEUTXX9R48plNXfNl5Nenu9FwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789718; c=relaxed/simple;
	bh=k50GxoGrT4BdyEqu5eg03Q31kNPQWysG+LFpp/8nOWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMCbMWlfhLzgBrvy8o1tvJsic41/lsh7dYJ4MD87T8t0fC0WpxbzIi2OAgIUrDN5CTv+jdU47ZQyt7ZIAaZvIg5Wv8LGHPjZFcr2R8pzacAAsp5vTEHFzsr997np+0s2mCj8ETsJIEKkmBUxtw8CHTaVawtWosOg3gZqnfbOwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMN4JKsc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a46ebe2beso28138667b3.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789715; x=1774394515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzfNc65EHvjg4p3nKOAoKsba9Kbou8Ay9sLIMwWOL/4=;
        b=LMN4JKsc1nNC9EywVSgaWP/tdlyQX6fA0b1WJj2hGpyTLkA8j+fONhni0CLW5W4loS
         CJ65ruEyl4+LzUIleNVpKKnVOeO1mn+9eomvG/0/N72MCxPl12cZNNfNneF7yq3LjRcm
         P52og0faO2pXQW+KqhoSYZ++ZOGsqF6nNB+ybzODjQV8x9eXlxRkv8wmCm184br12sHY
         1rddhgjjMCbAK1AdmEUXgSJpCpFY6+tN2wkcT391R+iwd+PRaCUCInrE6Zzb1xJUF3VR
         +3mLtOkeUgnV+WdNgzmJVVHaK6Ff6RmG4MN+1xlKFCFsku6cVvsVmLRFWS8h9yFo9s8U
         YGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789715; x=1774394515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzfNc65EHvjg4p3nKOAoKsba9Kbou8Ay9sLIMwWOL/4=;
        b=Am2DX4UR0R6LTBB+G/g85ZE97Oo96LMkeCUHlfqh3yqw8STvKnsa7mc61P1rrIQ4DI
         0zXHjgTI2DHT1YVjuK/2PDUQ9jXsDhALsbKDxWwfnwyXd7MCVb2r0rCFN2obNHtKhzuf
         d0y/52LqmNjj1B82h+OFPc8KvUE6EHx7qTkjSsKiN0qzyapIGhPAxKUSxlgpcZTI6aDV
         nH2zBD3Aq9wyA1U5WQvmPJQdZ3v2j0SKkK5zOJsXEqXjjOKYsTvPR7o0ECZQfFwOqw+4
         n36ZISFtq8j7taOSMAuripUH6bETVi2fhBzujD3TYiljoSLokMbdkQKlb0y/Guwrrqox
         2kww==
X-Forwarded-Encrypted: i=1; AJvYcCXwifiyco87AoHX4QALdVg/2JOIrkwyxDM48rwjeSm5/FEuiK5DjvQi99kqLoIyG2bE7EPxglI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCGvBraAkiTrPHbPE26czz7zDsGRoBEwMFafp2S31rveTgg0u
	al2VwlvZD4blUq4TbKRFvlEjFzBHJGuGguKRzTQqzWTukiLtBqAvn3BS
X-Gm-Gg: ATEYQzzcBPfJ8Dq1TJmqdDgdpuu2paLf4/RN6W0JdOcCpsnsiDcJmzjYg3Ip4MYUkvo
	TrkPx5QIobzkrH9eWVXcK2CfyoiktT+tJcEZrvR1VnF3jowvFkC6JTKsbb64qaIq/tSSdc9zxtK
	4e2RmRZOKEjDDb4E07O/ksYpqMPrMrKP35SCvw6CpPMQnu/sp8qBnT1fruhg1ZAafMInETPPn0e
	YlgNZUlG+JRwaRbD2aUDQ9NkEjX425NR2AiLEul88T9vkP8DPIg/CEre2sUg41tu6jzCvyS1llo
	5m46ZLjL3Mng2cet2CsVUx3AB/zbVBpVrQe0V+bRYWIF26uzfh3qbxmCBKn7PBCnB6C/5IJrwA+
	Klzn0D9nfI8i0Yic7DAYwSrN1ZDX4bxShW6nkX8LNYqytI6bgGlkSSeVCzu9ao2EU7onhCnm2BW
	qG+jEvbTFcj63VUuJw4dzf
X-Received: by 2002:a05:690c:c1dc:b0:79a:3e2a:7b5e with SMTP id 00721157ae682-79a71637f2fmr12793897b3.0.1773789715581;
        Tue, 17 Mar 2026 16:21:55 -0700 (PDT)
Received: from zenbox ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a7136e507sm6600907b3.6.2026.03.17.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:21:55 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: paul@paul-moore.com
Cc: bigeasy@linutronix.de,
	brauner@kernel.org,
	demiobenour@gmail.com,
	fahimitahera@gmail.com,
	gnoack3000@gmail.com,
	hi@alyssa.is,
	horms@kernel.org,
	ivanov.mikhail1@huawei-partners.com,
	jannh@google.com,
	jmorris@namei.org,
	john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	kuniyu@google.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	matthieu@buffet.re,
	mic@digikod.net,
	netdev@vger.kernel.org,
	samasth.norway.ananda@oracle.com,
	serge@hallyn.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v7 1/9] lsm: Add LSM hook security_unix_find
Date: Tue, 17 Mar 2026 19:20:41 -0400
Message-ID: <20260317232041.330576-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
References: <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,oracle.com,hallyn.com,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-268813-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,maowtm.org:email]
X-Rspamd-Queue-Id: D22732B44FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Consumers of the hook wishing to reference @other are responsible
for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
therein, ensuring the socket hasn't died since lookup.

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Paul,

I updated the hook placement as per your suggestions. Moving the hook into
the block does require duplicate stubs, but I don't see another way to move the
stub into that block and properly handle the case where CONFIG_SECURITY_PATH is
defined but CONFIG_SECURITY_NETWORK isn't. If the stub is moved into that #else
block it will never be defined in that case.

I removed the self-evident comment as well from security_unix_find and added
the whitespace.

I also updated the comments and commit message with respect to locking.

 include/linux/lsm_hook_defs.h |  6 ++++++
 include/linux/security.h      | 13 +++++++++++++
 net/unix/af_unix.c            | 10 +++++++---
 security/security.c           | 19 +++++++++++++++++++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..0017a540c2fb 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -321,6 +321,12 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
 LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
+
+#ifdef CONFIG_SECURITY_PATH
+LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
+	 int flags)
+#endif /* CONFIG_SECURITY_PATH */
+
 LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
 LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
 	 int protocol, int kern)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..3f8c23ad1199 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1641,6 +1641,14 @@ static inline int security_watch_key(struct key *key)
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
 int security_unix_may_send(struct socket *sock,  struct socket *other);
+#ifdef CONFIG_SECURITY_PATH
+int security_unix_find(const struct path *path, struct sock *other, int flags);
+#else /* CONFIG_SECURITY_PATH */
+static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_PATH */
 int security_socket_create(int family, int type, int protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
@@ -1712,6 +1720,11 @@ static inline int security_unix_may_send(struct socket *sock,
 	return 0;
 }
 
+static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return 0;
+}
+
 static inline int security_socket_create(int family, int type,
 					 int protocol, int kern)
 {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63a..5ef3c2e31757 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1231,11 +1231,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -EPROTOTYPE;
-	if (sk->sk_type == type)
-		touch_atime(&path);
-	else
+	if (sk->sk_type != type)
 		goto sock_put;
 
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
+	touch_atime(&path);
+
 	path_put(&path);
 
 	return sk;
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..f8df5e1b55e6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4073,6 +4073,25 @@ int security_unix_may_send(struct socket *sock,  struct socket *other)
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
+#ifdef CONFIG_SECURITY_PATH
+/**
+ * security_unix_find() - Check if a named AF_UNIX socket can connect
+ * @path: path of the socket being connected to
+ * @other: peer sock
+ * @flags: flags associated with the socket
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket. The caller does not hold any locks on @other.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return call_int_hook(unix_find, path, other, flags);
+}
+EXPORT_SYMBOL(security_unix_find);
+#endif	/* CONFIG_SECURITY_PATH */
+
 /**
  * security_socket_create() - Check if creating a new socket is allowed
  * @family: protocol family
-- 
2.51.0


