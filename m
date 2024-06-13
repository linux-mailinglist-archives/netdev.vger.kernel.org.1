Return-Path: <netdev+bounces-103186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C0906B13
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1341F2444E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DC1422B5;
	Thu, 13 Jun 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="loPu94fK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2113.outbound.protection.outlook.com [40.107.236.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B2143866
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278542; cv=fail; b=TsI3f4q/s1JOURj/x+6+x9VC1q1ryOLtV9U4GV1ZW1hBmUxekdpl1/r0Xx62aVT1MFaG/akSIxJQV95+OH+WB2yfJWHq//vpkv00DtuvJT++zsd1qrvDKdc5ZgcDksnXUC3ewWsEPhfn7uWz3wmSodTrrNzjwIynjTK7q33ZY7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278542; c=relaxed/simple;
	bh=JcIAn9KTeojfcs4DVTLHUYlLNDGqIwNPNta6I1STXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9nHK1uI3TKzPZm1FDGGMiwsyPtLLrTbT3Gcppu0UIKPHTaMj5lfxZGkgFfXjq6Q85GBWc0flAAyI16Fc5qo2kg6FFX98a4zC7ZgTZJ6R2pPAPBhhVkEe3UDlUqt1UA8wciSObHnxw7ocWStnNpBKKJETWfDHANYXAd9QIgxOFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=loPu94fK; arc=fail smtp.client-ip=40.107.236.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDYJvTKjvCMmVJAW8QZizTGVd7Q6IlmgkdvN9G2CTShNKJyPTyoZAfS/47xefTiS/K3X6jYfJ+fXOLgRlEHJJGr1Y5HTk546YtCgxWR2wQ3f5DMK/0lvbinNfNAu+B29tzZ/FnYjtzGoDLc+t6AtZQhT+Pi6Ft0fFChigMWWbv1dS2QnCPFLMWDkHZHGo4DBS7hGHzFhy2g4ChYhdxdNBMSKzt7Un8d5O8Fw6RAH+j9Nh82HpHNMh4htaT3KW7pWJSsFgX7/6XdIW38BhThywY8n0Wl7dYxAJiRgzpNWaUKKLmHOcneCIb++HbLI3qzlBjSiqMy1hNB2+GsaKoKGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRaME/wEKZf50Yfhq+87WRmCxYS72DdLpwUNDbvlzhQ=;
 b=mpmFNOYYzc6x6E7RTOBv/UeOjB251rRjZK/vQ5j5lXDfMQ7x24kSIM3XxZNAtYdT7tG5x+gv2LDM7zWIoNI/Id90WrjdekYEZr4VL0BzFp1EV6fVtE7cLjym0w5ScEh7neatDes98dkZbfG2S1sC4AYGMyqNp85vSxTN4J4HXJDt9IQ8B1GP08n0qDHfuC+eXYNXaErvi0e0t01S0gb2mzErDgdnprVemWWKpZiEOX3HETzESfW1/fwWVfcz7Lr15oNjOOFT0QF9kv8+xXjFoV0bR3PCnvAgD9gwxTxglG81k/p/YU2qfwEYc+6zbEeBxyqlNRqCZrfA29ivhY2y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRaME/wEKZf50Yfhq+87WRmCxYS72DdLpwUNDbvlzhQ=;
 b=loPu94fKL/ge+tI2FOg6vUdTNIG/T34q/kh/EtO37VHnZMLRO6srPzrBOtfh2RYHJst9QocN98IK7qjKWEwI2bnFoXsf1VXUsM9i88KIgFUoeCjaaCmw0e66xfoda/CslLhDx5+78bm4SdK4yFvy10NzaiTZI/auJlEKjJ+J/Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from PH7PR14MB5619.namprd14.prod.outlook.com (2603:10b6:510:1f4::21)
 by IA0PR14MB6283.namprd14.prod.outlook.com (2603:10b6:208:437::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 11:35:37 +0000
Received: from PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a]) by PH7PR14MB5619.namprd14.prod.outlook.com
 ([fe80::3b86:8650:ed26:d86a%4]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 11:35:37 +0000
From: Eric Kinzie <ekinzie@labn.net>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric H Kinzie <ekinzie@labn.net>,
	netdev@vger.kernel.org
Subject: [RFC net-next RESEND 2/2] net: mpls: support point-to-multipoint LSPs
Date: Thu, 13 Jun 2024 07:35:22 -0400
Message-ID: <20240613113529.238-3-ekinzie@labn.net>
X-Mailer: git-send-email 2.45.1.313.g3a57aa566a
In-Reply-To: <20240613113529.238-1-ekinzie@labn.net>
References: <20240529231847.16719-1-ekinzie@labn.net>
 <20240613113529.238-1-ekinzie@labn.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:208:239::15) To PH7PR14MB5619.namprd14.prod.outlook.com
 (2603:10b6:510:1f4::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR14MB5619:EE_|IA0PR14MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dea2320-91ba-4c70-a1b7-08dc8b9cf25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqqekSs7z3Rq/OlJghcpGbQ02XNE0PivBqiNAOOk1e0KSm367Ch+KviBI0zq?=
 =?us-ascii?Q?EuBAMOxFCmNbk8y/FEFrgPbPLC1eWDX4+tEpOwx1FZfCC/Qrg1vTMlka8pX9?=
 =?us-ascii?Q?vTGZygPBrNw3O0k9CKPRRqGC45bKSQ99FGu4O1knUD2wuRnizhheiP4bEz4G?=
 =?us-ascii?Q?lbI9OWbUzfF18MqPAW5G2pQnV2ESrXdzBBFVl5fZLoWSVHA+X5onhJRzSWAI?=
 =?us-ascii?Q?eahEq6wJoFWZNhSnHeYmrkh8IVvaP0rkxxmnhnPgut+MgnsUqTnIUPf/o2qP?=
 =?us-ascii?Q?r3ASIBvQNJjZd6fQopiM9tNA69yKAg/4CP/tzTRL4FUbDSHCDzW0z4sjcZNc?=
 =?us-ascii?Q?X9TDpy1tT5CRCb17ltPoTzyXoyGCWx58SDnvOcyx+qxiJQ8bTeAHKL+lAVyk?=
 =?us-ascii?Q?DsbQhq51HWVYnwm7JzH4MjgZFkkWMoM+sZS53K11J97jvkvnD2T5QBEadRzw?=
 =?us-ascii?Q?HVFAetGxvczWFSU9P7PVAnnCyRaXEkFUyUaR+Bl/mqoQqmvN1WdfCbtjIwN9?=
 =?us-ascii?Q?RAS1lb6xfzI/UfokRmfRiRFli30zawnZvcqpcmeUXjixZhVUgvNz0aHySNbE?=
 =?us-ascii?Q?IDR6Z4H4XwavYo8+QYNe7DC0PaPWhzJeOyLnV0iDGDaNvU9I38RWNRirjp0X?=
 =?us-ascii?Q?nlnjB5buJhijK3qA5vGPegY4he48qpw8tYBH47eTWYllKBeqqqMboIZS0Zs4?=
 =?us-ascii?Q?gZ1aDzgmXiLyLasCY8FR24yF4M3E/I+dIheE/BF+1ajc9/haQSBd9Yy//sNF?=
 =?us-ascii?Q?xZjUcQhE3twq403M5V3pvhdxyRhn9Nil/hcBIsS+ekfrbdCCbDIGxUaAPLR4?=
 =?us-ascii?Q?5NOZGAdC62qf6VYx+cf1a7sYqp6uHe+ZKpM7TSaRE7ZtDisB1uDROFGgZY1Z?=
 =?us-ascii?Q?cLiRd6zCGmIKvUxq/Q+kH5pZbnx8oIDmWl3KND8UmJLbAO4h5Q/8uYQia4pm?=
 =?us-ascii?Q?MDwgjxu65KeAO5Qgmmq1w3Lyz0qymNxbpx8dCTYMJGwJQRYB58jVauV1JJBK?=
 =?us-ascii?Q?QpNhHMejWAarKnAdypQT+sYu1MDiMSYjggz72wIT/RUURVQZSAy2y2ryLmai?=
 =?us-ascii?Q?GVLh7ymNehQrzCE7Ziu5wNd7FEBOiwmyo/dePe9GqdNV2P6Qhp1ho1um0593?=
 =?us-ascii?Q?rofNZoSybsUJqMaWZQPFs2QphAP51okrSTo0oER1JTYlX9tzD+ML0r14QAB8?=
 =?us-ascii?Q?c9Bm7CJ4EBanDABd2rFHd6EN6xGY1bLyiCp7PQVKukDpGAiqVMGWmPZ7V/xn?=
 =?us-ascii?Q?W8Q52PoLQBYZaZL6Hsr7Xh5qv96WmYmeTtprnreCX23Oi4A9GuVQ14NXw8N3?=
 =?us-ascii?Q?azaGFF+6Pu8lZc5CESAwJjbk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5619.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDHUhk2of4hlA9X3oqQEYSE+GSC3fDEa9nP1u+YR4RlltM0ExH5ZUEQnQVmD?=
 =?us-ascii?Q?mY6rqnzRp4cDahMuWXgzNxPXWLxeOOyiSkTvV0n8692roztTlxDIneLI+Ryj?=
 =?us-ascii?Q?fYC1BD+vkwr/IEuERqA7Gbi+VNaIy6cQI85Em73QYWrpMiprS2egqau5unIj?=
 =?us-ascii?Q?qcmGC80+x1e0Q0yZKMbC4fWYI2Dw/drOfWQKs+xqnZjdqxmZhyH2wU33AHWa?=
 =?us-ascii?Q?aaHg1As5TS3aCGO8rM+qag0OXJodm72E/nO9E9S0YeKpJ4EStOinstKiCjQC?=
 =?us-ascii?Q?1rpNgY4jq4HkF4FSE2X/BOJRP6dYXkx9fEGvK/vZNB2mSOJm8uFEAwe0crbD?=
 =?us-ascii?Q?/FGvldN7e767FQR689EqAerVNLnnd8gJwCXxDpV5uqjzLF2QxelqpDI3yjPm?=
 =?us-ascii?Q?lS74GOlmdnlQKq4aTHuEPd3ioxtHFavUqx1or9kHDdjgoWQm/cIJ/2rllXPj?=
 =?us-ascii?Q?ehCtmerpgdffOFmHqszqZRcV1zBbf2W+Asi45qFE2Dtd6Du4/xIZRqoF78tD?=
 =?us-ascii?Q?/aUoU4LWuWrmUH+OLes11REPAl9aHWTwSbXheiiOdyqghFsBjNBIHETuHYUl?=
 =?us-ascii?Q?NiDJUwPDatlEkwc3/K9jDogFtyMVXS3Si8txvXMFDJo3U1YH463arpr+aacR?=
 =?us-ascii?Q?zDEJ6R12mbmcX7C7GFZKyjnD67AUh9eN/tV8mV4jzasFrnG/Vx1mpdXRAqm0?=
 =?us-ascii?Q?FVJCoNh1/d/IdBmNRqUxcoiTpDal5Q9QMYDAC/jkj0jsaEbe1a+akX56RfSi?=
 =?us-ascii?Q?LTu7bp1OvCal72ADbd2nXrFGalRVM0jfqEt271IV0UUPglD0eC+HFVKH9am5?=
 =?us-ascii?Q?Xbu8u2YUTt4FmwFWS6FFN2YRdTqIFALrItYmC4rgKgWb5U0frdKSnFFcpS0r?=
 =?us-ascii?Q?sYcnblPuTu4C4y5xxT3DORSKaA1uwHHV99Go7X1HEFSxQZQE/QeYC/zxDsuy?=
 =?us-ascii?Q?MDx/UUJv+mB78j18vTwxee9xW1T1ckbPrU7F5Uxw4HM3BvAmAvWyiXo43c0I?=
 =?us-ascii?Q?ighL8asJbN10m/jDJPRWd6Zm1N17YwmharcubXSgBFc7UollCxZpSGyv6J5T?=
 =?us-ascii?Q?VVtTJl7aK/2GHkLKPF3bu62L/ff2pha2Y5xboAGy170kYGQPBpwzTn91dE/e?=
 =?us-ascii?Q?rnSUJPgsqLPF1EFsHNNdANCeMtZNGcRg/guPF5zSmUEQdjGqzIuoLNcqSvb7?=
 =?us-ascii?Q?mCjBVfUwTBE+MnYRg9ZJB4SxjSDVz3pgRm2ay5FqLWxYx0+uP9cNYSBZVB8h?=
 =?us-ascii?Q?eJVa7jmXmwMTF+5JPgHgwdjbiD9lSKL/yNZV1bdafgYBhG0CGFbJXYkGJfs+?=
 =?us-ascii?Q?xBpQZkxlg2ITebhsm7Sdu00PISt9vM3Tfmks2bW8uimyWhlsR2FBT+4L1Olt?=
 =?us-ascii?Q?8oV2btlbiU9IbwcPWN3isLOTIMveqkXczTJpGBaIR+AaUVHsndhHHOkpTv8H?=
 =?us-ascii?Q?1se4T+a4bdVi4IXRrCqaYPdn3b+dDZSOpsNgBt1gN1ux71uDliY0sTuzlIBl?=
 =?us-ascii?Q?wLg6yD8zFwkU33M3dNJGF5q6bEFz+RH6RPr1Hp+T/G+OWu0/oILwVFrndsG3?=
 =?us-ascii?Q?WYLLDkExj4pikykUAAY37eksP8ciLrmDlLvVZ84C?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dea2320-91ba-4c70-a1b7-08dc8b9cf25a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5619.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:35:37.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SzDrd55z90qCJJakMiR7IS3ZRrtM6d1z73HKsTFbbWllYfOOtBX0G4lthno3owwITbLZdlKsFdJSxbrtD6cZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6283

From: Eric H Kinzie <ekinzie@labn.net>

MPLS can multicast packets through point-to-multipoint LSPs.
The structure mpls_route has space to store multiple next-hops for the
purposes of multipath forwarding.  Alternatively, use this area to store
multiple next-hops for p2mp.  This change is consistent with RFC5332
section 4 for downstream-assigned labels, in that it continues to use
the unicast ether type (ETH_P_MPLS_UC) for multicast Ethernet frames.

p2mp routes are added by declaring a route type to be RTN_MULTICAST.
For example:
	ip -f mpls route add multicast 100 \
	  nexthop as 200 via inet 10.0.2.1 \
	  nexthop as 300 via inet 10.0.3.1 \
	  nexthop as 400 via inet 10.0.4.1

Signed-off-by: Eric H Kinzie <ekinzie@labn.net>
---
 net/mpls/af_mpls.c  | 218 ++++++++++++++++++++++++++++++--------------
 net/mpls/internal.h |   6 +-
 2 files changed, 153 insertions(+), 71 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 2dc7a908a6bb..e7f39ee05c19 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -339,76 +339,18 @@ static bool mpls_egress(struct net *net, struct mpls_route *rt,
 	return success;
 }
 
-static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
-			struct packet_type *pt, struct net_device *orig_dev)
+static int mpls_forward_finish(struct sk_buff *skb, struct mpls_dev *mdev,
+			       struct mpls_entry_decoded *dec,
+			       struct mpls_route *rt, const struct mpls_nh *nh)
 {
-	struct net *net = dev_net(dev);
 	struct mpls_shim_hdr *hdr;
-	const struct mpls_nh *nh;
-	struct mpls_route *rt;
-	struct mpls_entry_decoded dec;
 	struct net_device *out_dev;
 	struct mpls_dev *out_mdev;
-	struct mpls_dev *mdev;
 	unsigned int hh_len;
 	unsigned int new_header_size;
 	unsigned int mtu;
 	int err;
 
-	/* Careful this entire function runs inside of an rcu critical section */
-
-	mdev = mpls_dev_get(dev);
-	if (!mdev)
-		goto drop;
-
-	MPLS_INC_STATS_LEN(mdev, skb->len, rx_packets,
-			   rx_bytes);
-
-	if (!mdev->input_enabled) {
-		MPLS_INC_STATS(mdev, rx_dropped);
-		goto drop;
-	}
-
-	if (skb->pkt_type != PACKET_HOST)
-		goto err;
-
-	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
-		goto err;
-
-	if (!pskb_may_pull(skb, sizeof(*hdr)))
-		goto err;
-
-	skb_dst_drop(skb);
-
-	/* Read and decode the label */
-	hdr = mpls_hdr(skb);
-	dec = mpls_entry_decode(hdr);
-
-	rt = mpls_route_input_rcu(net, dec.label);
-	if (!rt) {
-		MPLS_INC_STATS(mdev, rx_noroute);
-		goto drop;
-	}
-
-	nh = mpls_select_multipath(rt, skb);
-	if (!nh)
-		goto err;
-
-	/* Pop the label */
-	skb_pull(skb, sizeof(*hdr));
-	skb_reset_network_header(skb);
-
-	skb_orphan(skb);
-
-	if (skb_warn_if_lro(skb))
-		goto err;
-
-	skb_forward_csum(skb);
-
-	/* Verify ttl is valid */
-	if (dec.ttl <= 1)
-		goto err;
-
 	/* Find the output device */
 	out_dev = nh->nh_dev;
 	if (!mpls_output_possible(out_dev))
@@ -431,10 +373,9 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	skb->dev = out_dev;
 	skb->protocol = htons(ETH_P_MPLS_UC);
 
-	dec.ttl -= 1;
-	if (unlikely(!new_header_size && dec.bos)) {
+	if (unlikely(!new_header_size && dec->bos)) {
 		/* Penultimate hop popping */
-		if (!mpls_egress(dev_net(out_dev), rt, skb, dec))
+		if (!mpls_egress(dev_net(out_dev), rt, skb, *dec))
 			goto err;
 	} else {
 		bool bos;
@@ -443,10 +384,10 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 		skb_reset_network_header(skb);
 		/* Push the new labels */
 		hdr = mpls_hdr(skb);
-		bos = dec.bos;
+		bos = dec->bos;
 		for (i = nh->nh_labels - 1; i >= 0; i--) {
 			hdr[i] = mpls_entry_encode(nh->nh_label[i],
-						   dec.ttl, 0, bos);
+						   dec->ttl, 0, bos);
 			bos = false;
 		}
 	}
@@ -477,6 +418,139 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	return NET_RX_DROP;
 }
 
+static int mpls_forward_p2mp(struct sk_buff *skb, struct mpls_dev *mdev,
+			     struct mpls_entry_decoded *dec,
+			     struct mpls_route *rt)
+{
+	unsigned int nh_flags;
+	int one_err;
+	int err = 0;
+	u8 alive;
+
+	if (rt->rt_nhn == 1)
+		goto out;
+
+	alive = READ_ONCE(rt->rt_nhn_alive);
+	if (alive == 0)
+		goto drop;
+
+	for_nexthops(rt) {
+		struct sk_buff *clone;
+
+		/* Skip the first next-hop for now and handle this one
+		 * on the way out to avoid one clone.
+		 */
+		if (nhsel == 0)
+			continue;
+
+		nh_flags = READ_ONCE(nh->nh_flags);
+		if (nh_flags & (RTNH_F_DEAD | RTNH_F_LINKDOWN))
+			continue;
+
+		clone = skb_clone(skb, GFP_ATOMIC);
+		if (!clone)
+			goto drop;
+
+		one_err = mpls_forward_finish(clone, mdev, dec, rt, nh);
+		if (one_err)
+			err = one_err;
+	}
+	endfor_nexthops(rt);
+
+out:
+	nh_flags = READ_ONCE(rt->rt_nh->nh_flags);
+	if (nh_flags & (RTNH_F_DEAD | RTNH_F_LINKDOWN)) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	one_err = mpls_forward_finish(skb, mdev, dec, rt, rt->rt_nh);
+	if (one_err)
+		err = one_err;
+	return err;
+drop:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
+			struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct net *net = dev_net(dev);
+	struct mpls_shim_hdr *hdr;
+	const struct mpls_nh *nh;
+	struct mpls_route *rt;
+	struct mpls_entry_decoded dec;
+	struct mpls_dev *mdev;
+
+	/* Careful this entire function runs inside of an rcu critical section */
+
+	mdev = mpls_dev_get(dev);
+	if (!mdev)
+		goto drop;
+
+	MPLS_INC_STATS_LEN(mdev, skb->len, rx_packets, rx_bytes);
+
+	if (!mdev->input_enabled) {
+		MPLS_INC_STATS(mdev, rx_dropped);
+		goto drop;
+	}
+
+	if (skb->pkt_type != PACKET_HOST)
+		goto err;
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto err;
+
+	if (!pskb_may_pull(skb, sizeof(*hdr)))
+		goto err;
+
+	skb_dst_drop(skb);
+
+	/* Read and decode the label */
+	hdr = mpls_hdr(skb);
+	dec = mpls_entry_decode(hdr);
+
+	rt = mpls_route_input_rcu(net, dec.label);
+	if (!rt) {
+		MPLS_INC_STATS(mdev, rx_noroute);
+		goto drop;
+	}
+
+	if (!(rt->rt_flags & MPLS_RT_F_P2MP)) {
+		nh = mpls_select_multipath(rt, skb);
+		if (!nh)
+			goto err;
+	}
+
+	/* Pop the label */
+	skb_pull(skb, sizeof(*hdr));
+	skb_reset_network_header(skb);
+
+	skb_orphan(skb);
+
+	if (skb_warn_if_lro(skb))
+		goto err;
+
+	skb_forward_csum(skb);
+
+	/* Verify ttl is valid */
+	if (dec.ttl <= 1)
+		goto err;
+
+	dec.ttl -= 1;
+	if (rt->rt_flags & MPLS_RT_F_P2MP)
+		return mpls_forward_p2mp(skb, mdev, &dec, rt);
+
+	return mpls_forward_finish(skb, mdev, &dec, rt, nh);
+err:
+	MPLS_INC_STATS(mdev, rx_errors);
+drop:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
 static struct packet_type mpls_packet_type __read_mostly = {
 	.type = cpu_to_be16(ETH_P_MPLS_UC),
 	.func = mpls_forward,
@@ -491,6 +565,7 @@ static const struct nla_policy rtm_mpls_policy[RTA_MAX+1] = {
 struct mpls_route_config {
 	u32			rc_protocol;
 	u32			rc_ifindex;
+	u8			rc_flags;
 	u8			rc_via_table;
 	u8			rc_via_alen;
 	u8			rc_via[MAX_VIA_ALEN];
@@ -1029,6 +1104,7 @@ static int mpls_route_add(struct mpls_route_config *cfg,
 	rt->rt_protocol = cfg->rc_protocol;
 	rt->rt_payload_type = cfg->rc_payload_type;
 	rt->rt_ttl_propagate = cfg->rc_ttl_propagate;
+	rt->rt_flags = cfg->rc_flags;
 
 	if (cfg->rc_mp)
 		err = mpls_nh_build_multi(cfg, rt, max_labels, extack);
@@ -1837,9 +1913,11 @@ static int rtm_to_route_config(struct sk_buff *skb,
 			       "Invalid route scope  - MPLS only supports UNIVERSE");
 		goto errout;
 	}
-	if (rtm->rtm_type != RTN_UNICAST) {
+	if (rtm->rtm_type == RTN_MULTICAST) {
+		cfg->rc_flags = MPLS_RT_F_P2MP;
+	} else if (rtm->rtm_type != RTN_UNICAST) {
 		NL_SET_ERR_MSG(extack,
-			       "Invalid route type - MPLS only supports UNICAST");
+			       "Invalid route type - MPLS only supports UNICAST and MULTICAST");
 		goto errout;
 	}
 	if (rtm->rtm_flags != 0) {
@@ -1988,7 +2066,7 @@ static int mpls_dump_route(struct sk_buff *skb, u32 portid, u32 seq, int event,
 	rtm->rtm_table = RT_TABLE_MAIN;
 	rtm->rtm_protocol = rt->rt_protocol;
 	rtm->rtm_scope = RT_SCOPE_UNIVERSE;
-	rtm->rtm_type = RTN_UNICAST;
+	rtm->rtm_type = rt->rt_flags & MPLS_RT_F_P2MP ? RTN_MULTICAST : RTN_UNICAST;
 	rtm->rtm_flags = 0;
 
 	if (nla_put_labels(skb, RTA_DST, 1, &label))
@@ -2386,7 +2464,7 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 		goto errout;
 	}
 
-	if (rtm->rtm_flags & RTM_F_FIB_MATCH) {
+	if (rtm->rtm_flags & RTM_F_FIB_MATCH || rt->rt_flags & MPLS_RT_F_P2MP) {
 		skb = nlmsg_new(lfib_nlmsg_size(rt), GFP_KERNEL);
 		if (!skb) {
 			err = -ENOBUFS;
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index b9f492ddf93b..585dd9ac1076 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -153,10 +153,14 @@ struct mpls_route { /* next hop label forwarding entry */
 	u8			rt_nhn_alive;
 	u8			rt_nh_size;
 	u8			rt_via_offset;
-	u8			rt_reserved1;
+	u8			rt_flags;
 	struct mpls_nh		rt_nh[];
 };
 
+/* rt_flags */
+#define MPLS_RT_F_P2MP                 0x01
+#define MPLS_RT_F_UPSTREAM_ASSIGNED    0x02 /* upstream assigned labels  - rfc5332 */
+
 #define for_nexthops(rt) {						\
 	int nhsel; const struct mpls_nh *nh;				\
 	for (nhsel = 0, nh = (rt)->rt_nh;				\
-- 
2.43.2


