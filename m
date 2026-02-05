Return-Path: <netdev+bounces-257328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJkBD8oZhWmx8QMAu9opvQ
	(envelope-from <netdev+bounces-257328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:29:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CCF810A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1CB300DE1A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB2336EDB;
	Thu,  5 Feb 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsjRBcPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9293358DA
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330558; cv=none; b=My4OOClJu+bunrh+Mnd9pamKKtF7w7ckZl2zI1iVMX97IpX/rkS0fM/vkkb2C+4mc1UUwg88vTTWvqYKFj8UHydVmGeaodhd8c/sUKNt61PpYB45qxV66CLrM+OFCHvv1bj4+H702zrTkT5KHqS5rX/jV9lZB/enGb374z//8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330558; c=relaxed/simple;
	bh=ek1pZiNwlWxp73FBJuhxzdEUAwew3K9jwcS+K09exts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWG8/GLvJxsZRJN8ukOUq52lGWr2Ntimrpj1WsC+KrN2Y+ebFMqUVIHK1597PGJb40A/y4BT1V+gDY2usGTAsMtOA5feFFR76E02BnMBuFNSPeFOao8Z2gaYo5MwtRz7p3Z3Zq+T6XkBiOxv2X7b+9X2Vab6Tuu3aApsBCb5+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsjRBcPS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8220bd582ddso1075593b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330558; x=1770935358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9X9i4ESD7Gzs5POQM+DOskdWgjqKue10OQAm2j4a7E=;
        b=SsjRBcPSDrdygFXo303n9E6qWaskxlEuekFp+7ObL2kupfjMrjIn0lkW3iwqwFoRx/
         5Lyg+8sEsOhL6h2CqBwQFcLTKU/f9QsM5aHx9AoDnZxvfxsqnGKXPzKupWHyfcN1BkhC
         q8vKBD1cSsSnu1vnpEgjgR36Lsizf3a7iJRSK4/fcWFTxi00kkxXzWHFgAUBJxUoP7Gj
         dnI+hV4rtwmrFopkWn9UC9OCJm7VP6+KXUvM1jV62Z/VSU3TIaqWVzWPCmXhrnRYpoQy
         tOQFGAGPtKxo9XG0zhnJWUW8+F1n2ggOK6W1UiIT1AxOo2Tu16mWYiNNmrM9c0gnldM3
         uhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330558; x=1770935358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9X9i4ESD7Gzs5POQM+DOskdWgjqKue10OQAm2j4a7E=;
        b=DhxrPvvLkVsR0La4aBoHs7AUDCnbYKJTqSepoqjWN+cibqYivaNO7gcUXiVbN4hktu
         Cptb0VmcBiezkWArpyHh6gokrHmX5U6eswaXf0yi8WKw3Zdof8TdxknTRsD+enXeNnIs
         NDfMVE47uMqsA6PIqnLJ2hx0a+66I1DVpcJOSvbFvHSc21aEZUinvt+34MD3gzIAQ9Gk
         QCWLSKE7hn1McZ1SXOFjx7r44gPNXgVTYXssJvAN5aQBtAMr7Uu5KVd5i5RwLj2LzVst
         vuzlNoHMDPRXz70BFBPYMszIQ3raSeWrAnRKbMTgdnIxm8a/K/yTmvPTdXTXzjVmcKGH
         cZNg==
X-Gm-Message-State: AOJu0YwDZtlZ0RgGX+d73ylCQflZsvhZEGe87Oximk4Mbu87Xk5P1fZg
	d5TmjhbHBG3/PGe6qQboaknpOEQaU+SD7k/4uI7whZVnVksYTy78iO+r
X-Gm-Gg: AZuq6aLQ9aaS4j3FTiMEcED7tztlm+wbfJZ3M8mv6HlQzievW0U2D3VVM/1YL5QJ6HZ
	kTdJPq/FThSyIzCBqWYruvKRZ/rpxCVXtcIzwa5jJTCqiX1f54CVQVWVwIYr9frS7W/4EFXnbQo
	jH5MG3ldMmFvzQA7WC/XGEpoZPkEQjl5yQY/MvjUz71+S0ZgWwOq0YQov1V5ceTY/RyNGKA1Ocr
	ADe8Zn4C2mZWewVyVpaw2IXOpb368ky5lhhW1rqn/If20Xvdau1AfH3cOWqmiZUVfxcVLsTvUr6
	cEnxCw/R8Tp+52TKb2PQAExwgmZMmt/bDT9yVLdE6R8Z2RqsRyemKsLyCy9G1+yaMoj79owLu2D
	jabalwOTaOQWt5RSsK9o64VCK+qxrQhuXWQwK/JTfLRlm1BLrRqSqem98XPxG89f1XBWJmkCSbL
	LHXg==
X-Received: by 2002:a05:6a00:2da5:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-82441612beamr450333b3a.14.1770330557948;
        Thu, 05 Feb 2026 14:29:17 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166fb78sm318154b3a.9.2026.02.05.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:17 -0800 (PST)
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
Subject: [PATCH bpf-next v7 00/17] Remove task and cgroup local storage percpu counters
Date: Thu,  5 Feb 2026 14:28:58 -0800
Message-ID: <20260205222916.1788211-1-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257328-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 845CCF810A
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

v6 -> v7
  - Minor comment and commit msg tweaks
  - Patch 9: Remove unused "owner" (kernel test robot)
  - Patch 13: Update comments in task_ls_recursion.c (AI)
  Link: https://lore.kernel.org/bpf/20260205070208.186382-1-ameryhung@gmail.com/

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
 kernel/bpf/bpf_local_storage.c                | 408 ++++++++++++------
 kernel/bpf/bpf_task_storage.c                 | 154 +------
 kernel/bpf/helpers.c                          |   4 -
 net/core/bpf_sk_storage.c                     |  20 +-
 .../bpf/map_tests/task_storage_map.c          | 128 ------
 .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
 .../bpf/prog_tests/task_local_storage.c       |  10 +-
 .../selftests/bpf/progs/local_storage.c       |  19 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 --
 .../bpf/progs/sk_storage_omem_uncharge.c      |  12 +-
 .../selftests/bpf/progs/task_ls_recursion.c   |  14 +-
 .../bpf/progs/task_storage_nodeadlock.c       |   7 +-
 15 files changed, 354 insertions(+), 561 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

-- 
2.47.3


