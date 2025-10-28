Return-Path: <netdev+bounces-233460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC0C13A43
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10E45561EE5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598B2DC791;
	Tue, 28 Oct 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J5nDTCUl"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42EE2DCBE0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641396; cv=fail; b=M35oi3UHG7n/AbM8Ct8kEIYkJ8CvdkCbSl9lK1QyvMrXxoA7CExlCKOPFfn2ForopsBi2C+s+JQ0QcBM8+ZM4VT6TykA3CLjwfKQOJoiBRcDsPHaqR7Fx1KsU+JOIKhPpAqXe2iRrMsZSTuaDkMYkMNx1/kTY7+1cRMr3g+Eyy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641396; c=relaxed/simple;
	bh=aIKzmfnG+kcyKi/eOkXeg/q3359pa4UXPaSo1Gy6mNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5GaCiKlLi/Q4L12Q4lr+WHdGwDlqpTPSyjzG1MEMbEkarrp0pF7x+BGNKu8/GlQxAsjNVKE0xEqhXVmb0AJW+JScVFoO6c6yih6qsHxGHX4XT5acI1lQpvj8u/BhQDgYjp+MVbqUk6tPYPBmWZhex4j+4h8029wc2pRtyPdwRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J5nDTCUl; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRPqh3IhFMV6SB86wV8VKwVhzGrS6aebJJJas9sX1b2nnhMJ8rVmzeftZ6Oz4A7NJ35uQnRdeo7D9RuW9AIKTp7Rm8WW/uYBId6eYOf9pCQHrAEv7S1UPRhyt5SwlBB1st9R0/v7waH718hHGnHZ+1XQhqbxOqxD0Xf/eEA8Mc7ZHpMIkD76wLNUOulo4KDpCAn8z1CgDtNAJU4/83lwJlY+oIuUPBN+OQtqXr5TC+dlj37W8YbUHSSSD2sUN+t8tYIZlhjet5x3I8U6QlAAk3c9qPhl5q26V1YT+8ZL1GrnbuG+olNKhapp4lalGRG6zJE+h+uwhMeLqXkgdr9bCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyU5AJsPQ7OE0n8TICSUg2VLFpx0MGjNbOnuQeE6znU=;
 b=in9qRyZ7b5v5a7vJNBNz/wLMWay2gJvJqPpfJNHWZCPNO0fXWb35V6AoNHbvgXnWVwpfedZtfocfw4roIz2LxvSq/6qmP4eXyL35c5JNGsw+5UVYQhmBdFyquXW3hJX955Z/3LHmSRD2SJGq6AL7IZwM+dCPypeChjVXizWucSw7uAuA52xcaycNOdUQNkpoBXQvwKIX+oqECzNGN3EBG6igsKspPTCHuNyDAMVSKIs0ByAgi2VDPi0Napukfxm4odYv7/8jGZJZ3e5QnOeCNO+bGXkxH7T9cZltyLOyeA3Mg+ha+Z9Gdxf2NxxnMxZnVaz3ICcNw/CyUB+JYLw1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyU5AJsPQ7OE0n8TICSUg2VLFpx0MGjNbOnuQeE6znU=;
 b=J5nDTCUlI3/m6FpLaNLZA/dMZpzTxlWTAD3/IYxUaOqjyp2HZi/JlvxZjUdWq5m0wHUHNQug0m7odnr4kMbqKBUC9/hV0yVaoS/vDHqrXPj6/LqWJ2KHHR1S/BJUWGoF7uG0SadZkUAI6uTUixDzI6p0Blg4aRDuOeVpd9s1CNo=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 08:49:51 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::b1) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 08:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 08:49:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 01:49:47 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4 5/5] amd-xgbe: add ethtool jumbo frame selftest
Date: Tue, 28 Oct 2025 14:19:23 +0530
Message-ID: <20251028084923.1047010-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a81710-46be-4eb2-c383-08de15fef506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCIMh5yomYGEi0iOaAL5yioetZvePZwGrYYzYyqQlmKbGxxEsBcUkWItAMBp?=
 =?us-ascii?Q?VeC2BGILiES2MY9ZPi1Lj91qBOmjDFOMJwOfHWwMmFJjmPgwo8Va9So7F8Rb?=
 =?us-ascii?Q?AazSWplvgnANh1VR5toW9OvyJJNKaNuFUhLBdwlm27O9QVyR76hkY8SL44In?=
 =?us-ascii?Q?D4azwoNfwIEZdHWPmU5B5F3r9jaefNneMNLUcNd/D27e+zNeGeu7pIAOHt/6?=
 =?us-ascii?Q?821Pjo7riFViXcXwZGWAfodXuRlxBCumtk6slIDL1CQ2o4wI9mDsSjPmLyqW?=
 =?us-ascii?Q?EkvcS5cyIMVGEW1HEH2PnaZpeAHcdCnvTHaYC35sYKicZJNPCgM7/Z1qQG3s?=
 =?us-ascii?Q?QSE2+0IFwR+uY1wCtzs/vlVa5jBsOOHZnlCDnwIIFbq0aK7y0G8JrRvkaPwh?=
 =?us-ascii?Q?6c5aVfQTGikMW65+P7nNGpfCfozWYUb3WW+Tn5p7bz+dg6h5RDSG6fO2+m71?=
 =?us-ascii?Q?IWwUOQpqiT30+ATz1NrnqlrbYuAmFR4Sk011mX0p68qdnaW5IoGvKRvWI7XL?=
 =?us-ascii?Q?5uCFfssEkI5wMS3jNrBa+j+mcz7VArsxkBGlNuEdIkuG5J0S2B516F6RtYzx?=
 =?us-ascii?Q?PB74MEFo6vbcqHN0LseWNfz8IHHojAwqiEB0UQqwWa4s94xS35LCUmCbiv/C?=
 =?us-ascii?Q?mlqbKPyebwX2kmFbF32LjoaHr30/ION0SEHe5MuIZz3eYQwFgVhJWC2Q2b43?=
 =?us-ascii?Q?I7B34JDGtk4/hTIZyUeNujWjjuggCvG8qZqcLizfuddfk7SVi81f+quWMXLk?=
 =?us-ascii?Q?DyfL4B3/OJmtGikgCFKdBskKP/+Q58TCKx7PdsBB7J+bx3b9hsCynrMXMTeG?=
 =?us-ascii?Q?qxRU7ZrkLrr5NbRItA2uHEE79jAZOccfLCeg+Wh8mj7QLdKuCuVBQNI8xuiz?=
 =?us-ascii?Q?/WlZjD0TtlMBxUNnpVjJSzlFbVD6B+5ahNcNiQz0sTqfVUQLJLgH+nsHqqnD?=
 =?us-ascii?Q?XZGTVWx59AiDrTPBOLA/y9LAqFhylGRdXauilp1fRLfQwaV2lCSmqOWvZLy2?=
 =?us-ascii?Q?4wJ1RUQSUSsErx7P3mDBI8WDXFmwQbmCEILExqO/Um3KWPjFwAEhDeWlWap0?=
 =?us-ascii?Q?0/UiEYk0dis2Scs+T0/IOTHcrBGgxdtK0RH7BfbQ9zcsnrKttrntr3V/v//m?=
 =?us-ascii?Q?30IYZ24tlw1MPUjt6LH902VlTmTD4MlAN3hjZbEyw2SQ0CZck613/PVJFidq?=
 =?us-ascii?Q?b9vsRG0MMwRjm/YX1RGuund7Z4ol+NzT/VEENHzxGFqoxy18wCi08XWTKbb0?=
 =?us-ascii?Q?P6okIkA1StOa8k4XKO2Y12Wq8wiihWcKi8ppUsCGantE6KBNNDUQVReGjM8o?=
 =?us-ascii?Q?cCPY9P5susmM624rfaAgy0izIkQIsQtNuCctrraFMU8G75O9At+QuCvMAIY/?=
 =?us-ascii?Q?bMCsT21OUSQJWPaSlVpgkiiFY0qJ3arZODTie2DHxFm6M+lwH6BBO5EoUCUP?=
 =?us-ascii?Q?PVSgqum+5dw49O2uo+txwcRXf7n0zUw55ZkS6inAbF6MxfC9YegkAX9cvDyb?=
 =?us-ascii?Q?J2g55ydkXPD58KKSrlJGLDm5Du1EWq9g57LHRowWN4wktqlcNsOYGF+HRAbi?=
 =?us-ascii?Q?jLIfeXAdJvCk94ZSBP4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:49:50.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a81710-46be-4eb2-c383-08de15fef506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 25 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index e5391a2eca51..71d67bdeae92 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -211,6 +211,7 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
 	}
 
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
+	pdata->sph = true;
 }
 
 static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
@@ -223,6 +224,7 @@ static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
 
 		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
 	}
+	pdata->sph = false;
 }
 
 static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 640f882cf035..296bdc276a32 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -48,10 +48,18 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	struct iphdr *ih;
 	struct tcphdr *th;
 	struct udphdr *uh;
+	int eat;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
-		goto out;
+		goto out;;
+
+	eat = (skb->tail + skb->data_len) - skb->end;
+	if (eat > 0 && skb_shared(skb)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			goto out;
+	}
 
 	if (skb_linearize(skb))
 		goto out;
@@ -221,6 +229,17 @@ static int xgbe_test_sph(struct xgbe_prv_data *pdata)
 	return 0;
 }
 
+static int xgbe_test_jumbo(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int size = pdata->rx_buf_size;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.max_size = size - ETH_FCS_LEN;
+
+	return __xgbe_test_loopback(pdata, &attr);
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -234,6 +253,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Split Header   ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_sph,
+	}, {
+		.name = "Jumbo Frame    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_jumbo,
 	},
 };
 
-- 
2.34.1


