Return-Path: <netdev+bounces-299275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uzI5DhsVL2oC7wQAu9opvQ
	(envelope-from <netdev+bounces-299275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56E68239E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=ujfuv5t7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299275-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B4B330179FD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FB32ED21;
	Sun, 14 Jun 2026 20:53:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3041330328
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:53:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470414; cv=fail; b=X1NmiIwAcsJ6y6UO12AnI7TMNMJ8237J8jieSh+cXQenAxdn5PcINTPFi1mV4qNhlH4rE8mhy0izg6U+yHn+vIyVCq4gLqDh8WpAimj5fzNG/r8kCLf0IJz2Hp8L4wBGi0GclUEHDT+Isk/tqWz5ixGYECs3uhx7zfRg/G6EAgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470414; c=relaxed/simple;
	bh=icabC6p84p/Do0njU4hbBteGp8pKH4iEsk+zGF0i3Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxrR6vWjnSV3hetV6XwYOGk2nSCg7XIjHZwmFOK/FA9zVVQBzv4A8o/ITAzCHGpoCdfHm8cBbVjuB7XaMnLjhapylTqLK/TVtlvmC7M3E/Ash/oQqyMZqqR6tCcaRTzpUH5tGhy7zlTxJNjeZJ1+1sU0DtIjXPhBYLoUDPyDnic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ujfuv5t7; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEn37P/dF9fjGwM5I+FK68y/M7FPP0rzVaZ9Qhm5NxhssWrrPl7zgFMOPs7NOMKur2cMOcFDdd+KnoocPXRx17I2HCa2FHzDvuszZ5yqF8ZlQUfNymfARTxNuGHMmJrKmTrrVuaTbAIlEf9fMDLh7qypmV2akZCw9Kl5mn6cNsa/HjSn9sSRNFkPGsCqCfue6qQ7TUFn1g/a9418s2MWSCEm73nQHyF9IlWoOudaWXSdudvVZVrQp/j80jALZq3XrHX0G34r253omEWz7reeW9zeFF1D1VdR2Xwgi28K1GGI2RO3PwIP8AyczMQ4dQTE0O+znskKGZ/hJpfSuTwchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD2PrKlN5pQ1tSP8pdkEAtMIxEnoVn1T2vzUTXkDYKA=;
 b=tN9du+0s1u0StFV5YnUxzq974OXX6FDIqQWcaHF2mzVsxFNTxJs2cNQ0aC97/jBB246s4LCp7//nNIeNZ2RGKthu3seiQYHADdh8KWxJdSoMFm29xBxb1dkWGQS6n8ohKYUnZkIFbRhgKIQ3sxoqi2abbd42ke4PvbtN2k2KHatmcxExoJ7E14jc1OrmyRXrlDXXoPJOWWgFEV2XNMDon97xKd+mft3WzweDLFLzq/uPD3DZrtJSA4pCcIIH4cw2RfjKvfch9jICzlR499xjxp2Mb9rol7NwseVuCiy01PepWKgSHCZOmTMGmwUC5vZ0vkEfc7vATaaajDTNVixzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD2PrKlN5pQ1tSP8pdkEAtMIxEnoVn1T2vzUTXkDYKA=;
 b=ujfuv5t7FNlzo0hky/ceybp/E69pGtBFGC35J6+Xg5smAhG9Jy+d/2exQUqeiTogMQPFotg/LvGKUOBe7+wkUpAc6eiRiI1c7vxpMnKBkuUo4OLvfLc5U8FYBvT5zc6cwT2OjAj8CfNaHQhdmowG4aVYaGRVAC3rhvv34yOg1Xs=
Received: from SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 20:53:28 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::5e) by SJ0PR05CA0064.outlook.office365.com
 (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Sun,
 14 Jun 2026 20:53:27 +0000
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
 2026 15:53:26 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 4/5] ionic: Get "link_down_count" ext link stat from firmware
Date: Sun, 14 Jun 2026 13:53:02 -0700
Message-ID: <20260614205303.48088-5-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: a8661bbe-dc56-4acf-77d7-08deca56fc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	EWdqyxd045G0AAr2cMI0jdJidEcBCxcvm1QNTkRXQvkDCMpdb4fUsLXL0hB/Ls494eYiuleIPDKmvPTLiISKPXVvEA7Qa2fRvVEeTCX5IirvZrwL/tBCJ9rQgtxvJksgLGCcKY73iBWOXwlD0im0doVwkgd7L8/7rQO7Zs9HWkXlehJUEaMnvdgyceSbxa+3N4GbvMuZBenfP6ZY76Th7AVyVB20xgGBpqmOUBNXOeLKUNAp04/8W/Epq8smGQatnFsLRZp4Gr1H2FNdLm6iqeirzUp9WeFLpaOp6WBOO+oW3CX3jEWxrn3m5hJska92awylpRmgitABunvUoKZl7ZxlOAxNCFVnz4mkY/cP8laD/VvNVtyo/L23WPrEIOijzBEahWbrUz4SubbgEMiCc2UugJXGsSyMOVOndiN19yC/Pzgqm/fwIboIfCHkST3pDL2HILbfStV9i9Ars6cTVantqAmDWhdBKEl3T6YDPuOfT34TmFUXffr0+/e3M80PVoJa773jzWCS5oD6qGNgS1PcDhmvZN3nTiS1Eu9D+C8mDQvCM/N5vocNohN88kIh3ox0yDEDxjnycTAA4TcZ5bhksIoBxVyi5YT+ZaCXFXqw5tZDdiYXBHFMOBNOVKh4GCLlC+6kFeWBaLa/eyW8+LReFSPu8YR07BZLOjbaPX5CBHqF14wqVP0IsEJDgsVvsEe86sc6aDgFBg//W94nDiqkzg8xmfzSehaUrQPyAJg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fpBpwbpfqG/4o8SEtA7JIsxSNP+mfiVW7nHn+VQ+Oi4XQO1AV3aqwntw4fEUmFgPrJS1EGJHvi8b79pWhXtxaCxpMC7HS+x1S7+vP5ABW28Zavzdeq2iMGpRzAlket/RIaeHizMADo2TgO6mfHowTNHLfbpVE9IRSs8ujdLAaXC3cTHV1Sf2vSH4vu7S8+NVnzP51zyGMezLnuK4Dq52sfALUBV3yO5P60hFifeQ+ElMvYKpumsQREqF+N2fyEcdBMMdRMv+0vJ3/dPZBvwg2edP8NYqOGuJtfHTrCdXVVivBhnc13gpllR+3iD4CwW+czBAdRIbZAPIIIJ1Mrxa6+YGI2AOWWbPKyRK6peN27yvF19QvCIsmnhNAEI/tZbj04bMyQH5iJ5jMnyHJu1mcTcdsebka/3iIZMrqfoIz8Exd3i3HbpMiW5YYPMwWEu5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:53:27.6575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8661bbe-dc56-4acf-77d7-08deca56fc0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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
	TAGGED_FROM(0.00)[bounces-299275-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9C56E68239E

The number of times that link has gone down at the port level is tracked
by the firmware and sent to the driver via regular DMA writes to an
instance of struct ionic_port_status in the driver's memory.

This statistic was never reported in favor of a driver-derived stat, but
doing it in the driver was never necessary since firmware had been
reporting it the whole time. Since it would be more accurate and true to
the description of the statistic to get this count at the PHY level,
replace the driver-calculated statistic with one derived from the
firmware one and remove the driver-calculated one entirely.

The stat reported by the ethtool .get_link_ext_stats() handler is
normalized to 0 on driver load and any device resets that require the
driver to rebuild state while also handling overflows.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 10 +++++++++
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  5 +++++
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 22 ++++++++++++++++---
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  1 -
 .../net/ethernet/pensando/ionic/ionic_main.c  |  2 ++
 6 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 3838c4a70766..648d9d24be85 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -1076,3 +1076,13 @@ bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos)
 
 	return ((pos - tail) & mask) < ((head - tail) & mask);
 }
+
+void ionic_reset_link_down_count(struct ionic_dev *idev)
+{
+	if (!READ_ONCE(idev->link_down_count_init)) {
+		idev->link_down_count_total = 0;
+		idev->link_down_count_last =
+			le16_to_cpu(idev->port_info->status.link_down_count);
+		WRITE_ONCE(idev->link_down_count_init, true);
+	}
+}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 5f677bcbaf02..db90e39a1442 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -185,6 +185,9 @@ struct ionic_dev {
 	struct ionic_port_info *port_info;
 	dma_addr_t port_info_pa;
 	struct ionic_port_extra_stats port_extra_stats_cache;
+	bool link_down_count_init;
+	u16 link_down_count_last;
+	u32 link_down_count_total;
 
 	struct ionic_devinfo dev_info;
 };
@@ -395,4 +398,6 @@ bool ionic_adminq_poke_doorbell(struct ionic_queue *q);
 bool ionic_txq_poke_doorbell(struct ionic_queue *q);
 bool ionic_rxq_poke_doorbell(struct ionic_queue *q);
 
+void ionic_reset_link_down_count(struct ionic_dev *idev);
+
 #endif /* _IONIC_DEV_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 6069fa460913..c4ab4b5caa0a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -115,16 +115,32 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
 				     struct ethtool_link_ext_stats *stats)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic *ionic = lif->ionic;
+	u64 link_down_count_total;
+	u16 link_down_count_fw;
 
-	if (lif->ionic->pdev->is_virtfn)
+	if (ionic->pdev->is_virtfn)
 		return;
 
-	if (!lif->ionic->idev.port_info) {
+	if (!ionic->idev.port_info) {
 		netdev_err_once(netdev, "port_info not initialized\n");
 		return;
 	}
 
-	stats->link_down_events = lif->link_down_count;
+	link_down_count_fw =
+	    le16_to_cpu(ionic->idev.port_info->status.link_down_count);
+	link_down_count_total = ionic->idev.link_down_count_total +
+				link_down_count_fw -
+				ionic->idev.link_down_count_last;
+
+	/* The firmware counter is only 16 bits and can wraparound */
+	if (link_down_count_fw < ionic->idev.link_down_count_last)
+		link_down_count_total += BIT(16);
+
+	ionic->idev.link_down_count_last = link_down_count_fw;
+	ionic->idev.link_down_count_total = link_down_count_total;
+
+	stats->link_down_events = link_down_count_total;
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 637e635bbf03..fd3ee9820531 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -140,6 +140,7 @@ void ionic_lif_deferred_enqueue(struct ionic_lif *lif,
 
 static void ionic_link_status_check(struct ionic_lif *lif)
 {
+	struct ionic_dev *idev = &lif->ionic->idev;
 	struct net_device *netdev = lif->netdev;
 	u16 link_status;
 	bool link_up;
@@ -153,6 +154,8 @@ static void ionic_link_status_check(struct ionic_lif *lif)
 		return;
 	}
 
+	ionic_reset_link_down_count(idev);
+
 	link_status = le16_to_cpu(lif->info->status.link_status);
 	link_up = link_status == IONIC_PORT_OPER_STATUS_UP;
 
@@ -179,7 +182,6 @@ static void ionic_link_status_check(struct ionic_lif *lif)
 		}
 	} else {
 		if (netif_carrier_ok(netdev)) {
-			lif->link_down_count++;
 			netdev_info(netdev, "Link down\n");
 			netif_carrier_off(netdev);
 		}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 8e10f66dc50e..d34692462036 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -214,7 +214,6 @@ struct ionic_lif {
 	bool registered;
 	bool doorbell_wa;
 	u16 lif_type;
-	unsigned int link_down_count;
 	unsigned int nmcast;
 	unsigned int nucast;
 	unsigned int nvlans;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 306d9d160e17..6e6f3ed07271 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -737,6 +737,8 @@ int ionic_port_init(struct ionic *ionic)
 	memset(&idev->port_info->extra_stats, 0xff,
 	       sizeof(idev->port_info->extra_stats));
 
+	WRITE_ONCE(idev->link_down_count_init, false);
+
 	sz = min(sizeof(ident->port.config), sizeof(idev->dev_cmd_regs->data));
 
 	mutex_lock(&ionic->dev_cmd_lock);
-- 
2.17.1


