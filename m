Return-Path: <netdev+bounces-38970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72857BD4E5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240F01C208E3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7E14A9C;
	Mon,  9 Oct 2023 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="mmL4iEMf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40F13FF4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:10:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2138.outbound.protection.outlook.com [40.107.243.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3DA9F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 01:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8N0BbbaYquwe9NR+MjyZuWK/tA8QiBKgL6K1m72JE7P6WIEjXtKWttuy5zwFNa6yw9j4pHTvUDYowq2TJ5lPMAnEWhEAwv7KzqYndFzn4DGePWu++KsYwMKhz51IQEgiZmz7LpcRybXSNh0mAlGxChORJbRhuG9iJz/UVH5xl+JkB7PJreLYw0+K/dYMdfdMlnkjmr+ZtNPBMWtZqmc23fOXMXTZh1AMxtpyeit+Nv4HMUT+17efyA8N4VzBEtQxGZ1UqDrXItm/GQBS0sSMKW6DsRLFGG/ktgdq5os0f54bcEsmzhAoq+kC5jxE6+QQ3w43EB8n2WCPjtfj2+IgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQCSnCWKNsuF4iOgwBC8P21CrxEelzYtVEndjwnO34I=;
 b=Pp/Ef/dzr+dqqElJHEIyg5VYR79islOeT1mtv+cWCfLDp1FduN28WBruCC3KMb98rwXYSdzXgkyAWO6v4ECCJCzkLEJUYBkbnEy9ANLd+242Sn0nk70oQntqpBr42+sCTbN8fiwQZ5+Uvh+LjGTz4a1bBE4nNwVc2gCuxFvjVaKaZQD/zl7JbluTTYrAfgLBOfsrHeqe7DdVs8TL0txK8c7PbMeaHmWH4ZjSS65J1hKooXWlKrGns5FcyV2Thnj9WnJj5n16EGmVPkIj8b7zN6RK8ezUx26IdVe14oeE5LVrSVeGzbC+9POqHsjua3MOxbjsVxU0F7jLOivdcyemDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQCSnCWKNsuF4iOgwBC8P21CrxEelzYtVEndjwnO34I=;
 b=mmL4iEMf/0PeGBw3IMG7Fbf5qz5izXkpstTWjzwNOyT1aMcJKHW3TqZMY2V/tBJ6aTmIQM1VfZItqdPRdLR3L5PedhWzqdAZGr8M0cyNjkDHeuueXLc6ciJxB1+/Mm06786cRla/IkoFjG960uKLFrUasxVixR6lDkS19njd3PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 CH3PR13MB6438.namprd13.prod.outlook.com (2603:10b6:610:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 08:10:19 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 08:10:19 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leon@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shihong Wang <shihong.wang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 0/1] net: add offload support for CHACHA20-POLY1305
Date: Mon,  9 Oct 2023 10:09:45 +0200
Message-Id: <20231009080946.7655-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|CH3PR13MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 653037a2-c827-40f4-bc94-08dbc89f2d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TQQw1R0N75ggwjjhokgpo1VGoXM2UzmXtK+IKgEidV49nh6nPR3LKU2AyNMhk4RlIabiTvT1HYPg4YXqfmbgeMuSQBVI9Elk9jaiHbyPg0m7yMbim/RN08uz6csF/xYjl6pp4sMtwr9+UFbDwEuRndgUS3KIGrXJaa9QYJTPUgjtLvuqPLML2xE+S8M64cdIJ9JCDiJ7rxUVRnmae+I6GgxtaMlUxFoSQ+tpi1vn24DcV0JBRdPfpSIjKk8Dkerki/cKhn+uZPqEJCRsreiCZThPw/2Xgxqp4blV8uqfwe4t4vUjecHCnnb0LNDMGeLXpQ3G0DS2LTRxA1qhJd7ibAmBEhoh8nBkWLWp/R2UdTyxfEeKaUTfPO9LGie2LLJNxvpRCy/2tsI20tpXiIreBSIHp67YH8czs7phtao7SFoxLxa5l97GdoRo4jyefb4l9XOYcqEXE1NxNMVrvAZt9RO3OaqKwSI/IB/OZfdvWj/e/3ToYJtEth75XQWnpblRRu4TKlrIU6/KAdoN25pdIMpvJpnnOTf4VuHjLgXDqOP86m1FKWDt80g5Bgj39jBIYd8xEF/4f5kqogASGZX+og8y+QsW6k6CSDliItpSD6UyNemRiEo+rc84xvfV/ea/LXj5V1ivvL0oCP9pmfYUz6+0az9/7D3c9RIXaScmrp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(107886003)(1076003)(2616005)(6506007)(52116002)(26005)(66476007)(110136005)(66946007)(54906003)(316002)(66556008)(8676002)(8936002)(5660300002)(4326008)(41300700001)(44832011)(6666004)(2906002)(6512007)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHgkJaEnGI/SbnSQq9PqdGf93mO6AgOsag2zDdj2NFZI1EOlM3bb8uJYHMXX?=
 =?us-ascii?Q?/iIWjFL/FxU1jK5sZ6jsElxoO4TWurRDDyW0KJiR+C2edRX3bRsJiLrkpatx?=
 =?us-ascii?Q?fKzgGmI58uBXiKLanazJnWH84vPDHN1LEwAlO8usTwpDfYj1qJ4fn6I1b9y2?=
 =?us-ascii?Q?wrFQcQ1hwxMk+LQDkEJ4bVfDt3xbxQc83w4LqmlQTwXPaQJm3SRLesdD8nwc?=
 =?us-ascii?Q?PgfWOPEtLcKLHPZSXCuZbGbTj1J7QcHsw+u+vO93ZBW/UwyHPO8WrTWuVLdf?=
 =?us-ascii?Q?BQ80fvsa1+eubbL+Z6dJHGB963XVKMWLCaLHHfEYe/UzA93LEjNTfN+Rroej?=
 =?us-ascii?Q?Fz/zAPCDKPqYwNhzZhdRAuEQMAIl2rD/kw70RdeqW1qkUwYvEXUYVoQpKgdC?=
 =?us-ascii?Q?5DOLSg1z8Ji+cBzk80rPZEC2YxTUhOu3HSrM5MNn/XeG12JovYpKodRr7h7L?=
 =?us-ascii?Q?rl7eDL3RvKLh2U5NQMHnPC6dJNX3uySqjk6TWWRYhXkCECGufFJPxdy/Sb3c?=
 =?us-ascii?Q?cGfFDuL+Co3zGcloQIXS7ulbxVNwTdcS+bWGO1uw1vqcstL02A+bXKDa5uw5?=
 =?us-ascii?Q?gnN6CNdTFupKC00eAHo4bP4Jd0pb+yLZhJlW2xu8c/+4RmsJJ8UXxH/JEj56?=
 =?us-ascii?Q?g8aLR0uZRmfMbZsSm/M9eHEY17+1X8U0sd3tW0L01b60HXPtvClgIF/XXMk9?=
 =?us-ascii?Q?nbYLrM99AAMrXmv6n+/m+yEyw9mWxinbDc16J1JShwj22eUFvQ4uAgANztjD?=
 =?us-ascii?Q?NXBla1rrEliD32KGRezsUan9xhBqj/Ab9DnHsF+VxuYLM54yJhxo+LYtX+ue?=
 =?us-ascii?Q?QnNPQZ13Jr5nLL877QyCsx3IbSX12UztqMelRHz7l3i7bIqvF4CXiDwiV8fA?=
 =?us-ascii?Q?4HjRUwRN5Pz6Wzf0pHHPaAJ/qxcUmJYJ+7fsGQmF8O0ghzLOjYxWv3j8jotZ?=
 =?us-ascii?Q?zMhJZf+NGzv/aT+DPuK/GyBrijd76ZpmyYr0FjWvRPLNwixLwZX3l0ET8tDC?=
 =?us-ascii?Q?blyQcHQP1Ow2d45TuNEWy6Ldq5QNPlj0v7RQkRrV/YstxlvB9ikFOBAHqhh4?=
 =?us-ascii?Q?4jPFgkH4uEOlrxnOniRI/gPmtLEegcHRpf0VzYxPaBNcGFosC4knEgI+Z9f0?=
 =?us-ascii?Q?mMBvjV7Cx6wm7Ik6ztZwxpwmNpqAxBcs4lKcfEiTdfvMPVh5FpT9aVX+aR9S?=
 =?us-ascii?Q?jCSDPmDIvDOLwn0fAPCxKMKSSa9A9ivINAIu9auvg4Ya9yjKK48o2wCX6OhX?=
 =?us-ascii?Q?bCsMVO97HBWJWIieT2dDMJuAmGuqc3c/UFb3i883yfbFJX9QgAd73UruOwNm?=
 =?us-ascii?Q?l+tXR5aaAVfhehZX5t0F61fSmCBYLDLfA8u77677uU+RT9yuvvFeajkgLXS8?=
 =?us-ascii?Q?hrlt6dcVbNlhZp6s9JQ7KdF3/l98oPAeqOoBwWhX242/RO/y/VkxqLCk/WTY?=
 =?us-ascii?Q?9lg4uRegtGTLpUYmddq3GIPUsl1RkChHScoBGv18y5Sk0jV8ILVMIxjTV9sS?=
 =?us-ascii?Q?xKY5u+6AGIdHnpu/rJ+HKo/RDP7hdSsz8SaHSh28OWiWgDuP+XLQkgMc/rp9?=
 =?us-ascii?Q?rltPe5htTb6WX46l6F7Q7jOCZZgBy8VJVgRsa/jU7UiCuLoGMSWv8ezOJ57C?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653037a2-c827-40f4-bc94-08dbc89f2d5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 08:10:19.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0JYd9DBSpsIFt36d1VqilpHPBUzOJHviMDI/eW854r315oaEyGsVNE58V75bwttJCtA6zGEg0Y7DWcKF4isQFtyvYPsEEc08rzhf+o57TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6438
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds support for offloading the CHACHA20-POLY1305 ipsec
algorithm to nfp hardware. When the SADB_EALG_NONE path is hit use the
algorithm name to identify CHACHA20-POLY1305, and offload to the nfp.

Changes since v1:

Remove modification to pfkey
    The first version of this series modified xfrm itself to add new
    things in pfkey. We were informed that this was deprecated, so in
    this version the name is parsed directly as suggesting during
    review of v1.

Shihong Wang (1):
  nfp: add support CHACHA20-POLY1305 offload for ipsec

 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 45 +++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

-- 
2.34.1


