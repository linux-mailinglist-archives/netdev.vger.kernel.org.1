Return-Path: <netdev+bounces-118951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA8953A1F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5BAB2608D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09637155739;
	Thu, 15 Aug 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKQK2i3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A761547DE;
	Thu, 15 Aug 2024 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746589; cv=none; b=QvZiZHOhmnSrAga9+F0sZo98GSC8N6Uq9xIWbRGHz0cMMqUKIst0WwnbwJxlM7/y3GuQrJZ/uyPGS7rThvOw1HccVJOyL7bqLLMoyjjZ6bKatoQQr9Su5NRuPiAm8DCfxarH1BEUc9QhjD6qv8YKmzUxwTN4Kf4dSdlop3oZ9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746589; c=relaxed/simple;
	bh=YG7ztYtGDpdMdRJxGt0nbvusc+jjG6LY7He5l4J8OGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ler5DdKRBE263VLl1Mpfs3hg8mqKfMcGdF29jP6fu/1WcsKZjKWb6COIlRVlTJ3oLMNprC3taXjObbY+mYflcYuwUkJaa0ZQmQ1sYa8W4VahqAvO8hHQe5vcwuYbmkjCVHqRQCPy/TArLV3f0IoJg5lzJuw1nk4uD5DDu9EZ7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKQK2i3M; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d399da0b5so1025283b3a.3;
        Thu, 15 Aug 2024 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746587; x=1724351387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaqFtVOJowFqILZS0KD2ZkJqnDGSSbSvRXd+7bNfKMI=;
        b=RKQK2i3MkRdHanUhQsNeeQgrxN0iv4OcG5ppoAwTgzBGHr6jHJ+ifLuZOHriv/gZYK
         S+n4Ui4QQZ3WV7ZEEvfUAo+/LnY8QWUh96jO6ascZvz5FF689y7UnMkzXnj9SXDJJif9
         CoD5I6TDI6ch+4ASZfXYcQEVJ9PRCa+/Ro/noJfrsF1wSwCTzHtstfSF4elf07AXQ6T0
         tkklVl2drbXVWfdW8QXjWBuBgR6n9C8s2CtW3/482w2cCc+gs4kASnolWS417U5eGZpl
         dJelAArThloiElLOXUfPNB2ENaAD6GPMrRaw5RasyX2g2HQcR/ibPbzcMVjYyW6tpS3B
         uAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746587; x=1724351387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaqFtVOJowFqILZS0KD2ZkJqnDGSSbSvRXd+7bNfKMI=;
        b=SHcHWn4iI3HoNqeM3Q4ExmuUGg7rYuQU0kMLd8XVH2xXN7R3DieLVNtTkcTRYOFroO
         m8ZKq1EDkapFG6feQM79pMN8M0RGVP9FJQ2B87+cwkTKsNAPe9E4Y5kONaVmE/hUSyFj
         TGbFXaBhgEzpo4tD2bb78Dn1+vLkOu54PKXn3EfIVqPLxOFJphjwdE8fSOCkjtgj9rPM
         GBEytyyQ5KAG0AZiVZmfBWB4bHC7GhWbeqkwLB+WiuAhYNZAsTvPPUw28/f5BDzLE6kb
         Z2ZTGzoJr37wQmO/1Ai0FPT5Xbz8FTh4xkoU8rtP9OjClzJpSukIl7wo46QuwTeCf+sa
         BnHA==
X-Forwarded-Encrypted: i=1; AJvYcCVPMNi9CyYl9tGk6k3LHmcQeI90Q2Ylyd+Q/amE4Cw8SqhppUoYk2N0MUJ4hU86Siv1jDssDmRFFPqXRLXt2Bq9ntcLyc1oX2lvaIsO8cWejnAoEhYPKUY4GOzbfqfnDT4S/ZvTJ0NhEHc97sPdFAuzVB+FVSppGxfde+5ogbjvO26ehPCmCaQTZDXE
X-Gm-Message-State: AOJu0YxPP9ph2Z6oUH90X8VRCXu14isjuFWQ9QgS8OvrpkdbxZZFbyY1
	FLRcLVYIyld0G5GWQGbKLLR/nkXhHxJ4wwOErrBUuzHINrdhg3lz
X-Google-Smtp-Source: AGHT+IHg/i02zernU8cOom14t7K88UP+y0+xstuHerG5u3WS+VLAHsxJyKYaAQsRpbgep845undT1Q==
X-Received: by 2002:a05:6a00:6f2a:b0:706:5d85:61a5 with SMTP id d2e1a72fcca58-713c4e0b4b9mr688752b3a.8.1723746587008;
        Thu, 15 Aug 2024 11:29:47 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c76sm1431683a12.62.2024.08.15.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:29:46 -0700 (PDT)
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
Subject: [PATCH v3 5/6] sample/Landlock: Support signal scoping restriction
Date: Thu, 15 Aug 2024 12:29:24 -0600
Message-Id: <c39fff6b21d4694bf2e0baa24e219fecefa7c76e.1723680305.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723680305.git.fahimitahera@gmail.com>
References: <cover.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sandboxer can receive the character "s" as input from the environment
variable LL_SCOPE to restrict itself from sending a signal to a process
outside its scoped domain.

Example
=======
Create a sandboxed shell and pass the character "s" to LL_SCOPED:
LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="s" ./sandboxer /bin/bash
Try to send a SIGTRAP to a process with process ID <PID> through:
kill -SIGTRAP <PID>
The sandboxed process should not be able to send the signal.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
v3:
- Add a restrict approach on input of LL_SCOPED, so it only allows
  zero or one "s" to be the input.
---
 samples/landlock/sandboxer.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index bec201eb96f7..32fec6cede2c 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -191,10 +191,12 @@ static bool check_ruleset_scope(const char *const env_var,
 				struct landlock_ruleset_attr *ruleset_attr)
 {
 	bool abstract_scoping = false;
+	bool signal_scoping = false;
 	bool ret = true;
 	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
 
-	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+	ruleset_attr->scoped &= ~(LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+				  LANDLOCK_SCOPED_SIGNAL);
 	env_type_scope = getenv(env_var);
 	/* scoping is not supported by the user */
 	if (!env_type_scope)
@@ -209,6 +211,10 @@ static bool check_ruleset_scope(const char *const env_var,
 			abstract_scoping = true;
 			ruleset_attr->scoped |=
 				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+		} else if (strcmp("s", ipc_scoping_name) == 0 &&
+			   !signal_scoping) {
+			signal_scoping = true;
+			ruleset_attr->scoped |= LANDLOCK_SCOPED_SIGNAL;
 		} else {
 			fprintf(stderr, "Unsupported scoping \"%s\"\n",
 				ipc_scoping_name);
@@ -260,7 +266,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
-		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
+		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+			  LANDLOCK_SCOPED_SIGNAL,
 	};
 
 	if (argc < 2) {
@@ -297,7 +304,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 			"%s=\"9418\" "
 			"%s=\"80:443\" "
-			"%s=\"a\" "
+			"%s=\"a:s\" "
 			"%s bash -i\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
 			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
@@ -371,7 +378,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		__attribute__((fallthrough));
 	case 5:
 		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
-		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+		ruleset_attr.scoped &= ~(LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+					 LANDLOCK_SCOPED_SIGNAL);
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
-- 
2.34.1


