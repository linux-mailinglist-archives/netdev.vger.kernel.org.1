Return-Path: <netdev+bounces-247838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 085DBCFF700
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6847A316E7BA
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086635FF7B;
	Wed,  7 Jan 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nhlFKbJ1"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E235FF58
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805516; cv=fail; b=XKig2mpQyIc4JmX4OryB2xx4oQw/+8zPYmZw6FoK8W/qJ6kEEahmkw9TEHx3jKGekxFPE7sPsqGjttmlQNfjwsb5ZSlO4EnjePxFJ/mg8kA0qBuOUJZ/mWS9nZ0eR6MLe811UA1Ab0Ru7a7Pnt/Hq0/IOFjJQ5DV4LnZIhtNUsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805516; c=relaxed/simple;
	bh=etGakq4X3vq1JYDtHgWce6l1LOKJzOK7zvAn3qV09rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU7JzZFt0ddKvF5jou+tiheg1eMbhjWpq1ZYl9MiFJn+qIBC7ci5h1b643WQgtdPxjXkU0YMH1kVS95nkHzH7OaNlY/CLL4vHM5+BY8JMIPq6fzECTLdlfml7fAG3xwe0t6If9XzGtgN8IqqFQMvVSfc5jso64kFDpaix5ZR7oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nhlFKbJ1; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9EiK8/yDtNIw7X85Vn+ARhEmlV8FRFcieFgL48JMQfXwKZLIqh7AZWtkEbcSL6gQ6veyY+pS4kf3Fw9shuJfDI8LLhJugvw3h8Fix+zQiO7fHUjvgPeDrgIpWrBf4Yy44bKcG3oocypdY4vkFtDgpkYwH7Cnlmf3/3KWM/I+TGz/Ku9CcMtC4DKMPB0Mpkyb+V6NEd8qnCF6aORWYCAPZrYOmd4lbW9J7CYcuBIPkM4xl44reIxS8i92bndFYaNa4eknRcF3UXjlCwXsg43AXC67CT6xxVAuvcYooKSFvZKytSmFr3nlBfB739ebOFqncalbdt5YmN7iolOjKtwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJxg8S9Nbs+remu+GC5vAOjwjMpf9i3ZHeDkg2Unlho=;
 b=slZGbj+BM42JILnUGGWoFeJINw67pYZTWnDvNBMPY923WRF4HP1yvBgvllxI/CJEscXJJSsqxbpjul3ogf4Tf/tJ/89v/2QVzrYxRrSI05n8oVpvw9Zdp8/eezciILjyy+LzIJnG3JS6t+k7dEBn80stftjtsY0gpPtYajX6Mvu52FPNmHqbwX1PMqhrWZeRSpgJP4y7GNSDBSgD2JpYzYbprp+9LcqIZJJyGmtGHSb7TIFVLZjK5Fo0I9MMYCM0ld4UgauPnI/Lt8032WEbjXpfPTr3RA1c68bKwwwEcDxSMfyW5621Tr3id9zwwTz2MMdqr8TUnzQSf2D4K/nnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJxg8S9Nbs+remu+GC5vAOjwjMpf9i3ZHeDkg2Unlho=;
 b=nhlFKbJ17s3OBaRCjKB9Q8nZFj1x0TCGbDAj9sTV6+5naS037YbI9FE48PgVelwBgy5hSRIwn2pElAvMLYgUc19GhKZgEkcOIE/FsPkd0yCl+hh4Xa8LX0RnrXzX2GSdc36/x+2a1s0uWPKOeFeYz/Hx6JKfklhcgEWYV/rP98Fwkt3uY/hVuq4hMwxTh2BB9cl29rZdw4S/JVhKNnSV+UEUjXwKv27Ph3eF0DVeNAdclEw17wAS+QboRh4Vip4XQEMaUFIecSEaFXPVlWc+gWoF974muovCYLsfVmnjadM5We1pAoRM+HN/SaYupCJh1cRW4vrMV+ZEM7XneCzVww==
Received: from MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 17:05:08 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::38) by MN2PR16CA0039.outlook.office365.com
 (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 17:05:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:47 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:46 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 7 Jan 2026 11:04:22 -0600
Message-ID: <20260107170422.407591-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: cda46e33-5f1b-43a8-d787-08de4e0ee936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LiyqGorjvwxRdh6DOMSCUbSPON4Qf6GabD7xGIT5ogMQ2+UzzKkL0nq8sOIw?=
 =?us-ascii?Q?TeHApMy/Iz8z0SKYoJswCZja32KYUkc7evwfcBpu794bL8rz8amqgNQpvqOm?=
 =?us-ascii?Q?6LGCtO7bMDhJDUi4Q67qVfqXr3WJy5DSxbO8K2fKHc7J3JXc3g3rE2cjC2+a?=
 =?us-ascii?Q?k+RRsZ++zSayDtnqX7I3fGLNP4FOaK8IqoszIToWe7+AfJ9bpYPrmKNZqKj6?=
 =?us-ascii?Q?foGUxwedj76tJ8qoHS6tKNfeU2IvPPQ608WbI9UY+DD17JcBrKFBd/mQIiaM?=
 =?us-ascii?Q?y8gjDGnR6EE2gubTzRa8XriMehf/4mL1q4oop/OBNWahWa7OwOvWzCsBcYTj?=
 =?us-ascii?Q?4AQQyXHiK4LUA6E6GSWSJffkyQGq/PCZhlkHmW6KmW6MJYHZYQvUcjDx9hFk?=
 =?us-ascii?Q?MTAY8EIElG9+rF8/+vYW/pWG4VNB4Yq3gJ0EFx0dfr0mR1bP21J5lKji2yK0?=
 =?us-ascii?Q?9Fm3FVYEmqyMCUd+wVEqlDnYA6v4XENRZ+LrsbY63cCAc7hryuFDZ9w6XkPn?=
 =?us-ascii?Q?kIWnVZrrjfjKq352QoMZ4WGmsuL/2sWlB8JAjpEzw5kUBWXL6/HBoDAFjqEt?=
 =?us-ascii?Q?QUJ+INSN3BCDLAgJ1EnmsXAJoWe+3svFFgL3FdJkeF71FiqMeVRR6doAUeF6?=
 =?us-ascii?Q?K3PqDY9OSy+zDFnmSpc/RUcJtKon6WAgLHrbIFZDs1n5LkTZcMNKpDdRyb8S?=
 =?us-ascii?Q?3hbAw+dI0N3vxuknY2a7/TI+6deQWbObne/emfg+AQbrc4n7T8PtWSkYIcwU?=
 =?us-ascii?Q?dHgUWicClA+Dkv3AEpGWra/oCZSwMMo2UTRbfuhrxbBbj0j76Z2uCfEC0pV+?=
 =?us-ascii?Q?8v9fzaHYx0BXCLsPXO23nK5W04ePIUBdwrZ/DJSltxsv0dudjWJBT6w2EVJJ?=
 =?us-ascii?Q?txW/ANkd+mw/13WjTxCPrGcYiX9ieNpdPpvgBAkRqNO4se8qYPEC6Tx0u4U2?=
 =?us-ascii?Q?FnFqKmIrc9Wdf2dyu9qtUicHwsTu6WpDp4LUWuJ0TVpSqucsq92uMeoYgOjs?=
 =?us-ascii?Q?98fvQ9PurjQ3NqNRX7XhWF4EVZ8ZPGsiycxBJLEtSr2VsCiwCEVqocCUAs0+?=
 =?us-ascii?Q?+K2hIRkvxVs2yjDd3d15KreKWz//JDso6GYfoi3cYliDj3tH2qzofWqH3HRN?=
 =?us-ascii?Q?pMlg/bJdWE6PIXj2z77zBG2L3NqD9MOpgvmEk4fV2ISRF/QAMswZ7r2/6zu5?=
 =?us-ascii?Q?tlmn3lBLZIZVpp3WGUKp9k4//3z8z4Xq6YCAYJ939gA1+tV14xZTuQ3gX9XL?=
 =?us-ascii?Q?Ts5lNwa/qmDo76FG8IMALHrMQRB3SwgMVzmtrvKW15P5qX4GhwO7r/k/34pP?=
 =?us-ascii?Q?K0GG8go5rV27hjXCUlTe8d7JpVP81tkcgMJ0PG8ZaEGthy19ktbhbuY0kAN8?=
 =?us-ascii?Q?oqrm+Hl4lELq2Ozx0qQH5DFLj/4J2b2OA5gbhPcEOOAT9DSIZy8cR/LjIrSe?=
 =?us-ascii?Q?wkFBHs2eBnvrMq+TRYipMxFWLUIVUcbULnJpbtrIJJ+3VNbyiD2Es0I/BR0W?=
 =?us-ascii?Q?QMG6hIERzXYAS27WKJLZUwrwAsj6vYODDd3WvckENMr1Wyy3A73AWt96hwxB?=
 =?us-ascii?Q?XdYSjCGA3El8N2Hy82U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:05:07.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda46e33-5f1b-43a8-d787-08de4e0ee936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

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
index 6ac3ac421728..148cabf397a5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -312,6 +312,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
@@ -5681,6 +5688,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5722,6 +5751,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6645,6 +6675,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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


