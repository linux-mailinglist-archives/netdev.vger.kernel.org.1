Return-Path: <netdev+bounces-56001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1980D38C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694C7281ACD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6294D591;
	Mon, 11 Dec 2023 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C7XZEr7T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B0C4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ung89gaHe51amf6hQJc2O3F85Rz033BcdYUfHiSA1M0/G7B/TDojlz/Hoend8U8JsPmG0A1FgXQYINJveFuum+jZNJwRiG3+PE3LfTxHaPyAHlAl4fQoU971GDr1PyIKQosM6eVzJ7+l4s8g7t6c93VhC/VsfI9Znz4PrCB+jw/O4DvPHwNJEmhZ7NEFEbI+BO6l58NqIkahfnJIM/RRXRmeoT0hPaNVZdYRmBfNNM/+9yUXe8dzewyM9Z/AP2DsG86kB9jcuEymPXZnJUzCVRmoniKaC70qaSkqAtcA+h1/lEH3nGy7Bh6jEBtFZlhEZTgO9mmtHqdbYCUur0VCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFM0ykphAJKxqHDoDs61LA4+RG0k/K2cQtsw3/gvXsw=;
 b=NEhhwS7Kv1J43cOPQVPIXId6U6ReDSaoYdpRVJ0SCub7fs1zf0pQe6VlX2HlnVr2sRuGHgRk9aHtou8od1JfA6Aare99uEBKphc9zepJdpdRi29Nqqc/ZHqt0yp31md0ol79huOwDswncN+rLUoWcBKWmAQz3MkDSwzzCCFaEQb6p4VzJy4n1jdeMHhF7LNdq4oL2GDTpobAjuHBQG5OHbNLJLZSCpotvw+FyusSXIkRvSE75gYirSX1GDuSZ3PaoT1i/vDlRo+MFZCfDUVQuVK1aqNrvsHVQmDBdXFk2v+k3jY/PMjmQPXxpoVmvnii4PSxaGeEiMl/1cTHv63mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFM0ykphAJKxqHDoDs61LA4+RG0k/K2cQtsw3/gvXsw=;
 b=C7XZEr7Tk/8pesRdol3fO+MYt9aQeSUfL9CXqk/kZ8PiXYeIRU18Qrz7GU7n3qNQbtEWqe23zZvTTqftBauxAFsOlhsoGPg8gjRruBdxC8JSu9H6JQ5zVuQe5JnEM4BV22CRGEz1+JNUif9d50TF1koPN2ameznXKpqfrNOu+Kc=
Received: from BL1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:256::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:19:38 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::54) by BL1PR13CA0012.outlook.office365.com
 (2603:10b6:208:256::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:37 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:36 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 0/7] sfc: initial debugfs support
Date: Mon, 11 Dec 2023 17:18:25 +0000
Message-ID: <cover.1702314694.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 02522f56-08a0-4dae-a0bb-08dbfa6d5a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hy4p4Wt5lgo/Jih0JsNTH2d/CdweTmC3QxNiEwJVjVPWSdg6B3nDFrgWM4SBAoYpRZWpQh+07iWhexNrDHGo44SQPexdQ7YW81JH29J2b717QUYsS463Ebtw+HYsp++7bssBc1+3CGAsPhizuXzau2490lQAWXXL/gM8ncpG6xvRaPew56JOE+H3XpOR8BwKcNCxy85QfpMUmMjTT2q1NE1D9SQ4y370BTV6Oyr2M7dyydc5QbKzDrGuziBcumJsWMXYqnJb3O3hQIWKWkz6BKN+x7Sc4jnwNNtkASPH/J/1x6/lB55WbXwRk2z3TWkLM+1ptwUphbq9GEoo6sefPk+6nczy0N2nK4T6llVTo0Jx8ai1FOEtq7kQdQJAjA+li8k772b3xUSG24y3hmbj10dFSfbmovDgUb6WhTa3SCT+2dwnkJ40wBZmMUenty9pYBN0wsKDIiE3Auk82WR0ngALztlARlNwqQVCQwUGu4K3F+dhsbRBj/MwdmOi3lmThjrZxN1XzIIuAu/6nJjvrzG3ZtaN1H/MITovWua02yhhb3Nyah0NdRU6ciyiIDLzQKqXERpbRjuIokeMLB9QFYnuzWKerj6wrB9FbPo6HHzhBbf9q1aShoHmkY/+dXV0qa+jM/pUpmgFv2dtnSUMRrtOnD4ViP/84+vqK/bed3wzFuFCcCJU2Vx/UsQrHHhyFpeAGBcTxg8xAsGv8WtER8ulaL7zoosxfNH3VLJiZz3dJdutwsbXP3204pj2EnCLquky093X9NTsyM8ZK2xKhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(2906002)(82740400003)(81166007)(41300700001)(478600001)(356005)(426003)(2876002)(40480700001)(70206006)(70586007)(54906003)(110136005)(316002)(6666004)(86362001)(55446002)(8936002)(8676002)(4326008)(9686003)(40460700003)(36756003)(5660300002)(47076005)(36860700001)(336012)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:38.0395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02522f56-08a0-4dae-a0bb-08dbfa6d5a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Edward Cree <ecree.xilinx@gmail.com>

Expose some basic information about the NIC, its channels and queues
 and their assignments.

Edward Cree (7):
  sfc: initial debugfs implementation
  sfc: debugfs for channels
  sfc: debugfs for (nic) RX queues
  sfc: debugfs for (nic) TX queues
  sfc: add debugfs nodes for loopback mode
  sfc: add debugfs entries for filter table status
  sfc: add debugfs node for filter table contents

 drivers/net/ethernet/sfc/Makefile       |   1 +
 drivers/net/ethernet/sfc/debugfs.c      | 539 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/debugfs.h      | 149 +++++++
 drivers/net/ethernet/sfc/ef10.c         |  10 +
 drivers/net/ethernet/sfc/ef100_netdev.c |   7 +
 drivers/net/ethernet/sfc/ef100_nic.c    |   8 +
 drivers/net/ethernet/sfc/efx.c          |  15 +-
 drivers/net/ethernet/sfc/efx_channels.c |   8 +
 drivers/net/ethernet/sfc/efx_common.c   |   7 +
 drivers/net/ethernet/sfc/mcdi_filters.c |  57 +++
 drivers/net/ethernet/sfc/mcdi_filters.h |   4 +
 drivers/net/ethernet/sfc/net_driver.h   |  47 +++
 drivers/net/ethernet/sfc/rx_common.c    |   9 +
 drivers/net/ethernet/sfc/tx_common.c    |   8 +
 14 files changed, 868 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/debugfs.c
 create mode 100644 drivers/net/ethernet/sfc/debugfs.h


