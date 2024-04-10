Return-Path: <netdev+bounces-86501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1389F0CA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AB01F226C4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95715A4B6;
	Wed, 10 Apr 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="R/4iMwZc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228415A48C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748477; cv=fail; b=pXWJ4+e33OCvDtpTRDCS0aG99CPveLzy40MDKz0/EBtSDCpC+3obm3P3WTrMhkWjoB/wW7hI5MWSe5xWy+k1RaQldKHJypdzQfR58tXXuH99UzwmM61HQNTzRxETJ8TdrTYNMbZNok0lSMvpnvLXWGMFjVWynHIaiXFCUYPxNsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748477; c=relaxed/simple;
	bh=NQCiH+6SWxgEsD+HwCdxnlYu2e/gvrkIv+dY2JJrA1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oN8p6OpIa0PtGDOv4RMeJM1Op4dxZuONooZ7BFZnruQDPgvpOpEF+a4QQ7Dkx00UY6BVuCU/p1//Ka6CR2WC3NCU6XoXuDVR55xmBqwmNXyF/NMIjs8hQLqTsb9Fc1dhl+UhjvZGmDAKbog0yJbMBB5/KmcBdSLpTTvEUzyOt5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=R/4iMwZc; arc=fail smtp.client-ip=40.107.237.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBIQcTLasvhWQ3x3n/wH6eNdTZqVp0cIUxOz3mNQWeJ9Z8ftYwoVPplzx8R5eMKLGnkZYra0rD85myp9PNrLk1PG44QSN5AgLwomErdv5dRf7CzoG6MNYG2Eq4JljMFMahKZPeZoh6eWKHKN+Nh0l0M+428AwJlo01sWxQ/DtrEk2qVW6sXh0H7THeUzVVu1bugqAfzRZChF1bB6TRONjxz6z9Sjk53LqDflA0G1AK/xsIzHCvZtTefwNzpzB8TtLgsY0lkH2AKs82GZkE5WjW5EbbeS06TnnEHG2ziJhJVECvw4CaXShSrYwoD4CypJ2nIfQml5BLvBAWeta5SrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fei/nlQzjUgE6Al4KGfo4lzZnDfJEAgN9m+WtfntunQ=;
 b=aAnfVSbj4xEQ7ITU6cywWLC++HF9xLV6Wg+Ap533a5rHRmsPR5Z44SCEQD6/c8k2fP023RLiiJyDXyMsiqcdAII7C4mJ3safl2+jN/0AlvqgbCPSUJmgJQAB/5MvKJc97m4wmO0trxEuIyDz3d58f6NGrivTSygeBIRlmle7WeYlU9IM+M1QLl0ubbajNv1fgaNcb+pEC5vm1EuI9ilTlG48YDmDbHarCZmRk/0hVRylT8x659lb64NU+qSCik1LrXw1q6TmLx5VjxWElbxYEo6aA8OIT/lWnmHXEuxPu3Dniu4MrBAdG8X1TK6CEYysOhbnTsbXHE6Ym6LJwr1Mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fei/nlQzjUgE6Al4KGfo4lzZnDfJEAgN9m+WtfntunQ=;
 b=R/4iMwZcI62Rex+rvbYmpWT0R/bxG55mGEbJPVSlBX/tPipXtQdSljNKqXhNN20puj5z0nFPkfpr9kpUj77quq1FNaQjrX+RlGk5MiwBr5cbaQ+UTeq9I+EvnN7ufHiI7DEeAEmxs8ZlXWFkJKC6SXg5iBhYsjmqG6jXdw3dj54=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MN0PR13MB6665.namprd13.prod.outlook.com (2603:10b6:208:4bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 11:27:52 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:27:52 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v5 0/2]  nfp: series of minor driver improvements
Date: Wed, 10 Apr 2024 13:26:34 +0200
Message-Id: <20240410112636.18905-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MN0PR13MB6665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jxvZyTMWZmvGNGUue0XNwqaBVzLGqgxebEAQOUJX2kNqjBR9pasGwNdNoEBXx4Vxc/34UnCuhKZQzq+541oRw40khs0mkCe9lVt3SmTvbBjndNyI1Nsk792iSVe0xV8PM36Pycg0BU9Srn9XtIjWYFra3FQB5AWWWclzS/1w5XfIMnuHYkUZ6kOH09cpMCMQrdZgg0JgwsvwKdthZPqrLJtuF7R6ArHrYXvUWY57hn3oTybZM13Dg+2ZehtI7Z1JBapi714P+bcKJctGfxNanCHE4oHDmFA5Dtibm3eXsLK3NHW4PKFNsdBlPuT75FEdwnRtjYRDY5qrBP9xzPnBdDU4S3GWcwb8DbOalE193Hrs4iZojhRFz+AC4eLsES8GFxh++Xxf0W0X2n7iGIdiL7Mp5pHkeKmsHs6JiaEW9aFM4J/h0bGoTqKBf6UqSwshMhosZlIr3/saSFEn62P2vHfHXyxDj9+ItyW1mY5ES/byEzS2JFO7xvtK+Yxp0L1Z2tdn/rQQe/51hIEElRt7yB4TW5CgCM0fUeX29sJqPS/5LoFHbT7DOkTE9cZrfGKMzRLkRCmoaAkoVvNmdbEvAYanN6aHOyKKT9Hw0xN932LyyujC0Lr+bebwHLXHmSVZgPYlWjzsflJZvJaZEwy9RVQ4E7mAW6dwSdi6ESs9LcLQm9oVyqhBLtL9/dG5O9W1D6w7hZUfGihTnlWW9ZZgcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JB1kgdZpJ1v87yGQ5Z5M7XrvTJzc5b3MrjrXBHA3L9jAPbZojTh1yHS/4mat?=
 =?us-ascii?Q?nw3Zz+tnKYndDf7TTjSsJBmOUhjSwFetrMnltp1ht5Od7SFmGtk0RlIOpX01?=
 =?us-ascii?Q?xZzXSxV0d0828uUTgPU3gkRzpaoA/2UGruJ6ZCuWTXN4jkl08G1xLCengCyU?=
 =?us-ascii?Q?WJ9ysZULEiaoXCvLlMgu1dRS/+6n3XPIU7U0A2GOV9CCWp57G3zom7unt080?=
 =?us-ascii?Q?MXHJa0vdKsGSD8ECYqiPGp6Kug4jvyZbUeeGQ/YCq7qjF1a8n+SbI+pN9qnU?=
 =?us-ascii?Q?VkQZGAtJK+I1wzInlxUzSjIrrDJhAJmXHoFfAe/wIxWIPjDesiyNl6JiQvJo?=
 =?us-ascii?Q?UgORSwLgZwZhRnqzoljKZ5onR9V7LlceLn5oeODtiwqJHB9k+2Fy0HKJHMsW?=
 =?us-ascii?Q?SrLs/KZSNxrWX7+IehRyD/UDf4F7WozbgyeRJr4jTANfvWhXgLmyr2NBuKCi?=
 =?us-ascii?Q?0PR5ooETcC2wiNRdrEQZZBDKct81U215vQpYJ8kk+49zl8MV9z1MVE70QuH2?=
 =?us-ascii?Q?3z48+OTJV2rkF/9bq0sEFVL6MaSEd3ZPGEdwOwn87H/lHs0eHZdInvVEj1Or?=
 =?us-ascii?Q?3utDLL5jfxu7OvjRj6FyvjCzrmSyGyO9731W3M3Yz37vWHYtCb7dAxv27QLx?=
 =?us-ascii?Q?EOFEDfjco1M4xR5pbraVeDF4vU0JrnulHe5NQlEO9Gx6Mug4P6GD+g5V86qs?=
 =?us-ascii?Q?m8HRDTC1xLt5zXEAdi5BZHvJn2UHyQ035zS4unzKN3FxzikcVLBd4ubv0BG/?=
 =?us-ascii?Q?zFaoKQyj60khxPwXZyiuvl5jk0we9OEfdhyjFmC/MA3nVwdE0SmoJ1MxJpok?=
 =?us-ascii?Q?Cs0DkfHOcwm/XNnZaoBlBettED9sIZ97D48v6774pCdBLJ2GL89PGtQTAgkE?=
 =?us-ascii?Q?oYdTwSXFvi6rQFc22Dxmw9sFpT2rzKNtQROBE2xvI5Y3DfoZLnxEpfgYYG92?=
 =?us-ascii?Q?4CxcZ5CFzo8KxgycwHGEnc1Winb8A7Gd78lQORXj2g2XWU2woHjlXwtm41Kn?=
 =?us-ascii?Q?XFfvOrr21p0dKBKtKrNLqCa0/K/WOrCJoxxgC3t8JrBcvpebi5MG39KPK5Ci?=
 =?us-ascii?Q?alzp4xc7pVIQLV8+KtastFaRuAkZHDruYM9YDOfb/LkfbXqlwqtt3joyKsoM?=
 =?us-ascii?Q?3sdWnOy1icMZQRpg8TzY4dpt82fXoUqnWR4EjsNOm0lBceWJVwFxOdtAzl+L?=
 =?us-ascii?Q?QgnOwDPFUusZWI1ROA/tQxXjLJBmFydChyBOsge2M0vLRkmzPM4EtBHQu5LT?=
 =?us-ascii?Q?gv5Kil2PWLN6kTTkZ9hpRgbzGaZDJfwqub4R3RzXR+QYzkKWx8qky5QZznaU?=
 =?us-ascii?Q?y0wr6T1QFozoG/IllSZFqdqDphse3u9gWVGXTJYQgeX+9jKrGGCCzytO1xGP?=
 =?us-ascii?Q?dwW+W2xit647q/tuTkhGnDSzG5c+D+9ojxJt687zmWyAv2c/PfknLelkPPjV?=
 =?us-ascii?Q?kOu836Ey8yJFqOhABdwaEGLsZCJoxlv9ETX1cZNjl1/P6mhRxUPqPaj3ubn5?=
 =?us-ascii?Q?d+JshN96+Ctyuxqc9xx+XLlkzSPF4QmIYYcQ1vEKzzxYIKIqjhfPSo7WJMY3?=
 =?us-ascii?Q?p9yJikVL40vSJl0WCC+KPKjVx1+juQyLXTNOmcsLJKTky+v85+dpSON3XasJ?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245d6841-4d82-4391-81d8-08dc59514271
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:27:52.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKUrrr8lrs/V52X1qqJmVHYWz8Xo0NZC5gzqa7CDrEZKLl1/+xP3LkgbziKeQzRz3O2r6e7C9jdge8dXohbrOiS+FjHtIKPhhiSfpViyK2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6665

This short series bundles now only includes a small update to add a
board part number to devlink. Previously some dim patches also formed
part of this series, these were dropped in v5.

Patch1: Add new define for devlink string "board.part_number"
Patch2: Make use of this field in the nfp driver

Changes since V4:
- Dropped the dim patches, as there is a more significant rework in
  progress to make it more flexible, as mentioned in the V4 review:
  https://lore.kernel.org/all/1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com/
- Updated the devlink description of 'board.part_number'

Changes since V3:
- Fixed: Documentation/networking/devlink/devlink-info.rst:150:
    WARNING: Title underline too short.

Changes since V2:
- After some discussion on the previous series it was agreed that only
  the "board.part_number" field makes sense in the common code. The
  "board.model" field which was moved to devlink common code in V1 is
  now kept in the driver. The field is specific to the nfp driver,
  exposing the codename of the board.
- In summary, add "board.part_number" to devlink, and populate it
  in the the nfp driver.

Changes since V1:
- Move nfp local defines to devlink common code as it is quite generic.
- Add new 'dim' profile instead of using driver local overrides, as this
  allows use of the 'dim' helpers.
- This expanded 2 patches to 4, as the common code changes are split
  into seperate patches.

Fei Qin (2):
  devlink: add a new info version tag
  nfp: update devlink device info output

 Documentation/networking/devlink/devlink-info.rst | 5 +++++
 Documentation/networking/devlink/nfp.rst          | 5 ++++-
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c  | 1 +
 include/net/devlink.h                             | 4 +++-
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.34.1


