Return-Path: <netdev+bounces-181745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770AAA86563
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7FE9A72CE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC2259C9A;
	Fri, 11 Apr 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="quS501AE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172A2594AA;
	Fri, 11 Apr 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395725; cv=fail; b=CiMMOChj1p3Tfky1gRLLnu+57mwXG1x/rymsrvwuQiowuhCmjf+J75JL0BK9GOSk5j+g8MVOu9GWvFXqXVAMno1McyRwiUbI9xmfmR6Z6duIUMzIYKQ2fhe6bubTCO93dWFq8Ab13sma2buv35fLMqmyCDiig6Dj33jgbx51DZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395725; c=relaxed/simple;
	bh=Oui1b2zB2Jk6xHeQiO+dnDK0Wu+K8WUMmZfaP62Wdes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjuRwfQU0MFxdZO4jdMm/WXhIZMNSJXyBB9jmtwXejtqj8DfHWbPIzOMhfm4I8MX/2vyEjVVf/8R+lPB6OIH4WGlIxKnrMLgRC9KvCfhT8tyfbI5iBTnIHt5PYXEol9cFwHZB08RTmhg9UEGphJt2vgILreepySpHc/2kdPxcBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=quS501AE; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZbDM/joJ2BT95NR3FESWbxYPllaiibvvqcoV8nSwT9p2YPCmym5i4gyFwYFKVgT6tWOQwLqvNZhnYE9/fg3Pyz21LLSj9ucQFyu8COQ3emIBM+UFbHQvE841mor/prY/N0ut3W79afCrDejnOQDI/brzwC1YtEyKVAW8ymrkWpoOB/iC9Gox0ouIXFPOZEYBvhVrPItt1vcvdnl9zvaENpAyduMmGjW/pwWweMjSUOtENP3u6etaK4Fk+JevyH0XxbECxtczlgsV9lTZu8YzREuKQ9yC15JY72bHJyWsSV3c72U6k8e6HF9So0kH8xy0gbgxy0Af/nq5ub5qfvYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiQpw1fNoCHDR1CaOq2PQNqL9ar0m5QS1Jor0/qZOoY=;
 b=kYsIm397t6YwHSGFOV8ICGDjTtmQNfayG1qarGPf5glhERkBXemJZFT6BuHhEZ4Ku2t/LFK899Ddh9f7nw/I4X+7K7TEQ0CnN+gpy5tqi4r1Gx4K5tNsx9Z949KIoCnOcxi+qRKZhZkE/jkQVFFiXVEjgERSGJGqr7JHJNiPJJkw7qhvXrfVXl86JY/shEcxCHMpfgy4wrxwpI5jqhX1zvbjTN2rMWVbsqe5AqIpatEs1QBX8sWlTqCcQ6lNvi8CfjlTDjfeQsivu5PmwS8eJHNHP41D6EsQpnbQwNZQIszkWBhXPJiHdpIOgpYqBeNM0TVPxOlI4ey8K/sYwek19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiQpw1fNoCHDR1CaOq2PQNqL9ar0m5QS1Jor0/qZOoY=;
 b=quS501AEQfD12cyiOTTUxzF/QLUNZKXcefQMd3nComu5+dqB3OR/Ws9lBgpkvUZU5EdqyJ2DLvDneOzlz8wke23e2U48Gk3bJujfS4wV+aM/BBEsy4X9kBzWGaXxp+o+utm69pYFkI/VBEoBjGlCBLFbaJ4Dc4PbCs+YmZyBL+o=
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 18:22:00 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::f6) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 18:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 18:22:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:21:58 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 1/3] ionic: extend the QSFP module sprom for more pages
Date: Fri, 11 Apr 2025 11:21:38 -0700
Message-ID: <20250411182140.63158-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411182140.63158-1-shannon.nelson@amd.com>
References: <20250411182140.63158-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 652247fe-b165-4bc8-5383-08dd7925c054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u06GN0ha4UUlcUbU9mAcjX7h1bCiV3oryBtmrxpzbJY6XguHCwBBqvqLGpzz?=
 =?us-ascii?Q?frS/SxHO5vq6oGfUm8tVVS403V4UqN/IHkIARf6k1B2Uq1ZWktonNuYGxFWt?=
 =?us-ascii?Q?44wT4umgF0eJ2hma8+b8lCXceRQOHmBY4xSU4fBpe5Dfysllse0TIqL7vZN+?=
 =?us-ascii?Q?Th/6oFX1Z7yRCLco9N0dC9RFTMw7NLaCph/0suDED3vre1wUAfO8Fm/hUzWp?=
 =?us-ascii?Q?+H9puSJKskEbgH/+JhviIoOiy+mOWm8e9ycpSVxvopVH51ju/JSK+7H+DF4w?=
 =?us-ascii?Q?lQ5rnlBSnTP/p4IMGlaf+UK+TxjML+/pdKejnCMkZ31Dcg1MF2umqG+6U/sU?=
 =?us-ascii?Q?2Ep5CfDufa5AVsIDr9384+nxMGLb3unYQ/IRniJRUQqyUAKdCG+EKzJrmTUo?=
 =?us-ascii?Q?p7zzvGlu6uQ5hlJx+oZOP+7rqPIy7XraWUQuk4ewHUUHu0s6f+jzH7SX6vgy?=
 =?us-ascii?Q?UC4qk27srVPTr7JN09J26G16svtrMgaXSlcvlKiMoidC4OnkIcsygwyafX/5?=
 =?us-ascii?Q?udz8dQuDz+TIALSzmuqT2AXi+/25ZfR0673hu90sny0Jlx/NjlK7mgYqk5Wf?=
 =?us-ascii?Q?QcECZSjF/WrJVSeRVWDpo4qFIXoUK1eQfYH0caiYbSYrqHhiJHSqFA/VvQwm?=
 =?us-ascii?Q?kub297W4LIuLQuJJsyotaDyY+FDOBgMsAcAnE3NOa18yJ/AtEd4foP7tuEno?=
 =?us-ascii?Q?b/1pGZLdJAS0whCuOb2aW8EHdDUB9SsXJfcNC2xGsoDIOesYmb6KUXnsUUTa?=
 =?us-ascii?Q?vv5m2RxjprQg+VF1Nrpa2tTcEJ63UbPekV4Or8RtY3tHhJRUVTLh2R6MltF0?=
 =?us-ascii?Q?ufWe+Md2VbYnwbVuCSJGxRdkOPudZ7qQTz/PMMu2lTe3PMt5WXYgYDpF4mky?=
 =?us-ascii?Q?/XDOclEfjHZ2VTowtl36nR7wDzFkx1E4Hyxw57Sw+jiiaIWJaFv4qDyqOE95?=
 =?us-ascii?Q?sJlKaGIupPrpUtBwhZInzSQaMsxyxuYM1cHHAn2vUB4YzgpNvEDxjEjkeVrv?=
 =?us-ascii?Q?H+I7dRiqe97b0s/Q9/txibpMK334Pul98MhBB/0YkIJr+NDHnozNFN+7Z9GX?=
 =?us-ascii?Q?uctV2cmOlJUvlh0Yn3rGfXKBjL0hn0FfTuCI4+NJbqI1/0TwlZjtEzr/7rjV?=
 =?us-ascii?Q?bER7etHhsowXSvhKmsuw+b2F1h8nm17JVMwO+QaFGfwYO5cGkBJkpkcHQrGI?=
 =?us-ascii?Q?Fv04rGnTq99kcGG09I6MVo/r8EaP2UwraFmHS9hgs/0Qwj0zPPtyK6TgcDmQ?=
 =?us-ascii?Q?AstERK4lqdTMeDBp2nuMli7NOOdx0DCZ7BQDM3lRIVUNNNgCXRzrZKpOlHXs?=
 =?us-ascii?Q?H59gS+9qw5BP2TF0nxUjL6TpF++Yo8FO5t1q1iLHidokHMRLUL7AuM1ujV3A?=
 =?us-ascii?Q?QXEXQqktXqyh6kPw090i1P0xGF/9WzRAr1TRbHre3ZKXJXaPaseqaenXMVbM?=
 =?us-ascii?Q?g1in4LUXOeAEtV9hyACwKkJ3SkrdxpacZqaThjY0pLDgW1f/WOj9apl4wKBD?=
 =?us-ascii?Q?4u0R9biWkqgGE5Vaf1yYslouKkEnZadN8vbr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:22:00.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652247fe-b165-4bc8-5383-08dd7925c054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

Some QSFP modules have more eeprom to be read by ethtool than
the initial high and low page 0 that is currently available
in the DSC's ionic sprom[] buffer.  Since the current sprom[]
is baked into the middle of an existing API struct, to make
the high end of page 1 and page 2 available a block is carved
from a reserved space of the existing port_info struct and the
ionic_get_module_eeprom() service is taught how to get there.

Newer firmware writes the additional QSFP page info here,
yet this remains backward compatible because older firmware
sets this space to all 0 and older ionic drivers do not use
the reserved space.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 66 ++++++++++++++-----
 .../net/ethernet/pensando/ionic/ionic_if.h    |  7 +-
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index a2d4336d2766..66f172e28f8b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -968,10 +968,13 @@ static int ionic_get_module_info(struct net_device *netdev,
 		break;
 	case SFF8024_ID_QSFP_8436_8636:
 	case SFF8024_ID_QSFP28_8636:
-	case SFF8024_ID_QSFP_PLUS_CMIS:
 		modinfo->type = ETH_MODULE_SFF_8436;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
 		break;
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+		modinfo->type = ETH_MODULE_SFF_8472;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+		break;
 	default:
 		netdev_info(netdev, "unknown xcvr type 0x%02x\n",
 			    xcvr->sprom[0]);
@@ -983,29 +986,20 @@ static int ionic_get_module_info(struct net_device *netdev,
 	return 0;
 }
 
-static int ionic_get_module_eeprom(struct net_device *netdev,
-				   struct ethtool_eeprom *ee,
-				   u8 *data)
+static int ionic_do_module_copy(u8 *dst, u8 *src, u32 len)
 {
-	struct ionic_lif *lif = netdev_priv(netdev);
-	struct ionic_dev *idev = &lif->ionic->idev;
-	struct ionic_xcvr_status *xcvr;
-	char tbuf[sizeof(xcvr->sprom)];
+	char tbuf[sizeof_field(struct ionic_xcvr_status, sprom)];
 	int count = 10;
-	u32 len;
 
 	/* The NIC keeps the module prom up-to-date in the DMA space
 	 * so we can simply copy the module bytes into the data buffer.
 	 */
-	xcvr = &idev->port_info->status.xcvr;
-	len = min_t(u32, sizeof(xcvr->sprom), ee->len);
-
 	do {
-		memcpy(data, &xcvr->sprom[ee->offset], len);
-		memcpy(tbuf, &xcvr->sprom[ee->offset], len);
+		memcpy(dst, src, len);
+		memcpy(tbuf, src, len);
 
 		/* Let's make sure we got a consistent copy */
-		if (!memcmp(data, tbuf, len))
+		if (!memcmp(dst, tbuf, len))
 			break;
 
 	} while (--count);
@@ -1016,6 +1010,48 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+static int ionic_get_module_eeprom(struct net_device *netdev,
+				   struct ethtool_eeprom *ee,
+				   u8 *data)
+{
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_dev *idev = &lif->ionic->idev;
+	u32 start = ee->offset;
+	u32 err = -EINVAL;
+	u32 size = 0;
+	u8 *src;
+
+	if (start < ETH_MODULE_SFF_8079_LEN) {
+		if (start + ee->len > ETH_MODULE_SFF_8079_LEN)
+			size = ETH_MODULE_SFF_8079_LEN - start;
+		else
+			size = ee->len;
+
+		src = &idev->port_info->status.xcvr.sprom[start];
+		err = ionic_do_module_copy(data, src, size);
+		if (err)
+			return err;
+
+		data += size;
+		start += size;
+	}
+
+	if (start >= ETH_MODULE_SFF_8079_LEN &&
+	    start < ETH_MODULE_SFF_8472_LEN) {
+		size = ee->len - size;
+		if (start + size > ETH_MODULE_SFF_8472_LEN)
+			size = ETH_MODULE_SFF_8472_LEN - start;
+
+		start -= ETH_MODULE_SFF_8079_LEN;
+		src = &idev->port_info->sprom_epage[start];
+		err = ionic_do_module_copy(data, src, size);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
 static int ionic_get_ts_info(struct net_device *netdev,
 			     struct kernel_ethtool_ts_info *info)
 {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 830c8adbfbee..4943ebb27ab3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -2839,6 +2839,7 @@ union ionic_port_identity {
  * @status:          Port status data
  * @stats:           Port statistics data
  * @mgmt_stats:      Port management statistics data
+ * @sprom_epage:     Extended Transceiver sprom, high page 1 and 2
  * @rsvd:            reserved byte(s)
  * @pb_stats:        uplink pb drop stats
  */
@@ -2849,8 +2850,10 @@ struct ionic_port_info {
 		struct ionic_port_stats      stats;
 		struct ionic_mgmt_port_stats mgmt_stats;
 	};
-	/* room for pb_stats to start at 2k offset */
-	u8                          rsvd[760];
+	u8     sprom_epage[256];
+	u8     rsvd[504];
+
+	/* pb_stats must start at 2k offset */
 	struct ionic_port_pb_stats  pb_stats;
 };
 
-- 
2.17.1


