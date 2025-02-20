Return-Path: <netdev+bounces-168035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96294A3D2C7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D44417A42F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF71E9B0A;
	Thu, 20 Feb 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gy4J04gz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88B1BE238
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038807; cv=fail; b=hJI10fkNaxUaMgsNn8L+MlmOU6JCJbDcRroPGN8/Me5b/nZp1t5+o3XnUI9s6U6vk2psWSomxJPOhbQ8Z9ndURUPx00Ud2z8jwblAFcq0WJ29oua7JC7G6uXUDAmoTzTa13TfgNnk2aQvzrP2Wck5WqySvnoErET5M7XbgSc2F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038807; c=relaxed/simple;
	bh=9dfT21zMWg9IOkoTn3AfBp1WKKIZVHNhTuh+IEPXRWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXT3X39u3OYhLrqhYBHhgGOeWRlMdaELDyLsMjP9saaTpcruI6MOuXGBDSAMEP3A1VRVnyn8bANXN9XmhaKhvrWHTY1oHcFWGTpr+UayD9F9LKuQG3Trw08pt3kFi+w7c/zqBYH/bpYRr3YBjYp5LrFdHRddao/q+4aGoqrlXCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gy4J04gz; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MegNfVrQPfHgA3Wg9bMSbcnA5YUCYSsghz9vViEoUuMHBblDStJrsEVK/QFD6S5olGMKVwuPl15Da08vVdXyw0VcJecclBVmNIWgZOHPSovpys3YTh5vIYYSmZKxUTsa6lDZawWHCjvwoYKRr7jwspeb3N6Edz8VogKU+TAYWjmZ+gu0j0VbnpjCqiVhWEQ8JKX1fHcg/r3RRBXO2tP8G2snl0hDexcv/f9ehTvYrb9Snk+avy0xVDaoW4C56dMBUn/rIfBiadrnqQKw2KfgARlkPoyVU25Okfo2UUPOkqbDc3/8Ou6Kf0yVg30Ho0JdcgCIVvHFqRi0igHtGvTnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL5iGkFDQOC99TFm/usTFSbt/j+mCfNiDJrZBpF5OZQ=;
 b=dAtcwlMIck5V7qqYae+BQmjxWXeIBmLBHe55cCxnWFbOJhGkggxliaogNxrzqZyArmiwwMNxuz5isxood3+cWvuCrrVSvxbXy5EPWAeN/8pn32czs0b/J/BCF2CS6JBLtyoBH4Cjp/Eb17k2CeuC3R3rWGB3iFtR8ujRlN8SPhC8fsIrQ6XipNiK/1cA9KnKWJ1LztBx6FKWxiPa45TdvW6OkPsYke2L/2ct1FG2kwalKZHYFmDL7teIBT5+7MOjncxnXeGHmTnWPGWJjZB4F9hA62khfYmD6b5khF8OBDUuojZgnORo005jlyCdTfRuiu8zt3OwoGXWcIH0T2O6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL5iGkFDQOC99TFm/usTFSbt/j+mCfNiDJrZBpF5OZQ=;
 b=Gy4J04gzv1vQouPXj3NP8VCZBVnVxU6mahN5iuGfvkqPjSBWA+dRXmcyZ4a02K32rnxBwYHKC2O96fBGp4ITikP4iwUemS9LTM+2/QgUfmN5c2v71RpUoGP+tKxGdbSiHSQZCzUc8uQQX8NneAEl8b1hzwWsHiwxn0ODzi6nsRHBKj1TqvV7ACQN+/XuwZRFp2SDxVw3JRbdydf4FfECFs7HE20R5I0TZuJ5BnTenIrIe4F2unHNcJLvdPmPPO1vn0ptXa02wQRgHV4F5/ygk3CQjiViNDZIoBC4fjSJInQ5Gtu4HjpVnO8LyStIYj1jliZ3mbSuARuQbNPBCrpdsQ==
Received: from SN1PR12CA0089.namprd12.prod.outlook.com (2603:10b6:802:21::24)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 08:06:41 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::a6) by SN1PR12CA0089.outlook.office365.com
 (2603:10b6:802:21::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 08:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:06:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:30 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:27 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 1/6] net: fib_rules: Add DSCP mask attribute
Date: Thu, 20 Feb 2025 10:05:20 +0200
Message-ID: <20250220080525.831924-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220080525.831924-1-idosch@nvidia.com>
References: <20250220080525.831924-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0d8540-5c19-4758-9733-08dd51858276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dl55UO+/cmjNWN0ny/TnN7NlqjMwjn+wyY42P53KdORU7O3Bro+29Y01E/04?=
 =?us-ascii?Q?ckkVTIgcnuBP4kaW6okCkHcCRGsbm2nohhTIOaHxFbYBUkQfKNsS50+tJqcl?=
 =?us-ascii?Q?A+7ORmIbUPXUVcweiSUpDAuZsEmBj15Lhvnz2xYfIBZK5L5UmJ3dkydnCvPu?=
 =?us-ascii?Q?a3CkXBZHEfrbpZ+EvoRySGMuZiCy8Q2aN+/J0aBrdZtI5sgMeUnv+s47a/Ke?=
 =?us-ascii?Q?bTPfpmKJ+p9HUL14/fuuHN9h0Omcpf+24CviBnKDBh8+2cUBpUeCRsSMCYPH?=
 =?us-ascii?Q?I6sjyLYIHDRSR/WFu/1dGjD+uaomeJdwDI1jSjpAaFw2IoZL+uCySZ2wnQKV?=
 =?us-ascii?Q?BV+Yv9SOFKlNKCG+8lGM5RQ8AAKfSZvTI86Kg1PD10cJ58gELkgqsOwme806?=
 =?us-ascii?Q?IG8lLoJvo0uk7GO9OzLGF2ZXtRHHdGYuLvCL2Dxg3tZOVGF2FCK5F1BNmi2w?=
 =?us-ascii?Q?hHTG15F4d9xG0GMDcm9YjftSrPh7UWZ970m/lYZqPCV5RFerTFlbjVLCSMsA?=
 =?us-ascii?Q?XehB/nMmmQQ5eNkQDgvFvWtnrDrGgIAk/ZUlL0gQRJ5wnHAtUzkG6GHTFcvP?=
 =?us-ascii?Q?nMdNkqzWOVgXh3MfdFPuMWbcQSCrEQpjUxoYWKnwUeo3YCKBuse+u8xosbEh?=
 =?us-ascii?Q?JsYz+/TB260RORCl8nu+6KPOaUdK/qOdIAjf63md18NcZxxUAmsgQOtwvac9?=
 =?us-ascii?Q?BW43ZqPicAj0giPUec6LdGZAqC20tFmFIe1WimJfthy74FxzyqZVRMc1AsLi?=
 =?us-ascii?Q?JNDGmzQDyvznUBeWauvGGJmYY1UvepUAEgZE2rcs5A1Vlm3YaWElZaYTEhZn?=
 =?us-ascii?Q?p+Sm718zuUW9QAxn6hNDZ111bjYKavPcd/EmvJYnYKP29HR+ZDWYLrykHrDF?=
 =?us-ascii?Q?jLp3nDAymxeNXLNBRIh1Toqhl74OY7GTxCYarigmalpNFrSxJVl15kW/AoJX?=
 =?us-ascii?Q?u/2pnXfPvC/4hojVddlUszg16TDaDCJkvAeUmhyt5sBT++PqcWYlaPN2w/Ew?=
 =?us-ascii?Q?77z9VcO/9MCn2V8D4E5C+7zro9y3UhZFdnMmiC57yIz9NZuV67Gu6/SK7fuL?=
 =?us-ascii?Q?U+pFQKzp9MMEvUxsblw/8OcdX6fERJ4kIpKEkJoMMQ6VPGsvTY1AFch1ttRY?=
 =?us-ascii?Q?sFkj/fmxD0O19aE4VaJji/41w80VQf3BIKD82EVpUY1ebTfzLchpTsD7nmRx?=
 =?us-ascii?Q?zwCRTuePdqD6H5dbSsK6a0EzAZprXS0/qfxV0NQz64RyQnhaCMB7fUiGcS8J?=
 =?us-ascii?Q?iNIcgBt38M1k0My5VUBKO7aSC5bLpFOrdbEjMZb22qWQa9r7mXESRihhP9hD?=
 =?us-ascii?Q?dhWg1DX4kTBfAggGQ7V4I8k/LjIyPpwZcNzWJklTFkDYSv8XxfmEff6bPB8Y?=
 =?us-ascii?Q?taQr22cd2R29PNEU5LOeuuluRA6raC1YsvuhIYBM/0f/HKPhmT2ulL59Mm8j?=
 =?us-ascii?Q?ZoNGU9krmR4VKNiWG24wxpsr/9+kyCQr6alLtdfQkzoevg5mhRF7AcqPRq1d?=
 =?us-ascii?Q?T9xFMWeJ6qVKWTo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:06:41.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0d8540-5c19-4758-9733-08dd51858276
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

Add an attribute that allows matching on DSCP with a mask. Matching on
DSCP with a mask is needed in deployments where users encode path
information into certain bits of the DSCP field.

Temporarily set the type of the attribute to 'NLA_REJECT' while support
is being added.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 1 +
 net/core/fib_rules.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index 95ec01b15c65..2df6e4035d50 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -72,6 +72,7 @@ enum {
 	FRA_FLOWLABEL_MASK,	/* flowlabel mask */
 	FRA_SPORT_MASK,	/* sport mask */
 	FRA_DPORT_MASK,	/* dport mask */
+	FRA_DSCP_MASK,	/* dscp mask */
 	__FRA_MAX
 };
 
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 5ddd34cbe7f6..00e6fe79ecba 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -845,6 +845,7 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
 	[FRA_SPORT_MASK] = { .type = NLA_U16 },
 	[FRA_DPORT_MASK] = { .type = NLA_U16 },
+	[FRA_DSCP_MASK] = { .type = NLA_REJECT },
 };
 
 int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.48.1


