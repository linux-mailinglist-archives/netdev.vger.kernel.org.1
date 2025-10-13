Return-Path: <netdev+bounces-228835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF5BD529F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 626655405BC
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC9131A805;
	Mon, 13 Oct 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7cwT0Hz"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA03128AB
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369331; cv=fail; b=bMJM9nlGQLx22bu8BN66KskjL3T/BuuHoazbiLvSFw+HLLhiwy7IyqU/xzvnGPJHRvAmTeJU7p30zYf7TkGqFqnYBhr6b20IZsPCPJxm7OgBpHPDTLVEILC3Ftxbm9jLED7AVtktJC4DanEStY/HSQNzGUwwHCsKrW/Vx9pR7IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369331; c=relaxed/simple;
	bh=xA1WWvqGpsyPC68U2FFk/MMojWg4wn4uGRi+B5JkvIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVjuM+eIjke9rohBsnPty44XH/h7hbNYYJEiC5fiM+grDiQhu/qkRc69/xlZZW4Z30CsVolFT+ZEsD+T9QEHuMW61b9LjhCyT3U5GQh34JoO4hrlQ/AEh9m0Ykfoo0nyLLxMJwA+MHOrx6ztpHDKNoCSIwyzo9nBhCSaUCPVecE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7cwT0Hz; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8R/QrlqChww/K/DqablW4tGxg4R3WsyV+tueAIdDZ/t1C2G2M9bcI565BJq5PdtL5WnB4mTDxUNT97W4Aggu6QRQMGn23t7+m4ok4j3uX/aCmVWbeY3Zbm/e99vtuIZpDECj0SJCWyoVWDQ3jOqbcjLOuK7GTplu1fxOgM7Z8bHLYpjX9hSBv/H7ZENRUANaeO7aD2AqNV7xxu/KJ7rAshsZyCuLG520V5q+3IYB4BIk9QZep3PQi3bnZNITP3eUAx/8bZ8E+eSsJ2pz8lZheRfgbXUAgtNLJwXcdTWIbVlGcloE0JjH5hF3Pjbar07v9QNlHJieJqR6F8x6KF0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zu0MGXbGDp36+OxeQPsmfhtxqpbirutruqg/W6avWc=;
 b=YgxgxjOqFBo+IL7H+7SlFm3rEErr7XmYU8SF6EKRNos/M37cp0VQbvDmXnP9r+guk214LkdviQhDNHlNtS7D+WYu0Od+nuiAB8yqGkSeRPg22VlJoU5H077KtlxxX3gvN1o70E7qpCsfTJg2iqvIKNoqxNuEdpe1gbkexWBLB6DQcersXIuQJIF64gTcwlGPg8JxrbK7m9BTm0oy1DduJNkiUIbPJjMmoGeHMrcrQcQo5WSXLW1Nebg7podC7oLRC8DfeDu/6VnrR90B5rL63X27Ch0/nZYRZJXnyIcbtThlfiqyTrzY8qibbXhzeAy/1Zre40jIEd9mhGJyKdmsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zu0MGXbGDp36+OxeQPsmfhtxqpbirutruqg/W6avWc=;
 b=m7cwT0HzGfaOmlrY/S6xagUJTAIUEPuXqtHDguq9HJbl9REWwGLOP0xP/7C8jMY5yyNv75svVBWd+4TFCq++vEW9lZhp3ahS3hGscROErCPDYBCAh3l6+e1FzJVzomrOFCWsPNOocokm7g6i75vy9pVpigpS8tZtT9UunwjqKYnV3NNOQBZxgjt/0yMD0SnzWKH04+3e1r5QaJhVwkP2fqZu7CFVV0l5lL5aAICsCvkwb2KiWnywT7+ShpQ7hm8LLOImBDLy95Z7/Ibm0TljbgN/MmmL0lDEs1hW/KT0CaLMmDcEOMOt08Oy4WAQ4auW2Q0aJBWpbtKPBQJDvITQrQ==
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:28:39 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:334:cafe::1e) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.8 via Frontend Transport; Mon,
 13 Oct 2025 15:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:26 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:24 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 12/12] virtio_net: Add get ethtool flow rules ops
Date: Mon, 13 Oct 2025 10:27:42 -0500
Message-ID: <20251013152742.619423-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd5e3d-5217-45aa-c200-08de0a6d2e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XJTzDZu/CvzxMCaoRNuIuWx1+j/EDwDaxTRyy5NBzMFpEUof5ksBdnFscJT2?=
 =?us-ascii?Q?dffh62n/uLcAGdUqnOqnZI/XsvUtZd9d5VAmGt2LTpLibp54MFulv70sPcHp?=
 =?us-ascii?Q?QJCVkQGSfy09vpWNk2XUhRwrQC5OI0uwGqi2JDspTkVOGEYpQ0eWYHbJImBk?=
 =?us-ascii?Q?ftWdVehkIYQtb9ZaXLXkmtUiCaNSfpdzZdByg49PcmgYtC8jFcIC6tcNJKvZ?=
 =?us-ascii?Q?8bUhVcYMZxjZRFA0/Lf6SWiIoQlfeYMdrJyQN5nVU7e+D4F84B2nhVvwZFFQ?=
 =?us-ascii?Q?wUC//2W8fMClBkwUrnAKNt0F8fySaHqvEKEvCceZIIFL4XTitmqrIo4fYhCg?=
 =?us-ascii?Q?IuSuIv8QR4UDdS7mZPQUvc94QdGp9EqM7MyQn2NsZQG9FasCco7NCa6bRFmh?=
 =?us-ascii?Q?+4wbWxb0B+xuIUPrwloOoyhFXXHYIg038gR0tD0eFq2NN7MKHUAFPDBVRMsT?=
 =?us-ascii?Q?m0ChHtZIujS+Jg7vbNGNTwShsNB2o3zJ3AdqJIaoIIdNrTHOk5vLKY5NqQ9u?=
 =?us-ascii?Q?J9BbXDyvNewxdy5+zxfV5IVjGsvCOmVJXFoqol43+gTyDlXBZpKqa0RIczuu?=
 =?us-ascii?Q?yQiA0XnYtjt4+d5ucQgjXfVK0+bNUUgpebcaKtYXxgZ+yTTKSllZmhGJL/LY?=
 =?us-ascii?Q?YvDUTE2B+b+rDnk/QMypRUlWShUHrtziT0r1du2DIz8mUYSNngJjpukzDBai?=
 =?us-ascii?Q?enr6P1nzWT8sqm/by9vsIXoyf2srSQT908jXhX0MipPOR6lFJgVprwpLS0BM?=
 =?us-ascii?Q?Aq9hmAbGN6kkkQucXnmmtqzoJqy7hnD8rIGx194tZQYyG46FDEIIzD+TIma+?=
 =?us-ascii?Q?jxfFZM4nN8Xfam/QAiQhoijc9HQpfFkw1wBX0+fqjxM31T8kussWJ0db9CNg?=
 =?us-ascii?Q?W40DyOfQTGHk+k57DFLGuQYsTCBLLVwd+9sae31thvkMQw0IzO3d1GxCFHkx?=
 =?us-ascii?Q?ScX7InbKp5nI+A5xh9J1GOG3fTb3J3x7jv92K9aMxGZ36duonxGPQqvXjTBx?=
 =?us-ascii?Q?zcU4sRULz25htjg8KOnnePaMImaGuPMiobiyOyBkF8x0ADQE6EWDJ9sKg4ti?=
 =?us-ascii?Q?fw3+9M6dh28cAhF6N0Wdl+OfnAfOdxCSjjZwIKnLmEHEcdUIi1ynykbRBFU/?=
 =?us-ascii?Q?sfaCI0NbERfkJbcdEi420cQRQcy642qhN006EMUF45YWK5As9Wv5COJ3iDDP?=
 =?us-ascii?Q?G9EXbuUzOWpZcgYuU2mQOTv3hhpwbYVGH/TPZCSrH9vCgcPs49V4rSJeGSeO?=
 =?us-ascii?Q?u9hwmplhX6BqWyu5dEKB0DPrz/OhU2CQfSrDPYEm7OKJfCNHdTbuoODWdBYA?=
 =?us-ascii?Q?HfZmKWLAvFS8jpgwW/geE7bTI+iQKnbHnNwbdhXRTijz2ZjoFzOAjjaDq0+I?=
 =?us-ascii?Q?o99qHmGVhtSHd9dT1PfOgyXrhKSIVJI/f7I8JGUTvl2fXy5f1ry2XTMwzhcR?=
 =?us-ascii?Q?zUorm9hHghq5YggFdDnGbsNxik52rx0lRymkCAUpcnGBMgMLmjOP1ivVD2ZT?=
 =?us-ascii?Q?QrvPzumffmQWYO+uQ/aOD5V2cvxUxEvjZkxPzaP8k1wyNt+0dqNraK6af7MU?=
 =?us-ascii?Q?axpn8bJZeQFZFgWtyp8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:37.9206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd5e3d-5217-45aa-c200-08de0a6d2e68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651

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
---
v4: Answered questions about rules_limit overflow with no changes.
---
 drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2878a1b9bc62..9dfa534d2130 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -307,6 +307,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
@@ -5645,6 +5652,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5686,6 +5715,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7605,6 +7635,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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


