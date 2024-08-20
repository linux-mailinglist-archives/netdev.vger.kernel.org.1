Return-Path: <netdev+bounces-119988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F261B957C4B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DB01C23DBD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EE1537C7;
	Tue, 20 Aug 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5rgA+1u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379E14A4EA;
	Tue, 20 Aug 2024 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126957; cv=none; b=odSoAWTnZqHUL8pDhTEf5l9pMl9LFo/HCHQBiP0EOZ+wHn5PgU4lgXFaRzJqBKe33CbhqmRXZD4gKGCl7bAsJdJCL6b1aOniU3Og/COUlcAq8/70ThCP/WFtdfW3Th3ieZpR2ZqQKe46nX4HMOK8ddSHF7u4pMd25IDZDec+oWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126957; c=relaxed/simple;
	bh=qRPnWBN+aRkuCOCgKm8uViF3Giq/poveOpR1CdqWrMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puWh7+WeqG5/JUsVC70dJAa/cnnkIeZVE7AHs3xqF2pDNX4gfCXLV5LYtrUqfBRAmZqNf7DZjzb79aWXgmx6OrPVsHgD69kqc+dH1XC0B0NEOTzyKzgoSUmt3fpSAEoFhAgTNZhRt0rFWjlpJP2EZd9B2Mq5K9zP8uatZMs+2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5rgA+1u; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso2931625a91.1;
        Mon, 19 Aug 2024 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126955; x=1724731755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkieDk+FChNj9tKCMLqWBbRnnkZ4Xuwb4Wx7nlGq+Us=;
        b=P5rgA+1uy2JfFFO1LdVYGgYDRNMJuvsooRkEzPYBiS46gYvJm615z77nhFttiLu3/a
         o1b3yS8xj6PgCLpVAhi+DG3hoyt5a4uUgmyz9CqLT8oFHDKiMkZB7KgpQ8oH3oCrASbk
         C+p4XrSvjst50UH6yYebcTLicfZPcdAndPOTgvE0XqznsUJ82TZFTbCdyauEL0bFbXNH
         /27lHGI7pG5lht4N3CS8vbJfA9bbLngLKvWwOedxir2jGVWHC8uvLlKohkzeXgfr3Rmz
         CWalJGy3Ffs1tUsLVyRlB7ktjE/SglI9HZgl9xq6xUoaMElbbTQ0nWHWXGWB8fv9IVMN
         ySeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126955; x=1724731755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkieDk+FChNj9tKCMLqWBbRnnkZ4Xuwb4Wx7nlGq+Us=;
        b=RNq6WaYY/dRN9w717osLlmInwKZXXTDELLTGMteNhPEOr7Jkkd+ObSPMWCPmaiVU5V
         jN8ob1xgSKtaWOGugxxYZWgLfeTHQo3R61Zj3RgzQJc8Xi79qbwEZcqQYLnGFNx/y9eK
         SNB19hQEdOz+lNsGdIxvuq5enLaw3Ad9txmCVKplw9nd7oPwqDMAEfRL1kdhSNr1Bikg
         VjgpCle7kEQoXtY4UUbYrGUs8yQG7m4dKtvm0ccN106uKLQkMtaUml2/wCgoDPw01/ix
         79SfebQ+ORxtOpMLIhxeC7uiq7/Zl+ArM9VEIWTaBpvge5Rwgn+/9SBshHnljIwxa1ek
         +oIg==
X-Forwarded-Encrypted: i=1; AJvYcCUW4k3Vm1b1xQ29nsD/y1eHZFIe8ui1bfXuE7WpQGy0ixG75yuCgH4By3Frs+5C9QY1hUtNJ4dnzKKWmPQ=@vger.kernel.org, AJvYcCW6GXSf1iU1sNAzCz8N4BdZ5OA6WSfgLCVz07zCVvF6lmTZXbrlJfTH5M63Cspm7Lu9s9hT/JUK@vger.kernel.org, AJvYcCWeEHCP3+k8CWlvZOUfnRpkWZfLLkjt8mcrVVrF8lxvGdXCBs/b4A2yYGiSmAJW70ua7QI9fGv/Wd+UF9u9OPDyUU7eHn4a@vger.kernel.org
X-Gm-Message-State: AOJu0YxJF/331SpPe4u7Wm7xxWhwwGeHl2LkzGOW7CGj7wRPWqcU692v
	p8pcsnooyWZk6E0hmlgf1s5J3VF8Dx7h7OgZhohoN+iY0v8sSfO8
X-Google-Smtp-Source: AGHT+IG2tkC7cclM4VN1VNh+HlN05uhyYyM4ch38fJSYPmGuUzykPsvhWAQFTSjytvBJ7vojTHPBsg==
X-Received: by 2002:a17:90a:d904:b0:2d3:c5f1:d0d9 with SMTP id 98e67ed59e1d1-2d3dfd8c5b3mr11955322a91.25.1724126955208;
        Mon, 19 Aug 2024 21:09:15 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:14 -0700 (PDT)
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
Subject: [PATCH v10 6/6] Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI versioning
Date: Mon, 19 Aug 2024 22:08:56 -0600
Message-Id: <417c242b839740d5409798b5becba183d4956dab.1724125513.git.fahimitahera@gmail.com>
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

Introducing LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET as an IPC scoping
mechanism in Landlock ABI version 6, and updating ruleset_attr,
Landlock ABI version, and access rights code blocks based on that.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
v10:
- Update date.
v8:
- Improving documentation by specifying differences between scoped and
  non-scoped domains.
- Adding review notes of version 7.
- Update date.
v7:
- Add "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" explanation to IPC scoping
  section and updating ABI to version 6.
- Adding "scoped" attribute to the Access rights section.
- In current limitation, unnamed sockets are specified as sockets that
  are not restricted.
- Update date.
---
 Documentation/userspace-api/landlock.rst | 33 ++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 37dafce8038b..89a2580a2bbf 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: July 2024
+:Date: August 2024
 
 The goal of Landlock is to enable to restrict ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -81,6 +81,8 @@ to be explicit about the denied-by-default access rights.
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
+        .scoped =
+            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
     };
 
 Because we may not know on which kernel version an application will be
@@ -119,6 +121,9 @@ version, and only use the available subset of access rights:
     case 4:
         /* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+    case 5:
+        /* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -306,6 +311,23 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+IPC Scoping
+-----------
+
+Similar to the implicit `Ptrace restrictions`_, we may want to further restrict
+interactions between sandboxes. Each Landlock domain can be explicitly scoped
+for a set of actions by specifying it on a ruleset. For example, if a sandboxed
+process should not be able to :manpage:`connect(2)` to a non-sandboxed process
+through abstract :manpage:`unix(7)` sockets, we can specify such restriction
+with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.
+
+A sandboxed process can connect to a non-sandboxed process when its domain is
+not scoped. If a process's domain is scoped, it can only connect to sockets
+created by processes in the same scoped domain.
+
+IPC scoping does not support Landlock rules, so if a domain is scoped, no rules
+can be added to allow accessing to a resource outside of the scoped domain.
+
 Truncating files
 ----------------
 
@@ -404,7 +426,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access
+    :identifiers: fs_access net_access scope
 
 Creating a new ruleset
 ----------------------
@@ -541,6 +563,13 @@ earlier ABI.
 Starting with the Landlock ABI version 5, it is possible to restrict the use of
 :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
 
+Abstract UNIX sockets Restriction  (ABI < 6)
+--------------------------------------------
+
+With ABI version 6, it is possible to restrict connection to an abstract Unix socket
+through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks to the ``scoped`` ruleset
+attribute.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.34.1


