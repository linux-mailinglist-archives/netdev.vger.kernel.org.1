Return-Path: <netdev+bounces-151551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869479EFF76
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C062862D5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F71DE3C8;
	Thu, 12 Dec 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OTNZZ7UN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2319CC0F
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043284; cv=none; b=cImw7Qp5dPjmzAKWKfaxrmbh8U+FNJCycY5FgsODbYS2c+9XCak9ewUFFRKkPqmlK7F/6VZbXEPWjt7p3A3mE6zgEqMU8be6ptNfyK+b/xCN/KTZ+2hvo+7mvXtr96g91tQlbYwaqR5F4kmiz2rTORhiBjKimnTZKu9ft0lmIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043284; c=relaxed/simple;
	bh=8ClgOEgT3jd6G+sJkrPg87LD8FC4bv7uHW/b45NmqDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mw7alXeVf7gtpQ0gUA/Wlp//f4dgimg8P2hLkaSg0YmjAgYJkRvMBMV7pyxmcx4dRq+Ei81OAmN15k6cpXSiBtTVyUybiW0MXY2LbqjmHCkgBRzAd3Ij46fkhRuHcaxRbYuiDF4QZYgvXESOxAx1n56qLz/HMRCQxOo1APUQFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OTNZZ7UN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725e71a11f7so1839082b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734043282; x=1734648082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkHEwhmq9gflzoNZZZqtaRi1lU7YO3D6W3U/YdC1pRI=;
        b=OTNZZ7UN8BIZPVND+89WYWCKoRz/9DorhKmAEZbPqV52VW81XmVSPAHCSyqdbjhHUB
         /y9Ec+DKH1SYlWGN06XtjQ7wqolg0fgrWX6Fc492jN2umPeUb/CM0klKJu/pWsZZoGFp
         9PzMResIUALA01R7NMP22QDqg+580cyG+nljA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043282; x=1734648082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkHEwhmq9gflzoNZZZqtaRi1lU7YO3D6W3U/YdC1pRI=;
        b=CDDVrUgcIScBrH9j3VZtAJjvZ2wbAIp5huQ+mADGAb1irc/YbGCcqmw9i3KKwpHhDG
         AWfmIAzNIyPt9rQYNh5hgM0xpSTH42OJJh0egR3ogGnlIgSW5YRQ06sHohSztZawbNjZ
         VKbRP7VUL9nEhDBL3Ko1KOBuNjb4RTm+VpMx2D6rEL9tTXKrzp4ubw3dxMbvLnm5yyYI
         NTFB1TJfZtS8uYRcQIzzJW/2cQobFbsm0JkdAK8MEO1qNsfoA0FE5d110YBnPr79Y66Y
         WAdjVM/Ndp5+/CqQAuG9Jq6J7Ij+WNuL5nTuz8+ZVtk5MFMuk54IbtpOnyuR1LWIZR4r
         b9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXj7UWLENzA+nFWwTYviLNxmqUbf+txv6Qc0QaWhFysXQ5nwCwZFwMds5ntBhtBK0Zpl0JUckE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJwOUGdsViEsh1SHlyfccng9QuyGMln23JrAKJyYSKMB6tEVV
	4/LSV/pNNjLAm2ZoDrAyuGIRq40wl0xmhxDwi+OmcQgH8y25hl/Rhveh3f4BaQ==
X-Gm-Gg: ASbGnctSgL5hWh/eYv6gG8UW4zkSw3pNUUbo9ceHAdDD8rQY+3GGlk8HaMF+luaUSOg
	FfaK8LoCP/I2kxRuPt3RHGTvpHWVpcEtqfzkqHw1wu1hHY6Hs38nYXKULAzLJqT9949BBESF5oT
	qC7S0CBLPpxVsmyd0ebJhbPwOgpbeO6s97XrP82o41z3iwp1HZS6P7GgWHhI1vawDLdD/RL0uHy
	CFMbrKsD7MkRJeqeSS+AyJqdtgC1Om8Po9HvxbVzapJipoHH5hPkIjRotcJkAJVlL+vtdn2innl
	GEajs+/H9vrI9xXiZqKJjFtysKoFAIqspZ4zJAOvC/dLkg==
X-Google-Smtp-Source: AGHT+IFg5b72WIMC/OjNdzMkLquvT4+Hz+oz5yDLZIulCxie6HrtA8ZZ4UN4+iqyZTb53UA1F2obSg==
X-Received: by 2002:a17:902:e803:b0:216:3f6e:fabd with SMTP id d9443c01a7336-2178c7d4eeemr76700255ad.7.1734043281979;
        Thu, 12 Dec 2024 14:41:21 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (200.23.125.34.bc.googleusercontent.com. [34.125.23.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216281f45a2sm98579785ad.250.2024.12.12.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:41:21 -0800 (PST)
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
Subject: [PATCH net-next v10 0/2] binder: report txn errors via generic netlink
Date: Thu, 12 Dec 2024 14:41:12 -0800
Message-ID: <20241212224114.888373-1-dualli@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
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
https://lore.kernel.org/all/20241113193239.2113577-1-dualli@chromium.org/

The 9th version only contains a few trivial fixes, removing a redundant
pr_err and unnecessary payload check. The ynl-gen patch to allow uapi
header in sub-dirs has been merged so it's no longer included in this
patch set.
https://lore.kernel.org/all/20241209192247.3371436-1-dualli@chromium.org/

The 10th version renames binder genl to binder netlink, improves the
readability of the kernel doc and uses more descriptive variable names.
The function binder_add_device() is moved out to a new commit per request.
It also fixes a warning about newline used in NL_SET_ERR_MSG.
Thanks Carlos for his valuable suggestions!

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
v9: remove unnecessary check to netlink flags and message payloads.
v10: improve the readability of kernel doc and variable names.

Li Li (2):
  binderfs: add new binder devices to binder_devices
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_genl.rst     | 110 ++++++++
 Documentation/admin-guide/index.rst           |   1 +
 .../netlink/specs/binder_netlink.yaml         | 108 ++++++++
 drivers/android/Kconfig                       |   1 +
 drivers/android/Makefile                      |   2 +-
 drivers/android/binder.c                      | 242 +++++++++++++++++-
 drivers/android/binder_internal.h             |  29 ++-
 drivers/android/binder_netlink.c              |  39 +++
 drivers/android/binder_netlink.h              |  19 ++
 drivers/android/binder_trace.h                |  35 +++
 drivers/android/binderfs.c                    |   2 +
 include/uapi/linux/android/binder_netlink.h   |  55 ++++
 12 files changed, 637 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_netlink.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h


base-commit: 6145fefc1e42c1895c0c1c2c8593de2c085d8c56
-- 
2.47.1.613.gc27f4b7a9f-goog


