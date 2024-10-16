Return-Path: <netdev+bounces-136255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A19A120B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6691F22B41
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D92139C9;
	Wed, 16 Oct 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hzvG9Gox"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB8212EF5
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104859; cv=none; b=sjGjB29mUNCngbvH+Waqi9ADx8n/jNIjGAalc0WF/5ZjYxT0RUGrAg0eaGapE0lmnYpSku0J0ZyVKJVyvBYN+Lr+W90IV/wOMzGws9fTnDbJCc6b3pVGp75+5jUJKpHfYt71rug/U7aK3hAw3DoegPnJNjh4eNJdcto9XfLhj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104859; c=relaxed/simple;
	bh=CdzHBfZKBXjb8uk5BW4S5tntaB8Xbng6jedjQ/To4Ac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHp08qruZ8MyxfjUxK2ou+I7bRDAjJAHZG+aPAK/oMxxSHJzlydyzg8ENk1AvjGv0GvxBKkfvMWlXoD8kVopoWFZI9drWLxB5cS0qenGQQ8enWZqzuUZZGu3U7Lubn9DJgDuwAJT0t2wFq14ATeh+54twZbxfYeG6DCkP+3yB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hzvG9Gox; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104858; x=1760640858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S1gqLIxQS9lZ1eCaWIK9c/vwyzG1g+H/YM9ejPhG4fU=;
  b=hzvG9Goxaq2h4o8XXfdDlhIfbvlRtrsaQnoW6z8LTbvIM4otM//GTl7/
   tm87Jy+qHRSbfyxKkmGofd3rgNS9VZ15eNx1mTOlkHIsr6+RAmAuu0jHr
   4soiv8QjTLUrMtA9BwLepq+tlsP4oPZhHTqSvvmu6sSFY6BdGwyoonIkb
   4=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="767178753"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:54:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:60084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 319949c8-36e3-4a0a-973b-c050c62d6130; Wed, 16 Oct 2024 18:54:11 +0000 (UTC)
X-Farcaster-Flow-ID: 319949c8-36e3-4a0a-973b-c050c62d6130
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:54:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:54:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/14] rtnetlink: Refactor rtnl_{new,del,set}link() for per-netns RTNL.
Date: Wed, 16 Oct 2024 11:53:43 -0700
Message-ID: <20241016185357.83849-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep for the next series where we will push RTNL down to
rtnl_{new,del,set}link().

That means, for example, __rtnl_newlink() is always under RTNL, but
rtnl_newlink() has a non-RTNL section.

As a prerequisite for per-netns RTNL, we will move netns validation
(and RTNL-independent validations if possible) to that section.

rtnl_link_ops and rtnl_af_ops will be protected with SRCU not to
depend on RTNL.


Changes:
  v2:
    * Add Eric's Reviewed-by to patch 1-4,6,8-11, (no tag on 5,7,12-14)
    * Patch 7
      * Handle error of init_srcu_struct().
      * Call cleanup_srcu_struct() after synchronize_srcu().
    * Patch 12
      * Move put_net() before errorout label
    * Patch 13
      * Newly added as prep for patch 14
    * Patch 14
      * Handle error of init_srcu_struct().
      * Call cleanup_srcu_struct() after synchronize_srcu().

  v1: https://lore.kernel.org/netdev/20241009231656.57830-1-kuniyu@amazon.com/


Kuniyuki Iwashima (14):
  rtnetlink: Allocate linkinfo[] as struct rtnl_newlink_tbs.
  rtnetlink: Call validate_linkmsg() in do_setlink().
  rtnetlink: Factorise do_setlink() path from __rtnl_newlink().
  rtnetlink: Move simple validation from __rtnl_newlink() to
    rtnl_newlink().
  rtnetlink: Move rtnl_link_ops_get() and retry to rtnl_newlink().
  rtnetlink: Move ops->validate to rtnl_newlink().
  rtnetlink: Protect struct rtnl_link_ops with SRCU.
  rtnetlink: Call rtnl_link_get_net_capable() in rtnl_newlink().
  rtnetlink: Fetch IFLA_LINK_NETNSID in rtnl_newlink().
  rtnetlink: Clean up rtnl_dellink().
  rtnetlink: Clean up rtnl_setlink().
  rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
  rtnetlink: Return int from rtnl_af_register().
  rtnetlink: Protect struct rtnl_af_ops with SRCU.

 include/net/rtnetlink.h |  12 +-
 net/bridge/br_netlink.c |   6 +-
 net/core/rtnetlink.c    | 567 ++++++++++++++++++++++------------------
 net/ipv4/devinet.c      |   3 +-
 net/ipv6/addrconf.c     |   5 +-
 net/mctp/device.c       |  16 +-
 net/mpls/af_mpls.c      |   5 +-
 7 files changed, 351 insertions(+), 263 deletions(-)

-- 
2.39.5 (Apple Git-154)


