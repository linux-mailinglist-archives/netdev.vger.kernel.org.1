Return-Path: <netdev+bounces-257286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMDMNfrlhGlf6QMAu9opvQ
	(envelope-from <netdev+bounces-257286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:48:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B005F68FF
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6776030182A6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C82773DE;
	Thu,  5 Feb 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lGRMKmWU"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A182EACE;
	Thu,  5 Feb 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317276; cv=fail; b=RFmkz9duUMogXaxMy/d+TyWnDs5hJ3n7OzkhPgc7WcbQxfwJtqLYtq5Iu5TWT67yMtjENqsE17g3cy2Skus62Nvk4lkQHOFgUWU82Wa6e8IHwVawv0+xprCG+X9maQgXnoF4G+RL/V3Eep5qGdRjfcm+0zrqZD80GMYanGEEXwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317276; c=relaxed/simple;
	bh=nzqSeqMB0nDOul6bV1qV5s1C9EGbTtCOohAxbh5Fv/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sw3YHQcTXavB4wlyx5MTKQmx2s30mM2aSPdVA8IAh0MZGbi3UsUQcDgbzR3R5k2BjogA8JxCcrbFA/cFmzIElEseZbwwOmx/udihbUVUWXgO3CX6006QgKCNeoZvrYkGOF05bXxH/YTbqcTKkxySyb+Gax9vrFWBwqZBAkkCQ5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lGRMKmWU; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCos2y0mUuUsbEFXM5Tr0MNH0K2SK1b5rbValBUSIKiwdVMvmJHdB2L4fY9gMd6RPZg0amdhdPBHKUCIhjs6ohPeh2X3UUPBoe7VKua8nPmkJ+PjXSzvI7zgVLxto92E6b9vEhYQ8uQT/IAv3UAJZuFhj2Gryv3ezrI7zvF7nixo4It1XRyZAAJmj6C3qoKgjKLxclvIlM+lLdQ3Evh6czGh/1GLFwNLK1YyX4R96MCZxXNDPOj0z8DovoZYaYiwp8EILw64xdHqnD2AgFlu/ChGSNbs/6udDE410TnyolqbFD5uNvO0hY5Fb9ubkdELeXLK2IorlrzqyPkjTxp/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Su3YUgriZOMgAVEg6luCTcnHWkqaDOzQxElq+EjPDU=;
 b=FA0oWDsou+hi/Ox9DOuz7eTCsooNtlXN8w9AUjIlrHX0iNP+BykBwy96tFku0uWuOnNrrB/Q8rRyCbO18q/GfG6sNQ9xF4A53F/rj+GnofSNsNrmKpI4WVPt67hSYRv97tg4JD9StjtvsvRTrEtLRl2MidZPhAb5p4nxQRIyhrI/Y1DWz4nTM2kLsY8m5EYb4NFKGjVXWQFDpaLGjzyYeeVexR3xif2qITLocQGeoWgZua23mPb/aeuOXkNxFhY23ZH2t7yXYZmobVQx5srwBlG4yoLZ/wWKeel+1kQ9ARUSm3xz5c7pTk51mwFADt0py7xRhbL7/nhuefQq7ct3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Su3YUgriZOMgAVEg6luCTcnHWkqaDOzQxElq+EjPDU=;
 b=lGRMKmWUTYglKmstB0O621oDYZMDyOvmzRon27jhFLPusSencuOaNLtOE86blQEISGwGDTXshZzJml/WFPHVxn60sod8oN1BaLRWPmfFko7uMI3xGT+uCJK5xnXe4CdnAWZF/DrD+UAYr8sfT/Krw89RVo/FckQr05RTEdF3AQc=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by IA3PR10MB8681.namprd10.prod.outlook.com (2603:10b6:208:577::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 18:47:53 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::d3) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 18:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 18:47:52 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 12:47:52 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 12:47:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 12:47:51 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615IlpIr3483048;
	Thu, 5 Feb 2026 12:47:51 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 615IloW2028676;
	Thu, 5 Feb 2026 12:47:51 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <m-malladi@ti.com>, <basharath@couthit.com>,
	<parvathi@couthit.com>, <afd@ti.com>, <vladimir.oltean@nxp.com>,
	<rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v3 0/2] Add Frame Preemption MAC Merge support for ICSSG
Date: Fri, 6 Feb 2026 00:17:45 +0530
Message-ID: <20260205184747.2451816-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|IA3PR10MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: da0fddea-6190-4704-9ef8-08de64e7117c
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKP7NfEaiikPFhlvNbVfmZkb6l7WjJU4198FUfU/qVJshZhE0ILd4y+BgHYG?=
 =?us-ascii?Q?Dcq1SIeffMbvT9smPXJjVoOZbXfTDeEhhwEf5GiACqaVLfvUv834PbrAbIj/?=
 =?us-ascii?Q?vgA+Tn136iCZB0sW34LDSlsbJ4Am08LHlektLtxXvvQQRRYnsZ3OwSTkUrFA?=
 =?us-ascii?Q?Fjz2CIy+JmZhsLXLmsOBy47VDi6DBYTVDcacxnOcSi+k8rUxO4OEPiwq/ifJ?=
 =?us-ascii?Q?wMTQt/0P++d+5E138THDNosK2sDawGbmO4HrozLM1yIlBjs3LF9hHmR8ENLU?=
 =?us-ascii?Q?XhZhLdMeTQ2Sadz64AHD+mvXxSkqEgYGKSq7cDo2FqEjNo8lGQtHx8dkc9F5?=
 =?us-ascii?Q?DD1FBRTHTPhfzSxREbnzqfW3SKfaIZ5C3KrYhVkkDaeCBNJvG+anQ/3yzXdf?=
 =?us-ascii?Q?BRIyUmperhDUfMhe1D2+KM+Eh5SFSu6+iEwpfdnspbP19RcvgEbqA2RZ5bE7?=
 =?us-ascii?Q?rIrj/IbHTdIM4DS6RFxeW84Q3uFFRIApBceLi4ALjpYl3GzPeMZ3rwgEGJ3I?=
 =?us-ascii?Q?kTLJuNCr6hiuVNkt4UkimwvKPPPkXDS3DcU5fSmh2QJHE5so6xffoGhn8MKM?=
 =?us-ascii?Q?McbuYkunSusmm6twXBYwP4nc7u36kyL8rjW+d/yI14BvNwNzxGVanpHBzKwQ?=
 =?us-ascii?Q?SNuHaqXavp6wEr1OqKNlInZcFg78WW1AC/06x2PTry9qeeX5/F3uwi/zsJFQ?=
 =?us-ascii?Q?SoROJn3j7x9gQSd3vqrEQUjoeGbNCtGuTHJv+J3wLY4qnbWgEsx+bY4wwyac?=
 =?us-ascii?Q?F+Ds4ZC+WnOPIw6roIbRdZtrXMK++3lZma/nl15FXYPojsLULFtkXnQW578I?=
 =?us-ascii?Q?gvctil4+OCm3OegPeCLHL7aSTjMTBPr0NiRzso5F6CAippsexvSNJHN2sltj?=
 =?us-ascii?Q?EBGzvW0rGwEHnDT+DifHO8lMn8UWHi7YsfqkP/SGzt4KQu2E/yn5DWryuZt+?=
 =?us-ascii?Q?rbSA8jI64ToIfLYKR+CWUShYmbeeCqWZB0hOhpyxNOj5gut6NlnydosFzhjI?=
 =?us-ascii?Q?Nq27fC6Ok07Ymgd6WTe4xlRobgCVlxz2Pj7tPrcRyeAY3FXSFKC23ikU7fLd?=
 =?us-ascii?Q?+lHDveatj0UNB2lqBbRoxZaO3WlYSFBO2fPb5yD3kQaB1ryxdTGZr3DbPZ7z?=
 =?us-ascii?Q?Svbknfo/yVk2dLnTmFWB3AKv71e1QrqEz5C/38eHZgtH9pDejmTwdeeRAbMU?=
 =?us-ascii?Q?eBxSDyzAfM7H3bWZarm7gfGwRU7eFX+5LPyM1IJRLpXNL3UnsysS3qnTf/G5?=
 =?us-ascii?Q?Wq+d2v42Yk/ojYgagBJYXfmdbpvvTxnFviUjvCe+BQLOUO8cUa8pfYz3Ptwx?=
 =?us-ascii?Q?1JIXNwGE55rtO9Z1+RvGmjeluW5jN0oYvQfayg8VHldCyzlHRstd6LxHSo6y?=
 =?us-ascii?Q?tuvJ8IdBmoRC9pmYP+/8ITY/bJRuTNuW036OEov2mKblPt3TDX6c8w7bw2v5?=
 =?us-ascii?Q?VerXR6dZ2jrTUVA6AoGxbMFL9yGv6WGJcYCM3IUSbwXN8IRyDCR5R533p+hJ?=
 =?us-ascii?Q?po5YqecavS9ki9BtEvIRE8zGmom8D4FW5SfbBsRR2H2Rr6e5OmihwGLk1emg?=
 =?us-ascii?Q?a3fQv4+VMm1ZupezEoTQ2cejecjmti97b6sxVI2EoQd+l/Rf8GGQkoOkrfuh?=
 =?us-ascii?Q?v4VLZzcGAzB/SaBtLhHjKOdqClCe58qz+MdqNYik3LEdER1rITSAh5uzTlT8?=
 =?us-ascii?Q?apntyDdusnjPDJLP71bxA+okp+4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DafOqUPGKJafsM8owwCkDnhqZgJfP91pm/IsQx0fO2FNL4KfGAYuiukHh0PFets2O4XsOgarJL5R14SEdgACLjhTZbLeJToti9XYvGezirwJ3u19GTJpSmN6q1efrl2Wbx5SeX8Gt1aVQgrENpmpcjWdQBDKH6RwLfdgUrvmDVqtJBYXXCrHFFLhTKIZwtep2DzsG2a+SQoILWA7HmLAx/kOQ+ITXFyy9xq6poCMqb+I+cEw4rRtLcGWg/GI3lCW4QcAcJ8Vd1p9LcUlEhrjFG/0iIUHoy+uQMeLvK1aUDFPtowERh+WKn/LCJFtegxxY8blQxtcLN6i/8sj6+QgTbR142hbljP3J096p0942YbMTUEg+rJrkAOYOrQmlrKi5FTlVZ8k4GC0km52jVo+jxlQBHlIj09KutJhwJVzDbu2CsmQ7X3aYZrBLW7cQ6HJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 18:47:52.5385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0fddea-6190-4704-9ef8-08de64e7117c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8681
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257286-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4B005F68FF
X-Rspamd-Action: no action

This patch series adds QoS support to the ICSSG PRUETH driver.
The first patch implements mqprio qdisc handling and TC offload hooks
so userspace can request TC mappings and queue counts.

It also integrates a driver-side mechanism to program the firmware
with the IET/FPE preemption mask and to kick the firmware verify state
machine when frame preemption is enabled. The second patch adds ethtool
perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
.set_mm and .get_mm_stats so admins can view and change MAC Merge
parameters and retrieve preemption statistics.

v2: https://lore.kernel.org/all/20260204140044.4086725-1-m-malladi@ti.com/

MD Danish Anwar (2):
  net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
  net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   9 -
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  86 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   5 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 216 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  78 +++++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   1 -
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   5 +
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 10 files changed, 400 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: 3e5aa52b45c73470092f00d219e947f32cce340c
-- 
2.43.0


