Return-Path: <netdev+bounces-136691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4659A2A51
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810E91C20298
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2301E04AD;
	Thu, 17 Oct 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="avc5gElI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6311DFDA5
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184754; cv=fail; b=feCF3cC+XRVM2gZ5dMt3IDM9TfTm/bw11hL8Ln1HWaVoTLYEEZQnmgt4yfin6syHK5d9/nVZvOJJbnuXi//3Tq7lrTH2PW7uM2ep0vUvyJVneqq3jQr2HlR1uVLozbPT7eQHcM8o94vA12IF682RULuObBpnG1Dt5BbzDFFpz0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184754; c=relaxed/simple;
	bh=AKpY7cuizzdarRsRebUxSJrybZF+at4e5aM88D+u5z8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CdyAUcH8tKFvQesR4jcHslZNOn/tLKl9VNih0wqlXydDumZ7IpTPdHtQ1YvDgRC79KlVgzkf/OV24CS87w0QIUbvTeqXbNrrieMjxB6nPB+vmrHsKdh0DTSKdrsv4tURGUGHzCOYLI0rRb/xjeFmp7LJRWTwdYXwTPQveZHm6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=avc5gElI; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCUVsyLxXi5hkuV7tSf93qWX4/Zkebana+9ENP7ix/OALzSwodJLxX1w3HEvP6THcPboDHAYHXEXZ17L3mPKMmMsRKzTL8qqKKLSvDeqZkDSmN3F5UVm6WpGAPPEnUDJcmzSHMUWrxPlgZNV3OOFTp3tsUTj0Kiwmjs3BgYcLae8rx+XjtCn5lncuWj6gEgplQoXX8iimbi7QWpuSmOs/hMICDk9NgiMj5J5KeJbCp/I6a6EmznLHIf1emNrKkkFqwEXQa479c9iRYPB4Sx49AHDspcTlB3LJaNOXEJE3ValtHi8GT2TSzUFhIrix37AZB8o2tK/Z9OcUBLRmCOU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKpY7cuizzdarRsRebUxSJrybZF+at4e5aM88D+u5z8=;
 b=df6BhIGQ55j40Uuju6+WxV8CzTWNGcnn/2cCRVrciH2Fuq13K9KxkTe9Zw4kuPlKxT2CSOdzZ7RHRdig2GOkrwemgQZ6C7Ba1B0V0KRl1Qy+TfzvGM3iDJ78Nax6vQikVvovQ2gaZOnyzumlFf3XslGzEtgltBj8wt0rZv+Oh+Zawspc6fPNWrsWoNUORqHR0h+kZ+PqGSKD06GMzbP823BD+Mc/riVemWUcysCpK4UgoC9CqSQnX6MnA4+qYV68t/sXOrv44arFouFX+iSxQo02Y1zhCwLB2c71DjeYu4f+NS78ROVuz0AYJQQBW92XUofMnTjqoZtaj93BrhPq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKpY7cuizzdarRsRebUxSJrybZF+at4e5aM88D+u5z8=;
 b=avc5gElIajhEDICq1IVXrA+fyqyyM6YD4X2t48UMcRk+kIJ63YYxotrEu/WwGaIIIDlLUB/boL/p5nSXSUzH/NYwCVORrgeMUVs0s8eMRv26SDT+RwdFIJ7AV43u0QScADJJy12lBqvAZJz6M4ud1F2XEz+YGpXPu890LcD9w4yuqpjvEu5z5Fl0mKxrFYoQF7fjSejz+ePkridkGce6pDR+RNThPD79dzqojT2XawxcWM4YobHTWUKQ84ykoVg/KpvGXW0kVP8XgG3g8rMh1cFj+hSArk4yU1SOGl3pbcSl5EwE0XELbDZuCdpM+QZb4b7gjmkTa4YsRZbSPjhiDA==
Received: from CH0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:76::13)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Thu, 17 Oct
 2024 17:05:43 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::ac) by CH0PR04CA0008.outlook.office365.com
 (2603:10b6:610:76::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 17:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:05:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:05:32 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:05:28 -0700
References: <20241017023223.74180-1-yuancan@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Yuan Can <yuancan@huawei.com>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] mlxsw: spectrum_router: fix xa_store() error
 checking
Date: Thu, 17 Oct 2024 19:05:17 +0200
In-Reply-To: <20241017023223.74180-1-yuancan@huawei.com>
Message-ID: <87ttdak6cr.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: be220ae0-1b91-47de-d316-08dceecdefaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tH+tkJBefmlNS6V71FwHinYcgr9Iw+ZtGmLmhVm1br4TLofLHhRzIVuKUCOB?=
 =?us-ascii?Q?5phREmsJY5FngKWDlQnbQ32nBbL/JqruLolKqPyIm5eN7cGHE7lSXUqt3Vrc?=
 =?us-ascii?Q?EseAVdYztmaZafmIy0RoVQuOt8D7DUi47BACFsdccQfvbNUWIRjspzkrxZHl?=
 =?us-ascii?Q?m6kW6+cWp1KS2ykrMmZOsA1HAPVBrXhjc9SHDJssJ0/32EsKgZM7mcsLO8ft?=
 =?us-ascii?Q?ZvylXvuNqbHA2+axTxW/EeMXx9Z2yQ4msNXObEZm4PlLYYqOfbBdnisyZaqy?=
 =?us-ascii?Q?YZ7yvWJ54ha5y1sZM7Qs+ffoI+MSBS2teYBWP9S6vuav14AVob3xjUMNS11b?=
 =?us-ascii?Q?SCdRVcusaQ4ILVBFV7GBg0fw58dsxzB/EFXPhgOuXJO39Ec3o1NQTK61E07x?=
 =?us-ascii?Q?kR0UZzN872uuWWDmComjpL8KX2tRdsgILRU+NTzvqMmxR6hM77fA4ji0Bj7j?=
 =?us-ascii?Q?QvYdl0RVB4GDvB4qS9s4uPnaIok/kLrslV4NDspSrPa94zMIYyMtUIPP0DzF?=
 =?us-ascii?Q?VZf7LQWW31muCmAu7Uo7wRuJqNFEV4vuU5QUB8dz5Vny8gzSeyLOpmQCSeai?=
 =?us-ascii?Q?cK0rJvg8IvdIcPWUmESxQ/3Oh/3VbmPZj8RlJyZnwGzjyMOBB10d6rzUutai?=
 =?us-ascii?Q?2p4buARyv8oWQAOns/0g6bu3THMgTxTPTjQ0glL5nQTejW2sS5DRSGNGQvWO?=
 =?us-ascii?Q?MjrDpmijOJ5Ahi42RSqzkWITGNJIoikr+AAaIOr9GslEG0aU1hjWXNJ9EUzf?=
 =?us-ascii?Q?rsBOXQbvEZY8eqVsLBJHlhnvHNgbrmiUxxYlEOtb5bCaM5cVa5C0HHZIQllY?=
 =?us-ascii?Q?/njatuetFB1aOnBWhJgpXnSbIPIuYRqVX2IuJ/OU4je69YoWJaemS5R2q+ZB?=
 =?us-ascii?Q?PUcy2JRIO296mjroaBBnhXtYIekBoDhPPwUeYGdjr2zKFjsOFDQFsOWws92M?=
 =?us-ascii?Q?WGULL/Ci//Wcn8tw0cvr9Xd5rmiRelSKI6uUiWRtbVp7a1WF3NZmuqken+Pb?=
 =?us-ascii?Q?UmnHCjJ47VcoEUxpVKA41dLQiXeVx8YE58nhZgLp0ftSWkC9H0H7PR8g/1lZ?=
 =?us-ascii?Q?PqZdvzmvgdvRVqRQpwCUu+T2r5yLF919KBvrOL13NVQV/1EiGeXxA38pk9QM?=
 =?us-ascii?Q?vGJbeDraK2t39qBcgwX5Vfg2MzpP9qBNt/TzXGcrXDVkKeGszZvoNzpPIOO1?=
 =?us-ascii?Q?RXUftOodJbEtjObBunxOJlQQMjkVds7sCS0D7rTgc5lD6jd0RpF9KUsDwH5m?=
 =?us-ascii?Q?9Lzes9GzA6Cn6tRCVMwNR0mEjGjhOnT6r8k7NSUoO5vDV/QW0cjJCGnXmsK9?=
 =?us-ascii?Q?janAdwh04Mnxt2y61IOW1Rzoo+eifMjKgnYiatNxVAelo1HB1ZnRDcuz62zc?=
 =?us-ascii?Q?60oMdfEWBJO1RxAte79gROr8dupxSqTWBQl/706JQxWYRJc3gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:05:43.5189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be220ae0-1b91-47de-d316-08dceecdefaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936


Yuan Can <yuancan@huawei.com> writes:

> It is meant to use xa_err() to extract the error encoded in the return
> value of xa_store().
>
> Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Tested-by: Petr Machata <petrm@nvidia.com>

