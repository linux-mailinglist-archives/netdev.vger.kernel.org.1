Return-Path: <netdev+bounces-238791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984BC5F7E0
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 23:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFCE3A03B2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12115302746;
	Fri, 14 Nov 2025 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTpXg+H2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9492D0C76
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158665; cv=none; b=luKXIw0NuUzq+aS+Fqkm8keX53SREv4zdpHTcvUnG0Ffj7yRb4V4Ogp3xNoDj0WEsUgePxhj5jwaaniCC0p6HGVeQSAAv/eUCb7zLCuRa58cjjdTjwI6hf67Acwdy0z2NTAriO9zzX9Ec9tw+hbaUPdcidjgHDwNqGeGwRqO4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158665; c=relaxed/simple;
	bh=Dzmx0YBJyLeugHh/HjszbcoKuh5grFiBKyTcFy/3q/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQ88LJDt6XqLIAGkkN+XGcjfCtbgKmL6IA6SiGg60FWIWyk2Mgl13pltM0Y3BHwKk8ILvblx8o/mYXj54rs6Jp0LZMLDnkBFSm3CIKIE0ycl5es+i5ecLfWz+w+kotVxkIHovgBanq1v0NMk2imVuepKsg4f/Zrka1KuFd2EPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTpXg+H2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34361025290so2025083a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158663; x=1763763463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIJ4sH8KrnjSYwejHwnXnjY+R7Br7R8cnGubWv7YLN0=;
        b=fTpXg+H2zulhZwXVuB2l1LSo9jBqK3+wRgRFfw6uXANfT9x9TqWC/uK+SOvUsTcyUx
         ASoiKwiCQMcLDgNRJZ0brxidsI9mX1SHrNw8yhL04PnqFjFsORUb/f/ZRu8aXlkVglg+
         6ffEFCTrctKRI3wiaXDqg4Ta1h8NC2vec7z6y7lICRKRWZhgD5Y8uAYMcC3+slfl0h+I
         GG4fxkbxlTwFkAFj7kBmxu+HBhGoXqfMzqhPBQfl6VVqxuyjPUkebgnXOZFuaXB0kmFu
         bgGLeU6nK5iD/W3z3NhR+VhiPoW6TtL/gt5X29eFYWxot7N+gj4cXi5hyxyBaMrQ3whI
         9Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158663; x=1763763463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIJ4sH8KrnjSYwejHwnXnjY+R7Br7R8cnGubWv7YLN0=;
        b=AdZTHjOud6sJOArTZysrbIpUMvgCe0fBvlh9Gw0k07TzMvSsCljpCPQr5/uwSoDxj7
         OazmSBJv/B+LnySF44/t5ZJtzKZGgAyrLdUxs/6XAp5zBkDnr9YmSuzppVajxwODhTaz
         BSOI/a37bu68tXCzyYKk2vdKSLHBI1NB+GFMPQlsTTJu2WDGJdG+HjDautz6mwv0tQdk
         N9YL7tirC/rdJVxOGmMGkN9roajbQB+NzrhgGb2hsXqrXw0FalCOFIKn25FX6IM71YEN
         yA+fX8jfSndiSjlnws0Ly6T+EiCblWdpQICi15a89uZfgD9Ozbl9h+lbKivUgctZ4s6S
         /4wQ==
X-Gm-Message-State: AOJu0YyY6xli4Wq4QgEangmCOhngH2uog5IM8nmmtI9NmVkJEzJvnuXe
	5i6g6HA39zqgY700MAFCYBdW2pwpUGrTlEqOY92Y5KxWCe2WtkzqDRwe
X-Gm-Gg: ASbGnctSrue9qFEBvR643GVvsUPDRiN7d7wAzmvvWCETd963mz90Rzu1G39xiDAY4hS
	JBMHxfpASnthvD8/F7Z34UCijMZGkf8kvdL6sNOGXvOSEfvcHLT+YmGSfS7ODxWGJD+5d8nVREG
	Rx0evhkn0Bp5ecyf4MaQ3m0NbGvQseMokj66bw83sLuhOAyr+ZvJBHJmrARFuHQMLdkVQ0Ky+g0
	oB6ZKMG9SGnp5OezoljHYnV0/1U0u/jiqteVVFa+FRLPPdN4NVcntELS9b09Ior3Ymiexg9Bv7z
	DlteFVl1IuswEnIXGjSyIsKXG2FrFLFp31NvoUU/Pk6rZ2MgireG/zSnRQ13bRJw2WHv1aTPCh4
	Tt8D54gHhbVvDPEQHzeEJo4AYkt0YR5WcMKhkNECh3fkhRKDE3JMErC3sabeVKLu1/+eMP9NOx/
	xwrgk=
X-Google-Smtp-Source: AGHT+IF6Cnknnt0DiYSboO3T3fLnYTky9FlLP4usktu2QdJMJ/eApKLyCMfz/X/OUV6+hEoD9+uKJQ==
X-Received: by 2002:a17:90a:e185:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-343fa6373c5mr5158804a91.26.1763158662580;
        Fri, 14 Nov 2025 14:17:42 -0800 (PST)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f0eesm1568894a91.7.2025.11.14.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:42 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 0/7] Support associating BPF programs with struct_ops
Date: Fri, 14 Nov 2025 14:17:35 -0800
Message-ID: <20251114221741.317631-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset adds a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to
the bpf() syscall to allow associating a BPF program with a struct_ops.
The command is introduced to address a emerging need from struct_ops
users. As the number of subsystems adopting struct_ops grows, more
users are building their struct_ops-based solution with some help from
other BPF programs. For example, scx_layer uses a syscall program as
a user space trigger to refresh layers [0]. It also uses tracing program
to infer whether a task is using GPU and needs to be prioritized [1]. In
these use cases, when there are multiple struct_ops instances, the
struct_ops kfuncs called from different BPF programs, whether struct_ops
or not needs to be able to refer to a specific one, which currently is
not possible.

The new BPF command will allow users to explicitly associate a BPF
program with a struct_ops map. The libbpf wrapper can be called after
loading programs and before attaching programs and struct_ops.

Internally, it will set prog->aux->st_ops_assoc to the struct_ops
map. struct_ops kfuncs can then get the associated struct_ops struct
by calling bpf_prog_get_assoc_struct_ops() with prog->aux, which can
be acquired from a "__prog" argument. The value of the special
argument will be fixed up by the verifier during verification.

The command conceptually associates the implementation of BPF programs
with struct_ops map, not the attachment. A program associated with the
map will take a refcount of it so that st_ops_assoc always points to a
valid struct_ops struct. struct_ops implementers can use the helper,
bpf_prog_get_assoc_struct_ops to get the pointer. The returned
struct_ops if not NULL is guaranteed to be valid and initialized.
However, it is not guaranteed that the struct_ops is attached. The
struct_ops implementer still need to take steps to track and check the
state of the struct_ops in kdata, if the use case demand the struct_ops
to be attached.

We can also consider support associating struct_ops link with BPF
programs, which on one hand make struct_ops implementer's job easier,
but might complicate libbpf workflow and does not apply to legacy
struct_ops attachment.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L557
[1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L754

---

v5 -> v6
   - Drop refcnt bumping for async callbacks and add RCU annotation (Martin)
   - Fix libbpf bug and update comments (Andrii)
   - Fix refcount bug in bpf_prog_assoc_struct_ops() (AI)
   Link: https://lore.kernel.org/bpf/20251104172652.1746988-1-ameryhung@gmail.com/


v4 -> v5
   - Simplify the API for getting associated struct_ops and dont't
     expose struct_ops map lifecycle management (Andrii, Alexei)
   Link: https://lore.kernel.org/bpf/20251024212914.1474337-1-ameryhung@gmail.com/

v3 -> v4
   - Fix potential dangling pointer in timer callback. Protect
     st_ops_assoc with RCU. The get helper now needs to be paired with
     bpf_struct_ops_put()
   - The command should only increase refcount once for a program
     (Andrii)
   - Test a struct_ops program reused in two struct_ops maps
   - Test getting associated struct_ops in timer callback
   Link: https://lore.kernel.org/bpf/20251017215627.722338-1-ameryhung@gmail.com/

v2 -> v3
   - Change the type of st_ops_assoc from void* (i.e., kdata) to bpf_map
     (Andrii)
   - Fix a bug that clears BPF_PTR_POISON when a struct_ops map is freed
     (Andrii)
   - Return NULL if the map is not fully initialized (Martin)
   - Move struct_ops map refcount inc/dec into internal helpers (Martin)
   - Add libbpf API, bpf_program__assoc_struct_ops (Andrii)
   Link: https://lore.kernel.org/bpf/20251016204503.3203690-1-ameryhung@gmail.com/

v1 -> v2
   - Poison st_ops_assoc when reusing the program in more than one
     struct_ops maps and add a helper to access the pointer (Andrii)
   - Minor style and naming changes (Andrii)
   Link: https://lore.kernel.org/bpf/20251010174953.2884682-1-ameryhung@gmail.com/

---

Amery Hung (6):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  libbpf: Add support for associating BPF program with struct_ops
  selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
  selftests/bpf: Test ambiguous associated struct_ops
  selftests/bpf: Test getting associated struct_ops in timer callback

 include/linux/bpf.h                           |  16 ++
 include/uapi/linux/bpf.h                      |  17 ++
 kernel/bpf/bpf_struct_ops.c                   |  92 +++++++++
 kernel/bpf/core.c                             |   3 +
 kernel/bpf/syscall.c                          |  46 +++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 ++
 tools/lib/bpf/bpf.c                           |  19 ++
 tools/lib/bpf/bpf.h                           |  21 ++
 tools/lib/bpf/libbpf.c                        |  31 +++
 tools/lib/bpf/libbpf.h                        |  16 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 191 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     |  77 +++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        |  75 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 18 files changed, 747 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

-- 
2.47.3


