Return-Path: <netdev+bounces-79224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57BA878569
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CFE1C21AC0
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473B4CB55;
	Mon, 11 Mar 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S3DGDYkP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC467495CB
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174251; cv=fail; b=PmjfFf8UJbOm6XVWoMd++BaU3r3szww0Q8EITheyeNP/YJpRK6dsX9Ly82AS1U3p9QQkXTC506Q2HccKfYNisOIqcB4lkGKBMnUWehNVkR/TfQaYoHv2CVxrfoL2mnYwlhhjs0oddXQ/kIJ1khN+fPgO0cfzudJMu0/g6jFRxS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174251; c=relaxed/simple;
	bh=Bt54MjHmwV4FjMTBgq+KezsLmF1a8FhC0ex7gTL9RQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp5w6GE+2v7zl6O25zIB+f6E50BGv79ulAMenTHckTn8NPg+8uhNm5BmN098tmgISn64fwiw9qRpxtHym8cYm2vghg+8ZhdZaxVwrmoHWJ6LCI9Cf0uwn815ymp9TziXwTw5A34nvo/sBOwJ2nHbI85MvfZjtf036MttSDMHbww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S3DGDYkP; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHi9zlQj/tZjk8nuxrX0P+yAYqOlJadmwMGTDfGSBnWP4A/MYbd4QgEzlCok3SN+u+SIRssWI9WCvXTa1KbTcwR7C7nrb8Gg0qS69Ld8jzNmAphV+JBfvJVBTuYVM39Tv4NeTGo0fM77FZRZ+ZaxWFEszX9I7WzmWpMLdhTBaQ4RJfK14pE2ncmz6nEtyPEO1lw//wlt8ea76zFxTqMurue5ezD6q4LlEZ9t9fDYON28EQ25AdR2OBkZkZE7RGIMLNudsYh8cPznUZ/xz52x3I2DH14rlq4P0z2ApqP0zB3bPNkr/kHASDvD9FAlGLkcK959yMx34eT9unFvgpHQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5jWqU+UjeQKRm9GKPwgtxwGec2O14vQ2HSizMTRnJU=;
 b=TojG9ndqdK31foKyCh1/r/bJREyH8Gg9CPNj1XsL/GTbpLnqm/P9NyjR8XKZutYK65wZLirzw3Wgrv5gJLNB9pDxsa/kkUcURdBFl67OsdIBI615S/ucHt7Bra0jOJQqzjazaV1k7EsfLM4RmXvvNnAFW+jUSTVsWC3fCOPSmtMyXFSzMUDwBZQiHHG/Vs1a04rIwKZzrtwq6uKgseka8JGctLHR1RQjRBMATTmFL830SL6hiMCB2M4m5vQi5uHV8txM1hFmg1XK+4geFO/cq47pZrMyQIUJAThmJa8X7HveeZ2YjfOg3H4UXxdQZkoZPuCUNBfAOpLePAHH47NxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5jWqU+UjeQKRm9GKPwgtxwGec2O14vQ2HSizMTRnJU=;
 b=S3DGDYkPNlrAjRoGpVlCMLCxV/5FAW3ZSQAz8jFRqhIvcY0PFVb99UZNCgxXFqFf3pYhXhoqVRyfHNW9S0gs0kDvgF/O1hA/XjzYuw67wyvDCyamkcv1Q+Zy1ST/ACwQ15FBsRBaHCz96dC9SNluSL/hZVuv+Xq8E2NWRAybKPZIhIc8iqJwPVUJ6JJjF8X2OzdVCV3O3mUJFDIc5MFKRP71TKRO8qdMk6gUwGW/QHQMcyHy7Rg80FQ5rDo5KGJ4A9P6+HTwW6REue2cY279w+Jj2a8J2YyNdFyRQWjthE0GKkYj2oXIoWnHPg5IFSxt5x0hSVG0PgV1rO4gX/qEmA==
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:24:06 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::9b) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 16:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 16:24:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 09:23:50 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 09:23:48 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 2/4] nexthop: Only parse NHA_OP_FLAGS for dump messages that require it
Date: Mon, 11 Mar 2024 18:23:05 +0200
Message-ID: <20240311162307.545385-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311162307.545385-1-idosch@nvidia.com>
References: <20240311162307.545385-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 95631b53-bfa9-47cd-e64f-08dc41e7ac57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DQVcc5TxSMp8UOd6L3EbnnoBFLsZ2DUW7e1KzUy4sMq1K+8nxbv6ZvQAR9xIuezgicAUEnTf9jDdVGormTRGSuW8Gkv7UWJCy3XFCktfWn98lTorq2ATmbqcLWhc7ONHmXBK0JtU5mR3IjeU0s/wi/NOTfdXR6nbV3W6bzw/ED67wm8inay0kXxQj96r72UVphwvWw8q6D41Oy7nAv8XvlhKSd07mx/QhYZqWRhg8hShL8jJBk/SrcbRKnovtjFNDWAbKqKAmsWyk27DXXzvk9kTVufCg7pO+DslySuuWDy2UMvoAJtmYGdNhtAJlGhlZ5IZBgJzSssbkxkR6sG+LjzFjpIG35YVtF52OUQRoIF6REweu3EG9kZfpZH4x2Ffy9oUtPN/yc4e2FKa1gtvlY8gW2ID4Ae3hNSYWOsXODvTROQLKFYBS0WaQKLPI2EBmtP3OHNeHuk1kitvnC5r0BDsjsFjmObGhDIFtKpQwElNqn3SlEMeZpPAiJ64a2c1JDpHMmRv09ipvDdgx953d2c6ZMRFffm2+wg6Csq8OTFVM/doG/KbKf7/zPToY1/xFNTw7/3s1DmgILta8koN1uIRVl7nl6+M6gYTBwR80zgh7w1IoiybXG76gwHbsoCA0KX7H9LfCaaGbP0TleXp2lK5ny8xdTasAGVpFpTXYN77URGY0mo8hTHRRIfOBWjLYeIXp0kT880eTN/WE0x+BwXVjBT6S7tSoU0FfIgfb42KXkxKYnhvshBlF1RNQqz4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:24:06.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95631b53-bfa9-47cd-e64f-08dc41e7ac57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

The attribute is parsed in __nh_valid_dump_req() which is called by the
dump handlers of RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET although it is
only used by the former and rejected by the policy of the latter.

Move the parsing to nh_valid_dump_req() which is only called by the dump
handler of RTM_GETNEXTHOP.

This is a preparation for a subsequent patch.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * New patch

 net/ipv4/nexthop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 03bacf9c0502..573da3660cb3 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3397,11 +3397,6 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
 		return -EINVAL;
 	}
 
-	if (tb[NHA_OP_FLAGS])
-		filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-	else
-		filter->op_flags = 0;
-
 	return 0;
 }
 
@@ -3417,6 +3412,11 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	if (tb[NHA_OP_FLAGS])
+		filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+	else
+		filter->op_flags = 0;
+
 	return __nh_valid_dump_req(nlh, tb, filter, cb->extack);
 }
 
-- 
2.43.0


