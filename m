Return-Path: <netdev+bounces-166822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E6A3768F
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72D3189090D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0D1A00FA;
	Sun, 16 Feb 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0/v/lkx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712919E833;
	Sun, 16 Feb 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730339; cv=fail; b=Gb2wTL0wqcvQ/k+zxVll6TBpN1uVJy/j9ic5QSCkMZ+l+qavSRQGH6w/kWwXFQF6SV/kcF7m5MjkZpHUFueN1NAu4IBDQQaMVh7eTsfSPnncbfbyZl+E838kduh8VBfno4L1IyiF0MwDVrdntAd/IC/ABlfjK2qofwevS9TOYQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730339; c=relaxed/simple;
	bh=NLkYE5HOT7xJwAeeFKTm4J+gC1LcB3xmVMoNtrE9KJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hy+LdoMGrYI6QVeZEpIb2wX6C9hPdPtR/gQVDcoH6tySH2UGg5jktkCF5L3yDkha1deQC5RU8rePowB+RCn2JLQReFMES8AcfSqyIgIQ+SZkegQSwJhDIGKQOl4K/XBpbcpZAvuRZesn/vicppYMcdh2AWfJgMKurEteqsycRiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0/v/lkx; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE09sJc785FWYhIr0VvlQ/EDeal/WkBLn+2f+kGowKAP+2ti1fxEcTisccXVVnKm9mCSFfuByVdOgt3PPyKt19zDCHLYCjQ0XTgJ+Z1VxYDo5CJ+0qOai3zCttWhIMC/AhsCkfocF5BSZrlhHFZQIVyyFAUsqfWED4/vChMwg5KtExX5pR2+jDOQnmDxyZ0IMihCWDFyYL8YROLgkWB0lCCKRGFMNCj2JHtYIYtAmjuCW0HMEVuN9QwIZWzY7kOj5iDRJ3k0zK0vZBTpaVk6nba5fl1AQNgYWqwPjhvy7zGvuWqi2+t2iv4y4R33/lz0+NDCM9yp4XCOjiynzvAX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs2x7GsY+Q8mv45wh/hP8xsKfiBJPgQpO0a3QQd5LRY=;
 b=IW9EOPTAa4ErERuy+eKhVuM6xiIxiq+5hhhYNjASJ5zl9bE6u4+1NSotBFBQRzad2oeK9Nj5eagNr/PsKU7egiPbvw5stEtTO3TTsPsTmD+Fo/BqlLjrW1doYxywTEFlUrILDKfnEa84FlosrGKQCs+/zOJk5EwiS9vjS/8RtTqw/ufDyN8b7ZUqEN/U74ZSrz14Mk6uPQMDlCbxQuFGiqH9MmsH6yeZbYS8MPQzIPAFxvJnIAumIYww7z2rkTpqLpza8/5yIfKWk4e2aUdnCAG9Z1N218//7qDFDdmKOyETPnjVyUXNkP9+/NK+uSS4kl5rR+HDcCERPxrRdIPYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs2x7GsY+Q8mv45wh/hP8xsKfiBJPgQpO0a3QQd5LRY=;
 b=n0/v/lkxNDtffCqMGuaSxwz90BhsFJal0I0wxnB6+wsKRpj4zJAwhhZYnYbAKe7uRyJDEQKbNH9KOdjsx7QNe3UXHuqS6EHG6nzOcEVPLm5dGApWPi93XFvkW97kntSAMmbqZ3YtThAsepRj4d3C+lRhAahu9aXNl4WHVN6jR8DOg9arxrXjvA+QZL1PaujhZZ2RqRQ+lYyHKq0rPAB/otPaaJnza4K19OxVdE9BTl7DrumFElQX2sk08yni84fT9SF9FYqPKnUlqQsM0QjbxpGjMC+cIHStdxlYZZmhHwwXk90iFLrfk9Lrle8Wn5JbMW5FCKUmTqxKZ07xBdx/EA==
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 18:25:31 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::69) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Sun,
 16 Feb 2025 18:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 18:25:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 10:25:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 10:25:20 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 16
 Feb 2025 10:25:16 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next v3 4/5] selftests: drv-net: Introduce a function that checks whether a port is available on remote host
Date: Sun, 16 Feb 2025 20:24:52 +0200
Message-ID: <20250216182453.226325-5-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250216182453.226325-1-gal@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ce8b42-1779-4038-b304-08dd4eb74bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/YW26nv5gm3425hhEvfKfkcBjg8pAz/GKGlA4b3FRj3ATUzQcvWSaMgYV89f?=
 =?us-ascii?Q?+EpFBsazCvNjAs10XHc+0mMqt/KfW8j68zcm+ZRGJA6C2OygtzMvpxq3rf1I?=
 =?us-ascii?Q?7W9A/RHbOMF5bEVAM6oW9ExpUJnX1/L1XeQPSdo/3mVt+dpmrGsvvZRZn9CS?=
 =?us-ascii?Q?LE2GHCYyxW+mOsIu8AinwtZxm9f41nLUnhHZZgMh1ZZOsV2v78aVhEF3h/s3?=
 =?us-ascii?Q?8oIYqK1r635L2wGhivQM9e8jIJ5hJML8pygwfp4Rvp6uJeQCJVsn103GCOKZ?=
 =?us-ascii?Q?7MhwDJQkpryHqd+N3cyrpLAnm3JTl6jAXZMAS9w4+cYAeEhLy7AY0W+T9JxD?=
 =?us-ascii?Q?juamh4yyS1ixIIvtnVfJnK1+l1FAWRRxMSAYWpwdDNN1tq3URYyHR6ZRebVF?=
 =?us-ascii?Q?r1mYfOTXqmLWHlCvoHJy+PZxYY6NflX5vaYm2nI63UywaG6/4LJAQmiD4sTV?=
 =?us-ascii?Q?Vgutav3DmlPXIaqcpSPeTzCLmVOOD+8ASP3MI5kG7at+CcYGiLUQzRmQgQGi?=
 =?us-ascii?Q?1xXetETBZP1TDepu3T/zw45Q4OMcI0a8FRapQ9ORLG2xmyGSd+I2zMRsArGu?=
 =?us-ascii?Q?NU19pQgU3567xCESfbDYHwwB5TWRuUshAIGOBhYCx1d64aOy+hKuNlts09M9?=
 =?us-ascii?Q?tRCMYz77J4VvFYtsxnKKa+cF5T9crb7Y2ZJgzsnTGqdp44ahj544e+YKVxm5?=
 =?us-ascii?Q?YhQ1K44cTYnab5+LiNkqloriAq8nUnnFgWUH05YZibWioiHwU2ireLjr6SmO?=
 =?us-ascii?Q?oR2/uYVKeW9YLaCt0i/abBWuWY10wbMb2pczgYXSzckcLnhFjUpbbwxAVosQ?=
 =?us-ascii?Q?BwV1iqGWZcKPlXigkTm6dZQI5GKT/ROsQ/hUf6BReYRDQy4FLe7wuKHE241F?=
 =?us-ascii?Q?kmopFG/wsulpMMn5oKLYhC2TNeFQAvyT9K187OzTcm9VHXTkPauRnVjKRd9g?=
 =?us-ascii?Q?fzJ3y/KQWxjSw6Rw4u4o31818oSxdU7wTty90yunVDSJ5LcK/72BZd+mrIqH?=
 =?us-ascii?Q?Bkmf2fpJxzwW/8KIZKnmQqp2xCG4RvE8YgMZ3oDcUeVig1/rolJMRxXd6Esp?=
 =?us-ascii?Q?WXI2Fgh8d98Kdn0avV4PcUzCb4NqQmuqdQ5bLvlkX3EP40TU8W26NhCSfp7y?=
 =?us-ascii?Q?5pJxE4VNPf9E8uvXKbkwR+C9HsjWMgUMjKMOJEWYV3Vdo5ZyFMEOo107INVz?=
 =?us-ascii?Q?RPavHEVlDOp4w+70BKw9NJZCcky9LCMo0pTilNp0e1e0GQ6L587Hy0FVkfCY?=
 =?us-ascii?Q?xHQY0bSr7S9ccCGy8Sfh89+67dbY1EwEUgVslro2u6eIZ3SYKkwICHvsUUpd?=
 =?us-ascii?Q?o6X8Y/lGpPEwfw0O/bctNaVcgSF1xJVkM1k1n7FXXUQnrYQDXBcqROpw4UNZ?=
 =?us-ascii?Q?pmlKv0+2VjRQkVOpel0Oj1R/yyX79vw89FyEDWXHdcyjhfRVW3gDjSXnME3/?=
 =?us-ascii?Q?EGFwIQNj7hgMtYgWPeNkE5koCvEZIEnoFmuCM1KMqgw0X9Gj9Z6mnJuQUXvF?=
 =?us-ascii?Q?p5lXZW8PP3eZa/4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 18:25:31.2856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ce8b42-1779-4038-b304-08dd4eb74bd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308

Add a function that checks whether a port is available on the remote
host, this will be used downstream to verify that ports that were
allocated locally are also available on the remote side.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 5a13f4fd3784..903cc042ed0e 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -123,6 +123,13 @@ def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
+def check_port_available_remote(port, host):
+    """
+    Check if a port is available on remote host.
+    Raise exception if not available.
+    """
+    cmd(f"python3 -c 'import socket; s=socket.socket(socket.AF_INET6, socket.SOCK_STREAM); s.bind((\"\", {port}))'", host=host)
+
 def rand_port():
     """
     Get a random unprivileged port.
-- 
2.40.1


