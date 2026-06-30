Return-Path: <netdev+bounces-303137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T2+qCJWvQ2pnfAoAu9opvQ
	(envelope-from <netdev+bounces-303137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:59:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6AE6E3E9D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:59:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=MngUT7eX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303137-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93037308D437
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545940B37D;
	Tue, 30 Jun 2026 11:56:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E3409617;
	Tue, 30 Jun 2026 11:56:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820595; cv=fail; b=Azt2odmkuuw+wk7WZTxgYLi9xGEbKHhpdb8dAch4q0OzBMEYb3zjSFLZKPUYFve0Lbjia8wF5TQ/ol8gvntT9zbq53qd8BjSFx5bm7OYi1mhEVqNAXlByUGWc52zomu5ScWI8pDaJIVA4d5rIOCkx3tUqlDCBMFQF3LDQq4BSl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820595; c=relaxed/simple;
	bh=puOrLbmmjXHZ5WFNunGVeEuTt9p5pHZcTS8jeegP6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGWy1imLuoCVyvfL4V89EM9F+olE3cEbvq+2rgpmdk2+pJzhBg9JoAcG10ln2j8NBGKeergba57kotOcZbzKpJUtFP21D+YXZtlPbruk1qK8N6B0hO1bwmZfZXop3ta6+e0+jGHucHDdyCqbR5CI8RNaZtSND78fQu4U0ZOw26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MngUT7eX; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUDvuf65mtQYKwqhQZKkGMXkfXU9oqs+qTTAAm9lWJZwYQIfTqRNrB7Z7IMrJd02igJ2GUOYqNBKsTDrR1OyChTAuLo477ZnKNYDZEvkz8VWRBOrnu28VeH7QrHJYxpEty4DfjHFrE2IhVhTXKEiOjRLYDnA6rfuy20Iyh78pFUoUJ443q8HJdr/cZAeTOpLYhlRBD9poKIRZgyfMf5vjuF5pGUVS6q1NZTwviRMbhU93en3tt4F5xHIZPL/t45Zhn0GWZd7Kkf3l/0SpPwpX6mDGGd5s7IiOEBYiwpTLDzRwRcROhI6hqpy0fiyLl0gbYFrPO2eWXG63cMz0LttoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKtSciYlV8JovYOti5iISY/o1zGHOPNcY3PJ5Tj/A0A=;
 b=rfO9OYjaVma6+KubDJByCE4lG/X3mmT6rCkuixUk6jlf/qDe9nkblbj2kj9OEDpq+ymkmmRw5u5YZ7CtfmOU87lMvcnAhjFDs95z7aaf/XiAewk2kflx5a0Ah3jnWR3CIywnU0elSEZkprvu54q8j+sPDu6wML+BXTGgLD4ab14/NzAC4o7491Q2A602gFv7FaGwdXmlCBGv5X0S93iZdzX5kMF5bLpG/MkYqRrQybyXHYEdRpZP+XUd2HS+Rdp23sym2qHeenxzBv9GB89UYdmAXQb6YFE2SYXvOmo2SPT4s8z5chU7lq1uq6C4cmg1VuDuj6QscTFQincRwAMJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKtSciYlV8JovYOti5iISY/o1zGHOPNcY3PJ5Tj/A0A=;
 b=MngUT7eXRh2T7U52H5/5qHGdYo+VCwBPsRHTFUDVOGfnBOKIh6UFd8vLveB6vzbV2KDO11hy712bUumTFfRNhAb2tiTdW4fymf9uIA20YjQAWMi7Oc/tVWSLmekvGplCRfyGCtD655d9lSRYP8077BOD10gGevy6zFCLb8+pD+lyqOFR8rlAknpEiXsu+oCK0pBjQt5Xly7KAP0X8emecPWSV0WEakB/ddxlCKmtE28eN+SnNnviKIX43s1ub5QHfHdMHf7cDxTW+uv26U9ulZaQVUVTfwMks1FvmfCnby+aVec7I+Biu6fi1YyYPhiryEMQTBzsEiqBgtcs+rLi6A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB4919.namprd03.prod.outlook.com (2603:10b6:a03:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:56:26 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:56:26 +0000
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
Subject: [PATCH v3 2/3] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
Date: Tue, 30 Jun 2026 04:56:21 -0700
Message-ID: <20260630115622.9426-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BY5PR03MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: eec709b2-5e9d-4934-79af-08ded69e9ca9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|55112099003|56012099006|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	K+/Hn/RzdaEWtTbJA+wqmuSkKwVJUyG5j15H4cnTFBaWlA7j30g2M7SA2wHR5bDPlmv5BOD7yEddtM+qC+98SqkBZbWZ5cPYUEpyLnqyIbYLPpc2cHimYCi2n8TUWVN0peVKEELNgR1tadOEKDn63tAetEmxtMEkPbYOF6pFPFI4+k/inuP02ct9Q4fKIP8o+W/IaI/PjmntCtML8U2u4F/xnftzyprPBxIbvPxXqGO9ckb9tX1bcBzVaHBxYPYf2VWCrOdEkuzJusvfdPltuFj7x0VaztR0VXayJ1oMTQ9NJXRxJk6oVsjOJUqBem5VYfBVgh2r6kYIo01rwciMTxPSaQ0WSPQGBwvnj8exw55QBVkXFkZ7rRl1cRQ5JQnUi0kEB2Ra5B0s369hMaxqlNmETjRMLJvFO+RFILCOSzuAGObTam34CczVZOQpaAV3oq7qMhiNDIo7q6jjn5mVgO/QxZY47agqSwnDhjwvd/j7WNtNt3o+SHC0eC8+XX/VfBVRTcA6FJnjwA6s9PJtF3Bzd5THuZSw8X3csf787Jp8QmK0jpsPRygtbQqTsUG2axQEVFTVBpyHPJ0MEkXJji1JfF6+JmOWBTd1c8fHDy6wOOaLE33aDBZ6bS1IG+5mZB1IXrS/H/3NqiA+g2wpoTb5B8eyReiVDTa+0YPvQPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9WVWKHSpaObnLmcP3OGqCcrnGyLo0T2EOq8fJnra3AydFsnUgwv9XTC6qYx?=
 =?us-ascii?Q?a4R7KzIgxXCQrwe9TVTSOARapj/Qn9oO911BaL/N+dNU5WUFCVYqI8j6b7Vz?=
 =?us-ascii?Q?lOydtoIcHWtKs1QiGOUl/AGAxnT0CilaJ2ZTEMJyPD8HMCYy4K2lB17qXdzr?=
 =?us-ascii?Q?WchyZlKvGAEdjAlsJjz6ALe1g9eo6QhqDP18WfStVWkqTSIqILsGjJD8/SHN?=
 =?us-ascii?Q?hLUEmQB9qiTv58m9cRNvODJk6g3aJy2oVFB2ydu2APdZil0w+DkIBxfPb7pO?=
 =?us-ascii?Q?p9JtD7cgpBvG7ZtYXL9s5Vkl2iLusNABObt7sb0D4GnrwHmtLwzvyGjJQWtk?=
 =?us-ascii?Q?juvHWo4mgkYfBtPtXqLt8M5FIJ7k2mBWejYrC0Cvb2Ng6wd7qHFshqPfxocj?=
 =?us-ascii?Q?WDZBdsffwStTBZ5WUj26O7cqSW/2w50L3iFoq26gcKhVeIFcrFnPIkyuuffI?=
 =?us-ascii?Q?gHp6FW4IPRQ40HHNa137Waz53j3o9RxPt67KtMkVjLSmoSTwa4lYHuLLwJJr?=
 =?us-ascii?Q?BqinVzFCIkJFpQqLBZ4fAE5gPNHMAlineQigOuea5ba0lWBBmFHj3MvRoyJA?=
 =?us-ascii?Q?qpH8DXZrsHg94K2ItL26LIkjxsvCJS17Rdh9U954pa3/dypmbysPoR/Fy54o?=
 =?us-ascii?Q?eYkgz8ha6uGrqdLCoQoPpQjtUHPS5jLvZ7X+LbYnem/Fm4BcBzUE0kDN/awy?=
 =?us-ascii?Q?2Clmp4bxRuQt1hzpNTdOT7n8xETukkjLeyEgdtkhPAlcNeWAMTNyLIwrrfIy?=
 =?us-ascii?Q?6IniKY5x2S9DNES/P47qMLkoJunW8qWALPqd6135wN9H2YQArRzF0gvPK5nK?=
 =?us-ascii?Q?reLcqBMwnV3W6chrBI3mn4vNx6o4vTl35YCKQPhcdZZJEDI5oa+JVGSYw2LG?=
 =?us-ascii?Q?3YM7t5aB064N/PzhtgQMz4G3vhrZt1cd+D1V4+lKHK+3MxmHdclW0h1dEkPp?=
 =?us-ascii?Q?DB0dHrphSIA9OEG+nxDy+Eg/Yl/wEaGzKXMpIJqhPqz/nCtMNfoLjtJYLRjE?=
 =?us-ascii?Q?wqPa5Xu/CGBf9HxoKGwozkPUwFuvKyhk01A/Sf4dZ9mhrLgsd1k6H9B4SsnQ?=
 =?us-ascii?Q?KASbFMinaRIUEiMz4RjOTg5IvyymDFhZZsK5u0rTa3Ak6yO+BXat2076fBQC?=
 =?us-ascii?Q?ZvRAqsuh4+F/VkHSiwKlRyImNhuB92ZS45emn5N3NAoI11Gv971rPWNgXGpq?=
 =?us-ascii?Q?83GcM2MqroQrxU/EjyrD3yNlQF5dTbMId7eNj0QzN1y4KGMb7D+6Up6sxITb?=
 =?us-ascii?Q?iQ7xJipoHR0b1sXi284jIT4lhQ8LYbOrRrevywd8zc0hjpW87mbpK9kgU2jw?=
 =?us-ascii?Q?9DyDHCNb1Icyq1jTb9fypjhX7wBAE2TqHb0tAXIZBRwBW0hcIS4l48jtO4zl?=
 =?us-ascii?Q?chiF044AxtZbrDRIa/dMXIKhzSl9MpIBnMrT8T5kbyQ25T4Ldx1QpPUe1cnG?=
 =?us-ascii?Q?Rsxco5jI2vHIo+5lgWRQbNEFb1v/A4H/L1cTP5XMJDeMuJ2rh0wo2pge2TiV?=
 =?us-ascii?Q?hfMoM+OHE92ZiPOPYJmk83QVULDJ3xwdMQ/WMLH76KqeN2oNqFYfcZfqzARC?=
 =?us-ascii?Q?J0NSJHlHMtvfUXPX6J9zIZcsbm0G6QitYihBv+hlZHi6bIEhexwclAZqm804?=
 =?us-ascii?Q?gjr1eXekILHFjfeL3ea3GUthIh4C49Z20QHrjGKEo4uorI8Py0TlLrjeXhvi?=
 =?us-ascii?Q?YugplmkNUlhFpmXxxPqp+8Nj5T4bTmteUYViMpPxtpB4v6SrJ84zgF6FjxKw?=
 =?us-ascii?Q?VQD7e1lt9O0DwkLCMER52UcpouEZlFx/iu2BLeuzJbG44IG7vH/yP0jrOXB7?=
X-MS-Exchange-AntiSpam-MessageData-1: ZSp9NLDwcHC0PQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec709b2-5e9d-4934-79af-08ded69e9ca9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:56:25.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJBOa7mGHJt6CLniQNgST5eKTCMswO+u/YXqOIuwOya+g656xEVJxTXdkLMt3Z5N6Cvt8FXqRyNgXHd93byyQf1yxr9V4wtVPjGgrBml0M+m+GZIL2EsJaKv7B1+txAfKPsRjIAc2QbJOSWNJdfAIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4919
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303137-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD6AE6E3E9D

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The basic flow parser in tc_add_basic_flow() does not validate match
keys before proceeding. Unsupported offload configurations such as
partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
proto are silently accepted instead of returning -EOPNOTSUPP.

Add validation to return -EOPNOTSUPP early for:
- No network or transport proto present in the key
- Partial protocol mask (only full mask supported)
- Network proto is not IPv4
- Transport proto is not TCP or UDP

Each rejection includes an extack message so the user knows which part
of the match is unsupported.

Also propagate -EOPNOTSUPP from tc_add_basic_flow() in tc_add_flow()
by returning it directly rather than using break. The break was silently
discarding the error for FLOW_CLS_REPLACE operations where entry->in_use
is already true, causing tc_add_flow() to return 0 (success) for
unsupported replace requests.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v3:
- Add extack messages to each -EOPNOTSUPP return so users know which
  part of the match is unsupported (Jakub Kicinski)
- Return -EOPNOTSUPP directly instead of break to avoid silently
  reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)
- Patches 1/3 and 3/3 are unchanged from v2

Changes in v2:
- No changes

---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d78652718599..14cabe76e53e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -446,6 +446,7 @@ static int tc_parse_flow_actions(struct stmmac_priv *priv,
 }
 
 #define ETHER_TYPE_FULL_MASK	cpu_to_be16(~0)
+#define IP_PROTO_FULL_MASK	0xFF
 
 static int tc_add_basic_flow(struct stmmac_priv *priv,
 			     struct flow_cls_offload *cls,
@@ -461,6 +462,33 @@ static int tc_add_basic_flow(struct stmmac_priv *priv,
 
 	flow_rule_match_basic(rule, &match);
 
+	/* Both network proto and transport proto not present in the key */
+	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "filter must specify network or transport protocol");
+		return -EOPNOTSUPP;
+	}
+
+	/* If the proto is present in the key and is not full mask */
+	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
+	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only full protocol mask is supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Network proto is present in the key and is not IPv4 */
+	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only IPv4 network protocol is supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Transport proto is present in the key and is not TCP or UDP */
+	if (match.mask->ip_proto &&
+	    match.key->ip_proto != IPPROTO_TCP &&
+	    match.key->ip_proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only TCP and UDP transport protocols are supported");
+		return -EOPNOTSUPP;
+	}
+
 	entry->ip_proto = match.key->ip_proto;
 	return 0;
 }
@@ -598,11 +626,7 @@ static int tc_add_flow(struct stmmac_priv *priv,
 		ret = tc_flow_parsers[i].fn(priv, cls, entry);
 		if (!ret)
 			entry->in_use = true;
-		else if (ret == -EOPNOTSUPP)
-			/* The basic flow parser will return EOPNOTSUPP, if a
-			 * requested offload not fully supported by the hw. And
-			 * in that case fail early.
-			 */
-			break;
+		else if (ret == -EOPNOTSUPP)
+			return ret;
 	}
 
 	if (!entry->in_use)
-- 
2.43.7


