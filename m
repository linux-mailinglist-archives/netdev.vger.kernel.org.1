Return-Path: <netdev+bounces-133227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554299559F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7271F25C7E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364861FA255;
	Tue,  8 Oct 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vvDt+LOI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D31E1A08
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408563; cv=none; b=pRzFl2dXM0Zz/oPAJY/vwq0hwFIYCDI9LGUN9H36zwZQMxYhmAgCc2dnnUoqYxz9+OINhQ3nIM130DMysQhCXepCdnHK+D34/R67I7fBm+RjjGZ2JLyXyj7X46G0r4Yt3ZcH9kgXmmBNYWdkvMpNEiSqmWm7yaKG+g+RoSZ/li8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408563; c=relaxed/simple;
	bh=kPW1zf2dS7ss/FmVnW+dWEcJhiqVHR2XzegrbdIX9Ug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BChEkMZ2f5pjcKLqTQACaFSdzlSlAdjkUoQt6Abo9rXVQeRbklOuWgt4PEMmX/osdyfD8qlln9xA9TOVQQUZPzQ+yBU1PBu4Zag2rR6zDK3Z6Z/euE6eMR6WeO1lTeYCmVXiVJWlNtGNd+ke/PolHkub7AmwnZ+f+z7cLE23bSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vvDt+LOI; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728408561; x=1759944561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wTyBxTj2YXT3UCmWlcYQ8s9d7K+m/nKi/VuE54Q24oI=;
  b=vvDt+LOI21eWSfiPZa6csivgCJqF8qQpyGRfBbdoQPgXNybOVQi/kJVf
   vyWBlEISrGrI8gq5w7ChvD/ykRhocNfsGre29S4NnMRyrgRct+lZGEHJw
   I1L+1+l/Y033ozpk7TfGDPxa08VmAiJuJ3QJjn4M0kUCkHReA/H6vdqm9
   c=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="686030767"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:29:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:58205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id a5b566fe-07fe-4e5e-a3c4-80bd5d443f2a; Tue, 8 Oct 2024 17:29:17 +0000 (UTC)
X-Farcaster-Flow-ID: a5b566fe-07fe-4e5e-a3c4-80bd5d443f2a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 17:29:17 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 17:29:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/4] ipv4: Namespacify IPv4 address hash table.
Date: Tue, 8 Oct 2024 10:29:02 -0700
Message-ID: <20241008172906.1326-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep of per-net RTNL conversion for RTM_(NEW|DEL|SET)ADDR.

Currently, each IPv4 address is linked to the global hash table, and
this needs to be protected by another global lock or namespacified to
support per-net RTNL.

Adding a global lock will cause deadlock in the rtnetlink path and GC,

  rtnetlink                      check_lifetime
  |- rtnl_net_lock(net)          |- acquire the global lock
  |- acquire the global lock     |- check ifa's netns
  `- put ifa into hash table     `- rtnl_net_lock(net)

so we need to namespacify the hash table.

The IPv6 one is already namespacified, let's follow that.


Changes:
  v3:
    * Patch 4
      * Drop change in inet_addr_hash()

  v2: https://lore.kernel.org/netdev/20241004195958.64396-1-kuniyu@amazon.com/
    * Drop patch 5
    * Patch 4
      * Fix sparse warning (__force u32)

  v1: https://lore.kernel.org/netdev/20241001024837.96425-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  ipv4: Link IPv4 address to per-netns hash table.
  ipv4: Use per-netns hash table in inet_lookup_ifaddr_rcu().
  ipv4: Namespacify IPv4 address GC.
  ipv4: Retire global IPv4 hash table inet_addr_lst.

 include/linux/inetdevice.h |  2 +-
 include/net/netns/ipv4.h   |  2 ++
 net/ipv4/devinet.c         | 69 +++++++++++++++++++++-----------------
 3 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.30.2


