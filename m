Return-Path: <netdev+bounces-137167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045239A4A00
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E01283EB3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A0192B60;
	Fri, 18 Oct 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YrtDuW4E"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3A19259A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293638; cv=fail; b=djRFQHS04TrAMsxzmTfgv8ObCIKsBKCI20CeHe3Tq4VNNB+hnGEbtsubCWhZ0deU1XfzUEyB5QTyqyBsjn7VxVAK9oE85O/iIkoSKkLOT8CTPw4BlCfGQQSdqUDE22twkgX5mlVURA3fdTJ1H8OD/3SXSmXOh6UH+CH3vA1eLos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293638; c=relaxed/simple;
	bh=fKBbeaPVW8DcZ6DYlD8c8/FTqvLtUMcI3CoRxLvDMr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ED/jmWYLq1LRKbz/TEENkfdc9H3NrRViSEPaP++DVdfUw+wSQ8dlLC6R3LMU6OwA6yl+iZEnZMR87ZZkovxqepoCWW3VylRzz/elPEWAYsgwEQSi/NeZOTSBBY5+Loc0j/CKbSxVIzC57inyRUSJpPOhPsDh2ETtaJaLW7Hu0VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YrtDuW4E; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPFLNFOnKkakfAF5RcF4FpxAOXgLri3NChCsJQozp8jDKLJ6O5tb75g+g0QvDvnwp1LwAbpB0KYgvoW/MGJ2VOHybqti5EWlAw2LTpoNhUJGy9J0hiTLB7Glqgmwd4vHjnkNJ+hFaYJr0hZBVeaOYcPRj8YYaEU/Ns5Ncl/XHvj1nzy7ztgMQO9Vh3rRmSN5oYrTGOdjkht6B+RoozBEwyiVtjkcigvVCqUjvMlRbDoXC6MA08McHvrSj7OTetF7GENqPUjGHeiPGxlj+j9KFE/u+e1pGsDmS8k1oHgopTxJCP1o2vnVea+/oIPQO6sCj6sEWGvo/TBEZ7nKp9WZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS+bjUXzLdWxU/fiVihhJtOmIUpj4scV3/uP4j163Rs=;
 b=N7OzOgGMzk4Uzdtef4aEFeU7Bjq0JmqDsrpRf/Cwtpf+1/G5ap6+AGEr53I7Pf5yxykHkVsYIq05OJxlTy2Tg/jkwLFLBMkHjTTzxR0kS5bKrEPLMSlxBQjpzK6DIRVdc2F6e1NzvRuyNPda13ZYf6KqURWLAqgVowikHpk1ctOQws3t6QSCjBm8lBgaa8bomR1kDQJ4QXeMp9x2+jo3pT7O1tBM9MjOanubzWY4DfhlV6oQCY3mKkWGyefFkF+1/2eFS9K8F+84wSE8GHxb+dt0qWSsv37aXUxtt4LTQnBXHqyS23Ra/HQejpBML5w0Yai/CK3DPUwC0g/Ofb8YRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS+bjUXzLdWxU/fiVihhJtOmIUpj4scV3/uP4j163Rs=;
 b=YrtDuW4EcPysS8Cacv2vWbprGp7YI30lNN1uxdr5t+4j2mxOpjVaxbEojNyVx/yxSFoiFDCUD0LZZPaexgqe7DGcK1D17uO+ZWMmL6wO7EztNE+5RsWDsYBsGRav2VqcjnkdBXI2DJBvZ5Kf/Uthl2DqDkQnzgdKeEopFrrOFyNI7i2HVw5Bbcxq6hk9CrDM2lGv7iZbabyifIIpYIrfx2sewUpMw41FEwmE7h86t1LLH5bPmQAzxtGDtufRxh0pKPV/5vqTLVAN24RMrPDmh6Vz/Sz+cbrMzlqjpEOCDjCEexNDCpFLVnlRzxp+8OPVviUQvPD5MIyoZ4SraINN6g==
Received: from AM0PR02CA0186.eurprd02.prod.outlook.com (2603:10a6:20b:28e::23)
 by AM0PR07MB6418.eurprd07.prod.outlook.com (2603:10a6:20b:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 23:20:32 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::38) by AM0PR02CA0186.outlook.office365.com
 (2603:10a6:20b:28e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJZ010239;
	Fri, 18 Oct 2024 23:20:31 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 10/14] tcp: AccECN support to tcp_add_backlog
Date: Sat, 19 Oct 2024 01:20:13 +0200
Message-Id: <20241018232017.46833-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|AM0PR07MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 981c5f48-0e84-4b88-8f12-08dcefcb7693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVNsbjVMckpzUHRjVElPUnNyckJWZjZyTzBkMGh5UFgxOFBtS1VTc3NITUVL?=
 =?utf-8?B?MW5scnpkWVlvcHlRZC9XTWZwSEtnSjNqTTlZZVU2Q2psTW8vWG1vSmxubko0?=
 =?utf-8?B?SlRtT21EUEphL0t1K1NOLzRBL2VvMGJrWnZsZ2hVUHFsNmpZc3ZnKyt2MG9E?=
 =?utf-8?B?VDYwcDBNU0xFZ0o2Z2dwbHBlT2xxTllnMzhHYkRTb2oyQlZJWlMyWU1wT1Ft?=
 =?utf-8?B?WStyeGlYSUxoSFZINDRPTHVnT3NMTXZ0c3lPV2hVRjRHU1J5K3pCVHB6bUFR?=
 =?utf-8?B?WFBRb1RDNXE1cVFybk1qUzVlb2cvMFZ3d096NnBuSkpsRndyNWlCVmNFdjlt?=
 =?utf-8?B?ZWtSYUFCc3NoYzhpeUhTRzd6WUx6S1poL01hRzJNN0UvTHlPTEVHMG5GdWRQ?=
 =?utf-8?B?NlZjdGZlak1CVTBSUVI3eWdKTkdrMDluZWQyenN4MVk0Z2lZYjhjR2NveUZw?=
 =?utf-8?B?TWExWXRBNmEzRG1jeDZGcFZveFVSWXZiT3FmKzB3RlJOSTdDUTFFNDdFVUh1?=
 =?utf-8?B?ZXdwSXZoM0hBYTdlNWZ5RC82NDkrS1JSVU5leGFEVFNaeklibFY2YXFlUHVa?=
 =?utf-8?B?TnBDMWtkQ2R0VXVJc1dkOVBzaFhNbDRrZTQzM2dLSmxBZHQwSWtnYkpKVDFW?=
 =?utf-8?B?T280bHBwMUQxR3Rmbmc5S2JhUEhUZEJtV2RqcnVJdk9DQlJWeVdGTUJGZ25S?=
 =?utf-8?B?Rm55b3BVRUd3MWExRytFK0tOM2JWWXJaQmxEbnlFQXFmM0xmUkxVOXdUMFJo?=
 =?utf-8?B?VlhKNlRBdlVENDJ6N0FZOWNrNytQcUg4YmE4ZWI3YnpKWGhvaHJmZWRaN2hQ?=
 =?utf-8?B?SWJzQW90NklhKzlBZHpkTERXY25SOERtQ1E4WCtXbnBlQlFGdWtFQXh0cFl3?=
 =?utf-8?B?NW5zdlYwbTdsaUNCZmg5RG1yb3hidVZxMld3aFA1RFE1bnJJVnJHSFVtejZ4?=
 =?utf-8?B?a3ZrZUtBK2tzWmMrOUlIekJHWVlaMWl6S1J1ajh4aFJWRmhOZjJaa3pRZ2xR?=
 =?utf-8?B?SlhTRW9IaXkrVUcwYkE1bytGMml5c2hXSTNtY1Y1Z3Y3NnJXU0xTQzRNNVJi?=
 =?utf-8?B?U0IrKzB3VnJZQmRweUU0azNxNTdKSVVzUDJ3aU9mVGNKOWFGaElCcHZkRHZz?=
 =?utf-8?B?aFBLR25paFVJM1JQUGp1SlRSR2Zyb2JrZjBnUTBBYjJpRnVHNm14cGlxY3ds?=
 =?utf-8?B?aDE3UTRDOElHSDZIS0ZlRUhsRDI4QVJKTHBQUkF6SmNiOE10UE5tUzRlbytr?=
 =?utf-8?B?V0N6NkFUUlFDVHZMeUtGeE9zemo4QVF0MGZpaHVsbXdnaStvQkRNOVNiYmww?=
 =?utf-8?B?WGF6blF1eEczTi9FL3JuV2taRWhtMVNKaEtaUFMyYU5LeHdiaklCTmxpNlNp?=
 =?utf-8?B?bU9hL2NHUDNNWDNHek81czlndGhHRUVlZjNRblpHSnoyREFPTVIzS1AxVWVG?=
 =?utf-8?B?MUFaeWx4eDZhb3B3Vyt4YnpPclpJVUUrVFJMZkRSSU8zdDVzTnNkajdubzlH?=
 =?utf-8?B?QTRaYi9sNEdTUmdkSzV6alpNNm55RXJlcWpGb3RseU1LSVdUZTRRRHNkTEtF?=
 =?utf-8?B?cGo3c2tXWnJMUTROdzcxTjgvMjVlL0R1bEhhQ2Y5d0I0amNTQWRHUVVaYisw?=
 =?utf-8?B?ajBZMjY0UDhMRzBWaENnUlRxcUkxOGpMbnpGOXlrRWxON0tQdlJlU3lPS2Ex?=
 =?utf-8?B?ckhpVEdDSEorS05yRGpidkxUQ2ljRU9CTWFHMG4zYVBmL0pmSzY3NGI0STBl?=
 =?utf-8?B?cHIrMDYwOXVEZ3VEaWJzTXRlb1pvYVdTZ0hPeFJxQThxZnhJdnovZFRzdUpF?=
 =?utf-8?B?SFEzbkVoZjRBVjNURTBZWHFPd1BGSi92bnhHM0U1KzlkNFdNRldTbWk4blRT?=
 =?utf-8?B?aWVRS1JMYTNacnFmOXRqb3VtcmhZc0J0Skd1VGorb1ArQnJxMVNOd1JmYXBV?=
 =?utf-8?Q?jS6cEiJEyms=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:32.5299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981c5f48-0e84-4b88-8f12-08dcefcb7693
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6418

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


