Return-Path: <netdev+bounces-68335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE836846AA1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B85F1F229F0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7E1862F;
	Fri,  2 Feb 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnPqKO4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B618637
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862137; cv=none; b=r7JvlYxY+MlRkT/Xy3/0ea7juFtELJstVZe6vR5HbLP7/DScytEZdg0iFUsCnvjcBaGvk5n4BOF3K/PO2NKn3l34uhkSWiwKpgBGqX61Ug7WyqIL2Q1vxtb75hf1j+M4jbOQC0iyCi/MQOsjuJ/OAalklVBGl19NnZk8cFHRO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862137; c=relaxed/simple;
	bh=5WF0YFctxpgIsmNbp4uoOx1zUFaWcq3QBbXSHTBxEVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NVg1Yo1PuxUw+05xBlaSue/9aL3kPK7y/H0Ow3KAN4woKU/eRrGbdrSK2GtlC6bEGX5uyirSOshtRrYqt/ta61QUQpJlL9GwnrnjXQkZdl3k9zzLptefq+19y93SZROBnVgQ6luMN8MJXG2Vugcb/cGLnMKqMrsZbWHewRsoA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnPqKO4m; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6041c7aa418so15215537b3.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706862134; x=1707466934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcBTfR4vgl6N8Kfen9JZ2oMJ9sy6qJW2Lduy/no9lAM=;
        b=BnPqKO4miymH87VwqmvfpZL9EJOF25V2M08VfZ9SPROlOc0E0cUzPbO1lCzF0UY2XU
         B3m9e3NZDYbhdgFKLuaTGz7iMdxg1mN27ElfEzU0SRkP+GrXBSRKNuYJwD5hs3EsXosB
         Hxps6HWI1SBjNMIOB3I+N6mtXBQU16r/KW6KQLJnJ1hvcVN6sfiitIuesW33EGh6Ud++
         /Y1ninwUBTAgYzxCcq31oLE1x7fqrt87yY59kfgqjQZ4XUsmpGrfsLsUq2DHqUMa764A
         rO4vEvCPUtvk2zsvBDKp88+MyvSArGnaXkYBabntRj+HM4KLYm3JpB2Ulx+tLWjWNUc5
         kIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862134; x=1707466934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcBTfR4vgl6N8Kfen9JZ2oMJ9sy6qJW2Lduy/no9lAM=;
        b=ix6VqraVbB2sOwRb5xqLH8r8FoB7nJTe7GaE4ArrBSWhSfEYhOg4GIrc7uo8B4OZQD
         VFiFRa7k3KF2ihfh5zbzj/bEg0oP0iavy6ECvsdF0SwhRRGOSaxpEiUkmP4JR3DWsmWg
         J1fcWR++mjq7gobzY54hty9FLiC9qROvbDyBdl3DKc5lAOug79rQ9xX7OW09ILn5n6/3
         d+xAW6eu3A6c9X0O5mShj3/EU/blSfPQClIx5mI4PvonjU4k+CyvlvXg0oHHbJ9HGWo7
         xTwHCNtt/W4y7RFoO3xaEJpjruEeIXLAW84W2NeM+IZeVen02uEkkKg9UZBAG01/cMGo
         gvWA==
X-Gm-Message-State: AOJu0YxVWxDH9ON7RKBqs7SHe2zV1OFOXlDL9f1wfXjBdLBmDqf9YXB2
	HeyBqx0l9JoXvjuB/4MTUiZqVeiQNwOLkpgj6huSerO95pnz6FltogwIJE+sGJw=
X-Google-Smtp-Source: AGHT+IGCHiBOKXKR944uLfbAY6RHYXfwdJQtuLec8xRR5cRKhU7ojFF6g6p+JxBJqDPUWdBGLrj4JA==
X-Received: by 2002:a0d:ea0c:0:b0:5ff:481b:b7e2 with SMTP id t12-20020a0dea0c000000b005ff481bb7e2mr7214002ywe.23.1706862134242;
        Fri, 02 Feb 2024 00:22:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6+up3Oun/6VaypIHreS5ar3uqGqMpAV2UEbr9LBXssXBRRjt9qwEuu3Ne7Gj3I3BOMso5JTOxzYSTCgJZjpm7Wc6iOIGQmQMkvf31vD2ELfRfu5672Y0874jxbdcoGP9iYS5K0Wd/SMwkMKOD+AKUgfIYoHvB3O2wrJtNUYMlbdB1wxy+5Butj53ROA2t50b61yC9oA0ce52utPB/0MTGVu6u1g8Qzn49k+hH+YtLMoFDyUQtFckOO+yrzru7nF81PjqTks6JtZVxqFY2GetSKL2Oie/JqZPpmcF20VM6OR2cpUozYnRPh8Z3qeAiYZW4qmkRlwwjnWsgR+5arX1pLy2ZHs4U/GzYxA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1486:7aa6:39a6:4840])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b0060022aff36dsm299679ywg.107.2024.02.02.00.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:22:13 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v3 0/5] Remove expired routes with a separated list of routes.
Date: Fri,  2 Feb 2024 00:21:55 -0800
Message-Id: <20240202082200.227031-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

This patchset is resent due to previous reverting. [1]

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

Major changes from v2:

 - Refactory the boilerplate checks in the test case.

   - check_rt_num() and check_rt_num_clean()

Major changes from v1:

 - Reduce the numbers of routes (5) in the test cases to work with
   slow environments. Due to the failure on patchwork.

 - Remove systemd related commands in the test case.

Major changes from the previous patchset [2]:

 - Split helpers.

   - fib6_set_expires() -> fib6_set_expires() and fib6_add_gc_list().

   - fib6_clean_expires() -> fib6_clean_expires() and
     fib6_remove_gc_list().

 - Fix rt6_add_dflt_router() to avoid racing of setting expires.

 - Remove unnecessary calling to fib6_clean_expires() in
   ip6_route_info_create().

 - Add test cases of toggling routes between permanent and temporary
   and handling routes from RA messages.

   - Clean up routes by deleting the existing device and adding a new
     one.

 - Fix a potential issue in modify_prefix_route().

---
[1] https://lore.kernel.org/all/20231219030243.25687-1-dsahern@kernel.org/
[2] https://lore.kernel.org/all/20230815180706.772638-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240131064041.3445212-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240201082024.1018011-1-thinker.li@gmail.com/

Kui-Feng Lee (5):
  net/ipv6: set expires in rt6_add_dflt_router().
  net/ipv6: Remove unnecessary clean.
  net/ipv6: Remove expired routes with a separated list of routes.
  net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
  selftests/net: Adding test cases of replacing routes and route
    advertisements.

 include/net/ip6_fib.h                    |  35 +++++-
 include/net/ip6_route.h                  |   3 +-
 net/ipv6/addrconf.c                      |  50 ++++++--
 net/ipv6/ip6_fib.c                       |  58 ++++++++-
 net/ipv6/ndisc.c                         |  14 ++-
 net/ipv6/route.c                         |  20 ++-
 tools/testing/selftests/net/fib_tests.sh | 148 +++++++++++++++++++----
 7 files changed, 285 insertions(+), 43 deletions(-)

-- 
2.34.1


