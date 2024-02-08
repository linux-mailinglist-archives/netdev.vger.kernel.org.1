Return-Path: <netdev+bounces-70386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB36584EB32
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CEE285E5F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAFC4F613;
	Thu,  8 Feb 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6hoHNt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818C4F5EA
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430043; cv=none; b=C2VxLBgHu3yrqEQfnXfdnNTD7NwXNvCjW24fw9EhecJ2kNy3y1H6AN0VLavcWQxwy//lYhylhFSFah2u9o24Mpb9yPCV+Y/j8LqZufjSwM2MowACn4b50B2mM4Nl+GWLrEzOhmdgjj0e4dO26Jn66tPn5yYWhn67Mk4rXjezx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430043; c=relaxed/simple;
	bh=XgaOzaX7cy8/aty47F/csuhZ8sJnrQhZwoy4ZgDqypA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kon/k2ZUmVdWgnbKwf5OG2DRAAfMynlRCaFXmk3yzVKQQcC/70jzhveyN9Fb0hgnj47/dkuGU/uHO214dv5z7G7HL+IBLIro3o+mFANqO9V/WG6Lx4ZLizNXkuEuYm+B4rAlHra5olQsDw1c2uqYPdEvcW2aHtA7QSlJgdPbcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6hoHNt9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60491b1fdeaso4424927b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430040; x=1708034840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+GpVYQmS8ym9q93OPL4ygUkvZVMAhk989UQh6gPkhw=;
        b=E6hoHNt9NgSA0Bsrl/WSD3KqunmCK8NjGTfurM0Oe58wYGbtPLyfhtdrAkZUiWd28A
         Ap3ZocCBIc8kYyWKf0dlMldXaC57fbV6e+ncyDpfF9Sie12yJuYWiU6fx4n0GhDwHvwL
         X2i4LZZv6+trcc9WF48u/bcCFOohC92in5cYRwGnXPwSqC49+fZTNRkNPYM1OgekuGOP
         hTdZNh2vv+tBLUF2lH7thamBaDsTh9fGGW9gDYV7XaOhW/SjjmYapHA+l5ClNK2U6dew
         scMHNtp7rF+ZR1+lJAM+ZcNUByXJs/KtJjQZbu7shs1I0s7RaxLVQ7caCN7feD6lL41A
         IbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430040; x=1708034840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+GpVYQmS8ym9q93OPL4ygUkvZVMAhk989UQh6gPkhw=;
        b=SO8WvjINYH1bDQLohxGIYb/11NW9ogVq9HvGsL0MWpvHwEznxccuM57vV0q2qbJtIV
         Hj+SX/I7GCVqiry35ejqDUZ82NTnQZ9T9IZhQ2QtyPQ7yD+UdsItRaj0iKAiwDhAYtFy
         Sk0u2T8VoADNnJCzeaWkExrzCbdBMLLWfOFKlaLaNvbXVDwH2wMg+Nxy2AowuP1aitNp
         v1QQOd9HzY6H3V7x416T7WA75DLmUH84E0CS9zp+4EAkL2Jus6MDmXRSTNbUVFH1+lZ/
         I247vHLMFLUHWp4NrCs+cgFlImgXk9FomJo4ppP1SGcEsEV15jUyHWFOTSAf/dFrgROZ
         szDg==
X-Gm-Message-State: AOJu0YwrL/GYO4BubIRCjmxmNj/enVpNwEI76AOv4A1QWn9cbym8PYbo
	9B/H1+5fef/gbEio1JvxoPDv3bgg7xdmBpK8ieg/yXrwEMxytkpsIuJKjDPgZ5I=
X-Google-Smtp-Source: AGHT+IEs+peILcIRfhYUBXGoK/urWQLQL9xsUphTDmjSi3ujBO6CMIZ8LYf59gKUJf0x9XvLnLt11Q==
X-Received: by 2002:a81:728b:0:b0:5ff:567b:74df with SMTP id n133-20020a81728b000000b005ff567b74dfmr869253ywc.22.1707430038827;
        Thu, 08 Feb 2024 14:07:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLoiZ6G/12idz1f/na33KpKhKWIdBH11yWQj7BE7PxsyyacYxZ3xA6nqw4JurYfdjGlRXNYOJC+WCZXxrOLTWBCKOLjpgKGt78gkg8WOWqQkkumeuxeEOj8QZ2Q8f7/A2W/JVdmybrjRA0Iy9eHy3pdzEvKggtc6FAHSg2FIfuJprmWbzRK9R7GxINrZnBHpCHEWSrl76Gvo6WHAXN8kkhMH8jSMmnF+FuZquWT656erlpCs1LhWic+AiY0nb1dyEuYb92tZOHpJ8fN2gUD0JG4kpt4a6/SHqb4UXrhuE4RwbdHq8RZyJVQ2dkzFC4BzNYMgTe9428PPQR6j07GzzJmhlwNIg1TYQlOw==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b006049e3167fcsm61320ywe.99.2024.02.08.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:07:18 -0800 (PST)
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
Subject: [PATCH net-next v6 0/5] Remove expired routes with a separated list of routes.
Date: Thu,  8 Feb 2024 14:06:48 -0800
Message-Id: <20240208220653.374773-1-thinker.li@gmail.com>
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

Majro changes from v5:

 - Force syncrhonize GC before query expired routes with
   "sysctl -wq net.ipv6.route.flush=1".

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
v5: https://lore.kernel.org/all/20240207192933.441744-1-thinker.li@gmail.com/

Kui-Feng Lee (5):
  net/ipv6: set expires in rt6_add_dflt_router().
  net/ipv6: Remove unnecessary clean.
  net/ipv6: Remove expired routes with a separated list of routes.
  net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
  selftests/net: Adding test cases of replacing routes and route
    advertisements.

 include/net/ip6_fib.h                    |  46 ++++++-
 include/net/ip6_route.h                  |   3 +-
 net/ipv6/addrconf.c                      |  41 ++++--
 net/ipv6/ip6_fib.c                       |  60 ++++++++-
 net/ipv6/ndisc.c                         |  13 +-
 net/ipv6/route.c                         |  19 ++-
 tools/testing/selftests/net/fib_tests.sh | 151 +++++++++++++++++++----
 7 files changed, 290 insertions(+), 43 deletions(-)

-- 
2.34.1


