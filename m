Return-Path: <netdev+bounces-144881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962ED9C89CD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BEF28513C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9A1F9EC1;
	Thu, 14 Nov 2024 12:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7B1F77B8;
	Thu, 14 Nov 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586961; cv=none; b=o/4PdTZbEFO4DJ8GB8BkuF2HlJipJrETBGFHQlvM5DjbsMNhZGyNYMwdkI+eMsLZs3pR+jNGPN5h63Lv4pUwpfpgUMKed4QLBo6gWGYGolW9vLsf5Ocjmfxw1rZwgNi/9uqEcq2dFh/mCcjJ5v7iJVPEdUocmQ6URjNVnAHfJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586961; c=relaxed/simple;
	bh=vibFjmdaIQBU2OxHDXKn/BheCTqUwyc2LzRki366Pv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVIROrHeUXUWMSayCkTVkxqQOcq91guKCXRgw+68xpuJxWNEYyR1pbez0m6ogR15tFARX9CLs70V+2KW2mN7Nb8p42aQdEVMhkJY+OPQu60HoySiqYQIkbRq9KSLQPBCGk9wkFQ3tw1CHnUzXmJ5uhg0hjzv7zKUEeNEGOf2sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XpzkD3XtNz1V4Nw;
	Thu, 14 Nov 2024 20:20:04 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 04DC91800A7;
	Thu, 14 Nov 2024 20:22:35 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 20:22:34 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: [PATCH net-next v1 00/10] Replace page_frag with page_frag_cache (Part-2)
Date: Thu, 14 Nov 2024 20:15:55 +0800
Message-ID: <20241114121606.3434517-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Performance validation for part2:
1. Using micro-benchmark ko added in patch 1 to test aligned and
   non-aligned API performance impact for the existing users, there
   seems to be about 20% performance degradation for refactoring
   page_frag to support the new API, which seems to nullify most of
   the performance gain in [3] of part1.
2. Use the below netcat test case, there seems to be some minor
   performance gain for replacing 'page_frag' with 'page_frag_cache'
   using the new page_frag API after this patchset.
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

         18.753187      task-clock (msec)         #    0.003 CPUs utilized            ( +-  0.44% )
                 8      context-switches          #    0.422 K/sec                    ( +-  0.30% )
                 0      cpu-migrations            #    0.003 K/sec                    ( +- 32.09% )
                84      page-faults               #    0.004 M/sec                    ( +-  0.08% )
          48700826      cycles                    #    2.597 GHz                      ( +-  0.44% )
          62086543      instructions              #    1.27  insn per cycle           ( +-  0.03% )
          14869358      branches                  #  792.898 M/sec                    ( +-  0.03% )
             19639      branch-misses             #    0.13% of all branches          ( +-  0.60% )

       7.035285915 seconds time elapsed                                          ( +-  0.06% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1' (200 runs):

         18.442151      task-clock (msec)         #    0.006 CPUs utilized            ( +-  0.01% )
                 8      context-switches          #    0.422 K/sec                    ( +-  0.40% )
                 0      cpu-migrations            #    0.001 K/sec                    ( +- 57.44% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.08% )
          47890149      cycles                    #    2.597 GHz                      ( +-  0.01% )
          60718325      instructions              #    1.27  insn per cycle           ( +-  0.00% )
          14570862      branches                  #  790.085 M/sec                    ( +-  0.00% )
             19613      branch-misses             #    0.13% of all branches          ( +-  0.12% )

       3.210892358 seconds time elapsed                                          ( +-  0.12% )

 Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 runs):

      16824.017944      task-clock (msec)         #    0.621 CPUs utilized            ( +-  0.02% )
           2987954      context-switches          #    0.178 M/sec                    ( +-  0.04% )
                 1      cpu-migrations            #    0.000 K/sec
                93      page-faults               #    0.006 K/sec                    ( +-  0.09% )
       31982647267      cycles                    #    1.901 GHz                      ( +-  0.03% )
       38907812424      instructions              #    1.22  insn per cycle           ( +-  0.02% )
        7112328962      branches                  #  422.749 M/sec                    ( +-  0.03% )
          94789062      branch-misses             #    1.33% of all branches          ( +-  0.21% )

      27.104994660 seconds time elapsed                                          ( +-  0.03% )


*Before* this patchset:

Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000' (200 runs):

         18.700051      task-clock (msec)         #    0.003 CPUs utilized            ( +-  1.04% )
                 8      context-switches          #    0.420 K/sec                    ( +-  0.31% )
                 0      cpu-migrations            #    0.019 K/sec                    ( +- 10.16% )
                81      page-faults               #    0.004 M/sec                    ( +-  0.09% )
          48548980      cycles                    #    2.596 GHz                      ( +-  1.04% )
          61857980      instructions              #    1.27  insn per cycle           ( +-  0.09% )
          14814201      branches                  #  792.201 M/sec                    ( +-  0.08% )
             42007      branch-misses             #    0.28% of all branches          ( +-  0.11% )

       5.565806266 seconds time elapsed                                          ( +-  0.08% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1' (200 runs):

         18.468618      task-clock (msec)         #    0.007 CPUs utilized            ( +-  1.14% )
                 8      context-switches          #    0.422 K/sec                    ( +-  0.43% )
                 0      cpu-migrations            #    0.026 K/sec                    ( +-  7.89% )
                81      page-faults               #    0.004 M/sec                    ( +-  0.08% )
          47950150      cycles                    #    2.596 GHz                      ( +-  1.14% )
          61745530      instructions              #    1.29  insn per cycle           ( +-  0.09% )
          14787783      branches                  #  800.698 M/sec                    ( +-  0.08% )
             41734      branch-misses             #    0.28% of all branches          ( +-  0.09% )

       2.584180919 seconds time elapsed                                          ( +-  0.04% )

 Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 runs):

      17105.617450      task-clock (msec)         #    0.599 CPUs utilized            ( +-  0.02% )
           2822654      context-switches          #    0.165 M/sec                    ( +-  0.03% )
                 1      cpu-migrations            #    0.000 K/sec                    ( +-  0.50% )
                93      page-faults               #    0.005 K/sec                    ( +-  0.09% )
       31819244033      cycles                    #    1.860 GHz                      ( +-  0.03% )
       37297412811      instructions              #    1.17  insn per cycle           ( +-  0.01% )
        6676699757      branches                  #  390.322 M/sec                    ( +-  0.01% )
         325102016      branch-misses             #    4.87% of all branches          ( +-  0.06% )

      28.568053622 seconds time elapsed                                          ( +-  0.02% )

Note, ipv4-udp, ipv6-tcp and ipv6-udp is also tested with the below script:
nc -u -l -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -u 127.0.0.1 1234

nc -l6 -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc ::1 1234

nc -l6 -k -u 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -u ::1 1234

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Shuah Khan <skhan@linuxfoundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>

1. https://lore.kernel.org/all/20241028115343.3405838-1-linyunsheng@huawei.com/
2. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/
3. https://lore.kernel.org/all/472a7a09-387f-480d-b66c-761e0b6192ef@huawei.com/

V1: Rebase on latest net-next tree and redo the performance test.

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


