Return-Path: <netdev+bounces-116202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B572949750
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089A01F21FBC
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8491E376E6;
	Tue,  6 Aug 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llxD0DCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392F129A7E;
	Tue,  6 Aug 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967879; cv=none; b=USU40iYQ1QfNCDMTrchGYkmcC/9FAv4a9c/5TfOSnlJp5aVejzCld4moRFCHp8B6NVzMLOuMBYKIFITD4Q/IzQdhBG1QL2LE/W2/ycxV2bqOWqujz2OxMUOJ3wVY1UXYJiCtZoy4g9wti6VaTD0a6TRk9T1f4XQub9VUNNANNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967879; c=relaxed/simple;
	bh=0ewYccFC+gUsRirqVBgroPLIdoo7vvA0gP/+dnGxjmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVJwcU0gNnMXh+GYxxnQDcWH86lIxbDCAi6ETgqekD+Q08/S2xQQFFghB+jNI1TtgCR3PZp7wRakPR3vLvbFOchAS/GOCHYn+OOwUDfFrHo0DXJFumNL+PLHmTBcMEF+UMLitOsF4D597aoaoLS/UBg2/foSA60ZU4cM/KfV5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llxD0DCb; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ab09739287so540017a12.3;
        Tue, 06 Aug 2024 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967877; x=1723572677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0RBuTc6tLdIB/+vTHorcWL7vaqZKWklEKUMNzfbf8ug=;
        b=llxD0DCb7doM12SRnYegKIeI/9wZUOFzdiBB70JeQM6anDyRjhCjP+zA7xJKOmdXLT
         8YeNB/zXI5zJzyDJKkYiZCuHrfe85iEpDjkPwAuolkXlT6ZRRwyX6ZrMENABc9t8ZWB7
         jJEux8hr1ZZKX4h8gra/wQuem4vvoCP7eSonhFyqrS5ULiPhfiUfR386QmFux3/wYE4w
         qwnDC5n7rPAYtxAWn4Il5YWObu7QAa1Ge4IEsBl0s/h9/3mf1uiWJuSo1nM9iWgl/s9g
         Te/2hnt2rih9zOJueKbDyJm6/8/JNWHAA9ZtZNalTPg/x+VRlIDf4ZRq/bOVAj3KoLG7
         wJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967877; x=1723572677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RBuTc6tLdIB/+vTHorcWL7vaqZKWklEKUMNzfbf8ug=;
        b=Ax2f834C39qQZI9nmY5QGov+wSHHKmDjI7LpdRUyth0jyRZ8fQdPBln8s1pKFQs140
         t51vXbAUN5286SV27uDGBo7eEBAaQ0gTzh2RhMCrduIdYPn0++vor10Ajwkuu8O7tmAc
         NKFWtPcnCRJSWSPAOxqYZGdVyEbYJ5lULCSP6XC44gFatF3/0u24KCVIwbktZs6avOoe
         BNJEElZBDtRyloLBGDqVlRX3X1Teki9ee0IboBdTyNLxZ6YJV0w+2DVv4aab6jmtiJI9
         dQlZe67w4/ZGkZMLIQqsOj7piK8S3afYh9i0t//aYqMmIAZD5owR4DuWsMQ+aSTPIrgj
         J/og==
X-Forwarded-Encrypted: i=1; AJvYcCXndjYN9tDi1WPcBvb1Vz9JK8nL2PrY4z+GboL8VhrVDcMtn/l7/2m+qE7bKMa4PjvHLgVhqM9edYFO0F8BDZcAa+TAfNrGuQPvNOWkQoOK40ugrT66kKrFyUIiKqdgusdRf7aqWdJ7n7VZTproGPh+Oxkq76x9rGVvuDmhuaLZnStnb/d7GNQWzv3I
X-Gm-Message-State: AOJu0Yx+eeNYgDGANOzwYxnovpPDZrjfByBdobCdBfwJKSxdNbrlzB+l
	h1yEezWu+ANP+hTThTSU/A0Pr0+ndlXbBXks4wIQkuFLjU4ZYsag
X-Google-Smtp-Source: AGHT+IEMFDWxG3XriWekADN9wxkPJTTGnTZ26Onx658MWf6fTZ3OlRburIFFPLH7N2CuvRHyAkCeBA==
X-Received: by 2002:a17:902:d501:b0:1fd:9105:7dd3 with SMTP id d9443c01a7336-1ff5750acd3mr176378275ad.64.1722967877035;
        Tue, 06 Aug 2024 11:11:17 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b51esm12829504a91.32.2024.08.06.11.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:11:16 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Landlock: Signal Scoping Support
Date: Tue,  6 Aug 2024 12:10:39 -0600
Message-Id: <cover.1722966592.git.fahimitahera@gmail.com>
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
(e.g. SIGKILL) to processes outside the sandbox since Landlock has
no restriction on signals(see more details in [1]).

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

Tahera Fahimi (4):
  Landlock: Add signal control
  selftest/Landlock: Signal restriction tests
  sample/Landlock: Support signal scoping restriction
  Landlock: Document LANDLOCK_SCOPED_SIGNAL

 Documentation/userspace-api/landlock.rst      |  27 +-
 include/uapi/linux/landlock.h                 |   3 +
 samples/landlock/sandboxer.c                  |  13 +-
 security/landlock/limits.h                    |   2 +-
 security/landlock/task.c                      |  43 +++
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 .../selftests/landlock/scoped_signal_test.c   | 303 ++++++++++++++++++
 7 files changed, 376 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c

-- 
2.34.1


