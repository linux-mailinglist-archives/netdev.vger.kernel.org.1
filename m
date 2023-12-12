Return-Path: <netdev+bounces-56247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C980E3DC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403C71C2198E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE513FF4;
	Tue, 12 Dec 2023 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="grDO1VWw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF7CE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:38:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sad1GykkTrifNjbvpT5gel20Hlo9W6cF4Q/PmnNDvynEcISFI0yB5rhrOzBAqnulS4PQzyjDbLqi06/RKCybQCKmMOZqIWGp7/XodvYcOxgFXyhnAG/PiWLIFB11EGY1tS0FkeopBZXZb8Di0fnh9UsxFOJOaV55zAs4G1L8wUnZTy03ekoJec8A+7b0w80GDb7PymACIKuW8Bu79uZoxyup/tHM+tQK1yXlHHkiA5zn3d0Etg11pQUu0FJPZnr46X3F4EzxVEYnGv13Pt3ROzrmd+nLVBAKaKSiJTHK1Brccpc/VrsjoMWmsYcudkOeQgqZgYB4gvW+9/t010NNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r//9lc9Jbo42w62n7F/sAVNANlAlLir6c+eeCc+ShAM=;
 b=kV462JSu1GPQ8Jf+YzPpD81Ia4EL2K0mx4+VGKZuxTVe4SsSRXYqaJhDHnaOZzR9HHEghMYEsbnj/X/Ffms3+nZx1lOYB56u9g3GJjrG7DAuv92zUxulbQA8hiJIyupX80/QtXblv8oIaMYh+D0Jcq3wTskgLFqEpmNgKbpqp1qq0BH7r7GnHx+vJjPAGFYEeH5LD1PVHwR9kFBd6GcXWexMFVSKVebHBFwxTX4v3qB48NxMira52z33y+4WnycElF0f+htqTdDjKzn5ZOWys4YfdQikgPEdS3DlGmrvPjEBe2IfCrQRl3yLvNAEFbFLCyeXR0F2p+hpfUXfN1n7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r//9lc9Jbo42w62n7F/sAVNANlAlLir6c+eeCc+ShAM=;
 b=grDO1VWwEvoeuvwBml4wegvyoV/oP6eGZyVgwf5A9UL8uzLeXFf61RsASE6ZF6OExKaqHGTfMDkt5iifZh1hDzCWGDZk1ck6EVMQJ+RKQDlOV57D8X8GCWhxCUNkwzCY7g54ZomMTdrdVQKChojvSdRt+O+AzwI/5xUfuPjqSL4=
Received: from BL1PR13CA0215.namprd13.prod.outlook.com (2603:10b6:208:2bf::10)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 05:38:01 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::6e) by BL1PR13CA0215.outlook.office365.com
 (2603:10b6:208:2bf::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Tue, 12 Dec 2023 05:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 05:38:01 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 23:37:40 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 0/3] amd-xgbe: add support for AMD Crater
Date: Tue, 12 Dec 2023 11:07:20 +0530
Message-ID: <20231212053723.443772-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: b31ee4b1-a514-4cf7-7082-08dbfad481af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ad3VmFyvua9w2JJfqMQsHtp4F0d3fcjNKA83ykjEHYAZr4gp0xI315sRAvk3pvn4/rroHA5tEybyF4EY774o1ynffSfls+TM2WYbFtGbYE2zr8aimYusClt131KpCvG4PiNZQWgFz6VUxmrRthO0lrbQ+K5XQpWK4fIe6OEFN2Un/hp4fv5Hhvf6f+C2bIZe0HO4Z65NLDxegwjJhTnm3YL43IZTsBzTxgN2okTknVrFY6bXiWCMkZjZzKSDUhaP7BDVuSK39fWnZmnm1oRtApr5OQn815/waKLKRrfM/42FwD7V0cRapdbe/ZCNupSBIMzZmBfsgyU0Mb122vcAtycy47Ou5IDpilCl4Jiszi5Ay/54cm0kBbjDwSI0rihoNXlqc8MaY0E6VZkHmrWhTfuNxC3Z+4A5UVaUl1z+As1FbbRqzqAwl6t0XYZxO47B+vDtgGYi2SQMsYTKZ+eu4Psk882MKDfKTzO4Vhsnaeozlv0uUBg9fWml9I8q3aI73V6INsokcoa1x1XjFwUnCWbTZ0q4S8RNFEsKwCsrtsu6y0U0Iy5Nb75aaPYA6Nw2qkEGqibAOPYQDPUfKOnRuts9594iP7EDaiGAAxsJdbks7xx+terYfwRwAHRkU148pViKahtaSsuguEqd1pTFMOrLrBHZ5rDLpW8VaF6kOXFhklN9aADqyG+ViM+PBT6z8ZyzWv9XgOZmGxCpdjetWMnkIrq2Ew20VNseq6EmdpE9/ITGho2j5Qou8QJ6Nni7y7yUwXgAiWSj5ztaR5JBspxnWR9h5IPRXliDfZg52N11kjaIdekPEwAck25Ej0lp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(426003)(1076003)(6666004)(2616005)(16526019)(26005)(336012)(47076005)(7696005)(36860700001)(478600001)(83380400001)(5660300002)(4744005)(41300700001)(2906002)(316002)(8676002)(8936002)(70206006)(70586007)(4326008)(54906003)(6916009)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:38:01.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31ee4b1-a514-4cf7-7082-08dbfad481af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices.Also, the BAR1 addresses cannot be used to access the
PCS registers on Crater platform, use the indirect addressing via SMN
instead.

Changes since v2:
 - Club patches 2 and 3 to avoid build warnings.
 - Fix the smatch warnings.
 - Fix the build errors on arm64


Raju Rangoju (3):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: add support for Crater ethernet device
  amd-xgbe: use smn functions to avoid race

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 119 ++++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  51 ++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h    |  27 +++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |   6 +
 5 files changed, 180 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

-- 
2.34.1


