Return-Path: <netdev+bounces-119987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C5957C47
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CD1F24E75
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC714D2A8;
	Tue, 20 Aug 2024 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNGhGXzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE61494DE;
	Tue, 20 Aug 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126956; cv=none; b=n5KdCv1rW9i0PgF8Pbgsq7TdK9x2j3ESaoqQ5E+v30LxRQU0wiuhP6dyQ4u4ZtDC1G8SKPdSlsmZGLDnCoqugxrBgvOdPv3rh/CteHBTatOaf54sDgcR5LAiTBbGm+5hxdXWlVYV/RQM8mvzmQHyVxXIqNr4ufH+nK5oM8Ty3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126956; c=relaxed/simple;
	bh=mrBJ4FWvAS/xv++NjS8czhWRS+O1DCL9uBfnsQoA8UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecQcPiqC3cIO/YNGvQ87a86C8BtUwKVF4C2P2LwPuc3Kx3jv7P/lQYJH15bx7OQviM8aN0hgP1daAEUNpERhgoLgYF6VYhdXcduseRkjBQGebHjIaa8Q74LcEucfMudwI/uE20GgLh+jsZXg+TdrF6sgU6SHwe4b0ubgw9hl1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNGhGXzi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so3695459a91.3;
        Mon, 19 Aug 2024 21:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126954; x=1724731754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f02nHzAJ24O+HfMSB+C6HjD5sQKV9lJTHpU5HZj3C1E=;
        b=jNGhGXzinW8Iky836XptwAmRv7lTwQTfyZC9pN7zV/+tYbrjpGrF+akneuxdtYAYpm
         KDUtGGqxq5X8uYmCjGO2DkkjGIlk1WKMJ52wJXfE7iKi6UdvU4x5NgkI2cSStHRiSSwz
         t90vElt418anJh3RTKSwuwkfK7GL6GoaTUhYn9B50tbgAdZtIwTzr3fXzuq4ucL1nWiC
         wlLHyUXsDC2JM2CuzABrvhCXrNeROVr9nM2ds7PYm2MleTVMsBtGJMQ1J7VQnQQe4OZA
         Q8y2QpjLpVtK5RWgsbRBGl953vO58oDf9EXD2WyoZCcRrFCn2lW4Yu0WIk4VBbrvdH91
         cWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126954; x=1724731754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f02nHzAJ24O+HfMSB+C6HjD5sQKV9lJTHpU5HZj3C1E=;
        b=R64bLA6/fniChl0jHrAk89VrS+2yoGpbHZvm18f+8H6VPJoc5w0+dikM9huMF4CQuM
         snmaI5GFeI4J0Qv3I7izLp5NDIFkI9xS4O8vB+7XuAC2SU7yo70YkR1UgQWf8Rzty9cC
         Kp0oLGD4vgAPgc1eYXliLphI5jpBu5SaDG4oLBsPy3VEfuIWMKRrkdLpz7aHHE6ndH2A
         FOUD4KN2cB/oVx2+yIYywuXXVpMB8ZzBUPJaXSnPa0ysWiDl4qq5Zqs/k4pizBp1IYtc
         z/oKVG1BydJIf4KrYR/cK6Ah7nPxv+7G/qbKjeH/OLBanM3muMfmL5cMOjYn1NJnXbpg
         yDnA==
X-Forwarded-Encrypted: i=1; AJvYcCVF0DdfxXSCVXsTgXdRiBvGWQKby3lolicnSYoozr9OjcsdjBRDd+jGfg1TwJi6C6jgF1ENQpWQBP0EXdvqq2x3nsYWLKDWsMRswM3iU78JrToECsISWdNJeT8PpvSOUCog7QAOqRPcM+Mb5RiXXi3abyO7jHMb2eaKN8DU3lDbG2vb88Cw5Fld0iwU
X-Gm-Message-State: AOJu0YysUoSyGpSpbrMOm4IGOZmNC1d0DVZsX3gy4ORiLs04OC7XeAff
	/p69eN3cnLJp7P6TfWMNktEVlLyQCO6x2ddVB9YLu7a4l1YJaW7cv0ot3Gtx
X-Google-Smtp-Source: AGHT+IGabbOzYZTuCim0+RpV5zEtWqgMYRisltOylP3DXxMzn9ixiG9uiq6myd0OIUSVXkgSl1178Q==
X-Received: by 2002:a17:90a:6fa7:b0:2cd:55be:785a with SMTP id 98e67ed59e1d1-2d5c0d79fa5mr1390100a91.1.1724126954258;
        Mon, 19 Aug 2024 21:09:14 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:13 -0700 (PDT)
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
Subject: [PATCH v10 5/6] sample/Landlock: Support abstract unix socket restriction
Date: Mon, 19 Aug 2024 22:08:55 -0600
Message-Id: <72945c1bf5ad016642b678764f44a3dcc5cb040b.1724125513.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724125513.git.fahimitahera@gmail.com>
References: <cover.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A sandboxer can receive the character "a" as input from the environment
variable LL_SCOPE to restrict the abstract UNIX sockets from connecting
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
v10:
- Minor improvement in code based on v9.
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
 samples/landlock/sandboxer.c | 56 +++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e8223c3e781a..0564d0a40c67 100644
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
+	if (!env_type_scope || strcmp("", env_type_scope) == 0)
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
@@ -358,6 +403,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
 
+	if (abi >= 6 && !check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
+		return 1;
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
-- 
2.34.1


