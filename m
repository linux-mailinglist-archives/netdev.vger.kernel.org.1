Return-Path: <netdev+bounces-135558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF199E3F5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200E31F23C0B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE71EF0BD;
	Tue, 15 Oct 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="n1yMvtCx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977921EBA13
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988233; cv=fail; b=ggvaxSMVGT2ODkoYyhKxFEx0fTWhRn2XgKtTABds0opF/4F83ZkSYBWLzAT/cB7h+HRjNhT/uXRhTK0ENJ3vkE4zl1NVroWB6Z9OjsfzSF7mDaoBQ4vSkUkv8Nmk12Yu09bhnB30C+8/gDVr24qamf+Lv/9Im5J2iSdfqKYJD+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988233; c=relaxed/simple;
	bh=fKBbeaPVW8DcZ6DYlD8c8/FTqvLtUMcI3CoRxLvDMr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7UHsDZx0DwHK2l5G0y6Mf5Z1SJ98/Bn3hxYGcHQHaFNxAuaB0hMdYIuLBDGqzqYSQBXbrw+rQt17UNHQG304P3xBYA7Me8y/2Ixlv7tzgdYNd1waGMNwNaClGUT4+V+vfWMxBwB7mFC8PdHKcI+1y1W87L0oM86iCxAa9Q+6e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=n1yMvtCx; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANPsIfYAUbp5cTeCLub9pATuvLnmRUG/txixFKuhDyDiqXJwE1l+c4vus48mhc3IjZ4uUzjZOum+cjnfRKMFwB1gYlBV7qt0in89vzgPlHiMDn2rJsoUgdk4WsJwzaPKktFfTGE173Urcdf0kSW1PuM+Z1hrXp3OuwkLBcXk7CrYef1EvCkKCF4Feh3wr6vwh1ctD+PCj/Sy7HiUKNvlUPjIkgyYi3LQeP/7Nm9ElZGVL7cHEhkyeQ2mODL525VR5bFzxPTOamhqnKw2Wjxs8aqhhNAfoKKAjXj8JXE9TFGef44v0eeiD/eVWp/URdk0dy4+5VPeK4bCzBrhrg2IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS+bjUXzLdWxU/fiVihhJtOmIUpj4scV3/uP4j163Rs=;
 b=mx5tReg0dH5Cs5+i2DpxHaJsAtIKi/q7cP/TKxAB3Mq0mY1DMWqPcHP8rpUc8iJYilBelo/i1obZ1NKywuHHhu2Buhz5rxtjzduiFcQFETjSQJ912BEPghq9al3+FuCpmvP6dkKEFN94eIhee8lm92Z48QvdFIwMWwkA01oXaJYIrO+rnbM0YnR2kx9JiJnP34tBjg19vFdoK/12LqSN7l1+tB9SyUNDD1u2g73lmyHlM2TTFjK5j9Ay5tjlpOLQKPIXGDHJgx0ZKtQ1ke0PYEe1DSK7jq3xCF8c8kexX/KnqUwJHoO9POKfjD3hOgH0I5INDCOOAbPyxaSu3ZXIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS+bjUXzLdWxU/fiVihhJtOmIUpj4scV3/uP4j163Rs=;
 b=n1yMvtCx/KJDGCFFAFm3hRJkXdJwo6EjH55nWgGIXYZWRg1dGX2+btNvWhWKceauw/1DSiWq/HElsHlCEIxuyI2HS1B3QvXny6ndlDUyCJg9iZPaMfZ9VocckJRLh9oKx/nzeL3ofKZYG1CpZaa9Fw5e+3Y+b55ZsSnway9NLA/5HKYX5i4NO1hC3NWDmVZ153CfXVbYxcUO4oiT5p/NH1EqDbPh/5iX/DwTnAfGBVyAlLqvuN0X6r8wWL9tZD6m9llx/zY676OMhbNOhq4SlWBnecPwueE3vUWHoyEVbf/LMmtCkeG+Xo+WjN69sGYHNS9C4sw7t41ZaSaQsF/2qQ==
Received: from AM7PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:20b:100::40)
 by DBBPR07MB7467.eurprd07.prod.outlook.com (2603:10a6:10:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:19 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:100:cafe::a8) by AM7PR02CA0030.outlook.office365.com
 (2603:10a6:20b:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnF029578;
	Tue, 15 Oct 2024 10:30:18 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 11/44] tcp: AccECN support to tcp_add_backlog
Date: Tue, 15 Oct 2024 12:29:07 +0200
Message-Id: <20241015102940.26157-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C711:EE_|DBBPR07MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: a02c2fbc-6a9e-4e43-a810-08dced045dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1V4dTl4QjFGNkpnak1Udnp6aFV1QUNKNW4wbE5kQjRldkRhOHlOK2xGMEto?=
 =?utf-8?B?VUI5MTJrTmM2SG1ZYmk0RWVHYkZHaHViS0hYb3B0dlVaVThIZlpmQ0VXaXlx?=
 =?utf-8?B?UUwxT2VVUW56MGNQcWlRZzQyWDBQMFRhY2M4OGVZOHhaT0E5Sk5LeDQ0NG9X?=
 =?utf-8?B?cGIySElmRndpWmNBWnBjdTRqaVVneE9xQkI1ZCtLOFhOcWJlQTh3cE9mMERx?=
 =?utf-8?B?cUVkVXlkQXVKUDhmS1RHY05WYmtjcmZjOXVURTloVkNRVXRPOUUwZUlldkc2?=
 =?utf-8?B?Y2NMbE9qUEFWY2lDVnAyRE4yUWNiYWxqL2h1WUozSldFa21IRXc1QmNMb2Qx?=
 =?utf-8?B?eStqd0FEWFhjSzJSUHFIRHV6dnRyRDdPcGRxRTM2ZnJ4ODlKbVVQcm9iM3pI?=
 =?utf-8?B?RGVyK3o5M2J5RjdYRzJZb1VuM3ZQSTh3UWZ4WVM5OWxEYlpLUDAyTHg1T2J3?=
 =?utf-8?B?REc1UEhOTkNNeG1BdU5memhsVndEQTVZUURJU0prMzNFSXc5cGNVeVBuQkNU?=
 =?utf-8?B?Vm9FWnQ0REwrSmZmTENZQ1pmTmlMeVI1aDROQjBtdkdTZDh6aFRTeVVUemI2?=
 =?utf-8?B?NStUbDg4dHp4Nll0MHEzbDhxZjk1QlVjQ2g2UitZTWpndzc2SVZJMi91Y1Qv?=
 =?utf-8?B?OUR6WlkyRDBzamJHM3QxMGVkOE1QYk15Y2ovUU9PMjZ4aFR6UWNKSnRES0Er?=
 =?utf-8?B?RDZSOWdvS2ExV24zVEtFRUJuYnVIdDNwL0c2RGYrT01HWHF5bzhGU1p3aURD?=
 =?utf-8?B?eDJjUVFKRGMxOUREOFEwRDIzRStxWWRhYU1hbVFsVWdFbk81M1NVQ2EyWUZC?=
 =?utf-8?B?bjBMaUdsVEpoK1QxRVVZd2FhTythSDU2b1B6c0VRR1h6YWFDR0l6VUNNMXlD?=
 =?utf-8?B?aUlRVGJiWHVjd0ljR201Q2dtK2theEFXd1Raa1ErRFJqUTlxQXNEaGt0OCto?=
 =?utf-8?B?cU1tTXRQTjF6Z25OYnZ2c2RtM0lxZDJLTEVMVlI3SUVKaE1XVllZMi8zTVFH?=
 =?utf-8?B?aDVoMkVjWXIrc1puVWkzSHpHOTlycjZ0ZVBtYi9ENWJySmdBYWxkWU9vOE9G?=
 =?utf-8?B?MkF6eGsvMjFGRXpKTXdDQkJ1dFFyOElnUGx2TlYyajZ1Mkp1aU01NHRveUx6?=
 =?utf-8?B?YTJ6UlZReVdsdDRNU2pkaVZhaWwvZ0ZUT1F4Z2xTSS9oR1UzL2kzbkJxL0pp?=
 =?utf-8?B?c251NmhwTUtzeVpTcGFNdXp6amQvNVRJcFRmQ1d6UHBsV3hxR2tsYzFzMDRz?=
 =?utf-8?B?VjJaYjlxMTBSa0pwQXRCV3VKV2FDVVRBRjB6R2luQlFSTU5Nd25rNys5U3Uw?=
 =?utf-8?B?M3RqcVp5OUV4bGZ3RmwvZ0hUaUlwaUJnOU90ZEtLTzlQUHpEMHhMcTFCMHNn?=
 =?utf-8?B?T3c1Y1dPMlM4Z2hodURGMVBFd0haNld2TUE2WFJXSHZxNVJkYVNVUC9oY1Vq?=
 =?utf-8?B?OEhndlZXdmtFaHdSbWVrbE5RZVRQUStOUUljZmxveDhWVDRNMTVNamFjdFYr?=
 =?utf-8?B?QWpLeHl3bEpOaXdERzJwMDZIdzhVR3lBcmJyS3g1TVFwb0VSOXdqbGw3V1ZX?=
 =?utf-8?B?YzA5WGd6VEsrRUlJYnJIeG1jd1QreWJYVHlzZTBtekxUTjFLNUZBV3dWaWdo?=
 =?utf-8?B?Rys3ZmNadnRDVXF0QjhPYkFwSVFlQ2V6UzlSZEd3MXRwRGo1OFpSZ292Vjln?=
 =?utf-8?B?UWxSTS9qVU9PYUZVRTlPRXRIV25HZDN4dGdUb29XVGNudkdZeFpqaHVXR2hG?=
 =?utf-8?B?Q0FLb2Z3Y05Sa1ZEeno1NEJIYTYwUk5UbmRoK2VrZUE5UmI5UmpPQk5weFIz?=
 =?utf-8?B?MllScDZrdHduTmYwZjZjb2Y5VitPL1ZxQzAzTldzdlY1b3ZmcWpubWROYWNK?=
 =?utf-8?Q?7ZmjOzm0KowQz?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:19.1074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02c2fbc-6a9e-4e43-a810-08dced045dfd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7467

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


