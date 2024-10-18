Return-Path: <netdev+bounces-136820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112949A32A7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47FF28151F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE616F282;
	Fri, 18 Oct 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ss3yofIi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69C13D881
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218129; cv=fail; b=LSnTv15SN5awgGHyFx/pLahwLboJdW5GGxc8G4dY4BsuGVHej6nSUf2LgBApmNUhG+ZVbAJO1RnNdAzb1dh6l4wIrowMa9Yqe2FWCwXN6Go2Gh76tDPC5wGBEAnj8DCHM/OrXo6mFpGWVucGwiMYmG2FsN6ld35Tk+CK9X6paMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218129; c=relaxed/simple;
	bh=zPyqJSmykKGxVlXqNbDC7sq7/jg2l/W5i3zHisFYLm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCxWngKVvEApmwuFr6u62vmYNhPHcXW4YKf+fvR8PhNvLvGyeBT0iNEH+PIXThQhD8ClSr8tk5HTDIOxSxuzyIE749OxBPrJPMCdWV7KHGAM6agchHAfjvJG2OVOB4iZ42Vm2L3cS42CcXoN/HOJFsV/Vu6xhIsQOtb2ff4/HK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ss3yofIi; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czegHM1LoiYep/SVeP2ovcz0tauh4fRlToImWRGowjb7wqs9BS/0+bKDU/T1OQhRlC1lI/xAhgooyUVVP/YlRyiaceBRWA5gQqOHtNkqJ2E+FQZy1Chqzj2vMTn65ER0ToZh2lLkJRKXdcZlTtQzdfJGxrtcXxqPnlZFmQvprvdoQ4y0Zw0Le/JO60PM512nBMo2BDfs/sesiXsuGqqIhxjALyHp5vj9Dyp71PO+azyOKLQdFIaKCUrP+UfOyFu2EB25PkGoEmAC66ovhMalO87IeM6UPmQQa0DFG/tgJNoanWsO8j0CXbWOJ+oVQ3Bcs1Zg2/gclVM+xjcKNHJPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/rwYzg9Wa7jAKkiVSMK+egxlBXHIwgOLcSY6jRntrA=;
 b=dGWJ09Q1UQnomn4BMTilvhm5dsiU3n639b1JhoOhCVlPoQF5LJceJHW3hykDas/E80vkHNPML+yRwe2T+M8s2rMu10k9X6tStYUU5cE2yPlXXUrWtipyBtGhNWFapIsWkHgKbU9ETU2zqNsvt0uq1H5zKInNCp++YlMm0N9/H97QcHpjnh8Kps/zIfPQZspH52mEUU0jYX4PnjXybsPGlCuarGYGZguT1R+NJKyrODvcOEqFUEFIrTuOAMsmixhI9J5nplp87ndT+3/yau6kGAi353ZSogtCqLdmed9Kor31dg9NNs3BzKjTM8hpdSVgbJmsAKE3ZXJx/qas5hugRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/rwYzg9Wa7jAKkiVSMK+egxlBXHIwgOLcSY6jRntrA=;
 b=ss3yofIiIKaD49SDCVJ4DUl3PSZcG63FD3CRMyCLpUSZ+b3PKPwvghzFtKAtZXKiBARkS1uoPq4+BiNnmKRioWsWW+26p7EP9FhHK0nNIpEJykHmrab6n1AxKaEKUR7cizHOwffiVAKjxuW0O0f9HiBKGTL87q660FjbiPH9PrCsGLIgbi8hTASuJ+o61ilvObu3aECpVrXjW5sSN+m822Bd4H7wsM6DFEPlBrykH92tySDKG+IRFjoR8cyibHy7bRSbFDC7AolTnKT8oMMAXc+BsKZN9Ng6cONdgmDIRCUn9PTlBv8rzTeWcW+7TiX/bjHDkPs2EhB/LGYaXu8CvA==
Received: from DB7PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:36::15)
 by AM7PR07MB6561.eurprd07.prod.outlook.com (2603:10a6:20b:1a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 02:22:03 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::ea) by DB7PR05CA0002.outlook.office365.com
 (2603:10a6:10:36::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Mc023685;
	Fri, 18 Oct 2024 02:22:01 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 08/14] gso: AccECN support
Date: Fri, 18 Oct 2024 04:20:45 +0200
Message-Id: <20241018022051.39966-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|AM7PR07MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf49738-62ff-4eea-87b8-08dcef1ba771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V21zVkdQempjNmVtclZnWUhDYWFseGNmbWxEQW51eEpNb09QVUNkUkl3NXJN?=
 =?utf-8?B?YVFZQmo4Y2ErbVpJQW42ZDFqYndtc01nS3ozckJoQkwrRUxKbGxVL3JZQ1Qv?=
 =?utf-8?B?STZjN2doMHRpMHpRY2R1OUM1OVJzbVVPbGovODVvc0NVSERQOERaOVhrSEl5?=
 =?utf-8?B?bnBMZDlNV1loQkRYVHV5T3JOQWM5cG45SWR0b3U2WFQvR28zblIwcmtMd2Vj?=
 =?utf-8?B?OEVKblpiOTNxVWdQMEFnalBrVnl3clVLbWVqUEZCalRWNVlQSFZXaUtzZGdu?=
 =?utf-8?B?aTFhYjBmUzFIZk85a2F6cjdGUGIxSUIrYkgwaGxBOThldHNQYXBUM1pmQnox?=
 =?utf-8?B?QW5ZQ0tZQkFyRUxUN2RSaXJPQmN5NVd5ZFpoL0IvTDhEc0tlekEzOXVxWC9x?=
 =?utf-8?B?ZElrS3NMb29QMGVwSWlkWFJkRWd4T25lbmNhK3JKNWJrVW9qNnR5WXlvcTh2?=
 =?utf-8?B?QUY5NWQzSERvNlMxMnB4MXA2bmFtZVl6SHZvdEVEUDd1NmE5alBiMzM0VUoz?=
 =?utf-8?B?bTMvWDVUa1V2NGJiWnNwS0ZpT05LRU5obHVVUGxiVHRpVU1wTTJkMVAxZTFj?=
 =?utf-8?B?TUw2bzBpZGw0YWJ0OW1uMmd4QjdKRFcwSElhMWE0MmVIZXFyV1RJV1pkWDFq?=
 =?utf-8?B?SlE2c25OUVczbUpSSWoyVk5aTU1zN3FlVUgrMlRabTRPTDRaV0hmWWs1eFhE?=
 =?utf-8?B?eXBhaUF4UXBwNnBTYnhsVEdrUkVwUlhJeWNMY1ZPR0xhZDRXcFNYbjk1d0Jk?=
 =?utf-8?B?NGdpN25PQmZEZVBxVWs1U2UvS1JDNVU0RXNaQlB5NW8vVE1Ocm4weE5HMmR3?=
 =?utf-8?B?R2QxMnFVdjVJdUpsUWpqb2szTGRDbFpTZWNnOXFqOEtjSExnUUZOR0lUZmxD?=
 =?utf-8?B?NVg5OTBVMzcvVE1JWXZHTU9JVVVUak5Ba0Q0T2pOZ0dVNFR1UTJSRG5qQVdr?=
 =?utf-8?B?MDQyTEJpQm1QNlVVcUY5MFFNVUd5cDEwOE5hM1dXOWkwL2EraWl2QjMxR3Zl?=
 =?utf-8?B?K2RpVGkwa21MUWIyZ3hrbTE2MHFRSTNtMU9tOU1POXFpRSsrNHU4K3lyUUh1?=
 =?utf-8?B?bEpDSDdxWnZwUWhmc0lVQlZ5MXFYWTUxRzlVdEtsaWtza3FVWkNpc0hlZlZP?=
 =?utf-8?B?MDl0a2RTR2dIR2dFWnlqWjE1eWd2YnhQdWZ0Q2dZenpsV0NGVXhyS1UvWHR2?=
 =?utf-8?B?V25zWHR0aGZCemtQQitrdUk5NTVZTVZkN2t4cWxkbmhQVUtCUlVGNHZocS8w?=
 =?utf-8?B?YlVTVXpkZUovbFJ4UXVlTlJPVFp0WHlWekhPejQ1UTgzZUhickY2TVNaTElJ?=
 =?utf-8?B?Wk9VdEtVYTY0QStiUFpXdTJmZjkxZ1lRNmh2MVd5NXowMnpEdkF2dHEvcWdE?=
 =?utf-8?B?TVh1TG0xdjFXcW4rS05VY0ljcnRoWE1SWUdoNEs2bTgzTndvLzZoOXVRVmRQ?=
 =?utf-8?B?N24xSDBqbE9MSGIzK21qY1dTcjFBZUhwOGR3cGs3aUZVSEgwajlvelFmNlN2?=
 =?utf-8?B?bGFKMVpESTJlVUdqWndJaDZwRDBpSmFaUnlBd1ZDUkh5akJZR2pHbnB4bExF?=
 =?utf-8?B?clFoMmdWSW5WVU9rUjh2TkIwZ1dXUW5zY3doYkhKUEQ1RWVndElBY3YrSXBX?=
 =?utf-8?B?dlIyeWVydDFqbGVvMCt3ZlhiaUhqRFdFWnhldDZJREVoWG14b04xQy9BbTVR?=
 =?utf-8?B?YUk3V3NpcFBJeFIzckorOHRqSWU2bnlDamFFQ0IySlV5TTBYZ1Ria0dGWnF3?=
 =?utf-8?B?aFZKK1NoR1hJenMrVGpWaTIwTXBSZ2pTSjVnd2l2Wm9HcWR3Wi9iYTJtU0tK?=
 =?utf-8?B?Q0o3QUg5aEgxbGRTVHFwZS9zUmdOcW15Z1g1Q3lzanRhKzdseW1sVmwrTkVW?=
 =?utf-8?B?QU9QbTVkRVE2UUpnem81VnQwOHNGZVZuM0dlUk5TOHNlR1Nob2dXcTEydHJh?=
 =?utf-8?Q?WvyzdgaGVvs=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:03.0439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf49738-62ff-4eea-87b8-08dcef1ba771
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6561

From: Ilpo Järvinen <ij@kernel.org>

Handling the CWR flag differs between RFC 3168 ECN and AccECN.
With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
starting from 2nd segment which is incompatible how AccECN handles
the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
With AccECN, CWR flag (or more accurately, the ACE field that also
includes ECE & AE flags) changes only when new packet(s) with CE
mark arrives so the flag should not be changed within a super-skb.
The new skb/feature flags are necessary to prevent such TSO engines
corrupting AccECN ACE counters by clearing the CWR flag (if the
CWR handling feature cannot be turned off).

If NIC is completely unaware of RFC3168 ECN (doesn't support
NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
with AccECN on such NIC. This should be evaluated per NIC basis
(not done in this patch series for any NICs).

For the cases, where TSO cannot keep its hands off the CWR flag,
a GSO fallback is provided by this patch.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/netdev_features.h | 5 ++++-
 include/linux/netdevice.h       | 1 +
 include/linux/skbuff.h          | 2 ++
 net/ethtool/common.c            | 1 +
 net/ipv4/tcp_offload.c          | 6 +++++-
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 66e7d26b70a4..d26e9a22dfb5 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -34,6 +34,7 @@ enum {
 		= NETIF_F_GSO_SHIFT,
 	NETIF_F_GSO_ROBUST_BIT,		/* ... ->SKB_GSO_DODGY */
 	NETIF_F_TSO_ECN_BIT,		/* ... TCP ECN support */
+	NETIF_F_GSO_ACCECN_BIT,         /* TCP AccECN with TSO (no CWR clearing) */
 	NETIF_F_TSO_MANGLEID_BIT,	/* ... IPV4 ID mangling allowed */
 	NETIF_F_TSO6_BIT,		/* ... TCPv6 segmentation */
 	NETIF_F_FSO_BIT,		/* ... FCoE segmentation */
@@ -128,6 +129,7 @@ enum {
 #define NETIF_F_SG		__NETIF_F(SG)
 #define NETIF_F_TSO6		__NETIF_F(TSO6)
 #define NETIF_F_TSO_ECN		__NETIF_F(TSO_ECN)
+#define NETIF_F_GSO_ACCECN	__NETIF_F(GSO_ACCECN)
 #define NETIF_F_TSO		__NETIF_F(TSO)
 #define NETIF_F_VLAN_CHALLENGED	__NETIF_F(VLAN_CHALLENGED)
 #define NETIF_F_RXFCS		__NETIF_F(RXFCS)
@@ -210,7 +212,8 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
 /* List of features with software fallbacks. */
-#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
+#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | \
+				 NETIF_F_GSO_ACCECN | NETIF_F_GSO_SCTP | \
 				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
 
 /*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bdd7d6262112..92fb65090ee7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5067,6 +5067,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 	BUILD_BUG_ON(SKB_GSO_UDP != (NETIF_F_GSO_UDP >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_UDP_L4 != (NETIF_F_GSO_UDP_L4 >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_FRAGLIST != (NETIF_F_GSO_FRAGLIST >> NETIF_F_GSO_SHIFT));
+	BUILD_BUG_ON(SKB_GSO_TCP_ACCECN != (NETIF_F_GSO_ACCECN >> NETIF_F_GSO_SHIFT));
 
 	return (features & feature) == feature;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13..530cb325fb86 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -694,6 +694,8 @@ enum {
 	SKB_GSO_UDP_L4 = 1 << 17,
 
 	SKB_GSO_FRAGLIST = 1 << 18,
+
+	SKB_GSO_TCP_ACCECN = 1 << 19,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0d62363dbd9d..5c3ba2dfaa74 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -32,6 +32,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_TSO_BIT] =              "tx-tcp-segmentation",
 	[NETIF_F_GSO_ROBUST_BIT] =       "tx-gso-robust",
 	[NETIF_F_TSO_ECN_BIT] =          "tx-tcp-ecn-segmentation",
+	[NETIF_F_GSO_ACCECN_BIT] =	 "tx-tcp-accecn-segmentation",
 	[NETIF_F_TSO_MANGLEID_BIT] =	 "tx-tcp-mangleid-segmentation",
 	[NETIF_F_TSO6_BIT] =             "tx-tcp6-segmentation",
 	[NETIF_F_FSO_BIT] =              "tx-fcoe-segmentation",
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..0b05f30e9e5f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -139,6 +139,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	struct sk_buff *gso_skb = skb;
 	__sum16 newcheck;
 	bool ooo_okay, copy_destructor;
+	bool ecn_cwr_mask;
 	__wsum delta;
 
 	th = tcp_hdr(skb);
@@ -198,6 +199,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
+	ecn_cwr_mask = !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_ACCECN);
+
 	while (skb->next) {
 		th->fin = th->psh = 0;
 		th->check = newcheck;
@@ -217,7 +220,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 		th = tcp_hdr(skb);
 
 		th->seq = htonl(seq);
-		th->cwr = 0;
+
+		th->cwr &= ecn_cwr_mask;
 	}
 
 	/* Following permits TCP Small Queues to work well with GSO :
-- 
2.34.1


