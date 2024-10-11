Return-Path: <netdev+bounces-134704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69CD99AE78
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228261C21D35
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BF1D174F;
	Fri, 11 Oct 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qNY9EH3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219B7F9
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684363; cv=none; b=Nv3Tfm55xF/DLiHYi/ZGOqhDpkgy/bEQLu8Tw3LrMW32QqgohvFuJt/MEz7zlvkEgGUhJe0AbwPolP7qGlqZeCGWiWbja2735pDaLUoaF7gMfEg/uWfdqhPKBCX80dM5rFY4/etwurVS3avfW9WTSra+gQeGDxtrVKQrfSNSQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684363; c=relaxed/simple;
	bh=8X4RLywbrH4DW4JHhECHz0WNDOYF+t0ki/eWMrFuMOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B0ng2izcc46z3hnTXwUd4eqUxJPqycCHu31VZVsdWPvqI4MmHm3zTLOmgkyVU6hlodtJXWjPox9USyzpIU3r42LqBAFlMbU4KELQXK1Xqvs3uMinwRyT2PbgUaBPRIvcvKiIgesATuNLf2kM4qe2agIH6ctoHfJbKi6DrwV/jQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qNY9EH3v; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684362; x=1760220362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U8NibbuwsOAYpP/wbseyMkMnAATMttUw8oNp0YPMjmg=;
  b=qNY9EH3vHmKWzNI2UX4lC6nqSjFq0fMlTrGCIZj3iCjqG44k/cjUJO2S
   LyMjWkQ44Tr4QXTwnr74uGDrUqyuWfHDS2AHCGSKKPp6iGQO+x231eMrs
   WoZbv1xHbl2DRcJ7aZVGhJ3HCOeqcK8CxCvn6yfju1xIv4/tBzVEUX4fB
   k=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="434489027"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:05:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:2962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 22cae159-bf2c-4bf0-8fd9-a3e4b908d723; Fri, 11 Oct 2024 22:05:57 +0000 (UTC)
X-Farcaster-Flow-ID: 22cae159-bf2c-4bf0-8fd9-a3e4b908d723
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:05:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:05:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/11] rtnetlink: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:39 -0700
Message-ID: <20241011220550.46040-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series converts all rtnl_register() and rtnl_register_module()
to rtnl_register_many() and finally removes them.

Once this series is applied, I'll start converting doit() to per-netns
RTNL.


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
 net/can/gw.c             |  26 +++-----
 net/core/fib_rules.c     |  24 ++++---
 net/core/neighbour.c     |  19 +++---
 net/core/net_namespace.c |  13 ++--
 net/core/rtnetlink.c     | 135 +++++++++++++++------------------------
 net/dcb/dcbnl.c          |   8 ++-
 net/ipv4/devinet.c       |  18 ++++--
 net/ipv4/fib_frontend.c  |  12 ++--
 net/ipv4/ipmr.c          |  19 +++---
 net/ipv4/nexthop.c       |  26 ++++----
 net/ipv4/route.c         |   8 ++-
 net/ipv6/addrconf.c      |  52 ++++++---------
 net/ipv6/addrlabel.c     |  27 +++-----
 net/ipv6/ip6_fib.c       |   9 ++-
 net/ipv6/ip6mr.c         |  12 ++--
 net/ipv6/route.c         |  21 +++---
 net/sched/act_api.c      |  12 ++--
 net/sched/cls_api.c      |  24 +++----
 net/sched/sch_api.c      |  18 +++---
 20 files changed, 238 insertions(+), 260 deletions(-)

-- 
2.39.5 (Apple Git-154)


