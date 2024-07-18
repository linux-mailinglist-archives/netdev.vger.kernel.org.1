Return-Path: <netdev+bounces-111997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC9934716
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F12829EE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26F855E53;
	Thu, 18 Jul 2024 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htsPrR+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0E1B86E7;
	Thu, 18 Jul 2024 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276154; cv=none; b=GCurUM77OD/ztPiIm8RKwjBlnJgJPznF3JR86w7H2mZGY4jLDKReq1iTZr7WFYxZaB/6e2UQp7vRTbsX3fPGRQyu6/2niZzWB24/qoeGQQDWze0fzelJtp76EI7B3Rrod2py4jvg6rMWY94EDgxVdckvqpDqE/CP/xWORMZ32cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276154; c=relaxed/simple;
	bh=U1skI0/owqu89TPWoLBxrMB2fOvZuZ6/wD+ec3esMxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZR5qUhYb9G7tJHTFFPKwEj0QT/wRWUmFubJriXpkR0fZItnl14SQMnjnE8nEUaKOLKWMRvzfMiV8XCUgYCYU5PDsLBF/jx5uakaVfmWjrh9HP3JeltqZzhFXOB/eGufC2bHC04vtqqbQd9neYFxUwmQ7y2MpKetLbjTt76fuAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htsPrR+o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc569440e1so3878315ad.3;
        Wed, 17 Jul 2024 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721276152; x=1721880952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4AZApuNWuMCTq5fWJPFQbHeMwMdXxcGaz7OzmTbO1M=;
        b=htsPrR+oxs7E3DAVDT3EvTvH43AjFsbjS+zAKbExEVUSB2OaB83p8Td2V/zUZstO7q
         GpZPSJPjCXkrcH4i7eBQC35Ozk622pFZ9mm4fsWh0fIRONiO80mj4DsFPsSsy2gPmxyP
         Q0SP/dSO9djaE2ceqbclerYnYPnITX3sEsMmd1HLB9NsHWicJHVjXnOnFX0BvvopevAg
         FTUsnhs/Dy6B0BkllvOmGn8XrVE4YydLrNWvf7xL1CntsC4jdIOjFdq6o7lM5dRC4x8t
         6JTF1VUWj53kXtBXD3ZtPdmfjAhbOEqzh1MxkZ/bttyzGYJYjGogItngkHrAy64Z9dBj
         kJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721276152; x=1721880952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4AZApuNWuMCTq5fWJPFQbHeMwMdXxcGaz7OzmTbO1M=;
        b=jkrnzNAlQ8hoVeqyTGHSaZql+fXEHD9mvcXskoTtD7SQn769OxEosoAOXvLaYdopYj
         TsalUeKn9YvRRe0U3b+lUw9/bO78YD5aO7/tf95PHA9qfyLKzjDt5IqnZDnYpg0M0ykZ
         SBCtLVewGBwr4QIqCz/yfW+9ZnERAZuZd6FmqgicvyAQVC2YObIxVtBqRiMa/fhcOXaO
         5cY56XuazohVOdrVDR7B9bTz5XWug3pRfm36CCsGJeecyjqFIpt4TXOR+aWphspHouEv
         A+xnkCNLoBkpEoCmEGgLh0H3CfwklIP2u3w4S1B1yURb4Fx0LdQ2TW5Tz8qu7p83/gPU
         KqDw==
X-Forwarded-Encrypted: i=1; AJvYcCV0nXldHXheZ+Hto9XjfVCqgqDBE2m7LJdNu7C60KiiR6qm5KMdj9q/+377+kqoxj2lzfXsYYv98qNYZWpZ6xff1kLNw99CcqX6+y3mheZFWKDCxOcyur4MAvTyfvl9I3O8UknhCmZ82pPJjTn+5dUOYU/K9WQ37rQ04AfkR9cPCP1eUulTpk0p7RFh
X-Gm-Message-State: AOJu0YxUKHHZJUiOhJCOHYf5y/3hPiyjlRhhO0iRYazRtuCmj43j+bsU
	sShhul319kb1Sss0gCK9Uc7NOoE0RyYlOObupVIxtQJ2JeXJfJzD
X-Google-Smtp-Source: AGHT+IE89WGHF6zhVB1Wo0uchAQ3vvWGFzOEJsdiKRmsm4DKPl2YocYWq1TxHWGxltp2Fr6Wyayu7g==
X-Received: by 2002:a17:902:c94d:b0:1fb:5808:73c9 with SMTP id d9443c01a7336-1fc4e676606mr33999065ad.33.1721276152529;
        Wed, 17 Jul 2024 21:15:52 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38dc0sm83152785ad.215.2024.07.17.21.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 21:15:52 -0700 (PDT)
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
Subject: [PATCH v7 4/4] documentation/landlock: Adding scoping mechanism documentation
Date: Wed, 17 Jul 2024 22:15:22 -0600
Message-Id: <319fd95504a9e491fa756c56048e63791ecd2aed.1721269836.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721269836.git.fahimitahera@gmail.com>
References: <cover.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Defining ABI version 6 that supports IPC restriction.
- Adding "scoped" to the "Access rights".
- In current limitation, unnamed sockets are specified as
  sockets that are not restricted.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 07b63aec56fa..61b91cc03560 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: April 2024
+:Date: July 2024
 
 The goal of Landlock is to enable to restrict ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -306,6 +306,16 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+IPC Scoping
+-----------
+
+Similar to Ptrace, a sandboxed process should not be able to access the resources
+(like abstract unix sockets, or signals) outside of the sandbox domain. For example,
+a sandboxed process should not be able to :manpage:`connect(2)` to a non-sandboxed
+process through abstract unix sockets (:manpage:`unix(7)`). This restriction is
+applicable by optionally specifying ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` in
+the ruleset.
+
 Truncating files
 ----------------
 
@@ -404,7 +414,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access
+    :identifiers: fs_access net_access scoped
 
 Creating a new ruleset
 ----------------------
@@ -446,7 +456,7 @@ Special filesystems
 
 Access to regular files and directories can be restricted by Landlock,
 according to the handled accesses of a ruleset.  However, files that do not
-come from a user-visible filesystem (e.g. pipe, socket), but can still be
+come from a user-visible filesystem (e.g. pipe, unnamed socket), but can still be
 accessed through ``/proc/<pid>/fd/*``, cannot currently be explicitly
 restricted.  Likewise, some special kernel filesystems such as nsfs, which can
 be accessed through ``/proc/<pid>/ns/*``, cannot currently be explicitly
@@ -541,6 +551,13 @@ earlier ABI.
 Starting with the Landlock ABI version 5, it is possible to restrict the use of
 :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
 
+Special filesystems (ABI < 6)
+-----------------------------
+
+With ABI version 6, it is possible to restrict IPC actions such as connecting to
+an abstract Unix socket through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks
+to the ``.scoped`` ruleset attribute.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.34.1


