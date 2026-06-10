Return-Path: <netdev+bounces-297473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7bVTMmADKWpdOwMAu9opvQ
	(envelope-from <netdev+bounces-297473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD13666377
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=QZPrsTkl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297473-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E7A31A168D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BFB372EDD;
	Wed, 10 Jun 2026 06:19:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63F37186F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:18:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072340; cv=fail; b=ZJj3PWYgo4bs0h4cj66Kl6ydITMWlhUPySbqGbr/ZxlnnIR1Jv13zdLV/2NM5FkYpKd2fo6tgEQkOOh7jMeyVTCmoXeoocFrZnCxmNNCH5OBc5GgZwDp72O4DJZUTVSCBuY1LyHmmjrHohBeNT3tPXpTIbGgYaQUPQtjom0Hvkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072340; c=relaxed/simple;
	bh=0+v4H3qPX6T9iW8NxDqjHTDPBcAlMwrnmz0wbc8wpcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STosG2VpwOm67OzIZo2BFC6CXzznPcd3EN1QntFVgl1+CzTcucMmuIzrXFfOumyisJJ+XnhZSxRfs1lmk3CGYVGqxWQxNrC1hthBjIEkHHfuhuL58TBJcmAjfhiszk+48eoJvDfE2Mh2zdmf9eCEkXzsneZ3t92odqYQ1h+BsbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZPrsTkl; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcrrgyUzuC5SKyOqUerbT1vhhH23Qk3tMGa0RwbE7iGB7p3J5qMHYppRvGPwtEYPJ6F5nXEpUr319JJuR6+lcntFQuXuYdrJzEk1N4kuOkD4Z0nZTXO2DB86HCD/XdFyJmDptMz8XFmrjbTAhJ1M5MDMDRo9+3qggB/5p5yuL8uczVx/OdPG6MhtD3zzT15wajxbaPYCqqK2b427EUMRhKloZq0mmkdHgcfnsjmkqYLS1aPD8wmb2MiRA8AfIJ0gZak7Cr0GpdUu8tZCM1W75GxRwHIi23WPyybjzdo1DCNrswNfTxFJeSB0euxMFFsZr0wV+vFkD1Vafct+QNtaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y9YMFGSVHy7l+peZWKD1piaXJAZyN2iMrxwfdEPAlA=;
 b=wxe81sKG3YHtxaS5FOzpJvWLNEB9MtbsMDcAQaMg6GJkZr5ShZXjHHEm7xlCfKWWezU/MWs6QF/gM7pWKKVZ2XXx0LVg6kZzWmtlLx8IyawJu19uDhlXY+IGYSKbXvwzJzK8DRZq6M/00ymCfFH1qeoUvsGu5nweg0k6L0l1kpgPpvFSWJn9W3vL5DFwXbqdbYP5hL4XnhqdiwENyzZVICH1rY2cTHu2F3x+c0t2ituPemGILyZPWLoG2fSXeH/KPMU+wrGQIwEzdSE/COQ87O9HVZZ9uJHS7o8XS/1lRKxXMvcwJ00eFRdX7s+08RCKqGnQtJqVzuxyZvaKCh14dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y9YMFGSVHy7l+peZWKD1piaXJAZyN2iMrxwfdEPAlA=;
 b=QZPrsTklPvr+HU6Nk5lKf2p8gI00zHT8JZvm9RWxcMow1tuic/VPRC2GUYQx7XHFbbicRHKcUFCcYPERhgaT04K9jBKl7eSY46R6RdhaG0PqWgIUZn7kimRdBe42++3J4RATt11Q3Rczjm/SRZ/laSRlEPtQxnxY1AL0Yg21sEM=
Received: from MN2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:208:23e::24)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 06:18:55 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::24) by MN2PR14CA0019.outlook.office365.com
 (2603:10b6:208:23e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 06:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:18:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:18:52 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next v4 4/5] ionic: Report "link_down_events_phy" in ethtool statistics
Date: Tue, 9 Jun 2026 23:18:29 -0700
Message-ID: <20260610061830.51037-5-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4d517e-710e-4dd2-e132-08dec6b8262a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NanmK+ghVAo0aRQF7uS4XpSNsF9ddnJ5ylanMmmtVMmoZk5NbjzwLzg0oz5DB3SZVPNaVDtrQ3Kj5ghrPecwvrjWD70U+0IHL7MKPpOL0VT5D63BmRTleq4684pYJ3Fa1L4pDe3+W4tip55qwzhvLc0mdY5s033PeWUmTGcZbrXTAbLT0p4J01Q6gbYSmasRUpLTFjfu1nZk6jXR2u/fk3iAP0n+y4zpIEop1fEM1LFzelaZTNa0Jm2TNk29oRfbn62/1GkxsNOR7OFNMBbUg0tyPzRTEpzhSriI9bYPlZXC/OrIDNzy+depcWJTU+2TcIMxeKijjeXgOCrFlYXpjHfJK7A3vAe7GxiB72pnwoNDuIoNaPA0C8fN3QHjAU65dnyO/x+WYCpFuvVi5+rfGOBoSuzYWPon1mnlmV3+Vgh/k5KBRIJYAbUfSgp0sX8FDIjvxqmP2PZ8SuorsJacGDV2UpJKyBUtyzHoGcTQ67CY0IrOT3QgILrLAAO2OzUB5EfONVoU5Lv/SpjO7wz+7yOVyain/jDqsuLuHbjy9nS4VvhpuMSob+EmtnsAXEWMlKyNC/eik/c7/eD/hGCx0jHMDvUWMMwsqiK+799bH4dW1fnDNQIYtnhs/tYoC5iTriheC+cj2l4z3tJK+werNSQElQ1XTH6xkcgAgcwnscGNKcG+FjueUmYbYDOHK0dNNP67EA0UvYXL0CpXX3xTHSAQ9Rc4YuYTPZYFJiL/dkw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/W1TMrRSBJB5czFsbvv5nSnYWXTeEvOr6+dYTLxsWT63atX2kM4isPhVCmMNBX/ya/8RN4rxr/0DgEWSntIt2iNZDomfE2ulNjowu3qUwFYIy5BinJ1vH15Gr6bWkJyggc/SwrZf/y7Y2tdHkLqnwVgKFz1ysTpQcmGImUIM+rRDUMe8UeeIXW859GzIRIwLSe1F3PIWzIw3v8k/Jr8LVt4DdMmOwa8UW3WDueb+dHqPzg1qt5al1A8E63GRap7z7dAGLyLS/KEIPSTlaHbeaZv+npR0Tip/U8pbfj3JB6gUzJlFIRQU5U7WM0AGU5340K+NthZJh0ecUyGzW1ulomSDcvdQdZ1hWeRDoJ8BikJIEjQBN+B69fNrJsgcd8JNVweuHLhN3ygMvY+oKNDRExcdrClH/BsCUmXRheQ7TzNAxOYB4gJAdLMszD9pXZT+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:18:54.9325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4d517e-710e-4dd2-e132-08dec6b8262a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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
	TAGGED_FROM(0.00)[bounces-297473-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FD13666377

There already exists a link_down_events statistic that is calculated
by the firmware and is reported via the .get_link_ext_stats()
ethtool handler, but there is a value that is calculated by the
firmware, too, that could be useful.

Instead of replacing the driver calculated value, add the firmware value
to the ethtool general stats output. Unlike the driver value, the
firmware value doesn't get reset unless the actual card itself gets
reset and is limited 16 bits, making it harder to use to track link down
events e.g.  during the current boot and any excessive number of link
flaps. That said, it could still be useful to track link down events
while the driver is not loaded, such as checking if the link partner is
flapping while the local system is booting or otherwise does not have
the ionic driver loaded.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_stats.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index e81190cc9d2f..d0ebba7aec22 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -237,7 +237,7 @@ static u32 ionic_extra_port_stats_get_count(struct ionic_lif *lif)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 	struct ionic_port_extra_stats *pes_cache;
-	u32 count = 0;
+	u32 count = 1;
 
 	if (!(lif->ionic->ident.dev.capabilities &
 	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
@@ -296,6 +296,8 @@ static void ionic_extra_port_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 {
 	struct ionic_port_extra_stats *pes_cache;
 
+	ethtool_puts(buf, "link_down_events_phy");
+
 	if (!(lif->ionic->ident.dev.capabilities &
 	    cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
 		return;
@@ -360,8 +362,12 @@ static void ionic_sw_stats_get_rxq_values(struct ionic_lif *lif, u64 **buf,
 
 static void ionic_extra_port_stats_get_values(struct ionic_lif *lif, u64 **buf)
 {
+	struct ionic_port_info *port_info = lif->ionic->idev.port_info;
 	struct ionic_port_extra_stats *pes_cache;
 
+	**buf = le16_to_cpu(port_info->status.link_down_count);
+	(*buf)++;
+
 	if (!(lif->ionic->ident.dev.capabilities &
 	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
 		return;
-- 
2.17.1


