Return-Path: <netdev+bounces-111754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08236932734
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CEDB21EE6
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79719B3C0;
	Tue, 16 Jul 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PAUn7uJ7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEBB145345
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135517; cv=fail; b=JDJlRHhx2obKXVZ49ugpC+/Foq4v0wO3q4P8sFAHJkMic0jh9eTgE0GyiqRkykrKTpsNYPkavrWtroTFt/tkngtZmxsU3tfkAolI6Ooaaypw0kplxJquwcWmqImsNHbCZeqrjBHPB52DGmDue/7w3RV4b6xlCKXCccLWdw8C7h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135517; c=relaxed/simple;
	bh=9acZI5c+p1CFQhEYlQdJ7P/r+80QzzDvDUmVquiD5e4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIs72XrBDg56w2tFlGMaDkmkd5baotjkSAK7HFSMMlevmOh883el2sipKLbt2korpxtMA+lejiLImevJNVS1Xi4D9D2yBuLI2Et0VQGCbtioEzqC/JZFpuTnBpYDmZ2nYtvG7go+p/BJqfo4+AEYHvLpQEORcOU6OFupuDbDkDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PAUn7uJ7; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIIu7CBYYgHpoCNDnZ74mNpyOQTkjWZnBKNeL1bWV5jD1tcu97QNA8ZP+9b+sF+MpWKseia1e74Ol/uH+8TfhhIQSb3OCn/m5O0AvJD2ShHndXRrqxsrI+e64dqXZW8Q2jQsm3VIVFCj75ziLuKXrXWwgkQMTJ1+nm/337y/8m5OQsROp4AIpH/LYCrP9+cpfkKLisuBqCcjwqVOGMWOq0IGh8guZqQG/5FNbaTuHeVyIt+LkI1ZsU3GA5M3/zzo/mpUqMqmuqi0YmeRS37DW2AGJd7bzP5lJAGRkfcZDyUOwBRlgTTK3U64dbK+8CH1A25Cxco+5KpJMwdCdjoa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qp0NySkWdIosViXMhdc24bw1Nvo6HoW3U1QtLoXnkg=;
 b=De/iyNlxAOAUMjPR5TAYqHlDFAMyLdalFDqPNokuU65dLeVgKpvkvHBA+SeSsO6MfG4Bd1tw22t5Ii601u7lJbuGXa2o7f2QWfY4DnOuB8iLwvVauNlo4cMmwCw5SeNPPt2AZF0DQhTpbxi5WgbHjkqfdG6U+I3FPcdqRtxDi6MFbmGmmMIDGkEAp0b/UXQ4ixQ7dJvTg/R4fhBzEOAp8LPOSgRR0JQKqrP22E93ssMn6Cyh4JCj0EyRshiFnKFLiNRDy/mc3bCy/lIRBhlwutsir9k/fgAQaydeQAzCj3WRqh7gjlf/VRUH/W3NesPN8DW0xv7NFUSliWXFgRRrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qp0NySkWdIosViXMhdc24bw1Nvo6HoW3U1QtLoXnkg=;
 b=PAUn7uJ75bkpySR869aW2PDmqhOJsswVI4jo7Y52nRGp4RY2sK3HtCKVIi0dm/YgOfbASvnubOJC5yxcLOiUiZyMCtGX0flZNhFAAU/eWK7H6h6uronCEipDJ/vSF51gzX/DEAjiPoHB2pk885EiYd4q1Ea3xRJuFZW6nT5gJnFK9y0hgTnNuGHy1y2TUyaH/ztqfuFTESIAfKM7rY7frTbHn30p6ZDq62g52vZp+WSTAf+5Bsxdlhlh7XbR2PT0C6Anm2SW1lkoXD9T9Wh8EvDCef3RQeCb37Zld872KZo09C9OWi9B5y+40NTF1yI7QP+/GCWOJY9MiQxw+fUCfA==
Received: from CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::18)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 13:11:50 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:610:1e8:cafe::3f) by CH3P220CA0019.outlook.office365.com
 (2603:10b6:610:1e8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Tue, 16 Jul 2024 13:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:11:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Jul
 2024 06:11:35 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 06:11:33 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool-next 4/4] ethtool: Add ability to flash transceiver modules' firmware
Date: Tue, 16 Jul 2024 16:11:12 +0300
Message-ID: <20240716131112.2634572-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240716131112.2634572-1-danieller@nvidia.com>
References: <20240716131112.2634572-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b8cec6-8079-492a-558c-08dca598dab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjAvPqzeX/2yu6FB3rhiBvaONS1f0d9+ULGF1jspcdeK9nptLpp1Vzuz9wms?=
 =?us-ascii?Q?FHysWJHZFViHnR8On2VNGT4WVErgsvcR8pdD3O3Q3hR0p1xBkzF5xT633mM+?=
 =?us-ascii?Q?mABlmepuqYENFIH5nsV8xvamfcyj7vMcc5hSykGZTwZs8IfTE5+bPFpnDXsk?=
 =?us-ascii?Q?7PkWW48qGG+QcUsutWFLxs6W1cg9iZ3B18CAxsOw37mH446cTuUTtt7QpIc/?=
 =?us-ascii?Q?84qCxi6heUhYCHRAU7UB+q753LUaiG3yNz2AasA0kltY1pYumDX2AD/QO1pD?=
 =?us-ascii?Q?xqQ8k/m8V4xtRZAoayK5nHggidZr9OgwJ0xBrvzIO+HC+0QgHFqTqXScePiA?=
 =?us-ascii?Q?HYG+KFlG6GWYFsmZf1EZXoZQqLpn33p5ppvsR8XuYMYwOSYK3ylluXyNBrSy?=
 =?us-ascii?Q?AZrtNL5kRB7R9H+N+f7ExR8hz6p/sMYJGOWqyUcKtxTuXnzHSghSnHv3P9lN?=
 =?us-ascii?Q?6n/6XTqBQ1TM0C4Y7tnxUptsw+3Zzs1mLJTn4nMmevsQMdr6sJVbsMhhzb6o?=
 =?us-ascii?Q?6E5RjDFese/JceEnPoLI+ghTIU0zSu/bWgkNKTdBd0j/R+/hS82xnUUSE3DW?=
 =?us-ascii?Q?38rW8nqEc5NEbBuky+ps8AsWDh/RfzyJnFXmD5bXcq3F24ndaSxuoLZab6U7?=
 =?us-ascii?Q?9vtiERzCDHmv43nyKj7auaPJLqVSlmrY1Z4HYYnC5CqJH9+DyzY4PVA6odfj?=
 =?us-ascii?Q?fVYxYAJtPvm/9vp4mESATnOozfNfal5c8jg9hHicc0CijtFJOQr/lkLTd8Ht?=
 =?us-ascii?Q?Cx9UBADvSTZjG8mxr3rMl6EBt1CPR83AIacdODKzDJPs+Mr27KRuQTBo8+x3?=
 =?us-ascii?Q?WK1TtEmhXViSql//zHk9xzxU257oCQnttAlJA73McLNZn4as87AJsHAEBnAm?=
 =?us-ascii?Q?U9Wd/WhTqktvklw+ntXQ+gi30ID2jzCx8/VSiGPdvWJFJSEfa52AEBxojBm0?=
 =?us-ascii?Q?eCnqCkXv1/kvxTK1aLLS+U3RzoS+iVWWYPvuT3OwWdEZ7jRvXHzfoagCVPTg?=
 =?us-ascii?Q?xtrXydMSmxnR5E30z4gGw79+kG+ksmLN5dB7IJQxO68NpdA34TONupSmmjRs?=
 =?us-ascii?Q?QcRlmoN3lI++DL6fwlwF3ZvXXGbzfcJfYwQArIDohiPmYgU+U58bzdMkYmL8?=
 =?us-ascii?Q?kc2FxJppeVLQ7Ot00OPuLfcIYmfOT5zQGtJoIcnutnrCCcuqZCZLHt1cYXri?=
 =?us-ascii?Q?+PxEmGgn4vHB2Xjy+I4wuHd+nGr3HdMaxktKSLlwSm0KyCBl/5HTt368lw2I?=
 =?us-ascii?Q?42Uz4duVE/oivnA9pEb1SUKLB+2LNF6iRIkkg8//cwuD9fC5MbZsGRYowygD?=
 =?us-ascii?Q?2l6/EYPoP9h6l5nZ+lJWyKEjB4ftqT41Y/pA3TihHLc5Xx7PcPYfTKEB08Sf?=
 =?us-ascii?Q?f238AEVndkxjwL9sZEL4J94ehm0F4Rv7P+Z0AX2Rly9/qPKm8Fy8XhSPcmoQ?=
 =?us-ascii?Q?U7v31vtIMSQ6vCA88P7PrwyzsRyNojno?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:11:50.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b8cec6-8079-492a-558c-08dca598dab0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

Add ability to flash transceiver modules' firmware over netlink.

Example output:

 # ethtool --flash-module-firmware eth0 file test.img

Transceiver module firmware flashing started for device swp23
Transceiver module firmware flashing in progress for device swp23
Progress: 99%
Transceiver module firmware flashing completed for device swp23

Co-developed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.8.in                  |  29 ++++++
 ethtool.c                     |   7 ++
 netlink/desc-ethtool.c        |  13 +++
 netlink/extapi.h              |   2 +
 netlink/module.c              | 183 ++++++++++++++++++++++++++++++++++
 netlink/netlink.h             |  16 +++
 netlink/prettymsg.c           |   5 +
 netlink/prettymsg.h           |   2 +
 shell-completion/bash/ethtool |  27 +++++
 9 files changed, 284 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 8090f0f..bfcaca8 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -536,6 +536,13 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .RB [ podl\-pse\-admin\-control
 .BR enable | disable ]
+.HP
+.B ethtool \-\-flash\-module\-firmware
+.I devname
+.BI file
+.IR FILE
+.RB [ pass
+.IR PASS ]
 .
 .\" Adjust lines (i.e. full justification) and hyphenate.
 .ad
@@ -1772,6 +1779,28 @@ Set Power Sourcing Equipment (PSE) parameters.
 This parameter manages PoDL PSE Admin operations in accordance with the IEEE
 802.3-2018 30.15.1.2.1 (acPoDLPSEAdminControl) specification.
 
+.RE
+.TP
+.B \-\-flash\-module\-firmware
+Flash the transceiver module's firmware. The firmware update process is
+composed from three logical steps. Downloading a firmware image to the
+transceiver module, running the image and committing the image so that it is
+run upon reset. When flash command is given, the firmware update process is
+performed in its entirety in that order.
+.RS 4
+.TP
+.BI file \ FILE
+Specifies the filename of the transceiver module firmware image. The firmware
+must first be installed in one of the directories where the kernel firmware
+loader or firmware agent will look, such as /lib/firmware. The firmware image
+is downloaded to the transceiver module, validated, run and committed.
+.RE
+.RS 4
+.TP
+.BI pass \ PASS
+Optional transceiver module password that might be required as part of the
+transceiver module firmware update process.
+
 .SH BUGS
 Not supported (in part or whole) on all network drivers.
 .SH AUTHOR
diff --git a/ethtool.c b/ethtool.c
index d85a57a..0a6a9f9 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6218,6 +6218,13 @@ static const struct option args[] = {
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-admin-control enable|disable ]\n"
 	},
+	{
+		.opts	= "--flash-module-firmware",
+		.nlfunc	= nl_flash_module_fw,
+		.help	= "Flash transceiver module firmware",
+		.xhelp	= "		file FILE\n"
+			  "		[ pass PASS ]\n"
+	},
 	{
 		.opts	= "-h|--help",
 		.no_dev	= true,
diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
index 661de26..bd5cbc1 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -496,6 +496,17 @@ static const struct pretty_nla_desc __mm_desc[] = {
 	NLATTR_DESC_NESTED(ETHTOOL_A_MM_STATS, mm_stat),
 };
 
+static const struct pretty_nla_desc __module_fw_flash_desc[] = {
+	NLATTR_DESC_INVALID(ETHTOOL_A_MODULE_FW_FLASH_UNSPEC),
+	NLATTR_DESC_NESTED(ETHTOOL_A_MODULE_FW_FLASH_HEADER, header),
+	NLATTR_DESC_STRING(ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME),
+	NLATTR_DESC_U32(ETHTOOL_A_MODULE_FW_FLASH_PASS),
+	NLATTR_DESC_U32(ETHTOOL_A_MODULE_FW_FLASH_STATUS),
+	NLATTR_DESC_STRING(ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG),
+	NLATTR_DESC_UINT(ETHTOOL_A_MODULE_FW_FLASH_DONE),
+	NLATTR_DESC_UINT(ETHTOOL_A_MODULE_FW_FLASH_TOTAL),
+};
+
 const struct pretty_nlmsg_desc ethnl_umsg_desc[] = {
 	NLMSG_DESC_INVALID(ETHTOOL_MSG_USER_NONE),
 	NLMSG_DESC(ETHTOOL_MSG_STRSET_GET, strset),
@@ -541,6 +552,7 @@ const struct pretty_nlmsg_desc ethnl_umsg_desc[] = {
 	NLMSG_DESC(ETHTOOL_MSG_PLCA_GET_STATUS, plca),
 	NLMSG_DESC(ETHTOOL_MSG_MM_GET, mm),
 	NLMSG_DESC(ETHTOOL_MSG_MM_SET, mm),
+	NLMSG_DESC(ETHTOOL_MSG_MODULE_FW_FLASH_ACT, module_fw_flash),
 };
 
 const unsigned int ethnl_umsg_n_desc = ARRAY_SIZE(ethnl_umsg_desc);
@@ -590,6 +602,7 @@ const struct pretty_nlmsg_desc ethnl_kmsg_desc[] = {
 	NLMSG_DESC(ETHTOOL_MSG_PLCA_NTF, plca),
 	NLMSG_DESC(ETHTOOL_MSG_MM_GET_REPLY, mm),
 	NLMSG_DESC(ETHTOOL_MSG_MM_NTF, mm),
+	NLMSG_DESC(ETHTOOL_MSG_MODULE_FW_FLASH_NTF, module_fw_flash),
 };
 
 const unsigned int ethnl_kmsg_n_desc = ARRAY_SIZE(ethnl_kmsg_desc);
diff --git a/netlink/extapi.h b/netlink/extapi.h
index e2d6b71..c882295 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -55,6 +55,7 @@ int nl_get_mm(struct cmd_context *ctx);
 int nl_set_mm(struct cmd_context *ctx);
 int nl_gpse(struct cmd_context *ctx);
 int nl_spse(struct cmd_context *ctx);
+int nl_flash_module_fw(struct cmd_context *ctx);
 
 void nl_monitor_usage(void);
 
@@ -130,6 +131,7 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_set_mm		NULL
 #define nl_gpse			NULL
 #define nl_spse			NULL
+#define nl_flash_module_fw	NULL
 
 #endif /* ETHTOOL_ENABLE_NETLINK */
 
diff --git a/netlink/module.c b/netlink/module.c
index 54aa6d0..42def91 100644
--- a/netlink/module.c
+++ b/netlink/module.c
@@ -10,6 +10,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <stdio.h>
+#include <stdarg.h>
 
 #include "../internal.h"
 #include "../common.h"
@@ -177,3 +178,185 @@ int nl_smodule(struct cmd_context *ctx)
 	else
 		return nlctx->exit_code ?: 83;
 }
+
+/* MODULE_FW_FLASH_ACT */
+
+static const struct param_parser flash_module_fw_params[] = {
+	{
+		.arg		= "file",
+		.type		= ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,
+		.handler	= nl_parse_string,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "pass",
+		.type		= ETHTOOL_A_MODULE_FW_FLASH_PASS,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+struct module_flash_context {
+	uint8_t breakout:1,
+		first:1;
+};
+
+static int module_fw_flash_ntf_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_MODULE_FW_FLASH_MAX + 1] = {};
+	struct module_flash_context *mfctx;
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	u8 status = 0;
+	int ret;
+
+	mfctx = nlctx->cmd_private;
+
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return MNL_CB_OK;
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_MODULE_FW_FLASH_HEADER]);
+	if (!dev_ok(nlctx))
+		return MNL_CB_OK;
+
+	if (tb[ETHTOOL_A_MODULE_FW_FLASH_STATUS])
+		status = mnl_attr_get_u32(tb[ETHTOOL_A_MODULE_FW_FLASH_STATUS]);
+
+	switch (status) {
+	case ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED:
+		print_string(PRINT_FP, NULL,
+			     "Transceiver module firmware flashing started for device %s\n",
+			     nlctx->devname);
+		break;
+	case ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS:
+		if (mfctx->first) {
+			print_string(PRINT_FP, NULL,
+				     "Transceiver module firmware flashing in progress for device %s\n",
+				     nlctx->devname);
+			mfctx->first = 0;
+		}
+		break;
+	case ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED:
+		print_nl();
+		print_string(PRINT_FP, NULL,
+			     "Transceiver module firmware flashing completed for device %s\n",
+			     nlctx->devname);
+		mfctx->breakout = 1;
+		break;
+	case ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR:
+		print_nl();
+		print_string(PRINT_FP, NULL,
+			     "Transceiver module firmware flashing encountered an error for device %s\n",
+			     nlctx->devname);
+		mfctx->breakout = 1;
+		break;
+	default:
+		break;
+	}
+
+	if (tb[ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG]) {
+		const char *status_msg;
+
+		status_msg = mnl_attr_get_str(tb[ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG]);
+		print_string(PRINT_FP, NULL, "Status message: %s\n", status_msg);
+	}
+
+	if (tb[ETHTOOL_A_MODULE_FW_FLASH_DONE] &&
+	    tb[ETHTOOL_A_MODULE_FW_FLASH_TOTAL]) {
+		uint64_t done, total;
+
+		done = attr_get_uint(tb[ETHTOOL_A_MODULE_FW_FLASH_DONE]);
+		total = attr_get_uint(tb[ETHTOOL_A_MODULE_FW_FLASH_TOTAL]);
+
+		if (total)
+			print_u64(PRINT_FP, NULL, "Progress: %"PRIu64"%\r",
+				  done * 100 / total);
+	}
+
+	return MNL_CB_OK;
+}
+
+static int nl_flash_module_fw_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct genlmsghdr *ghdr = (const struct genlmsghdr *)(nlhdr + 1);
+
+	if (ghdr->cmd != ETHTOOL_MSG_MODULE_FW_FLASH_NTF)
+		return MNL_CB_OK;
+
+	module_fw_flash_ntf_cb(nlhdr, data);
+
+	return MNL_CB_STOP;
+}
+
+static int nl_flash_module_fw_process_ntf(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct module_flash_context *mfctx;
+	struct nl_socket *nlsk;
+	int ret;
+
+	nlsk = nlctx->ethnl_socket;
+
+	mfctx = malloc(sizeof(struct module_flash_context));
+	if (!mfctx)
+		return -ENOMEM;
+
+	mfctx->breakout = 0;
+	mfctx->first = 1;
+	nlctx->cmd_private = mfctx;
+
+	while (!mfctx->breakout) {
+		ret = nlsock_process_reply(nlsk, nl_flash_module_fw_cb, nlctx);
+		if (ret)
+			goto out;
+		nlsk->seq++;
+	}
+
+out:
+	free(mfctx);
+	return ret;
+}
+
+int nl_flash_module_fw(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_msg_buff *msgbuff;
+	struct nl_socket *nlsk;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_MODULE_FW_FLASH_ACT, false))
+		return -EOPNOTSUPP;
+	if (!ctx->argc) {
+		fprintf(stderr, "ethtool (--flash-module-firmware): parameters missing\n");
+		return 1;
+	}
+
+	nlctx->cmd = "--flash-module-firmware";
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	nlctx->devname = ctx->devname;
+	nlsk = nlctx->ethnl_socket;
+	msgbuff = &nlsk->msgbuff;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return 2;
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_MODULE_FW_FLASH_HEADER,
+			       ctx->devname, 0))
+		return -EMSGSIZE;
+
+	ret = nl_parser(nlctx, flash_module_fw_params, NULL, PARSER_GROUP_NONE,
+			NULL);
+	if (ret < 0)
+		return 1;
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		fprintf(stderr, "Cannot flash transceiver module firmware\n");
+	else
+		ret = nl_flash_module_fw_process_ntf(ctx);
+
+	return ret;
+}
diff --git a/netlink/netlink.h b/netlink/netlink.h
index 1274a3b..92a336e 100644
--- a/netlink/netlink.h
+++ b/netlink/netlink.h
@@ -175,4 +175,20 @@ static inline int netlink_init_rtnl_socket(struct nl_context *nlctx)
 	return nlsock_init(nlctx, &nlctx->rtnl_socket, NETLINK_ROUTE);
 }
 
+static inline uint64_t attr_get_uint(const struct nlattr *attr)
+{
+	switch (mnl_attr_get_payload_len(attr)) {
+	case sizeof(uint8_t):
+		return mnl_attr_get_u8(attr);
+	case sizeof(uint16_t):
+		return mnl_attr_get_u16(attr);
+	case sizeof(uint32_t):
+		return mnl_attr_get_u32(attr);
+	case sizeof(uint64_t):
+		return mnl_attr_get_u64(attr);
+	}
+
+	return -1ULL;
+}
+
 #endif /* ETHTOOL_NETLINK_INT_H__ */
diff --git a/netlink/prettymsg.c b/netlink/prettymsg.c
index fbf684f..0eb4447 100644
--- a/netlink/prettymsg.c
+++ b/netlink/prettymsg.c
@@ -15,6 +15,8 @@
 #include <linux/if_link.h>
 #include <libmnl/libmnl.h>
 
+#include "../internal.h"
+#include "netlink.h"
 #include "prettymsg.h"
 
 #define __INDENT 4
@@ -114,6 +116,9 @@ static int pretty_print_attr(const struct nlattr *attr,
 	case NLA_U64:
 		printf("%" PRIu64, mnl_attr_get_u64(attr));
 		break;
+	case NLA_UINT:
+		printf("%" PRIu64, attr_get_uint(attr));
+		break;
 	case NLA_X8:
 		printf("0x%02x", mnl_attr_get_u8(attr));
 		break;
diff --git a/netlink/prettymsg.h b/netlink/prettymsg.h
index 8ca1db3..ef8e73f 100644
--- a/netlink/prettymsg.h
+++ b/netlink/prettymsg.h
@@ -18,6 +18,7 @@ enum pretty_nla_format {
 	NLA_U16,
 	NLA_U32,
 	NLA_U64,
+	NLA_UINT,
 	NLA_X8,
 	NLA_X16,
 	NLA_X32,
@@ -67,6 +68,7 @@ struct pretty_nlmsg_desc {
 #define NLATTR_DESC_U16(_name)		NLATTR_DESC(_name, NLA_U16)
 #define NLATTR_DESC_U32(_name)		NLATTR_DESC(_name, NLA_U32)
 #define NLATTR_DESC_U64(_name)		NLATTR_DESC(_name, NLA_U64)
+#define NLATTR_DESC_UINT(_name)		NLATTR_DESC(_name, NLA_UINT)
 #define NLATTR_DESC_X8(_name)		NLATTR_DESC(_name, NLA_X8)
 #define NLATTR_DESC_X16(_name)		NLATTR_DESC(_name, NLA_X16)
 #define NLATTR_DESC_X32(_name)		NLATTR_DESC(_name, NLA_X32)
diff --git a/shell-completion/bash/ethtool b/shell-completion/bash/ethtool
index f7d6aed..3c775a1 100644
--- a/shell-completion/bash/ethtool
+++ b/shell-completion/bash/ethtool
@@ -1164,6 +1164,32 @@ _ethtool_set_module()
 	COMPREPLY=( $( compgen -W "${!settings[*]}" -- "$cur" ) )
 }
 
+# Completion for ethtool --flash-module-firmware
+_ethtool_flash_module_firmware()
+{
+	local -A settings=(
+		[file]=1
+		[pass]=1
+	)
+
+	case "$prev" in
+		file)
+			_ethtool_firmware
+			return ;;
+		pass)
+			# Number
+			return ;;
+	esac
+
+	# Remove settings which have been seen
+	local word
+	for word in "${words[@]:3:${#words[@]}-4}"; do
+		unset "settings[$word]"
+	done
+
+	COMPREPLY=( $( compgen -W "${!settings[*]}" -- "$cur" ) )
+}
+
 # Complete any ethtool command
 _ethtool()
 {
@@ -1217,6 +1243,7 @@ _ethtool()
 		[--test]=test
 		[--set-module]=set_module
 		[--show-module]=devname
+		[--flash-module-firmware]=flash_module_firmware
 	)
 	local -A other_funcs=(
 		[--config-ntuple]=config_nfc
-- 
2.45.0


