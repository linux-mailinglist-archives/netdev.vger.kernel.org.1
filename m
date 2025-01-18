Return-Path: <netdev+bounces-159549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EFA15BDD
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1F03A12A0
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50E1632F2;
	Sat, 18 Jan 2025 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/fuFyqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C615FD01
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737187789; cv=none; b=k28ncMWw5fl3GESwY15wyMSedE6ZrVrG24A/MseovKFZI17+e+Loy6b6FmExj66X8kCuiZojDv/TcK8ebUnlZfC80Y/McAu8Rjyh4X9Qv5wmNSs4rerYD3f+R1O8D7ZWM8IfbUGNU7L9bKI9sFB9tcSK0PA+geM1pI8+wkKi/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737187789; c=relaxed/simple;
	bh=lk7i9VEmfFrx0Vj7XQMC+s9K4I7nQndxPNju0KEzUhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8vDtDsJOPcI+NaY+GsTiMMXZXqgLnl9ZbydG88OhPfqiIPhjtrbW4KO9kfyKaD6Sdve7S2tStsphy7sYjQE4APYCjkOYeERB9QAK/GtgRrdqHBCnF6vtf00MgmIR5xoy7DpgKXyw0BnR1BcXbN2I5c/eTb+qkKYDnOMPA6OqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d/fuFyqK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so5033753a91.2
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 00:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737187787; x=1737792587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ts7rCfO7RdQOq9AEOS5H6idZJ+Ca7XhoZ5MB9B744OA=;
        b=d/fuFyqK8645I3h5ku+aeY/V26WhuSH1V5FZc0aHjd1uJroJwo5YK1PS6zAdtxU9mc
         B5iRCIIpfyD1klhIXGSnd5f48MtgUxOPC8k6dFDQBH2XgQ03PEKGWmtEUt8RMVW5rUyE
         qxgsJbC6fpYgDYox7cLC3zn5tm1wLaIiH8zjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737187787; x=1737792587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts7rCfO7RdQOq9AEOS5H6idZJ+Ca7XhoZ5MB9B744OA=;
        b=upTDCMJkbR9kgmoJlbY1Nj71+kZCNZD5TBVY7oUHIHLmGyoFLHp9pKi2sH9Z3J0U1f
         DpzOEpct6dAqBdiZ5bXwtD0Nr6Dv2Ywt1rApxsSz3YjtO0vIB6nC2em0xrwxrle27ydp
         odHHxL3h8J3Ef/MRzOAlntxaF1u58Dh2v1P2JdTLxn59nMTwdjh5vlv+VNHGJjiX1lcE
         /bg81YoierIV5VmQquTBwGK5yR+qFUHOhC0f6F0rezbgn5x9SBrhQkIFqIKyXL4g1xt7
         9zBDWTebOACU7QO7KiiOW2DCirbReP8PTGVwEd0JlSrNnUkf+gytftSTT6dNrEFEhcnw
         tkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrvdquKYl51IRFBdfA9BhMm/3whkQtPONsskQ45vSmyG5nmXUdsMgJaw12lm1og9iqEp/r7fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRy2zxEKzZb4kXbPv4ExIqtEwdf23QRzG4pHr56cHECEAWmFmQ
	rr2YC/qkA/+OxhSxetc6jmgd0C8bx0wlhplhTl+aePzrvC/BHOEdJ7QZPg64eYEnojKsNOITm48
	=
X-Gm-Gg: ASbGncuODGhyYTgbbY+UoDnvCZ/wYDk7sXSr1Bh7FVc6Exs/5Z02Cu5KDsb/BX7jhLi
	toVKZsSsXT4p2h/HMrA3UovlQqxai7j2VNOO3twwwolVZNYKLNEocm4yy0A23xHkAcBFTbvx75P
	b6cn4adceQhfUiXcop8Mk6Imwiy6xfGaAVMJdcjSaAKV5Ty9wxZiko2byvEDNHcCzIrymiquAh6
	nm7eo0eE9g4Z4Lg4OTmTN1eMNVwEif3n4rwTjj/RirN+a3zczXuxJhbz7dr1s0IkLiGuYOSzNWf
	EHyqybSXatVTlMqaFzSNtxTcKHpc31t46uyXejep3iKtqCUh+gPqXdZUVNk=
X-Google-Smtp-Source: AGHT+IHk1AI/XHd5Gsea8u2Z/slWcUR5j4TYRRf/qGyH0gKekdSy5AOWEh3eP9AxBUZQD3f8rDcm4g==
X-Received: by 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-72dafa44feamr9452075b3a.14.1737187786630;
        Sat, 18 Jan 2025 00:09:46 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0877sm3213225b3a.23.2025.01.18.00.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 00:09:46 -0800 (PST)
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
Subject: [PATCH v14 0/1] binder: report txn errors via generic netlink
Date: Sat, 18 Jan 2025 00:09:38 -0800
Message-ID: <20250118080939.2835687-1-dualli@chromium.org>
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

The 14th version fix the code style issue by wrapping the sock priv
in a separate struct, as suggested by Jakub. The other 2 patches are
no longer included in this patchset as the equvilent fix has already
been merged to upstream linux master branch, as well as net & net-next.
This version has already been rebased to TOT of linux-next.

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

Li Li (1):
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_netlink.rst | 110 ++++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder.yaml      | 113 ++++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 280 ++++++++++++++++++-
 drivers/android/binder_internal.h            |  30 ++
 drivers/android/binder_netlink.c             |  53 ++++
 drivers/android/binder_netlink.h             |  22 ++
 drivers/android/binder_trace.h               |  35 +++
 drivers/android/binderfs.c                   |   1 +
 include/uapi/linux/android/binder_netlink.h  |  55 ++++
 12 files changed, 699 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_netlink.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h


base-commit: 0907e7fb35756464aa34c35d6abb02998418164b
-- 
2.48.0.rc2.279.g1de40edade-goog


