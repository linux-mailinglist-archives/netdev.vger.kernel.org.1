Return-Path: <netdev+bounces-272622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILaDCrS1xmmgNwUAu9opvQ
	(envelope-from <netdev+bounces-272622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:52:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1082347D74
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 965A43099B72
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E635F163;
	Fri, 27 Mar 2026 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq4oOeI3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5735F18C
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630149; cv=none; b=FLjjA7YjAjVTbbzUbL/cyL/Fa4hGW34esNeVhlZg5tDNbCjBpwr1HnLtOJpPq3I2KKWgMy4zCCgnJB7MvtecwdrE1PTO5PEbTle2u3F/iDibJwzGwvHfJQsW9sBTacaAtHvBSrrhbrg54Vm6kwS2CfVXesgRBCS8pg9sLdywPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630149; c=relaxed/simple;
	bh=1R5QoRjpryjEmRKSu+GecPhvfAVUv2rQ3tJZWgcI/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrI8Dv9ZRDuMnNmhI/R0AMSVKUDAHAehVAEMx0WnwBUkMOSn0Sgm0ALTZOqyGGmzIUButYo4st7cGBa1k4rnLUpunX8lr1KQEeYhbrwZclXoPAbS301j0fHXiD5zc1b8K/HCIL3VDHTxUDPz3bALEy8AeQnWnKQhZO36voEK+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq4oOeI3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2188126f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630146; x=1775234946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B00FySKCwug1nr/4nnc+9QuABBXvC6ZmF4Hl8lqc1Mc=;
        b=Hq4oOeI3Cu5ZfFjRKshJU+pTCsD28o6TUlnBfac64pxupRAHxVvfYn/Mw1w5Bth3Cg
         RwbgAZl3MIevtPUqzbTXyZgt9foQoc0VEz3MHZiVwpVhPPHOcrh9oaY0YuezeKBVK24c
         5QmUzIb3NQIQ9mDTSQi759WcBVf68cHrm6M6Mubp7F9L0p8J/X1FjvaPlnKmiymehKD3
         PrUXjzypgW+wDWw6FCkoUrL+iAHdjdPkieD/N3HQQ2YNhzMXy3ihlDUflimNEFEpFOlf
         rO7T44YtzgoGaZE+euXd+fQ+TaaojhDr2BSPufTrg7rSeMZGB5vpY0rXTiSA1GK/7Olh
         Jvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630146; x=1775234946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B00FySKCwug1nr/4nnc+9QuABBXvC6ZmF4Hl8lqc1Mc=;
        b=THi7doNRBs1OL9kwjliV0OVy0LZoiqIxMhqSAO7wX1P6sCugHY+6rRtXPGWgRst6U5
         CvWqLzomXRCppfQyOOY3crVCIwSgcnF+IKqEcsYmbbKpksyXcv2V3YZRmEWPGXmTH473
         vLLuUAOY4Hn3AUhUFVsxEPpdkMUXQqcAaZHyQeuUrCz56kZSayV8zjMVGZwmjCJb32Bq
         xvvLtkgsih6f5l+zcSAHlECa3iZjwnUcKrhFPQmUYI/3rZG1PYz1azWb1mpRE49Agdmr
         XAWHpAh0kY95leTwu15EXSLB3KNGpILadSZuvGUvOveVw5nppup0jD3UoumT5a32gzn5
         vT2A==
X-Forwarded-Encrypted: i=1; AJvYcCWTXQ68v62M/+WSta7IxFpMwQ1xP7dOJb6JgK/yMZQ2CBE4GgnUTMbjcu3ghCgtmMlb/zEqKZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hqJ7U/QwQO/VWinYVmXPmknA9vvrm4b4Yd+mvh9f9bkPuW8B
	P1srf5PFEZvzf00R2YIdPrD9xmIofHbOeZMtiWId4sBkpgRBptoiQ+Ir
X-Gm-Gg: ATEYQzyIHqvBb/X8CPvWZpieXN3kY9+hmcwDqIzUEWcwT4hZ1F5OyNZAlvr4LWgR7ko
	wG2ESFh77JEjQ7wpURLhlLcqyDFbDmi3Usct+sixQewkRUMMDu5/M5MZnalnkhTfdXNCN3vF9yW
	GfITW9ZfN87pO8vLD+VlymQ1MLFx0nkx5MFg82dJWLqrI9nc633Ey7azrBjmamRcnydB+2XNmFW
	5xLwKMx5DOPlUdqtTda1y6n4wRvIf0FnYsVaWbKJ9Us3X9SKdFSR1PNxF1GOkqud73sVpiuRrp6
	Y1+YCCN17wNmW2x6yM+sY0jIVHjszRKhHd17iNkcOzBymCAZFbJBDhx6T/CeTcxfM5A1vLLDbMK
	2Yp8twAcf7czj5IUtPF0gwSDf9lLFOew7Y5qJHo/Iu8GGw5gg2hFS5NxlqjbXlQHtxVPSB9nVA+
	cl+LtaPGh1Qq2tQZntcDUx7iWGOht1PyyK9b0fgKr2Xy+/JfCk
X-Received: by 2002:a05:6000:4287:b0:439:b8b2:fac6 with SMTP id ffacd0b85a97d-43b9e9e8ffamr5655815f8f.22.1774630146088;
        Fri, 27 Mar 2026 09:49:06 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df7e7sm15397364f8f.26.2026.03.27.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:05 -0700 (PDT)
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
	"Georgia Garcia" <georgia.garcia@canonical.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 01/12] lsm: Add LSM hook security_unix_find
Date: Fri, 27 Mar 2026 17:48:26 +0100
Message-ID: <20260327164838.38231-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,canonical.com,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-272622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,paul-moore.com:email]
X-Rspamd-Queue-Id: D1082347D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Suess <utilityemal77@gmail.com>

Add an LSM hook security_unix_find.

This hook is called to check the path of a named UNIX socket before a
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
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/linux/lsm_hook_defs.h |  5 +++++
 include/linux/security.h      | 11 +++++++++++
 net/unix/af_unix.c            | 10 +++++++---
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

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
index 67af9228c4e9..28ccea205874 100644
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
+ * AF_UNIX socket. The caller does not hold any locks on @other.
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


