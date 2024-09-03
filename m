Return-Path: <netdev+bounces-124549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00E969F7B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB88AB24489
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07E47F4D;
	Tue,  3 Sep 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntdurU7J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5014778C
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371666; cv=fail; b=IoQTbWTK51QAPP5Y9ahbrG9O00ACovGIACkbApr7XzzQmXJvrp9Ix5A9shEdSF/252L9XQfsubOjecVkJznYbUR2xYUTri6hQs2ZQKRY2XOp7PlH53stFRuLknPY3ZFiF6GZIKwwR9kZbL5TqIjNeU9Y/gJx1rpYl1rTEyAfLgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371666; c=relaxed/simple;
	bh=RbvgjutYh+ZdlQCU8nro1WhJh3p0J310sXjDAOGOm78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4cOPm7B1PrnvfcWSnKEp+D0Hucm0j2XGXzOtx0EwWLESfXBjEJeOt1EWrX5fSRU+Bcdb8fnSWPuaacXHKZ0LuJhN1Wc1c2WEU5XXASsrEyosfNAQovl0uJPJZCdK5CgqD0LDTARy0xwCARA7V6nzQTowbVu3fo+qMYn3ZJas3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntdurU7J; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqi/4QaOpqHOw2HKBZLUUrG4gHAvOtS0FtaLPHT3J6e7nNW8+1mEOGiihEbzmCQCKNvr92Ww8r305iBfH7RLXXiu3dgaW34fdjYCqNXKK5UQOnIgj2yt9mhulBJpDSjK3uddjvNLI2wvSCmUwLWdVhWCxPE231COFVgcLXWDbVCHY5Kk4IhU/WYGqhSSayTYsxAPqsvzT0fdyzq0d6GfEp3IYSACrXzBioNPHvNirL69wPmwEkYwhKviyApoFt7DVdd6ednCluxN9E1AHB1nxRoUfDMr6AIQImK3+KFgO4Bce7T0zFSXjEFN21D0QmWRKIiuup8yEvQ5wwa5GgPTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EkoiU4jZm7x7Gxu311FrQRmI0Nt51P4Bp8bPsbrof8=;
 b=Q09MnkrPxHi0BIVZkpb7EuvW+o3sMma5PPGU7xYN8nY8UeLj3SMGDKjJhbgAqiW6XGUkmJxjx2tqLS4tjf7Q8veCdLS0YDDDxb1hrPRVyraFZNW+UBUNQLa+/cu7nKsxHS+Cng9gNrCZa62vkAAZ5I8xpy2XPVQ85xWx80KasG1TJmaGCD1LrKnBNdRyVxVuTB3Sgv/WsLcRjhzeHYBvYUUKK2oJ7Aob+k57rYtHqWBGDPbXc+voY7R0lLwVNceSpgLyklYPHQhyN/ROIXGJxuKYQsq0SM1jDsXI4WGn3WZby6C9vq4kDQABnQRGq3buZMyE+gLuE0w5v2jLxeev0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EkoiU4jZm7x7Gxu311FrQRmI0Nt51P4Bp8bPsbrof8=;
 b=ntdurU7Jq6TYRgMmpwpayROTE/7Rk4v4GDKHBJPqhyoisWPiHHf2TEPl8C/KX5jxiroFL3FQ9tO0oyoxLaGVnBkwasSg1MbruvJubg6VJ/2btpYoC77k4MOn0O4EVs9r8XPCrsqHgFMp5mvmyxqy/aGKWq5XfuM0dWjDmYHrqmjdW3g51SjKlYHIwDZtPeTR2qwBWynsr67rZRCJMXzQgR8eWNGCjhgla/yeIFUWBUIJJv/9CeVfX2w+Uh3v6Qc7dt/fXE89t3i8Vcj/T3F+IHeZyQXP+kkyQasPLmLTyNk4hPWyiH2AJvxN31QXP2JAC+gF11S6r59Yuci9TA0kTg==
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:54:20 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::e6) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 13:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 13:54:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:09 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:04 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 1/4] ipv4: Unmask upper DSCP bits in __ip_queue_xmit()
Date: Tue, 3 Sep 2024 16:53:24 +0300
Message-ID: <20240903135327.2810535-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903135327.2810535-1-idosch@nvidia.com>
References: <20240903135327.2810535-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: be0bde55-2098-496d-9b5b-08dccc1fe8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8h+nv1V4qkbqWpJXE9WiTxC3cMXgRuVUNZmuVd+DCTMksz9UV0FpeyTaHe+?=
 =?us-ascii?Q?cyiUONDEBki8DIgkWyEXAUYZAaTzSGboGU9ONP4EjxT304oX0iSwF9TxbTjD?=
 =?us-ascii?Q?sSEaRgWhrssmp6Qxxz0G7HK/UngD3wmKMEnsJlzRQ/HR1dsIRQNZXKVa1A3t?=
 =?us-ascii?Q?k+ngUA5V98UOEgJxN1RQ+9Zq9+AVoz92rUd9ryES2L1iFuMjphmkReg8XduV?=
 =?us-ascii?Q?+VmnhRPghDJ6T08Se0SF4VACMjFeEqHwA+qxvHfaVqGyOSvzBoXcvdat91Yt?=
 =?us-ascii?Q?TljKTg2od28Q6tIYs0jgkZCTxAhHVjJj/atq8gfAtAKaW61r0FQm9+b/34rK?=
 =?us-ascii?Q?W/Avdbo3Vy/JcM3JuGQeYNiCiCczelajLDYLs4Tdl1KFr54xucqyvwmskTaL?=
 =?us-ascii?Q?Go1MJ6zsyOqVldRjir4rtcXbADGjLSmxgCnF9NrHg3A2paK5Tm35rOwlvzkL?=
 =?us-ascii?Q?bvcfZdgR9YNy0nQWEiPqvOdnvsPvRxumlgznmil1f6rEXe4JbLT2T1nwxAfQ?=
 =?us-ascii?Q?zr/DtzcPPhRbBJ2RncBb09t54CTJGW2k5JvfRfHqFDzHl1Tmnxxi4X+MBxx8?=
 =?us-ascii?Q?PzQ+JW/rXq7qsSh9pw3WLhhAYtWUP7443S1ZhEF/i/BOqZAZxN6BGGAYoTjB?=
 =?us-ascii?Q?7hbFzEaSW6OUa4u/IrxlbtCtpHCZlPQSZf+yOtBbWbgfFT9NRd0uSq7jIB99?=
 =?us-ascii?Q?P9hRnyKntmqBO7TjsGS3LgASHBwOiL/h9gKv6FN5SQi77GziSlxVCI6ruuvs?=
 =?us-ascii?Q?w26x0/zKXigos/o03rgTPJjBMr/riIyLBHV2reZiK3zzBIL3+yuD5eSytL5p?=
 =?us-ascii?Q?oqa7Jv6XDRQEh0/CwfUOa9AnQX+IIC0ymJEUrsbhAJTuIl/vju2bexT6WcHj?=
 =?us-ascii?Q?iwG/i6uTK0J14dhWqO7FU8c8FJu0RtjaGWtXFjFrsR8vXz7iqS8BtfsNc991?=
 =?us-ascii?Q?EUEfHAqPWiRhSAoWzYaCroCrJJzlws3HLpr9kFEjZCfJVucFEezTf4EBJyvI?=
 =?us-ascii?Q?dKU4q7rLB5HIetJF+aXEJBAv4ePbeDcf8bJXtAuthCybt3WvUL6ulhtbvjGg?=
 =?us-ascii?Q?tU9UhCWctJSDFrQ7JT4U+TpqU44tFQH0ntA7cod+QxZ/rxJ8v7BiBnTs55In?=
 =?us-ascii?Q?9WvnykX0OFMlF7fmsRpsvNmzznxzTkdhAkrwx75UhaMCwKcs1NXqVDRQ6Ww4?=
 =?us-ascii?Q?pIdwTaV3zQQnHWXUQXMT55OLdLm0Rv44N3aVI6gUGgP2WzEmpDOBq7yglT2l?=
 =?us-ascii?Q?pHImSFZ5WNhS5yiMxNFk7dVvcMUM2QiMYs1j3g08d6BXNm/W2ReiXG9q6Ss1?=
 =?us-ascii?Q?Ka4Hh3btXIzd34by0Kkeo80SGVqtXRGLsDyOzSfvriErNprIx/SUxa6W6twV?=
 =?us-ascii?Q?QVa/NkGXenQFAQZQWuZLm8TJFWqo7MOjYGkxzcXs0HPcYxANa2IOaPNYnxwD?=
 =?us-ascii?Q?qYBNcx5rUkg7ELLx7E3mlWKoy6A2Hf2h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:54:20.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0bde55-2098-496d-9b5b-08dccc1fe8e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

The function is passed the full DS field in its 'tos' argument by its
two callers. It then masks the upper DSCP bits using RT_TOS() when
passing it to ip_route_output_ports().

Unmask the upper DSCP bits when passing 'tos' to ip_route_output_ports()
so that in the future it could perform the FIB lookup according to the
full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index eea443b7f65e..49811c9281d4 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -494,7 +494,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 					   inet->inet_dport,
 					   inet->inet_sport,
 					   sk->sk_protocol,
-					   RT_TOS(tos),
+					   tos & INET_DSCP_MASK,
 					   sk->sk_bound_dev_if);
 		if (IS_ERR(rt))
 			goto no_route;
-- 
2.46.0


