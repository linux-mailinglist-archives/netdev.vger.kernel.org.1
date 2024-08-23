Return-Path: <netdev+bounces-121351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F48595CD91
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45BC1C2099E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB311865FE;
	Fri, 23 Aug 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSDZ0wpQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574E18628F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419007; cv=fail; b=OTRzG4OUuPUUyUkW4B2hcubxOOIrJKjQKuN7ccOKE6xRkA8sOFhBykcIZZbb92G+0klaPO0wv2rVz/5n75P7+kZA5AYQiWZSQX5dHYVWxh+0aMwDdt8NpVtg5qa6gJW6bxrm66JG7wTI25VyFk3yB6+MnDQGfwykRGfbdm1f/XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419007; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AOcDJtcpORnsFSdBfSucsXmEwVBfeYdHixNqqbyZ/bFCspOYno2gDq85v9VDthKQFnmZ+wIzMLc39bgVpH0j7+pSiXDCIiZ5RneXJTRohjsMsjtqbmyowgiHB6mZAlHiU801EjDarGZhob1hrIJJqo0Vmfo5U5pAXBsPFbOkRbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSDZ0wpQ; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMoUCvBByPf51pF3EkfRtspj4zEjLKbWdzBBCN5ReijdruNFpVCIO3n1TYSbAun/A36DZpqQLC2SSL0IRsflOh1abQMne1TdOpDBCAW75KwTxC/lGAFdpdYUpwwvNvB4qYguyNNo46iYIEvD0PjK964nnEVtBqrtFSvFUCCISp5qwTiPve/nGrnifWakwUdFmQ2rnVKKl0mUc28MseSfTkEfRPqwn+box3/YmlLOWghignBCevysHdNO+XsUOgl+p7wdYP+pfOdEPmRetF2naBY+6HZBuarBoFzxWa+QgIInthC/3HrkqJkZiF1CLspSKfb4K+Uca+Xohlg+aIBNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=y62fHNDmBifoDXzisrUIvb9WqJn17E9Z3ZTe0vLKKBPI3YrV98PANzFnZVOl7GowF8YzNo1jXkAcQqcMja8SJszp5MjyLGO2DigtPn9vtvPnXgWbiH1VTp8Eu/BrK+GJYpArCGd+ivTMarYddlD6nKuYygIw/nFkPly72HE3lxTAcXWAYEhHUm5PyeQGoQjMdUeHkhwi1Pj692DyJ9mg+lLey3VAU6DoZYqt8dY6Ntma6VBfNZ4VAfRZ9I9IMWZ8ak8Jk13/pVT9daLhq2FET6uu1OOG6vanAQhlaYWQk4uo3Aen0QghfN3yAyG7Wko/qWnYJ5V3xCeiOicpXPFTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=iSDZ0wpQIMpwCkRiwxqBnnBt8lof0l+XW5GsFmNCA33SB2xNb4Lj8BapkgyXSNMkIMCURaZeiy54Yptn0d5ZVVNw5j1oEdWKFVCreslH7Y5qjKX/N+SbF5UHedkMam4iZ7iYczn0QlWRvRXS8FZMw3sTIVqa0Oi7M5VcPmk46v54Ujas+02UAp5POTwSNjG+xqm5Nqaxn8GYuDOjyHOhnp3MOFZgDKDv4Ha3j7UdYFoSnCIRihW/YPBRS7Fks6JsIHRuCOHvxVj2yeXoMGZ3DXibFoHc+sXy0yl3NMf+6u1595wQKaCcOtJRGiUE3aViO/v47aYcZNbSGagcWq4BkQ==
Received: from BL1PR13CA0388.namprd13.prod.outlook.com (2603:10b6:208:2c0::33)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:16:41 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::b7) by BL1PR13CA0388.outlook.office365.com
 (2603:10b6:208:2c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12 via Frontend
 Transport; Fri, 23 Aug 2024 13:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:16:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:16:23 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:16:16 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-10-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 09/10] net/ipv6: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:16:09 +0200
In-Reply-To: <20240822043252.3488749-10-lizetao1@huawei.com>
Message-ID: <877cc7js6b.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5952fa47-a367-4d75-f442-08dcc375d3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5xpXmTQs1axIEF6rGX2Wz0BBoW9pBtF0yrNGwrsI+AkzfJzPve3mRIzY4FG?=
 =?us-ascii?Q?P0WhmPunbOUW8XTf1MkqMluub7pGB7864oB3/JNtkatagDIuddp9kzgu1YRa?=
 =?us-ascii?Q?CfYS+P8ReBFhY11WW+WgopuwOaEvSGC7DpNhztWQIVPxmHoNnmLp92DXh7P0?=
 =?us-ascii?Q?r3fBSqA9Bm/W+6pKDo+pbKVDHFnSuRm1yZRkGapYm2Ur4pGTRaCmOGBjXVxh?=
 =?us-ascii?Q?ctDthd/M3btxMAxbSCeshAfJOee38iT5iGLz5xJUua4qiCNPW43TQ7euQSc3?=
 =?us-ascii?Q?ZWinMAIZ9Oo7GG4di40YLHapBhREk8HlkOVh/qhKi28BWJpJ2uEjyL/+sycs?=
 =?us-ascii?Q?y0C7322TVNAPfCKteB6fg9/o8rI9SAPhpF/5W6EpFOK9bS0pESYrSTEWsUjJ?=
 =?us-ascii?Q?5/fq+9uFWuYfkL1k5tvzCReWY2zu+xQlohfBX3r53XGHBzOFFlYV416zwPcO?=
 =?us-ascii?Q?M3ch6sRqJi8gZ+Qh59xBdEHVWAphpccs0XzhqjB22JZZAyE3Rzf+RxSv+ypq?=
 =?us-ascii?Q?WvmndPgQhISfSJVZT0qqVy4UfgXZyTnpOH1Ap6B83GX4MqZZ9VEprNQByN/n?=
 =?us-ascii?Q?7+qygYSuNh/PBEZc7criy6BZhV7iLsbYWexQJdudm+cw1j57gywl8ix0tU4F?=
 =?us-ascii?Q?zM/lSSf8IeQdLiKJBi2IJyyNCLnOMMXvBam+l0S6gmttB3s3xsnh+qEZjv6e?=
 =?us-ascii?Q?idEtlubF4kho8HfvSuzoYFqaNQ8cUZdxiPloPQk7XLwW5wQ3BzrhSY3/PclH?=
 =?us-ascii?Q?lIe6Vgv5MNJ5I6U6gILC8wtZiWfsLWlmpLutt1PgbMssJEmdNzVXDbod9Ztn?=
 =?us-ascii?Q?HVEoLuIhRiZ7wIsfmjdp0/pwM2QyUvvmY/UBwd812J0plfshs2ZVEG4QaCCf?=
 =?us-ascii?Q?EHLZwDUBjjLfScAcYCTpWvamxzllQgcCh/2eXaFeg013aZ0hKtX6NytqAlef?=
 =?us-ascii?Q?RKNjCKQmHWHR8J0jC5xW1FE2+vkB4d7wSS/AAy0turN6MD7KdyBfRWvAi3XL?=
 =?us-ascii?Q?EF7eZ5fWPoaUfPuOo1OZe0e9lwBeoJHO7PW43LMT/a6Cghr4wfbCY8f2FVFM?=
 =?us-ascii?Q?aCPEuTY2GozrU3yjMcreg3Gum7CeoekieLtM2subXX9SVh1H82ANUQhnMt+Y?=
 =?us-ascii?Q?a9RdpRhmwhyEU+mIjxkmH+geaR1cWfCaEL/EW0T2sqQr5YidE9uLbjf3fDUJ?=
 =?us-ascii?Q?XIZEJeWOoF8A+ZdssYqcuM4dD07mS+oATwdT5jbSeUxhdUh2fGvVIbvCQYfy?=
 =?us-ascii?Q?dctXsMyf3F7gEj7XwhqZ/Obm2k15lL9DpPDTNY4vgwVjH0inKZUX4kEvic8h?=
 =?us-ascii?Q?qzH8hXkb7jYG/guT/KDmyPECDE+iGfq767wNslmtfWf3FMCsEucF5kwAc8wx?=
 =?us-ascii?Q?rRjB2FAMaxV7LK/kRjxyc8EjmO7497zVEg9bwU+8Dm7QJ4kNTo3qi3ljwm4F?=
 =?us-ascii?Q?IWC6Zd0nbnmCzjQA5+Mr9F9dS5zODGgL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:16:41.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5952fa47-a367-4d75-f442-08dcc375d3e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

