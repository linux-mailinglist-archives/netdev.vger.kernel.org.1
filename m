Return-Path: <netdev+bounces-169966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDCA46ACD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12E0188B1C0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6F22E3F1;
	Wed, 26 Feb 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8Xzo1ZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6922540A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597661; cv=none; b=pcmo4Ho/btSfidZ8CJCT7IC4GHGYqavB0m16BGsz6NkQpnN9Z1hvlDbSroCXpJ1RJPOpyzGmcSWHe6O+6uJacOfuoZ3qEhDV/BrCt6JKyvdWG3FX4DFa368HHYqTkbCrpdY+dfX30v27ZMab/qZUWxlP4p6F6Na5Qb6a8y2Lfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597661; c=relaxed/simple;
	bh=UUYvAQhs1KiAGxC1m7xaV5aQ4fWZ/WwKa5MJLLC+w30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uY9glng5f04mrjNr4U5ySrS7qu0CdMUuetdoSSBdun3wp9NwLAuZv+23ofEeami2hOmwfj0RkSjPNfoe82OitGroYElzXXeA+kNm6mgUQvXpPicJ/wqFB8aJUnqkwjBrKF6QZ9c8UU9bFMvXoA8E9BnPM/MBXf83ZZhNRtYXl3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H8Xzo1ZC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22339936bbfso1737875ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740597658; x=1741202458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czH1DcjvV2gJQRKqe6n0e4xla1CwWZ0MjiBisJa1Rf4=;
        b=H8Xzo1ZCb5FjF0xbUoxYv0Zp6vqdBEXQ2y7K0MlrSzJUeJMBiZGPcaQZZ4i2NDqh3z
         AFOQoiyjaFr2ajIn9z5z5WbJIk1X71OsLfe0LayUUJYT8Ols2AVtkLuSDLJy4TF3Iwvr
         NF3ucL3LQLbdoGiJF+ZKHcnOTpLQ2KsN6HS2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597658; x=1741202458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czH1DcjvV2gJQRKqe6n0e4xla1CwWZ0MjiBisJa1Rf4=;
        b=V+MO53cByOxdBqC9P5z6Jxie9c9eV6gNW+BonQ4vtiiM7Bzt6t2rOye1+RaXEi6qTB
         zw3J1RfjRg2HX2z8zzkVfW5iRjHjV2DYcLmmuZ+PSuBL749+E7hWE0p6esw52FsYL4mm
         g7QkmsfBXRNY/vQDyxsTIDdfWjVZo/zZHIbzNEqy046gUyn1MQK9setZ7clEAqaOO2UU
         IE2xMNR+pO/fOlmBDsMffTAOUj3mPzU9mYWfZFKsPullmaRXHUGc5fnB0FFfLFIrPi8x
         kHwn6Qm0U7/XmhCxOS8tfrvB9zf2d/Ua4hSm7ELtWmqz1FmW/RIpiZQ+kpI67wSkiL9N
         dRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4OGZsM7LBOxF3caXurd1Leqxjosewq5HHSiQj0Cwl7nhb5gHHesmPvI0vb2Nqk5Q+1IPjoSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAOlj+5lDxWD5hG8bM8a71bsD+r32QB8g1w3HUV1rbVLbxdKZ
	AoRQ1kIqsyfbVLmdGdZpuAct+ITYZBjg2iyULKVXwWZruuyjal+a03QYZadd0g==
X-Gm-Gg: ASbGncss9GsVE3LmPsC0A34tYEe/Isr/RvOKDvhE66IK8a9PxAFbAZ0eNGhHFFli43V
	wUL1y5GGb0q63hfGCv4DHqrp2mZLpAKLGaTICxSUVzjmQMh+yjT94tr1ISqSpcyCRgMy67TOgrz
	pY8/rIUY+bErNZ3LKCvvy3liiKc5fo0ii0eQlaLuL8BPf0P7iXynUc4OhQeCNhdSAyqfMyQuaWk
	iQxlf60n/0E23+/dxFWZR7HcPRRZAwtN/2j4zX44WqaIcFH58U7M8ulzR3CFGUhpvyLw8IT4Y8w
	d+DNtgaXvdTFVykJVYELIiWHFlua8Fndg8G2PWcWLRLZvKjAkXlG7yX0dsm3gfyFHQiV86dZxAU
	8eSpv+rJ2oVAi
X-Google-Smtp-Source: AGHT+IHvyZFAQDOhL2Je3ZfmlWmLMsIrm8gpqy56p6L/5rQl0hxXWMZtg3kbi5Xu9/6ZKG3MoybU4Q==
X-Received: by 2002:a17:902:cec5:b0:21f:81f4:21b8 with SMTP id d9443c01a7336-221a002df1cmr361262255ad.50.1740597658269;
        Wed, 26 Feb 2025 11:20:58 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22341c04d16sm8473865ad.190.2025.02.26.11.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:20:57 -0800 (PST)
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
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v15 0/3] binder: report txn errors via generic netlink
Date: Wed, 26 Feb 2025 11:20:44 -0800
Message-ID: <20250226192047.734627-1-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
https://lore.kernel.org/all/20241212224114.888373-1-dualli@chromium.org/

The 11th version simplifies the yaml filename to avoid redundant words in
variable names. This also makes binder netlink yaml more aligned with
other existing netlink specs. Another trivial change is to use reverse
xmas tree for function variables.
https://lore.kernel.org/all/20241218203740.4081865-1-dualli@chromium.org/

The 12th version makes Documentation/admin-guide/binder_netlink.rst aligned
with the binder netlink yaml change introduced in the 11th revision. It
doesn't change any source code.
https://lore.kernel.org/all/20241218212935.4162907-1-dualli@chromium.org/

The 13th version removes the unnecessary dependency to binder file ops.
Now the netlink configuration is reset using sock_priv_destroy. It also
requires CAP_NET_ADMIN to send commands to the driver. One of the
patches ("binderfs: add new binder devices to binder_devices") has been
merged to linux-next. To avoid conflict, switch to linux-next master
branch and remove the merged one. Adding sock_priv into netlink spec
results in CFI failure, which is fixed by the new trampoline patches.
https://lore.kernel.org/all/20250115102950.563615-1-dualli@chromium.org/

The 14th version fix the code style issue by wrapping the sock priv
in a separate struct, as suggested by Jakub. The other 2 patches are
no longer included in this patchset as the equvilent fix has already
been merged to upstream linux master branch, as well as net & net-next.
This version has already been rebased to TOT of linux-next.
https://lore.kernel.org/all/20250118080939.2835687-1-dualli@chromium.org/

The 15th version switches from unicast to multicast per feedback and
feature requriements from binder users. With this change, multiple user
space processes can listen to the binder reports from the kernel driver
at the same time. To receive the multicast messages, those user space
processs should query the mcast group id and join the mcast group. In
the previous unicast solution, a portid is saved in the kernel driver to
prevent unauthorized process to send commands to the kernel driver. In
this multicast solution, this is replaced by a new "setup_report"
permission in the "binder" class. Meanwhile, the sock_priv_destroy
callback and CAP_NET_ADMIN restriction are no longer required in favor
of the multicast solution and the new "setup_report" permission.

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
v9: remove unnecessary check to netlink flags and message payloads
v10: improve the readability of kernel doc and variable names
v11: rename binder_netlinnk.yaml to binder.yaml
     use reverse xmas tree for function variables
v12: make kernel doc aligned with source code
v13: use sock_priv_destroy to cleanup netlink
     require CAP_NET_ADMIN to send netlink commands
     add trampolines in ynl-gen to fix CFI failure
v14: wrap the sock priv in a separate struct
v15: switch from unicast to multicast netlink message
     add a "setup_report" permission in the "binder" class
     add generic_netlink to binder_features

Li Li (2):
  binder: report txn errors via generic netlink
  binder: generic netlink binder_features flag

Thiébaud Weksteen (1):
  lsm, selinux: Add setup_report permission to binder

 Documentation/admin-guide/binder_netlink.rst  | 108 +++++++++
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/netlink/specs/binder.yaml       | 116 +++++++++
 drivers/android/Kconfig                       |   1 +
 drivers/android/Makefile                      |   2 +-
 drivers/android/binder.c                      | 229 +++++++++++++++++-
 drivers/android/binder_internal.h             |  16 ++
 drivers/android/binder_netlink.c              |  46 ++++
 drivers/android/binder_netlink.h              |  23 ++
 drivers/android/binder_trace.h                |  35 +++
 drivers/android/binderfs.c                    |   8 +
 include/linux/lsm_hook_defs.h                 |   1 +
 include/linux/security.h                      |   1 +
 include/uapi/linux/android/binder_netlink.h   |  57 +++++
 security/security.c                           |  13 +
 security/selinux/hooks.c                      |   7 +
 security/selinux/include/classmap.h           |   3 +-
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 18 files changed, 663 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_netlink.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h


base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
-- 
2.48.1.658.g4767266eb4-goog


