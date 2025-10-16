Return-Path: <netdev+bounces-229872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB96BE17B3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DFBD4F41CB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A062264C9;
	Thu, 16 Oct 2025 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOUmhLf7"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77115227EA4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590903; cv=fail; b=Zqn00Ufw+uaCbJMSDfPRsWkBaXGoYiIYljVCXVpw39ri9bQRRbcwddZsgCP5hqH8g5oOyBO11iFybv8ggZYq278JoBurE1t15K1l0lYLroMFtJL+qlBD4qSNm5HOlJcyc5PHbOC0LvRmEJIDta/ROq4zdvJxkRNTfq6OWOuGkjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590903; c=relaxed/simple;
	bh=3IHtl52oOpsX1EPxKQ6Hxw9lz93kXwwV2POTUSw8yGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgMHduEH0TRI//DbqeQzZHQR1Ce221+XJ7Bmgnxvi7TtRb3P1Oq3S83B00em/1hDyciJXJZpI1CHS5/G0xGvUzhz0Q7lXN6tC+bqrzpooRCiTaLdSGC5DHO4UpSeA07NSvHlkkuMU1RytWtdEtnZIjWGEdy8OSxeo5LqoFNkYGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOUmhLf7; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDYRG42SfjJwS0YUJrf6MFyFJa+WS4IgLlkcwiRz8DO8vM2mUlkH4mYtAdWWIF5ZnaVN7hVvfYmIpl9LZw8R1rzVQ3xBEyGlP3P+jRqLmh3bEXf8fFvS3Gh0xCxlosS280RK3KgZCLEzttRoOTeX/lrSPe9g2lhiOi1MmnsjoUAAMo/Lh85c7W4aJP6+owfy29/S0Ur1CI3t30YK8auwrW0Re4nX0/b1sHaUWUrUaB1HD4Ic3u74DmAraDzPaaeJrft/ZPoERqRujXIepVT1If3jxulqnlna+doO5yH0qnFCsL41+LKRTz0Og1hl4Bu6IZzcC5kRnoWzqFPwvJTERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7UCLr8PQIOGUjehiMk/AHZbo4srtI5jTkgpBuCvnfw=;
 b=FaRRCQyIb4VS1oezczO/gQfdlOzPRf7SLv9fMEwc9FI7ImdwdKQjXBnOwdNv5DjpuSUXmdqCEtFGBKq9ah2A+5gb7EjMrqRM3SNCjaNiXod0jTcF6g0x7pUvCsLINjt5QyP7HHoutXuS29FT2HSeSKpOD1hbc6ByFLNQklR9zxs+xif3OOZ9VRl0Y+sy6QRd2Naywqjjcm4Udrxu2nfcbQbFLy3cfWIhFH7ZxZHTfwq/3bE01CxvBhXktDLiwmSb5X135Gn4gWP3WGhjWkUxjRAN+wLG3DmOynHP0HIeY+5XtVhDUoeQbXPLr84R8WDG7WxFslx8NK34sNYVxuzImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7UCLr8PQIOGUjehiMk/AHZbo4srtI5jTkgpBuCvnfw=;
 b=YOUmhLf7ZUnCTZBpQ63I8nKv8wd0oUcF/kgFN4jCknm1Q4RCtdSziQ4qH69IKfw43ChSrtKU3oMpa1WFmaQzrQvhabp3QCo8vLwH8pE/IEi8JXGulkw/C4CcwHRKFWoDXwd11xAHOHs//QBX3Gd9Q3fkpnFz3lT+sDX3m2jqY0CH58XDw8q10M+bRVnZsNo+v8wij8uAgImmdEVLBRhr5wcSpZcmz7rSjb0Q9W+B0ZvPk28/+IBKUXo371sm2vDivhp/bzWe0WSE6TRgdmmShjR2fA6/R4r7icVQla/xwQeAVPPEf/j3oIAr8HvfjHo1z/8aJw2/ZZnSjQTTs7BBlQ==
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 05:01:34 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::ec) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 05:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:26 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:24 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 12/12] virtio_net: Add get ethtool flow rules ops
Date: Thu, 16 Oct 2025 00:00:55 -0500
Message-ID: <20251016050055.2301-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8ef711-0e83-4588-5ad5-08de0c71145f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t81f7Fyu09O3aX+idWKSvZUPpJ599x+sWMW4pBYsT+/bA2Y3NASXG/H8guHx?=
 =?us-ascii?Q?ZiEERogviBfLzVyKwSXSB1g91eW+uWQFXN3Z64Pu/mOrMwwUQbkUyC0i32vk?=
 =?us-ascii?Q?x0RtDDY37QDR0yAzaJOy4URDXCQXmcigvdET8r7fxexR3AXRA48sdLPFygjF?=
 =?us-ascii?Q?RanMc0ZP0rW29UiQVavayq00eQZnoxXvJ0TqXHiaH6+KnaOKpaFDmKbxUJ7r?=
 =?us-ascii?Q?ln6D0qf8FVZHLr+RzuU+sjaYg6nOkus1NkzdByg/GNSxDEGLMrAfil/h48L8?=
 =?us-ascii?Q?4Z+yCA/JFScBLKUBeFDwbZexw3Tt3FDe14BlHw46ULzBcfHW9FvJA0byz5U+?=
 =?us-ascii?Q?haT5FWE4SvvNyw5lE6XQbJD9wxkIQ29vW+3YVGj0vnErVTtLsJPUP/+vpmOb?=
 =?us-ascii?Q?7ZewXJdVSW4F70y/OGMWM1z8f87vF4cC84r/3DZzZXHi/kdR/qdeai0Lwtf/?=
 =?us-ascii?Q?Evf6WrdDPxIRLfWnwmjXQHNcxYPbqofTCvVDo7XksCVPVnPy7bVdE+MKyEGR?=
 =?us-ascii?Q?tp3+c/YRizc3WUahNDfB9sQI/wflZVKCM8Et6DgjKGgN9L1XpiqHW+CVyvjf?=
 =?us-ascii?Q?VQijhx18mjWGH++4K9f6kJHob+2I9UnXpR+KD3UK0Me9cSqTLEKH54Qn671T?=
 =?us-ascii?Q?QGeowg1iMp/ur7rI4znclkFQT2HBXH3Bm4pROk7vtaMvSWd/pwHs96Sl5Wxo?=
 =?us-ascii?Q?38OrjAkUjh2i7TnUcVEu/rqXtI1Ia6XH0a5L8N04KvS33jleNhI8m9ZdfTri?=
 =?us-ascii?Q?gDkXzSmc3u58wDW7zV57gHCl2+GNappNNaUYyl9BN+NxZP1DnAc8ixL+NDv6?=
 =?us-ascii?Q?ryczOvEtGV+sT3ZUusV7Uqj2FsXYlXn+pU+aRGAHEgLq61pxhU4vzmXdphfk?=
 =?us-ascii?Q?ndPTz4Nxt2MhMSy5C/L+61IAZ5pDXOeihD7HZyhdvI01DGfr46IKWKk5Fr5r?=
 =?us-ascii?Q?hlCHjvJi1KvkpGThbmN/Po97IbLt/bISjQckbJnUT9PDdvSbQ/B6vNsle8ov?=
 =?us-ascii?Q?0v17WmhVEN6hYb+3rlxzmS9E9/NMLHR9VZ93gKij2Aa4N8VFWdnrEvJpyRqX?=
 =?us-ascii?Q?y67U77OL0x9smsvM5sUGho9jwZNybwgbjWHk/UJIaHvEVKhS77WK81CdaOSo?=
 =?us-ascii?Q?vvrliMD4FibS0hrZwWoLHIYji8R9Bc5Wj7mKrGuejF51i7syANQP5+gmUFmM?=
 =?us-ascii?Q?tg+MNXvmhAZxc012ezUbVAjtZtTAwwQlxWSwhU/pUFjk/Pj8Akx9Wa5gn1Ad?=
 =?us-ascii?Q?aHceEFTuxyKPr34MayJ9qtX5/s1+psOhAm1DwNY7DgC0qpw2desFwONO3OlR?=
 =?us-ascii?Q?2nZ1ZcIMCs39svLAhslOxQRuOXioyRLfvyYAsOLitzBBsjRYbsI4S9wNe/wo?=
 =?us-ascii?Q?b1SJz3ctWmlrNTYqeUpctMGDPdcAatu4/MqWCRo572jV07EAyxG0B8KraP/P?=
 =?us-ascii?Q?5gd13V3eLikw0iWqlnRiy01eEA7eAyq3BC/2qkLqESS90wA2uqxwF+fDYyoa?=
 =?us-ascii?Q?tQUG1Yc9E66/EOneM/4wE0WwOYv5AXxjmHPts6HBt6tqXS+l2l2uR2FObeF0?=
 =?us-ascii?Q?BO4dQ6Rya45KjY7DZy8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:34.4731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8ef711-0e83-4588-5ad5-08de0c71145f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641

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
index 623b318e5375..65c5e75fc8d8 100644
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


