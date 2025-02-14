Return-Path: <netdev+bounces-166329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA94A358B4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D79D16F4AA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C10222564;
	Fri, 14 Feb 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K2ZF/PFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF6221D9B
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521145; cv=none; b=ZKWQU3msum/xZIIy0NhmVkPvsBOHLP2gt1DC06Oc8gVJzW/mfyp7GOj48sdPq+JVAFAL6do3YcR+S1OgpRJ7/+JfwJ6yKulccRcOxo/r2Z3EZAYT/WQL4I78Zaqnev2CEncgwLJKFLwkLdh/WXlY3uEyUHaaYqayxP3lr8/EJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521145; c=relaxed/simple;
	bh=45vpw4lyGNwmwznESJ+p7R/+2oDgiTTGI59ihglnVRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C/SrucM1OribypSNXIlPFPxXXCa1VXvNo/xnwctypYHSkm7xAJYKNA2BWDfQAsJViBWU8FN60qyxu0LDYUYK5DI0dqNqjXWFJ88bT0bsYenKIx/QE/GDLC3p6uTqXi5RfzXtL0BNG7MRqXaCEjL9VJijYlQDuul9+5N60PF9sfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K2ZF/PFD; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739521145; x=1771057145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kmSxIaSQNuE4bDEhjr0tEWX0p2iXtDaNwX+VNTT6bJs=;
  b=K2ZF/PFDJuXvI4lFs/YkbpOfwA6BUduX9+RKNHkewQpUE2sQki2uF/VJ
   vQFW2nBiFe67XYfbYYQToTGz/ItZpk2p6Drkd/LPWKleZc3jEW4i4jhod
   5XZ1saLUlzdJ7wPuQE6oq1sPf4C6u1dc2zz/vBrcJMildPWaCdEIniHry
   A=;
X-IronPort-AV: E=Sophos;i="6.13,285,1732579200"; 
   d="scan'208";a="718726375"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:18:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:46023]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.150:2525] with esmtp (Farcaster)
 id 37a3b9db-95b2-4549-bd08-a7d20a21595b; Fri, 14 Feb 2025 08:18:34 +0000 (UTC)
X-Farcaster-Flow-ID: 37a3b9db-95b2-4549-bd08-a7d20a21595b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 08:18:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 08:18:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/3] bareudp/pfcp/ppp: Improve netns dismantle.
Date: Fri, 14 Feb 2025 17:18:15 +0900
Message-ID: <20250214081818.81658-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

pfcp and ppp holds RTNL in pernet_operations.exit(), which can be
converted to ->exit_batch_rtnl().  Patch 1 and 2 do the conversion.

bareudp leaves some unregistered devices in a list in dying netns
depending on where the device is cleaned up.  Patch 3 fixes that
inconsistency.


Kuniyuki Iwashima (3):
  pfcp: Convert pfcp_net_exit() to ->exit_batch_rtnl().
  ppp: Split ppp_exit_net() to ->exit_batch_rtnl().
  bareudp: Call bareudp_dellink() in bareudp_destroy_tunnels().

 drivers/net/bareudp.c         |  2 +-
 drivers/net/pfcp.c            | 27 ++++++++++++++++-----------
 drivers/net/ppp/ppp_generic.c | 33 ++++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.39.5 (Apple Git-154)


