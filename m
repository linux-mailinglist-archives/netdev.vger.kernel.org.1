Return-Path: <netdev+bounces-118952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5D2953A20
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAEE282105
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFED6155A3C;
	Thu, 15 Aug 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJywlqJE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D851552F6;
	Thu, 15 Aug 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746590; cv=none; b=hsBBxDN8mEJBFw3elcF8DYLlP6GLOrdUDKCez8KVlI+fGreYzA7at9lfJaKl9Fe5Fq37HgSpFCPIq/d5ShcHnvZRp3YKh/Saq7soiXQFv4HEdZwcN5HEevQ2UCv7VFor4UKebzakETv9g3wka2jnYFzipOwLGEvoBKqkqbFNpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746590; c=relaxed/simple;
	bh=t0Enpj60gfN/JUE7bk8p4OI6mGC5hHGB86LNVGrDQfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/Sbjcm7v3NwZiGoqn0Kl7iHi7iKc6NIc++sD6WWkO5v2qT128VtJFbFp0fL6WU7JfQ39sEHRPZy4B0DX1RDaj9Pg8mlqpvZMEX4IAm9trJGlSdW7MLdSGyBF9w8j9V/5JoNrcwbqCoePlt7TUy57NebS2Y4EnJbu5Xo4q1WR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJywlqJE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7104f93a20eso1033346b3a.1;
        Thu, 15 Aug 2024 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746588; x=1724351388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxWGhsb+sltdlCEsK0/J2MWqc7UN/0sEwhlAO7H6tHA=;
        b=YJywlqJEFxwhGa9o0Fo1y+MgiamqafugrTJfJGrUpQPgirK/H0TBPh3bgN3l9024ZN
         /zr37Ql+7/YbkG/+S5RqY+oKhQjfBCk89VN5/gpU8oACeQWbB0IMAvdlzMqVUFOgYpHD
         LVCXl1X0MFtjeSgNOy77eR78pHVSpoCtqBfKKhfdJDgVmq8uSlBb8vqeEsCXXXw/knCF
         CxBNBI8b7GQbyYI+iFDvIQnZ4CMxbIqRztcrRVCoJYMvFcExotTOfTY4N8yCdG74ZdXl
         KmSlQOM7PlbXF35y9mATlfkIAoBMKPoXbaFOwuAyLmc/fh6yV83JlIO8GfhqIVxAUnuP
         BNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746588; x=1724351388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxWGhsb+sltdlCEsK0/J2MWqc7UN/0sEwhlAO7H6tHA=;
        b=WzXzNbtoe1zTWrruU/ML+vvW1cPkREPEz1QOxW6O+3/Nsl1rIwNSkF7rb5b863gEHS
         XLId/niFG6q2K50NgG361+4OaB3jj9iSPUMYF0AEcH4TTO6ME8HaJPvgyIFbiaAANEwE
         aGfMXIRD+CDsAzCtbohKTRjXfEdC3CZHGnr7jLS9qtaHZXL2VEGbWNCyasnsEWmw03AM
         iq/Lbj0fO0HRTXRPmT5wAH9u47TwucQX2Ea82VfK1W24zEedZz3s+S67zZM2teZN/mYl
         zbi8AMlzWTXWi0WGKl4iRQND+v8TUiwVA7NS6bYBxg04VcpbBGdyWSEs/FqgFSmH8ek0
         bFjw==
X-Forwarded-Encrypted: i=1; AJvYcCXXjRgEp86OSrakHzlFa4o7BwF8CjRY4sLyqoTkAJhxsweJX7ZvG+fgv3HMWrgrFzBe+l4hc6yrq1OLJLh4jFpZHzsMl6k5VQeJVGYI3Zn9Hx8sWVGpqhxIQFwt9j0ZZuA/y5qkFuZHsIPhIihYZvFE9NK/2vENp3MJcd/x5qqYPpxXa7EQT1Cay3WN
X-Gm-Message-State: AOJu0YxWc0XhYo5L6Q3Gm+i92cqJDSiz3yfhwp1Srf8mVLt13cT5kzUf
	cb6Dg/YSBunv0luih8xHXgWd6oq36CwcJpfHEqNO2vkfPiH3pmxg
X-Google-Smtp-Source: AGHT+IG/FIFxbDQQiPJFjK3IdEie5/2+FB8s8IL4SwTgKWmuvq51aGA0+c8ITA85FRX/ms6AUpHPsA==
X-Received: by 2002:a05:6a20:d806:b0:1be:c2f7:275 with SMTP id adf61e73a8af0-1c90506d709mr505004637.50.1723746588057;
        Thu, 15 Aug 2024 11:29:48 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c76sm1431683a12.62.2024.08.15.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:29:47 -0700 (PDT)
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
Subject: [PATCH v3 6/6] Landlock: Document LANDLOCK_SCOPED_SIGNAL
Date: Thu, 15 Aug 2024 12:29:25 -0600
Message-Id: <193b5874eab4dca132ae3c71d44adfc21022a0ad.1723680305.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723680305.git.fahimitahera@gmail.com>
References: <cover.1723680305.git.fahimitahera@gmail.com>
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
v3:
- update date
---
 Documentation/userspace-api/landlock.rst | 25 +++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 0582f93bd952..01e4d50851af 100644
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
@@ -319,11 +321,15 @@ interactions between sandboxes. Each Landlock domain can be explicitly scoped
 for a set of actions by specifying it on a ruleset. For example, if a sandboxed
 process should not be able to :manpage:`connect(2)` to a non-sandboxed process
 through abstract :manpage:`unix(7)` sockets, we can specify such restriction
-with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.
+with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``. Moreover, if a sandboxed process
+should not be able to send a signal to a non-sandboxed process, we can specify
+this restriction with ``LANDLOCK_SCOPED_SIGNAL``.
 
 A sandboxed process can connect to a non-sandboxed process when its domain is
 not scoped. If a process's domain is scoped, it can only connect to sockets
-created by processes in the same scoped domain.
+created by processes in the same scoped domain. Moreover, If a process is
+scoped to send signal to a non-scoped process, it can only send signals to
+processes in the same scoped domain.
 
 IPC scoping does not support Landlock rules, so if a domain is scoped, no rules
 can be added to allow accessing to a resource outside of the scoped domain.
@@ -563,12 +569,17 @@ earlier ABI.
 Starting with the Landlock ABI version 5, it is possible to restrict the use of
 :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
 
+<<<<<<< current
 Abstract UNIX sockets Restriction  (ABI < 6)
 --------------------------------------------
+=======
+Abstract Unix sockets and Signal Restriction  (ABI < 6)
+-------------------------------------------------------
+>>>>>>> patched
 
 With ABI version 6, it is possible to restrict connection to an abstract Unix socket
-through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks to the ``scoped`` ruleset
-attribute.
+through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` and sending signal through
+``LANDLOCK_SCOPED_SIGNAL``, thanks to the ``scoped`` ruleset attribute.
 
 .. _kernel_support:
 
-- 
2.34.1


