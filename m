Return-Path: <netdev+bounces-230344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E073BE6C48
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AF63B0F11
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D730FC2C;
	Fri, 17 Oct 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N/x3F8CF"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FC30F7EB
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683676; cv=fail; b=bfnwLHGI07/nkAXQDXzWSuvYFJYEqq1M6rt54erdunh96VI/z+5Gk8wRwx79XhjEIzEPI8GiQoreV3L5I/YJvmp7vCxGTdxJ4CZpbVvwVMIOAnzmPn1oyOEFItVzXeypjU7wEjkWzwvK2J05sv+HSydNoauZWfbaU6PgUD1ioRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683676; c=relaxed/simple;
	bh=CLJ+UY9uyz/EYtj/5kJ0wLXbS7bjX7crZs8GZ90dmeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZEaNoJolbc6uuhSIGsQVw+pQZxm3dDOnMUsOQ2acJqudtX0CMhMHWcqxvTqDBI3IgRgFdGEWszu3mpLc9f6fSkMrhmtyOG7nllTKCSv0eiPtu0bk2lLiLj3/xFKKz/fV++xnZ6Fuz2FIBdXJtKAJ97dsaa7F5YKkdlX008ZK4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N/x3F8CF; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvrqKyish2KEHYf/i8Xoxm5MoVCeCqsl9Ui0kOc4x4w5vcCeUdRJ7MBRntign96WXroHOJhKWUQ3hxzd5LfXwm30FaHgnPyHb34dARoQ+t22WK3k5pOnb88nfnCds9ci25CGGUYRzEZDMQ5VnT6NfaY8wpNpgz5gAaPxhW7EdBMB62EFmZ7VrFnV0U7Cm0ooGM6ZLcX/UY2TJudYW9kaluZDPGPAzhu7aKdNnaVr1/xt4fvIL4zLGMJjM8YzjBSwPQjf5B0Ok06wssd5dxnzBuVwSm8qajQco9BrZOmuPux1dOdeFYvec/bu4Ia562qKa1BoQKXDwkD4O0UlQZK6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0u2ikz1giTc0Sq5nUqmbSQ2Kh639auPPbPAR3/LR3A=;
 b=FVhY91a4/XTPsPLmWXAVCKgJMZUM1rIixonnu/nNShrxtPPvrCwh3j8mvB9xDaVdeCSkMOEtnGcDHBKnWuOgAfNSzz/mGEm8djrYaS0ky+x/7Qg6Nj+Ip0mCgUTUYCQruyXn2RV2s2BjQuvKftSC97MQ9omhQcR4XqueH9iFEzByJE25pY7U8MWA2Gu2MIEZ6EddL31prxkfO/u6i7X5ixDDkMWzYxEw6hOSsloC9zG3Eq62XpTdb+YffXPZXV5y2JyrNc09/acgq4nCna4/XlQghz3BLWAEOzjxJSk79Nmx+46JXryObLyp4nmkeOzJpznICDC4BR3cBVYudnU45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0u2ikz1giTc0Sq5nUqmbSQ2Kh639auPPbPAR3/LR3A=;
 b=N/x3F8CFWBp8Lj5hzoBdT5oGZOVolE26tOIV+ZK/33XC4J7w4z1WhSEIFKYROtV7TkOIRN+7HrSEbRdnzuD0gS+Wu0ZtVUwW0UwKnOzTRcJduK1FjFa0JkVujXyyWMsHTxM3We2egwpnv4Wvsr+HMBrCMTnSYBc5B7yVVACDNQM=
Received: from BL0PR0102CA0022.prod.exchangelabs.com (2603:10b6:207:18::35) by
 DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 06:47:49 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::fa) by BL0PR0102CA0022.outlook.office365.com
 (2603:10b6:207:18::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 06:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 17 Oct 2025 06:47:49 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:47:46 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 4/4] amd-xgbe: add ethtool jumbo frame selftest
Date: Fri, 17 Oct 2025 12:17:04 +0530
Message-ID: <20251017064704.3911798-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
References: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e8cd25-3a2a-4ea7-9393-08de0d49167e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?inZKOimaGR/BPI9znYMgrOKfriK166lqBfQJlFkPiBOtgUVEB/hDQIVSvRF2?=
 =?us-ascii?Q?dp2oGb0W2FBxz6oI7fSxZNfoNxh7fpvreF6rI3Nza0yrT/z9mGt6TTACXMRF?=
 =?us-ascii?Q?3GXta2QcWHHRrsZVIhK4hiZVMYwE1QGYnY/vOEGQn4jUkW6Er97YuagIvM13?=
 =?us-ascii?Q?wg54pp+QfPPnEqXwx3u4dsRom6no8d/q6hGDjH6rmfj/hExn5bfgrgYP4PNd?=
 =?us-ascii?Q?EPeg3QwGZhkdJlB4hVFzx/stpcrWhX2HIrDUIqM4dGplMa6bmdeOIoTxvI9Q?=
 =?us-ascii?Q?y+hznWarCe54Rrs/XdKeQNjsv/bGtaIMcvMZjBDoC2rZgmSAHckfgGqiTciA?=
 =?us-ascii?Q?Zw1eyvHIa9tELjc0iMxJhSkRy6l1a+2BSOI9Knh6m8QgTVSj1kimE971qq6B?=
 =?us-ascii?Q?UagqqxG2DTQ71FtjcCPSlGJz+qEQrFLHasejcWhbDFNA/Su0xaRyKZ5qAWzG?=
 =?us-ascii?Q?0S/0AtBFTatQwQZIhc3TJVtRUjL0rczeD7xa//hYN7jCG3QzxvJx/RQV8p2V?=
 =?us-ascii?Q?QacLhltDCmav3kvono1BmOryizNg7nVuwjcawo1mBdsv/LOWRdfjaG0m1FaJ?=
 =?us-ascii?Q?NToieLGX/l3gg9YTjeHWhlZhAe2GVAAp9iCqyb8fp3lvXHxh2id6cHEhXJPc?=
 =?us-ascii?Q?rWSJ8bsy8/rTJKNV9xKyTsZWcVXO30fO9R5utEfajYSjHBv3dKWnsYtM565D?=
 =?us-ascii?Q?HNfxUqEEjreB4c7yOu+nr1Pao9KZJTXdQdtzdATLZWm5X975LV0B11ofr9sR?=
 =?us-ascii?Q?+M6jlGV7ngGsU4Kyw9ePweZSQaKnsfEpOVZO4TvV6wDhsEMuBKsdfC/Uq5Xr?=
 =?us-ascii?Q?dgRt4ZyLJRc9qzX8NRnjFmBJdqXsHHMNrZtmSVuBx9oo7hj0veN5ZOHiHekh?=
 =?us-ascii?Q?qKLK9hUdY4pu+Av1Fb48qJWNcMn4gwlrRnAwh4LU6d9Lmd+YkrAvsWZW0Jye?=
 =?us-ascii?Q?5h2oWMiesx28zqQ70FNKFAJreLO3Y9K65oNQ0JzV8d4Bck7OHh/Mwjn9aKFh?=
 =?us-ascii?Q?rQKb+jK1z/teirRSBJKssPA//dsU8Ci6k+RldwASI7caGQTvgOp9V2z6YMRC?=
 =?us-ascii?Q?IRQgDkzv6mJEAyipg++4vzc6OQ9JAeVmXjpMH1VLpEEOvp82B3fh6qio8z1P?=
 =?us-ascii?Q?zgW+SIhmOa3gnSVvKzHiLzhoKFFHeinZvvSoirJXXKe6yinfbEYtktK+BN06?=
 =?us-ascii?Q?MFHP0aEzzd7a1N8xoyub09sTDVVb2KvMQ41N71CU8RdY37cCdR62Q/3rG89l?=
 =?us-ascii?Q?gopTefInH7QBq/jueEJq/9GT7qN9unop67MFG1r70Vo40PwH3MdTwbulIEhc?=
 =?us-ascii?Q?LsKqG3qwggGCTsfQrpInNtqOSyL1CTx3fHfMi00xDrcgRAq9qeOAlhsEvmXe?=
 =?us-ascii?Q?yf0P29Cmq5qlaYzA1d2fjc7ZuRiVD5joRTKEBYzD0UguJq9BwcnB5F27kS5h?=
 =?us-ascii?Q?0JjpUnkV0SRTaPIIjjUn6+buvsO/9w0+V9cjMrz4yMfju7uPxLWkksNCo5qo?=
 =?us-ascii?Q?J/NbQ3WATkZesIfkMESmOa4pdJ6rAlQ0pl7cWpO+/sn68vpDph0cywxBjejq?=
 =?us-ascii?Q?E0TIuGE16jfxoSSrKLg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:47:49.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e8cd25-3a2a-4ea7-9393-08de0d49167e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index ae7c8d6aca61..717e03040420 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -199,10 +199,18 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	struct iphdr *ih;
 	struct tcphdr *th;
 	struct udphdr *uh;
+	int eat;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
-		goto out;
+		return -1;
+
+	eat = (skb->tail + skb->data_len) - skb->end;
+	if (eat > 0 && skb_shared(skb)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			return -1;
+	}
 
 	if (skb_linearize(skb))
 		goto out;
@@ -371,6 +379,17 @@ static int xgbe_test_sph(struct xgbe_prv_data *pdata)
 	return 0;
 }
 
+static int xgbe_test_jumbo(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_pkt_attrs attr = {};
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
 		.name = "MAC Loopback               ",
@@ -384,8 +403,11 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Split Header               ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_sph,
+	}, {
+		.name = "Jumbo Frame                ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_jumbo,
 	},
-
 };
 
 void xgbe_selftest_run(struct net_device *dev,
-- 
2.34.1


