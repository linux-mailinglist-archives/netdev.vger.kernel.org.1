Return-Path: <netdev+bounces-152323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C534A9F3721
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CD016D0EF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B0205AC6;
	Mon, 16 Dec 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cL30Ocwf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D91FF7D4
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369185; cv=fail; b=TiJrORzXcdLATw6LapTVgX5qjgr8KNJZ8Sd6CTML3DQylmRQyxLOYr26t3RJzMRtGNVnO5PVjBXXdLK6VM8NM9vDewa30xy2BO9bV5omHuK5/2d0aHUuDykTlHIGIcL5GRsWbioXa4YWLmQ2Is1rFhsda6z7jzN9c/gKiSkjg7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369185; c=relaxed/simple;
	bh=EMbycHs3YJ01wGP2xUHVFK727aPkEnVYKJX3N9EXeQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfXBPp6SFkgWQfuD9eXqqY3qQSOMFDh2jqTLu13UqtxA3WMtuDj8NbTh7RZZUCShGswo4EBAlsQmJo6uXuSJe2kUm5WHObYCYBYkxDhrWhPLf7dtaXN8Ri+VQH5B//YGGg3LPAoJNjOtlUAD/hbja3PPy74Ygf1H6KWenb2tkmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cL30Ocwf; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agci4OiVuDk2upSdivSDR2Do7Tc142f7YYbiNlvQiAN+WRNeozlUGQy4eUIIV3bCbYmMVajSxUtNVQrrtx3n1AgY/9KCaQ4Mn0a0VNgLCSucEQBPWmOe3aYInLAQIXNnwqWjqXqf1ynf6A2Rn3JrDmXmCBQa0nszQE/aquWk5KKxG8kUwuIg98UHJUa7Ha3WgV7NtYgL+hINsCjFF41N91KTYdVDBe1QFvcBjbjzjawEx4F5FS/tKmjP9BR+wZS0sazQ9O0U81lESK9BBErPWBg6JuxuETUsDKzpKmUc/tXvwJhYPvK+Ue6rKg2z7SvJax+kuzUXXOukrkxPrpl8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czbhTkznWvnVw1LK3jO1WKJSL61usp12oSkYpzaO0wo=;
 b=nOqUStZTI1mrHgnhuaNNoAEFSVdybajve/0K+LrTa/qHJvdaIY2t1qKxS355eGTY91Wea6qZH5qhdfVq/1Qc63VR3mzVdcrPEDkAUykc3qIrl5yOkeQayiypgZkE3xzkSbN4MmqzbX5yGjo5shNX17fK3ct5T+V94zKQ8zoZ/I85H69SxX2JFhY1CwXj0Zd+B7capRYRLjFRTdHrObMjZ19FJp9/OCDwtTqcIvqceyPZte3xBt4oxbncQhHbfMLL+KeyLWlTzkMsya/qMhVOHibyo9h9pjINpd7EHvAmW+LgHFMWfmXgHjdSOdYp1atmPAT/zJ69NIdCSK4yl2QdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czbhTkznWvnVw1LK3jO1WKJSL61usp12oSkYpzaO0wo=;
 b=cL30Ocwf7u8Nj6ILct0PgV8pZR0ujDf3n1ctMt0uk8uVlYg3VgV6egcC2DWsLDswo9kC0Sfo9YoBIixlxM5PRF9RatmdPUrx9KrlyIIFwNDD+lbF9ZfbW5N+DxhWFNWfd9Mxl24z3QcT+6RHI4ZN+3/yWeac3IpIXoLRQEk6jsHfgATRqg8Cb5OOdBU7FLVqAATpOzCGn2ksDKnWvoazJXR/Pc/aLKxSwMqd30Ub8Tf57QwYjdhsyglnxDrDE/j00QnYftFOVaeGG3ZEtg8Lim6KbDNB7wit7hLIMCegXzqitzagcU6trWQiEz+/vjDTsE09iTN/UInjpdcQPSj47w==
Received: from SJ0PR13CA0084.namprd13.prod.outlook.com (2603:10b6:a03:2c4::29)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 17:13:00 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::63) by SJ0PR13CA0084.outlook.office365.com
 (2603:10b6:a03:2c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.9 via Frontend Transport; Mon,
 16 Dec 2024 17:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 17:13:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:46 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:43 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/9] ipv4: fib_rules: Reject flow label attributes
Date: Mon, 16 Dec 2024 19:11:54 +0200
Message-ID: <20241216171201.274644-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5d9511-ede7-4936-9b6c-08dd1df4e4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7FYVYoFPZF3nMQgyJhG0h6DbfAgzv/kBqWEzpeUp/L3/rCpYdKWk5R1QwJ0M?=
 =?us-ascii?Q?a82wBE5lbhc3mLwz4UwqY/Xl7lkuI+gRrdYjjoJ98MU07WQN/c70QJuqgF9o?=
 =?us-ascii?Q?7RA4R4iBmYe6Q/jlJh6kD9l0m95YzI+3yi1Cq/e5P1lhmRCFjJtSkatku6VZ?=
 =?us-ascii?Q?guEf/R7wqj//vgOhNWDSHUnb8Xy1pI7O/0cbN5JjAQ6MIa45tjLtFdTJcFn0?=
 =?us-ascii?Q?B+9MGrGKEiX90z+zqTUfbxKR7a+CJtqy+9uyRwtTuaMa5BKbCels5hg5fULl?=
 =?us-ascii?Q?n4NV7QgT3BX6WofDinYKHnlt5nAKpQm1Kj3DsCnQt3sd0YjAqGBsBJzxzhG2?=
 =?us-ascii?Q?or9WqI72Kc2p92nTqxGfVxGCIcKMIPFEpQi3Lf4/Y/YXTE+LlRIY+jY4lVEK?=
 =?us-ascii?Q?jHZXgeZFhIcgNKq+oOKYsUevBeaLreDuNTg6HcGZC93GbUN7jg6lYuzHdPXo?=
 =?us-ascii?Q?Ws/Rk3UkuO7XO3f49Igc5CqR6i8BTVRKNqXieB+lip6GnDLL7Yfsjc60NMLt?=
 =?us-ascii?Q?xHYqGiPRZ8oi40UPEaGPjwG4FH3YRZLHCD2XPMbL2EDE+itIzJZTsfhj7MCa?=
 =?us-ascii?Q?BhnXYjveIneJc+IRtwnSE7MoQ/XeU4KMM3CtV2SDcQRHV9tWK1B2/P3NW7My?=
 =?us-ascii?Q?ABPzxJ+79Ft6RT7Umqzl85f8NrH+yBpoO4Y72emEYgaverzDRLOhtP9R6Wnt?=
 =?us-ascii?Q?NHvfb81ajipFpXAsN29OZJ3/UHZT7ATeOZzWVKsGHglxxcBS+u43BHGob7bx?=
 =?us-ascii?Q?IQSFBMUxXWh6byr1WQTm0a3wUJtmvVA2EtML/CIQyU0xX/Gb6sLWsZ6L2uv+?=
 =?us-ascii?Q?owKBhVzyj1dibQ3tH1QkgNsA64QOhlFcDkvphZJ9Onaa7+vx6mfDywP/Pf4m?=
 =?us-ascii?Q?iSxkx870S9YLPKFL11Gch0U2/uiRpINeXAbh4a3xea3V3+CbvTdF4B/LJ06Y?=
 =?us-ascii?Q?V3i8Igg+QQpkt0Q5+osAmphcNbxPYexn8mnqW5MQOd+TPVxhap4xdJ6SDZVu?=
 =?us-ascii?Q?5DrvCYVM3fMFnswV+B2HYPZ2IgU+1xSH0tv3fvS1hogoyI+n3oYO3HkePxow?=
 =?us-ascii?Q?zPOBNcLY58+ZmfSTOe0CvGbwixJ/OfSBPOsKtd6UV9bNMPiAvrSK41dx9DxJ?=
 =?us-ascii?Q?7SIHZ/fj8r7SGuqAKtp7NvVRp2clYBfSVb71gifZ2mlZUS+c8N3JZSuimEpb?=
 =?us-ascii?Q?NLDRvwwgDtAd9mem1oDKqLgqtS80tR/HP1oWBBpw3HbrwcnIA/kMqU1x92Oe?=
 =?us-ascii?Q?dPukHCiQM+CO1qdb6Ffey+eehSgQ1pxLyibsExFZqIkBrmJum3Z+rbiLBkNo?=
 =?us-ascii?Q?XRqMiyzN6GFINZOBF5xPCObzgCcTH8Z6rHWhH6zknaxvcsxfEZf6j1HF+Csg?=
 =?us-ascii?Q?npawJ9rJBsTh0xtgHoInlVPBvqQ1LuBlF6HaSyPYS5D7joHHI1dkdSIoGGn5?=
 =?us-ascii?Q?i709vRQU7k5dwbxCD8A64KvzJwXnmEyHaAs0ee1bIM8CTfQ1s3xbCH/a2pt0?=
 =?us-ascii?Q?shIEkADsCRHXSEs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:00.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d9511-ede7-4936-9b6c-08dd1df4e4b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

IPv4 FIB rules cannot match on flow label so reject requests that try to
add such rules. Do that in the IPv4 configure callback as the netlink
policy resides in the core and used by both IPv4 and IPv6.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_rules.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 8325224ef072..9517b8667e00 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -249,6 +249,12 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	int err = -EINVAL;
 	struct fib4_rule *rule4 = (struct fib4_rule *) rule;
 
+	if (tb[FRA_FLOWLABEL] || tb[FRA_FLOWLABEL_MASK]) {
+		NL_SET_ERR_MSG(extack,
+			       "Flow label cannot be specified for IPv4 FIB rules");
+		goto errout;
+	}
+
 	if (!inet_validate_dscp(frh->tos)) {
 		NL_SET_ERR_MSG(extack,
 			       "Invalid dsfield (tos): ECN bits must be 0");
-- 
2.47.1


