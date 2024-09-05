Return-Path: <netdev+bounces-125311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A558196CB95
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE831F2641F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598FE624;
	Thu,  5 Sep 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXDnBiso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA640184;
	Thu,  5 Sep 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495262; cv=none; b=XmyZ4QMt9kobtRYZQcpmBBj8GK12qiSmCfxLmrRLhDLproI/bSFY2inpHqzmOoUSNcWAulYdU0mfd/+AYNdZvcxREBhWZF9ZUmbVrbj3AQ07N0Nv1y1+ZvL/eITh0IGolnwUuDXuZ2np5+wr6L+5o5zucwaUW88jnCMnAPuy38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495262; c=relaxed/simple;
	bh=qhfENanhYlqO+Tb9devw7AVXsZcEt1vJt7XKABJZUp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ss7nnGHI57Iwq4Xm+W8MbYiTACFtR4+LxSmRsaur4D9+bOdPCVk9in5+seg7an2YkUOTRcdW2drjXvGY3m5/zK1PMNpHfgYxpVSwLBUKXUxho7U20QV9dfrgcR16TcOpoLSdz60XoI37RnfToOKejKyBNce2LTAliaugrc56HHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXDnBiso; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714287e4083so151011b3a.2;
        Wed, 04 Sep 2024 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725495260; x=1726100060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAeF4Hyg0coER913U25Eksuz8dAnYzaOfEwRiEEL0qE=;
        b=EXDnBisov6kN/SzptQid87BCS3umbIUj2oWEEow3/k57tjNfFR/wH8plWL9Giq18YU
         8U12T2GuNjw8T6T4pSDoTgRDPiIAl+9B0MhtulItoEmcuM0tUZKukyShDb9cmO6L2Gik
         olh/OcUe6CeJE8EqzG9a5rUaacpXloWObAj0P6w9l75SoKUzg6JPgHgDAnLdM/ysEZGN
         jzQ3I6itlgHvYhWcyMNHwvt6M2h3O5TfRcvsGMXutWAMsIR/KMzMYYUbom4xewOImI5b
         Wxwjo1J6CjGtxIMlEUXN2uka70GeWig+RnpvzNfCJ9I4YNaDFFRWrlcLrmTe12nEhUiG
         RmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725495260; x=1726100060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAeF4Hyg0coER913U25Eksuz8dAnYzaOfEwRiEEL0qE=;
        b=IuoDlWRKKYVT88guXagK0b0xUzA8lyynfyIfSFePU9YwAZ8x1sQS4pGvbBTW62JzMo
         Ma5cWSzAfFp4nn3kKyv6Uy6xX5Vd6NQHpWA9bcwdzCjsjIvUVHPkMfEsoANgmAci48zP
         fTICSjgZGGyZ4FmxqSuaLcrSTGuY4sFzSieP/6o2K0cRKmtiD7FPBAlsS7Wy4v6BRMz4
         qPF8xnoXnBiGQmZQpzN5ev1TeJHJKUrQliKUFiYHpX94uEbAnNbxn0FJ6J+s7hdckKXc
         h6sE8ciOPgolLHbm0WLhWWq936cQh/mSuV8WT9WbFrifvoU9CJRNAwZosw8YR6EO+SN2
         36fg==
X-Forwarded-Encrypted: i=1; AJvYcCWkKnAt9OFgEZH0P/0eBO5sbsiu6fXbpstjvI1y0hebs6nyc2pfGTpdglsDL+/4svLTyd4DlzSF@vger.kernel.org, AJvYcCX2hMhRiZSVDOuFGkA8lh0gEsPMTqjkmD76xgz+Ig5smL1w9SKATeMM6YBi03J3f4zJA/5igMXCEzyeDp5PQH53cGKfYnqL@vger.kernel.org, AJvYcCXELGEzT4q+gJas9qOjgrk6/HTSxoC5rpGVv6kJ1+3ZaUSbtK/kYBUR75Efb3xkP5ofwLfzfdJMkfxLopc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHrp1MTY+gUj8YbILOGuE3OXkadd/BGQ90eV2yY2rTmL1AD+c
	ZVb/loLppBwmgA/8orWUM/pi0c2fi+OcvcOSR4o2cnAHXaBAXmkX
X-Google-Smtp-Source: AGHT+IHyfjWhUvFw1Huv+dk80Us3saRElnhLngJ5hOHA40vi4UsdUdntl8ZeyERi10edcXy4+Dwz1w==
X-Received: by 2002:a05:6a00:2d07:b0:717:87d6:fdd2 with SMTP id d2e1a72fcca58-71787d6ffe0mr2767467b3a.4.1725495259874;
        Wed, 04 Sep 2024 17:14:19 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm2159781b3a.76.2024.09.04.17.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 17:14:19 -0700 (PDT)
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
Subject: [PATCH v11 0/8] Landlock: Add abstract UNIX socket restriction
Date: Wed,  4 Sep 2024 18:13:54 -0600
Message-Id: <cover.1725494372.git.fahimitahera@gmail.com>
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
abstract UNIX sockets, we introduce
"LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" field to specify that a ruleset
will deny any connection from within the sandbox domain to its parent
(i.e. any parent sandbox or non-sandbox processes).

Example
=======

Starting a listening socket with socat(1):
        socat abstract-listen:mysocket -

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
        LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash

If we try to connect to the listening socket, the connection gets
refused.
        socat - abstract-connect:mysocket --> fails


Notes of Implementation
=======================

* Using the "scoped" field provides enough compatibility and flexibility
  to extend the scoping mechanism for other IPCs(e.g. signals).

* To access the domain of a socket, we use its credentials of the file's
  FD which point to the credentials of the process that created the
  socket (see more details in [3]). Cases where the process using the
  socket has a different domain than the process created it are covered
  in the "outside_socket" test.

[3]https://lore.kernel.org/all/20240611.Pi8Iph7ootae@digikod.net/

Previous Versions
=================
v10:https://lore.kernel.org/all/cover.1724125513.git.fahimitahera@gmail.com/
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

Tahera Fahimi (8):
  Landlock: Add abstract UNIX socket restriction
  selftests/landlock: Add test for handling unknown scope
  selftests/landlock: Add abstract UNIX socket restriction tests
  selftests/landlock: Add tests for UNIX sockets with any address
    formats
  selftests/landlock: Test connected vs non-connected datagram UNIX
    socket
  selftests/landlock: Restrict inherited datagram UNIX socket to connect
  sample/landlock: Add support abstract UNIX socket restriction
  Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI
    version

 Documentation/userspace-api/landlock.rst      |  45 +-
 include/uapi/linux/landlock.h                 |  28 +
 samples/landlock/sandboxer.c                  |  61 +-
 security/landlock/limits.h                    |   3 +
 security/landlock/ruleset.c                   |   7 +-
 security/landlock/ruleset.h                   |  24 +-
 security/landlock/syscalls.c                  |  17 +-
 security/landlock/task.c                      | 136 +++
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  38 +
 tools/testing/selftests/landlock/net_test.c   |  31 +-
 .../landlock/scoped_abstract_unix_test.c      | 993 ++++++++++++++++++
 .../selftests/landlock/scoped_base_variants.h | 154 +++
 .../selftests/landlock/scoped_common.h        |  28 +
 .../scoped_multiple_domain_variants.h         | 154 +++
 .../testing/selftests/landlock/scoped_test.c  |  33 +
 16 files changed, 1709 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
 create mode 100644 tools/testing/selftests/landlock/scoped_base_variants.h
 create mode 100644 tools/testing/selftests/landlock/scoped_common.h
 create mode 100644 tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
 create mode 100644 tools/testing/selftests/landlock/scoped_test.c

-- 
2.34.1


