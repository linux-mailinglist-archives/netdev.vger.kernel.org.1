Return-Path: <netdev+bounces-87479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAAE8A3411
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5838285561
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1014B077;
	Fri, 12 Apr 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG2YHcOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0E14B075
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940768; cv=none; b=nBvixCaKVNyoBfABIPtbrMTpDqvgqGuKbn485jd11LqezFWf1AayjhyWs0gfTuJLGO8PbMS5lMH2eGATjtG95oV5lIoxPqMjns3av6koayh4PvfyJ3C0+5lktqDWW69xKVumqzNxSopePrJs8Z7lHFPIxLAxfHnLqTREyZ8iA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940768; c=relaxed/simple;
	bh=usmj1mNoKthI5m8l3Dk3m0aCP+Dn54ILjAR1+C5OQ2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ETukGXmUVkk3WUtSjzv2h3R5gzQQG2n2djkC8Dd4uGW+YFWKwShojpMK6ZLSPdrPjT+/y6tvHaNOh64VX8pxJzegXThJ3f/Ii2E/mquwmNt67X/8wJj8h1BtbkoFnRtXh+titmclNoIevUxkKhiWxyaEUNyVzvCd1EDRh4ulJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG2YHcOn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6167463c60cso13365577b3.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940765; x=1713545565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQ3wry0bRnSowFxbBNPWKPghb31lBBPlIMBNxACr2OA=;
        b=CG2YHcOni6AEmlQmicX+mS5T8GEIbabjEioW43Twavrb7oS7ALRRZZu5owzqsGNEyR
         qlvHOvHmVpsN3sfYMRIZuz6DRLDwFf7QFj++azKzXYkNlayAh70uxajwA4MYOC4SqdfH
         HMXzKLuQRnHTOZvm+bkY3g6gK8ynJK2d3evXEyD8mVjkHUk2KA5ZRJ0nDIp9WRmJ8Qw8
         QFYWQwXheg1LE1W9HRkznh32p4iGWY1RPK+SNt5LY+m3bgd6PSafZcWg6A91DZ9+Y3RZ
         1G7/ZCepk90a9uLuZxDznMZ2f+XYvIuYatPZgMsYRoURUPk0SATnQ3jULWQVrVAY6AQ5
         ONTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940765; x=1713545565;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQ3wry0bRnSowFxbBNPWKPghb31lBBPlIMBNxACr2OA=;
        b=MLJ/JqLd3S1jACiw20hyajcOS2QGe+kOuk1FcEtX1p6S0/3ccsVZeZ7B2jn9rCbXHC
         27/RLaHfTO3reOfNULXUZOYAv/SPrF5l9hMTLelg2/6ySpqaGnhynBx8KXXoCehOsDFB
         v3CRT7p388cSPU14s14z5HkkK6weiqrdjGo+MfVO05auw5G3hnZLIAlZCIXq5k4it2Yf
         urQnkDRqGn6XqE/M9Xkxj7B8k7pkNYo8FCH7YbTQ0eWJ+EhDbCBJmwa83jREAIayh/30
         ec3trNA+/RmPYNc/ngv+UWwA6s4nosNYLhFe0hct7trcjmNNJ7tNEre4uLgZwvgMzlTj
         z8iA==
X-Forwarded-Encrypted: i=1; AJvYcCUb8dDwKiPLHzWIk/8FNR48Y71V1SlXkk9HJBEEQg4ga+JNe1gr6oJJLatqAEn6C8ZnUC5dalo+JUFRf+MZLdxaVi7RlQ9J
X-Gm-Message-State: AOJu0YzKQbgFGsTZwg/TGGWPKFaqP9o3TJPBDg5OeLgvyclNMgW+QcLq
	bk99X5LP3FOrSiSGNhE2vUJPo7yK8yqWkCv9x9sojzeNaxG1t5vtdPLuSRSt3+g6Cr8i9JBqvQ=
	=
X-Google-Smtp-Source: AGHT+IF9WYo61DUMT0LJwtbVzY7nTOoh6B3GbB8pT2/kXoroFpERZxCmf6idfLJrdqRCRd+UeikUEizhGg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:4c55:0:b0:618:3525:2bb4 with SMTP id
 z82-20020a814c55000000b0061835252bb4mr1435298ywa.3.1712940765015; Fri, 12 Apr
 2024 09:52:45 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:21 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-1-jrife@google.com>
Subject: [PATCH v2 bpf-next 0/6] selftests/bpf: Add sockaddr tests for kernel networking
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds test coverage for BPF sockaddr hooks and their
interactions with kernel socket functions (i.e. kernel_bind(),
kernel_connect(), kernel_sendmsg(), sock_sendmsg(),
kernel_getpeername(), and kernel_getsockname()) while also rounding out
IPv4 and IPv6 sockaddr hook coverage in prog_tests/sock_addr.c.

As with v1 of this patch series, we add regression coverage for the
issues addressed by these patches,

- commit 0bdf399342c5("net: Avoid address overwrite in kernel_connect")
- commit 86a7e0b69bd5("net: prevent rewrite of msg_name in sock_sendmsg()")
- commit c889a99a21bf("net: prevent address rewrite in kernel_bind()")
- commit 01b2885d9415("net: Save and restore msg_namelen in sock_sendmsg")

but broaden the focus a bit.

In order to extend prog_tests/sock_addr.c to test these kernel
functions, we add a set of new kfuncs that wrap individual socket
operations to bpf_testmod and invoke them through set of corresponding
SYSCALL programs (progs/sock_addr_kern.c). Each test case can be
configured to use a different set of "sock_ops" depending on whether it
is testing kernel calls (kernel_bind(), kernel_connect(), etc.) or
system calls (bind(), connect(), etc.).

=======
Patches
=======
* Patch 1 fixes the sock_addr bind test program to work for big endian
  architectures such as s390x.
* Patch 2 introduces the new kfuncs to bpf_testmod.
* Patch 3 introduces the BPF program which allows us to invoke these
  kfuncs invividually from the test program.
* Patch 4 lays the groundwork for IPv4 and IPv6 sockaddr hook coverage
  by migrating much of the environment setup logic from
  bpf/test_sock_addr.sh into prog_tests/sock_addr.c and adds test cases
  to cover bind4/6, connect4/6, sendmsg4/6 and recvmsg4/6 hooks.
* Patch 5 makes the set of socket operations for each test case
  configurable, laying the groundwork for Patch 6.
* Patch 6 introduces two sets of sock_ops that invoke the kernel
  equivalents of connect(), bind(), etc. and uses these to add coverage
  for the kernel socket functions.

=======
Changes
=======
v1->v2
------
* Dropped test_progs/sock_addr_kern.c and the sock_addr_kern test module
  in favor of simply expanding bpf_testmod and test_progs/sock_addr.c.
* Migrated environment setup logic from bpf/test_sock_addr.sh into
  prog_tests/sock_addr.c rather than invoking the script from the test
  program.
* Added kfuncs to bpf_testmod as well as the sock_addr_kern BPF program
  to enable us to invoke kernel socket functions from
  test_progs/sock_addr.c.
* Added test coverage for kernel socket functions to
  test_progs/sock_addr.c.

Link: https://lore.kernel.org/bpf/20240329191907.1808635-1-jrife@google.com/T/#u

Jordan Rife (6):
  selftests/bpf: Fix bind program for big endian systems
  selftests/bpf: Implement socket kfuncs for bpf_testmod
  selftests/bpf: Implement BPF programs for kernel socket operations
  selftests/bpf: Add IPv4 and IPv6 sockaddr test cases
  selftests/bpf: Make sock configurable for each test case
  selftests/bpf: Add kernel socket operation tests

 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 139 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 +
 .../selftests/bpf/prog_tests/sock_addr.c      | 940 +++++++++++++++---
 .../testing/selftests/bpf/progs/bind4_prog.c  |  18 +-
 .../testing/selftests/bpf/progs/bind6_prog.c  |  18 +-
 tools/testing/selftests/bpf/progs/bind_prog.h |  19 +
 .../selftests/bpf/progs/sock_addr_kern.c      |  65 ++
 7 files changed, 1077 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c

-- 
2.44.0.478.gd926399ef9-goog


