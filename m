Return-Path: <netdev+bounces-125318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E785B96CBAA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461591F273A4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F12556F;
	Thu,  5 Sep 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0paisN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0528EB;
	Thu,  5 Sep 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495272; cv=none; b=iYguu8EixlBXmg/LwV50ENed3HGpsNf9gt4s/JLCiTAyUO5Y/NXglF844ZIcMjfawfu1h/lru2Dric7cznbOvhdmfLzC6m9kV4dVu3C4QRVRoGjLfH6tnjX1CAn7H7tFZsy4L8xtxHn7Tg3v1CZikM0+an1SmzHT8VuTGP2+DOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495272; c=relaxed/simple;
	bh=3eeRu4zbZB1MuGmyZVhbliCojVX5Q+y6lx7CXpm0fh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2j4Xyvvx9f8o2a7vINwFoixHa/cNCa5fgNtDn7vzmj2po24yTtqyL1r2Hq8BXqangQ9UJv8Z2w4b8YomMuMHuJhgB5k/SXPc6uioXUo1+JSfmf+UKjW73OpPZ21R73LR3WM66q5/mDIVT6DhndJJjrxGHW2Sr8+sFu8+i+5Pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0paisN7; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5dd43ab0458so147725eaf.0;
        Wed, 04 Sep 2024 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725495270; x=1726100070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb5jw/WoOQPFLaFxTOIP9Tl9HcnrTWdqDgrxkbTFv9o=;
        b=I0paisN7f07ANEr/v+HTox9gAVSsu4gNMyOjBEYnVybpbZp9e8SCb6uA2rhbppxZ7R
         nqxsBpPmKWDySW3kexQFbsv3TKBNpP2Bmx6cFgxof45JuXCHeL89P5yTHvsVYGKOaja/
         LIaefhmtzOljEvU6iyHpnKXs2RbbIWIlD0DIyccJW1sDzGQ0L4Sm72MMm3VqLD9uWVuL
         e2JYJmnK8XBkx3rzzrbii1BI7yoda7UgqnVXxVE8j84pt5M8JelzfgxTuXrtg78bf+Yi
         PGJ9PNHE2EgpC8zn5ir3ETHw3Bmb+0f55X3cBqGoCz+4sa2i2QhncTxaHu4Yoa7IxQ9/
         8Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725495270; x=1726100070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb5jw/WoOQPFLaFxTOIP9Tl9HcnrTWdqDgrxkbTFv9o=;
        b=WBW+ei0n7w5CGHfyTMGcyJ1VUE67GZR925viGG0AJORXAS61cIE6YIwjP1spg8JyVn
         SxeZOIpUFuDVMK6WfkCbAoPygCIkWAzzRJpSKDeCydJLd1sjFZlNxryRvo+OoFHcn/71
         xntXEx76QUczCIXxNzQ0IY4JesYreDP0q+iQpYzUkcCliX1tHzMkPTd3LKD7LF3QnA6Y
         rGbsnbFo9+FcKSZY/3/6Xr0tDNVWvjr4Z/lFPzO07J1Jqv9/W/fdkkb9JMJsuQJLylah
         UUeSlyzAku4L9urYd7+wkFX8EdHyFww6A2MxKh1rMzvQcjtNuGoBoP8JHEMZFBFfS8N5
         NdnA==
X-Forwarded-Encrypted: i=1; AJvYcCVA1B8fibhuOa9MGCMc79B8P4vXkDYgOqIyDCe83v/Y1KIn2XzL3N5pC4tT8EpFiLm8dv8suPjHmqSj1mSBp2DNNum+Yril@vger.kernel.org, AJvYcCW1pqCc655k5hVo5QcPJEJ/BDCY9zUCveHLh93wTLltmx6BSWAOV59mQgyJerQjtESfuNPvpBAIkd1EVag=@vger.kernel.org, AJvYcCW2nYHhm7spGI0e7EFT4Ic77/8/6JvztFg7sPBqdw8bpRK3oakI65EmcQcluhWUFjMyIKShSOl+@vger.kernel.org
X-Gm-Message-State: AOJu0YzllZa8V/j+BDk/CS4DEwRlGBhnkbjQAlWjTYyh4tDyyfDlr5xJ
	kPnX3cpTrb94Ou3OLvwsfkqb7hDMdy0p6YCcDneKpcpG5/dq5FGlLUI94EA+
X-Google-Smtp-Source: AGHT+IF/swT4/QCQUaShc+LWLrYgsQ803/PfQesWXvFDsSqr4DHMuf7CQ8p1bPaggbUhXEZiXo2vvw==
X-Received: by 2002:a05:6870:ab13:b0:260:e678:b653 with SMTP id 586e51a60fabf-277d06c890emr17533784fac.42.1725495269915;
        Wed, 04 Sep 2024 17:14:29 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm2159781b3a.76.2024.09.04.17.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 17:14:29 -0700 (PDT)
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
Subject: [PATCH v11 7/8] sample/landlock: Add support abstract UNIX socket restriction
Date: Wed,  4 Sep 2024 18:14:01 -0600
Message-Id: <d8af908f00b77415caa3eb0f4de631c3794e4909.1725494372.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725494372.git.fahimitahera@gmail.com>
References: <cover.1725494372.git.fahimitahera@gmail.com>
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
Create an abstract UNIX socket to listen with socat(1):
socat abstract-listen:mysocket -

Create a sandboxed shell and pass the character "a" to LL_SCOPED:
LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash

Note that any other form of input(e.g. "a:a", "aa", etc) is not
acceptable.

If the sandboxed process tries to connect to the listening socket with
command "socat - abstract-connect:mysocket", the connection will fail.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
v11:
- Change implementation of check_ruleset_scope function to make it less
  bug prone.
- Imptovement on the commit description.
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
 samples/landlock/sandboxer.c | 61 +++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e8223c3e781a..18d072c23a23 100644
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
@@ -184,6 +187,45 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	return ret;
 }
 
+static bool check_ruleset_scope(const char *const env_var,
+				struct landlock_ruleset_attr *ruleset_attr)
+{
+	bool abstract_scoping = false;
+	bool ret = true;
+	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
+
+	/* scoping is not supported by Landlock ABI */
+	if (!(ruleset_attr->scoped & LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET))
+		return ret;
+
+	env_type_scope = getenv(env_var);
+	/* scoping is not supported by the user */
+	if (!env_type_scope || strcmp("", env_type_scope) == 0) {
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+		return ret;
+	}
+
+	env_type_scope = strdup(env_type_scope);
+	unsetenv(env_var);
+	env_type_scope_next = env_type_scope;
+	while ((ipc_scoping_name =
+			strsep(&env_type_scope_next, ENV_DELIMITER))) {
+		if (strcmp("a", ipc_scoping_name) == 0 && !abstract_scoping) {
+			abstract_scoping = true;
+		} else {
+			fprintf(stderr, "Unsupported scoping \"%s\"\n",
+				ipc_scoping_name);
+			ret = false;
+			goto out_free_name;
+		}
+	}
+	if (!abstract_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+out_free_name:
+	free(env_type_scope);
+	return ret;
+}
+
 /* clang-format off */
 
 #define ACCESS_FS_ROUGHLY_READ ( \
@@ -208,7 +250,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 5
+#define LANDLOCK_ABI_LAST 6
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -223,14 +265,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -251,15 +294,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -327,6 +373,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
+		__attribute__((fallthrough));
+	case 5:
+		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -358,6 +408,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
 
+	if (!check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
+		return 1;
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
-- 
2.34.1


