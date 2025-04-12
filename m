Return-Path: <netdev+bounces-181896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600FAA86D3E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4137B688C
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39071E7C2B;
	Sat, 12 Apr 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B1AnGHPH"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011033.outbound.protection.outlook.com [52.103.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065672B9BF;
	Sat, 12 Apr 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463798; cv=fail; b=F/SNrFFggByO0ZCpVqCOA+bwIuLtWWoD4FT9IRaOTIrdmVT1aZleqXW/9fVyLp7K+2k3GLnRusRRwVbOerMF796KlPMXRbDo5rfgDhROgLBl/Fq7pdao0R3l4Dwl/TDZfXIS9h208IonNdWebx4lV5g9AArGDCy+5ug9D65eG9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463798; c=relaxed/simple;
	bh=CpS9ArjXOOzxqn3KEHg0E6ZhxaB2nyswywN9V9eU9G0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iXIdjM/UNWuAM10ef+Bnl/EmZ6CweGlneatoJPGah2qdlwNuwC2DRLklDDl7ypxHa+hFz9fJU2xx62ogSFd+9ualSYD4vNq1Oml894wpP5q4fOBSt3MRCqlhJcKBBIYrvAiFsbpCJgmKHLh6+PpyFgRBhZON9mw1Xv+dfQ4AdSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B1AnGHPH; arc=fail smtp.client-ip=52.103.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP86p0HAxHZJAj+1fNm6hU1CxVWDZ9G4hJhiOLk1yHv1bq+K2bkxEyFLbzWvt9MoRIhLi15MWWdojVPpN+Fn5ndIWYYe5VNqkhdUXzlRTkNA415G+zLqaeour991K4fvYa5wYhzkGkPMGBf4gFsHdq5Hxwa3rq2ATsOAqdWFhjPVBtG/9kVgTuUqAOcyYwWOEMH6KW25z2o9n6pMHtcQkifMAT+ErNdTjYlYy7dorsWSVyRlFDDvyIdJnAJBXZr0+PRyHXWulfWX/ZJk9W8DmkdfWj9a79+Cqk5eJX8NgQ3wBEyHMWvCrk5dU0U09WS4PrTHaiQpmlaae98eeKw8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpSyx1UQVXHnC6eOsnSOskF2c5N3/h82Uodua0YGWnc=;
 b=efT6P3EYGL6DRxundmffK8EJSGAltAaTjetBzcpkTadTVz4R2RWbqXM9ee4XiVnqMWx1U1ZmUVVfo16D0sYgRmpLG/ql6xBcEqP/31mZDY1TV3t7YND2H2yehBNvAibNYXJqxRXpyeoLHnILSFuJgRru2FJAV8mckiMiwRD8a92eqzcY/XHdREU8TXJLQ2lNVBzexljzZNYL3PsshE805pYBAL/PEtrIEewSRM01JRmC4CrugO4gcqttpiPBonltxHbFh0SACxWMPfmB7JzysXdv9swUJ+o5ePQ/72zK1apH+NfU4yQhfuL7Jiap7sjyN3zbCyUFJ57BqXVf6YcjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpSyx1UQVXHnC6eOsnSOskF2c5N3/h82Uodua0YGWnc=;
 b=B1AnGHPHSM2aeLIIM2ovH2D1IxlJ7BCQ0mxrVP4SEXocrEnrK+bYj7a3dmkIdpbFphCYJhCXAQRwBA8DmUVjcrLbi2GHFHk/n3bTRkqFQTCCuL98RNdpUameos7QSAn0svtzeqrsVPUuirkCNuQCkzqRGtxiyL8rPIST9SaEZ3X4GaBrwhup0Ao3VHdJTbJ/5DW7eMTj08bXN9w47fL/2X+qgobg219gMOOokyGAleJUE2dCRPVtbE0dkmStG3sN6vqrywusNnxSoJI+OwkDNVhgx0QwNu5LVnXeLQJ9CWIXUL4g9GkJRF6yoOEB60KRicM43rvNN3gX3AWWtQF7MQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS7PR01MB11855.jpnprd01.prod.outlook.com (2603:1096:604:244::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Sat, 12 Apr
 2025 13:16:29 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8606.033; Sat, 12 Apr 2025
 13:16:29 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH net-next v2] net: bridge: locally receive all multicast packets if IFF_ALLMULTI is set
Date: Sat, 12 Apr 2025 21:16:13 +0800
Message-ID:
 <TYCPR01MB84378490F19C7BE975037B1698B12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250412131614.56407-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS7PR01MB11855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6758a2b6-c424-4ef2-6d46-08dd79c43c41
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5062599005|5072599009|461199028|8060799006|19110799003|7092599003|3412199025|440099028|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnoXuvOKK99YcYJo7CtCGsF/os/FBXEsoCjpfPmlwkdE+gcA0BkJPnfEcScU?=
 =?us-ascii?Q?pQTirL5C2Rb/JrHufeHdMCyJU7U/V3NavEwLJcLT2wkz8bjqauo+Fuz0DSvp?=
 =?us-ascii?Q?i9HQIv8oYnHQ9sIw1RgWGOgfYeks6f6UUe7Pjj3yoInkgC0QbwSdea/ZFrPI?=
 =?us-ascii?Q?wwaQI8G2zlz1FXSbaHH2U+kBt5in+Son7JvGrdgwbQNtMuT98KWL9BMmIxZ4?=
 =?us-ascii?Q?Bh4iJyoBXEi623mgRptdCkd0oZzh9cPRjTAjELpFCKU9bGHqliOilkiAlW41?=
 =?us-ascii?Q?59/geH3rHpC9/ZmaO4oDz0FM+baoqguTe3S+ZUud/SIxhF4VragHwexJ9ETB?=
 =?us-ascii?Q?71kaoLdX8yFdiWorAk47m2FkMGrpSxTzs5EYikah/n3/PYQxQ1vm5a2tIVVT?=
 =?us-ascii?Q?9VSJYGXaMIiNE+CfJegsw3sVWp5eZJia88cErevhPV6G+hTZFGs4eQcdTTG2?=
 =?us-ascii?Q?m1FYYiG5bSpYX1Y6GnhJVcONOSS7Eh76TsWWYtuKiPvD4cT3+I7wwG6MOU4V?=
 =?us-ascii?Q?SKsgVkbTHsGInpKD86dJoyy4ZzbBBZESyJK4yuvCYyvX8lCbUD1OQOqYy/yI?=
 =?us-ascii?Q?uhLFvbzkkNFe8taqG92s0jJ6sEvquUFrXq8uCdDxEeruf9HwZqg5uKx08YQa?=
 =?us-ascii?Q?TJwJbHUTa5SS0t3XIMGXpLSzxCaCtz/aPPGaFkK9WJGKqSXN2AAeBbaabJmD?=
 =?us-ascii?Q?k2uzaUKhestGbibM8B83ni/7psNBK6SvHJTWPi+f3LmVEEgMjpQL3SivB7hD?=
 =?us-ascii?Q?mxQB8RTMyMMgPyepE9cmGreWKPoB4ugvVDhrIggrY5fdw43BcBIoynY2vldi?=
 =?us-ascii?Q?yP1VY9JyS7ltRMilqTBzJwk8nPg+g3pO1Q6mou+2lmCvnRFLu1XJe8WmuMYZ?=
 =?us-ascii?Q?o7zB7CBAN/HYq1O9vYYk+40jVU3FPSjaNeRFxMXd3UO54NFjeI02N36BcdDN?=
 =?us-ascii?Q?mMF5Ghfj6pJU9Gb1zFm+J7/kJHmVj7CSIskGRdsAtOsMhsWut+6Kdc/brWAV?=
 =?us-ascii?Q?ExUofyuSP5FaOxRntVzADWSDG2yzFv19cbAdzQKJfRX+DaY/gxnNE3Nmd5va?=
 =?us-ascii?Q?1PpjSKCFlP0D5MUSTrMhBoIkxEWb5GR5utsp/sTXFQPabeYfFPcCmW+wIR72?=
 =?us-ascii?Q?lLcxuE+rTO9ZC9pjwaNCJGYLZjR2YXbGQrVCW2qkJG3R82aWCLKRY+VMyazI?=
 =?us-ascii?Q?NZ4OUIcsJN5XuKIiLH3tzsid3XCJnOfWEJB5wg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEyM8yNxM8lINdwKT4FUo7W4y3zOC3BzadLjJIX64RwcJV9leaNd9Z3/N5TJ?=
 =?us-ascii?Q?XGbX/g/iIjST8Lc9RTnFX7+3U09BqD/uLaKy+CaVTZkw67/0zuXDodH6r95J?=
 =?us-ascii?Q?IoInfC4jHebbXEHbIxwIASZ+BTAWLvjJ5UMH17Q0UudmL0ZiXq00mibuiTHl?=
 =?us-ascii?Q?2jFwKlQHRIvwDVcvKeLW5c64+vPxap69AB/AMUg0nrdweIZg5NjH/W9Hzx+p?=
 =?us-ascii?Q?mYHV32dhwFk0vPhNPdccs3IJxSe5nDCD+KH0VZNfsfw7uYSmvJVzu+vsPst/?=
 =?us-ascii?Q?+Dlmfk2/WhE3OJrIH/3TcNyIlkCDSUgt9Rfw35BV6DJdl5Rp179mdNxaO0jg?=
 =?us-ascii?Q?qHCrih2uSfORZVtiFFwrrd+Cdl4jliYHFNBrMfTh1BGsvw3+0fUk6lMCY+L1?=
 =?us-ascii?Q?mvRoWhH/jOLN13eN/cl/Id+oPqhgOMJQcc7WYfFnuj8LibS/CuMjeMS88dBE?=
 =?us-ascii?Q?Yj5j8HM5rN0LTvKzQM4vRk3jLwZLWv0Zocu9BzHzZeTqROiav6qzudAFR3/2?=
 =?us-ascii?Q?C9a2icvELu6HESx81/UGYNz8QYFCILET8eLG3KDTfBaGNPnghXXInkKxIiRu?=
 =?us-ascii?Q?aEEkFIeHsg/hAH1LuuuCpUYjQF0IHCNbL3GMC1qidQpdwSM6BMD5XGyx0AAB?=
 =?us-ascii?Q?bGdMO8ehb+GOkUhViDPE48Ng63SUFmAuCeSQnyE+17Jw6vZhjrc+Reiv718C?=
 =?us-ascii?Q?+IY4cdZI2mvSEGVWxjDDL/Cqzk+QRFolsbthuSbdITCWC6LM20ydsv7F1fCl?=
 =?us-ascii?Q?hUTtGU3Hl1xMwL++bo2Y/cp1DAUBxiKpnAsOAyukWw1aVsYGywisY4z9f/yl?=
 =?us-ascii?Q?h50vHrD0Psqcz5lwjCmvrXiEmul3pEsp56msHBqscuBB4nxRvNN006AE9QsB?=
 =?us-ascii?Q?sYTImV0rzvRiOTi4upDs/3I9jvC1M6HMSJxwZew5Fi1pAzd8K9vO/IOkCAeQ?=
 =?us-ascii?Q?W6i55+RMqXY89uv2lOafsFYORYKjzoTQ4s+kUY95MTMi+aKiTMfkdf2ix7TU?=
 =?us-ascii?Q?4n2JOTpkU3Ib0Q8rzIRnQp5IV80So2bhj3IZamANJqyCDnVCU97tYBX3kd/2?=
 =?us-ascii?Q?xxOW4KX7G2zRNMc6uIieVtuue8+kMCegO0GG6t9Ot73EDwaTshxx/RJXV1FA?=
 =?us-ascii?Q?UI6WCwXbQXBlUd/S/xkIOEbip9eXC5sYUpODJhIN7RbFahFVVr0u8pMuM5ut?=
 =?us-ascii?Q?ADkGFu0zyASW7NK8zwTzEMr7ohqGKS6ZS9ys+XyNTLEYuUeO3vdKawVxh84N?=
 =?us-ascii?Q?wVRXxYain/1ct0ErhEI1EUqQ0R91U3zOMQMWkKVCmDM+Ke3WQbfv6HBToqZp?=
 =?us-ascii?Q?dqA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6758a2b6-c424-4ef2-6d46-08dd79c43c41
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 13:16:29.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11855

If multicast snooping is enabled, multicast packets may not always end up
on the local bridge interface, if the host is not a member of the multicast
group. Similar to how IFF_PROMISC allows all packets to be received
locally, let IFF_ALLMULTI allow all multicast packets to be received.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Since Felix didn't send v2 for this patch, I decided to do it by myself.

Changes since v1:
 - Move to net-next
 - Changed code according to Nikolay's advice
---
 net/bridge/br_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 232133a0fd21..aefcc3614373 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -189,7 +189,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
 			if ((mdst && mdst->host_joined) ||
-			    br_multicast_is_router(brmctx, skb)) {
+			    br_multicast_is_router(brmctx, skb) ||
+				(br->dev->flags & IFF_ALLMULTI)) {
 				local_rcv = true;
 				DEV_STATS_INC(br->dev, multicast);
 			}
-- 
2.43.0


