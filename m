Return-Path: <netdev+bounces-132681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952D992C4E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B671F2106E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CF1D2B14;
	Mon,  7 Oct 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wFOadLGq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3EE1D26F9
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305119; cv=none; b=SM2TULOsTSsbWSueaCFO6MaqfPcK/ddOJVBRFsfdtCX6Z5VozbF6LQXn26yy6uGMJRba4jXYt2wZjP2ve2DDvG3JOIGLqiW7otbM4cjyXQ0Cv9gsH8L/D5VbJWDx79g+9/FSlQJfoO3xFXHFxiq9LC3wClah2IlXHL9LSsWeZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305119; c=relaxed/simple;
	bh=wQF50cYvoHNjgReo2WNGZUncZFgTkB9XJNz3iHRDhHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e9K6oNSAPOJ4P6AXVvd/M2bs5XDkjWgd1IWPlj3KQj7Rjqc+Jg+W9Y5iNo0IO1EwCkOlNEVCnRLLOrObGdHyoMYnlUiRszvF7dcxVVpc31yiuURsaKUfS42TQ5U50HNpqm/LR/8wBCMdKnkoKyf0ewFHApUcLd2zOVBVLavbuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wFOadLGq; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728305117; x=1759841117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GqtHppFC4GbIH8XhMpm6kc93ktnnTfk03bmKfNezhWY=;
  b=wFOadLGq8nfGygdflYbkFsq92Sw9xIjjdY+gtIimmJk7hcPaiAdqgTAS
   q5AjiwHkAQx+sKRJzzipHJkH2moC26kwHEBljLbrdfhcnnup3rCStBM65
   Um7/O2FZEbSn8LSHI67x8eX6DEqP3MjHzYJXWdAHsC/x+ao5xOamxlL9d
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="429419835"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:45:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:46993]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id 14a008f4-ad49-423e-931d-ec313c223c44; Mon, 7 Oct 2024 12:45:14 +0000 (UTC)
X-Farcaster-Flow-ID: 14a008f4-ad49-423e-931d-ec313c223c44
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 12:45:12 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 12:45:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net 0/6] rtnetlink: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 05:44:53 -0700
Message-ID: <20241007124459.5727-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While converting phonet to per-netns RTNL, I found a weird comment

  /* Further rtnl_register_module() cannot fail */

that was true but no longer true after commit addf9b90de22 ("net:
rtnetlink: use rcu to free rtnl message handlers").

Many callers of rtnl_register_module() just ignore the returned
value but should handle that properly.

This series introduces two helpers, rtnl_register_many() and
rtnl_unregister_many(), to do that easily and fix such callers.

All rtnl_register() and rtnl_register_module() will be converted
to _many() variant and some rtnl_lock() will be saved in _many()
later in net-next.


Changes:
  v3
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


