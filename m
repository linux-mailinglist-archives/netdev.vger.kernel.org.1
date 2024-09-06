Return-Path: <netdev+bounces-126062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82EF96FD52
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DC91F25F5E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89A155316;
	Fri,  6 Sep 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOyEfkbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D01B85DD;
	Fri,  6 Sep 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658217; cv=none; b=QnkjYKg0DRHwEX4O8o9cUyGypx2+jdo5ajsHaUecjhF7tQLo0kkawA6aojxkqFTBj5cbCApGJknB9MS8jqPVVya6BSw9nTDH8EAoIrzYWOMqtWwoNY7AxEqV2SrYXBBX33Uh58PtOk8GNpSEAOmCKRd40RL5ysa4o+j5VMDFryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658217; c=relaxed/simple;
	bh=y+y0VlIllb5CtOz4Ek+InCMwxUKWOuc56I5A+WE7J8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcqE/m67+f/CULrOlQoUgnDrmLpiPhbHSHBL8t7LPZcIlAYO3Ck6aB8yWeKGXoGDp1zUglLWhxlXbLdiEs7PIo1AgZjc2KPU9UHeekUim0etYWZR9qwPNSxFjjINvq6mI0Xm1wfyob6Hw1+VRtghoVWdQCso2/BQlF0OaDnNORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOyEfkbK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2059112f0a7so25589535ad.3;
        Fri, 06 Sep 2024 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658215; x=1726263015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsHQ5h54doNUK/ufVxcrXlo/0lcc6AzIgFEDd9yj2fY=;
        b=LOyEfkbKKMOtMq4X5HpOq7oRblnV2p0juoW0/CKrG4MUSrHcQObf08KbeH5TpOI2FD
         lgLO0ZxTUvkmbYTyHVfjJXK2AS4oMG15zpnuNW1IaI81ETAP7hxSWBQTf4tMSIr1+zaA
         wGyd9D4ihqY08dVBs5A9wHSVpcCbE4Qy9xZkhjtM94hWPNf9zr0M6qACVCgzN8ohKVrU
         EsFCMzr0tMhwunOTG3o3tHAo+GwWY6Co1qnxt/vuAOzCnyp+k6GoAcTDpkG0NhhjC/Da
         sguRecby6SR3mInVT78LrEWdMI8LveMlj+lleWG5CDfzmDNi5vpHhKim58fMuJwE7IZM
         2iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658215; x=1726263015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsHQ5h54doNUK/ufVxcrXlo/0lcc6AzIgFEDd9yj2fY=;
        b=bbIUShQ9B6R2ACHH1k4d5HRl4lY4FXXPdhCanfY9iKHqJMxHMAGOlDfrcHQuzZPI80
         m3J5XDRvXYNiifo00xRGBF/J0IkPMiVhVdvV1REjkjR15Rse6kFs56WElzrXh/GT62nr
         /8UvOOLyqK1/MjiejAao7mosXrggJyOpkNiG8bm4dui6Ms28K/8bHmsOwTvjEoUg7qfR
         /pYdcEsxZN3Pfswy5nFu+1bBPYDR5r/p34Ul8rXuTMrZglZ6cJj/ymXBFT/eS5qeD0Tp
         G3PIx2OCHSnB7TmbKSoKd3OBqRcRI+jBI7LXAcvIUaRkVCnKvWOLij8ROz4djmzeoGUY
         vrqA==
X-Forwarded-Encrypted: i=1; AJvYcCV9kwYhmFBOeKkzWXP6UdrC0yMkUhlrnqLIxwKXfdd/3qfj9nS+Ho7/m6PHHseWbHGpcOaMAnej@vger.kernel.org, AJvYcCVwpGozJ9a1JrxQ7Rz5Y8Nrpynrr3f1ikTjjD24nPbb1DU0HmEgcT8SVLunMXCReGoxAsQYUSrRKM6yINF1/z5AQHJsGNKn@vger.kernel.org, AJvYcCXVVTM5JMLp01EmP+RN001YW4GJdhfuavsMS4KQb+pLbw5YsVj+11b/L6vtYMBgHvLNxAtUD/WgxAqKQK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbF/uJv9PkY9kyIvLtPlvn0jlyQbKsbNLNQ34+SCKGPFzQivd4
	fgCQlGoe6RfVZQmn0uzXdz85iu3nZjOSvJ4rAfY9Kioj2cHZVpta
X-Google-Smtp-Source: AGHT+IHlBPJGfsi7DG7bnhqRrXUVLLOWGqvqfg2nr5hiLVWfmhC7Cpgcyq8IeMIPowRRJIv/NNqkCg==
X-Received: by 2002:a17:903:18f:b0:202:cbf:2d6f with SMTP id d9443c01a7336-2070701f045mr12805625ad.57.1725658215407;
        Fri, 06 Sep 2024 14:30:15 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bd1sm47081065ad.247.2024.09.06.14.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:30:14 -0700 (PDT)
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
Subject: [PATCH v4 0/6] landlock: Signal scoping support
Date: Fri,  6 Sep 2024 15:30:02 -0600
Message-Id: <cover.1725657727.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds scoping mechanism for signals.
Closes: https://github.com/landlock-lsm/linux/issues/8

Problem
=======

A sandboxed process is currently not restricted from sending signals
(e.g. SIGKILL) to processes outside the sandbox since Landlock has no
restriction on signals(see more details in [1]).

A simple way to apply this restriction would be to scope signals the
same way abstract unix sockets are restricted.

[1]https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/

Solution
========

To solve this issue, we extend the "scoped" field in the Landlock
ruleset attribute structure by introducing "LANDLOCK_SCOPED_SIGNAL"
field to specify that a ruleset will deny sending any signals from
within the sandbox domain to its parent(i.e. any parent sandbox or
non-sandbox processes).

Example
=======

Create a sansboxed shell and pass the character "s" to LL_SCOPED:
LL_FD_RO=/ LL_FS_RW=. LL_SCOPED="s" ./sandboxer /bin/bash
Try to send a signal(like SIGTRAP) to a process ID <PID> through:
kill -SIGTRAP <PID>
The sandboxed process should not be able to send the signal.

Previous Versions
=================
v3:https://lore.kernel.org/all/cover.1723680305.git.fahimitahera@gmail.com/
v2:https://lore.kernel.org/all/cover.1722966592.git.fahimitahera@gmail.com/
v1:https://lore.kernel.org/all/cover.1720203255.git.fahimitahera@gmail.com/

Tahera Fahimi (6):
  landlock: Add signal scoping control
  selftest/landlock: Signal restriction tests
  selftest/landlock: Add signal_scoping_threads test
  selftest/landlock: Test file_send_sigiotask by sending out-of-bound
    message
  sample/landlock: Support sample for signal scoping restriction
  landlock: Document LANDLOCK_SCOPED_SIGNAL

 Documentation/userspace-api/landlock.rst      |  22 +-
 include/uapi/linux/landlock.h                 |   3 +
 samples/landlock/sandboxer.c                  |  17 +-
 security/landlock/fs.c                        |  17 +
 security/landlock/fs.h                        |   6 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/task.c                      |  59 +++
 .../selftests/landlock/scoped_signal_test.c   | 371 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 9 files changed, 486 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c

-- 
2.34.1


