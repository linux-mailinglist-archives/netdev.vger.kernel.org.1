Return-Path: <netdev+bounces-257287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNPuFCHmhGlf6QMAu9opvQ
	(envelope-from <netdev+bounces-257287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:49:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE7F690F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD56A303A8D5
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD6305E21;
	Thu,  5 Feb 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CxNA6Jpb"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF5279DB3;
	Thu,  5 Feb 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317279; cv=fail; b=iGJiEUr14jLMQu7XHppjx8B5dIxU/FBm359sXL/cCsU8JnI+ZbOjNtr9YY0/AS4io1lGykVi5dvie300ko8D/si7epkR/4Ff8+KFkMMeD+TK4UJrmWaoIMCYUcINO1uopJrvO+QV2sUXqoEZLH8EqN8lAc05u3uJ2JjGAlbnMuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317279; c=relaxed/simple;
	bh=7/MY/SpolqCbr3p3hiQ0xed1D7J/T3vooM49DUh4Iu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVfhDhK/ioF+CPOPFi9wtxohv2MPhuS2cQ+fbxFyp0gaU45JZMDAzT7c8Jp3qN/Qd8JPZIdLG7DKox7mg3nRLsJuSNFJste6IIKkfBOtzN4tIwUpyf+s/8IaJ+lgjsQ5hv+lSj9sDARRyR+WZyzZXPVIh984djUnAvDeu1GdqUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CxNA6Jpb; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRjMBKD1v+fLRTpyNygKCF4gp8HsEM+8T0/42qHJut0uF0X8szY7aGFARGpemJuMTt8MpDSF7MJ8nLKXgws+MvGXlLgZswvlOKbkWzGdg/yimHoa40m3O2YSS4hPVo6gBrZvyWyiQNK7TvmahxzhtL0LYbuKXWQUrx1slCnlihuFvnE0sfLFJTlVUsJCUvvsyVPkXgcKHeKknXPgpw/U3zUjW2tk8WJyokGrj+s/Chfm3m7Cg9xWPq66O+Gg0hddeW6bMtsAGOT1TwtlxqvsBQk3+h/dNyRL3yALrsJjSiRd/0rGjdp7cxEaH38juoG2zHWVxEHX2sqBWtcRzqufSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWGUeFxoys/infEXqHSzOTQJqRP0iqfGwc6aXdKIYVY=;
 b=v2lp8fPfmi6bKbOO/bcSTMcr6dR8mUMZKC5ODHswKGk1pT0dFUmfhQLO+DAZR8xIpVqKOJQYJc6HGFB7COzdvCFUHXT04lQcCfnHjud2A+z5VC9HiBFpXgG/aIBgSBIhfw74VfjgDmypuGntWzAk7H9wkLWa6fw69T11rCttmjymeapJXsdyRMhsVG5dr88wuYOWI/MfCZ5jA8KaNz1mOoA8fyXENkT0pSasVx3SJlAdSHTJDXywkE/WSjJ3ot7yI/pFnmIZVLNnJ2fvyyZz99hawuao0GbRpckqq7ITVRm2/4hIsYV2YLVIKj8SpzHQsKI+Kpf5HmFqbgSHbdJ3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWGUeFxoys/infEXqHSzOTQJqRP0iqfGwc6aXdKIYVY=;
 b=CxNA6Jpb10M7UnBEQD2CqcNqOW4+AtuPE1TWynabNArbJcW79AvXQnPVd3qenZ73LgDXEtDI+9Hcw2Zt9wc4Tk7p61KDvB14CWXCIVmpAa847YYvZcCjpnmMsN59TdYFDKfeMktlHWEVkapZwDYi7aJkEm71gJmWAG0VoVbP4Rk=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by LV8PR10MB7942.namprd10.prod.outlook.com (2603:10b6:408:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 5 Feb
 2026 18:47:55 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::1d) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 18:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 18:47:55 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 12:47:54 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 12:47:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 12:47:54 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615IlsIt3483079;
	Thu, 5 Feb 2026 12:47:54 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 615IlrBg028681;
	Thu, 5 Feb 2026 12:47:53 -0600
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
Subject: [PATCH net-next v3 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Fri, 6 Feb 2026 00:17:46 +0530
Message-ID: <20260205184747.2451816-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205184747.2451816-1-m-malladi@ti.com>
References: <20260205184747.2451816-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|LV8PR10MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3558db5d-47d9-43c4-a62f-08de64e7131d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|7053199007|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TbMMaGpOqu+bxNcwnUYJYJ+rWfxSMpndqgHzSDlBGUHt4TOOFpmr+Ge2dqVg?=
 =?us-ascii?Q?oMjeRInlUE+QZnI3RDhSzqkHBu/kJ2PYQrMy1NWepC/kzhN1+9hQ4yLVZqCt?=
 =?us-ascii?Q?FF/j+x+xOZIqG7pI9/+a1fJz9b19BrMoSA4IxE4wLUXPQ5ROFyGhdeujP2XY?=
 =?us-ascii?Q?FB51YueGQnz/gAqlkg24yDjlbSEqvMP2zVspXtsjTZxMbtWQSOV3jIsG5F+u?=
 =?us-ascii?Q?X6HmoJwK424DfR6TCGir9tV8iKQ0etfovQqRG4lkcSQPiFpgyQYVUf7ulDlv?=
 =?us-ascii?Q?7SLzwPTznyu1ASkWjid1nylmOikeR7acQb/qhhlVmJAkXEZ6NfsEhjmqUk53?=
 =?us-ascii?Q?NEb0eeXoIXwtHzsULEO1lhRVK6cj3gdZHNyPloms5b7c4rDAAdT5/xlKswnC?=
 =?us-ascii?Q?xZLjBRGc+SacMF8N4Sv1Xkt8SA6WDDndJulDhdxJdmcyklgDvvxznMeYziS1?=
 =?us-ascii?Q?G/vjt5Wk/+HXsjG7a0Hmco5pIsw/J/iVcKH+d2xiMYmTlfrZ+cYZ9pAuZ9SG?=
 =?us-ascii?Q?XRy/nT787lsqvDIOMhaWv1BjI0B9r6UenhrDgXyV6V/Oo3ohcG51rQ4J8uWx?=
 =?us-ascii?Q?Tf4fLgeK3X76h+8PC6aIJZ5GKmpc1fIAhuUQJKG+Y/M/lepn/UXOGGJaiLp9?=
 =?us-ascii?Q?iAXH0obcDQv+fUW1goVeUITF3T1n5melzokewnAbYCc5ev+2x4SYVEJ4dVVJ?=
 =?us-ascii?Q?T6My8EBAlcJE5dNefPgJaqzSMWvMyTDmwNy2HzU0HcMXk3eUArhP2N9ioMOE?=
 =?us-ascii?Q?ODSQlr6pmQvXC3GDOhq7r0k7uRn6J8P5sIN3UafBIp+N+5BO6oJj297bSPfC?=
 =?us-ascii?Q?lMS3M88A5c2U45Tv3ji32laf9+MyJMEPuLXRFIsCplMQan1T/oqwl96llnct?=
 =?us-ascii?Q?h46EaGs/FrdQkhgGJWghyjA8rf/SAMWgvnIjY6cBS9XP9cC1BeD1oqhLcJ/V?=
 =?us-ascii?Q?MHDebjn6yvUDGdpDsvc2w4gvPDlGTuYAZXev40rvdqQOlNzcDajXUPp0CHd0?=
 =?us-ascii?Q?b+bCEblEyuc5mEHi+uaypKy5ZXIxli+ykL7jvALOA/8LXCa18Nfqt4CnMXxr?=
 =?us-ascii?Q?Bd9+spfQdycMrJACFi6sIcdaAeJpbwhZQrD68WjIuDzPCdW+Gu9GriRadiZi?=
 =?us-ascii?Q?5vyMgd7b7ePOeI/T1KxLEF3haC782UtOHIfNE5blUC3I8+LML4mQ1U4F9vdL?=
 =?us-ascii?Q?zsNGL/X2gz4p/V0bVH4vWTlBWcw8P9pT03A7RAZjakRhIw6iMMElRLMhpOD6?=
 =?us-ascii?Q?l/UwsLyxQf3EhcKu4Mspb19NmrWNRAAiDWDJb2X0entER7fgcxlPWJa21ti3?=
 =?us-ascii?Q?wbNQBDGXheJx0cVvPcU5tTF8Q5g4FvLvPoYdlEUFRurFnEoy1D6SISM49opN?=
 =?us-ascii?Q?FBCLJST7fXtP8rU8cis4FZ2eUQcGTC3rkvrdOIpHe/XgQOdTemQVZX3PR3Z8?=
 =?us-ascii?Q?31tgFsEmQplW0cAuTjFRgXcidip22dka+bsq0bHBhtTxA769LqCmUOLgwqfF?=
 =?us-ascii?Q?aFHwcClVCR/eDtcJAkelerCoBMGmlrBcTFF4lQZSvUBvAB63Sp09LEAy8lBS?=
 =?us-ascii?Q?0J9tbh3PtMcwCSspkaTxJpXqUycXI8ztACPk8Q8AuWvu+4sObr9kKoQI2iGB?=
 =?us-ascii?Q?ogQGqbd0IkVva+ePij9YoCY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(7053199007)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b8Thbe9ixn+7aQ0vF1zRk34Ulh3Xg8zf4kB74lx8YhnrpAy2/lFHsVTYzcFQUTn3j3cYNPK4Gd631Quie7Jw1QdHz8DCBTy1Q2hUwWhuf0u48SiZVrGW4rNHPDZBjBR7E/UG+4dd3er8RrOgbF96sXeuJvYSLjV20jsqapKfGLw46D3j9peVM2quq4YWIABZTuIlZD0iDQh6ypRlcXQ+dBAfVYA40Dvk9GNlgCnAPin7o1tP4K6WRreqtmX/LWiiM9UmdZI1Q8CZhhlJBn1zVDPOk0q+K4Gp7ul5r2Q92SVwfqOp8THToKE0G+7iSkxzCdEHnUYAQ6dMZK9X/gvIgHkqszis0GdMuD4VePsGGCQb0HDJ4yXSQtVjMYBItB0FfBir+oJplQ5LgkGMa2JwgWFntfwDDXKzI4r2flvv25igmN2dgV96jHQ/kZn5Alcp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 18:47:55.2409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3558db5d-47d9-43c4-a62f-08de64e7131d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7942
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257287-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,nxp.com:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A5FE7F690F
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

This patch introduces qos support for the icssg driver. This
includes adding support to configure mqprio qdisc and IET FPE.
By default all the queues are marked as express which can be
overwritten by the mqprio tc mask passed by tc qdisc.

icssg_config_ietfpe() work thread takes care of configuring
IET FPE in the firmware and triggering the verify state machine
based on the MAC Merge sublayer parameters set by the ethtool.
The firmware handles the cleanup after successful mac verification.
And in case the remote peer fails to respond to verify command
before the timeout (5secs), then FPE is disabled by firmware.

During link up/down, verify state machine gets triggered again
based on the state of fpe_enabled and fpe_active.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v3-v1:
- Move icssg_qos_link_up/down() to if-statement right above as suggested by
Vadim Fedorenko <vadim.fedorenko@linux.dev>
- Fix p_mqprio dereference without initialization as flagged by Simon Horman <horms@kernel.org>
- Following changes as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>:
* Provide more detailed commit message
* Fix the ordering of the functions to avoid forward declarations
* Fix the bug w.r.t scheduling work: fpe_config_task without initialising it
* Fix the logic for icssg_iet_set_preempt_mask() - configure the queues based on user requests only.
* Remove prueth_mqprio_validate() as this duplicates what "caps->validate_queue_counts = true" does.
* Remove clearing PRE_EMPTION_ENABLE_TX on failure which is irrelevant - ACTIVE status never transitions to true.
* Fix handling of these flags: iet->configured<->iet->fpe_enabled and iet->fpe_enabled<->iet->fpe_active
* Schedule asynchronous work without waiting for any timeout
* Remove cancel_fpe_config argument from prueth_qos_iet structure - no reader
* Remove mentioning "priv flags" in the comments for prueth_qos_iet struct

 drivers/net/ethernet/ti/Makefile             |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 216 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  58 +++++
 6 files changed, 282 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 6da50f4b7c2e..6893baf47d46 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
-icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
+icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae..1ac202f855ed 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f65041662173..1e4bc5fd636e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -374,9 +374,11 @@ static void emac_adjust_link(struct net_device *ndev)
 			spin_unlock_irqrestore(&emac->lock, flags);
 			icssg_config_set_speed(emac);
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+			icssg_qos_link_up(ndev);
 
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
+			icssg_qos_link_down(ndev);
 		}
 	}
 
@@ -967,6 +969,8 @@ static int emac_ndo_open(struct net_device *ndev)
 	if (ret)
 		goto destroy_rxq;
 
+	icssg_qos_init(ndev);
+
 	/* start PHY */
 	phy_start(ndev->phydev);
 
@@ -1421,6 +1425,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 10eadd356650..7a586038adf8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,6 +44,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -255,6 +256,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..8d17b28357f8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
+	int prempt_mask = 0, i;
+	u8 tc;
+
+	/* Configure the queues based on the preemptible tc map set by the user */
+	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
+		/* check if the tc is preemptive or not */
+		if (preemptible_tcs & BIT(tc)) {
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				/* Set all the queues in this tc as preemptive queues */
+				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask &= ~BIT(i);
+			}
+		} else {
+			/* Set all the queues in this tc as express queues */
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask |= BIT(i);
+			}
+		}
+		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
+	}
+}
+
+static void icssg_config_ietfpe(struct work_struct *work)
+{
+	struct prueth_qos_iet *iet =
+		container_of(work, struct prueth_qos_iet, fpe_config_task);
+	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
+	bool enable = !!atomic_read(&iet->enable_fpe_config);
+	int ret;
+	u8 val;
+
+	if (!netif_running(iet->emac->ndev))
+		return;
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ACTIVE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(iet->emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+		return;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, iet->verify_status,
+					 (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED),
+					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
+		if (ret) {
+			iet->verify_status = ICSSG_IETFPE_STATE_FAILED;
+			netdev_err(iet->emac->ndev,
+				   "timeout for MAC Verify: status %x\n",
+				   iet->verify_status);
+			return;
+		}
+	} else if (enable) {
+		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(iet->emac->ndev,
+				   "F/w fails to activate IET/FPE\n");
+			return;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	netdev_info(iet->emac->ndev, "IET FPE %s successfully\n",
+		    str_enable_disable(iet->fpe_active));
+	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
+}
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* Init work queue for IET MAC verify process */
+	iet->emac = emac;
+	INIT_WORK(&iet->fpe_config_task, icssg_config_ietfpe);
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct prueth_qos_mqprio *p_mqprio;
+	u8 num_tc = mqprio->qopt.num_tc;
+	int tc, offset, count;
+
+	p_mqprio = &emac->qos.mqprio;
+
+	if (!num_tc) {
+		netdev_reset_tc(ndev);
+		p_mqprio->preemptible_tcs = 0;
+		goto reset_tcs;
+	}
+
+	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
+	p_mqprio->preemptible_tcs = mqprio->preemptible_tcs;
+	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
+
+	for (tc = 0; tc < num_tc; tc++) {
+		count = qopt->count[tc];
+		offset = qopt->offset[tc];
+		netdev_set_tc_queue(ndev, tc, count, offset);
+	}
+
+reset_tcs:
+	icssg_iet_set_preempt_mask(emac, p_mqprio->preemptible_tcs);
+
+	return 0;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_up(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* Enable FPE if not active but fpe_enabled is true
+	 * and disable FPE if active but fpe_enabled is false
+	 */
+	if (!iet->fpe_active && iet->fpe_enabled) {
+		/* Schedule IET FPE IET FPE enable */
+		atomic_set(&iet->enable_fpe_config, 1);
+	} else if (iet->fpe_active && !iet->fpe_enabled) {
+		/* Schedule IET FPE IET FPE disable */
+		atomic_set(&iet->enable_fpe_config, 0);
+	} else {
+		return;
+	}
+	schedule_work(&iet->fpe_config_task);
+}
+
+void icssg_qos_link_down(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* disable FPE if active during link down */
+	if (iet->fpe_active) {
+		/* Schedule IET FPE IET FPE disable */
+		atomic_set(&iet->enable_fpe_config, 0);
+		schedule_work(&iet->fpe_config_task);
+	}
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..8aa79b68ad54
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt_offload mqprio;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos_iet {
+	struct work_struct fpe_config_task;
+	struct prueth_emac *emac;
+	atomic_t enable_fpe_config;
+	/* Set when IET frame preemption is enabled via ethtool */
+	bool fpe_enabled;
+	/* Set when the IET MAC Verify state machine is enabled
+	 * via ethtool
+	 */
+	bool mac_verify_configure;
+	/* Min TX fragment size, set via ethtool */
+	u32 tx_min_frag_size;
+	/* wait time between verification attempts in ms (according to clause
+	 * 30.14.1.6 aMACMergeVerifyTime), set via ethtool
+	 */
+	u32 verify_time_ms;
+	/* Set if IET FPE is active */
+	bool fpe_active;
+	/* State of verification state machine */
+	enum icssg_ietfpe_verify_states verify_status;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_up(struct net_device *ndev);
+void icssg_qos_link_down(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


