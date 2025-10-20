Return-Path: <netdev+bounces-230933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F8BF2135
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C34F8347
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26026560D;
	Mon, 20 Oct 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uLeVpN1N"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06632652BD
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973809; cv=fail; b=kCikNaxkNdF/2LZFF+k/+h7dvD3clZJz7KYXVnJWj8StaAnP313TxAZ5WTVOkwb5mGMEil7yI+liKFU8VLea22YM/NNb3EyDWzCG7OcUlNs5/BehOFOQVGrj/EZVHbtbWT14DdQTJFVPNCaG/CZI9KTtHJjXzDcJ/3SOfOns2pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973809; c=relaxed/simple;
	bh=z/yUnpvqNZJu2bNALy7SgRBEJZ2iVX4nhjtCcDmLpPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X39xD/Up5WLKjXGWTgbdRXaRf0GQDvaN5n19mNiX6fGzMeYPhV+W1x7WpcqffJf81bSC70iOcJzGpX0TEzRxOAgNztyEMBXkp28CeHEH9nxqoJ7dUJXk0R+H2nj+BpR81fs1JShUv9uAEHF9VERlohJGcap2sclG8HnwxrpibO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uLeVpN1N; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaOrTggdPqcjrEyxM6TYwoq6OX0R4g/0xms0C31loQNUZMz2y5gB38uFZgeK8f4VUSjCAaO6lCfD7mjb0o8D3sK3SCTU2dn4QBnX09natQFBF2CawlfG+jJCuR1FkbeujId7Ufxivh1ET+RAYixw3PGPwoj9yPOwSz+SY3XWYfNqnyje8GDbEoS1KUVOe+UJA9n7UKZzhzWurw6AGTYq7grlieW94q3c+aE0eV4EtufUOzHZILC2tUe9Vg7gxbyZwmffyEcL3l065f2LqxW1DroOwp+V96ynmusD7AB5mieO6FDKLMwe7P46WRRxGSEMese3kPOZ916sMOEiak0otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM9b5n6qmQw+CDsGJX0hLSDxbPguJrQimwdNSFW8WxA=;
 b=WjGGHXWhRwaeSayO97zqhpXZ0Swokmj9juo43UhMGXbp3vai2z1w3S0UdVtXvgMImBfmApj45ysuNzyPEXpFbEyQ2tMHAH8Q1DTkwI+bGH508acK/JwjPuxBfDFdAN2aEgfsXwj6s0siOhqXJ5mhMhX1xy/P83v+FwfN8o6CgI1ofNN9PanpxtMPJez23c6ZBn+FEDKhO1auYZyQoLhTarDUE2AdxpWM8BK8yjB+axMQudYWlvE3MiOv6DMa3hlo8fcFcQXpnj3EUvCcxriUDWHfOjs8xMZSC479LLzb56XSbLieXH8aiKu6wWtQutS3ZaUX6+1TrhKmX761ur+7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM9b5n6qmQw+CDsGJX0hLSDxbPguJrQimwdNSFW8WxA=;
 b=uLeVpN1NIfduXO7PrlHcucLCKFQ0WWp3gDF2C/zSSryDX1gSf0gT/1LvfXWsZN/IjyAy3FOlXZiS5Jb2LrWiNUZpvTUCOyBTL0ulnNkedVv5eI1eU6770XVIn8F82me8GCflZ5MTU7bOaoCZjQlsiGpylzoiXsRtgokD/xLbqZk=
Received: from PH7PR02CA0030.namprd02.prod.outlook.com (2603:10b6:510:33d::24)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:23:22 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::58) by PH7PR02CA0030.outlook.office365.com
 (2603:10b6:510:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 15:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 15:23:21 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 08:23:19 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 3/4] amd-xgbe: add ethtool split header selftest
Date: Mon, 20 Oct 2025 20:52:27 +0530
Message-ID: <20251020152228.1670070-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: d31e2461-e5d9-4ec3-6cea-08de0fec9ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utFr3ros9p5ljw4aKkLZVNX/2OxSEKe9e2GN+h8I1a3zn7Ra9CxAWIvJVyD1?=
 =?us-ascii?Q?+JF+iX4EYKAisa0i8sH9DnR2f6vJAj3sTdwLkXJ1vsdrmuiP3Fz5Wd7yuknD?=
 =?us-ascii?Q?rSrKR6H/PvO2x8UqKIAvQCHw/JLoH03b7V6tAya02ESZu00wpJKKfaQ/LKXR?=
 =?us-ascii?Q?QPrV5b7HD2EZ02JRqm77XVftTJXrq9gwSa/jH5eiGzhOHF4NPEe/nXleHy/G?=
 =?us-ascii?Q?vMKHq4CBRWIR+HHTTEFWjsFedpehT5WbztMsEkYT0C8412n/cXhfqKmF2JJ9?=
 =?us-ascii?Q?p34ZeETxt4kg+ItNt2qCzw/1EP8phu/A/trEhgRSPGLs52TS0jlUsRv4mJTG?=
 =?us-ascii?Q?SEsDKOMcWsJfuYdLxMEo3oNBW2zhb+QJANYoyxy6eaJ1oIxpjubP4MnVw1Nj?=
 =?us-ascii?Q?dzghXMncXjnWWNrxotTu3nmt+zaR/MiITxPMBc0hB8EYGI6nPNMA5q9mej6l?=
 =?us-ascii?Q?y5yGHzHKIMVSrAoAmmo9YzTc33oDsXnIeVAaPO/BZCgEAg6i0JFdnJpkZJKw?=
 =?us-ascii?Q?AI4uf+bGq9YsCpOAOMAZaKkbZ5+KBL29gQnKZgFbA4s0cioncJRiEvSD1OqR?=
 =?us-ascii?Q?ne1qd2+PNJmloBO7tmYXOPRXyZ/T5yGG0yBDmSDP348yjze6gVowYaaKuUXE?=
 =?us-ascii?Q?nHzOIHC3Qt2iD+4mnzyrLX5iCgBH23t8CwZmJabmTvZjcjaMuhhbk+Qbc87N?=
 =?us-ascii?Q?yVD4rqZg7VK30/UBXFuKULKWyBJTCr8rYRljf+LuRL+BjgpE+xjdrQN3ejdx?=
 =?us-ascii?Q?OOwIbBgy14KjOXnRzhDslpXk5vk3tx1rvlYHuEsyK2D8Eh/SVeldhoApCM66?=
 =?us-ascii?Q?FA8S0sJdPNNaIHHMywE5oNNZyMPGLv0E+RjwlkTDGfrruO5ZpB214/CFGYP1?=
 =?us-ascii?Q?R2t+5ryfWDkRGmdbA+ZPJteS6kmBjlEV9PlaisO6nUemmng3yIYZrQY3a+e8?=
 =?us-ascii?Q?QdgrKoj6kuNxm1Y+Mp/RasC30v7uFLfn8v/gdKZc47jbQZa1VZcLNnc0zdM3?=
 =?us-ascii?Q?BgnoJGqzM0AGb1x6Kw9rdyR1vZ0PWkiLCQbQsN4ou722JeT6KaHIjSx75AFl?=
 =?us-ascii?Q?CaO/hDVZ/2/bWk0FekuhueNIoCSJFC+W5UN3YsuSbn2k9CtOkcF3n2W1CIZW?=
 =?us-ascii?Q?RIDkFIY7iRzgoC1xxf5o2ne90RNNpKxAEBWgKH1zX876dXY2Py9yeZYDQrcD?=
 =?us-ascii?Q?DQcBoGh1pfbXPHQ0UC/wFrEXHZ5RIhPM5bFORC/nIM/kFIlJiOwae+V22a/a?=
 =?us-ascii?Q?ngyFyExSRzoSZvFX8GKw724LGUfw7ETAQ2RameHySCU5EDYSBEpN0paM0FSU?=
 =?us-ascii?Q?Wdg3cwN6LCiZdEje/7dvN3/0AKxaRrcRLLy9cLeIMnN0MDjtzIeLkmD3/G0l?=
 =?us-ascii?Q?/QMUzH6xGtp0TwZR9HA40LAObpt78j5eeoZOugdCH0yh1iedR377wE102zU2?=
 =?us-ascii?Q?j7EWgSmGhOATCKgzvG+e34VnUw6TQTt+1PYHps6ipen/FKxCxQ95uPsw/68d?=
 =?us-ascii?Q?/xZN9D6mjfr9aJSrSPXfhYDfJjTIOZXgmvjvZogA+cGAhXXrZ9kunVW3maRl?=
 =?us-ascii?Q?6g7P1KrmDbhvZqR1NJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:23:21.7349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31e2461-e5d9-4ec3-6cea-08de0fec9ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

Adds support for ethtool split header selftest. Performs
UDP and TCP check to ensure split header selft test works
for both packet types.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 46 +++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 16909c98bad4..a99ee37bc4ce 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -337,6 +337,48 @@ static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
 	return ret;
 }
 
+static int xgbe_test_sph(struct xgbe_prv_data *pdata)
+{
+	unsigned long cnt_end, cnt_start;
+	struct xgbe_pkt_attrs attr = {};
+	int ret;
+
+	cnt_start = pdata->ext_stats.rx_split_header_packets;
+
+	if (!pdata->sph) {
+		netdev_err(pdata->netdev, "Split Header not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* UDP test */
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = false;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	/* TCP test */
+	cnt_start = cnt_end;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = true;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -346,6 +388,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "PHY Loopback   ",
 		.lb = XGBE_LOOPBACK_NONE,
 		.fn = xgbe_test_phy_loopback,
+	}, {
+		.name = "Split Header   ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_sph,
 	},
 };
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index f4da4d834e0d..a51498af4aac 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1246,6 +1246,7 @@ struct xgbe_prv_data {
 	int rx_adapt_retries;
 	bool rx_adapt_done;
 	bool mode_set;
+	bool sph;
 };
 
 /* Function prototypes*/
-- 
2.34.1


