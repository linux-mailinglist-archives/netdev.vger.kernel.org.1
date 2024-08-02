Return-Path: <netdev+bounces-115208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A889456CC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA6286148
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C073BB2E;
	Fri,  2 Aug 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOLNQBet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAE22EF4;
	Fri,  2 Aug 2024 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571393; cv=none; b=h8g0Oi7AoT/iZg9b3Gfz/mUOk2cntTQmujgEdfU4r6J0zIQVjUzr/sW1yGvZ1eNeM2JnOUUV8xea7ZkhVuUV0kZ1Fv1UFmff0jnito1ZQpwdSjD+RQZcj3GrVlAKxB+Rw18RhbGYmviLUBIaR0t8boUh24lNBZ2nY3t1zi4mB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571393; c=relaxed/simple;
	bh=8XIoOmnudj+J0jp40AbjeJinyE+1/P9q1HUvUmfnQcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrOKeyKjBIRlYMWUe/eUB6Wcoo3Ys4pIgc00ygNPtnT1u239Z9p/OXO1kY/ZeeS2B7NMipCkNX6cxzU94ivLkltnFNVso6obUrfz3BoLTuZaKrQ++xkZPGF1yExut9UPvVGDeKlsTfRDJX2yNkW7JNy1wz9w8irckDsMEF0ALFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOLNQBet; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d333d5890so7149951b3a.0;
        Thu, 01 Aug 2024 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571391; x=1723176191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/7ENZLqF+SNnzbCmbEtFHYfnUukQIei88t3Zjus22M=;
        b=KOLNQBetdHWt+35tSKSfyKvN+1PMYSF4jDYj6fTnRgL6mHitzDkfKSjmwdoXBOGSDj
         j+g0HIV9FofGRhwkgrzgBdhHV3yeygIReXF9Az0fWfcqqUnqmLAVrwX4ue3Dk81a8TjL
         Po8nwWM7pZIsP+Nqy1eKwbb3BSyzkT4qyWELjzVVoXF+Q1UhzH9944gyaJGYsmhdj5Ii
         fFnNEnRb3ov3zZ0N+WHuCXVLMCYBzRkettUY/+EgahlDCpdtq3NdxEI/dU69nQTpejro
         Q6q/A9XeMhE0ouRUxC3KCXwUFdYEpwG87B1jJL0RE4jiRM5ncB4w4XPR0Y7JwZhBGzMo
         bPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571391; x=1723176191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/7ENZLqF+SNnzbCmbEtFHYfnUukQIei88t3Zjus22M=;
        b=SYquLsPcjs/8LvcpyJ3s6pKB8OruRxok3LDETv/oJxjRCNdkpjwVA8s5J8xFi77kb9
         WuyWJI/bnh5Pnf7QIlhPcsO3N3+3YrK0WHaLqmnFxe+FQNVvmK9xtCwODSYKQRskkuBY
         34ogdUyobgHSwnjj9YBDIJp+4IwdwTbtaNcmeOZz/a+HI2ux3OgEN9dMrAOlpBuhKbJz
         Ec97UJEATfnMhRm4lEWRSoLog1vTF169kwNXg0xB2qY8zksFLqXHphEZw2mvRsgp3EML
         HXMe7n2Aea4FJXP+uUGcG9kfey/8S7y/qi1fmYvMp2h00R89JZYzHRmCtdNU2Qny41DO
         CTmg==
X-Forwarded-Encrypted: i=1; AJvYcCWJLr6heK+ZDJNG22NSa0l06SWeEnJPxahDvti42RMHkDvXG1g6y/GursPI9chO/Rs48Pt/4gFVTCoILGX+X0UlmVI2qJ3jLn7lrDNbD7Q/fya+8eW3JL/vD57FpsRw8gqPoHRyohcHE9bzmWlpeOyHFCFGfYU4Uo2zGYwcf7zQsvPfY9gmLXBi2Ck6
X-Gm-Message-State: AOJu0YyThuP8d+TE6PMt6qA964F4CUf/Yam9ar0boHK/hajfIrpQLrxw
	P94G59dPuERHi0Q84spZ59mHsS2eyqhZ4and2lR6XJJbbPwCTYTU
X-Google-Smtp-Source: AGHT+IEYDNYKInMS3sjYGMrrwrb6W3AgsMv3z/oTq4RwfulLbbgIBY6gjz5fOXBjO9sspRWBr7e5bg==
X-Received: by 2002:a05:6a21:38d:b0:1af:66aa:7fc7 with SMTP id adf61e73a8af0-1c6995795c3mr1987577637.3.1722571391105;
        Thu, 01 Aug 2024 21:03:11 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec41465sm542099b3a.60.2024.08.01.21.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:03:10 -0700 (PDT)
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
Subject: [PATCH v8 3/4] sample/Landlock: Support abstract unix socket restriction
Date: Thu,  1 Aug 2024 22:02:35 -0600
Message-Id: <2b1ac6822d852ea70dd2dcdf41065076d9ee8028.1722570749.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722570749.git.fahimitahera@gmail.com>
References: <cover.1722570749.git.fahimitahera@gmail.com>
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
index e8223c3e781a..98132fd823ad 100644
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
@@ -184,6 +187,38 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	return ret;
 }
 
+static bool check_ruleset_scope(const char *const env_var,
+				struct landlock_ruleset_attr *ruleset_attr)
+{
+	bool ret = true;
+	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
+
+	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+	env_type_scope = getenv(env_var);
+	/* scoping is not supported by the user */
+	if (!env_type_scope)
+		return true;
+	env_type_scope = strdup(env_type_scope);
+	unsetenv(env_var);
+
+	env_type_scope_next = env_type_scope;
+	while ((ipc_scoping_name =
+			strsep(&env_type_scope_next, ENV_DELIMITER))) {
+		if (strcmp("a", ipc_scoping_name) == 0) {
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
@@ -208,7 +243,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 5
+#define LANDLOCK_ABI_LAST 6
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -223,14 +258,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -251,15 +287,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -327,6 +366,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
+		__attribute__((fallthrough));
+	case 5:
+		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -358,6 +401,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
 
+	if (!check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr)) {
+		perror("Unsupported IPC scoping requested");
+		return 1;
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
-- 
2.34.1


