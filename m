Return-Path: <netdev+bounces-238116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11885C5445C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3434B3B8350
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C28352FB1;
	Wed, 12 Nov 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J7OaNfbS"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89D26C3A2
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976137; cv=fail; b=p17w2uWR6du1XnvAzoixeGT5J4P0aVslE5MlwTy0gQj1djuCL+XqiGl+wABuN2u7sWeOhCOIi1sHEm+qzqwHZrCjdZxEZj9/B0J3wi+u48zLdeUamyThOMIOrL8vsZit9D+HDLF1GntjTgHnq1mPHdNFSVL5Sj3K5kNl855AuiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976137; c=relaxed/simple;
	bh=12AYTfHK/j6ifFWKLD3fEziZk9xMFDvV20xvODBnvuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sv6myR5m80Wl+LBlWCe80TSVk2rmzeUeVS3U4AFrZ0BCY4td+4v8+/um0Fyhmh6ymoq1aVLRH/JrAcwIJzxxeyuV2aWz+Vw6H6yc+onSjxiPYus5SETVCUBMcYlcMWrWTfm7hpOvlqc+1ev04ELqeIHYu3Ll/bQ9aB5JeFAkhrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J7OaNfbS; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPuUheYvW/6smS3cXWNqpP4mHargBO12jIqt/V4y7jsX8/NVfbIyGiE4Oz8In/HftiC/RvlzpaJCgITCUp03/UoFh9MSnUJihwe3ELRKfu4Xi6WOU8bsp4w3bi8Jtw6sSt7szzjYYgQsWxZ2ubBfNMWSFIJlcdovtzdsYSYSpIBt+jyacBFUnTyLjY1x0F1e09JHBjteUAboklYBQvbYL2VSEzmfq0akyKcdzE+b51rrAKlK7u0ld3Pe9SSHwaXy0iPcJ8YezEUAbZa07i6wDjBkp6r3OqpaZzJ56McXKSUziwg/X9ACtmSPhWay+pNSxa8GUsFD/OxX2Jb6jlC1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEQFmFIR6Ykn1VUe6TcEPYpF1bq8a43nMKt/EZpFxyY=;
 b=lyaWY4ZAT7GD0jzx5ubbHgqC7KjmJUpjthZw1hLe4foTHyYMvvQzpt7Mv/1a5htJaQfVJzQLHXEs7pKEGBpNxKr3d5BbX54eyhDfqknxGDjpWwnyvIvydxSuspj7WmsGSM0tO7NKDnsykPjX4AXBbHlUSXXEVxsaVCelhNJ89iriFeeZ0JOkZZ7QvYr2hLwkpUQ9ABvYHVt6yW98dd8UYEw1vujPWygBB14gZSWs2XG9Z250QXKejxAMcX0pul4XU+qBa2+5H12Xh1NfJAm+Lp1M46uyGTHMaLZiMAODkaZIBwiOPucprAhAZPWAl4hnpA7JsjODGom9DuaV+/lrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEQFmFIR6Ykn1VUe6TcEPYpF1bq8a43nMKt/EZpFxyY=;
 b=J7OaNfbStaR2fcrwJ3gPCpXyIisRyBphvPX1CQpSvW2DX6jxFtobCbcbEb5qEoIqTPunu4uGSfQ4qP0YQ7id44DnW033XmOq9b0aE5Sga+AYllIwOZV4RQUqHn1Fu+DwyADDYRQnZQUUDCMmXoc3aQf4puzXlnE6R9YD6csErqYN01w8HRgVAwrA5A9ZtQvgyFSwOQdQjA09SfEB2TrBUFN7vMvM8nBq+1J/Tw9AaEJlP7tv3mr68BHSHJh3OyE4dwIhAQ/o7ijPJaIwWWrAyenP+ujVRSOlqEmETRG8qfsduCROC1iyvB1U17xQXNbNG/2Q+8h2VhSzq4ZDU5+dvg==
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 19:35:31 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::30) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:35:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:35:10 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:35:09 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 12 Nov 2025 13:34:35 -0600
Message-ID: <20251112193435.2096-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: c1766f90-a508-44ea-e6c5-08de2222a437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?baupViH1Nak+U3Ve1SOZ7JcCb//0jTG9A2RqBOY9fcERLz3oBZZDIrrkPjT5?=
 =?us-ascii?Q?dIZrd4SnK9GcYQSAnDxpYR97p/XhzRQifVBe2CeIII6cuBQZ/EUbz7AU3ILe?=
 =?us-ascii?Q?IXdawx7OsxiqKpRTYKnZhzV4a3mRZCxmLGhbaDMQbmG8UIE73FbK1eAgvBUD?=
 =?us-ascii?Q?TksR4fyIIUPoygOdNvDE78Dq9W0Cn3YYjKj++OrAu8jWfKJy/t0CP0PC/Rfk?=
 =?us-ascii?Q?FhkcNZxib/nTflJv/H5VSt78zi+slNb9qUqOclCsx2frBtM9sNuI4P0Tatq/?=
 =?us-ascii?Q?9+bVVfGTqe4vPGKqaLY2LqvCCzvcqBX5B4hIzyxWD4vw/WHleEj8PYCh834F?=
 =?us-ascii?Q?MiFxSE9s+1PHzVy4IQ0UpJlI5m3Vg6CS+Iy8FNr/XMPryr1y+TyEsjIyCNWy?=
 =?us-ascii?Q?3lA7EDwb3Sp1CgfZ5ee760TSe1q5xNFIU/KEvL81MM+UfJBQZdx5Ok9RHO3j?=
 =?us-ascii?Q?tfKf5MvMqypFTdz+L6RsAWP1QReqzkjuWl7hO7oU43oirsH41O9Ue+VverAV?=
 =?us-ascii?Q?ma73sTPcRxAmfopwXjgoBRDjOI4fNQ8U6jhiCP2ei5E9wrHskfLyRchgPRgz?=
 =?us-ascii?Q?MgN1Jx41RFrHUmWl1eqlnAyXOHExjrc3LGBG8hPdfUAFB/X8q3Rh+GOpgqP0?=
 =?us-ascii?Q?XHdxoC9plUw4dlvp09V2kdCqJd7jzfeP515Jcfu8A4jfFH0z6oJy9hUsTrRb?=
 =?us-ascii?Q?tN0Y+xQP80HgRkJOgZQuQvHnJDCJaECJvtiRqU2uCh62ZMRuWFUSKG3OQpUT?=
 =?us-ascii?Q?MS90BcLvthdI8ltoFbVSXAaJrD+ILXBz0idbb201d3VhSeH8P5VqV66pi5Yy?=
 =?us-ascii?Q?finaknf994fGihlrl7kbIV42TK0DRR28tcLJOawEB9OurD6OMGfFR7d5ahmK?=
 =?us-ascii?Q?FDFSiH5YniWoorsGncs4ykjpS5aFIV7lDlEdKzwyv07FnnvVSn8+nWIpZVqU?=
 =?us-ascii?Q?qPJUtTi27hf8cw/obhvYUDPWEu4/gX2MBmbATb1bixBGfnczIpJnymJtA/Gw?=
 =?us-ascii?Q?kyJBKlKvRvecC0ElRNK3w3EoaD8FaQxTmwoTbIsFRZqYQSnYJ6/YvpBG0i01?=
 =?us-ascii?Q?3UDmXAko1QAApadYaOmOZMpaWaI3nO6iyC52GkhDWKyR+cpJ0lUGuhle5dOP?=
 =?us-ascii?Q?M2lkyFLToKBXbcGAYl8xVkicTCAHfR0UM+S56P3So1ARchCMmPx3nf9P9BkH?=
 =?us-ascii?Q?IGpObHqVUIGLe9wQFOpvd2X8iByoZ95F4nRVmTwP+dU+pebX8Czxctx102AG?=
 =?us-ascii?Q?b2IsoN/03/bhTGAxWvMJ2GyOWWgwCBNQwxvZwr1T0iBvPpv0AwqfAR7eMD//?=
 =?us-ascii?Q?sTn+uaK6/H621+ZfwTucwv8ebKNmSYKtj56qZhfWy6pPfQZQdwJ+lD6AG8uH?=
 =?us-ascii?Q?ioCAkP9q2CG0OAZDwn9rAwtb6jw7JUuvmHbOe5H0J9/jMkD4i8d+leCVJ1K4?=
 =?us-ascii?Q?U/6Dd6S7Rjgje4uJ8HkDLIxTVVjE1N4vvXRurpq/QSMM8qaGUTy5vWGKMWNB?=
 =?us-ascii?Q?ke4amY9F70tepE1qAsgP5Uaj6Hl0dQ5BrMtvlHHV0icXyvzsMJEOny01QgHN?=
 =?us-ascii?Q?iPlT8HtpbcbPiqFf6O0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:31.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1766f90-a508-44ea-e6c5-08de2222a437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.
---
 drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 852ccff52a72..3955962bd741 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -306,6 +306,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5659,6 +5666,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc = 0;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5700,6 +5729,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7619,6 +7649,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		rule_locs[idx++] = i;
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


