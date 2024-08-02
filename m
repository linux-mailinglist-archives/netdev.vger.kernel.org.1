Return-Path: <netdev+bounces-115210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD89456D2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3487285F49
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2EF4655F;
	Fri,  2 Aug 2024 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="larFFRCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F1335C0;
	Fri,  2 Aug 2024 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571394; cv=none; b=gXnGHoF4A0dR/XCRDah56sm0Ly2iyF9IGtjkaBPq4Sqplgn6NqC2pZumKZ4ZdsE2wMj9sgY5O15KDIu68EPDigVIiWUyobh5DdW3unlYybH/qaSp7zcLApeoW2xWGPSIUpGVJmXmvOO1KoniVHP/QGdtTOH0EGLcvEalbwMdIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571394; c=relaxed/simple;
	bh=a355BilX6jKKKj0H6k9w/Vm9ilkMy24RIIwkHdsbVvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihS/Gu4ID5xlkioaTBMXGDbNt/4XPugHAF4vlLzSU1wyP7v5wFyfsAB9TW56DhvRalUv23xRdOhCERmm5f/05qf5vWtsC25SCxl0pogdhmZa/yPMp2S/olra36tCoO18I70VLPuW54odNMwQp4l4vcdxC3J5ejytVzMNqifGk7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=larFFRCP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so6813881b3a.1;
        Thu, 01 Aug 2024 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571392; x=1723176192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRxrTMmH8N1DYXk4ty1+L/H8I5vVdXfCPChLU7yZPwk=;
        b=larFFRCPvQdsIUblDOZqXKYZcuUHAviGiDFyQ0/PEl/OunbZfuqJdpf/oaQMcQdnot
         Zbd+k0ciTXKDf1ILtRTnZLexCEVaf06mt05pclngL3xAQYgAERuCd/1HEe8rYwo4NdDT
         GFz424LSWmHCNJrfLOfnAO9o1oe0nREkZ/w4SLnW//1NJapRw/NO6W+B3/VdRcD2Xi3n
         fxLYsbn/BwDBO6U2yCXZhzkYnV0wDimdlb4fa+0BTOteiRoaAg9Neg5X3KNvnK18M2M1
         8p1PjO+EgD/nFMcFZU7e+XkGQod1f46fJSlH+msNDJrjVgpuWlGOenbYQI68yRoLazJA
         cYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571392; x=1723176192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRxrTMmH8N1DYXk4ty1+L/H8I5vVdXfCPChLU7yZPwk=;
        b=snWfRbi2PbKcVDxHVpEIbvpmcwGYTlpskiZAw8NZyGpNCDu8OixxEwmsHEs7vifmcI
         vx3rFZDv9VHezeyZK2t3NUAeG6WqP91zzcg2HuDgY21/gxKeZo1SQj0TtZSiMZUG0BzD
         2AceUXe89urGOKVTNghDtC+ZMglevnMo/wJY8cbDO4DTe0G+GBVVkg8pGrcE8itXMJDZ
         M2EhYGTni9D6+4gDjSv1k/VRN5c5rowRI/DeusS61j2a0SkRawZNcDFgJgRy0HuMhLSa
         cdakrljtq+ZpWnp6DksXlYZ/fqEQe1tlkMnQC3AJLPCdXx9hLcSHmg6zezUEDGroelIe
         8vFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2QXWqqLjf+sW9gAHky9+9GlXJgip3TC74OCcrm3fdx9Ar2qUYOTSp8WejxxL8pekqkw4sqRcQzz003DOZYoi/Ea9NmL/fTNSj3xmAqeDO9cNsZDEaj5F1tuWppgJwH8yVL+B7V4bsh83pYRZey703tROokPjCJ18SuIi8+u0XZs7rs5Wo0mCbq/B4
X-Gm-Message-State: AOJu0YxxUXkpMCJ5sjy1mpx3H9/pWgoxBZ+3oBnEoyPi4i/zVYrO9u9D
	yQ2IBSGEuo2+tU1xjf4eWfg12M+MyJHhrvGFdYLeBs1jOJKCLfUK
X-Google-Smtp-Source: AGHT+IHktciSu4iKx7zcFVbNktYsYHY4XS0+bl/4S7s7XP2g1yKVjzJEwtc7zwtohxGC40IodBPXDQ==
X-Received: by 2002:a05:6a20:2444:b0:1c3:a760:9757 with SMTP id adf61e73a8af0-1c6996b9b49mr3523239637.49.1722571392202;
        Thu, 01 Aug 2024 21:03:12 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec41465sm542099b3a.60.2024.08.01.21.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:03:11 -0700 (PDT)
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
Subject: [PATCH v8 4/4] Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI versioning
Date: Thu,  1 Aug 2024 22:02:36 -0600
Message-Id: <bbb4af1cb0933fea3307930a74258b8f78cba084.1722570749.git.fahimitahera@gmail.com>
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
index 07b63aec56fa..d602567b5139 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: April 2024
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
+not scoped. If a process's domain is scoped, it can only connect to processes in
+the same scoped domain.
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
 
+Abstract Unix sockets Restriction  (ABI < 6)
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


