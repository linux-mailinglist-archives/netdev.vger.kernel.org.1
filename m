Return-Path: <netdev+bounces-243474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7929CA1F69
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 00:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619023007943
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0FF2DC763;
	Wed,  3 Dec 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbOzlubQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611B2BEFE3
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805072; cv=none; b=RcjqN0f2gLMqEuY+McGi0pnF91Rff5JwfOPZrpa9cIZJLx8pxlqFYi8FuAEkAHG57ng4a6JJCzYlRzBHM4TH3xGE4Mtkf+CKhmohjw2p+Is8Rbj7y98s8YTrOl7QF9Tcz1MbRNqhuXrF3snmLmuWZiZA17YLp7RrPGjb4Oc/J2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805072; c=relaxed/simple;
	bh=JepOAw1Q8APuAqTzsOv9af0/tqWodYuLxCG0QothZ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmPYXS20HpKSU0gGTcMs0hbyvmAJV6LejCFkEk2TGbBDKPpOHcIAHuOt7AenURxyMJUoQOMCpYUuHrSfiT0HZ0lTJ9t6PObRoSgmZWSLHKym6cTP5tS9SnLymhlDoz8KeKtym4y58J9mGnFDmL0b0eF6DSbPbPzR6dVKtCR7KRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbOzlubQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29812589890so4540665ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 15:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805070; x=1765409870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TVMlMguNiTYIto8PiOHwp4RWH1Z/21SQruzhxDczSk=;
        b=DbOzlubQ8mp433i3ckB4ow+lhYTcEyVX+W7S8Cen7NFQFskoU9TknkMaj8+Efbl/3w
         STfiG8eocfUaB9mOfAIJPYJ1KGWah/cIOmyAjcH34zr0mjONs03FI5zapXTzOnsLQ4Cp
         gaKNMVu3bb6F54djs3Zcxw2/MVApxmI2YzhSNZuAZA/CE82Uz8ySi6+9qCWzx+c9MzFJ
         sgqZwKGgZYGG5mKtzAIo3GDIaMvW780CcnPJ6vDOiW8VimiQjd156nlUA8q603iPfK8g
         zbpEWRFVUppIonflg5REYpgUWTrU/CUxa+GP9qM3jomAuhI3sv9DhNJBeNms+lsjX2l4
         YxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805070; x=1765409870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TVMlMguNiTYIto8PiOHwp4RWH1Z/21SQruzhxDczSk=;
        b=iYM9KAO7BgxtIMJGy0phVbVGzWjIlSVUacW3qVnNmLTIbclRQQ0iKHUtk+GPmP2rLf
         kBRfdd7CGyeV9DjrAhevLrQcQ5tDR9vUyYdlvB8c8PgUg2CSGr12V+pbwJ3fHENc9bvb
         vZ+SX3jLSxv0Am8ANYbbppNC+Z8wKkSKfTGAJH3YxWWhRneMB22hytxmJiHsDAq88ZXU
         F7Na6XMbrXTcZa5K5X/vImL4Df+LrjPNjb+dNHPr8YGBY3ZplhQ3TLyfRoL6uMK6QTEi
         +cowZOG5THVj+1kGlgkVNyM3o7Jt6GQclkuVrhSjm0dV8THXSkHKK2AGpNWcZKSJBnZc
         xtyA==
X-Gm-Message-State: AOJu0YxG/m1Q49pwRWT3sHcnMXtpipJD53U0YeLQtS8gGoHhk6ZoArfX
	/sP0HeU8WtwSKypXHu1OfJUfSFsluBrjMy9sN6PqXFCZfX9DjAaS8daY
X-Gm-Gg: ASbGnctopZTAL1e/p+MN7lsmmYEzXepWji2ANfpZnXkxjmD0Ej6wTwSYP4ZdkwyjAtT
	bBi9fOGFJ6G+S8UeL1Ex7E9s+V/NHOVM+Sudg3cg1SO0ENl1fh9100cBTdc8A/dw+DgNHDZhnur
	TazjsyBpW3yeAg/ldT+DPq86VaWnn+rw68SsApFdn5gfDK5X63YuX818Lt74V3Ht4FHVvR1LMzh
	dLxmq3uOCudzRYvz7owywpC8Da2QImelhRd9RPLDOCHPQ1eg1XSPZYnRI1JTiurFdID3qxN2E6f
	HOb+F6ReBhcnivwbuZ0NQAj8UuhTULZASkeo2a4VSvb4qnD7XQUbxADlAk5qeoPjmyPqjEEXgyX
	ZUI3DicDzN7vDprcZkUHx7WBEMWcymGakFVLmfHki17xzDYNZYyon+S9sidNWXKVE+DPNS1i6M+
	oii00VLOOlXNrGobQUBZHMr7IF
X-Google-Smtp-Source: AGHT+IHGZtG5QEkOM2H9Vv3vWS1Z1Nyc5fkHbjBfjthSCaic2V4Ljak0EGWGnK9kARvMeKSY0xD1SA==
X-Received: by 2002:a17:903:124d:b0:295:2cb6:f498 with SMTP id d9443c01a7336-29d6833a7fbmr47431535ad.7.1764805070189;
        Wed, 03 Dec 2025 15:37:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40276sm196321885ad.73.2025.12.03.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:49 -0800 (PST)
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
Subject: [PATCH bpf-next v8 0/6] Support associating BPF programs with struct_ops
Date: Wed,  3 Dec 2025 15:37:42 -0800
Message-ID: <20251203233748.668365-1-ameryhung@gmail.com>
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
v7 -> v8
   - Fix libbpf return (Andrii)
   - Follow kfunc _impl suffic naming convention in selftest (Alexei)
   Link: https://lore.kernel.org/bpf/20251121231352.4032020-1-ameryhung@gmail.com/

v6 -> v7
   - Drop the guarantee that bpf_prog_get_assoc_struct_ops() will always return
     an initialized struct_ops (Martin)
   - Minor misc. changes in selftests
   Link: https://lore.kernel.org/bpf/20251114221741.317631-1-ameryhung@gmail.com/

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
 kernel/bpf/bpf_struct_ops.c                   |  88 ++++++++
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
 18 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

-- 
2.47.3


