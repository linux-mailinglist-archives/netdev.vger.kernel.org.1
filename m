Return-Path: <netdev+bounces-235964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B979EC377A7
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D3794E2874
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBE30F81F;
	Wed,  5 Nov 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZiLsZK0"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5826FD9B;
	Wed,  5 Nov 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370901; cv=fail; b=gR51yMCvJ8iZkBd6SPbhtecz9cCKpVQDoTHfNHzJ2Xem7Y4y3IUQbZY1GM/VWrgMA365cm+jz5W9nYIzQ1LltwfUbC8VQtWq7naBCtNzeoSx47rqBLgsXKCAZzzRMEmvb+BU8/rUw0h/OhMp3mUKcsAI3gW/SID4vn84bZeUO7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370901; c=relaxed/simple;
	bh=c4cTFtmdpD5W9XZnSxANsG6/eQrEq6OwC6zEHpMNHig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X0O9cux3KjNxwyWtoiOjcJRb3wTpUuq1ye4QMK1G/JiIZp7K1L+WqLY8Gj1QdOqHGG5bJRSGBy/GiSfZqQ1B26O4+fu66dMCztyxLNilMM08HycMFhr6m6Bk4AZBEuZXzriPTqBHp1LZRaSIQrkY+JiT5hZ263UZAFz76mDWssk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZiLsZK0; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRieVi6vVtYjY8/sJ0Bb4+SI5rhZK3q7cf2ODkjhvlCU+iUyL4CxJ18fK3XonPGsBDq+PLjRw0xwIdezj9FsYzXihPbJjMaYPKmMa/YOc+BtaoKl1a1zCys/rUghLtT7YRev3jBo2hugRoQz5TAP6nvFklrSwGrqv/bQ4VqjBcHNwbfx57ZWpgGrug+mLfS+eYXrJtRLvmmvYJVsNXsim6ugcTdB3QAdzDuEyOrkqbeuL0J4ETXd25rbHWx6cEkm8bLKkkZIX0C+8Sb1/PLym3AjjIiRMhzeD1RzWGbOjdPWA4Uqw+vLSCpLWKaIyXsmNBxuBPn5Hd/mEf8cZOmcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RucstBaZ3HiPNEtoHz+B+cogUPIL5HQUIK/4yLoZ3vM=;
 b=jkw+dC5PtodSP79Eh3N62s8iX34hNpBYbIrEKHtESo9eoiqzn1bq0vwEuQM8dxLdGjOCvqg06GJCnfQg5OUeU5vOBUaKxqQ3zG7IUVbcPmiLCplkmFDKUjeKVdtFZYtsrdUx7qyGVVNXSCflJeG5Ls/+LzVLcwzgc28zf2KrT/JhXcc3n8y+aIMLOcG4F2+BQUkhkQb10Wj6m6TcobwRozuDCai3iS6Ms4pYKE1hn/tfZs2lUinSy+0MVGuQ7vAxqwlxtI4VbOOCGOTT0M7UiczwhsqxR6/ys5TnOzEcLGSANlBGYuBy3oSO7oRjgMdT1zOFSehWQpJ0Pz60Iq2vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RucstBaZ3HiPNEtoHz+B+cogUPIL5HQUIK/4yLoZ3vM=;
 b=AZiLsZK06nftPQbOd16WAgrafiozxhnrXB379iWeOR1KFUjOqyh9NmTm9B29YXI7J87uKb792k5ncX7rowNpUXSYyWy9gkHISvHZ6IXAaYqftY7VZQDj9NjbLlK0nAsQ5yd8/HeasEatJcx5beeQcLFdk3CnCabEQ033Lki62vbH5xMwFDqZ3Y66n2EsVrXClDT2/2l/30I3IIdfrf3Phu2UqdMoEVPs3EpPbYOzFLsYFn0unnc/2FoBqQlZJb3Pij79YKyNF8sERzdkllnk44APKDRCmtXAJlo99+plrWQlOgF+O1nfO2alcwmc1IVZcknh+Oc2aInQkVp9wNSg+Q==
Received: from BY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:180::19)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:28:17 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::c0) by BY5PR13CA0006.outlook.office365.com
 (2603:10b6:a03:180::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 19:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 19:28:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:28:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 5 Nov 2025 11:28:02 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 11:27:59 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next] docs: netlink: Couple of intro-specs documentation fixes
Date: Wed, 5 Nov 2025 21:29:08 +0200
Message-ID: <20251105192908.686458-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 50decb1b-6333-4258-1690-08de1ca177df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOiULFUyT8zPoejqm3GV+xWVCD/cLFq5o74a6ws4G48eCgnQu1DAWkuxH0oN?=
 =?us-ascii?Q?R7yoyA5IGV+gMgY5pcKnKv4mD67u6+75PmHoTeDBYjR3mSAXOVZ30uS92zx3?=
 =?us-ascii?Q?5bKjsyeW+fRJfttLX0P4lq3f2dglpBavZeUDh/mPXAu7gO1j+R77dy4ehdFi?=
 =?us-ascii?Q?q9Bzfmov6TUvwnuI32Vk/GYRo58KV3sdG6CEm8i/Sl0NB99vutYVwfZMDJtG?=
 =?us-ascii?Q?ndTwIehlUeFG6Nq7IoAUVCHuAP/Ta/1IiioEGpoYUxKp8eBXfvb5LGSPVcAC?=
 =?us-ascii?Q?Y68KE58AXzNDn3dkkAtBrKi0vbmM+WQLh8lRAz5rm/mNWATeIE2xdw+U2DKb?=
 =?us-ascii?Q?ko4/Rv+EK0pU/4xyfXzZcYSLmPFnzKGwwTbDwvQsmgYOGZs6Zps0xHqUf25K?=
 =?us-ascii?Q?Q5OrFBOqzKR0AfNOeYpulzPUaXvyqrrIaviF36YSziSdzM1+hoBzyNOVfw0X?=
 =?us-ascii?Q?cx93e+zeowX5tTkkkWK/aKAuoBbhl4PJKLRj95xNx8dxcHsOyNf5k00HQClo?=
 =?us-ascii?Q?Yur3C6jfLoT/trQD96JuaGxeyDAPURLOEDww4SOpsHWkLDsjyEW6jCEhSGco?=
 =?us-ascii?Q?+2JkvS5TkiTcskfi/NBOo+zIWJNmjaVj9mSZYng/zn/qoOxWxBNsYqt4V8vg?=
 =?us-ascii?Q?RTvoOD8qw9gGwQTRyzAXKvMuqF2hjGlayeTDi492rE+HqZ9PIXMOXfySzFJQ?=
 =?us-ascii?Q?FdvCZa6FBz85+7AcFfT/p3QbNa/aSkxaIqlTLsF5qLLBYL/+NDlx0IoIvrhn?=
 =?us-ascii?Q?H9tQHTwgGkulqCqgOG1sOXflRUkgN2HfTJo7ev31FYnzu8aK7GdjMC2RnMsv?=
 =?us-ascii?Q?87rRuQjY8NX33DnAXbZ9Y2BTmcZdlZshUGWogG6pPTV2Ghvs5jCHzkEjk3Yx?=
 =?us-ascii?Q?CnQQkdntCsSIotbnN3oasNwnsJMgdw9r1zR8ImtCVgEiGPUYj0AMDJ5I6yXl?=
 =?us-ascii?Q?PF9D5Qd4hk650oFN9LRTIfWdMer3/1sE0tqnGbBkmPR0aDisdP/LEYILBPjN?=
 =?us-ascii?Q?Rq41FhncmqLRRwnJSecUAn9RFxBoMDfyKCWmGOueLg6N6rekzk5NGsHoxCCx?=
 =?us-ascii?Q?xRv2fJ1aGmeMbAAN+EZQyBxkH5TNL6ILykvhgdcUKge8fGqbwcxj/FzvgedC?=
 =?us-ascii?Q?GwR0Fi4OEwhYdksGvTukMevcY1k+IzqevMcCqUfkHcrQL68zBnZ2E1ytzAW3?=
 =?us-ascii?Q?V4H01WBTBGI+4pOHWl3+nJVDH9ucodn/+ygbqJqyKqs/KfrIMU/p76y+f7Vz?=
 =?us-ascii?Q?KkgceKPnKnIMI4OC0ifyhClLyUiEmNU0W7clgr0txDA/WLVb3Vi/GP4gPqTc?=
 =?us-ascii?Q?J/hXvqQTIUa5GN+MD1WXrxP00id9O6nYBHJOg2BI63+W/fORppyrz9PA8njY?=
 =?us-ascii?Q?qEan1J+Yso6kkFP046Pdu+PyXf5ldkUIt7AdL8tGvrOBWXsK2oU9s76WYlYl?=
 =?us-ascii?Q?QFJLIUCrxGlAmMiD1yLFf/Lr56SW5afOKubiC3+aY23uWmphlkWy2/9LZfZ1?=
 =?us-ascii?Q?1dbP3Pz9vqq8bn8z/hA6nh7G3lzWLZ/BiDpbwU3QadI06AIkYUqfK/ECwqWH?=
 =?us-ascii?Q?b0qoYXBiMYDthk/UFoE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:28:15.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50decb1b-6333-4258-1690-08de1ca177df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

Fix typo "handul" to "handful" and remove outdated limitation
stating only generic netlink is supported (we have netlink-raw).

Fixes: 01e47a372268 ("docs: netlink: add a starting guide for working with specs")
Fixes: e46dd903efe3 ("tools/net/ynl: Add support for netlink-raw families")
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 Documentation/userspace-api/netlink/intro-specs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/netlink/intro-specs.rst b/Documentation/userspace-api/netlink/intro-specs.rst
index a4435ae4628d..e5ebc617754a 100644
--- a/Documentation/userspace-api/netlink/intro-specs.rst
+++ b/Documentation/userspace-api/netlink/intro-specs.rst
@@ -13,10 +13,10 @@ Simple CLI
 Kernel comes with a simple CLI tool which should be useful when
 developing Netlink related code. The tool is implemented in Python
 and can use a YAML specification to issue Netlink requests
-to the kernel. Only Generic Netlink is supported.
+to the kernel.
 
 The tool is located at ``tools/net/ynl/pyynl/cli.py``. It accepts
-a handul of arguments, the most important ones are:
+a handful of arguments, the most important ones are:
 
  - ``--spec`` - point to the spec file
  - ``--do $name`` / ``--dump $name`` - issue request ``$name``
-- 
2.40.1


