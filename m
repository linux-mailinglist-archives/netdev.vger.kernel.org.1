Return-Path: <netdev+bounces-164611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA7A2E7D6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207AB1887C89
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011DD1C1F3B;
	Mon, 10 Feb 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o45Gn1NV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394121C1AC7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180030; cv=fail; b=K/cy6o9uLT75zPuYLuC6ifQ1udBOmrY4WVDY3zVSNAf2eUtPf/Y56NkNuSuBG07gI/8RJWKUNpIdp7auYyo9++4liHE5qzWE+D/fps+TMSAX/aUlvP9rlHo8WtkgBe/VYcy4+cVNtR/FLWH9ztgSjD1ECw+wb2uwk5pKtrjlhgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180030; c=relaxed/simple;
	bh=3jiCmm8L7s/SBeol+W6DAf5fK3Cc3avaLluPDxYKQ4o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVcgs8PlkYM7tYz68XQwlINHJqXVXwxbHH8l75Xsl32qvV0ILVs0NuxN9RrIK37BiG3uqqSiE5ASS2VcMMWu9caTeDKTt96EBioi/mrNMMEXSRmrsLA74PrGtUHQh0lLeUrZKoNoIA/s72pnxTA+C6JWtbPNWI9RHzgG/I249yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o45Gn1NV; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/P8LW86FNYpIRcwes+dMJcZqkIss97ikdY3bGhQSKyymjxDRoexuqmi2VD78LhjAI2+eVbNpwJHTyGuy5rADomoVBvcJV3XcLIalw0S9Ut2UoWgeTNccN1SzGnUK+jwQ8qcRYmAJpPlQx+ZSDeFCHPGch4OSASQ/ewNF4WOYZG/NCvEYh3HMe6JhvO6Ytz1APX9SMH7GeCnWw/wOuVCff4gP7rzUjK2uWwsUHMNHh4D7ng8u8Q8QgS0PplvWWQIoIQkJz9Tm8RqYiA199jldYSXqU0jGRFPT9pJ23KeVhGkq/KWBY0EprU+taxMK+dwtVz6UmX4toCLz2Jos8gU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd404nGsjysvU9aRNl4YLF2coQ6y0vtYOLez0tsrays=;
 b=HQ3LfosA51q+lWREUzgGlfTazvohtXlhOsxmjbgrk0CorjZjm3CF4LwGNVNs6i93W2WxrJrli75WJPvm+N4y89Ux3V+r8cdlSLm51CC34xDxmT0kOqRg3fQRUX0kKtGqY6/OebzLiLL4eKON7ZCr3Fntro0oQyKt1WylBrvEv+SbztUNNNmFMHVA9NFJUZGsvKY6/G/9Zokwe6m1uHGpa41BPPXoh1gtX3iyMdbahLXGQQptTr4nOrii1Q6KaniDeEfejezF+MQPF20KjmTzzvoUFyzoums/AhsKYKFyjnoZ9qNgn4fSg5Qexgl9iBxTL+P3EBt2CVZCPN1nbkX6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd404nGsjysvU9aRNl4YLF2coQ6y0vtYOLez0tsrays=;
 b=o45Gn1NVgFIZTersIn2aQ2feOgiBsrdzeZrQZoPiUY60+0xyhbtF6kKlM5as3FYucY7QGn0Ts0/2kUqwSfCe6lTpy85dYN1MxXZAEhoVaJLbrS7SgwwodyT1DtBMH5sgE3J/7Ps9jsWjMB4nRsLDqev5Nl2al51LfZ77i9cR5jYxdBrHncDVR7gLtHHMuavks6BAHC2u0tbYsDIP7EaAO1v6aSlH0f95EoESZWn8SjQ3FYxlRCA3eiP1JMYivbAolDbvy5r6DcLun12kDwN6Y9piLT79zkJvUfjbaPuqarT0GL6HgnUjM/fhhT8QtwhVtgNc2+/cuEAnJztWv61ulg==
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:33:45 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::96) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:33:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:31 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:29 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 00/16] Add JSON output to --module-info
Date: Mon, 10 Feb 2025 11:33:00 +0200
Message-ID: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5f478f-7720-4820-d2f1-08dd49b60400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ifXrL35iHibxMp08zQuhgHH/P/eKshutQnaPwi69p/S0uCc1x3nzmEmLaNGj?=
 =?us-ascii?Q?rMDd2tl904TUWbExQf9KF7YFT1+dsM6rvLwlxIaZ7w53cHDLkFevt+i0McF6?=
 =?us-ascii?Q?wlimzMAzEJU15XEY113h9msjW9dmyeVVvKgyfoPzmdzSccyCsmgTGXR9xQWG?=
 =?us-ascii?Q?kFxqtXNY6M4u29bohUwXYUIG9bKT0e8RrfVqIelz6ht+fKglPdNpGONzP7fK?=
 =?us-ascii?Q?859CBoCtk3bWvqrj4fmUbCOFFcpxCpj9w5FDmwX6l5gvMMvG8FEoNliJsKr+?=
 =?us-ascii?Q?PR5VGtzFdnoWsX4ECwq/sO8HnjyPWaQZfYRJSl+pGGvvHqSdILDRnnxxByE2?=
 =?us-ascii?Q?Atmckn6CZ7fMH3HcTPe0yTlVA9lMH7n1nOBq7Xq898na0pRH9piNYlHmOsJQ?=
 =?us-ascii?Q?TN+XcLMkh0pBirLBnWL/14/iCe8Hr3Pm7DQIehysW7wmarrpB5wuvl/bUEFV?=
 =?us-ascii?Q?Fv0CoMLOa0NQzC8VHxGoHWpPkOC3G92X7YMqlHWi6/XWFWm7WeEHJ2dI7TXl?=
 =?us-ascii?Q?ZKTyMs9tvpmIH2dtGZamzwvZ4obwoKnGlaaU89OsuUGGjY4cdJi30yoQRhpm?=
 =?us-ascii?Q?cxPDb8imByI2F/HEXuHoVBL3gf2SnuH2Sze7V0zgHVVyeU0qR4CDDssp/0y6?=
 =?us-ascii?Q?1aNLq/jYT5Nbe7wyMW8sMhK0CqAlc6UB0NcnK7WPkCACLnisFAdY5de5D1fD?=
 =?us-ascii?Q?0u5bOol9xRQojvWm6priUffOhQSDl8P/UG7Ss5MlDxlDoXrJuOvCVcfs6aew?=
 =?us-ascii?Q?hYheKHBUg7k+8HdzEfLM/BGYGU4cppWl/OGNQGktCEXXsc2X9BxWosxgSQxF?=
 =?us-ascii?Q?aftErH9l6incVATvSOKPVTcwyX06DsphFTGQk4KTrpkLYOUI2w2DA4rtLpgA?=
 =?us-ascii?Q?kogrnnQl3EAEJ589/dKx8FdCJ6pKfq33VTjCjNRz4cdlVHogUYYLNiW91Imq?=
 =?us-ascii?Q?alAK3ZBJqvpdFR3nmJWY+hI+leirx9a/0eo3eTTenxrRXqdnjTuMvy8fDK1N?=
 =?us-ascii?Q?IBRRSlXjhzo5Rmo/FLqsfFc+TPw+ZZfHpxjANUqinEioCszSShsajC6T41EJ?=
 =?us-ascii?Q?oVK5tusvoZc88w99b0CdvvU2hmmMOTgsOIrXGdPoE+ajMAvehFJk/qc1RA76?=
 =?us-ascii?Q?M5AvzKrkxZaPU2wMcZzKbNrELknVzMkQy2UZmJxV/PEBTwV1cfm53trafCry?=
 =?us-ascii?Q?u2z9QaZtZ5n/zSqnFOyy2XR5cU23Isr4xSj6Ue9VqJLXulR2BS2ihv4nhGuo?=
 =?us-ascii?Q?R5hJhIpupzOdvhCK12QetMmrk8Zb/H4a80F9GK7ZlTeoAnvVT7+LcBk49qez?=
 =?us-ascii?Q?rhoNA7Dq1ORnq2WDhXHNQ53OfQEravwUUdy5bSgRS0LCcttvAQpptFeBeX5Z?=
 =?us-ascii?Q?+IvUMiTNhWT6Jp2gosF3OOQZMKKUlyyraGeyh5ljJkZZsKGI/2s99wkJhFwO?=
 =?us-ascii?Q?Zi3ute0CE21DFHnBa6r7n2DsDMH7HnS3Q8wYqW4H86zFC14qvGhuz1cpifGA?=
 =?us-ascii?Q?+g2SRgXdPOPOh20=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:33:45.6360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5f478f-7720-4820-d2f1-08dd49b60400
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

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

v5:
	* Edit commit message patch #11.

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

Danielle Ratson (16):
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


