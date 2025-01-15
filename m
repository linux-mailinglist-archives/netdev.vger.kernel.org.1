Return-Path: <netdev+bounces-158476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A2A11F6F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD6A1884137
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E356241695;
	Wed, 15 Jan 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DnggEdan"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC8241A06
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937001; cv=none; b=X5hLUIvv4kCwuGblSKhzQyvvoMaHodJlMzm3lKTS6F8Zr5KiZeONXRiYfgZ5p4DhcvQQ7ZemnKPwcJ9dhdIiNuP5und/o0y6Ms5vsTSexC6p38GsDisMmEZf66ocuO2tYF/CzQjjBVLa2HALWozQZ96yeyv+moNcSp6rDQ0u1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937001; c=relaxed/simple;
	bh=jt1m/j9PSVPxzuvoQ8e+uL32NKiLS/Jv487EtOtqPzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSHXX2GATr+Fv6QP9dJZVZuec4JRpRgwe7whkB6z/KsOeBr3sdUDH5sYng3cWkVNBZFWS6nwzKEbLIJ/JX8DNEDr3+JEj8ApbYPHudlgx4Vjm7+0B75Yt5Gwa3Op6BKS9CgqEyh/f95OqkP8HLEyf5V7Lqxdq/CjGtIzISDoV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DnggEdan; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21680814d42so96951985ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736936998; x=1737541798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9e7Uw/2eMRVn+Ju9W+kjDajWwn8iBg3HrM68HGerkk=;
        b=DnggEdanyf3C/Hravj3jW7sYa4YPflHqkyAYFw2vq9k+R10p3vNHhgiCdU0iNhdonM
         vNneEHXz6LHrr0U7RxtYIdkI3Vn+18Y3sDa+kotQqP131EdHPUfIqOeGlMs3AksmEHf5
         2MBPMKup1MiBEy8BKk2KWJ42899ezu5wNQ27Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736936998; x=1737541798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9e7Uw/2eMRVn+Ju9W+kjDajWwn8iBg3HrM68HGerkk=;
        b=XUxJ4epjn9eTVtThhJQgtRQGzhABQ7fKe1zmL8NwqyUkqfuSb5ioI8ZjxcvHqfvFNU
         nKI1WxPcSeNL+MRn5sLxWBEEAZkcDE+ELwCuItq/dY/EbFcj1oRd/m97xB+tX49vzhZQ
         k4F7OHNKS+WGtRvkKroAUOafgLs0VDroH9xL5eoYVuuKDUOo8oWsJFp1BwC0COevDJMc
         63RddffOI5rbtrEM+8E0Brln+QJHdLwpQ/FzGjwMvk1ps1F0HIcmJCqmn2hiCOxibIT2
         GPtFD2t6KDECnBj1Rzb3BP8xZyqyZ5meqs4ioIpapcI+riTgcKErj4CtvzSrFtCFOqMp
         G3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWZny/QcdTrPYA3qleT1Ks+y/f4ChWUJKsHj2dHYxnkccLDvNIh+W6453Ckpk1gsxXh9ekDaPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM57uUocHeRr2ctPUVqND1Y2DVB3zXL4T8ZSp2WP2exx6x96qt
	BL6SjItj/XxXE2uDy6xYOFlRXpsYz7/Z2AsvxhDhDcLHvTcP/yaWmNxfYPSvIg==
X-Gm-Gg: ASbGncujt5dSm3iKnQCO9f7yGqufHLzzzFPp3YH15zZxy2KAbFOWhUoUfvyWnkhggrJ
	9VLSsEQnOOd6bdHF1ShQlytzD2z6qX1xEckrD/qrFV1R9xBWu5mkMu9FAkALuSG1V0dUIOuzcfy
	JrWZJs4HZiUp0O2nG6WykP9xScvE3aBhRCk0gyjoNf2xps4zibkNn297zwneRxizbSZrLyxDtzE
	acVn72grVBJaabM6w4YsFm1hg6cRBCe8AwKJ7hqdl5hCpfo00tHQOb/aN1CALrZ5XykBedCoq0s
	0UBpn0+qOLpCKUag47to5pI2C94sf2k1UuzFeYu9pnxSHQ==
X-Google-Smtp-Source: AGHT+IHeOIm5wcljItb2rSwY2xBvgeEwNXjG2ti6WA0n6el7SGS50/P1UCVMvEkVGUzl+NLyB6LWfA==
X-Received: by 2002:a05:6a20:7fa5:b0:1dc:bdb1:349e with SMTP id adf61e73a8af0-1e88d0ff203mr40869971637.17.1736936998448;
        Wed, 15 Jan 2025 02:29:58 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e591sm8835195b3a.126.2025.01.15.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 02:29:58 -0800 (PST)
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
Subject: [PATCH v13 0/3] binder: report txn errors via generic netlink
Date: Wed, 15 Jan 2025 02:29:47 -0800
Message-ID: <20250115102950.563615-1-dualli@chromium.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
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

Li Li (3):
  tools: ynl-gen: add trampolines for sock-priv
  netdev-genl: run ynl-regen to fix CFI failure
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_netlink.rst | 110 ++++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder.yaml      | 113 ++++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 282 ++++++++++++++++++-
 drivers/android/binder_internal.h            |  20 ++
 drivers/android/binder_netlink.c             |  53 ++++
 drivers/android/binder_netlink.h             |  22 ++
 drivers/android/binder_trace.h               |  35 +++
 drivers/android/binderfs.c                   |   1 +
 include/uapi/linux/android/binder_netlink.h  |  55 ++++
 net/core/netdev-genl-gen.c                   |  14 +-
 tools/net/ynl/pyynl/ynl_gen_c.py             |  14 +-
 14 files changed, 714 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_netlink.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h


base-commit: dab2734f8e9ecba609d66d1dd087a392a7774c04
-- 
2.48.0.rc2.279.g1de40edade-goog


