Return-Path: <netdev+bounces-225037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5EB8DD19
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880D7189C1F1
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5B1C700C;
	Sun, 21 Sep 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uf7MVmAp"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70447199FAC
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467408; cv=fail; b=d2YdSBkfENk7oqbTWivYY8XF4eNrjJGG8xzogqopRU+2HGbrOGV1cPlWk4qx4iL2scQllkaQ1X43c9D4Yy3uVzWBlK0rtigH8jWjWmo4SKARMrN2/x9PUtifwLFDa9YVEKmvpRHz9VWoJD5OFGcjcFPbFEyMBcbZcWGcNXFQieQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467408; c=relaxed/simple;
	bh=RouEIDdtCUQCRwPLiA+k9hbEOd30JCl4FP+l8wNrZcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fuV5oMYE4wOgcJWYq4xftlUCmzAZHZQhus1SXxVu2mP7ssUnzsjnVgTfsW+kQfh6hu1v5g6zuk5wP9cCr0/2ebOn0OP9RyWMWkR04IIhkKW/pBlpwl6DqM8t6229YbTGmxacC9WCzFyJn74opQ80kXlWWlwHYRgrremRFupAx6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uf7MVmAp; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roQZj/mjpGEsVB/jUIMKRvGLSJm/9e6CgDY8DuE9Ok8PKQkkCss7pKkcHJ4rMOJKQ8wOlpwe9a3Maek3ZE665Ob2l1YSlQnzX9uNgvk5FrLYLzZSMemb3iIxNkoBhZdg0hnPiZ1ViewefKTvx+c9tz/Wh1/Xe5cRsSGMoz5wZtCMpyfMCWnk7ffF8DGoOnJaMN/USFAcNCys6oUl46aInUVG92Jmg9UANrsg3gMEydEgTKvMy3nyHYT4DXrcwUYVD8/QQWXB/4yASEBH8WFi97dzQoeq5sDGq2nq3rEYdgIz9HGhwHO+k1BwaKuCkQPF8yAB+ltyDqxAPTowZH+nBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8PJFzVSVyascDsyjJ+eWSwATQ2kmquURnG1nyAIXXY=;
 b=M61vTZibREO8sFnsWokr4kFITAMnLD9uom5t/x9Vrtr8qkdr/BV2oTawTC7Grcp+lkUq0SHR1vP8UHoZI78YAjpkziGpymVWT7wG1ETDoZFswbTzzsRjM0gAEz8qXbvP2HwMvA+Dl1TOrblbYV4a5o/3/ckMj77FTNijADaniF+fAWe0fZSS/r1uaBotBHTCgrhwW6rdq3C99QOzTxcC0+3fDDGGmL1jjSwqAM+Fq4eCdAgLZnqhcxkDWEmLWPcIlD6kaAOso1m2qfaXepO0/BiLfbS0wf+W4RDgFjk+UQTQohqUoF8WOsR/7Rlzwb1rVrUrUW3Ys1QtZGlB8qSA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8PJFzVSVyascDsyjJ+eWSwATQ2kmquURnG1nyAIXXY=;
 b=Uf7MVmApfZTYZh8ewFZ+rmYi4KdcyX+hg85ujju7RNcyQMQyXOZgpv+EfZ4pmlQnZDK5cfmJzIZ9KIBf5ZgBgoZSijx+QKZCoEsyZEQoaKfN+kVU24gL1Bt/YftOS3HT7FZeSH9Iy8LEPDJgS1SlYhRm6P6IPkk+329vN/R008cnPAWF3lfUp/rxi/4G/qYoSLuhAkvwDU4IQ3FsAqwD30u/1JDMwIjE3S00bkf3FQe0ympuDoxsqf97MAiKFVC/DvJeWpRgGX+eEo50I7UTTUg8DtMbRCxFCskYyM6l8SP8h6JN9oTD1Wlsx/f5lXTpWMBG9LilA3s6FBcJZ/ZcPw==
Received: from BL1PR13CA0423.namprd13.prod.outlook.com (2603:10b6:208:2c3::8)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 21 Sep
 2025 15:10:04 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::55) by BL1PR13CA0423.outlook.office365.com
 (2603:10b6:208:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Sun,
 21 Sep 2025 15:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 15:10:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 08:09:56 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 08:09:52 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<petrm@nvidia.com>, <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/3] nexthop: Various fixes
Date: Sun, 21 Sep 2025 18:08:21 +0300
Message-ID: <20250921150824.149157-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f505a6c-6a35-4648-041a-08ddf920f158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YW1bh9E9IjOlnrWudjA4CDngByiS+DjxMW6jx2Q3vpw0NPP26xkSJXIF8dKm?=
 =?us-ascii?Q?9VJH5E5dJ2m5aWexy2cl5yOx44ivLj05SLv9TJKIqBGHxlJRmTMEcSB1TSMz?=
 =?us-ascii?Q?E0hRbpkqYyEpwQ0/V7VHi8xfKRStUwnctbpC888XYbuargWO/8vCBASrBAHb?=
 =?us-ascii?Q?TpBACm1SnRJNT4Do2jAHOMOejE7SIyediKsC7VEdq45XwrQGO/XxDexXKpj6?=
 =?us-ascii?Q?jMIFypoSCW6UFwmC4ilL7zWQ8jRCE6Crui/RDty/1wAuTHw/ybZwaBwU+hMQ?=
 =?us-ascii?Q?rV/M7Gsm0Z58AbqsQOZV99LNHKV3bmWvK1JJwJ1+3OE+v4Da2aXUYQooaEpr?=
 =?us-ascii?Q?s6DzhP3zmljp65M1gPnUqA6ANaW3BUmjnEprwAKII4Z0XnjvTefjEdjqZ27w?=
 =?us-ascii?Q?iW8BQgXvPoJPQPBZ7JVY7f9VRcVALnkd0WgmcuxG60PmdR0gs0wAxDTYK3xa?=
 =?us-ascii?Q?oHUDTSGjc1zNrXgX6RkKVx1FTLrJbxqcDJQXrZrmEseJ9Yx983BCjkpra/lX?=
 =?us-ascii?Q?bxIE+0ez3ld4svhVLN3cYGZvEIDszhoTtGcY+dsh20IbF28zXLwe8mXKLAtZ?=
 =?us-ascii?Q?ix5hhXOt2J35crlCKipW0cT+WIfB7UOrktQcCYv0UXZ+DUhNK1faL9Dum0bC?=
 =?us-ascii?Q?y5lcYm4JgC84TZLIaY8Ttkqo5pFuIEMx/3/EGmxR+zj49/Y2z/Da0ZxIrLdg?=
 =?us-ascii?Q?iskvtXGZlOXMCyq9l6Cv+ZTGZNbIydhL1ND4LgVkY6jK5UCIEwHkHjJkxhmz?=
 =?us-ascii?Q?L33o0U+n3X7bVzudipRKf0A2+BFFcGbSZiPwAH+CSnmoXTSoF49wvmSi4PUe?=
 =?us-ascii?Q?69D8tDl25tJQSIng0wfihFKcPfVCWzqj/GDAxHYU6iWXUX21Xqoxqe6GnIKv?=
 =?us-ascii?Q?WmgJYrXPn9enRQRqnMh10IV8LTpH8WA7NsBXcOYqYxv5GNEyW+vivZYcOUgb?=
 =?us-ascii?Q?x9U+f3cZBDOjihfc/rlsXJ7VJT2O5/AwWdS0xii6Y6n5F8fRK72rIKELXl0y?=
 =?us-ascii?Q?n5mZAytyQkDSupcw1rN8Unr4NKkXpO9hJoBxXTi0kDxyNB2VKqaO3pSMfxkd?=
 =?us-ascii?Q?rr+bxfcBlgcfSbj8ZTRlBanoVydJRpDFEmRTrwNqdPjnxCa+019teHGRk8IV?=
 =?us-ascii?Q?kMXmWlurRH254I6rxM3wf1B4YT7HnIzjOX7eFiYJhRQC+Wgvrmx2YqNDGx1i?=
 =?us-ascii?Q?ySzi0TJhsq1zgMfL1e7EZqw6s/UO7CZlAk57Y/asEWiN1fxKH0mKw2vkQ2m6?=
 =?us-ascii?Q?+NgVscdJKJHrvjUAkA4kftAevFD46XNVTaoRuLfyDSMSnLDjChek2Coo2OLt?=
 =?us-ascii?Q?3jIi1RLY/MHzSKqOInXMoCGok9tS0X2eSgGSBqkeVVWqf0JYMT+aB67vEhty?=
 =?us-ascii?Q?s665IkVjn4eVPokO7xK7RH97wLWXmEL9AAeS7jqYBYYdDfKkAUJmI0HLaX81?=
 =?us-ascii?Q?ThC4MQBD8lQtz7z3RdfxLvlSCl0bBvkYytsNlnvg4NLlPo67yLfGL0IRdJoO?=
 =?us-ascii?Q?yBxGRACWvdIcSXX27yC7N3U09PmyyK49x5e+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 15:10:03.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f505a6c-6a35-4648-041a-08ddf920f158
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

Patch #1 fixes a NPD that was recently reported by syzbot.

Patch #2 fixes an issue in the existing FIB nexthop selftest.

Patch #3 extends the selftest with test cases for the bug that was fixed
in the first patch.

Ido Schimmel (3):
  nexthop: Forbid FDB status change while nexthop is in a group
  selftests: fib_nexthops: Fix creation of non-FDB nexthops
  selftests: fib_nexthops: Add test cases for FDB status change

 net/ipv4/nexthop.c                          |  7 +++
 tools/testing/selftests/net/fib_nexthops.sh | 52 ++++++++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.51.0


