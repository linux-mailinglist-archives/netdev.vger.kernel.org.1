Return-Path: <netdev+bounces-74588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBD861F23
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E09D1C22B1F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE1148FE2;
	Fri, 23 Feb 2024 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LCOKJ5Yu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D32145B1B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724433; cv=none; b=IxhJXU8EhnNSSPuaAGovk0k//oevEId6mT9iFrScrVftWheSCfUUctT12oMD9rqQl9b/dm+/Ei7uUQrnGQqg/vQoCIC9oCBF9hZSFI67D8dcgabCQB8M+meatCFfUiz3AdCjymdBysMMRkxzZeD14/Nj19MQdfz0cm44OdNDvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724433; c=relaxed/simple;
	bh=OWsxxwor+Gt5qfJ9M+iLrLbwz5PeL+heBz1jUIQAUnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DfJyOf6TgkgWJ72SKfCD/ihmAzNkRTbxQ9g7FmVvCbLWq2NhThWvW0X2XE+1uI528cGBQZwrAa9o1V2ABwrstOZJCFP2fVedTJXCHq6okmJAJGQGUXiFIBmXswxxYDboqMW3D8VgqRrw67knsp2HRVLQzt1mjr86iFueURI+NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LCOKJ5Yu; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724429; x=1740260429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d4qnCajh8SxwQDVNTyzQb/LDEuymboC0QO9NBAHrN6s=;
  b=LCOKJ5YuKtdd8d6l5On/lsPl5bW+F8xtWZGsL8w8tQY7sgHteZn89GZI
   9JZ4Wiru62hK9pSGWtJFFXtJzh4qQxyeOFh1d5JsVHOO3xCag+hw7Aw7B
   Hs7zmVMoXDkf9/8ePqRAaSGwhzJS9LeR90ZHNEnNcQq4tKPuiWsgDxBYz
   c=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="383301748"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:40:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:53971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.221:2525] with esmtp (Farcaster)
 id 0697ce43-381a-47ea-adae-2cd974b337e9; Fri, 23 Feb 2024 21:40:24 +0000 (UTC)
X-Farcaster-Flow-ID: 0697ce43-381a-47ea-adae-2cd974b337e9
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:40:24 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:40:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 00/14] af_unix: Rework GC.
Date: Fri, 23 Feb 2024 13:39:49 -0800
Message-ID: <20240223214003.17369-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

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
algorithm, and we will consider each inflight AF_UNIX socket as a vertex
and its file descriptor as an edge in a directed graph.

For the details, please see each patch.

  patch 1  -  3 : Add struct to express inflight socket graphs
  patch       4 : Optimse inflight fd counting
  patch       5 : Group SCC possibly forming a cycle
  patch 6  -  7 : Support embryo socket
  patch 8  - 10 : Make GC lightweight
  patch 11 - 12 : Detect dead cycle references
  patch      13 : Replace GC algorithm
  patch      14 : selftest

After this series is applied, we can remove the two ugly tricks for race,
scm_fp_dup() in unix_attach_fds() and spin_lock dance in unix_peek_fds()
as done in patch 14/15 of v1.


Changes:
  v3:
    * Patch 1
      * Allocate struct unix_vertex dynamically only for inflight socket
    * Patch 2
      * Rename unix_edge.entry to unix_edge.vertex_entry
      * Change edge->successor/predecessor to struct unix_sock
    * Patch 7
      * Moved after SCC detection patch
      * Fix up embryo successor during GC instead of overwriting edge
        in unix_add_edge()
        * To not allcoate unix_vertex to listener for embryo socket
        * Kept the name unix_update_edges() unchanged as it affect
          successor tracking during GC
    * Patch 12
      * Drop self_degree and check all edges
        * To not allcoate unix_vertex to listener for embryo socket

  v2: https://lore.kernel.org/netdev/20240216210556.65913-1-kuniyu@amazon.com/
    * Drop 2 patches as follow-up that removes trickiness in
      unix_attach_fds() and unix_peek_fds().

    * Patch 2
      * Fix build error when CONFIG_UNIX=n
    * Patch 3
      * Remove unnecessary INIT_LIST_HEAD()
    * Patch 7
      * Fix build warning for using goto label at the end of the loop
    * Patch 13
      * Call kfree_skb() for oob skb
    * Patch 14
      * Add test case for MSG_OOB

  v1: https://lore.kernel.org/netdev/20240203030058.60750-1-kuniyu@amazon.com/


Kuniyuki Iwashima (14):
  af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
  af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
  af_unix: Link struct unix_edge when queuing skb.
  af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
  af_unix: Detect Strongly Connected Components.
  af_unix: Save listener for embryo socket.
  af_unix: Fix up unix_edge.successor for embryo socket.
  af_unix: Save O(n) setup of Tarjan's algo.
  af_unix: Skip GC if no cycle exists.
  af_unix: Avoid Tarjan's algorithm if unnecessary.
  af_unix: Assign a unique index to SCC.
  af_unix: Detect dead SCC.
  af_unix: Replace garbage collection algorithm.
  selftest: af_unix: Test GC for SCM_RIGHTS.

 include/net/af_unix.h                         |  31 +-
 include/net/scm.h                             |   9 +
 net/core/scm.c                                |  11 +
 net/unix/af_unix.c                            |  27 +-
 net/unix/garbage.c                            | 526 +++++++++++-------
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/scm_rights.c        | 286 ++++++++++
 8 files changed, 685 insertions(+), 208 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights.c

-- 
2.30.2


