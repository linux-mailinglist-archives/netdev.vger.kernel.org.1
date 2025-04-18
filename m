Return-Path: <netdev+bounces-184010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F36A92F43
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755684A162B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44EE1BC099;
	Fri, 18 Apr 2025 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BDR15YjD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FD1A256B
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939664; cv=none; b=Gj+TD6yfdcbqEXp78PvqDbOYuglFEhLkoTy4ZCdbw8oJDluuJXRa4Ak/ItZtmU0tmbB2SmXLHbn/j2RClS+OvEHEsti470fRrj8Ciw1Nxoz21jojreqe9ptVszrzl00aEcWduU+B+kEKNz5ygetQSRYzcLweSIpxGvy0i1ziB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939664; c=relaxed/simple;
	bh=HUJWBkBa53hQsa72g4lKfaFW0xPoaLLX/27Pe15PHio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o4G3GocQxLeHOzBC15wPzdh4EI6c+2RyrIDt23t+p/v/5wqcak+CWfPeVBwRnouuGUD/jC+YMvS7TOAFI9wC0+BHyQMiedVpcDJRBydjDyywEWMXHyKfg6IkuZcWTN0bIqY+1FNdRUDcqgu4PYpSkq6DgoGNOFXPJbsTndi/rbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BDR15YjD; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744939663; x=1776475663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FtzdmKinpKj28iT81SXfrBuEPcgXAjXrbjqCsomP7NE=;
  b=BDR15YjDU4cKPoXkqtpLS2/0j95UK+76x5fPstT4ZEYKfCzv+EqjaZac
   0IVtg9uMLvtWmgWTDgQiGFR66vWpC4mAlmmB6rq6COE/ocnjTm0/EGKfE
   DR10iabw2kmrdKI+p1DV0gx0vNyNPpgrE5NS2kkWBCZY3ctGToh9sMA8B
   k=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="84718613"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:27:40 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:22518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.145:2525] with esmtp (Farcaster)
 id 6511f248-5bfe-4403-8768-ff6f0c8ceaa5; Fri, 18 Apr 2025 01:27:39 +0000 (UTC)
X-Farcaster-Flow-ID: 6511f248-5bfe-4403-8768-ff6f0c8ceaa5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:27:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:27:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/7] neighbour: Convert RTM_GETNEIGH and RTM_{GET,SET}NEIGHTBL to RCU.
Date: Thu, 17 Apr 2025 18:26:52 -0700
Message-ID: <20250418012727.57033-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 - 4 moves validations and skb allocation in neigh_get()
as prep for patch 5, which converts RTM_GETNEIGH to RCU.

Patch 6 & 7 converts RTM_GETNEIGHTBL and RTM_SETNEIGHTBL to RCU,
which requires almost nothing.


Changes:
  v2:
    * Patch 1 & 2 : Fix ERR_PTR(0) paths

  v1: https://lore.kernel.org/netdev/20250416004253.20103-1-kuniyu@amazon.com/


Kuniyuki Iwashima (7):
  neighbour: Make neigh_valid_get_req() return ndmsg.
  neighbour: Move two validations from neigh_get() to
    neigh_valid_get_req().
  neighbour: Allocate skb in neigh_get().
  neighbour: Move neigh_find_table() to neigh_get().
  neighbour: Convert RTM_GETNEIGH to RCU.
  neighbour: Convert RTM_GETNEIGHTBL to RCU.
  neighbour: Convert RTM_SETNEIGHTBL to RCU.

 net/core/neighbour.c | 211 +++++++++++++++++++++----------------------
 1 file changed, 105 insertions(+), 106 deletions(-)

-- 
2.49.0


