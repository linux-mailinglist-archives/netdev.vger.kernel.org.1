Return-Path: <netdev+bounces-254295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOJDONgfemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:40:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B232A2F87
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3627230BED57
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81748360746;
	Wed, 28 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AX4F9TBh"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C752358D34;
	Wed, 28 Jan 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610911; cv=fail; b=Ar0Im0phvQNThOwlkOfiWwhRoIl1YgRWRykH8Xt0L+LsKwAGbhP4mdV60LIrAEOBtweqRTh07D2zrImyxL4UFBW3O5/DDPLrYXut+2UjHGMgKcXtVvvACLXTyHRDCc1wPgyt/ign9PrfJccasema87bWAZ9iN/mzYi3udaSEq6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610911; c=relaxed/simple;
	bh=aCGsXc0ECY/51S4/B0Qg3jxznul6XwrSFbVpn24dnzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I03F8lAAcNgkK/eUs9qrxzXxwd26swequUMYNvTx9coeDxQv57stH+5Axj1W2E7qVLFRp+nfr9+7C+3y0qEr0sto+MOAv+ectwgSOZ9sW20cnAIoMcLiE7nN2kCixuxN8mSqGsoXLPRgqzyF00lO1Gvfyi2eoMYogj/bcdcUcz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AX4F9TBh; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmyvEwQ4dezHn2iLvPJQchthV+rGztIT/5V3XiUCdIeyk4KRY4SamRrWiIHEzylY3+lyA0sTxJ7Q4pktbvvFfHLHz5HlDFsuCMFihN8v/6B9I/W6/OIkAguJGKEtMk1cMaALCLPt0u15sfAu0LnO0KpVprpWMDhvkoBNuly3+hRtHQg2eBuTz9pk89zHcK0Lv3kds8ppnlbwRif2fhlERZ1yy6pb5FafY+M921or16aEGTwX2h3tElI8T7YWhTjfRq7PbmymLqlU37ULG6KN6GmlKREIeO6W5nolKgl+pau/X+uygItt1Id0nlZrllMbb1snnsgY+s48q3PX97anSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wyfNjdHTW6TPKt9tvUN3NKTKqjlo3f7bHppT8NJiuk=;
 b=Tl4Nt0yorr60rDUpAwsUheOYsjT1vktnPYEV6A5uhWGVxGFeT5BfDxueUCZfvTxH/sIx682JXP7vaONCX1YlSWo1DamOShe9Y6YnF1lhGk4va7FKUC35dOstMCG+1u+XssGTgBdhG3SZFzT2pQopkAuPjWxrpmNdMD3klf+/5svcdzzCELxCA0cwkZ5GCM1gcvxU1vr5yIrfoan5XdXuBcGWvN03NekbhcVVwn+SHqnfIXHrP1JsqM2LNaxUu9yU3kOejGKZ3gOVcxhVm5O+W6Pmeg9nUqyMvkpoHmvyPciiJU3MrLYVuQrk/aKz4b2y780LkXrOa0xw2zCIQb3bWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wyfNjdHTW6TPKt9tvUN3NKTKqjlo3f7bHppT8NJiuk=;
 b=AX4F9TBhLeNwRijvwJ2NeYuqUyuDHoWcDsGgsK2dv+gDq79tm8S24FI7wUUUwsQR0EsRaMaJLc2Yg6VoRAdJlILDxuQQsr2MTzUmgNrdCUhjPYidcamRDmTiVeTZJ81FCSpcOEN6ECOSUexTYOzxNqkivSBz+fzy9+ImTaEiZqfFrlUWzGQsb4FaiB+5sN0vMkZsCCu73PbgrQlFLyfhjUR/CayOCZ8IiFsUQK2x5SLILoxrXECR0Kv63UdjpfmQKwdDn9A3LvY54lloMEeGIXPxxov9OZLm0R/fcJcTM+z3BSFnazZZ9FQdHJtq0DvC1HHUohxo40HuMSv7WcQR/Q==
Received: from AM0P309CA0012.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::19)
 by PA1PR07MB10210.eurprd07.prod.outlook.com (2603:10a6:102:491::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:35:00 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:28f:cafe::88) by AM0P309CA0012.outlook.office365.com
 (2603:10a6:20b:28f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.1 via Frontend Transport; Wed,
 28 Jan 2026 14:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:35:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C665723656;
	Wed, 28 Jan 2026 16:34:58 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 11/15] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Wed, 28 Jan 2026 15:34:31 +0100
Message-Id: <20260128143435.15708-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|PA1PR07MB10210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a0f64a9-9dcd-4ddc-c8de-08de5e7a6ad4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KjIiXutSYPqyuil+gIp+2mRzpKOpUemRywXQ8gidjYEJJcVd85ds76kY1liO?=
 =?us-ascii?Q?+4T+8o+I5nc+NYBUF3srHi1x/EZe7RSbf8+Rjv/AQbcedJufJxi0mN+/rXTh?=
 =?us-ascii?Q?efPP4DNIf4zmsMiS0SAXTAoMXwheCJpv+9G7qBMbshh1GAzoF1njMVX088cN?=
 =?us-ascii?Q?XtcM1CHsg2wfzp7/sotFY8RQQxDDLr73T779r5yLEW9wLLDUO6DudEwTwkOf?=
 =?us-ascii?Q?yUHv4aU5GA5zy+A7/C0RT3Z2pKY5jeYx57YeuRUcIwycxs5dcqdqSfbe1sFv?=
 =?us-ascii?Q?Wtw9zQvnVPo9a3VCEAWIUB3vYLXk4SXA3xTHfgydeY6+o5UCS7U7lXVq0FlX?=
 =?us-ascii?Q?g26qtlBhI5wF00yUNiMZdB7cVL1Mr9mENCT93ugOVISHyBSYqYSUE18E6nco?=
 =?us-ascii?Q?SSY064y+pZ/busRDwSiEvzLQVZucQYD9ZFdOlW1sHAMgZnQuLMEiJMyByad8?=
 =?us-ascii?Q?sNgQ7goRnA2djF9ewVh658gJsxTcsKOX9e9+xwJY15OLLPcQvhCaDOjebloj?=
 =?us-ascii?Q?qa2gVs88VdEtfajGFW1mepEO1L/6wGQb6ya4Y6Z7fvihFVDGsy6HGiUlNF8g?=
 =?us-ascii?Q?2EAZoQY9ISizTFWUdj0/v7V0se6+Koz+JljsACJ9EUt88NsW/Lk5hGys7fBG?=
 =?us-ascii?Q?OeNC3m2nIWb4f/Ml8dz7T6KteK4p8z+XM+y3p3sAqxO78OQgVYBwf1F4zpWT?=
 =?us-ascii?Q?MDtTqLtMa6i4L9/pg+FQ3yHwQm3H9g8eXcWnXNEN+GAEXmp4NYUSLUJ6rVhR?=
 =?us-ascii?Q?aMPHQVQ8oVZsRjuEZ81w7aIuIapFXRGEibtzGnLZrnU7Cym8khCRSqELDTrQ?=
 =?us-ascii?Q?TAO8y9SwRR6Cr5WgP5nlNp6OKYrSHLLd+MH5ttyW7oXFuWSAGSsdClrWPF+c?=
 =?us-ascii?Q?MNAYKAV0O4IrQZkff+sFYzLBqEejFm1y3D+fosq2Y7SwcEMjMdVi7BPKsODq?=
 =?us-ascii?Q?t4la0XD//sLI1L3p5AUlaOe+c1rNm5rd4XnH3js8auKfr21netfYbgdeJa7H?=
 =?us-ascii?Q?eOzta6zwNc3ldkQPeLtPCqsfvnJyWwEHPfsOy0uwJSiljQH3gWfDsvDPs4LW?=
 =?us-ascii?Q?iDs9tvxexV4w6djkN/MTwXdsEL57L+XTX0bTvNagkc3mNrBcXYku19qLkmyq?=
 =?us-ascii?Q?KvPMfhPDQE1f6fQSXHNqHT380PTa11QMbW1b9/L/euYuYF6On8rPKYDeNg2X?=
 =?us-ascii?Q?2lh5giWIdG9M16QFWbuk9iJRe9WDAUnp/vxYNE1WWjPXdt6kqEKLg1KbrhJ+?=
 =?us-ascii?Q?aBaFMFC82d0Ww5qHvAvoY/8RdvfzDI+oyQGJMLatfSfhU0ghEMLwI6jfM43z?=
 =?us-ascii?Q?zd6ehuk2Hj10Idafw1oW2cHpdEqHfhjTa0do/v9nMUs/DxaWMEH5Yd/qhiqQ?=
 =?us-ascii?Q?uZd5I5a9ZJRFVspNlvcm6kVif7EgMGbLf5D1qS7VsvhEjkWo98X6rY35v52v?=
 =?us-ascii?Q?5OCIA3U2IbS4tqP4ARj6N6rMQroVFq/j4SumVfenexbfTcDrDiKR72GtQpWo?=
 =?us-ascii?Q?1DgFlNECRgOXafRXK9mdsxAiAGUQvSd/MXv64XpFmrLdApBf1kxKB0xn+6SX?=
 =?us-ascii?Q?yvO0KKW8p1YRfCQN4cUJqLubyuLYLlljll3Iln5rxL5fReqC2mxOb5xnz73o?=
 =?us-ascii?Q?YSi0/LAXa5L9eDpKWB3XZ7s0FHJMShpYuxJkNE02yp/ncDUiw3uTRgQywn+O?=
 =?us-ascii?Q?Vy2PMWZcH6Hf0gbZZdPfaBRoCoM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 JWsaCfAoEwOi94TgXhyn7/SPFk8ngp7kLQ474Y+aed+eikNgl5vGrKwclZoWG4v0z8hkmCEN9fjomKyZgn4TyeUgzslQN4ZO93Wsa37wMtC1nf5LcaMLk0riuGFbjp3JzihDlo6J6rluIV/gVRyXRMUYNyyxprY6KbDbAFeUpa78jqsdk3iTMJAhsNGNeQfVqrLnIW1DjReVIrHWk+6oY7oXU0bK9OorczA+Nv4p0C7PgVAH/7dts5pkbVnIYqfry5CAj75BhZJTeuLPdcK4Fqnah+N1hna3TazAnhWIchSA6Fm+5oqgCIoJInXnsPaqFNM/CLWsp8M3fiIKVQ4gC/+qahDL1mznkrS/NvSRxZwAjTmxO+JoE1z/l0EGz0DSypy0gC3zwX0EevAZvdgPngoYYm49Gg336lhgin8ndM5PVsK0cVgJ3tAZXKC6daAL
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:35:00.3816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0f64a9-9dcd-4ddc-c8de-08de5e7a6ad4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254295-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B232A2F87
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..49e0b865fe02 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


