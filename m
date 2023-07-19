Return-Path: <netdev+bounces-18923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3005759169
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3AA1C20E52
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E2111A1;
	Wed, 19 Jul 2023 09:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8E11CB8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:19:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C59D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYNQXpQzGefo4g6zQqnETaZ8BkASidOTv2XNuvRZKao7o6iKl0HLTmKq4gIWjMDanL00JNERkKHjzwl/hBZ+ogjIXqULeNqoYiOAmOBR4p9pZ3yO1mBD4ui01TPpYaBl7P4PEX2t1rQAubpg6wBwGMMSkK0rbbdMLTZsOsWIaZEnrXamUWh83/+G+ErvoWs/4rc3bbHwXNfbwJQPviOl2pe0bVbnJzXKdloJVe8A7JC4J3u2956Vss1k8BAxvK2ZvVN+dVxsmEiMGNVn40NFf4sHlfjpfvSllDilQ/xb6yOGLeAX+0i4R0C04sZMARrZwjiRKRzYic+s403GgXegkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tcPW8nXDyNsawkfEe7s8eCT9C3xk8JcfDRxJ02hVBk=;
 b=M+kTH4MdLgpezrwrek6V2HcRdMpOGukYBNpFvE/Dfg+2ZDeqkpXix3s/5kUbrhzvuCqAXnmGnwiMSo2IJD4WcaQi5J6064TVisVGHZ0VaTDpT5vrNiSO8KNCp6Wqja1GQUBa206FO/YgVvE2HehOig3mTmXE6Wrrz77QDmhUelUkRGgX1rLIQlfPghGr77WgaIMzxxkYcehrVEzlyNm0TD8+lee9MgPFdcVNl07wNBsi2JiSsMkzGZI6FzeQZntlw5gdewh7Z7BjfRPAwDObK6e+QgBTNuoLWFBT8guO/DuToSmCHk9ceH2XBjeIyoAs/SJTBLYUJjlH+0MUcUeQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tcPW8nXDyNsawkfEe7s8eCT9C3xk8JcfDRxJ02hVBk=;
 b=iZFtJnB500/d7xNZsmTjZ5yWUt71Rp94uy5eaME+ENkRMQIxSB+oYi8WkN2FqhqkrNGjsY4d1AWfFSqjeMf+n0oaeKmvADaDhPBUX8AXxMFLuM6r/OCo89h8Sj/m05fY+g9+UDYH9O5y2NvX7r9pGSdYVMBDEkQX04GAgvww0EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 SN4PR13MB5661.namprd13.prod.outlook.com (2603:10b6:806:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 09:19:13 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 09:19:12 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leon@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Shihong Wang <shihong.wang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 2/2] nfp: add support CHACHA20-POLY1305 offload for ipsec
Date: Wed, 19 Jul 2023 11:18:30 +0200
Message-Id: <20230719091830.50866-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719091830.50866-1-louis.peens@corigine.com>
References: <20230719091830.50866-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|SN4PR13MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 198f0c80-6e00-4c4b-c3a9-08db88393712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	amWTT/ZTIpCIKuoOG5dNOAHRkwUOp+Iu8/UR9p5zh6VTjqh6qNKRzUKKS2/ywPPWP87+G5uwUsuvpCMRNM0FAvDXQ40yMUcSwklmSHjFe8gyqW+stWC2m8B/8xa0tJsabCPWCl0LwmcqPhIILoSEu/d55d8f54NuixohmfFYXQXEs8/+/6vwZcvnDcaIdUkHmTnIp22Sb5SJ3ZzgblTB0N5v/AhQ95MYPkIrKoPuHsb1If7lhGDMLTmphfK7bxU9sD0ChM6vLJhTCGdQW7LObmaEQUhcwfw2S5xFXBf86f9CscoQSpWBKRQF5ufx+lebD9yaB0ErUHYqAKzywvPFK7yS9QVqFixeblw6q+WaFGIBrZAeG6OAP/WVHHqeZQLhCJaeVLdVQwcuKIwqGEWnAomPlq2R291Mwqc/QkLaU6RqbH18p5h7XvlNn8jTVgZR6Se2+dthEPcIQ0qUHSE7DNppRuURhRU2Wopzfxd2Q3v0221HErvyM4yVePXgAd+QXELddxScR2HCI5wckdOLdVk/ToxcggEiFH5hr+Ts7qKZ1phI2KkOYAK+GN8LwlvhGruRmr+x83gVg+yMFAfhw/0JRw5tNI/+uawKTPSi1Eq/LojomatVRHrvqzQKp/082sJ3w+Lqj9XZZ8lifLckwzX3MtpjzX5ZKcd5+HmEAno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(451199021)(54906003)(478600001)(38100700002)(38350700002)(6666004)(2906002)(86362001)(6486002)(52116002)(66476007)(66556008)(66946007)(4326008)(316002)(83380400001)(6512007)(41300700001)(36756003)(186003)(1076003)(6506007)(26005)(2616005)(8676002)(8936002)(110136005)(5660300002)(107886003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/DYC0SgoYmU1S9CzKNseD+MEhX4e3xuNyrAAISAKO28ZdEtYtQhr/nDHP0Av?=
 =?us-ascii?Q?iKyrko0HiQ5kE6aMDodpWxqKZOD+r7qVK5GSZWyPWIUtlYHNICuJTMBhX8Uv?=
 =?us-ascii?Q?OErEIcG55SbeQbAhggDhKamPlZ9MNQoVm6AcbKGVVtfOvy7LO+Qt6Qh38JYB?=
 =?us-ascii?Q?aofCCUJm7r0IiYqLN8PX4jpmfG2/PLpgsPYrftYn9pJZW19awvEbzbWgt6Cl?=
 =?us-ascii?Q?P5CAxAt8MKgG4ylWlOdqcSKpyy/g4SyEq/jvVu6M+S0fj6TGO2ATGWZt3WV8?=
 =?us-ascii?Q?s07mNcoSEBs07yR5E9MKjePM2eddb07fplkNty0SP2iqay+C+WzE26orNAli?=
 =?us-ascii?Q?BN8aBFdAMXr6b5BBg1zfvdXGQvmYVs/8N2UtlKTMmVbj5IGf74RtdCrbPStz?=
 =?us-ascii?Q?Ijz53On6gPMRXHXi71spab2MnIvy9rmLpCtOqWPtGZaPoIhejVI7G2Pq9Rtd?=
 =?us-ascii?Q?bA9V2YHsRzeNbBdCYNpaGNGrTgAkceJYMNMMOk8zDl5zPtaq3jYUd073IW/V?=
 =?us-ascii?Q?DtJLb2rQVTmhEyJ/TOEEmC3EHtT0WcPfmzSqN//DuSmtIgwzQPQ5QXVmGSki?=
 =?us-ascii?Q?vJ2CPf16JQqi1EpoNa9jFZClhwRK2awrSxmImB2qpAbDzmoxa41TN0Uuiyju?=
 =?us-ascii?Q?aepTp3lyc78i/gMamBmsJq/xu6NNZciIYb7RLJ+ndZ2gcKHtepeaXLcKvRxM?=
 =?us-ascii?Q?F5jqCoCqRb+qZDoiIR5XYyrPnLQNIkW9QBse3lZL3eCS2pQQ7LsA1l3w7zw6?=
 =?us-ascii?Q?gzeaSTjvsq0zkF6EXTKcKxg+rq/ygdBvEFRwfCOtezttW4uZJbDfXTjs3q3q?=
 =?us-ascii?Q?kRELjxrbvgZ8xsj6QjK/51hWkptGPDT8fot7Nbhhp7c7EOoEOfLo9Z13vvM3?=
 =?us-ascii?Q?iihBEiV+Ef10QyhBK1DNUTkPiD+CucjMRiBT7NSdLc60p7fb+xqj/C/hqkam?=
 =?us-ascii?Q?z1Pqv/F930XHDdA4tLWT8RoqZpwgUu8nyJQ0+X+2H2QuonlqtKb9J1g5rsLG?=
 =?us-ascii?Q?wrq74GemLaKgiamuz490vxCulV9dTZbe63WSlyyj2ImVvJ1H1yJ9AsJNLPwb?=
 =?us-ascii?Q?QaNe95wvk+m1NLMg42Ba0w8DwvN0IQbvgfqnD1a+5VX89r9OklNRn1jA1pO+?=
 =?us-ascii?Q?U1VseV15X5+vVlnUuC4V71Mr6m840umdrYcPA6aTql3hJaHq4LpNW67ktste?=
 =?us-ascii?Q?/o2nHffCqBfGADfSpjaGz0mmnphSqIzRq8588HX59wHRPI/WrnAlKY1/Z3ky?=
 =?us-ascii?Q?Nen4ZaczQ/ZSB/yczTrGqAsTGz2WISjWmGjzPNykalE+U6hW3JmwlhRrDAju?=
 =?us-ascii?Q?36u5dDfrU5r0cWNtWO4+67f+IQJZaP9NJg8a4vBmzD+2ZHk+q61P3fT6zEiS?=
 =?us-ascii?Q?bcLIL+fguoqYd484JKWUdE/nQSof3w91vuaZFr2lZEaSxJjE2l/P0QEdcrkR?=
 =?us-ascii?Q?VkqtB3h6X3ekCIgDpf/O5oFoU+FSGP/rRzgkph193GR8TQ2ClQM8KEPGxQGN?=
 =?us-ascii?Q?CrAtddkD2F5s0WV0bbwSYV/yfv3NSMzC0l56I+pDxRmnZhrPc4Pdi77S82VI?=
 =?us-ascii?Q?g0xW6haAanZDNOMqU2XqRx7wf/LGlAvTBhKN2DFtaKCQYtEscZcu7V5NyA0E?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f0c80-6e00-4c4b-c3a9-08db88393712
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 09:19:12.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7q+PR6q1n/nqjcAeNHN5+8AYss6ihnHEoRLNoWbCODo6ZsGV+3ukvudA+nSUaMHAVm4oQKc41apOVSXt35wz+p5rFiGMeveobWDDjHJwsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5661
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Shihong Wang <shihong.wang@corigine.com>

Add the configuration of CHACHA20-POLY1305 to the driver and send the
message to hardware so that the NIC supports the algorithm.

Signed-off-by: Shihong Wang <shihong.wang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 42 +++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index b1f026b81dea..6b8a1874e4fc 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -421,12 +421,38 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 			return -EINVAL;
 		}
 		break;
+	case SADB_X_EALG_CHACHA20_POLY1305:
+		if (nn->pdev->device != PCI_DEVICE_ID_NFP3800) {
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported encryption algorithm for offload");
+			return -EINVAL;
+		}
+		if (!x->aead) {
+			NL_SET_ERR_MSG_MOD(extack, "Invalid CHACHA20 key data");
+			return -EINVAL;
+		}
+		if (x->aead->alg_icv_len != 128) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "ICV must be 128bit with SADB_X_EALG_CHACHA20_POLY1305");
+			return -EINVAL;
+		}
+
+		/* Aead->alg_key_len includes 32-bit salt */
+		if (x->aead->alg_key_len - 32 != 256) {
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported CHACHA20 key length");
+			return -EINVAL;
+		}
+
+		/* The CHACHA20's mode is not configured */
+		cfg->ctrl_word.hash = NFP_IPSEC_HASH_POLY1305_128;
+		cfg->ctrl_word.cipher = NFP_IPSEC_CIPHER_CHACHA20;
+		break;
 	default:
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported encryption algorithm for offload");
 		return -EINVAL;
 	}
 
 	if (x->aead) {
+		int key_offset = 0;
 		int salt_len = 4;
 
 		key_len = DIV_ROUND_UP(x->aead->alg_key_len, BITS_PER_BYTE);
@@ -437,9 +463,19 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 			return -EINVAL;
 		}
 
-		for (i = 0; i < key_len / sizeof(cfg->ciph_key[0]) ; i++)
-			cfg->ciph_key[i] = get_unaligned_be32(x->aead->alg_key +
-							      sizeof(cfg->ciph_key[0]) * i);
+		/* The CHACHA20's key order needs to be adjusted based on hardware design.
+		 * Other's key order: {K0, K1, K2, K3, K4, K5, K6, K7}
+		 * CHACHA20's key order: {K4, K5, K6, K7, K0, K1, K2, K3}
+		 */
+		if (x->props.ealgo == SADB_X_EALG_CHACHA20_POLY1305)
+			key_offset = key_len / sizeof(cfg->ciph_key[0]) >> 1;
+
+		for (i = 0; i < key_len / sizeof(cfg->ciph_key[0]); i++) {
+			int index = (i + key_offset) % (key_len / sizeof(cfg->ciph_key[0]));
+
+			cfg->ciph_key[index] = get_unaligned_be32(x->aead->alg_key +
+								  sizeof(cfg->ciph_key[0]) * i);
+		}
 
 		/* Load up the salt */
 		cfg->aesgcm_fields.salt = get_unaligned_be32(x->aead->alg_key + key_len);
-- 
2.34.1


