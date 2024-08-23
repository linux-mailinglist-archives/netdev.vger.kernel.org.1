Return-Path: <netdev+bounces-121343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E295CD7B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C241F2326E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661916BE14;
	Fri, 23 Aug 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gX+5Pw2P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE2149C46
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418830; cv=fail; b=lxi65kMKPrzBOyOgei3cQpOAt6JpdZhc2y8EplZVG9J3qyQefrnVZHeqwvDaqGuyaY9AlNRGjrdXo/crLlwb+BmpCccHfudg+xWIN8gYJyGGTuuLPiq2lt8sFkUdTdCrViqtzlWQvRRwLdMPzSN8fQd9gSU250leK8ZdDVqJ09w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418830; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ExHfuMVm6WxKxxOlIEXhSpkKpwKhEr96eBQY4RqDPaNTZ4eZsaZ1TABoSjIAmkilyG08KqJgPLM9tgQbexhFvTN8iRPHq4mkalikVipeZvC/G2zM18B+wvbl7HPQsBKApin5FdMkjajf6AkDFq8+MUnF2SHgH00AqiyzVh3ODYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gX+5Pw2P; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKeJe+U2roZoEEtkSuz/Izmj0WmkiZRKxmFEvxWnby3rtv15Zifp63hg8zXpG7AshNn/i2M6Iell/VnLv9jrzob5SizCk91fx2vfwHAUskBe4ZM82adjGIFQl6h/75AH9NmS5RI0fwiCxNT6KMqgDnQ8cUY5DKLkJm84UQ4jW3zhoFebINyHF1M8Q67I6fwCd4M1e7xg6C//erKoh/MIx+CE8lowd/auoB4raWRnH1sl7BB2eT3Y1lfInASVDTGscKNvOIz0hrkaD4s91CkR1eRyPXVSVhA553kpQ409aVAscuIb2nHlstO8LPPyKqkXG1uUZV640rnf5TZFoP+vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=OhsD6LLDxccYfecLYPTzfFZ1+7Hzh6jiDGmeCfWHUss8ub5aWYvJCdaC8lDuAjUsUx5p5nqKo5tLaSkS7eGUGFqyEJeLs3V4Kv1CnTJ1iZjFMzFBN37aOINMAO9ZhH3D0fYTz5oO/R1XfvUFTPWWjZqM604lVRhHcGMOKrx+u/PPmT6cjYsE835sf3+znE8axGY8DnmKntgvb06ncmwkOEFLYDX3Pr2BDBRqD5WJw/AgaSi58vdLXdES4HkdSGApZqwri6N6Q4x2IdTuf0rsd3Y0cm6bK94YMqNNP0mFv3RMp01jdKNlZL5hmCyIp/VHz3X5u3b3Usbcm4+pCOuLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=gX+5Pw2Ph4YAfbDxlFsdg6rcuxC9aLb1yyyAyx8HwL7v3kGprDv19Z/tUj0sJrXry7RdwvX9CsGyF77yT4wGhfAbg5nHabpjvYcbfqICKhcrKDnUXek+NQR0YtgzR7BuOo+kIkirc0Vyr46AacNUs8dVzPIK5OrhQbemoZb4EgW3W47Q4tLawberg787Cxsm7CoQ5cJo1PH4RwzfxRUWTaCm1PMkwx7/17uNzerhbsQ9vUsvzrP5CrVMhkj+1q8BmYzmXrS9bVtfMyGHvHqBq51fyvZ198beLzdZV4XiZa+2/JOuSOenqPPjQSLAIvuedsarRPG7KNC8CZtHWbPF6g==
Received: from PH7PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:33d::26)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 13:13:45 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::ac) by PH7PR02CA0021.outlook.office365.com
 (2603:10b6:510:33d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Fri, 23 Aug 2024 13:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:13:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:13:36 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:13:29 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-2-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 01/10] net: vxlan: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:13:12 +0200
In-Reply-To: <20240822043252.3488749-2-lizetao1@huawei.com>
Message-ID: <875xrrl6vd.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: b3982b69-a362-4407-cd01-08dcc3756a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sog63Je81VaqxDXOqr6s0Ao+nMtG91KfindVmz5FVjDIEzejbSzpxKOCL7dt?=
 =?us-ascii?Q?ekv0z5jKa4Msnli+rN+BWClJn0J1eBwr6yd/Iiq80WINuNB2cAHTOQX00CmP?=
 =?us-ascii?Q?3uyxjCCs162ZB7p0fMhjNwC1tpqq0auS2KqpoIVyONEw10UWWUxQFMe3MALh?=
 =?us-ascii?Q?RZfg11R0y7BNdvw0XV6TGxqcZqFpdKTBkNmrSwcx3Q4NrUExaybFSqbH8J9f?=
 =?us-ascii?Q?KXPVwXZuHgyJ04okWWvA/Pk17hWSsv09X1ZQP+czOLtgCUcgJe23e6j2iJJi?=
 =?us-ascii?Q?a5v2/C56iuYnHdj0hXfn1Pj3yuBSPYKTu5DhYj5x6JI3h7X4gID13CxTxn7B?=
 =?us-ascii?Q?CVVebNdyc7NXjHUsW4C4aMKG4XZvgLWZr2xAa/i/FdQ0tgCWNHNnlbIZrg5q?=
 =?us-ascii?Q?83GOPEyNZNFnnFqqwH23RGK4vqVwhIMBDlWL71SIeAy6Zy8xtXQCIPobEAGH?=
 =?us-ascii?Q?hxbzvBhay791v7PDhpaBy6rp1z0bQHADLHvbNU+xKKvYXLPnPHs33iaSgafi?=
 =?us-ascii?Q?MO/3BeVZLlR4G8wsRoNNp+9OVSKt8DKnaAv+cSSPdjHf8AeVNfPRXS+76mb+?=
 =?us-ascii?Q?rOwv8al9/FCWctx9ThV0obqY+8Wi2RNFqjOWFpkdpaW+l+kMpAiR6uHdLI9S?=
 =?us-ascii?Q?MBCC/Xw91N2juE78VfQAcGtajOdXVt4C+e66xjaX3zAkgjGzlCCx6+tgw5/i?=
 =?us-ascii?Q?ZhL2Uja4ifkGoeRQsoFrSa64qM88kp9+40l+FQsPFQOSYwcjpw3YX5gHpbPo?=
 =?us-ascii?Q?HPbYja+xY23xD+/M4D+SbB2NZcNqxtwqwWZcRk0xNn2NXeIYn9jtnw5tJfMp?=
 =?us-ascii?Q?A6PnaZDZM1+ygzGPv7AlVk4RYNUnaRGRZyqzRHfRKkxMWKZsOlauJEMEADva?=
 =?us-ascii?Q?7DbtTLC8b429gb51D2hbUjUjjSsIkXzL1fNI3C6qEhBS+HiTLgjtKvAugPPd?=
 =?us-ascii?Q?cwC+69A1ZmNaYQI24qfNbuQjBMAVwsMVB9k9b0JMUSeA4EJsjZyNGHno4as/?=
 =?us-ascii?Q?RHrdyVbivc9tEnPEwht/x+ljyCA1nUw7/UdJUj5vVTOTCZw97NWnLwBGQ/cK?=
 =?us-ascii?Q?MMeCtQv1RX0jxXEiqk/gLxHzcJuQEHWF97pwuKvG4PIo1v2UlKAHTQuojd/7?=
 =?us-ascii?Q?u0jlylxOEM5oWoJYDwVAFBc/dRw1fVu/6nV9l3OMdoeN2Zm7B79C1Ptp3ZHN?=
 =?us-ascii?Q?Jri9nU15+a2o4LsEjBKbtzDoAGNoDn/DAwj8vEJ2EKQJFTY47wkEF1BgTdPt?=
 =?us-ascii?Q?JXSC9Jta/+bLnfx+MQbfyEE7uWa7cSZjGTRyybfrWUWmQLJEWddtx45vFt9W?=
 =?us-ascii?Q?wak+9/MFVSW2GDGyZdjbk2LQKnD1FJ0NBXFLpwfcW8Y6yCGOgr0HTxiphEBT?=
 =?us-ascii?Q?PNEk4FLbiWnJo9MqN/7J8pObNOMaFRCmWSI74ot4yIeGZ0QonJiHm8f66Pnh?=
 =?us-ascii?Q?LcIG0ulMcIqovwXxjUSj1xa461FkaI+w?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:13:44.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3982b69-a362-4407-cd01-08dcc3756a93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

