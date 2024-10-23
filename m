Return-Path: <netdev+bounces-138175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800F9AC80A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E0FB2107A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76FF19D07C;
	Wed, 23 Oct 2024 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CfGcAlhR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719491CA84
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679624; cv=fail; b=nneAipWkTRw1mu0YIPieNuRTAT/8dBNhA+y0fTugMZ1Oa4b1borlihFbWgxuX8QuGXOlovtwOODthRG0J6pAqxsxSlnDB6Q52SH0u2iVrDthQ5F3/F5sSD1ifdnBkYiIHPHqk0Oqh1e6VlmH0beWXsrQxCQY6kLyYWNOZoQ7ktA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679624; c=relaxed/simple;
	bh=1DN4WJ4zas1HOL3cVt6qZF+H4s4PTD+/6x9LkLurPDM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A+u1B+5egnhx2jclLBK6375JF0hCJ6mpQ1tFYbrANmOA4rhxbXM7H/1ZpXq4EUjth9MS6ovsp39fE8NT9TUDrgTQXaH96ulT5/mz+FFNVVJZE6ozBL7yRXQpGakPeRl0rtSNaWIeu7UyvQV1qVWtosdN7OUR2Jy9n6fipfszmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CfGcAlhR; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oprIcKDmAoE26yRBi6FyxuLJC0TppLj8AMhGmeMJqZU08YaZqZDth0HYuHAwf7Ix8se+rCk9+ao/NT0THkoQeNSjdsB8xoMQdprxEjSyKEHILUWbJxqGVibl72KGYueAI1MjCjz6iH22cffDUSAATIj1Q/xSVdPV2jQiG5xQjWYCY+bYKCNRg/Pi5EjgEGOv4mc/dhNVXb7wuAD+H5gge2S4fGUx42Y4ss1OiwaeY/jSHKbpFSIwr/BbtUkvgTY9L4/2YYPqLnJpn993U9I1p70+w9FqW0iR+EEw56gFC7CDQkxDuyFTQw9J9QzSA9j+7YHMtLG2zCSen0yrhMcoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DN4WJ4zas1HOL3cVt6qZF+H4s4PTD+/6x9LkLurPDM=;
 b=vRs4k6dyfXMK4cnTOQZVnwaGkI/J/HZfDcZh8sH1dKKJ2Wl2XUjqQuPGbFz38+fhTIL3T7HuTX7ymXh6HfeuOGOzFRUBxDifCd/1MWkzXnv4N/30t/OB5KYm7J3QIwuxfmnk82R1S7NrD7Nl5eA6jsiCDTDfZrmtW2uxPTNJjPrg2crWp26RYxbD0J6YHGQhRFD8TBa66/bi6bC3nND+Oe3h3gNrt6t9pXNoU2fme0iajBTerq45EF+KnHBiENRB0PU5DjnuZpb9Jw1jz6JfDOBTQBuRLRE4hhxqJW24Vs3z5LTBQ2xDSLgSSnQ9nqt9VLOq6MfbIwpAQhbL6WX/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DN4WJ4zas1HOL3cVt6qZF+H4s4PTD+/6x9LkLurPDM=;
 b=CfGcAlhR+uwbYvWy4qDovTiUUjc3qXFA4LXh6JVDlTADxdu6y/nTm9OSoIPggaMLkhmC9RDtlf3wJPlIxJY/mqVKaDj8+FNyUVpR43HBvlzC6O/AHsRzRGIaXBBEeFKA2EIirOka71wXICBTbqAGYWSEMoeUWO5u8aHBi0dyfoy7PX1QZjPaUHEMtv86mral7I4PVXiwIGw5jyCm/RCBUb1OleEjQclctUytQ9VzjIcj2m3gCDjWX4uBWJ4yNatLwKGYzBv4kiZRie+o9/kIBcXxuwI6ve0n1NqykA5uuJ5IS0zP0pD6Fc2WXZM70ePW2fdlYXQbt7dPzifcNNZoag==
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 10:33:40 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c6) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 10:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 03:33:27 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 03:33:22 -0700
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
Date: Wed, 23 Oct 2024 12:32:28 +0200
In-Reply-To: <20241022171907.8606-1-zichenxie0106@gmail.com>
Message-ID: <87o73bhzwx.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c39ed6-3799-4922-792d-08dcf34e2902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mxrytuYqN/0jUpkbSJKkvMk/0nPS2LuXAgDu5OsGcxmip1s5lySZcPp0FDbG?=
 =?us-ascii?Q?mlyqnikKhgdtGSkT17l5XtL6jGdlERPLRYdifFmsgJLb9RaQzbDf9+SkxLGX?=
 =?us-ascii?Q?g8Cq+3RqP73N+v3pE2xmj6KpLSINHSUuJPesvobw1tyv0LGFF4/CHWC6CSwO?=
 =?us-ascii?Q?Ne+veCmNpa8TDktUET5ncJWilR5lvu577wpCuZ+mrHHitaopzz+3Zatjie0F?=
 =?us-ascii?Q?Mh9TPUTrD9bpI/9M1oZ/2cQEvlMHfhdMGPzaAo9dEXgZE1jlDcYT3WjSsqRU?=
 =?us-ascii?Q?WMCgUL7yoRALlGCfASMYhwyaglT0t6LUT0/BrVojzBW/73cR95/FsrKYId70?=
 =?us-ascii?Q?gEtHHdf7voyCNyj4qdA7UY9c0mT9E4gtvZAZKTMSbqgP+VO4ZZOMp2cz9/0v?=
 =?us-ascii?Q?Vm0n1gvqaQiAbN267KTFqpscMcIVMlB9CPpDv59+a5MXCvtcXPMrt4/bCBfT?=
 =?us-ascii?Q?1xLVsxxqQpqd32zHxJEC6p9ZWTbvvX9nWvwwTZQ5Wcy3foSOObMLT4ivK8MU?=
 =?us-ascii?Q?i/Zz5j4dkz1jC7gNXWdvMcBIc12gF+2tsQ32FmHQAOqtuDZp/JSjlvfU5/sS?=
 =?us-ascii?Q?VrLAf3FJ3/v9lPkYn9jUaTrS54oZQALWXQMFj3s0cqLeEgj5J2QaRRP3HnAQ?=
 =?us-ascii?Q?hBP9oA88eoTjNOiie8kHghX9SCbCvkb0Giia+J8buM0Wl/I/DZzGXxnlaa/J?=
 =?us-ascii?Q?MmyIEZ5HGWqz34ntjbVtQH2ymc0SbQR5P3SQu20CWjAFobWmMhAzB2Bv8kwv?=
 =?us-ascii?Q?CY55cH+BfQ4NoxzgrSUzoyazxanL0n5h/fwGhHHRm9WGnJJPOWsUzmVSYYvU?=
 =?us-ascii?Q?+sHOGU6u9nI3hk0EpRBVhKTnpcX53xaqI4sw1V2Wju8PtodtA0+1vjjGWk4g?=
 =?us-ascii?Q?eLxt0aIDSUR/hO9Bn4tGWI9YIbH3vyr9l80/D3Q/wW3w6Hor1Qq+0XbBn9nE?=
 =?us-ascii?Q?kV79gdwwyznaMFqNiSftSTxjMJaOR7c7thTkawTXlmzBTiiSQD8xpDsqOy+c?=
 =?us-ascii?Q?4HnxVY1f9MQ6D3De2jzrRyLTCngqRxzG49Hd4sROzl970wRN9kblkGZMvTMD?=
 =?us-ascii?Q?95h+XZYza3vOwNvk3lCI0yeHDHXus/GMyeWBorl8AauCcBnEbJowJsvtXC/O?=
 =?us-ascii?Q?9t7QoIhzGbXtB81sCb6VVQ1UIeDtFJOj4h1UaoRiXREVarySpa0iCp6XlWe0?=
 =?us-ascii?Q?yttJdyLJM+FsE0YNNvlzDQvY0kJ6r1v9pdpYyF13OechhX5VbYawEKyh5lzk?=
 =?us-ascii?Q?cZvaA1HFEd9f0eGrgQAaHpbJPzl3shfUy3d+SN/u0ZkN7GHA0cU5hRRWWqm9?=
 =?us-ascii?Q?30iumb6cvp0bPv9rFeh8lUMgZEV5it5i4KK/MCoH5qnJGZlElIhVT0ZvWL2e?=
 =?us-ascii?Q?r2YQCNyMW8Yno1ydOqB0+UZow9qzgNwzy93ImMrtAMgS9QNCSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:33:39.9544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c39ed6-3799-4922-792d-08dcf34e2902
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196

The subject is a bit long though. Maybe make it just this?

netdevsim: nsim_nexthop_bucket_activity_write(): Add a terminating \0

