Return-Path: <netdev+bounces-291400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDnXDo2UFGpfOgcAu9opvQ
	(envelope-from <netdev+bounces-291400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1185CDA12
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5873016D3D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01C364046;
	Mon, 25 May 2026 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PJXKA08S"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DD355F47;
	Mon, 25 May 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733641; cv=fail; b=k/NOqZKVtrj7evuawJr1otR4dcScAJ9ClJ8uxMFmPqHagpaAtluZkISmkQiuLOL/XIl5HuXhpvcNVfNEM/OrwBc3Et/tTIpeHWnxBb+o7mtyUNIUg8AVT4EA7jHCNCDVI+Vfdnxl8ExF0DOhWdWZo92f2F7mgJbGpd25R8Uk8Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733641; c=relaxed/simple;
	bh=nqm/pmGH3suat8JxnzIooSvHcgWXlwJIYYUaHJJzrTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh6AqOJPvzjv9eUx/sB/UAaBwTtjyLRMv0c7O1y4HOeKWM7cEb4yNSh4f3NIfQ5jW1suXJQTx3MmxI341KOB+ZvKYkfx+GloiDbypVKk+uxAXIv3DIfAOuwQ+yQDgDvib653HcsMXZUA2r9Lf130kKlDCzn/ruCICQTRvRLnp6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PJXKA08S; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfKRPeEWf7Jf59cFXOrHtQPIqQdF7Ix/jq9SCYyGLGfVFhsWuNiqigE6zTzEVfYaIToxliabxGHztjgKwyEI9t0FOAg+MJ6DMx7F+0xnmLAZblpKq1XQatN68zFhlXIL3rfDsgOieP/AM56Hdg563yeLnaNCBU4QFwQZA0FQXp+ebydGEPnk6EbE7BymllT0juJVmZ3KRtQMprvtYtUy8TGt8yr2DuruSsGKegrqIjrSC7vSIYwSzwm15YT51H0XsyAx20Qd0t4a4Q9PdTsA2RTlQMrf3+FJkvjxEYgTtbtd126XegyrGrBtcqVI78V3pQwxThbKFOlWMQ7GugKBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hokIAi1rYapGOc+ITEf0MHEsqvpw3Fm83dY8u9+Qvc=;
 b=KzEDYOh/sX4p35BetDgiawIMPuJ1Jqfx9uY9X2R0SJFTxi9kiE9yCCSUrAReXFwZ95E6vIM05vGEQ3HFhq1qwwgViSksJviEkMWKPpqBi0DNRHfWH2eU7xtffX20egkJ2SMAS6CBXxEkqem8Hg0FDfUXjuvZGbr30MKBifvsksOzeOGwcYfHjgO3ggPP77s7mQdkTCulxGQlROIBuw34ivOB7tZ8AVNOUPotrGZg+2NA6xc7y2OO6XNmHEyso5lPrDUZEuEi+kqH09cI4v/wSF+by3sg5YMGnOGZrdYRHT89Y+gPSS9v6GQOshcaXs0k3upgi9PNrJCz5VWS5RfFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hokIAi1rYapGOc+ITEf0MHEsqvpw3Fm83dY8u9+Qvc=;
 b=PJXKA08S0nvg+aDXkfq7gygJa+/qZaA5+hvIOUTDn3ubI86lf8mr3KbM4G0SjM9/WwHh1BQUQjSx+OuY1BBTNeI27vZKpHDTXja4w2L2ausHyYXNI7lNpPPtwDWP90flMJqaTKvi1/VCX56xPaes1sxbF5A8ILGMem2MRVHRNrM=
Received: from SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::33)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:27:14 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::78) by SA1P222CA0015.outlook.office365.com
 (2603:10b6:806:22c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:27:13 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 13:27:12 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 13:27:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 25 May 2026 13:27:10 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64PIRAWD3512349;
	Mon, 25 May 2026 13:27:10 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64PIR9w8018232;
	Mon, 25 May 2026 13:27:10 -0500
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
Subject: [PATCH net-next v6 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Mon, 25 May 2026 23:56:59 +0530
Message-ID: <20260525182700.3135858-2-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|LV3PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7d89bd-454b-464f-a131-08deba8b3daf
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|6133799003|3023799007|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	aOfhbQxM3UIaAp9U94IpXirzZPlKas1KtFnXO6rYvBIi8UrDc+6ws+u8jSwocGgYQKUUGjqjOiG1DAUpxUr3YzUe6RnNi13B6lJXm9w6dQzLRcyc+0I97/a3XxvICw/ZbNKj823o8twt2AJiLFp2tj2WX98JDWT9JUNGYh3pndyI3+W18w5iRSG+F+gwlsCT3M6inBDIBd7WlP2cM6Ecq1l/TArfLLoNk5DjDKV8UrvsoD8ppeFxtBTnhj9gyZ++YQVZZrKVhLJ8QlJjOjEakmlnkVK23h53JhvRsvZEiajL5sTJKT4g0EcUtC0OHhd26yDkRl5y1E4QIQ0+FDIJEC0sIr5DIrvAIjqa4bzFBKtLwZr5LpK5PEBniqoKAx2pnH9xVBCmbgoRvIU/Ge3gOOwrJdDb0zkcJQO3i8N5tqgb5HFOfQDX6sPxenWZqL4cjKPT3XpK7ApZDgbW/Hu9pJnPNfNClww6N4VhlVYa9jVyJQnunpu+PLL2lHTwPlZxwQDhiSCSpKcPMqTy2i9iCbFRCIRe3h4j0H0RsfzLDQzFaHEopvwdmdv3dGspxTda0wt5cm07OGGJgPAaF3GZovXrCdl4kBmkVCdXXNWV7jbfLMmcLGtySIj2R5lcU9aAzOqy5ie8YVHGM9VynEl71m5er5QwZ2jixSUTu1SqZYyVIweTLl0SuNj6qHrtEnML2tJKD1X0QTLc5gyLfCWVRijFPpPg1UeOB4Hvg8P5cMI=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(6133799003)(3023799007)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T/90PgXNjMptliZwFmVBco8CIfkwX4s3pVzZKwYOnF3YOWKecGsdpwPlMsr1Xn06uPMxUQnNcHJoh+rANLXI3xszANa8CJH6+B0oBboSs8HVX/DgbPf3AzLYha6aZzr6BwZ4893ka7UkldINEa7QIh2YYjclXUxn9oDG97m+8iodBsAAeXrwST5wv8h4nQPWfUBMe8b7kj2eDacvQrdVOXkQZY1UHsn/pwNJGSqaX9IHLZQXSv4jobr1CkDyS9A+ibIaW+rUh4TdxFcqA0crCQCgCcfJLc8uFAE3ajzLplf1xSHz9qk+4exDyK6VcbjJTfgjT8eVxOPahTEv+zZ2C4Os2DIYgMPQ8XDclFzxle2mCcTaXGhXRs2E6A4dJXD1rQKyDm2NQJzvJzYdVnmnoXVbGN2BSeBc7ml+qgBtLf/rxCQjvc/NLkML32jEy6Cz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:27:13.0445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7d89bd-454b-464f-a131-08deba8b3daf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,ti.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291400-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.952];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9B1185CDA12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: MD Danish Anwar <danishanwar@ti.com>

Introduce QoS infrastructure for Frame Preemption (FPE) support in
the ICSSG Ethernet driver.

prueth_qos_iet tracks FPE enable/active state and verify state machine
status via firmware-reported enum icssg_ietfpe_verify_states.
icssg_config_ietfpe() configures IET FPE in firmware, triggers
verify state machine based on ethtool MAC Merge parameters.
Polls firmware verify status up to 3 times with verify_time_ms intervals
and driver handles timeout by logging error and returning.
In case of any failure during configuration for enable/disable,
IET FPE falls back to disabled state.

For MQPRIO qdisc support all queues are express by default later
gets override by user-provided preemptible_tcs bitmask via tc qdisc mask
Preempt mask configuration: Maps traffic classes to queue express/preemptible
state and applied only when FPE is active (Tx enabled)

Verify state machine re-triggers on link up/down events based on
fpe_enabled and fpe_active flags, and for memory protection, fpe_lock
serializes all FPE state mutations, preventing races between ethtool
config, qdisc setup, and link events

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v6-v5:
- Balance fpe_lock mutex lifecycle on all error paths 
- Remove deadcode inside icssg_iet_set_preempt_mask()
- Add fallback label inside icssg_config_ietfpe() to fix
  stale state machine handling.
- Replace netdev_err with netdev_info and netdev_dbg wherever
  applicable
- Remove EXPORT_SYMBOL_GPL for icssg_config_ietfpe()
- Remove redundant code inside icssg_qos_init()
- qdisc deletion path clears per-queue map as well.
- Protect all read/writes to p_mqprio with a mutex
All the above changes address the comments raised by sashiko

 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   6 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 269 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  66 +++++
 7 files changed, 346 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index f4276c9a77620..d19bcd25c9d07 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -46,6 +46,7 @@ icssg-y := icssg/icssg_common.o \
 	   icssg/icssg_config.o \
 	   icssg/icssg_mii_cfg.o \
 	   icssg/icssg_stats.o \
-	   icssg/icssg_ethtool.o
+	   icssg/icssg_ethtool.o \
+	   icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4b..c3ee97e96cd50 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1724,6 +1724,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 
 	netif_napi_del(&emac->napi_rx);
 
+	mutex_destroy(&emac->qos.iet.fpe_lock);
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae2..1ac202f855ed4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b4..39f379df923bf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
+
+		icssg_qos_link_state_update(ndev);
 	}
 
 	if (emac->link) {
@@ -1652,6 +1654,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
+	icssg_qos_init(ndev);
+
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
 				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
@@ -1793,6 +1798,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 free:
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 free_ndev:
+	mutex_destroy(&emac->qos.iet.fpe_lock);
 	emac->ndev = NULL;
 	prueth->emac[mac] = NULL;
 	free_netdev(ndev);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b786..85f7017d2c8e7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,6 +44,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -254,6 +255,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 0000000000000..2781abf39e9bb
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int prempt_mask = 0, i;
+	u8 tc, num_tc;
+
+	if (!iet->preemptible_tcs)
+		goto reset_hw;
+
+	if (iet->fpe_active) {
+		/* Configure the queues based on the preemptible tc map set by the user */
+		num_tc = p_mqprio->mqprio.qopt.num_tc;
+		for (tc = 0; tc < num_tc; tc++) {
+			/* check if the tc is preemptive or not */
+			if (iet->preemptible_tcs & BIT(tc)) {
+				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+					/* Set all the queues in this tc as preemptive queues */
+					writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				}
+			} else {
+				/* Set all the queues in this tc as express queues */
+				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+					writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+					prempt_mask |= BIT(i);
+				}
+			}
+			netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
+		}
+		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+		return;
+	}
+
+reset_hw:
+	/* Reset to default: all queues as express */
+	for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
+		writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+	writeb(ICSSG_EXPRESS_Q_MASK_ALL, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+}
+
+static int icssg_iet_verify_wait(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int try = 3;
+
+	do {
+		msleep(iet->verify_time_ms);
+		iet->verify_status = readb(config + PRE_EMPTION_VERIFY_STATUS);
+		if (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED)
+			return 0;
+	} while (--try > 0);
+
+	netdev_err(emac->ndev, "MAC Verify timeout\n");
+	return -ETIMEDOUT;
+}
+
+/* Direct synchronous configuration of IET FPE.
+ * Caller must hold iet->fpe_lock.
+ */
+int icssg_config_ietfpe(struct net_device *ndev, bool enable)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+	u8 val;
+
+	lockdep_assert_held(&iet->fpe_lock);
+
+	if (!netif_running(ndev)) {
+		netdev_dbg(ndev, "cannot change IET/FPE state when interface is down\n");
+		return 0;
+	}
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writew(iet->tx_min_frag_size + ETH_FCS_LEN,
+		       config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	} else {
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		goto fallback;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = icssg_iet_verify_wait(emac);
+		if (ret) {
+			netdev_err(ndev, "MAC Verification failed with timeout\n");
+			goto disable_tx;
+		}
+	} else if (enable) {
+		/* Give firmware some time to update PRE_EMPTION_ACTIVE_TX state */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(ndev,
+				   "Firmware fails to activate IET/FPE\n");
+			ret = -EIO;
+			goto disable_tx;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	icssg_iet_set_preempt_mask(emac);
+	netdev_info(ndev, "IET FPE %s successfully\n",
+		   str_enable_disable(iet->fpe_active));
+	return ret;
+
+disable_tx:
+	icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+fallback:
+	writeb(0, config + PRE_EMPTION_ENABLE_TX);
+	writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+	iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	iet->fpe_active =  false;
+	return ret;
+}
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	mutex_init(&iet->fpe_lock);
+	/* Set default values to prevent garbage values during .get_mm() */
+	mutex_lock(&iet->fpe_lock);
+	iet->verify_time_ms = ICSSG_IET_MAX_VERIFY_TIME;
+	iet->tx_min_frag_size = ETH_ZLEN;
+	mutex_unlock(&iet->fpe_lock);
+}
+EXPORT_SYMBOL_GPL(icssg_qos_init);
+
+static int icssg_iet_change_preemptible_tcs(struct prueth_emac *emac)
+{
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	mutex_lock(&iet->fpe_lock);
+	ret = icssg_config_ietfpe(emac->ndev, iet->fpe_enabled);
+	mutex_unlock(&iet->fpe_lock);
+
+	return ret;
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	/* Validate parameters */
+	if (mqprio->qopt.num_tc > ICSSG_MAX_TC_QUEUES) {
+		netdev_err(ndev, "Number of traffic classes (%u) exceeds hardware limit\n",
+			   mqprio->qopt.num_tc);
+		return -EINVAL;
+	}
+
+	if (mqprio->flags & TC_MQPRIO_F_SHAPER) {
+		netdev_err(ndev, "traffic shaping is not supported\n");
+		return -EINVAL;
+	}
+
+	if (mqprio->flags & (TC_MQPRIO_F_MIN_RATE | TC_MQPRIO_F_MAX_RATE)) {
+		netdev_err(ndev, "per-queue rate limiting is not supported\n");
+		return -EINVAL;
+	}
+
+	if (!mqprio->qopt.num_tc) {
+		netdev_reset_tc(ndev);
+	} else {
+		netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
+	}
+
+	mutex_lock(&iet->fpe_lock);
+	if (!mqprio->qopt.num_tc) {
+		iet->preemptible_tcs = 0;
+	} else {
+		memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
+		iet->preemptible_tcs = mqprio->preemptible_tcs;
+	}
+	mutex_unlock(&iet->fpe_lock);
+
+	netdev_dbg(ndev, "dev->num_tc %u dev->real_num_tx_queues %u\n",
+		   ndev->num_tc, ndev->real_num_tx_queues);
+
+	ret = icssg_iet_change_preemptible_tcs(emac);
+	return ret;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_state_update(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	ret = icssg_iet_change_preemptible_tcs(emac);
+	if (ret)
+		netdev_dbg(ndev, "IET FPE %s failed\n",
+		   str_enable_disable(iet->fpe_active));
+}
+EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 0000000000000..9355e96bbcda8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+#define ICSSG_MAX_TC_QUEUES			8
+#define ICSSG_EXPRESS_Q_MASK_ALL		0xFF
+#define ICSSG_IET_MAX_VERIFY_TIME		128
+#define ICSSG_IET_MIN_VERIFY_TIME		1
+
+/**
+ * enum icssg_ietfpe_verify_states - status of MAC Merge Verify returned by firmware
+ * @ICSSG_IETFPE_STATE_UNKNOWN:
+ *	verification status is unknown
+ * @ICSSG_IETFPE_STATE_INITIAL:
+ *	Firmware returns this if verify state diagram is idle
+ * @ICSSG_IETFPE_STATE_VERIFYING:
+ *	Firmware returns this if verification is ongoing
+ * @ICSSG_IETFPE_STATE_SUCCEEDED:
+ *	Firmware returns this if verify state diagram completes verification
+ * @ICSSG_IETFPE_STATE_FAILED:
+ *	Firmware returns this if verify state diagram fails during verification
+ * @ICSSG_IETFPE_STATE_DISABLED:
+ *	verification is disabled by the driver
+ */
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt_offload mqprio;
+};
+
+struct prueth_qos_iet {
+	bool fpe_enabled;
+	bool mac_verify_configure;
+	u32 tx_min_frag_size;
+	u32 verify_time_ms;
+	bool fpe_active;
+	enum icssg_ietfpe_verify_states verify_status;
+	struct mutex fpe_lock;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_state_update(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+int icssg_config_ietfpe(struct net_device *ndev, bool enable);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


