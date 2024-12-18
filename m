Return-Path: <netdev+bounces-153130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDD9F6EF4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CFF16CA7E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422931FC107;
	Wed, 18 Dec 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvNSKkGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B517BEB8
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554270; cv=none; b=cNMcZfK1Q5QfvKfU5Bf6LNKVH0CYqfzv54xqgfZ8b9979is5NS7t7bFiCik3UdHPsAZGdIjyhl3AEdQI+nRCnUwv7oQf1g3gGP0BLJuIyyrRXXMgS4mT0c4Jt176iPOoByNCaGyGsgHUeX3CRU8QRPNu8Zw0HAhwV+07j0skqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554270; c=relaxed/simple;
	bh=IhRP+7NJ2B+iWkGPlxLoJB8bt83/5U/AJ1sxTbpyDME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jphZ0uqP0v4E35NwyR6YJBrvG0YYZ3BWobAcKvhzNN6CEvPCp+BwdThnVzX1m+88eiyZrfqdx6HovqEffN5HfCOw5aD+k2LHZq/aUQynHj/MMhBUnTG4gGyynobKWR40MwL288c5IJhR57hLyHfcYGB3IavlgfpHurgHjcF29OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mvNSKkGm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21619108a6bso722255ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734554268; x=1735159068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5XzJ8Cdox5aRKpQqeo9w29DdxGzgXVrCyxDolo+s08=;
        b=mvNSKkGmymqFvtaCx4kJwU5goGIeALaIzzFqzrDgjKKUPnSxRfdpW8wnuA7jStd0Fv
         GIInMa+lWEgqcdFqz0qmvtBripiTD1BH5K9fDVanz+fUJfVoUZHqtFWBLWKMNvRj+9B+
         7Gm86/m4DChDwIyQ0Z0+pTV5WcPaVjGLUD+xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734554268; x=1735159068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5XzJ8Cdox5aRKpQqeo9w29DdxGzgXVrCyxDolo+s08=;
        b=CF+b0SWzUMX+s9y6IGOXeV+yTerhaz6+E2c/6kh80R6bMWa1C2N38t5viVbjLFG/eQ
         nyg5SAqqhUrFl/xPueeS8maEp25vsiVVimW0g/AYnX74fqMdplAt8tvZx7mCzm/SuxOo
         t2sZ+cXuDwHzNCbGBDB6FxUjDdG2skg/95XULdNUkpT3IEScL1J3GWmDr9WIxr1dhnN3
         3xnjmDYDVY4CzHd7QscoNFoUopTJyxHZ7IQCWYxNIeWUEr5KhJIK++VeikPZDRvdKlHr
         /8MO48e3Cp+sSiPKGFB7svLNRkqDbZ3GrzfgyWuz9gnLnlCtuWNDoJkTs0kbH17V+3Y/
         Wb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9Fkxmoypxb6XG+o1RgdnZomOuzMicGopTU0b5sA/kalKCvY/72FWBzXwV8Npe896wPmjvVCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPnpW+cz2sGHjtQIJn5Qpqzv97wtkKX7nXt7VD5raaUUfjiJ01
	wzgpbv6jLRX2UPqeePoL5DA9U65gkY+794ZC1SgI1BT4g97yjstXQBH2L2saHA==
X-Gm-Gg: ASbGncsv7apJYumzHdyVDvZFQAn3nqcEUS4mouh30wSvaFjAeLtX2Ya4j4EtAOaP39K
	pFxG17WI76G/6sIwUuxP+k4lbejIJWC1V1Dyy14Y4Z9T07zTGjrQGfLAx71r+eltD8dMD3O7uhu
	L3cepQoaJBbSX2GuZcARERnEhCJG8xZzlvTlxpPHeYJVNwlctzGhBAcQmw5IofWr6Y0Xp6Q36tI
	mtUAjwec+OMPjV0VsgftErEoH1UISnb+UHQnG4L2OZuase6t2jP7lanhKTADZn+erJmEHaBrzOf
	P2x3b4gQ/zuukhNyWOCh+Ro8LK9PIGV4NVqkMPYiWFsTHQ==
X-Google-Smtp-Source: AGHT+IGlef6TD/LWtcINLUtwvJmMOe41iee+xQ58bapO5aUrQXRwK5Vh0AP2TAffE3AY5yQHc1Rg9Q==
X-Received: by 2002:a17:902:dac8:b0:216:526a:53df with SMTP id d9443c01a7336-219d96abd58mr12354635ad.54.1734554267884;
        Wed, 18 Dec 2024 12:37:47 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (200.23.125.34.bc.googleusercontent.com. [34.125.23.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64672sm79920155ad.216.2024.12.18.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 12:37:47 -0800 (PST)
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
Subject: [PATCH v11 0/2] binder: report txn errors via generic netlink
Date: Wed, 18 Dec 2024 12:37:38 -0800
Message-ID: <20241218203740.4081865-1-dualli@chromium.org>
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
https://lore.kernel.org/all/20241212224114.888373-1-dualli@chromium.org/

The 11th version simplifies the yaml filename to avoid redundant words in
variable names. This also makes binder netlink yaml more aligned with
other existing netlink specs. Another trivial change is to use reverse
xmas tree for function variables.

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

Li Li (2):
  binderfs: add new binder devices to binder_devices
  binder: report txn errors via generic netlink

 Documentation/admin-guide/binder_netlink.rst | 110 +++++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder.yaml      | 108 +++++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 241 ++++++++++++++++++-
 drivers/android/binder_internal.h            |  29 ++-
 drivers/android/binder_netlink.c             |  39 +++
 drivers/android/binder_netlink.h             |  18 ++
 drivers/android/binder_trace.h               |  35 +++
 drivers/android/binderfs.c                   |   2 +
 include/uapi/linux/android/binder_netlink.h  |  55 +++++
 12 files changed, 635 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_netlink.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h


base-commit: aef25be35d23ec768eed08bfcf7ca3cf9685bc28
-- 
2.47.1.613.gc27f4b7a9f-goog


