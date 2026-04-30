Return-Path: <netdev+bounces-282799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEV+CCw882mFygEAu9opvQ
	(envelope-from <netdev+bounces-282799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 976314A20AD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A0630131D4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621D3F0A8C;
	Thu, 30 Apr 2026 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BWYg6a3j"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF983E717F;
	Thu, 30 Apr 2026 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547863; cv=fail; b=TPTqdQaY7OP6J65HwgE6oORuyG9Now5OpmdOjq3OC7U4ocLmpN3o97LqDDBJoz9EUtdTm2FM6XdeVIPj0ygmiiMdiBct8oJWnWIwgq2Pgx6eHNPCeFM+G2DQkeSUdNKmIRs5rXftRFDToC9Evx9lrM4GpzDcK83nau2MR6F4C2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547863; c=relaxed/simple;
	bh=LM5BVsDAqtfujOtXZ3OT1UDjgSlh4yPBZpj0mX/BHMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WM8VqzkAHDVa+49EQpoFC/LM5futHES1iPcZyYXjIpioG0oodmgt7CzKo+IyUUeSSupo4Yz9V+NxeGLnO6mV8RZvnI9Vq4x+IjYSy+YE3VNHXdvc0MpJMLum+f80wEk3lcZFO/sCpNGiz1fhSIbUBJGBGFNu5Qc8bfZV4EEXWSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BWYg6a3j; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyndqoW9ngIu7ZX0V2KveEpqfI5AjTB9JAQc2z8E+BZqnyu4MjuGsdDew6NvyHSRXuwapeQEU70Wvonq6l3f0bRjAScHzEZ8rvrb/wTcd68KT0fG/gJ/7wSDMqqXPo1s/PMnbIBUj11DsBt8p6nyjEPm1eMw0OXdbBOCAwERavUUZpWHWQtM/jnsncBiT2wyLLlg4QlP9V4NLWbIshOpVdNKGtE0Hq03AbBqiDfUN5Ka2IG3wJkDZbCD/2gap5devcZ6DkYIwh1o3LXLgPeLP1TR1A/Tzi/jCJOh7dfk2dX0oTsTlVZrJj+e9/VNemtVxYsTwUcKlSoPOB0hqu/Hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRgxgyv5nll+HnAKrl7rA6TjK1HbJdnxpOZOlYaG/eo=;
 b=FRQHNOI7BbSXuGOC3aVf9vtalwE30YhPTxiYpEWyfAE5G7fjEQLaJBm0VWZOo5PChkUgEJBpL57BefVnT1ohU2MTfra1lz6yOcDgwZHT3QET908z9hsVn2nPwAjOR4Pdehs2Q68Lr6oxap41pTpq2RE0vX5QKTvmqhLMbqxmfEnlGzizRmdaL2dpaUXUQiyDiJUdWJhdu5+1bUJwjNlbAEP4bVdtC7/RwzhyTKq+V7w3NEd2CPRFZB9V8q4+drxXcCuEaiJR4YO/pJuo1FKZJDP1XQM9Irmkv9OsByfvYFxtKDsd/esqOPdCDPi8+1fI0HLWvtg+W4pACW5lISpkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRgxgyv5nll+HnAKrl7rA6TjK1HbJdnxpOZOlYaG/eo=;
 b=BWYg6a3jpsfpnwb70GvuOgvfY64Nb4lXqgrI91FyQNL2HCiYCcQq/TV+s0tGjU2mYkCoiArlK2Ecze2td3Q+DzoDZH6a9GsPeIomtv7eP8xH62shVF/XPHZZQn644YigxI1TwgfjW1587rpe0hmkwLM9wVZ/7BJcSMZ2dBOD9iU=
Received: from BYAPR08CA0069.namprd08.prod.outlook.com (2603:10b6:a03:117::46)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:17:38 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::bf) by BYAPR08CA0069.outlook.office365.com
 (2603:10b6:a03:117::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 11:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 11:17:37 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 06:17:35 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 06:17:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 06:17:35 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UBHZTu1000506;
	Thu, 30 Apr 2026 06:17:35 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 63UBHYIk031199;
	Thu, 30 Apr 2026 06:17:35 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <haokexin@gmail.com>,
	<jacob.e.keller@intel.com>, <horms@kernel.org>, <m-malladi@ti.com>,
	<arnd@arndb.de>, <parvathi@couthit.com>, <afd@ti.com>,
	<basharath@couthit.com>, <vladimir.oltean@nxp.com>, <rogerq@kernel.org>,
	<danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v5 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Thu, 30 Apr 2026 16:47:23 +0530
Message-ID: <20260430111723.497113-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111723.497113-1-m-malladi@ti.com>
References: <20260430111723.497113-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c03c0f-6666-4b7b-da4d-08dea6aa15bc
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wpji/iw8ZbKNZ8XzjETsXoenby5XkRQbozU/cJ8mW+lGg2anIJp1ss2xn59/HVEnGT6PiunG/3aV7eKmlGsWWQl/5lWz47msR3+Cy2G69iIBjps6QrGIrxl3sh1uEv64cxtvBazijwLcqjXVkch6O1u5vn997PMdUBDrHkhQPsiWJbvztE3tKLgWNiC+U1opb1myM1CGJ3+MyQ/Ul0mlxJ5zwrXHAkTI9yfPQpZ3D4dBtkObGQGuIacbQx6xlfeO4a3TK0dzcJwfWC2oHawgxudLs6pLY6dktbV6Kfk4G6fhfcBOquq70c0yErgk7WauLKTtLGQqkLrFouP03h2NX3l3uwF58zP1JjhE6innvOnqqKAzwVKVT0WHF98C0wrHOkDEw1EmZ6ocRV+uCGVw/u+T8+QeRJbfG0zX89O7yS/qICaxuQdphklKFGm0lbafbKMGVTD/I/1GbB6dZr8pi6VvR7sgdd6vRSC2BebXphPYqhUSWusJbSp3flI5H2RjKr5zH95fPizXzp/zeau/p171DC6h1GGxReqPBiSmUdDo2UivRHv2gk937wq2z8f9YxjXnDft3agYhgrklh11OQbxyYf+wMBewmlzvmvkxZ65E5U0Dc3W0jxZrwIPVqbPEZ76sZTFsm34iEYJGYyNWU411XdbCPdfNAnPNQ/niHJa9Kr25yFI64j9heyuZ3f5hQA4FqewvhlHFo2QMjZQvwr8iW458EOcxGltdjDy369ss/0wkQuESkAaOoWTazpV0bt39o143brJEFo6wMZQ6uwy8JeqQo7N1D8TwhqFKPq3uQ/2vV0nsB9B7mgt+HWv
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZkpmaQ7YgdobTRiY8ls3pokbSebXp9vfuniWA4AP8hr+SKB29UBos4MK+YTDCIOrK1PvbXuWQZ3IwRnTpPId33OFiGRJej6cwtzWdDp0TuZTxTuzSziw51cJ/s6+2ehOgFhdc4hQ8+sIp1mrnRCOoK3DaZVz4kndRZnRsTx6b0xdEqHj1c6fVPvITRCPStAgO89+3Gapk7J6EFxc+F+9Y2GvvpybEN9LMrTeMUR0nnXySdkZ99o5+5i5LA4u5YHvBVg0LZt6e5HKPfZTG9stSNj1wdp0OV2rFhKYe5+EAWZdDmxqxCSnpTLYsmcjCxzj6rLI5ulQhmn9zsgEn53Nv3R+z1U4MagyJVdZdUEpCqd2LLX8S+Vfats0Z3IQEs0X3gA5KEfAfjbD985XWn1r+7u7+ZsauavPwWWsKAFjU+FtcOmTs2N98KFwFRkO/kdG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:17:37.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c03c0f-6666-4b7b-da4d-08dea6aa15bc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Rspamd-Queue-Id: 976314A20AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,intel.com,kernel.org,ti.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282799-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]

From: MD Danish Anwar <danishanwar@ti.com>

Add driver support for viewing and changing the MAC Merge sublayer
parameters via ethtool ops: .set_mm(), .get_mm() and .get_mm_stats().

The minimum size of non-final mPacket fragments supported by the firmware
without leading errors is 64 Bytes (including FCS). Verify time bounded to
1-128 ms per 802.3-2018 clause 30.14.1.6. Add a check to ensure
user passed tx_min_frag_size argument via ethtool, honors this.
Add pa stats registers to check statistics for preemption, which can be
dumped using ethtool ops.

Fix emac_get_stat_by_name() to return u64 instead of int and return 0 on
error instead of -EINVAL. This prevents invalid stat lookups from corrupting
output stats with signed error codes cast to u64. Error conditions are still
logged via netdev_err().

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v4(v5-v4):
- Fix the naming conventiion for icssg_qos_frag_size_min_to_add()
- Change the logic to include FCS while validating and accepting
  values from the userspace
All the above changes are addressed as part of Vladimir Oltean <vladimir.oltean@nxp.com>
comments for this patch
- Handle all verify_status values in emac_get_mm() based on what
  all states are supported by the firmware.
This change is addressed based on AI-generated review and highlighted by
Simon Horman <horms@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 107 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  38 +++++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   5 +
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 6 files changed, 160 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23ac..6a08c40adde54 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 
 static void emac_get_drvinfo(struct net_device *ndev,
 			     struct ethtool_drvinfo *info)
@@ -294,6 +293,109 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	enum icssg_ietfpe_verify_states verify_status;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&iet->fpe_lock);
+	state->tx_enabled = iet->fpe_enabled;
+	state->tx_min_frag_size = iet->tx_min_frag_size - ETH_FCS_LEN;
+	state->tx_active = iet->fpe_active;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+	verify_status = iet->verify_status;
+	mutex_unlock(&iet->fpe_lock);
+
+	state->pmac_enabled = true;
+	/* 64Bytes is the minimum fragment size supported
+	 * by the firmware. <64B leads to min frame errors
+	 */
+	state->rx_min_frag_size = 64;
+
+	switch (verify_status) {
+	case ICSSG_IETFPE_STATE_DISABLED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+		break;
+	case ICSSG_IETFPE_STATE_INITIAL:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		break;
+	case ICSSG_IETFPE_STATE_VERIFYING:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+		break;
+	case ICSSG_IETFPE_STATE_SUCCEEDED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	case ICSSG_IETFPE_STATE_FAILED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		break;
+	default:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+		break;
+	}
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int err;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	if (!cfg->pmac_enabled)
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+
+	err = icssg_qos_validate_tx_min_frag_size(cfg->tx_min_frag_size, extack);
+	if (err)
+		return err;
+
+	err = icssg_qos_validate_verify_time(cfg->verify_time, extack);
+	if (err)
+		return err;
+
+	mutex_lock(&iet->fpe_lock);
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size + ETH_FCS_LEN;
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+	icssg_config_ietfpe(emac, cfg->tx_enabled);
+	mutex_unlock(&iet->fpe_lock);
+
+	return err;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (emac->is_sr1)
+		return;
+
+	if (!emac->prueth->pa_stats)
+		return;
+
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +419,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 85f7017d2c8e7..61320c252bec2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -45,6 +45,7 @@
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
 #include "icssg_qos.h"
+#include "icssg_stats.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -58,8 +59,8 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
-#define ICSSG_NUM_MIIG_STATS	60
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
+#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
@@ -460,7 +461,7 @@ int emac_fdb_flow_id_updated(struct prueth_emac *emac);
 
 void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
index 083f248c557de..104910516d966 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -65,4 +65,42 @@ void icssg_qos_link_state_update(struct net_device *ndev);
 int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data);
 void icssg_config_ietfpe(struct prueth_emac *emac, bool enable);
+static inline int icssg_qos_validate_tx_min_frag_size(u32 min_frag_size,
+						      struct netlink_ext_ack *extack)
+{
+	/* Firmware takes min_frag_size including FCS length */
+	min_frag_size += ETH_FCS_LEN;
+
+	/* The minimum size of the non-final mPacket supported
+	 * by the firmware is 64B and multiples of 64B.
+	 */
+	if (min_frag_size < 64) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be at least 64 bytes");
+		return -EINVAL;
+	}
+
+	if (min_frag_size % (ETH_ZLEN + ETH_FCS_LEN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be a multiple of 64 bytes");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int icssg_qos_validate_verify_time(u32 verify_time_ms,
+						 struct netlink_ext_ack *extack)
+{
+	/* 802.3-2018 clause 30.14.1.6: aMACMergeVerifyTime must be
+	 * between 1 and 128 ms inclusive
+	 */
+	if (verify_time_ms < 1 || verify_time_ms > 128) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "verify_time must be between 1 and 128 ms");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 #endif /* __NET_TI_ICSSG_QOS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155cf..950d58d8183eb 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 #include <linux/regmap.h>
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
@@ -74,7 +73,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
 	int i;
 
@@ -91,5 +90,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
-	return -EINVAL;
+	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67d..f35ae1b4f8460 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
 	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
 	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
 	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ece..855fd4ed0b3f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0


