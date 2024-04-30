Return-Path: <netdev+bounces-92293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF1B8B67BD
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEC21F22B96
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB45C96;
	Tue, 30 Apr 2024 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bmwUWNdv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1853A7
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442311; cv=none; b=DVMh1tBBVMg08f4LthfWRKWKT+3IhORPkg/hx1nuchA0/DYLoD/tqY6SMkGcwrdC+GzCa/sADvB9/pBWu4PbZPSnAUju/AYwy4U5+DEroyKh3XB9M82PmgWJT4LIAEhduKpb8yk87Wwk7WaA07H3vLO219CUrKbFT3YbVfR0SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442311; c=relaxed/simple;
	bh=ZKH9Axkb37UTxQ5wzd7xwsaoKElZA/sn8w9YiGBRvzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjQnEU2bXw92TK6sp9S9wZc0qqc3zvp5a12iuvDOEZiots4EldGGzEU+HoYYPrMtyst3KQksavu2SD7VM7U+a2/qBUHKYtYdOZxTHg0SucrjPhq+rHAg04LaphXl759Fy+hNs1pNoRBX8rxwnfUT4HCsBSJWuflS39ij9AD8pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bmwUWNdv; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442310; x=1745978310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H9tE6y/XyzeOjVrKhWDZRtq8cbmPt4wykpB3gQnXKBA=;
  b=bmwUWNdvjFp5ne1wj8aNfiZoaOQtQEPjZGEc+7p7US+OrvFkDhJ/Jl8Y
   gzk5ZmqcWJMnnsje/kjxpDTkyH1fwOTW/2kG9b4i+p6BNT/r/7ZU9IcU7
   wezfWTQeEgtfaWBna7hMTlqNH9kSCMazVW1MOaRyBscLJHF+c+idNOgcB
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="403646777"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:58:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:43666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.46:2525] with esmtp (Farcaster)
 id fb71ba4b-adda-4e96-8ee6-4d8b1791a117; Tue, 30 Apr 2024 01:58:25 +0000 (UTC)
X-Farcaster-Flow-ID: fb71ba4b-adda-4e96-8ee6-4d8b1791a117
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:58:25 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:58:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/7] arp: Random clean up and RCU conversion for ioctl(SIOCGARP).
Date: Mon, 29 Apr 2024 18:58:06 -0700
Message-ID: <20240430015813.71143-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

arp_ioctl() holds rtnl_lock() regardless of cmd (SIOCDARP, SIOCSARP,
and SIOCGARP) to get net_device by __dev_get_by_name() and copy
dev->name safely.

In the SIOCGARP path, arp_req_get() calls neigh_lookup(), which looks
up a neighbour entry under RCU.

This series cleans up ioctl() code a bit and extends the RCU section
not to take rtnl_lock() and instead use dev_get_by_name_rcu() and
netdev_copy_name() for SIOCGARP.


Changes:
  v3:
    Add Patch 6 to read dev->name safely under seqlock.

  v2: https://lore.kernel.org/netdev/20240425170002.68160-1-kuniyu@amazon.com/
    Patch 5: s/!IS_ERR/IS_ERR/ in arp_req_delete().

  v1: https://lore.kernel.org/netdev/20240422194755.4221-1-kuniyu@amazon.com/


Kuniyuki Iwashima (7):
  arp: Move ATF_COM setting in arp_req_set().
  arp: Validate netmask earlier for SIOCDARP and SIOCSARP in
    arp_ioctl().
  arp: Factorise ip_route_output() call in arp_req_set() and
    arp_req_delete().
  arp: Remove a nest in arp_req_get().
  arp: Get dev after calling arp_req_(delete|set|get)().
  net: Protect dev->name by seqlock.
  arp: Convert ioctl(SIOCGARP) to RCU.

 include/linux/netdevice.h |   1 +
 net/core/dev.c            |  27 ++++-
 net/ipv4/arp.c            | 203 +++++++++++++++++++++++---------------
 3 files changed, 147 insertions(+), 84 deletions(-)

-- 
2.30.2


