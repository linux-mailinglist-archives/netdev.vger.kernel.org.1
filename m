Return-Path: <netdev+bounces-243843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7ECA87E3
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9E9A300671D
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5233F39C;
	Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6DYlxzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC23451A6
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954740; cv=none; b=q09UmhQaAjl0/LTjQ3r7fSFtIsQt9df2dNAlCazR1NEA0aQAa9uiaE0jh6hu75h2kNrF6XyzWned1jh8Aw/+fC2A4wVw0RtWpdkBEGy+JEBRW9P5/B95eue4Y87idzRJUhehQM5WgLzhCFqz75bSOmy+ZCFOAs59Xc5A6lEsoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954740; c=relaxed/simple;
	bh=Ke9Hk/U1tAD95iE3yn3zf2OpEhZ/z0cUps2pNlkpgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzEoBS4g1ymrMq848eSl9tQpvpsyUJ20u/zzq5y6XVaCSJSvRCB1S9IyRcYFO+b+e3t63e2o6LGBAfWEBTu9W/Sqi+tJnO4tfXpNikWqUoyu9aMGDnNgGgMkxL+xGcOqtqyIPE8cbMDXERFrWJClcuNCBs60buCvZgx2QSNi04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6DYlxzK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso1993555b3a.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954729; x=1765559529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qORTeh1RcK0OLbEB6J4TCs98golUP6RBmjRH7IZnXsA=;
        b=S6DYlxzKruzDfBHIyj/heAqkkyMEmdAfW3L9vPdmwoamBke00Z/laqgNYOsutGWAdT
         pjzvi2xxee3wUmzepkOB570WTwyyRLsUrhUh9Ad9OZ6kURalpPG66IaCY1N/y6zX/xhf
         OfHZSpCjzM/nN9ZMQRjKiXf4S+0gsQXmNVWQNG7/do+yxT2C9Rd165VAMA5D/tzB8TJ7
         UT5/5e0zejwtA8UwbYQzy0KOcNMdDDOxAfXKGFUO+PEV1RP7GvC3hT7mLkAPBahbWYTC
         R0qhxeRXPefvCAQhF0M9gBJUDwKyGItQjcJDO1E4cazifF33ayaxOBoUQcxSx2BESR/p
         /qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954729; x=1765559529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qORTeh1RcK0OLbEB6J4TCs98golUP6RBmjRH7IZnXsA=;
        b=YguZOczotc+LMnhZp9f4rMf9RAWeh+GeB2PbiRXezqIeL37rha7mVZdLf2hEtj9N56
         rZ09Tj1Dv8ni7Qh2BFnxKdyvE8vFniiLnGQgPpZ4e6GAR5HsWSM/Q7RULSkWDJt08aM1
         dil5C3Vf1X6X76KS12zxjxVZX0bO+yaDi4W5uLC7LrQyKUGkh6uPDZfqcoq+oPj8qSC2
         WElzECWMYeX/OJS0VCkSBH4+y1XWJxHk1E9nCTK6tcROrcNtD81DsSL217AHX1Kfc1TT
         zWsqtCeBYSlRBIIQtwg7z6liBKE0Q1LAUFTKAw6f/3+6Wplasgu/eOnUofo5m1i05jxo
         hp2g==
X-Forwarded-Encrypted: i=1; AJvYcCWE0EM5JV41qiyKyZGeZtpJ4Zos5vX4S2l9K/Yq/uWi1R59WrpbuLb09hljtAvEYjDfkAimsLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz79/fS9x/0wah31H5JECMtHJ/nHFkrwNvs/TZGzvZup2LTQJ3U
	50UkNQouHXrmVu8UtXQZIcpoTubIi00PQMlY3d83aIcx6rsDbYaKezgP
X-Gm-Gg: ASbGnctS8qJ/VE3U0mdhWzi+n5QDxHVYCTBYK8CUrUG4+ooOjdi23qNGWhEebXQvMoT
	pxZX9zFrU/gXxAx0wqpzQiVFPWfKrphnYwafehvY/E0U8Yc7SdxzcVldVwRY/RI5IT2Q3xJ2ezr
	YzM7UdhcvULcqDblzb0XjbsghJL3duAFOvgKDpa9Hzc/9bIdHW06qXkH0mcH59eccD2uxyacvVQ
	ry0EhLEIUdp0SpKR8m+1h/k5LlukU4fAALt1qJPicWI3YIxzxEnqJQbKIUQuFzVrGXM04EJ6vKZ
	uHEGSMsP/3bd5u9FYjlVZ93xjiBkBfX61DDch80Ohb+ym7camDYcpw9CkbfdoIdF30dz+4KHV3i
	aYQTH+C3spEM+0hYQac/8rqDL+5pN6ormH7/ZYu0YFC2DHX2pv4MfazV/2MNclzKnVRSbsHykwA
	RKbHZWh0Zku6FuCAMgv55RaSs=
X-Google-Smtp-Source: AGHT+IHG9Ub9xshsdF6kH5/FAkq+jq1T/rEVFAM65Ag5B1+pgNhqA3GKA+rpXsrwIeGzgMXlNvHVmg==
X-Received: by 2002:a05:7022:609f:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-11df643be88mr5146019c88.1.1764954729409;
        Fri, 05 Dec 2025 09:12:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm20336959c88.2.2025.12.05.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 00/13] selftests: Fix build warnings and errors
Date: Fri,  5 Dec 2025 09:09:54 -0800
Message-ID: <20251205171010.515236-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes build warnings and errors observed when trying to build
selftests.

v2: Emphasize that the patch series fixes build warnings and errors
    which are seen even if -Werror is not provided.
    Fix usage of cc-option.
    For "ignoring return value" warnings, use perror() to display an error
    message if the affected function returns an error.

----------------------------------------------------------------
Guenter Roeck (13):
      clone3: clone3_cap_checkpoint_restore: Fix build warnings
      selftests: ntsync: Fix build warnings
      selftests/filesystems: fclog: Fix build warnings and errors
      selftests/filesystems: file_stressor: Fix build warning
      selftests/filesystems: anon_inode_test: Fix build warning
      selftest: af_unix: Support compilers without flex-array-member-not-at-end support
      selftest/futex: Comment out test_futex_mpol
      selftests: net: netlink-dumps: Avoid uninitialized variable warning
      selftests/seccomp: Fix build warning
      selftests: net: Fix build warnings
      selftests/fs/mount-notify: Fix build warning
      selftests/fs/mount-notify-ns: Fix build warning
      selftests: net: tfo: Fix build warning

 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c     | 4 ----
 tools/testing/selftests/drivers/ntsync/ntsync.c                    | 4 ++--
 tools/testing/selftests/filesystems/anon_inode_test.c              | 1 +
 tools/testing/selftests/filesystems/fclog.c                        | 1 +
 tools/testing/selftests/filesystems/file_stressor.c                | 2 --
 .../testing/selftests/filesystems/mount-notify/mount-notify_test.c | 3 ++-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c      | 3 ++-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c         | 2 ++
 tools/testing/selftests/net/af_unix/Makefile                       | 7 ++++++-
 tools/testing/selftests/net/lib/ksft.h                             | 6 ++++--
 tools/testing/selftests/net/netlink-dumps.c                        | 2 +-
 tools/testing/selftests/net/tfo.c                                  | 3 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c                      | 3 ++-
 13 files changed, 25 insertions(+), 16 deletions(-)

