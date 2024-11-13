Return-Path: <netdev+bounces-144556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9D9C7C32
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F471F22A12
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110C204947;
	Wed, 13 Nov 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUDQgI3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707631FAC53
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526369; cv=none; b=Gi/cCnEAeOdJxpjnylE7lGr+FVVlF0oDVYEXpo40qYHCqeSvwVvaP8irKIMKwmbHcY3YU2FbjAKLawHl/2V0hcEv7bUOeWF7u245BCfqhHrK/gYVbRRW1wuqF0GPKWACwMq9I7cP+YZKmNdKf0YEHCqEwxmqHxqZ5NumfoILiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526369; c=relaxed/simple;
	bh=Pk2z8EvkCIjNI4X29FMwpG2/sl7k7tzx6sXUrnUChXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXoQTaUhGLhi04QsdCJW7uybR28olXOzlfnqUds9S6cwbYs/ygkBrarGSCFLvLH4HgfONndDkUwpHl/tdmhy6qMsLaQoWM6iJvj2THxbdFkq35DmfjGXfFFnrG7DregZqRAkQZSKYsKkco05DhMcCS42cwufa8Ie9iXTvb5Boyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HUDQgI3J; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72467c35ddeso21034b3a.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 11:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731526368; x=1732131168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TlbuMhMpbQZuWcS8taAW5rJrc34QPHtVjPTbOGsu6u0=;
        b=HUDQgI3JWn3Jfi6LLtwqC7nfWODalECz0jGASmWZ2ES6jpnpMwGAT3PXly6LmtQZuf
         EthAG+GKL8baoa8DS2Jp081uxw+Ys2I16fcBmDms0LEsc2kUQ92goAqJncJHwS4OGAB9
         sNgCDBu62fzKbt81W1rVj1R3grA7T0tnSGU7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731526368; x=1732131168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlbuMhMpbQZuWcS8taAW5rJrc34QPHtVjPTbOGsu6u0=;
        b=mMlHYHl5uH0T4C5PaQfmPbjICzIUo/J7uGL5tTsTXIs8/Ay7wd2CDE6K/XIT/3hh+z
         nfCmRg9SuS7HnJAlIkbs0MKEVY4vOP3mxonhlsWuLd7qspv8AszYoZNNXCiSOwtjN6jo
         /Tm6sZ7znztYba/smaVzrcxw1KGK5/2a4cZ1TIjLIg6SV7yX2u6D9aYayB8qT4I+Iy+g
         hZb0BD5pQ/VvJ6Vub6lazgNOT0vHp1WTs7ENN5rJlpBLjqBKaFJYEqfy1eYlkeTlHofQ
         ylMSLfxmwAuLbC+VNPswDiirIReaphqqyMjaqTwRXebHYl2tplGjSA+JM1FPvWOntF/F
         SByQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/SZ31X/H0lqg1GSTHV5d1rbEsJ1OKrDG4m/S0ZKdNpvr+jlwo+M94Vj1y+HXWosjnH2UomMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY325aziI2dn57Dsk3wt2gqN0MpqPp8aAVnChm/9tqYSXZbcSk
	U2sg59FiyMt9YFK2yM4g3dFUXLf4YqpGlb6MZzbq84XddD1Q7gE40yR1R9Yi1g==
X-Google-Smtp-Source: AGHT+IGBIzNEEvDaSKFHyP9PUw5cpI4u/07UJ7DgR2EYmMzH58hiQoqiGp4uo+5tX8uOf4kl/WH7Rw==
X-Received: by 2002:a05:6a00:23c4:b0:724:6757:7d95 with SMTP id d2e1a72fcca58-72467577f3bmr227272b3a.5.1731526367596;
        Wed, 13 Nov 2024 11:32:47 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (51.193.125.34.bc.googleusercontent.com. [34.125.193.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72463e72282sm630883b3a.119.2024.11.13.11.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:32:47 -0800 (PST)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH net-next v8 0/2] binder: report txn errors via generic netlink
Date: Wed, 13 Nov 2024 11:32:37 -0800
Message-ID: <20241113193239.2113577-1-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

It's a known issue that neither the frozen processes nor the system
administration process of the OS can correctly deal with failed binder
transactions. The reason is that there's no reliable way for the user
space administration process to fetch the binder errors from the kernel
binder driver.

Android is such an OS suffering from this issue. Since cgroup freezer
was used to freeze user applications to save battery, innocent frozen
apps have to be killed when they receive sync binder transactions or
when their async binder buffer is running out.

This patch introduces the Linux generic netlink messages into the binder
driver so that the Linux/Android system administration process can
listen to important events and take corresponding actions, like stopping
a broken app from attacking the OS by sending huge amount of spamming
binder transactiions.

The 1st version uses a global generic netlink for all binder contexts,
raising potential security concerns. There were a few other feedbacks
like request to kernel docs and test code. The thread can be found at
https://lore.kernel.org/lkml/20240812211844.4107494-1-dualli@chromium.org/

The 2nd version fixes those issues and has been tested on the latest
version of AOSP. See https://r.android.com/3305462 for how userspace is
going to use this feature and the test code. It can be found at
https://lore.kernel.org/lkml/20241011064427.1565287-1-dualli@chromium.org/

The 3rd version replaces the handcrafted netlink source code with the
netlink protocal specs in YAML. It also fixes the documentation issues.
https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.org/

The 4th version just containsi trivial fixes, making the subject of the
patch aligned with the subject of the cover letter.
https://lore.kernel.org/lkml/20241021191233.1334897-1-dualli@chromium.org/

The 5th version incorporates the suggested fixes to the kernel doc and
the init function. It also removes the unsupported uapi-header in YAML
that contains "/" for subdirectory.
https://lore.kernel.org/lkml/20241025075102.1785960-1-dualli@chromium.org/

The 6th version has some trivial kernel doc fixes, without modifying
any other source code.
https://lore.kernel.org/lkml/20241028101952.775731-1-dualli@chromium.org/

The 7th version breaks the binary struct netlink message into individual
attributes to better support automatic error checking. Thanks Jakub for
improving ynl-gen.
https://lore.kernel.org/all/20241031092504.840708-1-dualli@chromium.org/

The 8th version solves the multi-genl-family issue by demuxing the
messages based on a new context attribute. It also improves the YAML
spec to be consistent with netlink tradition. A Huge 'Thank You' to
Jakub who taught me a lot about the netlink protocol!

v1: add a global binder genl socket for all contexts
v2: change to per-context binder genl for security reason
    replace the new ioctl with a netlink command
    add corresponding doc Documentation/admin-guide/binder_genl.rst
    add user space test code in AOSP
v3: use YNL spec (./tools/net/ynl/ynl-regen.sh)
    fix documentation index
v4: change the subject of the patch and remove unsed #if 0
v5: improve the kernel doc and the init function
    remove unsupported uapi-header in YAML
v6: fix some trivial kernel doc issues
v7: break the binary struct binder_report into individual attributes
v8: use multiplex netlink message in a unified netlink family
    improve the YAML spec to be consistent with netlink tradition

Jakub Kicinski (1):
  tools: ynl-gen: allow uapi headers in sub-dirs

Li Li (1):
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_genl.rst    |  96 +++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml | 108 +++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 287 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  39 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  27 +-
 drivers/android/binder_trace.h               |  35 +++
 drivers/android/binderfs.c                   |   2 +
 include/uapi/linux/android/binder_genl.h     |  55 ++++
 tools/net/ynl/ynl-gen-c.py                   |   1 +
 13 files changed, 666 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/android/binder_genl.h


base-commit: 31a1f8752f7df7e3d8122054fbef02a9a8bff38f
-- 
2.47.0.277.g8800431eea-goog


