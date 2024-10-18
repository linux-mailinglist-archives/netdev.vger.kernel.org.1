Return-Path: <netdev+bounces-136821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A66B9A32A8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2093B2853FE
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81B16F0CF;
	Fri, 18 Oct 2024 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AvT2p5vh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07213D881
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218133; cv=fail; b=ly8JPCROds2XUd5MNm0q4r1orQV9GzhOfTsoUZiSHTFO2eeg5a4/3rsfi9gw3dFWHoKR8XO4dcDWU8MOxok0UCk0MmArTK7E71z5QrFf99yF1CDJ2sva2dJiyui9RBh4BMmiKicq9hf4IKE9fR8RrP1GgBv55ddOYXTOwKAjIdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218133; c=relaxed/simple;
	bh=4j5SJ5HYuPel2Dv+IBBWRsO/17dTAoza3QBOY2Scc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgDG+OihaDEfa2OpopQzgigR62Ss8hAdTRNuC5ARd/9PHUfgLPa2JxfZT6BoqyjtqdRwNcJ2zfZhFw2s3aPggAy41me6I32GehrWLpmWBMu9YpNzHcSDpJb7x2TZTGD2WN/tWM4NAppb7G4LYS+zIyykUxy6u3XND5EkHHH7EjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AvT2p5vh; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5A61Qer4lqsAr0TGCWaguBJLv4I1tdck8fYGMfP3r1VAyMyhLjXhAAI80PwfXYOJa7Hw/MLiSUoN9TvGP5qNAQ7DMYTyVKA45JoYqRSkz00I1S9AG7exX+wFOwzCnOB1RQPntO81EOBzwI2YUwEIo4YILZuSI/Zc5akuV66NzsxuZrLTNJrR7SBvNlsI54iyehX4CGdZVAm74WQn3wz6tc7ri7U7RKZ7Y6vMHgMMWnr3cyOhjoFOsafSTAD/i1lHe5IyrHcGk4iZe/B1SiTlPxGdFV+Cq9M/lMzycZ0EDAzhd/tagNK7VZlW4vgYyhHNh6fjae51OzUrb3EGH4/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=nAnin9+V1ME4pIfCKTGWSY6LVNMAQ1wxY86kyxHnnm9KgpUd7j3Jsj0sE27sOx6l2ftn+ovGfCLRJj4p8GzRFnq3HIsqBa0kYX4R0SFj8zDPoZRpZgC4lIGekaWIvyqwas7t1+Wd3pmlZDI2SY3Ig2bA7sNIRcWt4C7M/V73xxhfmQ+r+UMPWFguxWK+dIuLk4riWh59NwEy0xKioa8lzn4tW54DOEhmOno2gdHcKRC8Mqpg0GsNJzdNs0FdFupRoC1CwXpI4eJKO7OSxyiAODOOu+GJTJIkGIVlf/XD0SpJb7b7lGf6v3t0sWo1Ll12a8ESTzY1w3TT5mlQRoCPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=AvT2p5vhZZNgjWf3XgIaVWAxZMvyjwtu4mjLB5HoycOvLW9ePnNoLuPzonFolnz+TTSL6D65gCNjED4shxBlnZjT8mwQIJP9D15EPlZ1Q4cS9kE9qG2oleIUNdCqjgCC4rq+tMWIU3xO3CReb0+geWfXiZFMDPONeUAH+4lDnajUC5YjswDkF0BbJh2/FXPAyuH1C3L1BHZZt6ms5ZIcH46Unhe4GUu8fPS7Tg+SPP5QsuCyzz8muw2uoj0ipIzFjgb5gTLy+3xb9bw/u+C58rRX4/DnhpujAHww8HBfDGUpoe7oyshJBNwRSx2zsP3dDFAbaIZxmyV74LE1Kry1tA==
Received: from AS9PR06CA0158.eurprd06.prod.outlook.com (2603:10a6:20b:45c::16)
 by VI1PR07MB9529.eurprd07.prod.outlook.com (2603:10a6:800:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 02:22:08 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::b6) by AS9PR06CA0158.outlook.office365.com
 (2603:10a6:20b:45c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Md023685;
	Fri, 18 Oct 2024 02:22:04 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 09/14] gro: prevent ACE field corruption & better AccECN handling
Date: Fri, 18 Oct 2024 04:20:46 +0200
Message-Id: <20241018022051.39966-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|VI1PR07MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f3bd16-cd73-4993-367e-08dcef1ba936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDNwcldEV1czbnd1b1VOL0FSUmZjRFhsUlVra3c0c0JldnlJVmZFRTJFSVVa?=
 =?utf-8?B?a1B0ZXNmRERHdE1xMGZYeWJyc0c5N2d1dnFEaFRwZXJwVE5nbjFOOVZqdkEw?=
 =?utf-8?B?Z3k3TmtidWhSMko4TVVPYU5GTDNTWmtCRmRtRWZWenhPR3pRWFJoajNNUTBo?=
 =?utf-8?B?RVdVbTFiYVRWcDNXTjJHdFAxeGJnR3RVWFB2S0N5YzJDbEkvUStUNFRkUHBO?=
 =?utf-8?B?UWR6Y28vbXhhQkpValJXRytmZnNJK3o5Q3hnajhqRXg3MERXOG9aY2hHbHR4?=
 =?utf-8?B?UnpjMmdYV2dQeEI4ZE52cjEzNDdNVFFvbmhxUnFqbUlCd0pWeHMrSVBac3RN?=
 =?utf-8?B?T2pKOFljQmJ3dlBjaWcycFVxdGxVM3FBS1NkcXU2bUhpdWE2WVI1MmQ2US9Z?=
 =?utf-8?B?RlVYR3lOSU9IWCtCTVpDbHFXN0JKS0NrLzh0bzhIazB6TVFnWHd0RCtiSXNP?=
 =?utf-8?B?RUVvZnJuVHZNcS9Yamk1Z2I3aDZsVUZPWFNSRkVXZ1RtYkxnVWVXeXNlV2ZO?=
 =?utf-8?B?YjB3Q2NEenlWZ3QzV2p3L1RDWXFYTkpjTmpDTy9kRFMyaDBiNFNRdTZDK051?=
 =?utf-8?B?NXpmdFlFdFhTOUxjK1hZQ0pYeXdlUVUvZU1SV1BZbWttZWNpWjdVeTFVVzVo?=
 =?utf-8?B?SmJ5OGxjQndtTE1FU0YyQ2NxTjlqMERSQVBNclhEOGw1YUZUY2l1cmcyUlFl?=
 =?utf-8?B?WTYvWFlHb0RrTmFaQnFjUUlYMW1WWnhnT3orMkVSbWpnTlc3NzcyQXIxWFBU?=
 =?utf-8?B?TDh6Y3VYWlA2RUlSSTROT2hsQVVXQTBXVEc5RHhKa0tpbldnNjUrazFGMkNH?=
 =?utf-8?B?R0xuNDRpSDl3cTQ1MTJKK3p4NEFQbWQvV3k5RWw2aWU5Nml1UXplYVlxeUlC?=
 =?utf-8?B?NnVnSGVFVEJSK1lNQ0N5NkRLellRcXI2eHJiRE1OYjJ4SE13WVgzTU44bFB5?=
 =?utf-8?B?RUJJYmI3eFBRendJbGtwR3Q1ZWFoYlU1QjlOeTVNTnc5cG9OTUl5SXhmV3JK?=
 =?utf-8?B?ckZDb3NiODFEWE9ZTUw0cEE4VEdscFl4bmIxM0VmaDZLYlcrWVY4eU91TGZ2?=
 =?utf-8?B?WGpNcEM3TmFWNURoWExEUnZHTWtCTUN0SHF3K2wxOVNFVm1pT3A1aVhyVXBW?=
 =?utf-8?B?MVlGamR1MU1KZWJJakMzVDR0eHhJcU1veVhUbnQ2ZnNKRTRpZUx6WDNjNFhK?=
 =?utf-8?B?QWFWMzJsUlVUNkcyR1ExcElhQ2RUQ29qRDZNdTZlV2MwZzVLMWIzcHcxVkxy?=
 =?utf-8?B?a3lnSVhoM200eFR3bTRzRGRxZkh4ODQ2OVNSWktJZmVTMmFUN1plTER0VktF?=
 =?utf-8?B?TXNBWE4velQ3ZUlKMEk5VXYxMlVOdGpVVm5OWE1vaWp2RTVPL25wY0I2OWZx?=
 =?utf-8?B?S09tekl6eDI5eFhvZDJDZGQzNVJpSlRsR3FTV2ozVDJpOG5wZjArbWZqM3dr?=
 =?utf-8?B?TUp1QzgxRUpWNWh1b3JHTmtNelk5SE9qYlJUQzljK1FaWGwzKzdaUG1xTmtr?=
 =?utf-8?B?UnJTVmR4L0VQOHd0YXhaQnJOL0YzZHlHa0xzN0h0MjJOZUd5TzBzTGlzQi80?=
 =?utf-8?B?THhxWHZ4dlVjaU1UZGFrTENnTGw4SEVHbndZeHZJZGlFVDFiVzdqcWhSZVVm?=
 =?utf-8?B?NmVMZ2N2aitMaUh4eE9uN05iR3ZJZTdGV2EydnVpQnZ3TWd1VFBqMmFWVDJq?=
 =?utf-8?B?MDMycC9jU2dVejVsaDVMOG0yYUJMVkNnQWFmSFVwdTEvYzVITUMrc1gyZnMx?=
 =?utf-8?B?TXhLb0t2TThBQm1ldzFwQTJmZW1xY0FNL3pLM2hySjVEZkxXUndUelRVN3pY?=
 =?utf-8?B?R1pkMmNYZmt0OXRsMG5vZjdsaUlDSm42ZDZwQzNoazB5RkhDY1hGdUNCQjEr?=
 =?utf-8?B?NE9IaWxSVXFWcGVQaGg3QXdYMm1qaVk4Yis2SEQzYml4KzFMNlBNdFlKODJG?=
 =?utf-8?Q?GTp1yJbjXtA=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:06.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f3bd16-cd73-4993-367e-08dcef1ba936
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9529

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


