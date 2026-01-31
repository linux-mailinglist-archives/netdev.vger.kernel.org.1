Return-Path: <netdev+bounces-255344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 89i7OIeOfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:09:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E86FC0AB9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10814300C935
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD49307AD5;
	Sat, 31 Jan 2026 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap4w6iuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4518859B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836164; cv=none; b=gYq3z4ds/ffsc1GpQRxiXvYNbhvaT5p1twR6hcxVctVwtJDT655KgnqxgR5zMpc394g2fNeEffqCdTWq5LadI4A1wS8Qoq+q65bMG4jjxP6PD+s0q6gaex/Qajsv0RPpNA4O2UiRvKf+QM5hPcIcr5kv/krn3xWe+B2yy++q9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836164; c=relaxed/simple;
	bh=8XjcPhCs/+nEWiT7RuyEIahF9DTfBeYYEwjz6gEkaBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eMBjHmSxMf4dtYlqKgbinQqUhX5M9H2lDEni9f/+O22zzRUp6c5+UkpFyEck50Z+hbGWvntljObZcsBugFCibT5zz4SCZswLq56UUTJURon673LoSrlbM0wuirlrwNO9hbDa9r8UJr9qidNU0b26oZbyeeMXyOtwkRnxVgJF8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap4w6iuo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-823081bb15fso1498924b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836162; x=1770440962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMKJeWIN/PSt9u/0sA3A4KXd4+nmvh9FcPJnNWu2vck=;
        b=ap4w6iuomUWYPWLPu3BYzTOTmxfxZi70cMFY2Un6JLsfCqJWCBgOsBbmx1/RXeXxOd
         fqywJrraw3oo2rkbjfEzqO9NfiXMFIp3QTy3j7givcThkf9jvTfgV5rFxH+p5MObrFG1
         No5gFVq9w/+NmW8f1c7dIvUXJR73fGmt/Zu8yO85+rZqAhs5rNJiBfZoNbCIKpI6+NxX
         dXp9Enb8/uL+0I4BvBt97BityZebge82kgxnV4CHSkee6i32FhSEIorwulvz5jW2xch9
         0n9A2ExEPIBZmgeZJja+zSpkF8WLIsxlH3BNwx5c5V5ZXchLfDqIxD8Rbm70ms9CraAj
         ThYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836162; x=1770440962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMKJeWIN/PSt9u/0sA3A4KXd4+nmvh9FcPJnNWu2vck=;
        b=TAbK3S43ceGQkI3ms8brxQ+drSsolzaIBRGo18oBqLaZIHvStsjJ9OUaHabgulGE3E
         L41lD+5zMW6QBZWgEBtk7XelMTuu5AGah+UKhp/LYSNRl5nenrdKMweK/9+lNEZEAEC5
         2pj/lUnHyfSrDuQpJ38iihuPVN9SF/nWy2LPx42Jgq3RQ6pfcD/cOQUce2Wc7jq9c8yE
         XF3i8nPnzqqSTEswsXQgExuWG+1nLp/lBbx8XW4j9K2v1xLeD59VXJmGbtjj10qcGNGx
         Wf2lFpk7p9ENVfZ1Y/qBW2ZaM6xLOtgCQ6faUOXuUrU+yk21yw5OhZRPNlgrlpOG9obq
         f0dQ==
X-Gm-Message-State: AOJu0YyhZJ3/VNTRnHNpgMU2uE2f4ZWqXYCWvODd8dAx75vax4qIFVox
	HjFJYP/M/XvfxPAOYFlZ8OMEWE+23uS8fssXhKBQS8lLTIJFTzROUFTo
X-Gm-Gg: AZuq6aJ+0JkrPuIlyY2+BiqITbz7z62Kg5ckZhghKGiX00Iv9bSQ+6TMzqLz8EWispj
	ToCl0Hit5AbHDr1qxx5FLHTsax1ozyXAvITaIWzz/bzXgtEPIxdImfVPrd/8yJLy/1VAFH8fekS
	/gIUZqkETvIU2W8zHEWhidwnM/VDv/6HQxQfHrmCdwzaUTwljYT1nITvqbsBspYXNl8KnI5wBj9
	+63SRfLAfbH6Hg72PvhObgHhDSaUg90snqW9T5NLXS3L5H1RvNOO2/nIAt1WhLm9l7dIgKSejLJ
	jWlSoBBAPC6xkD4f/KFy5UyYGhkqdMl48XXb9QWp+uBCucV8bfo5Wg6lZ8ZGTfOQCkcCgJPlr16
	TaM04xwQn4aOIstCx+0qIRA5eW+hhTtfDICHG6R3RWMRtacAOQqAeFqPuV0C18SlEGB6I/Ed9jq
	/QmA==
X-Received: by 2002:a05:6a00:4fd6:b0:822:682d:2c5f with SMTP id d2e1a72fcca58-823aa6574ffmr5518783b3a.28.1769836161999;
        Fri, 30 Jan 2026 21:09:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm10180821b3a.14.2026.01.30.21.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:21 -0800 (PST)
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
Subject: [PATCH bpf-next v4 00/16] Remove task and cgroup local storage percpu counters
Date: Fri, 30 Jan 2026 21:09:03 -0800
Message-ID: <20260131050920.2574084-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255344-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3E86FC0AB9
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

* Changelog *

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

 include/linux/bpf_local_storage.h             |  24 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  63 +--
 kernel/bpf/bpf_inode_storage.c                |   7 +-
 kernel/bpf/bpf_local_storage.c                | 387 +++++++++++++-----
 kernel/bpf/bpf_task_storage.c                 | 155 +------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  17 +-
 .../bpf/map_tests/task_storage_map.c          | 128 ------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |   8 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 --
 .../bpf/progs/sk_storage_omem_uncharge.c      |  12 +-
 .../bpf/progs/task_storage_nodeadlock.c       |   7 +-
 13 files changed, 346 insertions(+), 508 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


