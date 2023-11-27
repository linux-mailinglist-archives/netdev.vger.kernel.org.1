Return-Path: <netdev+bounces-51203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B72FA7F98EE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 06:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA99B20A2C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 05:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F653BA;
	Mon, 27 Nov 2023 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="MIwPOLjc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61F3E4
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 21:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxVCjoYuAdlm1x6JuYSz8BzDIWIZ6CrcQcvYr16KgqsSKYUwX2xiuuoldROAKwSMPUKFgHxykpvb6TxBZU5o4quB2w+dsQs94WHnF80EikT4gPE8SKozBcrjt15n6MZnAE2qLmQ6hx9WNpHhnOmv/26HFkHyAAyc9iSRkK8WexYV8FlARV13OLNVawZh/yPgXnXWThiQI0t8hF1LluE+FFihwvqjrDI8qG8FaBEaQ0/u6p9XEtKAKolB7ITyhsOjLJEOp+HVu7UCtQS2IpaNd9G3d9LdTlOkcwp0rmIitfbES61EKh/xGbJVMVeWnKI9MAMDOpOZieU3ZXSBDyPa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCtbXL5OQdiHsGqa4LHB9YmqoJRlih6duFqvyzmSPH0=;
 b=jxio2uhTyTrS09h/kM/2SMocductuYxp7gcLSQP3brgkL2t55F49FqsQ5R0NSb/+mqD+Ki+/lR05bZ8SiEDhIzyO1MI+EozvVTDzxCuz8aHYgcliQ3xMzBQbsyfQSPMGMgSnr0IMm2hgle6CG2GuLyak7Nmwh5XYI8y8NqNgSA/QLfqSn7aeRLnBpyRe2Ic6q4GepCxrQ3fWORusYnZfIOy6NJOCvBzXTmthCOyW5UMWGCadinOr6Jrjfzr+9ug2aqIwxkyqnRSkJZqlrLnpJrCx2bq0NgzGuRbvG/XygG/lph/lFBz/dfXXiur2982rODdy+4QdJIVz+AVzv5ktLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCtbXL5OQdiHsGqa4LHB9YmqoJRlih6duFqvyzmSPH0=;
 b=MIwPOLjchVK5692ZrLkG14o4gHdIknGW0bZuCoUhonwMxRbsVcwY3s+1nvzKPfDPnIymRQnTaXJigJzGQ+V9LfrAp3Zj39r8BMzbn834rvF8cGmotqH+1gYaAfTlMdhO7dE08/NF/W0Rla9d6b/K/lAyO1wyDGIz7ujdKHYIJFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by LV3PR13MB6500.namprd13.prod.outlook.com (2603:10b6:408:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 05:51:33 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 05:51:33 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next] nfp: ethtool: support TX/RX pause frame on/off
Date: Mon, 27 Nov 2023 07:51:16 +0200
Message-Id: <20231127055116.6668-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::22)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|LV3PR13MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: a138a027-c3f4-49d3-4b04-08dbef0ce962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RIn3as/rNkl+hhDyDVx45HqfZHM4qZ22NatesJ7mZ34ibElFdqx6GlbItThVqu6FyaxNvPBNZWyTJavV7YnynnTSfZ9N4bgz4V7P9WfPSX3sjvh0JYVc6Z1sZD07F5rLkijF2g1xNyVMPcOYInw+A5a5osV5RlhYDIhYJR8JiefdUyW6j5JZAcnE1M+nBM/6YhhWRZ9Wv+Iu0+lLtQdJOfmoUYmQ+TUTUOUpcE+nv6N3WaUTyf4kwJwmhXxEjxfSPUcjK7oWLX2ttlNlpdkqleIr76jzi0MtQ9OKK0+SBNDNxODxcG1g9Ma+WbJdtKlLEg801ZR8tm109kYqV09Q9ZqvepNYcbD5mrmjmSbXs9n4UBI1LcHLf7Y/qJZlO02aM+XbqQ6LG7ztAbzQsnqCH1DmweLJJp1OQcRE+gxUhAPncPD4ZpK5YP4+wixHJobFVvY7rdc8qv0R1DAKDpMWpExkXGVNuZ0egky4IUkgok+KXMuLY+dxj7cwmmTKirYeiP6Hp5IDTvtiwfeUbU6mBtZs4QnA49I++/0ty1xSR980za+SuHLMEHEqm5SV/ZoZVSjX48Xp68SYh2etLUBWfOjShuf73V+Q1BR+7kdzGrMAefPrqTFKdiPDE2G628XHZorpY+e+zslOAL1sOGLV5+mdXy8xpVSHWjgJd+DOjSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39830400003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(52116002)(6666004)(86362001)(5660300002)(2906002)(83380400001)(38350700005)(44832011)(4326008)(8676002)(8936002)(36756003)(66476007)(66556008)(66946007)(110136005)(6486002)(2616005)(107886003)(1076003)(478600001)(316002)(26005)(6512007)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OhOyHtWDJ2VVh2/5WQj5r6EYp7j4U5mDa/jvOApJC+xwlMl0qi4R89vfEqS?=
 =?us-ascii?Q?hp3PEY2pxhUGxfStbaWr3SEUicneAMj3iDRqXF70hYU0F3X+27KqIJWFK4H+?=
 =?us-ascii?Q?gcAY1tqN7UzBCRW0dDErCetKkDYns/XuJrH14olB9rPqyt56HWP6amZ2zi2a?=
 =?us-ascii?Q?madoeveqhfmbp2Polluzw6yphazgmJTydqkE3ucdobAXDBcxW7Fqh7FJoG1X?=
 =?us-ascii?Q?m99Ih82d9KqGQzraZjqC5Dc0s2BoA0MqpTBZ2KMuBc8HEhOkvT9HqG7gkh0d?=
 =?us-ascii?Q?0X6o70Bgxs7AfqpIKsJaMgzLXMyYdMehUL24jG5b0Aqv0bA9bKy6K/fqU1v2?=
 =?us-ascii?Q?CRkFTxKRlQLyHor4BMxO3hK0z8X/BXKtfpsI631Gx+/LY8ZXWfJn4YNL/ES5?=
 =?us-ascii?Q?nzf1IKxiDVAH2FdYD5PJcdojz7ysYNPWRn8mfeMIiFY9FDMlDmsD6+H8zWbF?=
 =?us-ascii?Q?v6lVAxG8HRK9W9Tp9mb+8sZ3v3Okd51dnQK3ZMowmMyqtOiuJ3PTIzVcCwyL?=
 =?us-ascii?Q?QrH55r91eQgNeC+8jDL+KwIPW/4sukRzf0/dEsLr4UU/4q/5JkDak0KNEFHx?=
 =?us-ascii?Q?R2M40YjuCxu5PvkQSEqHsn4m8knXekVPAFX36e/aQp7sjhNZeL6oLrfL20UU?=
 =?us-ascii?Q?zUjYyusQy5MoGFZsI23dl4ItIMzFEX19sisiKwSNaTC20CIZ13o54KcRIQtp?=
 =?us-ascii?Q?fqvDi+PRkYY8lLc2xJdCw9qVuJYMjFTa5PmPi8sQ9IilCUeWSHyt3D7H4syo?=
 =?us-ascii?Q?lh6+zeasD+39KBxjd5C9IA1iAo+/F3fQ2abfcJCXrR+BM+4AZcTDVXi46AxE?=
 =?us-ascii?Q?/Vk7gF65bNCCbF7HkDJC31YCISBy52zdvAk0e/TAb2D1/Uk0up9kIG8NVTFQ?=
 =?us-ascii?Q?qFVqKxxJRz7MGBS+hrN1OsPO/S6rJPb34CJ01woRSdLIg3mOUErnpH8LYo/y?=
 =?us-ascii?Q?R0YBZhehkLxsPCBbS/BWsdVNwDShEwW+7MkqPLXBTY1/nomi21YQYqFdOB73?=
 =?us-ascii?Q?p7wtJL4GLgajkIdQXs+qc/LninWHlH2tnVdKSFFhj6Ek7UXcPvWmKHqPDLtV?=
 =?us-ascii?Q?Rnk1ygs9k6LY66r6wHb/l3/Zrh3M6N9Wswpr+i7K1NCPDDtEU0XZFTyid+6w?=
 =?us-ascii?Q?FRw3Oe9YmFawz4nh5SXNWH0k5ZongRf4gq5AqY7WCghBKF+lSxRCvDiqq3kC?=
 =?us-ascii?Q?irMiWmmbuW1c2sG8YIVNSvLkDxnUSWJ0jEgKPIcYF2zliHMKT6D9GMcTDrHT?=
 =?us-ascii?Q?NM1Pd42Wjaqd6+RPQv6In7d9L4OS51TfBnqYr3NpDzaMR9BZ6qxM7xBRim/D?=
 =?us-ascii?Q?/fSA0pVZTfp0r9jzjfoO3jWRwk3nhcgCqYI+Cif6XyWlL1TJ/sTGYdtbcox4?=
 =?us-ascii?Q?uaafPinqTZSPCvUYCuyFT5A6MWM3SfFrYKsYI1xs0+NC+qhfEAoljN+/E4xB?=
 =?us-ascii?Q?q1kvfWt97zK2eh1Pb4/2zpEmnll33lGEc9Pynv1RTmzlh1brenGBKMZGf5Jq?=
 =?us-ascii?Q?5g+s7qb/vB/HIzgIIXFNZryX4DigoEv7Aqti1coh6fpKKYCWKXVTcJ2MBgYM?=
 =?us-ascii?Q?i9iFzfnTHBx1Zmf+4lZOKDXpds7/lrEf2IKasEWDYOKkhi21RELfIuNDQIK7?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a138a027-c3f4-49d3-4b04-08dbef0ce962
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 05:51:33.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqM7+mLJ8H4Q1bCWbIC9nH278+4tNF+1wkAN9FLpbHcZgh5hDdaPZy1bFMM84s9oA2ocXcfPeWEv+SJ6+sg8wXWmEWYp1kzXiJuHDpwipQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6500

From: Yu Xiao <yu.xiao@corigine.com>

Add support for ethtool -A tx on/off and rx on/off.

Signed-off-by: Yu Xiao <yu.xiao@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 32 ++++++-
 .../ethernet/netronome/nfp/nfpcore/nfp_nsp.h  |  6 ++
 .../netronome/nfp/nfpcore/nfp_nsp_eth.c       | 90 ++++++++++++++++++-
 3 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index d7896391b8ba..776bee2efd35 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -2235,6 +2235,30 @@ static int nfp_net_set_channels(struct net_device *netdev,
 	return nfp_net_set_num_rings(nn, total_rx, total_tx);
 }
 
+static int nfp_port_set_pauseparam(struct net_device *netdev,
+				   struct ethtool_pauseparam *pause)
+{
+	struct nfp_eth_table_port *eth_port;
+	struct nfp_port *port;
+	int err;
+
+	port = nfp_port_from_netdev(netdev);
+	eth_port = nfp_port_get_eth_port(port);
+	if (!eth_port)
+		return -EOPNOTSUPP;
+
+	if (pause->autoneg != AUTONEG_DISABLE)
+		return -EOPNOTSUPP;
+
+	err = nfp_eth_set_pauseparam(port->app->cpp, eth_port->index,
+				     pause->tx_pause, pause->rx_pause);
+	if (!err)
+		/* Only refresh if we did something */
+		nfp_net_refresh_port_table(port);
+
+	return err < 0 ? err : 0;
+}
+
 static void nfp_port_get_pauseparam(struct net_device *netdev,
 				    struct ethtool_pauseparam *pause)
 {
@@ -2246,10 +2270,10 @@ static void nfp_port_get_pauseparam(struct net_device *netdev,
 	if (!eth_port)
 		return;
 
-	/* Currently pause frame support is fixed */
+	/* Currently pause frame autoneg is fixed */
 	pause->autoneg = AUTONEG_DISABLE;
-	pause->rx_pause = 1;
-	pause->tx_pause = 1;
+	pause->rx_pause = eth_port->rx_pause;
+	pause->tx_pause = eth_port->tx_pause;
 }
 
 static int nfp_net_set_phys_id(struct net_device *netdev,
@@ -2475,6 +2499,7 @@ static const struct ethtool_ops nfp_net_ethtool_ops = {
 	.set_link_ksettings	= nfp_net_set_link_ksettings,
 	.get_fecparam		= nfp_port_get_fecparam,
 	.set_fecparam		= nfp_port_set_fecparam,
+	.set_pauseparam		= nfp_port_set_pauseparam,
 	.get_pauseparam		= nfp_port_get_pauseparam,
 	.set_phys_id		= nfp_net_set_phys_id,
 };
@@ -2499,6 +2524,7 @@ const struct ethtool_ops nfp_port_ethtool_ops = {
 	.set_link_ksettings	= nfp_net_set_link_ksettings,
 	.get_fecparam		= nfp_port_get_fecparam,
 	.set_fecparam		= nfp_port_set_fecparam,
+	.set_pauseparam		= nfp_port_set_pauseparam,
 	.get_pauseparam		= nfp_port_get_pauseparam,
 	.set_phys_id		= nfp_net_set_phys_id,
 };
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
index 00264af13b49..dc0e405c1349 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
@@ -189,6 +189,8 @@ enum nfp_ethtool_link_mode_list {
  * @ports.enabled:	is enabled?
  * @ports.tx_enabled:	is TX enabled?
  * @ports.rx_enabled:	is RX enabled?
+ * @ports.rx_pause:	Switch of RX pause frame
+ * @ports.tx_pause:	Switch of Tx pause frame
  * @ports.override_changed: is media reconfig pending?
  *
  * @ports.port_type:	one of %PORT_* defines for ethtool
@@ -227,6 +229,8 @@ struct nfp_eth_table {
 		bool tx_enabled;
 		bool rx_enabled;
 		bool supp_aneg;
+		bool rx_pause;
+		bool tx_pause;
 
 		bool override_changed;
 
@@ -255,6 +259,8 @@ int
 nfp_eth_set_fec(struct nfp_cpp *cpp, unsigned int idx, enum nfp_eth_fec mode);
 
 int nfp_eth_set_idmode(struct nfp_cpp *cpp, unsigned int idx, bool state);
+int nfp_eth_set_pauseparam(struct nfp_cpp *cpp, unsigned int idx,
+			   unsigned int tx_pause, unsigned int rx_pause);
 
 static inline bool nfp_eth_can_support_fec(struct nfp_eth_table_port *eth_port)
 {
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
index 9d62085d772a..5cfddc9a5d87 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
@@ -42,6 +42,8 @@
 #define NSP_ETH_STATE_ANEG		GENMASK_ULL(25, 23)
 #define NSP_ETH_STATE_FEC		GENMASK_ULL(27, 26)
 #define NSP_ETH_STATE_ACT_FEC		GENMASK_ULL(29, 28)
+#define NSP_ETH_STATE_TX_PAUSE		BIT_ULL(31)
+#define NSP_ETH_STATE_RX_PAUSE		BIT_ULL(32)
 
 #define NSP_ETH_CTRL_CONFIGURED		BIT_ULL(0)
 #define NSP_ETH_CTRL_ENABLED		BIT_ULL(1)
@@ -52,6 +54,8 @@
 #define NSP_ETH_CTRL_SET_ANEG		BIT_ULL(6)
 #define NSP_ETH_CTRL_SET_FEC		BIT_ULL(7)
 #define NSP_ETH_CTRL_SET_IDMODE		BIT_ULL(8)
+#define NSP_ETH_CTRL_SET_TX_PAUSE	BIT_ULL(10)
+#define NSP_ETH_CTRL_SET_RX_PAUSE	BIT_ULL(11)
 
 enum nfp_eth_raw {
 	NSP_ETH_RAW_PORT = 0,
@@ -180,6 +184,15 @@ nfp_eth_port_translate(struct nfp_nsp *nsp, const union eth_table_entry *src,
 
 	dst->act_fec = FIELD_GET(NSP_ETH_STATE_ACT_FEC, state);
 	dst->supp_aneg = FIELD_GET(NSP_ETH_PORT_SUPP_ANEG, port);
+
+	if (nfp_nsp_get_abi_ver_minor(nsp) < 37) {
+		dst->tx_pause = true;
+		dst->rx_pause = true;
+		return;
+	}
+
+	dst->tx_pause = FIELD_GET(NSP_ETH_STATE_TX_PAUSE, state);
+	dst->rx_pause = FIELD_GET(NSP_ETH_STATE_RX_PAUSE, state);
 }
 
 static void
@@ -497,7 +510,7 @@ int nfp_eth_set_configured(struct nfp_cpp *cpp, unsigned int idx, bool configed)
 static int
 nfp_eth_set_bit_config(struct nfp_nsp *nsp, unsigned int raw_idx,
 		       const u64 mask, const unsigned int shift,
-		       unsigned int val, const u64 ctrl_bit)
+		       u64 val, const u64 ctrl_bit)
 {
 	union eth_table_entry *entries = nfp_nsp_config_entries(nsp);
 	unsigned int idx = nfp_nsp_config_idx(nsp);
@@ -629,6 +642,81 @@ nfp_eth_set_fec(struct nfp_cpp *cpp, unsigned int idx, enum nfp_eth_fec mode)
 	return nfp_eth_config_commit_end(nsp);
 }
 
+/**
+ * __nfp_eth_set_txpause() - set tx pause control bit
+ * @nsp:	NFP NSP handle returned from nfp_eth_config_start()
+ * @tx_pause:	TX pause switch
+ *
+ * Set TX pause switch.
+ *
+ * Return: 0 or -ERRNO.
+ */
+static int __nfp_eth_set_txpause(struct nfp_nsp *nsp, unsigned int tx_pause)
+{
+	return NFP_ETH_SET_BIT_CONFIG(nsp, NSP_ETH_RAW_STATE, NSP_ETH_STATE_TX_PAUSE,
+				      tx_pause, NSP_ETH_CTRL_SET_TX_PAUSE);
+}
+
+/**
+ * __nfp_eth_set_rxpause() - set rx pause control bit
+ * @nsp:	NFP NSP handle returned from nfp_eth_config_start()
+ * @rx_pause:	RX pause switch
+ *
+ * Set RX pause switch.
+ *
+ * Return: 0 or -ERRNO.
+ */
+static int __nfp_eth_set_rxpause(struct nfp_nsp *nsp, unsigned int rx_pause)
+{
+	return NFP_ETH_SET_BIT_CONFIG(nsp, NSP_ETH_RAW_STATE, NSP_ETH_STATE_RX_PAUSE,
+				      rx_pause, NSP_ETH_CTRL_SET_RX_PAUSE);
+}
+
+/**
+ * nfp_eth_set_pauseparam() - Set TX/RX pause switch.
+ * @cpp:	NFP CPP handle
+ * @idx:	NFP chip-wide port index
+ * @tx_pause:	TX pause switch
+ * @rx_pause:	RX pause switch
+ *
+ * Return:
+ * 0 - configuration successful;
+ * 1 - no changes were needed;
+ * -ERRNO - configuration failed.
+ */
+int
+nfp_eth_set_pauseparam(struct nfp_cpp *cpp, unsigned int idx,
+		       unsigned int tx_pause, unsigned int rx_pause)
+{
+	struct nfp_nsp *nsp;
+	int err;
+
+	nsp = nfp_eth_config_start(cpp, idx);
+	if (IS_ERR(nsp))
+		return PTR_ERR(nsp);
+
+	if (nfp_nsp_get_abi_ver_minor(nsp) < 37) {
+		nfp_err(nfp_nsp_cpp(nsp),
+			"set pause parameter operation not supported, please update flash\n");
+		nfp_eth_config_cleanup_end(nsp);
+		return -EOPNOTSUPP;
+	}
+
+	err = __nfp_eth_set_txpause(nsp, tx_pause);
+	if (err) {
+		nfp_eth_config_cleanup_end(nsp);
+		return err;
+	}
+
+	err = __nfp_eth_set_rxpause(nsp, rx_pause);
+	if (err) {
+		nfp_eth_config_cleanup_end(nsp);
+		return err;
+	}
+
+	return nfp_eth_config_commit_end(nsp);
+}
+
 /**
  * __nfp_eth_set_speed() - set interface speed/rate
  * @nsp:	NFP NSP handle returned from nfp_eth_config_start()
-- 
2.34.1


