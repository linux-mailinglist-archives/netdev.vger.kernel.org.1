Return-Path: <netdev+bounces-115206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12009456C7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354B4285CCD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517B17BAB;
	Fri,  2 Aug 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+wH4J5b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A228FD;
	Fri,  2 Aug 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571389; cv=none; b=VXe0c3oCWc4c40PEDB7Aj6QZXCxgA5o65ydJb00pwKzJsyZ5YWX+sJ7julrJxD5yjRP/aqAikWzzuQUUqIVbHGVw0N2PWOW0WLDH5WuNA1sZWLkowzB5V14/7TLDikMEr5uexUMTXRFIltb89/QvyoKNTnvnaYduKPa1b6UWkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571389; c=relaxed/simple;
	bh=+BmkYUY4FplYkQ1Fdo4rcSxasEfFGNdydNASNR1GMSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fp79g8B74pi9iXILQF2CNYkgMGn31UIDkHVXIZ9yZdu/SWNt4nzvsJu3YqRVUKzgW2ZTIviD8NcmVTVYdQjzPei/y99wwPnHs7N67eGgtdJt0Pa0VAefELltdCYF7K2IVfecE/SGirA39zV+ExlzmG3LhK+5ob4kOZWzBsL96r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+wH4J5b; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2b921c48so6135408b3a.1;
        Thu, 01 Aug 2024 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571387; x=1723176187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87jAKyalWQYEjkVcjCPIrit4kthuulRv/TtpkKf3Fj8=;
        b=O+wH4J5bwcSpUQ37z8UdjKuJYrOfmYL32owv1Y5dwB/g4/FVKTjjtVNukKxPvvnYPR
         fcBytZqKz88nMiP0pEbYwl+To86i9rGrnN4CFe3IVVGrFtNZ2PunJswaiGpFet5T5z9V
         LmOnExlGWG2pXBLdMMUYJZy7iirO7KI1HrwNYiX0qCPgew7VnEbgCiYTWgtMSPE+r9O9
         NVUmaDQ5KGQA8PqCApeSVJGT/6v9TeIQqITckACIdZiq6IxCxrcXa4ueT81ebCyl7ij9
         ZPOK1MF6/lOzaRloLUMm+h68ulyYQVnbeY736C0ITJhX40VOSunz+DZSNRO8ZtjK4pqS
         Ntxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571387; x=1723176187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87jAKyalWQYEjkVcjCPIrit4kthuulRv/TtpkKf3Fj8=;
        b=ewVhUnSiLoJiPRClLJSsoy/lWkFEUFb380Nn+KpITmknoJ57WglOvExLPC4+AKi+im
         urg2OtGEzW1oAPlSI1TwibSYw059fEEzfUoXoYBgXgol208fIEt/fpQSZY4NxZb7arpC
         REs26B3Gk5qudr8UWgAtlFw3CKjrbMFSOrDyWDHg5gfFgjOo3+874KeSVObeK9t7AqX7
         ukDgvPlEg/RHoU9kWUfvxmeYgBJ32UmHw3W3MLY3dxyb+mgwLJy++vEXPuD7sIF28iqv
         haJeznaphz4Cdf0Z9Pdu+7DzlpD4YkGLILywb3wT3piTemQIRHuCld3z96u/7hXQnKqe
         QHbg==
X-Forwarded-Encrypted: i=1; AJvYcCWtNy0PyIEpFv03Xu0CfPnEmx1Q5A1sOT/d0svuU8JRVWNaqY9CgS6KjWvkA3fEC4FsXeEJf3mdDhvN1Y8drimBznSuRE9jpwsv/jZsuur+blRt6u/LnkPQTS/6KjS36SwxYPo1eT2t3knBg96Gh6s4/BAvpn/ax8nBdZxz8Z2NgxGUc4GCoYYOu05z
X-Gm-Message-State: AOJu0YyoT/7a8skOOJdwfmCOS1CjcvmJkYgcjq55zhFope1e0/2UfU2e
	+/R656EmwLlGs+o89VLzM3trhk0C/N7MVNUUkcXKPeVME3QAb4DyDAxRNVPg
X-Google-Smtp-Source: AGHT+IG52+8kacj0yZdlHx1LB4HGbf8WZV2BUzSpcQgNapmwB0WeLFpk3LWzvr/d88yI0SuUgYUahA==
X-Received: by 2002:a05:6a00:914c:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-7106d04618amr2607561b3a.23.1722571387151;
        Thu, 01 Aug 2024 21:03:07 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec41465sm542099b3a.60.2024.08.01.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:03:06 -0700 (PDT)
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
Subject: [PATCH v8 0/4] Landlock: Add abstract unix socket connect
Date: Thu,  1 Aug 2024 22:02:32 -0600
Message-Id: <cover.1722570749.git.fahimitahera@gmail.com>
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
  sample/Landlock: Support abstract unix socket restriction
  Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI
    versioning

 Documentation/userspace-api/landlock.rst      |   33 +-
 include/uapi/linux/landlock.h                 |   30 +
 samples/landlock/sandboxer.c                  |   56 +-
 security/landlock/limits.h                    |    3 +
 security/landlock/ruleset.c                   |    7 +-
 security/landlock/ruleset.h                   |   23 +-
 security/landlock/syscalls.c                  |   14 +-
 security/landlock/task.c                      |  155 +++
 tools/testing/selftests/landlock/base_test.c  |    2 +-
 tools/testing/selftests/landlock/common.h     |   72 ++
 tools/testing/selftests/landlock/fs_test.c    |   34 -
 tools/testing/selftests/landlock/net_test.c   |   31 +-
 .../landlock/scoped_abstract_unix_test.c      | 1136 +++++++++++++++++
 13 files changed, 1518 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c

-- 
2.34.1


