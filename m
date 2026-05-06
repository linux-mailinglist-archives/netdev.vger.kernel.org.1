Return-Path: <netdev+bounces-284700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yELdNTHF+mkzSgMAu9opvQ
	(envelope-from <netdev+bounces-284700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FE4D6223
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02DA730260D2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 04:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1972FE575;
	Wed,  6 May 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RHC2OrVT"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891F26158C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042149; cv=fail; b=f4ri/H7MEeurh32ELnzAzdTjR/4UXaUfay2YGUkW+OThnKLAnGUUpon1JXP7ML5Wro/XHeidOS0pKMrwWNWzed/WAZo9no7g2z0Z4KbdC2v1v8jOlD7Vuz0TrEKqoKLDSDaYuaC39ldmEs9LbFu8i3cCfkuDygxBqUti5zV/nFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042149; c=relaxed/simple;
	bh=rwJGA5Eo6HMXdk/NlbOCEREC7dN1bYP5PAqCesbcHR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTHo7w/kAbr3BKm7zy1iKPF0IHLOWIHAp4OHdOOTMxATyA+VYJZ/h3YafC0TknbK5rFOUOOo6fyRlJWc2Yl4JPk/AtI2u18EA8bZsFWRBvqlq2f1sbJViZL6l1eylTYlP7Le+hS2q0ScA6CeA8lBoeJ3qJSelCjg33KrFjcEeQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RHC2OrVT; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh+EdkuKp/aMx83IHoMGkFXeCG7cxUHaSTkO5MMTj+GOUFlZbZSj9U5CxmfmUzMbIg7XVLIBXmk7AgLb4dsjKqTfP/X5bgxrCWiOkf5wZ7ZRworwYgslgDjUwGZc66kt9Bak1t6hK8degCX6bSMsn6/32p/FOP190pkyTv27AK16jGeuk4GP/VNlNnkGX4IkkBLtlJtD88of1s+YeaQD+fOaliAVQlFfi37ybMJnbCi2sIiHxyKbzOsQ6SiUGO6XaytICDo4DL1MgyzTPoNvjV/YUN9u/89W64iW/8WZ4eaJYD0yL4MFuJP4ipdctAzWJ7psHOQnlyUsFGaK34LssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsEdR0sW5n7yBJcWyDtymV/OzTyjFyZRuUrtFm0CDnY=;
 b=fjZQ62S3cfQzzNLIhkuTS1L9pXFHoatWVZwxeXWyi/fCO9+PD84FtQ9HW/49qWwOx09PdxwVzlMpYPppv65bkmjqj9s66CHbMRahDZz3BOJiFC2tXPRPHhhhHA7ZmJVvMxEJ/IJaCqxZ51Y+LvNuimJIAAjN0nzKV7YhuSo5uPlEUq84f4p+zzPDfF7BJqUenns5VN0qyPmmUM/7oLraFLtckqDPCLusSUuW/MFXfNrosRsvRRkWWqsHrJDAhw22PjvfMAdcl7u3ELegG/e5Wt9HlOft2GjDS+ImvQ5O/g7d+qWTdoRVLJ1g69/2qS1ygZY7MbVoTxygl3I83Afn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsEdR0sW5n7yBJcWyDtymV/OzTyjFyZRuUrtFm0CDnY=;
 b=RHC2OrVTuLis2oN5NmyF+3eZsUJ1v6P4tfv/fmddOhJx7cqOXM/FfhdIy8VnfG8pUEaxfKacNW/dbvgHC93OjDw2NBk8DMc0YgqVWF10hvFOQpqhCiB4U2rdQB00dnoVAGkPTrZCI58JUkeK17qWn2PQgvhFYOgpcom+YdTFbDg=
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by LV0PR12MB999070.namprd12.prod.outlook.com (2603:10b6:408:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 04:35:42 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::44) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 04:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:35:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:35:40 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v2 3/5] ionic: Update ionic_if.h with new extra port stats structure
Date: Tue, 5 May 2026 21:35:23 -0700
Message-ID: <20260506043526.64301-4-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506043526.64301-1-eric.joyner@amd.com>
References: <20260506043526.64301-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|LV0PR12MB999070:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a209de-63c3-4b67-1844-08deab28ee6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xySxacDHKwsdhrgZl4a+ZMj9AzdTdqWb3L6FT5zIZgzNvEzF4OgfAe0cSKA8lpQ9Tjp3Rg8G/C1FVJLhuJniRw4gz0ShItaVgKZVPooiBp8y9dF9wcRB4Vy1334C4uE6uTBh8mzECejCpHJTNNR9IgDLcDoj8T2bcXKfPFCgRPXwUloeBXM66Yx/DhNCR5/vAOCx5802Fi7e7gQ6DZvTWDI25NmbSsUJyU58Lvgc6aJppiuUTVyWemOVAWeORVgd7eOFFKiPJWJ+Ic0ax3zAZ6MpMP7cwrqgqBZXXeudBt2vCmTGNtVYEd8aQA0nd+YTJ7+f5SuNjbARXDD9t0CLQM141Dn9/ppocsei0pJONbntb4uxj6m9YipfeBnmHcuj4vBFlXhZ9lsK3sSm3I02eW/V8m091uaap94WKH4mEOIJtxKzJylKk7n+YJyfd8DdrepxIePZDPCApmBqYyAmM8DBlodCvsncz4+QuPwIxH0mU/kAZ8KEZYB4hiA4rzGO9m882gRepATqxGYVXrJlan3LkCcf+kEqAGeO7mEHJDJYj/nfgO3yFow3rEBUU9uSzRoe8nAC910ZLYsiv6TMFlHV79IPZJmyvvcXRvfBzhE1UCUlnX9fz/NNEzG/5l9aXL7I89cJHu2eyE1n3LrKYJHSqFpsWx5Q9NFFbjh2ESmktoedXo9KmAfHGtOwB0nMhW2JC8vZUEKMMriP43BDOc0UKQT7YQf8zM50dP0vxKc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QL2ccZjnMUUEtdibX7vHH0Q6tHH4Cqxmrn/WLgsx76OXdesISL92sFFTCguAU7cd6nYKX4UvTgj7kTHsYFvtx8TFG8bpQFSUexbTqORVVB35p13UbvT4HqOmc6+lyaQq/ptt9/2ug4V8MlSWsFYBnQ/pVtpULGDUndgN1c8a7xU1/kHfgM063rsp+08sGiy1XLmUl4WozbCncxM8YnSCCPs9sWMTnuS7MYnmRBtQEvRGY+ZVoSwBs6mfd4Ky7hQ5eq3KVGiji8+BEqZPvWGt0tFuXtEuqFYh+62uFH3ZTSchKIDH/VBT0G88fK5zcaCEV9Gnvd/jCjE09UkwWStraOcygAqudFU2CCCOBBQfrnLaUZAznKR57dCFHmea8vmsjCcOdkbvI7q5kbwhpsx+7dsZq78/uhtHYHTyQGNL3/w66NxNVlcuq8TedxNDdhcs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:35:41.8795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a209de-63c3-4b67-1844-08deab28ee6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999070
X-Rspamd-Queue-Id: A87FE4D6223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284700-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

A new structure to report additional statistics from the firmware has
been added to struct ionic_port_info. It currently only contains FEC
related statistics, but new statistics collected by the firmware for the
port would go in it.

This structure is located in the same area as the unused
ionic_port_pb_stats structure, so this patch also removes that since it
was never used in this driver.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 36 ++++++-------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..01668dd10c0a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -2855,6 +2855,14 @@ struct ionic_mgmt_port_stats {
 	__le64 frames_tx_pause;
 };
 
+struct ionic_port_extra_stats {
+	__le64 rsfec_correctable_blocks;
+	__le64 rsfec_uncorrectable_blocks;
+	__le64 fec_corrected_bits_total;
+	__le64 rx_bits_phy;
+	__le64 fec_codeword_error_bin[16];
+};
+
 enum ionic_pb_buffer_drop_stats {
 	IONIC_BUFFER_INTRINSIC_DROP = 0,
 	IONIC_BUFFER_DISCARDED,
@@ -2883,28 +2891,6 @@ enum ionic_oflow_drop_stats {
 	IONIC_OFLOW_DROP_MAX,
 };
 
-/* struct ionic_port_pb_stats - packet buffers system stats
- * uses ionic_pb_buffer_drop_stats for drop_counts[]
- */
-struct ionic_port_pb_stats {
-	__le64 sop_count_in;
-	__le64 eop_count_in;
-	__le64 sop_count_out;
-	__le64 eop_count_out;
-	__le64 drop_counts[IONIC_BUFFER_DROP_MAX];
-	__le64 input_queue_buffer_occupancy[IONIC_QOS_TC_MAX];
-	__le64 input_queue_port_monitor[IONIC_QOS_TC_MAX];
-	__le64 output_queue_port_monitor[IONIC_QOS_TC_MAX];
-	__le64 oflow_drop_counts[IONIC_OFLOW_DROP_MAX];
-	__le64 input_queue_good_pkts_in[IONIC_QOS_TC_MAX];
-	__le64 input_queue_good_pkts_out[IONIC_QOS_TC_MAX];
-	__le64 input_queue_err_pkts_in[IONIC_QOS_TC_MAX];
-	__le64 input_queue_fifo_depth[IONIC_QOS_TC_MAX];
-	__le64 input_queue_max_fifo_depth[IONIC_QOS_TC_MAX];
-	__le64 input_queue_peak_occupancy[IONIC_QOS_TC_MAX];
-	__le64 output_queue_buffer_occupancy[IONIC_QOS_TC_MAX];
-};
-
 /**
  * struct ionic_port_identity - port identity structure
  * @version:        identity structure version
@@ -2950,7 +2936,7 @@ union ionic_port_identity {
  * @sprom_page2:     Extended Transceiver sprom, page 2
  * @sprom_page17:    Extended Transceiver sprom, page 17
  * @rsvd:            reserved byte(s)
- * @pb_stats:        uplink pb drop stats
+ * @extra_stats:     Extra port statistics data
  */
 struct ionic_port_info {
 	union ionic_port_config config;
@@ -2968,9 +2954,7 @@ struct ionic_port_info {
 		};
 	};
 	u8     rsvd[376];
-
-	/* pb_stats must start at 2k offset */
-	struct ionic_port_pb_stats  pb_stats;
+	struct ionic_port_extra_stats extra_stats;
 };
 
 /*
-- 
2.17.1


