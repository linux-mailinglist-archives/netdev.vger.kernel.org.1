Return-Path: <netdev+bounces-67435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5C8436EA
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 07:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A93B1C22758
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355232186;
	Wed, 31 Jan 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7aJqldO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FB51011
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683247; cv=none; b=BFiL0MStM419ljIfLNsTk42BBM7OF7gydLWn9SR6wtR0fZ9VFn+C10mKN5NaX3wBWAEoGQjD+PrMxG7oliV7QC2gC2MrFKnTZVcQVk6B1MkXTXKci0ECY8C2Q0DpYPiXLC2lZEn70yUoe8auDdRd0Vf3P0OKUBIlQ1dLlZ+gjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683247; c=relaxed/simple;
	bh=u7tHbYmfgFKPryryDzcWXW7yDRXJXLNX0YONcJ5AW3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jsDP8uyZcEq6IGT3oeMJeWxnqDwNoARTGJAAyzIMZxbzHAbHJwjNbl7a8vL8uWrgNTG//Azf/vAAboHcL4dUKiCIbxYPZRbpgy1seHKm4atiJuc00dApxO0PP/fSzBFRlRxdX/6e9qbpkxBOjuaWxq6nA5GUypasv/bTzovYtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7aJqldO; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4783466276.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706683245; x=1707288045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xii9v6yBDHuufwEqPKjXSveU52i/0nWLFD+8xN0mg4=;
        b=B7aJqldOw94EHJt50gdbnO9NT1CQw7gg621ZoJbijnqEplKNR5/ypI7gItXZxM4k5N
         m/l139RI1xptN4PNiuMzyWBEmSciUrA9485xhUerbJizsrhjG4zxGsQ5WqcT7Fhz2GBS
         Zel5lkC1G54i+Ko1WCkWaRMmYtF1BIBXm/YMhB0o1cfW3HyzKBojgddOZ/um8gNv1YtL
         tlKYzO7uFbGNvfYa3V5qW+JdpQgWBKvjZItG0J91Jhf75ha+vqW4QpSu05QYyDYaI5uI
         3CAc+9QgCP44/etIGO8l0ZWVwxSU7PCL8fbhjSpdICX8xnQ2lRoPUiFhow6aK3Mkb3uc
         Ykiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706683245; x=1707288045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xii9v6yBDHuufwEqPKjXSveU52i/0nWLFD+8xN0mg4=;
        b=LUoWs9QH4SAWbXdq5gM6yWZ8RQvEX2r2Xpvzw0741WTkrY+xxQtBRR3VdF5afnCIM3
         QoWUehnLSiGlXfjrTuNp5T/KLtvBSlRq4FoEK2YUWW4gmJyQrDIAFY1MGB0GF4OYX3f3
         jf4t9tPwgwu+U2qM/V/MJzipF4cMEyz4wiSy/5bJwcpueQ+7baphlIUDIvY4xRYBERwz
         p5fcyIDRiARNqQ0wlETgbeoN3an+oQIJdc0xg/qIyhMDAe/V96N6Ji79YXoOCSubLarf
         NuYE20GDNgBqlgk0eGktJ/42+bLFHpdvAKQooP+JcuwxOQEtWGGtXIt3u/KxHqiPG9bp
         bdnw==
X-Gm-Message-State: AOJu0Yz8scL71/QWg5ca6ubjBsLB/zUx5BNT9HMCbbuvwZce0RMlM6Mf
	6aPdRd5P+ppnOYXs9ZY6H1GloZ8WTNLmKd9fMTH0nD6h2JbkfnmDOj6VYp3undM=
X-Google-Smtp-Source: AGHT+IFi46IMmw5ck24T2Yojk7irQNwKziYL0J/yBmFTsDUiVO1QwHuM+/FPtR3um+b2vBgBArLRvQ==
X-Received: by 2002:a25:b288:0:b0:dc2:1a4f:bc30 with SMTP id k8-20020a25b288000000b00dc21a4fbc30mr734158ybj.26.1706683244576;
        Tue, 30 Jan 2024 22:40:44 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7a8:850:239d:3ddc])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc228b22cd5sm3345683ybm.41.2024.01.30.22.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:40:43 -0800 (PST)
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
Subject: [PATCH net-next 0/5] Remove expired routes with a separated list of routes.
Date: Tue, 30 Jan 2024 22:40:36 -0800
Message-Id: <20240131064041.3445212-1-thinker.li@gmail.com>
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
 net/ipv6/ip6_fib.c                       |  58 ++++++++-
 net/ipv6/ndisc.c                         |  14 +-
 net/ipv6/route.c                         |  20 ++-
 tools/testing/selftests/net/fib_tests.sh | 159 +++++++++++++++++++++--
 7 files changed, 308 insertions(+), 32 deletions(-)

-- 
2.34.1


