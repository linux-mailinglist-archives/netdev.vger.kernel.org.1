Return-Path: <netdev+bounces-259583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKMzLhhtl2nxyQIAu9opvQ
	(envelope-from <netdev+bounces-259583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:05:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1B16234C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63F753012273
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625A2305E21;
	Thu, 19 Feb 2026 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuS+4c3G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCD2C0F6D
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531541; cv=none; b=BGioHAlQXIuDpCSppU+zNa4C+vxu3VI+V4T1EFH+ZY1KDHYGa6aDugiKgQwfjp9OeXlMvLCtNPzUSBi/HNvHXQSBCF/KO4+YRu6lmwadg/eroQ0yAsjVdvShapwM0QtpL3sbirVqJ3bFZV1mBf7Wfx2HmyBP7qldk4LOKhPoAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531541; c=relaxed/simple;
	bh=WQyPCMu2/LVxP1HRKmCCZGdKwmRzWEn+99ptBGf9kFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1dJ/gv2J8mwWKHWB4vS7tH736bEqnv2zLr4kZ8YqrubNBISEMQD0qv2QxTDMOdlu/J90d6p78bSnEhmaAY+x47B1or1/rbv4pnlZ7x61QpsZAtj5gF6CO3ue15/Fiwf1iJNB//Ze9KxXZTMzQ0UdeU7e7/oeccTggDTN7BQd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuS+4c3G; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64937edbc9eso1317201d50.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771531539; x=1772136339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i/0wTnFIm7HfE0FOOWnlBqJyTOzDQHrvyvLNh6JIe4=;
        b=CuS+4c3GjbnXeolZKsGMH36GQxpWc/g+jwVRHrSyvmGTbbZqp/tKlLrHsNogwvn2zX
         iX9vbck7mxdF2d5DQ2q1d8kLqSxnA6oHpoEYrmOfjz2S/4ayv1gkSF0BPupNpegdyibz
         VN4CA2/VApttCIsvXeslfnAcpHDjncDjaXWOBdgk3N4C25Dx2J2tSSziqYDdGVN8yHYR
         qpSqpdQi+6OUi2HrpE0FqYq8Zg6SgPRtTfrHMluqJI1bLfBQVIJHrAriV94tRlK5QuZg
         bEGtDQutvVKkxwJNt6loklSjlMSoXYyrQS2hXiL/2j3neADa43uouYXVwWB6Cak1BKvR
         SAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771531539; x=1772136339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9i/0wTnFIm7HfE0FOOWnlBqJyTOzDQHrvyvLNh6JIe4=;
        b=L/qQxrqq9Bj3EHVD5q8TUPBIbgZKgvw1C0Y0J0hOuHxFaFZ68rdOuxcpnOPlkN9+My
         cnJpN6BRxxxsv3KiroM7r85oljK7M7UsnQ5sz1woTezsz2I08WZMN/+7anjvskyn4F5m
         1xCzAoFyMcCS9rhxCGLfBkQP2QqFEBvZlhD6rqZL9i2/EAs+cag1mpXTNrZ7HY0aukMb
         ZHu532xbkeB1mRybBXWAqiO/pokJCANObP/4yK5zRDrEwI4zXrMdk4yqKCSYsMCMcUIv
         le2QGKzfIiiXuOEzd2guu0PL7vHOcSzDHC9yoUU4LGnIGYhQ2ssRKm1dNekd/JTCa3Gl
         JUaA==
X-Forwarded-Encrypted: i=1; AJvYcCXYnhwphUJr1t9lTJdGLkl8oHar+BQRZVElH5g1PPLOd1g+IpOlvGoVPlzs9afEPWyXZS6/hVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4co//jZkbxZ0yS4fjK94PNwjnpfPmJyGfZltA32R1Ph0ihNo8
	MKjzHclIw23QTUqhML+D2q2akAnVWjl8TOH9c8l305RI6rP9+q2yQ2dM
X-Gm-Gg: AZuq6aK6FS5MvCK23bkUQu3me+533AhV3csF3cbR44/xSh4HFaOQNrbd3bKe2ll/mSW
	A0JxDqfNF+kQhGGAycj5y/JP6WRJPSPwDxu29T+l40P7/Tk6yZ2mMonDJ7tT9YOhgwn4A5lVXwu
	xwkzmVfdSgg33wXO8rTdup/izn03jpOj/RBvFM53EcEPeSFwmVG9oNBPvR9DdUyPqLUCLggyXRq
	Q796u8XlCTy+VaVUj0LE8Kh46yi3q70+hhgiRBvbWoViRinl6TQRicHDstZp4GVQrrZM4QsHTI8
	rkIDlZTnppOUhPtPORUfM1XHsYcphAirBP6KjKQqdPOL4I8luxqkjTu7ixmFScXZ95Ir27DTmHI
	gjEMozcw2akeO4hWZtTmenNEblfmiqx7W5IlJjb7PMMdh8dv6DSXwcloqwqWVW1PKJY4qSLyqdu
	yOzHJGJAEZuPIu6ZhtDMWvxhRCpnbQ
X-Received: by 2002:a05:690e:16a0:b0:64a:f3fa:af58 with SMTP id 956f58d0204a3-64c21a43cf9mr15905823d50.17.1771531538628;
        Thu, 19 Feb 2026 12:05:38 -0800 (PST)
Received: from suesslenovo ([129.222.84.220])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e73125sm7292264d50.4.2026.02.19.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:05:38 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: utilityemal77@gmail.com
Cc: brauner@kernel.org,
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
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	matthieu@buffet.re,
	mic@digikod.net,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	samasth.norway.ananda@oracle.com,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v6] lsm: Add LSM hook security_unix_find
Date: Thu, 19 Feb 2026 15:04:59 -0500
Message-ID: <20260219200459.1474232-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aZcPd3OKqxwCZV-5@suesslenovo>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,paul-moore.com,oracle.com,hallyn.com,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-259583-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0EF1B16234C
X-Rspamd-Action: no action

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
index f6d56e70c7a2..41698460194b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1231,10 +1231,17 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -EPROTOTYPE;
-	if (sk->sk_type == type)
-		touch_atime(&path);
-	else
+	if (sk->sk_type != type)
+		goto sock_put;
+
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
 		goto sock_put;
+	touch_atime(&path);
 
 	path_put(&path);
 
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


