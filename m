Return-Path: <netdev+bounces-135547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC2B99E3E9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F352A1F23AA7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01531EABC3;
	Tue, 15 Oct 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dN/jdCtv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EC1E7669
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988225; cv=fail; b=OFkj85hqm/i4yGgPZJY/oY0NiE+gZSZ3RVbmMlZqxkh60EQZT5mCeQpWHrUJo1kXorRIkTE/BypTlY1ax8XjA6TFYKe2shL9YklfJfLnXpkYuYZ66JmNr1AKsuZbome/96JZG6bSv0vJA3KZyANQWptSCyK0N+r992JAx4aLMPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988225; c=relaxed/simple;
	bh=6Sx9qBTCTxY479UCAsx2LMSyVr7Qe8WzgVDxPDrhidc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3PaxsnPDVHorHaBnhS6v6d3s5zR0fu7+Y9n0+GQHA0A1J7Nfd45a0r9dBArsT2L7o0cZZJ9s/sQq30fgHXUnuGOinmG7hQjAvxgj8CgUR5TiGPJcyqqgRnaojjv/2nNI+NubDZYovWW+yO8GdrnN6bXFmZNNyyaWyjH68rTB1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dN/jdCtv; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWLJZaINH/gJwgpRdUgrRsbk8SUHk+iSguMpGZpCBkzhAAlEWcB7hBzxaJW1xPuO2nulolFXyO3g1mht6BH086SVomG0zkS1apN1Z1nwHwf2j8MbkmT3efmeWtdPiLvR+dGnKVgdOz+Xwd0UEQzhUqlkaQHTtvPvG78XbjCGJU3+rW2cNw7tUnUsmh2b7OnGi5lwsuVpVqxGlPCZLbZq0YBt3VndU9rMWp012DzJvUhAqna4Ge/M6J7DcRQqJrgESjQ3qy6qjG6Rqm4H1NmzGBAKdsVHCYkpKA4tm4mQ/I+8bmbnZmpv6N39OAQm+vIAGse6gA8Uxvn5ttB+E9jssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv0Ov8Ang6Utb31hNCUR9cNxCKHwSBMvKHA6lzQZylw=;
 b=gO4b3qwwxskOuTx4Tl10rixKqP05mS62UxFTHS8Ja31eHmW2ztYMsQ5mKBeXa02TXFnXf8YIh6czdb9ZkTBjgHeypPLApTsW6JpgVlgfsu2ad5kcoomjLavgZRoQhdLYBPughpCUeWy8iA/r4OZNFMugiQ68VhmMrX1L4zCQ9DhC953p8I856XPKWr4YiN/T7Y3Gs0GHIEJdkp8Ao7UwMYiJFRvWKX9vVUMtCEHcK+lUYJ0ktz8iO9XsJVpNSbgRC93HVbipI1X1D9fDH1DoHLxOuw4ehPSHQd6addWp/DgXIuw5Vfu0hayaYw4tSh631YrsXu3lio2eVL0jpOwc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv0Ov8Ang6Utb31hNCUR9cNxCKHwSBMvKHA6lzQZylw=;
 b=dN/jdCtvAcDy+2PTIPcv2cThYeFlaPMVlqWkokAsn0+uKEg7rXgKzUDRf9DGTn89QY5fsFfTR5WrLTY5J+XnGJPGHk43YZACVogeTnL2A7DiOJsuE4H65AAunc3uFV8jHexROJjfTO5/OFmlENMRtXxHeIQghxH20fZbSzRaSlVAGrNtyviqTGSiqPhicxAuWDc/1UL5VZ34m/7srbfnKvO8yHOk8Z8xWN3N4vQlVJw9tYNZ7E5PhNp96VrSYlYdVAfPOx9EgLB5NGGyZPIo6YKbGmfo8YqlCTodrh1cm6odfJaaSN3s0B9cFsfQmo44I6F0U+UHAPH6PiZMMpUqdg==
Received: from DBBPR09CA0003.eurprd09.prod.outlook.com (2603:10a6:10:c0::15)
 by PR3PR07MB8067.eurprd07.prod.outlook.com (2603:10a6:102:14e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:18 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::86) by DBBPR09CA0003.outlook.office365.com
 (2603:10a6:10:c0::15) with Microsoft SMTP Server (version=TLS1_2,
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
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnD029578;
	Tue, 15 Oct 2024 10:30:17 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 09/44] gso: AccECN support
Date: Tue, 15 Oct 2024 12:29:05 +0200
Message-Id: <20241015102940.26157-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D08:EE_|PR3PR07MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 772f627a-c6d3-4c3c-6e83-08dced045d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHFTMmNOQXRkQ2FiT1hYbWh6NjlIYU1zYmpYeThCb0FqWEY0ajNPcWswNUdJ?=
 =?utf-8?B?SUc5ZWY0ZDhUWThKRkF0OCtNMFI0ek9Kd1pHY2dqQVFyV2lXV2N4V001SE9U?=
 =?utf-8?B?Vm5qTDhmQXoyN0djazNiNDhWZVBSeTJqWTNvbExuajBXUG9RWWg3T3BJV0l4?=
 =?utf-8?B?di9ER2NHLzNBOGE5czlCUDFvWC9DZDM1Vnd1UmQ2Y1ZnRUhLbU9TeEhVOW9D?=
 =?utf-8?B?U1RVQmViK244ZkVxcHYrckNjb3dRTGRKY2VkcytUc2xEY21zbkw3VlhKNUdU?=
 =?utf-8?B?alNPU1RXNSswdXNEdUIxVW1WU1d0UFRIRXVmSWhaUmRrZWZKUDBJR3Q3K205?=
 =?utf-8?B?QURUSGU1emVJMFhJNzBtalhMYjkzbkxrTnNPZEYyMDJKdmNtMHN1N09IUkx0?=
 =?utf-8?B?R2Y4c201NE5EbGM3WnM5M3BUY2hLeCthNDJlUXFrdGREWlcxL1ptZlVPWWw1?=
 =?utf-8?B?Z0lhTmtpaW5qcFJ6ekhhNzVHOFZYa2kvSzZSL20wRW5lbGhMTmpRa3doeWtn?=
 =?utf-8?B?cm5wMEpOa1N3NWFiS20rQU03VWJta0ZldzJHU0pYeEx3QjFVK1ZtSEpTVmph?=
 =?utf-8?B?cVRiOHlCS0FmV0NhUUpIMXp3NWpibzA5T1lTeHREcTJWajNhbWRSU0NUVEZ6?=
 =?utf-8?B?dXZIajk1TFlqdDNQRU15YXVQSVFRM0pCUVBzdmFMWUJmblM2MFU2YmJpMWZ4?=
 =?utf-8?B?MW54SG9QQUR1YjZyK3BqQ21Jc2UzaUFLNElEdmRUNEttckRHaDc1YjI4OHZJ?=
 =?utf-8?B?dm1PK0lHSnI3alRxRHBnaWpvVUEvdk9VWDZ1RzNhUVNLSEx3MDBnTXNadDRE?=
 =?utf-8?B?MjhiUkdSbE9kR0ZmdjhKZERqaFZNMjgraENMa3E3WXBSRGNSRXZJMUVtSmJW?=
 =?utf-8?B?WU1uRGlhMTNIVUttd3pOY3Evc3phbWNKeHg0cVBNMVpmT1dNOWJqT0tMd0dl?=
 =?utf-8?B?RnBvUTQ3UXF1di8vT2VKelU5ZGt3V2R3bTRvNUtzVTZXNFB6cENqZWE0TzZZ?=
 =?utf-8?B?QVYvSWlLWU02MXRYTlYxT1FqWFV0VTgxT1dXejF5K1Y2bGdyRlpYa1NPaDVV?=
 =?utf-8?B?YUViU1pONlNzeEhOZkVVYk5TdGdZOXdRclg0UUxyWW5sMzREUjhWWHBhLzFR?=
 =?utf-8?B?dzdkeWc4cG84R1JwOElrbjRsNlJxK0x3Rll0b3Y5di93Tk5PelVHVUNuS1Uz?=
 =?utf-8?B?NEhseWNiNFRhR3dNUU50YkZhQ1BzSGdxWmRJSGdaR0xTMW0wb0gwbXRHRG1q?=
 =?utf-8?B?azRZVkFrS3B5Y1Jjei9WZ2gyMnBCVUZ3R2NxVVZUd1BNWHpMbTMxY0dmUDJF?=
 =?utf-8?B?NktqdStzbVJTZnR6Vjc3OXFDMkN4a0ViRHFzUEVrV24vekhTem5HV2U2OTI5?=
 =?utf-8?B?bEtxaTIxUnZnaEZnMEZNbHYxVkJLNGdLRW41OXVqbHhOaWEzc09obngycDVu?=
 =?utf-8?B?WDJPYlNTYTU0TVZjNVhGZkp4MnBPL0NUU1JEdTl4blkwemJ0ZEc5UllQVG9h?=
 =?utf-8?B?cVZrQXdrNXJZZHp2VHRNR3lpb0pTeG00RjlTUnNSaEdjU1h3RkZwcTc3RDZU?=
 =?utf-8?B?ajJVVFQvSXB0bjFHSlQvaXR2cmpxNEQyc2ViOFVUQjVJYytGN25tUDNyQ3k1?=
 =?utf-8?B?UlNjazNKbkJkdXYyekh5K2lmTVNlWjQwbklYZmpFSFVxMjdSL0tPTzFsakUx?=
 =?utf-8?B?TEJPYVhPQXA5eFl2YzM1L2prVStjd05FbXFlandzU0ozSEx5N2F6bFV6RnhI?=
 =?utf-8?B?ZEw2SXVDTDJKS1BHNG5ZK0FaSjNzM3A3Y1N3OENSOXovUzZ2ZFFab05hVk9z?=
 =?utf-8?B?a1haL3hIMU1TQm02SFRtRUw1cW1TMytFdXJ0c3lXb1l3enAvZkdrQlZyQm1O?=
 =?utf-8?Q?sJ0AK+ke2BgHp?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:17.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772f627a-c6d3-4c3c-6e83-08dced045d55
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8067

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
index 66e7d26b70a4..2419045e0ffd 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -53,6 +53,7 @@ enum {
 	NETIF_F_GSO_UDP_BIT,		/* ... UFO, deprecated except tuntap */
 	NETIF_F_GSO_UDP_L4_BIT,		/* ... UDP payload GSO (not UFO) */
 	NETIF_F_GSO_FRAGLIST_BIT,		/* ... Fraglist GSO */
+	NETIF_F_GSO_ACCECN_BIT,		/* TCP AccECN with TSO (no CWR clearing) */
 	/**/NETIF_F_GSO_LAST =		/* last bit, see GSO_MASK */
 		NETIF_F_GSO_FRAGLIST_BIT,
 
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
index dd345efa114b..75625098df07 100644
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


