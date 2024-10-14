Return-Path: <netdev+bounces-135298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787699D80E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA85281FA3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FD155301;
	Mon, 14 Oct 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nqOHHMTz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7314AD22
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937122; cv=none; b=GsP/rTWEyHZqeHJTZWRR0oABFAP/TXkt4CVtxCAlGXwk7A8G6fAjYj+OGB1iAMnq42ZdjPU75DHSNuqjTxfPXUsEXV0QXU6QN6rRN+KQlJ4LjHXVHyiUaiHGhFAvfwYHGPpiiYrwKoGYzZWerx2fxMZs6s2QKWFRfXVsbm2gy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937122; c=relaxed/simple;
	bh=1evAZFoR0px/x26U0XMv9DI6EYy9OkozvPC3vMptaQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MaJsorJM5bhgjwgFO+BaGreTVmrCa/OZwgYOlsRGW9y1UJjclekX1wNT/fCyHjTyhYjhJcXO80A3b+EeLNwGznbfel+Y94KFZG/0tauTct3W92E9tWrTjPv+7JVrKDWCrWxb4RKANSpl+d/p8Qftr5PdOP5HTY4K9jvppKPVqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nqOHHMTz; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937120; x=1760473120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=04ntst3T9Tb/t7Q9NeFqu4gBS8AQJxv0C06nDiV74Vc=;
  b=nqOHHMTzlLnL77z7qagTH2GqN5SnAgMaUFRq/l0lrdx2AY/Qav0zCfdl
   Hk6Vf9DUBtzi+w9AVogT0xhoYpawvl3r6NBgH+JnodzikVtGhKewS3iF9
   4sztBZnDbvtbGac62zDLJGq40Z6LTSddGwAIsnasTPqoT7ZGy9X8xOi8I
   0=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="138008328"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:18:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:43714]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id e77cce75-6b33-451a-86b3-45cbc3bed71b; Mon, 14 Oct 2024 20:18:37 +0000 (UTC)
X-Farcaster-Flow-ID: e77cce75-6b33-451a-86b3-45cbc3bed71b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:18:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:18:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/11] rtnetlink: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:17 -0700
Message-ID: <20241014201828.91221-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series converts all rtnl_register() and rtnl_register_module()
to rtnl_register_many() and finally removes them.

Once this series is applied, I'll start converting doit() to per-netns
RTNL.


Changes:
  v2:
    * Add __initconst and __initconst_module
    * Use C99 initialisation

  v1: https://lore.kernel.org/netdev/20241011220550.46040-1-kuniyu@amazon.com/


Kuniyuki Iwashima (11):
  rtnetlink: Panic when __rtnl_register_many() fails for builtin
    callers.
  rtnetlink: Use rtnl_register_many().
  neighbour: Use rtnl_register_many().
  net: sched: Use rtnl_register_many().
  net: Use rtnl_register_many().
  ipv4: Use rtnl_register_many().
  ipv6: Use rtnl_register_many().
  ipmr: Use rtnl_register_many().
  dcb: Use rtnl_register_many().
  can: gw: Use rtnl_register_many().
  rtnetlink: Remove rtnl_register() and rtnl_register_module().

 include/net/rtnetlink.h  |  15 +++--
 net/can/gw.c             |  29 ++++----
 net/core/fib_rules.c     |  17 +++--
 net/core/neighbour.c     |  19 +++---
 net/core/net_namespace.c |  14 ++--
 net/core/rtnetlink.c     | 141 ++++++++++++++++-----------------------
 net/dcb/dcbnl.c          |   8 ++-
 net/ipv4/devinet.c       |  18 +++--
 net/ipv4/fib_frontend.c  |  14 ++--
 net/ipv4/ipmr.c          |  22 +++---
 net/ipv4/nexthop.c       |  31 +++++----
 net/ipv4/route.c         |   8 ++-
 net/ipv6/addrconf.c      |  57 +++++++---------
 net/ipv6/addrlabel.c     |  28 +++-----
 net/ipv6/ip6_fib.c       |  10 ++-
 net/ipv6/ip6mr.c         |  13 ++--
 net/ipv6/route.c         |  23 +++----
 net/sched/act_api.c      |  13 ++--
 net/sched/cls_api.c      |  25 ++++---
 net/sched/sch_api.c      |  20 +++---
 20 files changed, 267 insertions(+), 258 deletions(-)

-- 
2.39.5 (Apple Git-154)


