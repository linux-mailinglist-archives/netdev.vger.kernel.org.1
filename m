Return-Path: <netdev+bounces-121344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BC95CD81
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E9C1F23AA1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD70185B43;
	Fri, 23 Aug 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AI+nVep+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7C149C46
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418859; cv=fail; b=O73mMpOv2ahARjo1Md0GvqErTChGMAPA1NTeyV9jptUOG9XiuLW1oCmhPlp2ole1NoowFcMbfLNaDP0fXtFuxbCGzIwnBXsoMEfzcQ1IMSfmSU7mXBMoW7LxpTJCsoWDv2OUgEtvkT6jQjv5YTUJV+Kcx2J2RKL/PmN2yVWHrCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418859; c=relaxed/simple;
	bh=tbaJYPV7I5FpT/w/6+DBEW1TzyG71/apMzO8LqYRMTo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oaBQ/hNZ2iv47WNd8Bbg49BBru81iJ/I1xgB94gVER659SPn4dd3xS7SZf6zxCQJ5O6in2qeWnd7KufIR7wtZU1LBsObRQ2OV1cTx4lz7/ME6rIQHhfuk1egInDfXy4hUetcocJYTtjY/2T9dTmF4kDw5PwjUzwxIJYXGzQUm2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AI+nVep+; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaWOR7sBYSEgFa6XbPP+v5g4FgIo4BZdcyrUzx5+J+3tM8MWrK+OF/jnN+RU8RL2/hWUFd1LZ2K70+/H4NBwuh/dUPnmMJMxNM5PyhElxiXMStNsvl3zyTV7wexOFx1PQd6FcjseGNygjznAiz0XdWnZIwbd+EcKbuaaYcZuusLokUFlBGCmkhPg+NsnXAQMBzuTakzD4KwNcd1JBWLyDaSPt2LeK3lV0x1TI/D/L6PRLHVrDQ8ChuGBilqC2D/fl0JXp6Q9Rbfr+4xsVIbVe2wHlxuwOUlQ2Wm1WSxsg7TPVUTRLrn5pSY+GmcaVeqRAm3UKfxENSl8shZxGhDUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbaJYPV7I5FpT/w/6+DBEW1TzyG71/apMzO8LqYRMTo=;
 b=GJJM2CFhJRImPeuJ7agCPgf/TZDPsS8gxcQAPDfp4FJr2PNIALMg9rnFuPX/ZHH05zhtQCIq5ZouVapT5EQN18Q834E98vpwLXfrfZqb9bTGEaF7CPiPFJisjikqO9fHAlG4iXQpQUS9A/KHe171pxl48KfBsw6ejgZtMLcPkyoj/U151pkmTh4SiHWFyuxnHI+6IvQxzUDDRJOHyoBUelCnNKIjdSBKFidSPNt80wy3AZ2Ny529teT7ZuqWdokNoH8ocgVxL7W7hGapm2J1+luKsgTRBHh9qGZknyKfZ3f4yH/j6C4r1KNW05FS1VI9GCscKbMuJsjMieLn18IJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbaJYPV7I5FpT/w/6+DBEW1TzyG71/apMzO8LqYRMTo=;
 b=AI+nVep+3q11VkdmqkGtuaX91uuX3jow3xSdsIx5oLtcsb6mczmIBRLKtkoVYbNTfB34ccxXGmyzWdewVIDN8WqMFIEWEzFdz5HWRQnrcSZJouSR7pDQUTo6rsN8Au9DnTcuBYhfQYtRZDKgQmZn6uxFCngR2THauqqkZ5Z/TWulailqJQ3xCQ23tkVJOSQQ6HTTltXwcf1KUprVHvE10zH04t3zYq6+xbazutXEGjNUoDxIepe/7mYBo6SsAfBrk2ub/Gec2KEWlDdnLxIc2uapNEC6FFEqGVY+gdie9fjX5eM9TzKEGamRYMhJI1ZCtuygXBGR/UH2tQ0PAkbO4g==
Received: from PH7P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 13:14:14 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::2c) by PH7P220CA0032.outlook.office365.com
 (2603:10b6:510:32b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 23 Aug 2024 13:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:14:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:01 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:13:54 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-3-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 02/10] fib: rules: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:13:42 +0200
In-Reply-To: <20240822043252.3488749-3-lizetao1@huawei.com>
Message-ID: <871q2fl6uo.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edc724a-8550-4c74-1ac4-08dcc3757c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mx30AMrPJkcEniZkQZ0BgEWsEmZmqhehFKPqiZ3t0dt0/8EJmSCNrC4SrXCy?=
 =?us-ascii?Q?scDRR7T/Jg3t0cWmoYbbPBgQghjcJhkz4H9xyNaJLhZfIwVtWL3NLmYMMbuY?=
 =?us-ascii?Q?G2fEbGtx3TNHwlWwJYGz2QTDzQvnJFQTUnXxhbjZIdzSI1ex/1C9V8Ij1+G1?=
 =?us-ascii?Q?SqeANs21FHkdiKpOZjZSM36S55LORw+un32GfHPnFs7MNkayvz1PGvHksutG?=
 =?us-ascii?Q?fmJNtxMLVjJHCKRT+Ws+n9Pkb3eeQXFs2I/4+vG4xIOQ7Wjo/85sH4FKErYR?=
 =?us-ascii?Q?APp96cMVuTaFNb5i18J/+FlnJSgxPDPzUQoU4eH0VyoE3k8UScM4d9sTGNlu?=
 =?us-ascii?Q?KhCWsT/RmEVMh0Un25AJDWSJGQ5vYDVcyad5PpeVcFMeEU70W9Zx1eGW7DTc?=
 =?us-ascii?Q?A9Jx/aylnZO+XGSBCrErsllsqu471666+VRTWNZ11Jiliq55dSsBpzFwyEnI?=
 =?us-ascii?Q?BYWJ7xO99b7BxahcDR0V/7YCcxvOHRroy9gBCogKukiAZF9l3/qy7YHdwXL7?=
 =?us-ascii?Q?bqQFVFCzQl7GfIEdPp8+q2fY1Amn1kz53Y6oUlN1NHv7BopdDK4KppucFrRo?=
 =?us-ascii?Q?VKTNYEYhVlwKc2bnFIWxwpnOT9KSnVMnxhy80Pkt3FAuXefx111Kh8BTAjWT?=
 =?us-ascii?Q?sEbX622HRrGbET+r2DO/lOWhd062IcAL99w4GUAlvLflLxAhpKNKCvov9mLH?=
 =?us-ascii?Q?5XfqtM6KCkxARycFeybZcDhq8Z8wfXEovi7P4QpHyP44XnpMP5EtfT/DY1kE?=
 =?us-ascii?Q?U4yHDN0sYj9iL+wjzX9g0eiYh5vhQjF3myTPB3sQn9hPEqat0mbUfpn+8LOK?=
 =?us-ascii?Q?wmhxqEC6At14HhAyGRf9GFEtnopGJeGJg+1VY0qGPCpgEhgyu6H1Iuz2TZWT?=
 =?us-ascii?Q?LzyFtkxmbls/CfRPtDcrRhowKqjpmQpncZSWk4QoFYuGfrBJs05IqKAVfRPr?=
 =?us-ascii?Q?gWUWLKYMyZ0bSCc/4MCgBeeid6ZS1E5oGp8Vv9dpfKtqoIhtfMYRqsldgnIU?=
 =?us-ascii?Q?AQMgs5OGKsH0MiVTwb+uofFfc9qal3xk6KjKFhhinHOsbmw9c0bD4Kr6JAlW?=
 =?us-ascii?Q?JSvdY9jLCDI62mmBCaOs1hP/1SdSYxdVHICmjGIPHq825oHZv/UJSQ6nzoSX?=
 =?us-ascii?Q?gRG8BWMoQDRMLauFPXQf5lKA8EWCMz5bnqrAiykMUBmt6eGS7hu3F5CFZMxq?=
 =?us-ascii?Q?21HH5TwM+L/XSolnXB1UGRPrh+Mv0nTRrOvAxCqPOpd/G6JJ11JKu4DRBb81?=
 =?us-ascii?Q?gRXGyRwwo7Ymbq/K+FYdtq8NiKccR/qbe8kQliarS6+MGAMC9p/7QHa16eGB?=
 =?us-ascii?Q?LpyQu7GFtEio/kn5V3NdYuLjnnR/tVt5c0tdqwcrTJhPpbFVG1aR0vaZIRjF?=
 =?us-ascii?Q?SiRTqf6whyRk88OZ96jABcB+a29labJh1hKyIgCFZtBckhuJJl2AkMVmHiP3?=
 =?us-ascii?Q?EQzIceNSWDphMADqaVUW9cn0CIloKGZi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:14:13.9349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edc724a-8550-4c74-1ac4-08dcc3757c1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOMEM, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

