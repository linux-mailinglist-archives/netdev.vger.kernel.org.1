Return-Path: <netdev+bounces-81759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E088B142
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E292E1F61443
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620445026;
	Mon, 25 Mar 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jg1LtUSH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448545023
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398290; cv=none; b=IkTy/EUt72IK8QFqet+ioeg62dToJPRnQ06MBeazTHizKRnFZnV6Wv7YL0MG0aCSukh4uNIad4uB8Hfzh8BVGkHqcnLdaCUXEYTqK9kNT34OhlxIQHQ5TcDbI+thIpqPaB9x7BEs9uzlkxflnlnZgp1jF1cTkhpPh2b+TXbmc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398290; c=relaxed/simple;
	bh=sDif3+3o7vYdtp5FnOp8sAbzR/ddMZeJA3NowHNXJkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O465bqpccD9CZL6IQp1+ZCkEknVomBObAYcPoYW4yjR5SxtPO6XlNxh90806Enaf0HkFvfYEA6ovk+krTLefl3UXIqBX0wLrx7g6SttyRTi4O+m8FERiULagKTFN8zK2lsUS+DU+fyyLBlpjC+H4JwgctA/IV1A9PZ0aWacpXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jg1LtUSH; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398289; x=1742934289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iDlp2Ow6J3WTr3vd68h5yuA3wmz9ljA120C/qhmFhZI=;
  b=jg1LtUSHc2oyw5oeU6rReWjUZdBdP/bxu0MoMs/g+50ps81vANJU9LTv
   y0XjKJucONKXKxtMDSE4GVxExM9azdCF/D50ezTRXaGPLyPMxRrFhZvbo
   Q/xRueXs1o8zvtuWsuUFnX3MW5G7R30QR9nQEYpZM8QJgaU5HDp2oYWy7
   0=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="283722690"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:24:45 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:39832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.239:2525] with esmtp (Farcaster)
 id e4abef63-ea86-4ffb-affc-bb886ef32aec; Mon, 25 Mar 2024 20:24:44 +0000 (UTC)
X-Farcaster-Flow-ID: e4abef63-ea86-4ffb-affc-bb886ef32aec
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:24:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:24:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 00/15] af_unix: Rework GC.
Date: Mon, 25 Mar 2024 13:24:10 -0700
Message-ID: <20240325202425.60930-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
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
algorithm, and we will consider each inflight AF_UNIX socket as a vertex
and its file descriptor as an edge in a directed graph.

For the details, please see each patch.

  patch 1  -  3 : Add struct to express inflight socket graphs
  patch       4 : Optimse inflight fd counting
  patch 5  -  6 : Group SCC possibly forming a cycle
  patch 7  -  8 : Support embryo socket
  patch 9  - 11 : Make GC lightweight
  patch 12 - 13 : Detect dead cycle references
  patch      14 : Replace GC algorithm
  patch      15 : selftest

After this series is applied, we can remove the two ugly tricks for race,
scm_fp_dup() in unix_attach_fds() and spin_lock dance in unix_peek_fds()
as done in patch 14/15 of v1.

Also, we will add cond_resched_lock() in __unix_gc() and convert it to
use a dedicated kthread instead of global system workqueue as suggested
by Paolo in a v4 thread.


Changes:
  v5:
    * Rebase on the latest net-next.git

  v4: https://lore.kernel.org/netdev/20240301022243.73908-1-kuniyu@amazon.com/
    * Split SCC detection patch to 3 & 4
    * Add comments

    * Patch 10
      * Remove early return in unix_update_graph(), (cyclic=1, grouped=1)
        triggers access to uninit scc_index in unix_walk_scc_fast()
    * Patch 12
      * Make unix_vertex_last_index local var
    * Patch 13
      * s/dead/scc_dead/
    * Patch 14
      * Fix lockdep false-positive splat
      * Make hitlist local var

  v3: https://lore.kernel.org/netdev/20240223214003.17369-1-kuniyu@amazon.com/
    * Patch 1
      * Allocate struct unix_vertex dynamically only for inflight socket
    * Patch 2
      * Rename unix_edge.entry to unix_edge.vertex_entry
      * Change edge->successor/predecessor to struct unix_sock
    * Patch 7
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


Kuniyuki Iwashima (15):
  af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
  af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
  af_unix: Link struct unix_edge when queuing skb.
  af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
  af_unix: Iterate all vertices by DFS.
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
 net/unix/garbage.c                            | 573 ++++++++++++------
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/scm_rights.c        | 286 +++++++++
 8 files changed, 735 insertions(+), 205 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights.c

-- 
2.30.2


