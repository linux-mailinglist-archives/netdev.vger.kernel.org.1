Return-Path: <netdev+bounces-164684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CFA2EB08
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CDA3A151A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA8D1DED72;
	Mon, 10 Feb 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1OGxuG7R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D9288A2
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186840; cv=fail; b=kE1yNm8EiM4+3DjANsBlnms+is2/bsGVirk38mFEpQfk67SuGfrQpte8i8iMV8wsUP3IRvmDYEwJvoe6mk3yb/P97Pp7WDX1LPh3Je3d1ob6JhjGedGThHHVbhE7/OmWHFoZoAuXQHm+eLb12JMt0Rxse3HLdWcXlFgU7o1mirM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186840; c=relaxed/simple;
	bh=DLmcxpRilDq2NBuUuN7yrf+psncf+lL+bDxEIDXsa+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZqNbxiTTMKLxTUbPWcA14/V+nUBlzNPsvAlObQ1LZjIGLiBEeegbubfkijPZAyRYtC0LlGWcctMRXNn0G/nh2Ha8xNL4pTQooPEd8xleJWDM1JrC/asqnCa5Xs+36hERF98O89kp39XsQXdDF7hA7h8sxagAHUlf9kTjNXghQyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1OGxuG7R; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vtbj7sE7jkeIdoqZOpCJobcdO7sr5Wox1lH7sLwd+77qTQbS0O4gGvOOvJMYN0eBRr7ltsscubXn0EVmAujlz28d4x2uhvhmx+a+1O9DHKu0vpXNFw41a7cbemlZmWtGI1uKxKioOTCgAlvL8TZV0zpkOjLLWlygCjhHLB5E6LTDiw0N5E5OFKB0bE1OG4rMfS3xMtb0IVIiigTG8bz6zlMwz3lU5GwWhLkfdFV+8/2CxBKkdw4Mu8U8NZ8ExzfOiFcFtyzpCbj76DHRQcha9bqQ5jVbc1G5Y84nIWLjq/iMBH9yAP+PHB3o8BdjC2t8Cdw5QCLSs72TNN32946S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xFmxAEqjLb7Sj26JIsw8+d4/87g8AJL5q9ytVr0eH0=;
 b=q9Jc5l8gguBoQs+4cnGlZr0wfnUtV6MZ/kCAEmxhW1G3jgOA8ubP4ge9fYCoqTOel/i+Nn56I8IoFyjfRrW2CDVCXGXa/SuU6dAbTdvzKktGrUDwPPU0ALZFG6Va4pg57DHBQCcre5UZj/yn9Qaysukc/VkqSMdG3QNF2nhZIzMxyh5Jc7th8B1CUUJIesfAqj7JdF0dX/h2dkxalkSgj7bv99LmFGa4a3zevLsZivJRQUhvnhBh999yUrnJNjpBCzgUK3WZjbXEfqS0PwAsR7us5WP35rgne/hfAtel4sBjx2Ud/mVc687+k7MTrd4skoR9xpr9xzS+0n1dJGhcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xFmxAEqjLb7Sj26JIsw8+d4/87g8AJL5q9ytVr0eH0=;
 b=1OGxuG7RXC8hBPYv0wTLTei8mItsL/Vel5ul6V/K3q7D7lyv9RehGeyyqgCNrLGkqSB0/1ZPVf6EAgy6PAlzsMQrCzCQmsbxDng0nxsJpW8Fj3Hf60ONVJYYhTs2m56p7BpHz7UDxgt9eEdhhnJ/SznWMGIW//An74MEXWqUgLc=
Received: from CH0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:610:e7::30)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 11:27:12 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::1) by CH0PR03CA0235.outlook.office365.com
 (2603:10b6:610:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 11:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 11:27:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:27:10 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Feb 2025 05:27:09 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/4] sfc: support devlink flash
Date: Mon, 10 Feb 2025 11:25:41 +0000
Message-ID: <cover.1739186252.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d81d60d-0e83-452e-0ce2-08dd49c5dc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9L/SoGgkDITVgqEYeomdr2JBthlPOKvewceFd5O8tu61KcKJwAh4hjKLaqaP?=
 =?us-ascii?Q?FZ3TO4ag9M+v1vLz8Z3K5EDji6CuEPk1PeFDuB8gdPCTHtGKYlm/Y0/xxma6?=
 =?us-ascii?Q?66Q/LLsK3YaGP0x+rXA3FWDpbwvJpzK9XeNxBGFalHOoAm0PCKDg3E2Fti+f?=
 =?us-ascii?Q?ZSDrVXJ8TReozlvWS3QJUPPnZGu7dq+nQBrPQGjOvIIULqQXpkfXsVA995SQ?=
 =?us-ascii?Q?wR6ri11aC54icKka3HC4ripYwbE22LA3rvu8AekUuo5dlp+j2rUfeoW+Nc7q?=
 =?us-ascii?Q?T0w1WdoAz9BlVWyL5Y86w8ttyNGKa4YLK4uDGE4LnW/Rg5VbCEidd5PrOUlT?=
 =?us-ascii?Q?MYqH9xvDLjnlmKpR7ti01P2CAN2a119YJaR4S06/awE1LkpssOfhoq88vRte?=
 =?us-ascii?Q?Eshpmp2vFv0+KIrM90BfU1O1k5AfNZtbbfirddHZa2QzAkgErsHjUhqEtbPf?=
 =?us-ascii?Q?nCq+WbS8mt6ZJLxVn5ilmNOjrIKpcDgf1EDaYSNicOTgpZzuteszst69M4JI?=
 =?us-ascii?Q?ajynruqSCOeKVQoMpBV4ilh0V1NgJ+ck7bmsIeRURLjcEzaSqxGBqoOjYFK2?=
 =?us-ascii?Q?0tP7HoAN4WT+xNo9t+ElaJ64Skc4sp4nH/MX+tu2E+/MTZ5HJbiGCCT1Ky1+?=
 =?us-ascii?Q?mZN/E2Pns+ZCgdEAZO7jlDuldL8QBj8o1OaEC74InRHpkJnFMm1+PK5is/l+?=
 =?us-ascii?Q?0d3ZMwqDM/MUs6xGc2yMRT7S6iil87yR8Uy+HTNVJhPgsCii+y9/F3lderoR?=
 =?us-ascii?Q?HnmAycINM7L93n5rUubJ8/BWZ5+tztJzn9CCmZO7BgQ62YOsRBdvzay4awuc?=
 =?us-ascii?Q?dwFcWYe64PBeqmn3utQZb/9aN/eW0S099hF1sFqaT+HU+Px6ixaE3an/N+7Y?=
 =?us-ascii?Q?1O+ioy8691su2s9AKXBj+kz0/lRL8yN6LNnTSX3MbVLjHo81tRm2dMBPZd1W?=
 =?us-ascii?Q?FWI6mloITRyTrVc8NLFETXdSTCUVH70G+ZBsK8cgNtpYAwty5tcy6NwgbNbd?=
 =?us-ascii?Q?O/W6oBxKJ3xVpxv7RljG5i0PDY5rSwhjyXEv9BreKu5BWtxPI5cqE9EbmUSr?=
 =?us-ascii?Q?aTVUWQw/gqwqMK0u0SX0ZCdCGhAnkCHDKxitYhKgCs5dPR0w+QGthQbFutGL?=
 =?us-ascii?Q?v9zTnGpUretMP7guKlWrxkaK2fwa1PXcFpEWFfVWDGQpN36UPeu+soYe3wFH?=
 =?us-ascii?Q?oESoxbbf2RiRYf03V+YWJf1WyAFBXJs/DluEicfTQ3itSo3FDiOmJ40CzgCE?=
 =?us-ascii?Q?kVhwquP79iTcKGCMvO2cP1WagO5bwuBI0Gg5DJCAMYBwLoUfNAsyvAHg9uOn?=
 =?us-ascii?Q?EtB/7vq7c3dVxq/PaCuk3hP7JM7P+vq8ZuB+AnwSl+6oQr92++uciX1CTwG3?=
 =?us-ascii?Q?1QCHIpUmSEFR3PExzhtapOjDSI3qbXcnKZVAx4q6ILdVbFh8kl1vy9hVmH1U?=
 =?us-ascii?Q?L99AVzUTDv/MS7JznQawaFALwGbpKNQMUatkugV1oT7yTnGiy3eb7RntPcSv?=
 =?us-ascii?Q?baPRLXfxRbMzKKE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:27:11.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d81d60d-0e83-452e-0ce2-08dd49c5dc76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

From: Edward Cree <ecree.xilinx@gmail.com>

Allow upgrading device firmware on Solarflare NICs through standard tools.

Edward Cree (4):
  sfc: parse headers of devlink flash images
  sfc: extend NVRAM MCDI handlers
  sfc: deploy devlink flash images to NIC over MCDI
  sfc: document devlink flash support

Changed in v2:
* Fix build error (unused function) when CONFIG_SFC_MTD=n (kernel test robot)
* Update Kconfig description for CONFIG_SFC_MTD

v1: https://lore.kernel.org/netdev/cover.1738881614.git.ecree.xilinx@gmail.com/

 Documentation/networking/devlink/sfc.rst |  16 +-
 drivers/net/ethernet/sfc/Kconfig         |   5 +-
 drivers/net/ethernet/sfc/Makefile        |   2 +-
 drivers/net/ethernet/sfc/ef10.c          |   7 +-
 drivers/net/ethernet/sfc/efx_common.c    |   1 +
 drivers/net/ethernet/sfc/efx_devlink.c   |  13 +
 drivers/net/ethernet/sfc/efx_reflash.c   | 514 +++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_reflash.h   |  20 +
 drivers/net/ethernet/sfc/fw_formats.h    | 114 +++++
 drivers/net/ethernet/sfc/mcdi.c          | 115 ++++-
 drivers/net/ethernet/sfc/mcdi.h          |  22 +-
 drivers/net/ethernet/sfc/net_driver.h    |   2 +
 12 files changed, 804 insertions(+), 27 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.c
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.h
 create mode 100644 drivers/net/ethernet/sfc/fw_formats.h


