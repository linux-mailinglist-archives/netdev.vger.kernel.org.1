Return-Path: <netdev+bounces-126891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0676972CCD
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C09F1F25F64
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C00188A38;
	Tue, 10 Sep 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MaDYY+lx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF1188CB6;
	Tue, 10 Sep 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958968; cv=fail; b=cLt8qcenIW4ABiBzghYV3lqM+K59R+609wTXQ13rF/PLnMR+z9EU0upAhDA0rlb4R64/Lz94hvdcnJwl9JZfj3mrzNUlgwyW46wPGAvWlZqdm1eB07sTmGCbAHsS7yz34pHZr1rvqeArIAYONr5gmuCD+xs8Xr6wpK6htW5Dxm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958968; c=relaxed/simple;
	bh=uCbnacWyVuRw+OWKBKZ50PHLs/rBhURBocldpYUsJ54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EOvuT2pAG19OSJZG+qyl4HLWNRFJdJT304PXUuBk8UgWIU4M1JdGv6vIvoLKEAxD/AnIjey4uGSV9v/w931JnL6MVGwDADLGjYjzfyo48zTyWvjHB4Wknp8BAQtzYfIA3vlvYt7+tRWGT5edwQswm9p1ScWD6oQq1N7AN0IZeM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MaDYY+lx; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5thdLI5EYhPan1WpztVy2AMI+dhW8bJWNxHmmGlH2vmNqghOiYcm+qPoM3I9nE4LgGOEdzl/bvdQmckz1pBUueB9XUUUxdZp9vcBW6mn3a9Si/ZMskYFwct8L2h0YGDDzmHMHsZ33k+aGop6Is0Bt2ikp3tjajUr5ms4WnJXYxUKIkGzf2/FPTTqXrUobAHVkuxMl5109GMx1gha1boK7ABwWVQs/m7RbEnRvhxWjrbsI4Q8ttESZaPAUf3fLNAtZRokzJqHWmRvzUWRjR+eCcToP+AHF5bfW73d4pujNddeePDWZtFf1Ns5WdPIIZBUV/Lr5nNGMlnLtZmnH00xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EqizNmZMcAaPKN7yP0kULIdR+c9J7aP97wp2gH4D3w=;
 b=V/d4N2kmGnkSFLSgCUWRtN1qnWnZyAwXYcrsYI1765U1JlIlUot0/00GWJnZmDmIFDVnyW68ET4yCHjS6fmgLMxT8mNrrdqyKzR5+hXzaAwGOrcAPVOfhGF/HLU8pJ9EGypHZyZMYFIkenQPn02cKPsFT3v6bSxeeB0SrNfS9k02vbBq4vp0vGAtpFMQNe+zV7f+i04DLCs8soFSZur8ieP99F/iQhuti5DLLiyY+ayG+2YpS+DWw2px1kMHlUg5ghvpmXHwDyQLXngf5Xi2UQFGbWAm6VibGT0wf5S8zCYFH+9uMQB+xuSIdUVdkN+LYaD2iyjNl0B4fJTkz+CELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EqizNmZMcAaPKN7yP0kULIdR+c9J7aP97wp2gH4D3w=;
 b=MaDYY+lxi6hdEZMP0BiyxfpHP+oeofpax5/DFyW+nQXWsPY+JHfQbGdhPdAv1zkGHxlzcoLnMiIWftRopBZEpzSNMW0YBBCHK1f4ZetHtcGVEqxNjBDMo33WD8gIwS32oHBUJogBdubwMC3tsImq9YhspxXzcsKprtGN5KmYnTnLQjRSy5D73sTyK06nld/ljvt8wBhjrvvgRBcQf/SRSPjUkTXiAW1eMAhCHqijbW+BuHAFHmCkvu0pdaBSRhWRTcrU0+ERwkmVdU8J32osrKtV9FS4GQKeU3ZHPJ4ZT2XPueg//d5fieN7m4aHJgrM21lWOn+4TANCdgnED9NUqg==
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Tue, 10 Sep
 2024 09:02:40 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ae) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 09:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 09:02:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 02:02:32 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Sep 2024 02:02:29 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
	<petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v2 0/2] ethtool: Add support for writing firmware
Date: Tue, 10 Sep 2024 12:02:15 +0300
Message-ID: <20240910090217.3044324-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c7aae1-0e67-497e-9ed3-08dcd17752e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTJ5H9sRYqR/pLAtGNwd3X7yb+i6xu7LM45evyhR8F4giAFli7A18hHKgbos?=
 =?us-ascii?Q?Pf/Ztl8ZrlxFGSZZkXI25kPQnacgCDfhinaV09E0tHuWADWznSCq0qTTPOmw?=
 =?us-ascii?Q?XY3QcYI0UfsTk6jQkOmXOWLMRhkXV1jG99WtusdmrwvKzhgPNTqXtmb/Jvfs?=
 =?us-ascii?Q?WUhPN8MGJ43z0oN+ZY+4eAbA7Kmf7M347+/llyXRWcpXjS9jpAJGIUPqyD9w?=
 =?us-ascii?Q?4gLdMbK3asGtNIsNMtc0vMBff4qZJv/vAFgUt73RzVVqC06Jda0k5F4Y3f2b?=
 =?us-ascii?Q?ewIm73Lj1rFeQi4CfdJKhTx1rstSlD2fHH4kAhsWDz+4Jf1MB8FnNFX2/XJA?=
 =?us-ascii?Q?Aeq3JMITkisADKmbRt0JdZ+32KdQ/qS+dm4Mare37Jl29wz1M29vIK7eOHod?=
 =?us-ascii?Q?nCo3fN4BhO1YbUwnfE1BoU6B3e5tvOa0ABiArwsC4pSPNIPmIl7UmCb1miLz?=
 =?us-ascii?Q?xT7NpuYDtLUCYIPlVH75m8wHpu7XKPItHjbdizwsZfVsa64S5WWF5aEjIYFA?=
 =?us-ascii?Q?/2YQSZw0EcwXvEYggMnQ1inFUyEV34uqFjtzKy2adUkdQfn3pZgNjknYaDsY?=
 =?us-ascii?Q?dz8EnuSRAiwfaL5HB72d92lrTKR2kuDFe/qjdyM9k3vkVMC6wP4YbEPKt/DZ?=
 =?us-ascii?Q?aPssID0wkSK2ZdKj83aXdIJYDOVM8+oV73NvKg3zDK2oblmyd+I/guetibpd?=
 =?us-ascii?Q?FzEkLEcPkznn9q2a0NU+HcNFZlggfh9Lxf7UIAmnPcOfUJv9zQ70LbhrgStp?=
 =?us-ascii?Q?uXCHtI88om2Vnb+8+DDs7CZe2NZiNp7Y+DjtTJXUxViwcrxw/KErFVSET/j8?=
 =?us-ascii?Q?tG7g7g+g0pDNQPNk9sEU634OBDqNwNEsUWlzVjz76glLFHdS2BC3IMNvpSym?=
 =?us-ascii?Q?6qh9DRS7rvun4GbTpUuhyz4kpHZPDXIBtdAPGVuyzBvkd4F/1nGfjyoNzb0l?=
 =?us-ascii?Q?d4WK17KGZEjLWPrZU3x0YYsAyRBXrM3+b/qalXg9T++OekDrzPW7hEJp/ekq?=
 =?us-ascii?Q?0JyMSNw3kF+1OPWfj9iPXuG3uwnqssl11cFY5jSa9wVql/uphHuJk0HOH7Re?=
 =?us-ascii?Q?eL9nujJgnyoUDTKo1Vz+U2CC6z+JJWoMTNC9lIu+l0vPoAy1rHiI8jVygW4p?=
 =?us-ascii?Q?Tpi9gSci3/S7EWEUvkeKVf5swUirk32R+YV66PcHYeheKYMfMv3lF10gglFo?=
 =?us-ascii?Q?yuvrvup5JJmlvojgvbh8Lsm1N5UxG0rfx+fJcT8ugU6BDGnJROohJy8ITNV+?=
 =?us-ascii?Q?eaUBwvqBw8XXq0fogWEmr/T/ZjdRf+7YfcQ6iHXrlkoibFqRBWhZV88nC85w?=
 =?us-ascii?Q?1q7ofiY8axlU3H8o/bZ8y1ylANCDRwbhKCagf42LJQuu5KnstTsrnT+Oc925?=
 =?us-ascii?Q?OTaaIWIWAuMfERJ6l2S6RfCG0IEFgcfOFZSdNHiqo+QwtELSUC66FDTaxpuu?=
 =?us-ascii?Q?/MYc4UAZgbbF992Fnq9q0gH16P4IVo+G?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:02:40.0036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c7aae1-0e67-497e-9ed3-08dcd17752e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

EPL payloads are used for more complex and extensive management functions
that require a larger amount of data, so writing firmware blocks using EPL
is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add support for writing firmware block using EPL payload, both to support
modules that support only EPL write mechanism, and to optimize the flashing
process of modules that support LPL and EPL.

Running the flashing command on the same sample module using EPL vs. LPL
showed an improvement of 84%.

Patchset overview:
Patch #1: preparations
Patch #2: Add EPL support

v2:
	* Fix the commit meassges to align the cover letter about the
	  right meaning of LPL and EPL.
	Patch #2:
	* Initialize the variable 'bytes_written' before the first
	  iteration.

Danielle Ratson (2):
  net: ethtool: Add new parameters and a function to support EPL
  net: ethtool: Add support for writing firmware blocks using EPL
    payload

 net/ethtool/cmis.h           |  16 ++++--
 net/ethtool/cmis_cdb.c       |  94 +++++++++++++++++++++++++-----
 net/ethtool/cmis_fw_update.c | 108 +++++++++++++++++++++++++++++------
 3 files changed, 184 insertions(+), 34 deletions(-)

-- 
2.45.0


