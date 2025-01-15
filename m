Return-Path: <netdev+bounces-158400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC9A11B7C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6A3A27D6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545622FDE9;
	Wed, 15 Jan 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LRH2irst"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93322FAE2
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928391; cv=none; b=jl6o0zQGWTYNhfB3PhCuGIY4/9a99LoJxhkwUZ4sLrv1ypbVioPQSJ0rcZLj9MQDfx5vJ+70jOM2cVsNTKJJcwucVxKArt9sepgm6t88NmRUudnszA2UX0Pa8DrqM+rpicPYz8y9gYN0HVqdWKoT+F7vTANd8tdmNaZ9Ugr1dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928391; c=relaxed/simple;
	bh=FbhxDEm8WgFGMAVFxZzxhZcCh0W2YJNkHx5dVARADzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXGtuzbEHPw7ODomLYh6DRRS673wsniOvlhK790/xDdJEPE72Z28wY0QR+j2wC+mmbhb50KbywsWPWGPQ65sTvvQrUyOxKfbU+1hKzt6Bmkb9egclwRDpSSuLdzHUj5mMOAxetLJPeiONVGTwMS7udQwb7yQLLkF2SXle8G0T7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LRH2irst; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928389; x=1768464389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m0IyJzgi+arrvdG33O5F9njObwBFx1vUwkCSu0qr0+I=;
  b=LRH2irstczRqUq1BGDCVce+oYFL44mq2AweULCyt9Nw8BB64oNY07bOP
   pZliCa+VeaK1IFIGKH34Z4C0j+aSHKAA5OHZP19tU+Ry3aGM5i+tbuVbo
   kxt/xd6RH5Imeezps4RJ12gmzyqh6fasAsqrx0hb3NInb2L504kdST5h0
   s=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="454337336"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:06:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:28672]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.5:2525] with esmtp (Farcaster)
 id 6b67056c-4e08-4396-99a1-9989ce3b45f0; Wed, 15 Jan 2025 08:06:24 +0000 (UTC)
X-Farcaster-Flow-ID: 6b67056c-4e08-4396-99a1-9989ce3b45f0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:06:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:06:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/11] ipv6: Convert RTM_{NEW,DEL}ADDR and more to per-netns RTNL.
Date: Wed, 15 Jan 2025 17:05:57 +0900
Message-ID: <20250115080608.28127-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series converts RTM_NEWADDR/RTM_DELADDR and some more
RTNL users in addrconf.c to per-netns RTNL.


Changes:
  v2:
    * Reorder patch 7 and 8
    * Move ifa_flags setup before IFA_CACHEINFO in patch 8

  v1: https://lore.kernel.org/netdev/20250114080516.46155-1-kuniyu@amazon.com/


Kuniyuki Iwashima (11):
  ipv6: Add __in6_dev_get_rtnl_net().
  ipv6: Convert net.ipv6.conf.${DEV}.XXX sysctl to per-netns RTNL.
  ipv6: Hold rtnl_net_lock() in addrconf_verify_work().
  ipv6: Hold rtnl_net_lock() in addrconf_dad_work().
  ipv6: Hold rtnl_net_lock() in addrconf_init() and addrconf_cleanup().
  ipv6: Convert inet6_ioctl() to per-netns RTNL.
  ipv6: Pass dev to inet6_addr_add().
  ipv6: Set cfg.ifa_flags before device lookup in inet6_rtm_newaddr().
  ipv6: Move lifetime validation to inet6_rtm_newaddr().
  ipv6: Convert inet6_rtm_newaddr() to per-netns RTNL.
  ipv6: Convert inet6_rtm_deladdr() to per-netns RTNL.

 include/net/addrconf.h |   5 +
 net/ipv6/addrconf.c    | 253 ++++++++++++++++++++---------------------
 2 files changed, 128 insertions(+), 130 deletions(-)

-- 
2.39.5 (Apple Git-154)


