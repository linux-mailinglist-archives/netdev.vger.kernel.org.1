Return-Path: <netdev+bounces-133950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A99978FC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24025B22160
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45B18E348;
	Wed,  9 Oct 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fD9LflgD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68E1885BE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515829; cv=none; b=AZ1SVHAsqv4Euskj8bt81CaZJka3sGdzBarzA+6ma2uzIAoVX4B8C9XBjzoR18y962uBp81gBRr+H0Il4+x2w2Hqenn49BiUHWWMQZVtBIvUs2Qy2RTiTzgk5Qp1QYyDIyrFReapjgXuofL/xL2B1lHbwN7jazw8bQnyR20qg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515829; c=relaxed/simple;
	bh=7ROBpVyC5MGXISD10PZotpFpiZ8WmAZkEGCFCV8QNhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXhKxJ0L4UUFLzY3Hcl7P0Vo4zhchH7qyzy179ofMjKE0LHkkxTQAVM1szNG8R5gWDkuUVGsnPWBRpsCaH/xjYKfBgIhqHOhLu/VMZvVAAyN3o4o5KidO7t0XrYQeaEeohYhJWXU5Zbx/VJAXy4Llh9WLeR5aSfzc1HhRwCA75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fD9LflgD; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515827; x=1760051827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wiEsbY5l9e0o6XrG8w+/SfftEgiS1Na8YrAsfTHoAEc=;
  b=fD9LflgD+ajSSbc581nucA5ASyt20BW+vxpg+Cl5J6XRGH9fwJHn6Pz0
   2NjiQWvLKVNkN6SDIEI9iYa9t0cPV5t3tIZ2TfiVdf3yOAv0YNRMO2ShK
   43UxgiW8SYjpfria7krzu7RpJTU6WHn30tTR9PW1tkoIYX3TEqTshM2w2
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="686428985"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:17:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:55371]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 2868d795-306a-4573-90b5-187cc3ec0633; Wed, 9 Oct 2024 23:17:03 +0000 (UTC)
X-Farcaster-Flow-ID: 2868d795-306a-4573-90b5-187cc3ec0633
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:17:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:17:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/13] rtnetlink: Refactor rtnl_{new,del,set}link() for per-netns RTNL.
Date: Wed, 9 Oct 2024 16:16:43 -0700
Message-ID: <20241009231656.57830-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep for the next series where we will push RTNL down to
rtnl_{new,del,set}link().

That means, for example, __rtnl_newlink() is always under RTNL, but
rtnl_newlink() has a non-RTNL section.

As a prerequisite for per-netns RTNL, we will move netns validation
(and RTNL-independent validations if possible) to that section.

rtnl_link_ops and rtnl_af_ops will be protected with SRCU not to
depend on RTNL.


Kuniyuki Iwashima (13):
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
  rtnetlink: Protect struct rtnl_af_ops with SRCU.

 include/net/rtnetlink.h |  10 +-
 net/core/rtnetlink.c    | 552 ++++++++++++++++++++++------------------
 2 files changed, 310 insertions(+), 252 deletions(-)

-- 
2.39.5 (Apple Git-154)


