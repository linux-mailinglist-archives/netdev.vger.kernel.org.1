Return-Path: <netdev+bounces-86503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8177F89F0CD
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63C3B23054
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A9115B13C;
	Wed, 10 Apr 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="MZ3YnOUO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344A15B149
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748481; cv=fail; b=Vv69BdUO2nh6PSpoQVIVf3eBcVEr5GEJqanPVqwIu3FbbTc1s9s6RAyMvKGOO9m/cSIiVNC46Kn/FxWYYjQxGGvKakDeDA/dM1dCiEBD81SFaraxfQnHv78psmd8c7NsRVgP5O9wi5qygdUwtyYEIrbKvTXXZq9zSS+9wYSs05w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748481; c=relaxed/simple;
	bh=0zwGfWqKaT/Qc4bIZisiGWzIvked8VFmzgazivox/yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pAYUpKXIyz8j8ourdj//9VDdwvMcrzqtae3tzQe4g4dOA6EHSc2DXO+6+COg1I4+BuFinxJLZ4BbQEferQg6/vAOa7MpVHPlz3CpNYBUpn8jK9mtaLY7syViU9oLYPw9Pw5wl6Y2LAWppT240xaNGTPgxrpe9ieKPuVvZ5B5Dis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=MZ3YnOUO; arc=fail smtp.client-ip=40.107.237.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuuB/b0SLedlGR4M8k6bH9Ho/I67i2TgvJjGXYB46Z7UH13P7qX6GisMtN336czdMQglc09twjX9vVdWHmhhU1lv92VunUol3St8dnpV6CO3PEtMrudVChc7ScsvpOFI/ARdxZrz7GmEvSjl1ZNjQ/v/KjpaZ5SjntZg09mUeHhlthKuzSvxhK9X9xXcx0LTMdJf06ZeqeAKg1GlYqa5ye/4Y+kFfc7KeVVk3ewK1D61u3ib678LeIL2A59R3szVrB/BnBM+IIzd5UmPTsFXAf9XSDLhAJef7SEhVvZaSJpjNMpq8lJB5TRrAL5p/Zr6mNYvq41k2vMhBY/8NR6Hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhtUVw3+Co6aGJVR4JGY3Gu/jHGmKbMR5LMSmRymCis=;
 b=hw0xNrczOPNFsIOmaUWR0YsUZP2CmN8gg/PJb2PoCagQpMF4OMLnfszWE2e1Sj7zcFdbImuoznxswrEdoTfDXQDTNt0fOs7wina1mas6NjpFjRrAClAO2HRdO4Z4U1++JY8gDh3ErGoRaXmqxbYyCJ15CJisuJSETBfHgLUV6J/3OG86iEaPhTGyijwU4DQPSMEzEUFdX9MxvW3X7HMcDeAUy2khSZvG4NSqrzg+4UY1fFSCa/ztFAZpzoWBSdccp9cYUPTpHpbg4IO9L/3whgL3l2Ycf+AQh3ZV/ukt4JLOLUMwLeRkJq3BznCPFFHuWK8dvcHK1iPYiVBK5uvCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhtUVw3+Co6aGJVR4JGY3Gu/jHGmKbMR5LMSmRymCis=;
 b=MZ3YnOUOXu+8AtXzjS/IHkblmPSujPfNQFAQm6VFqp1PDk4B8BROK80tP4QOLgB1XgnuowFR+JurnLoVXjozKYwQFBu5vu0oz4/lMwah1eU6JPq8dGV9uSfmM5N2ZlIMgaMBaqo+m5WXOQSEaXNeDNnCULMu1+dPh8580gjmJIA=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MN0PR13MB6665.namprd13.prod.outlook.com (2603:10b6:208:4bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 11:27:58 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:27:58 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v5 2/2] nfp: update devlink device info output
Date: Wed, 10 Apr 2024 13:26:36 +0200
Message-Id: <20240410112636.18905-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410112636.18905-1-louis.peens@corigine.com>
References: <20240410112636.18905-1-louis.peens@corigine.com>
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
	uEs7UIqNxdiYDktdw2s/2+ZvOLGkAMquPerV17QLn+4t0llyWk6BVKosiN+Y8Q7A2OoPZC2zIAo/gbQLx909OAcN2T7MGuTt99dlsaVeLgzuMU2DXoof7Gek2WYb6rgNg6MMTdcyr/8+LWJ59zIvEOLuL6TpdwHBj6gZz4ZXPQc01c4ZD36ilDnO7G5WPNWlUt0cb1t40qtThM62nGE9E3Uo7lnBQsQHubh2VSBTEpXRIQOw0Fbx5yQYJGGhYzYqkCmOriVmwivRaFHyoL0xGxufJSTS6RJmLTfbMY6TW2Y/sarjNqyb3RY+mPAGuf09XuKpmMGyCHjysN+zfhYzLQltbDD4I/J2htMS4T55vfT714DrLmpHa8TLR+cW5TkMbwdPaaidN5vyA8EGSNNpJtK7Ud2zjMuhkgrNmq62XSeh2DpsPPI3YeKnbQJM4DLFZ+TfKyLoe9ibbsuFl1hF2R+Oqv8HLDFIWzM2McdGG8SZ4HIVuL/FNnHKaL9Re/pQVtj0y61v03erhSLUP3mSivi861APtlXr53Zn14eTlUt6xCMbm0/2EsZlPdCp3KZ4ahCvjLfnhD4anLNjAxPj2mozDA+DAucHMGyHhHAGtwH2mweszmn93VVmKPbwQnk2eUhKHLwzy0TspfgjpGS2F+bHQBejWzHI01dR6Igp4VIRLfK7EUI80Aadzpi/Y3w0RQB+O3N5696nRJtCE3tEbGAYiAWCOcSiuxH4ToFjBUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e80xEIK7v0GSRwQaeMT0U5b3IPDjExVc46C02KJjfUtjs/DS1KoFQlQQty5M?=
 =?us-ascii?Q?TcpNB1uVgVBMqpof68UP6viOekkgnra5aezG6UVJhT7wg2YGQexLBlfDWe6l?=
 =?us-ascii?Q?mAq59hAK1FsPefD/Ko13GGQU31CQQc4Ja6IV+aOa0j13vdqda1D86xl+FvYq?=
 =?us-ascii?Q?6Z84Um1tbQ9uIWyWJWkZMqBCH69JCteqPnsvFnUzxqKPlk/A3qUqxos0NpqP?=
 =?us-ascii?Q?Cdfr9d90QvdGBL9tfyRJcjTbgohkwsu254zWRLREOPrOt17/ru4VpfKEmKZc?=
 =?us-ascii?Q?SobHrWih2srJtzIxVzlKnghiViFHsKyjcBzdcE/A9XiAa0xNEKDFTUPqC8qO?=
 =?us-ascii?Q?PjTSttFFs1yptcyKy0tkofvKM3eMsl42XYH43/CI+22fmQb0ZyV8moQZvcJ8?=
 =?us-ascii?Q?1u+GFWZLD6XMZmS9RHFR6qD1pc2YyI5trsyX5vRGRyTBZ2VWh4N5YsKBjU64?=
 =?us-ascii?Q?6NjCkwJLah4aeT3rv9wfrRFvKbMSNzLQ0BXmq6f9IzeUj0W2GhRoYgXiDiP3?=
 =?us-ascii?Q?gYB8C3xgdPeiQzaYOeTMnEUJxtuuUJLJumIfNOsZ8RJJeHIvEjaIAkcF4FdH?=
 =?us-ascii?Q?ZGrjsnhtfugyYq7vYlMLCh2AyLwz8NQkryLjIkto0pOqYWUz32xcchPlvyBC?=
 =?us-ascii?Q?H4FUof6VKou4BbLlC/gbZAtA2LQGEW3QxIaXPi1+LC6OmMheAVQN4Bo9rKvQ?=
 =?us-ascii?Q?3iiBylNSm6AIkNhOFgfNdtWKoWS47S16662xR1SvZiEZER+yz3gJnLY43JDr?=
 =?us-ascii?Q?oTua0YRJnU9cXmZnvsvJq7J4okDhUi4pwpJ3RxQiBufsseCmoaLUjr7c/WdO?=
 =?us-ascii?Q?zwQ390UJGfzan8C45bc19hm2BNKxfpkUTLzX+NHzbvFB8F+XrREgLJ0ayeBf?=
 =?us-ascii?Q?LJMlXUgtHzARa/QNubaBrlScT/sufZeGnytHc8hhN4DGrfjl8oOPhN8e2kXo?=
 =?us-ascii?Q?eUdU5LFlPl8Wlfbv9h5Y+SmbTBHpo4WMxbbYtfJ1XSqc4Ot0qYT284CpWpiD?=
 =?us-ascii?Q?DbG8daNXOpkw20w9v49Qz3IiLpOAo6N6NZ8JRO6HZ3q8WIoy8jLSvSTYDJKi?=
 =?us-ascii?Q?mIly61RrbMeOVkrp6oaHPGxgPv6uv0c3oIZLuDPlcpUUpJuvaXTMPCc+snG9?=
 =?us-ascii?Q?+Ip1ETcz/UX0BSf9AfAE3XCMj46b85iBd4qgzyn70cbMiqMVdftSVMaD2IR5?=
 =?us-ascii?Q?EdFpCVIhkOUgYi0lmIY4xujddKQ4pntXAXvfwdfDpkBce8JoBb7kTZWCJV0q?=
 =?us-ascii?Q?SqcaRVXMS2aChie7HCEM5MCaFWbPy96f9Ez1N7MmWGadYl3b+xoAZdQPA0Sv?=
 =?us-ascii?Q?Ry/3K46bIDr49tUJ87+ySyXAvkLj1h7ZHLAGeapILVQXCXKUQ/CUC0vMrdRa?=
 =?us-ascii?Q?v8qWhNMtJOWXezyd7ku6YmhYECRDhelah7L57CfzENvb1vcx8ca65YOEQnvC?=
 =?us-ascii?Q?B72aWt9Wkn2KuRj5dZ3l73pmBpsVsEoTX8gkQUUPCPShWi0rpPIh9WtoSrrW?=
 =?us-ascii?Q?rh3wA7P+TSJTPUb6l1dQWJN9vDsBzMN2sTYxFIGhdJOfFWYv1GnWqE8RY0+t?=
 =?us-ascii?Q?MDIzGqQzgEeFLa7X39Gx/WhMAhfXKkvXnzr/n+yOi3MQOodmZedUv/62qwdK?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0453a8b-4db1-4d74-129e-08dc59514600
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:27:58.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kse8H8WV5OhDD6tDOeBzFkA+Vw5O51UpvYICqsPx/UDcV28mSDUG0FHo1Yn8gJx4lU0XEU49uDWLe4ce8j6lavH3gGgRcwtPA6jj/oBV9Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6665

From: Fei Qin <fei.qin@corigine.com>

Newer NIC will introduce a new part number, now add it
into devlink device info.

This patch also updates the information of "board.id" in
nfp.rst to match the devlink-info.rst.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/networking/devlink/nfp.rst         | 5 ++++-
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/nfp.rst b/Documentation/networking/devlink/nfp.rst
index a1717db0dfcc..3093642bdae4 100644
--- a/Documentation/networking/devlink/nfp.rst
+++ b/Documentation/networking/devlink/nfp.rst
@@ -32,7 +32,7 @@ The ``nfp`` driver reports the following versions
      - Description
    * - ``board.id``
      - fixed
-     - Part number identifying the board design
+     - Identifier of the board design
    * - ``board.rev``
      - fixed
      - Revision of the board design
@@ -42,6 +42,9 @@ The ``nfp`` driver reports the following versions
    * - ``board.model``
      - fixed
      - Model name of the board design
+   * - ``board.part_number``
+     - fixed
+     - Part number of the board and its components
    * - ``fw.bundle_id``
      - stored, running
      - Firmware bundle id
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
index 635d33c0d6d3..ea75b9a06313 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -160,6 +160,7 @@ static const struct nfp_devlink_versions_simple {
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
 	{ "board.model", /* code name */		"assembly.model", },
+	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER, "pn", },
 };
 
 static int
-- 
2.34.1


