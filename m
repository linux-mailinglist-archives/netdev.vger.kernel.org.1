Return-Path: <netdev+bounces-134490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A525999CE5
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED68E285A0A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 06:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047A208994;
	Fri, 11 Oct 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGdOztTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4920898A
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629077; cv=none; b=MMoc+0pMaqNz7FdnP6VbAcSeVt/u33YfSdfyfyP+1+4TZkSDrUr/GMOnqEBZasU052IcEW4GLEqXEBJHAu5NS9YCt1H9vkDff7xwZNUa2REbvPcUxVjYwIKUtY942XEiHBMJqi7C1rvw/KrEWr93qd+dfWbQrPuy/rG77nUk6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629077; c=relaxed/simple;
	bh=HtzI081zHtZSI+J9sEUvMCM/dvjcwisc+1F/dT5H4FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKdoKsdCdId5RUlVuHFqzW7+WEg/4JMHpH1tzijk4xgDkRul43wkpkXFBtacbmcBYWh/rYIKhgf7oRFYKDpYBCqp9Byfb99I5LkgBj+DX17149Rcqi10uUSjIajstRTtuD2wj/Nq1FCeuduJRfsPG38jicnJUuJ5NqoDDI8GZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LGdOztTk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8b557f91so10939175ad.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728629075; x=1729233875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXak+K/ivuo0yn0eOLdK649JwMrgxIuHICVDrxU66gg=;
        b=LGdOztTkpDTQP25zDAYykz6sdMCOTBIDMaC3y0/WJQpa+ZWSOh4YxkK5/L4lp2TQxd
         L4LNi5x1Cgynz4lUDL9aEhfSYuCUkQSXD1vqek6cIWH79wcVi/L9Gd/bzckQ83391ewj
         ihzs2tqA+qGmFJk1kV8h7GGXBNJ8eUb7l0MfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629075; x=1729233875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXak+K/ivuo0yn0eOLdK649JwMrgxIuHICVDrxU66gg=;
        b=d12P0kDrWdb4sOYftzDLZVhG8+qeh0bKq6epZpB3Dtj8z8aezPTylj27jp05B8h8Ba
         yTC49b5u96W3fBJmfsWQYaMyqWq4S9XdOXzGg7ez2NRRxHDw8VW8WuFK3rQQJU02H/To
         i7h442ezl534Iuvh58xMq271Ca/8d41E5tbb1aNinfjOS919wzsYgfHDQ/W6qxOu17xs
         KT0fLrG4IgFvv+FKjQ6j0bWootj/D4d2390RWrpMbLnW5AhUZXvfMajL3PO/3KK6LUm2
         oXj806Rz5tCcpaE3ZQmokWEcCCRC75gWl1zkNz+J8vTGe/5xPV1bO6wn+n0Ie4sGa6tw
         G3KA==
X-Forwarded-Encrypted: i=1; AJvYcCWf5T9T+GgjWruF+MFjxbaRBWrd3+xaoTofA0cs2Q739GAXVowpiPSR0oK4An37zwxmq5SPC/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRshc6/3SBA3YW+40mMru/I7nFwq2GpFC9645OOAcCagk2IwyW
	YsPobeScrKI17NXDxT0k28JqLQlV1bmb2XtJ5pOxaaLsauTiHouEhZRW/FNCFQ==
X-Google-Smtp-Source: AGHT+IHJ6LD99qEecDXNWzIMqvh4vifNKH0a7GwYHT96HzQtlchraLxT83xme3B2j+uJE98XoTWbHA==
X-Received: by 2002:a17:903:22c4:b0:20b:9f8c:e9d3 with SMTP id d9443c01a7336-20ca16ebe51mr18078475ad.55.1728629075390;
        Thu, 10 Oct 2024 23:44:35 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c3561e0sm18201585ad.291.2024.10.10.23.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:44:34 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
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
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH v2 0/1] binder: report txn errors via generic netlink (genl)
Date: Thu, 10 Oct 2024 23:44:26 -0700
Message-ID: <20241011064427.1565287-1-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
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

The first version uses a global generic netlink for all binder contexts,
raising potential security concerns. There were a few other feedbacks
like request to kernel docs and test code. The thread can be found at
https://lore.kernel.org/lkml/20240812211844.4107494-1-dualli@chromium.org/

This version fixes those issues and has been tested on the latest
version of AOSP. See https://r.android.com/3305462 for how userspace is
going to use this feature and the test code.

v1: add a global binder genl socket for all contexts
v2: change to per-context binder genl for security reason
    replace the new ioctl with a netlink command
    add corresponding doc Documentation/admin-guide/binder_genl.rst
    add user space test code in AOSP

Li Li (1):
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_genl.rst |  69 ++++++
 drivers/android/Kconfig                   |   1 +
 drivers/android/Makefile                  |   2 +-
 drivers/android/binder.c                  |  82 ++++++-
 drivers/android/binder_genl.c             | 249 ++++++++++++++++++++++
 drivers/android/binder_internal.h         |  31 +++
 drivers/android/binder_trace.h            |  37 ++++
 drivers/android/binderfs.c                |   4 +
 include/uapi/linux/android/binder.h       | 132 ++++++++++++
 9 files changed, 603 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 drivers/android/binder_genl.c

-- 
2.47.0.rc1.288.g06298d1525-goog


