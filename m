Return-Path: <netdev+bounces-132262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B0B991245
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561E51F23C71
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EA1AE009;
	Fri,  4 Oct 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rE+AGFMp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14F1AE01F
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080655; cv=none; b=HLgjnFXVgDLtRSS7z+Drt77csg8FNkgbcWh5U6JTtg5O/YJ9uEIuKZ6dIwGnXkJbeyROaL1xNxpaFx+NphgJ7CtTxPBxdTwqHzBh5G/JNjHgL+gzTXMF6D9W9N4wEYhp88n2kkDGA3EnTR5seFdI+PUHDikjf4uPRnT94c0nNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080655; c=relaxed/simple;
	bh=c9qlK7+aWmuQFaHf43pZswax6Kf5KZbrTc9SJRWLEY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OU1nThhtbjfIgiX8RDa0k33xG9C+qFTzvxXqbPlVfbn/IFy+kQx85yMeYPfh0Qn3Gxb1QkWdBv/eQMyNEMjHudnEq2Qxd9qFDBsZG7QvELeRtBTTQsrURJ4BZqqLgQZaWjTlKSkHsL8PeB5ZziK2+T8SBCoBn05mNIznFl2+rOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rE+AGFMp; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728080654; x=1759616654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bVqK+lP3xlqo6QBw0xIm4g+K/iBqeLdVWO2dowKWFTE=;
  b=rE+AGFMpATi24IoYecCAp5NT/lxS8wzcLLvKnB0zhMMG7JTCkwHKdihD
   5wHTElAXrDpThDOMf7xxeONEultMFePntJyVqpk7ZqYvMVJL5l28/oAm8
   XmZhB0ynE//KnBpLVzAI3cwbUeVKTT3DObPITADYDGX2ypHjgPOkM9m9U
   8=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="663830804"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:24:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:53949]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id df0b9da3-15a5-4069-b2be-7b8456af1a9c; Fri, 4 Oct 2024 22:24:11 +0000 (UTC)
X-Farcaster-Flow-ID: df0b9da3-15a5-4069-b2be-7b8456af1a9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:24:09 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:24:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/6] rtnetlink: Handle error of rtnl_register_module().
Date: Fri, 4 Oct 2024 15:23:52 -0700
Message-ID: <20241004222358.79129-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While converting phonet to per-netns RTNL, I found a weird comment

  /* Further rtnl_register_module() cannot fail */

that was true but no longer true after commit addf9b90de22 ("net:
rtnetlink: use rcu to free rtnl message handlers").

Many callers of rtnl_register_module() just ignore the returned
value but should handle them properly.

This series introduces two helpers, rtnl_register_module_many() and
rtnl_unregister_module_many(), to do that easily and fix such callers.

All rtnl_register() and rtnl_register_module() will be converted
to _many() variant and some rtnl_lock() will be saved in _many()
later in net-next.


Changes:
  v2: Remove __exit from mctp_neigh_exit().

  v1: https://lore.kernel.org/netdev/20241003205725.5612-1-kuniyu@amazon.com/


Kuniyuki Iwashima (6):
  rtnetlink: Add bulk registration helpers for rtnetlink message
    handlers.
  vxlan: Handle error of rtnl_register_module().
  bridge: Handle error of rtnl_register_module().
  mctp: Handle error of rtnl_register_module().
  mpls: Handle error of rtnl_register_module().
  phonet: Handle error of rtnl_register_module().

 drivers/net/vxlan/vxlan_core.c      |  6 ++++-
 drivers/net/vxlan/vxlan_private.h   |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c | 19 ++++++++--------
 include/net/mctp.h                  |  2 +-
 include/net/rtnetlink.h             | 19 ++++++++++++++++
 net/bridge/br_netlink.c             |  6 ++++-
 net/bridge/br_private.h             |  5 +++--
 net/bridge/br_vlan.c                | 19 ++++++++--------
 net/core/rtnetlink.c                | 30 +++++++++++++++++++++++++
 net/mctp/af_mctp.c                  |  6 ++++-
 net/mctp/device.c                   | 30 +++++++++++++++----------
 net/mctp/neigh.c                    | 31 ++++++++++++++++----------
 net/mctp/route.c                    | 34 ++++++++++++++++++++---------
 net/mpls/af_mpls.c                  | 32 +++++++++++++++++----------
 net/phonet/pn_netlink.c             | 27 +++++++++--------------
 15 files changed, 179 insertions(+), 89 deletions(-)

-- 
2.30.2


