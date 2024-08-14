Return-Path: <netdev+bounces-118332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C7951473
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928AB1C22855
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732713D518;
	Wed, 14 Aug 2024 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P10pBHHB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75613B2A8;
	Wed, 14 Aug 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616585; cv=none; b=SKmQ2AiLsGdrdwcR2gujVKc1xwb+nOdlVcLgysil0rpvoD5K1VBdnCfcuatV3oY6QsIvhL6CKMor2yFESI2Fx+IzSM1HmPvgPyunxxa8xFPQsD9jXba1UQggQ/46k1lfgGKggJizlxodPqJCPnl9RXiVvV4H1pvIH3WeU5LKCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616585; c=relaxed/simple;
	bh=kg/8idxdUWZ97chH/ydatb40FE1TQIX2TYlnPM93mr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5WvTOIJcusu6zu9Og7ZtPsBad1q3GQTMFJHsKzIBbJdArLsBxWCH9pg7cJEUxEFMI/dWVUP56juvEEFQPxVvSwVpaOifIn44eKpnAXT2t3ZdyjC7939s8NEKQ+NoKctdNRMrrgcCpMYI9McOEQO9y1nW2sKh6Ad/wfbG3xL1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P10pBHHB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb5e0b020eso4875735a91.2;
        Tue, 13 Aug 2024 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723616583; x=1724221383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSbos34GZP1MBxqk5DevnuLIKX/BhuXlgd9OTZVY/rQ=;
        b=P10pBHHB/09I1rkpdVKSNSFczbS/luJ0cmye/WZW0xdwYWj7RaAB43CbMnU1691oFA
         QtFfMjixGCU37m80cDoVAMDjJlbsT5lT/u1gcYMp1LRtUIJFlI79RrGqWGl4nDOYVOB4
         ntlZm0QlhREz+c1CcnlZjHdUhrU+kR5/FV6eBoJ7Ie6u+QUlEes5uKEb3oeMydl5R1+L
         YRoSlmfQzA+F5ovX4Us75naXWIz51e+SUeF203mqArwu2nFEOlAcNNnu+5HUlYT3AFwW
         7luYMNgSff6AuZdsm2NMQ6fIspCtek+Kf3+dG9m6E+NCBlg5CMVRCkgLlizSDLEiIhZ3
         6Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616583; x=1724221383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSbos34GZP1MBxqk5DevnuLIKX/BhuXlgd9OTZVY/rQ=;
        b=ByILouvPYcdhfR6W38Nf0mRhh3ieEamFiFwHJ03QMzi4Uxut29gx6J2j7m+G+S3kCr
         ymYRThVLV3kSJfuaoix1ZHfDlMibELPW0YPwq7+uMLZiEOiRvWC3LhJcHodfpIgui85U
         O06xDG5Df4uCk4QSRU6e1gnkm+SyEqmcfIiwWlgDz388frrO1K3LELJFw1IxWWET8KGU
         /ahUArRekxCJU2fIdPDuN5Ssr+C5o3iof5/przCKh6SGZBH1LvyN3Qvv3qeDzEIwN5sv
         RBec+Jf6/sXP8x9qbXtb+BGZsX5OsFWlbwWN9Hj8zsrKMyPuq8SiGTsCRCFNIAALmB+k
         XOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYCq5rO8M2zf78hsL06L3YW/e6JhR2GJrn8F/kmlzNxIsneo1eLidnlGq3NlaNZtPmK2jyCssTl6enGjkaWwOJNBwmc0Pcdgvj/n7soHb6r//cSG4tN0C2nIqeSwVRNpSGqYFWlKCy9nxfRfhy+GfySR10c9KdFqHAE71HZyYdVaGfH52+e/RJeZle
X-Gm-Message-State: AOJu0YznLdZ6nQ41pb75DtiOUy3ak+1+qfddvHQMnwPZbRm3axNboeR/
	qsAU4qUDNAl7zAx5h30xyHgUR6Y6lynLfzVfcZVtDC7b5WK+N83S
X-Google-Smtp-Source: AGHT+IF6HPZG22dVWfrD6tAfo2bx5IXCLTB3G2YTykE19Ncv2smJjp42YPHsxmMGgakJZ99PScYcRQ==
X-Received: by 2002:a17:90b:17c2:b0:2ca:5a46:cbc8 with SMTP id 98e67ed59e1d1-2d3aab50abdmr2081710a91.26.1723616582727;
        Tue, 13 Aug 2024 23:23:02 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2120sm728811a91.31.2024.08.13.23.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:23:02 -0700 (PDT)
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
Subject: [PATCH v9 4/5] sample/Landlock: Support abstract unix socket restriction
Date: Wed, 14 Aug 2024 00:22:22 -0600
Message-Id: <60861c67dab1e1e8cf05ec6bfd9e5ac75d09b63a.1723615689.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723615689.git.fahimitahera@gmail.com>
References: <cover.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A sandboxer can receive the character "a" as input from the environment
variable LL_SCOPE to restrict the abstract unix sockets from connecting
to a process outside its scoped domain.

Example
=======
Create an abstract unix socket to listen with socat(1):
socat abstract-listen:mysocket -
Create a sandboxed shell and pass the character "a" to LL_SCOPED:
LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
If the sandboxed process tries to connect to the listening socket
with command "socat - abstract-connect:mysocket", the connection
will fail.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
v9:
- Add a restrict approach on input of LL_SCOPED, so it only allows zero
  or one "a" to be the input.
v8:
- Adding check_ruleset_scope function to parse the scope environment
  variable and update the landlock attribute based on the restriction
  provided by the user.
- Adding Mickaël Salaün reviews on version 7.

v7:
- Adding IPC scoping to the sandbox demo by defining a new "LL_SCOPED"
  environment variable. "LL_SCOPED" gets value "a" to restrict abstract
  unix sockets.
- Change LANDLOCK_ABI_LAST to 6.
---
 samples/landlock/sandboxer.c | 58 +++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e8223c3e781a..bec201eb96f7 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -14,6 +14,7 @@
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <linux/prctl.h>
+#include <linux/socket.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -22,6 +23,7 @@
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <unistd.h>
+#include <stdbool.h>
 
 #ifndef landlock_create_ruleset
 static inline int
@@ -55,6 +57,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
+#define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_DELIMITER ":"
 
 static int parse_path(char *env_path, const char ***const path_list)
@@ -184,6 +187,40 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	return ret;
 }
 
+static bool check_ruleset_scope(const char *const env_var,
+				struct landlock_ruleset_attr *ruleset_attr)
+{
+	bool abstract_scoping = false;
+	bool ret = true;
+	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
+
+	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+	env_type_scope = getenv(env_var);
+	/* scoping is not supported by the user */
+	if (!env_type_scope)
+		return true;
+
+	env_type_scope = strdup(env_type_scope);
+	unsetenv(env_var);
+	env_type_scope_next = env_type_scope;
+	while ((ipc_scoping_name =
+			strsep(&env_type_scope_next, ENV_DELIMITER))) {
+		if (strcmp("a", ipc_scoping_name) == 0 && !abstract_scoping) {
+			abstract_scoping = true;
+			ruleset_attr->scoped |=
+				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+		} else {
+			fprintf(stderr, "Unsupported scoping \"%s\"\n",
+				ipc_scoping_name);
+			ret = false;
+			goto out_free_name;
+		}
+	}
+out_free_name:
+	free(env_type_scope);
+	return ret;
+}
+
 /* clang-format off */
 
 #define ACCESS_FS_ROUGHLY_READ ( \
@@ -208,7 +245,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 5
+#define LANDLOCK_ABI_LAST 6
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -223,14 +260,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
 	};
 
 	if (argc < 2) {
 		fprintf(stderr,
-			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
+			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
 			"<cmd> [args]...\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, argv[0]);
+			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
 		fprintf(stderr,
 			"Execute a command in a restricted environment.\n\n");
 		fprintf(stderr,
@@ -251,15 +289,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		fprintf(stderr,
 			"* %s: list of ports allowed to connect (client).\n",
 			ENV_TCP_CONNECT_NAME);
+		fprintf(stderr, "* %s: list of restrictions on IPCs.\n",
+			ENV_SCOPED_NAME);
 		fprintf(stderr,
 			"\nexample:\n"
 			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 			"%s=\"9418\" "
 			"%s=\"80:443\" "
+			"%s=\"a\" "
 			"%s bash -i\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, argv[0]);
+			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
 		fprintf(stderr,
 			"This sandboxer can use Landlock features "
 			"up to ABI version %d.\n",
@@ -327,6 +368,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
+		__attribute__((fallthrough));
+	case 5:
+		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -358,6 +403,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
 
+	if (abi >= 6 && !check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr)) {
+		perror("Unsupported IPC scoping requested");
+		return 1;
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
-- 
2.34.1


