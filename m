Return-Path: <netdev+bounces-101672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2C8FFC92
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A9E289ED6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD7153BC2;
	Fri,  7 Jun 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="axQCC1c6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnZIEtqU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CB153565;
	Fri,  7 Jun 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743875; cv=none; b=Tjxq2uKhgDMiEPuFqeAdOZ09L+2Gkjtjyr7R0TQjzvJGDRA0sPGn2DFXsvxtfbwhAiS8yfP9KXioSZ81RpJKetp07mseB4Kbsh/w+m1F0hUOaoo8X2DeVXSYS1pR0zSe5aqjGPVkuNAzyEWgdp4h5O/aAW9JBOpki1t4p+U+Zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743875; c=relaxed/simple;
	bh=pIvd/UG8cEx2HD52dn68NoQT1ixfLIkF0bK/EZDoj4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdbrEMcSZbJqHxKDq8GBZ7Gz7ABZMCNzWHqrFsA5NJluuWNBkXkAaIAt6sR3cvsr4ZbGuDXzglyS2Yka49zSx8tAR8CVIlMpEGxjq1JwIzvBwNjg7fem6KJC2+fluKLwSC9mgTeceYSQl9VMh1tOtHoAOuBKs4I8PXpSxpymzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=axQCC1c6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnZIEtqU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717743870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GIMJk0s+/GdtxaQIdOpgGsRKBn/6OfM/tdOLMaoEkBA=;
	b=axQCC1c6FeaMEPS7gfnFgQdsue4cQZs7uBZYVKXOeVeFWMxRp9im0/QcsMP+HeWiPQw2do
	eAkO2B64eczhw43QRcrRX+vYVkEGmlDML5iJpIAU65IC0SE0JBMxFhXj23bxZB2OY5CzgY
	yXUqNNDoVNpIzlm0rZP2ZP7DNXKYbo9qR3OFDBMTYmKB5sfEi21epUdYvtqjwoyNz1SF7l
	4dmUyul4xQRJ3tFqlWrPcfFzMNE2o20je9rW3dVXJ1sGmaQSXFYjY77EtsckoPYB5m+3yn
	Vs8JiS09MNRuotAA1I1VHu5kvW0SJ02AbHaK+LPkZqRo6jowbdVn3gN3qQdieg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717743870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GIMJk0s+/GdtxaQIdOpgGsRKBn/6OfM/tdOLMaoEkBA=;
	b=UnZIEtqUWz/CSSyOqnd61ksRl37f4H0rcbfvijQ4gIvwUgsjYvLGPJBjf8s4O0Plzs+opC
	QMI3an4VcQssgKAQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v5 net-next 00/15] locking: Introduce nested-BH locking.
Date: Fri,  7 Jun 2024 08:53:03 +0200
Message-ID: <20240607070427.1379327-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
local_bh_disable() section remains preemtible. As a result high prior
tasks (or threaded interrupts) will be blocked by lower-prio task (or
threaded interrupts) which are long running which includes softirq
sections.

The proposed way out is to introduce explicit per-CPU locks for
resources which are protected by local_bh_disable() and use those only
on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.

The series introduces the infrastructure and converts large parts of
networking which is largest stake holder here. Once this done the
per-CPU lock from local_bh_disable() on PREEMPT_RT can be lifted.

Performance testing. Baseline is net-next as of commit 93bda33046e7a
("Merge branch'net-constify-ctl_table-arguments-of-utility-functions'")
plus v6.10-rc1. A 10GiG link is used between two hosts. The command
   xdp-bench redirect-cpu --cpu 3 --remote-action drop eth1 -e

was invoked on the receiving side with a ixgbe. The sending side uses
pktgen_sample03_burst_single_flow.sh on i40e.

Baseline:
| eth1->?                 9,018,604 rx/s                  0 err,drop/s
|   receive total         9,018,604 pkt/s                 0 drop/s         =
       0 error/s
|     cpu:7               9,018,604 pkt/s                 0 drop/s         =
       0 error/s
|   enqueue to cpu 3      9,018,602 pkt/s                 0 drop/s         =
    7.00 bulk-avg
|     cpu:7->3            9,018,602 pkt/s                 0 drop/s         =
    7.00 bulk-avg
|   kthread total         9,018,606 pkt/s                 0 drop/s         =
 214,698 sched
|     cpu:3               9,018,606 pkt/s                 0 drop/s         =
 214,698 sched
|     xdp_stats                   0 pass/s        9,018,606 drop/s         =
       0 redir/s
|       cpu:3                     0 pass/s        9,018,606 drop/s         =
       0 redir/s
|   redirect_err                  0 error/s
|   xdp_exception                 0 hit/s

perf top --sort cpu,symbol --no-children:
|   18.14%  007  [k] bpf_prog_4f0ffbb35139c187_cpumap_l4_hash
|   13.29%  007  [k] ixgbe_poll
|   12.66%  003  [k] cpu_map_kthread_run
|    7.23%  003  [k] page_frag_free
|    6.76%  007  [k] xdp_do_redirect
|    3.76%  007  [k] cpu_map_redirect
|    3.13%  007  [k] bq_flush_to_queue
|    2.51%  003  [k] xdp_return_frame
|    1.93%  007  [k] try_to_wake_up
|    1.78%  007  [k] _raw_spin_lock
|    1.74%  007  [k] cpu_map_enqueue
|    1.56%  003  [k] bpf_prog_57cd311f2e27366b_cpumap_drop

With this series applied:
| eth1->?                10,329,340 rx/s                  0 err,drop/s
|   receive total        10,329,340 pkt/s                 0 drop/s         =
       0 error/s
|     cpu:6              10,329,340 pkt/s                 0 drop/s         =
       0 error/s
|   enqueue to cpu 3     10,329,338 pkt/s                 0 drop/s         =
    8.00 bulk-avg
|     cpu:6->3           10,329,338 pkt/s                 0 drop/s         =
    8.00 bulk-avg
|   kthread total        10,329,321 pkt/s                 0 drop/s         =
  96,297 sched
|     cpu:3              10,329,321 pkt/s                 0 drop/s         =
  96,297 sched
|     xdp_stats                   0 pass/s       10,329,321 drop/s         =
       0 redir/s
|       cpu:3                     0 pass/s       10,329,321 drop/s         =
       0 redir/s
|   redirect_err                  0 error/s
|   xdp_exception                 0 hit/s

perf top --sort cpu,symbol --no-children:
|   20.90%  006  [k] bpf_prog_4f0ffbb35139c187_cpumap_l4_hash
|   12.62%  006  [k] ixgbe_poll
|    9.82%  003  [k] page_frag_free
|    8.73%  003  [k] cpu_map_bpf_prog_run_xdp
|    6.63%  006  [k] xdp_do_redirect
|    4.94%  003  [k] cpu_map_kthread_run
|    4.28%  006  [k] cpu_map_redirect
|    4.03%  006  [k] bq_flush_to_queue
|    3.01%  003  [k] xdp_return_frame
|    1.95%  006  [k] _raw_spin_lock
|    1.94%  003  [k] bpf_prog_57cd311f2e27366b_cpumap_drop

This diff appears to be noise.

v4=E2=80=A6v5 https://lore.kernel.org/all/20240604154425.878636-1-bigeasy@l=
inutronix.de/:
- Remove the guard() notation as well as __free() within the patches.
  Patch #1 and #2 add the guard definition for local_lock_nested_bh()
  but it remains unused with the series.
  The __free() notation for bpf_net_ctx_clear has been removed entirely.

- Collect Toke's Reviewed-by.

v3=E2=80=A6v4 https://lore.kernel.org/all/20240529162927.403425-1-bigeasy@l=
inutronix.de/:
- Removed bpf_clear_redirect_map(), moved the comment to the caller.
  Suggested by Toke.

- The bpf_redirect_info structure is memset() each time it is assigned.
  Suggested by Toke.

- The bpf_net_ctx_set() in __napi_busy_loop() has been moved from the
  top of the function to begin/ end of the BH-disabled section. This has
  been done to remain in sync with other call sites.
  After adding the memset() I've been looking at the perf-numbers in my
  test-case and I haven't noticed an impact, the numbers are in the same
  range with and without the change. Therefore I kept the numbers from
  previous posting.

- Collected Alexei's Acked-by.

v2=E2=80=A6v3 https://lore.kernel.org/all/20240503182957.1042122-1-bigeasy@=
linutronix.de/:
- WARN checks checks for bpf_net_ctx_get() have been dropped and all
  NULL checks around it. This means bpf_net_ctx_get_ri() assumes the
  context has been set and will segfault if it is not the case.
  Suggested by Alexei and Jesper. This should always work or always
  segfault.

- It has been suggested by Toke to embed struct bpf_net_context into
  task_struct instead just a pointer to it. This would increase the size
  of task_struct by 112 bytes instead just eight and Alexei didn't like
  it due to the size impact with 1m threads. It is a pointer again.

v1=E2=80=A6v2 https://lore.kernel.org/all/20231215171020.687342-1-bigeasy@l=
inutronix.de/:
- Jakub complained about touching networking drivers to make the
  additional locking work. Alexei complained about the additional
  locking within the XDP/eBFP case.
  This led to a change in how the per-CPU variables are accessed for the
  XDP/eBPF case. On PREEMPT_RT the variables are now stored on stack and
  the task pointer to the structure is saved in the task_struct while
  keeping every for !RT unchanged. This was proposed as a RFC in
  	v1: https://lore.kernel.org/all/20240213145923.2552753-1-bigeasy@linutro=
nix.de/

  and then updated

        v2: https://lore.kernel.org/all/20240229183109.646865-1-bigeasy@lin=
utronix.de/
	  - Renamed the container struct from xdp_storage to bpf_net_context.
            Suggested by Toke H=C3=B8iland-J=C3=B8rgensen.
	  - Use the container struct also on !PREEMPT_RT builds. Store the
	    pointer to the on-stack struct in a per-CPU variable. Suggested by
            Toke H=C3=B8iland-J=C3=B8rgensen.

  This reduces the initial queue from 24 to 15 patches.

- There were complains about the scoped_guard() which shifts the whole
  block and makes it harder to review because the whole gets removed and
  added again. The usage has been replaced with local_lock_nested_bh()+
  its unlock counterpart.

Sebastian


