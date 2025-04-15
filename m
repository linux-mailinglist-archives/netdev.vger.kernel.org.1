Return-Path: <netdev+bounces-183043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5BEA8ABE6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5FB3BEB7E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BF2D86B3;
	Tue, 15 Apr 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJMKQBKY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AED23F296;
	Tue, 15 Apr 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758822; cv=fail; b=jFgdT7wJEyiqQ+4tr0EldALvyDu6vT0iXvd1gd+kr4ZWBZf+O9Sao7RVolIALg56i+B8yRKh6rpDtgp+vQuuzQSy+aIy9rN1UKYLKGrfNsEDVFw98qw3tUIB9/O+2SHP5q0WXP9H7Pu+JmbFEozG1VCtzKlNZsGCsl+MObbK/UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758822; c=relaxed/simple;
	bh=Oui1b2zB2Jk6xHeQiO+dnDK0Wu+K8WUMmZfaP62Wdes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1SphuSUVyQTIESlI3zN6TZ39OPmOnxnqsFH2SeBGooVbbdIjcVMyAfvzZLpOXUWK39ks7f+z9U2Cv7GcHKdBckNxH59u+m4eQWzfQvJVSNQ7m8wsQ6H6sz/Wz6b48302Illw76yj9HBzYqfUfqXRfyoeXP7DEBry5JmvomTOmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJMKQBKY; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXFrw4j8H6zHK0RXfih4l2gGel6p3qQkRiCitIW36vyu/91IkOWWQigEYbvFY779ZD9kE0L25C+3HD2x+KoudNncIlVhyfsrl2vp8734+ONGRrJ9MN/FyVaqM9YzSuuFqCFYYnsTtXe/LFEaJAUAa0ckWg3/KOzLkbxeueajtxj7YyLtuca1+bJrVohwkUy7gPOQl2trQEYakmr6OEnxuwNTRFkvnpqGNNDkyeN60BJjlDRd1d7FpwiYMYSJnJMrwPWNXFYiemeUh2c0Q9hufk/TJDCbd8p8EIZE8v7QYLwow4n3nZV4vpqzhTE4npYq5sJJgNxKhl4x2FObSuOX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiQpw1fNoCHDR1CaOq2PQNqL9ar0m5QS1Jor0/qZOoY=;
 b=tJRKaL35Yr26rMGFBuZiRyHzQ6iJHv93MEBqQWQXz3tIo2rGkf+3JSzyRi85mAnn6Nh1DTZNSK8FW5JRjK3fdXyipsS1livR6GIk8hsWZIMyeVQXmCNrdBmdlIo4Ajci8TWxpKw7gOw4lbprTlv3PzSnlXnBm8cwY00b/3YI4fQ6w5UH301SlMw92T90RfSlp83inOl2oaUj5/nCrb+cEdUJV6SqsqbINp/Wh/5PaKadM/plRgExWUZFX6ml4rK6v4Aj3KI5bA5oQI8uACpa+rXuxJj0OqGRn5o2ywtueRA1tx6rFMuyWsTYhqahuIFqi3TlSUbd+dCbS6gVxnbXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiQpw1fNoCHDR1CaOq2PQNqL9ar0m5QS1Jor0/qZOoY=;
 b=GJMKQBKYWGYBJIIuBTxh077spDfJlZ4mlXRC3LWA8+X5YhAww1BQe74neS2pjq1dUhnfr/0gQtYDoi8/hMOCxdqQB6mtZUNm7U2FoDp7pBbxK/E1idghR9XQ2n5moqTUH7xhfx1kAj8Q+5xn7tjJZ3Prw6KO3zSMtJlrpxlA31A=
Received: from SN6PR04CA0091.namprd04.prod.outlook.com (2603:10b6:805:f2::32)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 23:13:37 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::1) by SN6PR04CA0091.outlook.office365.com
 (2603:10b6:805:f2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Tue,
 15 Apr 2025 23:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:13:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:13:36 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 1/3] ionic: extend the QSFP module sprom for more pages
Date: Tue, 15 Apr 2025 16:13:14 -0700
Message-ID: <20250415231317.40616-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415231317.40616-1-shannon.nelson@amd.com>
References: <20250415231317.40616-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 634b7884-6b84-4ec6-90e1-08dd7c73271c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQ7VQ47Fc0H5e+5mpWTH4d8Pw+wOrQGTtzatLSvUPg6HJGUBFh6BO8jm6V24?=
 =?us-ascii?Q?zj/6cgxCmXZ1P3LGit5/rVYs9K6uJLoAJ07gevSgCNjmNIsi5GclQyxm9RJ0?=
 =?us-ascii?Q?X46kAS9c8eLN1D/RkmlhPjcqA16/bmF4PLPnAxz42vI4hgWEkyhsnSVbHaQZ?=
 =?us-ascii?Q?vs9jBUsbAu+sQIse1RXKgfbVVPiTCc/G5rxQ9PtZxt4uXgc6LA4nY0gpcT6k?=
 =?us-ascii?Q?GbBx5jqB/lRIFiQcYsl8NxqM9eja0ZzDOicQ7A+OCeoZ1ysEhBKYOJQqOi4Y?=
 =?us-ascii?Q?C4fnB5nivp3QKvRAPp7sXwwfH7HGo7lGLDVYbE+kQadwzzEGto9oIdL86lbs?=
 =?us-ascii?Q?VZtKe1zzEuyRsDnfne0AXZ+topymVYaG9AcCYIxWc18fvvRRFUM8cjgNlJch?=
 =?us-ascii?Q?XILP5UYeO8mcGUiOIEq/Ef5+psxW22nNUqXxAQvrp3pS57AOehqKg5jXe8A7?=
 =?us-ascii?Q?pSu3IwBbZw+Kns+hx0ZGu8oeuRKlPIY5etfSLCqPuNTh9KHP1JqMSyIqX4ru?=
 =?us-ascii?Q?gka5ZftBuv9b0HM9wZwHtRPYueQUqrYrU2F7eqJieSfMykSQa1ke3SvYIX3t?=
 =?us-ascii?Q?+DmGljI+zsyLRYneiWLypmGVdo5+KeqM7NfESCevhA6AXiS5PMsx1W7fJisn?=
 =?us-ascii?Q?oD0bwS4uWJsExE0ZNJd/oTbKW7J4HYf60L0o2eJ8mE+z1pQWbkyc1eJTVa1X?=
 =?us-ascii?Q?oqSHMUMCcGxqPn09yG7Bjci5vWmzbZOwwTwl7jQ4W7ZCA1Y935z6vTmjQWnV?=
 =?us-ascii?Q?H27V6Hscy0/Rf2N2w2qq496WHqvbfmm98tBGYCtFs54GDRRRgzQ/UNLf4kOc?=
 =?us-ascii?Q?zR3mZNou/BTl7cAdpHRi/eygi35waz+iFrrrRCXyXIph8ps6X6W3B1v/SczR?=
 =?us-ascii?Q?b1cVCUqJManuIP7/brLzhciRNeXfyj8MnMlZNGp6XElrR+TKBm4PsMHZlg7/?=
 =?us-ascii?Q?u0yEf8Q4wyZM/jll7QZ6jhZO5HCqssCNOM3USpUf23+toM81y5SSsWprjnkG?=
 =?us-ascii?Q?j5fqBXi4UiVxo8rlbPNb84652Pu/aNA4z2ZTkCHc4V8KJaq968xGCwu8zid2?=
 =?us-ascii?Q?YBph8aK5RveZe+7MSFwbjHSlePeTK0sSn3d481Vs0pn+7eKaR68ggdzDtP2/?=
 =?us-ascii?Q?fTpIK2ClwHw/fomG6sqFELvtJ9/vyDQeFMA8ALDUk2OVZvw9ALAzzcF6ZchY?=
 =?us-ascii?Q?aNZHc92eODrGCB4Pd4Tld3fHi1Q712jc/xy3aPJhlMQ+1+S1/MaizJ2AIh5D?=
 =?us-ascii?Q?4H3G1rGx8CyolWHkbfkKSUaFbDbEEny4DECiQ3rg5G4mxS8RDmTxvKR5fkta?=
 =?us-ascii?Q?bFyuE0sshSkXcUr/BgrDAwVTHIYVGfpBHv4GjweIbVLF1tm4pXSSboO5a6B4?=
 =?us-ascii?Q?e5jJc5M/YUgNr/R6RB/WlecUQiZ8Tn7hZQp0mXCg5SCH+7AQSGubae22t+Bm?=
 =?us-ascii?Q?UzlC6uCZL9AhFsU7BtaU1Qso6rIC2KBqNBC2Dbv4DrAh3jA9XgyEjeUL2Xku?=
 =?us-ascii?Q?hQwV9oE7dGtlcDoAtjl4DXsJCVTEA703aEsn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:13:37.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634b7884-6b84-4ec6-90e1-08dd7c73271c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904

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


