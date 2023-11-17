Return-Path: <netdev+bounces-48554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE3C7EEC7D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40E91F25C21
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D5DDC5;
	Fri, 17 Nov 2023 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="XFwMtNtC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA9D194
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErwaCEliPSbnXIM3f9et1TMmGTrUBOThWzselzR4aad3P1fKXQZ7NeS7C/3k04vCs/GPyBZ7mLAYV94zGK93hNOzUIGShQVBU6ZZemUyOnSE3vSRrI85pmLxOXIlxzc8GyWKV7DFGITDHJThehEypTHx3oVWHNUqWPd4I3WZXE61wwSKUKeSF1cBcm0pc4nf+RH1vPHlWCfc6TCogH4soQ5fCu7Ej2GQ0sgittz9o+kXzK9LdeKFUGkqf3Yv8x+slxlrm/HZYspur8NDHMxl/hQRssm4am5bp5beYgjylHN/PCX0Xn2m03TSm1n6S8P/w8OynMursS2E0PfnBJ0NXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCaNFyAf0bcmrjNvq/k4RE0DXK929DJDwp8QmwMWrts=;
 b=R4s9m5lSlB8otFcEemoIIY0j2K6/2xI+yqzh3O3QAdLOwsUJ4Y9Sn9yrSKaw42H7JNE8UCbiWFO8hRvWoa2wm5HLI8hZv5HSqvWu/TY48BssE2XyM/LT6ITyhDbyBDqblb/R1fiXbAQg4gsgm7lSVNoLWcnycXXnT1P8Q/r2SF033CZrBIAtRhLp0MKGvEkYrA2txErHTR5/pZ8QcYG6J6837Uruzv2FJo+x1DONWWGhC72ONGVUs0JffwG0cgM5chClk2H4s3Xg5in8Kj1mi4Zwh56qhLFkQQloyAurYfR+CA2feoVdZ0UWDnffp+BSh5cvARpz2j1WwpcExHDesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCaNFyAf0bcmrjNvq/k4RE0DXK929DJDwp8QmwMWrts=;
 b=XFwMtNtCQ0O8iKEF72DBNvmYsdWx2H2K3C2OON1eyYKOijVL5i8RiwODNVi+zEcTuVO2L6qdM3cx2SwHCtM60HfEgBEzp73T6zIHijYuxr/GtOFk1XGVfMnhmugRHwVq1Ku5KT+F6XZFIOPDp5ya1uEx504Wuog0aF23qkWb7Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB4553.namprd13.prod.outlook.com (2603:10b6:610:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 07:11:44 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 07:11:44 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 1/2] nfp: add ethtool flow steering callbacks
Date: Fri, 17 Nov 2023 09:11:13 +0200
Message-Id: <20231117071114.10667-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117071114.10667-1-louis.peens@corigine.com>
References: <20231117071114.10667-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 42993835-f56c-45c9-3c65-08dbe73c748f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TPP3MgcnP9TpG+UGZmE+EB//MtbMVtgPi5ETFM6s2gv6zNCLIzQP4VLD0ZNz8rjo0R3ddraMi+8Tm1FoYysFzuCwiYm3UhLnEE1GPJs2BMxm9aK3/KT9bG7cxD3FDNddfB8VkwG8DzGHUqGx6QKEEmsiArXklp2esal+oSp/vBTjg1mMKFf/qaKAoh2TGBXr6cWSQPUc9SN5F6+LDpZn6LnoxyZCiQFguFYJfFM+8wZEr3nr3IGm2PQBshPyj7MysgCnVCvLwnr+laD36+7gt2uMqa+MeB+R8SGH+F/jKf1TP4CoIfJY6xnc+8DjqO1Kf9lrO252Kx72ts+djZOlHgxnH+W4qRt4HI8/0jCH+kxJ6VgBzHDKW2eIAo5v0b5yosROPrWyvwOdkTK0VksyBFt47M6NUvOI3m+3YmR0XmjBAcW07bllwNAUW8vW5AG35p2bqdmkqNUAndgBzHFjq0SKXbLf6m5W/6LT3nG10g6vAfnjvzJkT9BRDYAY82FOJyKp7Kik5//1/4ind6iczIm8alP0Ob4KsKQqXZ8n3HzMEl1uFFZl4nCqSh3OJa+lLK2jZTbzYcsKr8BHjv/ns04zuFbvZZ4smLgo9pf2xMKyhoZgdAhsGZGapSHAoH+w9x1gTZj4e35T4MCkbHnJ9ck06toiUhLBAzG0uzGNXTHRGf6c0taDphlLUU2Bi6jQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(66476007)(66556008)(110136005)(316002)(2616005)(26005)(107886003)(1076003)(478600001)(83380400001)(38350700005)(6666004)(6506007)(6512007)(6486002)(36756003)(52116002)(38100700002)(5660300002)(44832011)(2906002)(30864003)(41300700001)(8676002)(86362001)(4326008)(8936002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSpgwWIdvFnn0aROVAUvb6hNkLvC+33CQbZxVY7KrQDrC6fQXFJxJm+l1k8u?=
 =?us-ascii?Q?BxkY5Sjf2qUB4PP+2ORiXeWZiDdp2ArIKwPG8+VcwJYme+8X/rjbovlemq5X?=
 =?us-ascii?Q?Fe6FHn2OkU/aMKwEPc8KweZ1I01g/fxZjzFNdSzbUxnL5tPl94Rshmex2d/F?=
 =?us-ascii?Q?bpCYSzn0MQZ0vtD1YIA5c56XOQEa84v/VXiIxfeQ6dXm+S1YTgB0A47gL/ij?=
 =?us-ascii?Q?iV7JN91CqvhTbudbaInly9DR/wXbW7Qq6gxMPnkLAlUugg5W4bENLFIIQdz8?=
 =?us-ascii?Q?nhk1nYJLSnXidhGJTsgkNyktUc8nP4TVTd44oIS2xl+2deQhzPmjYaDOkPMX?=
 =?us-ascii?Q?3XQ9GQ2CMGRg0gMPrwoA5mYiLYZkQWkOlYC9R7I6HpHXowrh/9sv+e1MmwNu?=
 =?us-ascii?Q?fW4J7soRCXHnPtOsmQkuQR10I7F98eLWU8Oldn6bDSRdHLvxhiau086zgFpU?=
 =?us-ascii?Q?dAM38Hht5mbKN/rg+VBN7vIHBY7nFinqjGDmoHHhUESToOz25k6sr4JTDC/v?=
 =?us-ascii?Q?qT+oaMfxApkPI3Wvmt/5AY7bnbZK0GAvGemyLcPhyH8q6ygtAhR8BEbKwgod?=
 =?us-ascii?Q?f6y7h9VAkXqXEIlLKx8oNZPIP2uZBCc9KiXuose1nHnsR2291p10ZqBh5/ch?=
 =?us-ascii?Q?4olS0PIwKGE69NA4zc1wN8XiI2RGtI3CpBv2XKiT+zWNUarabVDXxWblg9qA?=
 =?us-ascii?Q?Aw6/K6xw2RuvtdQc1QbjCQqqN9unmV1jZR3FPhgn4to/XU3cm9L6WYyN43Ui?=
 =?us-ascii?Q?S0+KoE4916waKX/MAXh6Ng3u9Qdws5yIDmBKjCmoQyaGSGzc1jOCsvuUMmPU?=
 =?us-ascii?Q?nSGgXG3vSSxvQLlsQtxa3LWxy7++CFQ7BQGg5LEPVBkocVeHG6cN+2VOm0sJ?=
 =?us-ascii?Q?6FM8ErjN/wdv7/sQ58xAvC3yBMJDL22PfzCOXlIPClg4dIpN06+uGMKm2RPF?=
 =?us-ascii?Q?dkX6b0pGhxlZ+oWCOEc/MybMSeWbAO77oIU9pv8SiFuNcQ4XtEqDM98xnw8v?=
 =?us-ascii?Q?kW3CznaXs3WuW3MJS73Mi/fGEYDzpeyjgyDGG66mENkqmKR6CCBxpjodRr1L?=
 =?us-ascii?Q?5q533/QeqBX8f0mppc5WPmzUcf4ZrYCw8hOHYikoQRR4Uve63DZFMAmjnIC8?=
 =?us-ascii?Q?HH7QPOv7WMXgspxZOaVmlqMn/oenxrE6EQQkMN4WfzbnoVzE1YkuUnB6afeD?=
 =?us-ascii?Q?wa0pHQz1/XcUGDKFEOqhEEur9IDkQDagU9WghiXYqcRfejBKd6rHfottlTem?=
 =?us-ascii?Q?QqjkRXBKZGFz3Rh6iwJidTRPXoJh0ycc0kzArzJgk07cpzftxLmEDhA03Bfb?=
 =?us-ascii?Q?lKhEbowvBc32FNA7TTPSNFnmxuEBy1NthsWrTuSC/qzSLV8SfVR240lm+Cl1?=
 =?us-ascii?Q?bLywqCF5P1XgTOgLnXtjaviZc22ZHVUXcfVTsxAIvRplPrEgOHd7HWGcKSha?=
 =?us-ascii?Q?GMcRBxcUDCvDSx6a1vLdzTxB3WP5LmVs2C3LIMBKhcIh07N4w4kUb4M3WQR0?=
 =?us-ascii?Q?laAzT/8bd4Rr+xW1lrWUyxb3qLBE7D6/vtBq3Xwj7pRsG/naq1MbOytzn+0C?=
 =?us-ascii?Q?dG/StCcoIgrARBgodS+vLdio09A37SQjND0xJZNdU6gfvoxEBkRNyY268612?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42993835-f56c-45c9-3c65-08dbe73c748f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 07:11:44.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTuca7wxd/MIsucH+zDhR8waArCoSefObEGVovqZ0ZO3qDuOQz/nYstD6+1UWhHF8vjeLUSEjkyKi9f4RkuqQtvC0QrC+HS8GxgriMz2IdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4553

From: Yinjun Zhang <yinjun.zhang@corigine.com>

This is the first part to implement flow steering. The communication
between ethtool and driver is done. User can use following commands
to display and set flows:

ethtool -n <netdev>
ethtool -N <netdev> flow-type ...

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  36 ++
 .../ethernet/netronome/nfp/nfp_net_common.c   |  24 ++
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |   1 +
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 369 ++++++++++++++++++
 4 files changed, 430 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index 939cfce15830..bd0e26524417 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -621,6 +621,9 @@ struct nfp_net_dp {
  * @mbox_amsg.lock:	Protect message list
  * @mbox_amsg.list:	List of message to process
  * @mbox_amsg.work:	Work to process message asynchronously
+ * @fs:			Flow steering
+ * @fs.count:		Flow count
+ * @fs.list:		List of flows
  * @app_priv:		APP private data for this vNIC
  */
 struct nfp_net {
@@ -728,9 +731,39 @@ struct nfp_net {
 		struct work_struct work;
 	} mbox_amsg;
 
+	struct {
+		u16 count;
+		struct list_head list;
+	} fs;
+
 	void *app_priv;
 };
 
+struct nfp_fs_entry {
+	struct list_head node;
+	u32 flow_type;
+	u32 loc;
+	struct {
+		union {
+			struct {
+				__be32 sip4;
+				__be32 dip4;
+			};
+			struct {
+				__be32 sip6[4];
+				__be32 dip6[4];
+			};
+		};
+		union {
+			__be16 l3_proto;
+			u8 l4_proto;
+		};
+		__be16 sport;
+		__be16 dport;
+	} key, msk;
+	u64 action;
+};
+
 struct nfp_mbox_amsg_entry {
 	struct list_head list;
 	int (*cfg)(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry);
@@ -987,6 +1020,9 @@ struct nfp_net_dp *nfp_net_clone_dp(struct nfp_net *nn);
 int nfp_net_ring_reconfig(struct nfp_net *nn, struct nfp_net_dp *new,
 			  struct netlink_ext_ack *extack);
 
+int nfp_net_fs_add_hw(struct nfp_net *nn, struct nfp_fs_entry *entry);
+int nfp_net_fs_del_hw(struct nfp_net *nn, struct nfp_fs_entry *entry);
+
 #ifdef CONFIG_NFP_DEBUG
 void nfp_net_debugfs_create(void);
 void nfp_net_debugfs_destroy(void);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index de0a5d5ded30..12eda2c2ac23 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1763,6 +1763,27 @@ nfp_net_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	return nfp_net_mbox_reconfig_and_unlock(nn, cmd);
 }
 
+int nfp_net_fs_add_hw(struct nfp_net *nn, struct nfp_fs_entry *entry)
+{
+	return -EOPNOTSUPP;
+}
+
+int nfp_net_fs_del_hw(struct nfp_net *nn, struct nfp_fs_entry *entry)
+{
+	return -EOPNOTSUPP;
+}
+
+static void nfp_net_fs_clean(struct nfp_net *nn)
+{
+	struct nfp_fs_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &nn->fs.list, node) {
+		nfp_net_fs_del_hw(nn, entry);
+		list_del(&entry->node);
+		kfree(entry);
+	}
+}
+
 static void nfp_net_stat64(struct net_device *netdev,
 			   struct rtnl_link_stats64 *stats)
 {
@@ -2740,6 +2761,8 @@ int nfp_net_init(struct nfp_net *nn)
 	INIT_LIST_HEAD(&nn->mbox_amsg.list);
 	INIT_WORK(&nn->mbox_amsg.work, nfp_net_mbox_amsg_work);
 
+	INIT_LIST_HEAD(&nn->fs.list);
+
 	return register_netdev(nn->dp.netdev);
 
 err_clean_mbox:
@@ -2759,6 +2782,7 @@ void nfp_net_clean(struct nfp_net *nn)
 	unregister_netdev(nn->dp.netdev);
 	nfp_net_ipsec_clean(nn);
 	nfp_ccm_mbox_clean(nn);
+	nfp_net_fs_clean(nn);
 	flush_work(&nn->mbox_amsg.work);
 	nfp_net_reconfig_wait_posted(nn);
 }
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
index 3e63f6d6a563..515472924a5d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
@@ -269,6 +269,7 @@
 #define   NFP_NET_CFG_CTRL_IPSEC	  (0x1 << 1) /* IPsec offload */
 #define   NFP_NET_CFG_CTRL_MCAST_FILTER	  (0x1 << 2) /* Multicast Filter */
 #define   NFP_NET_CFG_CTRL_FREELIST_EN	  (0x1 << 6) /* Freelist enable flag bit */
+#define   NFP_NET_CFG_CTRL_FLOW_STEER	  (0x1 << 8) /* Flow steering */
 
 #define NFP_NET_CFG_CAP_WORD1		0x00a4
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index e75cbb287625..d7896391b8ba 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1317,6 +1317,116 @@ static int nfp_net_get_rss_hash_opts(struct nfp_net *nn,
 	return 0;
 }
 
+#define NFP_FS_MAX_ENTRY	1024
+
+static int nfp_net_fs_to_ethtool(struct nfp_fs_entry *entry, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
+	unsigned int i;
+
+	switch (entry->flow_type & ~FLOW_RSS) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+		fs->h_u.tcp_ip4_spec.ip4src = entry->key.sip4;
+		fs->h_u.tcp_ip4_spec.ip4dst = entry->key.dip4;
+		fs->h_u.tcp_ip4_spec.psrc   = entry->key.sport;
+		fs->h_u.tcp_ip4_spec.pdst   = entry->key.dport;
+		fs->m_u.tcp_ip4_spec.ip4src = entry->msk.sip4;
+		fs->m_u.tcp_ip4_spec.ip4dst = entry->msk.dip4;
+		fs->m_u.tcp_ip4_spec.psrc   = entry->msk.sport;
+		fs->m_u.tcp_ip4_spec.pdst   = entry->msk.dport;
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		for (i = 0; i < 4; i++) {
+			fs->h_u.tcp_ip6_spec.ip6src[i] = entry->key.sip6[i];
+			fs->h_u.tcp_ip6_spec.ip6dst[i] = entry->key.dip6[i];
+			fs->m_u.tcp_ip6_spec.ip6src[i] = entry->msk.sip6[i];
+			fs->m_u.tcp_ip6_spec.ip6dst[i] = entry->msk.dip6[i];
+		}
+		fs->h_u.tcp_ip6_spec.psrc = entry->key.sport;
+		fs->h_u.tcp_ip6_spec.pdst = entry->key.dport;
+		fs->m_u.tcp_ip6_spec.psrc = entry->msk.sport;
+		fs->m_u.tcp_ip6_spec.pdst = entry->msk.dport;
+		break;
+	case IPV4_USER_FLOW:
+		fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+		fs->h_u.usr_ip4_spec.ip4src = entry->key.sip4;
+		fs->h_u.usr_ip4_spec.ip4dst = entry->key.dip4;
+		fs->h_u.usr_ip4_spec.proto  = entry->key.l4_proto;
+		fs->m_u.usr_ip4_spec.ip4src = entry->msk.sip4;
+		fs->m_u.usr_ip4_spec.ip4dst = entry->msk.dip4;
+		fs->m_u.usr_ip4_spec.proto  = entry->msk.l4_proto;
+		break;
+	case IPV6_USER_FLOW:
+		for (i = 0; i < 4; i++) {
+			fs->h_u.usr_ip6_spec.ip6src[i] = entry->key.sip6[i];
+			fs->h_u.usr_ip6_spec.ip6dst[i] = entry->key.dip6[i];
+			fs->m_u.usr_ip6_spec.ip6src[i] = entry->msk.sip6[i];
+			fs->m_u.usr_ip6_spec.ip6dst[i] = entry->msk.dip6[i];
+		}
+		fs->h_u.usr_ip6_spec.l4_proto = entry->key.l4_proto;
+		fs->m_u.usr_ip6_spec.l4_proto = entry->msk.l4_proto;
+		break;
+	case ETHER_FLOW:
+		fs->h_u.ether_spec.h_proto = entry->key.l3_proto;
+		fs->m_u.ether_spec.h_proto = entry->msk.l3_proto;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fs->flow_type   = entry->flow_type;
+	fs->ring_cookie = entry->action;
+
+	if (fs->flow_type & FLOW_RSS) {
+		/* Only rss_context of 0 is supported. */
+		cmd->rss_context = 0;
+		/* RSS is used, mask the ring. */
+		fs->ring_cookie |= ETHTOOL_RX_FLOW_SPEC_RING;
+	}
+
+	return 0;
+}
+
+static int nfp_net_get_fs_rule(struct nfp_net *nn, struct ethtool_rxnfc *cmd)
+{
+	struct nfp_fs_entry *entry;
+
+	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_FLOW_STEER))
+		return -EOPNOTSUPP;
+
+	if (cmd->fs.location >= NFP_FS_MAX_ENTRY)
+		return -EINVAL;
+
+	list_for_each_entry(entry, &nn->fs.list, node) {
+		if (entry->loc == cmd->fs.location)
+			return nfp_net_fs_to_ethtool(entry, cmd);
+
+		if (entry->loc > cmd->fs.location)
+			/* no need to continue */
+			return -ENOENT;
+	}
+
+	return -ENOENT;
+}
+
+static int nfp_net_get_fs_loc(struct nfp_net *nn, u32 *rule_locs)
+{
+	struct nfp_fs_entry *entry;
+	u32 count = 0;
+
+	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_FLOW_STEER))
+		return -EOPNOTSUPP;
+
+	list_for_each_entry(entry, &nn->fs.list, node)
+		rule_locs[count++] = entry->loc;
+
+	return 0;
+}
+
 static int nfp_net_get_rxnfc(struct net_device *netdev,
 			     struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
@@ -1326,6 +1436,14 @@ static int nfp_net_get_rxnfc(struct net_device *netdev,
 	case ETHTOOL_GRXRINGS:
 		cmd->data = nn->dp.num_rx_rings;
 		return 0;
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = nn->fs.count;
+		return 0;
+	case ETHTOOL_GRXCLSRULE:
+		return nfp_net_get_fs_rule(nn, cmd);
+	case ETHTOOL_GRXCLSRLALL:
+		cmd->data = NFP_FS_MAX_ENTRY;
+		return nfp_net_get_fs_loc(nn, rule_locs);
 	case ETHTOOL_GRXFH:
 		return nfp_net_get_rss_hash_opts(nn, cmd);
 	default:
@@ -1385,6 +1503,253 @@ static int nfp_net_set_rss_hash_opt(struct nfp_net *nn,
 	return 0;
 }
 
+static int nfp_net_fs_from_ethtool(struct nfp_fs_entry *entry, struct ethtool_rx_flow_spec *fs)
+{
+	unsigned int i;
+
+	/* FLOW_EXT/FLOW_MAC_EXT is not supported. */
+	switch (fs->flow_type & ~FLOW_RSS) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+		entry->msk.sip4  = fs->m_u.tcp_ip4_spec.ip4src;
+		entry->msk.dip4  = fs->m_u.tcp_ip4_spec.ip4dst;
+		entry->msk.sport = fs->m_u.tcp_ip4_spec.psrc;
+		entry->msk.dport = fs->m_u.tcp_ip4_spec.pdst;
+		entry->key.sip4  = fs->h_u.tcp_ip4_spec.ip4src & entry->msk.sip4;
+		entry->key.dip4  = fs->h_u.tcp_ip4_spec.ip4dst & entry->msk.dip4;
+		entry->key.sport = fs->h_u.tcp_ip4_spec.psrc & entry->msk.sport;
+		entry->key.dport = fs->h_u.tcp_ip4_spec.pdst & entry->msk.dport;
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		for (i = 0; i < 4; i++) {
+			entry->msk.sip6[i] = fs->m_u.tcp_ip6_spec.ip6src[i];
+			entry->msk.dip6[i] = fs->m_u.tcp_ip6_spec.ip6dst[i];
+			entry->key.sip6[i] = fs->h_u.tcp_ip6_spec.ip6src[i] & entry->msk.sip6[i];
+			entry->key.dip6[i] = fs->h_u.tcp_ip6_spec.ip6dst[i] & entry->msk.dip6[i];
+		}
+		entry->msk.sport = fs->m_u.tcp_ip6_spec.psrc;
+		entry->msk.dport = fs->m_u.tcp_ip6_spec.pdst;
+		entry->key.sport = fs->h_u.tcp_ip6_spec.psrc & entry->msk.sport;
+		entry->key.dport = fs->h_u.tcp_ip6_spec.pdst & entry->msk.dport;
+		break;
+	case IPV4_USER_FLOW:
+		entry->msk.sip4     = fs->m_u.usr_ip4_spec.ip4src;
+		entry->msk.dip4     = fs->m_u.usr_ip4_spec.ip4dst;
+		entry->msk.l4_proto = fs->m_u.usr_ip4_spec.proto;
+		entry->key.sip4     = fs->h_u.usr_ip4_spec.ip4src & entry->msk.sip4;
+		entry->key.dip4     = fs->h_u.usr_ip4_spec.ip4dst & entry->msk.dip4;
+		entry->key.l4_proto = fs->h_u.usr_ip4_spec.proto & entry->msk.l4_proto;
+		break;
+	case IPV6_USER_FLOW:
+		for (i = 0; i < 4; i++) {
+			entry->msk.sip6[i] = fs->m_u.usr_ip6_spec.ip6src[i];
+			entry->msk.dip6[i] = fs->m_u.usr_ip6_spec.ip6dst[i];
+			entry->key.sip6[i] = fs->h_u.usr_ip6_spec.ip6src[i] & entry->msk.sip6[i];
+			entry->key.dip6[i] = fs->h_u.usr_ip6_spec.ip6dst[i] & entry->msk.dip6[i];
+		}
+		entry->msk.l4_proto = fs->m_u.usr_ip6_spec.l4_proto;
+		entry->key.l4_proto = fs->h_u.usr_ip6_spec.l4_proto & entry->msk.l4_proto;
+		break;
+	case ETHER_FLOW:
+		entry->msk.l3_proto = fs->m_u.ether_spec.h_proto;
+		entry->key.l3_proto = fs->h_u.ether_spec.h_proto & entry->msk.l3_proto;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fs->flow_type & ~FLOW_RSS) {
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+		entry->key.l4_proto = IPPROTO_TCP;
+		entry->msk.l4_proto = 0xff;
+		break;
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
+		entry->key.l4_proto = IPPROTO_UDP;
+		entry->msk.l4_proto = 0xff;
+		break;
+	case SCTP_V4_FLOW:
+	case SCTP_V6_FLOW:
+		entry->key.l4_proto = IPPROTO_SCTP;
+		entry->msk.l4_proto = 0xff;
+		break;
+	}
+
+	entry->flow_type = fs->flow_type;
+	entry->action    = fs->ring_cookie;
+	entry->loc       = fs->location;
+
+	return 0;
+}
+
+static int nfp_net_fs_check_existing(struct nfp_net *nn, struct nfp_fs_entry *new)
+{
+	struct nfp_fs_entry *entry;
+
+	list_for_each_entry(entry, &nn->fs.list, node) {
+		if (new->loc != entry->loc &&
+		    !((new->flow_type ^ entry->flow_type) & ~FLOW_RSS) &&
+		    !memcmp(&new->key, &entry->key, sizeof(new->key)) &&
+		    !memcmp(&new->msk, &entry->msk, sizeof(new->msk)))
+			return entry->loc;
+	}
+
+	/* -1 means no duplicates */
+	return -1;
+}
+
+static int nfp_net_fs_add(struct nfp_net *nn, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
+	struct nfp_fs_entry *new, *entry;
+	bool unsupp_mask;
+	int err, id;
+
+	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_FLOW_STEER))
+		return -EOPNOTSUPP;
+
+	/* Only default RSS context(0) is supported. */
+	if ((fs->flow_type & FLOW_RSS) && cmd->rss_context)
+		return -EOPNOTSUPP;
+
+	if (fs->location >= NFP_FS_MAX_ENTRY)
+		return -EINVAL;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    fs->ring_cookie >= nn->dp.num_rx_rings)
+		return -EINVAL;
+
+	/* FLOW_EXT/FLOW_MAC_EXT is not supported. */
+	switch (fs->flow_type & ~FLOW_RSS) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+		unsupp_mask = !!fs->m_u.tcp_ip4_spec.tos;
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		unsupp_mask = !!fs->m_u.tcp_ip6_spec.tclass;
+		break;
+	case IPV4_USER_FLOW:
+		unsupp_mask = !!fs->m_u.usr_ip4_spec.l4_4_bytes ||
+			      !!fs->m_u.usr_ip4_spec.tos ||
+			      !!fs->m_u.usr_ip4_spec.ip_ver;
+		/* ip_ver must be ETH_RX_NFC_IP4. */
+		unsupp_mask |= fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4;
+		break;
+	case IPV6_USER_FLOW:
+		unsupp_mask = !!fs->m_u.usr_ip6_spec.l4_4_bytes ||
+			      !!fs->m_u.usr_ip6_spec.tclass;
+		break;
+	case ETHER_FLOW:
+		if (fs->h_u.ether_spec.h_proto == htons(ETH_P_IP) ||
+		    fs->h_u.ether_spec.h_proto == htons(ETH_P_IPV6)) {
+			nn_err(nn, "Please use ip4/ip6 flow type instead.\n");
+			return -EOPNOTSUPP;
+		}
+		/* Only unmasked ethtype is supported. */
+		unsupp_mask = !is_zero_ether_addr(fs->m_u.ether_spec.h_dest) ||
+			      !is_zero_ether_addr(fs->m_u.ether_spec.h_source) ||
+			      (fs->m_u.ether_spec.h_proto != htons(0xffff));
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (unsupp_mask)
+		return -EOPNOTSUPP;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	nfp_net_fs_from_ethtool(new, fs);
+
+	id = nfp_net_fs_check_existing(nn, new);
+	if (id >= 0) {
+		nn_err(nn, "Identical rule is existing in %d.\n", id);
+		err = -EINVAL;
+		goto err;
+	}
+
+	/* Insert to list in ascending order of location. */
+	list_for_each_entry(entry, &nn->fs.list, node) {
+		if (entry->loc == fs->location) {
+			err = nfp_net_fs_del_hw(nn, entry);
+			if (err)
+				goto err;
+
+			nn->fs.count--;
+			err = nfp_net_fs_add_hw(nn, new);
+			if (err)
+				goto err;
+
+			nn->fs.count++;
+			list_replace(&entry->node, &new->node);
+			kfree(entry);
+
+			return 0;
+		}
+
+		if (entry->loc > fs->location)
+			break;
+	}
+
+	if (nn->fs.count == NFP_FS_MAX_ENTRY) {
+		err = -ENOSPC;
+		goto err;
+	}
+
+	err = nfp_net_fs_add_hw(nn, new);
+	if (err)
+		goto err;
+
+	list_add_tail(&new->node, &entry->node);
+	nn->fs.count++;
+
+	return 0;
+
+err:
+	kfree(new);
+	return err;
+}
+
+static int nfp_net_fs_del(struct nfp_net *nn, struct ethtool_rxnfc *cmd)
+{
+	struct nfp_fs_entry *entry;
+	int err;
+
+	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_FLOW_STEER))
+		return -EOPNOTSUPP;
+
+	if (!nn->fs.count || cmd->fs.location >= NFP_FS_MAX_ENTRY)
+		return -EINVAL;
+
+	list_for_each_entry(entry, &nn->fs.list, node) {
+		if (entry->loc == cmd->fs.location) {
+			err = nfp_net_fs_del_hw(nn, entry);
+			if (err)
+				return err;
+
+			list_del(&entry->node);
+			kfree(entry);
+			nn->fs.count--;
+
+			return 0;
+		} else if (entry->loc > cmd->fs.location) {
+			/* no need to continue */
+			break;
+		}
+	}
+
+	return -ENOENT;
+}
+
 static int nfp_net_set_rxnfc(struct net_device *netdev,
 			     struct ethtool_rxnfc *cmd)
 {
@@ -1393,6 +1758,10 @@ static int nfp_net_set_rxnfc(struct net_device *netdev,
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXFH:
 		return nfp_net_set_rss_hash_opt(nn, cmd);
+	case ETHTOOL_SRXCLSRLINS:
+		return nfp_net_fs_add(nn, cmd);
+	case ETHTOOL_SRXCLSRLDEL:
+		return nfp_net_fs_del(nn, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.34.1


