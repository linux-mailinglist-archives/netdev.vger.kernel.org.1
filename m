Return-Path: <netdev+bounces-136782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40989A31F9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697D91F22536
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361623BBC5;
	Fri, 18 Oct 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iFtYaV/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250628399
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214559; cv=none; b=CbLJZ2BZOKAvN6mfgcdMIW3Bh48/GwR1vWf6Z7lyaHc9Gmo5P+o+l/BFiR4FSMc+VbUAkhXAF+PdHcZ+C8HvurUGfsI6HeSpbKcLXYlM3DINRY9sgKUnRybVCcX9zJGeLijOhRL0mULMZqcaWWxxNo0hQeoAT4vJCcjOokElJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214559; c=relaxed/simple;
	bh=o09tcE+gtCEgzrHq9041SDMO6k493ggFw8gYzpwoN9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8BYY+IgUVtew0lE0ZovZYVxR44BK0QqCz3TAk5HwrKr0abYie78yctpDjcgcu8rAnzw0oE6drxG6y24UZsK3aaAW4ycNZmEjNNH56BozR2sn7vl7Kn8GPj7PJsmEpZ48XqbxsmLS2jc3A/pL3BazUggwsldaIbA2lky1zITGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iFtYaV/1; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214557; x=1760750557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N044h5pGJKSJD20vTqfqggVHCSxlGtODQRDgGmqMo0Q=;
  b=iFtYaV/1Z813wTR7H8FVjM+P9doK//TMo+qp++UFJWx+JPG7EfO6g8HB
   4menb8i0rggihPZTFxsLj8WLp9oXWL0iYq2mFOPo/YF6GZA9plx4nRRSN
   pPHhgHSpnlsxPpSq9fFZdYYCGJ8gat49qRBKIANFjMgFsqvq8zbyEjXeP
   c=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="240275702"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:22:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:60072]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 7494e4f6-605d-459c-893c-333bcbef0b22; Fri, 18 Oct 2024 01:22:34 +0000 (UTC)
X-Farcaster-Flow-ID: 7494e4f6-605d-459c-893c-333bcbef0b22
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:22:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:22:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/11] ipv4: Convert RTM_{NEW,DEL}ADDR and more to per-netns RTNL.
Date: Thu, 17 Oct 2024 18:22:14 -0700
Message-ID: <20241018012225.90409-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The IPv4 address hash table and GC are already namespacified.

This series converts RTM_NEWADDR/RTM_DELADDR and some more
RTNL users to per-netns RTNL.


Kuniyuki Iwashima (11):
  rtnetlink: Define RTNL_FLAG_DOIT_PERNET for per-netns RTNL doit().
  ipv4: Factorise RTM_NEWADDR validation to inet_validate_rtm().
  ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
  ipv4: Convert RTM_NEWADDR to per-netns RTNL.
  ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
  ipv4: Convert RTM_DELADDR to per-netns RTNL.
  ipv4: Convert check_lifetime() to per-netns RTNL.
  rtnetlink: Define rtnl_net_lock().
  ipv4: Convert devinet_sysctl_forward() to per-netns RTNL.
  ipv4: Convert devinet_ioctl() to per-netns RTNL except for
    SIOCSIFFLAGS.
  ipv4: Convert devinet_ioctl to per-netns RTNL.

 include/linux/inetdevice.h |   9 ++
 include/linux/rtnetlink.h  |   6 ++
 include/net/rtnetlink.h    |   1 +
 net/core/dev_ioctl.c       |   6 +-
 net/core/rtnetlink.c       |  11 +++
 net/ipv4/devinet.c         | 190 +++++++++++++++++++++----------------
 6 files changed, 138 insertions(+), 85 deletions(-)

-- 
2.39.5 (Apple Git-154)


