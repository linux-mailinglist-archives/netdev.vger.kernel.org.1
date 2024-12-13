Return-Path: <netdev+bounces-151912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E09F19EE
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AACC188D981
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99B1EF09A;
	Fri, 13 Dec 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XlSYdVyP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A31E571B
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132604; cv=none; b=aNQS66ZMrZSoYhYyuilpw6mFsmwVqMdiZNaxQquXAFW9I+jRPwmCOjozs63FPdzjUnH1z7sfGM2NIm5YnwxcsU9JQIo/ygdIgXp9TmCgKmEF6TO83ONiLlBWM7xFqSJw3LV0aL0GOmOkF+qAaApbwQHyvwdJU+9TzTPSKIGEV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132604; c=relaxed/simple;
	bh=cG/JycwS3zQflQlpRYVHzUkgPDc+z9hgfuV97hgVKcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lJku5gUma5YrP/4xq7m6b+BqDKyl+1WBEvsY89NAjUE3kjb57YohIOxrTef1V1RBZoyYP9HIes4gte76jW4VZcCkrpwtnWESaVnPHzk00Vy5i/FOBgTtZMO1SeeHHyJSBJWQ++h+K15fHTZTdzRy40Dk1C74ZPCIUnJqv0fIGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XlSYdVyP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6e24aa0dbso174711985a.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132600; x=1734737400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUoOwE7tZbDAomkC7fsi/mlJBzVHztERWnTUpGvWsq0=;
        b=XlSYdVyPip0Ch6fUge90XvQZvddyP+D2guQ7w02W57+7lktsLQUMfMNKtMth6Cg/jk
         MfMZn6wfj1nCxO8oY11A25RUEXWVHpuXCv1y8Ua0mOvJB9M5am/P0XJ4I+sa+uNlfzm5
         JnmZnNKbFZXYp9qtHrqUcQ/gemadv3hZXG40mBloqAF4RgtRHWroNn7nTtmMNUx3P03/
         1AmpIzFuEwZAuZ1sVwUo7d+TRPGhXV2LePA/HINp3q69wpnjAu3Ba2ArX4Hhj8ET3M4m
         jUzFxdNEi7fnwijMYh5uJeS17/xx393XGSrOwdQdRKB6JulfKrVSUu1U02S5aQgVl2IG
         8VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132600; x=1734737400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUoOwE7tZbDAomkC7fsi/mlJBzVHztERWnTUpGvWsq0=;
        b=EkXJvxAn6zyNtj50KhPkuZhlbic2VxZnwWO1t6LpZIRTDGCwy4JmDI3Asp+pQXvsSt
         I32URIjsDgy4xiSl9+2T3b2hC1kaxsD+IklUU+2SQtFXUoqx5UVA3Y+HbUAq/EmMnDxA
         lDR1uV9fOPUMud7ixA9Y5hX+18tofUG/t8F8g4HKtBsmXY6GCKEA+LV8aqkPWw+nXTds
         2NUIGb63MjU78klidG4ALXgLVZgcymmoia0Gl/bzJY352/vXXWIm61EBMU8Y3mA3EpBD
         Yk92FvO/jH7WIvGGwa6OCsJqvFe2hk05ynY3GsjSXlI5BzheCxPQS1TDC6zyxbVXNYPB
         9LBQ==
X-Gm-Message-State: AOJu0YzfMrSNa1f9rC0oRfo++uZ29NlubO1cgsuaHQjWeyd9YG6r12W7
	9oq3sj6nz1HX+obpGtdfLMSMODXS/f1PwjBhSvx7zdV0YHJfug6ttqS4J9kUYzqiqNSnsg9hIcv
	P/JE=
X-Gm-Gg: ASbGncvpgAIKchYC1N4GKThtcIAR7FA1lATsSd6Jaj0aOKbC5LPZKhstd+aQYipZjk6
	LkhgZFnNU1ajxmsDwVWOsT1jCaiYczSRs7ostYK9u4BdP2BQLJ6hPbP2m/cz5XJ6i6wp2ApyUfr
	Eztw//y6xdc8NeDwKK+JAOBqwwi17bhDHhH6M/ysqIbzIZBxV3tD56imx/OpB97L5vOUguWHDQC
	t9+IAyDx3BAkZyVfVwh315xzMg5g6oCVGMrYQskpg0io6nLoD/p49rgcrG/SDgN4ACxVA6RygBn
X-Google-Smtp-Source: AGHT+IF+6vRhoRc39hVrmunM8VDgLbfyri9ELaaL8BL8ZoRhNqPJq/Of71BCbILOJNLoENhKeAW2Bg==
X-Received: by 2002:a05:620a:8807:b0:79d:759d:4016 with SMTP id af79cd13be357-7b6fbeca5aemr672694585a.11.1734132599725;
        Fri, 13 Dec 2024 15:29:59 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:29:59 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 00/13] bpf qdisc
Date: Fri, 13 Dec 2024 23:29:45 +0000
Message-Id: <20241213232958.2388301-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patchset aims to support implementing qdisc using bpf struct_ops.
This version takes a step back and only implements the minimum support
for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
directly and 2) classful qdisc are deferred to future patchsets.

* Overview *

This series supports implementing qdisc using bpf struct_ops. bpf qdisc
aims to be a flexible and easy-to-use infrastructure that allows users to
quickly experiment with different scheduling algorithms/policies. It only
requires users to implement core qdisc logic using bpf and implements the
mundane part for them. In addition, the ability to easily communicate
between qdisc and other components will also bring new opportunities for
new applications and optimizations.

* struct_ops changes *

To make struct_ops works better with bpf qdisc, two new changes are
introduced to bpf specifically for struct_ops programs. Frist, we
introduce "ref_acquired" postfix for arguments in stub functions in
patch 1-2. It will allow Qdisc_ops->enqueue to acquire an referenced kptr
to an skb just once. Through the reference object tracking mechanism in
the verifier, we can make sure that the acquired skb will be either
enqueued or dropped. Besides, no duplicate references can be acquired.
Then, we allow a reference leak in struct_ops programs so that we can
return an skb naturally. This is done and tested in patch 3 and 4.

* Performance of bpf qdisc *

We tested several bpf qdiscs included in the selftests and their in-tree
counterparts to give you a sense of the performance of qdisc implemented
in bpf.

The implementation of bpf_fq is fairly complex and slightly different from
fq so later we only compare the two fifo qdiscs. bpf_fq implements the
same fair queueing algorithm in fq, but without flow hash collision
avoidance and garbage collection of inactive flows. bpf_fifo uses a single
bpf_list as a queue instead of three queues for different priorities in
pfifo_fast. The time complexity of fifo however should be similar since the
queue selection time is negligible.

Test setup:

    client -> qdisc ------------->  server
    ~~~~~~~~~~~~~~~                 ~~~~~~
    nested VM1 @ DC1               VM2 @ DC2

Throghput: iperf3 -t 600, 5 times

      Qdisc        Average (GBits/sec)
    ----------     -------------------
    pfifo_fast       12.52 ± 0.26
    bpf_fifo         11.72 ± 0.32 
    fq               10.24 ± 0.13
    bpf_fq           11.92 ± 0.64 

Latency: sockperf pp --tcp -t 600, 5 times

      Qdisc        Average (usec)
    ----------     --------------
    pfifo_fast      244.58 ± 7.93
    bpf_fifo        244.92 ± 15.22
    fq              234.30 ± 19.25
    bpf_fq          221.34 ± 10.76

Looking at the two fifo qdiscs, the 6.4% drop in throughput in the bpf
implementatioin is consistent with previous observation (v8 throughput
test on a loopback device). This should be able to be mitigated by
supporting adding skb to bpf_list or bpf_rbtree directly in the future.

* Clean up skb in bpf qdisc during reset *

The current implementation relies on bpf qdisc implementors to correctly
release skbs in queues (bpf graphs or maps) in .reset, which might not be
a safe thing to do. The solution as Martin has suggested would be
supporting private data in struct_ops. This can also help simplifying
implementation of qdisc that works with mq. For examples, qdiscs in the
selftest mostly use global data. Therefore, even if user add multiple
qdisc instances under mq, they would still share the same queue. 

---
v1:
    Fix struct_ops referenced kptr acquire/return mechanisms
    Allow creating dynptr from skb
    Add bpf qdisc kfunc filter
    Support updating bstats and qstats
    Update qdiscs in selftest to update stats
    Add gc, handle hash collision and fix bugs in fq_bpf

past RFCs

v9: Drop classful qdisc operations and kfuncs
    Drop support of enqueuing skb directly to bpf_rbtree/list
    Link: https://lore.kernel.org/bpf/20240714175130.4051012-1-amery.hung@bytedance.com/

v8: Implement support of bpf qdisc using struct_ops
    Allow struct_ops to acquire referenced kptr via argument
    Allow struct_ops to release and return referenced kptr
    Support enqueuing sk_buff to bpf_rbtree/list
    Move examples from samples to selftests
    Add a classful qdisc selftest
    Link: https://lore.kernel.org/netdev/20240510192412.3297104-15-amery.hung@bytedance.com/

v7: Reference skb using kptr to sk_buff instead of __sk_buff
    Use the new bpf rbtree/link to for skb queues
    Add reset and init programs
    Add a bpf fq qdisc sample
    Add a bpf netem qdisc sample
    Link: https://lore.kernel.org/netdev/cover.1705432850.git.amery.hung@bytedance.com/

v6: switch to kptr based approach

v5: mv kernel/bpf/skb_map.c net/core/skb_map.c
    implement flow map as map-in-map
    rename bpf_skb_tc_classify() and move it to net/sched/cls_api.c
    clean up eBPF qdisc program context

v4: get rid of PIFO, use rbtree directly

v3: move priority queue from sch_bpf to skb map
    introduce skb map and its helpers
    introduce bpf_skb_classify()
    use netdevice notifier to reset skb's
    Rebase on latest bpf-next

v2: Rebase on latest net-next
    Make the code more complete (but still incomplete)


Amery Hung (13):
  bpf: Support getting referenced kptr from struct_ops argument
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning referenced kptr from struct_ops programs
  bpf: net_sched: Support implementation of Qdisc_ops in bpf
  bpf: net_sched: Add basic bpf qdisc kfuncs
  bpf: net_sched: Add a qdisc watchdog timer
  bpf: net_sched: Support updating bstats
  bpf: net_sched: Support updating qstats
  bpf: net_sched: Allow writing to more Qdisc members
  libbpf: Support creating and destroying qdisc
  selftests: Add a basic fifo qdisc test
  selftests: Add a bpf fq qdisc to selftest

 include/linux/bpf.h                           |   3 +
 include/linux/btf.h                           |   1 +
 include/net/sch_generic.h                     |   4 +
 kernel/bpf/bpf_struct_ops.c                   |  26 +-
 kernel/bpf/btf.c                              |   5 +-
 kernel/bpf/verifier.c                         |  77 +-
 net/sched/Kconfig                             |  12 +
 net/sched/Makefile                            |   1 +
 net/sched/bpf_qdisc.c                         | 394 ++++++++++
 net/sched/sch_api.c                           |  18 +-
 net/sched/sch_generic.c                       |  11 +-
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/netlink.c                       |  20 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  15 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   6 +
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 185 +++++
 .../prog_tests/test_struct_ops_kptr_return.c  |  87 +++
 .../prog_tests/test_struct_ops_refcounted.c   |  58 ++
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  27 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      | 117 +++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        | 726 ++++++++++++++++++
 .../bpf/progs/struct_ops_kptr_return.c        |  29 +
 ...uct_ops_kptr_return_fail__invalid_scalar.c |  24 +
 .../struct_ops_kptr_return_fail__local_kptr.c |  30 +
 ...uct_ops_kptr_return_fail__nonzero_offset.c |  23 +
 .../struct_ops_kptr_return_fail__wrong_type.c |  28 +
 .../bpf/progs/struct_ops_refcounted.c         |  67 ++
 ...ruct_ops_refcounted_fail__global_subprog.c |  32 +
 .../struct_ops_refcounted_fail__ref_leak.c    |  17 +
 30 files changed, 2026 insertions(+), 23 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

-- 
2.20.1


