Return-Path: <netdev+bounces-119982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60104957C3B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0251C23CB6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712A4CDEC;
	Tue, 20 Aug 2024 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbSD48TA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F51BF58;
	Tue, 20 Aug 2024 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126951; cv=none; b=CDNJkwss0J3m9erdSOcrShj2Vv0M+a6A0GV8SBVJ9tigEuQ/KvLjuuMPB/a5+BZ821dqnY7GlwyrU08keEmgvXBfiBx7JnVLsobIr8qf8n48CXXKqS/5PlahBiuQJXEvMHHi5LG69b9x75jLqR3YwTYa/+PLfKxWER6o49Ookkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126951; c=relaxed/simple;
	bh=722SrbrU5FYgP/rCyWOB/paH8DLrpPvaWd+6+O/GNKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kvywCKqRgm1cmzJYglzMij1MOje56+3HjfkvYvWg1rJyf2Q19hBoWC9Cj+d5mPRYOKz9UGoTLuKIQ9u4iVvXvh7Dh3ogBoVNHITuz/wdyVtfUNstNyqX7xpSEfFdILz/1hZAqRv2LB70rUEfxXJ0tDQIxZkL3JJFvFASe5Pl4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbSD48TA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3ec4bacc5so2349040a91.1;
        Mon, 19 Aug 2024 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126949; x=1724731749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VBYYwjNxkH2Y1cBz1QAcJjOLR2oZ87KEXbLeXrpaRGM=;
        b=SbSD48TA4s4Q7bf8wZ0kUsX9n0yJmh+o2uEysbN/dVBmxonwD3umzKCMHQ2Y8e+cFL
         3IrPokIjua0Hex5FHvIS5Tg+fNQLL+mJfT4RhZx/gs6rMDku7fe/b6omnhO6CNOWCLLM
         Ry9CMJ+oicQfVoo7JqXb4R7uf9DeqXPbovPPJxBS1DCqQmHUK26JJy8IG9BOhxFM0Lwu
         hxB0hv/nKFH2zajpxHVHjQRn+5ZrSRxfPEURl+sxixDdh3/G3M4tOpwYej4GmNTW4LpR
         hbWoZgkS2VQV/aaInhyuh4uEEFGpj9t4IS65g+vZVB0t+gsmeDJ6NpK4aLquahOXogCp
         rDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126949; x=1724731749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBYYwjNxkH2Y1cBz1QAcJjOLR2oZ87KEXbLeXrpaRGM=;
        b=nH1ijxcWg9PQ96r6L44qATGrSt4N9y0JbtKXE9UoEEv0ns1VqHPTQDHKx+jkjWdCxL
         ZEBcK9CuR3zxmYrc2iougXCenW/Pi84e6dG13irTk4SpplRCWVg8rfeHxPN2XjzqiWIe
         sA7YhrnYL9Gqvudh6ynY6ClAuzKvNhcQ9Znqzhsw5M2LwOAeL4jgCUyPLabkX/XmYEb0
         eSDs8c1sCZCWldS21hSrU8eF4J4PEYqLeVf9rDcIwwHbhZ9ZPBPuPs3FrZPq3nKMSx7L
         sAQ8gp5OWZs3LExfVeNaeIvyoJ0jOJRNa9QXvrav1pVgbbUMtVT23uCpRvbFj5N4vmpf
         +zHA==
X-Forwarded-Encrypted: i=1; AJvYcCXhv3la/vlFK0RL/YRWOybLrKN2XgTdklv9rVDJAvkbvI8HQ2eMnObQ3Oqx3eJBcfZx5fRSY1xnwnSilUkEoezPcGIV4ZfMLfT4MGMVmoNQB0/tSO7bNW4gMzxeSdaNkPLP3GMLo7nfDPxI9jQ0JZaB28Z2/SZbHiYxI9jVqsqwt1V8j83tT4oNoItt
X-Gm-Message-State: AOJu0YyZB5zVM7rizKb4CSQa32LC9x7Qtd9+tSwjxaPUH7Nf9h3E9TfB
	tI2r9/UvzY7NLC4yl7K5oQ4wm8QP+jXD8Ih0fI8EuDDlWXCDpJ//OcjX9Uzw
X-Google-Smtp-Source: AGHT+IETFymxJ8RD0sGkskYUpuypnOlax75HpUcfIv9lVAy026lOUBXDBs8DpOa5LgcJ9ZOiuk/ZsA==
X-Received: by 2002:a17:90a:b308:b0:2d4:27de:dc39 with SMTP id 98e67ed59e1d1-2d473218371mr2577275a91.6.1724126948740;
        Mon, 19 Aug 2024 21:09:08 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:08 -0700 (PDT)
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
Subject: [PATCH v10 0/6] Landlock: Add abstract UNIX socket connect restriction
Date: Mon, 19 Aug 2024 22:08:50 -0600
Message-Id: <cover.1724125513.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds scoping mechanism for abstract UNIX sockets.
Closes: https://github.com/landlock-lsm/linux/issues/7

Problem
=======

Abstract UNIX sockets are used for local inter-process communications
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
  outside_socket test.

[3]https://lore.kernel.org/all/20240611.Pi8Iph7ootae@digikod.net/

Previous Versions
=================
v9: https://lore.kernel.org/all/cover.1723615689.git.fahimitahera@gmail.com/
v8: https://lore.kernel.org/all/cover.1722570749.git.fahimitahera@gmail.com/
v7: https://lore.kernel.org/all/cover.1721269836.git.fahimitahera@gmail.com/
v6: https://lore.kernel.org/all/Zn32CYZiu7pY+rdI@tahera-OptiPlex-5000/
and https://lore.kernel.org/all/Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000/
v5: https://lore.kernel.org/all/ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000/
v4: https://lore.kernel.org/all/ZnNcE3ph2SWi1qmd@tahera-OptiPlex-5000/
v3: https://lore.kernel.org/all/ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000/
v2: https://lore.kernel.org/all/ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000/
v1: https://lore.kernel.org/all/ZgXN5fi6A1YQKiAQ@tahera-OptiPlex-5000/

Tahera Fahimi (6):
  Landlock: Add abstract unix socket connect restriction
  selftests/Landlock: general scoped restriction tests
  selftests/Landlock: Abstract UNIX socket restriction tests
  selftests/Landlock: Add pathname UNIX socket tests
  sample/Landlock: Support abstract unix socket restriction
  Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI
    versioning

 Documentation/userspace-api/landlock.rst      |   33 +-
 include/uapi/linux/landlock.h                 |   27 +
 samples/landlock/sandboxer.c                  |   56 +-
 security/landlock/limits.h                    |    3 +
 security/landlock/ruleset.c                   |    7 +-
 security/landlock/ruleset.h                   |   24 +-
 security/landlock/syscalls.c                  |   17 +-
 security/landlock/task.c                      |  127 ++
 tools/testing/selftests/landlock/base_test.c  |    2 +-
 tools/testing/selftests/landlock/common.h     |   38 +
 tools/testing/selftests/landlock/net_test.c   |   31 +-
 .../landlock/scoped_abstract_unix_test.c      | 1130 +++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   33 +
 13 files changed, 1483 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
 create mode 100644 tools/testing/selftests/landlock/scoped_test.c

-- 
2.34.1


