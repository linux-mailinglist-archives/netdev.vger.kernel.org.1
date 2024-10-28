Return-Path: <netdev+bounces-139485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D79B2C9C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432661C216D9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8A1D278C;
	Mon, 28 Oct 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d6ajV2SF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D991CC890
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110802; cv=none; b=AGhccFlXH6R3eXDzNGudDWzGnsaZ3FMic4tiUj3L4qYbnQVo7HRxywaq0IqNZE7Sn7eAAiUtvXF/7WECanaYBx0ZlR2mLDvHy2qrEnL+pIDB3umVfnMWbPnIzxSpW1DL1ay5wzC2k/flrPOP6fkvzyzVSuIkdV0F+10UfTnm1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110802; c=relaxed/simple;
	bh=+eKOmr6kMvUFCzPSLNg/FAr9kh10bBpAJYADSjFQMVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNiDlqgN7ey/5O58dSTATd93/HuT7AsSwyieFsMJJTElYip9267DwWBy40QBs2L9dq44ayZ/2U1s9Ywrp+VqFySBuAP+BbNtuIjHeYGXv1zM/aDMawFjkQChmHC3ivUXe4I4aIPBQReMeE1AeyH7woXZBNmOV4Du8Tk4r3q27kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d6ajV2SF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso3052368a91.3
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110799; x=1730715599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igD6vQ3WwH+IIb1oCc5ezu/rYCLuT5cyR3IdV0ruWZE=;
        b=d6ajV2SFGn8JEus9UXnHskevvfMV3HCCs07gbIHnQMuYtwZRHKMScw0r69aoiK/Jj6
         A1gcDd6+9bVBpSleBrWQKAoIagpXvxvmbWvcB5hiyKJy4XSIC2elD38f8/mqc6EOFY4M
         2jfcwGKKPNyjxBPnkWUa02cqYo70h44tjonYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110799; x=1730715599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igD6vQ3WwH+IIb1oCc5ezu/rYCLuT5cyR3IdV0ruWZE=;
        b=EDtYyf7zmECIw2Qz6pdlRgn7zriOS4zdSJoNvbLjdpL34RTClD/3LgzPuEF4gF23py
         X9IWqaGXYvwnBMyucxV97CXGyB/hewAWpfkTNdqhCo6iCLpMJ1WUtLuhfad8+A1I9mZs
         ZQsKjm/jfm/FwIaM4y/Xw2H1ee5vaJosmHe4BHCBVo0OHiMJQXgMxvECTB9WwaC7nJG5
         sYsqF2e3NQ+VjFjWMAMk4IK6Kk2XVR1L8dPmYx+yucmNZuKcS4JzVs3VtYTh+UuceSB+
         0aVZu0JqsJ3dEtUjZ7Bmk6G61KAAEkatgqRYw2A8qsROFMHzRgZZ9CLoWiJ8hUQpo6iE
         OLIA==
X-Forwarded-Encrypted: i=1; AJvYcCXMyCZARxljp2EMjmuA/eGKpVlzXuCdw8qrqJT2q2EV4+iBKaGyIxIJYehNQ5mpQlwjwMc65Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C6Jxtfn2KG1rJkv4VQoo7YUuaHRKGhK42nzU6aQhhMmbmLSn
	eEIqoe+R35lXgIDxmn70lp0hYceCMtmu91hNZRzbMd4fkMzZqWeCAfG5WhEWOA==
X-Google-Smtp-Source: AGHT+IG5RUGhFFKkFLavU9L9hqopmW7I2XCKG/M+A7RCSZxfFmmCOi3mYQmuh8gSXSXhedp2ZDqNjQ==
X-Received: by 2002:a17:90b:3848:b0:2e0:5748:6ea1 with SMTP id 98e67ed59e1d1-2e8f11dcec5mr9319102a91.37.1730110799516;
        Mon, 28 Oct 2024 03:19:59 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (51.193.125.34.bc.googleusercontent.com. [34.125.193.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3749977sm6768202a91.43.2024.10.28.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:19:59 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/1] binder: report txn errors via generic netlink (genl)
Date: Mon, 28 Oct 2024 03:19:50 -0700
Message-ID: <20241028101952.775731-1-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
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

Li Li (1):
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_genl.rst    |  93 ++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml |  59 ++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 302 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  38 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  22 ++
 drivers/android/binder_trace.h               |  37 +++
 drivers/android/binderfs.c                   |   4 +
 include/uapi/linux/android/binder.h          |  31 ++
 include/uapi/linux/binder_genl.h             |  42 +++
 13 files changed, 642 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/binder_genl.h


base-commit: 81bc949f640f78b507c7523de7c750bcc87c1bb8
-- 
2.47.0.163.g1226f6d8fa-goog


