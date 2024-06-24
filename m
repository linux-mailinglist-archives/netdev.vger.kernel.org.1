Return-Path: <netdev+bounces-106145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B3914FA3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD931C219EE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3B142648;
	Mon, 24 Jun 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lgTqcOq/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E419142635
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238369; cv=fail; b=X5jAhuE1BDsUrWdiDTDzNqj/um2uKBo7FSvW08eDhb6PGUj6bi4SppX1KBH0BQdVk+bax+xhwTHriKm5K6eqFs0f9EETUzqEBGho0nowEQ7avt1SpECBiKhwh7PE+Qrfxcl9yG0bTEhcjOP8k8rptiN3E/A9VGFf8AfyooeFSt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238369; c=relaxed/simple;
	bh=bYlg6lhl6yaPdXOT/V2IAc6nt+nPuGP1kBXZexv5E2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N7JmHMyBupDuIQ9kUEN2pXuzk/sDDpELtjYBYbJfufU1y2OV8XSWmCUYj4AowvhPN2NMn/DUIvjsX6SI2RY9WLUAVsShvKg7nWPW2EYHykxm2htXplc/Zlkkx+xvnIJNCjZYPCDScLXXTXkJctdgoxZmK+PF1BL+tgkVyZABw7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lgTqcOq/; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abWhj3ICqlEYB59078c0XEpVoL+JVl24Jckcbn5LQGIOfGw54KfOmHGPX8k1mIYpGzGjycoJCdtf5KYOL0mfNmv5lxNmh9pbUybYI8NHHrT1WxF/4F9jkkTLf5PFjxBxVPQXnMTnBX8SLmoFmxAVbC9wmWnScdQjQFzhpAMsluhzcZCrLk4eCN750VxBxE1pm0YcFr+g17tfEidiL6Y+iGZ/unYPvhtDLxeXyI9c2SF+PJ2hFLKpFwvGNPNH4zSeQAEfv2xoLpoPUr4Jg0DPBcVMqWQMX4Ie1ZN8ledPWLOsJufiHDkO5/rpKd56oBUMpZWWGATl8Y0X5mDsm8u2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF9OwncYWBxQUW/1WsrXaDXUSClIgwTow4k98TcaH1U=;
 b=jr2Co7QhoHWdvmAZMYNPgODFamvjmLqo72LSdsjm7utR5Ks7j6NCYsKaBqXRuOvhE9dcz8/sdeXqTfXAJXpKRGxUhDTohsJYQzXEX3wCTKukkWv0/l6p6odYUQkaw6RyTlW6NEpZyzP2CJNe4mTarhzqWV0MdGCHJDglsY+KzqwK/I+MkpGVWiinI6OmquKVhgE21obRSCFAyCf8b5Zk+jCnuYAnSRUFKevY4DSYWC78I72tnN5oNiZxEp540VSsNxxa8g46moBcw9BykCv+AlC1s5rde1LHjhk4yGxTcd0UTkzLemhiXQxdaLCuZXPR6JhGZmgaHUQtnpDf9sfe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF9OwncYWBxQUW/1WsrXaDXUSClIgwTow4k98TcaH1U=;
 b=lgTqcOq/J2nMzrdtxNLqQx3vwbbpAyJAnmHhujW4DLXRM0dOTrjWk0MtbwblnR54eafw7NAvICaXn2KItFFUEOIMk8g9RQkNp0NT2860WZhnGRQsOAYSfx0zsHnnpPi4cXJdRks2OhIsihFvpBefQ8Qle7USeicHdr5Mgxr0H8Q=
Received: from BL1PR13CA0234.namprd13.prod.outlook.com (2603:10b6:208:2bf::29)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:12:45 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::30) by BL1PR13CA0234.outlook.office365.com
 (2603:10b6:208:2bf::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Mon, 24 Jun 2024 14:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 14:12:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:44 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:42 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<horms@kernel.org>
Subject: [PATCH v7 net-next 0/9] ethtool: track custom RSS contexts in the core
Date: Mon, 24 Jun 2024 15:11:11 +0100
Message-ID: <cover.1719237939.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e59943b-631c-470c-d4f0-08dc9457b815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|7416011|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vEQrNu7nLAtkS6Cu/wpSe7FwZEDSAog5Tiu1z2yh04GbJ2kAA5j1gKLvp2XF?=
 =?us-ascii?Q?ajBeiHcroelviQ4rjCi+6dEWP4V+6xGeJ2kolOhZw4ExH/O0zxeibXaPjgYt?=
 =?us-ascii?Q?wMW3e3M3ewE8iPGIReMBjbU+Q2yNcKaaZDkegAdEu4d9mfsACqkX9Ie9XBpp?=
 =?us-ascii?Q?BGNvrLgQqMK/cuYzSZ4vBgOm2GX0bcTEhhopmpEYhaAswXeSC/X+20scyZrQ?=
 =?us-ascii?Q?nbH5uTxoqOdfreli3hmkDhmmpH0nhRdG/GKUSnuH08Kp7sokL5PAntTkC/vm?=
 =?us-ascii?Q?torkuPZIgfjb0H2g+qL61/oPPHC6L6V071D/YaFgZZ9ARO/ZAR5rZXvttXTZ?=
 =?us-ascii?Q?4aQh6+GOp0bKjfguJ0nmWifGijnrZcT+qoG+VSv+V2z0lqvYvoR89vNJ4ZTP?=
 =?us-ascii?Q?L1kfwIR8h+hf+0sFX4icm5YG8fIbimsY0yd8Jb55XgOd6Ilcr26+iShgKZcX?=
 =?us-ascii?Q?ziV7ukBDOq4Hh/rBjZcP7a8/OCRaacr2pGTaoUsxqAGMe+bxRj4zDPCkvbjo?=
 =?us-ascii?Q?M0+kKVsAGsDFkrkn/anyfqW+8Jf2JlT3rh35GXZDAAgVeRd8fS9OowASA3kP?=
 =?us-ascii?Q?tVnvXKgg6MLpoB5gB9i/4pm9JYQqgy/Y09oIk/pOGVis5YoGFd7P69vB9HAu?=
 =?us-ascii?Q?ubfLQkPag441jFqaGGEH9p5AhAqebwWUSNDWfFkSD22nLbAjTgZjeVJI6U2W?=
 =?us-ascii?Q?NF7G1Z3UVWZ9lSFzDjolyBHo3/AnhwCXUNuwIzeIp3hT2R1ljmdq1NQ0Dzjf?=
 =?us-ascii?Q?P/0ISUO0Jb2D78V+K0voRnB0N1+gU4/Dg0KI5r/jEUxqAY5ScnW7xnzDPmSJ?=
 =?us-ascii?Q?bF7F7LJmBQHW4vFs+O6MiQCf905sdO0DGl5Q3zeyuPMV9XubEAMdJ4fK1wRA?=
 =?us-ascii?Q?Gziwm9bI4vOoOSTM7Geq2gmvtJZv5gIPjXlNYIX7jAsk94RO8z8poKl3ki8d?=
 =?us-ascii?Q?T579jD+s9kRlnfHusSmNKm+wkfboOZPgyzDfe839o2rFKu9rjip7dgFotpzu?=
 =?us-ascii?Q?zEbWdsTA6bXoAtb7AezmzXIxM62hEDlLr22D0USLaQtKXuQL+v5NRm2ilFef?=
 =?us-ascii?Q?5hHjztlU9V1oA36vqykxJI5qvuriVPSjqa73xrnbVDb8/iiTF6JPhB+i00tl?=
 =?us-ascii?Q?D0A+D2hkQ5m9MRj79gYSG3mpHoBbl3MRKrx++XB2ed/kAEcMdKtUt6cIF/bQ?=
 =?us-ascii?Q?GizG9uASpFQyXZ5UODKIvSMpIJtOF6wOhLoAQ97vlL5YBRTPolilSwXanQD4?=
 =?us-ascii?Q?IwKzCcbuilL3VLbxtqdZARm/1qEpz76rjyP+i44k6XvEsKB728ES2yGHE9m2?=
 =?us-ascii?Q?qG1yG4K/Q3hIIZVx267QWx8MrFYPj86UTER8mSwmWPVwviuxStNYrGzj20Mo?=
 =?us-ascii?Q?MmQFnPf3LTfzUDbdxITgqUAr2Z7mue73rXbBksqVtbZ5X0x8Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:12:45.0646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e59943b-631c-470c-d4f0-08dc9457b815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419

From: Edward Cree <ecree.xilinx@gmail.com>

Make the core responsible for tracking the set of custom RSS contexts,
 their IDs, indirection tables, hash keys, and hash functions; this
 lets us get rid of duplicative code in drivers, and will allow us to
 support netlink dumps later.

This series only moves the sfc EF10 & EF100 driver over to the new API;
 other drivers (mvpp2, octeontx2, mlx5, sfc/siena) can be converted afterwards
 and the legacy API removed.

Changes in v7:
* ensure 'ret' is initialised in ethtool_get_rxfh (horms)

Changes in v6:
* fixed kdoc for renamed fields
* always call setter in netdev_rss_contexts_free()
* document that 'create' method should populate ctx for driver-chosen defaults
* on 'ethtool -x', get info from the tracking xarray rather than calling the
  driver's get_rxfh method.  This makes it easier to test that the tracking is
  correct, in the absence of future code like netlink dumps to use it.

Changes in v5:
* Rebased on top of Ahmed Zaki's struct ethtool_rxfh_param API
* Moved rxfh_max_context_id to the ethtool ops struct

Changes in v4:
* replaced IDR with XArray
* grouped initialisations together in patch 6
* dropped RFC tags

Changes in v3:
* Added WangXun ngbe to patch #1, not sure if they've added WoL support since
  v2 or if I just missed it last time around
* Re-ordered struct ethtool_netdev_state to avoid hole (Andrew Lunn)
* Fixed some resource leaks in error handling paths (kuba)
* Added maintainers of other context-using drivers to CC

Edward Cree (9):
  net: move ethtool-related netdev state into its own struct
  net: ethtool: attach an XArray of custom RSS contexts to a netdevice
  net: ethtool: record custom RSS contexts in the XArray
  net: ethtool: let the core choose RSS context IDs
  net: ethtool: add an extack parameter to new rxfh_context APIs
  net: ethtool: add a mutex protecting RSS contexts
  sfc: use new rxfh_context API
  net: ethtool: use the tracking array for get_rxfh on custom RSS
    contexts
  sfc: remove get_rxfh_context dead code

 drivers/net/ethernet/realtek/r8169_main.c     |   4 +-
 drivers/net/ethernet/sfc/ef10.c               |   2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   4 +
 drivers/net/ethernet/sfc/efx.c                |   2 +-
 drivers/net/ethernet/sfc/efx.h                |   2 +-
 drivers/net/ethernet/sfc/efx_common.c         |  10 +-
 drivers/net/ethernet/sfc/ethtool.c            |   4 +
 drivers/net/ethernet/sfc/ethtool_common.c     | 168 ++++++++----------
 drivers/net/ethernet/sfc/ethtool_common.h     |  12 ++
 drivers/net/ethernet/sfc/mcdi_filters.c       | 135 +++++++-------
 drivers/net/ethernet/sfc/mcdi_filters.h       |   8 +-
 drivers/net/ethernet/sfc/net_driver.h         |  28 +--
 drivers/net/ethernet/sfc/rx_common.c          |  64 ++-----
 drivers/net/ethernet/sfc/rx_common.h          |   8 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +-
 drivers/net/phy/phy.c                         |   2 +-
 drivers/net/phy/phy_device.c                  |   5 +-
 drivers/net/phy/phylink.c                     |   2 +-
 include/linux/ethtool.h                       | 110 ++++++++++++
 include/linux/netdevice.h                     |   7 +-
 net/core/dev.c                                |  40 +++++
 net/ethtool/ioctl.c                           | 136 +++++++++++++-
 net/ethtool/wol.c                             |   2 +-
 24 files changed, 496 insertions(+), 265 deletions(-)


