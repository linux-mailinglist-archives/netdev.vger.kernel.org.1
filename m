Return-Path: <netdev+bounces-75574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC086A946
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F081F28BF3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B725567;
	Wed, 28 Feb 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="I8TDm5S7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69625579
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106745; cv=fail; b=oy+B1Jgzwu08YYX8RWb5Knprls9IxVoEhylYOrCzqc4IKwDsocbpyCKttF/gg3cXf4is3izRsA8uDEwVcmpX1glsyPSZILananExoxG6rU5B82tuKFpge3w2uNBbOefeIqBERMWX3jLTIt4bx/8PZdD3ok9WMyVulmwxVQSpt5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106745; c=relaxed/simple;
	bh=LXz2OkyFMlV7l2hEg37jzGafdpcV0JTCVEa7FOtD2ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/g8pOf51wq23/0d8U6Y97DfZCnnX+awyBTnU3NhBcdwl7AkfzuKvgWb6wqgUe8qQWrYKdNwvlcYVzzOpyb/ZDtC00+6SNppEDVZGHg0pJmJwx4QYGTjHEr6+oyimjtDamQK8VCGlhK8GMMGgdd6AntRsQ1V9ioNuZTVg83SvHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=I8TDm5S7; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKjWDoG2mxEXP9DnxVqGDJfy1TKCIa5PpAA/zJxYKG6aCR4gcTUHKN5CWjOpVqyNDOU+V+moX4RGqjd2sv1BDBjMY86j2rm+Mdb2kyDrz17QmADhq/eK05LsVRpqDLli2ed9wSXpo6tMzI8QvMQbg/y2DA0rRQtleVjpX2ZPqa6dDDSvgB+kJhqWYs2jTviXKk0d6RNyiqgbU9F0MFeh5gCMHnhIZB7VO83Lobvg5F82E+4RgAp9Lns18dlcxHEmJzcydVlQsZ39rmRsp4iBB3uwhoC+XWBZRXypiZSwpWghZqQx64iTT3zYkthTsBGG50TbtaOM4CU77GLveXHDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oocHr/eLDO6DADJ8vYPGxAR3h5ZUhnGskdTNmuWUKI8=;
 b=RpO1r3NvaAp8UF+AQ2WRuNNcmdantQJYWd45cumznvTS3uQK801JHvft3sF7Mo1EKUc0KOB2ZNx9eVWDeBlisvHYkDsTRtLqCwh8OylABn/b+GmEdT1kUyj7lY80b+d0jJ08VspO5zSkD2qf0ZABJihuHWcIU7dFKOZIejyfoPO3/MY+Ps29BnSyNRnm+tBS0AAcWSxCNEJNPCuoMX6GKAS5EituHqERGViEEw7jbp+bV12iaWv43hWyza6B5UA6mzSCgGaSBlUrg67d7NvVTwdBdQkLyHXuG4Eix+XYLdoHbgmu5z/qAl0gzWUeNTu7/BmNPW39QaoBcTUdcvwlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oocHr/eLDO6DADJ8vYPGxAR3h5ZUhnGskdTNmuWUKI8=;
 b=I8TDm5S75OpFo5cUivFrJFURVTyH9JnmQ/BQlYcjZ2h624mHxbEdhiZHyn8w2f8wXJvEsH0GvafXbdBb+llsDXA/qPgW3twJlK8PwXv4ZCYn2GUsaMV6kO1Q6LkIE4tHr4Zwf/clL0hHfXlKP0HdFnjtjLDkhEZf6aIFsM82vpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4496.namprd13.prod.outlook.com (2603:10b6:5:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Wed, 28 Feb
 2024 07:52:20 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 07:52:20 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 1/4] devlink: add two info version tags
Date: Wed, 28 Feb 2024 09:51:37 +0200
Message-Id: <20240228075140.12085-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228075140.12085-1-louis.peens@corigine.com>
References: <20240228075140.12085-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DM6PR13MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 727d57fb-45f4-4281-6c3c-08dc3832312f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wuoVJ0VWMGYbHCpMS5fhU6vupRcPw9i6zoYMy4oI3jH2gCTrOdjf/SLVFb5BcV53rGhLVjbWzzm8MQo8zJ6kBJLQOIFsNZoJpUfI8SDfLsBpPAY3ue2KuYq293Sz0sv5oVUn62k9lto3DnDOKvac77Gd9qYTLy/8tZI5Y4QACONHxfdDnE2WU49WkqRSCV7yv5C7g6Pbdlr5mJTuxtVgOZZVVu1gEc221jSW6bHZ8Vxjr3HZMpyhxBtI2YyNl25AnvD5neoPhKBW2QH6FtrOwvsRnsGy63vSTLPH+vIIfedMvpLRIFg6nm45NT0y67FTHrkj3P2SJES7DMhPbYNLEnBxw45SMRo3usQnnep8QFrNaRq2dCjgwnnBvKcSHAQZWuuNxgGrGXbLwDdCj1hfPl9Sc5RRKxPXc6/bkbRycuDKhjyI1BZ6ZFmH8NtIA7xWRndYpiHcABhHykSl+6fUciqA1lgLvVzXAXUJdwH18Fruob6QaEPVuBbxxRFvwq1tFNdPEG9U1OxW/4BxLDT2bnStyA2B/W0Znx7W70+1OEyDKfmlu914CLmYTA9gdnEudxO7C3e4Dra2/ufiAU6pEkCOhyo2uSwzRWmyx2JVKo5vzVNFAnIcsTyb9y9feYdiTcF8xsYRsJ8z17/HxZ1sQmMl0/gcsl89PDCvhGi7SC4sTRCuNlptrhijzv7GbBDmeLomPBSIMs3aHO5dc7pxSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nUe+JJGj2MwOMX8+KK7nJvsAdVyT+R5nHgNHk5bSdVMA7euyF5P9egOzgOae?=
 =?us-ascii?Q?qgflxbFrF4/geKKxQziTPYLvibwXGRz3CbRrwHuE5+RKLv5lIuO8rRAILmdM?=
 =?us-ascii?Q?zKqz23aoK1IHDv3V51N/ReDAJazF4TLg4rJGJNKN8HehxaH99LJ+q9JSF2MZ?=
 =?us-ascii?Q?FfOjp0tJn+i29adIzT7CiDgclNtfljcEOXyiBm3glxRw3ehZBMVpQ3HPuzsj?=
 =?us-ascii?Q?UTL0GCBuWl4IKsTIEht0pGIgUax1PoF8TEvHKF/nS9ip9EGPl27IJh88zEQ9?=
 =?us-ascii?Q?3kKWdAywOkMkv6Z2oHXQdFBRCyVq0a8rM8Ll9InL1W8YalCXPNFCSeOkDMMZ?=
 =?us-ascii?Q?04RJPub5N5tUq2UiFtSF+lZulk7yzbAKCU8UBRTU95MbNHqgCjMovBFuZklz?=
 =?us-ascii?Q?DK8s+lSuUahewLHK/p6+lJdFelSQ651xyjh2SKlmffTtdVj3fjdXvTdt7KUu?=
 =?us-ascii?Q?VovT3qdSocjHwB7427n1ICtYTaCN0q1/qUr08lmzKf3oJrtcFwxsvCdWoUYb?=
 =?us-ascii?Q?AbsiZABKDftJm9osD0poEYqKvyz/L+gWv/ZYfRxDius7enwC2rVvRr37Rf2J?=
 =?us-ascii?Q?itOGzidQLFu5tND9yx+DTH046RsvMEQCA1Y5fH5Tu4BtOmX/rPkeg0ysHpHv?=
 =?us-ascii?Q?JKno/7a6v7QCNuFFvmftt9Id/+iKd6b3JksyTKQU0p3jKCNjLBRvxt2p513a?=
 =?us-ascii?Q?EbcPs+k4sm6PAIQS23tOXUi4y3mmaY2qm7MzFRKH/6LB+VzeqB6DtTjuuEQ6?=
 =?us-ascii?Q?iVlqsIAXZYbjEqLCkmhyfkJzfX33JsRg+1fWU4wyTXrozU/47R7diB8rn3bU?=
 =?us-ascii?Q?gGU5uqyN8vjJKWPmJP1opxpjs+3y4VbWYVX1jwdglooaD4xJwaMdqytDyhKq?=
 =?us-ascii?Q?LlMhx3zuka8fJcyrFYY/dgFuRil5CXS2NURISawPFvFJuND8nG8RENfE/dCE?=
 =?us-ascii?Q?8UsfCMXk3tm7jGp8Iq4veuXrCN0jG0EhHvWp0jaMobOUpZ1zU94AQ42yQQb7?=
 =?us-ascii?Q?KD51Fj52PzFOpgfS4KVyW9IYu+w/UXZga60zlCioyPbSd/UAYXimAD9oJdPn?=
 =?us-ascii?Q?gjBGYnvyVJODn/bqdIAJUE+WuHZrI1RztHHi3ot2E4wuEJ7s6AG1Mf2RxBs0?=
 =?us-ascii?Q?BXfilszgb9R/VN14dlz1nTSrGD0/5zzK4hMotmv21SHmtYv2am0Ubh2NduYE?=
 =?us-ascii?Q?CxX99xK9Y45C06OggBpy/nwQh08D9kwrFKuHiHf8S6cGnQKMdOI+xnSwayC1?=
 =?us-ascii?Q?jCboUPfS5tj5OhGaDHDG2Wz7iDEFpsDEqmL2ILW/kyQ5NoHRmA6Q8TyLppFC?=
 =?us-ascii?Q?5XVDZTqpTWYPXfSwUydP4WzaolF99LcYZtrubkAJDhphXo+oSVyIfpQzejUf?=
 =?us-ascii?Q?JZIZasm6l+nb8c51NN/xuU5cRuaoEutWjeaKoL+hEaWNEd5LMZkMexhpuh+J?=
 =?us-ascii?Q?OnoJwixOrzs1gc7woeqHdv/owUxllocGghmqTgXYixJLI4pZZn2cniCrMh2B?=
 =?us-ascii?Q?xLrdeu5nl/SOVwS8ohjgUzcwon6Z8l6tsVIOM5294BNM3MQfS2V3Z6DUADwl?=
 =?us-ascii?Q?KuV+irrGgEGyPLcHVI3X/ghXkKHG8nhITqyRTaa2WBr7zrNqcgcVX1324RZ6?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727d57fb-45f4-4281-6c3c-08dc3832312f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:52:20.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c5joNmO3Qy3kMSD4McZ19LUBv+gjfc4I8BQscAgT+TcHOKNIoa7CPy5co4cv2NRvP8kDbPpTkolZYYpuB8/C6ZczIdYhQnhT55OUALG4oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4496

From: Fei Qin <fei.qin@corigine.com>

Add definition and documentation for the new generic
info "board.model" and "part_number".

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/networking/devlink/devlink-info.rst | 10 ++++++++++
 include/net/devlink.h                             |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 1242b0e6826b..e663975a6b19 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -146,6 +146,11 @@ board.manufacture
 
 An identifier of the company or the facility which produced the part.
 
+board.model
+-----------
+
+Board design model.
+
 fw
 --
 
@@ -203,6 +208,11 @@ fw.bootloader
 
 Version of the bootloader.
 
+part_number
+-----------
+
+Part number of the entire product.
+
 Future work
 ===========
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..edcd7a1f7068 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -605,6 +605,8 @@ enum devlink_param_generic_id {
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_REV	"board.rev"
 /* Maker of the board */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE	"board.manufacture"
+/* Model of the board */
+#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"
 
 /* Part number, identifier of asic design */
 #define DEVLINK_INFO_VERSION_GENERIC_ASIC_ID	"asic.id"
@@ -632,6 +634,9 @@ enum devlink_param_generic_id {
 /* Bootloader */
 #define DEVLINK_INFO_VERSION_GENERIC_FW_BOOTLOADER	"fw.bootloader"
 
+/* Part number for entire product */
+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"
+
 /**
  * struct devlink_flash_update_params - Flash Update parameters
  * @fw: pointer to the firmware data to update from
-- 
2.34.1


