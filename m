Return-Path: <netdev+bounces-111993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223093470B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172981C21349
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CD358A7;
	Thu, 18 Jul 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awq+TxRF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CE1B86E7;
	Thu, 18 Jul 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276149; cv=none; b=nZJ/w9+pMGRNVyXIRgrpcuKkhkTVeEwXHda2ytWUZDBzLb7LN+U5L6pL2N7AZJeBrZ3sIk8G8zxYc+es2Ge96BP8drFZNPDXt9vi9WW14gWFNBY6WtWuv5XfloiDgzTAy1MFlc8X4ffDSfK8I4i/bxFsv4ahP/higmrvl849La8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276149; c=relaxed/simple;
	bh=xS9HzJ26eapCxsqG22ug07nWyykWP5myd8/Gi2rEkfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LyEF+erlbvc1wnXOskPVGh6xr/D3+M6S8lABfMfZE1bjr0+CoInGgu0UBCLMAupkYUwxpygvHx6La8R4CSsOw/tlOs8pZeFu28RqDTq3Wd02QB5dA0thMMgMCQGk+kcmSAH6mXAz2AEt7vaebQeAp7r7Vs6R+4Kjj7Vfv5ERh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awq+TxRF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so217929a12.2;
        Wed, 17 Jul 2024 21:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721276147; x=1721880947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xfBb1hnVWsV5Z8J/Lq5YU91WCxCZemS1KmpZKl+3DM=;
        b=awq+TxRFtLUIGDFjsG7vjtUUpJkot3aB3Rsa2RqcEb4zXQX2ZUPeLumrWIJIBfmsFg
         2T4hlEz+nTWJXtAezkkVuYZ7dMtacqx2BpRAUYqzXIKyVxHf9oSXAMMwKCQFcISSSq36
         ouJek3ds9PTUN2oBET0nXMUf+6fZifKmz2EHeQntan/bcngUlhbHc5Ye+Ot+LFnP2qK9
         6yPhb7FvC43IDkQ4HviUKRvvaV5RjWhwOelzTndCzfP+FQPs3RlGkvSEUf7gVUL1EX2J
         /qvEQDPWAlx4jwWmYKoHOURgruYe5RQwpBeumwfVhe4/C5qKEW3Bu+6CEpPZPmlmrK4M
         H0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721276147; x=1721880947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xfBb1hnVWsV5Z8J/Lq5YU91WCxCZemS1KmpZKl+3DM=;
        b=C0Mza0RDQbkyMJefHKv2o9swV3n30kwq2kXSlJid/CDbKNZYWBPygGw9Q3AXZkQbPp
         OPVRM+KInLUanofn0+J9C0Eiq9dm0b8GdO9APCPaKDp3o/AjEZ6lsA5F3zOyz7Ofcnsk
         sIjjQ6rd0j+PJwWgqC0SNQ5NH/YrWMS5yO2wWkL+u1LWrr3xIYyrhoNcA3Uvn3J/24x8
         hUF9tAZFVgmc7Sv5CjrAf83UPQ+PnlxllCu+XhXWjoztMdFgzZESWPaJ4Smw6eM9GEmW
         LItg0jbhJph+bWLW0YrWK1Y0J0oi5/F6xuMMQ9uW/Dt+x4xZR9N9ntiY5M2svUqBp3GA
         cEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYZzjhd9QLXJ9+Tjiq1VTgIXd8Tjqhb6+9dZI0OKdBnLxwZL2bOMo5vJEWPrwx6GX2BUg8Of2pu2NWYOI9XARnpDudp8778ac9pLayexfrfw8LptGiCOEAYPnW5uMcez3ir/1J/BRXN/NZ3X6m6/SBvRgFzE9CHJ/Jd/pZUFjaRGapwA9j6vJ4LO1v
X-Gm-Message-State: AOJu0YzDE0Zzh0OuZzYmXRdYMAPO+NGorlDMEekZx5RZEtj8fVAc68FM
	qrpRiOOvXBDhGKuTsxMQyLn2nGhlHkgYegDcwyc2KELL0O7tLdEd
X-Google-Smtp-Source: AGHT+IESaYhpfV02sqOsiWtMIHrOjSqm0AcrATEmKLVT9QNkCxeByy3igBQsB6Kqh7pEJw5O6a//Jg==
X-Received: by 2002:a05:6a20:9147:b0:1c2:8bcf:a38e with SMTP id adf61e73a8af0-1c3fdd338ddmr4456730637.37.1721276147082;
        Wed, 17 Jul 2024 21:15:47 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38dc0sm83152785ad.215.2024.07.17.21.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 21:15:46 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v7 0/4] Landlock: Abstract Unix Socket Scoping Support
Date: Wed, 17 Jul 2024 22:15:18 -0600
Message-Id: <cover.1721269836.git.fahimitahera@gmail.com>
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

[3] https://lore.kernel.org/outreachy/Zmi8Ydz4Z6tYtpY1@tahera-OptiPlex-5000/T/#m8cdf33180d86c7ec22932e2eb4ef7dd4fc94c792

Thanks to Mickaël Salaün and Paul Moore for guiding me through this
implementation.

Previous Versions
=================
v6: https://lore.kernel.org/all/Zn32CYZiu7pY+rdI@tahera-OptiPlex-5000/
and https://lore.kernel.org/all/Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000/
v5: https://lore.kernel.org/all/ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000/
v4: https://lore.kernel.org/all/ZnNcE3ph2SWi1qmd@tahera-OptiPlex-5000/
v3: https://lore.kernel.org/all/ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000/
v2: https://lore.kernel.org/all/ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000/
v1: https://lore.kernel.org/all/ZgXN5fi6A1YQKiAQ@tahera-OptiPlex-5000/


Tahera Fahimi (4):
  Landlock: Add abstract unix socket connect restriction
  selftests/landlock: Abstract unix socket restriction tests
  samples/landlock: Support abstract unix socket restriction
  documentation/landlock: Adding scoping mechanism documentation

 Documentation/userspace-api/landlock.rst      |  23 +-
 include/uapi/linux/landlock.h                 |  29 +
 samples/landlock/sandboxer.c                  |  25 +-
 security/landlock/limits.h                    |   3 +
 security/landlock/ruleset.c                   |   7 +-
 security/landlock/ruleset.h                   |  23 +-
 security/landlock/syscalls.c                  |  14 +-
 security/landlock/task.c                      | 112 +++
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 .../testing/selftests/landlock/ptrace_test.c  | 867 ++++++++++++++++++
 10 files changed, 1088 insertions(+), 17 deletions(-)

-- 
2.34.1


