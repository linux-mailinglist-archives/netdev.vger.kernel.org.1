Return-Path: <netdev+bounces-106832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D59917D67
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74801C213FB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3017A918;
	Wed, 26 Jun 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="idDgcMvF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213951741C1
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396687; cv=fail; b=qAiJrQr+25mjgPtjWizXWSu0SbiN5YOcvIywcnlTCBQ2khJLdXUqlo7Ld3NuW1Q/u7y8v7jYISpvzOMsw2ytspzce+58E+ZSNf7yTTwIk4xqLSfCSGD17PM89+AWzradLTnElqTkRlGE/a/8vSolRspOu6G2GmCr1vbzGRzFAJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396687; c=relaxed/simple;
	bh=6hiOANRLeHd5HgVs/b65rb90hTq2lzoXdCXcmQpbdTE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uR22UPbx8LC3EN2ERQsxyvQtVuM0RCU9DpgnWvF7jGl5OmsgZwHxSSJqr80bLlDjy5nViStSoZ9uOcZQWpcFLDUfG3gXZki0zKt/EpnrZC8mbt2rUp/8VpSiE52lX29fXs7U1xahKZEO5h6lDhL9LfaZ+aSA6+JcyV7+6rh29n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=idDgcMvF; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQlSw47u35CDoMba7MF2A/bXRCS388ug28eNfYPMm+rQnXXi8dtPXux8KI2r2kGhuj+cE4i/mrVr9JH6EjmEoMvlZF3ehRH0Ql/7olR2IaM+sQM75+JrxaauLMbJJLAwa4LqGgoOFNdjodlgKFN4U6IISZWFLmkF1DeSWmG/OKCkaZcVXq6k/O45neMoGd0/n+k7JpQRw2KY8+cOMQ9fIpFMjEtKbkbGPWTqTFrHW+O//ymxObLTEXD+1Z1YY58wm9zkaZfxowDjVXYoFx0J3xGa0hrkf4RYY+WobFlxW5hyA0ECEO7Eh9D7X513D5bTGPJV07Ydte8ZIWFNPRbZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hiOANRLeHd5HgVs/b65rb90hTq2lzoXdCXcmQpbdTE=;
 b=K9BDidgc32gIZEQKLwWFMfH69QmEMcy+grtG5cXDyThpOIJ/Wc5r/U9gOV+fAUVxaHMJwvCKwtQkTwYZA5ftdxb28KSCSH1yg0mNcGYRe6XcAU3FMtkQYLgnxR3gNUWXN1x0LZLu2PDBM1Y1vhLU+eAXvonXlidwG1WZN5m6RZroNQKDenXdDkkSGQduh4ok3VMivh+crptBsLdnpzpwaGLlNG97EspxJMBoIdTPpNVLhMJwgImBbFKFTe25Ic7VdiGqUU0TerEht8GgfMRABz3gPOb/moKT7jx+mjWzhQ/t1NWmAQfl2rjM1RMcbgof+X4Jn3FOq+PSzGFKIhVR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hiOANRLeHd5HgVs/b65rb90hTq2lzoXdCXcmQpbdTE=;
 b=idDgcMvFVP6M3bPpjlwGnPn0UanPp3kneYXzaz3yo5DRvDAH97D5A3yaWwxrk3MCV0pQBpgeuKXcf/gyikkWvQ4cQMB3yZefgWRx9L1eXtXu1tAI6Ltwgamu6gBiD8wVjzlppUg3sy1G++Rn5jpf8xDrDG/J1tPxiY6IjbL9pu8qnYIOBDsbd87q0oztPd1bA09uJrTg+jtRfiaM/5BxZy69ygC/6IAlzKffwjrR/v25ElKMyQplqQRfjBdfnvTxJS5WMlwkb4NEdUl7RWzALgc3r5CMvi8ihut7vTLwyTDp+VxMWw99inuAJJ4A2HKjZhqxCkqq6YsUaPB4lfomCg==
Received: from MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::32)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 10:11:22 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:80:cafe::6b) by MW4P223CA0027.outlook.office365.com
 (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 10:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:11:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:11:07 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:11:01 -0700
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-3-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<leitao@debian.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v3 2/4] selftests: drv-net: add helper to wait
 for HW stats to sync
Date: Wed, 26 Jun 2024 11:49:53 +0200
In-Reply-To: <20240626012456.2326192-3-kuba@kernel.org>
Message-ID: <87le2s9fpr.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d989b03-14f9-47cf-b26c-08dc95c85402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|7416012|376012|36860700011|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?34xAouwnsyjxT2rWs9CB5UMbCGQagkhs6fUCUgiZcXzQUlFzXWon79IUmBok?=
 =?us-ascii?Q?vT4QgE3CffhQyqr8BptZnWcurDPnLaybJodK3rPGGb+QQy5+eu6oZEpFzawS?=
 =?us-ascii?Q?/iij4hLb7vZk7WXCOAgn9t03e8DJQzSySNtVluxeugd14aNxeX/NsQ0fWCWZ?=
 =?us-ascii?Q?3HrdMYDWo6LvqQLT/cOsmKjWWybZcJZd1d43PQG9KZqDTBiHlZO8m05ejkn7?=
 =?us-ascii?Q?TeiUB7Xa8KU3/nFdFsuy5pT4ENBkjfZNiMR+PJL532VRIMUZIlgJMiEmVK7L?=
 =?us-ascii?Q?FeUjmFm9PnlpBCeEqWqoXAMpNh+vZrtx8NUFubNcT74d8mx/byK5fdFKABeX?=
 =?us-ascii?Q?n5fx/FTZ9mWLNK9xhiuOyb8UwZBH59lJq11eM5nXSyUWp75ODtQxooZ3Gu32?=
 =?us-ascii?Q?RTsvqyGEuAfZ1HwsyvQhlSbcQch8BJ2ltOs5UaCDOEzyx7kp5lp6lU306oFD?=
 =?us-ascii?Q?xl0fRREtr+vpbkm52boTjLm0lCZTC2bxdVu57RjjX67FV9BYrJWXUqMFLl7G?=
 =?us-ascii?Q?Vn5o7fgb0QpdlDBnpEPs1JeNmidEOmofb2WR/zWM5IjXHY5wh6PB92m3Wo/f?=
 =?us-ascii?Q?+UJSVEC+UKy3EEpd7eUZ5NqeBgCEu9oCljGd8WgF60Bbhs1qBBE1UyGbvNfd?=
 =?us-ascii?Q?x1eg611EoWB36UxktnaM2j+rUxwBQpTxc1fd3V1Ju/nDOTXxPwKRMv0y0svl?=
 =?us-ascii?Q?ub5CZGvbu8O5hf+P4HxFa1QqP52CTc3KB4Xa2WPwGbkFQLX1FV/EDH/TENgQ?=
 =?us-ascii?Q?iVIZpmOAmAE82X06OKVfVQs/tDlhcvtnFNI9deelZAR63mYmiBC9RNXlkxh7?=
 =?us-ascii?Q?TlImTWkzMa0xrjabcnEQa5X+IrOhkwWNxq9aoxhJYg2Gheyms9eGUyIb6RMW?=
 =?us-ascii?Q?Vo88EUY/JeLo192kws7yeFgBkTIf+sH4sa+ndNPEGLXHDvDYHjXJGkDPWZmU?=
 =?us-ascii?Q?5F2jU6bdi+AwBNOv+Sv3VpVDR0Uf5vVrNjYLni360dxDjm6Ae9DpNSv3I0NY?=
 =?us-ascii?Q?wWGElVODqH2rsRR3RFQdQ5agA5pMPJwQf4LaLoeAjdcvl7qbDi/RVD3sR6WD?=
 =?us-ascii?Q?MLSaEPbVR9sWxhW73eIcqW7k9my0adMCYpOr9WcH75KqK9JaQiUay89fd2W6?=
 =?us-ascii?Q?O5P1MXv6UjPd8JwIBF+Ff5QH4MCvcehd9KXMF5ylh56aDwPz6Gt10xgCbMMm?=
 =?us-ascii?Q?iXGlC/Du4igwUDf6fnyyxTB03bz8ZGN3R3f1Qlkig89sm0ijjqp9/UywdJY6?=
 =?us-ascii?Q?4WHjmvlAxwHNzPhyXVtIZnSQZPlnnWVWN8Lv++rs3gN13Ob+o9jDo9AE0Yy0?=
 =?us-ascii?Q?TPe4npB4bPg5RmK6Qhbn9EvFZekpXIagXAs8r3GXQZ9Gc+RCp9J+tvK0WC36?=
 =?us-ascii?Q?yIBMsFqGlWXIRV6NoXIgnrYKEQ3WX+VY7DMpnk/CnamM4KaHKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(7416012)(376012)(36860700011)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:11:21.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d989b03-14f9-47cf-b26c-08dc95c85402
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234


Jakub Kicinski <kuba@kernel.org> writes:

> Some devices DMA stats to the host periodically. Add a helper
> which can wait for that to happen, based on frequency reported
> by the driver in ethtool.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

