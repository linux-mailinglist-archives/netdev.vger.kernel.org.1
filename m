Return-Path: <netdev+bounces-234132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE9C1CE9A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8D854E28D1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8A3590D8;
	Wed, 29 Oct 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JBIm8oU8"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49483590D0
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764620; cv=fail; b=P6XhoF3NJ3e/nYCMhSK1QYKHoFpvmTpJZlpNZUW63NNh0ZCIEdO6nHLJybK2hLmCk1yFh/GXd8BT8K9jW/UNHHafw2s++521JxRSa8E5IP/b4GSMDTXjLLV/XBwKrc8yKLilyg92ILcgY0x8tnuMq+bXMSKke2UWbFnMBIcMijs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764620; c=relaxed/simple;
	bh=R7XbUbLwD0YPMbYZqOfhogVHH7OYVcLifTrOqbF8iJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMlKQNBDaSRFCPYpKOjYU/6wKI/oGdimmtFZI8JNCPQPH+Tso/2Z9I58UxdonYsS+VNMdFSzdf4byH+fX2gzux9y6DsO//yqqVJZBErpny+HW0RCKM3/CWizjyTA0zPuxrZaIPtXXtEgdZYuXK+ILOMsIfZ36yIgJX90JzyBp9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JBIm8oU8; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+Owqv3ebC8+c+ooXh/o9cnpnOE0MXR5Zl0KsP9SQBVcZ9WEvo7NQiBqB/2REJX86iI0jJwo0rQVO+KziZeiOS+lHfZYpf4bgSFX/KlrdAGesHBKU0Dg3SrjDyOLCwH1bcUmAmRRpz0FBl5ESoYbVE7Zb8h6k6fdWAgYy56q8MlhEwhRbDEUhiA0P+TWZ4JoyqFILyEvcu/NlOiOyqAgQj1TDCsPf+z9uP6m1qD8cyz8jIFlEm66kHOpzqgcG6VMtH8Ew9d/1Fx5ZPjSB3eP3ntUjrvgkJC8qtMAQbMJq5sW9JhJJWfFgCtOVuOGpHUdZFFs6HaKhRP8UDpIooW9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Q8wUFSTcE9y0T/z+OqUpnnvBEpqkOx4NAHB58+AtU=;
 b=q092lfzQaqAoZsYl5LZGvqDP8p34McK5hOjlo/eTJFJYNjDp+UZY9AuPJKmJTLm8Rksr/bFiC2nI5dvyH2wAYGhFv9nImNODK/xX8A+Jr5LQoDgaAyxj4itGFpie5z4GLY3tmzxGBPL39bbykWjFNVhu+itQm6uXjLKytFILLg3YfFcGbq0oXZ6olMqzN6cR2QvWwKG0y5rJGsZk/Yw4jzXFcS07Ni0+zlH3e8X9a1r4+EPYgpCBtLACVvFpNmIyxlWJ7zqCUW4iDbJh27BJWmOg5qYGzpEWY1QrLxT51n/P0gG/tNmt0SLowFe1JgJnoqcbbIPWYmJiLuYvpxGSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Q8wUFSTcE9y0T/z+OqUpnnvBEpqkOx4NAHB58+AtU=;
 b=JBIm8oU8CaiU/T91ZxJeAexDf72RSUWgTBykyXpkFXDlO/U9nTr22Gk84zIRiZ+OOjYsESFLek6riWv3527qCcEmnIKi1Z4bRYY9kMPISIjHpLx32vc6Zsr1o9Z7lKHH3eI6zsAiaZSOUHoeVYiksxxSIpCGI3trhbg0x2xJY94=
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 19:03:31 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::eb) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 19:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:03:31 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 12:03:28 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5 5/5] amd-xgbe: add ethtool jumbo frame selftest
Date: Thu, 30 Oct 2025 00:31:18 +0530
Message-ID: <20251029190116.3220985-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
References: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: ead5d399-42d3-4f5d-fe26-08de171dda2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A3Q5hdBiQTzBv5G4yc3QIuUrn3uW6raVcm+w8pH2fqhtH36X2AFMRoJcFy34?=
 =?us-ascii?Q?I61MUHwoVqaDTfewustKq8sybRakxWx/ypIDFql81dDEPs/sdnHZ1cDWuG4P?=
 =?us-ascii?Q?d7wYyUHuTnzI+9AccZBoigByP/G6xnj4JbmHcRyiBo65JEQDosPSLClvPGhr?=
 =?us-ascii?Q?t4lRPd82hqND7TjXuJa+i4wBS/WMyA2FhPc2C4s8Cnj5XOpNQU9aUnuw8vIg?=
 =?us-ascii?Q?yyO0vKrdSiV6++mcKZea16TfWLJutYKwO75nOuQlU+UWgMUi7f4tZvDfbjUq?=
 =?us-ascii?Q?Tw38cWapzNwl4domWj8uNOZFyrj4sq1JtfpcrGSaFziW1Tzotf6oHWWCkTRI?=
 =?us-ascii?Q?8Vm1J/ymcS2q3iYlWH9xKmSFpt2Iq1n5PUW5gllqcm/5XtNhiZBu0J/79ZFA?=
 =?us-ascii?Q?pP+7c2DehCobvUwj5WV8rkvfazUIpa2Dt1I011ug6JtuX9odBawK+ePoOYfX?=
 =?us-ascii?Q?8aFrzgUhTh71MxEUZDCCJcOLGkSS871mMID4J2v2LEza5bygF33p6I9hLNeG?=
 =?us-ascii?Q?bUdZC4MqpAd8+/0uBgVNSf1OK0whQQL+vPYBgwq7cgQZWCjVo/tKluQNoLkw?=
 =?us-ascii?Q?E6JyPABCtAO/XFtRzQN1zC/u/T96uKx9v6v1rf+6gYSrf+GDqYP+ohCqkwXs?=
 =?us-ascii?Q?902vX0RB+nAYn2qk3gkneUO3eJzVJdv5Vekw/6XlP7cJ5vUKJpuy+EnFIkZ0?=
 =?us-ascii?Q?PJQPAbUpK2RfEfsxpOXslnTO1/MY4/YVCxnZc3+2v5YvltLH/u2d4wiuml7H?=
 =?us-ascii?Q?marRySb4GPtfPT1RYaecmFW4PLDiMB94HNbmVd2HOM8sIXoIXHpTXIunkqH+?=
 =?us-ascii?Q?6LM3mAfEGeHASrTLrg+PtbBcx+zYyG2LL+f1szJ/zmrmORy1uSXG3GvNnSKQ?=
 =?us-ascii?Q?lt5fxgrbhEBI4Nnv8+VnAg9/QsN9x77to6CTbUNDkZ76tlmHjbO5ieIFWifd?=
 =?us-ascii?Q?k2HZsHEQxwfnqhQt0WVEdDv2l9WPH1qIzc1vtnlgAFI8DoazuWRqZEsIuKyA?=
 =?us-ascii?Q?U8g7eg5ahWUw4laV/wk02Zr1ZKp0WVL8aYGUE4WlbRDQub30cWRH2T88m78w?=
 =?us-ascii?Q?V4qzBD95UcOaaSEJNvX14Skqr8WRp2S9DN7BpFb2UGWUklz8JKqLvLMSY3RO?=
 =?us-ascii?Q?CH6u6PMQ4LIXmEgxZa/dLmEcHOfwLOZtdYPtm+FWpOxn1EgMsL2jfCiX4oDM?=
 =?us-ascii?Q?ACIkdHRUw9m5Z4vWerChWtTq60mfPH8QjXhidVKnpaGUSP35mA2PT/7BilGe?=
 =?us-ascii?Q?EA/zIcP7mF6hpQoEwXw4E+Rx72sYYBTkNhesNEb/iHsadcIlCMgP4+csJbu6?=
 =?us-ascii?Q?qAMxIyK0FmsmQ557D1RpwLpXYZq50XiaZhS5ODe8mj7h7Rj8ebojRZj4Xk7Y?=
 =?us-ascii?Q?XXUtug9tr4N9tjqFpj6eFK5a1O/ShtxzCfQ+Cw3rw1ihF4oqEsQcubOeqEq8?=
 =?us-ascii?Q?3yTF/lJqnD/TVPYEPT2s2DCO1PYFPcaFL7FknscdVM6cQbkMXKJHQtAJPxbP?=
 =?us-ascii?Q?eG8S//O4WFdeIQDDDVLbluctiwOjOWewiDBpqQywLu2epf+3my1jC1EfwecJ?=
 =?us-ascii?Q?0T3Sk1Xec3w/bg5If40=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:03:31.4498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead5d399-42d3-4f5d-fe26-08de171dda2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v4:
 - remove double semicolon

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index ffc7d83522c7..b646ae575e6a 100644
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
index 1a86375201cd..2f39971547f2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -42,11 +42,19 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	struct iphdr *ih;
 	struct tcphdr *th;
 	struct udphdr *uh;
+	int eat;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
 		goto out;
 
+	eat = (skb->tail + skb->data_len) - skb->end;
+	if (eat > 0 && skb_shared(skb)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			goto out;
+	}
+
 	if (skb_linearize(skb))
 		goto out;
 
@@ -215,6 +223,17 @@ static int xgbe_test_sph(struct xgbe_prv_data *pdata)
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
@@ -228,6 +247,10 @@ static const struct xgbe_test xgbe_selftests[] = {
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


