Return-Path: <netdev+bounces-121348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619895CD89
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3801C22779
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4C1865F0;
	Fri, 23 Aug 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2YSCFv7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5712184544
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418928; cv=fail; b=tr2XUP/rTTCqWlp5ARGaSJ+rNXE1skwMm282dO7wSpD+Dey+eTKn1/PBwgLzvQMG2x7ebjRrn8e/0W7owk9pg0iGJTueorCPHkt7S+TcCqR3qETBsVOrHjHNEx6pO1ABrVG432CLPBUBP+fn/4wpO9hRJC6UxlE/CQWc5y+VSO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418928; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aAi21KhPEagILX0h6KYIPG0YU1/cujoT3cyK1WeO8/LcmKo+m3wXSUVBiWWjh0qp1/OSzInPq0U2wuWf3ohrycF6nM9tXDQahkdKGUY2IB2bm2xPd2/Jij/ZTjjxcel5vLgBMN1wh532T2aFK2kyi0tFaM2wzoFbK2XadOlFT/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2YSCFv7; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr0zTWrwPoQeDUGTzIntbdF4HLy6YPyyCFXK1uBZfx6iB8Tflmux6/+/UbXU8b+cK0x9DMtmKe3PNgFEJiC3uig+PidlCO8BBnqrolhN0H3WzGN683VrBYxNgi7eRFxOApbKj8i74ZCxHadLWvT43u6aM8dQa5ne+b1C+aKscef0LTQ7Idz5eRcO8q8h5wGX2cbnu6kSA2QjuR8qzc6r+dx3NXKy0USAKMxY/zfKPXxDaj9RgEJWGR9+VmXKwruYZ2cWSw00j64Wz9qyCgLcKQg6PFYbjDg5ADZ6BdJ1dVYAh8OR4SkP9a05YsTyGKZype6K4ORAkPlTnzC/SWqQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=ligNFbuSGdL/BkjjLTFWKpBxPUcZ8WLIfOyQka6lg+oyeIuu3pDhlMl4yoRuLVfiUWtMTbnsYBwvC/6U5hCLGCWvtoJfdf1Nd82S4eDDiR6Zq5BKjpNvlzz7ncbl6MAFamYSlOGmFYJiVG+2OybgP/otjW2N2N0gJkqqUZ9KAxDQ325eSopT/ThrlLM3dOfxX0qTdp8p1DROAIdQ91f5ljd0EcCP7p0ZPwir2/MQkrD+Ky8g+qp/Qozt0X58B2v79YSnrTJYXpJmPl8OauLYRAo02OfF0l2EIZrpFch++4OOG1H8f9p89Er2V36c9QojXpCLhNEUUkXg4K7hiUlCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=G2YSCFv7Y+/oT0Lvrca7Iq8AwZCqLEvkMJVSwKudF485PAFDOTmlZ8+OLpqmmOsBMj0P2PtzDmkNMtgwUfZnQ7LFDF4nSTfAC5/oTHvKuLy3mS5PdCZUd95cN8/6qc+74XBxe1ejuayMyCaGthEBpZQVerIhZovfRgN6suwMzSJH3uTyq9+cllPQ/HIPz0NurGm+J+Ag6xNhduNKmak6xOXOuI2ui4ud9juy4GM17U9k8GRVG7VjnCsHQEl6INHtWZ2DOqnoj+BX7HNJJ02gliC5oTFOFwMH+2HX0nRp4jTHBGDnIOvxpLl4V4uzw2aFcWbrK64K/QS7tpFpcMBw8g==
Received: from CY5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:930:15::14)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:15:23 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::9c) by CY5PR19CA0010.outlook.office365.com
 (2603:10b6:930:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22 via Frontend
 Transport; Fri, 23 Aug 2024 13:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:15:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:15:14 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:15:07 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-7-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 06/10] ipmr: delete redundant judgment statements
Date: Fri, 23 Aug 2024 15:15:00 +0200
In-Reply-To: <20240822043252.3488749-7-lizetao1@huawei.com>
Message-ID: <87jzg7js88.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1032d8-a157-4ecb-1efe-08dcc375a565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFyJM5b7ooJNZU3WO/QkEdz8fhWL2XfHRnYLzwNgyv0kdhIERUZ1bDBLh2DM?=
 =?us-ascii?Q?jgLC5f3nwgwTxk5RO4Ff2PSfJ1ZLX+fpU2yjAdKD2q+REycwYuGsmkCW+5mS?=
 =?us-ascii?Q?uDTz1yGPtq3wy4ZkfDNAwRVSwXqc7/xudHPoPSlpVz3SYYdTz1SNyfd3qyRi?=
 =?us-ascii?Q?ekj0AECUUnUZaobtDXowWti95zbtz+gvYn5yaW5ltaGw4rKVvbB4mIWsskp/?=
 =?us-ascii?Q?E78Ah6pVJuFuci4cfgjaLvsTGo/JBkHGvgU2P9gSscNjbbDoprnClknZZGOk?=
 =?us-ascii?Q?7agZDateIsdPWpZL5MDTvzkm+pKHcfbtxGRG8NSXjFtAitxfpHLAfaTI2HDh?=
 =?us-ascii?Q?mIWZ93DZIh6uhhkRrBB/MS0v+MuRHjs37Z7TrNeNPE4UpHq8PlcR5lSB3Z4B?=
 =?us-ascii?Q?9YifbTP6UgrPlhlLgWmKyuRtpdrDsyxQ3uUSWNQyiTPreb9aNmtnSbYZahiT?=
 =?us-ascii?Q?I9gFLnjGCJhso8/rVaxx5w+WniYEsgzixLhOFhKTLmMpavsvgUEz5IkfyNHg?=
 =?us-ascii?Q?4ooaswT+XKqL+G0utovyy+JvRxcg+jtgbKPtOLIsx099yVJ6RLgotfGKczOd?=
 =?us-ascii?Q?9btOOYnw1BfMV4EeT2mRenvr4PIV9r63h1aG/oDf7plfaa+5oxLLOx1Sue0C?=
 =?us-ascii?Q?VFd2wnouw3ijCOwR+Yn/Ri4pSCFXgHGOMMZRRlVJZJNfXcWaX0deDHnCLplG?=
 =?us-ascii?Q?XpOwnqOdqwVI0GYdGpfU1LiPRTeLIVxzdmGOQzt/iZIOhme8LbyYrTFU1K/n?=
 =?us-ascii?Q?gPQuwCqUhNzkEA20VdD2PYE7IC75Y2RRyVnUxscY8dZnwFliNIjsDMtSMf1J?=
 =?us-ascii?Q?Kwxm71XYZST40igBr+lyXmmp63sjkrQf5lrD6MSUgu4/Lrp1IpIZNNS/9rDB?=
 =?us-ascii?Q?RjLTW2g/fV2j7awOiUDso4YYuJ+4sERAtKrBIkl7IYTvVDvLa0y4z4Mn8f2m?=
 =?us-ascii?Q?4bR/++mcoTZDbrwCAPq+H4pDPXsMYC+OYU5HeMRPFUm+GUh6ln2ZLQcnF9nT?=
 =?us-ascii?Q?Po1qB/iiVl3O2GTQT8i1X60xaAzota3kGKRtEqAdlCYN7Gy+bgNEBdLcGBuh?=
 =?us-ascii?Q?mQ53inPdsH5TVfCSsSR/kq/Ro2OuXPz1nA8lsv/r1OwqI07MYOnyaMw2GxFJ?=
 =?us-ascii?Q?wZ5J++gfNVbu1uNfOHamPXzB0vXQNZDtchpbWoDtOrEkfDQDqFZVZZz7dQvM?=
 =?us-ascii?Q?LNzIpiOk0MO53dp/xGaHvOMfhnbWdsIr97md5k7GC5rZPIyrcIfQ5W0ofUjo?=
 =?us-ascii?Q?K4PfWIEW3sLQNKClDOD2dVPIcDzzKW6NkBo3Z0zrdb+7+pfp+BOUKj1YBeoz?=
 =?us-ascii?Q?l2CmoVf2OWtfenehyJ2QTNzn3Imf74S3MDFOnQOPsCykVIXfUQtBaSjoZENr?=
 =?us-ascii?Q?ZPTN62teejTWjCBG+Wd/1OvG0EvqEw9Ep3UT9CdWQ6qjNvklbPtFKtX0sk8W?=
 =?us-ascii?Q?3lms9iDrmDTs5eJFgEnbgDoMDAVGqTo6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:15:23.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1032d8-a157-4ecb-1efe-08dcc375a565
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

