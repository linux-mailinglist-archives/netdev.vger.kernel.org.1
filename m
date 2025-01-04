Return-Path: <netdev+bounces-155127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F39A012CB
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1C1884854
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722E1386C9;
	Sat,  4 Jan 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XI4KsP7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138B33E1
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972688; cv=none; b=mpvio7qDMbzN6qMwbyZWwIbCFaySLG90jIiWc2M9BZkpDHiLtzCQJV5/+JdVFqDO7/Rl26yPUEeLromnjNJs0HBdg7IL8NletIknpp/iegVS35QOHEdKnIq7gjElr3xsLG5WQH2hBvExtJ/+19OcCExqBULyjrr4ihzpAutSpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972688; c=relaxed/simple;
	bh=TXCYmVUyRn5v/Mv4aVyRVFMonoZUpaIuRamdR4E36Mc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yl0N0VK47jqklKOwgQ92fL0fbCm4LpbzwoDwMNQAR9sCd6qs0FllYuW1BTFNlpImlZHS3lvLGf/fRBRPzha/ZEm25fkrRt80014iwrubW2dzTAbsQ2ZrwfgcA0Agmzz3CNBUzjbTXXSIabF+vYTCqvewgL5/i0qSjLscb413ZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XI4KsP7d; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735972685; x=1767508685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lR5LwlvPxpRcWBW/ns3V8fRNwALtYr7IajdDxtEXQsA=;
  b=XI4KsP7dHxUuZtATUZtSpBEzVYNbR5yaAHtBpe7eIPqwvALnruQLoUS4
   oUIVy0nfpBV51aFrBXiXRFGOq6D/fw7p/xvgww2Z8kmIuA/1JsN6RqyxQ
   P/cUG9cBg7ddMUIoch/NG74YXlL4Ytt+h9GQSJopUpnlVlGS9BPyCtU6y
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="708401079"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:38:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:7746]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.230:2525] with esmtp (Farcaster)
 id 9f81ae20-4404-488f-a1c4-540822a74b8f; Sat, 4 Jan 2025 06:38:03 +0000 (UTC)
X-Farcaster-Flow-ID: 9f81ae20-4404-488f-a1c4-540822a74b8f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:38:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:37:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/4] net: Hold per-netns RTNL during netdev notifier registration.
Date: Sat, 4 Jan 2025 15:37:31 +0900
Message-ID: <20250104063735.36945-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 converts the global netdev notifier to blocking_notifier,
which will be called under per-netns RTNL without RTNL, then we
need to protect the ongoing netdev_chain users from unregistration.

Patch 2 ~ 4 adds per-netns RTNL for registration of the global
and per-netns netdev notifiers.


Kuniyuki Iwashima (4):
  net: Convert netdev_chain to blocking_notifier.
  net: Hold __rtnl_net_lock() in (un)?register_netdevice_notifier().
  net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_net().
  net: Hold rtnl_net_lock() in
    (un)?register_netdevice_notifier_dev_net().

 net/core/dev.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

-- 
2.39.5 (Apple Git-154)


