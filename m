Return-Path: <netdev+bounces-137625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8429A7305
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85626283C4F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F11FBC97;
	Mon, 21 Oct 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJMXaIuQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C701FB3DD
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537963; cv=none; b=q5HOe5jxPVBpK6tHsCg2pyoPyYFOJS4tw6nzsqeo2aMag/lx3+i/itCOuVCvJa4jIlcfmUpqR+wZ7RczxOKRzAKzAGw5Ek9J3rx6tUhx54e6UwH+iFYu3fqdWLBxFIvRZI9Ct+HEk0384Co4r/5ZTQVqg8TaCrt7Ju8xfnFP6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537963; c=relaxed/simple;
	bh=OA6oC+JctuqR4btwJv2R+DttHT11rHc+JhWEiDA83w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuS/vt+WA3Jb4nQzxlOHUkcJ80LnWdd7APXkXJySdxJIb8/CJjOIVJxWRopLczku6RVGDMBYUqw1asw4WXkOtKG7Qzu1WwcOqNvdCSk7W9DGTpaUGCAuwUeNn6qU3zB9ghDSKgnD01AEzHF5qvNUPTrriFOsUAd+pTTTj+w0IkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJMXaIuQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3b0247d67so17424775ab.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729537961; x=1730142761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nR/53ICQ72xaEPax0k1Vh7VHIBvm4ARUGvWrYyOsPJE=;
        b=kJMXaIuQ3sVtZ7zl58GymW7H2zxn1V3fvZEsrM8aciLQj07PKHHZSkCv2r3538j1wL
         aD+03b2L9dDfz74s6gkzrWZVCCyn0mBiiLt3i7XDTduIC1ZfS1V1J+BDhT8OhHToOrQz
         S0aCFjTCBdqXGzrBijka7vpJxht6jC/yna/Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537961; x=1730142761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR/53ICQ72xaEPax0k1Vh7VHIBvm4ARUGvWrYyOsPJE=;
        b=FeRtT7jpL7by5bUfVLlOgxHjKbJIWPPkLlymCAcSpy5BECUX7ivXcetKSPLdyVJh/K
         VMXTpeHwa4j85NcZHbgpZhHvrZ7OV6ia4LCEyVJYn/huBSSXyRGtXTP+z3MyravyZpI+
         i7daxo9Tx3vhL2NvRBaDNef7GphFF3IgMAtdgM5pn1wmMBIpAQND1pjDXMAX4UcM9CZL
         0QOWb2ibZUumyGCU2GQ99Nhvm/aWxUOQnDILkRTO0CD7cRpjkeUZL3CGIJnP4DiiWQPE
         lUNog+YTXGsvE7buWGLCkNbnCTt89BeIakUZ57piac7/zUCUMsAIifIVysT/h2Tf2Fnq
         zq7w==
X-Forwarded-Encrypted: i=1; AJvYcCUO63riU12a+snzHQUEjGj56WSuLpFLveKW7rJz6ELh9M3dLqGP3I7Ra666rGtDQakMKz0chcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsyGAG1GHAx0VHERzLbxw805AtbCfdyeEig3K2WWKRy/NuPA8
	+wUCYGOD/Vtc/VLLDJ19lvijcG3mB71rXNuPmEsRmpsgE95A1fCOwWIKMWV2wQ==
X-Google-Smtp-Source: AGHT+IHLVMF+kEvm/0PO2Tdio6NQsbYaI2dHy6VQhwbKqOvgu39dZCvkw9Go8R7AbaaNPOfYKKqhVA==
X-Received: by 2002:a05:6e02:1d97:b0:3a2:7592:2c5 with SMTP id e9e14a558f8ab-3a3f40a7c0amr100984245ab.17.1729537960825;
        Mon, 21 Oct 2024 12:12:40 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab581e4sm3502386a12.50.2024.10.21.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:12:40 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH v4 0/1] binder: report txn errors via generic netlink (genl)
Date: Mon, 21 Oct 2024 12:12:32 -0700
Message-ID: <20241021191233.1334897-1-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
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

The second version fixes those issues and has been tested on the latest
version of AOSP. See https://r.android.com/3305462 for how userspace is
going to use this feature and the test code. It can be found at
https://lore.kernel.org/lkml/20241011064427.1565287-1-dualli@chromium.org/

The third version replaces the handcrafted netlink source code with the
netlink protocal specs in YAML. It also fixes the documentation issues.
https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.org/

This version just containsi trivial fixes, making the subject of the
patch aligned with the subject of the cover letter.

v1: add a global binder genl socket for all contexts
v2: change to per-context binder genl for security reason
    replace the new ioctl with a netlink command
    add corresponding doc Documentation/admin-guide/binder_genl.rst
    add user space test code in AOSP
v3: use YNL spec (./tools/net/ynl/ynl-regen.sh)
    fix documentation index
v4: change the subject of the patch and remove unsed #if 0

Li Li (1):
  binder: report txn errors via generic netlink (genl)

 Documentation/admin-guide/binder_genl.rst    |  92 ++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml |  59 ++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 287 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  38 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  22 ++
 drivers/android/binder_trace.h               |  37 +++
 drivers/android/binderfs.c                   |   4 +
 include/uapi/linux/android/binder.h          |  31 ++
 include/uapi/linux/android/binder_genl.h     |  37 +++
 13 files changed, 625 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/android/binder_genl.h

-- 
2.47.0.105.g07ac214952-goog


