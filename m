Return-Path: <netdev+bounces-108206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CFD91E5B1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13162282D7D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A6816DEC4;
	Mon,  1 Jul 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwJZ0jB7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5616DC35
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852302; cv=fail; b=diT6PGq1h6bCh0oABzDEGnnb8MWSvb9137WYwP3kHsUR3z2CdOAGCsMecFezmbMS7jPknT9nCkBRmb92sRDhKybZtIJ5MHt6sUozJli1mK6Kydma0kpuoLUJDhRcu4isHSHEyU/nveTxE6VjL3Jfr67gX2OAadGB3+Cf5iUCw5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852302; c=relaxed/simple;
	bh=FBDbL7ZhWadHhg8TqPp8EXBH7AW6GDLKEzqWRDNGrtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KRuuAG2RHBZm7jnnT2lBs2rU6/LSWt4tutDNrgM8qcnidqgXU6gcJBh7qEfvu4k1qP66mJIVEqX97HdKccOSaU6Mdx2pwC3cApYUkjhAfD3oapIelz/a+fXZxNVxh5q3PVw9h8JVVniuCDNYv+bvCP86DUQu6Xnqd3gt/l86eN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwJZ0jB7; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhbyPzaY33SqVR2TgYOvQS57t4BXNCYapqrWZjux21oiYI2J2cCkWg5i4Bzfo3XVSOd5AtFZQi3tweG7/LiTskn2fO77fsLB9XCt7sBJ8NXTW6bFe87Dv/uoyC70eguYc5mitcZsY8P4/CD0EC1P1pnBI0ej3EjfkltK0pbN0f87O+GHwWUhWH5AogBXvnCBGbTehmdsgZyGkheCWnEgWJIYDk7snrS7YI1UWxRK6n5+XpTrGbaZk7qR/LZKQV/iZXmtzlCwKzASQT5WOlfohWadwOfPX034deVE0M0uvL86gHqUs2n3wm1EujSXBB5HpIJko8V3yA83zgDM9tbCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3ETSJchrmxgjHkv8nt3GkVjvwayyJ74sqvtdMWxGJY=;
 b=mmBZLlZrfnbqMPTqgr/6FoMbL+PQby0qoxWpCq9jmDOZIORcFce7fPUN+WJXmgS2nCHm3lbxqQa1qfoBXnfljCitsokLYMfvGvWAxV3VczYosDnsHVByvxjbao8hf+AVu+DYazqG4S4uFLJqwXwyjw8kFsZwrnbsYy6liv+2OWGGSO9NSiB98C2yNGhOdzKz0tDR+XAKPQQ3A+dAqxnUYG1XY5Mr5MUT35jIc6Kr6jFEPABvdQTs2ShbTVHbnIT9937OIMOuVM19cVZQW+UU78sTke10M7ykApTc1ULID2pWOMGZ1rPnETJHSjrn+GvGBohuu2d5hUN9CallPrr5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3ETSJchrmxgjHkv8nt3GkVjvwayyJ74sqvtdMWxGJY=;
 b=gwJZ0jB7eAxDhpdgzsJYGwEnSQ8FIFp+B7G6PEsV3UpdH1m0Rqwa76M3GlxSI93Nyo85OjrGbKPn831ni723kfvqCVdTJIoOrNnwlPucgWqQaPq50KIWq9FFRFWldHIQs+3bFCiIOO1MNxiwAR6+fQM10XIl8dOI7Xheo6Rc+CoJJAs2Ifa1NF2HceqBi+517+4W1XfeCe8e//pUbpQ1R8yuS+8x/hJGHfPkXP40reE2tiQQPkS5AePHxBuTYzVg6+Fs89dpmDJkB3+4ARUdAdSon5ulimXLG3ei8UsrlFOOyT2IsqKAWvz2zmUTyoi6OCbTr6D5BaNXWe0hxomLPA==
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:44:55 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::35) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.18 via Frontend
 Transport; Mon, 1 Jul 2024 16:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:44:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:35 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:31 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/3] mlxsw: Improvements
Date: Mon, 1 Jul 2024 18:41:52 +0200
Message-ID: <cover.1719849427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 65067b47-cc99-4fbe-1149-08dc99ed2294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLNNPgLr3dhkwwNgoSF5jHovySyZCAi9z2OSVGZB1eSaVOMx5kfHUB43HmSN?=
 =?us-ascii?Q?HHBncba62tqDW62+sVf2VUOr1/0I/WVc8yXoA4pvcFGEqxWNRT776JnKSrnW?=
 =?us-ascii?Q?/7oCv0Z5O9SS1WxfsaeKEmXQ9hOfeu6hE+ZCVBkpMbkmJaTNXl7OKuCPIBvP?=
 =?us-ascii?Q?69l39sPBeBZNiPB701CN8LkBlWTqLcruzWihboMs8IOsHrpn0tz9ZqMu6t5U?=
 =?us-ascii?Q?8Kn69xQAMGnCY6R/NRvoJgtLSirSUrMQ54Bkcr7nBfrW2oS/SOb1nMPd/oWW?=
 =?us-ascii?Q?Kp900B966cokFOWqzQS3ur8DxSX3k1DbPZDF/UEJrDdZlXjyh+pAX/C5Vhpr?=
 =?us-ascii?Q?Lm1ZGV4+gg0VnNTkGc2oewELDk1alrKWjY2EVm9RPdyZC5EY53xNXL12Qwfo?=
 =?us-ascii?Q?iSu0SJ9Zzl0qIgH6fgEKCRC02PZhqFA0aqw5B5YWjtchQSBR6N+ejYQX5OwW?=
 =?us-ascii?Q?4Z3H4ctR+mwvsuHggrvx/pPeq4awoOcHGudzX6eUru24LCPu4qPPyd22l4Cw?=
 =?us-ascii?Q?OitaZuZIqoZxgkBSZJWQQtdjXewp0bZ7wf7LoS88sEH2e3CfsCyEQm4jnBdJ?=
 =?us-ascii?Q?ANxPswLtnQ0kdQ39eHzFBAsuxt73v/4xYTDTjGfkBtkchwfj5INHUszcjWFz?=
 =?us-ascii?Q?dtqwrzJ8YTc4gLDFSu/0GWPGwqrEY94k/3L9Ffib/Gwx/7LEqWHF7mgTQXS5?=
 =?us-ascii?Q?43LAg14FriwlsCW2cMdy8ZyOdG9Sy3SZwyyJG0SwPisrvawds8bImXLXSean?=
 =?us-ascii?Q?8sPWfqdf/whdgNBrDEVH30xQPxieDfTaI4no1ToAoshwPMNsIyoywPMWDD0R?=
 =?us-ascii?Q?dyrx+rVoES9bX8NtZuRotbrjx/xysntUB7MXwhrYUlNnvVLQU9bocVThi7k2?=
 =?us-ascii?Q?6CcIdOhnBYHesGUb7xyUKUhUPROAU54aajQagdx4BMltsg5RqLJQXJPomp3W?=
 =?us-ascii?Q?M/FdQAx5MMYWv89CMlOiMl5FU6iK6iomICaytMx9XMioLJyiXl1BkAIv2Wjj?=
 =?us-ascii?Q?H3kfV3sXR17ywhrFUl+tREHbiWSOuzPrzO0pSQl4gxAfiOITDGjdkRxS1NSd?=
 =?us-ascii?Q?66QYG+kJYUReooapVXlsr5n7cVfjmMo2AyXa3xGFyaUm8TVDsstyE+pSPamG?=
 =?us-ascii?Q?D8Orno07asTcbWd0Smr711kWmOXfUOCnDuI7GZMhVhtGP6jarh1v6RZ60O9Y?=
 =?us-ascii?Q?xWgNlOiM1PnqzwJGcX0tS0VH93dRpLvN0RZGnSKPHR4xX8QbNA/jZXzjcd9Y?=
 =?us-ascii?Q?uPhk7yY+Xqc2XOYKRNIe49peI0b1geMnwZQTqEnfZ9bv6w+Atamoa+QE5bqk?=
 =?us-ascii?Q?JqGf/SRiJS6wEC3t1RQ3oJzQsXhGXKW/JqvQs+DltsVDrswN27ucNjNIqd6u?=
 =?us-ascii?Q?/rvVHWYDZ1sJK9sFwze0pJNtZiwd9mvyvuIQGzSwUh3yTaDOez0/l9XOofXr?=
 =?us-ascii?Q?ZPHkZd5alSm48fskL9phx4/cO9ARhPSo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:44:54.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65067b47-cc99-4fbe-1149-08dc99ed2294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

This patchset contains assortments of improvements to the mlxsw driver.
Please see individual patches for details.

Ido Schimmel (2):
  mlxsw: core_thermal: Report valid current state during cooling device
    registration
  mlxsw: pci: Lock configuration space of upstream bridge during reset

Petr Machata (1):
  mlxsw: Warn about invalid accesses to array fields

 .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
 drivers/net/ethernet/mellanox/mlxsw/item.h    |  2 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  6 +++
 3 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.45.0


