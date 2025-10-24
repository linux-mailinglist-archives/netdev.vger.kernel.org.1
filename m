Return-Path: <netdev+bounces-232711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C40C082E8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A028C4E2CB5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A42303CA3;
	Fri, 24 Oct 2025 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7AGt/uL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9F26E17F
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341358; cv=none; b=HgVw1xwZHWJG2m5dP1golcPkjUfwKPlwsK2P9/Zhr2od8d9WQ7srfYcEYhEcucl+FLyUcoNjaZRY8QyhxzQSJr5StP9Jp4lzyMhpVDRmgF6HLtSGRjtKirRXbXG4//setuaZNFa3VCJWge0QysXrBTMqd0Khb426lnbsZR2lm9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341358; c=relaxed/simple;
	bh=JKHDBpg4OBl3lzIIY1CN15+uYY4Wiv50kUjavFwrzAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXF3UiDD1UVDbr2/4OCDUi0PetPCFFFYF234D+faEmED82NuIDFtaQsAvUISUelQxoNISa3GjXZpm9u/yiiS5mJG82fydErEFOPUcibxzlpu2D/GTSvsF6LkBQi8BRD42uE2Ca4sOBm80smiAfSgxnr8MROsdgCeDrFBbweHBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7AGt/uL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cf3174ca4so1739234a12.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761341356; x=1761946156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EU9xH5+UPSAYoVQ8wEDemGogj5Ty2R1EwxfKRHGjQM=;
        b=K7AGt/uLoRWV2pSWGj0YbQ+8Ugtntk7CdCJi1+GHV/kK9K1IRb6CqJmeTjKNlsdXHX
         PbV+ILxlyIk6vMKTZvdFNEJFUCcN67UgDB6p98b/Nnn4zPh+HCUl8EIR6Mb7FUXvNZR+
         pyCcaGEpzBF54BpxXn3PTm/fV70e0GXrhYkcTKCdWsfdRhTxZV/f9M7CT3tJ1prVuZz/
         e6VGUMNIScT4Jx+8fQNCHCOuBNcqpSNeS+bYOs7ViZNA/4hAG5bOpzKXAAHdLlYeEa7h
         3E9A8MxV/btoE1q4dlNwIcIwOpQan70ceA5Hth8KswTd8FkzmwrXHsOgAUHR5p3M7rI5
         EUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341356; x=1761946156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EU9xH5+UPSAYoVQ8wEDemGogj5Ty2R1EwxfKRHGjQM=;
        b=o/iMkiEQ1pw2htu0QuqK9Z/6wiDyFzDYGQ27Gr0BKtt0CMJQWwzChZclGQgx6TvIrt
         W2cQLqAyiorP8gVZM4alvom4rAPOI98jL2qE3PtIG8c2KU02oBSIfk7TOZ6v1KCb4Mqk
         ZxLPn7/XY1Q/9Qyqe6EYd4VIXb2Rc2PDSEy53cnPDxU147woszYMhw9kAfOFq3ZaHwUC
         QiYUhXopxrM6iUVsxfDNhevg9biblaxyE5u8uXd3V/YL4Qt9YOLzqjrEW2A+ih0y49vi
         ra1/Ys60GFIX6nL8NflGpJ/oAzr7dswfZYvt14MyImcGVFtd/l/GdmP9TCxysoP4emjf
         OEkQ==
X-Gm-Message-State: AOJu0YyByP9wBRijo3pazcbvXLfgEJs6fE2LWpjXkx+5Vt+C6I8dTma2
	Fw6bt228S7FxsCdeIrbVitM7Q3zQdfyy0v6k1Giu3B3UnCFIo7HXjI0/
X-Gm-Gg: ASbGncsXQzbEEvPxCesQKMl/U5/YTJON+yTmbyzd2N6Tz7nDhxWzAINwdDclrtb9FRz
	M6tLm2fIzC0WZs4h7YnyLpZ0YbTA0M3irBxjasXIZ5Bep73T4SjhCnD8uMdSLTy4dScna24fSaJ
	58pRtfiEztfYYYADnPGsd4GFBrAJHatSce9YABIwOGzbKwMzMiXPxIu/klWk/HwhwNxS9WXX4ml
	187ZlcDfozj9ZyCstVpmy2TXaKcJrpn+XAgC0gecYDWRjUa1QRZK7MBw38gwTWMcoaHZztUpXI0
	/QipfZfSse024NdclSmvSzoaHVNOCv/vqw/UkFqoGH+0LDy8LJFTo8bkjK2Gi0R0KIbokFh4ss0
	E6K2+oPWbTLKnXvb5xy8ytr6AGhjHbvz3D5Qk7HwNSoFXRU7zMvTxdbrAI3DYlViM+K1KfISmjI
	3K
X-Google-Smtp-Source: AGHT+IHvzcUrPSn44ijYP7d73oQIeq+NCLKotvdG2nU0bknx92ahEQpqtaMR99mZEI9uY6WxXNo8gg==
X-Received: by 2002:a17:903:240d:b0:290:ac36:2ecd with SMTP id d9443c01a7336-290c9ca66famr372510255ad.14.1761341355545;
        Fri, 24 Oct 2025 14:29:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0967fsm2009675ad.26.2025.10.24.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:29:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/6] Support associating BPF programs with struct_ops
Date: Fri, 24 Oct 2025 14:29:08 -0700
Message-ID: <20251024212914.1474337-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 -> v3
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

Hi,

This patchset adds a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to
the bpf() syscall to allow associating a BPF program with a struct_ops.
The command is introduced to address a emerging need from struct_ops
users. As the number of subsystems adopting struct_ops grows, more
users are building their struct_ops-based solution with some help from
other BPF programs. For exmample, scx_layer uses a syscall program as
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
be acquired from a "__prog" argument. The value of the speical
argument will be fixed up by the verifier during verification.

The command conceptually associates the implementation of BPF programs
with struct_ops map, not the attachment. A program associated with the
map will take a refcount of it so that st_ops_assoc always points to a
valid struct_ops struct. struct_ops implementers can use the helper,
bpf_prog_get_assoc_struct_ops to get the pointer. The returned
struct_ops if not NULL is guaranteed to be valid and initialized.
However, it is not guarantted that the struct_ops is attached. The
struct_ops implementer still need to take stepis to track and check the
state of the struct_ops in kdata, if the use case demand the struct_ops
to be attached.

We can also consider support associating struct_ops link with BPF
programs, which on one hand make struct_ops implementer's job easier,
but might complicate libbpf workflow and does not apply to legacy
struct_ops attachment.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L557
[1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L754

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
 kernel/bpf/bpf_struct_ops.c                   |  98 +++++++++
 kernel/bpf/core.c                             |   3 +
 kernel/bpf/syscall.c                          |  46 +++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 ++
 tools/lib/bpf/bpf.c                           |  19 ++
 tools/lib/bpf/bpf.h                           |  21 ++
 tools/lib/bpf/libbpf.c                        |  30 +++
 tools/lib/bpf/libbpf.h                        |  16 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 190 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     |  77 +++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        |  75 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  19 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 18 files changed, 753 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

-- 
2.47.3


