Return-Path: <netdev+bounces-175941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F84A680B6
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D7B421954
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E11DE3C2;
	Tue, 18 Mar 2025 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y3gLrlJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A1224CC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340778; cv=none; b=pmU9wgK4ayRpnPDtH1qH3SxJJTReDgCOemf95tWHradvt1ZDvfYJyJi0gikE/dDJ07mbqp9lJfSZZsQ+Xv3/C7pZmZe1gNO3YXIgOKcAqcdtWlCQMMftxccq/3cyKsHFRU1UPRtSBgVMmBLNYr4qqhtllnUDH7qelYABJ8TmhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340778; c=relaxed/simple;
	bh=96UYYXOnpsBc07DkVwZad3vVXkFez4nUsv533xUkDNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RS9OCEl7YahZuaFQ32Ygk7JevIND1wqiA/CWxHPp+j0At5nL1FIvb+3rDZgXEsEFoAVu3HhVT6BkmbK+dbEAQxoXYSq4tujXH1SoHkRd7POCeybqiSmXdYFx2c0ZaWZmZg0sd5LFupgW/nuuzBnEFnTSCzX+7bHtmcUnV1SBVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y3gLrlJm; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340777; x=1773876777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c0644+xIhkgt9GTTpY9lFJMmedgNi0t1FG7aI/uC990=;
  b=Y3gLrlJmiPscrBQHOGDJUVrDlXHGsGs5adLGW1R/st4H7CFSPaujSSKQ
   wyRCzEscgw/fBqiqTwVOh0mIL9Tm5gfonPKW6Nag5DDcB/A2NWi+CbVac
   SR6Agxxgj87mqIF1PJNqq3V/tqR6JRTuquPnHDdMLuaNfgkAuK4xZrRIH
   w=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="706166306"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:32:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:62837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.90:2525] with esmtp (Farcaster)
 id 818ed80a-3113-40a4-b9a4-b4f3bcee0481; Tue, 18 Mar 2025 23:32:52 +0000 (UTC)
X-Farcaster-Flow-ID: 818ed80a-3113-40a4-b9a4-b4f3bcee0481
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:32:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:32:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to per-netns RTNL.
Date: Tue, 18 Mar 2025 16:31:43 -0700
Message-ID: <20250318233240.53946-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
done without RTNL.

Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.

Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
this series.

rtm_get_nexthop() can be easily converted to RCU, but rtm_dump_nexthop()
needs more work due to the left-to-right rbtree walk, which looks prone
to node deletion and tree rotation without a retry mechanism.


Kuniyuki Iwashima (7):
  nexthop: Move nlmsg_parse() in rtm_to_nh_config() to
    rtm_new_nexthop().
  nexthop: Split nh_check_attr_group().
  nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
  nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
  nexthop: Remove redundant group len check in nexthop_create_group().
  nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
  nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.

 net/ipv4/nexthop.c | 183 +++++++++++++++++++++++++++------------------
 1 file changed, 112 insertions(+), 71 deletions(-)

-- 
2.48.1


