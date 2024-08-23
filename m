Return-Path: <netdev+bounces-121353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE32D95CDB3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E24286560
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079A18660D;
	Fri, 23 Aug 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IhvcI567"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5518562A
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419360; cv=fail; b=FWO2XZswievHyJCit+L4PgdW9IQzFwHrSNBSHSBM5hv38CfYQtXKHgJyXxEKXJqYedowpN1X5ePlo4V0qqR3Br3mBP55rCSap/Thz8FhQsSv2NqsTAUqZgwD0fL/Rtuf64yPcsM//whUxhFhMIRCEW4o6Fy2R6OwSjFByXEXLls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419360; c=relaxed/simple;
	bh=9tjonQpnue4cWGPQlnfneyKU+fxrDf5W2h+fRIx5AyY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o+NMIMs1uINlvcB1g3QtVjvEbUrjgAPqrepHtbmXb+gbb2iSnnBK8+M4MvX07fRIzCvXZDD6Me7f8OBzv6+w8RiY90EeO3lutkVCS7v7MHKWZaMpKeVNlhpx7N2ixvD3N4F7F4+arYpKvqW2dMy0CcEkEL433gqLJqSoRshNk5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IhvcI567; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCL9WyLcADKC8D39fjVhY6H7ZXpsUQqXfL0q+Bg2AeSFhc6XKp3RHo2fjuf3pYn3ZYeigsM19S+9lUEmhNz9R17dQrBFCi+mZI9EkCLAX2DvqkRT7L9Yv84liblxxFKuiFwqWJj0ZOMK6XCpCRNDxlhaCGciCJWMwfLXV0fRuFKx6QjQ8yeZ5h1EQJLlI8bjBrpa0/gWg9on7SLxeT1376SDOrYKy6dbmACOpUgpQ+GaoDgnZsruIGJBR62mV5IN65BU7PLtxPZtQNEQs+9Qbi+my1U8Uq9ntirrb+e7x41cGINoNrIntCej6Mw7NEz0hmdH8pB9t8OvwJ25Fn78nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tjonQpnue4cWGPQlnfneyKU+fxrDf5W2h+fRIx5AyY=;
 b=sWv1Hg+FAFvTjoDrhJElpOSbOjUB75dgq96H6LkHJeGtn91UKLs/PQ1Tctiwu+5Ns7VvbyKbWM9I4fy2qnCHPICyy2Kx/f4G5+esn+vehbiPFJrE0jreYy0NRiNFQT0ETlrabAz7hTMmgRWXV3Jrd+3lJ/knSqbISAdlTodYpw1Frov+ShRHGiQfZe68qY1/DgUkN4w/9E3X0vFKcL0w60hhH1tG9DvPRMbHWh3I9+d5ZncX/lvI9L5vpBVh94st3cAfDFvJL8czFwhl+rHqhQYKuIIziO4PHxbXtdPxQELMJvXOPP/wxbf9uNOWKeGTXWdtjhVUn0P2xLn44jcTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tjonQpnue4cWGPQlnfneyKU+fxrDf5W2h+fRIx5AyY=;
 b=IhvcI567kopU4qcmjS2vNYsNA/knHfyxe2gErwx1VENQve0t0I7wiJE5ZXk0viYes1AZaQbrH7u3SsXAstl2Sd7R6cKA91L0nl+KVH8ueibsEFXQgt9tlMlavwUjMcEM0vUTiWNIlOrc/qyskHuFnY1e9Uu50nUn/5OPjZvpMjmLIyDecj+l5a8wF4wOPR+3oHUPOW0IiIAKC5VdXGKQb1WKxEdwBG+IPYEiYek2zMvr9I7O/IIfEJWQTNEAqWTFmwQxKb2KIbnWIa+8whmsCoIwzCVzr+dtxSokNsZ+tl2a4qYMtdH1d48hpv77hh27YtrqZZQfT1xgbzgA1fW3Aw==
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Fri, 23 Aug 2024 13:22:35 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::73) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Fri, 23 Aug 2024 13:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:22:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:22:26 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:22:19 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: Delete some redundant judgments
Date: Fri, 23 Aug 2024 15:16:46 +0200
In-Reply-To: <20240822043252.3488749-1-lizetao1@huawei.com>
Message-ID: <87y14nidbs.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e861ad-d9c2-4db2-1c7e-08dcc376a6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VS7yFPArBL+AUz19BvjpPk6ClmLdThkHZGiFdo+PpHhqllnOLzXnrUrd4Lq8?=
 =?us-ascii?Q?a7eBV/JemnZ50P4Gm8gVu0/1bPVIaFWBS5+Y+730Z6TPU9ST3G8gTqlZ+RCh?=
 =?us-ascii?Q?P8w6n19gBZEaHPMl7m5MoUTWWdFIgcM30aN6Y1I/4I4A1QkJFrwAe0TEz5yE?=
 =?us-ascii?Q?B5IYaoBYHT5Z1SOyU99o4Sdj1MFpKTv3FSV2gaZFZPTvLCKoZjr1O19Nfhsz?=
 =?us-ascii?Q?4QhdU05gHO8zTZ6y8atrFN0tQSoVDKPlASL784gRH5BhYWarC1O9ve2gOKQD?=
 =?us-ascii?Q?nnBDZbhnVSRIVfRpwe9+P1SwcQaGJARU59E5/FsUgIoWASlJxpPm/DijAjV1?=
 =?us-ascii?Q?f/2WOVeQK+hwSnWIXId5QpdoM8dLsG5I7HwxBe6DQnMtx2IkXE1/A1cIbU6Q?=
 =?us-ascii?Q?T9Kb3F2o95a9LlVmafKssYXiRiz8TvXsMcS2D5NXyUGK99VuaJz45v0CFLi0?=
 =?us-ascii?Q?qyT8m67SDFpmITc34qhSRbvR9O52M/cnxhQ4NT/abRL7gTOCMKoa2ecMGZvq?=
 =?us-ascii?Q?Uz+aQ6Y+lJvC6YS6wt2VBhdPoplaLETLxy/083ojQ3y+6T3oZP75949y9ZWg?=
 =?us-ascii?Q?tk0ZU+jq7dKgrekcJH0llwnrDt8gC5IGormVAsOnMHAO8OfzEIknoZCBcpVB?=
 =?us-ascii?Q?QbvfA0Lgsp9/Q7EWPSACd/37O5ywsfVXIP7t+7W620Fr/jKJb/rc5/rkU0kZ?=
 =?us-ascii?Q?8jQ2rQTS2250gRUnDbIpvH9AUv8XRQMgPkKzvk3DeUNniLPLS7VNgKpJj7PC?=
 =?us-ascii?Q?QNoXMC+/5T/5UgiENIHkpUyIcGAQugBsLPYT+Gvz0bNFM7dMogs6gh/r0eyr?=
 =?us-ascii?Q?D6pz/lSFir1IiGLshUHTsNfdSncBT6iuT4jR2iCF7JX6WIcDRN35cOK2IE70?=
 =?us-ascii?Q?vtYU9IRSk+fbzFNGHASadB3bJr1hTpeJE55WxvcYMEHF5nhMYJipYQ+hF1a5?=
 =?us-ascii?Q?OY2LWW0mPFQOL3JK+5UlPvjQqU9grPXSCUHiXJdbgwOd9GR4PYO556oDeQ7N?=
 =?us-ascii?Q?Zu6DXD7GcCZYpMEP92zdkbG3/7jTyiZWcpLjDwxYqHqeZy3GBxsZFt9InRux?=
 =?us-ascii?Q?RukPjVhyoiX2hXMVS8p+vlGLsUdgSGyMuMnwQgrDcYXsL7jEfGLAAIh3vxM7?=
 =?us-ascii?Q?Qg3Zn/Bs0yLWcb7rIBT9hKhDmV3/CC4yQ9ZvxUG9euVPQlJ293bQxB5N7WZw?=
 =?us-ascii?Q?cJAkwWpzUQdhwJjHTYmDDY5J54fGFnKDwTuGm/tpv/+RbLXqdU1ySoYKrUaH?=
 =?us-ascii?Q?FNiJ+vd6ZaUZWnIo4lv1+ZN+WKcmToNHVrIH8DEIUWeNkUvhvRF6eEcDqRGR?=
 =?us-ascii?Q?JCz05va+QW8/23srg9OrEY0JIKXd1NcrcyDPv+6uA82eTIzmWOop6AQndL8Y?=
 =?us-ascii?Q?ju5DUG8p8TBAsi+kEhhQrichndum0+YDc3vzHr7Hm9arwwkXYoPvH3GQjPKv?=
 =?us-ascii?Q?kOIKsvsjc1BDLMns4ojcXalF6EnxSCMg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:22:34.7843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e861ad-d9c2-4db2-1c7e-08dcc376a6b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455


Li Zetao <lizetao1@huawei.com> writes:

> This patchset aims to remove some unnecessary judgments and make the
> code more concise. In some network modules, rtnl_set_sk_err is used to
> record error information, but the err is repeatedly judged to be less
> than 0 on the error path. Deleted these redundant judgments.

What you call "judgments" would be usually called "conditionals" or
"conditional statements", "judged less than zero" would be probably
"compared to zero". I think the commit messages are reasonably clear
despite this, so I'd leave it be unless others push back. But it's worth
keeping in mind for future contributions.

