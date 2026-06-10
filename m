Return-Path: <netdev+bounces-297442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LtkQK1z1KGrTOAMAu9opvQ
	(envelope-from <netdev+bounces-297442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:25:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EDB665EE5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=gJ38Qlfp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297442-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297442-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95673037EC5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301E36729D;
	Wed, 10 Jun 2026 05:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A4194C95;
	Wed, 10 Jun 2026 05:25:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069123; cv=fail; b=gdfamY97lYDpPwgTdiB80cR27k+uD9IxkXayIE5IbKJN2IV5e6VQpP4d4MU5CvBK4ybI4O9c7+G+O/sZa//IFSeo1YwnJCSbx3ZCsuij+nU3MP9+5sVYJnPqGT0zh6TxwjzTnCUSJXYBdV9+OpOnhPvSlTkKvXxDXZiaE+T8CVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069123; c=relaxed/simple;
	bh=n4pBVl0woF3zgD1xqn+rNgnJ4L7PdQWX878u+g0FplM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEl57XTSSIhcfMbJtUmf3fLV7glKH7RSJ4CWBPxWNVKdBND0AZwMCO5gjGJDO496oV/tD/Vbw5YFBlVh1Fd1XdedTu7wu0BJMgnFuJKrzQ6UL+9VTALF3N5KAueeJids9kCWg8D4dj2DYNekJZLAIzaH9CHBVtKezEuI+LdwM2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gJ38Qlfp; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsL3SXIKJ6f6XFj6t7lnKJKaWDhXze2nkDKUU43LipcKrfN0SX9Umq+NPb/CCzaWsdqefWkPvWZ7JSpAqhvbiBnZXtbGAFEOh/LCa/wP0tQXKMVa68/yofAprga+qz4C7lLlcMJV6+E6ZQQr311Ewzdvr/GTEe4AdvRwcdyWSpclb4QAoLLHY+cqLI/XOGhoi3gL3WT+uE3pTiUVf4Pg4J7sqkzEu9aTmINSKmEZm1B0tKbWA5jEXwlc3i178KyBMAIelca9Tkc1NJij5zTsDb60x7StBLasNb/499i+FXojoxdmduJKN9DtCZdrNe+FoNKyRKLXd8rJ1ErQzKKwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF8LJIyIrMWj1aEvph/qudyLFoABlv7uEc9R6thIf1E=;
 b=sS83uABfu+hB1usUUqda5mHMGnLgUXPKGk+igDNGnTinRV76YY3rZslaI4IfMgTO+sT9jP6I+Ge/GruRuLA+nOLRNRArJbDOcdP8n7A4vM6PCV7SRvCL5LDQQ0WfhRBjeKfx8+FWqh0f8HmyZnmX7mqdbfQDX2P0Hmi+nYx2PpiAF//PDRjmo7H74ARmXY8PmguEmjMzGy0bKYNHGKw53zmE1lQVM1VUxqvLW4g92052MV/SHijHMUjIpBJli3Wod76CTEAZuOXCcl6Jrtqx7RvICPxWoeCt3unlexao+MzVajA6IPwzKhE8Qjk+gKAT0h15RDQMGsDkJKdQ1+RMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF8LJIyIrMWj1aEvph/qudyLFoABlv7uEc9R6thIf1E=;
 b=gJ38Qlfpw5GbB2I/gB48K15gD8+oErA7mjf8aPYKrsHJU8rjc1faN/p1IAU2wIuzkNQyIuGlL2eFMMauKn3/RfAbG2602MDN/TTvR8hNyI0P3xuINXPIC9AMa8MZSHhm1zF5vwIMkLh//jttQs5Z657s7Fh3ArXdATWjhCydD7g=
Received: from DS3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::18) by
 CH3PR10MB7414.namprd10.prod.outlook.com (2603:10b6:610:155::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Wed, 10 Jun 2026 05:25:18 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:45e:cafe::5f) by DS3P221CA0014.outlook.office365.com
 (2603:10b6:8:45e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 05:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 05:25:17 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 00:25:16 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 00:25:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 00:25:16 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65A5PGE92601652;
	Wed, 10 Jun 2026 00:25:16 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65A5PF97004443;
	Wed, 10 Jun 2026 00:25:15 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <arnd@arndb.de>,
	<basharath@couthit.com>, <afd@ti.com>, <parvathi@couthit.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v7 0/2] Add Frame Preemption MAC Merge support for ICSSG
Date: Wed, 10 Jun 2026 10:55:09 +0530
Message-ID: <20260610052511.781752-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|CH3PR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 52233a92-8cbf-428c-bf77-08dec6b0a871
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|921020|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IB1mqapmCWOjouGACvUQ/6s/eLNdnLqU0w4TAcJnfuOiN9Q+It9lH4GZqsiu2rYCgvhCrikbQq+lIZ8C1b0BKImzxREn8wx/K/BAyIEnp+vh6x/XLRmOw52FceW/qlMmd4O7162epFTdgE8B8Cj7YxRdMHPWtd9lXjLyHNa2YLGqWMq3s3ReJLJcnQPGh6vDZgh9vSjvNVQNCYKiddYkRxUHNF3p6j1xAAAugf4LZVdE7YsBkdnW0i3n/AIGRm/H03c9SZ5nIqFC2QxydFEcFxSZj/+4hXg/xlPeGV5DcRLguBfFyemes0RuDKVv6jorOxMjt7tcE4m5r5sgN39ZVpqh3qrjfkd0v17I2XhXC5zr2673wA8+FKH0rNbVE/0IIqxz7QT3db4CT/AlUHR4wRDveJhtH3FMGS6T5Ws790H6n0NV1yflFfk9ijFM1QkLxF0pCIHzqs7dPXYtlfdp84VfBOnBBMh0wdpCWYrFFj09fGUIJ7d0Cev4ZLyTlt6HwxMVOf7CSkL4vpG6IHgfh0/AoFlVGqvF5Qdnc/3cmW3Kaif9rTv58t2djDrLoSJfZhmtRZHE/OslAzhLCVhVRcyO8+myskFlaz2+H6X1VAZfgH+aAektvbNhNMkNGLtkSJzWV9iAtuIkIRHz+drzEIRIr2q4V6JDXS4hcWb6oMSUg0y4VSlveyw1/EDIvCk43xV4h9gKFokdV9B6xkwnq/5U8s5OPfcg0cCkX927q6SQg0ka0fUzmmdF0/bTXrbioUlcptbvpZXU9WYSXp+Oq3fEEYOLH6GQtOezKwh9CGs=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(921020)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rvu0OCJqFLgqV70WCrEzRSskyFVc0PV4rSi3hXTQLf58Qe7NvsH2ajRxJUZyuzx0liJhFMpn7zzrEKt8jnV0ONjNQqflTVI3cGmXQFkKgMi2nNrmA5C9nvWHt3c6WJqY0KGh7owPI+Rtep4JiuFEXQwUHuZL1KKeZ4H3FVN2jmHq0AQ4zlJ5n5FDhBA0qX9/JG9Rk1UNtFHm/nPvDaMGWTBm5Oprey9yeMSpmhhLVH/oQt459DD3jm8KF5KArH/YnkfJsGaD/mH9HwTvwtm8UQMm3A7hLAtNDIr1mNB6rj3Vtd1IWCh7Glxifp1M3yjSuBJO6dfwlpGJ61m0HOG8JFiXP9/pq6MOfbU37+Lp6o1/rbW0u40ZgEthtIeirEMhv48MwS9S8fusqHU9hATezLgWIyqquglU7w+5S7BPpAkCsrUDSho5vJZyONqFdbnc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:25:17.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52233a92-8cbf-428c-bf77-08dec6b0a871
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7414
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,ti.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:mid,ti.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297442-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22EDB665EE5

This patch series adds QoS support to the ICSSG PRUETH driver.
The first patch implements mqprio qdisc handling and TC offload hooks
so userspace can request TC mappings and queue counts.

It also integrates a driver-side mechanism to program the firmware
with the IET/FPE preemption mask and to kick the firmware verify state
machine when frame preemption is enabled. The second patch adds ethtool
perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
.set_mm and .get_mm_stats so admins can view and change MAC Merge
parameters and retrieve preemption statistics.

v6: https://lore.kernel.org/all/20260525182700.3135858-1-m-malladi@ti.com/

MD Danish Anwar (2):
  net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
  net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   9 -
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 100 +++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   6 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  15 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 282 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  68 +++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   7 +-
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 11 files changed, 480 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: 67ad35a58a88c360136d893cbc4c7f5b14100bb9
-- 
2.43.0


