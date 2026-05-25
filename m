Return-Path: <netdev+bounces-291299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFhWMFo5FGorLAcAu9opvQ
	(envelope-from <netdev+bounces-291299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991A5CA34A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A97B3015489
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA54537F754;
	Mon, 25 May 2026 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwReIW3q"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3137FF72
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710295; cv=fail; b=uULS9FLGeVEySmy3GlJnPpmO/0S/Axnkry99wVuzGCNVHJOd+A2ADhYVcjgdVmOCHTwqiw677+HskLalqxeejt/xy2W822aZqARvj91mVwPqsvznD4m1mtN4unlLSkvX4caxvyLrBXkhP1CuDGIdPxhlLtK7cXGK2v0v4DLdjLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710295; c=relaxed/simple;
	bh=7AcXKoBbz5IWRS+HQBOvgvHkpu6XTr2jOCJ5SvQvD7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GSZL5g1x9ufUYp+rW1Xmh2oN5MCyEoEucBB/CbIKsECxFGa5eZE9SdxlVH+xGW+xPa5gCHC+gMYl7L2StKDjgA31hEFMJFR1I9eYV070rl3XT3hSStejgAbITABScUf5dFyOIj5+ReC9dCDbajIpcZJ+Ei919PxYpTBUKHaG44I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JwReIW3q; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM6hLnHkCUBn/2daVl3L3qMgUoA2UulXu6kihWnt/KIvlLWRfrxjujtCdWnZwy/bGyxgnR+UCpNF7mni/ndq5U4c5tzSShAYmmO73XMLpotft0+hZowDJexFgjyuosK0+U+/mv4GfuPFRGZOquDrVUQ5+VGMTgpV9JkQvnLEsfe1Jw5I3oB2hvhFsYKCyKgnWSUKAcX0ggP+8RZVmy0yRw8MbRi39EOUBFs3r2lwVKDvEGDPKm2IJIUN/P8AL4xKdyqwGlXmePcgL4Eqi48y1kAVWH7PlsMor5QDrlnqOFglaWYFJne3l4AUUMdRGMxcK8OOTqzBSgO+otOw54Axag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iih3xJUOxsOMqqhS9brWNDQJjU47VhftTRmr3AyI4Kw=;
 b=HvB4VwaLVDVgTOlla9dNOS/ZC2+lj1CKJjnoeLihqiGlISk8z6j+5zYHwsTy0VTS3VrtuTAGL4L/MMSNioV1B0Wqm7b253PfEs/W1j0QPID3+5hhCTuCQb7injgzpZqTwe5n4LMgSosAV5WVxU9hWt73IgZIsDeS20+ULoSqagT+B+MNTXyPNaNcmjV72EqFHTPqMb7rc9CgOSgt7fJ6d/pnWZX10p/v+nSQWAT1pHX9Vefs3GaL1PWllCMlFixF+akkNU4oS1LF2b7tRUHk5OIkAGI6x2wV1gbGNVLvPJcxnE3P6FWSfUZ++kB+5GGljilaVcIA6p2Ku6VsJ82k+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iih3xJUOxsOMqqhS9brWNDQJjU47VhftTRmr3AyI4Kw=;
 b=JwReIW3qTUGPZZLszZzWIrt5DgOrWw4qJe4OGC9vilqPM+PPvcUs8GHztnvwkl1uichvOj57M4QO8iipJXdKhGYY4ykYXuZ0agfKqBPx9P2Or51Urg5Nfjh78+pcA7Oy8L2UFROGx/b6V4A1S6zf2NhXVsj+WY3idlqZV2yTkppiwU7sAoWeJmBtSWutB9XWch2kydXQ3OJtXcNF5ez7AQ0yqYObnqsTKJr99FAPHK4WrVMWPNgpuNU97MRENlbocM0bjXB7AAQZt1hRsPPM2dGQ3vrJxZGZzr2SuStpceU0F+kTUsnUQpeImL5zaI7uFU1m2vzXZ4zyJll9v06h0A==
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:58:07 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::9f) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 11:58:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 04:57:51 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 04:57:49 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 0/5] ethtool: Add 'pages on|off' option for module EEPROM hex dump
Date: Mon, 25 May 2026 14:57:29 +0300
Message-ID: <cover.1779694603.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a25ae-56a2-4f8d-b0da-08deba54e2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|6133799003|3023799007|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	5mQimmC1x/pyLrqzkXc742ynQFQh09ckvbIsl8IgqZHb0s/cc2obO24Ci2WTHKFaqU/2XSHP6UOZijdGC0R0mPajxI+zC9OUE6k8TP9puUtT7VW/jXJvEK+D9Wk7GlwBGoPHhwfuYfk8fGRGrCnv9HHB5M2C9e1bCEkpgO/+/kQm5nobgO+QTFMHTARFuM0LScKy33CGOiMFmQsWbb/qpChykUXn5bZGuTTsnV+u8lE7wA5Z+4glJBiPciAGLEBwuKsDsJkZqWtKOVvLhYh56rge9Q7qwKbAAz9WlM50F62wu/4pPWoHda4LNDWPZznatpIF4nXiY9a11hqZy5UKZRBlqIkY1EssX7L30qTveyXn3oI3ZbVrYah7HWR5XYFTvICWwDF7his2cBcfaKQjLb3AdMq9xsQLBbGzaiAMAPlngbbwmLnVGTMGIK4+p6xR+DeGFhEQBE1AxOMC9R8Gqbe5bmwzxcEJVte4oFlH7cBcQdfxZz9++A0oEvHrZvHC/uOcttiS0smwW2Lil/wXewafYL5GU0afYqxewhNd2UnnIGgjlDmUEupaV2O6269fvrzIPy6al3L2OOmCnF9OXjRXXweWoviPgMnRY6+5czlSlCObDmvhUDZl2d5gGqP9Y35jy0qKfd67M/uSrzUlVLSnz5qku3opMV445giS4a7NnYBSYoJ6D3Q8OXffLR62ALp9iQrt6eGYZ1xc+kpq04rBunFdomRQWmTHMGbF4uE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(6133799003)(3023799007)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	exOBcbXn89fmD37bNCVb6y86moS+v70vceLvIaXjbHzkrLv9NTawrhTSQxHOlohcL6i9lEKTMV1YpZPik3aaBqKK6bIPyydLJF3v6bQN3DIu88NGBFVlHGZHPeA7pwiqYl7GF4E7UO8W9SRR/xaTZ/AHKTfUPvxxwVe9ADXViZWU7K0GF21KmpdYZaeuOvFl0FjJc613JeV5jwPGc6935Bqpx6kTsj/5jc1YUeMt2EzsWbcUOvf/KMSVoQFg8AIgK+ckTXgggxaDQgNzR/akbB3yQHfISKlmxmnP+aGwNwdrQ2+ToyWgYdqKq/tG+GapXz/4M7KyUGOJSh03EBpeBRzm0ezzAaF5FP1hNnSzlcm37upvLnRLrWKeyRbJY4Qubwsp7Xb+N70p9KycYM1befnMTERGZbczlQktTq6tvh+kWxO2L0G+uvnuJXpJB94G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:58:07.4608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a25ae-56a2-4f8d-b0da-08deba54e2b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,8.in:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3991A5CA34A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing 'ethtool -m' command can dump module EEPROM data either as
a parsed pretty-print or as a raw/hex dump. The pretty-printer reads
multiple pages per module type, but decodes only specific fields from them.

In practice, both outputs are often needed together for offline debugging:
the pretty-print to identify the module type and decoded fields, and the
hex dump for fields the pretty-printer does not decode. However, there is
no single command that provides the raw hex dump of all relevant pages,
organized by page boundary. This is especially problematic for CMIS
transceivers where the existing hex dump does not provide Upper Pages
beyond Page 02h, let alone banked pages.

This series adds 'pages on|off' sub-option to 'hex on|off' for
'ethtool -m':
$ ethtool -m hex on pages on

That produces a hex dump organized by page, matching exactly the pages read
by the pretty-printer for each module type.

Each page is preceded by a header identifying the page number and, for
banked modules, the bank number. For SFP, where the two memory regions
are separate I2C addresses rather than pages, the header shows the I2C
address instead.

In JSON context (--json), each function emits a "pages" array with one
object per page, containing page/bank or I2C address, offset and data.
Consumers that need a stable, machine-parseable form of the hex dump
can use this output instead of the text format.

SFF-8636 Output examples (values zeroed to omit vendor-specific
identifiers):

$ ethtool -m swp61 hex on pages on
Page: 0x0

Offset          Values
------          ------
0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Page: 0x0

Offset          Values
------          ------
0x0080:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0090:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

$ ethtool -j -m swp61 hex on pages on
[ {
        "pages": [ {
                "bank": 0,
                "page": 0,
                "offset": 0,
                "i2c_address": 80,
                "data": ["0","0",...,"0"]
            },{
                "bank": 0,
                "page": 0,
                "offset": 128,
                "i2c_address": 80,
                "data": ["0","0",...,"0"]
            } ]
    } ]

v3:
	* Drop redundant "length" field from JSON output - it equals the
	  length of the "data" array. Update the man page documentation
	  accordingly.

v2:
	* Add JSON output support: each per-type function emits a "pages"
	  array with one object per page containing bank, page, offset,
	  i2c_address and data.
	* The shared module_dump_eeprom_hex() helper takes a struct
	  module_eeprom_dump with print_bank / print_i2c flags selecting
	  which header fields are printed.
	* In JSON context all fields are emitted unconditionally.
	* Document the JSON output format in the man page.

Danielle Ratson (5):
  module-common: Add module_dump_eeprom_hex() helper
  sfpid: Refactor sff8079_show_all_nl() to separate page retrieval from
    display
  module: Add per-type EEPROM page hex dump functions
  netlink: module-eeprom: Add 'hex on pages on' option for
    page-organized hex dump
  ethtool: Add man page and bash completion for 'pages on|off'

 cmis.c                        | 70 +++++++++++++++++++++++++++----
 cmis.h                        |  2 +-
 ethtool.8.in                  | 19 +++++++++
 ethtool.c                     |  1 +
 internal.h                    |  4 +-
 module-common.c               | 36 ++++++++++++++++
 module-common.h               | 12 ++++++
 netlink/module-eeprom.c       | 43 +++++++++++++++----
 qsfp.c                        | 67 +++++++++++++++++++++++++----
 sfpid.c                       | 79 +++++++++++++++++++++++++++--------
 shell-completion/bash/ethtool |  2 +
 11 files changed, 293 insertions(+), 42 deletions(-)

-- 
2.51.0


