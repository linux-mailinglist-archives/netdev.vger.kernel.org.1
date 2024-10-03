Return-Path: <netdev+bounces-131770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745AB98F852
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C31AB219A3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D3184524;
	Thu,  3 Oct 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="slpS61Ga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF112EBDB
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989066; cv=none; b=ju0x4KyiYq9RUZFG3Vi2N96ijDv4Hdsg6mzILgdUrPrrGG7htv9MgUScn08sEde9VDIc9l88uCdc+ih2Yqf4JIZwhjXgDQELoil08kmoste2tTPqnAsy5PQbPcPiVZUidZvkLxYaqkQfhjR0MdLYft2eipDEHXpCPl+QOjJsVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989066; c=relaxed/simple;
	bh=yFH6NkcxRQnMzoIVkN77PwSPl1DyFtx2BdMztiN/zsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbAY95UC2EThOMd0bkmN0tlC6pbzOuPzD8K5DrIQYKbV41E8o+p01NxmNfJjtoxU03Yi6bf3eyFenqK4K/rHLpEHVZ3k4MHifef3l0//DK2UQhIDg42XElX60sui0guwaPpipfgm/uSr1fZsGxegdovamIWoUD/qXD1F3TaTi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=slpS61Ga; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727989065; x=1759525065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aiAelU6QmapaZXz9G/7KilgR9B6Y3KT+YWknbbmloxg=;
  b=slpS61GaeJ3sY3KFKRyy49TFjEugUcUOjGbc3a4bI4YWslEp9CDNVL77
   ytf5QxCmCHyHXrHFanDopIL9sp9qpARumbfTiKdwO6GW8RfSLvJgkxZ1k
   iOI3/YwDcbCMOrBFmoKlu6zXwkVZ3hI1YyBJ2wb1oEvYr7H1rCj8rK4zF
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="372649081"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 20:57:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:9945]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.191:2525] with esmtp (Farcaster)
 id 127ecb93-8e6b-4700-b8ec-dff9d37f1d1d; Thu, 3 Oct 2024 20:57:36 +0000 (UTC)
X-Farcaster-Flow-ID: 127ecb93-8e6b-4700-b8ec-dff9d37f1d1d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 20:57:36 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 20:57:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/6] rtnetlink: Handle error of rtnl_register_module().
Date: Thu, 3 Oct 2024 13:57:19 -0700
Message-ID: <20241003205725.5612-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
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
 net/mctp/neigh.c                    | 29 ++++++++++++++----------
 net/mctp/route.c                    | 34 ++++++++++++++++++++---------
 net/mpls/af_mpls.c                  | 32 +++++++++++++++++----------
 net/phonet/pn_netlink.c             | 27 +++++++++--------------
 15 files changed, 178 insertions(+), 88 deletions(-)

-- 
2.30.2


