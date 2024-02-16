Return-Path: <netdev+bounces-72528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640438587A2
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E381C26B38
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA941A92;
	Fri, 16 Feb 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f5qcNXMs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67728E2B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117588; cv=none; b=et6U6RCg4DhTnmMZAU9F99CSaayyXIoSJZQPH9JLRFvezTqKfbkSrREp0YRWpx2N/i3pRm4NDxoscPLjkET7RataKs9vdlM+snY1m/8atUZoXaEMJ8dmYTLnC/DTDEhxhoIy84c5OINLtdN+0KxY6QM3Y6jd0/JYd1l/JdZCHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117588; c=relaxed/simple;
	bh=nyyTcg7M3SaOlU6u8WbJucb6cfowHp/cGKSAnyA2H2o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/Ia4mtXVJboLFJckiAFfeD4jlVUzWklRh9JLhqn/RGU7uO38e9ceV6sGlnCZOyHHZarOBoJ8mbMrazgZuudbXBE9Cj5rh2AimE+ycAlc1YgVJLgIr98gs/kDepMEdLtECSZZI9AOPQSkt4+5XK74MvMIbNY7O7s2yqiLPc5ZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=f5qcNXMs; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117587; x=1739653587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AO7HEql7TvqW+06Q7aKT8PrpPLbZmbNcsqc2Fa7j67Y=;
  b=f5qcNXMsXo5BRWj/7/iC5uQm8Aez2HbGQEE9tU+FC9mWvue4wgRGa6l7
   zBVvcLWZi7kvPzNn9t6PEZb1XR0AB4Kbdf0HPEQLVXRjik6htf7g9kzG/
   cc047emTPWwkTDfl8jAOUxe4UwlqYTeG8Xa1M06SOfQVmjXs6tyhsgL+I
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="274710238"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:06:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:64697]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id 27fb96e4-dbe8-4c5c-9306-d8359be8fc52; Fri, 16 Feb 2024 21:06:24 +0000 (UTC)
X-Farcaster-Flow-ID: 27fb96e4-dbe8-4c5c-9306-d8359be8fc52
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:06:24 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:06:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/14] af_unix: Rework GC.
Date: Fri, 16 Feb 2024 13:05:42 -0800
Message-ID: <20240216210556.65913-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we pass a file descriptor to an AF_UNIX socket via SCM_RIGTHS,
the underlying struct file of the inflight fd gets its refcount bumped.
If the fd is of an AF_UNIX socket, we need to track it in case it forms
cyclic references.

Let's say we send a fd of AF_UNIX socket A to B and vice versa and
close() both sockets.

When created, each socket's struct file initially has one reference.
After the fd exchange, both refcounts are bumped up to 2.  Then, close()
decreases both to 1.  From this point on, no one can touch the file/socket.

However, the struct file has one refcount and thus never calls the
release() function of the AF_UNIX socket.

That's why we need to track all inflight AF_UNIX sockets and run garbage
collection.

This series replaces the current GC implementation that locks each inflight
socket's receive queue and requires trickiness in other places.

The new GC does not lock each socket's queue to minimise its effect and
tries to be lightweight if there is no cyclic reference or no update in
the shape of the inflight fd graph.

The new implementation is based on Tarjan's Strongly Connected Components
algorithm, and we consider each inflight file descriptor of AF_UNIX sockets
as an edge in a directed graph.

For the details, please see each patch.

  patch 1  -  5 : Add struct to express inflight socket graphs
  patch       6 : Optimse inflight fd counting
  patch       7 : Group SCC possibly forming a cycle
  patch 8  - 10 : Make GC lightweight
  patch 11 - 12 : Detect dead cycle references
  patch      13 : Replace GC algorithm
  patch      14 : selftest

After this series is applied, we can remove the two ugly tricks for race,
scm_fp_dup() in unix_attach_fds() and spin_lock dance in unix_peek_fds()
as done in patch 14/15 of v1.


Changes:
  v2:
    * Drop 2 cleanup patches (patch 14/15 in v1)

    * Patch 2
      * Fix build error when CONFIG_UNIX=n
    * Patch 7
      * Fix build warning for using goto label at the end of the loop
    * Patch 13
      * Call kfree_skb() for oob skb
    * Patch 14
      * Add test case for MSG_OOB

  v1: https://lore.kernel.org/netdev/20240203030058.60750-1-kuniyu@amazon.com/


Kuniyuki Iwashima (14):
  af_unix: Add struct unix_vertex in struct unix_sock.
  af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
  af_unix: Link struct unix_edge when queuing skb.
  af_unix: Save listener for embryo socket.
  af_unix: Fix up unix_edge.successor for embryo socket.
  af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
  af_unix: Detect Strongly Connected Components.
  af_unix: Save O(n) setup of Tarjan's algo.
  af_unix: Skip GC if no cycle exists.
  af_unix: Avoid Tarjan's algorithm if unnecessary.
  af_unix: Assign a unique index to SCC.
  af_unix: Detect dead SCC.
  af_unix: Replace garbage collection algorithm.
  selftest: af_unix: Test GC for SCM_RIGHTS.

 include/net/af_unix.h                         |  33 +-
 include/net/scm.h                             |   8 +
 net/core/scm.c                                |   9 +
 net/unix/af_unix.c                            |  27 +-
 net/unix/garbage.c                            | 473 +++++++++++-------
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/scm_rights.c        | 286 +++++++++++
 8 files changed, 632 insertions(+), 207 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights.c

-- 
2.30.2


