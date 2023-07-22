Return-Path: <netdev+bounces-20069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77ED75D85D
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144E81C2188B
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AC365;
	Sat, 22 Jul 2023 00:40:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562347F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:40:14 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FFF3C39
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:39:48 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-576a9507a9bso53155277b3.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986347; x=1690591147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qRTBHmYtbOW7FNNoUAE22BlAdmkPSEI+pQNypEhDbI=;
        b=XA+LaQ7LfqUyJUAwwji6aXHNjgVZXmyKwB5eDo7aCYwy+DDNexJYD8oTE+r94JSMDs
         Cx5t1qDokdvARPWNzBA6S9AEXn8wLX2HS1C9D5WCfJt1vQWpuzGPU1IXhe2oGTAj1n6y
         OaQitoKlecZoCSpMx1FgOwYjl2o0FjDoxEBhYquRDqW65uStm3gGi+zQPyJayhVpBwc6
         T9iwNL9iLM6zwvbUfekT+w6zBFB3W/XddqcTALGvalE9bKZD4zn6mlwQnBcoblArndjQ
         KfikoUZEclI7T5mZxbssFiHo46C5EKF86clGrJZxfhFUVA9aC/20UE5p6gKIxcONA3HJ
         tB8Q==
X-Gm-Message-State: ABy/qLa8GhZxZxPbSNI9ac1VkmnAwtsATBNE/ue/KWjbJ4x3UB2N/Evi
	4NBHFLjIZXzmJDC84MahB9o=
X-Google-Smtp-Source: APBJJlHIWcmbPLZ5NjdqZ8M1IGRp6Sy5YgQWnNiMwFioEhRu1iRU/w72nLvT12cTQEVhY7rlKL8dGg==
X-Received: by 2002:a81:9157:0:b0:577:3cd0:3728 with SMTP id i84-20020a819157000000b005773cd03728mr1136862ywg.14.1689986346580;
        Fri, 21 Jul 2023 17:39:06 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a927:bf54:acf2:ee0a])
        by smtp.gmail.com with ESMTPSA id q2-20020a0dce02000000b005707d7686ddsm1265937ywd.76.2023.07.21.17.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:39:06 -0700 (PDT)
From: kuifeng@meta.com
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: thinker.li@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH net-next v4 0/2] Remove expired routes with a separated list of routes.
Date: Fri, 21 Jul 2023 17:38:37 -0700
Message-Id: <20230722003839.897682-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
can be expensive if the number of routes in a table is big, even if most of
them are permanent. Checking routes in a separated list of routes having
expiration will avoid this potential issue.

Background
==========

The size of a Linux IPv6 routing table can become a big problem if not
managed appropriately.  Now, Linux has a garbage collector to remove
expired routes periodically.  However, this may lead to a situation in
which the routing path is blocked for a long period due to an
excessive number of routes.

For example, years ago, there is a commit c7bb4b89033b ("ipv6: tcp:
drop silly ICMPv6 packet too big messages").  The root cause is that
malicious ICMPv6 packets were sent back for every small packet sent to
them. These packets add routes with an expiration time that prompts
the GC to periodically check all routes in the tables, including
permanent ones.

Why Route Expires
=================

Users can add IPv6 routes with an expiration time manually. However,
the Neighbor Discovery protocol may also generate routes that can
expire.  For example, Router Advertisement (RA) messages may create a
default route with an expiration time. [RFC 4861] For IPv4, it is not
possible to set an expiration time for a route, and there is no RA, so
there is no need to worry about such issues.

Create Routes with Expires
==========================

You can create routes with expires with the  command.

For example,

    ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \ 
        dev enp0s3 expires 30

The route that has been generated will be deleted automatically in 30
seconds.

GC of FIB6
==========

The function called fib6_run_gc() is responsible for performing
garbage collection (GC) for the Linux IPv6 stack. It checks for the
expiration of every route by traversing the trees of routing
tables. The time taken to traverse a routing table increases with its
size. Holding the routing table lock during traversal is particularly
undesirable. Therefore, it is preferable to keep the lock for the
shortest possible duration.

Solution
========

The cause of the issue is keeping the routing table locked during the
traversal of large trees. To solve this problem, we can create a separate
list of routes that have expiration. This will prevent GC from checking
permanent routes.

Result
======

We conducted a test to measure the execution times of fib6_gc_timer_cb()
and observed that it enhances the GC of FIB6. During the test, we added
permanent routes with the following numbers: 1000, 3000, 6000, and
9000. Additionally, we added a route with an expiration time.

Here are the average execution times for the kernel without the patch.
 - 120020 ns with 1000 permanent routes
 - 308920 ns with 3000 ...
 - 581470 ns with 6000 ...
 - 855310 ns with 9000 ...

The kernel with the patch consistently takes around 14000 ns to execute,
regardless of the number of permanent routes that are installed.

Major changes from v3:

 - Fix the type of arg according to feedback.

 - Add 1k temporary routes and 5K permanent routes in the test case.
   Measure time spending on GC with strace.

Major changes from v2:

 - Remove unnecessary and incorrect sysctl restoring in the test case.

Major changes from v1:

 - Moved gc_link to avoid creating a hole in fib6_info.

 - Moved fib6_set_expires*() and fib6_clean_expires*() to the header
   file and inlined. And removed duplicated lines.

 - Added a test case.

---
v1: https://lore.kernel.org/all/20230710203609.520720-1-kuifeng@meta.com/
v2: https://lore.kernel.org/all/20230718180321.294721-1-kuifeng@meta.com/
v3: https://lore.kernel.org/all/20230718183351.297506-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  net/ipv6: Remove expired routes with a separated list of routes.
  selftests: fib_tests: Add a test case for IPv6 garbage collection

 include/net/ip6_fib.h                    | 65 +++++++++++++----
 net/ipv6/ip6_fib.c                       | 56 +++++++++++++--
 net/ipv6/route.c                         |  6 +-
 tools/testing/selftests/net/fib_tests.sh | 90 +++++++++++++++++++++++-
 4 files changed, 192 insertions(+), 25 deletions(-)

-- 
2.34.1


