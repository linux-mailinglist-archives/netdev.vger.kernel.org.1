Return-Path: <netdev+bounces-78463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404D8753A7
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9F285790
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627FE12F397;
	Thu,  7 Mar 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BPa56bU8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAA12F380
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826534; cv=fail; b=C0A8VZ6O31ZNQNpXg0UALGQs2POF8a0EdqKR5U6h87UNlQnbT1qjokT09rQnb4mXdIstX6MCWiJhBA8OYXTac2FkHxpaEbBL/EDJpVFPNwkNNA8/tLELkFxh0C9AxoocdUYmidSUbfk91UJ4g4tLepaY9zAuq34Y3x63Eav5xVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826534; c=relaxed/simple;
	bh=6I6BcAXbZe66vpAEu3q03wgWOuWlfJcstAHoUJxpYVU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rp4Zpns31cfQ9DtsJP1yEPwxC35XA3CzLx155rBGydl7QYXJfeBWBOsMfKNLcGD9ag00v6K/aWHHB6pjRv6QenZ6BxlfAb7TLkQZ0rOJzXQN47BUaFTlFCPxn0S9YbjSSc3JKREUo0xiLyqHB/QFgwjUeBwtVpcvR6+Cv69t/pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BPa56bU8; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRs+Qaxkg//s6nygyceFPJORVUcSasEZwf0J1HUcMs+DsvsG3mR8IH4wu6BUdRrvAEnVeabXLIz/2Il9RshJeni2Uj1tS5zBInu7a1yMgJVcGXudEVPSFlmjZ5MPeislJ8aOW/23e5An5kHz7/SF+Ie4mCxFzv4L9Lg++zBWje1KgmZD//CxOvEey2LqLF9V5rl+MqPHkgLWp4iMmbmBnGBvTRhiHeiVUU2MTW2o+opgxbtYe15D5XHtMwaA4+cTUHUAglnpxwqUDKZxKdIAIGD5vTLyLde2Ju9p5TQUaW7APTAZs1iLTG9KAhRg2UJJo/dqjO4zuMYDh+dbuinjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bss0oNpLHYVIqAPsY8UHhhYQ12dgUC3g1gG5nbZGdc=;
 b=W+a1mzm/sB3T7Q2Fkq9K4ObVUK4R2AivQkUlZa8ypNRo+24cxIdLTtNYFye+oKZ4m/VXYuGXYPkl8mX/hWAkYyOdcwBVA/E5nk7UhH28BNoI2EEaQUMortlXUCMuVbeJPxPdqbQIsRYq39TARvM6KFPB06Pgs6GBt8qP4U+GCEbFMgcu5WglTwcwz7SnHE+BBS0vyNlFy33CpdOHBE5RHLUAJ2sqM250+RedZvgT2qTtwHAjDpw2vk1ENijeT/jnUIiT3MVFZKdhby7GXUAK1F2NDYPzo8OwjoI/0uRzzywr9W0ABhjcSpdLRBBXZzwpe2UsQVzvJV/0QdGTKlVoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bss0oNpLHYVIqAPsY8UHhhYQ12dgUC3g1gG5nbZGdc=;
 b=BPa56bU88s8HGLgQr7NUQVbTI0IHTkMIVX1rOostF/w7jnI0nV84Xvd8K+4mYn5ycj29XCwFI88XI8vuNKMLDNa8pw85eg1tZwhFVg3UltmXZj+WnJ+rs23+PwBAn9cwh6HNA8NX8joKlEGh2hxVnWbXHSh9eZnupo4eCYYodFt52eNY6vdh4RMxwNcjjdj/Su8glgzA5OIymaNpNbLfZFH3vEBbec6mNeNQvLgBxbYJMGuZ9kLFxUJOb+dKvvSDCDdPU/zm7pM+sq59HAD02Cz+jDe/h7no2RY5CkWMrlmUbhYxPDLJzQFRKtbsakMU6shaKPHv2u0f0M2x8SgQnA==
Received: from CY5PR19CA0021.namprd19.prod.outlook.com (2603:10b6:930:15::23)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:48:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::fd) by CY5PR19CA0021.outlook.office365.com
 (2603:10b6:930:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 15:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 15:48:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Mar 2024
 07:48:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 7 Mar 2024 07:48:24 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next] nexthop: Simplify dump error handling
Date: Thu, 7 Mar 2024 17:47:27 +0200
Message-ID: <20240307154727.3555462-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 100af6c4-4e68-4aff-6d8b-08dc3ebe1349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i/Vg/NUGgQ9qU3dNxZLturWM9PprWHCQLPBxHPSBBu4gR/TAT6iICRX5FggJvK9f6yOBaJhD0XC2nfj20EHmbsDZLTorjMwr4ECttI91nRT+MFQj1dxKTsFrLd/ItG8yl09+tHiLaYjdPl0Uz2r/PeQIZ7n7INsLuzQCPeODKiKq5iFBcOnpK6vohNfppsysPz3tHYED1QWdKLTAlSlkxIihhv9/uQ6PVo6nx8Ubz5EbgWrCsiPTeeooHyvdDKTgy6RiVU/0sTeMRpETJIKEFMitV05XOFRzaYtL9A9BKllpZKKz6ai85U0yiw6Bezwu6WBpV/eVtW06QmuWtZigT+EnxGqVKa4nIBM3On19MHbEVHKcPpojEgOlZ21jdrz6Fot+GG4C1FtJNcTlWE32uOE0clgMnz5HbIVlMfOb/TtwZwiKnEY4shHqgO29xNLBpFqtKzpy1055fNw3xObUaWwyP45OyR3TrTCbZBTkvai85BLzTp3VM9YCZyJoBZ2DM3AkH0qP2Rii7Y6vfLyRamN/W5ShDbylpWZ+AJbKLF5aBKYMJ0ZrNaJxcUMDadWNh2XgXyVZt9A52uhDF8wok+bcdNw+HVKvg/fmmJz0QtmkRBus0JPJKDwYOHPsoOmL7ciLV3mxdKmsYpR3RmqVol/gAlobk37OAn5ZKU/9LI0rbNApYEHz1ZpXXqWD35809gv9ocM8Hvm1NkQo76spWyeMsgkD9hVplwbfED7nHxyxs1gXCNe822iyMK3HG5ap
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:48:46.6805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100af6c4-4e68-4aff-6d8b-08dc3ebe1349
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253

The only error that can happen during a nexthop dump is insufficient
space in the skb caring the netlink messages (EMSGSIZE). If this happens
and some messages were already filled in, the nexthop code returns the
skb length to signal the netlink core that more objects need to be
dumped.

After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors in the
core") there is no need to handle this error in the nexthop code as it
is now handled in the core.

Simplify the code and simply return the error to the core.

No regressions in nexthop tests:

 # ./fib_nexthops.sh
 Tests passed: 234
 Tests failed:   0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 70509da4f080..b3a24b61f76b 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3241,10 +3241,6 @@ static int rtm_dump_nexthop(struct sk_buff *skb, struct netlink_callback *cb)
 
 	err = rtm_dump_walk_nexthops(skb, cb, root, ctx,
 				     &rtm_dump_nexthop_cb, &filter);
-	if (err < 0) {
-		if (likely(skb->len))
-			err = skb->len;
-	}
 
 	cb->seq = net->nexthop.seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
@@ -3439,11 +3435,6 @@ static int rtm_dump_nexthop_bucket(struct sk_buff *skb,
 					     &rtm_dump_nexthop_bucket_cb, &dd);
 	}
 
-	if (err < 0) {
-		if (likely(skb->len))
-			err = skb->len;
-	}
-
 	cb->seq = net->nexthop.seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	return err;
-- 
2.43.0


