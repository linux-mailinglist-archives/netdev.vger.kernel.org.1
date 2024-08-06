Return-Path: <netdev+bounces-116205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10789949759
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329AA1C215B5
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CD14EC44;
	Tue,  6 Aug 2024 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvKqtmSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711078C8B;
	Tue,  6 Aug 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967883; cv=none; b=lHSUZRv/fgLXt89xWH+PVEinIZqYwzDGA7UZ6NajiKlGhk/Hxh08crKukC2oqTuYpKXDoPAupy731O7yP2ZoYmYvT2lvHpvRCHzkYGzTxH/O6rsTsQJKvgQaVy2Jp4fSGtPsU0H26O54EIzkeZFydcTi0aQjQiBzLOdXEIfQb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967883; c=relaxed/simple;
	bh=n4/dqbrwVslhyK/HTd08bHNcZ8Y8wPwXJ9K9yx1yxas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVz+Hgd8CvaezjxW0j6aRIKcaFlplc/yQ5fKyUwmupVAKExJAj6W708aeEbGl9+JUluEgttm6kHV64QDVMvCJ5iw9jZBm1fgHGEXVXzNy98r3FoVj5g86B5TqLCLguoWtyxG/8Ujozo6cGNnSU+EGORxDVtXNXVmrwiXRxLAkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvKqtmSX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso708311a91.0;
        Tue, 06 Aug 2024 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967881; x=1723572681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEZkK4aC6TuYoJdjdgVGJfF2fqj8l2qjt8Waj8faY9E=;
        b=CvKqtmSXpWxWXxQ4+2Krey3+ZcfKkiSM9J9xfCN57B/3+PVsi54AwyLQNx6LrHQjVm
         qVJroDkWcMljU0UQca0fW+hwwpY9w5qB8iLNAMgFLWQuv0tCjfMar0ogNBlWi60Y8tn8
         YprDYhAyNLHZTVh0upac5PebOufQiHdzsOGe+4gSw4N4naw/tUD3khotVuwEM+uTNdW5
         6CpZzCCdsLlxX/DY1uhqXyfc0yQOxq7kMd3Kwut/7zVj81XZZsWI8Ib8f8hKpylixEj0
         ifKVWTpw2Ff5OGAHLPxrVUA/ITHiyTuZMdUVt3fn4BFZ8y0TZQ1OtEynH6baWmXq0+Rw
         A/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967881; x=1723572681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEZkK4aC6TuYoJdjdgVGJfF2fqj8l2qjt8Waj8faY9E=;
        b=wY4zpMBMhn43P4sEYPqtruDd/raCNdSOkbT6qL994qsYmgwz6gq0l392nfYFPH0GMq
         6oQveQnH3Y1Q5WzDNAfi1alsMEiwyGjXBzHGh2hzH/evqIjxUlJfxf1gYq549Ozy0IZM
         WK+lSyNS6qQ2WZNvB6LrfFuReppsFQYekp0srVziLPk9NRQHEa+YX6KrpVjscUYJYVp3
         JyIsoMbato7UKsTfosHmyZnBKbiywsVvT9tavatL/wf9WrezpS3CwkGfTKkJ8yb7RWlG
         hMqRRbHaocAK00V1Y9YYKQZhEarZbGcsKhA8OUndgA+LeFe8o5+8W15vDmgNpJr+cnPG
         ChZg==
X-Forwarded-Encrypted: i=1; AJvYcCU0cMQ+BTRA7xxU6P+u2q97PqXjTndq1ZnBkuRDdlPFvRS9r4/YTs0L0RzY+0mpSKtb112eTLw63KOb2LLMbYq0pdVavUd8wb82ldxIIz3clseH7c0wkNnX/TWU5ZKLxJ+wRYH3LR7Dcc3FZVXw1bcyTV3CU3cfEzFH90x0psplBFDg+7WCbaizMd1w
X-Gm-Message-State: AOJu0YzyDfFj3hhP0QDEn5F/GOhm4VsVYoCzqSw51tD+kEE1iygs8+aw
	grVHZ6iycuEQlmTtpvNMQDAZ4wKY/WG/W758Rq8Tvl7NV0K2SLDX
X-Google-Smtp-Source: AGHT+IFp4JhvBq+3jfMNtSfpN+1rDjfve0u0OglfBB7FNWXmGTaZh1UuxmojRVX4EBP5p89W5q94xA==
X-Received: by 2002:a17:90b:38c:b0:2cf:2ab6:a134 with SMTP id 98e67ed59e1d1-2cff952becbmr18435616a91.32.1722967880615;
        Tue, 06 Aug 2024 11:11:20 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b51esm12829504a91.32.2024.08.06.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:11:20 -0700 (PDT)
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
Subject: [PATCH v2 3/4] sample/Landlock: Support signal scoping restriction
Date: Tue,  6 Aug 2024 12:10:42 -0600
Message-Id: <b301aea5431e60f8827404e76975cfbf4601edbf.1722966592.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722966592.git.fahimitahera@gmail.com>
References: <cover.1722966592.git.fahimitahera@gmail.com>
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
 samples/landlock/sandboxer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 98132fd823ad..c3123f3ee8eb 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -193,7 +193,8 @@ static bool check_ruleset_scope(const char *const env_var,
 	bool ret = true;
 	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
 
-	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+	ruleset_attr->scoped &= ~(LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+				  LANDLOCK_SCOPED_SIGNAL);
 	env_type_scope = getenv(env_var);
 	/* scoping is not supported by the user */
 	if (!env_type_scope)
@@ -207,6 +208,8 @@ static bool check_ruleset_scope(const char *const env_var,
 		if (strcmp("a", ipc_scoping_name) == 0) {
 			ruleset_attr->scoped |=
 				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+		} else if (strcmp("s", ipc_scoping_name) == 0) {
+			ruleset_attr->scoped |= LANDLOCK_SCOPED_SIGNAL;
 		} else {
 			fprintf(stderr, "Unsupported scoping \"%s\"\n",
 				ipc_scoping_name);
@@ -258,7 +261,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
-		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
+		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+			  LANDLOCK_SCOPED_SIGNAL,
 	};
 
 	if (argc < 2) {
@@ -295,7 +299,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 			"%s=\"9418\" "
 			"%s=\"80:443\" "
-			"%s=\"a\" "
+			"%s=\"a:s\" "
 			"%s bash -i\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
 			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
@@ -369,7 +373,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
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


