Return-Path: <netdev+bounces-67870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E2845292
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553F61C21AED
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202F158D88;
	Thu,  1 Feb 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/gCJIl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F61586D3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775630; cv=none; b=AXJYqQIFxCbDe1vAP4FlJeI7MI2lYALNwZchxuS3FmPBatxERpUvpKLkDpP/aQSdv3X6zmpPOus+Llnam7TzSKgeqV3HvgSpQEAJ9RjTVeygB5j2vgbR6qvjSVOPfgFdRdKqdcJBOx/ANnoXK1JXDqbzCe+9smjflKRLk7gHXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775630; c=relaxed/simple;
	bh=GqGnAy3+aphrlbagXWWRUmba8RphMb+mfDEspGTfygY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLe4td+nr9oMqIjuu2T+7amW/wS5jNj+qei2WW8W62LspsHq4b4zIGunacvbA9FZCSUeWZKA66ge0aPT41MHcPN1zjogEW+TjTL1ytPW0yXkzmHP9hXknLDar/rKE9rduswEZmtF0YH7rQTvtMbhtdUr/M9NE6jLqQUCcGoWl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/gCJIl7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60412f65124so6565437b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 00:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775627; x=1707380427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H74uBSYPuA5MLeKVeci45m+lpkAlQKR6+WealTr+ZCY=;
        b=U/gCJIl7r3mYzkD1+fCW2kaFDbrugHENlBhrDkkk+bz7p0ZCTHoPuY9SsnKKRKn3/Y
         0C6FBv09SF2vPi7HP4A4VGi0+CCcReXyxb/7poTGJqYemT65Lr0AT2ctqBRREUocmr7h
         TeURzM9nLMm8kWGYZWS75BgNfYh/UL91OTqBXeM0Om4yri+hp9Kint2wHOBl6r/lB3yz
         5tFrG+hO3nygHFHDoqzjGb7cbN6RA5V2m3VM5D1Gl/3kMsEw0NZMAPPQrWKec5VSArxH
         pypE2WbpadNkCEP5hjUnLv+oR34VvQvCAFY/EVhgjHbwSYuG1a2iN3Sygk51Hgh9lniC
         okUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775627; x=1707380427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H74uBSYPuA5MLeKVeci45m+lpkAlQKR6+WealTr+ZCY=;
        b=MBZHvIEo+g9HkzLJHP+rdQNK/e25NUciIvHrADJWwgF8nlfU0/K9b53Q3bP6XoaFJI
         6R4FJ3XxC7Ocba9iy0hL3DdhymbWiP82tlcZy+v1YYXYFZ+fbYYrcnaC4quMIyqyd4Hh
         mTx9BusbeGhr2u76h2dagOYi1WN82HCYW66ugNWcpPHyyszmDYWQwWT33Kshdw9X+5ON
         9qFs8jDu4diU92KmY/X36OHeXZE2CjusIzxeRpE6ORiWM0CAAgpBuUFxPYALQ5Lh7Ctt
         oJJ1CKbrbma3teRD2jNoZKPvfG2/6ExfqTz4kSXblrPXyqnEmMRFF1k87A/zFlgs9MSl
         8nZw==
X-Gm-Message-State: AOJu0YwAVvNLp0Rysf/WIDcNU2tCohVsB7s5f6/lIUeL/QNZXvGzkNBK
	pUN69AI5d2nD+2JCxu0ZlHPxIb5zRCpx8RiAgAOJu0HKK01Tmg8lzM+ACmJWEE8=
X-Google-Smtp-Source: AGHT+IEaEO1JAMEHZiJ8g7zWW2W0apd9hzI8A+qYdKwCIjI8dnpF520vYF2WKP/hYJPTC1CkLuV9kw==
X-Received: by 2002:a81:4f0d:0:b0:5f1:2dcc:fe5e with SMTP id d13-20020a814f0d000000b005f12dccfe5emr4271383ywb.46.1706775627254;
        Thu, 01 Feb 2024 00:20:27 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b616:d09e:9171:5ef4])
        by smtp.gmail.com with ESMTPSA id w186-20020a0dd4c3000000b006041ca620f4sm209090ywd.81.2024.02.01.00.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:20:26 -0800 (PST)
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
Subject: [PATCH net-next v2 0/5] Remove expired routes with a separated list of routes.
Date: Thu,  1 Feb 2024 00:20:19 -0800
Message-Id: <20240201082024.1018011-1-thinker.li@gmail.com>
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

Kui-Feng Lee (5):
  net/ipv6: set expires in rt6_add_dflt_router().
  net/ipv6: Remove unnecessary clean.
  net/ipv6: Remove expired routes with a separated list of routes.
  net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
  selftests/net: Adding test cases of replacing routes and route
    advertisements.

 include/net/ip6_fib.h                    |  36 ++++-
 include/net/ip6_route.h                  |   3 +-
 net/ipv6/addrconf.c                      |  50 ++++++-
 net/ipv6/ip6_fib.c                       |  58 +++++++-
 net/ipv6/ndisc.c                         |  14 +-
 net/ipv6/route.c                         |  20 ++-
 tools/testing/selftests/net/fib_tests.sh | 161 ++++++++++++++++++++---
 7 files changed, 306 insertions(+), 36 deletions(-)

-- 
2.34.1


