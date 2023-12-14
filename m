Return-Path: <netdev+bounces-57424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B4813135
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06B1282C2A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CEC54BF0;
	Thu, 14 Dec 2023 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXmnY8BP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307F126
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:19:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW4vun+tnsKtj6TEyCJsFfCoelj6ECQd5LGcsNdoKcs91faxPPhNjy7VRvXXruf8cXx7XRISe4CGW2FNEhJ/6vn2u8bLj2mfOYw6864VdpR6cl4b5Bw+72JSdwpiDIk4zzwrcr7LyA00od0R2Tr3iH/A+3B21Yaxpt2yeG3ETLG6tGjobmj25myhzZPOIZHqIG0lQlF7r2lK2Gzo1LmzoaYnFB4BCfATfZtHS5MsTzdeZVeBnpXhqzqwKbpeeNr1AP861UrG50oEE7rkevywfaUlheQ4n1gWF5z+mABQVu1c0nwdQ2CrSgjDE0qjnEo3TiH9LYbQKH4qAxXHs3keXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1/1yboOykKNs2/hJ5qlc7r/LTPTFA4YnV+47omlwbU=;
 b=GsuTBP/c2G9bIRPlKkeBtRjDQKZC3sW7+7BEWmHYqSnrs90JOxue7FRKiuy5ejQld8DV/eIyxGCJmRQJDnEwcVbY6lSSWVS3Z4rnY8P4HMBH8A2R6CsiPU9wY1jloOd31LojjMIPelwUW3ss+6IvvMYFP/W2sFx4VDNGmbxT5SK/oGN7DJxFTkfp0ILo4TUKqjlfNp9UeijCMDjirtp0GUebOLSVslnhc4nDbWOzYlfnvtizxCUZSDkLbht1V8Jmm930yS0ORzfUFIkG6ABjkla0+eJtu0Wl52LglBKg98tu2WN3JtiD0cxGPzen6WtxTuBj5187M8YbAV3PlGpYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1/1yboOykKNs2/hJ5qlc7r/LTPTFA4YnV+47omlwbU=;
 b=pXmnY8BPMFMEls1agsDLr6yTZZypPTvmfQf4lUWfR039ymG15t8Wc4KR0vM3yCFDJFfGvyVyIGeI9kUtuHuJ0s2PdpgT+Qk/4XANX6iee93F4GQt/g0w2ax/2NkAc7DfOw/2s6sMRGqZpQdjweOL4KtsKHEQevp7fenVq59yeS18+ufmN8/ssoyYJOxLbZfYwF7m8XeM8ZJMt/LNb7wROODH7sMnKDuA+/nALwoiI1Xzyk4c9kb74vhTyzqW1XbIYmKJXIf57YwjcrLdPBUcQXvj+XnmFWzCQypKcNPu0yic+FW9LB87fpuCi2QpgFe4MBFZdEZTeb4/Pktk7IS4xA==
Received: from BY5PR17CA0005.namprd17.prod.outlook.com (2603:10b6:a03:1b8::18)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:19:42 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d2) by BY5PR17CA0005.outlook.office365.com
 (2603:10b6:a03:1b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 13:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 13:19:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:28 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:26 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/3] mlxsw: CFF flood mode: NVE underlay configuration
Date: Thu, 14 Dec 2023 14:19:04 +0100
Message-ID: <cover.1702557104.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 660db006-def9-4583-b46c-08dbfca754b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNmyKekVhkXdlvXA3W/2T26ynZypMtDFsdUcClyotRklLweI3FQzmJp7VfrvhDVXFyRqkAYICRYDm+PmufHeOnhxLKRPEAEydDQmjbxnXXVJgpfOJjNI69E1XXiRfyn/XhdVRAj9M0q/8pKRpyxxilvVzCOpJRPZgiSw5kiTwR9keZDUhmsQGCCrD+xi6BOMlrbNbzUbywWcEv1H3TCp/7KeZI57yovl26mrEs15jFp6aKjd9pKnkfS6fIZVglo4ofgtvJ0H0K3suGixDQpzZ/AvvYhMnOB/xFdbYdlXny4pdwC/flpFfjq6Gr3xn7EQsc6C6rmHK4X5txPdydlXwQ0dfe9hRxTTYlZDRGKcVGOd6rDCU96LSX/DtmslCXv1P49gspj3xrstM2XXBaadRhsErztjgl5RSswmmLWv09+MO6/KrmhnmTPOABhxCd2EWYL1CakAsz4+ga36J8t0neoMcDyPvX8pJIe4tCPGGXMHp6mjK5KomDv6qoirPfTNkrojpdzEdCcav9Oq1mXhMwnUCMnAGAdmQbmncXppHKjv686CGqkek/O1X/WdViX7zvIadzLo6eS/OaU64tbPco4q/emKvFYydRkDFzK+oKxfkoYAIoFX/DHTb+cnb0UtXVo5jOBhxCN3IpRzqXJoHj6XFozokcXS1EKrdij6atmA9Ggfv+o7Woo/kd/0NQy3G4Bq1Kz9K4vke0BJPFC/froe+AwXFuyNl6JUOx+wqLat1J13l0XNcOu5l7z4mErlKhpuDcJFSeyVY2Mz0xfVBxv2gu/Ax7t7US5czUJSCUk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(41300700001)(47076005)(40460700003)(83380400001)(82740400003)(356005)(36860700001)(7636003)(16526019)(316002)(54906003)(5660300002)(26005)(107886003)(86362001)(8936002)(4326008)(2616005)(40480700001)(478600001)(966005)(2906002)(426003)(8676002)(336012)(6666004)(110136005)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:19:41.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660db006-def9-4583-b46c-08dbfca754b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

Recently, support for CFF flood mode (for Compressed FID Flooding) was
added to the mlxsw driver. The most recent patchset has a detailed coverage
of what CFF is and what has changed and how:

    https://lore.kernel.org/netdev/cover.1701183891.git.petrm@nvidia.com/

In CFF flood mode, each FID allocates a handful (in our implementation two
or three) consecutive PGT entries. One entry holds the flood vector for
unknown-UC traffic, one for MC, one for BC.

To determine how to look up flood vectors, the CFF flood mode uses a
concept of flood profiles, which are IDs that reference mappings from
traffic types to offsets. In the case of CFF flood mode, the offset in
question is applied to the PGT address configured at a FID. The same
mechanism is used by NVE underlay for flooding. Again the profile ID and
the traffic type determine the offset to apply, this time to KVD address
used to look up flooding entries. Since mlxsw configures NVE underlay flood
the same regardless of traffic type, only one offset was ever needed: the
zero, which is the default, and thus no explicit configuration was needed.

Now that CFF uses profiles as well, it would be better to configure the
profile used by NVE explicitly, to make the configuration visible in the
source code.

In this patchset, add the register support (in patch #1), add a new traffic
type to refer to "any traffic at all" (in patch #2) and finally configure
the NVE profile explicitly for FIDs (in patch #3).

So far, the implicitly configured flood profile was the ID 0. With this
patchset, it changes to 3, leaving the 0 free to allow us to spot missed
configuration.

Petr Machata (3):
  mlxsw: reg: Add nve_flood_prf_id field to SFMR
  mlxsw: spectrum_fid: Add an "any" packet type
  mlxsw: spectrum_fid: Set NVE flood profile as part of FID
    configuration

 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  9 ++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 ++
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 29 +++++++++++++++++++
 3 files changed, 40 insertions(+)

-- 
2.41.0


