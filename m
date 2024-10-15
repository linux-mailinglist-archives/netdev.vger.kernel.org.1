Return-Path: <netdev+bounces-135543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E596E99E3E5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE75281EEE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB801E7671;
	Tue, 15 Oct 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QOitL4IG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BB1E5720
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988223; cv=fail; b=BUaDspgWQX3XHO/h4EaXqarrU5QC9CLSBHHJk18ZPnktB7k1TLFjdSmuCyWLJi+JrN/EvtmDbxiR2LgD8wVYGZimawntevgx7ZQvm0avU+S5rt5keBGEBeFejgrBwS8xDhJb2YX8iBut4vwntILftJANbSUqqi3d3SyIfbefdgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988223; c=relaxed/simple;
	bh=/DXiP48JvOyuu2neVkASCL/V6m9Qs0aUxatR2JoMVD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM3esYgSD8zJ2kkdlmzi4A1sYago3w0SVUS7Pigu7b2HVfLdpmu1P2x3DG02xLDWow/EHwJKI02dq0Ym82zmjV8cV3P6khhHyGKtL7po10GnKMj3Nt7SSjPeWNRdaQgW5w5wyHgIn2wWcNFu9lAqj9Y1LrShHEPLMTs6WJ31QGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QOitL4IG; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr7yYMjoCggfHuKMCeG8G5Ou2fz2Ao3xLZlfaWj2M/o3BbuiLPk061UDMuolAe1H15X85QCD+X9OCpVSV1m0ftsOIt4OLPabcwxR8XdYGEvzo7w3ur+OzeYQBLA1dAi+H0EjFilpqq+KT5xc5MOmebUkFph/VfyhkBt4zu87jlc6hfwWBvU0rKLUxBJiL9Zc5uYrJkSq0r7iKNZq6TvI1HMeARuZlGIRMTdSNUcn1V5T0HEnYLFZizFQ9rbTFWfmisyCu0lpKCmFgtoqfak7EAKQsfIiy8/BImGGdZaXD87VYqZUd+Y7Geagj/8BLuQKoSq786dant6ZVnlQNRdw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=gpzyvC8LC2j1GPBSFWUgRcDVvR2KSZa2SCzIrBiH4DRyuR6ZyPs3AtTPY+CNAVIJiq1PqEjx5xhnA6wXoNLV5Iw90rpveSiDI51jUuNdWiB9kRmGRkC8G1cU467GZrm4hcKFaF29Qrl8oXKCAnE0hfI4OhUKIWTsQkPht7J8IL/I0+73cOSocwqtKFCCk0sMAKp8aQaOiWmzfuPsEtX4Im37U502vNoH5po6Gq1Ak5/lkq8GdSx5lSNwKEnZDzxrPlgVTXtjHVy3pDp8RSnMl5P0H2eJKu66amvDMm1d0OnJEgls35S3NiygmRm/9xMp/ssVAEHsEK6fXgRn9pxcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=QOitL4IG3MD22SwSdFgIYMXtBvn2EpT8u8Az5ugwGWneqQafcKHOGj9xpdBdfe/HIBeFiod/EvW1/d3FenizwSR9xhj7pTuR7n85fnenGnmroAgKfmRGoHH6HWYKdF2RUYjBRSg6J6M9b9UTXAvJn/+smOwTYC+i1/DZAYPLAY8lPtgTGwIK1jVS6HTU7P8i7qx9LyNz8geqkAtpk9iX4yKf0ASCmDKHaZNHvqLcRfMfREbqmvCWB0GIkGY7MMiPx7eaOvOMXeTiymwQLmTkzbYfuCTA63h/6UHsbaPIKhJfILYmkOoiwWjop2JPNstTpHcIx5xjf6ByeTHH+WkyLg==
Received: from DU7PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::10) by PAXPR07MB7726.eurprd07.prod.outlook.com
 (2603:10a6:102:15f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:18 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::30) by DU7PR01CA0022.outlook.office365.com
 (2603:10a6:10:50f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnA029578;
	Tue, 15 Oct 2024 10:30:15 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 06/44] tcp: reorganize SYN ECN code
Date: Tue, 15 Oct 2024 12:29:02 +0200
Message-Id: <20241015102940.26157-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|PAXPR07MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: e757c98b-e7f0-499d-0143-08dced045c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFBPT0t5bktEZXJSejlOL2orQTFqNjNjdEhYazJjTGREVmFTc3hkUm10QkJU?=
 =?utf-8?B?bWJBZnpZcDNzZmY4bXk3Z1Q3WWVrZ0NSVEZDR1A4SWZHYktsSG1KNHp6WnZn?=
 =?utf-8?B?bVRsR1BCOGdqa1NkYVUxUXNpbGFtVFlid2R5OWtiSVh5ZWs1RFNiV2NkVHk2?=
 =?utf-8?B?VU1xWS9STlB0K3BSSWpBaE5SRlppTzBvekNjeEd1RzJ2R2tkVkljOFNVdy9X?=
 =?utf-8?B?eXZnb2lHKzgrT2MxTUh3VHdtWWZkMHRjRHJ2Q1JHWlYwVFFRcUhKTENYUEdT?=
 =?utf-8?B?NXNsVjdtYUlkNlc2MEtySHlCVk5pSVQ2UFBqZVYzbWxraTRCZHdBZlVKMVF2?=
 =?utf-8?B?aUtCTXB2MWZ4ekU5Y0dlM1Z4cDFpMEVVdk84bzF3TTNzcFhQdnpJZzFmR21z?=
 =?utf-8?B?aVZ0RStwanBCYjVMczd4ZmpBV2IvM0dXbWM3aURuY0VNMzRROXVlRmdXbTNz?=
 =?utf-8?B?cWNYWWdvOFI1OXk0TEZ3dVI4aGh6MjdTcmlrK1RkMHFITjhQQS8vWVorZEI0?=
 =?utf-8?B?NkN2TU1FR2xPVmxrcWhKc2xjVE5JU2JTNWFDbDBaTjVIV3IyN2tHSGFWSW9j?=
 =?utf-8?B?RGM1bCsreEdmQm9SOWtmdTdYOXF4dHNzWDEwa3RNVC9tb3J6Ujg4dEFBQXBG?=
 =?utf-8?B?TEJHbmZGaHp3TFFSakVrMytHa3pYQlAxeTdvWklRenhNZ1JJS3lGREJxcnRQ?=
 =?utf-8?B?TFlWa0pjemIwNGRWbXhZdXpNQkhFaWM2b0x5NnhVV2JXNzI0OWV1QkROZEhU?=
 =?utf-8?B?VE5GeWVtOXZGSVhoUHRTUU05eVNSMkt2YjhpZkd6eERBdTFrMWpUcW9WVSs3?=
 =?utf-8?B?K2lNeDZUcHVSVzZrT1BvY3N1RHZRT1IxTWp3VkxTK2RjeC9maUF6ell0Z0x5?=
 =?utf-8?B?RGhQRWpVazlJenZVaU4yTHZwZE5XeVkyWUVEZnBXc1U5S2I4ckFjZG9rQysx?=
 =?utf-8?B?czRObDh1TktsUVdvdDBkR2Z6dEZEUllvWXBtTWpBRzhRVkptY3lvWDZtNU8z?=
 =?utf-8?B?b0wyZlhJSHpFTStDK2MxNDBJd2xNcnZDOC91N2d4aUNDb3Yya05MRThmTDh1?=
 =?utf-8?B?SzVRa254TGdkZXFiSnJ6S012RXZDajdqUzRtUXpqalhDNFY4RlJqcDM5eWla?=
 =?utf-8?B?TlZ4KzBHeEJuNWZyUGkvVnFubzNjc0VTYzc4L25kOUVtK2c4S29zZUp0UXBw?=
 =?utf-8?B?Z0I5VFVTemRyTDZJRldybW1IQXpDQlNrRm5SSWRsbFBrQ1daK3EwcldBSW1N?=
 =?utf-8?B?MVRQMTU5Q3JCZ3l5citsVXgvelNKcjYvR0lUbnQwcWtiR0F1bHBsYThReXV1?=
 =?utf-8?B?eVRvUFJzK1V4bGsxbFk0OWMwVjdpM3VicllnQ1hnYVFid2QvS1RoWjQwbi85?=
 =?utf-8?B?TDlkWXJKRUoxbVBTUVUxeTdsWHBKSVpRWm16b041dllOQ09TZnJrUzJCN0tW?=
 =?utf-8?B?TWIrR3l3TEs4a3luVVVzR1pGYlZHSnJjdFhNSGo4dG1uYUhQbVZjcnNzR0lZ?=
 =?utf-8?B?UERDN1BmLzNtdkN1Ukx4cHExZ1ZxVitWVjdMVUFOVm9YdFVQSHJ6YlJ6QzVM?=
 =?utf-8?B?MUx1U3hzaGtPQ1dTazhWWXk0MEludUVRcXY0OGpxclpzRUxnNVl0QWYvRlpt?=
 =?utf-8?B?MUxMN3VMdDk5UHo5dTdMWGtXQ3dNSlV0ODJLUHRleldHdDNZZzVjYWpjRVFx?=
 =?utf-8?B?aTRDbDVtOFhqL3pCd3lFYXVyalFjL3lINmtDUlJxS093bzBvNjFULy83VkQ3?=
 =?utf-8?B?clZ4NS9JSjV6RWU5UjlsdmNzSFhnK010U2dldmFnVzlwR24vWGlScG52ME1z?=
 =?utf-8?B?TnR1Sk1KVjFmVjFXTVhWN1ZTWTFDVk9ZcnpNSytMdlBFT0IzUzU2SWh6KzJE?=
 =?utf-8?Q?AcIn3viSWynPI?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:16.1465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e757c98b-e7f0-499d-0143-08dced045c41
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7726

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


