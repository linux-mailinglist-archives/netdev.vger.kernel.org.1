Return-Path: <netdev+bounces-138174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F0A9AC807
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DD4281444
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529915D5C3;
	Wed, 23 Oct 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rw/XpEkC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAF143C7E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679517; cv=fail; b=qL4jqS5u8ye1L13FMpFVZVTiR8bpO/RH/B4BmTQlMSTefWNn9BL1YKQaaKXzB9qj9p5BjPe9BYtv8VMLIa1cGd1rbwWb2hHRjENg+JUtY54ezCPC7hwEHeByodv6tLKSFmWWenK6EE92kKKTHcZoRYeZC8QHoR8fFKOIN6omy3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679517; c=relaxed/simple;
	bh=wOJGdFPRQNWf7d6MrLk1GKEC34/lR++a1XPFfGU05MU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pNb6D50h4LnuK9ZGfl8uvQj3zeCszh/jaoFB72oXX9Ix72AStfYr3yX6+7t1EDVOmTW8EH4TEio63IA/2n/vhcBE/SuM1FqnWd2AB97s6juTM7Z+z5nyYmSBQ5aQHm/U351wZmFaz4x4+PuCy5wiv0/oFuhCErW8hnYX4HTAbZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rw/XpEkC; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIN873iC4v9fubgiv5RJtJhzwr2uRiLw/G5dkSnSdHVRcSCYfm6RFHMrZXqb+KvorNv6N0WeRyXzsoQaXUY2LiMMK5S/D6pIwpkeBVrJNWqWbSp25//JDzENUf1AcY0IXdr5XiuTLOScUIRncQeARx0NNkfWNxJmYGdNYuSJmwMIZRxH+mw1YjF34bWjePN19bjtq8TxHdWzevv2r17aZn5nTYxlvdPJdJM91gVG9MofC1XngN0TZFUF4OfktkUxqJXQ3af3iJLv1HPJIU5kXAeP2aovV5FcFPPnyLLVohCpVfx/YwYwOQZ+zCk+qasVmOklVRj7J0YTr0SWR7X0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOJGdFPRQNWf7d6MrLk1GKEC34/lR++a1XPFfGU05MU=;
 b=TfCWL+iwTYAzSm8pQfHR6OkOAHsYn/aaicJBPj2u0ATboWkLOptIDjPxgciXfRDpQX4BSxBSPFj4WbN8MPRZvr/NO+JW2x34ohjNJrtvJa7/2bOVOC6Y9aX+9W/hGn5o+gC1RJ0nXvUZ3UrZazRrdyvuiEu+gkyS8YtVwAMqgEOehZNBlGDh3pMJ+20nA6bac9S1UCCcr6UQn3i9Y5A9Y7rxpoRNDePbmvEZGpTzgBjbUKiNkwSoIJ9ukUORBajut47Y0D02ej0xEomhYraIWEOJY/9/a7QwX3e4L4ydKY9djPlDhe3MWtRtYFi97hn/+/sFG5HdKVHYt9ULPJ2kpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOJGdFPRQNWf7d6MrLk1GKEC34/lR++a1XPFfGU05MU=;
 b=rw/XpEkC1x7ueVmcNiumExGHzGMJJJnhRmOPB4frF0FpOnkHGkW9pYEEs+9q86gJOgG51JThvOpDKK0RtEGDKlnDSWiw93swMAyhfGd6Dqj/w3DSBuMtAxKaUpYMVU181odj5/afRE9LHR7u3wP80ufBe8XO+11Lux61iM+6upHXtazEd31u/rAHgMDMu07z5MlqC/NhVYhDbw52t83LeMM10e/QSY2h+0cQcjDcYj4UKK6oz/w2i2B3Hlq2atYYKw5adfDE6JI7CJ14CWP8b8Jb52Wxh/YI5HO7fjq4IQHHPnPtFDk7z4NjzsgVQz7tzDDUQGy4hnrMmCi8UI6w1g==
Received: from CY8PR11CA0046.namprd11.prod.outlook.com (2603:10b6:930:4a::6)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 10:31:52 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::ce) by CY8PR11CA0046.outlook.office365.com
 (2603:10b6:930:4a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 10:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:31:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 03:31:37 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 03:31:32 -0700
References: <20241022171907.8606-1-zichenxie0106@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Gax-c <zichenxie0106@gmail.com>
CC: <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <petrm@nvidia.com>,
	<idosch@nvidia.com>, <netdev@vger.kernel.org>, <zzjas98@gmail.com>,
	<chenyuan0y@gmail.com>
Subject: Re: [PATCH v2] netdevsim: Add trailing zero to terminate the string
 in nsim_nexthop_bucket_activity_write()
Date: Wed, 23 Oct 2024 12:29:12 +0200
In-Reply-To: <20241022171907.8606-1-zichenxie0106@gmail.com>
Message-ID: <87sesnhzzz.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4ac4de-ea74-44d0-0ea1-08dcf34de8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DU8Iqi5CZQNuvwrw5ACf/r3aw5W7RNAYxzUzNsgt5vmrAUrTYceYWlg8ZAmr?=
 =?us-ascii?Q?sgD728ca6xc62bFJJuicD3oy+gPEZ0TWssUthV+6xVcEENZ+PqCqRa+PjJTl?=
 =?us-ascii?Q?jH0cJRga3o2SYpdfbnrRPV4pu7pGsy3o2Cfnckml25r/7XL9B6yslYIdSisg?=
 =?us-ascii?Q?3JS671lUosU/48C31NI7e+ifASDcVu5c0BShjyYQTFJMiT59FSaMcPtUHv6z?=
 =?us-ascii?Q?xkZ/C3U0VHltjs0WCdEGiKQonukRSKXtWm+5Cgkxz2nbJrRacjXDiaNBegng?=
 =?us-ascii?Q?Y3rUpIwAv4Jbr1FI1X6BU3luny1WD4S13GA7leuKvWTmtKBDEZRfh/8Z1Qj+?=
 =?us-ascii?Q?eFc7vNOm2ap4qkFWSUGlF3XKO4rvEa4wuJHEcqTLcVSk200/OPefLPPl3/ba?=
 =?us-ascii?Q?WXYp9xgr+h8JsSlsbcdlLNbqOVAfwSbeA4aPHXTfgDDhMP+lyJv1T0DU3bRd?=
 =?us-ascii?Q?HeoZwislbTQVoXp64y7OukNgcgGehKT3fw8KIj2Vi3qYNdFGmJsJXmT4E7Jr?=
 =?us-ascii?Q?gV0X0z36wSUhGn4taSfMPK3/ahz4PaKooAP4oZ4tv5fMKN+zLD5Ga2O8kDug?=
 =?us-ascii?Q?modPsWyrlbHqpgSX3XNx8ofVmvoOExvKA82teiCcpQoBvYkSinYGNsxUC/5z?=
 =?us-ascii?Q?iZRBRxKgrGa/pkMqd1uXFtaxESjW+msIUc/A3Og3cSXzd5z05lXvwINV6boZ?=
 =?us-ascii?Q?AM3AkQmIf85hBj7q7otXUvWtE3+Hm47YBTbpFVKghKpFe1+WX231t/UBaQ/m?=
 =?us-ascii?Q?+4e6tEES/+9MxersvwpHeng+YJaFpfmPJUDBawHuVLZ7P6Gkdsh/QEOl7/v3?=
 =?us-ascii?Q?cgjpifRyc0uOPKbMpxxeXpylAAoHr2Rwi+Z9QLOudhNlBhAISKSyNXu7La0B?=
 =?us-ascii?Q?ZU0/HIuGWZ7PkYrubVR18NUpYUnz7SMz5YqQ53ejZ9PwUgdLxu7IBhNT70hV?=
 =?us-ascii?Q?zkl+FkSFQMesgsDRTrBH5G0uokJcOax5qTJd1/+aXlCPxYUn5mL+HodHt9fM?=
 =?us-ascii?Q?G7H5mFrIhyHl0VIzgZeWISG07J/tkaS0/nRS7oeYhyKzDmS2LmFr/voyjsrf?=
 =?us-ascii?Q?RZz9l+iGwQN5P2BrpdyOhOgBPAF0xHZDtvy+trpjNMl5Io3tv8LEoOYeUxUs?=
 =?us-ascii?Q?OviEdbR0c0IthiahNW+hwjLJ/kVS5BJc9F6fv2P07UbMN9WgjO8cGWbCwrKb?=
 =?us-ascii?Q?V7suy1xkJ2T+4Bp/fZkPn4VRqpSXOFA+VHb2N6L918dZtcz09YxIZ5T6pzeJ?=
 =?us-ascii?Q?VUV55oDzeBGQcS+zmOODOGye7/Vsf8bMPKNPxRovyl2IrITTPw0heDwiZKP3?=
 =?us-ascii?Q?In08st3x6KmKlnXNtlj39lUswGhTGlEC9LvacqhgHmNKnu0sKIEWVJ+Xty1H?=
 =?us-ascii?Q?VxSlNB1Z7kDgUaSWiiMDwkhPymj8f4hjpTY26Gh9HhD3eFJv7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:31:52.2785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4ac4de-ea74-44d0-0ea1-08dcf34de8d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164


Gax-c <zichenxie0106@gmail.com> writes:

> From: Zichen Xie <zichenxie0106@gmail.com>
>
> This was found by a static analyzer.
> We should not forget the trailing zero after copy_from_user()
> if we will further do some string operations, sscanf() in this
> case. Adding a trailing zero will ensure that the function
> performs properly.
>
> Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

