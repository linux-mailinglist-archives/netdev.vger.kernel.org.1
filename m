Return-Path: <netdev+bounces-118333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7BF951476
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67EB286C12
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA213D8A4;
	Wed, 14 Aug 2024 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TssGwZm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036513CABC;
	Wed, 14 Aug 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616586; cv=none; b=X0o1b5dwsWeb6Q5U8p4FVZJxjfziQqQ2H8uc8XU8yA+RUM9DNnL+ZgP4yasVQB9UU15ieKsGvgQFFwo4+yGgFWvqNvkU+YAySRqms/h0kVaVAqWz3CreqY8J0JkTTd5l+XZhfAZIaFaSW8wcP2TGUgY4ezNZfGkKQEfva3opSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616586; c=relaxed/simple;
	bh=WbizJY1JUcwczi5iymZY7vyl+95kV8i1U2PWaG0v9Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk/vWUL8doniaLYAYQg6V14nobbGaSCGK/f/gV/+Z/Zd7EUgDTcBp/bvgcs5rV1hGjwRQwVxnsy42O5shm4EPoEhR0qgD6azFcey7zebrIicRSWmZ1oJ+IEHs7AFyCXLcHMI3x1300HidNOZLGtpZK5njnA6rSKxJra0wXPxXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TssGwZm4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso4906143a91.0;
        Tue, 13 Aug 2024 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723616584; x=1724221384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOXF/mk6fi+su1BZXevEKau7aDc4101e4pARIviEtYA=;
        b=TssGwZm4sDfr81ZRNSsl5YguQ0972GJsHfh3Xe2+5xAMeZ/QSPjHDdmfn2FyI5T+hO
         Z6ihG3ZO6F4oy7gbDcO66izQst+b9V7Khj4G74VOaBuHFXRaNCVvW0PQMqEloshXb1NI
         7Lbwj0nU18NoIBRCgObtKZjJhxW/O4j1nizJe3CzcUTil5aizXitqNy1a6ivgEPjKzyW
         JGzRxMSN5277zkXSGmur35/pnLMIL/VV1CRYezEHbY72eLTH8ruSPkSdpRdtm4X6+q3z
         T5UKnHmpiddoeWAkMI08rUpj5WnrtTNe0lYzmv9QHdDjZD7xjpFvT3dQWMf2dY81lPRm
         kYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616584; x=1724221384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOXF/mk6fi+su1BZXevEKau7aDc4101e4pARIviEtYA=;
        b=HNssGOieco/ke5Hem9u1uq8Iq9y4DZoTg9nqXzWleMzO47QujCCeE08mQnDa7XWGDO
         Zl3xaWcDOn86poQkbbzed3M20vaNtVQHU21A8/gslJ8tr4tBsoMWUbdsJgxMLvuasWdr
         bM9QEBkS5El6a3rcTqTk0BwtLdMuPQ1w6MHrihO/LwA9TZH6fqxeZKlMEPFmJXXZBhIU
         P9LO0PE7LD+/N8J5cpC5OQmwbPnvkACuRW3r3UDudYt2bX2mgR3vrJVKv049JF5o/HGr
         +YSenTF+MvAKiPSpbcX29LvPoXZsDL2KqTLeSUWIobJXX7AyUYeJv63AVyyG8/GkeR1J
         U0xA==
X-Forwarded-Encrypted: i=1; AJvYcCU/2polWqdJ/WbRiFQvUNUm9dw8vkJnXlX09xVc/lif2s5M23i4ZhxFsiB2kvTx69eNDQY2plcgX1XcR6UoVHJw5r1F/z5Wc1u6FBwU06FQxRUmxPubFV/e+uC78TteZYviBsyL6v51dSdpzy9m23kW3Nu4TJYtMtsB8JelSFbzdfovt1Vd5phLeMaV
X-Gm-Message-State: AOJu0YwO323au1+57KoLZVh8EweUWUv2F0lXuTa0ZmCFJSBRDMtsOv3t
	8zGljqnanhIhKZmdhsGOjmqiFqo/K7sSUUeI9BSOMGalMgI52ove
X-Google-Smtp-Source: AGHT+IGnacH6xdXHc7HMG9kQdrthisEdqyOEUd8elau0NzGFjqqKSMK6zwmrSwuMifeckUn+hbb+kw==
X-Received: by 2002:a17:90b:1811:b0:2c9:7849:4e28 with SMTP id 98e67ed59e1d1-2d3aab43815mr2191088a91.27.1723616583775;
        Tue, 13 Aug 2024 23:23:03 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2120sm728811a91.31.2024.08.13.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:23:03 -0700 (PDT)
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
Subject: [PATCH v9 5/5] Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI versioning
Date: Wed, 14 Aug 2024 00:22:23 -0600
Message-Id: <c70649f74688605f31ab632350ab77d2a4453ab9.1723615689.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723615689.git.fahimitahera@gmail.com>
References: <cover.1723615689.git.fahimitahera@gmail.com>
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
v8:
- Improving documentation by specifying differences between scoped and
  non-scoped domains.
- Adding review notes of version 7.
- Update date
v7:
- Add "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" explanation to IPC scoping
  section and updating ABI to version 6.
- Adding "scoped" attribute to the Access rights section.
- In current limitation, unnamed sockets are specified as sockets that
  are not restricted.
- Update date
---
 Documentation/userspace-api/landlock.rst | 33 ++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 07b63aec56fa..0582f93bd952 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: April 2024
+:Date: July 2024
 
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


