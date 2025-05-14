Return-Path: <netdev+bounces-190531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74CAAB76F0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577A67A8826
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BDD298C2F;
	Wed, 14 May 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="thKQ5ZlJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CB297103
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254001; cv=none; b=IA2ub0ge2nlhC9EfzKOwupwXOzEIvPUGHlkWD4lrTr3uYtJap3PonhyvsqMSSQRoLt8CUnN4k2hUQ73XNNsybh3LsY3S8op5kBvxy9RrO9tpWAeM1hSO2b0PvwBK26qnVcgB9UE6btGPcGCE0eWkZUDBxG1FWHnqkN8+4v11DkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254001; c=relaxed/simple;
	bh=7BSNfVGwVIV4HSW24sU5c7Jy9PO/H7gM/t7wbEFJ4mA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jU5fej16MQz8YnC8N7WZUPP/In44SMkw+HNQm/I8DRdysTK6+l2o0swxtVI3Q55k3zKBBlZnJ+j/btPlLEO1vcNigDjwnAAeNZ2AmC7rTikDaZRcVNyNJvpRh2Qsps/JuGRU1A6ZKv+VmL/JJd1PHK1QKNpOohicBRwrF9Ea7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=thKQ5ZlJ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254000; x=1778790000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SQgfKc7wqAhaQvvIhxbHu1UhLW4DMDTNlHfal5y7dqg=;
  b=thKQ5ZlJ7gmSj7VdTMWahKgFJeJIbNPLGcYk03BmfMSEp8Bc/02K9lIz
   Q5illPWOdgQgyD1LZG/iCceu18d7puQGtZ8Fs2P8Ed2Sck0ovqKuDAb36
   z5oDi+O/AgD8C9SThHgZrmmfp6CxDMGDCQMN6/X70rsUN0aLDcuL1X20L
   7Mx2dekuHHfJjF3yQCk9PGh6BhXDt0uZMI6XzCw3iQ00VvzaGFD/q8wUR
   nU+fq8owmQ5zIZU5onA9sb51okPmn1dLFhKwXim8tm78A0hPDZuxguCL1
   LcPvtx8uhbKNHqYN1jcx3gwo0A8QxHIhHxJKWdUgrD9BtOxe1JWXuzvP5
   w==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="722847268"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:19:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:50986]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.62:2525] with esmtp (Farcaster)
 id 4eb378ab-923f-480e-ab45-3162918f67a3; Wed, 14 May 2025 20:19:55 +0000 (UTC)
X-Farcaster-Flow-ID: 4eb378ab-923f-480e-ab45-3162918f67a3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:19:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:19:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/7] ipv6: Follow up for RTNL-free RTM_NEWROUTE series.
Date: Wed, 14 May 2025 13:18:53 -0700
Message-ID: <20250514201943.74456-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 removes rcu_read_lock() in fib6_get_table().
Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
 was short-term fix and is no longer used.
Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.


Kuniyuki Iwashima (7):
  ipv6: Remove rcu_read_lock() in fib6_get_table().
  inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
  ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
  Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during
    seg6local LWT setup"
  Revert "ipv6: Factorise ip6_route_multipath_add()."
  ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
  ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.

 include/net/lwtunnel.h   |  13 +-
 net/core/lwtunnel.c      |  15 +--
 net/ipv4/fib_frontend.c  |   4 +-
 net/ipv4/fib_semantics.c |  10 +-
 net/ipv4/nexthop.c       |   3 +-
 net/ipv6/ip6_fib.c       |  27 ++--
 net/ipv6/route.c         | 269 ++++++++++++++-------------------------
 net/ipv6/seg6_local.c    |   6 +-
 8 files changed, 127 insertions(+), 220 deletions(-)

-- 
2.49.0


