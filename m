Return-Path: <netdev+bounces-150364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6D9E9F5E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCD016564C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBC198842;
	Mon,  9 Dec 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EiiBZckz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21E140E5F
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772177; cv=none; b=RLrcZqAx5H/NfBqYTFucR/nyw2sToYxGBbHadMVSxxb841QOwe1Iq/+2s0kY6oDTpwzuMwBQGSJ1hL+ga3GdN5TMVuomBH3XrMYIU1tI9t6LDxX81ZYfkM+qcx9t/fxowE/GYh2yruVJ1rtPoikFmXclxbP0LexoFFaJgz5EkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772177; c=relaxed/simple;
	bh=NleSYG9J4OCqFY9Y+OEctYbv1U/bsN+3zJ+VxP1dFYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXzOxdWOj1wJJy7zRw9Xdr5tQUUKMtsmfWDZyBQEmqS+KIamlDFw1LuAkjqWU9ThzgS048qsBF8ZfhHxTSUC6n14XPoWq+zRpHi77QPlfO5FlefOGdoxMy1CjDUHT/4epFq7h+1QNQkdQ9PyEuau7eqgUExRV5oTHAkvahyi+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EiiBZckz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso7905195ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772175; x=1734376975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMNxrQU3BlOFL0aVcISo0D+qZd5/+cR22Ac+Tq/ur5M=;
        b=EiiBZckzB1wJTQm7HtUSk8jMMcLcMZA6siodisA7hnJX1JEAzdHuSkepoEtPQ2ZqOc
         jdZA3jU1HNIMT3v2Zeq9cjLvu41Wyng3Ginzy8fcM25KpUaKeOVTtid+C5U8LyUfCOVv
         QW5tlYL+bbXO6XFVdF6rI/WOFuuf3+DL0MQ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772175; x=1734376975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMNxrQU3BlOFL0aVcISo0D+qZd5/+cR22Ac+Tq/ur5M=;
        b=v6gJznSAzRqheE+bPTdmLfDIN1gxMf9ijD6dp8URL163Xf5W3vYniNEHz7/+cmT7Be
         MN49Xq9I0EYBSMcRkrEIowuQBDdFOhmcHf+9gpF/BT1AqWzqKIRu3G9+ODt+Sf3Za2tm
         e//YuaruKwvcz3zUBjGklU55T0i+4Ln9j+CpUqLj0lm0J/ZJ46O9hGJ2svfWxR5x015V
         MybZ6cXtpyX8OHpgtnhRZLGQGPfZUyHn9zbKnGl5ilPlTHOH6dGlDAamfPfidqjgfXUv
         1SC/YdLGQSgFA+KvyU6XK3yw8bLxdDxyg8SyR7wDAwWAvBtZDUj4Sls7RHMdDKe0wGqx
         js0g==
X-Forwarded-Encrypted: i=1; AJvYcCXTZHJLlrWQRxelZF+SyAdo8vPbfzbB3fslfJJm2HbCRya2NB4BElr2lQM21vQ6VPb6isRJ9ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiR4STb3fq5XgnhacqBu82UCN5XDp2dZ3n7Mx5VRRSvuha3x1
	6kaAH2oxJDF6ykSE/ipc0QD0a6iMqdrgw/9P5W9iHAPLqVG63KKHebUZgC3zZQ==
X-Gm-Gg: ASbGncvum+ZD36vmPXIpJxsPaMNV7JJer0iwzDU5f9+igVkL/ReOp3d49DN6/oQU7zm
	nH+O/bHqRe2gLljIFawPhWO7JHep1NCsWJ5kdE7eS9gDdnRc0syxJNLbx+Eup4CiBRxpKJLUuen
	mqatJ6P+eHBIEyg8abQquymJ69dywBeeXpUg+l9FfLaj0prpcEnwvNddb99AMx9QD7BUTG5o5o6
	FRcXdSco9SlIVCEShIeDuD9Iwhrd4KzQ472HvVy7W/8yH/anedcG4RaOo8v28IbdYcuKb5FEK0X
	iqEFLjBzR/haD2+l4OvrNyGW0NRbjEOJCxAdIp/MYv4=
X-Google-Smtp-Source: AGHT+IER1eCsVvVd1QP/9aD09iPa9B2WieuT0MBJfO4/oQJ8uNJhVH3tpmW6SzSZqR4gBoO4sFSPrQ==
X-Received: by 2002:a17:903:32cb:b0:215:522d:72d6 with SMTP id d9443c01a7336-2166a07dbc2mr28037865ad.38.1733772174854;
        Mon, 09 Dec 2024 11:22:54 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (141.161.16.34.bc.googleusercontent.com. [34.16.161.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21645b94602sm27363375ad.96.2024.12.09.11.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:22:54 -0800 (PST)
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
Subject: [PATCH net-next v9 0/1] binder: report txn errors via generic netlink
Date: Mon,  9 Dec 2024 11:22:46 -0800
Message-ID: <20241209192247.3371436-1-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
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

Li Li (1):
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_genl.rst    |  96 +++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml | 108 ++++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 277 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  39 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  27 +-
 drivers/android/binder_trace.h               |  35 +++
 drivers/android/binderfs.c                   |   2 +
 include/uapi/linux/android/binder_genl.h     |  55 ++++
 12 files changed, 655 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/android/binder_genl.h


base-commit: 6145fefc1e42c1895c0c1c2c8593de2c085d8c56
-- 
2.47.0.338.g60cca15819-goog


