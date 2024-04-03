Return-Path: <netdev+bounces-84537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE16897334
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93038B2C18E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C506149DE7;
	Wed,  3 Apr 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="KiSY0xto"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2111.outbound.protection.outlook.com [40.107.101.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B4149C6B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156305; cv=fail; b=mG6jVrNv50CFuyXIW4Rti87kgzXX+AZm1pQ4C7vWpFh2jdyvshaaxMkMGNSnvmsSvmtfBi29cScZQtbZjFCdoSMUwD61t8EWVwdSsYgnh8B2krXm4NxJqickOA9Zik/N3k5jN5DUYVRv7GjmmyfHj5AlzYFYaf7iUVLfiyUk7eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156305; c=relaxed/simple;
	bh=J5lRiAM4DHYT6LOGVg+wAMetr1qYO2vAICV+ZbXxed8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHvsNZ+pUJdbIzblKL4oPCYB4tdVrLFvX1cmSUl5COf6/l4tH2/MsNKVusyzAElO/bP00vXD8h5X2VwYg90wUgaPSVm+/5nz+DMfAaTeFO1/XBMXv7213p8K/asqVPCSf7PndBZ22bwf1+zmS1p64tYzkcISGeTYhZPsaW5A4sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=KiSY0xto; arc=fail smtp.client-ip=40.107.101.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz2dDkcKmYxAweFC1mmlXodhvTSh8BGPx3awFdZXX6PQInoM3GTgV2gKuiVBaJQQCGslhmIDKWWciFw9RRLoiO5SCZYpcd134K+VMG5DgXHdc1udALFIjq4M2P65DNKk9+3idjb+s1J0lyUhYybau0K455hSdd8fCWc3rKZOOnjoThfRZQC01M6GSPr6iSu8PXcyNppOoTeP7/M2oPNtrY6UvheZuKmfH7gLhpzVRkEUet989PINbgP+HlktvQseGGopMvhKw3cJYvYElv4q3lit9DBR6l7uuYJJMrlMaME0YFzS3zU72YVW/jq2xzGFYNzGJVqb2aX9se5Kznsc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9l8r+G1BzZPnbcvK5oAV3wVtxHPXYyP8fMI8yDwX7o=;
 b=jG3U3WjC61jdlABAnH7NCPjrN/aWb7Q7MCiGz91VtKX4UabpqvVN85NoLyePHCynKiGjTVBj9bDUAa1SKDL7cWf1QYkLMsB18RpUUmsM/uYPzh25rWzIgKHi3sAaNBljp5Kt1/NhFXO+HR6spEF/Bv9riwMcveD16pIWDjsJ0S2ZJy1ybgnq0dAJxQ+zRH57+RVNQLhqr3WCrRlvR3Zb4ycz+5hM4nrUsiT+qzReje0GPupyb/sMbHtdxyNfiuLPbYVImGEyo7NcoLL6NdGKZo2Ymvs6NpuLNwatkEBs3d+YYtE4JHpmva9Usd7JwgzdRltkWW/zROiD7+qF/bTpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9l8r+G1BzZPnbcvK5oAV3wVtxHPXYyP8fMI8yDwX7o=;
 b=KiSY0xton+PkRSv2Y69SYQgnE/SQgKz2GN4leMGybQ9HxEb7M6vVmWgHi8pXjCo9ERUvx8En9hOR/WE4CLAaAo90ZuXyPwTOcRi1mGt7qrWu6nuACks5qLq90oHdfti5Kw033xTbMQSwTt17UtLcW1Y2FAYVMTXb0eeGNPUhjlk=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by DM6PR13MB4528.namprd13.prod.outlook.com (2603:10b6:5:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:58:21 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:58:21 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v3 2/4] nfp: update devlink device info output
Date: Wed,  3 Apr 2024 16:56:58 +0200
Message-Id: <20240403145700.26881-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403145700.26881-1-louis.peens@corigine.com>
References: <20240403145700.26881-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|DM6PR13MB4528:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2OJVu4SznMwNUSvI8lVM1sv7x6MJ+fbx908H6tFtEV7/UVWZSi2c/Yv+86zFsUiZcQI6p2TtU/t71aSPiAeBxNQvPOyksaCOaj3YW8o/9M/QRZSMg5pAVHW6RWUIUgWtJUYmkgCOh2y6ixf6B3ZMoQKbhQflWrd3YYp0vRwizW5nkEclT4MTTHImhH1cd9l/0RM0fVSTtayKD34MRj0USViR7UoMmXm6VFoY745VGLANREkKFL6kofxdL24Qx8PLhToOGlNpyfSnBJNr1GeaP5yE3pM5EAHfctAgnoN/t7JKbdynP6Fww+m5IinhOf79NkH8srAWx3SQQVJBbkUqUuW3aC6wpi06Hn2+LHux+mEaPmvRulAMc7CUBU5oYrW/y34wDq4v1d5BL89tXZbgmP1fMS+OV/gjfe7M+wfChCcoBLQXdZcL3rWo/iJZ4xB57igVzPMQaWjn9SUakxIf6mPeRf8l+xbX4GfnTex+3b+jXmYkyLkKvY7o+fswi5TmrSUh+2QokQaYPOEibkEV+46Uk8i+0jhh3aalf8NZcv5PjtT/Hy9G4z0yFFVHUo5rBb6ZUMtrZPR0dPivBH9mtM4eQqFwUvGlOOGQsuEEelyBoxYdtMp4i1BBzlomS4ws9y9NBU+PZobTwog+CtzHqGxNgkCW4ifJlYlf+SmfJOzbc7WpYu1maq60gWQOLa1cUSi7OaixEOg3sg4PTo0ytzKpJYNEsVcoIuFMQ2CUrOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAWAZhRhudGlYLnR0Bxi6qQ9n3tu0cPiYChupnj0b4fuvYd6OrgTe+fxyUGd?=
 =?us-ascii?Q?eveQwLZgFrDzmOgbsm3XhwLmGezakdsrdA/JDpVgre0GJaMN73GxoFuqdBMu?=
 =?us-ascii?Q?UhUzv/278EQQaUOsgI7cqHbfmenCp1+Sw1VVbWy63iyfzAarPnXQ5eGyyqDn?=
 =?us-ascii?Q?W1q3zkt8cZ8l7BR2MgIjlrbE/sWhGmhuUAv0OK9x8Aw2SiBrN20js8crFdLD?=
 =?us-ascii?Q?qw9VWtB4pXt7dGcZI1HNuZ0NrwkRk74nm6+jTZhfDC7RftXAgt4hRk8vzTC2?=
 =?us-ascii?Q?WCb4QnmETBSxyUp3WzN6f2fCK5IK9Dd1+efbbqYNLJdXsTSTBE876FcLgjbL?=
 =?us-ascii?Q?+cGsU5sr0jEAT67ImJgg/4COgDqQSqrIGJLTISiYaLKUAvCM1a/UKTgXdCXg?=
 =?us-ascii?Q?gjTWB+OnBNY3pQQR6+LFzA44bQ8k1tDw2lC7vWDb6IUJDNoeTQrmOC+ePZuH?=
 =?us-ascii?Q?4ADLTWV/rxSwh4YClOv+zGyUYzWh6tXChoH9rubloan5RvACphGVLcLFBLE+?=
 =?us-ascii?Q?8o+KDOdNOtDfpCrv14xg7Tble/bIC0zfaWprX6H0X/9y7w60uhQ9A4J24y+Y?=
 =?us-ascii?Q?ZDFib2Hqg+PIRAaEEjG8LfZBNzIrDxLQ5dpmyJY+q/zZZ7RgpB/0q7QdFniy?=
 =?us-ascii?Q?BFblrLGDF7LC8aW36V2AgwO788yNiMCfsQ61S76wB1alRlEMYQtTe94WVMGG?=
 =?us-ascii?Q?b3ORWKrx9sAO3S0ZxSCaac5rQe6HSZnCIo5P+bxQsJBW3rhwlrPY1BjtOvC7?=
 =?us-ascii?Q?KXJLCThJrRaHiF3PWGdBrDX/sgoEBMiepWlz52GeWxcIbTsugFU7C3XwknSh?=
 =?us-ascii?Q?8CG9qatGysmpYJ/JNMvavtwwth13oG9GeTQyVkSly57aBRQ7BuNR9sZtAmBb?=
 =?us-ascii?Q?y0aDhaTOG2CQWfE/rtCTZKzMOVks2p5rJrvNcqvb9txTkpohOIYgRFRBr0aB?=
 =?us-ascii?Q?mk7I1Gyc2Fo5CFBPWkoeDh1kJI8rcpDSgOd9VfQo9gMADV8S6v/ZNl/2flT/?=
 =?us-ascii?Q?W5TTejLSx+sTL6uBZ4lO/yWlpnLTXs9lr9xjXiojhmnbHLA0D23UW2uK6NN7?=
 =?us-ascii?Q?eYt3GxLLgXsYiuoYGpH5IgEArxZN1Nh1zP4SoO68ptyk2N+n3+Y2cF7XvTMM?=
 =?us-ascii?Q?+gBxse05WtCRI/Ou8SdxcUUGM/SEn4OtTxIlJS6HejdGtcxXUn3DC2kdoNur?=
 =?us-ascii?Q?zxvtgyGUbIYqBZ1KmH2Ngq4CPNGpc8NnC019m0K8NvV3TvWmCkhtB5UyUnHH?=
 =?us-ascii?Q?M0jJR9Fy1wfCJ9DZxSj+UaxuTKOUSktPaFPdBPCaTNDAknoYuzDAS750UDmm?=
 =?us-ascii?Q?YiVRi5A44PaHCQRoG8WRMRgoI2EOEJgyWliyouDO4fn7G8GXffNTw209NrH0?=
 =?us-ascii?Q?YhdmSlIWIOMr3zbzIoEel1loAEYH6vEVKUOGXZWueygO3b2X+L+7LmmuC50G?=
 =?us-ascii?Q?n6/aX7bAG69k3hRstGt/oT5jL8Iy1UdE+iPIdChOmfcgY9jo4tMHW/KM4O37?=
 =?us-ascii?Q?5FygOWrQgYIZ7Ub4I693EmZCs+A3gREvVglbdcWuctiLxiER5ZXPQrIxD1WT?=
 =?us-ascii?Q?yVuPYfeUlQ8YLX/DOn/B3PlkgwIphZtMywlaZmzaMQYhKkyy/0doeJ4WTI0b?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fefddf-963f-4e6b-4265-08dc53ee8103
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:58:21.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjV3pajj9l1Y8gnKXGAo0cBmMI0AphnL+qAo/0vu8EtNe/sTVbPg7lRL4FG6C+WHCBakenu1V5H9M1nR4+tvDo3oecMwdiwv0kbFuBhOMUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4528

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
index a1717db0dfcc..a9bed03bf176 100644
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
+     - Part number of the board design
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


