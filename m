Return-Path: <netdev+bounces-69962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB384D23B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08787B25C8A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621A8289E;
	Wed,  7 Feb 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjbbicFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A585946
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334183; cv=none; b=HksCA0uH3r3abNdlGAcvuMrkXGSOdXZVsevWO27SrWpWhm8GG6Yq6UX3CbrJyOQUPAsUVCX1YOLkWpzaA/oO1G1uR0oIOIVqw7JPf/TnTT6cDPkxEnGmRun2N6Z7rjh/PTvTBhRcnvKXEx6Nz05oBKSxhNyTJ9TYHn5b9aH0TLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334183; c=relaxed/simple;
	bh=ElOWcIrt0UyCHpk3MBgPtwnB8cW37tSV/hPiRcs54TI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIB/MsKIwCxsD4qB57AAairT76kSfIUvyt4we/FUf5SK7os+Cb9TGo/kHJsXg1hG4Sda7ZA5TJ4eYvmgFRvk8t3Yw8WPYY/nBSp6xfL6LwjdyZX82UHjcpwUUBn57jt1o+ngvTkUPdjZQqAMpB7M9YLK2Xr0bGfj00roTN92L0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjbbicFK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60487b4ba0eso10440747b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334181; x=1707938981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oyJ9kVKQh7P3q/AstK3yPZ0I8rhSqVsWgyYHWLwLFk=;
        b=XjbbicFKM3Fn3taimEmYerxyTCKLvkjbiBqEQjyfWoLwFGK6VLXGMf5z/cmnhOZwzB
         mohnCKsehMD+29OQ/BlHQTMaVjmA6PJ1r7dCPby0ecV68MSF/f6taippCZsLBWDe+kI1
         rOjdbqbmlFMQuwBet3HwopsxvxurfiRik9r7nRftcHDhTvTXK96mEemVCpzwu/biMp3i
         DxPinldJFxPdNnRzeiiakb4OP3Ab++hhgNHyggirl3lPBKpaViYez7ay3YA4in89FMUI
         tqh+w4H2tAGimiXIzPlz64qzZ+zc0bDLCCg0diwWgfJAdErhafinA8OooeMZoMmCgXOd
         XyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334181; x=1707938981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oyJ9kVKQh7P3q/AstK3yPZ0I8rhSqVsWgyYHWLwLFk=;
        b=SZefM5r1dfCrMMN6+JIrKW+m8Q+oRZaoiCAUrmHxt/zOCLbc9Ewtc37wfYuYu6hIJH
         8YvgT85Fv7C+hyy0z5LB++hqqP05H4P0NqkcUjXtGXtTHFlo4NTSe13W2UNFByKKN5yQ
         60unEcqVytrCr89vIMYZoaBPw+DT6HRzvGdiONTnMH7LJck7Ok8ZsULZbphRaOLThtMP
         MokOhTOFhoK0MSCnaIZIHecngxOw68pvuvAqC0aOT4gwprKB1atnKPv4aKO2o6xPko7W
         GjP1em7u7rmnQpGPJhSMePJnnztpyehJv6ttHzmxFEe+cIRaNrk9Qnkk1XrQ8UGLGPoO
         gfag==
X-Gm-Message-State: AOJu0YwIAjLER8960qxyQL5TQGv5HraMwoGMWKQiB+M5En8YMyWBft7k
	4pur4KzxxKD+vtaFex70Tn/Pfb4s/T0APk2HbJqwLIkQ2059XFv3b2hfdiTo
X-Google-Smtp-Source: AGHT+IEscltbBwNUf4cIJsP6PbWHdcKaAt8ToOQjs/W0RljIhvwyiekRx/Fu8hY+RtQCBZgxzfJOSA==
X-Received: by 2002:a81:82c2:0:b0:5f5:bdef:748b with SMTP id s185-20020a8182c2000000b005f5bdef748bmr6754970ywf.47.1707334180673;
        Wed, 07 Feb 2024 11:29:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXFJu4i0vpVsDyGLqe05KsFjpoqywX6dla/OUENHgLJyJWGVh/r5IHLfcFHtIG1mGudHskjxeQ8x6P0o6ahOJjtNtTDb1f+giT1fVIYcQx8QWSJ3PxD6ppXsQV0Cq/pQUWNcZj4CIbNFnFmH7trSMWqJogz4rrY4trXc9GNHk6HxEhV1cd/V3xJtjdH/HaNVdo4oJ/VhNIIWIJm+MJ5VkTCGE2+S7JJ8FWu9qwhraZ2LVXQysi8lns/Da4fvtPksaVD6Mvw+DKoULJswNamqDuGQ+NryxrqUUF7MdY9N87EQT4N1NvXtxLkV/25OGjkGuqes4+k9mjYhTo4dcWRllZBG3Rkc1pjk+y5A==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id cn33-20020a05690c0d2100b006040cbbe952sm380088ywb.89.2024.02.07.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:29:40 -0800 (PST)
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
Subject: [PATCH net-next v5 0/5] Remove expired routes with a separated list of routes.
Date: Wed,  7 Feb 2024 11:29:28 -0800
Message-Id: <20240207192933.441744-1-thinker.li@gmail.com>
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

Major changes from v4:

 - Fix the comment of fib6_add_gc_list().

Major changes from v3:

 - Move the checks of f6i->fib6_node to fib6_add_gc_list().

 - Make spin_lock_bh() and spin_unlock_bh() stands out.

 - Explain the reason of the changes in the commit message of the
   patch 4.

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
v3: https://lore.kernel.org/all/20240202082200.227031-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20240205214033.937814-1-thinker.li@gmail.com/

Kui-Feng Lee (5):
  net/ipv6: set expires in rt6_add_dflt_router().
  net/ipv6: Remove unnecessary clean.
  net/ipv6: Remove expired routes with a separated list of routes.
  net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
  selftests/net: Adding test cases of replacing routes and route
    advertisements.

 include/net/ip6_fib.h                    |  46 ++++++-
 include/net/ip6_route.h                  |   3 +-
 net/ipv6/addrconf.c                      |  41 +++++--
 net/ipv6/ip6_fib.c                       |  60 ++++++++-
 net/ipv6/ndisc.c                         |  13 +-
 net/ipv6/route.c                         |  19 ++-
 tools/testing/selftests/net/fib_tests.sh | 148 +++++++++++++++++++----
 7 files changed, 287 insertions(+), 43 deletions(-)

-- 
2.34.1


