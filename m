Return-Path: <netdev+bounces-256989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MC2HHxAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-256989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EACEF37E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62D83300E3E6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40A2C326A;
	Thu,  5 Feb 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjAi6nel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A7199FAC
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274931; cv=none; b=kw4pclr2bH94q35SK3x3+TbvL7MAV5yrnSKySGpd5ECyOTOsnod0HZSsohOsqI4PV+Ca0hhKSRH4RbgnlAf00ZU82lfoioty7f1vRCcli83YTjrJwKIc1MxScL3ZhpsyfbGp1JC598cfu4xSTjQj++eJ4BjoNnmpIXPfhGDHXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274931; c=relaxed/simple;
	bh=UrofwGf6OeiX/V/L1qUidfJoZvfk2lWfkCfTZvgJDGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pfdzLCTfKep6kzZKufsAjt+iqWVF8hqAnHIu1uT0QWGvSMFx5OcdMQu93Sn9u67SMMoTP+JSQ8bhOSlG+DU1krx2UKvCT+eEFD69fkt/wihZGvpXr/YjRnwrAWpNytuGJbBBn2eVQOMfwNDzIYze7JqASKsi4GwOlWaMT94253A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjAi6nel; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so467094a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274930; x=1770879730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y0ZHmJdDVcWp/j2+6ICbIpI0YI9gGKhxnxL/yoCo7c=;
        b=UjAi6nel4Cn2XvQFPX9Rl75OW/if7r2EBEJMWpetGwaEYWCYRkpLKYgLUYUs8R8/3l
         Qq8XAKe4vSkRUUn0v93WrC40cXQ67/qotnQNYHI4MVOa69ExdMvyscrxs1ylks0po6Eu
         7/rquN1/FBHUw/BiSWvuwoW+A169bA3zOkusAtnUDSPVRFVDiubImUyEvx0HdhUMHVSe
         7A6VnLOH7mRGICzH7uPPy9aI+gDc7X8VOCbDGffxFb/+2Q5fsD9VQRUb6Y/cgSQ9uWh1
         qAnWSZCoa7DqPvmCs7aDsbD9zLB48mGZ6AWBeUNb4F1ZV7CHWZfbG6J3+LVekqDAh+g7
         7bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274930; x=1770879730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y0ZHmJdDVcWp/j2+6ICbIpI0YI9gGKhxnxL/yoCo7c=;
        b=frFHSTf1jAlRCmjaUZPtYCkY+pVd/kYOXvIYSCPHt607ULMqOKI7qG4DgQj36kAlMy
         kbLna87TEMZQ5zs7VsqZXEJz3Q8D5KJiRT1gjLYsWQ4a3ZrE7/Wrgwwc4tWSeCR97xBe
         Fq+Z5xwTkE+slDjcwWhPBBu/L/pVuq215YpzGl6cclWHtXDruloaqOQfcOxjJu9MZFJp
         VooTkXJDy15tve0E+VRjaXDAW7K38q2Up7uzbot3lhWUNA0nNp1ls583O8Nz/XfJjNV3
         rs7lzAkL/JLDd2aVORQSlNpkDDWwJR7cBIQkkSfubXYp/GT7qrplxkHRf5RcKv2FkRyg
         dfUw==
X-Gm-Message-State: AOJu0YwouRvBqqgebONp5D2E3i6WovSi8LbwHmjEX3OO3S7JbCzn2zao
	FIDmk6qchXx/qTvrQxesIdZY9CET9bWLEoBakmbqTRlJS74KMVphbUEb
X-Gm-Gg: AZuq6aKl+VBV7YJBbc6CdDITkFJUMqPkilBQZMv02JvtJqoFEc/iKfwaN5gHxKg2dHO
	bCPRzU9vxcQntvG7G/lAa9Yr9otBnVzqbNnhLXqrgj+O1DkohszToKm/Mtt8LJbuHEfaliYdXpQ
	0EJZL3aciOsLnDMuW54tfIr1VDk76jWjA1K3VL8jgXBCXZZp6PfKyOSiqBNZ5hj20maCwaTLO4N
	CkOKGQCMoFDhjZJQkOmEicUrA35OLB7ZDYf6raXm3SF3TaFeiOtdkohsVQns9eLdl8q4vYT54Zj
	PTy+xtJ0Kb+18ET0FLt2tO4WGzzAX513fi5gTIDHLWrCjIvj6JOYlw94NRViwFKc7ZRSZo6Ov93
	CZhBwK1FIzqXk5AD3sxyctqbnco/XIBY+7E3ozsPqQqlVIc+ArdJdyLcYuH+YoZ2kDuM+NK4Too
	k5
X-Received: by 2002:a17:90b:5446:b0:343:6d82:9278 with SMTP id 98e67ed59e1d1-354871b864fmr5131969a91.30.1770274929900;
        Wed, 04 Feb 2026 23:02:09 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c239c67sm1449442a91.16.2026.02.04.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:09 -0800 (PST)
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
Subject: [PATCH bpf-next v6 00/17] Remove task and cgroup local storage percpu counters
Date: Wed,  4 Feb 2026 23:01:49 -0800
Message-ID: <20260205070208.186382-1-ameryhung@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-256989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04EACEF37E
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
being freed). The high level idea is to bitfiel and atomic operation to
track who is referencing an selem when any locks cannot be acquired.
Additional care is needed to make sure special fields are freed and
owner memory are uncharged safely and correctly.

If not familiar with local storage, the last section briefly describe
the locks and structure of local storage. It also shows the abbreviation
used in the rest of the letter.


* Test *

Task and cgroup local storage selftests have already covered deadlock
caused by recursion. Patch 14 updates the expected result of task local
storage selftests as task local storage bpf helpers can now run on the
same CPU as they don't cause deadlock.


* Benchmark *

./bench -p 1 local-storage-create --storage-type <socket,task> \
  --batch-size <16,32,64>

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. After swicthing to rqspinlock and
bpf_unlink_selem_nofail(), socket local storage creation speed has a
~5% gain. For task local storage, the number remains the same.

Socket local storage
                 batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
Before            16    134.371 ± 0.884k/s  3.12 kmallocs/create
                  32    133.032 ± 3.405k/s  3.12 kmallocs/create
                  64    133.494 ± 0.862k/s  3.12 kmallocs/create
                  
After             16    140.778 ± 1.306k/s  3.12 kmallocs/create  +4.8%
                  32    140.550 ± 2.058k/s  3.11 kmallocs/create  +5.7%
                  64    139.311 ± 0.911k/s  3.13 kmallocs/create  +4.4%
                   
Task local storage
                  batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
Before           16     25.301 ± 0.089k/s   2.43 kmallocs/create
                 32     23.797 ± 0.106k/s   2.51 kmallocs/create
                 64     23.251 ± 0.187k/s   2.51 kmallocs/create
               
After            16     25.307 ± 0.080k/s   2.45 kmallocs/create  +0.0%
                 32     23.889 ± 0.089k/s   2.46 kmallocs/create  +0.0%
                 64     23.230 ± 0.113k/s   2.63 kmallocs/create  -0.1%


* Patchset organization *

Patch 1-4 convert local storage internal helpers to failable.

Patch 5 changes the locks to rqspinlock and propagate the error
returned from raw_res_spin_lock_irqsave() to BPF heleprs and syscalls.

Patch 6-8 remove percpu counters in task and cgroup local storage.

Patch 9-11 address the unlikely rqspinlock errors by switching to
bpf_selem_unlink_nofail() in map_free() and destroy().

Patch 12-17 update selftests.


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

v5 -> v6
  - Redo benchmark
  - Patch 9: Remove storage->smap as it is not used any more
  - Patch 17: Remove storage->smap check in selftests
  - Patch 10, 11: Pass reuse_now = true to bpf_selem_free() and
    bpf_local_storage_free() to allow faster memory reclaim (Martin)
  - Patch 10: Use bitfield instead of refcount to track selem state to
    be more precise, which removes the possibility map_free missing an
    selem (Martin)
  - Patch 10: Allow map_free() to free local_storage and drop
    the change in bpf_local_storage_map_update() (Martin)
  - Patch 11: Simplify destroy() by not deferring work as an owner is
    unlikely to have too many maps that stalls RCU (Martin)
  Link: https://lore.kernel.org/bpf/20260201175050.468601-1-ameryhung@gmail.com/

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

Amery Hung (17):
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
  selftests/bpf: Fix outdated test on storage->smap

 include/linux/bpf_local_storage.h             |  29 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  62 +--
 kernel/bpf/bpf_inode_storage.c                |   6 +-
 kernel/bpf/bpf_local_storage.c                | 407 ++++++++++++------
 kernel/bpf/bpf_task_storage.c                 | 154 +------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  20 +-
 .../bpf/map_tests/task_storage_map.c          | 128 ------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |  10 +-
 .../selftests/bpf/progs/local_storage.c       |  19 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 --
 .../bpf/progs/sk_storage_omem_uncharge.c      |  12 +-
 .../bpf/progs/task_storage_nodeadlock.c       |   7 +-
 14 files changed, 353 insertions(+), 547 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


