Return-Path: <netdev+bounces-68756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75208847FC4
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D9A1F2319D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DF46A5;
	Sat,  3 Feb 2024 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XA1wQ3m2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D62582
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929279; cv=none; b=OfKI/SYOgliXWUJcYD7tb+Q7q8ng+cOTa0ArCjjTEcXQzQLzOSYE51yDbysdvWaa71D8hy3Jjaqn4ePQx6ShyfJdPmZ6WZ/8+50Fp1hyWw4tVkbXQFnSQPPROVj7gIOheLuFxa4XKXUrJnnyqbZDaDSRmwXQemlC0lwi13OxHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929279; c=relaxed/simple;
	bh=sn+f1CFyGJOXNXsEj78tXbaAgZELY4QybJgZVaSJ93g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b24B1wHC8bXYpkRfSgCNIajVsiFtPRNn4b3vsHQCZ9FKyAHfrYjPCqtXhXNfbpHiYyjS/lgiNRlbnPQ8PAoTvLIV38wyIcXCPYPvpjMQxof8DYTy60BlW8QNl1GMIQ1R/tVzsGFLC8UEdTE8auH1raWldH8Z9YCnpZ5EFH7o2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XA1wQ3m2; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929277; x=1738465277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kJWMbd27uEDoOvOWXBAenhSrwJdSt750ujG2qjjqwA8=;
  b=XA1wQ3m2uuIkVkVdYrzqkdXqMXU1PbkhClnsG+VqBwO1QN19kLFT+j9l
   RTkBMCPPMdNeAzAHwLHnZnIJayRTOgnkyCqhskgo4zb+CLSiVUa1u8oYf
   ZT9LlwDtmjxKhFr2LR9G7FDss1/vjGt9IdadT/DV41I0a7fPxeyAFqJH6
   I=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="635435546"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:01:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:50718]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.186:2525] with esmtp (Farcaster)
 id f106fc65-8286-4fe7-b1a1-d10aec6e2f71; Sat, 3 Feb 2024 03:01:14 +0000 (UTC)
X-Farcaster-Flow-ID: f106fc65-8286-4fe7-b1a1-d10aec6e2f71
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:01:14 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:01:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/16] af_unix: Reimplment GC.
Date: Fri, 2 Feb 2024 19:00:42 -0800
Message-ID: <20240203030058.60750-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

If socket B has the fd of socket A, socket B holds refcount of A, and then
we consider it as A -> B.

For the details, please see each patch.

  patch 1  -  5 : Add struct to express graphs
  patch       6 : Optimse inflight fd counters
  patch       7 : Group SCC
  patch 8  - 10 : Make GC lightweight
  patch 11 - 12 : Detect dead cycle reference
  patch      13 : Replace GC algorithm
  patch 14 - 15 : Remove confusing tricks
  patch      16 : selftest


Kuniyuki Iwashima (16):
  af_unix: Add struct unix_vertex in struct unix_sock.
  af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
  af_unix: Link struct unix_edge when queuing skb.
  af_unix: Save listener for embryo socket.
  af_unix: Fix up unix_edge.successor for embryo socket.
  af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
  af_unix: Detect Strongly Connected Components.
  af_unix: Save O(n) setup of Tarjan's algo.
  af_unix: Avoid Tarjan's algorithm if unnecessary.
  af_unix: Skip GC if no cycle exists.
  af_unix: Assign a unique index to SCC.
  af_unix: Detect dead SCC.
  af_unix: Replace garbage collection algorithm.
  af_unix: Remove scm_fp_dup() in unix_attach_fds().
  af_unix: Remove lock dance in unix_peek_fds().
  selftest: af_unix: Test GC for SCM_RIGHTS.

 include/net/af_unix.h                         |  34 +-
 include/net/scm.h                             |   8 +
 net/core/scm.c                                |   5 +
 net/unix/af_unix.c                            |  78 +--
 net/unix/garbage.c                            | 459 +++++++++++-------
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/scm_rights.c        | 242 +++++++++
 8 files changed, 580 insertions(+), 249 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights.c

-- 
2.30.2


