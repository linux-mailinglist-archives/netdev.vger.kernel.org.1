Return-Path: <netdev+bounces-84043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D839D8955E0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DE288C73
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDD82893;
	Tue,  2 Apr 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="niYyKOf3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE665BBB
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066232; cv=fail; b=Vakzb36tjFYmsTLK7k0TuPciSyjMhqrFizvN02QTgRCwpmEsEzcopQnMn2Yfa72R0jYaGE42N9dbzsVPqi4NmxTCRbjVu3mc7PN+exmqTglNEzwEdhKeYCANM3pC6+BBhXu+EZVeBc+maovNN0toq6OIS/DZX488L7uHcAcwIFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066232; c=relaxed/simple;
	bh=ZD/FWnddwSdTXwT4pjuNRNVWHsHzbs+iDAHga7kBjtc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TV8sk2voZ7z3us2ca/7cQr9DQhLc3M7NuB4XlXfTJszk9vKgQ+4GaI9TBSlhA+wqNqP7UyPP78p/NCtfQFXqBw5nFSyLVDCEVsLqgLk22Qq9VcJ6Mn7nD8YQAy/g/pJ3LHSMOWLd8UHnVYCKmVGczUGXzZ4AN+jRkgYeWWhXeUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=niYyKOf3; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWmRFJg+5XY/zfvzXtQkTCq8PhAx8iV/Qi3iVcwdrzZxp1bq9wm1DZFzLbz8lz63h/ZhiL4nicFKFaFwNEMLEkVite0rO1pRLrx3fUlTqL+8IdSc9RcGlhN37StI5st03Ja/UCnhq8c7G2c6zaNAWt0OagGXX5n5dAK16eCTtvoN5JyCuWuUGpYHkwQUDGPeVoJvdWiNFbsRxxttkefGsI863y9NYCtOHGuHZuXv2hoFKsGI4cafJhckmCihV14z+rYjAEWezOvMb5p5IKKeP5dncmNgWSwDZbia2YbbftnlVmz09D9dDOPD8VjJn7SZN54EsVBBT5y+dSQr4VfMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFbSAva/HMNjTA9hFL5COJkwE5mEKLmLgU8ewb0srZ4=;
 b=CP+RVlgHuGPbDc6/PSQtlu2f3QQyzVOd2RHxQMiGZF9XtsmLF1WaW8KUdf3CK0HSFmr0KEXFsadevBuvnp7uDzP/PNfX7bmBERVTRkkRaYzrEWUvgivf0jAQVenvilwWHLOLI+h6an835F5SYiC7yKObSGEvYCl0qwUXHEIcrzBbVL4DxrxZ7RIH2N6Zzp05CauvsQqdt6x/OR/BhSENDz9QvVBUUxxZ1wpAWM+4euw3BXyjYPADfDvnwb3vfAi/7JHUOWNLBX7Ous9sa6S02+3PrzvzE3UzMSaFK0mhrvbQe6lPdJZsHLDDl5fUT/SnIFVNVW3cqEMaSKqnt96YUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFbSAva/HMNjTA9hFL5COJkwE5mEKLmLgU8ewb0srZ4=;
 b=niYyKOf3qA6GyZWVKPj8zvbNZFeDeBz0K8GBRkORqjvilleCTiYfn+304wtp25/Ei7Y1q2kli3LbwF+gHMD15x0y30vY3RX3R150kCMw+JPjyofhymWVca4YiRWmgEaFx7hrl8a3pZ6vKqLV/zD2O8uUO/Fzj7V9tJp42XRTnN9WW0wg+IC5QQS8gI7kemGqOGWx3SaaeMPFkkhaqh+C3thOUvD1NSer9ydQSLh4cxYfc9o/HgmbIdLoA7z43CRXsO5jgPy1X+wtEMehdch15pLh3JbQomM4Nhn2hAydIIw/XR8+MS8zvxSSg3PCb+6R54VubN6k9JxUfLjulcHyFw==
Received: from CH0P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::22)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:06 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::92) by CH0P221CA0035.outlook.office365.com
 (2603:10b6:610:11d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:56:51 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:56:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/15] mlxsw: Preparations for improving performance
Date: Tue, 2 Apr 2024 15:54:13 +0200
Message-ID: <cover.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b8c461-7677-4b14-b5a9-08dc531cc7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J6DyiZ+STsTmUq1Kp0WresrB/hqjgVtrm90lIiKrvFPaki+Z3HKlFOEDCh22qoS0SS86u2b8uJTiFVU67aeuUePoQVJceLuDjzxVGuJdUKLOUtOLZgp3jVF9zsaQZDNKqGLgofJkotyQqxwI7JqRw71d+zfmsIep960TBo1otn2opwI2MGLJlPmpH+IAN/TPIDW4fOLWyEbXa5ClLr3zBScyWewntxlr0shhqCq0siDZr43W8ZdCyeNA/t2vlTfB6qzyrQBnKHsOmowKq+2q1/jhMrIEx5NphD3PWA1VIVj+gRLtqnkbfayKhvBAn3kuozq8s6HG7/Rh1qVY+2EfBwxRCBVmfTHT3Dlm90WePOlshSyMmfNU4yV+oucUEs7mIkB0f/yaLqfupLzAaDK7MRNMPedppShEKAiMFZaDwx9TjkJPnUQw84kv0ByCF1LKbp5xMOFCHckYj7IwVLqVpF38s/czjbsFVuCvZi2gBSa4C1ig0sJ7nPiF4/J8VmKPBOokrRgN7LKniyjWLqNLMZAFVkwsb/xG+A9+O5GD9WFlpfSOHWx3IVipc9Ktfg4pTtA1tqHWwMQ3/NGW/j+boIMD6Cciugs9huQZ0zOrMRkfm/Y3ea1kxlONBXca6xi2rcigRq5wN8sy26foU7OWty5vOFLkPJuR2VRBIKFkvjqRCGTKpqb6JWnNtdAQv94xx0VMlymSyklSjnG67yyF24FfMZjdcAHEGQifdiKTrVvPyFGUhSKswl/KjG8sKxM0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:05.4673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b8c461-7677-4b14-b5a9-08dc531cc7cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

Amit Cohen writes:

mlxsw driver will use NAPI for event processing in a next patch set.
Some additional improvements will be added later. This patch set
prepares the code for NAPI usage and refactor some relevant areas. See
more details in commit messages.

Patch Set overview:
Patches #1-#2 are preparations for patch #3
Patch #3 setups tasklets as part of queue initializtion
Patch #4 removes handling of unlikely scenario
Patch #5 removes unused counters
Patch #6 makes style change in mlxsw_pci_eq_tasklet()
Patch #7-#10 poll command interface instead of EQ0 usage
Patches #11-#12 make style change and break the function
mlxsw_pci_cq_tasklet()
Patches #13-#14 remove functions which can be replaced by a stored value
Patch #15 improves accessing to descriptor queue instance

Amit Cohen (15):
  mlxsw: pci: Move mlxsw_pci_eq_{init, fini}()
  mlxsw: pci: Move mlxsw_pci_cq_{init, fini}()
  mlxsw: pci: Do not setup tasklet from operation
  mlxsw: pci: Arm CQ doorbell regardless of number of completions
  mlxsw: pci: Remove unused counters
  mlxsw: pci: Make style changes in mlxsw_pci_eq_tasklet()
  mlxsw: pci: Poll command interface for each cmd_exec()
  mlxsw: pci: Rename MLXSW_PCI_EQS_COUNT
  mlxsw: pci: Use only one event queue
  mlxsw: pci: Remove unused wait queue
  mlxsw: pci: Make style change in mlxsw_pci_cq_tasklet()
  mlxsw: pci: Break mlxsw_pci_cq_tasklet() into tasklets per queue type
  mlxsw: pci: Remove mlxsw_pci_sdq_count()
  mlxsw: pci: Remove mlxsw_pci_cq_count()
  mlxsw: pci: Store DQ pointer as part of CQ structure

 drivers/net/ethernet/mellanox/mlxsw/pci.c    | 492 ++++++++++---------
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |   4 +-
 2 files changed, 250 insertions(+), 246 deletions(-)

-- 
2.43.0


