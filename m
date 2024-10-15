Return-Path: <netdev+bounces-135559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51B99E3F6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BAB1F23A72
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B91EF93E;
	Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Nhr23cus"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD161EF09D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988233; cv=fail; b=M6dIMzUio0KdQFcSWctdA03AGtw5t6Fzkp7GKE4p8b+YV+CDi8/HrFcu+oRrtexGaCRGXfSdHhw4F1A1JJlUVPy5IDt5Yu1M+qRQKe3nXckdA6KQkaKQPXWe+GRx0K9Jc9o4E8ho3Wm5XQ456ByL1CAYszmkshTbWEfE61YDXpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988233; c=relaxed/simple;
	bh=6W2eeaETfKUS7q+IQoIsmfag1icCOuuYUqd3t0j6JIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gx3WlKakguDZnaQbzvCCZJ+zIiCjrWzB8xccmFMsTe5uDOvLSzSEBaueOaErYIM/v6frSpsE/rQAdnsVTbvOOrkA6UDAU6i0SnhDSHJQY1mKmAhn9/o6OH1SkNZwrAsWu9ZcM48JBmGpKipjj6eoOL5QufmzLMV7KWjd44yUB5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Nhr23cus; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXNqV/IS25SmUKaE6TQpisQZYjvFEVxYWSp7ydRDNtnYyHPiEqXf8lex1ayxHbS8vihKSR51vW8ECU0gK2+1i/IlIC9PtM/t+Z54c4zOTdM15ORrbIRWIpDapEMpaplx0YySV1RhxoheZBYP2u7AOe8uL1cDbHRhHvy9RWX5p/Tc4ytYUAr5084AobczpFdj/kTr9Lg+rjUmWM4BxlNRdgTLnx8qNHtQpbnUfQwPMQSnG9l08iqv4mnA6bhNNOKLY5qXE9QDDBc0lLVV4PL44uqBOVNzVFlK4PEQyoFeMu+j3cZWgHHx/rXh09KaEFt4AyZGFE/pba8AsNGBgpoiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGUSvRQ5nvfxBGuWXThf9+eGeUp3Rb42NawIGNmq/ls=;
 b=LsP7Vl5FTjabvlEuV5rmBGP2vYbIQyUzmiDgFRuW6KAJuooyZVTsqMi9p+wiRyJOhvrxxjGi5jdkd7ldmT6FD2i/nb15P5GNpvZe6CW8nKRQF5gS1UhzKrko0Aec+KK7WBiAgTJarJioVjyv8jRzgXlZZxeFhwuYqPdaaNg1ESPFjDwLnZf3Yp6JHJYKVTFqSM31vyAzYB8JjRYOMD3rMHrm8+doolMT3OVjMbxrOR2o8AiK+hcIzIS1/yWW3HDoCqVEJYR4Rq+Wd7IcpQdjQT/l/WK/UjfJn+jFe/s1+25dqinX9bqiNGo7KRfYk6aoNxcv4CRwOQz7cWps64WYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGUSvRQ5nvfxBGuWXThf9+eGeUp3Rb42NawIGNmq/ls=;
 b=Nhr23cusfl2oNN+7QTFQfmk57zIG8gdXScIO60xz9vcW01ukt72w3cUV32xcv4wJpCehotSS89I412LqXjoi7klJAxVPDjgvdSWat7N3T49Mrgu0XvnyEWqSRGmBOlba8Z+CKf4MIjJhNvMWUfMme2CbrSvPoN+ZqfJ4nn31V2+VqcSvqzPIJmT8ipKixKpHCbRAhoPiOqmx23Hd60ZYzQV/ZPPNdHdsI1hdGUkIr/fB/grjcyxrgxcgT7jx0L8jHxDWmeX/oIJN8KoV8xSIdKccIG5zpUexJXtByuIDDKVgj9V7IXwGI17KqRu2T+7z4lThiHLNh4vGyiQehhQEuQ==
Received: from DUZP191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::8) by
 DBAPR07MB6710.eurprd07.prod.outlook.com (2603:10a6:10:18a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Tue, 15 Oct 2024 10:30:29 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::89) by DUZP191CA0048.outlook.office365.com
 (2603:10a6:10:4f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnX029578;
	Tue, 15 Oct 2024 10:30:28 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 29/44] gro: flushing when CWR is set negatively affects AccECN
Date: Tue, 15 Oct 2024 12:29:25 +0200
Message-Id: <20241015102940.26157-30-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|DBAPR07MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: e09aa0fc-3bf9-499a-07d6-08dced046433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXJBVDNuMnJ4TDN0Q0pSUUVtNlIrSjUxbVJwZ3hCTFFTWm1EcjE1NGZJY3E3?=
 =?utf-8?B?bWxXdGdWYTBycFRHaGJvcTFDU2wzM1ErQ28wcDVIK1I5dGZoOXBtWks2elQ0?=
 =?utf-8?B?bGlFLzdZMmlYUnVjbFRDd1RQYXIwTlQ1cnhzODZzSU1rbkh0Zk9zckt5RUlQ?=
 =?utf-8?B?bHRBcXNab1VMcXphM1RZN0puVVFWY2RvazBEN1F1bVM5NExzK2F2MEJXWTFa?=
 =?utf-8?B?V3d3UGM5eGdVQkdwb01xdXNmSm11WThMMmxQODN4ZTAwcUg0bC8zeDcxUi9M?=
 =?utf-8?B?WHY1aDdKOGV5cmxhalNoUG9lQ3Q1SDZwVlVqZnlkY3Nnd3ZmT1lpZGlsd1JL?=
 =?utf-8?B?RWxIQ3ZmeE1sclVLR2EzZDJ6ekVnM0F6NmlWSVh3aGlNQk9hdEZiWktkOHdK?=
 =?utf-8?B?eHBCSUU4ZndqL0dDdmRZeFM5cGtNV0Z1S2V0U1Btend3a2VRbndycm54Tzhy?=
 =?utf-8?B?UFhLb2tjQ1U5VWNwZUJKRmhibFRCMzdCeGFWNnZxNUVzejl3bTVWb2NlZGND?=
 =?utf-8?B?NVozcExHamRwUGlLdGhsR0RQZUhSMVRVQjFCTklGWDdRTjBvVG9odmZDSWFT?=
 =?utf-8?B?d0RmVmNXQkUzMlB3Z0NyRlVLUkphMGhFVkhTUEdjeW9wN2psL0tyV211TmRX?=
 =?utf-8?B?dXYzTjVJcEdmUUVpcXY0RXFrdWgrTmxzc2MwRjJoVUw4WkRsS2tDb1Qyay9p?=
 =?utf-8?B?cEJhWTR1OUhza3pNcGg5T2dwM29oVVFkVlplTnZxb242dHhhTlltMmNPakdp?=
 =?utf-8?B?VStDL0h0US9KbUY2eEVNblVEVk16aENEOWRyenhZQzEvZmFjT2t0MnBiUXlt?=
 =?utf-8?B?Vkxld2lqUjI4VnpDc2RLRjZsam5uNmMwZ0hZcVB2cFZzWTZrWUo1ck93ZXFm?=
 =?utf-8?B?dHdhNVJ3TEptbTByUlpzVEtpWEFFOVpIREQvWjBtTnhRL2VJc1VmL1NlZEN5?=
 =?utf-8?B?OWpicDVpVkplSU94RkxMTFgxZkZ4MVV5YVdnRzdtOFVGdWpqd3lRaDBuaEhO?=
 =?utf-8?B?R0JrTXhTSmgwZC9WTndPZjhSY2p5K3NGbTVZOTR3OVBIMksybWo0bENLcmxO?=
 =?utf-8?B?dTdkTmd0dys5TVkyVkR5RFNnemxUS0ZxOE1RSHNpNlpUZ3ZJbHpXbUplbU00?=
 =?utf-8?B?NUJmSVBIdDFua3d3aldGei9JaTNsbStnUWp4bE1qV2cycCtLckR6NmxYUFVr?=
 =?utf-8?B?YjV3TXBmN3RqYktFVmFtNHhFNXBFWU5hSTA1anVBTTdFSDBSVmtoU3dUaTZ3?=
 =?utf-8?B?YmFLVHRSdHNQdkh4NDY1NjFzOVVvUW1SU1dMK295THZSTjFIM1N1R00zcVNq?=
 =?utf-8?B?SS9Ldm1pU1FDdmowQmJnRlhNdWRTUis3QjluRnRBZll1TEdEMjhFQWp5dkJk?=
 =?utf-8?B?Vml2R3lGRkpmSSt0blpzeTgxZ29XWTJjZ0l5NENuT05zeWt2K0NYN2xubXBC?=
 =?utf-8?B?Tjd6UW10V1BtU0xVdWZ5ZDNLZXpIRmtyNEcyQ2VHUmNmUUdhWlZvSEJPNStl?=
 =?utf-8?B?c3NjVGZuQjJaU2pSWE4rOWtwRzNCemovY2ppZ0lrSkZqMjUvc3ZyQ25ldkpm?=
 =?utf-8?B?WGhlbm0rOTV5dXMrbGdleHh4eVBqK1dZRWcvSC9zU0xxd21XWWd0TVE4dXd4?=
 =?utf-8?B?M04wYWxoQWVNZmJ4enVLa1VOMEUyYVlDa3p1eHp5SzhST3RVV2RENHhYbDN6?=
 =?utf-8?B?eUVLdjNGTmo5bE0yRnRMRjhWeU9xOW14Y1kvTFhBUVZhSlEzSXNKYnJMWGh1?=
 =?utf-8?B?ZDAzODZJMHZ1NHp3MmVqSU1ocW1lbnZIaHpRaHMxSzdTaUdoMUE0UlpTdTU5?=
 =?utf-8?B?cVhzZFZSWEt3UXM2ZDBxUlV5NlU2cUZFU2xPaHVyVEN0MVliemJmMmR5UGpK?=
 =?utf-8?Q?2FSpPan5ZR2tM?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:29.4923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e09aa0fc-3bf9-499a-07d6-08dced046433
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6710

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index f59762d88c38..6286488abeca 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -327,8 +327,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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


