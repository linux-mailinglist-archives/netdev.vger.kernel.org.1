Return-Path: <netdev+bounces-99209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961668D41F0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73961C21A11
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEDF16EC1A;
	Wed, 29 May 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="nSDomSW1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2139.outbound.protection.outlook.com [40.107.212.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF91607AA
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024746; cv=fail; b=SvpXgyLsfVKPA0MMr52tusybOT0+ZCiNELRCu7ShHB8rusrUPpdNZtH4efFbPQ6Eg6djKLXJ4SIUsB6SMGeV4M0+bfshJ2vMfYVZS3fUIRPLqr4+6xlCAWNiTgxAtmY1IpvffROBnklDdehKGSd8LfWYw+69m2nIB9cq7f+xcKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024746; c=relaxed/simple;
	bh=O5Z6AdWLmo/IZqrAAqAzvrcimEorMI1kIYzS/MHgb6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vt11zvPrR8nBHZtQ+j+4S6VK/6jDno3YQ0nbrErzAec8YdRZRPh25NpnZEIvshi7h+mB6w8LR4crBL1tHk0JTMtLYhwG9eqiMXeaGzbOl6i4zFST8eWf1kU26bSetslBBwDQC5yJ5wBRGs1ZBazDo0vz6havM4CHJHYlkwmzCto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=nSDomSW1; arc=fail smtp.client-ip=40.107.212.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJRdY+VApvPqK+j0oiMKTEOp/TDWLiDOEbZR5Oi5wLo7LMWbTOUdMrKKZejo2BXVEAxuP+vy+zdQGYyp3wv7e+Ts5XUW7OWu6EEd9jVkXOkuIPI4eMq9DNn5efdRyBZoHw87h1ex4JhvOUWglwLdRFSAaj+lI/AlV+LzQWxMKen/KILpJ5HUVAD7D/TBy+Vl5aofEFKUk/7ceSDme0rl9IyqlwEEe+1Cyf6lDFGuFNp5bYYUefHCZWUg79vAB9VfdfvFFgt8EJAleG3lADlFnKMiZaOGP0G8S6njh59ncYEoVQuwiYqfya38rBhdyNAvIf3CUhJrVb8Ulq6ZN03Omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq1ZRoSk5sNoYiE7Ivm8FSXwGTy2d+ZtLW8YPjrg+CU=;
 b=bDbCQuM4bFTGOIL640x9YyolNOQTor7gq/fpLS99O/6CJTyzxaSijxkUzL0IzMCDadk58RaCMx/FzBWCTXI53W+gBD1OeU5IGZCJLWcmG+V+uixrF60jeP4twFdW2/MzEdR8cfSeV4FfhU5s9i6yOSHKQof4QyOhkBP/tYne4g/yQJWgW3i15UUbe20gafA8L5QO/7ZQjCy+EX16o0csv2JDPo5D02ehzKuNobmmSHScy6W4O3K3xftn/88oQfe0+qjSnnmR6G29Q9EMVUHO3nRQdZLchPmctE6PkrUxBCu/DftMxkNlICwzBEiOf18YGm4nUtqHUQ8ldZe4W5dmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq1ZRoSk5sNoYiE7Ivm8FSXwGTy2d+ZtLW8YPjrg+CU=;
 b=nSDomSW1oMLQj1SQbwksp1C+NXQKq6kclb++vj5mvZxaiHfC/O9k+1/x5fgSo3vgHmaoFq3MvfP1PsHaFQoUCeRvYjXWTNX8Fs5gBE13VAVfz/hy+C5B1CKt0CuZCZibXorstXdYkgN8sOfuiOuNgf1FmuGQ1P0GcThW5fh/DRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from PH7PR14MB5619.namprd14.prod.outlook.com (2603:10b6:510:1f4::21)
 by LV8PR14MB7648.namprd14.prod.outlook.com (2603:10b6:408:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 23:19:01 +0000
Received: from PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a]) by PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a%4]) with mapi id 15.20.7611.031; Wed, 29 May 2024
 23:19:01 +0000
From: Eric Kinzie <ekinzie@labn.net>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric H Kinzie <ekinzie@labn.net>,
	netdev@vger.kernel.org
Subject: [RFC net-next 1/2] net: do not interpret MPLS shim as start of IP header
Date: Wed, 29 May 2024 19:18:44 -0400
Message-ID: <20240529231847.16719-2-ekinzie@labn.net>
X-Mailer: git-send-email 2.45.1.313.g3a57aa566a
In-Reply-To: <20240529231847.16719-1-ekinzie@labn.net>
References: <20240529231847.16719-1-ekinzie@labn.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:610:55::24) To PH7PR14MB5619.namprd14.prod.outlook.com
 (2603:10b6:510:1f4::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR14MB5619:EE_|LV8PR14MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf90362-5816-45d0-2b89-08dc8035b981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9LO9E5LgBA+Vv2qnNgNqrl3XYyxiURbeAS4vOIK9DAY6VLrTvRbz8iHLN+t?=
 =?us-ascii?Q?eJMShxfPiAc8FbOI6fnFkU/jfOkGWqS9hlIIjeGa5VxkmAJHU88A+u9HtdXv?=
 =?us-ascii?Q?7TCBF/RxVum9dQpmPHzVd7KWHMDNP5aVG9nChfshCoDFY47op0HLXgMf/afs?=
 =?us-ascii?Q?UuY1n1QdZbX5F4jYA8N3z9pcZHABXXaAUvJaktdrubkPoFfupTBCjrcZYy/K?=
 =?us-ascii?Q?QZgbuNBCXigMaULyWo8xAb2iLi6L0CB0GP32q5lmW608lwB+HLhhUI6jAd+Z?=
 =?us-ascii?Q?c+0bVl2vDJkT1cVIoRr18T2mKFRo7lLpikvpZXwGXSXI01mB5ORLj5PdQMfx?=
 =?us-ascii?Q?iiQvzLTMvQZ7IGaW292tU/elunWWJNrZXPK0YYOVw6zt75QDWYoQfLTz4FQr?=
 =?us-ascii?Q?GFZpcV7HzDEqapGfKdMCJLbccSPg3aJeF2yGmGwPjhIVYic3GiuCIv69RnoE?=
 =?us-ascii?Q?I48SpfROWAf+vYgNgx2/FB0K1r6bA2Z9k7LAS84KUOCf2IY1OvVhWyXVZNUa?=
 =?us-ascii?Q?OOymTwnpkv/C9bzwIEwT9rdrtm40syFdMwgspXikOC6iY6fZBjmRRmZCn3c6?=
 =?us-ascii?Q?0IPm4Yf5cFPeqM8Cq/VK7N0wfrxBPHA0jRY2KatM2WNbs1v9FsF0dEHwIpTv?=
 =?us-ascii?Q?1tN6J71N2OoFI9W63/2vcuXxmv/iJmMPX3801a7GI9TrIPNtLnEPsp6G22n6?=
 =?us-ascii?Q?1Ym3476H0AJhScQzkcz/rE5P7L/6lY2h9OHti28QOFPACfcDCUj0drMfZgyj?=
 =?us-ascii?Q?x23y/rTOak9Omd/aYKJ3h6CuBDpcznPhbj9/JTU4bSsowQh1e8Wx9he2WLzz?=
 =?us-ascii?Q?HtLxwCJsdL612sSq2Gm74EjeDelXSTb5miv0nip+BiRXYcVWhHYZq0ifbqyQ?=
 =?us-ascii?Q?WLoOIeLwEkhsOQ9QTUUnId9tP8DYGeLWK2rni5NagpHHxgE0yFL19DXIzAkY?=
 =?us-ascii?Q?j1xwWS5uO630x2HkUgWBoueSaqyU47i/mMvgU347EHiT5GvXkTEJRCFottKM?=
 =?us-ascii?Q?zbQAy8RYRblXa6x6L6IJhm9tjw4ttdafHKXdBSA8U+HWMRsFkLKL/uMwEcU/?=
 =?us-ascii?Q?bixfW4+weqW8xv8HJu/11X+o3RxLadx9A3vKoIyBWiz54X4ydmmk/fKUp3j8?=
 =?us-ascii?Q?JqypFtWw4m9jjOeDlozinCVtZaYcNkyotjAykEqejmVb2U3LLJei+qRkhZju?=
 =?us-ascii?Q?3Q57DMKW+1F49oqftEDTvqGRVsX05Yok/qTpeCiAETLP4M6Ub8blVgzb6LuI?=
 =?us-ascii?Q?gleWbaFFvDE/iHLv+az0FemPlu+REYE+ZkgtDE+cuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5619.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zI3WVPgkqhvTGj3+qwM0x5KoDYtqFhK2EFs8QQZl1hrlno/Sbg5DG+iWDDlw?=
 =?us-ascii?Q?ALen86BzxwADEOQJP8DgZ7cLxedica7O087PboJJSl5bJQ0nFbUaLPGv6QNY?=
 =?us-ascii?Q?B7BAMjcO8k5DciYvJPNsl7fzeW/Q1v9nlxJFZZRgbFWyTjpaBMUZEVKCk0lK?=
 =?us-ascii?Q?MflqRW0froSSx1rDTWMONgwqt2xEGHoQ3UAj5UJ2kQsJxbnblqlGHZDsqSf6?=
 =?us-ascii?Q?MRMouevlQdiur8PxFKsnklMGYKTK1PVlODQ/e86zHTd846h8VWNg3mWCef5l?=
 =?us-ascii?Q?aPqjYJ7LwE4kiHeHFJEjTcHcvQ/fY07cuYQtaRrQyC1Xe5wol3uFejMu4iD3?=
 =?us-ascii?Q?heEX/TNQ4LRq20Txb7Ee7u2J2OjRvUStWJ+PX6fhnIUtQHj040pS4KsJuYEZ?=
 =?us-ascii?Q?kVjcBuOzQekHpKV+709ktJBRl9MauTUbbpZPZX9mY8s4N8WCO6m86VVXkpwU?=
 =?us-ascii?Q?4CLWUFTwe/tU0+Mv7kdN7a+CnJh3qa8GEUMmXcN41+EuhecI/HTjI/UHnFRQ?=
 =?us-ascii?Q?MlcvQZdcCOpRVP9kDTV6rIvHk8m7kDRdx3OYSD0vtkU+FCsdCyELlD1UGT8S?=
 =?us-ascii?Q?E0k65MCe5jUyZonfhSidJXWPOEbnaSNpdjB87Vl4tTpM1ADxcf1yuGG30bvt?=
 =?us-ascii?Q?Z57dXhrxTmR+90Nb8pbBI5jCAn80n493DMROCH0dRv4BAmDqHKpu0OdMeegU?=
 =?us-ascii?Q?xh1XHxXNujpIaB6YqqIxoyAB/gM9ImbB4zI+yTKtp2+FHrWczox/a8Jx2OvX?=
 =?us-ascii?Q?yQ3UFrjEaNGuWJX0yCMAzolcJx4rRpx9hDfe0/TYWiMGZUGLaxQ0x5BIGsHR?=
 =?us-ascii?Q?uaXBzAUrI6KqP2RsBd9+02supptpGjPt4Gmg+c4CjUmqiRck36OXSlaT9Yq5?=
 =?us-ascii?Q?+0f9TYdlar6+Sd2TRDae203VXl48rKImXH0461Lh0sImGs3/b3KwR+L2Hz0Z?=
 =?us-ascii?Q?raSYGNYXG5AT3DuAMGpp3EuKypKy3o843JM6qbN33NzQfNJiiY4XIrqtzNfG?=
 =?us-ascii?Q?oA+Jl4rHr26RI1sRbv5jKKXRr3ubF3AhqVw70OVI/V4INTbZX4FLBdX7ZqkD?=
 =?us-ascii?Q?t4X0AYLHjQvkkCKpj0hp+XNy3tWhLXx/X/w0EUdX1RF0TPXr5+MkvRtk9kkS?=
 =?us-ascii?Q?FYHnWuq0tuGYyD//v8Em7e9AWaOXr0HIJ9tyLoEFOmgeMm+LOy7D34Z/Nk8x?=
 =?us-ascii?Q?1lkWUqRDko+68Y3hgIPJY0iT09HHEGuqvR1sMOEVnAtTGSsXsJgLRdkvB6CH?=
 =?us-ascii?Q?4idd/PdQeQUb710864GgwT1urfWzT1PrL5D+UGPnhpRQl/NJnxgY5ruNiYUr?=
 =?us-ascii?Q?hwnVgUh+SY3CnuPgTtDYyQMeyjEqwpM6iU0RKbw6Ft23HjMLNM0uEbJma9Ro?=
 =?us-ascii?Q?qZfstqmOFWPE4Yzsvb/DuKpRiR02JzOqHrXVaYqLY3DxBSXjGWx4raj/jyf9?=
 =?us-ascii?Q?K1hHvm2qJTU0yMf2mRDHqNidJK8va3RJ0aGkL0p7kZYQtKb8jFCPTDTgLysk?=
 =?us-ascii?Q?83X4c/Y+K8F1WGFvkbfRhRUzA50JZDORGaCKN/Q5TH0fquw8RVPPjhWb/dM0?=
 =?us-ascii?Q?nxHmBYGE9pTbCSjoaHcVa3tbdaCfIBvATQ5um1TH?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf90362-5816-45d0-2b89-08dc8035b981
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5619.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 23:19:01.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7wTayrcINUNM6j3bqr8NxoLPzfuS5MX9ByPwwoGLpVoZn9hpbvDsWV9mkF4LWLPaZ+9zou/JE5tZ5YeDMvuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR14MB7648

From: Eric H Kinzie <ekinzie@labn.net>

When one or more MPLS labels are present, the struct sk_buff
"network_header" offset points to the outermost label, instead of the
IP header.  This is used by mpls_hdr() to find the outer label.  ip_hdr()
also uses the network_header offset and unconditionally expects to find
an IP header there.

When forwarding an MPLS-encapsulated packet, the data interpreted
by arp_solicit() as an IP header is offset by at least four bytes.
For example, with one MPLS label, the IP TTL, protocol and header
checksum fields are used as the source IP address.  With a TTL of 127,
the source address is within the prefix assigned to the loopback interface
(127.0.0.0/8).  This results in ARP requests such as:

10:40:32.131061 ARP, Request who-has 10.0.1.3 tell 127.1.197.239, length 28
10:40:33.144226 ARP, Request who-has 10.0.1.3 tell 127.1.197.239, length 28
10:40:34.168224 ARP, Request who-has 10.0.1.3 tell 127.1.197.56, length 28

Examine the inner network header for the source address if the network
header is not IP, but the inner header is.  Also fix a similar situation
in IPv6 neighbor discovery.

Signed-off-by: Eric H Kinzie <ekinzie@labn.net>
---
 net/ipv4/arp.c   | 15 ++++++++++++---
 net/ipv6/ndisc.c | 13 +++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..653394362c80 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -330,6 +330,15 @@ void arp_send(int type, int ptype, __be32 dest_ip,
 }
 EXPORT_SYMBOL(arp_send);
 
+static __be32 __ip_srcaddr(const struct sk_buff *skb)
+{
+	/* Handle cases like MPLS where IP is the inner header */
+	if (skb->protocol != cpu_to_be16(ETH_P_IP) &&
+	    skb->inner_protocol == cpu_to_be16(ETH_P_IP))
+		return inner_ip_hdr(skb)->saddr;
+	return ip_hdr(skb)->saddr;
+}
+
 static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb)
 {
 	__be32 saddr = 0;
@@ -350,13 +359,13 @@ static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb)
 	default:
 	case 0:		/* By default announce any local IP */
 		if (skb && inet_addr_type_dev_table(dev_net(dev), dev,
-					  ip_hdr(skb)->saddr) == RTN_LOCAL)
-			saddr = ip_hdr(skb)->saddr;
+					  __ip_srcaddr(skb)) == RTN_LOCAL)
+			saddr = __ip_srcaddr(skb);
 		break;
 	case 1:		/* Restrict announcements of saddr in same subnet */
 		if (!skb)
 			break;
-		saddr = ip_hdr(skb)->saddr;
+		saddr = __ip_srcaddr(skb);
 		if (inet_addr_type_dev_table(dev_net(dev), dev,
 					     saddr) == RTN_LOCAL) {
 			/* saddr should be known to target */
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 254b192c5705..16a93798cb00 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -730,6 +730,15 @@ static void ndisc_error_report(struct neighbour *neigh, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static struct in6_addr *__ip6_srcaddr(const struct sk_buff *skb)
+{
+	/* Handle cases like MPLS where IPv6 is the inner header */
+	if (skb->protocol != cpu_to_be16(ETH_P_IPV6) &&
+	    skb->inner_protocol == cpu_to_be16(ETH_P_IPV6))
+		return &inner_ipv6_hdr(skb)->saddr;
+	return &ipv6_hdr(skb)->saddr;
+}
+
 /* Called with locked neigh: either read or both */
 
 static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb)
@@ -740,10 +749,10 @@ static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb)
 	struct in6_addr *target = (struct in6_addr *)&neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
 
-	if (skb && ipv6_chk_addr_and_flags(dev_net(dev), &ipv6_hdr(skb)->saddr,
+	if (skb && ipv6_chk_addr_and_flags(dev_net(dev), __ip6_srcaddr(skb),
 					   dev, false, 1,
 					   IFA_F_TENTATIVE|IFA_F_OPTIMISTIC))
-		saddr = &ipv6_hdr(skb)->saddr;
+		saddr = __ip6_srcaddr(skb);
 	probes -= NEIGH_VAR(neigh->parms, UCAST_PROBES);
 	if (probes < 0) {
 		if (!(READ_ONCE(neigh->nud_state) & NUD_VALID)) {
-- 
2.43.2


