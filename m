Return-Path: <netdev+bounces-286960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPvANoXDAmp7wQEAu9opvQ
	(envelope-from <netdev+bounces-286960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9D51AAB0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE8BA302F74A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965F43635B;
	Tue, 12 May 2026 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pxr9sAKw"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CD42EED1;
	Tue, 12 May 2026 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566015; cv=fail; b=KjOsdnnNYxaTIX+wkthkvsqGjbLVrXx809pCJmAtjDOcotpQnrfvv8arAHZd9gzL0RR5SgErf8N0cJzcUKmsv4tEY5WTCdpB/Ptmux55iu5RVC0JXE0duSz/9stqAcD4J7zheGE7OKpc5dxOAnEq87fRf2HozfRTKCfpUqOUBvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566015; c=relaxed/simple;
	bh=Q10Xu7QXiuCsuqZ6+LK9+il4OTqCTBYXAqTh5LfTSKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5+eEJKCyAYI3E3nWrzHs/epWrKgOfA8ygBSq4pbZnhg4ov3+fehy+QzFlMtIxd3RtGDJ6+MuWACwhfgHzKbTicebYFPQk5d10Es7H2+0H98v2cuekNGv5gsJa3AF7t3Berq5kwwf3WNHUKKfw7oQD/5HP1ltYb6Hi1ghWj6wwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pxr9sAKw; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FskIoMQ9Ru2wQZS+fQ8OJwejEdkXFd/45naxZ2Q/R6hQ1xjIJQgoV8AEQOYU5hdcXaXYAXWlwNrtDHfCIMu2be5y2Ka8uLj/jOmVkZLMKyqErsw1oXFUQBW5NZNUnlMKhvV7R/WUL1ovyZKlr49QwhGTF4xEC/bzPG5NmUV658JjQznfj0is+wKRbd03JrXzYsy1h8YAkAAMKcNI2lFQDeG3KXz92REjJmBaI1+rphoYYhyVVGBt5otsTgWZVlvWCif2RtM9wmlYSWxPUCLokxHR82CbV1p3G2Wnc3DmIJokZHoqG0Cdd/Bz1FVF3JQD2CgnZXFQYsVSbGp5EWX//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhV5pZU1ZpCho63/VsNyuPlp5eR8q3Qx50F4hklB/Io=;
 b=k5HzFkDmmwmnsmcF/cOFoKHWtBw4gawm+Zwyu6loJdTn9mZTzFHNAEDrT4wxJlHi4nx4UnV8UbthnKJIDTw/uqMGZA0Df8sz0BzySGMlxut5cR3luMKYVzF4RdXON5KA0ZfEsZ9ocwZt49YQUCA6C6fl9GI+y5aQsYOHEIZ6UedBaLZgYJ3bSWX2jXyiKl/tPYEeU/l7O4SjSpySJnlgTT3KnXYjLCS4Udo2saV33qZLqbqunCT7yKWSojkspOy79VQ4rdJrf7riYJMOM0JovvA1Pf5icve8segH9OcxiqXiwJEROkUXs6MfYoZpEH9rzdQE23sf7RoljB/Zj7NH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhV5pZU1ZpCho63/VsNyuPlp5eR8q3Qx50F4hklB/Io=;
 b=pxr9sAKwZA1VGUxSKGpZgjiOHPGieuE1YCwcoSQ8y6BYIJpWlR8CTD9710TMr2grRKx/HeVKJjf0ir06OefUbjAMLP6Ch0hLo2MHLx3aFcA0JXQeXWUbW1ci6lvrNVN07A8Wu/fFzrLyzSShKwxkN5jjICTObrPB+r26bt4qU0c=
Received: from SN7P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::28)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:06:39 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::44) by SN7P220CA0023.outlook.office365.com
 (2603:10b6:806:123::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 06:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 06:06:37 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:06:37 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:06:36 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 01:06:36 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C66aVO2904985;
	Tue, 12 May 2026 01:06:36 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64C66ZYj031935;
	Tue, 12 May 2026 01:06:36 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, "Meghana
 Malladi" <m-malladi@ti.com>, David Carlier <devnexen@gmail.com>, Kevin Hao
	<haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next 1/2] net: ti: icssg: Derive stats array lengths from ARRAY_SIZE
Date: Tue, 12 May 2026 11:36:26 +0530
Message-ID: <20260512060627.3781329-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512060627.3781329-1-danishanwar@ti.com>
References: <20260512060627.3781329-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e2ce6-9e52-476f-4a67-08deafeca095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|22082099003|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	kL0mPGLxqAAMOxULR5TTfnztJGNYRVEjVVAlGLaDiJfpo+ZUDyGk8LX9OFSLRUyM8TESFrfgOuhGdXj7ozQgJw1RDPRh7WIbf1fT7Xjext3+kcK47/hkq497oOS08bIV6gxGLMeaOopfrYjjarmBzMPTwMQQGvTlLHV11lvzJWZo+dMrX73kmzKa+y3qGumtPsg6egnIHwwpzlWZKm05NDvaqgMa85fif+e94s6qs41viHLvkRgA2enbgPC05+VxLRJona+f/t5FGLPl3ZaYCsK7CkS51aEqwQa+hTOQKgCHnKnYSNTMpAeyAjt/VHIvK0esaXFZZy81RPExpSMHWltLmLCC+q0SCepx7T7ahAxgp6etlqkfxylq954iPoeyzrgd88TB6CiaNVonAAD3AaKb3HBQiqkVD6UfJRXs0T67qFVlXJtYebky+PRqS6g+QeBbdVLL7Gw8NX5Gu/6Y60c/wKWYJ4lm8BOMKGLlFeRIXSocgardXuf7ywdDlvph5c8V0SevfE2HolYUmP9AGLxoIkENWNiHAXHjyMmPFt1JMUdYEIcFHwfJ6YUv3T7T4LiNieziQ5OK4B4VECQDDlYYw86mqHO2E8nGpK4EGu1DjcUFgeyty2ij7fCvoM4c62d2m/tlupf4MykUdrO/9Ipahqg6u6OaA+o/mkaNIsiOTcfge7AUbU15gB7CNOLtQZleRrknZb7Udex514HxhJ73uQuBT1jHVZBqM0gvLzyP0XiRulLS/J1Lx2UNGOmYSfgMrES0ILOx+s5WC1KNew==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	djaagVge4xpEjQCHjLm9PurYKU/Aiad61asaSu/cAVgta0rz9GOFCZU67G6j7STX83g6thehFpZjtN4IjTa9Tul7/bcLKGAIX9ekg82wKVSfdA92DRGcUQi+YCq6n7CbkuLuO4Mw3XQes29VDu4+60vzEwGt8plyZSlZYyl4+wJgQOxK0IHgAEQa3gykThhQ6r8IQrnBRFCpLAJSwNmHVVzWlZujj0F+SdmKFC+1ss3ovDwI3CBMc7mduzhsxj8fA4YCAxpHoQx4/suarrx668qN2OeJeSf77i6dMS0mEaHpoVGhKdrb596qUg6FIIVj8rV0YKDFDooQeRFjv7sJgAEMth1Xhu2vidoo5kJ5ZesFCOh1FNiMU5+t/lmLVoZ4s4xm8DjkFjaPSLZDCfMAUQF8Vg31vh1p15dNOZzvPm+UXp7/ywSbRwMaGAkEWyab
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:06:37.3736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e2ce6-9e52-476f-4a67-08deafeca095
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Rspamd-Queue-Id: 59C9D51AAB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,ti.com:mid,ti.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Replace the manually maintained ICSSG_NUM_MIIG_STATS and
ICSSG_NUM_PA_STATS constants with ARRAY_SIZE() expressions derived
directly from the corresponding stat descriptor arrays, so that adding
new entries to icssg_all_miig_stats[] or icssg_all_pa_stats[] no longer
requires a separate update to a numeric constant.

To make this self-contained, break the circular include dependency
between icssg_stats.h and icssg_prueth.h:

  - icssg_stats.h previously included icssg_prueth.h (transitively
    pulling in icssg_switch_map.h and ETH_GSTRING_LEN).  Replace that
    with direct includes of <linux/ethtool.h>, <linux/kernel.h> and
    "icssg_switch_map.h".

  - icssg_prueth.h now includes icssg_stats.h, giving it access to
    the ARRAY_SIZE-based ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS
    before they are used in the prueth_emac struct and ICSSG_NUM_STATS.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 3 +--
 drivers/net/ethernet/ti/icssg/icssg_stats.h  | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b78..e2ccecb0a0dd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -43,6 +43,7 @@
 
 #include "icssg_config.h"
 #include "icss_iep.h"
+#include "icssg_stats.h"
 #include "icssg_switch_map.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
@@ -57,8 +58,6 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
-#define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67..b854eb587c1e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -8,10 +8,15 @@
 #ifndef __NET_TI_ICSSG_STATS_H
 #define __NET_TI_ICSSG_STATS_H
 
-#include "icssg_prueth.h"
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include "icssg_switch_map.h"
 
 #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
 
+#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
+
 struct miig_stats_regs {
 	/* Rx */
 	u32 rx_packets;
-- 
2.34.1


