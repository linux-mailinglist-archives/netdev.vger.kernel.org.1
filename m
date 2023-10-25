Return-Path: <netdev+bounces-44105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EF7D63A8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E784F281C67
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721341773A;
	Wed, 25 Oct 2023 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="IZkJRTA8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977218B08
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:42:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2098.outbound.protection.outlook.com [40.107.237.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8061270B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ber8Pcjz3CSULzzO9gdMogcDJHGnoHVko2kBcQo5yjin/Dg0OU3aC6r2aer/DoCFQBQxGqDUuFrmz+V4YwNrZzuQRHZKzYdASJyN5S02NlI+jCpEdEAvIeftL08J7YhCtoizRimQyvWxOOeMGpeMYRLptwXWm++pnmAPuhHZuWRezVduy6ocWoqFHgeQYEUynPk+CPb0kc+Ke8JswHuSmMuIoS4zVrXS09dJ38ygFw+FWa2uYMX1SHVmJL6CWxdgw/wNMcixfIb5HIHuoXeqZWFyaCin9AY2I0njNBL521pUAj67GvKNCLehsivAA0USBwfZZXUe1i7UIsquhe5Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7PiRijvr2wc8PfeyJzJqYNg7z+t62V/YwYlklew8vE=;
 b=EWta+1bfM3PI+MqFMcvDkwGTshCv3t+B2YEO6jem8vbHdmhoX34Uf77Fc0nBUSFB/f+MX0b4uRu5gfQbGLoyDm34k4MrlKom0gdRUfC66vGaS5lfPWb5L7uOvj4RKUtkZTmIKOMsuorBu1dhteU1cEiWC125kf5sTbs/N32BfwXwJtztU7BIE5/VIrIDmwDOgsf8SmyxJc+1fN7vjNTxwCqumj7KXnQFCHjF1aGCRHObvSiqRrDAmRAqHTlF9nyNS5FJ9N2NjBqgqr3CkUrQhq2KteDhtyzXPieEfO3q3onGTPjdUcvYWIO/mSSzvk+olMWHvaQ/biFEqjsOR+jdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7PiRijvr2wc8PfeyJzJqYNg7z+t62V/YwYlklew8vE=;
 b=IZkJRTA8+4GNVH5Hsxdvtw8SGyvyKQDjLew3n7z1mYd2VD/XsYyDI//pk0GhbJgBSh4vfLyQGdezG5XFMT9in2CuLhkyiu3oqdtrwHlXQ4bkgcJxdd2KNAgR1uTAa4iQqJ6jq4qRecHCacva11cVGhw/KazGqXFDu4RWpWcXbJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 CO3PR13MB5814.namprd13.prod.outlook.com (2603:10b6:303:172::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 07:42:06 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::b6f:482f:9890:acec]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::b6f:482f:9890:acec%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:42:06 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next] nfp: using napi_build_skb() to replace build_skb()
Date: Wed, 25 Oct 2023 09:41:46 +0200
Message-Id: <20231025074146.10692-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|CO3PR13MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 723543d4-7005-4b68-e3e5-08dbd52de335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/bKrxw1lRnGRb87erDq2P9o70Wa8zbDX+djaksucRGx//5uk4SDh2+TOwcKiIZ5hjITXLdKsek5Fj9+HLmO55gMK56nvdGCZJiDYyk+LZ/rEtp8bzS5fw/zFbf3U4rfyrwbm7MJXAFyKkkhiQ46A8dEivuwzgsFROsODJcJzxpqm3IwVjhF+wrZesXG0OhkDAME5hyvJQyBTdvPKzcsSySYx6w8+vmNitCPK/rCBbriTw8i+qS0kPpijJtNFkosj3QZ4hTy15RBAPoE6JNUygHlV0VHkUZi2IilSvYJWLKlvzBG2KDVHy4jTiDhBVW5Swf/EYM7L++KD3rYvoT731/7XUUjY+P48VEvBDQOCOGpzGKM8rSEuG+HQ7RMNPh2kmawLFqpaZFwR5KW8Sns6/30GrkmvZt6dKW1R1SqCz0cd+6RC8RiXeeAVSOecqJrhTdzNXJj5J3o4KRDZaEAuTXoJsz4kmm2ivBEmUHmE25VBXi4LcQ1+YQizsBliRxTeAXNxA24uG1x5ijSixcH5jjmkujyDYTPHJJUwqDMBV6h5bcCxLlsCFLfPr08KRI+6hRS0MObn8uofGhFHH1XHm9o5l0pQX4ARQjiqVqxjcw8KPDts62bj1ocCC7rGG7ll7N9T5T5RGVindEP0EO5OzXypYvN5VRKlEtoBY1nun7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39830400003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(38350700005)(36756003)(8676002)(2906002)(107886003)(1076003)(8936002)(38100700002)(4326008)(44832011)(26005)(2616005)(52116002)(5660300002)(6486002)(6506007)(316002)(6666004)(6512007)(66946007)(66556008)(86362001)(478600001)(110136005)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T1hEIPx1HkYgvpU477ke/4T3YPoBQISXGCEflvf+fHCbKEarBWnMFm/DOE7k?=
 =?us-ascii?Q?gNcErWCxhfyrMMj5EbWjIpAGr6y9BWOGak/iuU7Y4KN+3tiJwlcU1Wmp3VaE?=
 =?us-ascii?Q?tu6gbCF4AmA2BdQqzxXqh7zK5Ioo7FnZtQTyF8YeqOYA86DOV/+VP82Ef8HD?=
 =?us-ascii?Q?A/aPczq4Ogj++NrGY0Q7ynBxtP6Y9OkFugbBHIV2GHnTjjQThKm6somkvvmY?=
 =?us-ascii?Q?0rBbprzEOIlXorpyyLoocNWc4oc/DW84WZtku+OlT34/BVVxTKvJCNbL2TWn?=
 =?us-ascii?Q?4qF4IK/u0hC06UTtsGwehSCSs7PeeEcMVCCV+g+O4Dggohqw22KgeEcBAr8V?=
 =?us-ascii?Q?qjKZReO5J8oxARlutINqqZJ+DAPqK5H2teK4a/rQAbYZbifCYzMFXnO3b2lw?=
 =?us-ascii?Q?trDzVuxTh6i6vlj079U1G6txulaUGxY/7fSUEwqm6epuE4SHLcTM36F9xrCx?=
 =?us-ascii?Q?9Nz67yK2ZbYi2VLequw3I4Zx+akmz8Z57w0RMmJQrzaL5evkcxjUWG6jwFC8?=
 =?us-ascii?Q?Dxrv/om9SkTeSaSp/vh2dg3t07QQMPEkzSndON0wf34eYwv6ds7txqj62+GH?=
 =?us-ascii?Q?RYPtc13Q4ACbgUierFHCyh6+MHM4kyTFL79O0Me+dBj8iBCIsa2LEXZwz19Z?=
 =?us-ascii?Q?mtddwQ+2oyXII13HW9fnIBo3QoKCOc6oLScyu2NpgZguSUgf1+p6I4XwIVkz?=
 =?us-ascii?Q?N+Oqdz/LwpY1Ds9gezzSOs5dPm10Kasy+f1F5jkbl5BpeT31frmnHJL3B1s2?=
 =?us-ascii?Q?VuIPqY8mxjNEQNxmDwaE55IzJ2lEOH6Pdk4gsSe+1dmXe9S3O/fKDrmdGYK4?=
 =?us-ascii?Q?fq8bWWr17ElUD8M94M05FoACH7hBhVgfN+cldmlsn5NQ140l5fCreN78uCO4?=
 =?us-ascii?Q?UbKGQNcWLHYc5jQowzMHjW+zQ/6LvBhLotAxHuX8hrBJqTWoTED9BneI3FlF?=
 =?us-ascii?Q?Ye/giFeRi8qJl2akgjrmlqTrlL6QHVGX3sWDbEDlbNCFmwQFoISxqARKahZX?=
 =?us-ascii?Q?V5pzrL9XxRrjtGkq0cUVt9yXHF8MnyWamPomnYQXCA1GIV0Otkgc0Eju8VH5?=
 =?us-ascii?Q?A9uE7CYmiSePkdo4nnpNJKjP1YJ9wkUTiJaGbdvViKzeamhmnE+Q8oWvcIbe?=
 =?us-ascii?Q?GG2VeIyD+OVjUzEl3k3zp0/Lw1MjfmgwnZgNMUpkGAKkV2egNll9qgxZp6+k?=
 =?us-ascii?Q?t3hWEZ2ZVJxXax3lUZPTzRJ/hO3l963SaDkIo578W4qLaxapv5NAi/qStrXY?=
 =?us-ascii?Q?eytWFFyb2ipEZnHCL49baWN0S3C0hZwX8Uml/8ZAuEWkOccSzLyBwOoqlSju?=
 =?us-ascii?Q?a6/nSh04XYGfrLaz2kYVUgL8DQFmOEVOKWDZk92he8DArS6WiFI6A9Yy30rg?=
 =?us-ascii?Q?0Zc0RlnphtG/o2mQUlEnf7iK43K6kv+9wI5T/j5L+COpdtoee4HAgpv9e6kz?=
 =?us-ascii?Q?xPUuJoo/3Of8BJW/MZyfYo2aCH8/kAA0u2u4QZyDwBVVXk5lsc3xcrIYf/fP?=
 =?us-ascii?Q?FYQ5TAS6OR7IP33nZJbkg5k9XFYcZFCiJZ0P6S7FWBgAg4g14Pd3Xv8qPfEu?=
 =?us-ascii?Q?E/KsU94H+MbbIvYAHO6cPxm0/wXE4UQghk4rcAEE7vTsqMbQCoZlmWJclfxf?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723543d4-7005-4b68-e3e5-08dbd52de335
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:42:06.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBdUIOgHgjHnhYqjY1W7p93K8UlOuKyetHveFF+MizjTeJsexk6ixwQ46FUqLX6YcQp+7ql9dQ2j7KmXQh7vjz7XCllup5pxRfkR3TYKNI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5814

From: Fei Qin <fei.qin@corigine.com>

The napi_build_skb() can reuse the skb in skb cache per CPU or
can allocate skbs in bulk, which helps improve the performance.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 4 ++--
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
index 0cc026b0aefd..68bdeede6472 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
@@ -1070,7 +1070,7 @@ static int nfp_nfd3_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 				nfp_repr_inc_rx_stats(netdev, pkt_len);
 		}
 
-		skb = build_skb(rxbuf->frag, true_bufsz);
+		skb = napi_build_skb(rxbuf->frag, true_bufsz);
 		if (unlikely(!skb)) {
 			nfp_nfd3_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
 			continue;
@@ -1363,7 +1363,7 @@ nfp_ctrl_rx_one(struct nfp_net *nn, struct nfp_net_dp *dp,
 		return true;
 	}
 
-	skb = build_skb(rxbuf->frag, dp->fl_bufsz);
+	skb = napi_build_skb(rxbuf->frag, dp->fl_bufsz);
 	if (unlikely(!skb)) {
 		nfp_nfd3_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
 		return true;
diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
index 33b6d74adb4b..e68888d1a5c2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
@@ -1189,7 +1189,7 @@ static int nfp_nfdk_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 				nfp_repr_inc_rx_stats(netdev, pkt_len);
 		}
 
-		skb = build_skb(rxbuf->frag, true_bufsz);
+		skb = napi_build_skb(rxbuf->frag, true_bufsz);
 		if (unlikely(!skb)) {
 			nfp_nfdk_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
 			continue;
@@ -1525,7 +1525,7 @@ nfp_ctrl_rx_one(struct nfp_net *nn, struct nfp_net_dp *dp,
 		return true;
 	}
 
-	skb = build_skb(rxbuf->frag, dp->fl_bufsz);
+	skb = napi_build_skb(rxbuf->frag, dp->fl_bufsz);
 	if (unlikely(!skb)) {
 		nfp_nfdk_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
 		return true;
-- 
2.34.1


