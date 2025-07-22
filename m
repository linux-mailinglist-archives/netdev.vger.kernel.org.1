Return-Path: <netdev+bounces-208845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB5B0D61C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30DC1AA5040
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510E2DE702;
	Tue, 22 Jul 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTpZPz3M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7F28ECD0;
	Tue, 22 Jul 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177176; cv=fail; b=CkMZCCXpC4e7zdJnwCvpTEtcpDz0+3+I45MMRetdwoiurQ41Wc/DRV8zpZPf/HR7Gi1QOKb6EzfUk4M0gvrWrbtwvLR5RWjVqhuRh5DUpBV+YkzYmtnCpEO7dTjieS1M94TCkbtS0UuFPOdd/Wogsrw5fMoyUGMPW14GcRqv75Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177176; c=relaxed/simple;
	bh=KebvGi6LutLVbHycZLTrWH5nSJsteGXf+wFyVYH1i90=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=unyRWir+QV1PPAgLk2N5cVzi9ygoUIfwS3hdcv4z7bzZnuwq9isqIv40JTjGHEi/HnhoORdKt646FqmlKFae9BS6vYp/VN7PSXWZbbqY4Q5GCOufN6jHJxjm8/DA2kthJLNzOCOKo/09/UKtBdpuqd//Lv/mSfCB9ISJS4IXjIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTpZPz3M; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et6ASM7VAvsonOQOLAhIY6Uzdmalxa9sGo6v/zPf9tP8u5w0fmG2SQQcFPVKAlnabAtH/Nvt/RYDbzgDH6BXh3270doKHTJspLSLa3+KXxPEgt9bj8fz8A+L2JCNQ2tIzPlR5y/11qMwsVO9Wt7v+ZGuvCg3A4dIO5ViPBfC8k/1N4NHTf00R0E0wRjn3FsRYGz5uuZdH0qPSLQxx8QL/8q+ksuq7Xyj/HbGYtFh/cp3vhkxH27fOAv1goTkUhiK4WnpSfpAxQ24fXM9+q83nBUI9+6GpEfh8caFSxNlWVpHPyW049BbJnQexrC0eSAKp+AngvauB2RfWMD7NCwlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KebvGi6LutLVbHycZLTrWH5nSJsteGXf+wFyVYH1i90=;
 b=WfpclG3zxcAFEg/6GhWEVb5E+05OndFcT9t3skpsSXWRtjsCWBjbZkqa0ooALFztgrNvYFWzYOHCQKr3Q9OhGWu+LPsuwyfBxp5+ucLFW1zGIQDq2fd/AvssRqZucBzPINEG9D0UXOHfm6sfytQ81idg1b/4odE0AXp2UHar2dt8VlzCXObvzbw5ruPM5fuJ+7PaVVGws1iHiKzZsXr7NC/zKPQnjm1GnJ0h4tO59Wb0K8W+qFUapeFcIFlaMmijMzTWQcN3+1Cl1/zI74ZBiI7BvrnE84htFX9hSeIN9ZcEjJAFwAUIQVm/A2hs4aHcKZ9NvNi+6k2p23QhrBTWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KebvGi6LutLVbHycZLTrWH5nSJsteGXf+wFyVYH1i90=;
 b=nTpZPz3MgASopyUSkSFTqJIyY7h/pEflm3tuIl3eNUkJVymnvQGkK9W03Mvq1uTjof5NeMRzl6XTy9Pd/Qo41yDhtOmYkOva1M/etX5x7+TI8MufOTIcpdn3yQO+DzSUEuX9xCB8qGurHsez9ptdk9wyyY5cRfYUkh+rQb2a1ObIpV6dC28oSxy3IzjK7ONRsRJK1T4lw1NMjtzq+2+IBSfXYzD6fkmxpHTmORCnIgid1c59FLlHhe0TFDAweYOi5+RNpsdRQgrORQvwLIW3hhF4Few8yzyWAwHjRtpakiD49MXXJRYnGVaO4pjsWsGhz5dn5cN8vEvvHeiVI99ucQ==
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:39:32 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::76) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 09:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 09:39:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 02:39:16 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 02:39:09 -0700
References: <20250722093049.1527505-1-wangliang74@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Wang Liang <wangliang74@huawei.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<idosch@nvidia.com>, <petrm@nvidia.com>, <menglong8.dong@gmail.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] vxlan: remove redundant conversion of vni in
 vxlan_nl2conf
Date: Tue, 22 Jul 2025 11:38:06 +0200
In-Reply-To: <20250722093049.1527505-1-wangliang74@huawei.com>
Message-ID: <87ms8wd0p3.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5206d2c2-162a-471c-aa65-08ddc903a96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mR6e/hiAoN3DSsKtO01on0wVhMcz4DyFXXM7B50phGVJm9wZGf8lbClnjMRg?=
 =?us-ascii?Q?ubpCaqdteoRVOmPmRWGkK2TUccq/fdI0eJ6k6aL9aJNla5GqlFcRUMc1q4/I?=
 =?us-ascii?Q?twOzqE0y2kS1R8SjoYRHyYa6IOj/Oo1xLsgcZ7WBguW6Hw4vhVUN9i/g2Mls?=
 =?us-ascii?Q?z8iwTI1JfoTtfsihtxqrPPghNdGQogpDj/PB5e9hxxo651cL2lfDb8c5xVlv?=
 =?us-ascii?Q?3fBxN77ajBbKWhcRkbhPhl36nPV0E42cbKY91u7+MWUyT3zjK9KnXbpAQFqU?=
 =?us-ascii?Q?UNCF2o/cZWEdpQJu5PNYghA3gN1WQU0lPPL63N4s9vJ2HNFgYxVi5DlCfloA?=
 =?us-ascii?Q?TvjueiZqfb6QXzvbvz8dsbP3cfv8cM6MJm48FJLwmhBrOBdG6CoHrYpov9fr?=
 =?us-ascii?Q?je1sQEaI5cvC2Ghi//0Y26H8hkDuwnIdexBGt3hpTFYsbnvtPd5ttZb6LzyB?=
 =?us-ascii?Q?r7rmYE9FcxdbJlDh8FQ67JsktNGYg4zYrloxhnPobJVironhbhNjE4TWb3Xo?=
 =?us-ascii?Q?wm5I1jzHlfS9FMq8ElhP/3CIkgHLDhFlAQ4834SdruYs0gBc0/W8TR8rZH3E?=
 =?us-ascii?Q?LGzDrsrWvD5dUQSFFy6reqZFxjs5QmYwG1CGJ746BDgnYKVTnipn9q4TeVYH?=
 =?us-ascii?Q?huaDgqKkdJtKr2KuO8u0Vd0QVFlbeH36Uuy3kF50p3dSiWgMeth/dSaC511k?=
 =?us-ascii?Q?F9NibVdpd0UW5u2ZDEzulC3S0zmwtDtZYLqKobaXgMWj0KGW/dXlRIjNp3no?=
 =?us-ascii?Q?t7QLBMGUys5hUF39a13ipiXAtiTrUJtqICNlw5yKTzBdzPVlMSdgvaXrU1pZ?=
 =?us-ascii?Q?vr1cEWZxNBR55q4ThYoCt7TkpBE1TL6/QLwY9OJLA1eBq3D5cKiscoRJhNEH?=
 =?us-ascii?Q?zgII4Nb6Od3Hmj6JhHZsia7mm2jIrasra9GqmF94Mo/CQStx1r1sw2TqBUf9?=
 =?us-ascii?Q?wlNst1GIjaL9FwDxVStwnrf2wOr8RitjY5XxmUmEHJO/w+lxi6btbcmQX16m?=
 =?us-ascii?Q?3BXQk6wLrTV33jNvsetyFxLqxXjLG+RaeQuGflYNcrOqqiewkmxRdIC3WvO7?=
 =?us-ascii?Q?xW7NkjPUWMr5Jmyiimb01hLTKRtH/6zeBV4DjpwpGcHZPeeL6X7x+c/E3erp?=
 =?us-ascii?Q?gAGW8LszqGAiALD/jHbX5iv5V81SsfZonhsV3wh4160CDdwCVQi4CIMEwKAr?=
 =?us-ascii?Q?nMuJ+V1RYDWUUDqRWl0LBZ/4VGdOrfRspRENQ0U8S0mvZWmtPlkDtv0hm7Ea?=
 =?us-ascii?Q?TKDz06tK0tXxb+deK2zRKVOYe3+m1AVG5+E05aXT3mmXH6731299TtYME4T8?=
 =?us-ascii?Q?uUD1CvHi8G3Q2rCRreI9ZvGN0c30RjhoGxUxM1nn+WHAqyYQGOCVfZJZy12F?=
 =?us-ascii?Q?7PxN0FU1W2WgCspI2uxFRiWAY0MTZzlCKIvCVDqX2K+eZK/D8Izhi04ZfIFm?=
 =?us-ascii?Q?0W/i5aecXCjnIIY54r1z1E+HcsrgjB2KS31qSAMw6j0uud+briki3YkFoiFf?=
 =?us-ascii?Q?OV3Fb8wYM7/7iXNTa5smK9UFuVSe6dKfg6B0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:39:31.9326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5206d2c2-162a-471c-aa65-08ddc903a96e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294


Wang Liang <wangliang74@huawei.com> writes:

> The IFLA_VXLAN_ID data has been converted to local variable vni in
> vxlan_nl2conf(), there is no need to do it again when set conf->vni.
>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

