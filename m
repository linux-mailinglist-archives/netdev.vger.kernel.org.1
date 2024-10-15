Return-Path: <netdev+bounces-135557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A999E3F4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755762826D3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352251EF0B8;
	Tue, 15 Oct 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="D3PAndfs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CC1EC012
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988233; cv=fail; b=qgfHn+K3iigKYIqrDPvKvWWbUPYEYKa7rcqnVsOTs8N83kWa6Qe0yp/05O4+rfR1WfjluxIHRZ+TJ/9BPVYaeUe7nijIiqeQvY0QCDWnLkGgEx8rC914CMcXEg0PWD2PKfLcQmFarT6TFdH3t4ccJITQD2K0sLRrIX5K5xkRmwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988233; c=relaxed/simple;
	bh=0iqVpC3ix4wcVnQolShz1trtufb10W3igQoHnnx0u84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNlZYzi/8R0yCUBoO7NlcqQXxejFF15zY8UhAQ1B/SW2jcIIzm/nfZxnbrnARmTK9zsngOtCS432NXgy5jiWSLGPTXLDeX8djjrYikUPIT7//ezTaIKTfr77YTyc8BiiL0X+JJ6VpHAJu73nK5l3ukMK051nbA6z5oGLJF+Q33E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=D3PAndfs; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGmNcAazK6Z/jkpaREyYFrpTkIGal0C1G1wzmFjOjtAy3wN76SsKPT8B8tR3LnjwT0ao7vPxzW7MXUh2POlsU7rpo+Nxx+0u4if1cszVd96y1t3LiMqnHyuO0mFuIJ3RcfCuLgAEA+vVjILmUWCKwGRsQOcLzsaOqJ/eY0UCgmHLbHrNNZw/0PFGqJCU+Dm8L5dXw774WrDMA+2SKmERErex46pxLrhXFwHAc/5JGyY6RTV4Gwacv0gUkle9uP+SjQeTK9iwAbLwga21/utWbn0dKic5Yg4cDzmhcCoD6Z/tp21kttBqDRNRF/RzLmJy7csz3HOAt6Wx3HpUgAirNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h+tkf60b8yXMyLY4Z8aLYinxoPsag9gw40RsoQrVdA=;
 b=EJ9L4pydbkwmyd8WEi2ykOSemJl3htybJPs3cR2AQjnTVc9HSPNnyGZ5bhZVFwthpDTr5LavJTayiTXtWCtta2QTvTk1AH1LYBUMaLCzLMMdq23s5Fp1Tmjf/Nd0+ZsII66Cczu4gKCYvxN4QHUpCNn6VnaEQK9LFy3tM6Pn8XMbkn2iajnrRrM5uaiFiAzFKsEa6SQOggVWyzne1I6K50j1zACMxdV/d2jElYUb4NmxjZ9WM0vPKcE+Vd18u31WZ9LP0aslG58RjK3pNvJWn0sulCx7pAb1LKHsRYY+WIuyvSnNYSDBicUmdPIt4GgKKsF8v2mKtnbypDyvwVTRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h+tkf60b8yXMyLY4Z8aLYinxoPsag9gw40RsoQrVdA=;
 b=D3PAndfsAIE+CvRtsqR1vWikkCJmYmQj0+xKXzfFyR+XUydEFg2SK3O+m3QcbQapviU1jsW8KZJ6Uoli5t6HU+B+RsUm3uA/imVozyUfcdCVPemu3EYoBcKo3ieFERk6DULjTdvsaR6LTrNHchu3v3kAB1eUhYxg2c2QNG4grbkWbqMHgxCvRqkey08Y0mQbqingbhk9HoQaQqVqns1cmiLNMKDVwHpLfRv24z1iZuFCfdBiJQYcyc6B4poWX8s3LTaZ2bYb+YJdFOfRyR79OPhf2+/1i4Clds32IExrO41eog8pWneQe0Pesyknj/MfvvIBBkvXtxR+JVoYY9Izqw==
Received: from DU7P250CA0014.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::8) by
 AS8PR07MB7589.eurprd07.prod.outlook.com (2603:10a6:20b:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:27 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::2d) by DU7P250CA0014.outlook.office365.com
 (2603:10a6:10:54f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnP029578;
	Tue, 15 Oct 2024 10:30:23 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 21/44] tcp: sack option handling improvements
Date: Tue, 15 Oct 2024 12:29:17 +0200
Message-Id: <20241015102940.26157-22-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|AS8PR07MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed5a913-8636-4213-3109-08dced046196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHhsUy9VS1hRckJaaW1valpxbVZ4emNuT2UyMEdUWWFSVXFtSHpMVWxBUVZL?=
 =?utf-8?B?L3hxekxlbG9xR3A5SGtlN2JaWDhBMmhXblM2Y0tmN0UyNWVlVHgxT2J2eE51?=
 =?utf-8?B?T0NQOFNidGIzTExrQnV4VHE3dW8yOHpHUmdmN0RDNWJVck8wNzEvc3N0M0ph?=
 =?utf-8?B?bnhMbk5FclZ5cWNGcnFRejhpeFJPL3ZrMUlPUWtjQ2Q1YWRuMVJWTUFPS2hH?=
 =?utf-8?B?U2hVbXgyRjV6UWZkVVByMENLVm9WRi9NMzdyNHB3MEk0eUpOVkswblp6ZVFI?=
 =?utf-8?B?QmtFbnUvNGl0NUVXZlFwNUpjeW02dnVIOE1UVzZJN3VwNVlPLyt1UU5hS0NT?=
 =?utf-8?B?cVl2Vkp0eFoxTEEya3ltQ250bTNtVWJ5TW54Tk0zQ1VTVUNLajk5dnMweXhK?=
 =?utf-8?B?N3AwZUdlT3FVOGIxWlVwL1BpL00waHhSZFBPajE4S1UxUzdnQ2RLUXNab2RJ?=
 =?utf-8?B?d2UvL0haRDNmdnBrdm1mTDhCZ1RWajByWkJwdEJpU3ZsYlZ2Y1FvNkxNMDNU?=
 =?utf-8?B?aDdlTTNxVUhSRXg4VC82SUdsWkp4N0FvZ0IzMUZxUGRxYVBzV1hmUlFIa2dp?=
 =?utf-8?B?bTF3ZUJNeWtubkp3RUR0SlJFN2Eya0JqSHNDOUF6aXdqMklrUlJuSmR5NFNG?=
 =?utf-8?B?Ny80WmdNeFllc1N0V3VidXBIMnlqMWZkZGVwTG1jcE1WZ3J5TnJNL1JBVmU3?=
 =?utf-8?B?dmlCc2R4UnBvdHdQSmNMTHVTaFNqUHV2V2ZoUExWK3grK2ZMT1N6UmhWSCsr?=
 =?utf-8?B?S2pEUFFxQ0NxT2ViSE5YSUJCZ1NKUVJTNCtqNzlEQ0xXZ2VmZjRPVCtMYmh4?=
 =?utf-8?B?TzdEalBEa1lhT0xMYXRVU1IraEVTdk0wVVhGNEFXcW5Xb2V0UWM1TUw0VnN4?=
 =?utf-8?B?OHd4R3lxYVV1ZWtheVpDSkYwdWx3Q2pvZmNXTndyTG95V01sQVNwRHBwaTFL?=
 =?utf-8?B?MTI1aXFpMDVBYUp5NXNqcHFyK3FpbFVmVHozQS9Nc1R3blRuSnoyai9DMDJ0?=
 =?utf-8?B?b1k0Q1hMY1dVM1FuRndyeHIyN0lVMlhpTWFaYktMcDQ0R3IrcmNsZEVLdjY4?=
 =?utf-8?B?QWZQa3J4dzN1WVhBNytLMzV5MU9ITUdObHRjZ0c1bHoweW13Vm1ycjRvejVJ?=
 =?utf-8?B?b1lvUlhVRC9jY25aYWJ5M2VSRlFYN09XQ09QWngxSUR1NVhLcDMrK0JIakMw?=
 =?utf-8?B?dkVLY2xuZXJHVDVSYUFWOTBhRjZXNmxnemQxdmNCOWllWUtRZEVZVE1zQUlM?=
 =?utf-8?B?ejh4WUp3VHlETkhpOU1wWUVySWxhajkwSG9KcU1MUW5BK0tBOE9ocFljZllI?=
 =?utf-8?B?eTQwelI0YnN3QmxrdnVFdEhUZDk4MXdnOXZjNk9lc0xmYWdrRlQxdGxYMlRT?=
 =?utf-8?B?REtXeEhjWDJ6VE5nSk9aN1M2VTlZazdWWXIyZXNBRlN2b1dKaENWNVFKRFd6?=
 =?utf-8?B?aDNVdVlxU25UM2Z6M2xmdUVPVFdQNGs1QXRDVGh5dlhzMTB0ZkR5RjFlcVEv?=
 =?utf-8?B?dEVTWjlPeFBrSEtnYzU4aUNWcHdWSy9uYXV6ZVlVcWRxZVBTVlBrYis3MnNU?=
 =?utf-8?B?cWJiZDIxcU0vMkhsYWU1dTJsR1RnY1p0a20xSG5KQ3NmUVRWaEQ0bFN3NW9r?=
 =?utf-8?B?YzFOZDNPRyttbDlhQ08wOFB3eUh6MWtuQ011NERSdW9waTZNTHFqNi9XYXBr?=
 =?utf-8?B?bnBldEtQMG9nSVZxNW9Vb05TVjMrSWlaYlJiU3NielFnQmRPTDZ1eDdnOEpm?=
 =?utf-8?B?OUNzTmdmVS81dCs4WGt5dmNvKy9Oa2ZOMERNODNYYUExbVlSWE8xZnF5MjZV?=
 =?utf-8?B?TWlpSG9qMGVxOXJ3TThsSnZrZ0JZZjhuWEYxblFJdDJzRXlVN3BCUHdpbzhz?=
 =?utf-8?Q?sMb4VqJCmXJ/T?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:25.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed5a913-8636-4213-3109-08dced046196
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7589

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index becaf0e2ffce..d6f16c82eb1b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1089,17 +1089,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


