Return-Path: <netdev+bounces-299725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l2m1IB/RMGqRXgUAu9opvQ
	(envelope-from <netdev+bounces-299725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93A68BE74
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b="Eo8fX58/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03EBB301F1AA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B83C8C7F;
	Tue, 16 Jun 2026 04:27:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEE2F8EB1;
	Tue, 16 Jun 2026 04:26:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584021; cv=fail; b=E9X1ceTy/uZnAi+9PN+lQkGvGXb2hdZdC5ALR4I0waa66QMTVivsmpFbk8pTqJO6RMTlzu9/1TLZadBJVW6XLsJiDG3BZda9qGUJk6JT8AgfUL6P5RH+kBQQBcKeBKwQSbDwr2W4gbM5Ox2CfkwTtBHUu2SyyGoljY2nPrGiqwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584021; c=relaxed/simple;
	bh=+4yol1rh02CzC8V5s8NwIRiT+vWQnQMmPgCpJwimOjo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fZInKYb3lxIaH6loHoEiU2jKYIy7gDVW5NrRxvPrMze+tOAoFE2sCveHYxqoEM8WNSUvx61zXCbkUdD3Crfk2ci6zQVmZX3aUg2NHoTCWRYCD87oPveldkFNTbGSw1s76Ga3YgsR6Rd67HIynPcQ5fgyULdKtAlFCbAgmkurDus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Eo8fX58/; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYkcnMVKhQ69BS/kwvZ7Fu3rW6Xka+AeuT5RDRUKIUIK8p6GGWJoyGDPH4jrfF+ogHaNvW5oeBb/dVpQbqj9MPv6bRpkQHc93oDmC74u+g9gKoGV3wSo3T711zPmaSd8/bSTEDFfZOavGzSLJWcGoDev+/sBFWgNnyCxOoYkdjkilyzd8jcez8WUBysoskZM9pCT5MMs/k0BZZcuIODncUAHN7Q+Oljo/E+ugfOox8bHU1oNEfnnDfV1xaUgwyJjl+pj9fLayeMRlq6iVor/aToXdmsYvL0Thyf2tP/egHa72PHbCBmpqL8I0yV8ldOB1Psacvb4ITREfIotUA1V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hYB7yA8RpTvdbuW0obSHGKU8LebNS+LMT7nAF6kC6g=;
 b=OWpUJ6Jeaq6UkafL6hzNTbjrMeRR6OkYoeB9DyaddQfE6AxudXRugwJSCahtsNmyxprxFEuNCwJ1ULNMJedfr7mnGl2j/aYVCYRKsS1KzDMAtfpZ9seEc9VRH26YifAHGcdcdPHXuNM/JRHtkygqn5KDeKOkNMxyycNfQbRkmzNuitmdZ9Zb033zFSI7Cc33fV7FB3zuKabb5Nr9qL/wEpoJ0fey2kK3n+b+ldFi78yvfpPkEwgEokQ7C2f684J6Ns1NiAfwRPJZ4pxpVJvttzNbvd9AueovoXjlioHJnjcE/E9mrHjlH8JyPQK/xInl8w7XU7gSGIiERiYJmtki3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hYB7yA8RpTvdbuW0obSHGKU8LebNS+LMT7nAF6kC6g=;
 b=Eo8fX58//5ugkyUSBT2P0IZsxyLnUnV6QL76agiXB08+Q/4yXJI1+njUf7ZcL77nztnmFsZxuXw5Z8Ss7PATGSf8dTqOHJ/RTloQEKuev02dSodlpgPRAWV1+cdLSJXSnAwRBRhD0Q28Lcal2S67Ag7SwNqMWNmx7sFGV+eMqwSM59FrEGRzAbK0bzazExtyMhKGibCeYxQjrAbIgB17kASO/7vSRmXEZ8wfsTmU4luD+lYKuZ2sBZTfz8svSIRPium/TxxXyKM68vtVPaay5OK21n9FyCI+3SRSkmQe3gJyefbUh4d+FWBTr8CC5yBnRIYoFb35r2Fzv2JVMib2JA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 04:26:57 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 04:26:56 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
Date: Mon, 15 Jun 2026 21:26:52 -0700
Message-ID: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d59482-8003-4bd9-a5c3-08decb5f8009
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|55112099003|3023799007|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xJopVY7G6fLladnKxvZebMCaA6EqTH176St2LEY6K/CKJ6Abh12LfLLYfUT6YeIwgCG1ayU2iQdh5I2tuSuHxy8eeTSgYQEgXHFqMRYR/W6S3eYOEaGZeJlj5ElIuBAX5gi+QNhgu13vnkRjgphgLi8IbYBg63F45pNqKU/dfdWliNAJYyPR3GZaJbjq/VDF6FOcZLpP+CQRBLOuwlTzUoAQsktvSd+/b4EhG0uuu3gn/0TmccD5LMUpomF06cLEaorJPjK057p336fJUhm4KUQEEQZmtyzxGqU4yusD9n/ZxLtLzJ7muqFK1DeSFPEgdMoy0PYvJkuyxAo4BA9wsdb9rApnJ4G4e5Tj8SHX1qrFBQsaz3CvaHHauboUhK1wF6+CD0Dc8tL06TVLxHdLgo0484dsT1zWjkJztbkdXF0RT6/2O2tkLLRrZ5hfPIpeUJeUUxheOwLK4uvbRl5uHwWEkzx2HP4H51P/buyzVnVQ36jRFjt+HL8dnJ7I5bma0sjh68b5LwcgZORLfEP1CnGVbhuyno6Z5Iw0bNKvlV/NsGCPfWjUVyCXj8H8c1heeBCKArE9WVztQInHUIZVU/3cthGGlRzasq9HSsQ+H+Fq0nzHoy4G/oZoAId3Ks5/ihnNVxm9esdyZgSZK60Elh/yBp8mdi4MBkl6nwsBwMBnDIpPRRjg5LZ37JNAZFnc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(55112099003)(3023799007)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kstFWes6iO8+ZFIcoAW1XlBZipu+fEcRY3de415SUYycoS1cZexKhe0BvK5a?=
 =?us-ascii?Q?kRu3DGOrcI4Xu4ljZ0OWnuU8KrS8wZoBrkKo4lDcoe27SV+0ShMqRCDBr4w4?=
 =?us-ascii?Q?HgLyMKDQfdRe/UFISrvgfS8yO35dpMr3kJLepIwz8d7+OyR6kcPDC1FQxIHW?=
 =?us-ascii?Q?I/Tdemo3nObvfsSiBa7W1C8dvsf7RUXvUbshgYfMkTVftcziExfKfc0u0OyB?=
 =?us-ascii?Q?r6tx6oRMRfMH9cXFq3MW7LVXhfPnQwYV136+vKTmCyIMrr0P2QRQwEHhOdrs?=
 =?us-ascii?Q?qzaaCMinsS6CO+F4bpWnsI7nMR9+Nt/TtSr1jYDfBrvTDXjfXrSRUFlFw15o?=
 =?us-ascii?Q?/B8MP2+eA1QbvFzIcvB7E8bgdaVzcXfcvf0CRXi4hP+voykld4/Txm9UrjJ9?=
 =?us-ascii?Q?6r0YLDjEJCDswRhW6doKqXcl6w8a3s/f2yZf0gd/TcT2gmy+EltrDPzngEL4?=
 =?us-ascii?Q?VD9vADSkUtNKkEgz/N74Sh6BS+8r4OH4SEdEw0GHAaw3gBRE4nCDNm3q+7kg?=
 =?us-ascii?Q?1xqGhODGVuIVn0bJ4gj4bQTdkXV/6mfU3hl3f3HwioCz9GitNUlwkmPI0JoT?=
 =?us-ascii?Q?SAT1tBXKLTdqFzfjGPd3FSZbBoQk08gKSBvqRQ68IjDoJMTHUXfHP/a+iGAy?=
 =?us-ascii?Q?PySUTRbFYFZ2SbPedZMwF3R7ymcMrHpck4gQghbPw90Wu7TURZIiYnMbWZ5F?=
 =?us-ascii?Q?AfTBHzh2b/ZKz6nzmKcjmCVkK6gQ+sjTuzndFKgSGSUtlgoUHWHlPV2G4mrv?=
 =?us-ascii?Q?pWmnA+pRf//n4Mgn5KDQO5seNzyT7AGT0RZqhvr2F4M91BJZE8dUn+NxZSpd?=
 =?us-ascii?Q?9iRzvBvNAMFQfH4zc36z4w7w9OrUFNJPcbD0xYerJ/jyAWsCV/5UvTG4L/Ip?=
 =?us-ascii?Q?y2CD7ItQ19G+jC+7WlcRTrldgyCTf2aERJ0M99yzoryXM+RUQUzMXX+TNmvE?=
 =?us-ascii?Q?biOGixE/nwm5Hx8/dscgm8YUaqpECJBOwgqRLLB1eSxwXKM3LkO1DDZSCrcT?=
 =?us-ascii?Q?ohKQsa2pGLoSRz3VENQWd8YmJNSiQByUTFeM52v2RRb1E1fjD0qPtGYSM8Vm?=
 =?us-ascii?Q?u4opQJISM+9AvPHp+pdqfcLOJ4ME4WQ/7eEGaayMC3ApDdbyR3idSekbUaks?=
 =?us-ascii?Q?Ixz4sDoGHPUB8blTKzmvp3gv/kMdxxqwzF6UsrSdHDzcCXRSUxZnoRSJI4qZ?=
 =?us-ascii?Q?xnT9sS2AFWYHtWKkhHe4SccgqnUEoklSs3Mp9SUDyZXfBzKbsNix/bwSRXpY?=
 =?us-ascii?Q?LBfDF18jXXsdeWrrJTlOArFpXhnOrcvaabCVVLYP0kYwK2Lldz6WVtixEHBQ?=
 =?us-ascii?Q?DIOMDjtJjdm8g6OLMQXKOnuGSilnET/mrcffLEGP9Bs+2UXLJbzu63rdQjIP?=
 =?us-ascii?Q?54XWqZzI5uuwsmHCHgUpBSmFmAUHvN64G+XidZM7ZwJIugKu/Qjoekl8fEB8?=
 =?us-ascii?Q?O6pEFrmW/brvcNDayDDw2OS2FXoKM/i9m1qkfZY88og54B86FbrAThPzzIJd?=
 =?us-ascii?Q?m0smghRm6okk3o9TUjouQhY7h7YnZetF0nwbPJH82MuNbql09HbUv6R/mgU3?=
 =?us-ascii?Q?ZF1aCp01slhcsYxUEGqg2QGiaRuBbbcv66xqMgTo2DaTmz93Udwp3Dg+mZgJ?=
 =?us-ascii?Q?SEgGeaQmebJdUDFvHFSatGG7XzmlMnQEOkgmoH7la/rkelP/hMGlBfPtrjw7?=
 =?us-ascii?Q?gK1zWXPrVRI/SK90ZIin9GHYE2aMpCbpr5lHbBlb4k/20oP+S7JDUWbO4FMr?=
 =?us-ascii?Q?RsBk6Up3OnH7tS9V8F8yVDwRYDf7mBL/l0d/EGO/QrdxF5qlzfoNjP8/uo40?=
X-MS-Exchange-AntiSpam-MessageData-1: Sj6Q0sLDb0M6+A==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d59482-8003-4bd9-a5c3-08decb5f8009
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 04:26:56.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNdUvli1E8ymoTCx+AcAElGL+8B3ZlfC/Kb+dq8zF6N7+BJRJk8TzngmA06QsnXeotLjMtR0PQe7cwiPIzEjBYGs4GhQOOwaWOztvBplYo3kmxiVyJ+qtBfdKaCvy0RtY9j/y4G1O4BSqP+Dd1cZjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA93A68BE74

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series fixes three bugs in the stmmac L3/L4 TC flower filter
implementation for the XGMAC2 core. All three patches target net.

The L3/L4 filter match count statistics patch (originally patch 4/4)
has been split out and will be sent separately against net-next per
Andrew Lunn's review of v1.

Patch 1 fixes a register corruption bug in the L4 filter port configuration.
The XGMAC_L4_ADDR register holds both source and destination port match
values in a single register. The original code overwrites the entire register
when setting either field, silently erasing the other. This is fixed by
using a read-modify-write sequence.

Patch 2 fixes the basic flow match parser to properly reject unsupported
offload requests with -EOPNOTSUPP instead of silently accepting them.
Unsupported cases include partial protocol masks, non-IPv4 network proto,
and non-TCP/UDP transport proto. Extack messages are now included so users
know exactly which part of the match is unsupported. The -EOPNOTSUPP is
also now returned directly instead of using break, which was silently
discarding the error on FLOW_CLS_REPLACE operations.

Patch 3 fixes a stale action bug on filter deletion. When a filter entry
with a drop action is deleted, the action field was not reset, causing
it to persist and potentially affect subsequent filter configurations.

All three patches fix the original L3/L4 filter implementation introduced in
425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").

Changes in v3:
- Patch 2: add extack messages to each -EOPNOTSUPP return (Jakub Kicinski)
- Patch 2: return -EOPNOTSUPP directly instead of break to avoid silently
  reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)

Changes in v2:
- Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Nazim Amirul (3):
  net: stmmac: xgmac: fix l4 filter port overwrite on register update
  net: stmmac: fix l3l4 filter rejecting unsupported offload requests
  net: stmmac: reset residual action in L3L4 filters on delete

 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 35 +++++++++++++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)

-- 
2.43.7


