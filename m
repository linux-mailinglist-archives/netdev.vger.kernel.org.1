Return-Path: <netdev+bounces-158008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92134A101AB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D9F3A501E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF75246331;
	Tue, 14 Jan 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SNHVSqOJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7523D3E9
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841938; cv=none; b=nkm1T9bkkjbx9++YPw1u+mS9ct8qifP9/+2j4LHXGXh4u6LSnYCT5s321nN4tMfkuxQEBbVWWqKnWUn19gblU1g2gOfw7U3TCpVk3weXvaxVkTYANM5PcwUcglEFz3BMc+AtBWsi1Zv7jK9s/vSFenA2VVb+hUx11VGNUafx4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841938; c=relaxed/simple;
	bh=+GOjjH1V8TdbDjTPsSPw6uFx98jKct8T04th99D/PCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hU/Z3+8xxSTC/Ocj5wf31rAdtrD4nRaaaLEUVkOLjyU50cFGlWWhQjgchNa1QowISm5wQCzZWGwLn78L2Yu3HfrvXjXHFuV2Q9LHBj6t27GyFKKdmvjXysIVuqWCkdkz1L7Ar31M+aIhdwPRYM0zByHRAGMnq/RqhRBYgFqFnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SNHVSqOJ; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736841937; x=1768377937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/FtpEO0g2IxC/t3NUer5Jh05WwiJRFNYyGpIJ301yCU=;
  b=SNHVSqOJ66af2RN/MzBiZzfZqBj+BCdYoUo/8IZ50YTzOE95fHevrcrT
   ol5fRu4yKxTY4UGE+8rBLuuBPkREHVzVx8FmidZZ5NDQrm0d8n4A0IRgy
   69+0hQ3yzUt8gf1zpF/6vS4s12A1Yopp9lX+GTv414BQ+ZpWoWLug2ncj
   4=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="463923969"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:05:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:60084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525] with esmtp (Farcaster)
 id 2c833be8-a3ee-46d9-ba90-b786f10b0e45; Tue, 14 Jan 2025 08:05:32 +0000 (UTC)
X-Farcaster-Flow-ID: 2c833be8-a3ee-46d9-ba90-b786f10b0e45
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:05:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:05:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/11] ipv6: Convert RTM_{NEW,DEL}ADDR and more to per-netns RTNL.
Date: Tue, 14 Jan 2025 17:05:05 +0900
Message-ID: <20250114080516.46155-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series converts RTM_NEWADDR/RTM_DELADDR and some more
RTNL users in addrconf.c to per-netns RTNL.


Kuniyuki Iwashima (11):
  ipv6: Add __in6_dev_get_rtnl_net().
  ipv6: Convert net.ipv6.conf.${DEV}.XXX sysctl to per-netns RTNL.
  ipv6: Hold rtnl_net_lock() in addrconf_verify_work().
  ipv6: Hold rtnl_net_lock() in addrconf_dad_work().
  ipv6: Hold rtnl_net_lock() in addrconf_init() and addrconf_cleanup().
  ipv6: Convert inet6_ioctl() to per-netns RTNL.
  ipv6: Set cfg.ifa_flags before device lookup in inet6_rtm_newaddr().
  ipv6: Pass dev to inet6_addr_add().
  ipv6: Move lifetime validation to inet6_rtm_newaddr().
  ipv6: Convert inet6_rtm_newaddr() to per-netns RTNL.
  ipv6: Convert inet6_rtm_deladdr() to per-netns RTNL.

 include/net/addrconf.h |   5 +
 net/ipv6/addrconf.c    | 247 ++++++++++++++++++++---------------------
 2 files changed, 125 insertions(+), 127 deletions(-)

-- 
2.39.5 (Apple Git-154)


