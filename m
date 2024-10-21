Return-Path: <netdev+bounces-137603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10859A7264
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C64C1C22ABB
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BED1F9428;
	Mon, 21 Oct 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XB+KDvAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69653A41
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535586; cv=none; b=a/LmuJPiBICG24g1JMJYvhzNLpgCsa6dCRpldEnTITMb80tUHc6y/RMxbZ42YbJszA/J40CZxm06H0nSEL09fjELQr9A+tZXXqTAbo6sk2oxSClhFdIZBwURDee+Ic5r+tnshyz9MgUQIK5ZfrUvUierqCiZYOQcJ10RdKfiCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535586; c=relaxed/simple;
	bh=a1xyOXu5df84wWVlaWmZ1lLTFVjmRH9oDVLRvJWVDOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pu7qdukpOOIHs/yxOaS2A/TEZDnDC74WqfO2tlqWcDl10G83HFl8vxAq9T39vZkcnQlrGPeEolFLEut1p0YjEiNW00AAV1LV1ev9xaxVE0CDpq6LwZsm3V+IuuxHRoTHphsZ5+vXbHAlN/WLJoL/SkkYR/35QEqMbFtXcXoTVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XB+KDvAT; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535584; x=1761071584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m3E5BP0XBDZnWoBqpKPV7REejm2AMpHJL8XpocIc/fs=;
  b=XB+KDvATg+84WvHYCXj0Ygwtc+xyWiySf6VaxshwrWF5B5umvuQH+v65
   0Dv9qzHJ30ezhU/h240ZoViaCNhuU7NZ/GseRL/TtI8+sonmKmaRzOvcu
   2EVg9hx15PL3cylt3RtnTuI9lOGSJAAWkavRcsiWjODFp98EKG03p7Xh1
   o=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="768996922"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:32:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:61152]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.189:2525] with esmtp (Farcaster)
 id a2593c8c-6c58-49d5-baf6-1242584f3ace; Mon, 21 Oct 2024 18:32:46 +0000 (UTC)
X-Farcaster-Flow-ID: a2593c8c-6c58-49d5-baf6-1242584f3ace
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:32:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:32:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/12] ipv4: Convert RTM_{NEW,DEL}ADDR and more to per-netns RTNL.
Date: Mon, 21 Oct 2024 11:32:27 -0700
Message-ID: <20241021183239.79741-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The IPv4 address hash table and GC are already namespacified.

This series converts RTM_NEWADDR/RTM_DELADDR and some more
RTNL users to per-netns RTNL.


Changes:
  v2:
    * Add patch 1 to address sparse warning for CONFIG_DEBUG_NET_SMALL_RTNL=n
    * Add Eric's tags to patch 2-12

  v1: https://lore.kernel.org/netdev/20241018012225.90409-1-kuniyu@amazon.com/


Kuniyuki Iwashima (12):
  rtnetlink: Make per-netns RTNL dereference helpers to macro.
  rtnetlink: Define RTNL_FLAG_DOIT_PERNET for per-netns RTNL doit().
  ipv4: Factorise RTM_NEWADDR validation to inet_validate_rtm().
  ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
  ipv4: Convert RTM_NEWADDR to per-netns RTNL.
  ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
  ipv4: Convert RTM_DELADDR to per-netns RTNL.
  ipv4: Convert check_lifetime() to per-netns RTNL.
  rtnetlink: Define rtnl_net_trylock().
  ipv4: Convert devinet_sysctl_forward() to per-netns RTNL.
  ipv4: Convert devinet_ioctl() to per-netns RTNL except for
    SIOCSIFFLAGS.
  ipv4: Convert devinet_ioctl to per-netns RTNL.

 include/linux/inetdevice.h |   9 ++
 include/linux/rtnetlink.h  |  25 +++--
 include/net/rtnetlink.h    |   1 +
 net/core/dev_ioctl.c       |   6 +-
 net/core/rtnetlink.c       |  11 +++
 net/ipv4/devinet.c         | 190 +++++++++++++++++++++----------------
 6 files changed, 143 insertions(+), 99 deletions(-)

-- 
2.39.5 (Apple Git-154)


