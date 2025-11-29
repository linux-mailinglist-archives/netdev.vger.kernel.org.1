Return-Path: <netdev+bounces-242734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D1C9460A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41414E0F62
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B91F3BA4;
	Sat, 29 Nov 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RnUm1LVc"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F21DE8AD
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438655; cv=fail; b=Qq/QkSTzEGU99wD4DJR0S5xwAKb1BzUoDpAdXVXWKVSIVUVJSIOMk6+Dm35rEhkaTwv4jbpfZ+4qrCNDsPVODk2dTX8myd9YnvndJP42Uy735HbByoJN2wpl9JEh51yJ8ZQ9QFWnIzlRvFNo9l2A42THmNxNJxhbz90mnTeZKFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438655; c=relaxed/simple;
	bh=oOCaBve92eVHuvP8DhG1oHsjsZjIc9uH9ddR4pZUfz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8umhVUJd2uhD8CIO1ECj0kQgHyrfO+8k9dlCO//t5bC4VaHbKAxfxTJKDlAkePmfGkm1SQq3UK7yTtr2FBebXpyV98S+gMRw3DgG8O5pkmapZz2o+AcK5PGGjvxDMItc1TnvaZ+5BksP0Xw/a/KkuWmNOFxvwfRJzyXnP5pCxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RnUm1LVc; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0yyaR2ULizNOsoDqtKdv5UOr5k7bnTuZOCg7BNlgjjZudTXspVH/mSvoqH67I6sDvD3m+EVxCcxW9b49r38xQvXOYKQzN27/+5hT7zyThNhxLga/wduVNAcdifsBlc+sEHGnNIgNaGGMWlRW0cxPVlbkfrWyN02r2CCZpqkxfKjsBJnbd1bjSxp3sNaFXwABCOzmHMqVT+Pk5uhBJr/7+XsQ6by4nI7a0sayJYdrqRfJibtV/VWBiImP+TVcic4FqbPnN9C/dZ3Gk8gfZn4PG/M1xlU18jxnaeO4kIZQyp1EZ/p3S3woWW9FLFQvM2ex7mJ7LWlnpBDFtv10sNatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMCKSDNajwZl8qWwGmz/ZbRfuSi11cNzYbYMXbkZZsw=;
 b=IqwKrxkuhADwBdQjU1g2zxCp9x9jUoUrPVmJ7jqf8hpXxC6Jj662d2mUnpQacHezA7JMd15Pf3JUfrbAUY0BtMnpLY+DwQVqHHYbTcKVtXRCmTYbDliHH6qJPGmWT0oiFIIGt1xhJipJGVA/+iGJnLu74OfoC91e/ON4p3csu9ntMxSKqz2EOTWiPgBWtdDDQpLvTcQYyuRGy86ooAt7LeInnFAkxRZSTP9Djv9EKOw27FUt3qn4A9AfcIUpj/RoaVbstMiEsP0/ltyEo1dVz3HnU5gWndgBBKRNN9bB9vX7ypVRYuQHPW1T0oftB6oRXjQ6K4OkMrD0mJsODY2kjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMCKSDNajwZl8qWwGmz/ZbRfuSi11cNzYbYMXbkZZsw=;
 b=RnUm1LVcC6xiOY6wBfL5efBGRMdbu0WwPbiHa5xQKezAb54jyZRghZdHIXtVPu2NTHcONUM2bveaADZWkiQ0dP9fQ1RGyVDAYnGfsa4w4nV2WxpFsGzYbF7BVgs+jjq+scd2TbcymeConIE2nXc9nC1e/bT7KI58jW0/ScHdyBw=
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 17:50:50 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::75) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8 via Frontend Transport; Sat,
 29 Nov 2025 17:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 29 Nov 2025 17:50:49 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 29 Nov
 2025 11:50:47 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 0/2] amd-xgbe: schedule NAPI on RBU event
Date: Sat, 29 Nov 2025 23:20:14 +0530
Message-ID: <20251129175016.3034185-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 0431e267-8701-48b2-e314-08de2f6fd553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WfXLnm0HK/Tnk5TAbxbn19pOUs9Cc54tKAY25nrRYpyqJea9Gs9hRiZWu1CP?=
 =?us-ascii?Q?ruabR/ruYre+6A5fiKJ34EfTgQPFbZgIRVY5ETURAuIgVpsDEaktWZSQnlIS?=
 =?us-ascii?Q?s7vVVIjTT6iEUbUdaBriErHrRYqEureXApTtDzUrq5+PS7ryQjFzxnh2CLzP?=
 =?us-ascii?Q?YKBfeYS3SEAP6ZHxNmngEwc/fNhrv47mrRRUsh+C+48JmpWBWpqMT2phxHeI?=
 =?us-ascii?Q?+euXeB5ZGdptrUHhn2hVviVVQYN1XL51O+dNG2xXPVjrIw8Pht5C2j92jP9q?=
 =?us-ascii?Q?IqgAndlUPn38hXI9M4S/02D5J/mBiHQ+8JA4FI0Om/+XO48J3+bfezeuMmnN?=
 =?us-ascii?Q?YjYOzG6vQGn+mkAMtV/JETVRQf52ILDykdkCrbDmJX+zAJ/F+QK8zDLif5jC?=
 =?us-ascii?Q?IsuAFseDgE/OrEWG1ajlivm20NA8b9+PPzhDL2nd/wIPYTWffWPRNK+RSNGN?=
 =?us-ascii?Q?bMqYkixhawwAniszCJ71PunBNg/HK+djK8YRXY8xjwgiCibpcDb7lA7dSrBR?=
 =?us-ascii?Q?PCzYiRuiMm1ICFASk0D+cxn8d5si31Saj2Q2qzjCeqe/LpozadjJhEeEBFWK?=
 =?us-ascii?Q?EU/DzuaSnk0ZAc2BdSfSAFAmVny3TqZqKwbPE2ZA+T0jjNv/TkcbSLHF5eud?=
 =?us-ascii?Q?/tHHAdBE02CXpsdwHXcLDAEKky7sxugP+3hp7KP+pqPr8BJlIQ97Ly9KqOao?=
 =?us-ascii?Q?MoPw1kYhNdfqcBiXDORJOpjbY9UVZkQ4d/hDjJzA+pU7eIImbOF31kMaRfCo?=
 =?us-ascii?Q?vS3Lbgik8US7wkPWpeCPpc9Pn9RfQTpNiKVOu1eYOxNi0i13CnVKP6S2rtRq?=
 =?us-ascii?Q?764UNUIUs6I25/iJ6UuyRi2gqr+auuti56neFKy3rp2j1vLe33vr1nVHqsjM?=
 =?us-ascii?Q?MjNj5DsbWQsdJDWzaE3BrZJd5GUOASObAVirZIrHaPsV36/6F2JPCaiTWqSk?=
 =?us-ascii?Q?pFwZrdDY4pFh/u8A+vhpscByuBTiyCMBWgs3668azwFZA3vrUEBMQVhoQcHP?=
 =?us-ascii?Q?vN8xyOHcfOLRYznNfnBl3iniMcBUaq0wjEyOCPEJpDUHn/b1ueVH9yQEopsA?=
 =?us-ascii?Q?pOiG6BIqnZdp7O7cE18RdZsJspYRzR8VC/HUNgbta3DHWbazWVi7g/yPPtjy?=
 =?us-ascii?Q?2WkLJKq7CSmt+w4HNGbgMIIPztJfyBfJzeKXdK+7CYiv3rqHUt+2c3SJhRjg?=
 =?us-ascii?Q?ieQ8+c2QXvYjpzV6CTGqn/3x85DBAa2DDRGiMtzxHSZRrt0MibyFGYW+X/5a?=
 =?us-ascii?Q?O079HpnQl9VqZu3JzI9+DPIhpzcZIGWSGEtxufnT5Y18Q12lTF0PE2EEv+rW?=
 =?us-ascii?Q?EBIVPOaMa0BqOH6+cmjTc/fm5OaQxoCkflELNjtl5u5yogBl6PU8MMEH6XO7?=
 =?us-ascii?Q?3m2+TNDKFpgHmAImFH49dxX2VE889EYssnMYC0n/+1cqe0FR3PLJJYTtjhcl?=
 =?us-ascii?Q?znjGadguFWUQmZ5uinDRc1yb7W0f3pObhypbrF/spyVhWPnRH52/L9GgqgZX?=
 =?us-ascii?Q?0YwtT+D+z6GQsLaEENOvwW4ehlWBOCAKc5izCq5QrNHoetkoEssk0SW56qVE?=
 =?us-ascii?Q?EotesnhqMD2//G/Nsss=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 17:50:49.9295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0431e267-8701-48b2-e314-08de2f6fd553
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

During the RX overload the Rx buffers may not be refilled, trying to
schedule the NAPI when an Rx Buffer Unavailable is signaled may help in
improving the such situation, in case we missed an IRQ.

Raju Rangoju (2):
  amd-xgbe: refactor the dma IRQ handling code path
  amd-xgbe: schedule NAPI on Rx Buffer Unavailable (RBU)

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 71 +++++++++++++++++-------
 1 file changed, 51 insertions(+), 20 deletions(-)

-- 
2.34.1


