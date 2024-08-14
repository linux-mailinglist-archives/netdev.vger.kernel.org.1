Return-Path: <netdev+bounces-118328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D485951468
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107861F25996
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09E80631;
	Wed, 14 Aug 2024 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP+CAf8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94C1F94D;
	Wed, 14 Aug 2024 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616580; cv=none; b=Ui1R4DTFlpyAlfYb3xejvtCH1zQTN42Rzexps51e6UyeCe4EWEZK1JpTzswMN4xXv7FqpZtjmFDtNXFXTcz3T/8l+QnMJfBp0B5tLmxQeSHuPb6k5TBU3Jyg0mlgamJfYeYFiXyqIE+qssKxHrt37W91oGyIdE3p8pizVhW8D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616580; c=relaxed/simple;
	bh=zL+qnPL1jO2zhvpEIpxLqlOnW6CEZ9PD7cHRsrI7EA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kri2JOXk4quqqjV3oC3JBjdUI+HRY3PJRViWJ8lf8/y76pLy69TRzqqZuJHS1VUXrY9V3NrlB+KuRQWQgka7C1jmCa1nD9fEKrUsU6tQHJKyX6+RGTSDepUxgksoEIz9QrfGwf0svB3DKIBs2bJgdLeXipC24fiZ6+r3M4cm69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP+CAf8n; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a10b293432so4394328a12.0;
        Tue, 13 Aug 2024 23:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723616577; x=1724221377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6qpq46Cmtk8VQ38Im8rdWFCBv9ylccY5eUMWeEbdM0=;
        b=TP+CAf8nhukf2zaA+jB3kMF7QHwlNM9JobMbfEAPQ7/k1EafSZNF5M5WucbdXFDcOg
         QEDB9xRloO2XQO3FLxP886heg2xzAyqt++KgoBhNOYeAgGXNkX4NMVbOSO5zJqAdQl9W
         hYcIi1WidntPnuCMWv329op9YET5aylgQbD4gueUbdBY96DLSCgQAq20OrhKYV56i9KF
         dIYa5vLe/ePZtoH6AFMgbqeIxtXAWxfHRa2P+/KYjgjhcxsE/q7iVn5X9nqAh31UU1P8
         SQvQYHSLKLMedkovvVt5Rn6CtSmLX6lmPgOf7sX5b7AsVoq/8wn5STq2Dqbw4Hq9gcp+
         lgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616577; x=1724221377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6qpq46Cmtk8VQ38Im8rdWFCBv9ylccY5eUMWeEbdM0=;
        b=f+n2k9XS/chF/NND5URZpkud6fJw+FMZsyRXDFqNtrQoiDHxOwALc/HTKKB3shpz/z
         pHh/VDw7C/29GkmkxE6kZ7TQHvGcRRewGqecjBAz/7M+3o8jrDp8OhwdRT/XC2XIsejw
         AgEeA0LJ3EXaVR2u4hmK1XD1fkYk9l8KkC0thEuaebW2CWbxXB13Z4eWAzzZG4GxaaZV
         plCyCZ19ITKGfaNBJnglqvYHne+O9a3eDdCF/O2CtU182swSKPVqemSYt8RAkiMYE+ib
         I8tzJOXD1crWtNskkF7qS46rps/6sBx8A2ZbFQkhS3nx/xyhr+O1jMHv44yIcNlM/6OF
         c0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXqdZxF9xSAcUzIvPhJwrS1cawIZslKlBs4e0leuQf5UKzVmCwIl4pSFR0f+f0LmKTQ7ok+v33fuBDwg7ZJCaURZmdlE8U3pudQAmRbQfNHht/r0PbDyV99niJfKCp03Y2LJzAslIml3ME93UPS6Q761ZthXdjrzeA3Apy/Js2w30WwmRhmo0ozOvjC
X-Gm-Message-State: AOJu0YwzJajGn4vDeMiFYqCFo6xi3xXd2kJUa5j2urrRc8WE4vAanHMf
	CnYME4oWTYI+qG7/+muSKlocgv+yNxMdo5Va/ttOyRHHHRA05lDp
X-Google-Smtp-Source: AGHT+IEM+cQkNQYxKAzkEIN3SXPl5pEpGF0VS4xS43WkOmnpmzPVe0bsCIM7q1PBWtzTRnWKOVOufQ==
X-Received: by 2002:a05:6a21:3a81:b0:1c4:214c:cc0d with SMTP id adf61e73a8af0-1c8eaf80489mr2271288637.36.1723616577336;
        Tue, 13 Aug 2024 23:22:57 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2120sm728811a91.31.2024.08.13.23.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:22:56 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v9 0/5] Landlock: Add abstract unix socket connect restriction
Date: Wed, 14 Aug 2024 00:22:18 -0600
Message-Id: <cover.1723615689.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds scoping mechanism for abstract unix sockets.
Closes: https://github.com/landlock-lsm/linux/issues/7

Problem
=======

Abstract unix sockets are used for local inter-process communications
independent of the filesystem. Currently, a sandboxed process can
connect to a socket outside of the sandboxed environment, since Landlock
has no restriction for connecting to an abstract socket address(see more
details in [1,2]). Access to such sockets for a sandboxed process should
be scoped the same way ptrace is limited.

[1] https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
[2] https://lore.kernel.org/all/20231102.MaeWaepav8nu@digikod.net/

Solution
========

To solve this issue, we extend the user space interface by adding a new
"scoped" field to Landlock ruleset attribute structure. This field can
contains different rights to restrict different functionalities. For
abstract unix sockets, we introduce
"LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" field to specify that a ruleset
will deny any connection from within the sandbox domain to its parent
(i.e. any parent sandbox or non-sandbox processes).

Example
=======

Starting a listening socket with socat(1):
	socat abstract-listen:mysocket -

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
	LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash

If we try to connect to the listening socket, the connection would be
refused.
	socat - abstract-connect:mysocket --> fails


Notes of Implementation
=======================

* Using the "scoped" field provides enough compatibility and flexibility
  to extend the scoping mechanism for other IPCs(e.g. signals).

* To access the domain of a socket, we use its credentials of the file's FD
  which point to the credentials of the process that created the socket.
  (see more details in [3]). Cases where the process using the socket has
  a different domain than the process created it are covered in the 
  unix_sock_special_cases test.

[3]https://lore.kernel.org/all/20240611.Pi8Iph7ootae@digikod.net/

Previous Versions
=================
v8: https://lore.kernel.org/all/cover.1722570749.git.fahimitahera@gmail.com/
v7: https://lore.kernel.org/all/cover.1721269836.git.fahimitahera@gmail.com/
v6: https://lore.kernel.org/all/Zn32CYZiu7pY+rdI@tahera-OptiPlex-5000/
and https://lore.kernel.org/all/Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000/
v5: https://lore.kernel.org/all/ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000/
v4: https://lore.kernel.org/all/ZnNcE3ph2SWi1qmd@tahera-OptiPlex-5000/
v3: https://lore.kernel.org/all/ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000/
v2: https://lore.kernel.org/all/ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000/
v1: https://lore.kernel.org/all/ZgXN5fi6A1YQKiAQ@tahera-OptiPlex-5000/

Tahera Fahimi (5):
  Landlock: Add abstract unix socket connect restriction
  selftests/Landlock: Abstract unix socket restriction tests
  selftests/Landlock: Adding pathname Unix socket tests
  sample/Landlock: Support abstract unix socket restriction
  Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI
    versioning

 Documentation/userspace-api/landlock.rst      |   33 +-
 include/uapi/linux/landlock.h                 |   27 +
 samples/landlock/sandboxer.c                  |   58 +-
 security/landlock/limits.h                    |    3 +
 security/landlock/ruleset.c                   |    7 +-
 security/landlock/ruleset.h                   |   23 +-
 security/landlock/syscalls.c                  |   17 +-
 security/landlock/task.c                      |  129 ++
 tools/testing/selftests/landlock/base_test.c  |    2 +-
 tools/testing/selftests/landlock/common.h     |   38 +
 tools/testing/selftests/landlock/net_test.c   |   31 +-
 .../landlock/scoped_abstract_unix_test.c      | 1146 +++++++++++++++++
 12 files changed, 1469 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c

-- 
2.34.1


