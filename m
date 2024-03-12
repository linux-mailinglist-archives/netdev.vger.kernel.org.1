Return-Path: <netdev+bounces-79327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA8878BF6
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 01:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0090B211D3
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 00:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5D63A;
	Tue, 12 Mar 2024 00:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPEqiwD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523824687;
	Tue, 12 Mar 2024 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203813; cv=none; b=pZI9IMdl/pGCxxcl9IuPIRKDyEeWbrp9rQKxs03zevFaJlnlCq4uLmmHkLFFVX4sQ7zR/MryJ/5pihwciy27OMtsJg/Cn3dMWAYkN8DWcVr6cIyLDSR6fstIapo8o6wfKxuSra27hFNnKVgjcl/AaBDnvX5INRKJTN556Ia5a9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203813; c=relaxed/simple;
	bh=tKAUDJRw6CpCHFms5iUDu8kC5V+30VfEW2JZG4adGMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xf0oynCELSTovWz0MDTY0k0JsOSA/VNbbxEmCN9wtmL8fut2H/eiUax5fczxNGex0X7CDyA2E/Cx7tUyCGZpKU+1YbsWZKSA6vM8YWBQRUsLI3Ei1o6NdQOCFs6al3YMm6cKNk6hmMl1T0UEV3VHlehg1zGLjuBjofJaNOeGpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPEqiwD5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso37062305ad.3;
        Mon, 11 Mar 2024 17:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710203810; x=1710808610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX8uBvZD4AKffPJTrsk23iXdoaVCF5CM1k/lf1ZZjDE=;
        b=PPEqiwD5pwsxKT0hsFJqZdoZNjwJ1OCtKBbkFHqvRoBB2RBq/DwdJBZL7/OlaAb5/r
         o0xyJERTcKF6FjmvEj+0gXFu36Ow3K+XDko1ps0BFk1bDZcPLS0Dn6Q6cQbUVPBjsWPL
         9RZBuqPiLIFQ9zYwWfJpeH8Sq/7Rs8VMgJdEsKJxAFMPHzkNoLqBG4Z08HgyiMKPDqJU
         AwoGGALD/8Wh+4B4fk+NJDLTiD2NicoahNrf5zcL4ISgJyHDGWO8D3dcZrtKygInMpaS
         2HgFfo6kaHySDgLnRwYtkv7PnGpz+2LHH0K+6OZU+sBbYLhHzvacSNyKohD7nRevCY5t
         lkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203810; x=1710808610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX8uBvZD4AKffPJTrsk23iXdoaVCF5CM1k/lf1ZZjDE=;
        b=l5iMct+v6R3d51IWQP0Oy7ujU2ZUp1jcbWR9ru3D1fBpjRU1Z0Kchp3ifgDlc1Aapd
         ChhHRde79pSdgnAayfstXxYAvWi/icC/8M1LXCs+m13pgVshUTqkM6y108/I0kP+p/sL
         zw98JWYLVBi2ApBurE+3VD6LDHmlaVrHC8CnWtzaBwERGy+hwFLF86N6zGMFvPW3PzPC
         GVL8OdlByq/yWEIB/KQvHK0oMz4bPKZdlLOoq+JbGgBQIgVEpk24atotoqY8ZMkEsOsv
         HD9h6iLqTRnOQibWoCQjrx28m1P6xndo3No41GLmjGiuZsLkHDpKRhpErmPgNLlp82ab
         R0EA==
X-Forwarded-Encrypted: i=1; AJvYcCUuMkg66wSApsdRXhXPL5x2OaIV2jLhGMz5cDooFLfQpz/QCqi/zo3P8GH2O5ps77Lp+IAB2yWRlFZeUY/Cf4fFmfnpyjqJBHy0KlXLcyIHePF0koyI+T93m6bd
X-Gm-Message-State: AOJu0YwjQQBUUj0u1wmB3r55HvrgXg4LEygqNgoqK9lgzIS1mu84VZ1Q
	ugdqY9/nXIHvY3x7wNMNjKN1jDxFvnF4duaI+yaFWIgRZVCMwQmY
X-Google-Smtp-Source: AGHT+IF453M2j8cVeXwvdt6yGuVMugTkVSLm1RR2AbPGo7CXsL4Yveq9ihzCpd9Utk8CGHkhkF8BPA==
X-Received: by 2002:a17:902:d487:b0:1dd:b77a:70c6 with SMTP id c7-20020a170902d48700b001ddb77a70c6mr542467plg.32.1710203810385;
        Mon, 11 Mar 2024 17:36:50 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:36f6])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001dd7d66aa18sm4991845plg.67.2024.03.11.17.36.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Mar 2024 17:36:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf-next 2024-03-11
Date: Mon, 11 Mar 2024 17:36:46 -0700
Message-Id: <20240312003646.8692-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 59 non-merge commits during the last 9 day(s) which contain
a total of 88 files changed, 4181 insertions(+), 590 deletions(-).

The main changes are:

1) Enforce VM_IOREMAP flag and range in ioremap_page_range and introduce
   VM_SPARSE kind and vm_area_[un]map_pages to be used in bpf_arena,
   from Alexei.

2) Introduce bpf_arena which is sparse shared memory region between bpf
   program and user space where structures inside the arena can have
   pointers to other areas of the arena, and pointers work seamlessly for
   both user-space programs and bpf programs, from Alexei and Andrii.

3) Introduce may_goto instruction that is a contract between the verifier
   and the program. The verifier allows the program to loop assuming it's
   behaving well, but reserves the right to terminate it, from Alexei.

4) Use IETF format for field definitions in the BPF standard
   document, from Dave.

5) Extend struct_ops libbpf APIs to allow specify version suffixes for
   stuct_ops map types, share the same BPF program between several map
   definitions, and other improvements, from Eduard.

6) Enable struct_ops support for more than one page in trampolines,
   from Kui-Feng.

7) Support kCFI + BPF on riscv64, from Puranjay.

8) Use bpf_prog_pack for arm64 bpf trampoline, from Puranjay.

9) Fix roundup_pow_of_two undefined behavior on 32-bit archs, from Toke.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Note, there will be a trivial conflict in verifier_iterating_callbacks.c
take both hunks.

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Barret Rhoden, Björn Töpel, Bui Quang Minh, Christoph 
Hellwig, David Vernet, Eduard Zingerman, Jiri Olsa, John Fastabend, 
"kernelci.org bot", kernel test robot, Kumar Kartikeya Dwivedi, Miguel 
Ojeda, Pasha Tatashin, Pu Lehui, Quentin Monnet, Stanislav Fomichev, 
Yonghong Song

----------------------------------------------------------------

The following changes since commit 4b2765ae410abf01154cf97876384d8a58c43953:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2024-03-02 20:50:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 66c8473135c62f478301a0e5b3012f203562dfa6:

  bpf: move sleepable flag from bpf_prog_aux to bpf_prog (2024-03-11 16:41:25 -0700)

----------------------------------------------------------------
for-netdev

----------------------------------------------------------------
Alexei Starovoitov (26):
      mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
      mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
      bpf: Introduce may_goto instruction
      bpf: Recognize that two registers are safe when their ranges match
      bpf: Add cond_break macro
      selftests/bpf: Test may_goto
      bpf: Allow kfuncs return 'void *'
      bpf: Recognize '__map' suffix in kfunc arguments
      bpf: Plumb get_unmapped_area() callback into bpf_map_ops
      libbpf: Allow specifying 64-bit integers in map BTF.
      bpf: Tell bpf programs kernel's PAGE_SIZE
      Merge branch 'fix-hash-bucket-overflow-checks-for-32-bit-arches'
      mm: Introduce vmap_page_range() to map pages in PCI address space
      bpf: Introduce bpf_arena.
      bpf: Disasm support for addr_space_cast instruction.
      bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
      bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
      bpf: Recognize addr_space_cast instruction in the verifier.
      bpf: Recognize btf_decl_tag("arg: Arena") as PTR_TO_ARENA.
      libbpf: Add __arg_arena to bpf_helpers.h
      libbpf: Add support for bpf_arena.
      bpftool: Recognize arena map type
      bpf: Add helper macro bpf_addr_space_cast()
      selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
      selftests/bpf: Add bpf_arena_list test.
      selftests/bpf: Add bpf_arena_htab test.

Andrii Nakryiko (9):
      selftests/bpf: Extend uprobe/uretprobe triggering benchmarks
      Merge branch 'mm-enforce-ioremap-address-space-and-introduce-sparse-vm_area'
      Merge branch 'bpf-introduce-may_goto-and-cond_break'
      Merge branch 'libbpf-type-suffixes-and-autocreate-flag-for-struct_ops-maps'
      bpftool: rename is_internal_mmapable_map into is_mmapable_map
      selftests/bpf: Add fexit and kretprobe triggering benchmarks
      libbpf: Recognize __arena global variables.
      Merge branch 'bpf-introduce-bpf-arena'
      bpf: move sleepable flag from bpf_prog_aux to bpf_prog

Chen Shen (1):
      libbpf: Correct debug message in btf__load_vmlinux_btf

Dave Thaler (2):
      bpf, docs: Use IETF format for field definitions in instruction-set.rst
      bpf, docs: Rename legacy conformance group to packet

Eduard Zingerman (15):
      libbpf: Allow version suffixes (___smth) for struct_ops types
      libbpf: Tie struct_ops programs to kernel BTF ids, not to local ids
      libbpf: Honor autocreate flag for struct_ops maps
      selftests/bpf: Test struct_ops map definition with type suffix
      selftests/bpf: Utility functions to capture libbpf log in test_progs
      selftests/bpf: Bad_struct_ops test
      selftests/bpf: Test autocreate behavior for struct_ops maps
      libbpf: Sync progs autoload with maps autocreate for struct_ops maps
      selftests/bpf: Verify struct_ops autoload/autocreate sync
      libbpf: Replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
      libbpf: Struct_ops in SEC("?.struct_ops") / SEC("?.struct_ops.link")
      libbpf: Rewrite btf datasec names starting from '?'
      selftests/bpf: Test case for SEC("?.struct_ops")
      bpf: Allow all printable characters in BTF DATASEC names
      selftests/bpf: Test cases for '?' in BTF names

Jiri Olsa (1):
      selftests/bpf: Add kprobe multi triggering benchmarks

Kui-Feng Lee (3):
      bpf, net: validate struct_ops when updating value.
      bpf: struct_ops supports more than one page for trampolines.
      selftests/bpf: Test struct_ops maps with a large number of struct_ops program.

Martin KaFai Lau (2):
      Merge branch 'Allow struct_ops maps with a large number of programs'
      Merge branch 'bpf: arena prerequisites'

Puranjay Mohan (3):
      bpf, riscv64/cfi: Support kCFI + BPF on riscv64
      arm64, bpf: Use bpf_prog_pack for arm64 bpf trampoline
      bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()

Song Yoong Siang (1):
      selftests/bpf: xdp_hw_metadata reduce sleep interval

Toke Høiland-Jørgensen (3):
      bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
      bpf: Fix hashtab overflow check on 32-bit arches
      bpf: Fix stackmap overflow check on 32-bit arches

 .../bpf/standardization/instruction-set.rst        | 535 +++++++++++---------
 arch/arm/mm/ioremap.c                              |   8 +-
 arch/arm64/net/bpf_jit_comp.c                      |  55 +-
 arch/loongarch/kernel/setup.c                      |   2 +-
 arch/mips/loongson64/init.c                        |   2 +-
 arch/powerpc/kernel/isa-bridge.c                   |   4 +-
 arch/riscv/include/asm/cfi.h                       |  17 +
 arch/riscv/kernel/cfi.c                            |  53 ++
 arch/riscv/net/bpf_jit.h                           |   2 +-
 arch/riscv/net/bpf_jit_comp32.c                    |   2 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  14 +-
 arch/riscv/net/bpf_jit_core.c                      |   9 +-
 arch/x86/net/bpf_jit_comp.c                        | 231 ++++++++-
 drivers/pci/pci.c                                  |   4 +-
 include/linux/bpf.h                                |  25 +-
 include/linux/bpf_types.h                          |   1 +
 include/linux/bpf_verifier.h                       |   3 +
 include/linux/filter.h                             |   4 +
 include/linux/io.h                                 |   7 +
 include/linux/vmalloc.h                            |   5 +
 include/uapi/linux/bpf.h                           |  19 +
 kernel/bpf/Makefile                                |   3 +
 kernel/bpf/arena.c                                 | 558 +++++++++++++++++++++
 kernel/bpf/bpf_iter.c                              |   4 +-
 kernel/bpf/bpf_struct_ops.c                        | 141 ++++--
 kernel/bpf/btf.c                                   |  35 +-
 kernel/bpf/core.c                                  |  33 +-
 kernel/bpf/devmap.c                                |  11 +-
 kernel/bpf/disasm.c                                |  14 +
 kernel/bpf/hashtab.c                               |  14 +-
 kernel/bpf/log.c                                   |   3 +
 kernel/bpf/stackmap.c                              |   9 +-
 kernel/bpf/syscall.c                               |  64 ++-
 kernel/bpf/trampoline.c                            |   4 +-
 kernel/bpf/verifier.c                              | 366 +++++++++++---
 kernel/events/core.c                               |   2 +-
 kernel/trace/bpf_trace.c                           |   2 +-
 mm/vmalloc.c                                       |  83 ++-
 net/bpf/bpf_dummy_struct_ops.c                     |  14 +-
 net/ipv4/tcp_cong.c                                |   6 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |   2 +-
 tools/bpf/bpftool/gen.c                            |  31 +-
 tools/bpf/bpftool/map.c                            |   2 +-
 tools/include/uapi/linux/bpf.h                     |  19 +
 tools/lib/bpf/bpf_helpers.h                        |   2 +
 tools/lib/bpf/btf.c                                |   2 +-
 tools/lib/bpf/features.c                           |  22 +
 tools/lib/bpf/libbpf.c                             | 416 ++++++++++++---
 tools/lib/bpf/libbpf.h                             |   2 +-
 tools/lib/bpf/libbpf_internal.h                    |   2 +
 tools/lib/bpf/libbpf_probes.c                      |   7 +
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   2 +
 tools/testing/selftests/bpf/DENYLIST.s390x         |   3 +
 tools/testing/selftests/bpf/Makefile               |   2 +-
 tools/testing/selftests/bpf/bench.c                |  28 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c | 182 +++++--
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |   9 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h      |  67 +++
 tools/testing/selftests/bpf/bpf_arena_common.h     |  70 +++
 tools/testing/selftests/bpf/bpf_arena_htab.h       | 100 ++++
 tools/testing/selftests/bpf/bpf_arena_list.h       |  92 ++++
 tools/testing/selftests/bpf/bpf_experimental.h     |  55 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  26 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.h        |  48 ++
 .../testing/selftests/bpf/prog_tests/arena_htab.c  |  88 ++++
 .../testing/selftests/bpf/prog_tests/arena_list.c  |  68 +++
 .../selftests/bpf/prog_tests/bad_struct_ops.c      |  67 +++
 tools/testing/selftests/bpf/prog_tests/btf.c       |  29 ++
 .../bpf/prog_tests/struct_ops_autocreate.c         | 159 ++++++
 .../bpf/prog_tests/test_struct_ops_module.c        |  33 +-
 .../bpf/prog_tests/test_struct_ops_multi_pages.c   |  30 ++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/arena_htab.c     |  48 ++
 tools/testing/selftests/bpf/progs/arena_htab_asm.c |   5 +
 tools/testing/selftests/bpf/progs/arena_list.c     |  87 ++++
 tools/testing/selftests/bpf/progs/bad_struct_ops.c |  25 +
 .../testing/selftests/bpf/progs/bad_struct_ops2.c  |  14 +
 .../selftests/bpf/progs/struct_ops_autocreate.c    |  52 ++
 .../selftests/bpf/progs/struct_ops_autocreate2.c   |  32 ++
 .../selftests/bpf/progs/struct_ops_module.c        |  21 +-
 .../selftests/bpf/progs/struct_ops_multi_pages.c   | 102 ++++
 tools/testing/selftests/bpf/progs/trigger_bench.c  |  28 ++
 tools/testing/selftests/bpf/progs/verifier_arena.c | 146 ++++++
 .../bpf/progs/verifier_iterating_callbacks.c       | 103 +++-
 tools/testing/selftests/bpf/test_loader.c          |   9 +-
 tools/testing/selftests/bpf/test_progs.c           |  59 +++
 tools/testing/selftests/bpf/test_progs.h           |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   2 +-
 88 files changed, 4181 insertions(+), 590 deletions(-)
 create mode 100644 kernel/bpf/arena.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c

