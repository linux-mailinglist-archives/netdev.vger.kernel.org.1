Return-Path: <netdev+bounces-135542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6799E3E4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F4F281F15
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D51E7663;
	Tue, 15 Oct 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Qpdu1U03"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145C1E5717
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988223; cv=fail; b=KQDmgXXvubCa8mLVtAPP6TDtDb+cypM2Xq+EcS2d1JdM+V/TxUoKq0iKnwChDOzggYkhk3fSrkIMJo9m6tZ8TZ0L8s5RoIbnrymJxBIE7JFDuppcZZvFeI+rwIp9zcpqL5advV4aEkKm/opmh9b1835oeyXA2DW9uNSexrl+508=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988223; c=relaxed/simple;
	bh=4j5SJ5HYuPel2Dv+IBBWRsO/17dTAoza3QBOY2Scc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P79fHl1iIrQZOQ9S5ny5N/rkcM4facFgSrMN0sFNS0C93w9QW4fxUH91WqWXU1sylTWSeOyDNn23Sh5T7jheFYo3VDAgrqaIf3IkKuAYJQ7eY8sg/HNDxlaydtXVnQKL/64p4Byq4R8UYpdnnnZ8Tp7cbbXgIr6Um0f2TTgCHaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Qpdu1U03; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfH7Pa+9l8wC8c4h0m5BLkc17z9w+XzkspnQUutYbpBS1o519YntzgiOj6J2fup4HRMGuztrvv1pu/rL+F1pypJ+FW9eRQIYpsCbynK6SfW+i0CZNcQr+s3pVwg37SgtSqUmWaSOqOjuxbLmlzUED0f5yh59yex5a0KisbQ5C52QKdGB7LjNycbVemg0whidEeItJ17VQNvAy6wgLmtcs5myXtTwB5jfMmu5k/LDAk1kJacI+td9fb4Pf4p3acjcEKBB3GKVAe8msx9cfy0MvG/jtfw04IplFRaLz2QQIZNnSpkCC1pAV14DW9aiJM9I5DEgK7NEPrqycU8pdEzWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=NNI0qboxQCmPv5HLrSlNFwHufy741TCAAFyMv5KpgVHx3nDvcSSAl2VdGFxYsmb0RCOqxIlo2jzCVfyk479FGA8CpL+rHkGZGymGJsFdlgFoXI5ORDVXoduhtLIXjAi38iMHhihcesQGcms+IHwIMNxm56tGFopLD4VrJu3uLwDs23mHj1mtUo4X9eIURiShuPzG6FC9TxienTfBPemhCZ7LuT5nY9yxIo3ylc83MKy/jPOL/47uY+g7iZfHU/vwSm4WORno3zcVZDXDLQGezqsCJSBBIBPQq/8bPjcWdf8y+jDMo7JFxpPCVfuf3hCBfIYnyXYsSOFOTxLpIZ0XQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=Qpdu1U03EsVukVnVJHlx1wMfm+x62qvMVEhZPdYb2R2pYj4MYmn0H49K8rmSJg8ML6RSyZtmAcK60ooRGGW37JJLk/QdgagfrkXV3R7ftG0k9hA8xItasS8fMLtbiwhKhHu+vY9AkBvTqfq30syEkIaPn+zF8cRGvttGb1UfP/89gMshCWlso3vIljsG07cEU5ABC8z5Ds7gpT2HGadSDmWpdkL3zVyFLvSnGEt/Jtga6tQga+lL+jDKI6PZvsVMiiX47w3TaJjsmqnp3vCzf1MrfFoD0I3icvJyGJBUd+WL4fz9hCLbnsVazOr1VAIrdwKMl9BNDmTNfTIqAj+3cQ==
Received: from DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) by AM8PR07MB7666.eurprd07.prod.outlook.com
 (2603:10a6:20b:240::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 15 Oct
 2024 10:30:18 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::97) by DU7PR01CA0021.outlook.office365.com
 (2603:10a6:10:50f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
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
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnE029578;
	Tue, 15 Oct 2024 10:30:17 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 10/44] gro: prevent ACE field corruption & better AccECN handling
Date: Tue, 15 Oct 2024 12:29:06 +0200
Message-Id: <20241015102940.26157-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|AM8PR07MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f9ad40-b87f-46a7-05a9-08dced045da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0JyU294RGJHSDVlWGdVQ3FUY1N5anFUQ0txRngwaUlBVVlyczRMb05ITmty?=
 =?utf-8?B?MWZZKzFqUDR1Rlh3NHV5U2ZvVWtMM2ZNREcrMG5EOHd5ZHFwQ05tbVNLZ0pZ?=
 =?utf-8?B?Tjlyc0grY3U4eC9KTGdWNGxUL3ptbEJJRG1leGZjNXJQZmE0NDZsYmluNlA0?=
 =?utf-8?B?dXRBRTE2ekdUNW56QVpIMDlTSmdrakJqUVg3MFlmR3ZGeGF5UExnMGJRUmt2?=
 =?utf-8?B?Q2tKYThPNlRsZW5BKzlSNUMyenNKQTFPWS9kZVMrK0hzajJDRlBHM3FSWHJ3?=
 =?utf-8?B?QTlxUHJBcGpNVzZEcmVoeEN4OXZnZ2s1K3BJWGxtQnAyT2N0N2d2bStNeDFr?=
 =?utf-8?B?cVlkcmE1aWovOWJaSHFNbUVvSEp4ZHkwTUNISStGRE5YVkdkN0wrWTd5Rk8v?=
 =?utf-8?B?ZXJlazZQMkZ4V1dNKzF5NFlWMTloa0RwNHhsTGNKaTdiMmFvTktYemRoeEow?=
 =?utf-8?B?WGtseitWeVRiVmxHUExzM2N1RFJrbDN3VGdRbjdGemdpdklITjk2UjdZS204?=
 =?utf-8?B?WmYzL2xTdXFraGR1VitQZHZUWTF2SFlvTkpoa2RTU1N2b3RjOXlZTzhpVlFI?=
 =?utf-8?B?STFwdmN0Vkl1YkhkRmZZSHVjTXJoZFJhSnVjUHY4SlBmTFl2bHBrZzFpS0g1?=
 =?utf-8?B?d1NqaUdhTldUaTEzaUFMUC96V0NBQkZjWWp0Mm5wNmc2VG9PeXliM21SZG5O?=
 =?utf-8?B?RzI5Y0JqMmNyK3R0ZkpFazFQcm1aeTVGNGhGYlBRVWV5REpqeTRFUi8yWXR1?=
 =?utf-8?B?cG5UMWZuemdiVHoxUGFBdkhVVVdVamVNNEtOM09xeWxYZE5FZmpOWVFYQlRI?=
 =?utf-8?B?NUxUdVFkRWEvWHUwWXRpMGsyWW5yR3hxTjRZeVo0dzR3UW9VNEtqZXYwUVc1?=
 =?utf-8?B?c3FoeURmZ1lFd0hqQTVEN1RhMEJ2amsyZGJ1N2hHRExUdXRHN2VpemovamNN?=
 =?utf-8?B?Vy9FaGZURTdYRmYrenExODFyMHVrTk5LbXRya0dOQnBTLytOcHE1VVA3Tlhn?=
 =?utf-8?B?VWRmK0NWNFdEUkpzRWxRelpjVGVGVDQrRS84ZExXejEvL29nb3RLcEJ5dnZR?=
 =?utf-8?B?MFlXYlR6UXQ2NmtYNjFQTnlqYm9WaFZTT0prTGNsUzdKbER5SjlGZVJXRWNS?=
 =?utf-8?B?aVBQcWluRHBpK2s5bEoxY0VaeGt3cnNCVTdpQ2hWYW5ZR0QvdTUvQStXdGE5?=
 =?utf-8?B?amlCUUd0UEVPY3FVNXNqTm5NTUhrM1JFMy9uZFlhdHozUElYVHo4VTFmQjA2?=
 =?utf-8?B?NVpaZ1V1ZDVQWFFBdStsYzRiYW56dzNBZnk1OUlKRmJxNG9XYUoyVHJvL2ts?=
 =?utf-8?B?QWFISys5UjYyT1lyOVdwMllHU1E5WGN5bUJaWmRQSmhLTjdDWG12dC9wclpJ?=
 =?utf-8?B?TkVUdDc2K1QxZERESUROUTFnKzUyRTE2NlZHbjBBR1FqZ1UzNU5hcXhIYTFm?=
 =?utf-8?B?U1VVVVQ5WEsxclpTb3BBYUh6T2R1UzIzMVZWSHY1M0NUb3N6MTdCa3ZVSXRi?=
 =?utf-8?B?TlNGeUNzdGtxT1VLOWs5TmlzUUpaOGExQnBCYWdBRlQ1RFZkdi9WWmlraFE4?=
 =?utf-8?B?ZXk3M2w0Z1N2eW0vS3NSWEVnM2k0WjhsQUJab0VmcC9nQVBSUFkwdjNsYnZL?=
 =?utf-8?B?OUorM1lPL0tpdHdmbVBGRml0UGVmQTQ5OFFObE5EZWZSczJadFVpNDJaMzB3?=
 =?utf-8?B?eDJQNEFxQ2FDQkg3SWZuUHgrQ1Z5eHR4R2tmV3k2SXcrb29rNkNLQ3FiWmtR?=
 =?utf-8?B?OVQrbkNKZ001dzRoTWxocXM2Tll3OFBKa0NlOEEyTVFSTHV6Wlk0bHhZblVZ?=
 =?utf-8?B?VzlEL2FLR2tqd1ZxQXN4UlA1MEh4ZlY4QWVDTk4veEdOOXhsZXlnUlBEWGZK?=
 =?utf-8?Q?w16imJ7nUBbJA?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:18.5059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f9ad40-b87f-46a7-05a9-08dced045da9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7666

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


