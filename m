Return-Path: <netdev+bounces-236077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A0C383C5
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129493B8B7B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136D2F49E3;
	Wed,  5 Nov 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uXPfNY3j"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539202F3C09
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382715; cv=fail; b=pAHnhmQ2a5h+AVGaiOlw5Sj+AqvC59LWaocTnmPAsa/o5YH2HKU3qEsIuanUZv5srH1eDg4GsSONr8WgNiqGV1NSLlpHRCdNWLQOFxmaZ0gYy+qHcWPdrUlnDmZ6c4dd4Bc11SvViqTuYX4ckqjno1x+PuIntfljeZILpTT+eBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382715; c=relaxed/simple;
	bh=cm9N+BeCM+999cYBSH9Ix65wP2FFQr6gq6Wtv1TfExA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9k3ZfQTrcOKCwxxDpT1+xfPbO2huuLEG7dZOXQORrDoJEBRGEMuF/d/SsRl35oOtpeuzITQ4CgPiwFE582nUJmzlpiDAVTwxmP0r0BnrRcNdxjUVBw9PDY2SMbpyJtDxfQbmJQ2NCTpfA4ECsm3JWovlevVYvv78A8AE6mXbbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uXPfNY3j; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIRZspzp/y+uPKD5aV7TOwFyLA0Q126brd5P0KxNh0UVsni6h1zn5E/OMNvqkHgc3usgyI0xPy6sEpg0rYJgTFrrV8HFNOntZghrV6z51/ZIkBqMJjHGtRkn+f4t1iRWY5cTVBNuOxmowfNr7skB6EGF9Tfhj3kH52ZPNxZ+Ep5w/3E9meMUN4P/+w91LfqPewZLuWxNKtSi/llwnlv8KqWEbftDn7jsC0Vp0sXkM6P0ot7SRNeHKKA8vzblf4Ft8j29RM8WRSxnT9LTjIoAKLMvltoKV43ij05kCUvWvcSUsNmyBdzKvyj6t15c4PeAHT/UBCdznKGGVIHleWDTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUEAaLAzy05TpnQAygYKxqvoTDk0dD61mB+Cx4cwWfk=;
 b=SHBVr/jCHPlBCxRts1XgxU8i4grn+fOhXUTuCBlvKxlYyhoeE0gKmQ0mBv9J8GwNfStxzFZfPcmPeG6Fbp5y/dk6xqzsn8g15g09DF1doBLZKGVBUOGE4vSBy/GRrsxsAyGjML8qvgEJYOTyFZtDs9FzMk4mXDacMGqW++0OEtMxSK6g3jGOoRNEn6QqcjWy+IlH7enCSyfmJIOzmJV+gqFLLLYlYFtOOup8iwRCRsZiMXL4i2ETYZdf7uKxZsNyCGXVIkkOhCuabw9mnJl7+mFxz6zasb69duyWmXSBBPJCQB/ysoSu5VrjiV5WefFyJSnFmN6X9Bu/FMP5x1hUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUEAaLAzy05TpnQAygYKxqvoTDk0dD61mB+Cx4cwWfk=;
 b=uXPfNY3jzfNixzUEh+3E+EBUEt26s0hWluAOKcAQO34O2S3ZVR1QlZMa355S7cb0155ZrGgNxjgA7qxry1xIuZj9YDzbd8pSQWYTCrKJeQJIm5f+HrLMTD7CjJmStU7MQXSGYnfViuI6VGa+TP1mD0D7cHA1LAYRuJO7diX19hSSxqTMGdddg/iDFZoudl8mCVGsgshl+4X8nrFH3cJCstfuIVr1rd7saXPosplxVGqQTLejm1XgrlGWKlCGaTr1QJ6vLtrpY20YeXSaRQAg50voHTwD2geO8Iik7lpxaP1GfRkXMStVlkjQQKBpajQccP1GuwrklgUZlXHtL1//vA==
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 22:45:08 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::cb) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 22:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:58 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:57 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 5 Nov 2025 16:43:56 -0600
Message-ID: <20251105224356.4234-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4c67be-5d13-4426-070f-08de1cbcf86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LhW6hSagHoLt7sq0i6hTQE9f4+unZLC1s9oBy9QPtlhGfg1hYe6lJEVpZFWN?=
 =?us-ascii?Q?Eba+87Sw2IkmkT4jGgrByAFTxS0MJP89LgQIhesxEe8LZRGkTzzwnUQ+5aQZ?=
 =?us-ascii?Q?KaiCD7B4Fh/IkrMsOg1Ya7FJrpwcAuVhZKEGfaVm6ODn+ReFPie0rm7/sohx?=
 =?us-ascii?Q?NzlwEKoLgdgT2fGI1IBSlBDBtwuJn2F8hO7vyF2cJD6IRQ/guJCeWnsCBNXW?=
 =?us-ascii?Q?RE1WlbnCBBx5sRXoFgP+mjqL4xNIxFqRppc9qX1HvMqC4bjOASyDCGiSAsYX?=
 =?us-ascii?Q?vV4Kek3If7/lT5wdxdvk39a0VFQuSB1yn9NPjbhV3iCdq/i/64MZLd53wu9W?=
 =?us-ascii?Q?J5yCOiHD2fir6xU4z+cDbtv0TsM8HsE7KTEYNHK75pwEuapPMlBHR2HdofGo?=
 =?us-ascii?Q?TZ4cOGoDHlzhiBaMEyhK6Iz0g4SFXoaQHpcXWj+ttZ+X39/93alcT5bAC/YV?=
 =?us-ascii?Q?9KRui3UoZ+4tWU/CnMred87YRmBjRaNDdGUlCXSmsgiNk1D8V7ls//zQqOtt?=
 =?us-ascii?Q?BXaazuqdvLHml+8SaapnJ+8b5PFbHzatbPJWFwADIKBwb8XJivJHHqeOlkn7?=
 =?us-ascii?Q?FHP70XdvwfMJ/ydjE3ACq1cZahPZ+AfyXLsqZBot2Z8jBsLbD2mBeDA8iEAd?=
 =?us-ascii?Q?NbmzkW6GOGwWtOFEvhgu84Q3hVcVf0bHaNiHKSJdm9pmYhGnK2H3olaiRwo1?=
 =?us-ascii?Q?q06HcNbyibwPwO5WdDIeTH5bpQ9YOsnozwipAKN8A2Tx0bZs3nYzkrwgMiyA?=
 =?us-ascii?Q?MQbLDvNxAeuKRlnWADE8aBerUrz3b1sxD2zYbZJ+0rTUxX5g3bKS5WFfpKMC?=
 =?us-ascii?Q?1wO6lxGhALt+u0lqzufNMhML0RN//xFuV5erEL2N4k4aBBDS955his1+TC1L?=
 =?us-ascii?Q?KHaD4rbGXi4uz+bns8TryOyFnYZ2K7TPhdeRr0+OwioWdWekga2afvWrcVq8?=
 =?us-ascii?Q?NxuUT7WU7CdM91NEtHS1JUssP2+21qoPeHjTPIEIuR9QQljXdAxem0trnxXw?=
 =?us-ascii?Q?alKw0fPTiFU9nIO2h7ZTnLe714O8GaZNiM1pAA1oMwKk4ibdmDuN6qiL4aLz?=
 =?us-ascii?Q?9P4xCncaAvoE0+GnsetdcdIPiayQ0CibEp/VSYDX6hGxrAvRGtAHY3R/4xFj?=
 =?us-ascii?Q?xzdgjjdX9GbvBjO8ckq3sI7GjwFRf+vqZWkerYeggYmQ9JavR+UVaU+azQee?=
 =?us-ascii?Q?gYNV4LC/eXomUPLfrIodIlWacShhwT5x3tEa/E1w3FYJkZdCk1L2aispW11p?=
 =?us-ascii?Q?V2XFPs13EX014A4ZLW2NBsReRxDwjRENlejs2FHg1GfnJtlMA6RRQ1a+leeM?=
 =?us-ascii?Q?vgjMudoyHYm5Te1fpIayV0qby029j+7E86hVVxQ/tdMUNgdE6k/p5gUDJNjc?=
 =?us-ascii?Q?3qVlJ7bNiXXj8n0u5+T/pdICQr8fb5U2i22Fak/i/4OThTKCMKv1ltTMUSv1?=
 =?us-ascii?Q?tT71uGRvvzOxNSKyvazocucP/spRMCimW8+Ok89Xkn02CN7bk+ndbV/VMguL?=
 =?us-ascii?Q?9KDKctQgGP603W84YpbLjg0x2Yy7VaYbafkddAWlrJPw7C/xM+Gd7HMhLJly?=
 =?us-ascii?Q?NMyvgz9Hbw++Wm6FOP0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:07.8436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4c67be-5d13-4426-070f-08de1cbcf86e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

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
index c876a18a97e3..89af5306772c 100644
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
@@ -5649,6 +5656,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5690,6 +5719,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7609,6 +7639,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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


