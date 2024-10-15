Return-Path: <netdev+bounces-135578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003499E40B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA61282973
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A91F9429;
	Tue, 15 Oct 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="H+GN/X5P"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED501F8F0E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988244; cv=fail; b=fjN3nCd2CRMR6If+zhoF8REvlc2tl1umjqQaZIdOpNgTw27+9+v/yhgXwQdhsK7VVaiLqmnKGV2LCkr/0Q3Q4QyY04T+GGIr/Ofs03t7zVzOkCOG9QqMg7J6IXy8iEGi/+v0qgHohxcnfJuDZh8Ip5IdqHn90uHAKacKUNkmlac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988244; c=relaxed/simple;
	bh=PuNMmrXmWS8IZSFobeVZ7VQeDzMTU0QXq8GydOUGo54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6+Ku30UnUIzPOtoAuWVuBbEBJrlksU7LwsBNRyzTIOOSsrIFCIed5bOH9Dg8RnW4Wgn4zp2Q7bsyfEgADlXjua+C0TVZpauJi1hbWz7sxa1a3BaK9CykK4Ul2EwUiU+a8Pj9aS2EOidLAJ4urXXvdkLhafmolGD1VgyI9pd85c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=H+GN/X5P; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9KgrQlqGsDAw2WMMSQWZ+IkCDYVLr+jGQ8OStMlCKyHx3IotR5a+GSFmuNn+UH0BGQ10Ivn1f91dW7Cyu3HaOz8uCxFhauzo6o0HnQqWd86wUMYjcD5aTADB8H99kTC7XxDxSWU/bdDX0DCWd5gUYV793hdI6IFqLfSmsGU72YosBb9EnV4/30DIVS6PLtieolxpe9beIIcs73IyrigZYFJLN8Rp+IaNtL5EgimCzJSvL8jlYkZD+cbniQDFcDg+oxGvo5IlKLYUJWosqBHTHujhIcUwJdAJE+2ykUjFB8XrZdjHWTSzqUkfBQ6cXzPg4fh3UHdPn4lQVps9UWRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgOiQFUlQFKL1CKgxJh89B2VNzur7Ac2KNfLdkxozq0=;
 b=RabFvbY6YmUMThXfeB7rr19KOdz7a9BYns0MAcLczWNS2pPKLUkAqAdcY4nFMtCNCxM5CoESgl9X/55hOYhaZZ0AIx5ikQeoDFkJjT9fL1MUpBLsl4T+fO3PdD39jOxyz0ZWKi1M6KcNKDmnyhImnIZQUj6+SkAQ9jtQz8yvjLNoOe9OhIG6KLrDj9fVnDd3H7tn1AIM8Ss7Gtl8L0jWnBTDUviKkFwkmZtgIbyOMjUbqV2wtj37CvvF8aIxQWzaXtVExqndfJKu+8jJ9Du+1pFla0Fjp0oXCp55zeRvBlSd/nhbO2QSJoaL05U4abLintIFm/2KS1qbeIBkSeGkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=bobbriscoe.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgOiQFUlQFKL1CKgxJh89B2VNzur7Ac2KNfLdkxozq0=;
 b=H+GN/X5PrhG0hlVRdrEHqM3lMzXpW9Wcga20NxU+PJFnvi9cMmlgObEaczCIRIo1B5lh+Kk5txxrwZZ7Rd45wVhSvha2dAvDJXqEChcOhPgZCzDDZD8bvTQRmpH4gCHffyA74Dv190EXBxp86cfu0nKbC41WwrUQOD8b5hAMuztLTuKtDDRWUQG42U+j4vb8GZIKwLEQCm4fFrg8PXQF456OT1cd8XfMW6LBerLK4T/PUQic7KVjJXGO0R6wRgv93YXaWz/AvhmKpBm1FmbWnT/AALPNnu9LV9/E6tyarFqQCbO2gojBLi2AJ3I3oUehbUVBZww86nHbxZE1rfJmlA==
Received: from AM6PR0502CA0072.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::49) by DB9PR07MB7179.eurprd07.prod.outlook.com
 (2603:10a6:10:21f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:37 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::ad) by AM6PR0502CA0072.outlook.office365.com
 (2603:10a6:20b:56::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnj029578;
	Tue, 15 Oct 2024 10:30:35 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>
Subject: [PATCH net-next 41/44] Documentation: networking: Update ECN related sysctls
Date: Tue, 15 Oct 2024 12:29:37 +0200
Message-Id: <20241015102940.26157-42-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|DB9PR07MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf2625f-94ca-4c20-d934-08dced04681f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXRtV01pR091RmtrTkNVekVSN3JSZzdyWCt5WDhMQzhlYitDTlljYkpvNnJK?=
 =?utf-8?B?ckE4YytUaWZCZmVuWXpYSVJSSzAwZkZEaEZDT3c3WVJjK2lENWpSa2grSyt2?=
 =?utf-8?B?TjFUb3lYUy8yU2pZQmJxbU8za0gyb00xUVNnY2dOUHU3L2Z2RDVXSEl2QWl6?=
 =?utf-8?B?MW1lNHI3anFWR0tSWUFtYnp0SWhSWkh1dHM3SzJ4c24rSEwvMTR1VjBsVUVE?=
 =?utf-8?B?OGtqUGpqaDQzbjZLY0syNjVZZ09pQXFPaU51NmJXeVhGODZzUVdHMWN5c0hK?=
 =?utf-8?B?ODczdWVKaStwL2VzODkzU3Q1Tnh0YTkwRDJZSTEvamkzY3U0RVp3WnQxYis2?=
 =?utf-8?B?WlI4eG9WRWtKTUlwTXVER0lnUyt3VHFkZXlQZm9xVmhtejJMdEVHK3k5dXh1?=
 =?utf-8?B?bSsxWStaV2c3SzIrQzNDeGpTekFNMDBWVXlNL0dCamZHR0lTL0RDeGRhakhj?=
 =?utf-8?B?Y1J5aEdpQmVrcXZtQ1FYOUtuYzhhYmZzam50R0lZRGRiMzI2eVhpM0IvZ1U4?=
 =?utf-8?B?REQ5bWFJUUNNM2hwMnYrZXJweTZybE5tOHc1c1FMVGUyQ1g1ZldDSGwwT2Zw?=
 =?utf-8?B?aE50KzY1ZVRZQ0x1UVp6QXJVckJIc1FMQlJyZndYMFlWNU10bVEzYk9wckFM?=
 =?utf-8?B?eGF3Q0REYWFQZVlYaEZ1U1hzL1dWSVdMa3d1WjE2L1NHU3h5TWxRS0pTVUdz?=
 =?utf-8?B?N2VRd2I1ZEhFc1JqRGdZSmZCcy84YU1jaVhScFFsNzlZQThpWDlTMkptWHFn?=
 =?utf-8?B?eDBONlljRjZjcEg1RzJJajYxaVV6QUo0aFpxb29oMmJTQmVwZEttMzk2YjJC?=
 =?utf-8?B?Vjhtc0ttTkRJcFJKZE5sUm41d2ZtWWNCS1VOalM0aGdQNTBBenM5NTVWbmhK?=
 =?utf-8?B?V0cvdGx2bGJuSWF6bW9xYWYybGVOSW10NnVxT3YwY0ZPU2ZqZ21DdW5yNWtR?=
 =?utf-8?B?STcwbjlOYlRqK3E4L3p3VXN0NHczbzYvMmo5UzNSVHl4N2ZjcU9keHlmMlZq?=
 =?utf-8?B?QXcrRHNpWHlkUVBPbitOTVQ1b29zWXVldFRDemFqTmxiclFOTTdYbW1nZHNE?=
 =?utf-8?B?QlB1TDR1cVA5SWRDM2hhNS9IZkR0S3l1Smp5bWNIY2VUOE1QQ0dYbjNuYkRM?=
 =?utf-8?B?SUVSK2IveVBpd0hIczNOeFBHZmM2QjVqVFpHT3FNVi9xQUhJNkVlaUVvdHph?=
 =?utf-8?B?enFhRndTcnY1RjZ1VHlDeHdwM0pJSVdIRVROVXEyZmVFTXArOUJCY3pzV2pP?=
 =?utf-8?B?MUJHdy9EVWR0VGxVU0F2aHZIV2VSNnZWcGd2NVRVOEVzeUtzQ2FuMnluMWdW?=
 =?utf-8?B?bUVoWWRMcklnaklYWDNtaEtEY0JPMndjTW9oNkdVZWUrY09rREFXVWI2OVNK?=
 =?utf-8?B?QW42aWR0QjNhWk9PNy9nRWxLVFdmS0hvRi9kbk5NNjRWME5ySnFVazNZVlNp?=
 =?utf-8?B?aVYwSXpVMjRjektCc2p1S05TWm0rdEZEU0QrWWtlWlV5Vmd0bFJYRGRTSlRx?=
 =?utf-8?B?dW5NbkprRDhWcDd0eDhKZkJlbyt3aE45cGpMdjYxZTRRVDVaWkI1YzFZRkZ5?=
 =?utf-8?B?Q3FWR2dOc2JhRWhYOFRUc3lOL2FVcythV1RUTUJWYjVTK0p0c0RBV09EcitG?=
 =?utf-8?B?MUpaY3UwR1htcXhDY0FuOUJYL3ZqMmt0OUI3dW1YSStQbFdlZkN1cE01NnJR?=
 =?utf-8?B?eWNTMHMwamN1ZEpYZlBwMnpxNGhkYWEyTUdoaWZqemtqTGIzR2EvdVh3Tlh2?=
 =?utf-8?B?Tm9QNW5US09pd2xhcTZYVTZkQzBTMVVzVEw4blpYcmJ0T0ZjamVyL3NnNERT?=
 =?utf-8?B?V3Z3Sm10a29EQXR0VkdLZzhBclZIcVpFVStMMjJ6RmhqNHY5dnk1KzNueWZa?=
 =?utf-8?Q?EepDAht6Hqxbg?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:36.1087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf2625f-94ca-4c20-d934-08dced04681f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7179

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Clarified that tcp_ecn enables ECN at IP and TCP layers, explained
IP and TCP layers differently, and fixed table (table headings don't
seem to render unless there's text in the first heading column).
Add tcp_ecn_option and tcp_ecn_option_beacon explantions.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/networking/ip-sysctl.rst | 55 ++++++++++++++++++++------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index eacf8983e230..de6b57775140 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -422,23 +422,56 @@ tcp_early_retrans - INTEGER
 
 tcp_ecn - INTEGER
 	Control use of Explicit Congestion Notification (ECN) by TCP.
-	ECN is used only when both ends of the TCP connection indicate
-	support for it.  This feature is useful in avoiding losses due
-	to congestion by allowing supporting routers to signal
-	congestion before having to drop packets.
+	ECN is used only when both ends of the TCP connection indicate support
+	for it. This feature is useful in avoiding losses due to congestion by
+	allowing supporting routers to signal congestion before having to drop
+	packets. A host that supports ECN both sends ECN at the IP layer and
+	feeds back ECN at the TCP layer. The highest variant of ECN feedback
+	that both peers support is chosen by the ECN negotiation (Accurate ECN,
+	ECN, or no ECN).
+
+	The highest negotiated variant for incoming connection requests
+	and the highest variant requested by outgoing connection
+	attempts:
+
+	===== ==================== ====================
+	Value Incoming connections Outgoing connections
+	===== ==================== ====================
+	0     No ECN               No ECN
+	1     ECN                  ECN
+	2     ECN                  No ECN
+	3     AccECN               AccECN
+	4     AccECN               ECN
+	5     AccECN               No ECN
+	===== ==================== ====================
+
+	Default: 2
+
+tcp_ecn_option - INTEGER
+	Control Accurate ECN (AccECN) option sending when AccECN has been
+	successfully negotiated during handshake. Send logic inhibits
+	sending AccECN options regarless of this setting when no AccECN
+	option has been seen for the reverse direction.
 
 	Possible values are:
 
-		=  =====================================================
-		0  Disable ECN.  Neither initiate nor accept ECN.
-		1  Enable ECN when requested by incoming connections and
-		   also request ECN on outgoing connection attempts.
-		2  Enable ECN when requested by incoming connections
-		   but do not request ECN on outgoing connections.
-		=  =====================================================
+	= ============================================================
+	0 Never send AccECN option. This also disables sending AccECN
+	  option in SYN/ACK during handshake.
+	1 Send AccECN option sparingly according to the minimum option
+	  rules outlined in draft-ietf-tcpm-accurate-ecn.
+	2 Send AccECN option on every packet whenever it fits into TCP
+	  option space.
+	= ============================================================
 
 	Default: 2
 
+tcp_ecn_option_beacon - INTEGER
+	Control Accurate ECN (AccECN) option sending frequency per RTT and it
+	takes effect only when tcp_ecn_option is set to 2.
+
+	Default: 3 (AccECN will be send at least 3 times per RTT)
+
 tcp_ecn_fallback - BOOLEAN
 	If the kernel detects that ECN connection misbehaves, enable fall
 	back to non-ECN. Currently, this knob implements the fallback
-- 
2.34.1


