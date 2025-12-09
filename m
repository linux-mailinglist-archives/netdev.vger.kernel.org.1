Return-Path: <netdev+bounces-244136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F60CB02FF
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE28B3020B24
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB772BF3DF;
	Tue,  9 Dec 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pqApNUTI"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99A288C34
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288898; cv=fail; b=pV95yTL2N7jy8D6oeMrrR4BKp/SmBWYuN1xaKaT4u0hvX9rFpIfgb2EL43NyIyjx7lEO+BBWfPHCQh/wpkijFSPAGTZEjA4OatlGwzZZViP0zs4GVeXqiwVmiRDdGR/9/LeZs8ESdjlvhbQBQG4fQoUcUcUBW4iIuWGk3t2wi68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288898; c=relaxed/simple;
	bh=KqeFx8kchZO0tU6o0Y9qV6/03GzKfPqJsiO6szCgesg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FDcFcHqCaHWyqaOGw6rCayYYWDERezL/biA86se4FzwVK05Jj8DwjJfE549SB/D8hJ8I0SNq7q7gxJ7TQjJrEfjGJImlnma8JZBMmJXP7btBxouWa0wDQY7BMe2WWDmb83eU1ePq7WDE3LhtAydkLQLBT3yvPyJkgALOSEjhxao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pqApNUTI; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhBNAWUEYKPyzulZ3aPo+PcvueqsBOKDbaj0wLkoew63c1Uf9qkPDdmtxI1Jg91qBRT4dGuuOuD+bdusRs0r4mia2yrWfYlJ6gAQDmx1kgZ2r2qg5mmsCDO4EeGmDIN83bideP9xPFJWNlATR8j2JoqW2ZDqOjjmdCO/oT+bZPPg8rNdzUxzqgnJntF0oOQWwMHXAJ9TNMxxpl2eUgCRaX6RrMNPhSp7u7LJKsciZ39r0AR73c+gJmj9/XRgBxt1Ck5F2v6s2CRe3EXZy9yguhFffv6YFk9R9a/U+9e3Myd9HuGi5baeJNWuNbpJTZCboc5ykRIT1U/jy3NYcYDVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIoY1wl5vpqbryl+Rf2Cdh5rcOFoT+on1jDTwJrrv4s=;
 b=sB72YWZZDJ5VkzeTU6vzp5UwEA2Md+reQKFVkAeQM8jBihcC++NUz+XMdh9t5CuA3REYhOeRx+UGtRPp+49DkhGYZTVfKrFDYRmtI42Tk8FhrsoYp1NGa//DuY0SzqC/DhySruni8j+v8qurDl6kAhJRRnziH1cbsWUNumra9JkmStK6OuGxBBVAKZ0GzyAXXE5i5zrvvH1/WKDGBRjF5SIknSwXXDMRm2Knn+rTNNPuEqf+io56a/v/VQIwzGWYC/JNO4+Bgzq3nDx2a/5Xqt4mSx1tDSLd007oMYT/s4zT7jjqx4gs8F0wu7qgAssFn8tULR7rDo72B2mLSSvdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIoY1wl5vpqbryl+Rf2Cdh5rcOFoT+on1jDTwJrrv4s=;
 b=pqApNUTIDoB+yKfkctkFlxTubxb0pUmRSD4Hb58tzzI6hoel7sChj25LFMBpwPQt61iAI7ZXznz9Uw5CUfQyrSPwYuiaoCd0GA3fEOJqECVuWA3ovHJkJJwHObv5j9abEt/OaU1Z1CcEIkfyDrvySdJNKtmzh5quJRi/ksQYLJFLMtdos9pIu/K8UpT8UqmplHbgEohQF8lEuaFqJjHQFzprX8hog4yXPWzLtuCPddAylpNlg5jixv1BIXO8lMiEN4Smkj1//oSKiZZ/8aIzuzLCr4XCvdgUriJadBxt+698M2TzB4GDz4P2FhTrsRMDwjWSlJgdeKyE+gt5+QN04w==
Received: from BN0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:408:e5::14)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 14:01:30 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::6f) by BN0PR02CA0039.outlook.office365.com
 (2603:10b6:408:e5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 14:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 14:01:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:01:08 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:01:01 -0800
References: <20251208190125.1868423-1-victor@mojatatu.com>
 <20251208190125.1868423-2-victor@mojatatu.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Victor Nogueira <victor@mojatatu.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
	<xiyou.wangcong@gmail.com>, <horms@kernel.org>, <dcaratti@redhat.com>,
	<petrm@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net 2/2] selftests/tc-testing: Create tests to exercise
 ets classes active list misplacements
Date: Tue, 9 Dec 2025 15:00:13 +0100
In-Reply-To: <20251208190125.1868423-2-victor@mojatatu.com>
Message-ID: <87ecp3wy93.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d68ab6-960e-4f2c-5458-08de372b73dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tugopuVoOZuJqUm6Roxu+gvxPJV13rPDRQS1xjZiwDKnLoIfG8JCUx8Rxfo?=
 =?us-ascii?Q?sWX1EsSozir39lqN7ZpDx09AePEHldHuSB69FXvbjruk7ya+iZo0CDb5f7KV?=
 =?us-ascii?Q?e9FvwKyK7TVxkC8L+/pwMny2PGX2UNm5XSLG7youVBf63Xh5iPs5f+vZFx6B?=
 =?us-ascii?Q?p0kSJdK2MWH3c1zZCTFc9wUal9mx7f3EJngEUvvERfm3J6bcoxyNZqNShsi8?=
 =?us-ascii?Q?DeS/t6rPUtTBHgc2E/c4Be4t0ygjD81b71ePdDlf4CP7Uxs+TZ1AmYMf7LYh?=
 =?us-ascii?Q?HJvGS/ke+jkIrurvLrIpJ1XIqlQw6FPJPht9Tt/r6EbrnmFNAVUDtFFB0b7b?=
 =?us-ascii?Q?4SWVQRFHTmTfdr3galCPi5AJHULzBwtV2YPpFu3BSj75zeDlutxXP7a6Wsep?=
 =?us-ascii?Q?FBCOizcCoLvoUKa4UzCJkeCjWa5lYVvDJYCvu6QBI5C1nxpYQb5eUI5Y7Phh?=
 =?us-ascii?Q?isTnoeSdl4meiHqZG/4+Dt6o7lZOc8pNG0dyM1XTgkwb8NP6XXIVODMwECED?=
 =?us-ascii?Q?vlyrEwP2tkzS6JJ1y2Nupt6CKkj4AGr7WisS9WeGYoGRn99B7PK2DwByDAHT?=
 =?us-ascii?Q?fs32cEX8nvXICKPZt4tOTMDwAUEFR06ORIpgLKlWlUD2Fb58M1JefAgXEih2?=
 =?us-ascii?Q?6R+jvSYJ8ZSoiOBdH2/gRavtlUkS/Gx3QaKDpGX+E4bKkMOqlXACvLUSjjSQ?=
 =?us-ascii?Q?kiI3wurMxXiNDZR+dCMWhEb2LlJH8iVXETPD3stg/unsgGNLjoMugkyXqQa8?=
 =?us-ascii?Q?hHhJL/i6ee+VMhcVRgEdlDDcc0x8dxIolac2FD9qXM+5D1KaEChjKXk6pUJq?=
 =?us-ascii?Q?D5HLB6nxC1XVwcILkpM96ZTXKob2yHK0PRPj6zqDQHtSM2ZJpP4xS9gzace5?=
 =?us-ascii?Q?I8Byi3pSiQxVg7vn9yjghq0RBFv72SS602Kx5Sye8CdweB+VUvO/JF+v9l8T?=
 =?us-ascii?Q?8N7tMlLO9iCFoWT4guCTQmAMIpJjLgbEBms5QZ7Fjc7ErihiZsO38fm+gwNm?=
 =?us-ascii?Q?OiMUGlBKVNc2Eau5zvAZ63S6zlTEy3YeLcSyR4yYnUND+VtF14F7aYB+3BGp?=
 =?us-ascii?Q?qe2L3NL/B6F/qDBZWJ45erjVQkC9Zl2gDJEnyamJKxQuymoNPcLMIqk0aXle?=
 =?us-ascii?Q?OVsxk+PM+qDIOojCLw3U5X17Ay/OEEXxtJyph3dHXAVxMfck1QCDo547OpDW?=
 =?us-ascii?Q?WWjXNq7++haOq+/q0AwBR1ZO5Q4VuCBmEs8pOILNejzPKro0HrfgtyGiU9gX?=
 =?us-ascii?Q?5ubJmhD+1mpf/ALjB9uBp7xRP8ynVa2OeKJkh9zUMi6hr1B+SlhphDtbF/32?=
 =?us-ascii?Q?jBf8GfyCv2cDvPK8tYBKSr0dSJZiaCTEoWNUPwydNWqWvPkCACWza5E/SMdJ?=
 =?us-ascii?Q?xarqfI0G1Fb9KuJiB9aQndcdwI6P9GAdapTMOLz4LBD+pttttV9BTaxI6RFj?=
 =?us-ascii?Q?lCCnMdDI0O8DWNUKIRCnojSUUxKvOTUmm+tW5NYdu4hmYWynJ+iCNAmGcFWA?=
 =?us-ascii?Q?zzWUCaExoWU17o7H4NE6Npg/006EF0MIMCP3G7822MCfeiOt7L1DEL9XfJ17?=
 =?us-ascii?Q?+FOe6rwn89oegzx9F18=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:01:29.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d68ab6-960e-4f2c-5458-08de372b73dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9


Victor Nogueira <victor@mojatatu.com> writes:

> Add a test case for a bug fixed by Jamal [1] and for scenario where an
> ets drr class is inserted into the active list twice.
>
> - Try to delete ets drr class' qdisc while still keeping it in the
>   active list
> - Try to add ets class to the active list twice
>
> [1] https://lore.kernel.org/netdev/20251128151919.576920-1-jhs@mojatatu.com/
>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

