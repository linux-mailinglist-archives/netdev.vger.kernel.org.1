Return-Path: <netdev+bounces-111996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BA934713
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4852817CF
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5952F71;
	Thu, 18 Jul 2024 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0GYPv6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767847A6A;
	Thu, 18 Jul 2024 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276154; cv=none; b=ZjBCKKnH8bCPRR8+XNSZlajAuvObvGTKT8sIvFSeioKtcNlP2pWxQ9Z6EdK0qdqFfg6UHzp22837gvwbfsuNM2iGeiTMfali9YrLt+MypMvmokM/oev/Lk2UvvkTB80DV9u0yEizUnmPQkI+I9dW78HIBEgqryxbJSq9cIfXWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276154; c=relaxed/simple;
	bh=Mi5ZUM41/ktJX7zKCU6FlONfY/9U4/6+NbrEylDFMN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDuABLi53s8LY5CxaFiGIIwbi/frW5459uXuO6jjsXqpdWkXjrbkLPpdcOhd3BqzDzeHHlpvNU1Me5kcaD1z3lI6DEbx0L05k+QRTpzLdyTBeUlE7VVP08IsPUtS5IEKdt45CoXLDrudPqLFgzW9CkbonPTdttNIlva81158lHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0GYPv6n; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9778bb7c8so161877eaf.3;
        Wed, 17 Jul 2024 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721276152; x=1721880952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6zBj5uZPcxriKU++D3mNaRl/FODLGy5kTzzaF5U6JU=;
        b=X0GYPv6nsQnDv8eh+4hv1Fun5avsyHW/qi6McOiP2acHoT9Vaupa15tNijlLlhDqdL
         HlANIGPlRcY281Je2WNTQn6fmaJ7nPu92znrO9BRyS4HWGOlJv0MqwvT0QNdSGLzaaSS
         YUvEaqAEDn4YheMWOXEkPXKnTYPNaICoQhIBdHQtfz+x72mRIvetUs+3CZXIF96CGom8
         fMr0xvlHxznXC+KsvWVFU7aMHpeJwj4gk/DAmGigMHp+NR3Hj06Vt0bmDjhLUA7xIQeA
         8cJzX2cFCk4fkxyhkokeglRevI161CoXncC+EFyarRpu1ED6OA2PfeCt8ntkRBaBHraB
         rtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721276152; x=1721880952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6zBj5uZPcxriKU++D3mNaRl/FODLGy5kTzzaF5U6JU=;
        b=iLVdOrvIuJGr/4LVu8Xrb/xOfrQHUsKhqAxLC/x6ibtoY4/oIvR3V8wzC+gHzDz9hp
         08C6jBi8jVITXBaCDGT/3vsTDm3lnBZzQowGvq1wZs3Bhc/lqRV8qq2PAbWZBNNQ34mo
         b2TU0sY5wFPyp49heWf9+pCyj9PsZ27398rAPXuO0aQcRW2C8+/NDUcC3DryBUOi5foc
         S2N6jzv96fRCSRQTXT6KSDRBZPVKc+m7uE6DaPi11y1l8RIZtTBf3Kg5w6Wm/7IdOflf
         nOvVfPHZ9XYYZFjtTeNxXQSY2C0z+NqHaZIlboV9M5k371uPhzILV5BYty872Wz3feKN
         BoyA==
X-Forwarded-Encrypted: i=1; AJvYcCVfR95jAuagPTtwplf3iPUYpC9quwCTEuTxunptjvDo+87xzjPQYze3qbUSgxGfZXR66uGLx1OqahkreCSSPGXHgev384GbDsXT+G8RDYeV4wzY0q/VnmEuPJbZAg5Fz6jky/11HgD09Nv+a56JGD3wmzD/w2HreRkVN3zoUpUtsjkEbY2KMwZOZz+G
X-Gm-Message-State: AOJu0Ywoztvy0EojOb19dFw0yTrXJm/rWtjCUe39TUeAidDF6CQ+x94x
	YQEaj6RR9brGLEF2HuzQvzrYBzsSuXOxU88weYnNQJRZWYnlbOoS
X-Google-Smtp-Source: AGHT+IFwFt3EVAdJbOsXpxxA3vfHmISA7yugItyNb7EugfFXHK8ITWJL2iMN37Ie6Bpm5iDgO7brkg==
X-Received: by 2002:a05:6359:4121:b0:1aa:d71f:6921 with SMTP id e5c5f4694b2df-1aca9e92f8dmr148395155d.5.1721276151571;
        Wed, 17 Jul 2024 21:15:51 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38dc0sm83152785ad.215.2024.07.17.21.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 21:15:51 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v7 3/4] samples/landlock: Support abstract unix socket restriction
Date: Wed, 17 Jul 2024 22:15:21 -0600
Message-Id: <4f533a80d56d9f57d50a87d55101cfdeb03404c3.1721269836.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721269836.git.fahimitahera@gmail.com>
References: <cover.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Adding IPC scoping to the sandbox demo by defining a new "LL_SCOPED"
  environment variable. "LL_SCOPED" gets value "a" to restrict abstract
  unix sockets.
- Change to LANDLOCK_ABI_LAST to 6.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 samples/landlock/sandboxer.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e8223c3e781a..d280616585d4 100644
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
@@ -55,6 +56,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
+#define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_DELIMITER ":"
 
 static int parse_path(char *env_path, const char ***const path_list)
@@ -208,7 +210,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 5
+#define LANDLOCK_ABI_LAST 6
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -216,6 +218,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	char *const *cmd_argv;
 	int ruleset_fd, abi;
 	char *env_port_name;
+	char *env_scoped_name;
 	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 
@@ -223,14 +226,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -251,15 +255,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		fprintf(stderr,
 			"* %s: list of ports allowed to connect (client).\n",
 			ENV_TCP_CONNECT_NAME);
+		fprintf(stderr, "* %s: list of allowed restriction on IPCs.\n",
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
@@ -326,7 +333,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	case 4:
 		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
-
+		__attribute__((fallthrough));
+	case 5:
+		/* Removes IPC scoping mechanism for ABI < 6 */
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -357,7 +367,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
-
+	/* Removes IPC scoping attribute if not supported by a user. */
+	env_scoped_name = getenv(ENV_SCOPED_NAME);
+	if (!env_scoped_name)
+		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
-- 
2.34.1


