Return-Path: <netdev+bounces-33252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EF79D376
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0814D1C20DAF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8F818AED;
	Tue, 12 Sep 2023 14:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A2182D1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C020D110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtCDll7fCyS8vr/Xwpu9DjZFqYLDrmSF2S7k6J/PuxYmcP2WjkmnwD1vgoltDezyItwzYgJfPierqTAiTAFLiC/9U6lqykxREQks35xSuijOqTLZl+dEAaEYAfAJmr4HkVwiH5YJNzC6+LQxd5axEAfF1Avh4RJZjGG9cYMHFkaEKdlwAZgZYmCD2xyQ9vFzoCNURmZotJSFZYiX3oupsXpgMqpLBYwl7ZY/BL0qTUdqJGX3cCAErN8LvMYrh4wxccPfM72CXQXzjE9pv6J1u2h4WP85Z2iYadBYwYOWIvT6FvKOnNcb1KR6BWBBtN77p9AlidWJbg6cj52iIAOqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi/rQCN1UClihn52Bw5O/Z+thyimvt6RvcefLiK1au8=;
 b=oAnEXbJXKE6IRFUi81OViQwWTR56Lf6rngyKN6zunoiWF/YZ/zy8o6vmGpiBf6Vn8DxYmdtBldND2IbTurOXouvErWT4khPQw1aflVZl6OC8384RiRyC25pMIDStf2tDx7iN/o3q4h4sB2VW0/JoFzS5IjrWXWwPQ3fJvNF2emqSOL8p0EUcIGFd+3dmhJWgGVYtS5xxcJArrKx9UTnIYWQniJpXxPDV68IvD+MTAdXsueTbSUEE9i303sfU/32I4DAVEevFsdwgWQ4bRK0QP2fxTAUhbVerW0rpMHPhxOCJf2Qwkf7udEnE61g7B5MTAgz2Y0pTGEHGXPCbylziog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi/rQCN1UClihn52Bw5O/Z+thyimvt6RvcefLiK1au8=;
 b=5f/iI8IpOsf4vJZ7vQRoIKGRdGFcA+6dxNYAYLe60G5zroEJ5KTIYaIxUfV5dToC73nwyaNp9HPJiLqbXM4GNWdu3pOl8uZaV7dEup5N6JLvTHl95FsKwNCWoNFmmZjUX9w0rS+mrtZLhTlkmr5Qe8gNciYUckrYydpOQSBhtPk=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Tue, 12 Sep 2023 14:22:20 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::59) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 14:22:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 07:22:19 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:17 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [RFC PATCH v3 net-next 0/7] ethtool: track custom RSS contexts in the core
Date: Tue, 12 Sep 2023 15:21:35 +0100
Message-ID: <cover.1694443665.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 727a750f-3548-4731-e3f4-08dbb39bad0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OJnDtIM3wuh/My9eouoljcvX0IgGguYhvaaZ5NnQs3hKyZvyc/jKlxkT8Xs4Uajq4xvbelI20GERb5lrFdqowd8QbwkMC1rWdSOp/o+Wp1gDCCRA7twu1HS29ancqOweHRJr0dQHlhNHdZzclm+ocstUKO/kzXEqXwyjDv0nqtHLSuiEcCL4XisWDeavlzvwLKs3dh12m6qPd8fUZQNtx14TV/DiECUXPgGIPBmjLtc5CWfEF8v4dCONaGCZemg4PX3Ku7iI0LiPhOdopimuv8YKZtrUa+RgPngaLUl4mcQTxoIzC4TGFpTlfndObGrMrm0ZWXgxNkiL0RiKNcpfOgrdPywdwh2FaKLhpHEhNaMZMpSy8zh0LBD8ZgieImmYThUA5YF7uEQ1L0QuuvDYX+FMof0nBtgQcaDqJLgm+xCJnT3ewTjUCf/H6qoMX9CwaTdKR9Ke6UEs4aI1Z/mZPK6IL17q4HCL46VgN8lZJss48/eeSJgqRYG7hN242wsVgiLq9v65rSG73M3Lzzsi/ylNFfXYHJ6Tq1eWbVkQjkkBkRfqezr7KWjO/h1lbcqrj7CkuZO5A65GzDR72sQGGY7D6Q/jCvDpoQuRDqjBHW2ixJrWUMK/QDPG82crjQRISJFm2LqMF/v465yZf+MWPF8+EpT4HhFU1mLb+7sJoRZpyLlx3gdozUjfGRpQHLNlD/t0rCF1GmOxf75jIyTsNkL+JYz1qWtgsChMTBomtSibmt3qNtVeACoP1SLxDR/fs9FHTM6TMhENBXvOsolnDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(356005)(2876002)(2906002)(55446002)(86362001)(336012)(426003)(26005)(478600001)(6666004)(36860700001)(9686003)(36756003)(81166007)(82740400003)(47076005)(83380400001)(40480700001)(8936002)(41300700001)(7416002)(4326008)(8676002)(5660300002)(70206006)(54906003)(316002)(110136005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:20.6503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727a750f-3548-4731-e3f4-08dbb39bad0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

From: Edward Cree <ecree.xilinx@gmail.com>

Make the core responsible for tracking the set of custom RSS contexts,
 their IDs, indirection tables, hash keys, and hash functions; this
 lets us get rid of duplicative code in drivers, and will allow us to
 support netlink dumps later.

This series only moves the sfc EF10 & EF100 driver over to the new API; if
 the design is approved of, I plan to post a follow-up series to convert the
 other drivers (mvpp2, octeontx2, mlx5, sfc/siena) and remove the legacy API.
However, I don't have hardware for the drivers besides sfc, so I won't be
 able to test those myself.  Maintainers of those drivers (on CC), your
 comments on the API design would be appreciated, in particular whether the
 rss_ctx_max_id limit (corresponding to your fixed-size arrays of contexts)
 is actually needed.

Changes in v3:
* Added WangXun ngbe to patch #1, not sure if they've added WoL support since
  v2 or if I just missed it last time around
* Re-ordered struct ethtool_netdev_state to avoid hole (Andrew Lunn)
* Fixed some resource leaks in error handling paths (kuba)
* Added maintainers of other context-using drivers to CC

Edward Cree (7):
  net: move ethtool-related netdev state into its own struct
  net: ethtool: attach an IDR of custom RSS contexts to a netdevice
  net: ethtool: record custom RSS contexts in the IDR
  net: ethtool: let the core choose RSS context IDs
  net: ethtool: add an extack parameter to new rxfh_context APIs
  net: ethtool: add a mutex protecting RSS contexts
  sfc: use new rxfh_context API

 drivers/net/ethernet/realtek/r8169_main.c     |   4 +-
 drivers/net/ethernet/sfc/ef10.c               |   2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   5 +-
 drivers/net/ethernet/sfc/efx.c                |   2 +-
 drivers/net/ethernet/sfc/efx.h                |   2 +-
 drivers/net/ethernet/sfc/efx_common.c         |  10 +-
 drivers/net/ethernet/sfc/ethtool.c            |   5 +-
 drivers/net/ethernet/sfc/ethtool_common.c     | 147 ++++++++++--------
 drivers/net/ethernet/sfc/ethtool_common.h     |  18 ++-
 drivers/net/ethernet/sfc/mcdi_filters.c       | 133 ++++++++--------
 drivers/net/ethernet/sfc/mcdi_filters.h       |   8 +-
 drivers/net/ethernet/sfc/net_driver.h         |  28 ++--
 drivers/net/ethernet/sfc/rx_common.c          |  64 ++------
 drivers/net/ethernet/sfc/rx_common.h          |   8 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +-
 drivers/net/phy/phy.c                         |   2 +-
 drivers/net/phy/phy_device.c                  |   5 +-
 drivers/net/phy/phylink.c                     |   2 +-
 include/linux/ethtool.h                       | 109 ++++++++++++-
 include/linux/netdevice.h                     |   7 +-
 net/core/dev.c                                |  38 +++++
 net/ethtool/ioctl.c                           | 127 ++++++++++++++-
 net/ethtool/wol.c                             |   2 +-
 24 files changed, 491 insertions(+), 243 deletions(-)


