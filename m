Return-Path: <netdev+bounces-255647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5zzPFoGSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:50:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4FC6C77
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DA530053CD
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42324E4C4;
	Sun,  1 Feb 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDkFFyiq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7D2BD0B
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968254; cv=none; b=W70mJKZoZBDDu8lZBjCxt02uyCiiFNhR1Fn7pCeD7c7GwTErxPQSfz50+h+xfyiR1MGvPgYQhxzTFzMbb9JdHF4zcyvJ+wCowz73GjmLjGeo+UeinOCCfxl6VdkhuvIR5Flk1DzS+lxDwJDqeMhM4GUcVTt9nZ+99zcb4Y6I34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968254; c=relaxed/simple;
	bh=cg2jzwGRtktucXorh7E51T4BJc6i2Qfqj8YvDRg53gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3COT0Rrpu/zkdaNU8DoS865I91eP6f/ldh6+s54MiXIAV5x4UH0qELvQ3Pm0E7PeH+s7YF3JSKUpIKYGiVooAT44vjxSOy+PQ/NyKosWoOELrRKG3wONhodY18/Sxqm/dSCpytbRTVY1XPzgebIMYVsxjOV6qWAcjDTs1Mkags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDkFFyiq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c227206e6dcso2318449a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968252; x=1770573052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGovWk3eDn9d3GPvSOihLmUJ/7H/QIKO7jdquJXXWrY=;
        b=gDkFFyiqvVPsIxKKG5v4Zbbq451UKghub6WNt5hN1sis7EI1vhND7YffPqYE2hlcpG
         LGzsF6oCyZLI7klGFEKwb+4w69ivIOpZFMnX02BDmoHMOxBYMWqvm/DXm63I4Lrjpzf0
         H0X4mxeAq+VaXrtMobpmSbBfdFVQxjoryorJ7oUmiMejh4sxmIiFHqjiKcUbIuDFBYZw
         vPUwu1onL+/1Fp7rC4R8/Ze5F2NXj+nI8BXLXnWkgj9olKB5WkJ2Gf3zWdBGdnBJfvVp
         F0hcPRYyikAS3eKNt1kQjtKGOsujgiqwZlclZ8PUaHH236yV5vd7cNa9DnZT9C2Z+Iut
         vTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968252; x=1770573052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGovWk3eDn9d3GPvSOihLmUJ/7H/QIKO7jdquJXXWrY=;
        b=ma5525BQld9ThG4bMJfpRMtoxEPXSu2gebSXlJvqUxhqUMYLyv0O3ZXYneM+L1C1rf
         p0jZ2lJNC/9EV8uCEqPjrWf1DyjUf2pmKn9JsbI3uTj5zD8Q3U9B03JGd6ySlLai3UJn
         hKZH91UhCVPZSXhsjyqtABFC6KfkZ4s54kElDK6qI00TpGHsNUvT+xeUHV66ejfpmpVW
         /uaApwyLeySx5JeJuj4TnBsszw4UjmMHywdgQM1rzVHNai9T7YDvgm90UWfExDcX/Zbi
         ov0U/Ydpl1thopF89z/eZoHjfiYUlEQfRJsGhYkx/TvRcia9S61w99ICKeXbTJco7xv5
         AXeA==
X-Gm-Message-State: AOJu0YyJ2XNli6U7K7peErdIMz6eMKop803jxixaX3bof02Cz8dLb/O0
	3tn+E01Df4O3dFsLRjRqii1GNGrOPpMY4AIHWfWBN4Uuz2AIlEAkzznv
X-Gm-Gg: AZuq6aItDTpgtQJAX/HaU1jc/s8jGtTaScs59/QrCiG9UwDmRXUUIwjEIYv5QlDP+2k
	zmL9HUc8IEicUBdbcnGuqbOjmNut2X/PJBQQ/XH/tg0o/S/d6vpdOb2kr0c3tgkLwPFYZkRDBbV
	i4CmJ6zX6OXnVp6lBST8gFwd6Kb0EXaSG7Ax69l55CKs5gzXzW1hJmgIMWII1MJvly+52idSFDX
	441L6GdtlmKq5rJtiZs24KMuS63pWCJ/bB/c3WdhPIWLwfXyXWd9qQVIyIEhhpSrI75zKvbYPZo
	yBpLX+y3CIuCJghwYiTZC/qwMcquH/QwwIY2zvYkyibOxKG+4HTjwuHUCF+YE/W1vtMF87Nb3Gj
	YH7Vda6pjfA0RIzzKf9Ro23qNewgqyi+hbQiiQf5J4JLvOKZPWAZ0fLjiYe9s7k1oI3lReMX8c6
	GUNQ==
X-Received: by 2002:a17:90b:578c:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-3543b3b5d3bmr8250363a91.31.1769968251797;
        Sun, 01 Feb 2026 09:50:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543bc01bc0sm4617042a91.1.2026.02.01.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:51 -0800 (PST)
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
Subject: [PATCH bpf-next v5 00/16] Remove task and cgroup local storage percpu counters
Date: Sun,  1 Feb 2026 09:50:33 -0800
Message-ID: <20260201175050.468601-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255647-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A2D4FC6C77
X-Rspamd-Action: no action

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
bpf_selem_unlink_nofail() is introduced to handle rqspinlock errors
in two lock acquiring functions that cannot fail,
bpf_local_storage_destroy() and bpf_local_storage_map_free()
(i.e., local storage is being freed by the subsystem or the map is
being freed). The high level idea is to refcounting selem when any locks
cannot be acquired. Additional care is needed to make sure special fields
are freed and owner memory are uncharged safely and correctly.

If not familiar with local storage, the last section briefly describe
the locks and structure of local storage. It also shows the abbreviation
used in the rest of the letter.


* Test *

Task and cgroup local storage selftests have already covered deadlock
caused by recursion. Patch 10 updates the expected result of task local
storage selftests as task local storage bpf helpers can now run on the
same CPU as they don't cause deadlock.


* Benchmark *

./bench -p 1 local-storage-create --storage-type <socket,task> \
  --batch-size <16,32,64>

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. No significant change in the performance after swicthing
to rqspinlock and bpf_unlink_selem_nofail().

Socket local storage
                 batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
Before            16    126.346 ± 1.618k/s  3.17 kmallocs/create
                  32    126.683 ± 1.350k/s  3.16 kmallocs/create
                  64    125.899 ± 0.864k/s  3.13 kmallocs/create
                  
After             16    128.398 ± 2.734k/s  3.14 kmallocs/create  +1.0%
                  32    128.123 ± 5.185k/s  3.13 kmallocs/create  +1.1%
                  64    128.135 ± 5.444k/s  3.15 kmallocs/create  +1.8%
                   
Task local storage
                  batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
Before           16     25.008 ± 0.649k/s  2.59 kmallocs/create
                 32     23.616 ± 0.680k/s  2.64 kmallocs/create
                 64     22.858 ± 0.292k/s  2.67 kmallocs/create
               
After            16     25.989 ± 0.083k/s  2.52 kmallocs/create  +3.9%
                 32     24.111 ± 0.402k/s  2.50 kmallocs/create  +2.1%
                 64     23.660 ± 0.252k/s  2.60 kmallocs/create  +3.5%


* Patchset organization *

Patch 1-4 convert local storage internal helpers to failable.

Patch 5 changes the locks to rqspinlock and propagate the error
returned from raw_res_spin_lock_irqsave() to BPF heleprs and syscalls.

Patch 6-8 remove percpu counters in task and cgroup local storage.

Patch 9-11 address the unlikely rqspinlock errors by switching to
bpf_selem_unlink_nofail() in map_free() and destroy().

Patch 12-16 update selftests.


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

* Changelog *

v4 -> v5
  - Patch 1: Fix incorrect bucket calculation (AI)
  - Patch 3: Fix memory leak in bpf_sk_storage_clone() (AI)
  - Patch 5: Fix memory leak in bpf_local_storage_update() (AI)
  - Fix typo/comment/commit msg (AI)
  - Patch 10: Replace smp_rmb() with smp_mb(). smp_rmb does not imply
    acquire semantics
  Link: https://lore.kernel.org/bpf/20260131050920.2574084-1-ameryhung@gmail.com/ 

v3 -> v4
  - Add performance numbers
  - Avoid stale element when calling bpf_local_storage_map_free()
    by allowing it to unlink selem from local_storage->list and uncharge
    memory. Block destroy() from returning when pending map_free()
    are uncharging
  - Fix an -EAGAIN bug in bpf_local_storage_update() as map_free() now
    does not free local storage
  - Fix possible double-free of selem by ensuring an selem is only
    processed once for each caller (Kumar)
  - Fix possible inifinite loop in bpf_selem_unlink_nofail() when
    iterating b->list by replacing while loop with
    hlist_for_each_entry_rcu
  - Fix unsafe iteration in destroy() by iterating local_storage->list
    using hlist_for_each_entry_rcu
  - Fix UAF due to clearing storage_owner after destroy(). Flip the order
    to fix it
  - Misc clean-up suggested by Martin
  Link: https://lore.kernel.org/bpf/20251218175628.1460321-1-ameryhung@gmail.com/

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
  bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
  bpf: Convert bpf_selem_unlink_map to failable
  bpf: Convert bpf_selem_link_map to failable
  bpf: Convert bpf_selem_unlink to failable
  bpf: Change local_storage->lock and b->lock to rqspinlock
  bpf: Remove task local storage percpu counter
  bpf: Remove cgroup local storage percpu counter
  bpf: Remove unused percpu counter from bpf_local_storage_map_free
  bpf: Prepare for bpf_selem_unlink_nofail()
  bpf: Support lockless unlink when freeing map or local storage
  bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free,
    destroy}
  selftests/bpf: Update sk_storage_omem_uncharge test
  selftests/bpf: Update task_local_storage/recursion test
  selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
  selftests/bpf: Remove test_task_storage_map_stress_lookup
  selftests/bpf: Choose another percpu variable in bpf for btf_dump test

 include/linux/bpf_local_storage.h             |  25 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  63 +--
 kernel/bpf/bpf_inode_storage.c                |   7 +-
 kernel/bpf/bpf_local_storage.c                | 386 +++++++++++++-----
 kernel/bpf/bpf_task_storage.c                 | 155 +------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  22 +-
 .../bpf/map_tests/task_storage_map.c          | 128 ------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |  10 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 --
 .../bpf/progs/sk_storage_omem_uncharge.c      |  12 +-
 .../bpf/progs/task_storage_nodeadlock.c       |   7 +-
 13 files changed, 352 insertions(+), 509 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


