Return-Path: <netdev+bounces-136817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8E9A32A2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5DB23851
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20841155A2F;
	Fri, 18 Oct 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EPTVJtcF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8E154C05
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218108; cv=fail; b=hHv4/XFrybXAgj8XKJHmC6HBDPJwo7YXYYy9uCuJ/qgpBz4r/MCzN6e0KlyB+PbspXmTLH/CFLmonJxZOI+1u1xCoAns8UXTnRCdZdQP7l+pKw2bKst00RgE7pn99KliGZiF4UXPEl5/S+3PP8uk3cccReBz4WPvvRAVWgKa6iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218108; c=relaxed/simple;
	bh=/DXiP48JvOyuu2neVkASCL/V6m9Qs0aUxatR2JoMVD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWDbgDvCbVVc5Jjm2hRBpc2ntFArmQ1wGuTM3DrT8BgFkoTqPv9HrQ95Rc50C6DJ7bzz86sotyjpb+1rOp8r4syMvsKk3/UxyuVjSckGWNG0XX+2OqUCejxNvCzPKiMgrPjSt++N1qo7GTLA52oTawoTzDvhr3tbQ3h6MeOAuf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EPTVJtcF; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV8pwu1Va0NkJSftBQhNW5dKiTFdEMDv4/4cwQW0daD3dq9Wy8VD11ZpPMcAhZCrkuFU+NQ7FIM+BDkoeRSGpgZFSr73bDSVvZ7XR1Qa/0VBzclfyIdN2fKfvaYh8Y8sDG7pOR4Tc8kUDRV0UgMwNSnjiK44OLA7vtZvm1uhPqTVi2+OaAUdN84lBYJBzs4SDNgfCBP6pnWxAygtLQpl1H2ROjFyHS4vjaxr2Chjj3SIFctQrF727u4fRlzthZGLDGxnND3r+y65QpMRYRksqZKy0n4692bh4SdbGTKadVxXNu3hOIo7q+f6YvFoOCGdUBq9ukR5yWUyqd/vW9QgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=vQJTEgkBKh9bzAoJ9b5hhio37sgDX6JKgyw/Vx0rBFC3aBIJknq/j0Lcj0/HU0oLXsntWtVgDv6cS6rWQtXGKAAAK376tBWtNT1hNW5Gmi1V+52PKF/ga4X3VEDU1ptxWQvy5n3mpc/A4GSzYzQf/qeTfYGmSLVGi+eMcw+S1By/YpWcS22R1TBRugltEAWi10wbLdp7z2sCQXyX44edjLEUHTeECQAW3SV11JKpTwkikcs7jVL5NVHvjUa9aFAaXDdM+iHeSCKBYRlCuBmfVIcevPf/paWBTGAmK0wsMX5yMIk9DFXoMgzCNuigDmKLXrzfjUkOjcaMmCF31IHC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=EPTVJtcFa6i/He6vbBRC2wD9Xo0Fs9QIPIu8F48zmTZHTCujbcRmBd8vcNsk4AStJyxTknHxLPTafR35eFJCszcezuoJwf6Jizx7qQR2udq0xPH3dQskxOPOSMyyyFXi7A70SAyFyfK726TXzmPvqrmi/F1/FQA8Q8b8CSyIYfTduOR2U90SaKxkQFR6bpaJ+bFCIsJSd7HiQ0Fnk+evATwwqAT7Thp/zYDA0ELNtZTGgUSLubOKHZirfiQ0srS0CkEkrufxNuskl0M1N4OYfIMXRIRv1tC8cL3Z1KUJXTPcacCBYHxjxuzG7EzBFzDg3zHITXo5jHUTYIWwBaPSiQ==
Received: from DU2PR04CA0318.eurprd04.prod.outlook.com (2603:10a6:10:2b5::23)
 by DBBPR07MB7627.eurprd07.prod.outlook.com (2603:10a6:10:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 02:21:42 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::f3) by DU2PR04CA0318.outlook.office365.com
 (2603:10a6:10:2b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0MZ023685;
	Fri, 18 Oct 2024 02:21:40 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 05/14] tcp: reorganize SYN ECN code
Date: Fri, 18 Oct 2024 04:20:42 +0200
Message-Id: <20241018022051.39966-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|DBBPR07MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f2b56c-ba2f-4c12-1f19-08dcef1b9b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkljeUNmQlhUbC9Oei9CS2xURlNzeFg0cXRwdXVEekxNdlVwMEtRazVncXdy?=
 =?utf-8?B?Skt1SXBlTzNsUnV3RU9VVUlXbnlvZVl0clloREVBZXBhb1ZDOVhNeHdLdGFK?=
 =?utf-8?B?RTMwMGliZnNzTlpOZzF4dkxTNjIvYm5kQTE5MXNQQWdTUWpTd3BpNHZtZnNy?=
 =?utf-8?B?SkVNYmxwSGlsZmUrMldScXEzMk5CdDFpdUZLLzhhSUxmRUZoMmk4TXh3VEJr?=
 =?utf-8?B?MFlLQlRtLzJobStETWUzK3Z5NUFUVzYvcWkvd1FaTkIwaUg3c0FUZ3NEUDlo?=
 =?utf-8?B?SGVZcVJmQnY4ZU1RZTFDV1k2bURubkNnOENPNTgzbkpOV211QU9rcldoQWV2?=
 =?utf-8?B?UFdCTUZRZ1RCK0JIdVZMdEUyVlppc3pobFlCQ3c4N0lXR09NdnRmV1MxY0dp?=
 =?utf-8?B?bHArT0NQMVN6RjJUdnhzb0w5K1ZUTzFQaEJQY1hVMGFXd29YNWVLN3RGYkRB?=
 =?utf-8?B?cHcrSWVIYzFSWnplcVVxdFVjWnBPelVISm1NNUVsd3RBWFFEeUZuUEQrL0NI?=
 =?utf-8?B?SWQrYWVvUVllZnE3SnY5UjZKT1duemZKL08rNDQxL202Y3FrczY5RkUyaTRP?=
 =?utf-8?B?OE1DeURtVzFyKzY0VEZISEFkTE1VS01Ha0dKTEpxZGxVa215d2RqZjFpZDQx?=
 =?utf-8?B?cEFMbjJWWGJiL1VJZWNUVTR1S3FYV04wR2pZYzE0MU5JTkkzcG0wU05jYVFB?=
 =?utf-8?B?TkVqVTg5QlRmMXVnemNoZzMva1RCcEJucWtmWThzODVVUWtmUG5yUjVrd0d2?=
 =?utf-8?B?SnJ2eElrWGNYRkxMeUt3S3dJSDhaS3N1ZzBZRjV2NHpRa21XeGhoZm53dTF1?=
 =?utf-8?B?VjZESzZWeHhBeTk2Mi8xbmRCcVNFejZSUUV6c29xK3ROcmN1UmRQVENHS0dB?=
 =?utf-8?B?dmUzL1E0OTVta0VOamtTK1lkditZSDBrMHpYeWo1c2UxVDBiU1FNU0lTd3Q1?=
 =?utf-8?B?eW02ZWFTVFZLeTlSREZadk9MbXRZQWxiNmZkZHU5a0xicnowbkJkV1N6TWp6?=
 =?utf-8?B?cm9Qbm1JWnp6cGxFVXBRSmk2dVVXYi9DVnVPekM3VXpWOVdrM0RpekhVNk1j?=
 =?utf-8?B?Skkvd2tXV1N1REEvSG5zV2Z3M2ZxaTRTd2pidWN6UWxwQ0pMZUh3SGV5Vkhs?=
 =?utf-8?B?TTE4bUg0Ryt4ZEFYaTIrbm85NnVyUG5neXpNbUlFclJZUTJtWXJIL3BETjZ6?=
 =?utf-8?B?V2pUMVAraXNVOUE0b0RDYTNGUnhsbWZ0LzFJbm9pSzFjbFg3UStDdzhDeU0y?=
 =?utf-8?B?aGYzQzJ5cWFGNzk0cVNXV0NJcG5qc3MzMGo3N01uRm5VY29ZUWxQQ1luVjRp?=
 =?utf-8?B?SjFRUFA0S2h0NmVKNUlHQ0hvS2c0Y2lpS0VncmtJa1YvMmpBcnVZSThsUHhN?=
 =?utf-8?B?WFI4NFdiL1k5N1UrSHMxaWUvY2phRVdPc21hYlRLVVFldnZmTGpxaVFUSjRx?=
 =?utf-8?B?Zm9temU2RVZabnNJRk9uTzRoVjZTanRzdGhBR0xaU21QWDFpd3NvYnVSMnM0?=
 =?utf-8?B?dmphQWIyNEl6R1VEZUFOV1VEcWExR2FLZHdBUU90OE05WkVQbEJUY2Z3UzNp?=
 =?utf-8?B?d1FrbDZ4NlZyamRWMWRRNGw3S216UHN4TUExR2FoZjNhYWtaR1BIRGRXNTh2?=
 =?utf-8?B?T3poRDRRRUxhZFp1cmJ2WjNoZHhaS1R6bGd1cnFGLzNydS9iRFFpQnp2OUlP?=
 =?utf-8?B?K2JQY3JNRStleVdkWjYxLzdQeXY4N2xHR043YnA3Uy9pQXp6YkxIQVB3cWEv?=
 =?utf-8?B?WXlUQ3U3UDR3RjBZVzhhdlpjV2tuRW0xYytMSER1b2p5clF4b3BUaUNDZzls?=
 =?utf-8?B?RkZMUUpnL092SEdLMFhkMG1tWGNpWHNINHB1WDlBRVBvaktxNTl0MVhUQ2dC?=
 =?utf-8?B?NTlrRWp1aUZYVG5uekhqcVFhckc4YTBJTVVOOXRtblp2RGJuR3cxVnl1V2s5?=
 =?utf-8?Q?eZB1L0Ud9Tw=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:42.1746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f2b56c-ba2f-4c12-1f19-08dcef1b9b01
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7627

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


