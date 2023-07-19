Return-Path: <netdev+bounces-18921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C2759164
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA431C20D41
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265F111A1;
	Wed, 19 Jul 2023 09:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F710784
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:19:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2120.outbound.protection.outlook.com [40.107.94.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD29D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJSjp16yW6fuhepLt2rNzdjkM5/PN23awQoOKduwMBh9LKPaWIel3M0fYpYJ0EFqlMQnztaz2qrP5+03GQOGPbOwvL+aIoHjUsuFhBOEhuvm+bK8c6lBa0DOc728CBkclHyoWb/LYalm6SKncNtRAu2GdzS6FXketdSHbpGstkZNeLIuh85ilAoYPfi3suZ/e/LtjzzKI1QSBPQmHVvRfbakzt5z+Nyk2AUhy/TFwnsQ0s16o9kUnSiRPvelaIHWOfL1BeG4Yt3DIXL2hgqfh+tOWzw6bHjziRdQedDFpT6rdg7NjJ38eWSKfX9nfD14t8TZX866gbyTUYSTKOWk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jOnVZ9rsBy20R7hzdNp5Ry0OmBd6OpCaWhYSnAEYsQ=;
 b=Rl607z16vRWcMW9TufLWOc4WijigDsaCMDojOselrdr181fLXcjjNZMIA8W67QKH8aazlWN6Af0IIQ6R6vAAI/LozNlFYX/splVwAY1yaL/G4+8ayRLT5tVx8RcENvjBlZHL0Y6LHJO/JZqrDMA44nU6UHbhpdtvwYOpEb2VH82LtJk/bOwiFZSrDwsBWVrD6Wu1Vx/klUFgzyFSIBfJBbgrOPZobgCrUuDobgPw8U/gm8sQPZGNa0PK5911Ft2nydDioXrAef5TURz6qiDZOjwFNn6wkTddO+pXdpYaxa2Dnj5LAchzq+1jgdmK+5AGmONpVo8TCi7+P6szvDqW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jOnVZ9rsBy20R7hzdNp5Ry0OmBd6OpCaWhYSnAEYsQ=;
 b=CxQIGENux3m3ZHibrTf1y12ipjj6CPPGNwAiSXUDX+tfhCTnjaixZSMdt2ha2i0Y7KxjsMMSf8eg18bpJP7RJZvi2kwanVPyKrImaTHjShlkl1w0U6u2SprCoAaQY5Ga3o+VLjKKLMLDR67l15wGPWKqg+fSQ2ut1gdx0CTkTRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 SN4PR13MB5661.namprd13.prod.outlook.com (2603:10b6:806:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 09:19:01 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 09:19:01 +0000
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
Subject: [PATCH net-next 0/2] net: add offload support for CHACHA20-POLY1305
Date: Wed, 19 Jul 2023 11:18:28 +0200
Message-Id: <20230719091830.50866-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 29f99e84-07dd-4b87-322e-08db8839302c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r33EgMzh+NVYROSUqQmxcP6L42bu/72Psa5xGBZ76jRVe3H5SNrxD+GZrLdSwXUnhL2reV7fUlAfUSiyw+xyAUa1tQhFs9RblAwjSYVPubhyYrEZ8bfEgo0eJyp7UaNL+9cUS2L6NpiQzV19KFGeeDYWS600Nm6oK8kroX9tUORpSHJRr2rDfZjkIcneO4n2gr1efdEBKNadvxlUOHQ0OHEpLZa+7wZe1KiNNmAgSwW8PcpJ/6wW/DNOR5pYBjjL6reNubGlNb4y/WCDTWj7i/RjNcXqDqvhz6tFhZnBM4fJ2BPLgxh67IrSCCdVicPO9ccoXgvFDd/wRT1PSO6YNFYU57GGgDqf9tQ9AP8btZrCk5JERg/2xxfaHbaXbTbM1QEVoJwMk2J+q4Wq19SLA0n95rq290KcCMSk8MdJG8rPBQHCuwryyvxNIc9BZqh1zromlbV1ZAD1a6CffeVTVAWJ8Caba3LRy2qPer6m2E+ZD7Um9HC7LiW4v59CflI8vWGNyTv2AptlTvLyKeQFi07KdX34eayPoQARnWkliqFLQWoN5DkR1FBuTTkLAaStYccttuvEYtmkauWB3A384TiHFYVMpfoRP6TNIEl3aWtYfDzVxCjLtmP85NTQFLubyHKHzh3Iwh2ggc4+QGfs3hUoSpWjoyMs7W55hdBth8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(451199021)(54906003)(478600001)(38100700002)(38350700002)(6666004)(2906002)(86362001)(6486002)(52116002)(66476007)(66556008)(66946007)(4326008)(316002)(83380400001)(6512007)(41300700001)(36756003)(186003)(1076003)(6506007)(26005)(2616005)(4744005)(8676002)(8936002)(110136005)(5660300002)(107886003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4VTRR2vSaWSFSZAYfqJqORdiLbJS7ZT2Lzawx4YU3ecBZlGr31IR/xUR7Jr?=
 =?us-ascii?Q?Xnf9DQ4h4F0RgdBZyP3+wFx7u5zGl3WKhHboKz32JHydcZ7W2m4RAJmV64Q2?=
 =?us-ascii?Q?+1iaZPaJZOt1T5ItpGVqFmEJpc3HEtPAw/YSITqRp0LP9fbfxC1xHJwq0ZTA?=
 =?us-ascii?Q?vcfk4MwdXbIdHUBhJjDfd23YmJuJtUrcAg36ewWpf1RioY68AEOKU8daWb+G?=
 =?us-ascii?Q?Q89KnZ3qV+FN5ycmpJV5fZNktuamPwYL/h1eSoQh9wHK4rKVUE/IE60jIvKu?=
 =?us-ascii?Q?avWDC0ku/Po939LaKUyTQ6/Zxv5zszZ0FptOxegm5O0CdecL+ShIOe1xbfwQ?=
 =?us-ascii?Q?3XmBMtASf2f9bFWZk5gw24if5bEJHE8yQGitMHUMSrcACHajmDXHZogLJPk7?=
 =?us-ascii?Q?8mTOt6Co2suOgKyzNlIYW9r4j16ID0ZSE9nW2idIm8aLTBK5E3XZFpilfmj9?=
 =?us-ascii?Q?k89u85BHW1ny4FPFC75dbtIKCsRq0LKpRYtvYvhsvZeLVltxdJacRJiYJjAW?=
 =?us-ascii?Q?2+v9DKnN5fVbOmo/EmqylUzd9af/RnyUeC71b6Qola+2yuG+W953MQ6ZrAIq?=
 =?us-ascii?Q?4U7qVlO13FYj0ro/VCnvRxlryZAwLTu/9Wuxa3/oJek8/ksiwHXD5ZP4mlwL?=
 =?us-ascii?Q?OcXkl8coiARCP/JzrggqIIVVo0rn7rEVZ8zgtzwL2tRl52UqT1/Hnrtgerpj?=
 =?us-ascii?Q?gNcC5XcpMH3susubhEauBPQl1LVKkDMmmkNR0/2//PdCj+CSvi3WB27Oregf?=
 =?us-ascii?Q?z6AA0ndmB3QklEMYc35VUlAnasSncfwBZl7RnthSIY9mvkgacCjEy+1jTYou?=
 =?us-ascii?Q?uJPUjF/aOPaLm9bpX32AHEUB49y72rdWJ0kPzWFcO1OU7uhoxMdKSIZL8NQU?=
 =?us-ascii?Q?+wB51uY7Bf6j1snveEXImgYK8SjfbyYb76lslBaLxMqwawmeDUM0ZEn42D3y?=
 =?us-ascii?Q?qld1j4URuCBlDQ3sH+4f56Y8C6u0wOVtYJQc3rn7w/FcRoMFwCvNKFJhJEP2?=
 =?us-ascii?Q?Rjsuvuoc2z0guoX+/sVDSuEFb25XW/5WMyKqpWTC68At+EfXmqBFa0Vtd5Vd?=
 =?us-ascii?Q?PEViPS4Oq4nXLbWTmZqipgGkKT1Gt8iFvXyVtTpWoJbpvNA2yuH5XScBta/D?=
 =?us-ascii?Q?yMoinn1kKNj4Z8EPjWmm1vwEEb3axJXRtgazkGp9SjY8PnCu9tjm29LtI6Tz?=
 =?us-ascii?Q?F+MmHeA6HVn7CeHDKKQ9spgjqpw8kf0LdYsUpK24bIpu3UuEqZLCO92fuxge?=
 =?us-ascii?Q?CoBGUnMVt1auGpBET5Izi1e+LrCTFgS97qp/2Oo1v/dn5/N+fOz0YaQ8BuQ5?=
 =?us-ascii?Q?kYfY7d7eN6e+eU7iK/OIpTMaMlrN0W3NJLztS9zS7mE6UnXEPOOtiUhdkMcq?=
 =?us-ascii?Q?ZDeeE69/LQQ505bVsMdeO/ucIm7zYXA2IxEYqF5UivcPn2EuHPOTqWY6UhEx?=
 =?us-ascii?Q?QAPaFAdVykXeNDTGx7u8V8MXGby6TS5ECKzw5yBfTLrfE0jKHSH7eTDFKg7J?=
 =?us-ascii?Q?rPDlhziqPGWFQqchKTpZj+cbOBBnCKhgETpBB71/cFRMYUnd6Zmbh/wak9X4?=
 =?us-ascii?Q?JkHdnarT4XCoCk4jeYBcr/Pi0uDdbODMLHdqfMLHNrUALmMYq4uT+ObRS256?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f99e84-07dd-4b87-322e-08db8839302c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 09:19:01.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYz9qHRZxi3nlgE/11ErL6NPd4Ea+dyXsI0DIQl58Rh9aY+xnkgqfsjrVREORzvdBx4s9YxUJNtFrAEeSh/tAj8KKl50te+NBaajxxJJBQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5661
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This short series adds support for offloading the CHACHA20-POLY1305
ipsec algorithm to nfp hardware. It starts off in patch 1 by teaching
xfrm about SADB_X_EALG_CHACHA20_POLY1305, and then continues to
configure the nfp for CHACHA20-POLY1305 offloading in patch 2.

Shihong Wang (2):
  xfrm: add the description of CHACHA20-POLY1305 for xfrm algorithm
    description
  nfp: add support CHACHA20-POLY1305 offload for ipsec

 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 42 +++++++++++++++++--
 include/uapi/linux/pfkeyv2.h                  |  1 +
 net/xfrm/xfrm_algo.c                          |  9 +++-
 3 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.34.1


