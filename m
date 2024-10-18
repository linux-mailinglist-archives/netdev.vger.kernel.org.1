Return-Path: <netdev+bounces-137169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2860B9A4A01
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442941C21607
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DB6192B89;
	Fri, 18 Oct 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="E9L3hGxk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B71917C7
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293641; cv=fail; b=e+GAWYoPeut5+vYHP+wc0aurYaTtiKQpkCAcVjCN9Q2KC/85jutwTr0S3gwaAh+Jxfkai6PDPbwEvL8ngMf0ovoz8IOshP5gElNcf7aAiHLTyC+D0xrMFE3iFT8pOQkWZ/GN5Ndwu64bxiV5dhxklGLlHix8GuncivLi500wyJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293641; c=relaxed/simple;
	bh=4j5SJ5HYuPel2Dv+IBBWRsO/17dTAoza3QBOY2Scc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hb9FH4aF+PLn3kSZr35RQa2pf8FldjxOoWeKcNOiAfqevHXVHnDbB4Z2kSAxxxa7lbjv9XDmHkv3bbzWScbBGiOE0elqG3W9TW/TYvG1HghkSSH20sNnWe+C3okA2dwQrMoXQ2C4PNNil4rRhlB3bvczf1klspnBWFx8Ot+GFys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=E9L3hGxk; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4rw7rFREmGJoAPC9mdThqyJKmCMZLmXH59cyUoVlh8V99ZwC/FAKdgBuX1iGuiXcZMoh/gFa/udOClYDy6TpwKJaaKJLqEAR/806qy4SZ9Q7L4mQrPqao4Iv9lEsWNo78nxccrj6KJetxNPqo0nLOHNccggBJbIMgVEvn3I2FNIalxxc1NZPQh4a8+w+ZMHzSDyOJ1qUhBwNsQc7OCyzWi+1DSORd5jciRyuExP/ZhmFdc3mc8xkts7bE/4pRPjHlInIWt/3ZH9qKkI6y19HwlOoezyvCjH3tRf5K5swJZZGhEKV7zn0ukaQWhWUL8e/RwQcR7fHIkubcohNYtfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=h4d21AdKXmVgjz5sxYmww6m1+FDTpJqMdbG9AqSI9HDyF72pHgcO5mYpzWEdWOHdqB9U3kJyY3jjJmME1aJ0LNQsneGWAt/fll0JZtj8+E6teSGjfDV4tN4jLnD69GuqnKMiDXRpzgMq6IC/5RjoPvqUTlAulLH9vvhTQlQJj9GemM7T6vzvr7w1b8f2F8CV7QaVBCNwPkDssW5+5hxWlbx0R3BnqOx7NjPNg/cNShnN6ZkaYrQzA+Urbq2ZogPUnYzZltOltF3Rw1OZWYrIDe5Y8iUe7E4e715NlE31c/R3X0Yscj9R1XPRhcvk7VisRr3qwLd1p4t4I8cKnOWIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=bestguesspass action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=E9L3hGxkXRMn3bYY/K6vL+huo8zFDJ55Ug7MHhyWK9XpaslYjLughIX4BBK/U2Z11ei91R+BmQ+XXrC0zA9KODcuceGBB8OMZfjZgY0dTdl0Ey+vCoFwcQML35LsgGXSSMsTgEfP47xdp7X2FUVcHhVZW5y2MLPxIPW7O8S9Vkd2nXZOsukX+vcz0kpapKFi4sqjann/a+uiAQmp07jFBrXnBJ/2OM9fxQ6PFGXjFadh6ukBI5gojPFNs4iAphQ+22wpuzj646B9mCpdjdjJb4HDsPncW0HTT+oMH6B9XJKqYgUn1NfCwNyyaGxgcJ79FNS9wy6tN2iVfQom5HKjMw==
Received: from DUZPR01CA0340.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::13) by VI1PR07MB9421.eurprd07.prod.outlook.com
 (2603:10a6:800:1c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 23:20:33 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::10) by DUZPR01CA0340.outlook.office365.com
 (2603:10a6:10:4b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJY010239;
	Fri, 18 Oct 2024 23:20:30 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 09/14] gro: prevent ACE field corruption & better AccECN handling
Date: Sat, 19 Oct 2024 01:20:12 +0200
Message-Id: <20241018232017.46833-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C2:EE_|VI1PR07MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b919d95-9b72-44b6-0547-08dcefcb760b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEV3a3dRU3haQ1A3STdvVExXYUpSam1oNytlWjN3RXUxbURPYlhpTk1iSjhM?=
 =?utf-8?B?NU5RSlZFaGhUbCtXbU5qZTl5dHhxT1JLWXNneTRIazlDdm1NRzl5ekJSWGxp?=
 =?utf-8?B?OXpQMndwTS9xR2UxWlBWSzUyRzhHUWNzTk02dmpKL09FV25tanEwTHNHeTBG?=
 =?utf-8?B?ejJGNGZnclg4RldxZGQ2b1dJK3lVc2xmY1JPVWRHWUpHcWNIWlpmd0I4SEJN?=
 =?utf-8?B?VzFhN3BWdUc4OU5URS9ZdDhTdktKek9rd0tSMkRtckdqaVU4OEl5aG0vcFF3?=
 =?utf-8?B?emx3VWlCL2lnRFc1ZUwzcHVqaGdrZ1JXZEJwOTdkWnE3bkRhaE54UVlSMVZ3?=
 =?utf-8?B?Sm1NbmEzK09idXRtTi9WU0taKzFVeWtjNWdFdDhyQ0cwRjIyS0pWQ2tCYllo?=
 =?utf-8?B?MkIrQ3k2ZVlqdVNsZmRTOVluUWJSeHJPdkRRWU9kK2RjNnNaSTVwbVJrRTIz?=
 =?utf-8?B?ekZGQzN1aFlNcEVPV1pUR1JUL1V3cjJaSEV5aFBreVhpaEdtQjd6UW5ta3Yy?=
 =?utf-8?B?ME1YaGV4OURJNXFYOFZDUXJwcXVERVZBc2x2RjJXNzFQdDRackY3eGhZelpE?=
 =?utf-8?B?VzZlNDAzUitnMzg4emdGK3NpbjdNUUxKTUZIMlNnanhZa2U4MHp0Tmg1NklZ?=
 =?utf-8?B?aDdlK0RhdWFqdmd5RGhOVE12cmttY0d4R1I5SmFBenZsU2c4a0Y5ZzU5TEs4?=
 =?utf-8?B?VFgyOWNNODBNYnJYMHV3UGxiUzFoS1VFbkdONzZYU0R6OVF5cUllYmVlYzVD?=
 =?utf-8?B?cTAxblE2Y3pibXhCclJWV01qNGRaNTNCT2JFR2xRRm5rdTJlVjVUSFdVV2w2?=
 =?utf-8?B?MlM3Ri8zUkhRSDdZaXRNbTlqemdPOTFKbjVLYlF1TG1iQzNvei91YjcvWnlm?=
 =?utf-8?B?UU5Xbk0rVzB3dFlHejBCTkpDRTB0enJKWkxVS1Y1U2s0dmpMakFTcVQ2cWhv?=
 =?utf-8?B?M1laY08wNnAzMU52ZjVNNzV3SGtTMGFlUTJ6OUpmbm1ubHkxS2hDcHZ5bXUz?=
 =?utf-8?B?UFpncGk0VGdZTVB0Um1KNmtmRG5zNmU4M3FJS2tWRTluT1VkRkNzUVRuMGdw?=
 =?utf-8?B?cFM3aGJhU3locjJkNmx0Qm5ucHRvWERoZEl3VzIrTHlQNU5jN2RpcUs1MEY1?=
 =?utf-8?B?WWtYcjJpVUFSY0F5M2RWalVkc0xNU05WdkJsV2VKVjVIRkErVDJyUlRrcjFH?=
 =?utf-8?B?a01OdmNFTmJYVlUwa3JpdVdrOHR0QTFJS21DRWxtYThGb2IxWk8vM2NWWG9h?=
 =?utf-8?B?bnllQjd0RWl3Mm81dWI5MzNMOEpzTkN6R3BqM09iMVRBZG1SOTFMZGJrd1Zj?=
 =?utf-8?B?Y0p3VnNBcytYV0U3UzBQWGdGTS93dGxGQ0VGL0NpQXpkWmF3NStmSTNwdEVk?=
 =?utf-8?B?SG9yMjhENkdDV1ZWdFJhUW0xTUloVk0yT1VhL1F2eE1ZaFBSek5aWjlYR0F1?=
 =?utf-8?B?YnQ5V0trWExjRmJsRmxIU05DbEZGRWdsUC9WY21vKyszUzE5WUx4cUdQSWV6?=
 =?utf-8?B?eGJDQVJMV2t2WnllTDlSc0ZORXRvaXBRN2pyMFBndEsyYmJycGVzS3BUczE0?=
 =?utf-8?B?TWNiWkphaDJqUVlkNnRuNTNiMk1KVnZPb3lUVUJIUEZ5cmMyZGxobUUwTzFr?=
 =?utf-8?B?UFF2bEJUcTc5WnVPTjJzc1dqeGFEdmE0TlZ6R2VhK0QzcEV4YW5CMnpOaU8v?=
 =?utf-8?B?WU1TRHNDU1didWE4M2RaYVpUdHBxNTNnMUpKUXMxT3R1MGpQOGpGQWZWQ0ZY?=
 =?utf-8?B?NU1Vc2dWZE82M1JKMW8wbWk1V2Z6SW8rQ1F2L3I3WEttdllUcmdtWmZFaEpV?=
 =?utf-8?B?cWZ6emlseFR0c3c0ZCtQcUg4VnlNd0MyVDV6RVc5d2FPM0x3RUNUQzVsWlE1?=
 =?utf-8?B?R3JaYjJReW5FeDBvMUNQNTlEakJ6ZTNCV25wVDVUVmtOenJtdWVxOC9VQVFV?=
 =?utf-8?Q?9GHD7DXLfrE=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:31.5882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b919d95-9b72-44b6-0547-08dcefcb760b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421

From: Ilpo Järvinen <ij@kernel.org>

There are important differences in how the CWR field behaves
in RFC3168 and AccECN. With AccECN, CWR flag is part of the
ACE counter and its changes are important so adjust the flags
changed mask accordingly.

Also, if CWR is there, set the Accurate ECN GSO flag to avoid
corrupting CWR flag somewhere.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 0b05f30e9e5f..f59762d88c38 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -329,7 +329,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	th2 = tcp_hdr(p);
 	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
-		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
+		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
 		flush |= *(u32 *)((u8 *)th + i) ^
@@ -405,7 +405,7 @@ void tcp_gro_complete(struct sk_buff *skb)
 	shinfo->gso_segs = NAPI_GRO_CB(skb)->count;
 
 	if (th->cwr)
-		shinfo->gso_type |= SKB_GSO_TCP_ECN;
+		shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
-- 
2.34.1


