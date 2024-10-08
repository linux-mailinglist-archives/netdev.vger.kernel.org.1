Return-Path: <netdev+bounces-133278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68542995715
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FD11F27DE8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C23CF6A;
	Tue,  8 Oct 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gAUu1nOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237058F6D
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413274; cv=none; b=ezUJgUIho9KTaJ3cEDXbRIIc74hKEEkmo7REA7RZfuU9l0SEPdfjDt9+PU6JDoyfIxIKob4UeJAgYAApZsTwp9bYt0JH6ap1jQvVuySZGcphVjLiGYOGUZA4PurVxFJBPF4dy7Bd4Wamt3EPhmPfA1iJT679Qq86yOSjG0z4o8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413274; c=relaxed/simple;
	bh=tx4UsxxfKiLejNXQpM/JSHYhG/cJzu4aXqFEQqx5hb0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9LsO7XqXfn4/VW7dVn/eTgw8gx3/8iY4po/XH7ImfzqZ+aySYAFivU3NBV49hgNGaWD1cQo7qe4s4XZfjqxbSCEyfesw4oLgaB5SWOgJkJnTl223Ig1qw1ug91PDRPkunPDrA2V3eBmuw9O5cTeTGPhb7AOejBaUFx9u8+7aks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gAUu1nOO; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728413273; x=1759949273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RasTnKiWxrKEWrkFf6lVeQRpsPCpvyx9fIW2UNdHLMk=;
  b=gAUu1nOOV+l3VQm8QkAUkE/Ew2Y7vUhNjpjD30Yd+4MbkgXKmrRl4hsk
   rCaJjCfFzGDG3fJeQfVFIYHZ4I7hx9aYSOVrQP71D0PmgCBWdYTOdev0u
   BjZYVQCwN66oOAVrBoaSGlE0aESwZVTHZDL8ek93N7nB0U3AMM6jIbi50
   I=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="686053012"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:47:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:7405]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id df7dfd04-1723-414b-912a-0d824a8594c2; Tue, 8 Oct 2024 18:47:49 +0000 (UTC)
X-Farcaster-Flow-ID: df7dfd04-1723-414b-912a-0d824a8594c2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 18:47:48 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 18:47:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net 0/6] rtnetlink: Handle error of rtnl_register_module().
Date: Tue, 8 Oct 2024 11:47:31 -0700
Message-ID: <20241008184737.9619-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While converting phonet to per-netns RTNL, I found a weird comment

  /* Further rtnl_register_module() cannot fail */

that was true but no longer true after commit addf9b90de22 ("net:
rtnetlink: use rcu to free rtnl message handlers").

Many callers of rtnl_register_module() just ignore the returned
value but should handle them properly.

This series introduces two helpers, rtnl_register_many() and
rtnl_unregister_many(), to do that easily and fix such callers.

All rtnl_register() and rtnl_register_module() will be converted
to _many() variant and some rtnl_lock() will be saved in _many()
later in net-next.


Changes:
  v4:
    * Add more context in changelog of each patch

  v3: https://lore.kernel.org/all/20241007124459.5727-1-kuniyu@amazon.com/
    * Move module *owner to struct rtnl_msg_handler
    * Make struct rtnl_msg_handler args/vars const
    * Update mctp goto labels

  v2: https://lore.kernel.org/netdev/20241004222358.79129-1-kuniyu@amazon.com/
    * Remove __exit from mctp_neigh_exit().

  v1: https://lore.kernel.org/netdev/20241003205725.5612-1-kuniyu@amazon.com/


Kuniyuki Iwashima (6):
  rtnetlink: Add bulk registration helpers for rtnetlink message
    handlers.
  vxlan: Handle error of rtnl_register_module().
  bridge: Handle error of rtnl_register_module().
  mctp: Handle error of rtnl_register_module().
  mpls: Handle error of rtnl_register_module().
  phonet: Handle error of rtnl_register_module().

 drivers/net/vxlan/vxlan_core.c      |  6 +++++-
 drivers/net/vxlan/vxlan_private.h   |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c | 19 ++++++++---------
 include/net/mctp.h                  |  2 +-
 include/net/rtnetlink.h             | 17 +++++++++++++++
 net/bridge/br_netlink.c             |  6 +++++-
 net/bridge/br_private.h             |  5 +++--
 net/bridge/br_vlan.c                | 19 ++++++++---------
 net/core/rtnetlink.c                | 29 +++++++++++++++++++++++++
 net/mctp/af_mctp.c                  |  6 +++++-
 net/mctp/device.c                   | 30 +++++++++++++++-----------
 net/mctp/neigh.c                    | 31 ++++++++++++++++-----------
 net/mctp/route.c                    | 33 ++++++++++++++++++++---------
 net/mpls/af_mpls.c                  | 32 ++++++++++++++++++----------
 net/phonet/pn_netlink.c             | 28 ++++++++++--------------
 15 files changed, 176 insertions(+), 89 deletions(-)

-- 
2.30.2


