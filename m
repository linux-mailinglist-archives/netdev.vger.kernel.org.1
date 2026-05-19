Return-Path: <netdev+bounces-289448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEJPDEtbDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:44:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375357EF1A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8393002134
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CD94D8D8E;
	Tue, 19 May 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LP4WRwSw"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68343409E16
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194268; cv=fail; b=tjCo6G89YZ0QvctmnV+ZS4fTIsHNPNHIMhQT2km9WtCrkVwzloM+kPcW5V2ZnNsAYHyujBf2md2jIYQk0p3ZmqH7ZgNPxRjHxrDBJVIGwy8Txh8GyY53Rz0iATQm8NpWjLKegg4LLOPKkC0CBDs/O2chqCNPaaKrJaXcdDv1wkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194268; c=relaxed/simple;
	bh=4QiyXNrblvlgaDjCtPreIJZR7I37MQWeRawX8KtjQXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQ6oAeXibIlyh21ZIdANS0xuXKHzQTKSbWTp7Uff/1R6s8QchkbygwhVGAECOK0sJFysDjYLeTGUjnLuOjLTFyJs7WjVBOVy7XLCj2duu4zjf6h77eIZuZXiIBMQLcYdiLlkOAQrD3VmyH6pJoDc3XDEvtaRXKBjus/XfYufmF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LP4WRwSw; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ+GQZpQgVKsmZgtI9YEuBJm6PL4lDrolsWFt8EJJEAlYiN0EoERCa/m4SD9fbdEwZPzBa5bu6TcEly9sFIOSbNwx00vvZwsWER1Qooz79K5OlNY3iGx013gnfTmJ1N9J17124FapVGJQLtKDA4AIYfjcrdsxEq42+RlsSznGxRyEqHtOUAksqWZA6A21CyXTtFCWJix0I6ZoPITs2o4adE8ZBPeO4/Gd/i96S3OfBYZUcTBf0XcmJskdxzDysR0V9kh229i35Vl+duKJE0EmvOjCUHz4I1xg2Kprj26P4xzlZnoodYDKoS96Cy08+nejCcRVeiPsir+n65OnTcbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC0gZFKqAusun2IqQWNqseKNMZ8oOZUdQ0xl7odGVwc=;
 b=lwV9C8boIDquFynooomY71G36ixOso0hjsMuF6lEXcnl5LJsXkzX4mxk49cQIQUxbvSa0MV6smMeqPU78jEzL70lW5dPe1NHw2HbJiZRPei4j+bPTlA+00JgI/S6p1sqVG0u6XmDWAaKmUBKBgqnFt52g3WLhA6vLxIPjIaNWOMxl6gtfj/WKxrBxhR/duQ88JD27rbH9SWR1FMTpL13BWlfQJF5Oyvkm8nUW5CIQfDLxjyfP9i0GROsOjriZLXpS6tnjbFg7lk7ahbt4yAbMcGSKV9iiJVevq1QjaHg369oeQgEfaQRCL+NXv2MEBD47iHhNE0mjAwqm1/tQ9htFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC0gZFKqAusun2IqQWNqseKNMZ8oOZUdQ0xl7odGVwc=;
 b=LP4WRwSw5h5gQNEa2UmiXQo07NFYxt+7qXZI2jXh1R1sJAm0o48k4j37raqg0T3yTabtrSxA1Gpd4Nk6wJriOQeiwbf8taLnlWYaU2u4iQ6tfk5MgKbn2hyl474F9tTIkTNTKzMUVpWmE6mZ7rcWzkkrPNedZNKCQe0hH0eLUYxTqLBEJ99uvfP3606t0s7nszVC1QhiSkxCBSjo8SgGA0feJP+P94pH9BL2zyGFzr7dJe8Crs56PdxiGMfkca26hZkB6g/DOgjJSzfJjnRza/tzddvrP8OqIleTGXwA4d2yVhFEiM2c98vj1lfLXyf7HPJMVFslqOIKihjNQ1fYGQ==
Received: from BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 12:37:39 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::2c) by BY3PR10CA0009.outlook.office365.com
 (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 12:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 12:37:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 05:37:18 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 05:37:15 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 0/5] ethtool: Add 'pages on|off' option for module EEPROM hex dump
Date: Tue, 19 May 2026 15:36:57 +0300
Message-ID: <cover.1779190777.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddbf6b3-b2c3-47c6-bda7-08deb5a368b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|3023799003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	6pHWESSSz9DMl1cA60AvqjIeMmQDAKuM/LT17kXSEG39jgdoYzEceEF2wMJM3LQnoAc5fViAUIGJPOuIjnSRd6HJu7TzVy5pk7KMSHJpOkGe33HZzeMbZAd4hG5CdXyBpf0U5Es6i8+xKn6Riltp0vfIjeeb4+J17Wd50hCGjK7tz3ykZcwMSdk+TRCBhUlbMWTmwuBixBy2IOarEg44zLs7t1QxZderg0PVlrDOB8Twz6SR67c/LhrZ7F0XmURcDlF6g1C14C6tF8H3kPoHjTlqubpuS7Sc8vdPVN0B4ft0jTQjxaIDT3QkUG8qzId6PGV7kOs0E7yJWrNiOlk5lVX/rM6L7QPpaX1VFP1ER2vtyBndt+dd+zKeQS8rbvkFsqSoAKdG1MBPkbnYWbl1xjmpNV3XCHKMrQwBCpGele5zuJ8euJ5iP/laPrjPVwY0A/gmua6qbVxgwtRlJBCT6vfCLlZUqlEiwimlETeC0wj7O2UTuhvQZCJuHmzbj0xsCZm2FyYRjUArU/+4pInscuvtI9EKnC9kKgiAJEr+d+Fyq3H8qzgskyX/fhBJSJgbKCrZh/tbOeQEKePRdzIgEFSvlBs2A+TLYWrZAjEy8Zf5F+b7Ea7lyIX/rEn89+TETbfHqNPWg4er025k86En98KQksUO5FVkEsomYazqYg2J+EalFObNPBtDMTDIl0q9TP/nZcmHncCUUnkYTzLbJHEczijFP3M8Uu3L22530yY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(3023799003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FGZPCi8fgtGTSd39UvEDMtWFk/VGBFSAfRkALGZSFtZmjb69WGL31r30WRJXpnlFyojrPg4p9x0ErduSlwmHzW8xmsjJ640VkYGONSmf4jk88GDALsFPpIL0+ws4KWVdeLE4UPxstYzXgRYtmIOOB+KpS1omnmMHwFAeEP6gBUMd/svR/9EBfxLshvsHGtaPvbThW1l58g+HZ4Fy3jNX5DzNWWSodgjRfyqTMUyQL4dq6PT9EayqxNYIDbvg+ooRHbmxSBbOYlCh7vzZ6QTV6O9pUPfMJ6hf2EIBw4+RF3vQZBKe1zy55qQeYfJsMggR9ZasY9ysDu5uQ6FMnZho9uDShffbAGEf9h9AqLNqKXO7PoScsj0AXkGTx/hIAiHPuArbtDn+AIvZ87ACEHLRe+KIbyoun+O7q7fNi3JnirbV/DE8o/YjzewJQPBsq1l3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:37:37.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddbf6b3-b2c3-47c6-bda7-08deb5a368b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289448-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,8.in:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8375357EF1A
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
object per page, containing page/bank or I2C address, offset, length and
data. Consumers that need a stable, machine-parseable form of the hex
dump can use this output instead of the text format.

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
                "length": 128,
                "i2c_address": 80,
                "data": ["0","0",...,"0"]
            },{
                "bank": 0,
                "page": 0,
                "offset": 128,
                "length": 128,
                "i2c_address": 80,
                "data": ["0","0",...,"0"]
            } ]
    } ]

v2:
	* Add JSON output support: each per-type function emits a "pages"
	  array with one object per page containing bank, page, offset,
	  length, i2c_address and data.
	* The shared module_dump_eeprom_hex() helper takes a struct
	  module_eeprom_dump with print_bank / print_i2c flags selecting
	  which header fields are printed
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
 ethtool.8.in                  | 18 ++++++++
 ethtool.c                     |  1 +
 internal.h                    |  4 +-
 module-common.c               | 38 +++++++++++++++++
 module-common.h               | 12 ++++++
 netlink/module-eeprom.c       | 43 +++++++++++++++----
 qsfp.c                        | 67 +++++++++++++++++++++++++----
 sfpid.c                       | 79 +++++++++++++++++++++++++++--------
 shell-completion/bash/ethtool |  2 +
 11 files changed, 294 insertions(+), 42 deletions(-)

-- 
2.51.0


