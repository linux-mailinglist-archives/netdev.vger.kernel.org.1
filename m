Return-Path: <netdev+bounces-287853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHhrEl+ABWrjXgIAu9opvQ
	(envelope-from <netdev+bounces-287853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646353EFE6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D86B30440BE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88DD3D9035;
	Thu, 14 May 2026 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xNahIHbW"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9153D75AB;
	Thu, 14 May 2026 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745379; cv=fail; b=G/04QfRPIXGF35XKr9jLIqxGWWhGdSMV3ST0L3OEDPy42QxPGRf2lSuV01xp45u9k2Mukgaw4C8ZRhDohQWjc//sXoBjJzBICOvE4RmGNByqKx3x4Y6UFCby3cKpz9qhVMAVqDj/Z1noyYxxlzrUegR8bMMUSyGXDbW4R8EuAMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745379; c=relaxed/simple;
	bh=RgWw6N+GUTqiPzG+IKKc8WLzxW+3q8vlaRrRbTV5rLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gojwuokhU1A7S7+jqPo5mg8kvfhyMrQQbsigQ96Kt9hp/9EmB5VS7NTLbNahCYQnIpi7aXJK0ciTBeYdgLrRF3t3A5Xphp9+eE7N4JqYuHUMjYudC8JY5IEXOOmd0lEIlyKaLNxiNmczgDGQNdI2M+TH/eyusouMa+SJLDlj/xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xNahIHbW; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVyQde6yrtg6Jj5pAT0sBcwByG7QxIgL7BD54lPgp0zwtsT1bhgPKIRIOOcczIu0ylcKfNty8Leyh+NpLwh6/PLA1iziGk5LkMdJqaOrW9Vp76s8ngsxnKgyQ8Ekem2Y9RrIZGikhgYDZ5oZgQ3N2DRMbTEDYns2157eUtGkvw9XLAfUIbWtIuY0qMNUw1imKDyTAKuRIF90bs/dTDQsedjWJ11LqhuoJ9JhXzr3Me5OHnwM4/dOqQfulVzrceQ3thFA/WlR9786o6Rk0wyaUT7TE+Rv3dXdpw2F3Sb7aYUCexKmKOnFTfssOQfqn/Tygj0AkJkYb7P45+6Foifd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrX86sNzOKRKt3IsfLR5jRnt9vCJ6rEX/adYhxJUdvo=;
 b=F7OHwuuPWFZBAosWVsK8tR2GLKa8SkgcM6I+jsht1bVv4LH2TwKRq2rBoN6C6jymUYxMtS6kQiOLbbPmzySoimbPzQK17aAHuODf3oX2jKXvzrn9DiUkZ2ByVnTzywkneAVA/ozlkDSUrziTsv1mNUJx9DpnmqOjmcv4AEfnwY/LR2g0d9O/QcF1yRYt9CN1QqIHoUWkbU64LXZt01HtawQCErT1ZnhEtv/5USvACiNec5QG2rYhaucDVrDaIICE9jIJexHP4R4WoDOM6s3Weax4cRfcGyPUV+BCgtdNfoaPuntl4dXtPs/Gn52Oe+oIlMAQOjQPjX1xn4IXYBhQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrX86sNzOKRKt3IsfLR5jRnt9vCJ6rEX/adYhxJUdvo=;
 b=xNahIHbW4wye0uVogkDLZX7x29yPVHBVMTJMFcaO/DAPNKT6Zzc7u1rEVHx1q6+xLUXsXDQjZ5SGl6CAh4UshscDwdE+/GUNvG7hmqgi42pQxeOSok0HGA3mHsjaHEO0fEUdU6nDgQQGK6GLf+umNXr7sl3geHfiC9vVwVw3uFs=
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 07:56:14 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::2b) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 07:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 07:56:12 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 02:56:11 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 02:56:11 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 02:56:11 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64E7uBEh807596;
	Thu, 14 May 2026 02:56:11 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64E7uAlR005244;
	Thu, 14 May 2026 02:56:11 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
	<jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v2 1/2] net: ti: icssg: Add static_assert to guard stat array counts
Date: Thu, 14 May 2026 13:26:04 +0530
Message-ID: <20260514075605.850674-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514075605.850674-1-danishanwar@ti.com>
References: <20260514075605.850674-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR10MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 530c96a9-86a4-4462-bbdb-08deb18e44a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	3680iybITtBWy7EPZ0rKcCovfsmz8SdSsP1vV4+ygYhONNaEC+mVPv4U6SZIxfluNc6TW/g7uT5dx87S8Nksv7NlkkV8cpTzh6oDQj1LkYsPMhmYqt7mmKpcH0LnblkNjDnoskBcQN9s6X/VyrkhC6auHaC+azn1KyAhD/+WX67+3Jmgexl+GRAFUs7Te6QMqJDVxKZuM7oypkaiYKucgX0hxq1xM6Q2/Uk8N5ZHDzdmQOPRAw974L3e+wpAqcsAVmZZwE+8HhAtZjNQvFaZ0YmXScRXYfNBboVMQyazUVCA1kGT0BFrNSj/yG/XqpartGMvVf8bdRFFrkfPQ75Vi5mr+yqAV45+5UQcVxUU7MT+NteV7edAqfuV62UxP9uaCPP097cRrviRApKouLpktOxovTj/wGYejxZ8i9k/qHQIkoJb5aUvlbKAzazJ0+9XoMsUZTQVjsQ91tiivbHdewl4qbgCr4vQIMlncFvxEKrXYGzlSf/NiD/3xFXBS+QecrL9wsZSCkvBPmcpW2bEvwB7EByoyg+1tapBPjas+pHSMzhkJxzu3+6oVJEuacG18K8Osvv1XfJ+yAHBmXfStkboaRy/qyoynDtLEVDN9mo6e4II51jOSIklW53LAV7MR2+f9GD1/cYxQ5IJ4sssFM/3zmEnHuDYcIChfuySxrVs4VyksX9NRn4OxxRlK61I/qo0J717lmabZp2OtuVXVRDs/FoClI+pt3K8mQdet+lPj7tjUOn/szIT3iriRFOgn9c9LZFXU+vC4GQdDCA+Uw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E7oIV0fkQIII/DnY+IdZQrVKS8inlH+v1LiVo6R+suZMkVWZ9ezzJstzYACveFCI5c+oJNFCcOAetWQnnbdtQl0pnx7e+OX+FIanpym8LcchBcoOR6cT1JcnKTkstUohXcJBdAo4mv/vBkIdrsYK6dekU3glEuevReUndqHj4SCy+n3SIrHxBa6kHutTUqEnsY6bE1mtFdWY2H0+BkFZqJpmzDyaEpOzt3L/xOl6wIYin9TnSgFwWPmzkRvuvvJpXNvmaBqOWYug+0GM16FF11Z/nPy5lrOTIxMBN5X1RtBXeCNjknnzmTd/2z0gfNaR6O7G7aUXRwJi4RsRLfNqIlNrQDBQmom4aCb7mYpgHPSFi6OsBIkRycyT2DoIIkcVsj1sZQNzIL9hY1U5RD8DCWyhLRHcksrvnaUIrkG3oLM2W5tnc1pbyMGiBEpTJD5u
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:56:12.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530c96a9-86a4-4462-bbdb-08deb18e44a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Rspamd-Queue-Id: 9646353EFE6
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
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287853-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Place static_assert() immediately after each of icssg_all_miig_stats[]
and icssg_all_pa_stats[] in icssg_stats.h to verify at build time that
ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS stay in sync with the
actual array sizes. This turns a silent miscount into a build error
should either the constant or the array be updated independently.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67..6f4400d8a0f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -155,6 +155,8 @@ static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 	ICSSG_MIIG_STATS(tx_bytes, true),
 };
 
+static_assert(ARRAY_SIZE(icssg_all_miig_stats) == ICSSG_NUM_MIIG_STATS);
+
 #define ICSSG_PA_STATS(field)	\
 {				\
 	#field,			\
@@ -201,4 +203,6 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
 };
 
+static_assert(ARRAY_SIZE(icssg_all_pa_stats) == ICSSG_NUM_PA_STATS);
+
 #endif /* __NET_TI_ICSSG_STATS_H */
-- 
2.34.1


