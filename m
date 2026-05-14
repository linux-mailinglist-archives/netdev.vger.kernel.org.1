Return-Path: <netdev+bounces-287851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ7hBDOABWrjXgIAu9opvQ
	(envelope-from <netdev+bounces-287851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:56:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5F53EFAA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588D4300F122
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020433D810C;
	Thu, 14 May 2026 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vJh+hFY7"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F923D0C09;
	Thu, 14 May 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745378; cv=fail; b=LVCedEf7r/w2JJVb8ej9SyPpVhFVN5uIqJU0rBlZ6zd6mx9iRNDff2GGtuVCgFEZiiQGtPKsrBIiabf68KjhGBPeeWN5QFqa1FfgX33k6DUbRY2UvYsYOxqKbsEyRRJBAWkrezkQy8HJ7lhbeNDtMUyQtbYF5pSO103lR5VcS/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745378; c=relaxed/simple;
	bh=ryG6Nz+cgRfBbW0H97hSfOX/7PHH+DuDPn3zQGjQDoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnlNaBaFkM61UBdB5OjHsLQPfB+BWZHhBmPx2+Iip5M5AzPCex+hBDOluymqvG8LB4Rf84nb8udC7RSVrcx2afUc8OysAuATTb4u0XOFNc63ceOmZ2vb6hporSBwaeh69Bvz9aayOYtW8bcUtHV4ls6po8ThALaBtGuxFhq/QCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vJh+hFY7; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc/vmwm0yF1tlOFZZHgvHLiNpO1WxUjqQlDpN7otQIKAS4r78DRnXAk7NjSW1AUon8znWjDgwSlHrsV+K1CAfh7qgWu7zkQzmR8762rpn4uj/efPNNBQl31qqRdeiSjRyoEuBl5R69S8Iy/H9U428mW/qOqlOUKqG2tlCmEosi4OXn+j72DLAzScPzLiRpc0Sj7iWWRZbz7gYHowuDICpxRH5E9/gw1oDwRXbxb5B0DYVjhDEYCU2gv15EK79ViIVwc4mK9IsS0yF4bF/JIh1hQ8diHPH93Dm3rlCES/EeC4mZhaJZPQEDfG/q44+pc02aojwDG5mpvVyUtLPPv+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AByE3knXGGR5RSPvhYZEDLV393rLUke45jVF8IEqOGg=;
 b=dxlDrbQhs7aIpOiAs3cALyy9GNuAtfLsUJGUVjYjrAvzxcKj10NlpmBmbZ+++x4Y98bButV3BiwklhN/YuiKpaVQOiJEGbOs8qnphIsMw1sd7mWLfHQvc6E1ezgn0VtDD3Pztweurt2OULHImoeDzNRBFBe7SjUY9CfNfbwCMECa39maL8Ry6vOWCQ0mDJeJDkcbwLJQoZWatuyWgqWF0Fcl5qWBZAZfxAm+01HhXecEmPu2Wczvrq8aiHArlB1RKJmhHIBwuwZP8NeeJ2dWQwzfW1BJPWPXIGgQWMALAWtdT6PB8kMQZlo/EP5kq8IhPzIcL1gxrPMTxtWGFK6yXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AByE3knXGGR5RSPvhYZEDLV393rLUke45jVF8IEqOGg=;
 b=vJh+hFY7bPslOwt6OoLXq1KvuLQfjI775UDpIhXojUJNEA3ziwL56bk6wePPkRVVSdnmQhIeBI6g1h/IOLPza4QoK1OjIq87TVOHsPfz2RMVRWpaJ6mi5u2ekPqZUqErZ6Vz7h7ndflduSemAb8/wsSiTxLg5zEo07FMbz54VTw=
Received: from MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 07:56:15 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::dd) by MN2PR14CA0004.outlook.office365.com
 (2603:10b6:208:23e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 07:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 07:56:14 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 02:56:13 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 02:56:13 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 02:56:13 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64E7uDqb1745472;
	Thu, 14 May 2026 02:56:13 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64E7uCOv005249;
	Thu, 14 May 2026 02:56:13 -0500
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
Subject: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA statistics
Date: Thu, 14 May 2026 13:26:05 +0530
Message-ID: <20260514075605.850674-3-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: e77ac3a3-7fa1-4d9b-2c2c-08deb18e45b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fuhAuyFbsEzShNbJPABmT6SfPy1VwWfyL9Ohq7HqG0RIlW6MyrAdxuBx1nQ9Qsenid7x8OFNLNXdRVDh7NDsFswo/tOWkb22PheYMivkYUncNpxztVvmL12CO4CaDDBB1kMs1jVEribItlc4eMlporMRCYRqPIvIEg0y9rFMwyJgoSXxVaQdPKkgLMlqWi1DM5iIXQrQ3RdUG66byndlqIpBDwF6vkZZYYCU8dSX1nbaB1eQX9rNym27C5s9njljsN+ZfSfVQ6+hT2DJhfdoyRkhC6/WS2aMmhYFV4FkKHNb5voMCU7TNki0iKhuYgI8oyn2TkE7PbnM4Age+gDlwsEmIJ0PyI7kg1XV4LT3QNs7S0i9cnt1hwdeKDOl+QS5jUlWm2CAcGjXXFjwth7tGHOB15HhURSFl740a92CmnmAqORCryIWH27FphIkiGfoaza+SQRCRK+qC13Ff6U16GnQsr1ylDW7ny5oqAp11k5FpFMWNCE/staai5LTTQygAInw5i5Cp2H1nI90LTc4/b+xIB5165HN1AMLkDO0iKoHGB9Bo80eISnFLvkN6TNR2rbMR3hBDCv+h2DEvxtKo/aIOfWyG1OSzpQFcu1usiadKwxuyjsiAwtGWrQ29gu0hTvRYrk3Xm+sPe3BVOJDN4IfPtO4ifEW6joTGEcIDe//GHiLqHEuFny07v1q0Kcp6EfXYiLbh+7aDszM+C1aqk+DMWpazrn0zWtec4Pas9lvJa550OnXw+mMBPjXUwNshrgxVyZPg438gn9ZoUWeOg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BE19KIWZa8IDtTsFXm9y2QF6S4dhuPYeKK4d11fEiivrPW2Vw5S/NuDTypwhP9IgkIMNQcps9K5turgFjz7K3e/r4mJUV4u8aAYjemGr4UINnb+QN2aF0I4irLmjysVzoDetxTKvSI6aVuvCizRHmSdj85yElk1ddxMUb97c/pYwkhQQUEuDEc3HzB51RbvLIPcqbSuW6ULyfly/daXXQXKyGoxnzth8f3vK8oNn+iLHUYKqnfKCqhIyTngc+plhSxU02edyRRA2o8yYzo84p7COOswMUWjadY5vqKWj1zvGyIR7OamcJLReZ8zgmxX6KaA8Icm+liTpVV5MrZRbMNVtjsV4SxEFmw9/u24uO1CqAPbMYNjo10tBJMRwi7OmmHO+4LPgTS9G/OSoMrFITjsDrccaZ61s8+lH8ttSzeF+Q9rEHGBb1fRqZKAfV9NN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:56:14.4948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ac3a3-7fa1-4d9b-2c2c-08deb18e45b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Rspamd-Queue-Id: 60C5F53EFAA
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
	TAGGED_FROM(0.00)[bounces-287851-lists,netdev=lfdr.de];
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

Add new firmware PA statistics counters for HSR and LRE to the ethtool
statistics exposed by the ICSSG driver.

New statistics added:
 - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding path
 - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress path
 - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
   skipped
 - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detection
   counters
 - FW_LRE_CNT_RX/TX: LRE per-port frame counters
 - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
 - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)

Document the new HSR/LRE statistics in icssg_prueth.rst.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../device_drivers/ethernet/ti/icssg_prueth.rst        | 10 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c           |  7 +++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h           |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h            | 10 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h       | 10 ++++++++++
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
index da21ddf431bb..b0bda7327b2a 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
@@ -54,3 +54,13 @@ These statistics are as follows,
  - ``FW_HOST_TX_PKT_CNT``: Number of valid packets copied by RTU0 to Tx queues
  - ``FW_HOST_EGRESS_Q_PRE_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
  - ``FW_HOST_EGRESS_Q_EXP_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
+ - ``FW_HSR_FWD_CHECK_FAIL_DROP``: Packets dropped on the HSR forwarding path due to failed checks
+ - ``FW_HSR_HE_CHECK_FAIL_DROP``: Packets dropped on the host egress path due to failed checks
+ - ``FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES``: Frames for which the host duplicate discard check was skipped
+ - ``FW_LRE_CNT_UNIQUE_RX``: Number of frames received with no duplicate detected
+ - ``FW_LRE_CNT_DUPLICATE_RX``: Number of frames received for which exactly one duplicate was detected
+ - ``FW_LRE_CNT_MULTIPLE_RX``: Number of frames received for which more than one duplicate was detected
+ - ``FW_LRE_CNT_RX``: Number of HSR/PRP tagged frames received
+ - ``FW_LRE_CNT_TX``: Number of HSR/PRP tagged frames sent
+ - ``FW_LRE_CNT_OWN_RX``: Number of HSR/PRP tagged frames received whose source MAC matches the node's own address
+ - ``FW_LRE_CNT_ERRWRONGLAN``: Number of frames received with a wrong LAN identifier, PRP only
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4..e7a51a9eee24 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1633,7 +1633,8 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 			    emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
 			    emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
 			    emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
-			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
+			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN") +
+			    emac_get_stat_by_name(emac, "FW_LRE_CNT_ERRWRONGLAN");
 	stats->rx_dropped = ndev->stats.rx_dropped +
 			    emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
 			    emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
@@ -1643,7 +1644,9 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER") +
+			    emac_get_stat_by_name(emac, "FW_HSR_FWD_CHECK_FAIL_DROP") +
+			    emac_get_stat_by_name(emac, "FW_HSR_HE_CHECK_FAIL_DROP");
 	stats->tx_errors  = ndev->stats.tx_errors;
 	stats->tx_dropped = ndev->stats.tx_dropped +
 			    emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b78..60a8aedd334b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -57,7 +57,7 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
+#define ICSSG_NUM_PA_STATS	42
 #define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 6f4400d8a0f6..08b5ab6f93da 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -201,6 +201,16 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
+	ICSSG_PA_STATS(FW_HSR_FWD_CHECK_FAIL_DROP),
+	ICSSG_PA_STATS(FW_HSR_HE_CHECK_FAIL_DROP),
+	ICSSG_PA_STATS(FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES),
+	ICSSG_PA_STATS(FW_LRE_CNT_UNIQUE_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_DUPLICATE_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_MULTIPLE_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_TX),
+	ICSSG_PA_STATS(FW_LRE_CNT_OWN_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_ERRWRONGLAN),
 };
 
 static_assert(ARRAY_SIZE(icssg_all_pa_stats) == ICSSG_NUM_PA_STATS);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ec..bd2d54dd7f45 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -266,5 +266,15 @@
 #define FW_HOST_TX_PKT_CNT		0x0250
 #define FW_HOST_EGRESS_Q_PRE_OVERFLOW	0x0258
 #define FW_HOST_EGRESS_Q_EXP_OVERFLOW	0x0260
+#define FW_HSR_FWD_CHECK_FAIL_DROP		0x0500
+#define FW_HSR_HE_CHECK_FAIL_DROP		0x0508
+#define FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES	0x0510
+#define FW_LRE_CNT_UNIQUE_RX			0x0518
+#define FW_LRE_CNT_DUPLICATE_RX			0x0520
+#define FW_LRE_CNT_MULTIPLE_RX			0x0528
+#define FW_LRE_CNT_RX				0x0530
+#define FW_LRE_CNT_TX				0x0538
+#define FW_LRE_CNT_OWN_RX			0x0540
+#define FW_LRE_CNT_ERRWRONGLAN			0x0548
 
 #endif /* __NET_TI_ICSSG_SWITCH_MAP_H  */
-- 
2.34.1


