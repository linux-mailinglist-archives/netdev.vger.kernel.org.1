Return-Path: <netdev+bounces-210520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005DDB13CBA
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC04817EC46
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C461A5B8B;
	Mon, 28 Jul 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMu0BL8y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6A433C4
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711680; cv=fail; b=W4dsUcSPNPOcFExR34jSR+2ubtmYR9hq3fLX9LVnAux2LkzZmopYsAvVr/9rx/osOJdOw7nKC/5GEmEEQFURxiPMnouqsp/MtYXgHe1v6Ogi/2fraAY9OXc31fI47/rLBkX7Oj0o5MxBwCewjZGzbi6tCWJl8CLowsbeXClbo4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711680; c=relaxed/simple;
	bh=DbxMMdW4LkwG81HyV3zAblPlaDWG+3Zt9At4U+n1KkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vy+ap5rq0Ird7ckQ6MQixBV12/czYbmtdLOY/AlXSYW0eTorQAIRvJzyI0BKpMQMeMWdkQjfcpTTsRyOrWnMzWzjhPWpRggrG2oafkVDiZyxQ8rNlx/l7pXRDo5xP1rq9ZDToRSZbV2k8ECOk5qaO/CCI4fOQ6ro923SUSRv/Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMu0BL8y; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwIxgk72STJ78VtM+YA/jmpz6c4X6WsKyCcfuuKuVkIhud55MRcCANc8rXWNW3QES0YisiLd5dJhtocxaggP4KmDw14XOVRwtLJwlLkWO4FGmUkC/l0HdZcHrnadPkVQX6AmrZfSObUb+vGuoKlRRyGVUrlO+BvFwV5ct4L/4Vm43YJ59yL7jGlUd9EpG7Hmxf8e690tDJJy+4ca5kejAg7XyIC8FkmNMiGgV2OFmEgHSJWUXwPlPxWJS1MXJL2EgJeBgRhDSB69LH8hY5sxkMoj4XdkvUl0CvwRBtcELAqS97YmH9AA43/P6EOZhXZM9SoRmfvLkgOS93hHWh6uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+2VxpoLHSYaEVg+XIVPbvjWV4Vo0zas+lApOEbX/G8=;
 b=FkXr1ehpc8sauel9M96iuAHOBN45kHS1qelY4ipIYY05O7iRxt9eshE9kkZA45/AIUcmAs16zuU+g99KRrFhpTDJdz5BOJWmYmZaonEYtk6tluJrH+vnHtmbWiAcLFQLbI18+x3tnBDidStPRlm+b+Bb0pAB4pHjRGqZA4D8nkmxG9fj6a5D7tqBbliJ9xIZf2GixddPoa8b5VOsJZ0VwwE9AWkJoh+SBSxfvgN0v7MFZ9qV/kQkc4zk7Z4TZZcZJo9s9rmzzBy0+12vJx1FzQ/rKO0LJixHap4JrGkKEHFg7pwFffLi4frrGctP7W4E9GYdnS9SrMnvKgtuA4Mhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+2VxpoLHSYaEVg+XIVPbvjWV4Vo0zas+lApOEbX/G8=;
 b=aMu0BL8yzYV3WJC36t4xDM4BaEx9e/DzhCOF3DM/ZVkQO5Wd8Wo0FY3l/HjI6BH30jzZIJwVFAT19L+GQVPqY5NowdbFyhgUZEfcTbcv/h5OJUXDaVpWSliF6hAYBnxmanDzZ8toAq/WNEFeFPOfXXUIfFog70vWXkgZKYaD4539Toks7KOQN7DBoNut889KRlEAZcyYaMgeCvSFqBtpiFTxkL6mKFy43D6SHjidSb7qIapeXG2EzdY7JPFYlLX+cmqwvqiSxeX049kJIJjfrsYCQzVNjcloGcxYJFQeY9vF2/3JXsIqFIitB+QLLhhhpv74IfQdzCFimeQRg9BmgQ==
Received: from DM5PR08CA0025.namprd08.prod.outlook.com (2603:10b6:4:60::14) by
 LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:07:48 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::5c) by DM5PR08CA0025.outlook.office365.com
 (2603:10b6:4:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 14:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 14:07:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Jul
 2025 07:07:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Jul
 2025 07:06:35 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Jul 2025 07:06:34 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: <stephen@networkplumber.org>, <dsahern@gmail.com>
CC: Jiri Pirko <jiri@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH iproute2-next] devlink: Update uapi headers
Date: Mon, 28 Jul 2025 17:05:54 +0300
Message-ID: <20250728140554.2175973-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: fcadf809-fbc2-4193-dcb3-08ddcde02213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbDZRc//ey3WncH6PUvlOM+7aOxmmzmZUWx6QIDjmQBhJeiL9slLT5Oq8PCV?=
 =?us-ascii?Q?WMh3JKul9SW/h8tpzBOn3yLIVRz8aU5aZTgXjNzdCJONQs2A9kigGftWTEmg?=
 =?us-ascii?Q?6TnXXHHqzzns6oFujanh01bKP1mLnzm/QbC7lwQicu9zD1nvvU3IrK+bg2hG?=
 =?us-ascii?Q?fiOCbIZBTgGeOBpSdfkOZ7ZmH6oWXFMZJ3Xp88mxTVR4eO93scqygVC6xKOD?=
 =?us-ascii?Q?Xqke0HAJnvOzYm1hR0QercN0HEaZajiPRBUoItahFAmTujBcWaS9fmONV0OG?=
 =?us-ascii?Q?cU3rV+u6kq39FhaV2ktTgV+zmkwRMUOkYqtNUnI3ipXSKrBFX1qWZqSzLvag?=
 =?us-ascii?Q?tkvR/RJ4rGZg1mnCsTcXOmqYgVFy7DEdyqxOT6S8HutkVdBCMUFc/7j45bmv?=
 =?us-ascii?Q?w9uQ6eVXII0dkJWuZm0ZcCKG8nPzPSZeIHtE74ZLpbpgnr0fZe4QfGGYt7zW?=
 =?us-ascii?Q?njlQacEOJtnRz6F1xV5rNoqhNkcAQQF0Z/U9umT3tCfcRKSfoxiUxFkRK8Yd?=
 =?us-ascii?Q?qU1ODlgzV8EhfCXyqvAnChxzzVTFOwJ44XjHQSOsCBuGNVd5hNmCm90Cec6d?=
 =?us-ascii?Q?6+yk5i5PaoeXdtFDVibXiAQlI+WsfBfY8oAmo5doJ6RkWIXoworn8bGQcV3/?=
 =?us-ascii?Q?yLtRg1WjGl8fI9hCww/c87ezKKBMyD3szAhOXaM/WFX5UVEWEKVg2vWsN1ah?=
 =?us-ascii?Q?Pi4mov58gxKEhmWM9Ib1/2yR1V8d6A73iopRTjv2RTZWcMk2K2EdWOsSHwN2?=
 =?us-ascii?Q?Fma3Jy1Nrf+doUi2u6+vt3IBrsdCfW5Ty3zSP7uxqesn2Tk8SvrcnTEHv/J0?=
 =?us-ascii?Q?lolJlKXSy/WgwKnlouL1gofE0X2fdncuYJmr3BU2m0dLb9/u6qoYE7PpmQ4r?=
 =?us-ascii?Q?oV+Smk6oIq/Foz9qcvY06i9tTMJs89kG0BdNCfKQhqcabjLSNCW+3iz1wNSW?=
 =?us-ascii?Q?hLAbZ71TldNKRHNswxAx7gduiLfAjVgSYuifgr2cEDJn26ldmWxU8zzWSe4b?=
 =?us-ascii?Q?7IHUYyytHvioTtYn8gwjs/SaZmnts6XQcQIeTyZUXSlFGH+QDt8JIW0g/lbu?=
 =?us-ascii?Q?lPbYIy106EFNhOxXfiWmBaw36fAtgw2W73AwHEcnyJyTS7o89ECadKYVxtR0?=
 =?us-ascii?Q?1T1CI4pvUty3RhzkhFq4qoePWkkuozFjOAO4xQKp9A7s8Jb4fAB5A+N1+wqL?=
 =?us-ascii?Q?je8wftb36wAcL2+Ts5ptRnU/HwWseJiXnebX9RL1touUeSdIPS06KQj8L/bQ?=
 =?us-ascii?Q?vsO6EF0qX8ffA5oLdbmES2wBdDEs2ffgacpKkrIC8uSfkK843BpKmflsY+sz?=
 =?us-ascii?Q?X08QRHhbtS/lmuxKE/64AACM8rY+pwES88Yp2d6fSvlcc7Xf1tPsfgarvDVk?=
 =?us-ascii?Q?nWiwB47ad+tjgN1z859+PzHLw6jydRONOEMWrVNG5VFirjL4lacFZ8hrtS6T?=
 =?us-ascii?Q?MzSGxeexjYAosxues4EkEK56BPwJnblGEPfDl4QDjJ7N7opTvwlSQM1KM2Pv?=
 =?us-ascii?Q?zmX6nABy/e/2OKwLkNZdJVo+EMlkO40wehaY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:07:48.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcadf809-fbc2-4193-dcb3-08ddcde02213
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261

Update devlink.h file up to kernel commit 1bbdb81a9836 ("devlink: Fix
excessive stack usage in rate TC bandwidth parsing").

Fixes: c83d1477f8b2 ("Add support for 'tc-bw' attribute in devlink-rate")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
---
 devlink/devlink.c            | 39 ++++++++++++++++++++++++++++--------
 include/uapi/linux/devlink.h | 11 ++++++++--
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index fe0c3640..171b8532 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2773,8 +2773,8 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 			nla_tc_bw_entry =
 				mnl_attr_nest_start(nlh,
 						    DEVLINK_ATTR_RATE_TC_BWS);
-			mnl_attr_put_u8(nlh, DEVLINK_ATTR_RATE_TC_INDEX, i);
-			mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TC_BW,
+			mnl_attr_put_u8(nlh, DEVLINK_RATE_TC_ATTR_INDEX, i);
+			mnl_attr_put_u32(nlh, DEVLINK_RATE_TC_ATTR_BW,
 					 opts->rate_tc_bw[i]);
 			mnl_attr_nest_end(nlh, nla_tc_bw_entry);
 		}
@@ -5467,20 +5467,43 @@ static char *port_rate_type_name(uint16_t type)
 	}
 }
 
+static const enum mnl_attr_data_type
+rate_tc_bws_policy[DEVLINK_RATE_TC_ATTR_BW + 1] = {
+	[DEVLINK_RATE_TC_ATTR_INDEX] = MNL_TYPE_U8,
+	[DEVLINK_RATE_TC_ATTR_BW] = MNL_TYPE_U32,
+};
+
+static int rate_tc_bw_attr_cb(const struct nlattr *attr, void *data)
+{
+	const struct nlattr **tb = data;
+	int type;
+
+	if (mnl_attr_type_valid(attr, DEVLINK_RATE_TC_ATTR_MAX) < 0)
+		return MNL_CB_OK;
+
+	type = mnl_attr_get_type(attr);
+
+	if (mnl_attr_validate(attr, rate_tc_bws_policy[type]) < 0)
+		return MNL_CB_ERROR;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
 static int
 parse_rate_tc_bw(struct nlattr *nla_tc_bw, uint8_t *tc_index, uint32_t *tc_bw)
 {
-	struct nlattr *tb_tc_bw[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *tb_tc_bw[DEVLINK_RATE_TC_ATTR_MAX + 1] = {};
 
-	if (mnl_attr_parse_nested(nla_tc_bw, attr_cb, tb_tc_bw) != MNL_CB_OK)
+	if (mnl_attr_parse_nested(nla_tc_bw, rate_tc_bw_attr_cb, tb_tc_bw) != MNL_CB_OK)
 		return MNL_CB_ERROR;
 
-	if (!tb_tc_bw[DEVLINK_ATTR_RATE_TC_INDEX] ||
-	    !tb_tc_bw[DEVLINK_ATTR_RATE_TC_BW])
+	if (!tb_tc_bw[DEVLINK_RATE_TC_ATTR_INDEX] ||
+	    !tb_tc_bw[DEVLINK_RATE_TC_ATTR_BW])
 		return MNL_CB_ERROR;
 
-	*tc_index = mnl_attr_get_u8(tb_tc_bw[DEVLINK_ATTR_RATE_TC_INDEX]);
-	*tc_bw = mnl_attr_get_u32(tb_tc_bw[DEVLINK_ATTR_RATE_TC_BW]);
+	*tc_index = mnl_attr_get_u8(tb_tc_bw[DEVLINK_RATE_TC_ATTR_INDEX]);
+	*tc_bw = mnl_attr_get_u32(tb_tc_bw[DEVLINK_RATE_TC_ATTR_BW]);
 
 	return MNL_CB_OK;
 }
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 78f505c1..a89df2a7 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -635,8 +635,6 @@ enum devlink_attr {
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
-	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
-	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
 
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
@@ -647,6 +645,15 @@ enum devlink_attr {
 	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
 };
 
+enum devlink_rate_tc_attr {
+	DEVLINK_RATE_TC_ATTR_UNSPEC,
+	DEVLINK_RATE_TC_ATTR_INDEX,		/* u8 */
+	DEVLINK_RATE_TC_ATTR_BW,		/* u32 */
+
+	__DEVLINK_RATE_TC_ATTR_MAX,
+	DEVLINK_RATE_TC_ATTR_MAX = __DEVLINK_RATE_TC_ATTR_MAX - 1
+};
+
 /* Mapping between internal resource described by the field and system
  * structure
  */
-- 
2.38.1


