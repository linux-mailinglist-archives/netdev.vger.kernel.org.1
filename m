Return-Path: <netdev+bounces-36602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB67B0BC5
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 36B0A285003
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E54C874;
	Wed, 27 Sep 2023 18:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C504C84C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD06E5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsN7FLphchIxz1Cn+XYyjZRVqT6CqUPxQ8vNLNMqLpY89730P0TjVZYjzBxIMS0ydVaU6ohye/Iw03CEBEBkr7SvqyXSBmwzqp3NS49U0XSjNQiY931jTTIJWvDdP64pK1jwQHrjc7S1Vl7NHudXmis/qGl97ZOcX93niehdhJUXJ/P0/cUwhe/HiYpz/VqYLpRboUVVh2nxW67wLLp6rGtaK36j9aGSd5+5GMtgAfURyXBOZJ40exPtRYgadT7/XeYDWkK3cQN/jJOiFV50xrI+meCdYVQeXGSHDhIo3TOVFwSOFkJbaIwkJ/O0Y6TLXbgVuaEYd1fTqKW+kocAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQurpITnT2DpnE9XihlOSI73bKU27GQMvRc+ASjBS/s=;
 b=a+NoxlDBVj7BoY66AiRhDAJYLbjvnUCWDY+KwbT6FmxvAyEGznr3MQdOGQNk2Tho5RY/23KFsErbdcN+9Uhizh0pMrcxSJqLXvvx04PjzfRAOqU6zj3qFA13/g4u7EzexEctVZ8U2T7mlLhstBsMDcmbp6ZeeYO+/yOeXRWhdxzQdBV3ywaJ+ujGs5Q9aJmGpjm6bx/EJNEJK4MKTj70G/9qBeRn8/84mHgt+9IOi0rSrbOhCg6eLIc49G+/31apS8TevAcvZYLQYMF49wMaDJwi2+QerQ1+U874V5crP/4yCmsTm/tf2+YbUnRkNo4GIOVqKxR5qW6Qe2OYGqk/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQurpITnT2DpnE9XihlOSI73bKU27GQMvRc+ASjBS/s=;
 b=0braNgIz9sWo64lwEn529BwPa8TQkYbaob/YkapqD/Xdk46kmL7fKisbdHtbUGQiqVH9uKHbMGLk0JPhGEgRYDNc8OkLmoTXNCuIY9WhQOIVmksNTXQbsS4icSqJ2BpbnXIcgmenSabdv+XlEsxY6PeCpFCUrQe1D1XLehZtzjI=
Received: from CH0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:33::26)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Wed, 27 Sep
 2023 18:14:21 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:610:33:cafe::21) by CH0PR08CA0021.outlook.office365.com
 (2603:10b6:610:33::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:20 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:17 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [PATCH v4 net-next 0/7] ethtool: track custom RSS contexts in the core
Date: Wed, 27 Sep 2023 19:13:31 +0100
Message-ID: <cover.1695838185.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2574db-d4cb-40f3-0aa4-08dbbf859229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wjZCE3V0+QXuYab/k6bVHThac5c5IL7Uc6y0C8PubrjXleXPb3Fxgnc2K14A5bUdYj/qDIYZRbN52VZ+IhJXA5RZEFbD3smkCtK9TgWgcu0mbriCQiVK99/sIUz2Vep6bPk4LNrToeAXlbwq15ckbbxBYe+ntNX+Yny1mME9cYnCQNZYjB9h+yZ5sZ7Ic9NcMZwur6J+tIftkMk9Qs+XNr7DJ5nJ3m1ZGCvwo7nWx5OtYfU9beO1QUu3hvvQu22qJX9N/nRmuiInuCrX3zRaAVkFCSzTpF0UuIfcIjbazi01MpEWMwFneEr28aijW65OZBlqDQ0On7Vtl7EhD9WTSk81cGmqRq/fIjFk/0yOaf2YAGB3ZCpb9cI58z7zlUTmQqmHjbN4hQ4+clbdMHT0A1e4KPHipEER27FXl8JYzCjFhfm9DqAW7ev9HBqoOYFxp2yAUNINfEaZP/yYvzjOSnW9Vex0cAZZ568NLbefcDEiyFfEsN0We5myMh/mEjya0uzwjDQlt76M9FzAS9XwislvRDHu3lp+2edS3NjGaQ1fdSDdz51yAudA3jcROLjtnkJFc4V5u6a0KkDrwttFU3Mj4mb4FCcOdZoJAv1eH2JU1BxUNzHcokGTqx9l+UDhOGfGxDJPsRksRfvvNebAInPiN711iMn82gn+6BFlwcSlKKLx2PnYZLOAZqgLIHBwC6MXEap3xiOpO8R8nDTjjjvvFUv/+amKROfWaKoVa1TwWOEkCUDWqVCDVtUe/CF3FcGjb+nidfJkvEo1W3Mv2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(9686003)(40460700003)(316002)(110136005)(81166007)(54906003)(36756003)(478600001)(70206006)(70586007)(41300700001)(26005)(7416002)(6666004)(356005)(82740400003)(47076005)(2876002)(2906002)(83380400001)(86362001)(55446002)(36860700001)(8936002)(426003)(40480700001)(8676002)(336012)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:20.6151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2574db-d4cb-40f3-0aa4-08dbbf859229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

Changes in v4:
* replaced IDR with XArray
* grouped initialisations together in patch 6
* dropped RFC tags

Edward Cree (7):
  net: move ethtool-related netdev state into its own struct
  net: ethtool: attach an XArray of custom RSS contexts to a netdevice
  net: ethtool: record custom RSS contexts in the XArray
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
 drivers/net/ethernet/sfc/mcdi_filters.c       | 135 ++++++++--------
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
 net/core/dev.c                                |  42 +++++
 net/ethtool/ioctl.c                           | 125 ++++++++++++++-
 net/ethtool/wol.c                             |   2 +-
 24 files changed, 494 insertions(+), 244 deletions(-)


