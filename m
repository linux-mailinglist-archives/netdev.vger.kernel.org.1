Return-Path: <netdev+bounces-116751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69594B96F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC5AB2151B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3C146A86;
	Thu,  8 Aug 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHAHA3sL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F2145FE0
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107752; cv=fail; b=B7wZLhrcSuGFLbPmtN0Kf9W0dhyiWt3rr2t112GTLUX8WEC8GXPS6Cpf8I0GrUEgD44IZYic1vYZmriuabj8v8V2eV8VC5opjJ9nGpz0IReLzoYFd8pOdWQwX0Nw+cVu05e6dH/NPFjmhzqlnDf5y4e3PAgEY5sRrOTaO337Dq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107752; c=relaxed/simple;
	bh=Pi0KkL8K5G8HLjzUnzhFa1fHgNOeBXeUhR0HP0G05+Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WxudD7a8iiOBM75qWq3m9zMJfV7Betiv845l5I/9jOaa3r3CIK/3VrV+2+DNWKjx/ARi3aBSgLLua+20XG1PZpEVS8RYyp6wbhuTk9GnFfYCNaZ1qX9Ety+RYD79ZD1vprisDfcCJN/VogWGkXtLlOkYa5mLLIMmXmJDgDybAUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHAHA3sL; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aV3s4rZMEup6qaGcPajsfb/9sp1Yr2bRxuVghh+xlujdbHwMpu6XtZggCu9l808GfdRNZl1Rps1/mui9suzVjgPSbmMXahWg0qM4A3H9V6izRJnnvZJpRIB8vTR6Dse1lKOeVJ0Zb0QTMKQvjwrvHAQZeI6EuF4waW7R+XX0r11kMYnQS1SbpqClHd7S3+nJUtwE5d+BajKOLTsi75vEkPu3EIAi8aG/1RTTkp8git+oNaPAJfI5b1yHYf8i4ztr4rfGC8AkxkT0EYxvdooxCIbbM1BU7vJ2TjCUTbAT9QydO1Zb2Ik/tY2vJvLwSSkNCwwousiRx8L3/LKfnsI53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi0KkL8K5G8HLjzUnzhFa1fHgNOeBXeUhR0HP0G05+Q=;
 b=VwY9eV14/DiSkwge/S0w/Kj10a8rYt+EzN4yxE6YgNVZ18v5KL5W69M4F8I/npCtf4naZPPIucTD0VVFx5f1wO1xjtq3DmEhQ5QHW7F3ozCrrksQWNmtbVXlO9Uw/74QC72VzSWhTLKquTgZlh4uoH7DNMsVdijxVdfMNLB7aoOCzZCXQ1lWpPQidM2x/FXV/ieVNhOTnkvJWDMmfr1By2VGr5mSAvWOJ3AkSWWMR8w+SUb1wbpw+kmGUWxP44knBzbJHfcZS5tfAp1qn3eJbJ99VQrKgDRpt351Yj6fcZhtsYG1rksYfm2WwDzMA+IZhMojsuKLeSR1fuHv5+4Xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=solarflare.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi0KkL8K5G8HLjzUnzhFa1fHgNOeBXeUhR0HP0G05+Q=;
 b=iHAHA3sLpHL/w1TNTiC2y7l4EW/Grr58H/emFMYb5qWDB80fUDcP6GpaIDykBANt0YA1AiTydrfS5RgR/hdMW2JLPqBzUTEg3Pz8zuNWptb0G1CYRD0fh+sk9odaZrH4/wUVqqVKg1mh92AW2O1hhN5x+exQPpBrrF+RzqQMyO+J2+nbw/8Z+j1TP/ioYt0U5bx0MFQ2irIF0dePdbXOHIt+kqqZKw3+D0rCxU+I1d6N9zmstZOOEFswpDBq7pl+xwFEGvKeA0V0VADh2mHgZ1vILtXFjh8gROsuon11WH+8KAsVBS9ygmQ0/e5nOaXoXsXaSOOgcc2przA+nXBSTg==
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 09:02:27 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::51) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Thu, 8 Aug 2024 09:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Thu, 8 Aug 2024 09:02:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 02:02:15 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 02:02:12 -0700
References: <CAHcxVNOf38nOzoWZ6cxxFUpvkfHPYa+DFZ4tBBYBntkLag93Gw@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Gwangrok Baek <zester926@gmail.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <mkubecek@suse.cz>,
	<ahmed.zaki@intel.com>, <ecree@solarflare.com>
Subject: Re: [PATCH ethtool v2] ethtool: fix argument check in do_srxfh
 function to prevent segmentation fault
Date: Thu, 8 Aug 2024 10:09:37 +0200
In-Reply-To: <CAHcxVNOf38nOzoWZ6cxxFUpvkfHPYa+DFZ4tBBYBntkLag93Gw@mail.gmail.com>
Message-ID: <87wmkrmlps.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9c6bbf-c1fb-4852-916e-08dcb788d358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LS06OGgJoYy9iqB5bmD1h8yruUziexvDdCM5LRDMJC1QBI+nXYDA6BcvLW2?=
 =?us-ascii?Q?4ycqdNcolo65t00XaKY5kjKoMy9ZyTD6jhr8zSoG8rDrFZ+Y6YGhLWgS37mP?=
 =?us-ascii?Q?1ySo6tiu/TA1VpjC8s83sp5nCXH56bV9NDuMznrwBw6Iuv3+ZjVDfneF9dLR?=
 =?us-ascii?Q?P68w0D344k/Kq7olovShYPinLgwigLghKDF/mVq4dFAIL6MRmQ5L01MxwVGr?=
 =?us-ascii?Q?rTthOLiqrvTnybOcO2+wYtk4idY0kyMZE+LyPkf5Dtb2h1UNee5LgIf2Rh31?=
 =?us-ascii?Q?zCV1u0v/VDK9YCBj6zFBLaaFU1orlC5K97VWhrk1EJe5AEbzLpDIF9i3RZ+O?=
 =?us-ascii?Q?aZtf8J61f8NTDiS8/60zxlGcdotz5hhQm2la93Uj3XgdTFzY9H/VO2o7X2G4?=
 =?us-ascii?Q?ELXYPziBh0BU4Fm/v92dJFOiKOux8gkYhqZPk9g8DGHARc4VV+W/Zc725B9g?=
 =?us-ascii?Q?olf9UilF9SKPNu5+CByjfZaZ+xLJe1zdr9pGPPNoP9UsQZlOyMQqhKwbC7Ey?=
 =?us-ascii?Q?HppCZLKgbSR5wXt4CGAV4B8tzWxOwIGNVHRjze8hNc26KAd2cxQPVkFrQtcL?=
 =?us-ascii?Q?u1SUk/MDcsJxncoafuSyNqNhFA+RWhkvcimtBgHWphUEF2ovYqE1R6kojAuE?=
 =?us-ascii?Q?fV0GCifpyHqFntYATQQFH1/vMRFZomsQ1pFe5+U5ufIMCSbxXwDSh/nzgj6S?=
 =?us-ascii?Q?dtqKV5qLIOTqa/BTCiUSw+FEmRcUtQtahBQj+eqMRX8OvhA9yBkbL/k/uETG?=
 =?us-ascii?Q?A0ov8M68ci0EjP9r0meK8x/vKrd/m5DPBMH6PElPBtnqgO6Y2TH99ffnduPx?=
 =?us-ascii?Q?yHaGWVCvneAjftWcML6oiGRdjsZL2T42/VxenZFXHcchn+plCu30kkFS+9Ft?=
 =?us-ascii?Q?JTXo5cCrno39vyxChyvTtlwbVHdwxpglZxgzrHAEnNghrUq67ZOcxb6y07Jb?=
 =?us-ascii?Q?LowhtuxVBd21SwZEeRcn6ACBbt3aaW0DFCc/V/ne9j9sjpgzoLRc+ZWRnISH?=
 =?us-ascii?Q?/WEwjnEjISRIfDFO3g3iC0alZSbHy+YtNiD6HeChgwD17lWj5oDwPotF1N6g?=
 =?us-ascii?Q?/P0WScvpnbHIRDQv6P0IW1rrO6Eb0g/4ixM9gsZ8tAIjOxF5jb93CWi6JzLw?=
 =?us-ascii?Q?A4jn6yh+la3o3IYYlRHmXggTWUC5T/ZrpCwT1nvh6h88i9HXENSdlES98Wjg?=
 =?us-ascii?Q?K9Jsi8xpw+6sxTd3HtnrpXop2rKvV+LMYfjI1lhD84mEVXkAoUNd1jR54tX+?=
 =?us-ascii?Q?+vfZyOQp69f3UR2Di01gmrAYtoqbGyZRh1k3aD2Ge0yb/VP0/MjN2Tr+M13T?=
 =?us-ascii?Q?ObGGmdJ5Zw5U/IBhtNim3pTu9Xrxm1jxYktnD/HVEF8fuMfqwShETpOR+nx1?=
 =?us-ascii?Q?Q+jHLRKDFYRB15638p9yn2REfZLHXnK1q9N0r/cis1pkQxpmygdNcaJYCAu2?=
 =?us-ascii?Q?OHjabL9r0rNskBDz/YQaHFh3jWPttZUa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 09:02:26.7125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9c6bbf-c1fb-4852-916e-08dcb788d358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496


Gwangrok Baek <zester926@gmail.com> writes:

> Ensure that do_srxfh function in ethtool.c checks for the presence of
> additional arguments when context or xfrm parameter is provided before
> performing strcmp. This prevents segmentation faults caused by missing
> arguments.
>
> Without this patch, running 'ethtool -X DEVNAME [ context | xfrm ]' without
> additional arguments results in a segmentation fault due to an invalid
> strcmp operation.
>
> Fixes: f5d55b967e0c ("ethtool: add support for extra RSS contexts and
> RSS steering filters")

As Jakub wrote on v1, the Fixes: tag should not be line-wrapped.

