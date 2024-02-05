Return-Path: <netdev+bounces-69262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728584A8BB
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAA81F2E6A9
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350F5915E;
	Mon,  5 Feb 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqr5CHjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11F482F7
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169242; cv=none; b=Rk498LI/ooappvenL+k7Usq+SxJ5Jg5yppD1wYs9stEa2JHkrNjIzjmc+hjHPccAind8wDgqTVFP7ZsQnoFDX6FDLW+Pmqd4HL2dZP+gPvZPBOSlbzRe+LTaOy2MvYNOBiM2NG+vDwX9eLTAXNKPK9Krtev1cGsGxmMJfqlfkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169242; c=relaxed/simple;
	bh=6LpAceWVM9pA6pOaXXLcakS1wNo+7HzyrS5BtB9zDcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gn3LKBbqci6ys4uph/YxR1Hhs0KPWfdXUq/FqWtilPrYxVeFLrLKdtnuHcz4FPUhvYyvTSBCaMuebWDQx3o6fNJWZ7wp2oCbzKQFHROrp5ct0x4AQA7wJerJxEC9KOP60q2AjxuL+0aY+nH4YTciYGESrQK2Eu69BjOcCYu9Jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqr5CHjr; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so4494551276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169239; x=1707774039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmlP1zfydvH8qHcG3icMr5PJkdETknfc+IVlCCke5QE=;
        b=Wqr5CHjrzoNH9qD0+vEW01jetPMWqJF+vpFFxHb63wP+x6r6k4olMY+U+1gzJzJhMf
         21aVnbDiUMK+hSma9rjardjA4vhrwRB4f9ngpxe/w7xZpFP1qbr6myZVxG+mJkE2/U7L
         aXE7OEood9dVu/fXEldEi9ZiP6cNliFhhT0BvsSKRYl6QEOkAbJSlmfNGOY/miP3e9vg
         1V85satpMz5uljPOH6B/P4jseantovpWaXyTYPiIxPmSDW4wJKPPKAH3b97rsRiAi5kS
         gUW5hq3h74Ccy7JaADfzc3ECshDW0gJwcvXHAhtCDnqYcbsR9GFLMnky5RhckceHBuOe
         X37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169239; x=1707774039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmlP1zfydvH8qHcG3icMr5PJkdETknfc+IVlCCke5QE=;
        b=LH4pfItvT7G15QTeNmyM4cNxDvDVBBTnv9ft8oIQu929W4wBquwXT+Afj+rVhkeAeu
         0CuKPF0TTs63c2Ex2XoWxG4co3tNYdD8Ud9k9xIKw30WSHjZ3aPg0S2iieQjGuTO3HiK
         VtA77YdG1l20F3Y5frJf9kHbdYw2d9iXdD7gBB0/TyFyinlyYe8lNsSXhNy1flVF17YS
         cAWTAU1AmPfeTPIFenEm78C5m1DB4ZEqpGg+OYDIw1AZyuO8F/rlbB6SxfUr+NWj8r3N
         seuYq0EVLIzBT3k3B4P0Az+SWNeI4kSurU9xXM5PK/rVAv0KDSMFmOj18SA4Bh+LLC98
         3zQQ==
X-Gm-Message-State: AOJu0YwzbY7bVgxY72tZur91kMJN3HWCEH4zbHnDUcd6INop3UY0Ed5A
	+fpDRDakIHv9aq7LhFZFHPcA0bBn7JaSgMGsD6mVPMigLXiPyRUbpbUbiHs3uIw=
X-Google-Smtp-Source: AGHT+IH8R7lZpLyK5YHlkGgvFY2fe7OuTaqubsQKbl+YYk0lVVrQJWoQwsh4mC0fEzbITO0ljzpjnQ==
X-Received: by 2002:a25:2e46:0:b0:dbf:238b:add3 with SMTP id b6-20020a252e46000000b00dbf238badd3mr711415ybn.39.1707169239155;
        Mon, 05 Feb 2024 13:40:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXUZz1i/tqZqhZQ6GwHFk/EAU71HuGcBnSsfwdpXpgCgTepxgC9vI/fT2DqpEEz/k7ymxBiWYzo+vlefe46xZz82e2kh4MNpki0d3IgsdQGxCKi5rG8ttNFTUjGp7HvjBfXkHmcpu/SKK//gptgSOYuCvFB0YKcwF4b7hgf98Gm9LV+unBitEqida+2JJzuBqiS57SJZsjR6YF86Zj0pPoDUyOJyzG5dWqv2AA7ToB4S0YE3FuWVd25sjkizdUatC8XpLAtY9PtVOhVWcCMhEUcLRrUjP1hw5uUKnKLaisPj366Tq7CKIGMjz/aPRasGnJ9ImbdtZPIQEOR67Y9jUKxwqkYFetU1BvjNQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id d7-20020a258247000000b00dbf23ca7d82sm160936ybn.63.2024.02.05.13.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:40:38 -0800 (PST)
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
Subject: [PATCH net-next v4 0/5] Remove expired routes with a separated list of routes.
Date: Mon,  5 Feb 2024 13:40:28 -0800
Message-Id: <20240205214033.937814-1-thinker.li@gmail.com>
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

Kui-Feng Lee (5):
  net/ipv6: set expires in rt6_add_dflt_router().
  net/ipv6: Remove unnecessary clean.
  net/ipv6: Remove expired routes with a separated list of routes.
  net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
  selftests/net: Adding test cases of replacing routes and route
    advertisements.

 include/net/ip6_fib.h                    |  47 ++++++-
 include/net/ip6_route.h                  |   3 +-
 net/ipv6/addrconf.c                      |  41 +++++--
 net/ipv6/ip6_fib.c                       |  60 ++++++++-
 net/ipv6/ndisc.c                         |  13 +-
 net/ipv6/route.c                         |  19 ++-
 tools/testing/selftests/net/fib_tests.sh | 148 +++++++++++++++++++----
 7 files changed, 288 insertions(+), 43 deletions(-)

-- 
2.34.1


