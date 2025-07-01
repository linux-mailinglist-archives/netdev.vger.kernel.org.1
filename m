Return-Path: <netdev+bounces-202811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FFAEF17C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23E7189A761
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB226C39F;
	Tue,  1 Jul 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GS7uUsPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1F26E14C
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359289; cv=none; b=kiBeHtTOLJqkFM6OdBfCfBiuHWK7N8Iupe98bhUDXUW3QYCJE5NVxxBF4MriS+I7amhA9fluUIwSIvCJ1NmrbMYI3S0F3BWk3VL3o0j6qcZf8/MYJwejyUYKbk9ocGcLImiGNq/gI8CxyTpQ6AJ4dMpXmRxIBizJL5359NBgIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359289; c=relaxed/simple;
	bh=0akAzRxqSABVbwmPSbSZyQpcu7BC6CCroLhbO1qikaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpEhPNC0UZfv4mEPGFMYV1GdA5l3wX0hbMtFe2elSD79IbMWYE4tJe/4swD8sz1eEHvZycBvsRjGU5vleBOKy9fLdqhODaoBZWAPtqH1xk2Oo+O1rdsLcyarTDs6Myy7/uizV9UnIHBmyNgC3qE629+DnFoJr/dPmkkxeOKUFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GS7uUsPO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A5843F6FD
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359281;
	bh=6bRqWysSzHy3p2i0Lb/Op5tY8kYpY7PeuWK0tpwD9t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=GS7uUsPOGk1+z/FACwn329V7iEB6S2tI+A8I1jDVV6T7UeomCG0QcwHOk8Tb+qRBA
	 CqKsPWSziSqCVm4IMuroj6S74c2s522g5A6ygCVk6k0uqO2chz8z5AbWZ1jO2OSg1P
	 zx9TXlP17wk9x9Ba5GuxtKwHvbbhiIZpPqQPKe4nnHBUYHQz70yIXX/n49thm/I2Ft
	 mY7uFTdS3UsnxHu07toulak8HIPV1/W22ds+GKxuy2e7ahJn7J8eAUKK+IeU5GZdqF
	 yRYUZON2/eI4wnWQjNG1vrxGnX/4XA2nvW0zd6v0ZTQ0JCZi3RX664z1DdYhDBhTmq
	 JpdCrZCd8tK+g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade6db50b98so267288566b.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359279; x=1751964079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bRqWysSzHy3p2i0Lb/Op5tY8kYpY7PeuWK0tpwD9t4=;
        b=fZJOMUf0EKtABKVdweSLGeJGKgahVRo/9ylUv/B4CN9ToHDLWtNepVt/MyywSLJ7/r
         Hhf7minYtOips1aiFEdcbyBScqAMyNzPkW21GdsFENPLYMo3TvD13x1J0lksI4SJ2t++
         yqpGGyMB5S/tFcinCmErnyZUsubJqM3rM0yvYx4MEf0FOlwDwMu3SdiYxyT23mTUvCep
         xBmffgzSSgkiN5+Rhd2DcSdiG0YRTIijrSf3Q5roCNBg37g2kc/PG3Ol65zpaBafpJLN
         Z/gnElOYVkE2J8Kn1lGFA+5C/qFd+X0DAYPJPO1fx1+wDCWm8SYGNVyhEs2llf24mE3h
         8Dlg==
X-Forwarded-Encrypted: i=1; AJvYcCXvjFwaJMoZL7IVcM5hLO2Evfyvn4bviByo7uR0Xz1WpDnalhbSNte66qIAbyUoPepyIFPiJCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OgSI7Gl9PIEi9ZTMJml4rlil8F+etv2qLJ3nrj7TUeFRZC28
	aDFUvO2K3R2pfJAMW0EZIbuWuGBCHv3+eg2JGiggB61KCoouqBN84SMwuwE5IHre+Bs7NzDMkUj
	YESDGCFXiZi474Fp3ytiZx5V6AEGQd/bH9PFCi/v0wC5WQnk3mAB2NwPuqS8PwEtbjGXp9KXtHg
	==
X-Gm-Gg: ASbGncubG9G6lBskPauoYL/NF0V9flbv9DPeq33wY2twhz6/Z1O2g2j8GaeZf82o9Hq
	BwOoUaspEBF0/n2Ur+HKI23iia3HYJ/ADpFrPFL5PhJCyCUVQTWaPT8gWk3gfgCi23ov24ZB2OO
	cwOL3l5T8O5cqhxtH+FV+xOB/jHLcNUURfp/NE8Tm4B7abp+33V8EUhchdUErnsSjFypoCKwPz7
	qSwf/qWWAk0T4h+mbt6E6rb5Tu1F31yacNcBd84cMwFEHv9M+9x1O71ZucePXGKQ+4/r5NKr5t2
	EvKdfwjuPRwOfc+R1hp/6xZNnu8lSo/F5taD/QaBhxR6pUPF+w==
X-Received: by 2002:a17:906:d7d8:b0:ae0:ce59:5952 with SMTP id a640c23a62f3a-ae35022a01fmr1393446366b.60.1751359278854;
        Tue, 01 Jul 2025 01:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVSKnOX/bJZRqAewogJx3Ti3Do04ydXpz2fF9gVxLvqDFndxPHqMizto+aqZ+cPRud7HQo1w==
X-Received: by 2002:a17:906:d7d8:b0:ae0:ce59:5952 with SMTP id a640c23a62f3a-ae35022a01fmr1393443866b.60.1751359278381;
        Tue, 01 Jul 2025 01:41:18 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:41:17 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
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
	David Rheinsberg <david@readahead.eu>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 4/6] af_unix: stash pidfs dentry when needed
Date: Tue,  1 Jul 2025 10:39:17 +0200
Message-ID: <20250701083922.97928-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
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
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- renamed __skb_set_pid() -> unix_set_pid_to_skb() [ as Kuniyuki suggested ]
	- get rid of extra helper (__scm_set_cred()) I've introduced before [ as Kuniyuki suggested ]
	- s/__inline__/inline/ for functions I touched [ as Kuniyuki suggested ]
	- get rid of chunk in unix_destruct_scm() with NULLifying UNIXCB(skb).pid [ as Kuniyuki suggested ]
	- added proper error handling in scm_send() for scm_set_cred() return value [ found by me during rework ]
---
 include/net/scm.h  | 32 ++++++++++++++++++++++++--------
 net/core/scm.c     |  6 ++++++
 net/unix/af_unix.c | 33 +++++++++++++++++++++++++++++----
 3 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 84c4707e78a5..597a40779269 100644
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
@@ -66,19 +67,28 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
 { }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-static __inline__ void scm_set_cred(struct scm_cookie *scm,
-				    struct pid *pid, kuid_t uid, kgid_t gid)
+static inline int scm_set_cred(struct scm_cookie *scm,
+			       struct pid *pid, bool pidfs_register,
+			       kuid_t uid, kgid_t gid)
 {
-	scm->pid  = get_pid(pid);
+	if (pidfs_register) {
+		int err = pidfs_register_pid(pid);
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
 }
 
 static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 {
 	put_pid(scm->pid);
-	scm->pid  = NULL;
+	scm->pid = NULL;
 }
 
 static __inline__ void scm_destroy(struct scm_cookie *scm)
@@ -88,14 +98,20 @@ static __inline__ void scm_destroy(struct scm_cookie *scm)
 		__scm_destroy(scm);
 }
 
-static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
-			       struct scm_cookie *scm, bool forcecreds)
+static inline int scm_send(struct socket *sock, struct msghdr *msg,
+			   struct scm_cookie *scm, bool forcecreds)
 {
 	memset(scm, 0, sizeof(*scm));
 	scm->creds.uid = INVALID_UID;
 	scm->creds.gid = INVALID_GID;
-	if (forcecreds)
-		scm_set_cred(scm, task_tgid(current), current_uid(), current_gid());
+
+	if (forcecreds) {
+		int err = scm_set_cred(scm, task_tgid(current), true,
+				       current_uid(), current_gid());
+		if (err)
+			return err;
+	}
+
 	unix_get_peersec_dgram(sock, scm);
 	if (msg->msg_controllen <= 0)
 		return 0;
diff --git a/net/core/scm.c b/net/core/scm.c
index 68441c024dd8..50dfec6f8a2b 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -147,9 +147,15 @@ EXPORT_SYMBOL(__scm_destroy);
 
 static inline int __scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
 {
+	int err;
+
 	/* drop all previous references */
 	scm_destroy_cred(scm);
 
+	err = pidfs_register_pid(pid);
+	if (err)
+		return err;
+
 	scm->pid = pid;
 	scm->creds.pid = pid_vnr(pid);
 	return 0;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index df2174d9904d..18c677683ddc 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1924,12 +1924,27 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
 }
 
+static int unix_set_pid_to_skb(struct sk_buff *skb, struct pid *pid, bool pidfs_register)
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
+	scm.pid = UNIXCB(skb).pid;
+
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
 
@@ -1943,7 +1958,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 {
 	int err = 0;
 
-	UNIXCB(skb).pid = get_pid(scm->pid);
+	err = unix_set_pid_to_skb(skb, scm->pid, false);
+	if (unlikely(err))
+		return err;
+
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
@@ -1957,7 +1975,8 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 
 static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
 {
-	scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	/* scm_set_cred() can't fail when pidfs_register == false */
+	scm_set_cred(scm, UNIXCB(skb).pid, false, UNIXCB(skb).uid, UNIXCB(skb).gid);
 	unix_set_secdata(scm, skb);
 }
 
@@ -1971,6 +1990,7 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
  *
+ * Context: May sleep.
  * Return: On success zero, on error a negative error code is returned.
  */
 static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
@@ -1980,7 +2000,12 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 		return 0;
 
 	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
-		UNIXCB(skb).pid = get_pid(task_tgid(current));
+		int err;
+
+		err = unix_set_pid_to_skb(skb, task_tgid(current), true);
+		if (unlikely(err))
+			return err;
+
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 
-- 
2.43.0


