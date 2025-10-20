Return-Path: <netdev+bounces-230932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54961BF2126
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D6718A831D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED44E263F2D;
	Mon, 20 Oct 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWEJfqfc"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E177261B8C
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973803; cv=fail; b=hzcooGzRwsAs5+4KzqctB4TJ9g2/TPY11K56w6P30Lgaw6p+F52fQQ1Gv3dGMY2Xk5pen0SgfjFvVS330Bgv3BvRpgCaknvAFsKi83FRb6Khbs0nGmIYJXLj5IheX9xo/A1fNQe1kA9Pl+rJH867SYLcGfOWy8pN9fLop5kX5hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973803; c=relaxed/simple;
	bh=AdQxILjdy0ICOs1qOhmPRA2zFXsLUXn1/fwQm8Ndg00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxDEGLaoZ57Ek5Suoy5ozykKV8vPP/mPsqiktJxrcc1EE7EJqWyzK+gkANePQuJlyjGYXd2BbeMWy7LhcJLVA9z8eG5qiWFv2FGJt2S7JlxpinFL7jpvOqOfaDbuqL3rklFQKcv7EQr3qacwH6uyLCHNCyhk6GvWd7O+mSBtpDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWEJfqfc; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcBZhc4Y++mo5EXFBLJfwG/P3GQZ+Hysk9jmJeJjolqubk7dqdevFCJKj6p7TRAqZW6HmtusRytjyCMe++yajplZQ5Q9z70k8gLieynNd5DEraatxqYqHIRwLBkdTDmxLv9V4wBrXfbNZmlLJGC7W2Sw0NokFB9SXp/G7O4uJjYEb8IaSYHLhYkIiKKyvniMupKTxceXakDfO/JHTchTyU5x2ZUfJQnV1QgDoihSmyTrXykAQUgUqbXCwwSsyc0P9W0U5Y7LSoDMAu5hUf6hXzAM5tGhONzHhWXJVDOLte/BOD6FuS42+U0iisjl+6gvJuIeWVTXInn74/7ZjUDNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyoAcy3cFzre3L3oQbWt2LaKWBIf72jdUyJdOfGAWvE=;
 b=A5tm6TLgwDVOaaYStxUyIlt2Pwiz+Ht9me5F5zdp3vKAXReBE6Kz6P1KVl2kxshn3BACYP2/CDPamVXd83IK3cH4E7v/3bTt8furnfdrXdajkT7l7vOUoimvUPbBmgPPpdV+ApGGUztce6jgGHh0F7ehn/+PwQm2SeTrvYEv3/L51a2yX+UjatutmIMbbYXmqFHcXtS6hWiGhbFvbRyaXHID8qQddNapFeiEwDhrhHSSd/9/V0v2zIcrxyHWxZrZvMZw0/uKPTjpy43RiUJcpthgDX9q18s0fxfSCDBBqLqBgWuxiF69wz2ao/lUsl8xZPxMv+tNgaaKCtPzJGt/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyoAcy3cFzre3L3oQbWt2LaKWBIf72jdUyJdOfGAWvE=;
 b=GWEJfqfchKfvcYH5BBM+v8KK3oCIiai9+i2lMGOU5I+Lz/aFghQJwpuNbpvMEFkWTG+pbkkEzz5SDKZubpggVmnO9+LeIMpv6B81PhH486oUrpX0oRkH5LtXntSD7G/xyv7VQ8FU3H/BvP2CImeTC3I121G7FrsX70+PelJvHo4=
Received: from PH7PR02CA0030.namprd02.prod.outlook.com (2603:10b6:510:33d::24)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:23:19 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::ec) by PH7PR02CA0030.outlook.office365.com
 (2603:10b6:510:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 15:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 15:23:18 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 08:23:15 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 2/4] amd-xgbe: add ethtool phy selftest
Date: Mon, 20 Oct 2025 20:52:26 +0530
Message-ID: <20251020152228.1670070-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: c3903f8b-c265-4afc-3082-08de0fec9912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+BR/rC2bvN+qsYbuAtMR4Y8NvNzlWcS+mGYNwbJ4NXBN6g3L55xrBRhCO59l?=
 =?us-ascii?Q?JQyeFBV/qDv1RecGlMMwIoWXxpwp6ODkF6VE9kJjYYBegOHC5d43Dk8M9jLy?=
 =?us-ascii?Q?ahuxO1+ROJ+t2GTx/dEQwmCD1GvY4So+BrSnKMuB12Toip6bi3IfkbaONKXC?=
 =?us-ascii?Q?8SYgXUiPx/GShuMqWL81VVQ8Cf0ACZyy3ZO1YcaXrhW2OGv+hM2xcrUaxshF?=
 =?us-ascii?Q?iEfpbDNEaF3b4qSOY/RRB96pkmhhw0gHAdjQvSg0ozvMJim8SWLSMnZdWU+W?=
 =?us-ascii?Q?/7luvUVEAIOwACddJk3n79WpisNgePkwiG293SCRTbLnkqpHZUZa9x4caPj5?=
 =?us-ascii?Q?iZQ9MnpFRkB/dNg60UqlJjAFltIJtkvPOfyWz73oPUFcX0BE3jcsDrhe1Hx1?=
 =?us-ascii?Q?0iqE9lcl89AtImiOuXoTFJaHaX0iz+gigW63HvE9kuYmnABmgcvYGbOhsnNX?=
 =?us-ascii?Q?ptU1V4yJVja1MYIBgtGgX9+L/UO//jVEKMuQYdTOT0tcb1S52VO9qJRTC4cZ?=
 =?us-ascii?Q?uPfK33d7hqaMUoMrF9C+06mhcsF5gWNSYQsRkn6hyD5gQIS7QQauHofMLVL+?=
 =?us-ascii?Q?DwatcFCFa+Ao4eUwp3j89gQm8WZruQww2VWKicN/1re0ajB43Ph+fD/2FZ/4?=
 =?us-ascii?Q?hKw/IIYuEiGzAZTUNcroOKnhmhuzNcUBZW85IfuybaORzI2PmlXdHUZxVkw0?=
 =?us-ascii?Q?cVyyEMyjfqSaf88uuDlfI6Gxr0rbA/Z77Mo8vYmV9KuF9R1+pjOBP66FidE+?=
 =?us-ascii?Q?iVzGBqiNlKd5Sj/FasKunU6F/SS6ANpgIu/WBJ8vKuGn+N5BWC8crTHEQ0M3?=
 =?us-ascii?Q?/R1boMozTKJuX0nNCTl5vsL/BWdWacbSkQw14kkD0tQDl+d0Dyr/hrUuX3zz?=
 =?us-ascii?Q?XYBJyISRwwMdjyg/znvMqZMRmMP1nCatTuQVxG2GSdWDWkey20ocayBfMVzm?=
 =?us-ascii?Q?LRVsJvW0g8Sd09zYFTYWm5V2Nzhx7SBNyq0RUxJe7+sfSapYz6V7Ggm2uDqi?=
 =?us-ascii?Q?6oHxEg9FijSz+zXsGAPiWGEA6CrmvPgMbBmXirQn8u8oTOXXGRqUV6TQ6c7l?=
 =?us-ascii?Q?PXMLUIpnLIUBphcdnCTTE9xXRiSw/+Rt/XRFee5HKYcxVxWRDNFqrrkqeDLK?=
 =?us-ascii?Q?H2bKiw19klugqw6s2AA9FcvuVB9E+SJsD9sfd8N52ey8kKnPhyImABY13mCi?=
 =?us-ascii?Q?QwDlIG9FC9AiqzMf82xYdIgAP3EA/psYqYLimM6vaV5slEKcxcOR1XDR4304?=
 =?us-ascii?Q?R6z2vXwNwBsh7EaZp/az5+hKkXn81L+2NRolM2ql9+rIuNfIx7yfOV1bk+gg?=
 =?us-ascii?Q?82JNVPvLKR4c3HSqaIUnQE9rmpPW13+hoMfiq0rCHBetrxcgm6geSXk11Cuc?=
 =?us-ascii?Q?y4e006wtzGq5C7F35ehn2chNF+jSFLFIBvqZI0Pt1b9inGq8Eop4b+m2ufXr?=
 =?us-ascii?Q?gbxjRR/kisC7LzeejwG/uuB4zZmt5tIHbQ9gnxsl1gIQ5cZQaeCKfpbCAEPl?=
 =?us-ascii?Q?tG5ywLLgqpj/tMTU4HPsM7mycFh28ZxQ24A/KzCKhutONdR9BBIjsRzjnHFZ?=
 =?us-ascii?Q?TSXxSvrvCtACPtWUyQg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:23:18.6653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3903f8b-c265-4afc-3082-08de0fec9912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099

Adds support for ethtool PHY loopback selftest. It uses
genphy_loopback function, which use BMCR loopback bit to
enable or disable loopback.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
 - fix build warnings for alpha arch

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 54a08f5c4ed8..16909c98bad4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -25,6 +25,7 @@
 
 #define XGBE_LOOPBACK_NONE	0
 #define XGBE_LOOPBACK_MAC	1
+#define XGBE_LOOPBACK_PHY	2
 
 struct xgbe_hdr {
 	__be32 version;
@@ -315,11 +316,36 @@ static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 	return __xgbe_test_loopback(pdata, &attr);
 }
 
+static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_pkt_attrs attr = {};
+	int ret;
+
+	if (!pdata->netdev->phydev) {
+		netdev_err(pdata->netdev, "phydev not found: cannot start PHY loopback test\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = phy_loopback(pdata->netdev->phydev, true, 0);
+	if (ret)
+		return ret;
+
+	attr.dst = pdata->netdev->dev_addr;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	phy_loopback(pdata->netdev->phydev, false, 0);
+	return ret;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
 		.lb = XGBE_LOOPBACK_MAC,
 		.fn = xgbe_test_mac_loopback,
+	}, {
+		.name = "PHY Loopback   ",
+		.lb = XGBE_LOOPBACK_NONE,
+		.fn = xgbe_test_phy_loopback,
 	},
 };
 
@@ -351,6 +377,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		ret = 0;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, true, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			ret = xgbe_config_mac_loopback(pdata, true);
 			break;
@@ -377,6 +410,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		buf[i] = ret;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, false, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			xgbe_config_mac_loopback(pdata, false);
 			break;
-- 
2.34.1


