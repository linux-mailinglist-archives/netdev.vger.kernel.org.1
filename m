Return-Path: <netdev+bounces-209028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DEB0E0CA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BB6565C7E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B41279DCD;
	Tue, 22 Jul 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZrJfa2sx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF69279DC2;
	Tue, 22 Jul 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198892; cv=fail; b=Ut4UfTwMFI6z55G5ve7Q4P9az18/E+HCUSdr4aHDPcAm4zeVYqdA5VZH3KP2PrxHAaDB+W5r8EtkdN6/aNrsEN6M5E1uy6fhVomOxwrfoYmOE7HaMfiUhy0CMnh/FuHRS8lLtbhIV3Hb5S1+HQ0MSN2nDc9ruTgd1L1O2PTx/BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198892; c=relaxed/simple;
	bh=dRUJNEJDVXLOYfqRCxO7DMKYe3tH8W7/9yaCPcci8r4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+KuF/+J/B4TKkLrpRXcY+pg+E+kzjyj1L27NyKJrijdCvApx7xMT4WdhUQdaYVxT4EqHdUxl0O5CgqP10w30IbSzjsC9psh9XGIO24jCNWe5hY59gOKmyznIUh8yQN6ferHZvsA2XkYt/TfDeDJYK5NbgHYLfloQxrpNXg4SXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZrJfa2sx; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwPGfUdfEerLvbrrLJ6N0IZX4996HMFmDSh59fvnrT9wMXSsFpQrbIkK3m8UcLxmiHoqfBOYUjgbpd3wcYs3BcR60HwCNH6+g/VuzhNgPyCi/kzfZqPgs6sAimq8sEjLeWvnYoN6ykam94TN38cyjQD5FCrOYDuR+Jw55PuZ+ZyM5izlMiQZulXvMy1viW9EmQEEZey/Jj2qsv56g1GNZtOO5lepRTyL3E34AYeoVHffWKAZBN54+IvvBVc1oG8dNvM8uhZEQvPwqn0FFHEi0is6PnEld+5iT9XJx9rTuna/v8SfDYZCmrgO7kvFM/vHW6KVSJSioI8vGFB1mWk2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0YV7vGcDTQfqB/oe9FyO+7VtgmFnh5pr55Fs6ywPkI=;
 b=DP8jByPO+rgbyotfQsR83FxOnCmyRGGNUXznnkTQTz7MM3h0pCBf3EiQusYX6XbcxmKtus9KvF3LVENJNkE76a1s7JOoJJLE3V165nWsXEvUYIivZK6Rcy1RAt352iGX2xloOiCeRo1KUDwaJSBf5YPWX+2ozbWrd3nkVUKKwqzZ/9gW+lPPbmJdnYBJDBquBU5h90LOoj+GJA4AoCX9E5WwUUl6pHFX2DUDaHnWtf6x4GCBF76gmzYqMyp9QtrZvTxdOCC42Qed5TUe4loqX8scjOWo2FAUMF2+/yLCNQjBNNuEqgaMD7N1eXm8aqWF/tro2R7ODwwHUpZbsmrOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0YV7vGcDTQfqB/oe9FyO+7VtgmFnh5pr55Fs6ywPkI=;
 b=ZrJfa2sxDvCDmLYqysuhGHTVssxbzh7CywVx748dzGenlq8gzhqvLAuXvByAxlNbCxmqEBbSrrTfxduFKJqcvQnImrJuM6fUH1KPAoZoA4qoffALwGptd8U1cwAs73dZQFo0HWltdJ1RYWj8O4t3gbkgQVmLU2G+Mr1AAwb+i/s=
Received: from PH8PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:2d0::23)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 15:41:27 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::6c) by PH8PR02CA0006.outlook.office365.com
 (2603:10b6:510:2d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 15:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:25 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:22 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE command offload support
Date: Tue, 22 Jul 2025 21:11:08 +0530
Message-ID: <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 257b4059-f055-43ca-3ccc-08ddc9363898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kwbKCxcXvYvp1riOkLPB8x5MjMGlvt3jfbnUGH5hhIbXdop7pQXHMlVFUBJd?=
 =?us-ascii?Q?hmhhB+cpAgts/yIFZY529Nm+HJ/6emZUIc+RwuB9UIYrtgfsX//P8denS19L?=
 =?us-ascii?Q?B85ygVvpCuiVWmCvk39u8yW6dk9moLBYkTuJF/VWbmwqM1AiAChtekter0eF?=
 =?us-ascii?Q?pR8pA3qn+OzsfZHwfmTPJeGgEh9blIouIlY1pc60aE6ErVO6+Rv8VU04bxUY?=
 =?us-ascii?Q?7BVR585VRmeWfN+PaAHFDK31KjrWy4uKWr9ZocRBVOJbT55ZW9p8F9q+ZAKA?=
 =?us-ascii?Q?sHC6O4A2/zu3zJIFDkDULbO6TxFOwYCeqXSRxo5aOcLoP+BBmCGx2Df+075v?=
 =?us-ascii?Q?ROA77ZBxdS+ip2TTbFnzE+REcaHN6sy8vGtHsM4wMSFRbt5UAAgNWojCHe32?=
 =?us-ascii?Q?v0+roiNSfxUXuC95aW6dlXHpXo/76KZ+OR7EkBdgSG0vKu4C4USqhtmzZXev?=
 =?us-ascii?Q?lZXdAblnybIIeLQp+l1U1AqaKh7ZTACfvfVAAvpBBIEeM2RYiPK8bbSyJwz3?=
 =?us-ascii?Q?d2M0aJrPntXjiiY0PlCvRXIokeAeJOLGQj04dd/xSaFvq/P8c8ymGGfkUS6U?=
 =?us-ascii?Q?P9EEJodCRaTmTEKXh6fjK4VLRHBONUj2NKGgeaVUyu05Sfp8RW5VVhc7GIDP?=
 =?us-ascii?Q?xNOIXl9HKJqnaqpUjlMV7aBQXqvBWVAozpFUCVPh7wT2EtbumoNZRNpR2o6Y?=
 =?us-ascii?Q?E2DeGoRHMTEdRxdW7oKLonu3pfBDXhGBDqZZoVIQ8cli6jvFZgQYaFG2d3GF?=
 =?us-ascii?Q?U1t2k3gTBx7q+6RHrcVxSzSJ8lCG5tkoaD+LVla3yfzGJYXbyYpx97iXfnZX?=
 =?us-ascii?Q?Q730GtK5KQXIauao7UuyoQIcF8DFJr/3gjRFcHzmiHu4XT1sHN+Q4FBVW9BX?=
 =?us-ascii?Q?wRTnP8H12APPJoDBHJhSFuTI1Tp+W/qwHUxjzJelUnAn/tt937KbOAXSzTWw?=
 =?us-ascii?Q?/WxTM2UqlXe6irE3DDlEWRVnbgbJ9Ye7Y68EFGAenr16UbWncOT8VB0gXbtu?=
 =?us-ascii?Q?0ILTTFxF72106DyUCxoY7U1eY1zRppz5IIaif+dEJjBcAGlrdT4dGosfzJQU?=
 =?us-ascii?Q?fyWt4rqzsjfTqarCQS+dzc2GNYOi9NArfwtPYTXs89lOJGxrF9fJ3Ee9evF2?=
 =?us-ascii?Q?EtzS7wOB22xgKCg4RuCUXpoeGeI/6FYB22QkNoz98fLF3s0L5t7qT4duqZhC?=
 =?us-ascii?Q?l+cqZ2M+HnkDX4cEv94V7UX3hxzrnSSoG46foyRPxWxXL8f+3tfdsmdjlQ6q?=
 =?us-ascii?Q?bHxWgdcoYGrkT7C2NsbVRrXopZhKa+8oHAqm75R+tNP+IiH/PtADMlcKTwje?=
 =?us-ascii?Q?GgyXltnhMRfSxv93lbsYfPPdanB/cEHHvWi6Gp3qNhejM2yPzCIlmg+tyCDB?=
 =?us-ascii?Q?rBwGDY58ZDPUxB/DXgcT6e/F0V8TVyFVOlcfwqRtKSgpiyByNXka2sA8PsRi?=
 =?us-ascii?Q?4cSgvuicxcSQ0z/1RUKVR0BUtMCQG207s+q6sQwZqNoJkEeb5AX3sCNk6BxI?=
 =?us-ascii?Q?SKRW3m5CgB1xeklwK6xmNQ1ssEIs4ZPeFVbL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:27.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257b4059-f055-43ca-3ccc-08ddc9363898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

Implement Time-Aware Traffic Scheduling (TAPRIO) hardware offload for
"tc qdisc replace" operations, enabling IEEE 802.1Qbv compliant gate
scheduling on Cadence MACB/GEM controllers.

Parameter validation checks performed:
- Queue count bounds checking (1 < queues <= MACB_MAX_QUEUES)
- TC entry limit validation against available hardware queues
- Base time non-negativity enforcement
- Speed-adaptive timing constraint verification
- Cycle time vs. total gate time consistency checks
- Single-queue gate mask enforcement per scheduling entry

Hardware programming sequence:
- GEM doesn't support changing register values if ENST is running,
  hence disable ENST before programming
- Atomic timing register configuration (START_TIME, ON_TIME, OFF_TIME)
- Enable the configured queues via ENST_CONTROL register

This implementation ensures deterministic gate scheduling while preventing
invalid configurations.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 155 +++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ff87d3e1d8a0..4518b59168d5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/reset.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/inetdevice.h>
+#include <net/pkt_sched.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -4084,6 +4085,160 @@ static void macb_restore_features(struct macb *bp)
 	macb_set_rxflow_feature(bp, features);
 }
 
+static int macb_taprio_setup_replace(struct net_device *ndev,
+				     struct tc_taprio_qopt_offload *conf)
+{
+	u64 total_on_time = 0, start_time_sec = 0, start_time = conf->base_time;
+	struct queue_enst_configs  *enst_queue;
+	u32 configured_queues = 0, speed = 0;
+	struct tc_taprio_sched_entry *entry;
+	struct macb *bp = netdev_priv(ndev);
+	struct ethtool_link_ksettings kset;
+	struct macb_queue *queue;
+	unsigned long flags;
+	int err = 0, i;
+
+	/* Validate queue configuration */
+	if (bp->num_queues < 1 || bp->num_queues > MACB_MAX_QUEUES) {
+		netdev_err(ndev, "Invalid number of queues: %d\n", bp->num_queues);
+		return -EINVAL;
+	}
+
+	if (conf->num_entries > bp->num_queues) {
+		netdev_err(ndev, "Too many TAPRIO entries: %lu > %d queues\n",
+			   conf->num_entries, bp->num_queues);
+		return -EINVAL;
+	}
+
+	if (start_time < 0) {
+		netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
+			   conf->base_time);
+		return -ERANGE;
+	}
+
+	/* Get the current link speed */
+	err = phylink_ethtool_ksettings_get(bp->phylink, &kset);
+	if (unlikely(err)) {
+		netdev_err(ndev, "Failed to get link settings: %d\n", err);
+		return err;
+	}
+
+	speed = kset.base.speed;
+	if (unlikely(speed <= 0)) {
+		netdev_err(ndev, "Invalid speed: %d\n", speed);
+		return -EINVAL;
+	}
+
+	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);
+	if (!enst_queue)
+		return -ENOMEM;
+
+	/* Pre-validate all entries before making any hardware changes */
+	for (i = 0; i < conf->num_entries; i++) {
+		entry = &conf->entries[i];
+
+		if (entry->command != TC_TAPRIO_CMD_SET_GATES) {
+			netdev_err(ndev, "Entry %d: unsupported command %d\n",
+				   i, entry->command);
+			err = -EOPNOTSUPP;
+			goto cleanup;
+		}
+
+		/* Validate gate_mask: must be nonzero, single queue, and within range */
+		if (!is_power_of_2(entry->gate_mask)) {
+			netdev_err(ndev, "Entry %d: gate_mask 0x%x is not a power of 2 (only one queue per entry allowed)\n",
+				   i, entry->gate_mask);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		/* gate_mask must not select queues outside the valid queue_mask */
+		if (entry->gate_mask & ~bp->queue_mask) {
+			netdev_err(ndev, "Entry %d: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
+				   i, entry->gate_mask, bp->num_queues);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		/* Check for start time limits */
+		start_time_sec = div_u64(start_time, NSEC_PER_SEC);
+		if (start_time_sec > ENST_MAX_START_TIME_SEC) {
+			netdev_err(ndev, "Entry %d: Start time %llu s exceeds hardware limit\n",
+				   i, start_time_sec);
+			err = -ERANGE;
+			goto cleanup;
+		}
+
+		/* Check for on time limit*/
+		if (entry->interval > ENST_MAX_HW_INTERVAL(speed)) {
+			netdev_err(ndev, "Entry %d: interval %u ns exceeds hardware limit %lu ns\n",
+				   i, entry->interval, ENST_MAX_HW_INTERVAL(speed));
+			err = -ERANGE;
+			goto cleanup;
+		}
+
+		/* Check for off time limit*/
+		if ((conf->cycle_time - entry->interval) > ENST_MAX_HW_INTERVAL(speed)) {
+			netdev_err(ndev, "Entry %d: off_time %llu ns exceeds hardware limit %lu ns\n",
+				   i, conf->cycle_time - entry->interval,
+				   ENST_MAX_HW_INTERVAL(speed));
+			err = -ERANGE;
+			goto cleanup;
+		}
+
+		enst_queue[i].queue_id = order_base_2(entry->gate_mask);
+		enst_queue[i].start_time_mask =
+			(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
+				  (start_time % NSEC_PER_SEC);
+		enst_queue[i].on_time_bytes =
+			ENST_NS_TO_HW_UNITS(entry->interval, speed);
+		enst_queue[i].off_time_bytes =
+			ENST_NS_TO_HW_UNITS(conf->cycle_time - entry->interval, speed);
+
+		configured_queues |= entry->gate_mask;
+		total_on_time += entry->interval;
+		start_time += entry->interval;
+	}
+
+	/* Check total interval doesn't exceed cycle time */
+	if (total_on_time > conf->cycle_time) {
+		netdev_err(ndev, "Total ON %llu ns exceeds cycle time %llu ns\n",
+			   total_on_time, conf->cycle_time);
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	netdev_dbg(ndev, "TAPRIO setup: %lu entries, base_time=%lld ns, cycle_time=%llu ns\n",
+		   conf->num_entries, conf->base_time, conf->cycle_time);
+
+	/* All validations passed - proceed with hardware configuration */
+	spin_lock_irqsave(&bp->lock, flags);
+
+	/* Disable ENST queues if running before configuring */
+	if (gem_readl(bp, ENST_CONTROL))
+		gem_writel(bp, ENST_CONTROL,
+			   GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET);
+
+	for (i = 0; i < conf->num_entries; i++) {
+		queue = &bp->queues[enst_queue[i].queue_id];
+		/* Configure queue timing registers */
+		queue_writel(queue, ENST_START_TIME, enst_queue[i].start_time_mask);
+		queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
+		queue_writel(queue, ENST_OFF_TIME, enst_queue[i].off_time_bytes);
+	}
+
+	/* Enable ENST for all configured queues in one write */
+	gem_writel(bp, ENST_CONTROL, configured_queues);
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	netdev_info(ndev, "TAPRIO configuration completed successfully: %lu entries, %d queues configured\n",
+		    conf->num_entries, hweight32(configured_queues));
+
+cleanup:
+	kfree(enst_queue);
+	return err;
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
-- 
2.34.1


