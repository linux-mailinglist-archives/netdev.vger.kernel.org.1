Return-Path: <netdev+bounces-229353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6583BDAEB1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6E2C341FEB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0A3074BD;
	Tue, 14 Oct 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnt8ageJ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929227F01E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465554; cv=fail; b=ebTqGc6wXnRTUIePNZ6jzKittIwekqJNHpfxerdR5cMiIaBe70YhWA6hVWQKa6xKJvvSmkGASRMSpndXvrjIway9UQ4w1eOE/QHdzCjieApk6iToXzfsHhU396n2VOgTJrRDhdKDYXEPkRSCsTK5fBRVcVuY0SDFE8U+W9//Sf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465554; c=relaxed/simple;
	bh=5vs3pTXWqKEEYM6VhEwJKBe223PUVRNAZBi230tDbK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5NugsovOKNSsneJcG7X4TzsmS9umJWSvuUH9DWPXG1pgwPXvkPtThi4vdAcZL77m5FqECbFVbCkLoB9mVFVrmC/X9NYpBCSZo8xZqbdfEmtxZKuGRQJGGtYlrwDBgrsd2x8jPzA2NhvpGICtMs3Bfjn3l+Le2Pq17nBseGXSYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnt8ageJ; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtBpeg9VC/9DRFsFayKaAoj1MlqHfatM7rKGzByPTAsOt8Boyrgop2YxSaSkSETYa4XvRKhIsY+Cjd+ndRmKWhtx7nYzGdkrpFdnNyV6NPjFZsmbbJXlzuo7V9KA+LC7NKYjDX/9XUWuiURegc7gBNbAKMxzqx/ojx5JrPzc12GEhLS+cDI30IGdh1GZq+ahm/x20igPDip7Gl8pdEe+FqeQQfrZa9p1+gMkYK53fExxXtLjcOoBBMkJj0pvyfTZjZQbNT2MKWsbb2PZdMpw2gTWT8TeiTKNsTXpEeAi5lLjt7Mog2Avb4eKyLriiqvrFDttLfvzHd9+v/N07+khVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MdWuqHdZ/1npo2h3FNf0M/HFx2fdf/13qIP/FYOLb0=;
 b=s+HCcE9ySfn5yXaaxh+ux2Yq0gfmwxi5yiET7GPp2NKiTs7F4ryhND+qCtRS/mylMtroBT+0gLr9F35gb388rMeEUHJVm4oxguLxsrDF7TI3d11E5AqrpqdA6h6hr1lt8esV0mzi1aQkbHMFQ/UQFelfHSrR7zqfiZU6gnaAgKQ/u665KTqamgp30XyYW87LRi1+3MWCNPdpKceuMQpi43+rdffCgJ0fltXT5+9pPOFfXr5rhgkua8gowfQB79NegZB9y9TV6aqDfIwoj2qgFYBwX09InY02k43ly3RTl2l2F6X3pNVZ3YKvwsLir2QTyFVi2BHGuum7y6dheyv66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MdWuqHdZ/1npo2h3FNf0M/HFx2fdf/13qIP/FYOLb0=;
 b=rnt8ageJtDpVM4ypoXLjzMHPoOszmZhSZq4mQlCYkCT9D4Yoa4A4pXBAXUGZZYPbv6Ml1lpBc3KeoyYvk+uB72B5OfxR7ziLxgVHNiK17noHX0ctVyIkfiw4pT7yjw70QRiV5DdaYoBK/OoGgrFPkRZKEYrUC3eS71L0TgXHilY=
Received: from SN1PR12CA0068.namprd12.prod.outlook.com (2603:10b6:802:20::39)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 18:12:30 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::2) by SN1PR12CA0068.outlook.office365.com
 (2603:10b6:802:20::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 18:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 18:12:30 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 11:12:26 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 4/4] amd-xgbe: add ethtool jumbo frame selftest
Date: Tue, 14 Oct 2025 23:40:40 +0530
Message-ID: <20251014181040.2551144-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
References: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd5b2cd-d369-408d-d7d5-08de0b4d3d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hELiWSgW5D4tW7yXjRigxujC6yirt6nMnx3CONWSTrVEYG6pxw8vxqGFwnos?=
 =?us-ascii?Q?2YHqO3kDGy9XmKw4b6WT456UEKqD60i581TJJTC1IM/Bhx1KgOLO+GAoLILu?=
 =?us-ascii?Q?mYV92UQNaYzXSk7jipQS86We6HKVUnpKum1Pnfhgig2lMR82eiCMJZIl5IA5?=
 =?us-ascii?Q?FQ2JMuuTz2+pmNMBrZ1z5IZ4z0lUk+89cweNEv/FcDws6hkgWEKoAY8iqmop?=
 =?us-ascii?Q?fLOpsJxTPFmvYmZ96ZCWjI7Lu73ZzkCHxxRWRmo2hN0oc8U+8b4EG0QUSLUw?=
 =?us-ascii?Q?1T38NpnOqBa0f3CpBrHWu/2sMConl3m7ULXq4woa57VwVoWBw6jLFgkg9LSt?=
 =?us-ascii?Q?1Hlkz+qvs7mq2UaWlyxRXprIahk+OCi7oazwr7gEtMXErfsDCEPaa5M32au+?=
 =?us-ascii?Q?vT3EnGn1j6wXQpTgdxmZBo452oPRZjBdq18VxA0Zqgft4ThunWBO8sg6h3+t?=
 =?us-ascii?Q?hOcbsxXeJBr+MR0VkSZ1Frf8egEXkrCj9Gz10O/WEW5Rrf35n+WL5e4hmMWm?=
 =?us-ascii?Q?NxpD4MXdc7rEZViwjKWrvaRzCApF/W/hOCCpVtuRHyYlFhAVrNB12bbdHkvO?=
 =?us-ascii?Q?jOE8x6nYakKm+MPrezvuO8ONSS5qX3UeL3dssS/ro1Gqe/zzVsixGudtbrf8?=
 =?us-ascii?Q?/V1YVSED7VDNodAfHrg9flua04ItZk1klh2CZCBwcEVneks3UigHbpHLN44Z?=
 =?us-ascii?Q?/l5SDSO58pGz09LZRO7O3be3mt5Qj/L3hewIjdikJfrdpN76a5M06LVAvfYo?=
 =?us-ascii?Q?5z4P/0DnI4FoN6Ds4Nv9C+lj4Bnt+9mXIjRe9QrT1aR+wJU4GruzDy0iA3Hk?=
 =?us-ascii?Q?lmuYqephMNZSqRbk3xgxlXzcfeAKJpXxdBnkqx9Nf01rdWSvNGKUD6/tzr1H?=
 =?us-ascii?Q?iklAO2zBI9/TvWcehSipm5x1jmPhX0FpakRgpl8v+HP8xmFGoeG97y1Hfe0V?=
 =?us-ascii?Q?4VQeFqCVmoObK0oLtnWPphGo3rLUJhLp1RgL4fjwnZjy5etcdpTY4kxN4g0/?=
 =?us-ascii?Q?x3DTATX1gDGchxGos6NcwY3ofWZaybd15mc99BeIUIQSP0qEkNEaZEclx++N?=
 =?us-ascii?Q?hNWIIRUHlwOD59EEe7MOtZs0zv3Ms0vjWUunKUMfT8bofqXNDgnJhzgW/FFQ?=
 =?us-ascii?Q?ls+HDm8kc2MU7l+DeQI54KTA8gx+aqjF7e1HOZreqVQv/c+nSwR2hp9t7itK?=
 =?us-ascii?Q?vN+if91+RluubmaQps3PTcRoJw9B3D5mwWtn5yYLNG10JyyLw4GZYW/slaIC?=
 =?us-ascii?Q?FcYEuTObUpFc3gwtIFH7vLa6wfH8xDMkcs9q6suXLqeNJgPvqLEXF4/B4AWD?=
 =?us-ascii?Q?Lvab/dgt9OElZqHeXqRHTRHRQviw2GwYMlAEO0qGKA07UJrnDNEzDcBw7RRP?=
 =?us-ascii?Q?dur9sX2Wr9hx3Qzd9BIXXwrYoLmEtBro2st+ouLRJA3prL1Khw+6VZLIZm8/?=
 =?us-ascii?Q?gGzxP2Mz4yI4oSeRndYyI95V2b7/pxdF9Wfdlv0S4AZiN+tXm99+iNMea4AM?=
 =?us-ascii?Q?8jfvSviSQI7TcXsslJ2zudmBDdDQAe8hOM544wns4331DeRK3DOt796A9gkR?=
 =?us-ascii?Q?y3Nn/NynLhGZOqrj/eo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:12:30.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd5b2cd-d369-408d-d7d5-08de0b4d3d38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 6175ea899f68..ff2c8a3b6e8a 100644
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


