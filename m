Return-Path: <netdev+bounces-103185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760BD906B12
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3681F246B2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E13143861;
	Thu, 13 Jun 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="CBZQhdNp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2113.outbound.protection.outlook.com [40.107.236.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422913791B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278539; cv=fail; b=dr64Eeh/E6TSW7tdc+OMJ9sVYoETBtnt4aRTxfUQWLEj1a+OMbAhrLybYwhQi8oieit+/iYhUU5aM5Kl7TlLKalm4gPbaYaanR31jj9UEelTBT4USk3iXz2ufq+jPNZeu8nR0U2M2uLCQ9CWvuwmVBiYbKAZpXErPspu796FruE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278539; c=relaxed/simple;
	bh=O5Z6AdWLmo/IZqrAAqAzvrcimEorMI1kIYzS/MHgb6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Su2fRB+Q/Rj3PuAexJK3JX42wsGFNpZ48BFqIYap3M4qzRN8yN2MrbrlK2koYMPV7kdsKerwC+vShDkfDQHBeHOk5H3FUEzL2ATGKPQCiUWpMtxKJ27MKPKjmdTU2useW4EGQXo84AbmZcFUKz0sMRyeLq6sUCG41SHbwDdYXAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=CBZQhdNp; arc=fail smtp.client-ip=40.107.236.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxw/21dNzb6yzzDhhiTUASaZ0f5ynvfFfz3ApZOwvIBQqeDTf57s+Q9ZZqe6qeqHSbAK/8q6Kz5ibqlm7/E1DCByvDPQdc5kKkb718NBh/p3JbzQH3AHaDxxpAOzyszIO+PS7skNS2HqiiejPDTrY55dOjamw9nbl9fu8l1YLSNNN788l+ps448DXATIWxzUi5OEcOMRWM5WFp8RA3wmKF0KNXhag89E4/wkOYyWo1viRH1wuiOtNtmI3d1FLVgxq2gw5bKhIR/FJwuuxnu7QQSulAaHObS0uukqDP/nMb89y+Fwfixn/s3EovYdNKa6eGG9EoUrT6P028CzXBRYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq1ZRoSk5sNoYiE7Ivm8FSXwGTy2d+ZtLW8YPjrg+CU=;
 b=NdeicMzTNxx0pTGlT8gAaD6n0T0H7dKoCrkFidn9FZnE3Yw5xvabr0btKKix+CORR4L6luJgEoGw1PQWaOmqLuR817aK5M048G+ClHXRDPq7CqZNH5B2WAlUtAYifzerZD0fipC5nh37uCfGELvqpUiWtiOoBfYGCQdJD6+88h6snMbLqh4M4/i1hUvQQ8UdM2KrR9nW/x8nToZOrCKb2QKzLK/4VgkLSP0Klri7lbs6CAx3Auglde/d/j2fYQOyfbzbLGKKtjVEvjcpPCw9PAMni2YJxvJT/q3bRQF+N9IHILgBtZexQpjs3UsaBSu2CiJNKEkQXppbD18igSFhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq1ZRoSk5sNoYiE7Ivm8FSXwGTy2d+ZtLW8YPjrg+CU=;
 b=CBZQhdNp2KwUDFrZ0Da0vWvG+qEPsObW354THMd9f7BPt1ytFHjTjv2OjmNwFVsJio9fjipBfKMkNXZYtzmDaVrK/xSJl+8xnr3wJ5GAVww1c/+Xmc2VAV39UeHqzfYA8uHb3f1Z0NaFqVyKkIETLMyHbhgjHxcxQDSuNO8yTvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from PH7PR14MB5619.namprd14.prod.outlook.com (2603:10b6:510:1f4::21)
 by IA0PR14MB6283.namprd14.prod.outlook.com (2603:10b6:208:437::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 11:35:33 +0000
Received: from PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a]) by PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a%4]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 11:35:33 +0000
From: Eric Kinzie <ekinzie@labn.net>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric H Kinzie <ekinzie@labn.net>,
	netdev@vger.kernel.org
Subject: [RFC net-next RESEND 1/2] net: do not interpret MPLS shim as start of IP header
Date: Thu, 13 Jun 2024 07:35:21 -0400
Message-ID: <20240613113529.238-2-ekinzie@labn.net>
X-Mailer: git-send-email 2.45.1.313.g3a57aa566a
In-Reply-To: <20240613113529.238-1-ekinzie@labn.net>
References: <20240529231847.16719-1-ekinzie@labn.net>
 <20240613113529.238-1-ekinzie@labn.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To PH7PR14MB5619.namprd14.prod.outlook.com
 (2603:10b6:510:1f4::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR14MB5619:EE_|IA0PR14MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: bde2ea4a-050f-4bef-c195-08dc8b9cefc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avn7B5Yg1gCUNokXgtelLa9F4zaJsX2vuu8SK9hFPIFF385zts5L+U7ybLFw?=
 =?us-ascii?Q?ECHgGxFQkbIlouJA70tXjMZbJospMtJxh9VIQdjcut19l9RzPf7u7sd1yY02?=
 =?us-ascii?Q?fG/VioFHzPqu7vzQkTNVv1m+aCyJUbjPhRD3i92/6w/uZzaIvHdrRcVRbdEC?=
 =?us-ascii?Q?9fq2nwmQJkMAVZOuGI4JjUzwiGAYE5YoYb2FXK+E9DdR+G5WKfR4lDMNbzk8?=
 =?us-ascii?Q?MbRj8TAgWr3pNNf3Ro2wIaMuI8CJbtqW/luCUi5oAtOqAdnDrZo5+xIJzLWL?=
 =?us-ascii?Q?0PWNJqhmhkKGO3gN5tDEsWG1zPZM2rgANqfIXyvobUO9WpWsA2Rwnl2WruGy?=
 =?us-ascii?Q?WBdvEuzjJzKUDAke1qh4aHf2H05czs65NfQlX4r2GdC0F5b8/F6bZTFkJ5XH?=
 =?us-ascii?Q?qsFwfvPVy+NqmsI9vXJwQChkByjvpm5jDxWoaX9bC1j+kRZqNOMLYrjYsx2D?=
 =?us-ascii?Q?nVYcZxyTQRMHczG2ZJmtGk2adml5Zo73bVvsUYRcvFUe1VE6uXdyfnU7BK5o?=
 =?us-ascii?Q?lOsKo2ZP0VIkquvS/ExqxvZd4oZheFbn9iaa6dhWcZUm1434DGSVib1tvP2D?=
 =?us-ascii?Q?LFKUHpWSwCfrESM8WroZE+nj4VNvJzfRK86aWZdSbr7ou4pg7DLuRiMyQ3k5?=
 =?us-ascii?Q?r9KGT4WQ9OiJjSlPqCNI1DjxmBo67rDcVh18t2kki3IkKhkU1/6QOWkBhqCa?=
 =?us-ascii?Q?X6+SEKVXJO7IgjjPBzQxLt6gqL6I/LHVb74sHQODgUgduTw0oQ7CA+RUFFgL?=
 =?us-ascii?Q?rT64RbKEKnOGv4YZjpALxLOqQN17Q1vR9TWtwpCrpaQyBGhJGwY1aNrfrRiz?=
 =?us-ascii?Q?eRcnsmY7jtqnzue5y79ZegENPLNFZuNG3A7MwMUzDZgvd6C8byGi+DWhcy79?=
 =?us-ascii?Q?LTvW/xCSUuamHiUAO4kGmMWnGhNVT43g0eT6mDlVzwIKXyMtM6+gWgIppO2v?=
 =?us-ascii?Q?F0eDTjuNvPoxM+i1z1ptiOdWOHro0OduW/zO+ydTsD8d1lQk2BLmqV5kz8Qp?=
 =?us-ascii?Q?8AvPk0d4CeJCIBpDH517vpwOLj8ylBKwp5x9mu36fuOB4X5lN7uFl3h8tc55?=
 =?us-ascii?Q?C7lO6w64zYBq91XO1ClB+R5NLTwsy4qUR9PyK55gy9B+LVwnuJhdn6ERGIIt?=
 =?us-ascii?Q?JRvSIYWY2bttmIQF06wsDcB9Wbmp1Y8GygdCkItNI3TF3AVmRdIpxS+RzRYz?=
 =?us-ascii?Q?oXKP7Ix+tSTv98cIW0/cQ6JZdMV5j7IqcpdYJ35PLHEx90brV5QUJ3Tnq5rG?=
 =?us-ascii?Q?dDJv1OAaLr9tk97KTBRU/+BTy3xzw8LTKNoZVGfx+nPv2P+965qk/Yj3gDWh?=
 =?us-ascii?Q?0J8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5619.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6TCkqEFdHsEgzThRAPHl4U9qc+2vZ+rhbwup2t4QN59nYgMH1pfP3YZA41x?=
 =?us-ascii?Q?6h0CJVPyMGOJLCpp/Em4Yc9So6ZYKiMyXpNakP5HGbGvkhl+dc/Rl0gsM9Ul?=
 =?us-ascii?Q?ty2actP8h6KXJwfGB8K9l3YVMl+ClUhmc1aqGKZqsM280Cxn+MozA8C6Chw8?=
 =?us-ascii?Q?BQO7ocLfvuDYIRMVajvyNothBHIebIeZEVEyT3yIsAGUere7btUM4QbygUn0?=
 =?us-ascii?Q?wydAeThNaD5RLbIes6rruNIQlAXonrtEDYkhEsj5CrMTpPh+CdTSrqA5cepB?=
 =?us-ascii?Q?TfJKslz1lp8uemI702082drdDd8ZO+imTiwuqLuewJhIG2wDxNFKnXs7U8y9?=
 =?us-ascii?Q?oqGoCihu0PNFy9dkXXLIHS2F7bkzomM8pNqU0XsfT0aySF55N0wibP1ZHFZP?=
 =?us-ascii?Q?rkSPU2DuI7XImrYBLBD6VG90MrgMXqA0JAjE95pes6vjGDrZajr7iFPvfGyF?=
 =?us-ascii?Q?SGZ+c+mwq+3KtaOC4bNjaXGw4aLFh9lCY21XAJ8A9tTQOrxF6wKUuNz5eXc9?=
 =?us-ascii?Q?LksBYbbRhmbNaRLHJNvhtmoYZ8tuCjIgU4Sh8LyjRPwlZNvJiXZsGYJJ9JwK?=
 =?us-ascii?Q?5U7ZzeF4LUjZQTjUxNWI+HCU4BLzcIo7tUIWDAPfTdzBVl41LZC0se8PSgOJ?=
 =?us-ascii?Q?kqrvRlLo2e3R3xX7KPb2els+G7pgMI2jG3/QcB4Ohiz94edpxX0IIPktzyY6?=
 =?us-ascii?Q?Si5j+PPFPqWbZjQMf5OEy40sm+05d3H2vUQDYEl0js0vwGYmV7hlWP2dKhOH?=
 =?us-ascii?Q?yH3RRD6V6ohFdjnhBPA9wigm2u/dwJ7lG14w9bJGHDKHr4r7nKgvVXv6SZtk?=
 =?us-ascii?Q?qm+KJeH7NWwzFBmEoSwC5CkAdxdQb/G1+MqNTHAsx8FEQpAS/dgDzENbkKFB?=
 =?us-ascii?Q?OEyywbnxfa+U7+rXPPbQQNhN4/btx7YsDdncqN8UtCKPXgIfdjuxEvqMEs2p?=
 =?us-ascii?Q?TLW2znvRjsM/rE0oml4lZo3Tc343jssVENgChDlxXPnjSgVMGW+cdTVwytVk?=
 =?us-ascii?Q?mLq77+7N/iJsfBJNK8oZa/evQ4qEta4jWkqNkHxWXkXAUpONF1bXDRbR0F9q?=
 =?us-ascii?Q?UpT+TCbdF0yrwheRGMA9LT+0skHu8bod7u4idJDVE6DevRz2hT4iitqbbKXJ?=
 =?us-ascii?Q?lLbNERdr+GvqNfFEHE3uZcwKgcv2jDm9hCNhkLNajHbJD/MdlfCiNKjYkEQJ?=
 =?us-ascii?Q?6vmzmk760zu/H9W9CgVJBUJqoal46sVCjaMZL2SkdRn7WcIRT6zwhsRGZ6jG?=
 =?us-ascii?Q?yvd+UZjPVtMs55euJJDG3V7556sNaDcE7YRzbcjMV12/hNgcxdT0bHYgF4Bg?=
 =?us-ascii?Q?tWOCVyFcJoKZep5yvUzyAzcM0u+d8FyKUCYjbG8lYMzhVOMyoBSE8nvWUioj?=
 =?us-ascii?Q?oy3nxU6NMbhWpeMRgL14j2ET2fC+MVxvd/kvJT5sxLR1JwcDuRrpKu2gPLM9?=
 =?us-ascii?Q?GGIbXocmNeAeJkJRVtodNS3xxHtTgTJ3zzTxJrTH5X8XzxTFv2+873ncrZGj?=
 =?us-ascii?Q?lmsqT6mAJ6A1JPhMdsReL3L4ykzER5UA2MfYr2tdTPzdPPw5aWRjg9JYSCRd?=
 =?us-ascii?Q?CxOWubquGKxW+aCvDnwG5i7niID2lZ+PEsos/iWw?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bde2ea4a-050f-4bef-c195-08dc8b9cefc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5619.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:35:33.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxD7Y7nZ3UZp5hmguM04sLV1LNCwAZXr9GOPMXIHAeOurWdkCuEUDLUfcN5Ng18/mkypPWR4HqKi7pKPrdaErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6283

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


