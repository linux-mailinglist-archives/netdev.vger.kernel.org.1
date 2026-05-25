Return-Path: <netdev+bounces-291401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DIkEe+UFGpfOgcAu9opvQ
	(envelope-from <netdev+bounces-291401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:29:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD045CDA3E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC61E301A1C9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7936074D;
	Mon, 25 May 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cqjTU19q"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B636405E;
	Mon, 25 May 2026 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733652; cv=fail; b=Ug09c2N+mZqMuWB+LJDirjfNfE3u2o7ucMpb/YH0QNNeaDYalofhm+arfdAi7XOKbVwPlt7jpotDAOCjtWwKkQYCG4x5lO385Ck7X4zGjOyV+fGTUq3khC9Kfrvb/zU0nT4shrMlrTRi8hdF8IpyMbFIlQln3olIOYvJaU7s3Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733652; c=relaxed/simple;
	bh=wlTrwHDFqCUgyowSe8kc5GXoKzHP/5nWaPTeHnf3MGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOtiaH6KUeKL3JL7hDuEGcXx0wdhHPdvTWJwuN1gzTEAlX34nNI27DqG31O4JaPq/oDwp1i7FBA/zjOnpssI5+kqumvDVHBrb/c0gubR1NmClKFRiasikVYI1JnUg0xHODTicfkSz4/iIxf1uYQPiqOnLkOuBS44H/hsa5ZET4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cqjTU19q; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St+MmFN+Ib71eVu35eULjfXjv4eJXWevQ9hY6l+HkRvA/u6K64N5XZWHYsNX0aoMFVwen3CVmsSACtL+2EW1xzVGt3HN3pAtjxSoATehoBN0gRMPpniY9SVo7YGe6WkTKPyT/bLiybOC43Djm/w8xfwCnJPBIKag40NPPto33xpZrSFMd5Z+5o7BoPyy8zhh9yXsCU4+Wsf+l3BdpIL0WiRLX4zvkp9xwcsok3f7Me70EFsPcW0EcFy0I5SvVKf33ShO4kGfbkZ4kSbfbJxvRrsgjV5bjHL7tBrhsbwmb3MW1LfRWdKyxd+CgnYcKsadvptHQoD7gpBrR/7EMBlypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggDon9qhm+f3Y1UrHWAvMI0aSJXoQZDqyBTp4UYKinM=;
 b=hkVTTRv8KDR49f1RIhT6t8D+k6SFUlBfZMAmCxNODqW8Rw38PfTfqk9g/bIDrrKJQ6mIjEx72QcbdDEXgyer5z9dyJMoLtaAr0nbfIGmhUsIwvCfIlHMUwW+QJhvowgWGFmIap7W8iZsbQkgMmu/Klo5iljgk3A89C2jFqG/pgKtjdIFLOwCclBR5jBsdT7CDyvGd7m1pBvWCdIaEHMh2s26iBFc1xLx/ZGEK1lD7tE/Q1kH9mZc4YZ+pHGQQ0ljuZboSS99vG+7EgKdviscN/nTncRiPsX9oh2ZpxTzLjKVNSdFo213dv1kOXlJEHMa+m/jowEDMHDuO0AuK+JinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggDon9qhm+f3Y1UrHWAvMI0aSJXoQZDqyBTp4UYKinM=;
 b=cqjTU19qV/zrLZ7DXlhYyAyzI883rrPv/dQaENp/74MQENy5uPCbQfkqdC8/N/eSs9uQL9Gb01z2Hh6uxXYyHwpQQmNHIAHt2CrEHFGUZYlfS5Mp9saW/oVBrRiifYZYrCjx5Y+58uaESOOw6eKdOhfqVTUYKFQwMAiL6klbIfw=
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 18:27:17 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::3e) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:27:15 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 13:27:15 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 13:27:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 25 May 2026 13:27:12 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64PIRCTC4056334;
	Mon, 25 May 2026 13:27:12 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64PIRBCl018239;
	Mon, 25 May 2026 13:27:12 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <liuhangbin@gmail.com>, <h-mittal1@ti.com>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <arnd@arndb.de>,
	<afd@ti.com>, <basharath@couthit.com>, <parvathi@couthit.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Mon, 25 May 2026 23:57:00 +0530
Message-ID: <20260525182700.3135858-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525182700.3135858-1-m-malladi@ti.com>
References: <20260525182700.3135858-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA1PR10MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 216472cb-5c1e-426c-33c0-08deba8b3f50
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|921020|56012099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zWdMpNiWNxj9CQwk+aUIPXmL4VjLnIey190/cFvSPVKx+JZkge0MEEWsR5lMybHLDLyq9r9ZTQ6GF/6Od4YuLMdUh9m/xPb75epYtgCLNn6AB77BnQM+RZY9NK4tAG5FvfYt/XaGhAoSW2r1O6OzrESyLWCYXDd0O2mUyBAN+nQ/M4vokaPJV6CnLEth3Xl4WYilCR7LEVPlVabsSS59JSNCjmopSUuPS6onUKZ2AZhs2JG8q9DetHeFEzjV+rpnbQ8Movp1mJPpivRw7V5jRc/zBVLDL7ASNmxtAit/B2r+FTChBiMaU2Xu3Mt9crOoURM5VLzR4D/ziUrGpp+GjoqLTIaMP0LUrJwG8ZUuIxlUZIg63fHYWIjgyEOAPSM1CgW2iMZESXZhCLhH3pS0t7Xw5hqBZtBgHzJUtKoL1wMJtgNe4TJEPTPzBwOHR+GjQdRZxnpcQ2LFkJcogtmZM+Ao+AOb0qvGdlPkTbtyXnEM7Y4/mHYA/ibvA08y6alcZn8eyl540oBuAvz5UF5g9PKL2FCvANIwC4asoUTvsVFYwC5wU6J465u7/7LoE0qkW/yUXhK0ggm2oFoSCwt3sTkQdtmefOsmtRFFzhrrmGv4oA0AmtwZ4tbZzQChbWUcRaAB1eDKHMmVLX7dXRrPgVrfpp3x1W157QF0mNmPEFnvFOjpAtgWB/CA+ZJxJIO4omUT8+ANjizCkxK736lDNtqBsBRr9mb3KjMSI2j1peabWc6XQa5etjeiGdkey2PpSDavYYQ4JBpdQUSi0BLZLA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dvd0qXkXgJLC/qdhD3cq/ckIOLUpvd110h4nIeeRgq00ZR+aKOOH17HlV0DffDQWuqRVozQG+VXu5BpgVmpbY66Nteyn9Qa+D38GWAyCOSyhvAXF4j298HOfj6qC4Yu1A5LYM6qKomsklw/x9pW7ytYl3vlABNfX7ZuPdiIXjXmD4pHh4Fg/0MV1QP/CUXGv92Qr7lNtjh3G2S+Nd1I6l/FmS2YLXqO5x0oavpU1TJCHrD+ZMFDYeSjOm2RInVgMxcPnqtaMF+avrwGz5mNzoBg5UxB0slZUQOeRBtpBokrYTKuk/1GUMLs15uEvwKfxC6UixlUbX0o4ar+Qxfw7b6fv67P725c4a+LL6Sb2vcdhxOR2stpLQiSyXOCsP4ylXtY2dfqkcHPVEWeLyWW/CAzOmd67xauqEUFRv2blWdYg7IPlNf56uMoryAIOQ3kD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:27:15.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216472cb-5c1e-426c-33c0-08deba8b3f50
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,ti.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291401-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:mid,ti.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.882];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 8BD045CDA3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v6-v5:
- Initialize tx_min_frag_size and verify_time with valid values
  to avoid returning corrupted values during get_mm()
- Fix rx_min_frag_size to ETH_ZLEN excluding ETH_FCS_LEN
- Fix return codes for emac_set_mm()
All the above changes address the comments raised by sashiko

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 106 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  46 ++++++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   7 +-
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 6 files changed, 168 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23ac..ee940051644d6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -294,6 +294,109 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
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
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	state->tx_active = iet->fpe_active;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+	verify_status = iet->verify_status;
+	mutex_unlock(&iet->fpe_lock);
+
+	state->rx_min_frag_size = ETH_ZLEN;
+	state->pmac_enabled = true;
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
+	if (!cfg->pmac_enabled) {
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+		return -EOPNOTSUPP;
+	}
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
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+	err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
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
+	/* MACMergeHoldCount stats is not tracked by the firmware */
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
@@ -317,5 +420,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
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
index 9355e96bbcda8..87ca031afcaa4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -13,6 +13,7 @@
 #define ICSSG_EXPRESS_Q_MASK_ALL		0xFF
 #define ICSSG_IET_MAX_VERIFY_TIME		128
 #define ICSSG_IET_MIN_VERIFY_TIME		1
+#define ICSSG_IET_MAX_TX_MIN_FRAG_SIZE		252
 
 /**
  * enum icssg_ietfpe_verify_states - status of MAC Merge Verify returned by firmware
@@ -63,4 +64,49 @@ void icssg_qos_link_state_update(struct net_device *ndev);
 int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data);
 int icssg_config_ietfpe(struct net_device *ndev, bool enable);
+static inline int icssg_qos_validate_tx_min_frag_size(u32 min_frag_size,
+						      struct netlink_ext_ack *extack)
+{
+	/* Firmware takes min_frag_size including FCS length.
+	 * The firmware requires the fragment size (including FCS) to be
+	 * a multiple of 64 bytes. Since 64 bytes = ETH_ZLEN + ETH_FCS_LEN,
+	 * valid user-facing values are: 60, 124, 188, 252.
+	 */
+
+	if (min_frag_size < ETH_ZLEN) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be at least 60 bytes");
+		return -EINVAL;
+	}
+
+	if (min_frag_size > ICSSG_IET_MAX_TX_MIN_FRAG_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must not exceed 252 bytes");
+		return -EINVAL;
+	}
+
+	if ((min_frag_size + ETH_FCS_LEN) % (ETH_ZLEN + ETH_FCS_LEN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be a multiple of 64 bytes minus 4");
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
+	if (verify_time_ms < ICSSG_IET_MIN_VERIFY_TIME ||
+	    verify_time_ms > ICSSG_IET_MAX_VERIFY_TIME) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "verify_time must be between 1 and 128 ms");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 #endif /* __NET_TI_ICSSG_QOS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155cf..cfdb6f5dc5da1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -74,7 +74,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
 	int i;
 
@@ -91,5 +91,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
-	return -EINVAL;
+	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67d..8073deac35c3e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -8,8 +8,6 @@
 #ifndef __NET_TI_ICSSG_STATS_H
 #define __NET_TI_ICSSG_STATS_H
 
-#include "icssg_prueth.h"
-
 #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
 
 struct miig_stats_regs {
@@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
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


