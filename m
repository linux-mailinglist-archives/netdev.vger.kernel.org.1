Return-Path: <netdev+bounces-116775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC3294BA81
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B91C2087D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DB1891BD;
	Thu,  8 Aug 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5NTW3gV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4913D61D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111642; cv=fail; b=ukJxe48jf8kDgOIB1KeRsj65vPv0jgJquLQIzUDWCzQLmb8tP6qiS3Mvs5jmyY2ab9w/V/7WLtSdqrollBdLmuSZ8pN+2psQad0Oef6ovD3STENRixeKOoqh/P/lCg95HmQl9jIJOwTdopagpLXiPvjuppvdOU1XC4LOqNNmcqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111642; c=relaxed/simple;
	bh=XYj7KmwUC9LSFnXoWNNkok2DJVp6D9TV9tEz6cleSVg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aL2NSaShj/6NwYdLGAKYIM1jzW4bp8YqsLsa9cNMr9z1knufdO3+o+2Ky1INMeO5GRe8yXzYZjlzYhLj/QLg720VOg3aUIt7R56hbjuMC9Q2w6DOykzZ+1ULCpEVwkMY6HHzoS7Tbhx45sR+La51NV/QUvKT91MoM9PMhUmYdCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5NTW3gV; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrSS2GJKzHwzUr7ijttABRTDwzmlvXidDyuqC9x1fG+x7VMitsGTmIBmZA47IoVZR0dreMhTOKlIerOJjAMrphwNRmrtDFzYxU/l/AzrDtR3rZvzlN7+ImwtL0sIBjaBPGuMWUJ66hCfRGnBmyDIRBS+OX1FzhTS10AgWHlAc9Nzp61QhOXf08U4dcLJgU+pHhBJz97TEN/sfN0Q5Cjf5RdyD28TShdf0DRTNj5rYBu9oXYDNvJqIEsXD8bwUHLuk32xeedJJZFFhmm7QGp+vvUCsxq4FkUDNAvK+ZD/ftwdoFU2Xp56SEbARaorr+VViM6fSMYlKtGYWIvLbN55TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYj7KmwUC9LSFnXoWNNkok2DJVp6D9TV9tEz6cleSVg=;
 b=QtMO4dOaRQHMJ9FmNTOIjv0PH3JiexCtfLuzOB1E7De8uRkC0PImciQuBY7H+Hutwz3ov/MsplQ10+scr0MhzudiGYye054l6GucxK7Ku66QdJ3wCj5KE1Rg3pWJTIV4eCaksexCaiT551Fy3r7IKXBCPEKHH0lLgJ7QSoB2J8UAjJypVKhq4ZuYSLURLFLCSOn/XmlwwWny47PFpFE4fDumucTjpK+QH7tyLJCW36x09ha2A4Ik78aieZ7Lj5alpm8XOA30srA/GewvYDCXLihvnJ3Jh9eN1lmI6Qo0VO6IrhzqfaAsY+A10ZYeXbC+NPeHCbk+J/ncxYJTTuCiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYj7KmwUC9LSFnXoWNNkok2DJVp6D9TV9tEz6cleSVg=;
 b=B5NTW3gVdhepvoH+nAQlMs5lxmy+55JVwkh+qs8LdQguMYRc/EKMukm1DSWZgqr7u8NNG0rnMo4MZGKxapVcHwXiUVu8JPWqsAfEVFv5aL9krkl7PcMQIhFjedjsGwLtvGN5wNXkY0/+Nm5jrR6c/vzBpINnRC2CXKh/CRw/dA7xuMqLmggmgk8LLgmcmttpIKBMpteZ71t9FHk+hNXZ/y93EQW29HlW8gUN/E/83FRtvVKJLvjPHXcnJazsehqYqXowLRzxATl4qvIPpfbGhsOGQB4mnWW4txYf0KcQAlU5UWgTovbCMA6QNTtgkJWIchJuInV7R1eNvOEt2QH9rg==
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 10:07:17 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::d6) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 10:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 10:07:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 03:07:01 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 03:06:54 -0700
References: <20240806193317.1491822-1-kuba@kernel.org>
 <20240806193317.1491822-13-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <michael.chan@broadcom.com>, <shuah@kernel.org>,
	<ecree.xilinx@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<ahmed.zaki@intel.com>, <andrew@lunn.ch>, <willemb@google.com>,
	<pavan.chebbi@broadcom.com>, <petrm@nvidia.com>, <gal@nvidia.com>,
	<jdamato@fastly.com>, <donald.hunter@gmail.com>
Subject: Re: [PATCH net-next v3 12/12] selftests: drv-net: rss_ctx: test
 dumping RSS contexts
Date: Thu, 8 Aug 2024 12:05:57 +0200
In-Reply-To: <20240806193317.1491822-13-kuba@kernel.org>
Message-ID: <87sevfmipy.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: be7be57d-3ade-4fab-039a-08dcb791e204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4woLeH6tSQwbyjTiantj61SJFl0h8CGeMZTvCY9nnPH5OkuBsCBgNqG+3xDc?=
 =?us-ascii?Q?qBKadZxKMbAZ48wGmCRE8T8RMof9oc9w06CUyN+z1cdQx+erXUYLUHC7HNC/?=
 =?us-ascii?Q?RIPd3DhWbn8fKFnkU73ea1cM9vdngukxtxO1LQk9pNwC06gejUWheXVcaRte?=
 =?us-ascii?Q?uk4MC+3aXphJWBzx9H+dYW3Zjf20FmK6M6QY5m9igYaFXOtZo8w42h3jGYqd?=
 =?us-ascii?Q?PwdJZ2Om4rHsmCxVqBswwIx+wqvoSTyCM+qcrdLC46v23hfBeZjD1hpL3hsV?=
 =?us-ascii?Q?zMdyseXaUrVgWmr9aSVs3RLu5mLZeCn7XQzTTJVRgypkOskIhAYHSEzVJUFT?=
 =?us-ascii?Q?AG86B1yxdu+obD/HVDw6pat39zs/pZUR9jpFyKb3Pb7ynBdUODsJoujCt6dm?=
 =?us-ascii?Q?GoPFF1q65d/KG0WFQ+TW9XgmPt0GNhZMJwzyt0GQnEu+ja1XG9yXJyGGJE37?=
 =?us-ascii?Q?/OBw4razOMLSw21vbMqhuRyqVxXwfZg6TBMIenBIwrWuP2lCqfDpbCFcRJ8+?=
 =?us-ascii?Q?N5wnS4q1ta1b2eVLqhKYj4xe3si+Eaa4VsoC7hMuUWabbwejZLPybAojTME4?=
 =?us-ascii?Q?dGXlQg7IQgtUjztHhoaAz/TJ9oNut3650hvmhFsPesvyyCSBP/4gqwk/phPM?=
 =?us-ascii?Q?8WkV61ZogN77fWuntQdvE5W39atXnFbt6RDclxVxyk/DtXDA9WUPKMcr6zZY?=
 =?us-ascii?Q?pu0U+dmDohO0aTShQ6kBFDtVX3Mx++WYtpZLIjJmCPdHFYxKo3g4+KgftPWA?=
 =?us-ascii?Q?p/rmVwXtBs7qN+1hoPSywsdNeUWTEcIjIQuQ0RsVDzvfNWTrS6uovwUk2Vab?=
 =?us-ascii?Q?jd4Wp3n3vXQLs1ExLezaeXbXHRp0r3PiIdt469V00AjxYbAnNOHRBlJXhSIT?=
 =?us-ascii?Q?wSuL77VlJOFDgpWCXLyCG7mrDd05dqjFdC0P+7cnoh+fMWEVHWeDGkp9WPfu?=
 =?us-ascii?Q?1xC5LaUfPm2hOlCB45+FQ7LRBGxFZKLNkRKG5wGOYvPu5tGIauO3ucPjRi6x?=
 =?us-ascii?Q?1z3SgwgOo9F4c6AjP1GG7wPRk77m/+gLhhVLzDRcu9MtPIkzYVGn8LENBvJ1?=
 =?us-ascii?Q?0yBdOkawRRz2vcMDtiNudc89FkUasGm4FLNwa7KQms+ajX+MlyEjH/0f+8dT?=
 =?us-ascii?Q?yGdqw1u+zARy+F2+C8fOX9fVtr5XF5Xnn1CfISPl/sjWIhjcl7Nuhyizl/Ej?=
 =?us-ascii?Q?Lx9XCNij2Wc1cdvoHXDI11bHjkblH04rKpIgDOL17LuGS/Y9CXcNarKZ7KFv?=
 =?us-ascii?Q?Q7CEn7Nm8G8bg1TgGVuUGBDJiXXDxaGleS2iiE5WWUxGpCPf7CzdEy1dn3LO?=
 =?us-ascii?Q?9Bo75vtDTY7PYcazAZPwZ2ZaKujWsoUtUQ0rJOxaRIRZTdjlt06OQZppM25p?=
 =?us-ascii?Q?mMbBgCGhqNrrL7MVlXu0oz8GEvxFuWKYq7bpif8S2qpe4s/3R+tA3OHJsk68?=
 =?us-ascii?Q?Wmf5T4dcFamL72Uy8TVYDd1Kk3Gd1f+X?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 10:07:16.7791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7be57d-3ade-4fab-039a-08dcb791e204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748


Jakub Kicinski <kuba@kernel.org> writes:

> Add a test for dumping RSS contexts. Make sure indir table
> and key are sane when contexts are created with various
> combination of inputs. Test the dump filtering by ifname
> and start-context.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

