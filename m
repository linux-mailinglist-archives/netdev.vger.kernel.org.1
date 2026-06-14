Return-Path: <netdev+bounces-299273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRHmF/IUL2r+7gQAu9opvQ
	(envelope-from <netdev+bounces-299273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C8682392
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=peAdiNXW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299273-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299273-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A1E8301159C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD632C942;
	Sun, 14 Jun 2026 20:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031229C325
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:53:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470412; cv=fail; b=frvqToLvYN+PgDChSeZMeYYKs6RyFtMAZYjqThHge3E/mCjM9Fm2/fB6jbX+nmG0Q7zgyQpMjAa7oO1drQbdbvc+JytyJ8IaPnRwjcoCpD+rDAjDkKZI9lnGbc+czTaMC4dforEPAl6HFiiVRHjir1SHSzXx+nS3qMgARkBhXKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470412; c=relaxed/simple;
	bh=TGUoEQqqQ0VD0hvZOwhYxOjqxtMkMnn9Ju0fKzD0j7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnTIpO0LUHu4R16VFJSlT13BvwCE6TqqBZeLb3ML4Z9ky6LvLjDqBrxdxWxc7OQyS1dvfTBSiZPuImu21gqxDreGqV5zUMwl4J9CPKQVNFKaoSaK/43FoHMrPEoOsb6o/Nprqlmg+7fyJ0viYrgEEWzCg46j8nX74C/G3R44nBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=peAdiNXW; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPtxpiG+sA/e8TydpQTWJzSqq1KifvGGOKQNDCmLypjKDti/IRVS3IszEH8G2FWzVj2l3IppdRCMiQt/MU9CF9DxXerCilObNgAIuJt/2szgSmAnVETKDcXmjSzdfNtHn7jEdB7sPzR85/CxL7V24SpJDYIJ/Hp/nPqPiY/pRTv7RAHhn/1C1XBsEkceHiKtoTorpT0OBp7TdlrLiWhVNeKIqkDmy06FrD6R/xRGFNSKa2wdBtgmMzWOMtr4UnQ7+V/qsAoG53CAPpNgIpLlLn5mLO7dkFN8a+6IuFz2W9TGNTPJYmX3LVObVNwFbZ0n+BgP4VGhUOXUdtaaj+w9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7m5gkHJ5+odtY2o3sMrfLwmw2tgB8TA7GwHIK+0lNU=;
 b=BO+Q9DXSfbR21T+xzF2kLYpiyQfcWjjY4Vi03E28zzvrsiaNlhRbrD+VmarqAVS66v4AdqnD17EnrcN32X4HXQEjCvJTNCxzirg0yfqgnESWeel9/O7EUn/wMTc8N9iMbQyO03Dh2n4DJUJ6nHSdE2e9Louz4PPFN7w2PC/64OAgspYuzBeeKyDP7cIAqjHOQ++87enyhYtIorVZWKU5CNv4Z1VaEOQH2h7GhgJ2O9suS0PTu5UdPtVrRwqCPOh+w9ofEC8vECwzaGXLSj7JpbOej++u6q76vytD8j7Wg4MbiIAV+i6qkGrXrc+eO185ktg19jbWpr5xdHWpOYYljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7m5gkHJ5+odtY2o3sMrfLwmw2tgB8TA7GwHIK+0lNU=;
 b=peAdiNXW2S2L6U2MOKCzjdP5S3J7QdcYl666CppEbPhZZrfE90SLDSBQG/NBlxzrjSlQ+XZgEnnHsl9UhWps/uBaSJWci50+uUo2mVpHCu0NpyXvJI/z/8Yz0sdQbcotqj0PmYGQ0tW3HFOTmDfHzSzjc/0bldXeSyzg4NTnKok=
Received: from SJ0PR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:332::12)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 20:53:27 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::95) by SJ0PR05CA0067.outlook.office365.com
 (2603:10b6:a03:332::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 20:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 20:53:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 15:53:25 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 3/5] ionic: Report "rx_bits_phy" stat to ethtool
Date: Sun, 14 Jun 2026 13:53:01 -0700
Message-ID: <20260614205303.48088-4-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260614205303.48088-1-eric.joyner@amd.com>
References: <20260614205303.48088-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: c373b22d-1ddd-4b04-b066-08deca56fbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	asUhSGhIcJ8zOuEyJF6swy0EAU3VQwMko8LXPELHwOwV7GEdltM9aarU14O5QBoPJM+zr+cz/sryhmpo49I2ZCZXULSgb20XG9qqzx/N31Mdaf/gFOCLXiFmJW9j1z7c3EhQVguNOUhKZSr8FxAP05idXH9w+O2m/+hdg8OAn8xrpPqSzuWSLiwJsOAon4uApzYZ8aXm6CjORenG5IcPlN36DhCqeyruIKneaCFDhzojBLAZMvbjSmZAASLF7FUIpi6ByPVxxbcJBfEVJYWMosV43RInTfOzfFfntM/VmyJUML1AnFTrUk2+6QM3BFWzlSdXYqznS/DGvLaayFsqd0EhRkXDxevqmUqhDbsID9yH9mAjm7AloqWDreP2Oxmg82gXwfGQqMrsHBuCqRcJH6v2Njn9Nd7zrBCI/AFqb5BEtUZZwA+o76zz3INeffTIBjiZFitdP05bsOfBBZeOppIhAFt87eKh/6l8cNpzck94d6bh5lPPothEX9DSNOpQ2VFzn79Bv47g1sHhgs77Gztmf9LrixqdnGGmDx+/aWgys+tRt2jGFNvfDOlTrUIgeEUIq+2dqw77HBsVi697LkUz00NkNW2XNKE1e/587povq4wFnEEgK6e+HxQyXfWuu+FMccdK82O8+a168NdgCwWgny9qnmj/Q9eYeejY5KI43FBzfL7R8VbwFos8qw4GWpRypnC9Cg2a0zXew61LgBwFRIAxudFwTAIvHJFx03Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RhNiiZBEm1o4mjKCGjpVnNFPqkm9lhbMWGZidU4aYtyyWblE+7DqlkhiQb9RT1h8VxIli55jj71rLDRU4CCJdFdjsqcMivLiARkNwJJtxiJim3HIMhXGN9Fh8JgKK176tnCqzBeRzfIXkhsoh26LtKlmP+1RpIJj2gF9TiQ7dlXaNumk+thOF8uPfUIWtnx1x+D9uT//p/RMM6wuWHQXC+Ft+ncWGLTKN5coA86rshgwLFoI3HtDobKIX+xw0PNkqIFU8Iwq0tycxUfamD6fMbre+0M05ypDr8FfziD7WDvkMDcOmdxv1N/wLFtU+/hn9EaPEvlF46stHx4EMBJFtRbJi+GmQNBeqPLusdZXMrWWB00nTNoe5phZ7z43cMbfmNaLrvSVoCgLbUQcGaSmVxbGR5TsWATNqfwIFyUIpljoHkg6qO38GUrSIunqGUYa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:53:27.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c373b22d-1ddd-4b04-b066-08deca56fbbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299273-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 004C8682392

This stat contains the number of total bits that the PHY has received;
it's useful for BER calculations. Add it to the ethtool stats output.

However, since this is one of the new "extra port stats", it's reported
in a different manner than the existing port stats and only
conditionally added to the ethtool stats output list: both the
DEV_CAP_EXTRA_STATS capability must be supported by the firmware, and
the firmware must set the value of the statistic to something other than
IONIC_STAT_INVALID.

To help support this scheme, the extra port stats region is initialized to
0xff's/IONIC_STAT_INVALID by the driver, to ensure the statistics that
the driver knows about but the firmware does not are still invalid
to the driver.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |  6 ++
 .../net/ethernet/pensando/ionic/ionic_stats.c | 65 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_stats.h |  2 +
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 35566f97eaea..5f677bcbaf02 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -184,6 +184,7 @@ struct ionic_dev {
 	u32 port_info_sz;
 	struct ionic_port_info *port_info;
 	dma_addr_t port_info_pa;
+	struct ionic_port_extra_stats port_extra_stats_cache;
 
 	struct ionic_devinfo dev_info;
 };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 3c5200e2fdb7..306d9d160e17 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -731,6 +731,12 @@ int ionic_port_init(struct ionic *ionic)
 			return -ENOMEM;
 	}
 
+	/* If the driver knows about more "extra stats" than the firmware,
+	 * make sure these stats are marked as invalid.
+	 */
+	memset(&idev->port_info->extra_stats, 0xff,
+	       sizeof(idev->port_info->extra_stats));
+
 	sz = min(sizeof(ident->port.config), sizeof(idev->dev_cmd_regs->data));
 
 	mutex_lock(&ionic->dev_cmd_lock);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 0107599a9dd4..428d5cca930f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -167,6 +167,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 #define IONIC_NUM_PORT_STATS ARRAY_SIZE(ionic_port_stats_desc)
 #define IONIC_NUM_TX_STATS ARRAY_SIZE(ionic_tx_stats_desc)
 #define IONIC_NUM_RX_STATS ARRAY_SIZE(ionic_rx_stats_desc)
+#define IONIC_NUM_EXTRA_PORT_STATS	1
 
 #define MAX_Q(lif)   ((lif)->netdev->real_num_tx_queues)
 
@@ -232,6 +233,33 @@ static void ionic_get_lif_stats(struct ionic_lif *lif,
 	stats->hw_tx_aborted_errors = ns.tx_aborted_errors;
 }
 
+static u32 ionic_extra_port_stats_get_count(struct ionic_lif *lif)
+{
+	struct ionic_dev *idev = &lif->ionic->idev;
+	struct ionic_port_extra_stats *pes_cache;
+	u32 count = 0;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return count;
+
+	pes_cache = &idev->port_extra_stats_cache;
+	/* Treat all of the extra port stats as invalid in subsequent calls if
+	 * port_info isn't set; otherwise cache a valid snapshot for them.
+	 */
+	if (!idev->port_info) {
+		memset(pes_cache, 0xff, sizeof(*pes_cache));
+		return count;
+	}
+
+	*pes_cache = idev->port_info->extra_stats;
+
+	if (pes_cache->rx_bits_phy != IONIC_STAT_INVALID)
+		count++;
+
+	return count;
+}
+
 static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 {
 	u64 total = 0, tx_queues = MAX_Q(lif), rx_queues = MAX_Q(lif);
@@ -243,7 +271,7 @@ static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 		rx_queues += 1;
 
 	total += IONIC_NUM_LIF_STATS;
-	total += IONIC_NUM_PORT_STATS;
+	total += IONIC_NUM_PORT_STATS + ionic_extra_port_stats_get_count(lif);
 
 	total += tx_queues * IONIC_NUM_TX_STATS;
 	total += rx_queues * IONIC_NUM_RX_STATS;
@@ -271,6 +299,20 @@ static void ionic_sw_stats_get_rx_strings(struct ionic_lif *lif, u8 **buf,
 				ionic_rx_stats_desc[i].name);
 }
 
+static void ionic_extra_port_stats_get_strings(struct ionic_lif *lif, u8 **buf)
+{
+	struct ionic_port_extra_stats *pes_cache;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	    cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	pes_cache = &lif->ionic->idev.port_extra_stats_cache;
+
+	if (pes_cache->rx_bits_phy != IONIC_STAT_INVALID)
+		ethtool_puts(buf, "rx_bits_phy");
+}
+
 static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 {
 	int i, q_num;
@@ -280,6 +322,7 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 
 	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
 		ethtool_puts(buf, ionic_port_stats_desc[i].name);
+	ionic_extra_port_stats_get_strings(lif, buf);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
@@ -322,6 +365,25 @@ static void ionic_sw_stats_get_rxq_values(struct ionic_lif *lif, u64 **buf,
 	}
 }
 
+static void ionic_extra_port_stats_get_values(struct ionic_lif *lif, u64 **buf)
+{
+	struct ionic_port_extra_stats *pes_cache;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	/* The number of statistics added to @buf here must equal
+	 * ionic_extra_port_stats_get_count().
+	 */
+	pes_cache = &lif->ionic->idev.port_extra_stats_cache;
+
+	if (pes_cache->rx_bits_phy != IONIC_STAT_INVALID) {
+		**buf = le64_to_cpu(pes_cache->rx_bits_phy);
+		(*buf)++;
+	}
+}
+
 static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 {
 	struct ionic_port_stats *port_stats;
@@ -341,6 +403,7 @@ static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)
 					     &ionic_port_stats_desc[i]);
 		(*buf)++;
 	}
+	ionic_extra_port_stats_get_values(lif, buf);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_txq_values(lif, buf, q_num);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.h b/drivers/net/ethernet/pensando/ionic/ionic_stats.h
index 2a725834f792..7ed935868e84 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.h
@@ -4,6 +4,8 @@
 #ifndef _IONIC_STATS_H_
 #define _IONIC_STATS_H_
 
+#define IONIC_STAT_INVALID	(cpu_to_le64(~0ULL))
+
 #define IONIC_STAT_TO_OFFSET(type, stat_name) (offsetof(type, stat_name))
 
 #define IONIC_STAT_DESC(type, stat_name) { \
-- 
2.17.1


