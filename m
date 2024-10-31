Return-Path: <netdev+bounces-140658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324239B775B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6439284EED
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B15192B9E;
	Thu, 31 Oct 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIjH2sJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C491BD9ED
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366716; cv=none; b=CnzQ5vhjYFgi8KxkkQveHlwt7CmsvV8cgM8QFlF2nRbPXPOk0Vor/RFAF7ILjuo9FwP46vBjxePCgc65k8zFcaYwB+kYpVMFzNmtFS0R96yIW50gEN3FshSyuNfCQOa0tEpTE/nNnrxKZS7ggCOX2Fnewr7uyTZJoIaa/c/2o6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366716; c=relaxed/simple;
	bh=f1HdzsV7YLGVcnFKYBqESX9JVFF3pHrZctef8EYPBBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0Q37Y70skJC4bslY5IdYZFO8kYMW88xkfJFrmyzzHLRkzf9XvqW30IRQ+qyNPwQbeqvfvU/5ybF9aSpwMJTkktmdnBwDjlsvmc5p2gvSQ1PvJEtYb38mN1L+SVCNKuXD3vDXxXTaILSSu6Vl7mly3NVEFb8uG6DpRWVzWT4K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hIjH2sJj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so493985a91.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730366713; x=1730971513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lcLB4HIZIK9oMvpqdAO2JM1v5FMdpcqxSsSVqe7+kq0=;
        b=hIjH2sJjYXgRh2d/cZHKE1fVLWmbkUHiB29dCGH6onGlS3oRhMncWZEaH50x7bjmGX
         AglZgDbHIsGVoj3vp1tkeGyeuSy5uvtrSfrmj7uSKNf4HCejiXZgyPhAHhRSIMKasU2v
         lSoYTioSaNphcFncA6+0sEcX5gcFWkKnX7Egc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730366713; x=1730971513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcLB4HIZIK9oMvpqdAO2JM1v5FMdpcqxSsSVqe7+kq0=;
        b=MX0TeVRdw77ShY0mME15Xi86Ftn9yezNp0uNQFOgomczD7NihLm8kdHnlLPidN16Q3
         iPhm7FXqW8mgc2+UgQxcyXmXN04LZWGD3Elx7pksXS3sCbXoh3wZ6zLRuGcVNop2m04f
         /++eINrPd3D5FIVC9ohdtVbgv+IFLbz9Mj552sQDid1VM65p5WJslSEdgX9uFPeyscQj
         Hh2Qyd7zsMDloXLLs1ybeJEHZDsT+kXtpSiandIdLZblcohCtSCCDh92MmJi28MszLXN
         oaICeHA349kGNqeRl9M8fmzuWytZZ7Z4uGF6oGQzL232i1F30CIHApMpmoCGjVOnbDNe
         dZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6Odt1QUiRgfHbu/ujBQyDFHtkxeHXe2R18Y5m4pzhdSb5RdLd//jV892h/TKkJuZFdeGsn9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNswMsPo1rUva/MqCNV8ZFRRGKZEzjl1OGW5EdzEtpY48O48fy
	cqjysMoPcUrmk3VbBl6Hj7SzWGJr1fhzN0iSKny9zZsLg1fl2JplyZVKApAIgg==
X-Google-Smtp-Source: AGHT+IFRvrb9zsW85LZDqilyIUEvRLLhdyBSF+TWI+xHMtdLZ26nlm2NAngIK5apmSpEcozgXAu4Hw==
X-Received: by 2002:a17:90a:1f87:b0:2e2:d3f6:6efc with SMTP id 98e67ed59e1d1-2e8f10a8890mr20553638a91.28.1730366713299;
        Thu, 31 Oct 2024 02:25:13 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (51.193.125.34.bc.googleusercontent.com. [34.125.193.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe707fsm3074953a91.37.2024.10.31.02.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:25:12 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/2] binder: report txn errors via generic netlink
Date: Thu, 31 Oct 2024 02:25:02 -0700
Message-ID: <20241031092504.840708-1-dualli@chromium.org>
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
https://lore.kernel.org/lkml/20241028101952.775731-1-dualli@chromium.org/

The 7th version breaks the binary struct netlink message into individual
attributes to better support automatic error checking. Thanks Jakub for
improving ynl-gen.

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

Jakub Kicinski (1):
  tools: ynl-gen: allow uapi headers in sub-dirs

Li Li (1):
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_genl.rst    |  93 ++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml | 114 +++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 313 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  38 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  22 ++
 drivers/android/binder_trace.h               |  35 +++
 drivers/android/binderfs.c                   |   4 +
 include/uapi/linux/android/binder.h          |  31 ++
 include/uapi/linux/android/binder_genl.h     |  56 ++++
 tools/net/ynl/ynl-gen-c.py                   |   1 +
 14 files changed, 721 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/android/binder_genl.h


base-commit: d30b56c8666d2543112152dd5d93d052eafd6bc2
-- 
2.47.0.163.g1226f6d8fa-goog


