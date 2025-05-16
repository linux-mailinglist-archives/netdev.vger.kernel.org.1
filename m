Return-Path: <netdev+bounces-190916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C711CAB9406
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EB7501A9F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8C221F0F;
	Fri, 16 May 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kWgzqD5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C93226D0D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362494; cv=none; b=jHcv/bTaeu6KMQ6MSKvVVGL8764a7r9zXqr7a7ExMWMuDd2s+fiFsUbCASlFBSbhX0i+FJk2q8ydTHxqttv8XYon+ZNAU+KBzAaZbfjrE/F3tMBhaT021ufgflGAolOJ1P5nHo/f1cCjgY6f4UkIhqtdklsJul8IQ5Px0MCg8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362494; c=relaxed/simple;
	bh=t0hvsGfSHzOoWCLlEqkSVHFVccGrW99wUJ47rJHjjoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQFJcnb7emr4GrJPv8RjUkexYmhujudt+VlxsnDGydb8W7Xz2mi/sRRly4NUtiCJvOzGB7SF4ZfaKiHpXFwXhfrtP96fbQdHd4DCYiZZgORO2IIFcxfuaSc+JVQ2mwdJPSkO4MigtZR57rV698QTQq4NRou0psneplo3X6Q2J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kWgzqD5Y; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747362492; x=1778898492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CepHjUUj3nUVgLSAtbtLFXdvNDrsp7O8hm6wXoOy3s8=;
  b=kWgzqD5Yiyy7SaZoZlT9kXhjnG3TZb07swr6JeOmPQIOHesbeOOZat/0
   Zx8kjitFsyB0KlvcDsVGT1Imwlrz+2Pe4p9zaBnysLuYbSbeobunR7kEX
   WmpH6zfVEQMam9hUgpIcgjpqWCe2BTc6JrVQc5gP1+ULIXOtR9OP7fyoQ
   DQw0halanMFvSGM/hhuN8Nd+WkQ7fRFyWkoo7du04WCaNbjeKo8QMg45D
   sPZ6kNg9syj1NmFyl5NFuSsU4KHssYRd7Fsj1qgDEplBQpI8sbjPBCNOF
   Eq9Tk64eJKJ9AdUJowUOUtV2RKQ4tz9Ig5xwIoe2iRf1OSGyV3VoSAAXw
   A==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="197382240"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:28:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:32561]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 909b69a4-2514-4402-bbfe-f8925b12d492; Fri, 16 May 2025 02:28:11 +0000 (UTC)
X-Farcaster-Flow-ID: 909b69a4-2514-4402-bbfe-f8925b12d492
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:28:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:28:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/7] ipv6: Follow up for RTNL-free RTM_NEWROUTE series.
Date: Thu, 15 May 2025 19:27:16 -0700
Message-ID: <20250516022759.44392-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 removes rcu_read_lock() in fib6_get_table().
Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
 was short-term fix and is no longer used.
Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.


Changes:
  v2:
    * Patch 3
      * Call rt6_multipath_rebalance() under RCU

  v1: https://lore.kernel.org/netdev/20250514201943.74456-1-kuniyu@amazon.com/


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
 net/ipv6/ip6_fib.c       |  31 +++--
 net/ipv6/route.c         | 269 ++++++++++++++-------------------------
 net/ipv6/seg6_local.c    |   6 +-
 8 files changed, 131 insertions(+), 220 deletions(-)

-- 
2.49.0


