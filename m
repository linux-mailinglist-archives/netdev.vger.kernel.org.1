Return-Path: <netdev+bounces-242007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6841CC8BA5B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61DB34EDB4E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E934A795;
	Wed, 26 Nov 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OP31PLDg"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76B34844F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185795; cv=fail; b=YLW0+vfCLBIyV3eqYNGKqjlOyVQNWb6IAgmkafMTmETlX0O3c/b5hLaJ4QGQFipkJTuP0qMOV8Y3G75ngt3CzmFYSEnG5ycaM4RcROUFnMWD5DXsHjmF+DNYtsdKPq62AN18a2i5SurSM6N3loJVrov23wcRBSrGTTa/0BJhaaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185795; c=relaxed/simple;
	bh=zOUmClWf3bdg1WYO7etb2+lFmgOrGq6GuuVrCrIseX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNThEfec1gzbOP7vHuy63rK+tM6OeXzOY5dRP1zAnblukjXEBGtCu/mtmHe4YMQ0Jy9X/DfAfmRf7fgl9+TRHbV/WYG2AXDvKWYfmW6uUT7sF+w6ll1Y6V01wC9zwO7EZBKfQjg7s2jREIE/VdS3TWFyyqX9JHm5MLPU3rfXbPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OP31PLDg; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiKCKxjIL1YXpjVXMNTfvHi2P7AsnAvlhYiuLcLNHYnVzAnKV9Y4laZkYjjpckjUvlQFDgRmWFxvhVnJlbu6sGBWw+VQDlHOLJH6jjxs5S+yU+viTBAPvJwyhEouTZDtt18KGK4eBZIiniX9eXZH8nBbNO5P0pxswThcFB8fEUSimsfo4JHee7wM0MyQVSLUv2I1HgvoAxeJFTFEh38SRD58i6PbQQq0Jz4j5+zWUUZtQK/6rzOBggQN7kdcNIq7Q6zEi1bUgFhp/BWlgxfZx3N6/kZXgTCzaAZ97jDVPkMooi7NtuOWpgttdCRg1JSvlqys5JqedwcB0OODHjE8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCavV9b+4vKFv8AH+0aESUb9H+XP67mEhXTzDHKG2pc=;
 b=GIlsjGgl6QChLSFaUxkc7K2x79qBTYwEG+1izi9PMDM3HzMFMR8TSZdiJx13WfKHMFd7kHP6Fnzvh5R5VmgqC38XqfymbtN/ybAFQ8rsA2lQIjcXnXAVH3E1Ro8JeW5R7DYXKEItUyQz5m1hLqeVUhdtVLlis71IMaTIth+PFpgPsdaohK6XKQCopHZXG8pNK5uE+9JAt2R4rZ4jlSIsvJzxZ4WVAmg1X/K0vZTgNtU4tIU2PUWmJqOmMsgsDhV0DYeYf5Ux/J7gDvI/H7IkR952EHVn2x8FE6h2RzJxWFC+9+M+PAQ8XeDvRl12ywQ9VKX/mXT0D2Ney9Ds8/CwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCavV9b+4vKFv8AH+0aESUb9H+XP67mEhXTzDHKG2pc=;
 b=OP31PLDgHB+fOxizgQYmTeN7SpNeVrXvu9xauY/BZeiIizIjKWoo1a9SDAARVAJ4gVi7piJE/V64cvd7rzDIPjjwDQ8PerAE2eWycajsxlnqzEUEhksFydv5W7IAdR2ZyqU8OqQeepupiubZfBxMNFuwyXne9ZRIMI61kRLhCDCkmT5GBtuCmnP44JQg2YXR339bl2oPgZSaSSLvqBw1QYBwk2MmEtqS6m5oLHE2/5YbZCnZ9qmy/jRJPtfTAvQuDJm0kgl9JnLmUWvghshLCWCQ7+p7eYfADNfkgK7eA4QaxQcTcqlYuT8aGqsWHpymplfdnshXvVaquvXXa7v5lA==
Received: from CH2PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:4e::27)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:36:27 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::d1) by CH2PR02CA0017.outlook.office365.com
 (2603:10b6:610:4e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 19:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:36:15 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:36:14 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 26 Nov 2025 13:35:39 -0600
Message-ID: <20251126193539.7791-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126193539.7791-1-danielj@nvidia.com>
References: <20251126193539.7791-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1954214b-de06-4246-36db-08de2d23173b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVvrkqdjEw1B80GT2UkHbsI7z+HaGJ2/ggv/XLf8eBY3zoM7jC1aMhKRcESL?=
 =?us-ascii?Q?PhyTNI8LYup8Mp3mhlBeEPhIXZu+BzdGdgchN75a2Z6ZxK6HwRX8qnq+CYQA?=
 =?us-ascii?Q?3ev4VeUN8UUx/S86djiYe+2CHCtQ7RUsLI9hNi1N4RrFN4VulqECSOHRlV8h?=
 =?us-ascii?Q?zgagD4goGU/SuG1dGgZRqi7Bn54HOhr+lWT1viys/UZzWWYC2p495Wm3bPZZ?=
 =?us-ascii?Q?LdhQ7cI3+QbsfFKfhy6owsSDKotxzGCK1pqS0b0w9z+Yx+sYik4juJ7TQqK5?=
 =?us-ascii?Q?dLPgkrbwEKVNkRnoadMC7b4ZkpP6Lay93cCspHnwWpfPwZFfyS5un+2bTv4m?=
 =?us-ascii?Q?TrBbT5ALTyAl/RyoC6W9FrcLr9N3BXG1egY3eS9h/K/wyhfaP0jFvIqzeSCf?=
 =?us-ascii?Q?IRc9c1TSsRRxr0Pc/80s4yKqIDkWWxmkC1wFKr9TMcrAycDMAOax72BqOKDo?=
 =?us-ascii?Q?2tc/bAs6x6McgBh2HL6boUSah5xHsWsNu/YX7Nq3uhTlpV32rBFhqNUzCSxf?=
 =?us-ascii?Q?KRz3TAgVz7mNKed3sIlwImeLYpmjsw3uFVQaeGciJ3PgdI3bAI6apqqSJ6gh?=
 =?us-ascii?Q?345GCwTFy1+Rnwd36aNI/aLMdVHYtrFn95vwZ5hmpa5vxQtOX/ERwBI1mYTd?=
 =?us-ascii?Q?/4FaQmo+e5kIjM3W/DRex1ev0xLNFcPbJBVo55llYsrr9bk/295a0Moy9cYl?=
 =?us-ascii?Q?gp3ZMfDcUMcgmsu9GDwVSu1w+fiV3oF8KYIjMnXjiTP6EwNqah1UZIITWd7Q?=
 =?us-ascii?Q?/QgLHz68meZoIlTvODae8xogiHQApi7LMFOJ0MwzeSVwvGNunSXvuUlhIpTD?=
 =?us-ascii?Q?MWztJ2MfbtxFGHxiN/h73BLcY5aZ3btIlVXSxg32ijuLpjzOxTuJ+3vcl6fx?=
 =?us-ascii?Q?bEGpcoF/xu7/djoJQyzWVV7ZZa2M7v0x0AQF+t+ZuOoQvDya6Nd6o/rxFbkV?=
 =?us-ascii?Q?WTEtWijZKmodroE33YKK5dJJGZafy7yuvg/YPnou7Rmx25xr/l3I7ivKAPLe?=
 =?us-ascii?Q?NKRyd9iGZUQiHl2N9EmRXT4/QI+Jomp4zKCcUUIFg6gz3946I6PajG85157w?=
 =?us-ascii?Q?6VilSiGUQ3cOzMH0AIX97AM/gRbo9K4nCoBIR8EqT8ejBNfsGklAJX7TsifL?=
 =?us-ascii?Q?kZpdIsDqjz2V9XYbvy+XXHs+1q9D2GPi/wBjPQKH1PKbSSW5g7XymlNendkn?=
 =?us-ascii?Q?QC9PjiW4I4mCYfcdiTIA8S4lPBYJ0grE3byRSKIxrUmWTW9JzemBUdLO3tP5?=
 =?us-ascii?Q?DpGyywDZVprLGGUGXJoSjmAEYOqzy6GHtg4dkyi+9S+G3TNAGXgecIgoqn6t?=
 =?us-ascii?Q?31cOoegyE7pttlFBt4WSH+wUcurmc5tUChAenAXjZLkvvU8eQxMkjNUGIfcq?=
 =?us-ascii?Q?38Pd6Ftl50KfNG+KFtcZCGSEPjiKBDdovsJ4yFnhvu17wEeRzzYsvvy/RGXV?=
 =?us-ascii?Q?hPXI0nGu9FYzCapCcrEHhgwPydNplRdws555jCXncVi0VDWiqX85bnbwT3ki?=
 =?us-ascii?Q?nJV4V786q9miUFOds+QbCfT0vfBsTDqKA9OhgeDLdjuh9i/Hs77JMvnu06iM?=
 =?us-ascii?Q?X5UOLcvfzlWzanWFqYU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:26.8627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1954214b-de06-4246-36db-08de2d23173b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

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

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 908e903272db..f71b7af848af 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -310,6 +310,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
@@ -5677,6 +5684,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
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
@@ -5718,6 +5747,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6651,6 +6681,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


