Return-Path: <netdev+bounces-287342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C69H1WuA2ru8wEAu9opvQ
	(envelope-from <netdev+bounces-287342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD252B197
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7765310B663
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACF3A6412;
	Tue, 12 May 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="04I7d2fH"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265B3A641A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625894; cv=fail; b=iHfC6oL8oV8mY7DoDtvINii1Ry0+Ao2Y2xDAOOOvVK1yToKF2MKeZFxir3EaVy0XwM93Hkx1Xrm8nX+RGB5bl6kHahSuGKPXlYleXMXvctkLYLA4QkzvXF5SYd51vY6ZVpgQ5NPe6UoXintXi3EO9V/5wCAIcYweVFuNDiwWwQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625894; c=relaxed/simple;
	bh=rwJGA5Eo6HMXdk/NlbOCEREC7dN1bYP5PAqCesbcHR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxKxJPgkhuQXmJoTDtSyYzTjF1wW5yel209kCCFJ4PBVDMzg/sTPMHnZH7TYfZqxvuD4iS3InLkhWvy1mpxj3Vk2RbnYDpOVIgj62z2B9v8D21nn9sgDXdqZn/hk20+BfC1ACz0o3hUan+2dY9GX0gZaBCzX+vJpUWHGX4Yv4S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=04I7d2fH; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrHPKao+7HiLY4OGRnFd+HjWquTCEY5Bkkv+AApJ1nBOX1ogmbfL8Xd+w1rVWb4Qa6Qx274Fn0lKz+cgBwUKJsoscGvU8L5zkJhUAghpUmpvrXIQRIJEnsbDnuKLlvGJAMJiB/d/SOKEv7YqvfxyQKctVI+XJK+JvaNTRUZrCfI0sIEDq9+35UA0g4XUzQkd2yQKSGO3gVKVeDpfkHdvMYkHZHDpIHdovGY2GnUziNQjioXPzFfuzWZj0MUxSppBNKTsUqP6+sZjSPlUg4HFpTVl5ueuOEKhhBTqmnTEd0SFTmM3CtfTsAuYzSYmg1K+pDmsGwSjsiBB4JddJxDOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsEdR0sW5n7yBJcWyDtymV/OzTyjFyZRuUrtFm0CDnY=;
 b=Rnlk/1mrcVqkAEl1LNaQxkh9Y1h4H1TDWfp8d7oTMgLRonCIPCFnF+TEV8cmi83HVurLtOr7ZoXcPD9QiB+FCCEm0dPLHXp1U09k6i2inn7RRQc1SOPm4ayeBfJtoMKfxjgR0wNSAPoWEszaMUTgenvS5r3Nf1UDP0/3/lqR3RJ/ONCq6/QL8LqngfC9ZVRrHG7+/2RtnQ6qdUxNNEA9LSs/S5zUXzKryr34IIaAt/SUU1wLg1Gg0KRDGUkpwIjTUc5KZId9db+TCUO5o/N6mIGGjHvyc41nt3onBifFQGANeVY7gDMT/jsKC0TkRdclr5d8iPySvYP0ruL0Eariig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsEdR0sW5n7yBJcWyDtymV/OzTyjFyZRuUrtFm0CDnY=;
 b=04I7d2fHXSJd9yiw7Ko0ea4Y+2gW1zHfR+qH8lh6aFkdmsddPcs+BhgHImAvR8B1TQeaW7Y9mb0WczWHDTNi/Vn+qT8eP2ZTn/T4VDwyu57mGnZcKIDrP80c7XcviE1LgggkcMLyf+LE3XZMyP40Bnu6fmPwQ7fv6pnZO1/MdJ8=
Received: from CH0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:610:e6::34)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 22:44:41 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::9f) by CH0PR03CA0299.outlook.office365.com
 (2603:10b6:610:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 22:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:44:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:44:40 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 3/5] ionic: Update ionic_if.h with new extra port stats structure
Date: Tue, 12 May 2026 15:44:19 -0700
Message-ID: <20260512224421.25236-4-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512224421.25236-1-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: f172a32e-c25e-450e-d0fc-08deb0780e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	aI+8dQQ28FVcvbgqUNUkbJwF+lG+0ncASATrdCuDXCvK+yW4Qckf3nm7J3Rsg/SxY9z+N/huxieo6s9gez/zQWLYJ1ch4b3UsTnJXN7fk0EUTvIyM5ZWx+41eWdTGfnxqDrJ1dg5l2234AAdJXXixLDDOt+mpF2AaVVqeH3SsCT98f5ttLygFZJmwYiNaoojVJF+DTDV5GE3XRCd6+5P45DZR6dib93SE1CfJLeJJaPKXZfhAlf/bQjQmwBprV8Eo7hqbQipbbw57utn4YIf4nq0eblmfyP4Pf/Q1eUi0KilcDkKBbuXBbUD5HyWUCx+LnKpV1tdH6v6g3Ye7vvszeOgD8I9JlcP3Pe4E0HD1CaXFSHJacTiJGGH6f4gfFt3TzSP0t7tkuHn6KwS2uR4XhUVkkTx9oGjbrJL9dIm9/9bmORSrtjYHC5VPjNbB6fRy9+1YRMAae2cXQOXFzsK6p44F3oLuRwojbxhCy8v03RPadN4sPusfUnFyZ1oi6xqi69MEApM4/4gik8wpg779xTmjWuCFEoUzkT/sAoVJbtT8EY//apHyvV8dxoVaJzwMcUC1uDebDw4NN6Hydrd4Yj+CZWuCXUmyJKknkU0f20mb0Nts1tLae2ndrrsfwKsloAULGNXCfEIYHyyTigp1lrq3pMl//cKeC4jBImt4p7F1O/JPP6+phqziXiR32MadynsLIer385YNJo2DfoCSVnsZt+2U+8H5Zbf71PV93k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	30nrXCfG0b7+xshKcy0IsWknaFWj/rBxyS/M8urI8evxZkwB1RilCaVWuoBLcJXs5NH4J0gDq3SOg9ATShMTv9EktnLVyiqN7HXIeN2fTa8EAu29G0139sZsGrDifELiLojfS9nMLUvO6PeuV2sKoR6p/S0aQUmvmHk5/SVAm8JAPTE7OahIqJAGW74bhcgx/Z0cLquvDBNCneNvNkqQ9NhFV8NwhghkMOXfb2dq3mnjzmhIX451Mh6YfjVoa3OTme+k06keb3W3an1E/8fAFh4jkxC9T3l3DAF3vLdXUqj7+NeKJCcI5kkI86SwV4zcz+SlbAROOkvK96eoal4EdUEQsebMFAe4zf/YjwLCSkpdKCwB2nfvvpeQLRF3MZJIo1FbGrGQWLly04E8zsUrlv7BwkJcMN0ic4Uk2aDusXEjCGV63gThhkzwg9UI0oUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:44:41.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f172a32e-c25e-450e-d0fc-08deb0780e21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
X-Rspamd-Queue-Id: 26DD252B197
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287342-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


