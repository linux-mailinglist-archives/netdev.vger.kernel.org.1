Return-Path: <netdev+bounces-139536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431179B2FA5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00611283AD4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36291D89F7;
	Mon, 28 Oct 2024 12:05:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE661D88BF;
	Mon, 28 Oct 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117113; cv=none; b=Glvzt5Bng6mdT8/GI6CSEvBdpdo1BMhTk+44HyrHLJZ340JLPlP6Bg+KVPqxrc5F5WP4d95FYYZODFcp+S9DK8YzKOJcHBnfkPy798EnS67eSikjv3HkerfX9BzMfW8zP9Q9Ryfzs+bpyc8nS6wAn2EwgW2XBqI+YXVOwYnA/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117113; c=relaxed/simple;
	bh=xNtzbU6RYxE7Z3LPDjmeMYyTQ+edxjCw2G+7nLTaFwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkUhWucH+RIo3G8uKrOuXqyrNmo8bsAZvSokOgTG3KIJwS8iU18qdadxN/x7tWRNvaT8JmkOf31FGfh6Nw5t27FpXRPXtSfE6CXNzWP01PqqMsA32eKSsz0W3vt5995Pl+r3xm+77dFoJtRdMNigWchG/1WH/7Ta0UsgZ4zAjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XcXC02J2zz1ynlN;
	Mon, 28 Oct 2024 20:05:16 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BC2E180041;
	Mon, 28 Oct 2024 20:05:08 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 20:05:07 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Shuah
 Khan <skhan@linuxfoundation.org>
Subject: [PATCH RFC 00/10] Replace page_frag with page_frag_cache (Part-2)
Date: Mon, 28 Oct 2024 19:58:40 +0800
Message-ID: <20241028115850.3409893-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

This is part 2 of "Replace page_frag with page_frag_cache",
which introduces the new API and replaces page_frag with
page_frag_cache for sk_page_frag().

The part 1 of "Replace page_frag with page_frag_cache" is in
[1].

After [2], there are still two implementations for page frag:

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
CC: Shuah Khan <skhan@linuxfoundation.org>

1. https://lore.kernel.org/all/20241028115343.3405838-1-linyunsheng@huawei.com/
2. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

RFC:
    1. CC Andrew and MM ML explicitly.
    2. Split into two parts according to the discussion in v22, and this is
       the part-2.
    3. Split 'introduce new API' patch to more patches to make more reviewable
       and easier to discuss.

Yunsheng Lin (10):
  mm: page_frag: some minor refactoring before adding new API
  net: rename skb_copy_to_page_nocache() helper
  mm: page_frag: update documentation for page_frag
  mm: page_frag: introduce page_frag_alloc_abort() related API
  mm: page_frag: introduce refill prepare & commit API
  mm: page_frag: introduce alloc_refill prepare & commit API
  mm: page_frag: introduce probe related API
  mm: page_frag: add testing for the newly added API
  net: replace page_frag with page_frag_cache
  mm: page_frag: add an entry in MAINTAINERS for page_frag

 Documentation/mm/page_frags.rst               | 207 ++++++++++-
 MAINTAINERS                                   |  12 +
 .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 ++----
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
 drivers/net/tun.c                             |  47 ++-
 include/linux/page_frag_cache.h               | 330 +++++++++++++++++-
 include/linux/sched.h                         |   2 +-
 include/net/sock.h                            |  30 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   3 +-
 mm/page_frag_cache.c                          | 108 +++++-
 net/core/skbuff.c                             |  58 +--
 net/core/skmsg.c                              |  12 +-
 net/core/sock.c                               |  32 +-
 net/ipv4/ip_output.c                          |  28 +-
 net/ipv4/tcp.c                                |  26 +-
 net/ipv4/tcp_output.c                         |  25 +-
 net/ipv6/ip6_output.c                         |  28 +-
 net/kcm/kcmsock.c                             |  21 +-
 net/mptcp/protocol.c                          |  47 ++-
 net/tls/tls_device.c                          | 100 ++++--
 .../selftests/mm/page_frag/page_frag_test.c   |  76 +++-
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 tools/testing/selftests/mm/test_page_frag.sh  |  27 ++
 25 files changed, 1045 insertions(+), 288 deletions(-)

-- 
2.33.0


