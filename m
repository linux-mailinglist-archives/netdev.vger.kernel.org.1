Return-Path: <netdev+bounces-126067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2249296FD61
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4043B1C229C2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753015CD41;
	Fri,  6 Sep 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs9haEUj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C715ADA1;
	Fri,  6 Sep 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658223; cv=none; b=cckoaGHDsooxWPtQ9Boz9cVxXdiX/aOxkgTbNI6gDmmKdYuqsYLnEn0dt6q27zcc2qgBtpavZK1WAlW5gWicTnsRu7IMyyJK6MjWV1dF37w9N+MXgFnWggMlYSOhk4b1bVhGkPPdbHeMKkTz7xrt3CkwWMi5UA4QWkALTeYlnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658223; c=relaxed/simple;
	bh=5URkew6MTbSPjmDCxnZtF4ylhtAoZWs2zFXPZaqdC+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zi+4LY+TCevYNCdQZGUzVxeRElqbFHAxcH9hG9qIpuEgik9Ikg3HoicfeQyKiKH3IvDYkaNE041s6xpFn7tzRyTp1mFPxQvgCfWVlL1kwAGeg0nVM7uYv77NIeoYrwGV+wCYkfMk9y/r2YNbPHDQRvOxfo1rtX+4vxMAdYn+UpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs9haEUj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20551e2f1f8so25223275ad.2;
        Fri, 06 Sep 2024 14:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658221; x=1726263021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo09Uhc5A+uBAyAcs1Ht/DtBSMlFilRGw1wDCdIXuMU=;
        b=Zs9haEUjIGglJxR4fg8qeqhpdmhJ2l3L9jI3uId1ERu43e/is6SDEDQgrESX9Fvk65
         w7MYfPBe0GZJCSu8/uT9ZXcju+Zb+MMQgA77NTE1Hj9RXW2UCFGztgt9nEWrTpgT89c+
         UDe6Asb6IWiKGcLlVeXHiV8E6GxCpj83ZcwHufjpGzTjjH04yvrsEuz/zuhUVukmD7WK
         D667usn+8jfjEYTjVrB9vHLRVFL5b9oNpO+Rd/IuHTCYiyXHsxWHvl/Q0iVgEFmat433
         qnUc1TQ29zIOqJ06y4bsMadTsFOat3f/ROt3e6mlaWanQ6haAqH5HY9keok2WAZLdM3x
         IOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658221; x=1726263021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo09Uhc5A+uBAyAcs1Ht/DtBSMlFilRGw1wDCdIXuMU=;
        b=J593DZPGlrHu8fTBdCH6j96jd4FITrP8NyVikSekJH/eZ4MIuTurk5odcA4VYtRmuV
         1JG0TVxMVIZfxHnT+cKv5PAl8Kbk1/AiOmrc7IGIkO1r9hMScz7EBc3IQIstUKrKMK1C
         LRQkZFavma2KPwDYAhgD5qoxXIplAck9NWw+c5FnOweBLRyH7Y/rWI8B23Xab/I1MQNG
         lGWDWUy6UQJSZaAKYeiT71B5T3ybBc4sgWAVexOu7LBQSfZWRPl3r7bLqesm/5aCmgo0
         PH+B1HFZ9kAA0btjnOBcYmob5NxWGfBpGO9s5rfhSHfrgZFbotX73hHMprKmhyIRudww
         nU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj+TZiCx2ZZUj6QJirSjh+E42xLiKi8RThEeAilMW+XHnE89bEL/YWBRRsVNAaAhKRaf3yLtY/C5trSXEwxqkiA4ahVdQV@vger.kernel.org, AJvYcCVmoLtSNfZQHsARjA0V5uLnFvybl0R54gkvaJ0D7eKiAbt0MJj8Wh8I6ewZBX2vbErkdhYJxKqB1e9t1bI=@vger.kernel.org, AJvYcCWcePD4QUPzfIBwQZjaqHgVJveJ8tewNi2mQ7RAUvzpP8Oe25w9FCpZJOG3TDxiyiIsweGDRy9F@vger.kernel.org
X-Gm-Message-State: AOJu0YwrpCLSflJEXLG8+mTbtsEu+Dy/fpiRPYep5X3joEzbd9ABGdW4
	EaKXnKr4DsDShRlxkFUFS/FBq7lB/jnVu1+/4WzeuEYXD793wgMq
X-Google-Smtp-Source: AGHT+IFHhd91sIx7FTtJWHA0Ayu/+5PDc1IaIfyUSpCenN3ZsXr9Gb/JEuPnWNZjlO9JhweP6OEElg==
X-Received: by 2002:a17:902:d4c4:b0:206:f065:f45d with SMTP id d9443c01a7336-206f065f520mr43510585ad.31.1725658221188;
        Fri, 06 Sep 2024 14:30:21 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bd1sm47081065ad.247.2024.09.06.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:30:20 -0700 (PDT)
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
Subject: [PATCH v4 5/6] sample/landlock: Support sample for signal scoping restriction
Date: Fri,  6 Sep 2024 15:30:07 -0600
Message-Id: <1f3f1992b2abeb8e5d7aa61b854e1b0721978b9a.1725657728.git.fahimitahera@gmail.com>
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
v4:
- Make it compatible with changes in abstract UNIX socket scoping sample
v3:
- Add a restrict approach on input of LL_SCOPED, so it only allows
  zero or one "s" to be the input.
---
 samples/landlock/sandboxer.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 18d072c23a23..618fbf70d38f 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -191,11 +191,13 @@ static bool check_ruleset_scope(const char *const env_var,
 				struct landlock_ruleset_attr *ruleset_attr)
 {
 	bool abstract_scoping = false;
+	bool signal_scoping = false;
 	bool ret = true;
 	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
 
 	/* scoping is not supported by Landlock ABI */
-	if (!(ruleset_attr->scoped & LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET))
+	if (!(ruleset_attr->scoped &
+	      (LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPED_SIGNAL)))
 		return ret;
 
 	env_type_scope = getenv(env_var);
@@ -212,6 +214,9 @@ static bool check_ruleset_scope(const char *const env_var,
 			strsep(&env_type_scope_next, ENV_DELIMITER))) {
 		if (strcmp("a", ipc_scoping_name) == 0 && !abstract_scoping) {
 			abstract_scoping = true;
+		} else if (strcmp("s", ipc_scoping_name) == 0 &&
+			   !signal_scoping) {
+			signal_scoping = true;
 		} else {
 			fprintf(stderr, "Unsupported scoping \"%s\"\n",
 				ipc_scoping_name);
@@ -221,6 +226,8 @@ static bool check_ruleset_scope(const char *const env_var,
 	}
 	if (!abstract_scoping)
 		ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+	if (!signal_scoping)
+		ruleset_attr->scoped &= ~LANDLOCK_SCOPED_SIGNAL;
 out_free_name:
 	free(env_type_scope);
 	return ret;
@@ -265,7 +272,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
-		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
+		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+			  LANDLOCK_SCOPED_SIGNAL,
 	};
 
 	if (argc < 2) {
@@ -302,7 +310,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 			"%s=\"9418\" "
 			"%s=\"80:443\" "
-			"%s=\"a\" "
+			"%s=\"a:s\" "
 			"%s bash -i\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
 			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
@@ -376,7 +384,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
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


