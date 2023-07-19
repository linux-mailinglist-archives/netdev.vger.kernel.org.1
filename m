Return-Path: <netdev+bounces-18922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486AD759165
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02854281672
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5011C88;
	Wed, 19 Jul 2023 09:19:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596DDDA1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:19:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4310CC
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeH30uaqJ3ZSgXHqfuDUKXtFuHfmtk5a+nP/7Yj7G5mtqKjdZVWvcz4t8OlUN/b7tiK6AFAbTt71qxrjU9ctCWgt7+t2v2TVCEfyfB3kupywF86KI07MurhLYbLLM+BrVEaksEIW+JGU1gCjqzjUM7hlSyOgdHjxbJed/itYJtnO9TeU8bcUwIgeMnMyk62dyglXskWBiCgdg+jrlkmBrD/7JfHwFiXnlmrklOlZRXIRnf+F59S1ZO7B+4eUjBCQ73PAnX1uIV6FP2eWGyPaIl85UuLRovof6F0bqkwXPCm+2PT/AhFi9K4bz6d2WRb3CWKjiXqTqmOvWK8RmeYmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6G4rduk9kRLG7wpHItEbNdYmGiU7fRXUjN7AuzkYuCE=;
 b=XT+/Yy8fQDHTJukDQ4foNe6iZfQwWhwfVVcrCnMuKOiQmgexyrJkKpnLVVxJpfm+xB8evlItiAeR+gGBBFUBJMaKyU4KctRfM/BkxMcYcmgiReSQc5y5PUQ+jRfyfF1VviNtWIkfVX2I7AMHHLxzB1odUusChExzcWdx5zIozYdUPt7zea2pUcpV3PfMlZtdKZzf8G1sS4cv6S5UQNy0v/NXlmTtVy2hra8dYW7AYnd0gFbP0dhKeMn1B5FJLeU9fPr+lROFh0tgEGMNwNzw8Z+k34hj4D7+eH4UDLYpD9hnJuS0vBx+xW3mMolL9Rr+96GQ0ROy1tuBOHjn80gVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G4rduk9kRLG7wpHItEbNdYmGiU7fRXUjN7AuzkYuCE=;
 b=SmmA1gqiT5NfhzAJIjRT0yJnxuEa0DocZFo8OgJk1+h9r4o/oFy2R2nTBsDfW46ioYQlHZ5L5DQ17E1nxpaiz+nJagArLEoj4Lc8sEklXbkym2RXcIdsS2bLoGFJesBG77QToAufOLUbClxX01RW/CdAb7N24pGe3c/VWXdlYxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 SN4PR13MB5661.namprd13.prod.outlook.com (2603:10b6:806:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 09:19:06 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 09:19:06 +0000
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
Subject: [PATCH net-next 1/2] xfrm: add the description of CHACHA20-POLY1305 for xfrm algorithm description
Date: Wed, 19 Jul 2023 11:18:29 +0200
Message-Id: <20230719091830.50866-2-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a95c77a-afd0-4285-22d1-08db88393397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wK1dlFqMSk/5wAcfaH2IJfj/CwKBd3W91ZR3WyqUg7nLWGYRiStEfYMMshmKWAL8qbtuDWiXjfJ+278py+mEMAFyo8sL5LddeWst6eQPEtiv9tDFqhqpcZSozLNWfTzJn+BGzKzl+CnKJMQeibwmrnyymcKzu7REP5uIb0oi5B9/LINzP1XMrxw6LbeJrx1RS/r8WJcSFio0mrFSYxswAZG7NlVzWAp2yqeO7HMR6d7g5RE1NuWL6j7RRKph74zGRe33PnMkx3QbuhWGvaJzjuJw2eAmrYAmAzUfKMOhouDaTQjmmvyzSJfwHN6goGKf97dmUytvIzUgx+b4TNYIVdML6oJoj8xGuIO4Ka1BCdRqvrSJmFojojmRKBffUyKefzZmJ7vI+qUvpsR2gNbYFnu+lKdeNGVcYtFfQnkHnI+hLv4m4G5hmVqzpSYTCAp4jwLUN4Wcbza9M7f166eyHBxcfpdGaY9AWbGJ+ZZBTKthm1fuwF+9UUSBy/wZi50CISCfWGObprJrLFfz9cq5BZAM81XIG6upmYEybNCW9XQ+tig/zlboDy1AsnWvcuyaMUpWgJ1q08sD6P0HYTEL63kALDNdJ0BWDI7v4RwkPxtD9fdE2xaXkw/L8gRNGmA6lFAo2v3ykrxysY/fB2mY9FJgQdbXAyuspFvYPYo2Idk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(451199021)(54906003)(478600001)(38100700002)(38350700002)(6666004)(2906002)(86362001)(6486002)(52116002)(66476007)(66556008)(66946007)(4326008)(316002)(83380400001)(6512007)(41300700001)(36756003)(186003)(1076003)(6506007)(26005)(2616005)(8676002)(8936002)(110136005)(5660300002)(107886003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iEtbUJilaz+rjCgrrUYMO7KNWu7MNKUtvB5YGocvFw2bb4PCPGsYSf815q9z?=
 =?us-ascii?Q?YeIrZI1xU+EdQCEDdlWefJ6Qc78UB67mmepdq4KddqxlbkUBpkBZGhAmdzNJ?=
 =?us-ascii?Q?Bkh19zkBX9KYCmkCI1oq14+nn+dzUcst7DPGuzNczNrs2k3b8r4d+8OsXm+S?=
 =?us-ascii?Q?wySnUSkBcRxY+SKNeHTCUy8OInbdlK1ScTDdHnE6qQjzo78sY5WtTQSlJnuB?=
 =?us-ascii?Q?Aq5jGYYH4625ZphezFlz3GCIdE6U3iuB9rA1NZue0cVA2f3JSOVpJRnj6Ho6?=
 =?us-ascii?Q?FBTzZkujdE+RqO/G2NG4x3c/ypj4sYl2XF7YcSAqNWcIeSbPmbw8V+YsxYfM?=
 =?us-ascii?Q?lJ2zwyjxVz74eKbEI1GKOasUwejpFPvI8yVb8gs/Xwqnm7SymIJYm7t7BydD?=
 =?us-ascii?Q?MEBDWWgaLcul1dLRstM9tk6Vu04ZH03U9pSLp6yorem/y2I2yhGJ7/+Pc10p?=
 =?us-ascii?Q?NLJ4YhSp57JEcytyMDZ6sBFzLpDJkzHRXrD93+a9H89WOS8cGuLyhJKLiAOz?=
 =?us-ascii?Q?HBJkyS8t4qTCKPx8GuIExMoahUXx3ufUPDtWhbP1edIujgcuU//l2KGVMNGT?=
 =?us-ascii?Q?q55gaDGvYL3tl10RQY1MS7XXLgCe991mSL4pQUjNUol7EGshcHKJFBlCFRzm?=
 =?us-ascii?Q?EyQj5sYUHonBy4JgzKA2SlVHlvh/LuvN6gk5RfLrCZizTxtRAjE6NaFiwGsN?=
 =?us-ascii?Q?5wMIhZnTEe58/HfKyCI2d5TGX/c7LNbhgsk8PPPQTVaiMmec6Sn+cKTNYFIu?=
 =?us-ascii?Q?q3em6tmJ/Vn6h6n4PRqRWrTLt3UEFAmpMtfmGxIdzXutclpISvJZwh0dP2/q?=
 =?us-ascii?Q?jvxANWiJrzoWTccxvqRpZsiGq6wyfMu4QUv3iUZOUi3Hb71GFkFkMvdL8OiZ?=
 =?us-ascii?Q?yBtbYYYBNfrrUJ/7CVVhOosRtLS9HlxAgnF/kRcyHGdLDDdM3YfTzB+uOynu?=
 =?us-ascii?Q?ZM2Ul5QhOxPyqNnfIvdLnh9fCjtJHHRPoalcgMJqwBwwGNE8t29HKiJo0fbc?=
 =?us-ascii?Q?PUxkcQ/yptc5XoLGq/GxjZOX/kOutDWpJ7TodGIV6VmWQ9S0QSqM4DstGGzS?=
 =?us-ascii?Q?2h2C4R3PItGGmSHjPVDsexku4BYj5+ShNuIUoyJDENkFC8ixiHT+uttE0bDY?=
 =?us-ascii?Q?sIIhD6EyL1gTu/QNri7xWAIX8e7jpglY+/+xRpCG0nQbGHrBQ1ysgdSXfbGo?=
 =?us-ascii?Q?hudGhX78MOxh5W4UlRstuG6HA+xoSy9LEPIOfNHIpUMn0m0tk0PuBRQ4ZO9A?=
 =?us-ascii?Q?wloFSAUhy52ZJWbe7kWofQSiLbZIg4DNWrvgfQz2xJoRC5tSP7w2lzqwHNcO?=
 =?us-ascii?Q?o7fNC1sN1lRCDkRQqICRhv/LsAtddApkkplJLZvbAs6lOauXOUhDu6vqJk/s?=
 =?us-ascii?Q?pujWw0wCsiiydu1ny5aFYZ5FTboAty0Ppm331nGV+pw0kvUmvBSJ6PQqxos4?=
 =?us-ascii?Q?H16iKXbVe9egYpESc/T2gPZp7TIiQh54Kbp4axcoWjcwQNQSYEgP29iMWCiJ?=
 =?us-ascii?Q?2I0qxLDn0X8BZMSZslmT+6ovU77mTbJj2lgbMBVieR5/kziZy+VMuAa2/KfX?=
 =?us-ascii?Q?GCHxBXBiU53X1XB48nfaApZl14N4FZvTnU0qXTLFw6ZU1pOzKp00uqudgJLb?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95c77a-afd0-4285-22d1-08db88393397
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 09:19:06.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy0YnPQmHBgZzxUK+DEcF6nBApwNcboJkitJYVmzBhLQdmWt0ZKwGOtXxf4wjSU5wG2PJJiyFyttF1ls7UWEqWH6obDtr7jkNfIodlQyXiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5661
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Shihong Wang <shihong.wang@corigine.com>

Add the description of CHACHA20-POLY1305 for xfrm algorithm description
and set pfkey_supported to 1 so that xfrm supports that the algorithm
can be offloaded to the NIC.

Signed-off-by: Shihong Wang <shihong.wang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 include/uapi/linux/pfkeyv2.h | 1 +
 net/xfrm/xfrm_algo.c         | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pfkeyv2.h b/include/uapi/linux/pfkeyv2.h
index 8abae1f6749c..d0ab530e1069 100644
--- a/include/uapi/linux/pfkeyv2.h
+++ b/include/uapi/linux/pfkeyv2.h
@@ -331,6 +331,7 @@ struct sadb_x_filter {
 #define SADB_X_EALG_CAMELLIACBC		22
 #define SADB_X_EALG_NULL_AES_GMAC	23
 #define SADB_X_EALG_SM4CBC		24
+#define SADB_X_EALG_CHACHA20_POLY1305	25
 #define SADB_EALG_MAX                   253 /* last EALG */
 /* private allocations should use 249-255 (RFC2407) */
 #define SADB_X_EALG_SERPENTCBC  252     /* draft-ietf-ipsec-ciph-aes-cbc-00 */
diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index 094734fbec96..140821e9e840 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -167,7 +167,14 @@ static struct xfrm_algo_desc aead_list[] = {
 		}
 	},
 
-	.pfkey_supported = 0,
+	.pfkey_supported = 1,
+
+	.desc = {
+		.sadb_alg_id = SADB_X_EALG_CHACHA20_POLY1305,
+		.sadb_alg_ivlen = 8,
+		.sadb_alg_minbits = 256,
+		.sadb_alg_maxbits = 256
+	}
 },
 };
 
-- 
2.34.1


