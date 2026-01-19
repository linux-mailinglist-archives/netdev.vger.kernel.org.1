Return-Path: <netdev+bounces-251015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44919D3A24B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E073043F36
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273A3502B8;
	Mon, 19 Jan 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UWy3C0S2"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40E350297
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812929; cv=fail; b=KFDms0BZxsY8skrilz+gfHlnKQmSeW/tAIwdBYPwtfQKDkHyzibeIVsPhxJ4Ou4xtmNiilNkekmM52tdnw2xyz6SDkPuyvGNam+AuObUuisqfj4tsEtIa3mRK8MvN+aUuNHbo11hiMcaj6SxwFxBwR4khTzJamUZtXT8XYCFmZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812929; c=relaxed/simple;
	bh=CoUr0HW92+rgdCE/lHA5uw+E2nEHmjU4p8un/hiFxiU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VS9czVQJwW+KutTsWw0QeXOCoKBzolDGeOq1K0pCs3liXgH0dtK9HTguRXFMR+qpGx/57o3dKGC8K/eoAKv8Yaf78wuveYkXnJxGHfdfv+26rGfpmCJ6tDOJd83LCpvOxynED8ftV2L8EXZBZCIOD+BQkjdE7eeLh+5nTdZJOzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UWy3C0S2; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C67n1v762xYu+2htLFfs4kWYULYqPFxbCVetKZnlCANLndYeiyfaLNzhXSl8V75Nf45yXCYUF9Gk5BCvjD+kdKauEmNVUWR3Ua0nV+fMMO6r/O2GKQoNjijStS3u+7Kum8cVQwOsESg+0z07ciOJbCiNn1c5IFAjNdSv54OYLHn+dUBFTX5RIbfxK536lg5FtoZXUPlAQtIpnJ+kFQOAaC5XVkSs3NPhxHNIAhhXNVnIKzwf7OYcQjnDG5ggJp0TuhfMAxIYBkAiS1NuU+/Mmha5UkTAgOswkgPx33rICMu42Xz5/uh/j8ldra1OvBzrIhMbg5eeJ0mU6nxxmpJvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoUr0HW92+rgdCE/lHA5uw+E2nEHmjU4p8un/hiFxiU=;
 b=kcafSEvsuwmtErDgOvZeq3o/nvLPAT9gvx+g2EyhsEMn/KQGaAm+4l7NulMx9FgFdnbbUYrTIFHTpOycjYRp3o1LkqQw7zTVjrbCBzvLGwDkFPc7UpqOjI1SqriotQFduoUsffsP7qwQg/YeAxf1VRDTG1X8tmFihzqMJUopHLFJci5gn7ov4h7PNvW1syO/0XaelzzRgD40twR0Oz535OUp6XKNR91aNPAsvrh7nSRCnJOy04J21Mqv14VkZHsP7z415lwQ449N1cRj8fLEJcpWnOEyKQ1Kbg3b2NZETHQmGd9f5oUKhHWdjXlA/dzVBYfKoU/U6zfSIMqZ99FDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoUr0HW92+rgdCE/lHA5uw+E2nEHmjU4p8un/hiFxiU=;
 b=UWy3C0S2FM5LE5SjdrohhYPf+olsCZic/zx3BS92KzSZZW5YqjuVJ5Px0SZXbzyO1tbaobV3YSYySnYJdacAr1X829onCmiOZzk30iifA329D1N/EHLRyux5vHei+keukOWD3bKZo0182YmwOuHLqNuu4I/VzTiEuVcePkJd2Lfn4JaIUM5UvQU2Of2o56vfTODveUXv/+T6nr8syiYNM54QTSJhrNiBXP9mLCDpOFVG8MbBJSf6t0edFUQJWJV7ATSUOgS+wigc/z34scDXlnn57CIJKwqu13cbeSnhyiUUdL27ZTMOOX61ITR7BNDa5FwL3HDwnrob1ifbJNmP/g==
Received: from SN6PR05CA0022.namprd05.prod.outlook.com (2603:10b6:805:de::35)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:55:24 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::1) by SN6PR05CA0022.outlook.office365.com
 (2603:10b6:805:de::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 08:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 08:55:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 00:55:12 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 00:55:07 -0800
References: <e1528224375ebd8789994668a286fb3105dbb2c4.1768225160.git.petrm@nvidia.com>
 <20260118022629.1105469-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <petrm@nvidia.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>
Subject: Re: [net-next,5/8] net: core: neighbour: Inline
 neigh_update_notify() calls
Date: Mon, 19 Jan 2026 09:51:03 +0100
In-Reply-To: <20260118022629.1105469-2-kuba@kernel.org>
Message-ID: <87ecnmhti1.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b73321-6fbc-452d-030a-08de57387be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v78wazDYlZwmV11khCZJwb5njR2kv7hPwPC0iZ7oyri+HaDd9MemPkOO+wMD?=
 =?us-ascii?Q?y32+yflKIVOV/ajdst3rBqf7BJbpp7HumODX7LBB+9kU9VI1/JP3FJNZnX9V?=
 =?us-ascii?Q?zhjHOYCMqMh2JZ2xHgVJgUTMK02xHremDcgv/EOx7lKp5clFNXpyZPqvMyh+?=
 =?us-ascii?Q?yw8Gp5z2RAyGCcHKzsUUTQKTTsZPt0IUwbNOeNcduyhc0OZfSB1/TZnTwmp7?=
 =?us-ascii?Q?KB223k4IyrXER3hnzwUPe6yAhxpOJpOGRtutWg6M5t04CkH5W9jujsOVkn3V?=
 =?us-ascii?Q?mnI0rtXnrvP34vVm5HnKPUSA11vtlgsdsswgZju0C/jHUBt5QTlBsBxEl5XA?=
 =?us-ascii?Q?R2FV9VmPfAyoxNgJENUnMHrBE7+PEJ7Fd9+y7YX3seNDYmwdWTMI6vqKFb3u?=
 =?us-ascii?Q?iM+6REz5xXSMErCvE+rDzUVn+hpuit8M9A+/qVxNbCKWO2obN4eEiBXQqyBC?=
 =?us-ascii?Q?LvLxSbjljQnLFR651MPl0Pp0XbIUNawY2aY0GFjNjBY1zehuZa1TL+WKeRbP?=
 =?us-ascii?Q?z5GuRe6p5D96iOR0MD83GPP9iE72xKMzQ5zVL5HWDVdiBHXKSZakCbfqEwVd?=
 =?us-ascii?Q?k280Kc66TVPvk19w6wl80NZ1KPOZJYsHrFgdCLlUgI/Sa4lPWFmvNI8v4Xiz?=
 =?us-ascii?Q?LHZuUhmlA7YWZRi+fQq7mHAEgDQuEQS4IB5B1NUBGbWzo2ecuK/CLNFDeSru?=
 =?us-ascii?Q?i1LOjW2ej94oaifUfZS4ESi7T7ZskSj85TbOTXp1kbzqUSTOA5i0hhJUNAcT?=
 =?us-ascii?Q?CPm7sr9aohmqFaGEF5N5UpWshNKxTU/Ww+gbltmegB9SXheGTfwOIzP/NmhR?=
 =?us-ascii?Q?olES1nQUAis9VfAOu8p54A4VN6/al7VjD+VqnPry/1Bn1sPB5QT6Qn3+FC0f?=
 =?us-ascii?Q?TJ+qWy3qGdYIX9XRIIw9bqZKd7XV5lmx+12Eo/cWvOLhongMzjZws+YaGWe0?=
 =?us-ascii?Q?wxIouirlgzfFPIE4xRYiEWta+a1Ncd60/YtcOecmwRETu7LO8ujj1DCi2KO7?=
 =?us-ascii?Q?9hHI4ranfir7fuF+61fTGu5gRTVB6Ue5hsRsFb7s8iE4Iuk1ThUECGKduwZo?=
 =?us-ascii?Q?SG9g8ujVVjgZRNjeGU71ul7gXC0vBN65aTKRsUw3ikSMqef7DOXl1gR7U+Wc?=
 =?us-ascii?Q?SqJrvDwKHsiPY2u0RPgZgDdQIVnstKDvesCU2JBbpVOJtNd8RdJQRLyFXVOZ?=
 =?us-ascii?Q?4AE4n8Y2HfyfQlxXfwkQBnv+dahhLpcKrD5bD6nQTEHn1Yt1XS9o4rytrTul?=
 =?us-ascii?Q?S/VcozS2tmnOddlKmTOf0e4d7IUrQqKE9QgyCWUhb9wFLMlDCLsJkG9qal3y?=
 =?us-ascii?Q?1O8S/37soqjwOdF1WWXACXZbUfo1TFsnUhEyekZYCbXz7jywaiImrP2kzBMo?=
 =?us-ascii?Q?B3BiYgcinTA3QqZT2VYfLehlgVkTUZ72n03c3ZyduqcJuS6DDls7Zn8RQWK8?=
 =?us-ascii?Q?EA/DKZLJwj0S3VBwT0lxh/EjYYGrBJUP1wx4uc7kVAj4zLCQlhcvJ7qshkG6?=
 =?us-ascii?Q?JaR8SUT0r6OdJNfIsjshKxMBhxsQbCANE/V++TzqiS+RelljSJBArW5fMWgR?=
 =?us-ascii?Q?z428J1/YIpd5jdAWFCYuITWed9+X+6MWLWFLoRUp4hBH4TXFc4iMhftIcoOR?=
 =?us-ascii?Q?IEwdJrwVyuAIBXANAb1UoRsKed2AWVuqThIOAcS/R3RHQN2GryylRA7e96FR?=
 =?us-ascii?Q?fIHRMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:55:23.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b73321-6fbc-452d-030a-08de57387be0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670


Jakub Kicinski <kuba@kernel.org> writes:

> I'm a bit behind so I haven't validated this myself TBH,
> but in the interest of time perhaps you can TAL?

It looks legit. I'll send a v2.

