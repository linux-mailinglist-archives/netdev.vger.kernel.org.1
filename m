Return-Path: <netdev+bounces-136822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51609A32A9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893E328150A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89EB156F45;
	Fri, 18 Oct 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="V+cTfITn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBE1714AF
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218135; cv=fail; b=HmQVeWM6NCHRg1sbKq9D8rMfBgvZeeZelr/Njclfr3CyqvZNlUkN1IBl2xqbJdQEEZXffY2vfOGe9vFzf1gtnY0so1g1tRzJ1uD8PMxS150ZTiKN35AsBPySpzgj1TEFZc9ozJtfinNZq9eNSZu10OuKGFpcGDG/ub0OHV6LIaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218135; c=relaxed/simple;
	bh=fKBbeaPVW8DcZ6DYlD8c8/FTqvLtUMcI3CoRxLvDMr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+5qx+6ePi5u6lp6Ny9/o1xbaifpWg+OAMYHis8NU7efSrZHxiaWZN7r1lschSCIJs6CiUiaZ8GC75FgJdyG1TPQwCGZ7bSzRnw6IGfNVWmXBEWAUu+LyDf0SbfK5Mkly0E04ZoR1AvBW2Gfkxt3yre4uKn9rdXDeAO78xG7sWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=V+cTfITn; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci+Xs4aym2h+n/gJmljT1N2z5TFqy8k0ZvWpzZPyruc1YzdbKDEFK7VnwRFCJjPFxHGOF5mIzPAHlP3pYRt5gWf6BlFQnMtpQppdkndwgBFdLvz6LaEJRQ46+KywKlDPLP+mFY9k+rG+ugrMTK0JSzRjougLZFvBCjWHojbUb/eQ2AbzcE3iwcfPJO4pXFBBGSI8d3BaMgAOvcyRriKrxx621yQ6S5arE3vkMEkS9Gca1CXfKKkPFGeYzDvlCvlrB9l5mgr6yTVRusX/tHgMtzFLraUkrq+ZQ2Y4+AOhX97xa/iXgB6JtGFCfuLx4n8dJMkZCZX75hxuPGkGhZ40zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS+bjUXzLdWxU/fiVihhJtOmIUpj4scV3/uP4j163Rs=;
 b=m3gXJU2ALQALADA8mwZndLWMCvQjR9AgkItLupnT2yuBnFvDU/e/U1+x5zS/CODxaTuih/XjegmEU1yy107dz0gzqO6o5l/6zgIIjCUjejoql6uvQCto9qicbTU3nDYjZz3jfAuORY6/q414BAy96m6Vk+l+EJPHoJPl42EiTr7fOxWAIJ4R0f4djlR9HBMB1N2lDEnKeqpG6qkcHNgBHC+/jAhnsfhLakNvnQEMp3T2lD/mfpRQ7vjaFwrZEcFCDdc8cTNGE2kWGyjo9b+IPF0X4fZXFB3yOdq1PPge60Ep08Kk1DAvzZ/Z3Eq1Y5KjVJ2GTx4AXJEIoX6ip2FVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS+bjUXzLdWxU/fiVihhJtOmIUpj4scV3/uP4j163Rs=;
 b=V+cTfITnIDuk0/PW7hWRy5aokeu8K7/c6J0ryndOxS7gBe4uBPqXEpRhaDOmUV6B9CB4s05MGmNrDKkTq2uqku3z3fR98kA+UB8XCzgyMzfBP8ZUmUqgbZb1kkGGz1t8NWHuQsJjZYsBU9V89PNBUhNb5IXoWprHDjHyfLd193IBTTuJxwOtZahnzfpC7+l0AsTGSorGOvXGFmhhTsJBT9je3qnIVGOMNFUhkDoXOrJ2sghb/iJ7t5FLe/ZeStoNQ4XmJFahgR+cJVgukM1Fxgc+NCAQTaZPwTcV2G5eH61UzWrcGfTyb+kgRXFQaDSizORFgFqrOqOz34Nk+SjTdA==
Received: from DBBPR09CA0001.eurprd09.prod.outlook.com (2603:10a6:10:c0::13)
 by AS4PR07MB9659.eurprd07.prod.outlook.com (2603:10a6:20b:4fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 02:22:09 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::b2) by DBBPR09CA0001.outlook.office365.com
 (2603:10a6:10:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Me023685;
	Fri, 18 Oct 2024 02:22:06 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 10/14] tcp: AccECN support to tcp_add_backlog
Date: Fri, 18 Oct 2024 04:20:47 +0200
Message-Id: <20241018022051.39966-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|AS4PR07MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d648858-640e-41d0-6e2e-08dcef1baa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzRXTG5qV0d0SXJ1bU93VHB6REhuTEQrVDVQQnVVOUlNaWRBZ0hLVU9YZkJh?=
 =?utf-8?B?d2lTbDAyZU9GK1l0SEJHODZ1WTZwUlQzYjhrMVY4aDNQZUlaNHdyTFhONWhV?=
 =?utf-8?B?bFpjUVdISWQwanNHUWlrUzcrUi9DV1Byb2NUa1F1djd1cGI3WWZrNWsvK282?=
 =?utf-8?B?ZzlGZmhJVVMyeGJRUXh6cXh1dTEwZTVIUmJOSlQ0S1VUdEZ2TG1xSzN6bFJk?=
 =?utf-8?B?anB3OE5JRk4zZm9QcVhuUGU0aG5LOXQxTWJla0xDRHpFUURJa1krSVNJMHlM?=
 =?utf-8?B?ODRLbzFMUnNVVnlNWDMrSXJkUHIwRHpNOTJLaHphME9vNkZIYzJVK2RsdGtt?=
 =?utf-8?B?WWdFSmNCTGpQd1psMnplRUs4YmVVR1lZeTJ2WEpUYjJsSE5XVUNwNFQ4NW1M?=
 =?utf-8?B?YitPemYycncwa0JXWUE1VkZBWEQrOTE0QXRUZUI0U1lTRWxic3gvczlhTnRG?=
 =?utf-8?B?ZFlOWWdpMk1IZVMrR3FNMU9NOTNlTFZrd1pMRi9xK1FLaEN2SGgvWTZIZXpx?=
 =?utf-8?B?OUxyV2ErU1Q2UXA0QytFaXZaZk50RlpwWVJZYW9lb1ZtVWVVb1hyZmJQc1U2?=
 =?utf-8?B?RWkrbGlmVHkwN3BrM0dnaXJNRlkyaFJSSVN1cTZPck5VcTA5SUMwVEFrdlpL?=
 =?utf-8?B?YjJqOEx6Zk5jdWxsMm9oM1dhVjdWZG9zWjBJMGZCWkpXaHhmbkFoUDFiemlE?=
 =?utf-8?B?NEFaTUFSaVErYU1NV1V0SUFmVGFJZ0lGQm5oN0d4aS91V215OVFWWjVZZmll?=
 =?utf-8?B?SDlxV1FVSDRMQkVCT3g2c0tkWmdIRjJVb05ET0EzeXJtRXN4Qm5rUmN1d3ZF?=
 =?utf-8?B?Q1p4U3RiOEtkT2doZVg1TXlMTSttSFJYOTR6bG0yUjRkMUxwU2xnT29IWFZX?=
 =?utf-8?B?am9TdTJFbVhETVdUYzUwSFYwejJsRDF6SGRUTkZxcTVoR2EzWnBnSlQyeTN0?=
 =?utf-8?B?UHFaYUtOVG1id1V4SVRaVG0xWVhpN1RSdXhJRnZoQzZsVURuYnhpUHVHT0R6?=
 =?utf-8?B?aWxjSllVb3dBRkxEa0pidU9nRW56UTRuMCt0MGd1b093cEJIamJLaTVKbXQy?=
 =?utf-8?B?dGlnUzQ3LzJDSnVmc1NYdW13TzNjbk1HQy9ZL3hmbk9tWkZ0Ykh3UzVEZTNq?=
 =?utf-8?B?NDNzZkIwb0J5UFBrRjZYczRsOUVueDhmV21MWDhQcy9oL1VhdUZ3amxlVU1v?=
 =?utf-8?B?UXFNOXZDZ05qYXk3RTY1Nk0reUc1R2tINnRabG56Ykh6Y1JNZVcrQ1FjS0I5?=
 =?utf-8?B?eWRCK2tNSGdlbnI3cjFXWjVBZG9aUnlraFdNQkhDQUxiUUN3aXRaOHdMZzZu?=
 =?utf-8?B?WWZmNFRWdzVmWGVrZnpDQWRkUVpFLy9QemY0ck5FUWhEU2tOUitxdzFyMVZj?=
 =?utf-8?B?dXQzY2FWb2lyTFFrZGFnb1VMK3hoTk9CL2RSSUFrU05oN00rN0w4SDlkYStT?=
 =?utf-8?B?WGhidEMvR1FVUVh3OE9TclQ2ejZTY09SMG5lWWtTSmcrci9qTG15c1Y0WXkv?=
 =?utf-8?B?TEdhVnFySEpsYzhScXdCaG1GOTA0a0UweHlUeUphNnBuRzRnTXNJYko5R0s4?=
 =?utf-8?B?QlRJTlZ6OXhBVHNLWHBPSVB2UEJROVN3TnZwb2M5RHY3SG1rclIxOGNyZU5N?=
 =?utf-8?B?KzRBNHBIWFB3eDVJRlBIWnZ6YW5vTS8xTG1EZ1MwV09mYk9zcGJzZ1QyYW1L?=
 =?utf-8?B?NXgyZFcxMnREazdScXNlcTZkeS9sUjZhMm5yVVo3Q0lFQ05xOU5zZ3E1Zm9G?=
 =?utf-8?B?dXg4RGZYdjl3OHpHeXVWY2d1QmsxRGw3TFYySDRrUjBxNVp3NURMbS9Sd3Yz?=
 =?utf-8?B?ZGdDWUxqaThWUUdIZkRlRUhqWUJURHJWNE5hcDk2UUxqbEpHSkZSNU1jSksz?=
 =?utf-8?B?U2tiQTBaTkgwS2RGekcyUjlDS0lzQzBwS0lwbDZ4YkNYNEN2MStvLytFLzdh?=
 =?utf-8?Q?LFUHYfoc27s=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:08.2756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d648858-640e-41d0-6e2e-08dcef1baa8d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9659

From: Ilpo Järvinen <ij@kernel.org>

AE flag needs to be preserved for AccECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9fe314a59240..d5aa248125f5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2054,7 +2054,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    !((TCP_SKB_CB(tail)->tcp_flags &
 	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
-	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
+	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
-- 
2.34.1


