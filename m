Return-Path: <netdev+bounces-36606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6767B0BCA
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5FDBAB20CCB
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480504CFA8;
	Wed, 27 Sep 2023 18:14:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB294C86F
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9352F5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeNsj4Jqi4Q57sR3RPNCfCOse+qjrsNuRFBCO82jFW+Nc8MYQca+9HYIQCO7K3q0mHWFhZsu1j0R/gssdDUb6pEnvgYZ11i/fIhw9R5iehd02FkwprQUfX1YbeM5C5+9B9MnYR7z2trwFHgYFQ+7sftX2VZh91ffAhrEgbifqPF7mM02p/VCzuwmk7EIZgRS8iYPR2Fci9c5VVse6nR1e1e99Kt76BIIivmLjs3su892zHXZ/8B1KRABDZKoyPWZ70W9IFBeF1wAsoo/qmRGvjAkryUEWSAyF69TfBz0XUg2FSmIX4IePOPPRX5Um7jW+sKdQMnDo+Sb3LBSLPK9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWMk5Mdc9QZeFPR0xjQejX9yVvb+iT3NFFEozuU7onY=;
 b=d4r53INYpKcG1esheS546J1Hi11unx7DvXqBVBomBBYJ691F6hCH5gdhZHrnQYGT0alPdJHCcHEPd4/PWHOYaXMEPsZNKQ04acQ304vCb4CT6SFpx2bnRVRxJX10X9JxZyyib9tndcXXG3N3ykkOjlogGwYOVGg/1Xe73ZLLh/K9ygYkYH60XE+olZiTII/Ri4inGGnxa2hfxfNABPGTi0mtL7G25K+TthayzATRGAFuCdxmvt/DQzo8sfINBhndgcPwRs7QPkc2FdfbYEBuOC5Mmq3gApn8Fa3UOgOHvv9hqDx0T+nnF6zOINUWdYZjiWmIRY7PbEjHc2Zbd2Dbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWMk5Mdc9QZeFPR0xjQejX9yVvb+iT3NFFEozuU7onY=;
 b=WoNm65NGFaxhVkiKq6ibVFuqBbpeNf0gHl/nppa9jCKYLMHuddgUqIzhZt5nhwL5a1nI8u+fTxjlCv6ZV2xpRTm9bFbNWt8ClY2IHhlDueyCCl/R3AjhHgGQooA0wSLPLJNTx9kIzz7YIVJAnJ0tZW7fuq+A3lUYieN9T+nryYo=
Received: from SN7PR04CA0196.namprd04.prod.outlook.com (2603:10b6:806:126::21)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Wed, 27 Sep
 2023 18:14:33 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::b9) by SN7PR04CA0196.outlook.office365.com
 (2603:10b6:806:126::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 11:14:32 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:30 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [PATCH v4 net-next 5/7] net: ethtool: add an extack parameter to new rxfh_context APIs
Date: Wed, 27 Sep 2023 19:13:36 +0100
Message-ID: <63183b19786e2a97dfe55ed31313ede1a50427fc.1695838185.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 984f3fc4-f73e-428d-941c-08dbbf8599a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iHm5/g7sH75Ge7IMrD6KvKKgH0fP8al041xxlw3oMJrpZIAAHPFVQ7XyyRY9Wt3sXqiaymwmfS7Z1IFXy2e7MNWFAH13b8wVXLNb4S0wq63ng6O1ZNlm8gZ3rMHn6TLkSRzsu0pbvr6yaLyzvZSjas/StPfZkgRA6Eb9KsrDZwyrxaM2E2bhmm9jq5q4ojF+Zz+dKt0UymKx60VUpqq6lXJnxQ/ww9aIxTipVqUpnJjlaDo8tUmGh2xwJpzYYT+PE0i+x+RhYmyzMj0HXAnhGOD+Fz+aozZwKzonX+e1Wj3R8r8Oxbvn3+KZx5OVizAKiEYr+WZLc4RMJETQ4+vsTW4brQvfkrDggv/3aXaEDVdNmyFxkwzHX/yWqPm82TD3Otk65S43Kp1/YyUjppLWHhcBU6gzs9fScO295Jf9Kmaadaib6wboZ07Y3EtwX4dm533I+Bkp2jK4MAHdjQMrcj8PwmAlkHCN0qXUu22XYBfCSCuf94QZSLNu3Ixl+qJMmFtp7H+EvwB78zJoGqA44+90yU7u7iwSZaBbc2/6ZVN0xSvBSW2hC159DcfZXLPFPPq9K/7FNDwEZVM9PVQbi31arTO0qld29lY3/8E8ajB/Wx0m8oydkT0FRrx2NbR4HNr6JgsyBhTnd4Rcbq7YbqiC92xknQcPnd2dgNh+XMKHvoeFWzy/RrT04NAv3xPZ8eYgVPjrGS/eEyjcVSNmBSH2oPiQqiHLkv22KUA4OvFCD5BLjzNT+2Av8VB7bzQPl0dVdukM+dqGHvbgMEQRHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(426003)(336012)(9686003)(110136005)(70206006)(70586007)(26005)(8676002)(4326008)(8936002)(40480700001)(82740400003)(356005)(316002)(81166007)(54906003)(41300700001)(83380400001)(5660300002)(478600001)(7416002)(47076005)(40460700003)(36860700001)(2906002)(2876002)(86362001)(36756003)(55446002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:33.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984f3fc4-f73e-428d-941c-08dbbf8599a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Currently passed as NULL, but will allow drivers to report back errors
 when ethnl support for these ops is added.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 9 ++++++---
 net/core/dev.c          | 3 ++-
 net/ethtool/ioctl.c     | 9 ++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 975fda7218f8..c8963bde9289 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -927,14 +927,17 @@ struct ethtool_ops {
 	int	(*create_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
 				       const u32 *indir, const u8 *key,
-				       const u8 hfunc, u32 rss_context);
+				       const u8 hfunc, u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	int	(*modify_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
 				       const u32 *indir, const u8 *key,
-				       const u8 hfunc, u32 rss_context);
+				       const u8 hfunc, u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	int	(*remove_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       u32 rss_context);
+				       u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
 				    const u8 *key, const u8 hfunc,
 				    u32 *rss_context, bool delete);
diff --git a/net/core/dev.c b/net/core/dev.c
index 637218adca22..69579d9cd7ba 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10892,7 +10892,8 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 			xa_erase(&dev->ethtool->rss_ctx, context);
 			if (dev->ethtool_ops->create_rxfh_context)
 				dev->ethtool_ops->remove_rxfh_context(dev, ctx,
-								      context);
+								      context,
+								      NULL);
 			else
 				dev->ethtool_ops->set_rxfh_context(dev, indir,
 								   key,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index c23d2bd3cd2a..3920ddee3ee2 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1381,14 +1381,17 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			if (create)
 				ret = ops->create_rxfh_context(dev, ctx, indir,
 							       hkey, rxfh.hfunc,
-							       rxfh.rss_context);
+							       rxfh.rss_context,
+							       NULL);
 			else if (delete)
 				ret = ops->remove_rxfh_context(dev, ctx,
-							       rxfh.rss_context);
+							       rxfh.rss_context,
+							       NULL);
 			else
 				ret = ops->modify_rxfh_context(dev, ctx, indir,
 							       hkey, rxfh.hfunc,
-							       rxfh.rss_context);
+							       rxfh.rss_context,
+							       NULL);
 		} else {
 			ret = ops->set_rxfh_context(dev, indir, hkey,
 						    rxfh.hfunc,

