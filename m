Return-Path: <netdev+bounces-132221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6F991022
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448ED1F274A9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D64136657;
	Fri,  4 Oct 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jk6+DOtG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99212F375
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072015; cv=none; b=MynZ8dRIY0p4oZUvWX+jwuyMHMvKSSPgExVhxzmWEn32sKvk/QUZlLPCYfxu73K4owzmLGhVVpqri7RkOoCOY4br4bB92A/lM3M90I17rG2xcS+QqLtQoftOVczkY4hj1hfKsTkwE0a7IjXLKPm8xhlEM0jaW6dTV7JJpm5Clt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072015; c=relaxed/simple;
	bh=BLxUCYovAo7s8dSg4iq6V81h/WDcO4t6Sv1jT8MOxBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EmOxLd4U8XUjwOlVSDooZCpdN7WYAAWkLctAgZztXFidae4xbpaJ8+ZWlgIBF4xdBCWoKWHeUthOOO44n5mBLAzGCYu0dioKZAT2EjdZarwKxwbSecdIFbmJUfDdctqyBAZLbMsoKAGyzl/oeUHE94Sa51rsWMC0/hOFJuvi+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Jk6+DOtG; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728072015; x=1759608015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rKwGH6OaOGNp1Fs7j6r8hzdbERPOoxGHzV1adktinnY=;
  b=Jk6+DOtG9qOP+Gc/mZHtY8Bl8S3me3sEGjSB9fv8NNVOyXrpQlWOHTDP
   ry1o4pJcdR/iEF6O/ilSVFvJz9/IIfBnK+ZOuJQyjSVJmJSog0pPFD9qS
   G6sEz1PzpUlQR3H3ym1DJ8SFg2jcfKgxfiDxmpl67teXfEmCiWUccBSyC
   0=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="685203689"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:00:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:52073]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id 3ba3fa86-71b5-4802-85cc-35a3b6d72db1; Fri, 4 Oct 2024 20:00:10 +0000 (UTC)
X-Farcaster-Flow-ID: 3ba3fa86-71b5-4802-85cc-35a3b6d72db1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:00:09 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:00:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/4] ipv4: Namespacify IPv4 address hash table.
Date: Fri, 4 Oct 2024 12:59:54 -0700
Message-ID: <20241004195958.64396-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
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
  v2:
    * Drop patch 5
    * Fix sparse warning in patch 4, (__force u32)

  v1: https://lore.kernel.org/netdev/20241001024837.96425-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  ipv4: Link IPv4 address to per-net hash table.
  ipv4: Use per-net hash table in inet_lookup_ifaddr_rcu().
  ipv4: Namespacify IPv4 address GC.
  ipv4: Retire global IPv4 hash table inet_addr_lst.

 include/linux/inetdevice.h |  2 +-
 include/net/netns/ipv4.h   |  2 ++
 net/ipv4/devinet.c         | 73 +++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 34 deletions(-)

-- 
2.30.2


