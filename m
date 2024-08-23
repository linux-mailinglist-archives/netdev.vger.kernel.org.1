Return-Path: <netdev+bounces-121345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D195CD82
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA030B22B30
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CAC1865E1;
	Fri, 23 Aug 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZBGdv3D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E5149C46
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418882; cv=fail; b=XjMtc9HkqbDUHv1z8IpGAKK6GUJbhyHrBwbNmjdmcUK212GMoo73XvRiWfgNf3go2UZgUesg0F5CkfzdIfDDpmnkuCIPV+9hM/ubX/9SWIAAVSXr3/WNxGEs5aIge1nAONq4v5vfbm92QBska6zQgxRehEhPniXnpWK+YsaAXUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418882; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fL4ZbirEESGXPbgq+KnZvM6yBIKP+dbLHEeV21P2UDlYycvujIiWBO34GLfEHMlHHplWkIan6gV7J91NhOzaade5SBWXHyef9WmP4vV/Ut0y3I+juWeOXb9bhgMoLUcNhBbDfHlb/QFla6V6vWTKUX17ftL5yBFSSaL4DWrP0m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fZBGdv3D; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK5UEwjZNHu2NxYI1CpsPemjHqAJPlttLrGFuyCcGRyiq7G2GJpRLhhABC4iML6a6yslpH6FPE26LodazGFS03fELMV3yzPO7TlcslRfEnHLLtIJkKa6vrnYFyVTKWO61EoHQW8XDUBRE7feR1UxZKJ3LXeP/yYcnQQrq51FAYvEizzwWsFsjgU+jk7JupPz3o25DidjahBPpsjVXg2JfQGxgfb1TF1x4s371vyRD1uYzR6oOL6iOP8mXnNh9x4mTTdq2zw2DHAGRoLo/Htl9cGfoWAJPp37DHJ8cjqoEJDtIDqDB/AzZOld5u5Cvzmhz5WChr9RdNECg+bIRooiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=gJpNlP/+sGBdQrcKenp/TKvgeS0yodkHiDodm7IkVr6A9/qztt4km72eAX+V2RKso91yAJwJrQk0sXTfxNCNcENbALXn8DDU2FcJWOA+GFwvxpennhH/8X9rXednA4W5+ks0GZZy9Sygozm1x/wMbpUoYVnJ8fC4g0u70d6XWZLeyHp081P/orLIVvRw1vT4jLSXHE/56RnJQbjN7LJ61z+/j9m4K0S7YtSmFpeFXS1K5JzSGetyuvpAvs/CJKs6CJgK9RnnLdJd2FtlYCmaGJ9wcdFNX3qU9z7u24Cx1XE3HG3bDZ4ipC+xa0EZVtvRNuM6DSMkfbKzoNPvwmiezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=fZBGdv3DkJH6XZaFEnB8dcameBc399FNtPppdfOZt/v+Esfmqro04xTkJ5doxOkh7nPrP+Ev2LS7xmZ0bb6w3XLP7kvqXB8lmXzuF/bIZpGzgHfEEuhI9Vgl2hmGVDwFCEYOVfdqAP4cA5BaUdILzdeRyofEJ83wVWQ3hIoJ1V0c250V9BNYDAIUtzgWJeNgoMWDpqP38dTTo4e6kSYSD+GO2JFuAspsMckHBNc0Knxrccwho16orl6QUoeR1+spBXv2WA2s6Xc6L26kQ3dTkeKPmcp1P2OWnLHknsXjIsebgtfiNqhJ7C6JEjilK12xaFbeuNod4BKkZf2LzbCnUQ==
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 13:14:33 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f1) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 13:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:14:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:19 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:12 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-4-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 03/10] neighbour: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:14:04 +0200
In-Reply-To: <20240822043252.3488749-4-lizetao1@huawei.com>
Message-ID: <87wmk7js9q.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dc8981-489c-455d-9f29-08dcc37587b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ls9kMN0s+/V7hdR4kjZ/X2bbC/DLMpgthfFsHmMU1auRWzjmZa79beZu7eH?=
 =?us-ascii?Q?hlpxQHrdxJCHW8AIVEzCDPQcWySlES76rEnebYUZjlT+UMq2q+g8mwVh3MGR?=
 =?us-ascii?Q?f1r6iGj0ZqgjdozghVB9knjYHqhfM7sD5iX4Im4LkK6ZgRrS02uEJ1mhfVeU?=
 =?us-ascii?Q?G3XEbpEe5hN5ZRusAG4syvoy16wsPZcv2MxVjRtAC8RmADMlO6n4qc7TtQuQ?=
 =?us-ascii?Q?tm8bwbaLjOA6YkXs67sW5r3ImrAIJ9RdMt7wMEC8SOP3ALeqOEIDGxT6nBk7?=
 =?us-ascii?Q?OPdVT+BBWcIjz+REmg42FgCTT+h8klbO9zJZIOVtdcqxyKlvP4MGIb5g4UBx?=
 =?us-ascii?Q?VtR9HshSXj7RqsKIpf98VYmdkoGYp1QSjFEBUmWLYwIFF+dFLp8NKcKDp8L8?=
 =?us-ascii?Q?v6A6qkRk7d0+wO8MMF+e6CsD5Q7yT2ua1b0Hv8Gh11kc3gM95m98CZI9wow6?=
 =?us-ascii?Q?AErE2leZxcmAQCgK5mUpsFGm52x0mkH6URXWIFuOUW9AdiDnYwIRQ/Cw6y9u?=
 =?us-ascii?Q?w1LLqwOrPFdXOPUGG3rMR1UNLkLYYLQMf5ZUUHj18psXPcHkkKz2gce0uKxm?=
 =?us-ascii?Q?DKrpzJT3kMckRisobUaQ0tQzSoGQG1KwvWLd4DX7937/QE+GPm+WSXZeYn26?=
 =?us-ascii?Q?5pON6qvxTyY+7bcKiXi3mb5/8XVNH367Kn7+UlavQYAcJOZQH/jX5f7B38sy?=
 =?us-ascii?Q?ExupMZk0DW0Pm+VNnMhopxIMWyaJfxlv3mXOpNRzdF4ftWQCMtBGeD8Cp7bc?=
 =?us-ascii?Q?r7rU2TFdGBxN409xuiFmCsqkkh6rjX8lVl/wyv9jdXXwEVfsCg7sHpM2ejP6?=
 =?us-ascii?Q?uqKf496TpOINJhLcZwznEAwyR6xpjhQbjNrZySkvwGr8favD40aGYFOy4FgO?=
 =?us-ascii?Q?qFP5VgGl1cIhmKhGxEgrVd0wu0RQwQW+GbJCSZrFHwJN6iAMElRZ+Jim964a?=
 =?us-ascii?Q?VUeVRYWyWqghm7d0greTj0kZtWPjIPmfaqVbOe93EGT254jevzEsi9BHlbWJ?=
 =?us-ascii?Q?doYpQOS1nWSB4p15IcmKnLCN44iKKoWCJ5zGGmJtu/ESgOXrRTr3kLuOQs14?=
 =?us-ascii?Q?5NgNlhbWgUVp1mN3+UTSNvz1AczZjkY4BrvMnHCfCC5nzgs+fNbo9FeAfaaH?=
 =?us-ascii?Q?dpQONOzFiqgHh7jFztOMOLdRoC7EnASKs4jHU1Ii23iSVkGYo03qy3Ta+fMZ?=
 =?us-ascii?Q?HEtUvGRtMNcWCoLNic3Gh2prWFeH6mCW9I0XhiuhezYZZ4w3kJ3G86+5vVM8?=
 =?us-ascii?Q?nPEgC5Z8yKzoWnBq2B0/LFg/UAYROlf0pGvnDVUESLhigpY9hZfs5BGWPD9G?=
 =?us-ascii?Q?OcqtZoZ2tBcgqssPNh+wBJiwy887O9r5PU1+NcIgVWJP/jUP5yyaFE23sbYc?=
 =?us-ascii?Q?gW+hz4+D1u4veVCqAVl7n8TVFpWWUOLyH7xadv8svxXGVx5EshEG+W45w6rI?=
 =?us-ascii?Q?4E1cMCWL0jxdQFL+ie+20BS8AKDO1831?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:14:33.4221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dc8981-489c-455d-9f29-08dcc37587b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

