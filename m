Return-Path: <netdev+bounces-117470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA7F94E102
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7290A1F213D5
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAC3D97F;
	Sun, 11 Aug 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CtsdAqXW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85533991
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723377618; cv=fail; b=kZ2qRns9KUVt0cAmusaJAWZI3x02pQQGh6pyIwJeJNtZ7BSLikVkQCGf+eem0qjhLqEPdJ2hoKY1Mxh9tM2S8jCKXB1bSfSDUpaMFdnD6OpCFZhPQ/gXi4CIkRO1X0Bs4DPMYOBWop1HERKtUa5JBBsofhcG+D/J+/2escnQPGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723377618; c=relaxed/simple;
	bh=Na0TI9PO0PAa83En+V6vlbZd2w1W4QuYLI8S+5MR3wg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkrgo6SVcVfvhxDbLLVZvBF2p/kmikEdMkSnfsStY0FWFQNj/AmowQD7hqScnzieoCZcFltCEbI6tFVdHua4f2Ia4HFo5mGxuAMMWPY5/7uYYILQfRBJf33FHdPrxFBPMo01DuV7eqb915CO9DwuOJR0bPM4aiQ74vh0qF4gLnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CtsdAqXW; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbyedzWUCpbIhxfv9g7BVnYQk9wG+GMjvSSHhrqlBIGab/Y3Ub0AHmmScKOh3NbOyns9eUKfq54jSja11vLZlx9ayXJ34ktofIayN+I/6Xx9hZr4QzwIyw7NTv0MGbIzoaj9ZdKGG/lbUzoYznQtntuCaM9Nz5UPutZS4KEZGPbVoIOGyi3BQTfBW5z6gDa0b5mQ6J44Gjiv270DHyJ8jb42rwokCsXZ9InfXYchZAHS0krA1Oevgal+4T4z54GViD+Lhrr3P4sC9v5ZQtGm8/pyJsOfXNH0AznkdbDzf0HRhwa+zm/GgAW6a9U1vlMXP6QC9kvpCImAkAdkyeZ10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVrHaZCB8zUyN7gmzncN5SxSsRABML9LHMAwj9bLEUg=;
 b=IiIxfRm9e+illuI4ZFyT2RtvyMye79oMD6fTh9knggZyplu8LTZ+R68Mhg/mfOX0UhDL2tkNufjbHFIy9o+ZNa7rfA02JQ/JzVaJmgcjZPOP7xpSxo2y6XM9aQkIH/UvzNTyMxtRrnvCjCL6kSzC/zgAPiWmtVf+sHMIa4nO/rNF7PQoIF/XU9lcl+bh5mOr5AmnY8ijGch1lKmu2sqPTqvKHoN3DTtshyNVwiemAJvivg0tQv+IpA6TxhqPvPzIKGmwHfW57yPSKUuMxUq/s1x3FAITD2lN/+aydzHtAhJXnNxMS6h33Gaa/WMJSJ4+/zJUPMq5K2tL8IudPe331A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVrHaZCB8zUyN7gmzncN5SxSsRABML9LHMAwj9bLEUg=;
 b=CtsdAqXWap5qvRgetaDVywGt09niFPb6wuxUwTwjVRD9c02DTjLjFs/vyz2wpuko3xrCEaj6AGQAOeu6ruScAqG3fqIDryUIS0fcIE+ff7/jVQrFQMPnMSONQpIipH2w2GPJC/umn/zTFSqJGF0UeaRy+LjDdeXxht37TytMD20oj7/Lira6BOrxvUhck2dmIfQoU8jGpZE/qgdzbHaq+Xy/2S9iyf1pLNJunYUAY7FR0PPspChgSErZbqOmKYB+QSzY1tDawhBIWi47cqCcr2wQh5xgB3E2axMn130ZpoTMs8dpHVEf2xswQe33Z3hXDWhR2uEWEu0TM8VDtKyM2g==
Received: from BN9PR03CA0390.namprd03.prod.outlook.com (2603:10b6:408:f7::35)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Sun, 11 Aug
 2024 12:00:13 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::8f) by BN9PR03CA0390.outlook.office365.com
 (2603:10b6:408:f7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Sun, 11 Aug 2024 12:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 12:00:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 Aug
 2024 05:00:02 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 Aug 2024 05:00:00 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 0/3] Add ability to flash modules' firmware
Date: Sun, 11 Aug 2024 14:59:45 +0300
Message-ID: <20240811115948.3335883-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: cd326919-400a-4248-fdff-08dcb9fd2853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYJ2hIwCOuO8Gj68JImgatq7SuIhtYtTSRVWkU9FCOSEQkQdJG/64KzKdPIX?=
 =?us-ascii?Q?/NqmsF/hDzfP7EvzUH89f3bcmp4jBHCv3DnoX+sJEwxpGjQb8dAaoDo6lkiM?=
 =?us-ascii?Q?2c5nISVsM9yMaO24OUQ9RhmxwQZ0GNEEO/zO4NG0s3ObJt46D6aPWNuOIkfp?=
 =?us-ascii?Q?s2JEMvgP8K0UQcYF7x4N3LVY6EP+7mXK9GfFm2B6bc5NqiiP4rU0CEPbAI00?=
 =?us-ascii?Q?fpcjByoqyXSGQYE7YF/RTtvFFG44FNeZ4SA2gT6MeL5XhL/9/hoMxK/+SlU7?=
 =?us-ascii?Q?lMNUUcGCR4tS3ZUjSGO59xNl4H7f473vpGGF/H48j0rZYrRn/UvZBUIHVWOF?=
 =?us-ascii?Q?KeCr3znWSmgKJjNBzC/NrVRvNo9v4UwskPFmHGPgyDdBWnathDupAGPjX93Y?=
 =?us-ascii?Q?fp2FMP7dgoqfrv5Ul5cYQwwlhvuMgDnmvgoAH33n8HiowMEEFVjSvqjfKp2d?=
 =?us-ascii?Q?JupdbfTNC8fXFJ6ymtppX9swNwCK8tfEB6SxQVrTQcVjX+umvhNUcB0pvK6L?=
 =?us-ascii?Q?M8MkxVt+bsVfKj/87xbwMj3O1qnq3ZP50GhJ2u3RCSdq1jYg4fdJl1W4bTLe?=
 =?us-ascii?Q?ydrvmSeKSovFUNHt1UuNfZJIkySQh9J0f26i+qOptoCZc3y+ds4Uf8/BecIc?=
 =?us-ascii?Q?ebCu0rny3i7WCMrBwjxHeLV0AIn2XiXQ20q9HM7/fWE0RSvOBWV4boHvtZ4h?=
 =?us-ascii?Q?6vBF0d5lU6AU18IZoZf3FbuIePoYCwPiyTx8463w4dpD25Wztn2laH+fIxV1?=
 =?us-ascii?Q?2/Yr34EJDNzvOpZ/S1R8G6tAHGNViKLzgJlcN6I4FAn4GCmjv59t+S8WcI3w?=
 =?us-ascii?Q?L5xrMGDdmm5zQsy6XUqkwNxUE9MhIi8wghdE37kUxggXwDDlKux/Pxwzqcxs?=
 =?us-ascii?Q?btkHNoWPqu4CN6HeoeO0xXX6kAe25bAFhSzqAd+pEpLLqFx0DvC8iZD2bjyq?=
 =?us-ascii?Q?kuZlP0NWZAdImiATuiI82pfzADkO9PY58EIUE6sdedZ+fxd6MU6yVFFAg7TR?=
 =?us-ascii?Q?dL+mNrJ+KLjQUtAiRSIlPkQcIlPapQgGRLGtVibziewr8ew3Geu6y5W2agH0?=
 =?us-ascii?Q?PxmMg02ZpnvGWWak9Y14zTWK0kuXz23fVpcfiQuLdvYwIPExeDpd7o8zfhXe?=
 =?us-ascii?Q?IHyvavfyOr1NizvrnStgzID/+0/kftWdyTPcTWIuC0erto1HDDmHE/HjN+bD?=
 =?us-ascii?Q?mffRtFpBbWPLhhCYL6D+ho3i2UfVNYO21J1D3dZhCWaQECICSvGOjuZKRadS?=
 =?us-ascii?Q?LUmYiAe6pA56Et8dJjyAV0VfVfEv2Hkzm1dNvEOb+h797Gc8kabWwHIhTsBy?=
 =?us-ascii?Q?LJeqjXTa3fwrmpm5njvUTsA5BpFe2CPE/rtBFFb3QYxAbbKcXnJT1mYFsB0i?=
 =?us-ascii?Q?iOUxy6e/vpOnHEVnn2KyRa0vMnqJG57eLbsnW7sQbZzIr/JQRGDMO7iIxTYW?=
 =?us-ascii?Q?Z2mG30tkwpH1Z7xrMBMP04ZY1ZNCSy+Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 12:00:13.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd326919-400a-4248-fdff-08dcb9fd2853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

CMIS compliant modules such as QSFP-DD might be running a firmware that
can be updated in a vendor-neutral way by exchanging messages between
the host and the module as described in section 7.2.2 of revision
4.0 of the CMIS standard.

Add ability to flash transceiver modules' firmware over netlink.

Example output:

 # ethtool --flash-module-firmware eth0 file test.img

Transceiver module firmware flashing started for device swp23
Transceiver module firmware flashing in progress for device swp23
Progress: 99%
Transceiver module firmware flashing completed for device swp23

In addition, add some firmware and CDB messaging information to
ethtool's output for observability.

Patchset overview:
Patches #1-#2: adds firmware info to ethtool's output.
Patch #3: adds ability to flash modules' firmware.

v2:
	* Remove patch #3 of updating header, since it was already done.
	* s/ETHTOOL_A_MODULE_FW_FLASH_PASS/ETHTOOL_A_MODULE_FW_FLASH_PASSWORD

Danielle Ratson (1):
  ethtool: Add ability to flash transceiver modules' firmware

Ido Schimmel (2):
  cmis: Print active and inactive firmware versions
  cmis: Print CDB messaging support advertisement

 cmis.c                        | 125 +++++++++++++++++++++++
 cmis.h                        |  19 ++++
 ethtool.8.in                  |  29 ++++++
 ethtool.c                     |   7 ++
 netlink/desc-ethtool.c        |  13 +++
 netlink/extapi.h              |   2 +
 netlink/module.c              | 183 ++++++++++++++++++++++++++++++++++
 netlink/netlink.h             |  16 +++
 netlink/prettymsg.c           |   5 +
 netlink/prettymsg.h           |   2 +
 shell-completion/bash/ethtool |  27 +++++
 11 files changed, 428 insertions(+)

-- 
2.45.0


