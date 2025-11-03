Return-Path: <netdev+bounces-235256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06877C2E580
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622764F50D3
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB430F547;
	Mon,  3 Nov 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k8niN2YG"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F62FDC57
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210578; cv=fail; b=OyDgHe9iPsDV53eL3ojuZmP6RbLP9ZeDCeR14n50rDuXAuwXWSyem2J6rFTAY92dO5YxYV8SBtIMWVk2HW9fhkIg3ZAquE39FPdna1vgpBapYCreZ0otWtW4P67vCPRbb1ilSfK8mdSTGOMXQ4YLJ/7m7ejJJVawJOjXursH+TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210578; c=relaxed/simple;
	bh=K7/6f+Aw9D5hu4S79TTslG3OGiJLeRuZ0pxAkeprnF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSL20XGz37BprW1oHsd2gHlCzXYk1sDpHy/U4RPdUapFZMZFe80cFEsYHProuHYSTyeisrorN9Mua/V/9V5mLTtFFRQuUGDJlr5hGN2r0A8n9iveZOBK79Yye+hzWQjGZ9vKN5pl0fsE7yd9ZvSK9/58WOjKrdQg23kPl9kg4Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k8niN2YG; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiGkravqHdZdl1H65F3WTnrnZwuL0v30MtA9YFbiSuxck4mxB8/9YiKvFCcsyvDr5ZUtXsWzK4cyHOj/54r7sdDDQ01aJdA6kTKxhJzGWtTQn65WHgTG7sygXotd1FrRZUrGGrWZMNr4xITX+M8ZFEXjCabV+AIFJK/yYdkHkkwK4I/K6wz4f5atkHLupse1UVNVyO76gwWznk24SBFmqHIvmLYrSFWQYIIoc9EW8X+EyvCHd44uXuIxetf8D64HmJj2tuWyrzjhxMGwOyI37qQcwj9bMygZYzJYE3M8DXu1N28eUlEhepFl15W6Q+FHuZZH2hT1jTSuFxavWCJ4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcDDwuiV5PQZ4t9FfIbrCZInj6MdBr1t0sch/zP3FDc=;
 b=RbeZcRQAyNj9CAv0k7jfN5R777yA7WoP5fnmIeMg2aLhps5vllIgRsVyRO7r4/gSGq5F7bLTMCI458vSP6Wbn7gesqVtKJdiVHhxUNKOe1bfxDHj+j/EA3Nlipm29+s8Unhxba+fqkOI1hH42xLBbzDq8+kN+ygdXOancHcLAlEOGld1x4LQUA4m/2JVTiboUembFgDsiKbEsy4UVGFas/hHvvLCC/tSU7mquHMTpc0XOf1gWf3TEPGxNqD4BdqgPmnwbbNp5cRuHqv3RSzyDsfEJRPlk4lAqxmdTVVa2BuXf5WuOhYPkjzhrhKPW7O0XmRdnRX2QQXneNsKMZAvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcDDwuiV5PQZ4t9FfIbrCZInj6MdBr1t0sch/zP3FDc=;
 b=k8niN2YGwEu+qpbT42AW6kN2jyg0UTI8rYkrEz1roX6sxwXVNhXYbaXsdXybe3TK5c1JIhjRGsIIMU5LW2AaTPtiLqICgrgkWX7EjByy7cUoCyDU89BMOmLO2cGVo0uMa0GBPfqDLo1Krl1ZRK+8mjqFCUq1sxdnO4FE36e8ek0cE9HHjGKJUatj3IB1wcgdbcmy8v6/HpBY3cG6uX8FQq7M0ywH+3LFafLnNElwG7IZ/BR6SN2mh/nlUekt5sGFUQjgGRXS/srBG3MmBIiLOC91GGLRVcmRqYk9VZTxqYlB7sWECgafGjUTu265EHFykXOeFSDIkxAo9j3yz3B18w==
Received: from SA9PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:20::17)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:10 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::4d) by SA9PR03CA0012.outlook.office365.com
 (2603:10b6:806:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:53 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:51 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 3 Nov 2025 16:55:11 -0600
Message-ID: <20251103225514.2185-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 22983f07-3eb6-43cc-f4e9-08de1b2c2e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SoMUaw5feP80EzoID4f3ibch36WaNo02CS7x+sb2CG69q4JRajMJG2a0pECe?=
 =?us-ascii?Q?v25iYd7oHQ2uiTMVAFFVdZpeni7xeKUfEvb4mLBOtfEPV17SMDrKb7qXaA0m?=
 =?us-ascii?Q?SUKNfcEEfmSlfhsRGiQJ4d1u3KHhljDq6g+HyeZ1jv7pY0N3ZQM6VaA3Te35?=
 =?us-ascii?Q?7Vi5oBYanrNIQ5O7V1txx9GAh1CZkeRWELh56nqbS0SjWY5XP6pWgMzbiw5o?=
 =?us-ascii?Q?6es3HPz9XLYsyiN4No0YKX0K8R3TgtR0kIWpfOM6cgxppW4YeUlfbT1R8+ac?=
 =?us-ascii?Q?8u4nxZIRGO5NIa9zlLfTnQGn9CzUUoRsuZK1zzwNCau0BI0+5oEvb8AGbVTP?=
 =?us-ascii?Q?8scoG5HsnFDbPHH+5++qF6k3EFdGByTL9zhje6IZ2JBwU/1m1uC0NRNPocim?=
 =?us-ascii?Q?4pPowmvQ2BcSwFvYcGnc0+FBxCKgKQ2/bki8rqWkhEQgp0DzcvB0sKOBBxyL?=
 =?us-ascii?Q?RLLKYJz4Bnjs+q+fS3vjHifqJOTFaZK69MR0dcdDjfTWuqge7q0YrHFEvDp1?=
 =?us-ascii?Q?wQ+Q/kW7uATw/IR/9rW+Nz03hvGXYAKF6IpvRXmXkpUWmL6kyqx/ITTFukXE?=
 =?us-ascii?Q?fqtb9WmP+HKngGXsVGzG8RSYL7IVSyKw/pq6RT3CcZ/2z5JWH+dBZJn6VLDG?=
 =?us-ascii?Q?b9425pRfCcf48X9PG63DOWtNRIejOPlxhhq9Dfj9gM5hqIwdoVw1bI1Z1KJo?=
 =?us-ascii?Q?Mp14Ag96lpZmy2oh4G8uqvZdHGacDN2FrdqwdMnxyZ2VIDaO5J2fItUItHr2?=
 =?us-ascii?Q?FGnVnkjKf0E31J3jzbr7XlVwJn1iM/2CebAXgafd5ovmAmttgxbk6nGNncDK?=
 =?us-ascii?Q?PGyL5E4alC9Pe1TOqBFscSlgqXJC/i2JNiXEVWKGrjU8x0Rxkf/sTyRNm1tU?=
 =?us-ascii?Q?39Xapy8kNN9DWnBrQgcP/kk70OAUNTIN32aCelyJGRTgq+D4f6BC1kp3xbB/?=
 =?us-ascii?Q?YCU5scadR7AcqRLBIxrF33r44YVT0hhz3gaz2tuBMQnZ+okfJ22wwXmvshjx?=
 =?us-ascii?Q?BUMexVICAZQi3g9ZwctM0h2gonfnihapeUvqSpss9FnpBwAP6XM48yVmC3zr?=
 =?us-ascii?Q?p1BlpX/LKzR2JZq6gmo6Eo4PMw22q8MCSEv9TnvD/F0DXntKNkvEqHXlRqcs?=
 =?us-ascii?Q?MyafO6rMGf3+6JXIWdh/lHRWNF3lRow6Qp/2hLXiZtsPspnNndO6Jg1m6o4P?=
 =?us-ascii?Q?hmlPUpZWwRPnWEGRK7cHoGAeOTAWm45WSvH//apzDMNJl6x7XauSV/UZ1fDX?=
 =?us-ascii?Q?DqovbBR8l5caQKbdxQdWUHC7GF+mCt1dH6rxlj+x5TpMfgqYKk6LhTY02mDb?=
 =?us-ascii?Q?83lOO1xtwDj7gcBNPWWnqhJaR2/Ezu5+DiGhu0qkp9Mui+oGZ91ble7EZrPU?=
 =?us-ascii?Q?WCiLj8D4JcVr/XM63yLu4xxxzk7w91c7tjXdXTaxNTyEyOpauy5m/mKY9l2O?=
 =?us-ascii?Q?nsUNwWiJV1oKYnHKCPu7yR5YbWkX4Ln+FHd6CGBiVbVRoOPuuEH0hpvYZgkx?=
 =?us-ascii?Q?tnUsb+juYtnDjQFVYborun0Xr2eMaGtIy2htQL5Yt8WEJvv0xWj7g6v4GIrN?=
 =?us-ascii?Q?7AsxmZG8PT71v/h1ljw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:09.9440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22983f07-3eb6-43cc-f4e9-08de1b2c2e36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.
---
 drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a0e94771a39e..865a27165365 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6889,6 +6889,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (mask->saddr &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->daddr &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6900,11 +6928,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	mask->saddr = l3_mask->ip4src;
+	mask->daddr = l3_mask->ip4dst;
+	key->saddr = l3_val->ip4src;
+	key->daddr = l3_val->ip4dst;
+
+	if (l3_mask->proto) {
+		mask->protocol = l3_mask->proto;
+		key->protocol = l3_val->proto;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -7039,6 +7092,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -7067,11 +7121,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
 }
 
 static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
-				 size_t *key_size, size_t *classifier_size,
-				 int *num_hdrs)
+				size_t *key_size, size_t *classifier_size,
+				int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
 	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type == ETHER_FLOW)
+		goto done;
+
+	++(*num_hdrs);
+	if (has_ipv4(fs->flow_type))
+		size += sizeof(struct iphdr);
+
+done:
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -7083,8 +7149,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -7092,8 +7159,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.tos ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+		return -EOPNOTSUPP;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -7115,6 +7207,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -7152,8 +7251,17 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+	if (num_hdrs == 1)
+		goto validate;
+
+	selector = next_selector(selector);
+
+	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+	if (err)
+		goto err_classifier;
 
+validate:
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
 		goto err_key;
-- 
2.50.1


