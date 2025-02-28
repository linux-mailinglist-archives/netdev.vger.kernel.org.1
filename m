Return-Path: <netdev+bounces-170548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6953A4903F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D00A7A461B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BF18FDC5;
	Fri, 28 Feb 2025 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mshec9U4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC2819
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716625; cv=none; b=FGgvKQUZ7XkM0vXBuD/pgR8D/NsryiFXvYkMebYWC9SzIxVz97bJelI0MD2L2MkYMLQ5aDINKykaHe1eNrYEZfq2WhxsRH2syr9Le1h4jD2FrvnrJuyfu9QcGAXePfOG5w4oajVjdD63A42iu3x53WE+Y9rrXwdYy0ZjdnvKYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716625; c=relaxed/simple;
	bh=jpQpvK8DVBkN4xhaJGMlHfhGs8fUgBj73uvLbJsxVSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nkDHDeCrgIVddy9o4xz66nbozDUyiK3u7h0zSWm0im50nWOmvxxkYcuXB6P+ZHdYJbN0/EEqIl8tI+nxvyO3vSrkTU4L6zlZCijLpDzya95NcYv5Ch9Qb+RVH5XsAfLbn37VWmu+PEaE/pS2k1U/CAohkeEp6M7ILs3vog82Am4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mshec9U4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716623; x=1772252623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H+tg/5E3LDk9s8k2g1dUELkil8mwYi7aVEsCQhQj8y0=;
  b=mshec9U4FG9SoQyHOqmnKYc9SFD2jebDIcxFn2av1YpB2JmY7B3QxYxm
   MOxNiguW8U56Voh3lVba6WmOKTGirYCU41JWOuek6AzcI2e5Sx50cfanV
   7K5gKnZJMUhPlCyQQJRUJxgAiXYV32J/RT4F0DMFVmyH8PAw+5gFHBdyg
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="173990387"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:23:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:54863]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id a07c7e8f-4a1e-4c0d-91fb-e55af0ac1a9c; Fri, 28 Feb 2025 04:23:41 +0000 (UTC)
X-Farcaster-Flow-ID: a07c7e8f-4a1e-4c0d-91fb-e55af0ac1a9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:23:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:23:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Thu, 27 Feb 2025 20:23:16 -0800
Message-ID: <20250228042328.96624-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 is misc cleanup.
Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().


Changes:
  v3:
    * Add Eric's and David's tags
    * Patch 2
      * Use kvcalloc() instead of kvmalloc_array(, __GFP_ZERO)

  v2: https://lore.kernel.org/netdev/20250226192556.21633-1-kuniyu@amazon.com/
    * Add Eric's tag except for patch 3 (due to a minor change for exit_batch())
    * Patch 3
      * Fix memleak by calling fib4_semantics_exit() properly
      * Move fib4_semantics_exit() to fib_net_exit_batch()

  v1: https://lore.kernel.org/netdev/20250225182250.74650-1-kuniyu@amazon.com/


Kuniyuki Iwashima (12):
  ipv4: fib: Use cached net in fib_inetaddr_event().
  ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by
    kvcalloc().
  ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
  ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
  ipv4: fib: Remove fib_info_laddrhash pointer.
  ipv4: fib: Remove fib_info_hash_size.
  ipv4: fib: Add fib_info_hash_grow().
  ipv4: fib: Namespacify fib_info hash tables.
  ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
  ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
  ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
  ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.

 include/net/ip_fib.h     |   2 +
 include/net/netns/ipv4.h |   3 +
 net/ipv4/fib_frontend.c  |  74 ++++++++++----
 net/ipv4/fib_semantics.c | 206 +++++++++++++++++++--------------------
 net/ipv4/fib_trie.c      |  22 -----
 5 files changed, 159 insertions(+), 148 deletions(-)

-- 
2.39.5 (Apple Git-154)


