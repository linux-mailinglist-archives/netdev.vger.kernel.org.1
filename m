Return-Path: <netdev+bounces-55189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A5809C2A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 07:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C1281EBA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528F7473;
	Fri,  8 Dec 2023 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="SzWBwEua"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2122.outbound.protection.outlook.com [40.107.92.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B4DD
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 22:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq/mhHdVZG/+ME9Q7FlRIdzV4dhrv+wLk+iydKpwHDmoWtukfZ0Cv8bLGMiay7W9Q12bzbE8uX1f9O2l4Mrch8MfCA1OlcEp2xPE5fZZauj5nNMhoq4msJAUo2oI9n2A7lPkZ9bvBUWYnZAkAFsRp6qrLBpQpxEO0Sh8CF8MZHORbsdLWEE3JdgRZN4MBLwiWov1xFhrilDPKMXEQjJ58RjXiTe0V1kB2mBvlk/JpGfqSZNYu3Ghytq24AZ6zxHJDp5BU4AOlhXAbapYIJGnrUMUn/RsXD+1fGcFZGH8GB5C4ZnlLV4SexGIJkqno7yEVUShi1hTiscspW8xDGXPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y7Fb7gejbatPcq92lAb34KtDnUYLxVSeC6uS97O/gk=;
 b=G5Bf74PfAyaXAsJa5ZgeYfuR82VpZVzKRkxuvmJMSkvBvbI5qeCC/rgFYfrYwZ0k3r7qs9McWWExOQFSWS/PsDJ7L5y3WTYCFzXFYSE/zC6VX9rzmWXXhvFOY4D0HtBN+YHv+2ZUC5UevuMA5Bs+9Y+Kub1Xa1GcuNl5tjT78APjoj0k2PZ0S+tqXfTcP0yXdYsLB9aI7KGo3sktU8hb9/Yp9aPYdioyd3tJwB+imgGcmcaSaZMV3LnKoQHMH07xPPYxvcwqrfOTZ+nwhR7kh7MqmxQ0IgAPcYigE5QDcqAaalSGPk5+chGgs1W5xDaCnQuFTAR88W/dR5xXdWoiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y7Fb7gejbatPcq92lAb34KtDnUYLxVSeC6uS97O/gk=;
 b=SzWBwEuaRAbPP9x4ODTN1X3+4C2Pe1qWWO+WoJ8yXt0ERw3tcKMAp/hl1Yes3lw7LPGmTMUCxtwjU3baTB6eSWSPWwwaGpktBLNHj6EThpYAjRxtmzJ4DzH/W7VFJeDnFa9i9HdM9EE/S1Q80NBmFfbuUohLb/eF+6+65INyfzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MW5PR13MB5970.namprd13.prod.outlook.com (2603:10b6:303:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 06:06:49 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 06:06:49 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next] nfp: support UDP segmentation offload
Date: Fri,  8 Dec 2023 08:03:01 +0200
Message-Id: <20231208060301.10699-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MW5PR13MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fe9b72-d86f-41ba-7597-08dbf7b3ddaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OIl4IHrRaGMMMXoDfUlZJKS2InE1RLIoqTYmCoyZE6FeldLpakhAuzOBYWR1iSOaaqnu9YwW/Q7sC63z/aBzF+wIV4uBggftWdYO0oSIUw86WKeZvXJm8FN3rHwzDT4OH01PyhFtqD655F5SCLjdfnPVpb8Gpy9eakFsE81c/tuyM34WfAH1sFPA1tEk8O25ExlDueIb0V2BhYgHesEfJiCgL2oc1mFQ3EgMAW821DrMs093OSGNhxmhxZFoCSvSVTBmiyy7cq+1cb6HfR1/lk04Y/hBnH/FQEW8g0DtN/9DwHEYZEIxSChZCjCb7BQ7iAqpgXOQaf/9C3PALKlw2Yx24RSaLQAA2g6dvxQI5AmzMq9hUZnSRl3aTmimy4HbqEa50Fo9I36r096aimXoqGd6H3h1C84+V1ns6WozhpupP5T8WiAoeGoF+zuK7+CeboPhx5E7B4l4WptHBp6Gr8S7+vpBKOjvB9Zqjyqurs1kl2BblnmFj649Ve1PFzRBiJzA22SixnMWxIW4W1PFP/QDQ7nTbFRNBfnQvfSOcLvJ6xx1Eq5HO6C+rLlhS4gdlmNUh+XJz3wcJDVrTt9xoZf81zsYay+VrtKYpPink0naBWf7vOUlaV4eXr7o83hEtTTqXEnLl0nWicGxxN2Z+2FeyYmkRnnz3HT90tFvJ8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66476007)(316002)(66556008)(66946007)(2616005)(8676002)(8936002)(4326008)(44832011)(5660300002)(478600001)(6512007)(2906002)(52116002)(6506007)(1076003)(26005)(6666004)(107886003)(6486002)(83380400001)(38100700002)(41300700001)(110136005)(36756003)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+JlM2pZncPL3MFrFoJORWpHQVkuJ2EuRPIIIsY7jqox6WVadgW679GHZC0c?=
 =?us-ascii?Q?FrPnyYQgabxO0Yw9llUeuwowIrQWH/ee7DRjjZVdTqhcaYbswUH5Mo9g8nkd?=
 =?us-ascii?Q?66RE9ZBBMhPwiBCeww0RyDU1u67b4o/btxKLBFXiwLv5YNhWCF2dxOrUjStd?=
 =?us-ascii?Q?AWYkwj3f4wypsr6BAnfNq42Rf8kCBP2opuMM1KnUNe9TMNmhBlpbKvSztSnV?=
 =?us-ascii?Q?CFfIiwqg1fYLbOm8JNViuHqdCL9pLRe5Jxpef6wlYMvSuujLJ99CziCBuGTK?=
 =?us-ascii?Q?FKHIfDgKDyp1f7bHc7/ylXWmypgPBca/VxC+/SlinUFac/jf2MeQ8B203x1V?=
 =?us-ascii?Q?TP8cUS74mfqpEJ/0f8rdXaKpmn5XJcqJPXhZeK+NMhzco/lDn+UXrKZsUziX?=
 =?us-ascii?Q?huTvWxTsHfn4tCG1XpU6apNjPakhtDoO0CWRFJgL/V9voftuIuEWo1y8TkKo?=
 =?us-ascii?Q?QKrM7vCEQkB53npQky493YAKjL3rIP3d2PzIkZd1AICcHYLBpfFm8+TI61Gq?=
 =?us-ascii?Q?Eqvl9va8QsIheWYg4m7KLaFuBIlhvWapWe8DeR6iSMQMjCULkCwMEiuAzAZC?=
 =?us-ascii?Q?+bTZq7Dsla/GpFZjOg7lJ3iBUWkscOM8+j2QB0cIRBVgs+KXolKP9uO45M7H?=
 =?us-ascii?Q?LIWBEREN79OII9lEo66ZhIwUx7lQCvhETPJew+bCfF9MS6zi+ZqHhqAoq6YH?=
 =?us-ascii?Q?eWv9quD+DKQTplj0I0YJ1ShlpWYQY8Xd3C75DHTJ96rA9zfsPzvo1Zdydjla?=
 =?us-ascii?Q?GMzoP9PoNXM9t9TnDqFndMqSDuLIyqx8VNEJYImioOpEg0RSoECzxXZbf274?=
 =?us-ascii?Q?6iPoZBMUxfCldsqM+c7KYM047W6iQD+OznJFEoYYZjlmyUJOFfFPQP/6u8Zc?=
 =?us-ascii?Q?DXHsnVwOh15HEhy6iiOSvlKQRLnq6CgqzZ9BMzxbkpne2mOs08zU4IVprsjG?=
 =?us-ascii?Q?VHxuRkAPPIqAPQY+3RFfKup+ePH0L2eafX9NHvN7umQMYHH3SXJgWLBUvDSi?=
 =?us-ascii?Q?AnY0yu2/VNnQ0vMLKWJlCQzji6PZfLS2x+FaI9kRXrJSru/UecLaZ5eOF7NZ?=
 =?us-ascii?Q?Dxr4R5RBvOLQuvao4c6Ue/F/987fR0txEf7Pw3eWyEDohdltPHvOrJpv0oP/?=
 =?us-ascii?Q?4U2ohwxKBfo5aI8bV+JjUZJ5BoJ34jZXZk6g3xHEUG6VaxsJAK08OaTc0E8h?=
 =?us-ascii?Q?QHY/lAh/CoHz0rGGBO1T68V+F9l4hSb+ODc2tIuvNBWKEMSOdTMAoOGC6W83?=
 =?us-ascii?Q?8Rbxjka7fphTbS9chHy2ihhynYxSwCViSPZoz9XtTunwHN7AaS6wsSKwRxZD?=
 =?us-ascii?Q?oVTQQ3Md+KbS1VZ1dhyWb05M2O3LYGkCX1afoonatMgY8Yn5QMrhejyMQ/YS?=
 =?us-ascii?Q?htS48kfj1FNo9sljJpewG3rZ55Zuepm9Y6q/QDuLnzdWPZba1T/phgtOUZof?=
 =?us-ascii?Q?m/gVzfbCaLEduUntRQHyNaH1UCg5ELtrqYmlGIrbSo8hRbV+a3aYsbrRCWtD?=
 =?us-ascii?Q?GmLCUfSUQ3z3l4aKEG3pVdJTqK2ZBZRrFTf2Lm7fKP5neHxipyEWivztNbPw?=
 =?us-ascii?Q?NJKuxa+vLmZHSSQjVmpQgbysAPk3+655DwyLdIzEV2u/vc5vG4K0iVsiKtpc?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fe9b72-d86f-41ba-7597-08dbf7b3ddaa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 06:06:49.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBx/OazYtsajXy/qr+yEngc9ljPwtkXZhzzUVwFRjMBfsg2xJvcb3u7cvCTrD/L6QyM5tUsUOU/ylqI9v95K7ZeGP3ojanpSPJJKN5YCsyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5970

From: Fei Qin <fei.qin@corigine.com>

The device supports UDP hardware segmentation offload, which helps
improving the performance. Thus, this patch adds support for UDP
segmentation offload from the driver side.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c        |  9 ++++++---
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c        |  9 ++++++---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 10 ++++++++--
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h   |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
index 17381bfc15d7..d215efc6cad0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
@@ -74,7 +74,7 @@ static void
 nfp_nfd3_tx_tso(struct nfp_net_r_vector *r_vec, struct nfp_nfd3_tx_buf *txbuf,
 		struct nfp_nfd3_tx_desc *txd, struct sk_buff *skb, u32 md_bytes)
 {
-	u32 l3_offset, l4_offset, hdrlen;
+	u32 l3_offset, l4_offset, hdrlen, l4_hdrlen;
 	u16 mss;
 
 	if (!skb_is_gso(skb))
@@ -83,13 +83,16 @@ nfp_nfd3_tx_tso(struct nfp_net_r_vector *r_vec, struct nfp_nfd3_tx_buf *txbuf,
 	if (!skb->encapsulation) {
 		l3_offset = skb_network_offset(skb);
 		l4_offset = skb_transport_offset(skb);
-		hdrlen = skb_tcp_all_headers(skb);
+		l4_hdrlen = (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ?
+			    sizeof(struct udphdr) : tcp_hdrlen(skb);
 	} else {
 		l3_offset = skb_inner_network_offset(skb);
 		l4_offset = skb_inner_transport_offset(skb);
-		hdrlen = skb_inner_tcp_all_headers(skb);
+		l4_hdrlen = (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ?
+			    sizeof(struct udphdr) : inner_tcp_hdrlen(skb);
 	}
 
+	hdrlen = l4_offset + l4_hdrlen;
 	txbuf->pkt_cnt = skb_shinfo(skb)->gso_segs;
 	txbuf->real_len += hdrlen * (txbuf->pkt_cnt - 1);
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
index 8d78c6faefa8..dae5af7d1845 100644
--- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
@@ -40,20 +40,23 @@ static __le64
 nfp_nfdk_tx_tso(struct nfp_net_r_vector *r_vec, struct nfp_nfdk_tx_buf *txbuf,
 		struct sk_buff *skb)
 {
-	u32 segs, hdrlen, l3_offset, l4_offset;
+	u32 segs, hdrlen, l3_offset, l4_offset, l4_hdrlen;
 	struct nfp_nfdk_tx_desc txd;
 	u16 mss;
 
 	if (!skb->encapsulation) {
 		l3_offset = skb_network_offset(skb);
 		l4_offset = skb_transport_offset(skb);
-		hdrlen = skb_tcp_all_headers(skb);
+		l4_hdrlen = (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ?
+			    sizeof(struct udphdr) : tcp_hdrlen(skb);
 	} else {
 		l3_offset = skb_inner_network_offset(skb);
 		l4_offset = skb_inner_transport_offset(skb);
-		hdrlen = skb_inner_tcp_all_headers(skb);
+		l4_hdrlen = (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ?
+			    sizeof(struct udphdr) : inner_tcp_hdrlen(skb);
 	}
 
+	hdrlen = l4_offset + l4_hdrlen;
 	segs = skb_shinfo(skb)->gso_segs;
 	mss = skb_shinfo(skb)->gso_size & NFDK_DESC_TX_MSS_MASK;
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index dcd27ba2a74c..3b3210d823e8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2116,7 +2116,10 @@ nfp_net_features_check(struct sk_buff *skb, struct net_device *dev,
 	if (skb_is_gso(skb)) {
 		u32 hdrlen;
 
-		hdrlen = skb_inner_tcp_all_headers(skb);
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+			hdrlen = skb_inner_transport_offset(skb) + sizeof(struct udphdr);
+		else
+			hdrlen = skb_inner_tcp_all_headers(skb);
 
 		/* Assume worst case scenario of having longest possible
 		 * metadata prepend - 8B
@@ -2419,7 +2422,7 @@ void nfp_net_info(struct nfp_net *nn)
 		nn->fw_ver.extend, nn->fw_ver.class,
 		nn->fw_ver.major, nn->fw_ver.minor,
 		nn->max_mtu);
-	nn_info(nn, "CAP: %#x %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+	nn_info(nn, "CAP: %#x %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
 		nn->cap,
 		nn->cap & NFP_NET_CFG_CTRL_PROMISC  ? "PROMISC "  : "",
 		nn->cap & NFP_NET_CFG_CTRL_L2BC     ? "L2BCFILT " : "",
@@ -2448,6 +2451,7 @@ void nfp_net_info(struct nfp_net *nn)
 						      "RXCSUM_COMPLETE " : "",
 		nn->cap & NFP_NET_CFG_CTRL_LIVE_ADDR ? "LIVE_ADDR " : "",
 		nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER ? "MULTICAST_FILTER " : "",
+		nn->cap_w1 & NFP_NET_CFG_CTRL_USO ? "USO " : "",
 		nfp_app_extra_cap(nn->app, nn));
 }
 
@@ -2696,6 +2700,8 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 	if ((nn->cap & NFP_NET_CFG_CTRL_LSO && nn->fw_ver.major > 2) ||
 	    nn->cap & NFP_NET_CFG_CTRL_LSO2) {
 		netdev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
+		if (nn->cap_w1 & NFP_NET_CFG_CTRL_USO)
+			netdev->hw_features |= NETIF_F_GSO_UDP_L4;
 		nn->dp.ctrl |= nn->cap & NFP_NET_CFG_CTRL_LSO2 ?:
 					 NFP_NET_CFG_CTRL_LSO;
 	}
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
index eaf4d3c499d1..634c63c7f7eb 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
@@ -270,6 +270,7 @@
 #define   NFP_NET_CFG_CTRL_MCAST_FILTER	  (0x1 << 2) /* Multicast Filter */
 #define   NFP_NET_CFG_CTRL_FREELIST_EN	  (0x1 << 6) /* Freelist enable flag bit */
 #define   NFP_NET_CFG_CTRL_FLOW_STEER	  (0x1 << 8) /* Flow steering */
+#define   NFP_NET_CFG_CTRL_USO		  (0x1 << 16) /* UDP segmentation offload */
 
 #define NFP_NET_CFG_CAP_WORD1		0x00a4
 
-- 
2.34.1


