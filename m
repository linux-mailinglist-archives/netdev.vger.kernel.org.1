Return-Path: <netdev+bounces-260512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JTcF7yenWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:51:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BA1873A6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D36A30FBE87
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A839A815;
	Tue, 24 Feb 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LvgO6j+q"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10539A809;
	Tue, 24 Feb 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937302; cv=fail; b=OBHh/46Y2LCb5/v81YelYqXVC6ZeFu7EbZBpqi5MZYyRvEp3fjM6/UVEm2pCYom88RNA5yYsVqj6Nq4KI+HtVsr//ZG7oMRVKRToI/jZuOIKm5r6PtM1FoQaa4dRZD/ZO59H8U0HhpFWJzXNZEfdB0T3lNGUJyvLCTOJ51htAZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937302; c=relaxed/simple;
	bh=nkqPY3hkyfxbd3Y6SPoqmLdYes4mIy5WVf8Ath0L8pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1+UYkTE4/9L1hgC7zaEPb+i/MfaJDbH1PRqK0lamcCdSPsHDWVUNyw8NvIcLb7lGWSHO3ZslYl1HP3i06yqnyvVBAxr+bQPWdWGD62JVbxKmpsj7c8+/yB5A5u2RbH7iJkhj0W/AmmrVbBqZbavBlQ49l4qBkmQxDKgh0YqrkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LvgO6j+q; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM0mI23UqdfQ3AEXsYY/ihpL61wC5PH8ic6t16esfzzMUFul9LmZr1AXM1D4Y20fPPlV1/dTzAYAvkTf6T3xnBw4gKe6AnIqcCyjrdKL/gtRMyF8PUsi0cJV15Fgq3cadYbdoS/D4gprBxmS6pe0+rTNE0A7HpB6EOJLc0ldG1AQXY8VbaPfMkvMSNvBz6uxl7bsfaMzl7FvMdYkLdeNpZXs3+5x6fdwUcx0F1F+deheGlOmXVFkXM+Jo595VlPlFVGFfQOpheTYVQz2CHhsgNRBko9hF20Cg9/7ad4in7qNu89MHTVQs77QvqcSfDDN05C8tJg8wZISpsbi/vO7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvVKTiUq66kwIOrVrxTEFiS09140fQYkdhfu7p4PMl4=;
 b=KMc5CZriS2thOh1GlYPvUA9B8wsBwKEtzZ3mU57Jg688BmZ5oqPboq9jIDXcNy2rAmAZd54cq9Yd/oH3lcGdY0SVOB8VP5AGbF6vzUqbGD7op9BW5t51XVODmgv6sB72opVaT9Z3uFzSEQ4K6O/iUZ83rsWNjCQf5nAErjkumHDPNv2c4a5alyxasqdpe3BEmtv3waMX29vwkWL2EuBCs20hml2LQyo2HmR5N/rv8lpewf+M7iiUq4xBEkc+c5g7jQ+cEo9ahw9b5fI0ASMB1EDMO0tYkXS46d/O2GWbKaUQ43wJUxnRU9W45LpKA6TviSuLmRP/XKCXT+M5WnT27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvVKTiUq66kwIOrVrxTEFiS09140fQYkdhfu7p4PMl4=;
 b=LvgO6j+qPcbjlaUK2zeLBI8cpTOtCJWHhHgM/kolB0qygy7P0y82vrMyahtYjZ5pAgqXRrEpU81+9lG+DcXF7jCNcVnpjSdnVNRmrO5QW35Ka7Ay+MsBDQQDawsRfQ9K1gRGtMg3Tpd/mWkPUcyyjMHVjBNNoh58CIZQVr0lTxg=
Received: from BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:48:16 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::7c) by BYAPR04CA0028.outlook.office365.com
 (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:48:15 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:48:13 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:48:13 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:48:13 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OCmDcf2747059;
	Tue, 24 Feb 2026 06:48:13 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61OCmCd7020536;
	Tue, 24 Feb 2026 06:48:12 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <haokexin@gmail.com>, <vadim.fedorenko@linux.dev>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <horms@kernel.org>,
	<basharath@couthit.com>, <parvathi@couthit.com>, <afd@ti.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v4 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Tue, 24 Feb 2026 18:18:03 +0530
Message-ID: <20260224124803.3634808-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224124803.3634808-1-m-malladi@ti.com>
References: <20260224124803.3634808-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: b0525718-d345-4762-c6fa-08de73a2fa9c
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PM11W0OpFDBsZ6qWgHVnUzxl3+fGhty/KHhjBvrf8eJBKMtBtBy/8L9GjRpY?=
 =?us-ascii?Q?XKAqm5wqpgOduPcWPn9hzpR+YpkhSXz9j6B6pOzPlLGCm2T8GjhEmvCIwRhi?=
 =?us-ascii?Q?ir9+Fn7HS+foXunaQEq/vvrABACU32LMNIzc1vHkONNw554oj7N013K1l0E9?=
 =?us-ascii?Q?S8SznAYspVqUEennMpuAfZeOKutgMn4+XlhM7uSlGM5IeUgMFlAWNP1oUDbg?=
 =?us-ascii?Q?NGIhApoPdN5vxL77WwDzTPyIR/MwytMmF/Bv7lV00iYpnskN99HKU9lQQa+R?=
 =?us-ascii?Q?61wgfmT6//bgD+loN0qgMkzoeTTJ3mshH+gePHp9qFy9q9ICSAMN3Fk5YstP?=
 =?us-ascii?Q?05XQOHeRTWcIFNAldygIetJ+LkUqSPjCCE/rTtyWCz5YdZGmcN6RNPcIqMkX?=
 =?us-ascii?Q?VgRSKKHRVDcIt73RgTT058cMsmDWfoQ8pRhg0YZcPLstV3Hgp9QjYkL/sdQf?=
 =?us-ascii?Q?lnhZVz1qWwbvjJHdYpFyXufnZPvjPDbtP6lLmDmGiRu7bslXrLZG/u5S+6cv?=
 =?us-ascii?Q?EiY4LPWPo2qlKr8FvxbzZUoe/rjHF/maYG5yO6jpRTxVyd0Qwk6pd2gXDUAV?=
 =?us-ascii?Q?zLY1b8491lYWJQvDwaToobgVnpeFsyhnJALG7G5cxW8GWoTD8w6vwa2j+2t8?=
 =?us-ascii?Q?WhehMjghpSnrfEXS/KjlsI7eHe9qyr83elcVd815H3UKFEguD7JCXcGvHdj6?=
 =?us-ascii?Q?RTGMW3qtZUIHS0dtAZbeigKrJwouTu+t6pjjYeGvfBfXAZKddZpdYPUZQGAl?=
 =?us-ascii?Q?BeYYWtr3CuvBk7kyQvGbH6Wei2k4hpuavFB4hj8Y44wUqY3qhM1DaCNbvGTw?=
 =?us-ascii?Q?IrCwjQsxjw81+mKZQBHTb8KlA0yrNNWTRlE3ZV8nwFLESbvHDAfFE3O0uv3D?=
 =?us-ascii?Q?e9ohd4fAqA0NK3AEkP4NB4L1XNfDXgwSu3aZ30B0cOFgZ3AbshyjVAbtObwt?=
 =?us-ascii?Q?klvXRO2CEfVC8LpyPpuzroHnuQ95hpozirPXCuKNrZb0nQOb0A99UhGcFlt5?=
 =?us-ascii?Q?l/GnUiW6X2MiqW67R7ObBsS4q+MM0MkpUMKXlGmnuH+hH7beslQfCeMkJ7Eg?=
 =?us-ascii?Q?MHAJetWzQFuOOt4woN3rjct1JCgvfJcWuUFe9YAar/j9R8vztiiIgm9wyyik?=
 =?us-ascii?Q?iPkq9rzVMgtvV81h1DzsQsxPUgPTdirxqrzgOO2L0qQ9g1jXyolcEI9QUPYj?=
 =?us-ascii?Q?R/gC0hjdbXXpbwiSFdhhmg5RC5y+D96cTN1i5aMvClZB47ZpekUy+aOR+IWT?=
 =?us-ascii?Q?bD/IgEl0rCYvGbgcEmA1/eoDJO+RkH8A8sAsQDv0nH9NpOQzudW5ceYGvPe+?=
 =?us-ascii?Q?ZEz9v/dmiYThjkEs8C+fIX/k9kVuQtVNtYWqAeOoIR0DOZq3ss4Mes8/ih0d?=
 =?us-ascii?Q?qImNgf3SCh4X9DPR28O8BBNZcNbO+fncyhFN2c3faZSVfUOexlDxGyhjna3G?=
 =?us-ascii?Q?WksVVYzvtlbfWH/cfAbT7tT86XDZUFO+ICOerYFuE9K3ijmEXRtE4Wqq2wsz?=
 =?us-ascii?Q?lL8EscW4nzTljW+LQN77DPObtawIuK3OcvpvIrBc/GaxGzkmg9UTQGI29rv8?=
 =?us-ascii?Q?NRR1A5ASzifunRGX71RhMtSnKOkMwxt7PBJAkdDv4MP18EojNdZdFluTMIpy?=
 =?us-ascii?Q?qrbBIchrc3ihWlfHP+9kFXViwRe6WQlQjrEQYuw/1EjFhL5pDBhhClz5D3/q?=
 =?us-ascii?Q?9UVywFW3EADJmCwXHDX+zmESXpw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8gqmdcvgoIgFUjN8ZnCHLlZ5V7ssfYKIbn427sAfP+1zt5XCJrPEHU787ADSQhPBatJlvFHGhbSZKpoJO/sQSFCeFKsNPeffzoHegFMk9iwLs9JTpBrwVM4dlD3wY9CqsDZCjGGw0/imjLbvtDIfYSvUYD089GWgr6gP5UfMIXd9V56I4yH9bIczcwPsZ0+E4yh2Z1I2h/B0PJ25KsDq0CfFHp0wg9EuALBREejXEDnOVbMQmW9KRlU2hTZqn6UgD+5u3+vQ3NLu+rw6Yu03iG6MlbcyBmFFrdr3eLYQGTJKxVxk4OQ30PcfeYAcPhA6NQ16vPXs/ocB1YqVIvXnY1b9dxlsn4j9/oHXFT9x9CND4unYJPw/A9gtVTTX+NSx0BhYEeA5rzHXkIRfUKqC63Ue34MKaPmHbKXzFYp/a1y6UvmFqe1OAiARzlSx6oJ1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:48:15.8298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0525718-d345-4762-c6fa-08de73a2fa9c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,intel.com,ti.com,kernel.org,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260512-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: CE9BA1873A6
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

Add driver support for viewing / changing the MAC Merge sublayer
parameters and dump the Mac Merge stats via ethtool ops: .set_mm(),
.get_mm() and .get_mm_stats().

The minimum size of non-final mPacket fragments supported by the firmware
without leading errors is 64 Bytes (in octets). Add a check to ensure
user passed tx_min_frag_size argument via ethtool, honors this .
Add pa stats registers to check statistics for preemption, which can be
dumped using ethtool ops.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v4-v3:
- Added pa-stats availability check inside emac_get_mm_stats() as flagged
  by AI-generated review.
- Return -EOPNOTSUPP for SR1 devices inside ethtool_*_mm() functions

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 98 ++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.h     | 20 ++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  1 -
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  5 +
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  5 +
 6 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23a..2176536a0989 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 
 static void emac_get_drvinfo(struct net_device *ndev,
 			     struct ethtool_drvinfo *info)
@@ -294,6 +293,100 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	state->tx_enabled = iet->fpe_enabled;
+	state->pmac_enabled = true;
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	/* 64Bytes is the minimum fragment size supported
+	 * by the firmware. <64B leads to min frame errors
+	 */
+	state->rx_min_frag_size = 64;
+	state->tx_active = iet->fpe_active;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+
+	switch (iet->verify_status) {
+	case ICSSG_IETFPE_STATE_DISABLED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+		break;
+	case ICSSG_IETFPE_STATE_SUCCEEDED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	case ICSSG_IETFPE_STATE_FAILED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		break;
+	default:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+		break;
+	}
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int err;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	if (!cfg->pmac_enabled)
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+
+	err = icssg_qos_frag_size_min_to_add(cfg->tx_min_frag_size, extack);
+	if (err)
+		return err;
+
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+
+	/* Re-trigger the state machine to incorporate the updated configuration */
+	if (iet->fpe_enabled)
+		atomic_set(&iet->enable_fpe_config, 1);
+	else
+		atomic_set(&iet->enable_fpe_config, 0);
+
+	schedule_work(&iet->fpe_config_task);
+
+	return 0;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (emac->is_sr1)
+		return;
+
+	if (!emac->prueth->pa_stats)
+		return;
+
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +410,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 37de534e4d43..d9f95d6edc8d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -45,6 +45,7 @@
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
 #include "icssg_qos.h"
+#include "icssg_stats.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -58,8 +59,8 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
-#define ICSSG_NUM_MIIG_STATS	60
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
+#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
index 653dbb57791d..bf84cc1b8282 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -57,4 +57,24 @@ void icssg_qos_link_up(struct net_device *ndev);
 void icssg_qos_link_down(struct net_device *ndev);
 int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data);
+static inline int icssg_qos_frag_size_min_to_add(u32 min_frag_size,
+						 struct netlink_ext_ack *extack)
+{
+	/* The minimum size of the non-final mPacket supported
+	 * by the firmware is 64B and multiples of 64B.
+	 */
+	if (min_frag_size < 64) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be at least 64 bytes");
+		return -EINVAL;
+	}
+
+	if (min_frag_size % (ETH_ZLEN + ETH_FCS_LEN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be a multiple of 64 bytes");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 #endif /* __NET_TI_ICSSG_QOS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155c..d27e1c48976f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 #include <linux/regmap.h>
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67..f35ae1b4f846 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
 	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
 	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
 	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ec..855fd4ed0b3f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0


