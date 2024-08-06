Return-Path: <netdev+bounces-116206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0094975E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431A01F228DE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4A155C83;
	Tue,  6 Aug 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erkTNNf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F679B87;
	Tue,  6 Aug 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967884; cv=none; b=VD5uy+yjCb8Fi6r+e8x2rV3ItHf0y42Zhc3yR/X6klPcJKb1GSdVcT38P285s/6lxLn/2B6RuFAL0zWwbO1UVO8FuAlTIeI2ZgsVaigRUgrLAXWMfSCi98MBi7x2L7H09rx46ynaCPLpWqFH+sXV7SFj7NuNkcihNF9xPMywZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967884; c=relaxed/simple;
	bh=q9QLkZ/H/j6QTqNueNb0kSZDd/RQJbs+z7t4FIClwzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VS9Gq1xKpSmAZ1q7iRX0lIezHfJ21NZzRum5Q7EFteUOxyDG6voVtEMb7GuJgNKRgk4y5Zc2YJ5D/KpuyinKHVrc/Yo9eSZgChCQ1b0cmAvEc7KBl+NEJZ86Erk0Xgme+MaJd/BsLVSajxyZFRxO/rfzVlx3uHWxIXNw2IsPoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erkTNNf5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so651247a91.3;
        Tue, 06 Aug 2024 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967882; x=1723572682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VrsPTsD55P11qoYiWXSWqA/RANzLdJrHm5M8EK/YZ0=;
        b=erkTNNf5e3OPpMpZByd0s44hWUWBs0Nrg0Uay5xKL+I01ZMC7pcD2hZZvvTvE74G/y
         1ZOcvti4WXLVYagKJIkCweUOpeY/B+6ry6BbW1gC/4jdG9mtZUoaJOpGx59Y30B2cu+C
         ldSeI+Oc3Lzl3hUq6xm4egwZBk1F3tHXBpAdF5UXR2cMHZbGSgmEJy2NbD3xHpm3U1vg
         EgSkAYmr+HT4Dc4vp1Q58j6yMLt8Tenc0PUaUnPYc6NL5r8IPd8AT3OS8OWDIAzQCJ/I
         T9qg8nnLU4BgbBX7LQ4RAkbRx0/hsiv4dGJAxgCA1Wo/0RGLxQLylEdk8owXlrUkDCqj
         NSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967882; x=1723572682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VrsPTsD55P11qoYiWXSWqA/RANzLdJrHm5M8EK/YZ0=;
        b=sAZJbX5oCTP3tpbYjclzRboERdeGB0d69HczsWyID0J3EkNrT5oAmV8xDCvN5iN9fi
         CUr30Dku+2TWL6jWMFlZGVTktlLRUt9phb2wZDqB+Uf7H1Qpih1j6GzKqhsls7Jn7PrV
         N68VHKfb776Jq5glctCKVmSyMWxTwdO3z6sWuOHvm/kmA12ZpXHTjKnkhjtw9oqA7y0W
         GPBo0FzQRbSXlcdsDYsOMZfvCf+sUJ7hQsciBSEINscTkjnrDW9z7MEAC0OgQiaeGYl0
         20BPfy2idGGf2/85vJVLWeqQUdCMNYDJQ3Mn3zlyRWqwm5yM7+ahnOViTAyfGJjDFjXE
         mMuw==
X-Forwarded-Encrypted: i=1; AJvYcCUC0/6cXp4EHCoVJOpMNED76iggL8L0k3W+pYsrVKMRIqsO35H9S3EwXgV7sw0+NA8ulEL+9A9/1QYZndc=@vger.kernel.org, AJvYcCUFWyJZIXStBnV5P+btixTbVf04GI0j3LmkjsfUDxZ9hO9urKLxlfAdam7IJgebuGVyKuNsaqua@vger.kernel.org, AJvYcCV8JDqgKHPvTl0AOu2yetfrPcqYWmWJL1t7JjHjbmJufqpGGiEo2qoMnklA5VFcSvZI9wwI7sMPg+HotG3GSi1/0qhgIsdg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywel59CIy1khLlwLAvlaE9g6KtzyU+8OQJYB1ZR6tMz2Ki/ZdKJ
	UMAh9Ewsz2nZVHG8OtI4M9xnHorP8WM2Fj1W3mWa6FFVNmmSIOHC
X-Google-Smtp-Source: AGHT+IGiT+hmqoEULYz2BBGUi4Gw+UHaG5Qkj+LXdSF6TXcbaZb0t8t/rendJeJxdT7efNmVye4TAg==
X-Received: by 2002:a17:90b:4016:b0:2c8:8a5:c1b9 with SMTP id 98e67ed59e1d1-2cff94143f4mr15769258a91.13.1722967881560;
        Tue, 06 Aug 2024 11:11:21 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b51esm12829504a91.32.2024.08.06.11.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:11:21 -0700 (PDT)
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
Subject: [PATCH v2 4/4] Landlock: Document LANDLOCK_SCOPED_SIGNAL
Date: Tue,  6 Aug 2024 12:10:43 -0600
Message-Id: <e7d324cc4c256f8574b444c0c4c2899c78ed0c16.1722966592.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722966592.git.fahimitahera@gmail.com>
References: <cover.1722966592.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Improving Landlock ABI version 6 to support signal scoping
with LANDLOCK_SCOPED_SIGNAL.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 27 ++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 01bd62dc6bb1..1923abfd2007 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: July 2024
+:Date: August 2024
 
 The goal of Landlock is to enable to restrict ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -82,7 +82,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
         .scoped =
-            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
+            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+            LANDLOCK_SCOPED_SIGNAL,
     };
 
 Because we may not know on which kernel version an application will be
@@ -123,7 +124,8 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
     case 5:
         /* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
-        ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
+        ruleset_attr.scoped &= ~(LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
+                                 LANDLOCK_SCOPED_SIGNAL);
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -319,11 +321,14 @@ interactions between sandboxes. Each Landlock domain can be explicitly scoped
 for a set of actions by specifying it on a ruleset. For example, if a sandboxed
 process should not be able to :manpage:`connect(2)` to a non-sandboxed process
 through abstract :manpage:`unix(7)` sockets, we can specify such restriction
-with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.
+with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``. Moreover, if a sandboxed process
+should not be able to send a signal to a non-sandboxed process, we can specify
+this restriction with ``LANDLOCK_SCOPED_SIGNAL``.
 
-A sandboxed process can connect to a non-sandboxed process when its domain is
-not scoped. If a process's domain is scoped, it can only connect to processes in
-the same scoped domain.
+A sandboxed process can access to a non-sandboxed process when its domain is
+not scoped. If a process's domain is scoped, it can only access to processes in
+the same scoped domain. For example, If a process is scoped to send signal to
+other processes, it can only send signals to processes in the same scoped domain.
 
 IPC scoping does not support Landlock rules, so if a domain is scoped, no rules
 can be added to allow accessing to a resource outside of the scoped domain.
@@ -563,12 +568,12 @@ earlier ABI.
 Starting with the Landlock ABI version 5, it is possible to restrict the use of
 :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
 
-Abstract Unix sockets Restriction  (ABI < 6)
---------------------------------------------
+Abstract Unix sockets and Signal Restriction  (ABI < 6)
+-------------------------------------------------------
 
 With ABI version 6, it is possible to restrict connection to an abstract Unix socket
-through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks to the ``scoped`` ruleset
-attribute.
+through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` and sending signal through
+``LANDLOCK_SCOPED_SIGNAL``, thanks to the ``scoped`` ruleset attribute.
 
 .. _kernel_support:
 
-- 
2.34.1


