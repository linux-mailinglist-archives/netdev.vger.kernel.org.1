Return-Path: <netdev+bounces-248394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32CD07EC5
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC92730AB1D0
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0300350A28;
	Fri,  9 Jan 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QmiSFIvl"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AE1DA628
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947972; cv=fail; b=fuOQy+C/U4NwRUNspyppt24+MuTjmM2aKwCPVI9HoPKVz5+/U9asClWLoUKxpOnbRJPvVszrf6hf+79NM4Eao8Z0f+oxTYzgxyhJJi7Hldzsu2WIsX5U56MWhXsy7xlKz3h7njL0vvmKn0LNM16YgRJ3D4G6Dv14IXOkzOSSnpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947972; c=relaxed/simple;
	bh=D0IarSUVC/yKze6xCqsd+zwSi4QntLAE5y72WH2/mMA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Qqw3fxPp3q7NT8Xlon9Ye5KJbaBkMuy4Kf1IEWV+5nIwwoX6XHNu9zey4zmmFEhX387ItHhZX9+WkPXG4vY1SMMMoa0zGzCN3VWwOwA8gsdfbWRkyWIxGlaxt4dbcBmvU7wnJoWba6BEMGLMOytQMMMnTpzeSOy2WAmdQoQgA04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QmiSFIvl; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiIBZhQP4Ekz2/uj93MEEjvcqHDAGXjeTghOlTVXDrtQIWXahIsqOBwQ70cUrdQjACC57zh0j0hkmrcWuGnCLRqz+9hOIT2nKX3A5XwaWb+EO3IOkJAC8REQ/+TyJ9lxxpX/yAotEkZXXsfF0weZpHzVnKt7NyoVNyLIrpQ3OCs7p8wgcK5PlYFfcU42eu8yyAUDAyq55xXPFXutsKrqr3nR9pCPLlmUA/+Kk8b6ZrnYT7UH03X9LVjYOkngBtHBcPDRYRrxotAijU8F5nNAs7+PlyfOW2Ph8czlNfiLh3JRgtdHTCtRa8uYeHXSS25gZMqc6Ex6p+j37/gk5s9Y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0IarSUVC/yKze6xCqsd+zwSi4QntLAE5y72WH2/mMA=;
 b=XrR9SN+N0gsQcZOFyUuo5CBhdz+RmKv/vpaeAZdBQuJXiXatQbAtSI7oxnCEtcOr3wrTgymqbZn4cY+GF6HDTrDcRXdqr3CZHgkF/qTE3KbUCvWuIu3EG/R7P7FJIoBM3DUDBXBdfDCiNz0rPT1yjc7LxnHwVTUpb2oJOYTqbho3B2OFhgHLtitTj+Ww1TFn8VjzJC3sUXPEqGWJ28VhiePVEzjtq7gYDoDEatcVwoiMcbvxk5i7jGIs5J6h6sRBPm5BK5Cerzjte++FggR8oEKzmVfoySnyHgCRW4XkmhZTQFvWDIbeDmFeLaNSBRIxsofMAeu1JvokuM4tLc66tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=fastly.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0IarSUVC/yKze6xCqsd+zwSi4QntLAE5y72WH2/mMA=;
 b=QmiSFIvlhwD2sOi4CH8RVsFXdb4dwu8Sm/Q+cLdSAJkxRBWJhJlPzlgf8UtiwCfstOVlKw5F5E/Iwwi31EbBMjvSpKA3qgJGQoNgKaqnAjs1Ar/iUYQslcv2jxSJkYPsbl2L/xSChiPjl8wwaYqW8Zgo+XQAZuKNJ8mh1YdSCgZePjAG7cF4tmtAvY5pcnlXcd50iaMagBh3BLNo8E9WseVVXWH3fZN567tr7M80lHtJFFnedEpWta84QSTreG9Opdpu63BETqXatNVQA379tDAlB08gU051Kmnv7bScRWNUV5xxJeGeXMSYEzSX2usRRshTnI9zBGQRve3NipsPng==
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 08:39:19 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::54) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Fri, 9
 Jan 2026 08:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 08:39:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 00:38:57 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 00:38:51 -0800
References: <20260108225257.2684238-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <leitao@debian.org>, <jdamato@fastly.com>
Subject: Re: [PATCH net-next 1/2] selftests: net: py: capitalize defer queue
 and improve import
Date: Fri, 9 Jan 2026 09:38:31 +0100
In-Reply-To: <20260108225257.2684238-1-kuba@kernel.org>
Message-ID: <87bjj35gfd.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a45a9e9-3d6e-4e59-1cdd-08de4f5a9459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qlpyGWib1K39d66Q6KnoWbK5IkNQvG8WaULvoGf39gxGPYXBMUQFRgxx1Dx+?=
 =?us-ascii?Q?CZl/HOsGKi+ZNNXWgtp6A/dGZ+N+m6zBb22RVLaQzJoMOhS1pF4WmFrOw3QP?=
 =?us-ascii?Q?rQsijcp3uNWH6K+yBDT+BqJxy1lpeVTyW+fLO48lh2Wai40ozrJ1SYAuZo5+?=
 =?us-ascii?Q?4mmpx2pSWEqMFFRyFE3Uyv8FVLl1JT4yjh9wkeZ134+ROd+oaCfu7ssMZvmW?=
 =?us-ascii?Q?vfImL4aAqr/wMAn+kjGtmnd6Z/n4Dy+tROkFRnvO/NHh4D3Hw6ay71AQYrvY?=
 =?us-ascii?Q?CdnUMdkk5rhuYMkD2dRwTau0ENTIwWAzDJ2QiOxsib55w8ZZIlYgxv8r8r5Z?=
 =?us-ascii?Q?r4QABPt8BhBaJBC6r56HrFGOVk3C6lCajwOewQIBcvCH5SWvxLcFy57NHlrv?=
 =?us-ascii?Q?2b5X85O9XFByPY4rU9L4ER+jpvJfgPrKyY9Loq3PHH5v54LiAmWTy9kxwiB7?=
 =?us-ascii?Q?nRWeWmv9AY3Hj1kAMmX8jpsBPERDquS/AmsU3AufYR8Pf4TbR85LLD5JsOIb?=
 =?us-ascii?Q?aWEpq4pIVxm5qwU6Yzlakf/6XPVwWXYAGD5t3fX8tJvHm9LtTafdcghe0aNG?=
 =?us-ascii?Q?2SkHWanPpG5d2rhbiu83n2KVqjCHUSHtZhE88u+JzzBs/xHcb+hPWWh6sFzf?=
 =?us-ascii?Q?ESyi/DVvzvvTy2koQFWqHO6l8H2czKp281spEuF6WPUs5Dm9WrluXmdItgSW?=
 =?us-ascii?Q?K2yojb1sfX8VP9nVixOMqiBzbHcDrGCd2V3EvyZi8ZXtvK5wzP1F+WxoQMaO?=
 =?us-ascii?Q?WOnaBzQKWIJ17B1Mp4RAEoBnets84MLAqXcMifLxOnURYKD+3+irGMq21Rrt?=
 =?us-ascii?Q?dKdsilEk2cQQOt6IgeDsik4QeNk5TM+gm3aNKdvkZ2dV1aM525wfIJHSIUX7?=
 =?us-ascii?Q?1rSWmltLkz6To9OD4B+mZVx8ylnArhEmB+NQNEiRM2+0flDjUDB8QgoWI/Sk?=
 =?us-ascii?Q?W6lSdekl4TStZN3PKeDVT0IR9IEr5HTEb+6TV3npd2aauVdiuPJMk/gYrSmP?=
 =?us-ascii?Q?XYdaQXjYh9VWKI36AOWsPO9QwU4eFVHh+LOCCPCfJ+m69a3rFUo7VCDHXfu3?=
 =?us-ascii?Q?YNhev2JXKSXjAPlYy2Tu5OvWs9W4+KQg4fIZfpnTXPK2IPLfnKrdmhcsKByP?=
 =?us-ascii?Q?DsX2L6DrZAkruvQEvRSHpP5tJq6xzKZ82/d3NP+BiN2m/aZl0pW2UxfFtKM1?=
 =?us-ascii?Q?gw2o0XUPgm3yZ4IHToLtBR/NUWEFXHl3AMutyJmcsR4A7E2UzJOWYyKQQjwW?=
 =?us-ascii?Q?AoBOwffYhjBLcw69HLWrpcLTCB1Q9cn1RKyaOx/HtLdhe+ph0zZITRzkJram?=
 =?us-ascii?Q?VAl9c1l8m4CrelnjhGR37kvSEq+NDXci2rCToCBTKz2XixNFfS9k/cdnZ+k3?=
 =?us-ascii?Q?dYQKQsDCIy2poxYkCz9uaYR3RmSYqgIpulcOY6yAG7f5ESDh7K0IGy4uP7CG?=
 =?us-ascii?Q?BAoyiyvPK80nDtzhy8KW1KgTsS4FVoupnk/R2D96xC9BDWjUG1kj5/nMpjTS?=
 =?us-ascii?Q?jRTzhbQIKrCSAgDEuaUgS3+z7zEgy8g7cgcWZIWjVfiDQjZlNqEXkvi6W+7p?=
 =?us-ascii?Q?RTZrKHaFiJmyy36Bw3s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:39:18.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a45a9e9-3d6e-4e59-1cdd-08de4f5a9459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532


Jakub Kicinski <kuba@kernel.org> writes:

> Import utils and refer to the global defer queue that way instead
> of importing the queue. This will make it possible to assign value
> to the global variable. While at it capitalize the name, to comply
> with the Python coding style.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

