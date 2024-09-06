Return-Path: <netdev+bounces-125811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB2D96EC3E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89BE1C22780
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F114D71E;
	Fri,  6 Sep 2024 07:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086EB3C463;
	Fri,  6 Sep 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608563; cv=none; b=JmEKw9eGObUEtrqV1F0kohGfnA1yf3XeQfnker9xGT3/5i8kHxcHoWaxBfgqEZz/eWik5TrdtjS7r9Clc2jlYXiIF+t6KGvbOYXl6M0ai1P1gf/EHumlddUdkOxrU0R0LNiTWpGIUI7Te4ccbEV+TMGf7jMi8EemAJcHHbk0/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608563; c=relaxed/simple;
	bh=fPOfAeSm8nfnsHWOWceV/bvYS7T5V083albRjcz+sTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcAA4nZA0Aqn1hj3lACk0If2pxiUQemMOlaNs96J1jjute9Wm3KFqG4HsF7mOkIuI89CPcJmvrbTWtbkGyqHoyFB5u0yDtXn8UqzUa7L5+XLPYq28uSI2nfA2nMMHtGo7/YpxcQSf4QTUbwM8fsplG/FfANeMzN9DUkqWm9dJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0SqV3Mr0z1j88M;
	Fri,  6 Sep 2024 15:42:14 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CA1A1402CD;
	Fri,  6 Sep 2024 15:42:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:42:36 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next v18 00/14] Replace page_frag with page_frag_cache for sk_page_frag()
Date: Fri, 6 Sep 2024 15:36:32 +0800
Message-ID: <20240906073646.2930809-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

After [1], there are still two implementations for page frag:

1. mm/page_alloc.c: net stack seems to be using it in the
   rx part with 'struct page_frag_cache' and the main API
   being page_frag_alloc_align().
2. net/core/sock.c: net stack seems to be using it in the
   tx part with 'struct page_frag' and the main API being
   skb_page_frag_refill().

This patchset tries to unfiy the page frag implementation
by replacing page_frag with page_frag_cache for sk_page_frag()
first. net_high_order_alloc_disable_key for the implementation
in net/core/sock.c doesn't seems matter that much now as pcp
is also supported for high-order pages:
commit 44042b449872 ("mm/page_alloc: allow high-order pages to
be stored on the per-cpu lists")

As the related change is mostly related to networking, so
targeting the net-next. And will try to replace the rest
of page_frag in the follow patchset.

After this patchset:
1. Unify the page frag implementation by taking the best out of
   two the existing implementations: we are able to save some space
   for the 'page_frag_cache' API user, and avoid 'get_page()' for
   the old 'page_frag' API user.
2. Future bugfix and performance can be done in one place, hence
   improving maintainability of page_frag's implementation.

Kernel Image changing:
    Linux Kernel   total |      text      data        bss
    ------------------------------------------------------
    after     45250307 |   27274279   17209996     766032
    before    45254134 |   27278118   17209984     766032
    delta        -3827 |      -3839        +12         +0

Performance validation:
1. Using micro-benchmark ko added in patch 1 to test aligned and
   non-aligned API performance impact for the existing users, there
   is no notiable performance degradation. Instead we seems to have
   some major performance boot for both aligned and non-aligned API
   after switching to ptr_ring for testing, respectively about 200%
   and 10% improvement in arm64 server as below.

2. Use the below netcat test case, we also have some minor
   performance boot for replacing 'page_frag' with 'page_frag_cache'
   after this patchset.
   server: taskset -c 32 nc -l -k 1234 > /dev/null
   client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc 127.0.0.1 1234

In order to avoid performance noise as much as possible, the testing
is done in system without any other load and have enough iterations to
prove the data is stable enough, complete log for testing is below:

perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000
perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1
taskset -c 32 nc -l -k 1234 > /dev/null
perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc 127.0.0.1 1234

*After* this patchset:

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000' (200 runs):

         17.758393      task-clock (msec)         #    0.004 CPUs utilized            ( +-  0.51% )
                 5      context-switches          #    0.293 K/sec                    ( +-  0.65% )
                 0      cpu-migrations            #    0.008 K/sec                    ( +- 17.21% )
                74      page-faults               #    0.004 M/sec                    ( +-  0.12% )
          46128650      cycles                    #    2.598 GHz                      ( +-  0.51% )
          60810511      instructions              #    1.32  insn per cycle           ( +-  0.04% )
          14764914      branches                  #  831.433 M/sec                    ( +-  0.04% )
             19281      branch-misses             #    0.13% of all branches          ( +-  0.13% )

       4.240273854 seconds time elapsed                                          ( +-  0.13% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1' (200 runs):

         17.348690      task-clock (msec)         #    0.019 CPUs utilized            ( +-  0.66% )
                 5      context-switches          #    0.310 K/sec                    ( +-  0.84% )
                 0      cpu-migrations            #    0.009 K/sec                    ( +- 16.55% )
                74      page-faults               #    0.004 M/sec                    ( +-  0.11% )
          45065287      cycles                    #    2.598 GHz                      ( +-  0.66% )
          60755389      instructions              #    1.35  insn per cycle           ( +-  0.05% )
          14747865      branches                  #  850.085 M/sec                    ( +-  0.05% )
             19272      branch-misses             #    0.13% of all branches          ( +-  0.13% )

       0.935251375 seconds time elapsed                                          ( +-  0.07% )

 Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 runs):

      16626.042731      task-clock (msec)         #    0.607 CPUs utilized            ( +-  0.03% )
           3291020      context-switches          #    0.198 M/sec                    ( +-  0.05% )
                 1      cpu-migrations            #    0.000 K/sec                    ( +-  0.50% )
                85      page-faults               #    0.005 K/sec                    ( +-  0.16% )
       30581044838      cycles                    #    1.839 GHz                      ( +-  0.05% )
       34962744631      instructions              #    1.14  insn per cycle           ( +-  0.01% )
        6483883671      branches                  #  389.984 M/sec                    ( +-  0.02% )
          99624551      branch-misses             #    1.54% of all branches          ( +-  0.17% )

      27.370305077 seconds time elapsed                                          ( +-  0.01% )


*Before* this patchset:

Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000' (200 runs):

         21.587934      task-clock (msec)         #    0.005 CPUs utilized            ( +-  0.72% )
                 6      context-switches          #    0.281 K/sec                    ( +-  0.28% )
                 1      cpu-migrations            #    0.047 K/sec                    ( +-  0.50% )
                73      page-faults               #    0.003 M/sec                    ( +-  0.12% )
          56080697      cycles                    #    2.598 GHz                      ( +-  0.72% )
          61605150      instructions              #    1.10  insn per cycle           ( +-  0.05% )
          14950196      branches                  #  692.526 M/sec                    ( +-  0.05% )
             19410      branch-misses             #    0.13% of all branches          ( +-  0.18% )

       4.603530546 seconds time elapsed                                          ( +-  0.11% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1' (200 runs):

         20.988297      task-clock (msec)         #    0.006 CPUs utilized            ( +-  0.81% )
                 7      context-switches          #    0.316 K/sec                    ( +-  0.54% )
                 1      cpu-migrations            #    0.048 K/sec                    ( +-  0.70% )
                73      page-faults               #    0.003 M/sec                    ( +-  0.11% )
          54512166      cycles                    #    2.597 GHz                      ( +-  0.81% )
          61440941      instructions              #    1.13  insn per cycle           ( +-  0.08% )
          14906043      branches                  #  710.207 M/sec                    ( +-  0.08% )
             19927      branch-misses             #    0.13% of all branches          ( +-  0.17% )

       3.438041238 seconds time elapsed                                          ( +-  1.11% )

 Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 runs):

      17364.040855      task-clock (msec)         #    0.624 CPUs utilized            ( +-  0.02% )
           3340375      context-switches          #    0.192 M/sec                    ( +-  0.06% )
                 1      cpu-migrations            #    0.000 K/sec
                85      page-faults               #    0.005 K/sec                    ( +-  0.15% )
       32077623335      cycles                    #    1.847 GHz                      ( +-  0.03% )
       35121047596      instructions              #    1.09  insn per cycle           ( +-  0.01% )
        6519872824      branches                  #  375.481 M/sec                    ( +-  0.02% )
         101877022      branch-misses             #    1.56% of all branches          ( +-  0.14% )

      27.842745343 seconds time elapsed                                          ( +-  0.02% )


Note, ipv4-udp, ipv6-tcp and ipv6-udp is also tested with the below script:
nc -u -l -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -N -u 127.0.0.1 1234

nc -l6 -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -N ::1 1234

nc -l6 -k -u 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -u -N ::1 1234

CC: Alexander Duyck <alexander.duyck@gmail.com>

1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

Change log:
V18:
   1. Fix a typo in test_page_frag.sh pointed out by Alexander.
   2. Move some inline helper into c file, use ternary operator and
      move the getting of the size as suggested by Alexander.

V17:
   1. Add TEST_FILES in Makefile for test_page_frag.sh.

V16:
   1. Add test_page_frag.sh to handle page_frag_test.ko and add testing
      for prepare API.
   2. Move inline helper unneeded outside of the page_frag_cache.c to
      page_frag_cache.c.
   3. Reset nc->offset when reusing an old page.

V15:
   1. Fix the compile error pointed out by Simon.
   2. Fix Other mistakes when using new API naming and refactoring.

V14:
   1. Drop '_va' Renaming patch and use new API naming.
   2. Use new refactoring to enable more codes to be reusable.
   3. And other minor suggestions from Alexander.

V13:
   1. Move page_frag_test from mm/ to tools/testing/selftest/mm
   2. Use ptr_ring to replace ptr_pool for page_frag_test.c
   3. Retest based on the new testing ko, which shows a big different
      result than using ptr_pool.

V12:
   1. Do not treat page_frag_test ko as DEBUG feature.
   2. Make some improvement for the refactoring in patch 8.
   3. Some other minor improvement as Alexander's comment.

RFC v11:
   1. Fold 'page_frag_cache' moving change into patch 2.
   2. Optimizate patch 3 according to discussion in v9.

V10:
   1. Change Subject to "Replace page_frag with page_frag_cache for sk_page_frag()".
   2. Move 'struct page_frag_cache' to sched.h as suggested by Alexander.
   3. Rename skb_copy_to_page_nocache().
   4. Adjust change between patches to make it more reviewable as Alexander's comment.
   5. Use 'aligned_remaining' variable to generate virtual address as Alexander's
      comment.
   6. Some included header and typo fix as Alexander's comment.
   7. Add back the get_order() opt patch for xtensa arch

V9:
   1. Add check for test_alloc_len and change perm of module_param()
      to 0 as Wang Wei' comment.
   2. Rebased on latest net-next.

V8: Remove patch 2 & 3 in V7, as free_unref_page() is changed to call
    pcp_allowed_order() and used in page_frag API recently in:
    commit 5b8d75913a0e ("mm: combine free_the_page() and free_unref_page()")

V7: Fix doc build warning and error.

V6:
   1. Fix some typo and compiler error for x86 pointed out by Jakub and
      Simon.
   2. Add two refactoring and optimization patches.

V5:
   1. Add page_frag_alloc_pg() API for tls_device.c case and refactor
      some implementation, update kernel bin size changing as bin size
      is increased after that.
   2. Add ack from Mat.

RFC v4:
   1. Update doc according to Randy and Mat's suggestion.
   2. Change probe API to "probe" for a specific amount of available space,
      rather than "nonzero" space according to Mat's suggestion.
   3. Retest and update the test result.

v3:
   1. Use new layout for 'struct page_frag_cache' as the discussion
      with Alexander and other sugeestions from Alexander.
   2. Add probe API to address Mat' comment about mptcp use case.
   3. Some doc updating according to Bagas' suggestion.

v2:
   1. reorder test module to patch 1.
   2. split doc and maintainer updating to two patches.
   3. refactor the page_frag before moving.
   4. fix a type and 'static' warning in test module.
   5. add a patch for xtensa arch to enable using get_order() in
      BUILD_BUG_ON().
   6. Add test case and performance data for the socket code.

Yunsheng Lin (14):
  mm: page_frag: add a test module for page_frag
  mm: move the page fragment allocator from page_alloc into its own file
  mm: page_frag: use initial zero offset for page_frag_alloc_align()
  mm: page_frag: avoid caller accessing 'page_frag_cache' directly
  xtensa: remove the get_order() implementation
  mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
  mm: page_frag: some minor refactoring before adding new API
  mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
  net: rename skb_copy_to_page_nocache() helper
  mm: page_frag: introduce prepare/probe/commit API
  mm: page_frag: add testing for the newly added prepare API
  net: replace page_frag with page_frag_cache
  mm: page_frag: update documentation for page_frag
  mm: page_frag: add an entry in MAINTAINERS for page_frag

 Documentation/mm/page_frags.rst               | 177 ++++++-
 MAINTAINERS                                   |  12 +
 arch/xtensa/include/asm/page.h                |  18 -
 .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 +---
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
 drivers/net/tun.c                             |  47 +-
 drivers/vhost/net.c                           |   2 +-
 include/linux/gfp.h                           |  22 -
 include/linux/mm_types.h                      |  18 -
 include/linux/mm_types_task.h                 |  21 +
 include/linux/page_frag_cache.h               | 473 ++++++++++++++++++
 include/linux/sched.h                         |   2 +-
 include/linux/skbuff.h                        |   1 +
 include/net/sock.h                            |  31 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   3 +-
 mm/Makefile                                   |   1 +
 mm/page_alloc.c                               | 136 -----
 mm/page_frag_cache.c                          | 243 +++++++++
 net/core/skbuff.c                             |  64 ++-
 net/core/skmsg.c                              |  12 +-
 net/core/sock.c                               |  32 +-
 net/ipv4/ip_output.c                          |  28 +-
 net/ipv4/tcp.c                                |  26 +-
 net/ipv4/tcp_output.c                         |  25 +-
 net/ipv6/ip6_output.c                         |  28 +-
 net/kcm/kcmsock.c                             |  21 +-
 net/mptcp/protocol.c                          |  47 +-
 net/rxrpc/conn_object.c                       |   4 +-
 net/rxrpc/local_object.c                      |   4 +-
 net/sched/em_meta.c                           |   2 +-
 net/sunrpc/svcsock.c                          |   6 +-
 net/tls/tls_device.c                          | 100 ++--
 tools/testing/selftests/mm/Makefile           |   3 +
 tools/testing/selftests/mm/page_frag/Makefile |  18 +
 .../selftests/mm/page_frag/page_frag_test.c   | 226 +++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |  12 +
 tools/testing/selftests/mm/test_page_frag.sh  | 202 ++++++++
 39 files changed, 1696 insertions(+), 481 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c
 create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
 create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
 create mode 100755 tools/testing/selftests/mm/test_page_frag.sh

-- 
2.33.0


