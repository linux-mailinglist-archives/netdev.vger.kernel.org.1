Return-Path: <netdev+bounces-117473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350394E105
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5E01F2150D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC654AED7;
	Sun, 11 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGLfIQ/r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4412E71
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723377631; cv=fail; b=FYbsJXJE2n/1Zfa3yZ3ZpYXupcfK84ZjJlvJN93+WrOgMnPtqD7pDdb/FiRO9XlGH1bZ5AQL2fBkqQBjYi+8w+5szbWJZPJG5uzZFZJvCKM3nwDJ6tWZCFm64Nr+5x3ZsT2nVF6nG/a75Fr0GoTcuA5vYpYM4TazFyFWQnr6kKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723377631; c=relaxed/simple;
	bh=CTwdLR9vxJwjzHxxG2M93elhZRkkTr40IyMbeCNRRMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUS8O7ze5cFCEzLzT2ZsPAunPNFhGweWMtZfTVNF6bzJGz9px3Tq7vwRrC3e/1lSQGZEMs4vR5J1dO6VChSNAj8TX80miZFmz/Fp9To9XoALgryL7M4rvT6D+hh64Dc14KyvDyqpS/1HSlT6TOPcM+PWfbPVe0xezCcknznO+FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGLfIQ/r; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhBGat1HfLJbQlJbURbBam0RE5Y5+qdcr6vLHhWgDo+KX5Axi5dty210kRsn9jIN0nZyqQBDR0a1XLQVABAXZXKwdSzezjiGjbfzeVOmM8eem9DCVHmCogxxbLGS1RYqNpxF0F0YYHVjsymdL5VhnpYJWNw/VD3Y9LDcGInTP6S7wbLB/4jFNfypOL+Hx9Z8u5D7giOutw257fCLvDBjeNgStXnT4FUTehL7l+IEms3o12AZ6ir0F/MDRSEbHLpFturRoUXNqNcewtngdK2wPc0uSfQgGROwT25NrDvJFxt7JOSTJl6zc9c9SxbtuTIymb24YUFLdRXpaqGejkZE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv6crm5VZm0KUEnMrOkW494ZQwQD1Qu7ua52vrt7V/U=;
 b=Qr0jRftCU7bIzY2y4LXzR8AHWoLtvvO6wukqzN/1QH1JtdsnWDF0YAvmaRmcUyHIxvPJzo2bLuk4E1eytFxqaqrDB/O5A0mXsB2uuSPr9DAve/bcTzBA0fUBsQ3PJg2o7VOXbOh1lJ7VD15W0Of57Mv32hm05sGMTblJGbmSjwZr51mkQd2bI+89UbZl7QqLI2vK4QhdNyQubGbenWiyhQgTTdmVg6hP3QCvEA6RcxcP6Gq73xt+BqbTC+oatlOhjETJCOgJHxQkmy/pk6cl3YFwcdu5gcJchPjGLx7yGAu3WbOszBdCPLofuMimEypmTQRCquKqclmODTruI1a7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv6crm5VZm0KUEnMrOkW494ZQwQD1Qu7ua52vrt7V/U=;
 b=kGLfIQ/rp/kFRJBjaYfTt1oFdRz10GZ2bZQbPIw4c0+UctszzenmMlYZtIDUaYx9gmnpoUhWgHH77jlR4vF0qgCj00CTv6IS9J9lsqEJk5ws/YG4/R9OM5bRi2ASkZxcomUj0AF2YqG3ZeJkU6RjGwOQG3Gv6FCFj7HQ03dw4cXgNOL41Oan6fiNgg3vwisyG+gtkkNe7p55nG3gk3swnA1tKAc4OWZWbl9rFW6B25VcL8auISFtP+bTirD4Ar5JYpzcqPEVsnDlwkPzysTzAaFmJsxetHxQy1hY7tbKxVlxTCtCID3ZiP61I3OtLcBlN5tY6VZxE5ZPoGyvQvuxfQ==
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 12:00:23 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::dc) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Sun, 11 Aug 2024 12:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 12:00:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 Aug
 2024 05:00:09 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 Aug 2024 05:00:06 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool-next v2 3/3] ethtool: Add ability to flash transceiver modules' firmware
Date: Sun, 11 Aug 2024 14:59:48 +0300
Message-ID: <20240811115948.3335883-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240811115948.3335883-1-danieller@nvidia.com>
References: <20240811115948.3335883-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: acfdc981-17e6-4edb-e2fa-08dcb9fd2e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HorwAIu9B0eVns4TbF0tFCCTbSyQFtaFId9f4D4GKmuDa72v4Gwc/vzBiWkZ?=
 =?us-ascii?Q?X6TsoOMIsUWsblA2BD0Iqoqp0ZjhYABHEaM5u00VyElbjpmREveLNtZU65cW?=
 =?us-ascii?Q?SI78TA1xVUbQV3uMNzWtpJ5yex6ADTNioz7a+Rz15yAkXVcU5MAONiFN4ncs?=
 =?us-ascii?Q?QT8Vshfy5pRh1IMVqm/FKO1cehCpyOy8LsMhCOIqrWVsL4B9p2p4ZP0ysjWv?=
 =?us-ascii?Q?4rNcHMwtbRoGJ7I1wPgpaFuJ1o0ziEQE62j20Pd08+ua5Y8ex2yapVjZVzGf?=
 =?us-ascii?Q?NidaCIdLw+9FLqEETGM6ZQzkCkHnsi4osk2tQzaVi2GrKMgHFCRuXDt2e2ix?=
 =?us-ascii?Q?RXj5JxYK+5/6PAf2INSDNgD2NbwzhAZOaWX97HJJV8nhzn+IMvITwv28ECUB?=
 =?us-ascii?Q?6wXhRs0Uag/1xsSHu6YFpdcSVP86/3tYfJZW9LfeWD/a/x5iTuKXSddsRad9?=
 =?us-ascii?Q?eVlM1tO6TkArbjNdORAn49bsfvXNtuOARk8nxNYeORWLQzW3kk2GSpHnI9ky?=
 =?us-ascii?Q?oFm8p2ZF83jXIZwSXgf74cMa6aCDaFLuJrTkzaul7T3gYoTmGuDZQjbuKE/j?=
 =?us-ascii?Q?Sz/+70zPKiHSBBHDXXP6OFLqnNKytN/2Ndde0dupXOJzUgtQ51P9MOGM5wob?=
 =?us-ascii?Q?3Btf/0zQcQbu2bBFyIc1d03MwmJ0ZQNWxpOxCvjLN6HyMLOOejW2MYdP4Yfr?=
 =?us-ascii?Q?8mxxuXwaiB5UqwEpbH9vxXnjx8mYNX5VYzREaFeG9TOFrbLOsQu2t/Otwu+J?=
 =?us-ascii?Q?hRUqSGcKyQRArQnUT8GCeJkiFMXVCnFGY1QQNNKT6YJ2C/ZD4YmmhFf/kZNy?=
 =?us-ascii?Q?emnqxlLRX3M5UpOogrjqRRePNMuWz6bTPcHeWtG42CN45wYQUCjadPkYzfGW?=
 =?us-ascii?Q?iMByEO9fR/G2hvM67CiUowg5miLPSpy2yXCEp5ORlYWm2pgLSrNWKRU2CR5Q?=
 =?us-ascii?Q?q5yCyXtCYFxpBUIaDQpFdZF5MWXyROMg7x0ROkpC+DchUTnQhBxFoZcmR/AZ?=
 =?us-ascii?Q?ry9+h8ScXpLfiJKKRhfzSEwW/x23lKthaNvob7nPqujJg4Uehb80il7w2lu8?=
 =?us-ascii?Q?JuLBEUqFgJspViM0CWaIzsyYyHl1+akxBlda2DL7T5EdVSfSplps4OusNsdZ?=
 =?us-ascii?Q?7lrpBTJk5jiabU+hF4f3urWs1R40IwL0gpLoHbbmjkIB0ev2ewuB67gsn3Za?=
 =?us-ascii?Q?IOWdy2PuHJVDs1qJdYhojCHJUSa5/rR+xNBgTG5FzeQcgo89QX/AGaho6NeP?=
 =?us-ascii?Q?7/pPhS0ETEvLRmuQgZ2id8/qsRRG7Ere95A5Ur/BnGzSMPusGyyfML6D0Qjz?=
 =?us-ascii?Q?r14jqt9ofFSoONHpwvKCgWD97wBb2fFFHpe1fHSqQkCM6GOaZwSP2AO/rcJW?=
 =?us-ascii?Q?BQdYB6vLzVqWkNp6XzRkYpXuesaVPxgJnn/+Rmz7oA7OhzvgwJSBsHFTjJGw?=
 =?us-ascii?Q?sehJz3DvikuOLZiNdtkSAw30uNI5FHRY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 12:00:22.7738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfdc981-17e6-4edb-e2fa-08dcb9fd2e05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

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

Notes:
    v2:
    	* s/ETHTOOL_A_MODULE_FW_FLASH_PASS/ETHTOOL_A_MODULE_FW_FLASH_PASSWORD

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
index c798cc2..89811b9 100644
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
index 1e0a349..225f3aa 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6236,6 +6236,13 @@ static const struct option args[] = {
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
index 661de26..5c0e1c6 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -496,6 +496,17 @@ static const struct pretty_nla_desc __mm_desc[] = {
 	NLATTR_DESC_NESTED(ETHTOOL_A_MM_STATS, mm_stat),
 };
 
+static const struct pretty_nla_desc __module_fw_flash_desc[] = {
+	NLATTR_DESC_INVALID(ETHTOOL_A_MODULE_FW_FLASH_UNSPEC),
+	NLATTR_DESC_NESTED(ETHTOOL_A_MODULE_FW_FLASH_HEADER, header),
+	NLATTR_DESC_STRING(ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME),
+	NLATTR_DESC_U32(ETHTOOL_A_MODULE_FW_FLASH_PASSWORD),
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
index 54aa6d0..a92f272 100644
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
+		.type		= ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,
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
index 4a4b68b..ad2a787 100644
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


