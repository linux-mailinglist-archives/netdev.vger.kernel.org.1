Return-Path: <netdev+bounces-85103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D335C8997A2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493B01F22F01
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D81465A8;
	Fri,  5 Apr 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="buJxws7V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78D146A66
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305028; cv=fail; b=TNBYlHtPZC7Mx7GWTFwiaGf9Hq2rPNL/ktwF0K+xm8SK2katmwJmOJCycPd4spauUS9DH2CkVwvmLwsP+tRcbkEDUMHKa0ndTfDG+aBdD18T4zrOzmPaMUwgm0kneMWl8QGAhy87oLMij27Xn3GYI2F/uEjH+QN8+WbfFhMOWZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305028; c=relaxed/simple;
	bh=J5lRiAM4DHYT6LOGVg+wAMetr1qYO2vAICV+ZbXxed8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGuxq7pDZ8NG3FY5mjMgtq78bKSrOH7LNdwuOljMSNEOTdpEk09EXOyvc8Vpy/Wq0T1Pz8lQ8fjJc9YUj74HJ1sXvuv80ZJmfi5h+E5pDxCwbowZ1QpwPwWHKoVaX0w37U5Z+2m9qJqQtCo3aby2Z0w/TV1YUJP6NNFgzikzmW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=buJxws7V; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALFStpH8iK+mgWm7UyTCTO7LiRDYi86IDa4TeOh4yyAwIJayvGPvIWQ20l1NhrGUnwIDgTDyR7rIEGRoZS8Cf2gNcFExCsmrH+JAdIDka0U93WcGIu+FnCaJXpKvNfc4/VaHeb7dadfgxDOQd8YA4W2lhyEnR4JwrnhqdNznRN+RKpzLRCOeqVaahV3SiEfT4aLJyNimDiWp9mGy0vbNt2mcfM85kKVKts3+spacXzT7xNZBvtdhFcugqTpCRwD2aC7gfhA2YTJezNNK5iyf+mJtetXJ3nMrJYglVM4boDTkezIr5piSjzjnd3FwuZnxOcELf2nZWpGOGsIBGBs7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9l8r+G1BzZPnbcvK5oAV3wVtxHPXYyP8fMI8yDwX7o=;
 b=MllQZ8x2FyvSS/Z26+jHoHgR9aysg7HkFlQw079J/7Tb2zY10odEscjRrwGRC+1ys2KF1mvcuTdNmXY5CfK+gBT5xID8PfTgm37ikbVhaj3D5FcZsz3bC/hFjfH/kbXwR/slSmQwPJNgjyWAcohkC0eKsNvcATNc3VXASYHkOvJn9aFAr2cAeOA7U3ZSUpyryF//QeVHCNkMt+KeWVK9gmU0zppb4/Btu6PI8y3O4s+f9OMxtrWIP8GYd5a/zaehURF0LlvaHyw6Mq4GcrPrLjKJzeb4Fn268sBvbQHf2Z+EbQ/LcgNS8MvSNaFFBzPTSLiHEgeAHUau2T6auAk0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9l8r+G1BzZPnbcvK5oAV3wVtxHPXYyP8fMI8yDwX7o=;
 b=buJxws7VgynixydUBQJpMKcxP8Qy07orUi4GTvlhu0Y6CwphMfqt1RJYCkegwBnNo8dqVEUGfnPqJn0DiOrdMVqlOv6BTZdDZ0ZKKWZOrVJXnWGKKMJeioldacjWfLQ35dO+PMhozE0YBsDHZY5Vv0VgXwJ4l0AU1LNxZQymJsU=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by SN4PR13MB5678.namprd13.prod.outlook.com (2603:10b6:806:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 08:17:05 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:17:05 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v4 2/4] nfp: update devlink device info output
Date: Fri,  5 Apr 2024 10:15:45 +0200
Message-Id: <20240405081547.20676-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405081547.20676-1-louis.peens@corigine.com>
References: <20240405081547.20676-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|SN4PR13MB5678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0b2GnMtGK/Zs6y6PaMOFiKYU/zFW5v+gZZE4QZbtGMBKAv8q73b6+UKhKdSL+wMP8ZJVvNHIVTgoIESu4Uofu1QksKjpzUypOhHOq6eavGVO6ynHPs63Cxm7ZNSwvrwhl9lE7P2WMLquBWUQmAjF+gFP7Bi7NhUtvwGl/saaEb+1DwaYtJiE9l8d39pRYWBv4nFQC1je1V5DM3Aa0meUlLIeJkeOblJx0EGnzhMo6PYhmT+MiZmsnYT4CELHTa+60IRnkhNliXs4ZEQ/ryA79MnEwEoSiG2uV3LiJe1ndnYJCG0higJhu15io7LJDB1Z24Al47MBBidTj3Nbb7udX8P842VmY2T8QZ0Eaoxa3iY23jz2j7sbu4htpBSXD7f5X3zczncvAeJ0EtSoV0njK+yHTp4RtVF1vyU0ZVOhztwHn45wtvrhIH7pz/5M4p+QXsAltVk+QpEEPmmwgxwmhXPQ6WXtCsRjUgfEBKuqS05bF3UmaHYccbKZLtZGlvJenNjyawl89SD5KFZPgWVGXe4kbsJWgz5YgQ8cNfOKLIuQduPYYvMJ1MH9dVySHFg7jxIttcB75awq6gSo+DitTZKwuSDjjY/zbVXok219R0Kndc9D13kemWsx6odTm7/Ui8sZemfpwGeVVYKPw7rMa8s7LAOD4bZR/dDQ8mO8iCcC7JqnxN9mG4q05gPzl2DD71moIpPqnGbqu49GTolu8/jwLMBof+n7ka7tIsS0H6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6xWAY92OZ1ymGkz/GNsZMWmwCKaPU5ih6Amx0qCGDtYqXaL6pSpAwfoc31OM?=
 =?us-ascii?Q?NreqVFp0CvtmvY1/Tv4iUBdcqDcLdGWhlcre3R8i+CXgifyKLc8r9vbG6wRI?=
 =?us-ascii?Q?WPrNh9X2l6osrSU7Yp/TOFB6aj9bSHkG5ISPA/Xt1gyim+G6M5QffAGJoYjy?=
 =?us-ascii?Q?U57dcXo4x67MPd5ROErNc1ZeNFJYRC+JzCU1EZA+PrYZ3iUu4lOXbX8VBbzQ?=
 =?us-ascii?Q?yLM568i0/yFfJtRdoeVvypS2qKW3Hn4+gwzZI7gkaMdfxdy2MDA+UIr57VQh?=
 =?us-ascii?Q?avNgq1f4KzXgZuMQ2Bq4bgk5abeQvo6JZEq4vwECvEArGWANhfebFvQHYHBU?=
 =?us-ascii?Q?DpcyLWpcEV8I4vruF65GWKIfOdq+zdopgB7EGCRN983hRHhcFO90WjOdB4bp?=
 =?us-ascii?Q?wU4CmCsc38ipw++goQjWreXHMJLVj7qVQloF2jKCO5YK+qkHmJR5AhigAdt4?=
 =?us-ascii?Q?edwLEydnkPgRFgPnhz2du0OPxdxsIFaCHG/Acrxtu6z8WtR+hrbdxbS880AG?=
 =?us-ascii?Q?Ri2AQWt8PdHUrUthbMq8GilxbOTyNVvHRyKpjzrlVG5QUzh+EkrD5cKhzMmj?=
 =?us-ascii?Q?p8/Q805gut8XmPCB+lXRgooU8Lr8c9CDBQAnY6R6oxNbZytjruAAQ0sNVtty?=
 =?us-ascii?Q?NTOlN8RlRkgGLygtaJN6qf4aivloASftLLbUSJOy7q0INJSREEyJXo7RP0K8?=
 =?us-ascii?Q?T3/y2z++EVsCnMTopsO0/js/P4Jw+OfVFBpRCwKaNSO2XL9PAb0925N4eCoc?=
 =?us-ascii?Q?esAJ3C4ZtYL0VpIQna9zHLW8JFjpdJmJZ1YY4rWSAtgoaJpDgSqoAuoTmKt7?=
 =?us-ascii?Q?9i/bioHiJT6tOVoXA+WUYHtyrh2Zkijhtx/wMpaP5cguzeXZ/vpeZbPxysa/?=
 =?us-ascii?Q?TS0w24NWke13hdw094jaXpjOfSfgbv7MPd2Ueajgg7HiBRSBnwOjCuxX+Q6u?=
 =?us-ascii?Q?V+c4OpDeZ6cX2dNGfAkDnUFzMEvBhB7arP1rx4Fz+R6EWiW1FEsDvV26Tf1G?=
 =?us-ascii?Q?7YvQSX9jqK2QdqtVp3rRAsfhja4XNhe0uat/9/ST4+SjGVAVN3hPKc7K1o1e?=
 =?us-ascii?Q?ENu1cPIxEmIxYdD5Au9pi0YOhnaGcpIYoaryDyU9Qbyc4/v1i8X0EGnoqZzT?=
 =?us-ascii?Q?Ct5Sz1/6fm/H/RTgUjrMxyyx6Hs+jT61DZmiOUH0to1SRoECccM15Oi/eO32?=
 =?us-ascii?Q?FpJJFHTeJPTu4qY9OUGf4chjahaI37qN+mr9zokysi6bypQgNCjOa9qU3BII?=
 =?us-ascii?Q?5NHf5SjMQyB3RAk/rcnQJjmRL0+gx0h61blM0Jbt48/b9ppSTTn74NZ5Lq0b?=
 =?us-ascii?Q?t7Y4kfqZgWqpo6dlB5JEnvQ06R3kTSb+YiQiwUpBxwW4bW/HmKFeKpWPDF3i?=
 =?us-ascii?Q?6BvvrWeWJ+5DNeKWPUnE5gw3fG6W9MeHZIvrsDhAHuUc5rytBv4lN1s+DbPo?=
 =?us-ascii?Q?LzSEwCNSptiUenLHh1Zu5wXOffpKzby0484jCPfsogfDeKc3Y7qMlNo6bL3/?=
 =?us-ascii?Q?zcNGosMseErA5g/MT+F2W6HT13V4aLMkHaJqaaRiVpqyX4ASKHA/1Wgombgz?=
 =?us-ascii?Q?mIVeejmVcOPEEhnsb85xCPRny+tXTFPzeeuhdqImZAtLXFGvz0pYSL00FfE2?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ffaae5-9c8f-4408-a0c7-08dc5548c740
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:17:04.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bmdon2wtSr17HwGqslCIEFynRjb9z26olVd0gWvN1WSJEBV9Qm5y0iW24VXqoQGCPL/oYPVrIGzulh4+BLDZzPyeb7OWByZhI01xjJv5YeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5678

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


