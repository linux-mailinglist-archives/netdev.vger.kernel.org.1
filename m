Return-Path: <netdev+bounces-137162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD59A49FB
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC90C1C2118A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6BA1922ED;
	Fri, 18 Oct 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qbuKfVTA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA70191F95
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293633; cv=fail; b=MDCqgcdXGB0nUicna+2WG2UBC2CKKfm/gsntvzrw8VbVrYFCwrMfdSRkO6iWneC9VdTOsBjq0Otvc4nKJkTZuRQRvtxB00kVqcxqTRMcO1bsXBmbaLFok+sFQtOyYD0IP1Q1lpjonnhGLjHBQDrs+Rv9zZdfvDKSUBSIy3JZB4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293633; c=relaxed/simple;
	bh=/DXiP48JvOyuu2neVkASCL/V6m9Qs0aUxatR2JoMVD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqxlM/yYLwBakymTA/70j4PJWVwnH+Chwk/OXMZjIJLXUJJ8V7flHDTjvQ8dbdgNU6TmtLwH6iJlh0oYdeFLb/OQ3zEesVD6ZP6lV7FwnbdDMjQaNe3cfPlfb7rrsL4h+XVZiIW3akN9I/ccGMPMtpX5vLnce0aW4gsjmNqaQpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qbuKfVTA; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucA0TprMZoDKCCvkn4IOKOl5USA5iLAYJ4X4uEmH/h5ESDQUUHmlj14l7dx1cCLyNOr/N2JFHTui2ZV9A+XARtHFWHXuAp51VQyIggDvUB/qkzYpxVi8+a3PzrzRDp3fbRN0pEmjxmNFh8fHdn0/REMKnIozuPFMSezOBF66R8akpn2wTFxrR+Ou8rz3Ay2p2eaAXR+lJMYtcp+twloul1TVXUJV0MIX/ZlVLDzXUnXhn8yJ1bH45BG4txwdyLnf2+dJXvH0FxYppigXFW80hRNfXHzCMCsiM0gr6yhxg6hi3GWqfgRnEgMXE88pS6x8P9WeX61poe82A3Pp9/qNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=menLbY/T4sSpxoPKGkjIT/lGtsoGaZrFkKbZErdzlF/2qgNelix19NLVJZ/6jryCgoe5s1JWQ6EXEHVkKqIToG0JpvPCS0jMi6r5xloYeQO65Z9GtplWWp6cy/Gtrk/LysdIJAl2XBeKUJG9yFOgI/PKEQwTQgEZN3cIVYzge4ilbv4NpvgluP/T2APoeCuMUxeDuBJY1bzMfWiBMnpTU7cvypYL8YSeXyB2tBEm7cxYYLFOgtdH2mEttk3FlbQWgq+AUYYRHHN0Xx723VSc9hRBWjiPMm2LgEqk5eB8MVBvAZnvj9fcnkkSMl6H1rH1oPeWD6bPyOthh++dvITK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=qbuKfVTAWeM++dVTOOW3kzHUUTE12LxQ/WABxVFwspBDgeSk3cIUl0zVn74X2Q951Vd3hUl4MplKiquJd1kpTxU8/oMSD7ZdmVTBcd0ZsAEabEt/Qq22DlV5o6mHdF28jKxjw4C6fYZGQm3AcXlz/5DOkbVSuyIM6ST4QR9KiJoRyy/rLqVDT1fa5cT8tAsPCpYNjCchBh02FZp9OlC3725dsAtcQlu8so6uc0nFtkoWjdw4Il0VQE0lbqzjm8czd8zNt39PFTikhLQx2QHyG21gbADp8jFz6WMMDF0Hs8AdxKBgVANIbmPgLyIgKOJ9ibZ3JiBseJBAWhl0yFoP4w==
Received: from AS9PR04CA0044.eurprd04.prod.outlook.com (2603:10a6:20b:46a::22)
 by GV2PR07MB9012.eurprd07.prod.outlook.com (2603:10a6:150:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 23:20:28 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:46a:cafe::ad) by AS9PR04CA0044.outlook.office365.com
 (2603:10a6:20b:46a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJU010239;
	Fri, 18 Oct 2024 23:20:26 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 05/14] tcp: reorganize SYN ECN code
Date: Sat, 19 Oct 2024 01:20:08 +0200
Message-Id: <20241018232017.46833-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|GV2PR07MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: b37cda1d-ae5e-4a23-e1a6-08dcefcb73e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3JyenZkNjhhTVpVbFEyeXQrSEJIcWx5WVRYRGtxYzY0RDlIZVVaZ2FydERo?=
 =?utf-8?B?NHhnUHlHd2xhUnkwN0tCaHdwaElBUUl0Q3h3cDdoWnhGTi85d2huU2hjQndP?=
 =?utf-8?B?SzgrZnE0MXQrQnJJK1hnV1BXRVcrSHZXM2RwZnYwL2FmU2ZLSkttcXFSVEJN?=
 =?utf-8?B?VTFlUThsTUNQK0tJWHpZbVd5bVROdy94U0JkY0FvZmpRaVZDK3V3RElnRitT?=
 =?utf-8?B?KzZKMU5JaElSNGRQTEJYdUc0TUhEUkxhTzhDUWZsdTd3MTZ6emxkcEhwaUZz?=
 =?utf-8?B?d01wcjZQa0lsdXBlaFVEZ1RyNGJ6RHdaMW5ZNEdwQUd1ckNrUmpqVXRlNENE?=
 =?utf-8?B?TVhmMUt2c29mZDlmUEZ0R2t6V0ZYZFB3Qkg1a2NkTnRLT3dTbDV1T1gzaHR1?=
 =?utf-8?B?OVVzOWozWUN1VWJOWlpWRmQ4V0lId1BRVUN2REpDeHBMckk2YXBGQi8xSm5n?=
 =?utf-8?B?OEpGd25WZzZLcVVDWCs0ZGIzMmNSaklZeWh2NFljTWZ0NnhNeFJpVDA1ZDNo?=
 =?utf-8?B?bUpTKzhtMjh2UjV5M0lKZkpZZEFiVU5WcmNodDdlYjBkVmRCS3UzQTB0ZnpS?=
 =?utf-8?B?amhqNENkRUI2ODZkbHRtZkl1eEFCcHdmZGFoTHZmcGRzdW9WNHJ1VGQ0OFF4?=
 =?utf-8?B?WEhYK3RIVDl4MEJhQnJaZ3JXWWp3d2grMFYyOCs5LzdHZzgvWlViQyt4WkNs?=
 =?utf-8?B?b3hZbFRvWVk3MjNmMEh1RzdYLzA2WFE3azNTaVVOM0FDOU1EaHZZRjBGaml3?=
 =?utf-8?B?R0E1elQ2a00vWnBrUzVTV3VWcmswYUhtRFZYRnJjVWk2c2s4VTdxQTRnUmtr?=
 =?utf-8?B?TnQ2dk15L3FvbmRXaVZaaVZIYjF2a1hYYU1pWDVHQmNLRVFmdXJoZnd5bUxN?=
 =?utf-8?B?UC9ZZ01relN5MzlsanhSbmxOODVKRkxwbDhFWE4rbk9iWW1LVkIzVDd1ZHlj?=
 =?utf-8?B?WUhiNDF3c2pWbjhFQ21MeXZKRlIySi9ubnBQM3AyQnFpRVZKcnF5ZTJDd09Q?=
 =?utf-8?B?WGwwajRKelh5MGJ0K0JkTlBySWQ0ZURFMGVHMHQ4V1Zjam9seHpkSE9LWEZl?=
 =?utf-8?B?MFVadWV1OFExQUlSSWtwN3krQTQrbFBEYXlEOG9yYlpmb2o1UjYvd1JUa3Z5?=
 =?utf-8?B?ZzBidDZZU3dBK1dtVWRRRVAvRDZrOU5TTDRUV09EK0FSajBWWVMxam5sZUVP?=
 =?utf-8?B?VEdUZVZBU2xxU1luT2RxMDhHY0VvWGFNM3ZsSWxQY0hXQUR3NG84Z0k0bWEx?=
 =?utf-8?B?N0krdWYvNTh3VGNYd3NpeGFsVm9Ia2tOZ0lvMGNFbUlpbVVaTVpwZWpPRmF6?=
 =?utf-8?B?dDZYRlpVd0pCVE90dFFYY1MvdUE5TTlTbFZwZVBGR2ZyQ1dycGFSaUczeE50?=
 =?utf-8?B?Z3hzSDFFSUdwK2xxZEt4Vy9VbHBXZVRDc1NSUjBha2U5Skl4L0pLSUt5YzBw?=
 =?utf-8?B?R3dSSkZuTGdkSmZZajVOUEIxUWVGVWZrNlB1UEVjRS9BL3hzK2N0V2M5ekZs?=
 =?utf-8?B?dUFKaEZXeElHd1BGNm43SG4wdmJZT3pHWi9sMXdUbkFwZFp4amNGYk5FcWRC?=
 =?utf-8?B?YktNNlprVW94RHBSdVhKS1hVb0k4blY1b2hmZ3Bjcnp6bGRSaTF5Sjd0Sktz?=
 =?utf-8?B?NzFmSE5MTmRDVmpCZlYvb1NQVFNvMFVYVGpWY1pRSHc2QVV3VjZHTW1vaFpl?=
 =?utf-8?B?M1daOFV5c3RvbGZWQ1k1NC82UHVjTnRmRXNXWHZXcHA4aUZkWjM5cVRicVZT?=
 =?utf-8?B?ZmxEcndheGJjWTAxYXFHRmIxNEhSbGp5bnZCRDluVVNQK21DbUFqWTZ3SGd5?=
 =?utf-8?B?MThGZEhGY0dtLzV3UUJPdjVreDYxNkRlQ3pqQTgzZ1p2b1ZIbS9NVnUrYXZU?=
 =?utf-8?B?OHl1amJOSnovTGI3dVZIOWlpdXJURGJuZ09ZSTNXaW01ZDdQYzJ2S2JhR1lv?=
 =?utf-8?Q?3C84v3iDUwM=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:28.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37cda1d-ae5e-4a23-e1a6-08dcefcb73e5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9012

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 45cb67c635be..64d47c18255f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -347,10 +347,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tp->ecn_flags = TCP_ECN_OK;
 	}
 }
 
-- 
2.34.1


