Return-Path: <netdev+bounces-254285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHP4B8YeemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:35:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C0A2DAF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74314300C55E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648535EDC1;
	Wed, 28 Jan 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UW0Zh069"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09034FF75;
	Wed, 28 Jan 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610889; cv=fail; b=n/bW9eyvgnR+UY7Kw68TfvX496L3HT8MRSWO8a7sXKvsa781fI9knggNYZH8LSsgTPpCZRJQsxW0emccHu4G3PodWNftf+35uQOreLtoDL/gYUykzmznnAsO5O6RYEEkfjsICjuN7EnC9MXOP/C0TtYcuQJ+DdlHe1+lMptI5aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610889; c=relaxed/simple;
	bh=Fd1FaxLYEz6xZ2AGiIP3sdzQ6XTCI7FMlSaiA16alto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZ7dU+mEg/1JSPQ4EFsCzGgDUF23VpRE1azXfhCVhB8ZG4OTGQOkiIiJFu/sSkQErn5ro6AgtZusC1TObCxBHLqWebw6orqzgSi5AIsZ9WdYPyaeWpn5wcVugE8ogNMHGz6bYVYeUdViOpyu/jQ6eGewV7cmc8MQjNCCBdtDEiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UW0Zh069; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVwS3DSK2/NGecir46iAUwniH9/OJ7Fz6ZUSZEALQcpl5IJqSF98X3pCryYRFmiNnMnsFtAxaWT+Nsw2CuO8i+yroQrFDJok2m300u2VgqSnj072AIN+v4mahj65yOzkcoaVMKewIW934LMc3gx3UoOqwJoZnQQOsDEaj6wZAdifchnl3qYBc7G2PzuXfkZrrNfxpQFV4pJqELQFnrdF2rC2LLUUXDX0P0nEUQQWmF8F3ThqAINPINEP6lzp8zQDZn1o6C3zPIBYS0ypLzbQez+vKLUiUTgFyEZK37etkdQ/LwUj+SXMTbdjSsJKwtZqAxg7GqacdPLQ76PuhbOzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgF6wgdKGyAN98Mpvcl/dfVxI+c9B559KNGTjPo0tKc=;
 b=CfiTvtAp1j0IVd6pkPLoga8EFvzyaXAVRMIYxOTMqOdBLo2L9+5GFGu7NjMh8j47dBCecb5FzmKSWDxr3TghCx+XypyLj/2K/c2Z0oVGT9MMrdn6w4EG43KvfNTzjGgnVWdLmMYwi05RdRh7dgWXPOQkEoOCl8ONObjcImuiOnnLzSe8ExTnZJm25ahfyj6VEBZrTv2crQerW1tCx2fVLszw5kCX3P/6f79TYvRzm1+af2NHzIQ/dvm4Syf5LKvblT92cR+i8MdngDf3YVbGF1tBvTaAOlwD2JNXWIZEE+3tUc/d5x+NRclscmjLtvLF9e1f6S4WX77N/0Br2VJLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgF6wgdKGyAN98Mpvcl/dfVxI+c9B559KNGTjPo0tKc=;
 b=UW0Zh069TkmN3WcHP2NzwA31kriGnFoDlAz4sLhSnQCxF5XnHDPRwAJLpvchBBwTv0wpikKS0iVSAotIsSqrhjIzi9jYqdBZmI+wjt5BWltoAtPOzfEQ0DgL21eyx4B093O7xhtZqM3Cc64w/rEkNdULz7A8ju+SbyBz0LOhB+EAOjtVX48M1Udqhhl4d7ctbNqjzlBFfmsZYNYxq0aNmY+pij2P9O0ywy3NindLG4+Rn9ORh8mVKOAOa37uweEr/igtheMANt5hWn/+hAP1P3FvRPgFTCS6FFGhBRDNXODbCHeKf05BgfGah8mcB4rGmx7wmahw5nNkwTxHep2ilw==
Received: from AS4P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::14)
 by AS8PR07MB7271.eurprd07.prod.outlook.com (2603:10a6:20b:25d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:34:44 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::55) by AS4P251CA0022.outlook.office365.com
 (2603:10a6:20b:5d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.0 via
 Frontend Transport; Wed, 28 Jan 2026 14:34:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 65EDE23656;
	Wed, 28 Jan 2026 16:34:42 +0200 (EET)
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
Subject: [PATCH v12 net-next 02/15] gro: flushing when CWR is set negatively affects AccECN
Date: Wed, 28 Jan 2026 15:34:22 +0100
Message-Id: <20260128143435.15708-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|AS8PR07MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 256ab0f4-32eb-48b3-58a7-08de5e7a6107
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dXFnbk1vdDlHR0JCQ2tlL1JCSDA1R1JQYzRGMWhweVdnWXVybyttbGQzd0hX?=
 =?utf-8?B?ZmZTa0pIbldVNlNIaTBOTXlVQ3ZHYWo3MXd3ekEzcVJUaEZUL3BWcHErTGFj?=
 =?utf-8?B?Tm41dGF1UU1ibFkxVXo0SU5XV0pldXFyYWlLMHUyR1N1R3ZVZERPRElaOUJS?=
 =?utf-8?B?Slc1dW9LTVNYSkF6UVdnYmFseml3WVBiTlVZT1pvVEd0R3dzOXA2dkRPU1Fz?=
 =?utf-8?B?ZWVERHFwTVVwTDdnWU9zaFRnSEZKMEZVZU9LZ3NSekU0Y0N6MWw4Rk9qWjgz?=
 =?utf-8?B?R2s3M0RVL3hUNmVZbGJYeWp1RmpocXpjeWRVKzhGZU1HNmkwVmlIUUNMYTBy?=
 =?utf-8?B?WEhXalBFOGF6WWI4NXZoR3MrcFBMQnVxZnl2aUdKbEJhZEVXRTlQTmRMWGh2?=
 =?utf-8?B?bXNDektTTVpaUEhodUJieFVOQWZDZHlDZ1pyV3B6bkgvSG9zS2UxeFR0bThv?=
 =?utf-8?B?N09RRGtyK0ZFWlpyaXJzSTU1cTdtdmdLUTlvQ2VUcXVhd1NqakNaNTRUalFB?=
 =?utf-8?B?V0RmcHJSTmV3eHJUblVTRTVTN0lVVGdjZ09CeFRxQWVrelNWbmN6eTA0MWhk?=
 =?utf-8?B?K0lWaTI2Mkp0b3FRcnhEYXpRVU5Xa0V1VzVOZXJER0JXYW1hWDJ0S0tZbnRq?=
 =?utf-8?B?Y1Vab3cveFduRkR6OWtjUncvd0ZjZS9uY3p4alI0L2tKNXRjRnRUek9BZzdq?=
 =?utf-8?B?RTFGMUtJRDVreVNsZmtvZ25CY1p3VzZIVEhEK2w3Y05LbW52WXBPcTF4eVRn?=
 =?utf-8?B?WUJMS2J3TFBuc0x1dDRrM0srUTUwQkQ2UkZNRVNxQWkrdzR2RGU1UjFyQnEv?=
 =?utf-8?B?cXF5TStjRmZTRi9xNUlKVnhreWYxQm5ySDJVbkIzek11UFBKZ1BzSXFvWDFL?=
 =?utf-8?B?REtQZ3pDOTcyc0tCVFBMcmI1Tnk4Zk9rc3VDbmJvSktoMHdQcGRaS2JQcXVP?=
 =?utf-8?B?Tnd6QjZla2JOR1hDcUFSdUpsSFdwaStpbG9INmlwaXhNNVBoMVptY1V6NTRY?=
 =?utf-8?B?NWtrcTduRm1Jc3BxN2R0ZGNyUHg4UDA1ZHVXbUEzczVzM1JrY0tuOXQyZkUw?=
 =?utf-8?B?QjJYOTRuSThBV3RFUGk1dVFRVEJic01kaGRMSlNWY3hOSHdRTXVNYjBzRUg5?=
 =?utf-8?B?eFc2R2lVb2tkWWJ6cy9jR2pib1VibUlOdFpmVHZmQU9xSmFVcTVDbi9QUTZ0?=
 =?utf-8?B?MHlaZ0RCeVg4Uk9BTTFSaEpuUzE5UVJpNHVjRG02bWtnd0w1bWxxeVpsa0tn?=
 =?utf-8?B?eW1aRDRUUDRIWXJqYVdXd1p3SGs0S1V3SEdBM2pYWVdsUU92VElBdm52VmZF?=
 =?utf-8?B?a2htM1U1Q1RxZzlRWkVHUk1CRG5LbEw4WHRxTTJjU20rUWdScWdYWnQ1SkVT?=
 =?utf-8?B?blBOQTRtbm56bGlPOGpYL1BLdnVWMWR1NEdkMk1aVE9tK3h6OXhBdDNmWmZu?=
 =?utf-8?B?N3l4S2JpbTdhN1ZodnFDS2ljbmtFRXZFRDZiUDVkZ0d1QnNMUFU2ZDJlbHVv?=
 =?utf-8?B?TUxxdGFjTE82QkFaOFBFbkxsZ0tONjFyNTVrb1RNU2FsYTFyY21kQ3pWV2ZD?=
 =?utf-8?B?RHNQd2tlQ29tamFaTVRwMEF5VXZka0F3SWp2bmdIRlU2clNyUVB4Wnd1UlhJ?=
 =?utf-8?B?aG5VNGNqOHYxMFMyZmhieDBxWU5oYnBYQ2dJOTJaN0N1RDFDbkY4V2dVUHd0?=
 =?utf-8?B?b0RwRktkMzRoWGxwQUIyNUxYdzZUc1FMS2NXOHVvd09zMGY1TWYzSjYzSTFL?=
 =?utf-8?B?b1RKL0o5OXVPSDI1NldwQzUwSlJ6WmIvNlBHSlRDbWNNNWFkZGQyUWtqZDZ5?=
 =?utf-8?B?Y3p6UXlBaERHeEkxYS9IbFdrbzVRY3lza29wdmltQjFyUkJ3bDRvQU8vZmU0?=
 =?utf-8?B?TjVuYlhYL3NGSGVVeFo1b3d0WWo2TTA1cldUNkVvMng3V0tyVm5nMzZDZzBw?=
 =?utf-8?B?WjVONWFhYzlZSEJPaDlERm9aR1p2MHNXaUlhZUo5OWRaTjdlTWpUS3pvWlhy?=
 =?utf-8?B?bjN1MHQyeXVHdTY1RXpFaytIejEzUzFnc1RLSmYvZUcrUmVNbExobnd3aGk0?=
 =?utf-8?B?R3VhVzVNKzBpZGRYVU1FWm0xdEVDSDNXSGEzWTQ0ZXZoN1k0SGtIT0hQai85?=
 =?utf-8?B?ZEljSVVTTTZ2d2FSQStoMUIyUE9CK3d5QjZESlJmNVdOUVVPaUVJWWxXRWdG?=
 =?utf-8?B?VnBGVG16VlZodVFLTTFMam1MV0k0blVROUNBTTNCb0VQZjJJVklKOHI5emo2?=
 =?utf-8?Q?zTqq7B85Ihxd6x6Xf0l6CFRYHpNNpHAAmIyY2zB7eM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 2Iyww8lgwdRsr1AIIRET+35juQeQQMkx3SC9pf1kOnU13eN3KlJgK8wXVDhic34o3xePPrQQOL9IteVxCgxG07rAdfZ3eeN51lhOlGxHQZIrBjUUrasKQbLVRJiOpOs88LYUNTF1IzXHIAsiKw9ELIdkwblBFBMLa196YlouTFvE+NwJrQkoJJsAvNb2O8I75NYeKuN35rm4k4plfVejqVsewiDmH+ncN0tm+UL/bFDAXXF6eEk1KR24HnYqqThbs/zvcPApxI8f8k4vI7IPVectn+oWENZoGW4zJh4ADUqRTNnIK+36941rulzt8wDIBdG1m322AEYSOV6l/ZQVuBlfbP0QfvgVS2VrJq7nrhFyDkzNpECFDa8av+MUgnSG5+XDRuHWpWrD8mLCXG7Fc0ABbdqWoeuoU9xU3EPbn413VnbYhzEb/qCZWgqUXvbD
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:43.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ab0f4-32eb-48b3-58a7-08de5e7a6107
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7271
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254285-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E3C0A2DAF
X-Rspamd-Action: no action

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fdda18b1abda..9bd710c7bc95 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -303,8 +303,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


