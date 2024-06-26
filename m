Return-Path: <netdev+bounces-106831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23904917D66
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4785C1C22ACF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF3176229;
	Wed, 26 Jun 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3UXwQ/4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4B1741C1
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396676; cv=fail; b=IVWnjJ2xB8woIHEFwjmE9/a0uyuE/FcV3Th3ggJ2O9jFWOW6Vv1SEcl27Vyg59ybrd1yXCG7aYRoFMimY8gMYXVYUMQZiuq0rqBnLs2Nmfl/GjFzGhRVYrPh1sRMZafNl3WYXRnasvEEfmcYZPir/y1L97aOO8HG08tOCnj/0DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396676; c=relaxed/simple;
	bh=gWmSQed65baEC+/i4QXW8BnUq7Xnm3mN0ASY3nP0bts=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DJ5S6hRkepPdekMbAX512qpc7fMCryzw1TVIs6TqbDUrdzCRO+6SKmiittAzm+11QRAM+KaEBXyhBCorG4ipDpvXVGXcEeMvMSYPAml09tDwUuZDy91rqEMldB5OgPotryUls+aGZkZ6U5eKr2SJyKjmKjNte0tUmVj0U1Au44I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3UXwQ/4; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfLZIlmy/7k1Llm0X457ymPza+SIyColaLngVQilUic5jvLIOk/LLx5bO6iUe+9AMLnLLNIettuM7OBsxC5eVD/9/EIA8SVg1ylk1lffGrQ+tih9vMDe9yXXHt49wCKCtSzf4jz/rxWUZvHxfcTXQ9DaBOM95oJ71+5rlhI7Vn2caD/jZ2emhw4lbdF8aZBQbcSwDLtvs3uTFS1AX3Bzfn1ZtikyobWI1G27tf5hYXv2+QdohZesEfZCkJxPlSy9eEI2er6ifyKSl3MIuzgZgswXEyjBZR2jyl/sC1mCR8K3dZtQyo9Nual+uf5+O9S8lVNClWoua6idyCdttQCU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWmSQed65baEC+/i4QXW8BnUq7Xnm3mN0ASY3nP0bts=;
 b=NZdna25QChsUy+ZcOK61XZcQmlJS5kIMtLayLn6vLfzz0bkDiC1ctwNZNcHJgSXK+wWAit5649+SicQnn+eJt1H+lh/i4JIZM7HhbODekh1mYju1hB+Yvqx3Oz4FknfdES7yeRh5tI3HA4qpvsTUfhz+z9EKyU6BTBKTKbljiM7FpFg8L1v88XDq1mCcc2G8ijg6yDAG/J+at+IE4TPAXSXGSQ9kVeiCVZiAx+TZz5QLCJWjULkYJs6wPrWZGoN75iYjdSTFTaaq4OJVnFZrnSecg7pljF84xxIX+HZ5ZxYcUgWzDQvXTkAEjzk/QEUjwLvaq7iLZnvpwjtS5AVeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWmSQed65baEC+/i4QXW8BnUq7Xnm3mN0ASY3nP0bts=;
 b=M3UXwQ/4Os4Lp+lDUXeTlyjl4WfQT8vfuf6S7BucYStXaEnlBv2tqSdEEg/QTG+nYGXannUy2IcmfumlA2IGMz7boph/e6pzlyXoEIGqevcF+VaJDXpHwbpsWnzNxBRAV7PWVS2+QaIILvC1HY8DVB031SnQySuXp07o0XE1uMlQDTnDzTTQLKdcipA8H/4Yp7KfGwJC3dxeYs9/JI/WuYw9Fw5FztIAREnBCF+W6gzlEXoy1jNANelxW69CxjYxfSgibI8jJKcWO9+kteKNC/Qq/XKzDXuLt+ZUuqyVGz7GYh/qII7FW5+ZQFr+UYLPC0mnyfVKVvMoo2Stn/LMdw==
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 10:11:11 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::5c) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 10:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:11:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:10:54 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:10:48 -0700
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-2-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<leitao@debian.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v3 1/4] selftests: drv-net: try to check if
 port is in use
Date: Wed, 26 Jun 2024 12:10:30 +0200
In-Reply-To: <20240626012456.2326192-2-kuba@kernel.org>
Message-ID: <87pls49fq4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: f99ebc65-09a2-4fd7-cc67-08dc95c84da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|7416012|376012|1800799022|36860700011|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xj92UiUErxG9w0O1KjFM2aHfmRJkZ1Y6mW31RqDwjvg9qoPPiiuWbqZKNpVz?=
 =?us-ascii?Q?lrIKYaenqTHnz//E76yuGdsCFrK1qR/hS5kA1VAnMmqzsOxSZn7A5YjsucxW?=
 =?us-ascii?Q?BSeQIcgNKfA81ziIcfo9Yo7jUFsCCd8zizNteTbnWljmD+/J5h81h9cSHNI5?=
 =?us-ascii?Q?2ckBlTm7q01mBi278fLFZwdwHr+ZI4vpZy4E5MMwP5B/tgeuVSxqTQG+ToYl?=
 =?us-ascii?Q?AqONgwGcBZ/8T15nViXv+2kgl4NHsmKINgH+bm2lsLJiz6AacpIxYpIWmgyD?=
 =?us-ascii?Q?pIy28dMEt+ngukmXoFlZg5HEV6iX/JjmDszR4E3cthU8Kb8NhS6i1YUNZZ72?=
 =?us-ascii?Q?igCbXHmA97SnbOrkToN75me0x/xrBQiEQERoJDUHrtJ22Cm+uaCNvT9Qbpq3?=
 =?us-ascii?Q?zqWSNpv5hNX656MUSzRFH5f4jJg7s5X87Tw+acf2Bt2MbCiXIwYly0ItZDS2?=
 =?us-ascii?Q?Dwg8TUcDE1a9F5cOH9l9ALoVj/ZhZtpggt6Yvcsj+9vAgzGJdLX3lNlLzmU6?=
 =?us-ascii?Q?2rgz+kbqFTHS4b3wlFoptaXkx2msSaLV/M/Zn/XF5BlOoYEdfIZdJHMN8F1q?=
 =?us-ascii?Q?QOCAQnt8iPNSPvqTPi8m+9WdqJewxk4Rc8OKcY1s1Lsr0Wh0gdjbadYlGBuJ?=
 =?us-ascii?Q?xrqm3gvQvlgY8xEm4TwAn5DnqQt7AY3zjNsvE/bKVCvh0L53qkA19eTJIDyz?=
 =?us-ascii?Q?oYPbKNXBHqaSf+SCvMTwwL78PwllHnF68NTE/B2SApXL0xncN9uDz42fxCbr?=
 =?us-ascii?Q?iSUzzfGM6BF+oWLHxUsSmuuJ9sBJneYoBNtIIxCefXWzCu3mIBdW5hSAniaH?=
 =?us-ascii?Q?r+O3bjVpWvGVQQNUX1+twTFEX5fSxK675bGarMLM2LNcDK0n6Rtz8Ky+km68?=
 =?us-ascii?Q?dSVvftPgjglEPg8N9un4K7gPTi+FKCXUH0HOTPd8WDAhwv/PEdGBgmC8KQu+?=
 =?us-ascii?Q?QRelweAROAWWtUy5NyOlF88lq75Y0oz8BwgVgoGgVTBX2UprA6MwAeSjbIh1?=
 =?us-ascii?Q?2V5kEFxz86PUnv9frEbhuYnpzbnXgsfQ6mmfpGkGBN7mJB3fkHvvJpL2IeKn?=
 =?us-ascii?Q?02/e91LVHDkCl+YBTRu3nydEDrrGdLQOPU7iLHeNtXyc+AieV0y84gfr9IJ+?=
 =?us-ascii?Q?lspr/J5dmoT4mcRvK4q6fgNhpnKkICzx2sIH3HEH+f+Q1xtj4dcdKkwWa76H?=
 =?us-ascii?Q?6gbW1+MZ+pDzu7K47lalqCLr+99SKZMRj03oxkYoqzIfgVjUDYJQ+anDKXPU?=
 =?us-ascii?Q?QGG8aIghohSsD9L7Qai8u3D4d3rxQIJ0aMvecPHnwYsgA3mFdjuIuMjnkUHV?=
 =?us-ascii?Q?/I1X9Z+xllmPmTTkvi8jmmnFjh3jv4iff+zr7BQgSyyTd472GnpXCX7WK/cc?=
 =?us-ascii?Q?4Utop9PBhMYRV8Giy8W3jXy7tZMnvKolfprZwv826puQ1V1gs+xXQfCHRgpa?=
 =?us-ascii?Q?Bb//fLq/jjqhJzAz0XXIVls01nYcgaEF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(7416012)(376012)(1800799022)(36860700011)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:11:10.7045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99ebc65-09a2-4fd7-cc67-08dc95c84da7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645


Jakub Kicinski <kuba@kernel.org> writes:

> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

