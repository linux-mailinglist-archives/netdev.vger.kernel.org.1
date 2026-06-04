Return-Path: <netdev+bounces-295105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G0z8KTY6IWq+BQEAu9opvQ
	(envelope-from <netdev+bounces-295105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CB363E121
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:41:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=IwnVPdaL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295105-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295105-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBA33053FCE
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F13DB632;
	Thu,  4 Jun 2026 08:33:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E33C199E;
	Thu,  4 Jun 2026 08:33:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562036; cv=fail; b=TTm9q+QT90BYI1vF6fXugNvOqigJ5Af0onCLzitAfQ9542vUwL/UZzTz40yjNiOsiZdHqnIYPqMo49WOVzTqqnzIMQPdleCjFR3huH0bEAdu9Whf40hfQWmuE+zU2kZ2XcS3csw8h3l0GYwhtuFiW4/INTqougdMYQvwz6bus/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562036; c=relaxed/simple;
	bh=WvIobnspReK8B8/U6T5AJkNGJCRDtO10dTtcPzEz2KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NT5vnPFzeqg8nxTMMT/KdLAUN77Fh9prLKTJLTPRT9pBXzO5uBgnLUzrePEsVLd8xw0xdQiPxDPFOx05Dl3mtxyN95Go5IQtCCaey/mzQQYRW0VuctfpuahVisEhNOL6in09H5Gzd2GvKXtsJLgpgZJrRqlGVYpmsFuJ9aiFwrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IwnVPdaL; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtkyxMMcqK91j4spBz4C3sjzftoeS9ViFSxAnAM1/uG1wvLd9Wq0Jy9xZ8PrR72doB2S696T5Ri4on+OVzhcy/ORd4IC1SvXy5+rpC8/ITrr+gdQQIrIjpaR3WBEsCzqmMHwTCyf25i1D83kcPlI1OyZD/cWffJitaC2627kf2TcWsURs5nGHuuK7tOUPC38kkNtem361Mu9IZVOPuDkCPziGg+e2LxQg7fcUiqUAdDZQ9rKqs0FjpJgBdfyIgkngG+LkUDNIpYs+rnblLiKFBgthZvIIen6w3ANTNV4vc1Kt5DhP/CpZpo6YaHn3uCrTjUthu0q6Z8GM5jYLfl2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAOP7Q3vqZ8u70rJrMqcToY3LFs8448ocnO7Bh/Pcqc=;
 b=k42jHTSpM60rcOnPf1m3yuMvlDHpjy5hEIvz5nT7sVe/tGwMaYqoLNdy3JOOnuJfJyUhqrchnSEASb72VZalm2gxgUflsXT5XZ/h/2mxn/h23YlP4T765Vo4dr90WFPR5CF3pb1urxYKYdyqGSDrCIi0vs7b45p4/U2HSXcbfIpoJWAEfZ2GT8W1BYyV9II/mEYQ7rx5szGmjYoTHVqbtYzwBjRcdbZQrOXYFZGC6xNGFhwyie66LmoITsn+1fs3e54W1rzojH0j10+s6qCg6grFiytIif9t548dtlgl/e+PWbGZxxcwRN3FdM5vNo+IvqlYM9V8/Ndzgg11xAq1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAOP7Q3vqZ8u70rJrMqcToY3LFs8448ocnO7Bh/Pcqc=;
 b=IwnVPdaLopo2AYYHIL+8kbMuDT+VDEnC5FwDF6vhWZkLhXxXnaIkDQtbuTLieGzDD+k045UG4OaaB4R6nncoxwN/5NgzNWZKEnZUHHqF+JzoPpGqSbiTLRx7b8Bjc42GUKhIwBSXrX/STv7xatE3dM3RLl3Uxy+/a6yOj0cC1g8hNSVl2DtkglRdlXKAQ7GcH0ae1QScJ1pEd4TC87hWo31EYUKg3dylQ1RMqB0MaECg7tCX70rWAyVlGKBwrzqPpyIFm46rjDetMK6WYBmfA3XeU59O714ypMtypCzgKxmq4n0t+riM2CtV5JKPoNL12p6XnCRTm8e4hi4WVZJ4sg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:33:53 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:33:52 +0000
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
Subject: [PATCH v2 0/3] net: stmmac: L3/L4 filter bug fixes
Date: Thu,  4 Jun 2026 01:33:47 -0700
Message-ID: <20260604083350.1701-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e051c8-6428-4d36-a1b4-08dec2140231
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	OZ8oe3RKUtrATpjvmUoqXaI/PK7IklqGTlpNv+qE9kftcAf3PLZ++QMvUr12kZWbtcl/zCX/6NiAiusL2lNOGHNgWrUoMXqFTHZ8TSlQM0w/Z5JZw1l3iGrWQZgOGlvdW3xhlKfp54hqieG3QUzg/dFOvqxYm40pVQ15BmTq5k1XEicouWTmP8rosNJ0qPCM7RbVep76xdwqVJEP+fwXxKCgEc8LVXfXx2VTRsbcbt2gleBUV5QAWevGQ9TTOey0eFgE3mpA3igq08ux7SsxQmbJb+MyO1zyvu78FbS/UifjATInKf7OiSJtLxaSVAF09y0itu8Lr29thAX0AV3+bU4W6IF0mrUsp+kFxp9ddl0Bz2OBnEsufORVObX2RHlvnshRz2FCCnmyBsRfsIeBMGO5vvtWoPXs8mfUJo/ht6nbn1UZIBT4BlMfXOotvof2BHCQjfvO3dagpBKD6f5ObXCeCVJTSWvV5QuEfRHAGIx8ncTsK7pIH9btBMaeWNB0qEEmsuz+ytMc/PiOhb0Jb767Dp+1749vh6XWZzMcgUcpGL6Q1PcHRDclYG0YCd+yr7x98RmdxatfjSZtT//TGR9pPHbjwEWM2eWmL5bqXnPH63q5w1ujQtj1jBo2VM9z8XU8hCywIyQ9g1nSJtwGtzrcK2IySogwGayddul3LR7WK+SnlFyYt4Zl5PL13sfg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PT8P0RxhUX5dMdzUUDdz4e0HkGqbx0flwz+uSunzg9UA9dMk8NAfk5VZH1b?=
 =?us-ascii?Q?2t6CBeEjL6bkz7yQbgSTM0R04YD10T0RQVsTlGy9NUPQTlrEGxwndCtYGTtW?=
 =?us-ascii?Q?BNybzLvr456WOPhLL8gXf1fjvn4CIS28wrDqtRFkLobPA0U9unS83WpeA/c/?=
 =?us-ascii?Q?hSm+60Y/G292ygWt2owu/na0yGos2MrlRa+TgrQXvPa9mx40AlKGOw7iqHY5?=
 =?us-ascii?Q?6IaEW4Y7ADhmaZPLo5xkm1zzecz7TckuqY2MuCov3XmBVoz/0xIQ5a0Y73nT?=
 =?us-ascii?Q?chgkVj6qgrq4v59WjhqnRz4yYZnmBRwz7cCTFb4HGjw+03sVqHgESitvDrkK?=
 =?us-ascii?Q?Avpy5U0o2TexGu4AXsd+DJXFXzQlnzon+hMNEM5PiRcx68KgBFdL2Mc5C07x?=
 =?us-ascii?Q?Lo04bCvRdqwjU7Ib1u0R/Dfuv821DOfJ3lrGqu/wSTVun2iN9hF8jrMITkY6?=
 =?us-ascii?Q?tWpFvpREpMUDtk8j3GNibhC47evrpRxNb8bUARPHiRRWccxGRJ64s+TwS+27?=
 =?us-ascii?Q?XuS1pPQSkULJH1MJQEPuFxRMgI2FPdC8DT2Qg0nn273XDNucX+QPumdhBwtM?=
 =?us-ascii?Q?zwrzWiMm7bfyfLATJPqSTPi9rWuThITV5pfbtw0ne8e8Q+9sZmgqVaJTQs+P?=
 =?us-ascii?Q?dMgR+9RxsMWESZuSzUvNpXRSvujn2m9DrdRgqRTGKGI2HoPfQcuXF3qAMWad?=
 =?us-ascii?Q?e/xB9+1EEtOOuPnm3C7kN7AKsEz720Rn4RMdjYdYwTJhWRLMlaExJjXVh08O?=
 =?us-ascii?Q?ckJni4sZQrWmC+YIG81cEabKA0U5kZgR9VakbY5x5eof0k46JmzLLYIhdljZ?=
 =?us-ascii?Q?bJ19BoSRtSZrmGpyRYvFkAIAwKIWW98QqCK+n992/xu+ZC1YJnDK5grMkH+v?=
 =?us-ascii?Q?CmaD2mQBdwf4goovymS5U7nZFcMKsGAS//Q921wpl4SYfbgjFywqheZ6B9g6?=
 =?us-ascii?Q?lfrXznX7wov+on/bfbO4xzM8gd0gV1IYLNCkaRJExfVUMjblNcRCZzZSosX4?=
 =?us-ascii?Q?uD/UqzTt8/IeyOR5kElVjx/uGFmowz/E25Ex8CE+jdVJybOR8xoX+LgPIz7I?=
 =?us-ascii?Q?II+XgHhP5eczLmGeoIaRH6DGlaYBJ40bvj/XlG51OLY+HThi2NUaHHTiFG5x?=
 =?us-ascii?Q?vAde2KfCG+MNqFc5xiTn+QOSrq6tmQ5d2y3oV7/cUNQ55XetCu0JXanEtrCO?=
 =?us-ascii?Q?drUfI5WJl3THVQHjykGeTzQ35MwuM+H+MxhErpvgmCAk1L/gAH1b8VmCi6+R?=
 =?us-ascii?Q?2DIUtnFchzZkXtLrrlOYFzfJTTlxOllINuW1Qa1AqE98DKNzTQfIhuoDoMrt?=
 =?us-ascii?Q?zNwIYL25PU4sNDE4sXi/mE9cLIy6AA0vcIQm18VH2J+o14s1qlMdKZ3sVkGQ?=
 =?us-ascii?Q?yu5jn4bnfr123x7UuLjBNB7VBEBJFsexI45Pw+L5YLH4jkopFn6RlZ0Vn2N9?=
 =?us-ascii?Q?m0bgMHsi8ethzOgqD6LUiEiPLlTRlkQ+w3ezI/1mMCq5MVEGbmsG80JB3N2f?=
 =?us-ascii?Q?mTPjHDzR3l15/cVtmTNBRsAS9FYvnI+YSEumJrBA6acF/xttGVqT9Zp9Foip?=
 =?us-ascii?Q?EP5I4ZpObryez6NWbftsoOzte0tTx0gReaJ2OW5SirEtl3pa+IqrYB9TmnQ1?=
 =?us-ascii?Q?b+Cl0AJutugvNq6QaYJc7BoGZJclO6/iyLxoEixdta6rDj5hNId3UB0sllNO?=
 =?us-ascii?Q?6YPAplAZ3kXEV7bzGDhtXrjOvuHfuxPunlqm5+qLHL50kilib5LYcI5UZMsG?=
 =?us-ascii?Q?jr/VtElJurpJW+MFcdLZ76mk2m5KRNkhYieNrY7Id4dTetdnA4pCjArfeWUU?=
X-MS-Exchange-AntiSpam-MessageData-1: JL0nykyV8WxjnA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e051c8-6428-4d36-a1b4-08dec2140231
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:33:52.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ/hQpXY7d9GaaFNUpTkWj5cdNeVGadx7Cq2HurMQ2LXGmCXfBGcqS+JleEAbmvZNfsyF6ac78Ect4ukqTpQop+99R8MSewpwk0DjDm9LXb1pZpTZChKCgELolmkTakPOOxagZ3TzC/i624/+N+WSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295105-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13CB363E121

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
and non-TCP/UDP transport proto.

Patch 3 fixes a stale action bug on filter deletion. When a filter entry
with a drop action is deleted, the action field was not reset, causing
it to persist and potentially affect subsequent filter configurations.

All three patches fix the original L3/L4 filter implementation introduced in
425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").

Changes in v2:
- Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Nazim Amirul (3):
  net: stmmac: xgmac: fix l4 filter port overwrite on register update
  net: stmmac: fix l3l4 filter rejecting unsupported offload requests
  net: stmmac: reset residual action in L3L4 filters on delete

 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 27 ++++++++++++++++++
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.43.7


