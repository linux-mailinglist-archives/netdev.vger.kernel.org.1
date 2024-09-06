Return-Path: <netdev+bounces-126063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B6396FD55
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D2F1C23E79
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286B15A4B7;
	Fri,  6 Sep 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci1w1QEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8010A18;
	Fri,  6 Sep 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658218; cv=none; b=WuCnl0kCXICSHSX16QU/Juk/eOSSWZF2g80yG08QmybwFin645pQ7bFkN2V68RnGAv6RX/AdE0J3TOMAK9MqZQqyCHEq8NOPuPnIll8XIAyV4h60D5KRWqya5htQ3dq/XciwBmq+A4G1KeMrlVLLwkQlcS9kWvDJJSDTIVVa8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658218; c=relaxed/simple;
	bh=K+Qxz45A+ZqPOXWVuq415afaze3pbu1zD+OP3kZ887g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5nBkR9BbTKOoLVch3nQlcjgtKSK4KbIIOHAxsVOz52hfDwkj/99P6VmwQYVzWOOONM8Yv8GFmCFz80I33PdityHk9f5cm1JfsALphn9789BrKsnfjSElLy6WP8YfbUukXKeB2xH89lhLMiNF+TuTKhWPLMnisHcPt9Rug+uy2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci1w1QEh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2055a3f80a4so19649765ad.2;
        Fri, 06 Sep 2024 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658217; x=1726263017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNTSuYvcE2rzLSfQuS2YWafJRc01WE85sQS6n5qwC5Q=;
        b=ci1w1QEhrFkcfudMJCePHzmkLRu4xiqEw7q6/zZZTuJberSCEjE/SqHLnlOk0WDA+t
         M2DiDKulF4DWBEfGTFBPUL21Q9l9QPMP00jpOF4bmqufLKfxQJjTTF2amDfHzlX6vEoV
         PpYkttcnvaLQjs+jS2210qpD0NN+zd1cRh3UZqwFm7qYq7VgMHQsM8EM4bZYHJjNTCiT
         BRVnqo4QGZJMDYe6NwjAew2vG2WwH/RaHpzTjOYQvlSHTRNPF43gGRcdVjMqA8Y2TKwM
         aq9xKOTjwOUt+O1UWoBmMCdrPq3IZI7uBbkXdIFu5z672WiSRxFOwLodcp+yeS0Dk32e
         CbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658217; x=1726263017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNTSuYvcE2rzLSfQuS2YWafJRc01WE85sQS6n5qwC5Q=;
        b=j44rEUtjvozgyzT1cbsrEslLWLvBjp2KnpIrGnvqTtaX2RP//0bK+z89D9/QlGEUFx
         4nS5Qaspy4cfSpFAkoHcutoMpK8eyQCwLuak3vkBK0WZA5XAqj/w1T4Ktq/AxzhoESPy
         2kxqat982xnRdPsE8JBRUqaTK8c3yS9lj+arpBC9HJD57zKjD9IjWEFIykd8qzg2eqIm
         jjIlLQKEU1thMk/HpJVI3Sw9rHJwshBV4Pwj3CCigt8/F8cbNFoqbwkCdIEFq6d3r4Tw
         QTnB16uIbjCTWiprh0k7fYbEZLutXsoOjtWIQhY9BAtlFUCZQywgUSAnWeSgdNuT+EAb
         Oq+A==
X-Forwarded-Encrypted: i=1; AJvYcCUsEXGm3A4yW8zUgqOQC2GmeS8tTou5eQgsb3imEpjGwWaCy+A46gKb1UbRnlwxWiRmy+pz2CB+iyJjDkI2WlIdqMbCwIZS@vger.kernel.org, AJvYcCWNqWy/vBn7b4VNwBcXwU2+vI2H4Ees+DnJvdJKq55zDiLUqlEArvPolhpqjB4mIdznQocIPK1QvkwLDZo=@vger.kernel.org, AJvYcCWgQejHSA86EpfX7quJ4C50PglfuH0TmSaZ2Dc3fk4XMDEiWFoTjii6Aw25zGzoRMtn2YPYycHj@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVrNDX0r3YN1wi8MBF4UMJ0QS5xSWt6tetJ+6nS3/4eE24YhT
	G7IQ2bY1Sw9TjJSBo1NSZ0vOcUGz5HEI8pVenMkaMdYuIkMW0WKxfxsF4OWW
X-Google-Smtp-Source: AGHT+IGLGFe3bBoUDYICYLnIDNAzUNx2k3gkrHKaRnE81r7MI60+PtIa2Khcq4/6/hovHQFWRcjSMQ==
X-Received: by 2002:a17:902:db0e:b0:202:301f:36fd with SMTP id d9443c01a7336-206f051a7bamr45948335ad.18.1725658216656;
        Fri, 06 Sep 2024 14:30:16 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bd1sm47081065ad.247.2024.09.06.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:30:16 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v4 1/6] landlock: Add signal scoping control
Date: Fri,  6 Sep 2024 15:30:03 -0600
Message-Id: <df2b4f880a2ed3042992689a793ea0951f6798a5.1725657727.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725657727.git.fahimitahera@gmail.com>
References: <cover.1725657727.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a sandbox process is not restricted to sending a signal (e.g.
SIGKILL) to a process outside the sandbox environment. The ability to
send a signal for a sandboxed process should be scoped the same way
abstract UNIX sockets are scoped. Therefore, we extend the "scoped"
field in a ruleset with "LANDLOCK_SCOPED_SIGNAL" to specify that a
ruleset will deny sending any signal from within a sandbox process to
its parent(i.e. any parent sandbox or non-sandboxed procsses).

This patch adds two new hooks, "hook_file_set_fowner" and
"hook_file_free_security", to set and release a pointer to the file
owner's domain. This pointer, "fown_domain" in "landlock_file_security"
will be used in "file_send_sigiotask" to check if the process can send a
signal. Also, it updates the function "ruleset_with_unknown_scope", to
support the scope mask of signal "LANDLOCK_SCOPED_SIGNAL".

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Changes in versions:
V4:
* Merging file_send_sigiotask and task_kill patches into one.
* Commit improvement.
* Applying feedback of V3 on managing fown_domain pointer.
V3:
* Moving file_send_sigiotask to another patch.
* Minor code refactoring.
V2:
* Remove signal_is_scoped function
* Applying reviews of V1
V1:
* Introducing LANDLOCK_SCOPE_SIGNAL
* Adding two hooks, hook_task_kill and hook_file_send_sigiotask for
  signal scoping.
---
 include/uapi/linux/landlock.h                 |  3 +
 security/landlock/fs.c                        | 17 ++++++
 security/landlock/fs.h                        |  6 ++
 security/landlock/limits.h                    |  2 +-
 security/landlock/task.c                      | 59 +++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |  2 +-
 6 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index dfd48d722834..197da0c5c264 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -297,9 +297,12 @@ struct landlock_net_port_attr {
  *   from connecting to an abstract unix socket created by a process
  *   outside the related Landlock domain (e.g. a parent domain or a
  *   non-sandboxed process).
+ * - %LANDLOCK_SCOPED_SIGNAL: Restrict a sandboxed process from sending
+ *   a signal to another process outside sandbox domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+#define LANDLOCK_SCOPED_SIGNAL		                (1ULL << 1)
 /* clang-format on*/
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7877a64cc6b8..b1207f0a8cd4 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1636,6 +1636,20 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 	return -EACCES;
 }
 
+static void hook_file_set_fowner(struct file *file)
+{
+	write_lock_irq(&file->f_owner.lock);
+	landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
+	landlock_file(file)->fown_domain = landlock_get_current_domain();
+	landlock_get_ruleset(landlock_file(file)->fown_domain);
+	write_unlock_irq(&file->f_owner.lock);
+}
+
+static void hook_file_free_security(struct file *file)
+{
+	landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
 
@@ -1660,6 +1674,9 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
 	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
 	LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
+
+	LSM_HOOK_INIT(file_set_fowner, hook_file_set_fowner),
+	LSM_HOOK_INIT(file_free_security, hook_file_free_security),
 };
 
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 488e4813680a..9a97f9285b90 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -52,6 +52,12 @@ struct landlock_file_security {
 	 * needed to authorize later operations on the open file.
 	 */
 	access_mask_t allowed_access;
+	/**
+	 * @fown_domain: A pointer to a &landlock_ruleset of the process owns
+	 * the file. This ruleset is protected by fowner_struct.lock same as
+	 * pid, uid, euid fields in fown_struct.
+	 */
+	struct landlock_ruleset *fown_domain;
 };
 
 /**
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index eb01d0fb2165..fa28f9236407 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -26,7 +26,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_SIGNAL
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 /* clang-format on */
diff --git a/security/landlock/task.c b/security/landlock/task.c
index b9390445d242..a72a61e7e6c3 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -18,6 +18,7 @@
 
 #include "common.h"
 #include "cred.h"
+#include "fs.h"
 #include "ruleset.h"
 #include "setup.h"
 #include "task.h"
@@ -242,11 +243,69 @@ static int hook_unix_may_send(struct socket *const sock,
 	return 0;
 }
 
+static int hook_task_kill(struct task_struct *const p,
+			  struct kernel_siginfo *const info, const int sig,
+			  const struct cred *const cred)
+{
+	bool is_scoped;
+	const struct landlock_ruleset *target_dom, *dom;
+
+	dom = landlock_get_current_domain();
+	rcu_read_lock();
+	target_dom = landlock_get_task_domain(p);
+	if (cred)
+		/* dealing with USB IO */
+		is_scoped = domain_is_scoped(landlock_cred(cred)->domain,
+					     target_dom,
+					     LANDLOCK_SCOPED_SIGNAL);
+	else
+		is_scoped = (!dom) ? false :
+				     domain_is_scoped(dom, target_dom,
+						      LANDLOCK_SCOPED_SIGNAL);
+	rcu_read_unlock();
+	if (is_scoped)
+		return -EPERM;
+
+	return 0;
+}
+
+static int hook_file_send_sigiotask(struct task_struct *tsk,
+				    struct fown_struct *fown, int signum)
+{
+	struct file *file;
+	bool is_scoped;
+	struct landlock_ruleset *dom;
+
+	/* struct fown_struct is never outside the context of a struct file */
+	file = container_of(fown, struct file, f_owner);
+
+	read_lock_irq(&file->f_owner.lock);
+	dom = landlock_file(file)->fown_domain;
+	landlock_get_ruleset(dom);
+	read_unlock_irq(&file->f_owner.lock);
+	if (!dom)
+		goto out_unlock;
+
+	rcu_read_lock();
+	is_scoped = domain_is_scoped(dom, landlock_get_task_domain(tsk),
+				     LANDLOCK_SCOPED_SIGNAL);
+	rcu_read_unlock();
+	if (is_scoped) {
+		landlock_put_ruleset(dom);
+		return -EPERM;
+	}
+out_unlock:
+	landlock_put_ruleset(dom);
+	return 0;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
 	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
+	LSM_HOOK_INIT(task_kill, hook_task_kill),
+	LSM_HOOK_INIT(file_send_sigiotask, hook_file_send_sigiotask),
 };
 
 __init void landlock_add_task_hooks(void)
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index 36d7266de9dc..237f98369b25 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-#define ACCESS_LAST LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define ACCESS_LAST LANDLOCK_SCOPED_SIGNAL
 
 TEST(ruleset_with_unknown_scope)
 {
-- 
2.34.1


