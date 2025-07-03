Return-Path: <netdev+bounces-203941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF9AF834F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6770583827
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D7A2BEC3A;
	Thu,  3 Jul 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bGYhb8mr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A042BEC21
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581432; cv=none; b=q+fIRzsdvDkr+uZc3cTvstF+auC1eL9s115BCpci9EH39Mb7Ah4SiMX2xDFM48C3RBw29nN68HSKmv+QDR7NCGsAWVrORJK7OkWLqWSZYqbQW/p9JWnpe+yzmIypDpOLec7ZGiD8LN79GT4UyqGwczu9/ByKuXHjrbAUxxNngHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581432; c=relaxed/simple;
	bh=Gn7W5P0APLN41EFikXwUV5T0T3M9B52pVgzplH3HA2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYc2ITtlMCkm8c9uZ9pOxDWi/kx79do5p4Dsalh6EWDZ959D3K5aD0Uv6mtWqv5pJOdvlGIvsd+kgIQeDeO2avwKmGHHeRWWJBJBdjTs7G1MmGlCGHd4jXcBi0lxTZrUJ5n287l5cvuNZuu/0n7rFga+AgUb+YTVtyo9tYcWroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bGYhb8mr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5776F3F920
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581427;
	bh=RPCya3yNT0z68V2C/y3Kyp31HeP4GdNlj4LTMqhXVPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=bGYhb8mrW1Sg00YZPVp8k3nu/Js0zpIJcMDUmxk/f348HutISeMyREPDWE5PB+56s
	 4fBzNyHa/M/ewwb4mOOqNiclLv2VRwBFrge8a/C+vBdtb7u20+GrfImab0fjQg/b8w
	 CvELnOb+3d3HWCQlOQKoStI+wYZvZIMRWzLdrGgdmI/JCVe+9jHIJWSPOafrM1xN4p
	 umnzKdoBiMtJ6BoRXH2beSjLUUTXpIuQogZUeTNpgnW99IfnYRipbMSdZ80C0ewgTl
	 fwPVSH9XltwwPpt3fUfa5U0mP90vMBQVmzKOogCDcfBGi8CQKXkgp1DQCN9BTOv1Ba
	 uErYDmUSdnFSw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-60835716983so297360a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581426; x=1752186226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPCya3yNT0z68V2C/y3Kyp31HeP4GdNlj4LTMqhXVPM=;
        b=Wec5I8nBYcYd1skkq6WBJahUChBUi/0wnbzGJta+mKTugNrhcAD8Au57IjBvv9AD98
         8U2GazmCyRg9r/leZuyMaHUs6vp2UlUjycoopnRPNxhfpgiUvZaoMt9v5GBdGcviy40D
         vWL67XDk546jp3VbCyAQVWWOT8GsDveJiStNNwZZKOdXOuGVK7mT3ifCnXS0aiNdxsfV
         HDixxrvA4bd7rZl05dkD5xZxPbwFN/C3hMP4V/qH7cvb2pzG6EE4rMRX/DpfIn89c1iV
         3m6P2WLkJvamUR5mYwfOIhtxcFDgQzoFVH2bZkVItV9H7x06cS8snMnvJX0bMjgYwmTI
         NJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz6YMbL3u85Apjgm30payMQ+qMi8u2mFGrAOvTA7xFTSRyEHyHvm8HFRtkq0Vjjnezgw/QdX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNUKRj0fbC36k6B+LpUeV0PcdiKVzmWoFInMDsKuBMo8Al6sp
	dUn+hgUEOjMuFX8WQ8/E67selaDgBWPhdxstxkcFhDv6sqBXp5SS6NRRJ9YRZQSnf52TG9M2CeS
	eDvI6r+uW3Hm5njs9yASagxoYjpFPrhiNygSKIBq9PZu+KE0xqqEz2dt9LDqehrvNmLMM6juNcQ
	==
X-Gm-Gg: ASbGnct8jj9njVldi8Z+xt3dZkIfflEhNFK3wUkHOU3qx0gVs1DW3Tq+JB2VDJarVOW
	W9ZRYxOGZK64aGM1etvnmLy0kkxZ8QJG9ERh8G9DqUC5jANXeWEkm2q+tvnzdUYcFp+29fk+4ue
	xFI1YuJF9P1HQllztRweJEBUSflq3KupSnb6Iacx1K0LxZOBzTebgoILOPA0Xf78/Zu9sGljSv0
	mAZUBmJ3Ax2HpWUYZM1rFJ1ciWketvCavItRFtC7upsIcuegCikmf6YwbEoKpXw/3SG0msl90qp
	ocr+VQyhWCz3zgl1uwI0ml972TtXPN9ITQ12k4VIhPt6fNVZdg==
X-Received: by 2002:a05:6402:4606:b0:60c:461e:7199 with SMTP id 4fb4d7f45d1cf-60fd2fb475bmr206997a12.9.1751581426542;
        Thu, 03 Jul 2025 15:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhYrS4/6WMb2G+ZUHQLTdnePYa7hC/QbuhLVyf8RVZHrcRhQsytyx8CWJVQ2cOge1XHrBWFg==
X-Received: by 2002:a05:6402:4606:b0:60c:461e:7199 with SMTP id 4fb4d7f45d1cf-60fd2fb475bmr206975a12.9.1751581426110;
        Thu, 03 Jul 2025 15:23:46 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:45 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/7] af_unix: stash pidfs dentry when needed
Date: Fri,  4 Jul 2025 00:23:09 +0200
Message-ID: <20250703222314.309967-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
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
- [scm_send()] force_creds is true. Netlink case, we don't need to touch it.

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
v3:
	- don't stash pidfs dentry for netlink case
	- splited whitespace changes
	- removed unix_set_pid_to_skb() to simplify changes
---
 net/core/scm.c     |  7 +++++++
 net/unix/af_unix.c | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 045ab5bdac7d..358a4e04d46c 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/pid_namespace.h>
 #include <linux/pid.h>
+#include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
@@ -147,9 +148,15 @@ EXPORT_SYMBOL(__scm_destroy);
 
 static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
 {
+	int err;
+
 	/* drop all previous references */
 	scm_destroy_cred(scm);
 
+	err = pidfs_register_pid(pid);
+	if (unlikely(err))
+		return err;
+
 	scm->pid = pid;
 	scm->creds.pid = pid_vnr(pid);
 	return 0;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 323e4fc85d4b..d52811321fce 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1971,6 +1971,7 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
  *
+ * Context: May sleep.
  * Return: On success zero, on error a negative error code is returned.
  */
 static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
@@ -1980,7 +1981,15 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 		return 0;
 
 	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
-		UNIXCB(skb).pid = get_pid(task_tgid(current));
+		struct pid *pid;
+		int err;
+
+		pid = task_tgid(current);
+		err = pidfs_register_pid(pid);
+		if (unlikely(err))
+			return err;
+
+		UNIXCB(skb).pid = get_pid(pid);
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 
-- 
2.43.0


