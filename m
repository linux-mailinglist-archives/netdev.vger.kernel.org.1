Return-Path: <netdev+bounces-53677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CD804151
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFAB20AF5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C039FF4;
	Mon,  4 Dec 2023 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njD8rQJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67DCB
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 14:07:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cb6271b225so79002537b3.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 14:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701727651; x=1702332451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+2JhzqiOkdQh7PrR86fzViHeodIIDTXW1Ciu1FwU2j4=;
        b=njD8rQJMUKijFiydzI3XJ+Fsa54Kwa39xMxcPehGlEkH/bdkOif43CxhEzasrGQorH
         M+eVd/TrYg9QVcFla8GNjQ4bCHKSv9IUm20Ps5jgfKe1VFTwNKUvxg/vnfMB63ce0oY/
         hP4Kb/dF8XQkxeOiBI+AJ1xdla2hkVfvPI0a7BUvxPIe4+zzlNnmTMGP4qVFWEwpDdCC
         2PXZHxQgeccjczTVOzTU1Hslz1dOpKjroMXaT2rvS7P3WkyLUyIls3uJA3O6e4AAJOn8
         8LYEm8t9QZLR/Q7hMg1+QrPaVMkjRROpXOrXpIv0cRucNQDQISZ1weuaJ+7iiCRBkdE5
         thYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727651; x=1702332451;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2JhzqiOkdQh7PrR86fzViHeodIIDTXW1Ciu1FwU2j4=;
        b=B7HypyPHj2Ol5QKPPpye5AzlQEpTyE1qsX875ld0TrdN/FUWKGHpC8mOLGaW5EO8QI
         xZGKd6DPJMp8dDdMuvA6scmZNfyAqUHn1pG901+05/9VwCgWzY9dmj2W2wYDaRFI3EDb
         /9akJYF0CtwRIV7UqOLdKf4HU8O/zJk9maSOkujUk2csa0S5OUg7F6NN3sR/HLWK3Ayc
         2dPVJqvx6sgpGRQzqreuoG0AeoxQo9CnkO3fP4QIF27ZwJpQc8X7IR3OE/23dKL8Wwhf
         aKnHra/2FRyxa4tK+9VQWfCZ5guF2dOnTsa+mAO5QU8sGW0/h1/4m8WjuurUuiLFD4TH
         4Pyg==
X-Gm-Message-State: AOJu0YwBNSmOLFubgfSICD9BCRIYfKLPCiqNM1vA+WxUy+vhC//uXQzp
	s3MfuIeSfs5W5N5X44qY4yn8cnlXJ0Cxk3U=
X-Google-Smtp-Source: AGHT+IHO2E2prQ5RfZ058jXXyfE6P5LvlK6cEpcXCLPF2UZGRn7Y8VH9Bk12vfvisGPfCrCIk/rm4YcD+hZatqI=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a81:ff05:0:b0:5cd:c47d:d89a with SMTP id
 k5-20020a81ff05000000b005cdc47dd89amr1190971ywn.2.1701727651079; Mon, 04 Dec
 2023 14:07:31 -0800 (PST)
Date: Mon,  4 Dec 2023 22:07:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204220728.746134-1-lixiaoyan@google.com>
Subject: [PATCH v1 net-next] Documentations: fix net_cachelines documentation
 build warning
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Original errors:
Documentation/networking/net_cachelines/index.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/inet_connection_sock.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/inet_sock.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/net_device.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/snmp.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/networking/net_cachelines/tcp_sock.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Fixes: 14006f1d8fa2 ("Documentations: Analyze heavily used Networking related structs")
Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 Documentation/networking/net_cachelines/index.rst                | 1 +
 Documentation/networking/net_cachelines/inet_connection_sock.rst | 1 +
 Documentation/networking/net_cachelines/inet_sock.rst            | 1 +
 Documentation/networking/net_cachelines/net_device.rst           | 1 +
 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst    | 1 +
 Documentation/networking/net_cachelines/snmp.rst                 | 1 +
 Documentation/networking/net_cachelines/tcp_sock.rst             | 1 +
 7 files changed, 7 insertions(+)

diff --git a/Documentation/networking/net_cachelines/index.rst b/Documentation/networking/net_cachelines/index.rst
index 6f1a99989bbd1..2669e4cda086b 100644
--- a/Documentation/networking/net_cachelines/index.rst
+++ b/Documentation/networking/net_cachelines/index.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 ===================================
 Common Networking Struct Cachelines
 ===================================
diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index ad2b200147a67..7a911dc95652e 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 =====================================================
 inet_connection_sock struct fast path usage breakdown
 =====================================================
diff --git a/Documentation/networking/net_cachelines/inet_sock.rst b/Documentation/networking/net_cachelines/inet_sock.rst
index 4077febdb9954..a2babd0d7954e 100644
--- a/Documentation/networking/net_cachelines/inet_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_sock.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 =====================================================
 inet_connection_sock struct fast path usage breakdown
 =====================================================
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 98508aa4f8009..6cab1b797739f 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 ===========================================
 net_device struct fast path usage breakdown
 ===========================================
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 47e1a01053848..9b87089a84c61 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 ===========================================
 netns_ipv4 struct fast path usage breakdown
 ===========================================
diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index 1eaeb8bc252c0..6a071538566c2 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 ===========================================
 netns_ipv4 enum fast path usage breakdown
 ===========================================
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 802ad22015d7f..97d7a5c8e01c0 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
+
 =========================================
 tcp_sock struct fast path usage breakdown
 =========================================
-- 
2.43.0.rc2.451.g8631bc7472-goog


