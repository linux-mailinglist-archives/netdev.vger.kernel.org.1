Return-Path: <netdev+bounces-163101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E6BA29567
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A7C7A0FB5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD72190052;
	Wed,  5 Feb 2025 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rGhnTt7s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1018DF64
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770924; cv=fail; b=Cf/E84BkeQbbNypLcyTlFDoM+zQ30bcY/ugagJb45H2VLrbYOTN4oqZPZwHGqR4sKtnIv80mKQFZeFGx3AhCmmPPL0y8RjV7gRYX1MEbondg568PJ+FGYo2vZUNb7RscnFE0cLU1sVb5x7KwEyY5V15gk2k83S/1DGvZ3yoEl0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770924; c=relaxed/simple;
	bh=KPMMQ1ZubD+jZI5qU7lU94KFr/pjBv8FxEj0a3niVH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGChbB/yloKgUpOI4qcuMAyVlx5tr0/UjA4Wqs++ShhU0LOMS1M+G5ZFieMYNTT4KhDkq4rKBBbyubHIXs1RLfrwl/zu3AnbJPm+TM/A34W9E4zAjhaYjKTQkTntkBDfri76olZ9QR2f5407PKA9V63dvDuXQg2z3yIpLcntwD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rGhnTt7s; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3dCs+v1UMkKX//SgRENmIODy9qykDy6wqxkw/jMILAywAdGWfcJNYNqeSivsOPqbdrmd1E0x/Y5oTCfqZW4Ju71wgh6bIgKGk6qK5KaeUhmKQ1+GT3Ss/3nk+WbUT5DIfl+sxutyf2wytSM83upwDRvXhDlvgMuOgBLqAkjrByaHS1lp0BkMXpqg2OSrAxdxlJcUm0lVQUr8FTFPN7I705IUQ7Cy/nLrRc2Epg8mglrLvtcRfzCtGh3XNHmg1QdVsAdBxhvECWLFp67+m6TiNx/wSznKaFRIs/MS21NrnRmMUjGk+2GlOImxY+QFWyqkTg45uQmjEsiFzFMyPEmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai+C1RC+nDGCvC4lZA3sfCwa7f/jGpwRjA4NO7O5Ivs=;
 b=YnYLH4TgNPI4sr33dhs0ZY/WWDH7JZ/ky7X0kwcq5fcQ/dOTK7+RLAeJ7kKVfW0reY5y89zAeF5GjjYFmdN0sN5T0310tfTJOI9Ng8FBATRNx7bxZcAgihny7USmS993XE6jCz5sDzl0L+l+KgE7shdjjd3qkW+Jac0zHcSPYZt+TaQ9V2wJRj0FO1qFIblAGbCBl/S1aH7rWS1W2xCXFXZmWduIzfou5HhD4iWJMTp26XKyhQWcMXXnFFMapP+EASTShTetERVbXBVtiAELVHh+zOpmUkodOAQqa8tVfVKR/lcy7TaO3SrvdWYUcgGVSm33r4T6BRasA+l53jhBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai+C1RC+nDGCvC4lZA3sfCwa7f/jGpwRjA4NO7O5Ivs=;
 b=rGhnTt7szkAMvw0OMlB69PxKjg3W3OIattRhiZy4YvO/uOgNeIohm6Dnpd9QPBxT2YDNsuluI1pNM1LE2viTs64pbDly+nQamiwt8aWaa9VPfIcsKCgqG/8GCvdVyRsxj/JSq3JlSE7y4Cibs14OcLGX1jMcyrPFKY1w+Bj3rqvureqQqqNNKlhYznsFvA0gMMdj4PHwZYFueU0mo1AH11HqpW9lIu8QFpLvs2DHW5joB7Ko5Rpeumtx5c2aamHIvVG7gZYO9wyE3zg0NNuqSSicuvXlxhoV6got5QQZuhD4SS2rZuFnMpdNhhSfGSBKlRcSJl+1gq0UcZZ4NfMTew==
Received: from MN0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::30)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:55:15 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::a3) by MN0P220CA0006.outlook.office365.com
 (2603:10b6:208:52e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:54:56 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:54:54 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 00/16] Add JSON output to --module-info
Date: Wed, 5 Feb 2025 17:54:20 +0200
Message-ID: <20250205155436.1276904-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: fc11187c-5455-4222-3e0d-08dd45fd7b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wywbi78F50kl6WlUSBwvQUkh4TJZo78sRN0CZ7kCisz2+szz2hyz0ZLbsiuR?=
 =?us-ascii?Q?lkJJq1RTmQeIIkgoZL3jhQLMnzP+orjROk+8RqDmX5QUdG3PKn9jjVJnVvK4?=
 =?us-ascii?Q?XiCOudICoL0pWs15AtRGXNF15DaB4n2DOWdS0y5tpXHzjKcv6EXtrezexWmE?=
 =?us-ascii?Q?7inN20ObEMB1IG/8qDbJSw4lmMOlEI0PYlKDarkTR+/YZLZbKSBqVK5hKkqF?=
 =?us-ascii?Q?ty0hlMdz/sVWbeqM/td/xq2tyXVsgdhUa6pihcFAutbCpG9iBEqM+NbCaZqa?=
 =?us-ascii?Q?F7kwsfIBd5cEZmwxgJ7J5hPn3XUehd0LphYASh3jbB585KddKl4DANN1acL+?=
 =?us-ascii?Q?UpNFuZk5Qo0nt9phLaqMwbGdjbN9zFmaiIAs6h4aX/lWOppdcle//KJv/Crt?=
 =?us-ascii?Q?kFib22HhqOk50sVy6cmCbTTOYIyJZB7t33gjpnuFVvhI1JdRH9Ikq5iHwN3O?=
 =?us-ascii?Q?9f+oBDjQu8+8bV52SMAS/pS5cptXA0mahaBizm5jbyYXYkw0UbAKkuxOJ0zR?=
 =?us-ascii?Q?YoHPTkpidW2/IfHxnhkxqjPvSUT0sGv7Pr9pfLND4ZR6UomT2EsIHx0sgNd1?=
 =?us-ascii?Q?XzEtCI3+HyVKrG5tv2JPOEbm+QB0XkzAdL5fl7PPaK/0iRO/g8A+Ke63kaK2?=
 =?us-ascii?Q?yWxx4o/rjx1/U7TxXuU5HtYkyi59uEXnLKbXLmBg3qmihS+NFJI+4mb8C9CC?=
 =?us-ascii?Q?QRGRJMsvYSPdMGsU7+Ek4SZVXREPN44iQq79EgdWFKs8RQpFAUDVTW9xz1f1?=
 =?us-ascii?Q?tpln03YunHCa3aTpSYPZpjPPpe1eeyUvQ5oIqiM/BgawFxxBcyCgztWCHl2i?=
 =?us-ascii?Q?+pBjMDggZxbOObDVXNA7Ay+d0b0nlIsHCSIpYWeyRp5Io4+jwYnPAa82bo2V?=
 =?us-ascii?Q?1QCGTJhVs2aJOQXKHVoKXysouoD5xpM+kWey/hrV17EkvJQv/NVgAZEfSxWS?=
 =?us-ascii?Q?1jL6tNf4oAO19OYJ6pPl9qzyzSMu4h1Z7YQs09CJjletjQ0xdxbnzg2zQgEG?=
 =?us-ascii?Q?QXSfugkBHd1+AV4h2eV1Hi4fL44plHMweIpQ7/oinh0IO0cW0xS/G3rq4hEs?=
 =?us-ascii?Q?vDbPf/rtuavejkVfblzLvJGYylDsxN0jajWJhokQwNsHFjZGZbtEzEFArUHq?=
 =?us-ascii?Q?ATtIWzJ4UTJn1d0dLOJKNKFeNqKyozbNb7JREvyiKV0Z5Uts35Vn02jsM8Nm?=
 =?us-ascii?Q?piBaKmcUi20Ex1jm2NluNIXrLru0E3gbt0lraXLtbg8VLVSbyHbz4tvZYvum?=
 =?us-ascii?Q?tjbQBsQrv12C0ZlvB2dpss/DbU90w/9j++RVInPkZcWLxD2bHe85LP1zFkUx?=
 =?us-ascii?Q?ettYZSiluPbrYitC3xNXGVWAg3uj3c4XVa5k9utkrxVDTfBd2TV0GP2lgveW?=
 =?us-ascii?Q?GXgGGFZVJWXF6Ev0ECuPVkRLIcAKmxNjlB5y+KxEbIOS12gXkWm6s5FfVuhZ?=
 =?us-ascii?Q?+s/NsMyipRxm85AczkxCoShK5XQsy1wx02CpAMSqlnQ9Z7s0x0hCpFW7lyWD?=
 =?us-ascii?Q?SQ4xizqPRFJu+yE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:14.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc11187c-5455-4222-3e0d-08dd45fd7b0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

Add JSON output for 'ethtool -m' / --module-info, following the
guideline below:

1. Fields with description, will have a separate description field.
2. Units will be documented in a separate module-info.json file.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub
   fields.

This patchset suppose to extend [1] to cover all types of modules.

Patchset overview:
Patches #1-#7: Preparations.
Patches #8-#9: Add JSON output support for CMIS compliant modules.
Patches #10-#11: Add JSON output support for SFF8636 modules.
Patches #12-#14: Add JSON output support for SFF8079 and SFF8472 modules.
Patch #15: Add a new schema JSON file for units documentation.
Patches #16: Add '-j' support to ethtool

[1] https://lore.kernel.org/all/20220704054114.22582-2-matt@traverse.com.au/

v4:
	Patch #10:
		* In extended_identifier field, use an array for all
		  descriptions instead of 3 different descriptions.
		* Remove duplicated definition of YESNO() and ONOFF()
		* defines.

v3:
	* Remove unit fields from JSON output.
	* Reword commit messages.
	* Add patch #2 and #15.
	* Enable properly JSON output support for SFF8079.
	* Remove printings from fields that might be empty strings.
	* Fix JSON output in sff8636_show_dom_mod_lvl_flags().

v2:
	* In rx_power JSON field, add a type field to let the user know
	  what type is printed in "value".
	* Use uint instead of hexa fields in JSON context.
	* Simplify sff8636_show_dom().
	* Use "false" in module_show_lane_status() instead of "None" in
	  JSON context.
  module_common: Add a new file to all the common code for all module
    types
  ethtool: Standardize Link Length field names across module types
  sff_common: Move sff_show_revision_compliance() to qsfp.c
  cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
  qsfp: Reorder the channel-level flags list for SFF8636 module type
  qsfp: Refactor sff8636_show_dom() by moving code into separate
    functions
  module_common: Add helpers to support JSON printing for common value
    types
  cmis: Add JSON output handling to --module-info in CMIS modules
  cmis: Enable JSON output support in CMIS modules
  qsfp: Add JSON output handling to --module-info in SFF8636 modules
  qsfp: Enable JSON output support for SFF8636 modules
  sfpid: Add JSON output handling to --module-info in SFF8079 modules
  sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
  ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
  module_info: Add a new JSON file for units documentation
  ethtool: Add '-j' support to ethtool

 Makefile.am             |   7 +-
 cmis.c                  | 493 +++++++++++-----------
 cmis.h                  |  65 ---
 ethtool.c               |  10 +-
 module-common.c         | 662 +++++++++++++++++++++++++++++
 module-common.h         | 287 +++++++++++++
 module_info.json        | 191 +++++++++
 netlink/module-eeprom.c |  26 +-
 qsfp.c                  | 894 +++++++++++++++++++++-------------------
 qsfp.h                  | 108 -----
 sff-common.c            | 348 ++++------------
 sff-common.h            | 119 ++----
 sfpdiag.c               |  52 ++-
 sfpid.c                 | 446 +++++++++++---------
 14 files changed, 2250 insertions(+), 1458 deletions(-)
 create mode 100644 module-common.c
 create mode 100644 module-common.h
 create mode 100644 module_info.json

-- 
2.47.0


