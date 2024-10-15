Return-Path: <netdev+bounces-135568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE799E401
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AFEB219FE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16DA1E490B;
	Tue, 15 Oct 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DcjXk7qn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DE1F707D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988238; cv=fail; b=ixqNk6Q03v+oup8khRuN5Ny3kwtGLXKwJkuscKxvUdPiLfxjrURrbXCz63Aii981X3Fn/ljXVWO4czyLV8JtKEz7X92RREsJnf2j1TrvLBJtmQ5vUMg0OQWasCLzjiD0I2OZXeTsHACHtK2fC5o4HrwEQMqkI67KhSHvTrL7mUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988238; c=relaxed/simple;
	bh=lKGxXNDZZApDeCLGx8sftBwGSjzuLvwAVEG3hvVt7+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lf+HSxkhfxwpsC12Ny9z/2uEVJnOHXWxMPn4+eXvCH7xz70skK/2ldLAsdsW6YOCa6pFmgGclZ/RVibtaDk7wt/jQwALO26w0szN0UcNjc5Jovrwzae9OWc2qnZxethyIWou+PJAnJbXnZ434Hhe7+0nEXFaECDSXxrXK0shDos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DcjXk7qn; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idDQFqMNeBzJwv0QCxwgWgb6GzcaoqGCXxHAZmrjnEE188xV8eJXobt7ZHsgvmL6OGpJtv7YcYDcncenxiH0nmua4RGi5gYa50DXA6w4sByuPENDkswFI/lMpL85zUVUZYtOouqRqsggBZPi07EwkaEKcNxQo/DqBj/+F6443O9dr97O9P8AiJidMyLOlZRqRETuJdhJDnGw3//CIBqIGvlQmbHW9ZRCEPraJWG5KNUdd6Vet7OYCBlWbhfa0bdsHkzOEJUZiAeXtYoQoy5zHpT5rK3CeJh3WbVpSGT65DzBGOttSrwxcbGKHvTIsZlq3SVwb4HcM8X6YF3lYUTPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KEjRTgsIEa0i/sNgB5taJD8oCxxYCsc4PWaEhpGFOo=;
 b=FMrlpqnKKOcW6UvdryD1n9BpzrKKqwKvKOuvrwMFnOjOGUNk+OJDX/WUQpNVTj+2fwNtYZA4gYn93ZdhJjXJhZYUQLbrcMCA9vRdLke9qMjvaIBnvsOicXp/71urOZb3VEZGr1KRMjtmHIDm7Snbj2s3Nf7UIPyJdZ/5UR9Ad/RufkjSvjnROtu+sIsI51R+YsFVaP5lu8dho1Z6JlS2Y1vWn5NOn2O9DKhiSNoqygYmFzrpgJGwzqu0ZwpOtJxdlz3dMCl6TvmITGvkpu2Yx+B/p8Uga/8FzpTbVhOWcKvAQIZAxp1nE5GfNMJxh56MrJyoiGaBxRQ2OA2FEaphmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KEjRTgsIEa0i/sNgB5taJD8oCxxYCsc4PWaEhpGFOo=;
 b=DcjXk7qnDq2Op2Njlb/ie//6qrSet95RjGVixbhuyIzqB3spHYaIwOtKfEj//l2QPSzzYobtriYZSX28qC9J9vzh6A1uVxGjPjBgIbtqpZoJHrHY9FTFEEz91I5YI6kBTvS+Sr2RVW130FSwZRpWiZDIrGfxFJ/q3ZvUYkvFT/LpwcdeybKj6RcjTKMaQZfx/i1p4ghAXFelW6AR8YmSsliuf64uxtIWhlnOWxldh0VzXHbdi00dmLZTa947aRdZz3yZwn8mCLJmYtWsPH6SPbx/1yCI8zJGZ6W8bJDaElujrYnwa2BqRG9PuNYlnj7FS16RdRP+ujhadpn9/odMQg==
Received: from DU2PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:10:3b::24)
 by DU2PR07MB9410.eurprd07.prod.outlook.com (2603:10a6:10:498::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:33 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::b9) by DU2PR04CA0019.outlook.office365.com
 (2603:10a6:10:3b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnc029578;
	Tue, 15 Oct 2024 10:30:31 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 34/44] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Tue, 15 Oct 2024 12:29:30 +0200
Message-Id: <20241015102940.26157-35-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|DU2PR07MB9410:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b891e334-10b0-49cb-353e-08dced0465dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VR/AnmTNsQ+r0dgen6ErJO5p5UfwYrkgXiLVWeoP3uQvl8tjVo8MXl7bokzD?=
 =?us-ascii?Q?3b76Sf3K/zTfnpZtwikpqjGHNjOJRa0ZVBklT/x+TWrSuhxyZmqJlHfKeeDO?=
 =?us-ascii?Q?oScWutTFnu7KB4t7hypwwOKiXk4/U5xhk06JCRXSo9eEvhucxXkchD7xV2OO?=
 =?us-ascii?Q?n7rUnzp5aryIEjCtF9OF88R6jbVHdKi1bY7igeNaWwzxzQb5ewTBhjAoAxE6?=
 =?us-ascii?Q?6Mfi3JXOt5v07qkUsgtxCfA/00cGITyEcsM4n195mLF99iIKT0/OdKenRfRx?=
 =?us-ascii?Q?GOmCL+rRmbmD8M09SflTxH1W94/2O7q80aWI2Sk+KJDjRvwDYtFX4rDyp/Nt?=
 =?us-ascii?Q?gTlEEil+5TupYf4HoFMZXgxYTHFUFSt/OrTyPLsKiirgzXDUE0cMnOrlHbO7?=
 =?us-ascii?Q?desiVLYiQswboFaZFxaFovLPMIPfxHkZHr9k4aP+Kf790AoBwgBSmuJmsXJI?=
 =?us-ascii?Q?DOOMM8K/MWWQISbeYycTfCuTK2EFgNMB0/yzulluwx7HbhwruFq8vY/L+/dL?=
 =?us-ascii?Q?DXbDpV9Bb2IC218Z6jODERlMGUpjfU4mGw5IZh5CaP/K9gbvfPsb7pU15c7A?=
 =?us-ascii?Q?8DznSJfEZ0zcv/nzHlWHpN0/UzK3m5nu5ZwMjnVcVaeXUhkk4B3MwiETB81B?=
 =?us-ascii?Q?9RpT2/tgP0ii707Dp8YXiSQp3tnNgYzrJcRiJjYyIbl8p1AasSvs52pgBlwr?=
 =?us-ascii?Q?BdG4Jv0f4R8ItbwMP8hFxm1esXgV7+ibnsVd9lAXNhMWn5/zKzODW16AD+mf?=
 =?us-ascii?Q?sSCqEIEn8VZLtYWDvVwhGywp6EWKLRXnnoJdg/NTEObZWBGzqYQKuEeFMGy+?=
 =?us-ascii?Q?/SkQC9FIKgelVOccd1a3Xatear8J5aWUXqoTxoerIGW1RwIQ2dogQt0BJWVT?=
 =?us-ascii?Q?4n6UBsgZzd1Eo6/dqkqeaY+2wFcLZoh2iBWw8KvDbHtfAgaZz34oNPcl58KY?=
 =?us-ascii?Q?fvbYkAjrYiRxLKQPEpy5FOxdUOlmz1nAwNY+uUgNHFnzsh4NaEF6gtydJDl6?=
 =?us-ascii?Q?f5+tKRixiHoRR3f14iFQxq9+UYyUQwjOdj1K9r8ULo5TQv3rm+jOHGyvDAQE?=
 =?us-ascii?Q?VVfOE4Abb66zdhPBvt9wupPgZ3VKGVUl+/MsNdg6SIsFjJqUhZQWwz2Tb+gL?=
 =?us-ascii?Q?1V3lx1klNleHgCJREG42RC2ZsfgF6QgVyqCq4Zsdv1q0CLf2ujQSosf6n/Aa?=
 =?us-ascii?Q?pKcw2LdEjQ1XqvjrxRUKQ6N8AGQdNeoIaZEdlDi3V4vZzKnD1y87jM9YhJSG?=
 =?us-ascii?Q?tcQOT+iJay90Y/ov2nrczEsJxdBGiu+4Ed/dHex92hwEPxGBp85z8SXBA4Uf?=
 =?us-ascii?Q?mnCA9nk41c+KhqNibnHzjz1xPrbJu+/cS//lAaWTojCZFC7u5K0N++a6Itu/?=
 =?us-ascii?Q?rf73uszZDGbcTx81T8xNFbLCIhB5riEJ1VJ8la4t6rvvG1ZJUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:32.2787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b891e334-10b0-49cb-353e-08dced0465dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9410

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.1.4.1. Retransmitted SYNs - If the sender of an AccECN SYN (the TCP
Client) times out before receiving the SYN/ACK, it SHOULD attempt to
negotiate the use of AccECN at least one more time by continuing to
set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on the first
retransmitted SYN (using the usual retransmission time-outs). If this
first retransmission also fails to be acknowledged, in deployment
scenarios where AccECN path traversal might be problematic, the TCP
Client SHOULD send subsequent retransmissions of the SYN with the
three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ec10785f6d00..ae78ff6784d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3617,12 +3617,14 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check covers both
+		 * cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


