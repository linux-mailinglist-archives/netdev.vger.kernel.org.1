Return-Path: <netdev+bounces-245411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD0CCD0DF
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99533005B86
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385B2F0661;
	Thu, 18 Dec 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnrpXn0Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DBD2EB866
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080592; cv=none; b=UE5aLEmWPCQu+vmPDhJ0Us5PeS9thaDhsjb4YODnPqdOC3Lgmedh77C8T9vDcJdWgSacIVLS0dv29W5IvIt0MkKqUREGGI+ldONprRZ1Bb9PD+NVbDCFcz1mGIdbGODF1m/0N2/8IKWlOVBCGH6RpC7DPcO69+3ZB32UvRKzQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080592; c=relaxed/simple;
	bh=ZVbV4cHxKwzE/OTdWv+XSyST9XNOqj4gRnN2RmxwTbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SckLVr8uJ3vyugR95leWrKZEciysbipIXKvauEqxnl2c6QlcgLW4Bx/H0nNeGbMnkFfgqBIhtOFAKXw9/BV/j5Yt1qL/GUEA4kO3qT8iE99tij0Iiz4Xcx2QILxzDJrLFZpfbnneHDsVHn6oflDAQ1QVCiPKk6NjaSpRXvHelXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnrpXn0Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d67f1877so11495015ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080590; x=1766685390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClixYCWNobWOKTTO2EkdQNTjUXsGDKj6JmtXIBpSwh4=;
        b=GnrpXn0YD9S3ENThxojkUHxUx0BE80wDcfa4lUBwniFdqDqh6IpZSWaxzfvnI223GY
         VUXY3MnSB6X+DzVUfiQtF5Dk4JIb9mXKUTe7aSVlH37VdCyHH27UE5W9KMfHc+jMNz8b
         hzbEcpW0vSm/Yn4C4VG8KDj1IBFFKmtbkyEhFqQkcxTLP05+5pSxSnXqTHL9qg4F9M2P
         sdxbRbCcyddmqkzrx4XBTr7yBCH69lSRL94jf6DHGknd1xd2PSugFRN6HylmjcR9ibsX
         84GW5xuFXHpP8gG+XWiuQgy+g+0eOoM5C0JIzT9B7Vz5cpP9LKznm70wGpm7IvZTPRxX
         hpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080590; x=1766685390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClixYCWNobWOKTTO2EkdQNTjUXsGDKj6JmtXIBpSwh4=;
        b=rMi/O+Op+x0FwoZkGQmxgPjE8peZBnBm7B/iK4GH9wlr58XYVGhDfcYj42dxMCBu3Q
         xQW7OQwIe1X9mtp4pd4FOD+Y0cnsJlQ0Z71LETcLZSzyteGXaaXgxsake0NYKwawIigH
         A9US3lRS9EHOpWCI2crytkE+1VDhUhxjKiVkEJkNOVb5KiuStwygi5HK/OYx3N4nz67/
         CthhwuElKgemAk7E5ZUy5Jn5c/PPj7Me+NoAJSmeKQs3x2XU4/0lIOmvmf/XNZDCjMO4
         Fvitc8OPEB/mBpHRMkIwDnDERjqEa6Q2twlthFVv2RBo26+QPYHZaqMcD+xJP45CP/gn
         e5jw==
X-Gm-Message-State: AOJu0YzCiIVF9Q8s/iu6+zTv3gFgF3dF3cKsFCVaw3rJ8pAmpDCOpmL0
	uLDss0/LV4P4BBBkKqZnW5KDy3hKpZhA8VW8Vecj2njCMpYAXwkopTTb
X-Gm-Gg: AY/fxX6G1AjvIqdNBLaxNRDLbgEyraKiUnDKmr9AW7c28k50dbpybT0ps5ZlzoqJKR3
	howqANb56CdvaEi9pgfRq8mqnr8S66Agn2Gu6YmaSC/fQQ/5C2x8UrwV9vZdrRlr7eIgLrPWKdo
	43nTsdHRd5K1HcTcm+g9ZpfbYlrlzJk/QSo687QLpVr+3C3knqeJHBSYkdpkbK3fslI4pgqZzPk
	AJTWuiyotwfqnXPi9egs/zYGy+rPa1td4258ZFwmaCegLA3oF/MCiz/2gBJwdRpPHYgUT6jEI5P
	B8+3IWKLr0ifvoXsPvC9THzP4WmYDnUiTYy4ra7MPDPXcR1WgCpZo/LE9fauKyR99pn5tV3K6Kr
	HYga24Rt3dyfzdT28FOH/at1uq6OmvZ6IhqQ4nfjrqB6d+Prvi8X73q7TOHmcWJNNBAu/KXmOlJ
	B9FZvrmp2tKkQDgA==
X-Google-Smtp-Source: AGHT+IGqT5nrjv+12gBTc6qXXnRGrG8DwkqMZO+U8hVQGKbirO7VxPS0h0gmK8z3LYp2itS6RlyHGQ==
X-Received: by 2002:a17:902:f60c:b0:295:888e:9fff with SMTP id d9443c01a7336-2a2f221fa6emr1097575ad.20.1766080589907;
        Thu, 18 Dec 2025 09:56:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c64esm32317395ad.17.2025.12.18.09.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:29 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 00/16] Remove task and cgroup local storage percpu counters
Date: Thu, 18 Dec 2025 09:56:10 -0800
Message-ID: <20251218175628.1460321-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Motivation *

The goal of this patchset is to make bpf syscalls and helpers updating
task and cgroup local storage more robust by removing percpu counters
in them. Task local storage and cgroup storage each employs a percpu
counter to prevent deadlock caused by recursion. Since the underlying
bpf local storage takes spinlocks in various operations, bpf programs
running recursively may try to take a spinlock which is already taken.
For example, when a tracing bpf program called recursively during
bpf_task_storage_get(..., F_CREATE) tries to call
bpf_task_storage_get(..., F_CREATE) again, it will cause AA deadlock
if the percpu variable is not in place.

However, sometimes, the percpu counter may cause bpf syscalls or helpers
to return errors spuriously, as soon as another threads is also updating
the local storage or the local storage map. Ideally, the two threads
could have taken turn to take the locks and perform their jobs
respectively. However, due to the percpu counter, the syscalls and
helpers can return -EBUSY even if one of them does not run recursively
in another one. All it takes for this to happen is if the two threads run
on the same CPU. This happened when BPF-CI ran the selftest of task local
data. Since CI runs the test on VM with 2 CPUs, bpf_task_storage_get(...,
F_CREATE) can easily fail.

The failure mode is not good for users as they need to add retry logic
in user space or bpf programs to avoid it. Even with retry, there
is no guaranteed upper bound of the loop for a success call. Therefore,
this patchset seeks to remove the percpu counter and makes the related
bpf syscalls and helpers more reliable, while still make sure recursion
deadlock will not happen, with the help of resilient queued spinlock
(rqspinlock).


* Implementation *

To remove the percpu counter without introducing deadlock,
bpf_local_storage is refactored by changing the locks from raw_spin_lock
to rqspinlock, which prevents deadlock with deadlock detection and a
timeout mechanism.

The refactor basically repalces the locks with rqspinlock and propagates
errors returned by the locking function to BPF helpers or syscalls.
bpf_selem_unlink_lockless() is introduced to handle rqspinlock errors
in two lock acquiring functions that cannot fail,
bpf_local_storage_destroy() and bpf_local_storage_map_free()
(i.e., local storage is being freed by the subsystem or the map is
being freed).

If not familiar with local storage, the last section briefly describe
the locks and structure of local storage. It also shows the abbreviation
used in the rest of the letter.


* Test *

Task and cgroup local storage selftests have already covered deadlock
caused by recursion. Patch 10 updates the expected result of task local
storage selftests as task local storage bpf helpers can now run on the
same CPU as they don't cause deadlock.


* Patchset organization *

Patch 1-4 convert local storage internal helpers to failable.

Patch 5 changes the locks to rqspinlock and propagate the error
returned from raw_res_spin_lock_irqsave() to BPF heleprs and syscalls.
Temprarily WARN_ON() in map_free and destroy.

Patch 6-8 remove percpu counters in task and cgroup local storage.

Patch 9-11 address the unlikely rqspinlock errors by switching to
bpf_selem_unlink_lockless() in map_free and destory.

Patch 12-15 update selftests.


* Appendix: local storage internal *

There are two locks in bpf_local_storage due to the ownership model as
illustrated in the figure below. A map value, which consists of a
pointer to the map and the data, is a bpf_local_storage_map_data (sdata)
stored in a bpf_local_storage_elem (selem). A selem belongs to a
bpf_local_storage and bpf_local_storage_map at the same time. 
bpf_local_storage::lock (lock_storage->lock in short) protects the list
in a bpf_local_storage and bpf_local_storage_map_bucket::lock (b->lock)
protects the hash bucket in a bpf_local_storage_map.


 task_struct
┌ task1 ───────┐       bpf_local_storage
│ *bpf_storage │---->┌─────────┐
└──────────────┘<----│ *owner  │         bpf_local_storage_elem
                     │ *cache[16]        (selem)              selem
                     │ *smap   │        ┌──────────┐         ┌──────────┐
                     │ list    │------->│ snode    │<------->│ snode    │
                     │ lock    │  ┌---->│ map_node │<--┐ ┌-->│ map_node │
                     └─────────┘  │     │ sdata =  │   │ │   │ sdata =  │
 task_struct                      │     │ {&mapA,} │   │ │   │ {&mapB,} │
┌ task2 ───────┐      bpf_local_storage └──────────┘   │ │   └──────────┘
│ *bpf_storage │---->┌─────────┐  │                    │ │
└──────────────┘<----│ *owner  │  │                    │ │
                     │ *cache[16] │      selem         │ │    selem
                     │ *smap   │  │     ┌──────────┐   │ │   ┌──────────┐
                     │ list    │--│---->│ snode    │<--│-│-->│ snode    │
                     │ lock    │  │ ┌-->│ map_node │   └-│-->│ map_node │
                     └─────────┘  │ │   │ sdata =  │     │   │ sdata =  │
 bpf_local_storage_map            │ │   │ {&mapB,} │     │   │ {&mapA,} │
 (smap)                           │ │   └──────────┘     │   └──────────┘
┌ mapA ───────┐                   │ │                    │
│ bpf_map map │      bpf_local_storage_map_bucket        │
│ *buckets    │---->┌ b[0] ┐      │ │                    │
└─────────────┘     │ list │------┘ │                    │
                    │ lock │        │                    │
                    └──────┘        │                    │
 smap                 ...           │                    │
┌ mapB ───────┐                     │                    │
│ bpf_map map │      bpf_local_storage_map_bucket        │
│ *buckets    │---->┌ b[0] ┐        │                    │
└─────────────┘     │ list │--------┘                    │
                    │ lock │                             │
                    └──────┘                             │
                    ┌ b[1] ┐                             │
                    │ list │-----------------------------┘
                    │ lock │
                    └──────┘
                      ...
  
Changelog:

v2 -> v3
  - Rebase to bpf-next where BPF memory allocator is replaced with
    kmalloc_nolock()
  - Revert to selecting bucket based on selem
  - Introduce bpf_selem_unlink_lockless() to allow unlinking and
    freeing selem without taking locks
  Link: https://lore.kernel.org/bpf/20251002225356.1505480-1-ameryhung@gmail.com/

v1 -> v2
  - Rebase to bpf-next  
  - Select bucket based on local_storage instead of selem (Martin)
  - Simplify bpf_selem_unlink (Martin)
  - Change handling of rqspinlock errors in bpf_local_storage_destroy()
    and bpf_local_storage_map_free(). Retry instead of WARN_ON.
  Link: https://lore.kernel.org/bpf/20250729182550.185356-1-ameryhung@gmail.com/

---

Amery Hung (16):
  bpf: Convert bpf_selem_unlink_map to failable
  bpf: Convert bpf_selem_link_map to failable
  bpf: Open code bpf_selem_unlink_storage in bpf_selem_unlink
  bpf: Convert bpf_selem_unlink to failable
  bpf: Change local_storage->lock and b->lock to rqspinlock
  bpf: Remove task local storage percpu counter
  bpf: Remove cgroup local storage percpu counter
  bpf: Remove unused percpu counter from bpf_local_storage_map_free
  bpf: Save memory allocation method and size in bpf_local_storage_elem
  bpf: Support lockless unlink when freeing map or local storage
  bpf: Switch to bpf_selem_unlink_lockless in
    bpf_local_storage_{map_free, destroy}
  selftests/bpf: Update sk_storage_omem_uncharge test
  selftests/bpf: Update task_local_storage/recursion test
  selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
  selftests/bpf: Remove test_task_storage_map_stress_lookup
  selftests/bpf: Choose another percpu variable in bpf for btf_dump test

 include/linux/bpf_local_storage.h             |  20 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  63 +---
 kernel/bpf/bpf_inode_storage.c                |   7 +-
 kernel/bpf/bpf_local_storage.c                | 311 +++++++++++++-----
 kernel/bpf/bpf_task_storage.c                 | 155 ++-------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  17 +-
 .../bpf/map_tests/task_storage_map.c          | 128 -------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |   8 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ---
 .../bpf/progs/sk_storage_omem_uncharge.c      |  12 +-
 .../bpf/progs/task_storage_nodeadlock.c       |   7 +-
 13 files changed, 294 insertions(+), 480 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


