Return-Path: <netdev+bounces-121347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1F95CD84
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C558284BA4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CFA185946;
	Fri, 23 Aug 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9pRbekW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB8184544
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418912; cv=fail; b=Xi2BDBVKdcGVFiDNHgiIFs2hX+HELE9tkmbTXIO4D8mErKi/XoTeeg39JVMbniwGOoy2tAS/z97BxMAsgjpJQSH/bRyUwOie7KSBt9WsdwkVwFPl6JAmZhYnJ3TGZhHNkdmvP//+KVnkGpx4V4AojVHSNlmCrHHTdz03xKDn1pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418912; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MPHo5/Mu8l7WbL7mxzLM34yc5CjlnW330dnb0oUHhiRttDe/MkOcRv95ZOA+zC0RhRUHEuqNYM/00yn3bgm39q/8LTfSRq5IKvsvyiDdb+B8mez5tNGLpv0tqmePfGz6wV3ASiBjUgu3z//fSFuqRb/Y8+RZ2kf4aNdC53l7W2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9pRbekW; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srv4ZkINb6roJ6JeDJdQ2vNFyGTV55GJ8sPExQ4tVV/gsAVWrEk9NpSnLlLdh+jvyRJ9feDI3f9urawthzHzmbfrwEc1+Q52V1fpVR8X3N8i9P4z2sHMQ7OD2vvDG2aprkz87aXv3U7FnhTcH/RrulaihxzR0y2Ya7kudlJ26coaKbEBfrddp6Qo5fGRv25RKlpkGPf5UbIHfE+5RDlzUIbFZYa7rI28yjoxUmLNBxPQLaM7HTuP6p+IqV7WWf/gI/2AmjRd2Fbi6IQBNvRG8xeTXSxBbr1vSNQ3xZ1F7myWvsu6gfMrluz7uJQbU67T9v+EsSPOBihAFOZNOTR7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=sF50FKtb69S2uID8iWpLWnR/3gPFHokusVdvnSZl4QAH8vpxrTwfx7nLMtM5o4q1mbWAxybOJlo3JxDBPArkCh18kgHQLH10u3sbbFJUiZbDMpDk8+r+/ihGV5A/JgLn2HEMqsYuWJdrOQzFJSxoNLMP+OzfJ+T+9Kx7m2KO6ZBp2211IwtkH9I0T1nSDAOEwLcZzu2m4xaeOYQxYTMzjGVR9DEXWc9x3SC/qeEzz0cjjNq0OSlFNL7rD7APc/nFgfMJtzorKH7jHtgC57YVSGTVl8uxTU8I4ZpdM3/FE+78i8n/9UcMdpIgD4CtK+ncCSkQfTEVzXn1CZaOrFhwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=t9pRbekWZ20Cqk7PMMvJid9+fyd+PVqE7btvrJzlhDkw1NtLvv/eme4IoRk4FVJTzA5vHvWdMV5cF6CegSAMoWpkHaP01Iow7C/ugCo/xsXPtJ3AAUhr1IEgvEocC1I2sC/Ij1WLnfVAn8DOnlYXMe2STzLFdA1M9J3YJOK8vj+NtQq8NhWaOCK/TzqCkvo6VbaHfBES1gAvoXWz78H3BRh4ZhDo+Nv/TDq+8ZHsLOBfX00vASMpvybZ+F10rz6RLyb03hkVGoXKLG4F78iArtIYrhmXjMtS1KxjAMD4EnhFvxDrlqnM3m7UtTBMGCjtMVpQvXkN2BvT3hEQscHcaQ==
Received: from CY5PR19CA0007.namprd19.prod.outlook.com (2603:10b6:930:15::21)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 13:15:07 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::fd) by CY5PR19CA0007.outlook.office365.com
 (2603:10b6:930:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 13:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:15:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:57 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:50 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-6-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 05/10] ipv4: delete redundant judgment statements
Date: Fri, 23 Aug 2024 15:14:39 +0200
In-Reply-To: <20240822043252.3488749-6-lizetao1@huawei.com>
Message-ID: <87o75jjs8p.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: c1396536-5d86-4c65-14f2-08dcc3759bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7QqMWx61hdHcwWW/I6lvijSpBacHkeIGF8DAlbtf5P+kAk+OkZUOJufpEg31?=
 =?us-ascii?Q?6PWu3+I6It3KFhFBYizuLBLVDCn7bJYAPkI/up4tzvht/sMjLCKx/MWc/KO/?=
 =?us-ascii?Q?6VgcwYO/jyuQyEBoeqh9chVKi8VBjE99/4rGMLAuaAEs/ETNgzzEDAR0mrc4?=
 =?us-ascii?Q?gexzK2L+FWIC73GijSrmfW61lb1mxWcibJtkj/70zby+UAQ1eo4ZYRKXZHVJ?=
 =?us-ascii?Q?Z9pM/6QCgYIuv2Y+Tj3qOtAKfDBiLs0biHc2Q51TbNFL4GWXdZlxV6G99MR4?=
 =?us-ascii?Q?lL7Z/v+jtTzS+o+P8MUwZakXSUf06g3UxTpaoHJP2tKj6UGTaVFm78UuRP3x?=
 =?us-ascii?Q?/jgGYizYMl7tn4Pj6JJXt1cDrcb2uVaY1zyeYGdmTSepen20ztyAcKj8eNEp?=
 =?us-ascii?Q?otBzEhTXNrnPtr+RbVu0fMRrajt2DDxrq6DEUqjU0r33WzwdJjPlnHpZf5yk?=
 =?us-ascii?Q?O4nDO/GHQ+z7b8QLXW/9c2ETzsRumZ6zpvWEViz+x+PMlWXgwlpED1yPv0t3?=
 =?us-ascii?Q?+aiPwkbpM+7PFXEkDUGVDKkIKwUa5O0PTKw8DjxOanzHk7kogck/WMonh1A7?=
 =?us-ascii?Q?1MnZ9PHVAxNTpRo1jkmijtWi1Vzg5pl28W11QB32KVyiKaBtoSguROZEUejm?=
 =?us-ascii?Q?WboATMVtks2EDSX0CilHQMcO3yWxruSX36OR/f4TF0jZ/7pFqsS0eZJFulq5?=
 =?us-ascii?Q?8HYzF8Md5ggCtPiOUX8LgX3Z+c3yQt6SYm305p8btK4dZ0trXc1C10I4ZK23?=
 =?us-ascii?Q?0xIY9ygXqVIZ1aIgFUNY56pa/O5tXQtEcyOu95HHv5MUfRplkFjK4T8CFHGq?=
 =?us-ascii?Q?Imt4kb0JzW0fRw8UNzpUiaqMIKhBvY9ohdKIB8X2Bvooj0LLsnQFBH/UQKFH?=
 =?us-ascii?Q?HFlOmrsegRFrUmN39moHNvpX3Svv/QI23TWQoDTn2P91x1IzsDBxuGU/vID/?=
 =?us-ascii?Q?erWRa5M4j/mfWuZglDQd6CrxJBl1+sdE77SK8LrdjqELSOi/GNGwCc4pzKVa?=
 =?us-ascii?Q?pqqi+wdmJLg8ZakbimdRjj3TN6nTNV4OBM1VJyMybnmUxr7IMlmlAxPQGT12?=
 =?us-ascii?Q?NxZ5UmxBCg4ygAFQOMjv5nbTMIleouAoDBvhOWtwWRG30kq3h6CworWxho5w?=
 =?us-ascii?Q?qF1qRTJApBpkVL+l1pLSM+SbhfD/lBRzpv5qjfPvAHmR7Ud/kNe4nybH0s1V?=
 =?us-ascii?Q?xZI2Pv6HeIA2Nk+Odkh9xcai9Ez7ucbAmaoadghmlCfO60R29B1n9oeDB04M?=
 =?us-ascii?Q?cSGsTx+8fdpttuwhF9YRRNSFTMm8xgurAp1js21dx2xLnAP7USoFqvV54foF?=
 =?us-ascii?Q?HyuxZaS1UTtceVhnlTg/5kF+LH5CNZQ9H683KL9xp3F4NeOu+jhn2xJPoP68?=
 =?us-ascii?Q?fH49owQXf+5q+6oH2dy80VjCvGvDUmNnBREAiDamHXv8JPr6BfFu2zINFvaR?=
 =?us-ascii?Q?k8hXEEfYYzPCfwkIF8pyG9acuWCKANQ1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:15:07.4318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1396536-5d86-4c65-14f2-08dcc3759bfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

