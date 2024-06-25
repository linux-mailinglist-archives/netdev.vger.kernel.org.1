Return-Path: <netdev+bounces-106455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F439166FD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C001C2396A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64688156879;
	Tue, 25 Jun 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbFhXNCf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B21553AF
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317328; cv=fail; b=dPh4TmYj3UpbjumA6GTBCKc7rcH5Ht1F+kPMLXB465Qlga+v7gGmDXMNqZCAqAbrP7w13l5nUPPaL1JJS6glOjte/GZycPVfZEufyiaePMXdLIQS5VKqmr7AfHT/7w4j0duTFIvfRDWV2FQ2Az2SOyqfT/S0n76D4ohQosAy4AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317328; c=relaxed/simple;
	bh=kjG4wigMPDLjE3UeywLde49NHZ3i6oO7HhM1l/+ojnw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=He0egnLtzd6SGR+P9MWwVdgtpMvIVQxM3h4INFdotx9PDNoUMnUBEsnZRS6BKwnxnm9fE5yWNJ+7HG3d6I2UyM8oooZhajMyOJ/7AgiTEW/4FM8mnfqhWmeaqOeFJECtuco81ncmHH+xSbc/t1qc6rlwI0xb5WLXAaJp0TWfXRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbFhXNCf; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU/8TMJha2rTX+VnVmKqbmt7Zn16nabL7i3OAYmqplKWPAIosa5qR9y1/pEDWVrK4KHMiVAoHFb8wENUKfjzBRb8M7TB7M6alr6NP6fxpixAkVxJxcLSmqEnrCd22MdQbNtadXCEYCggQkAHrTLq9Dt3J/lUJIxfe5lbi1WdB96A6ppV50/qmwo+UOuuA3qzj4LeBtxMQ3G0bvsp6QlinVjcotnLWbklNME6pV1gGCF567hfjbUauHY1SNJlKNEqAjPeYElLMtTaFVXlZajmP4ADIkHLpCSsd8U2rFPoitAcNv10No1Ko5kgM/LTcejg7f263tyrkNdknB2bHRkA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtjx+Yg3h2YO7FWUl1mAzK/YANhaO014wQsq18LdsPY=;
 b=VxVPuYDX/1IetyzwBPP14ABz6LLlmcB606GRMVhOoM5BihR0d8rdYFrlLC30WjsBAl/5JAuJAbinZKoGkPEjQXSSne1K7PvOZHNE2e9aMu1txFx7YuH4o5ptH922Haw6nlam5CattuI4pjCcz/xCOSdB9GwLtY6ed7M0X9seHjxbag/KQ0uuZzSTdt9De6p8JB/mLgcXnQMmr/1JzOZw5pkfvL40PNaxGrBia8XgPghHkdl1aCcDBhWQ2i7oh3fVfPO4lZIDECiAmT7fUFaek+V3Fosi+gEjfkqASFCbhbmXBTl4kwQU8+Ds5TysL1HG5Vh3dRiYpFHjL19w8/y5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtjx+Yg3h2YO7FWUl1mAzK/YANhaO014wQsq18LdsPY=;
 b=tbFhXNCfUF2sNIFwH/0HsvEZWzhrhVDrBve9B0h513Wd+UNg2dqrOL4H/gIkPct1s7LwlImueRY6mqizZEKdIIDwlH5AdIWhKIleVZvg7ryw2aK0JBZ8XO8twFd392dfd72Wu6yeZkWCQ3VA95Ccas3ba8jLqJpxgF0d2EOrG1FRfYDgQiz+cnOU5V7lcwywiDsHJ4EHpqUESdJb+LJjB/eiBBwZPXL9vvaVfzIDMlKZHqHgavCoP7D2jzfKeAk5JYNpLl1AckFyuUe7De/FxVnZ7Ncnctn0pk0NaGP4npyjTN5woxiKTvHqTNVe8vcT65ZzH8PBIvDQb0qajhZKjQ==
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 12:08:42 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::fe) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 12:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 12:08:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:08:25 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 05:08:22 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, <netdev@vger.kernel.org>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH RFC net-next 0/4] Adjust page pool netlink filling to non common case
Date: Tue, 25 Jun 2024 15:08:03 +0300
Message-ID: <20240625120807.1165581-1-amcohen@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: b62b8e38-e5c4-46eb-112e-08dc950f8e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j9GWL9/8ujdW35A67rtt5aLPDG0ZnY+gl8OezXlL4G1SFzmK/Zoq5ClNyxcC?=
 =?us-ascii?Q?WwqEWg3nN5vY2E3tV8ZajUM/CPBsFYlUEvH6JcTw6//hfL8e72JryrTTj80t?=
 =?us-ascii?Q?v357Go0/RnGxSc/Iiub1XYj8oWiSSXyM96BIdFuEspCACONMCOXB5uHHAYlD?=
 =?us-ascii?Q?+0cLxbeRXZbB79Z+OuVDQOYHgpceej1mRIY/vlmr7K10OIgyd4qXlG1sxJbs?=
 =?us-ascii?Q?jc3Sah39CCbYBcyCjUxeZUkKTusMX1QsrQZ+SnutsQplwBYk8Kn+/En4J9GL?=
 =?us-ascii?Q?Wnrrq39MmbVLUDUukNXk7p138AJZsqw11IXw6NMYmvHYhK1WGIL/++4npC19?=
 =?us-ascii?Q?VJOizAlJwyMtW8JH3K0OU+8vHFuTh8lnmU3ESgaqbQgT3yh3Yz8Jnr7BF8BR?=
 =?us-ascii?Q?f3c5I6h0lUXKHLGkkheUr2MdrpDVl9VjehGz1ryuJydd4pUzZWTOL0LgClvp?=
 =?us-ascii?Q?ODCgsBn947uyG+TlIaSNAVevdK9T6K0h0s1YEkoZ1bQ3IhTrNWKLqSKGBRiM?=
 =?us-ascii?Q?yp7KYMsOoIhx6DqmKHjq3tlrSlsjUjXEIn63/+DghQ31rFnX41LrgAHLa/sF?=
 =?us-ascii?Q?NOzMLKVUI+mNxN8P99AOp05u2WTBeAffhaRD1BeJThTKTZEVSSpvCuIbcIV4?=
 =?us-ascii?Q?vZ6iolyruhqEW2Qgz3Uz3Wl1Z0e7LY7867mpcLJSjrIAmNrkOfW1eCE2wBer?=
 =?us-ascii?Q?yUBTo2LRZp+ueSnaRI0AsWJYmbxg97QAPlQ9zkBT66f4QO05dSRGk2uTTiZR?=
 =?us-ascii?Q?jt1ijvdiyG2c/S+l1JljoB9uIcc6jqw7SLkt1woBPmeCANTy8mQYyP5n8nwn?=
 =?us-ascii?Q?Y2RArGM5nCb/oqVEyhbEWgg9WrdzXEu26QNv0Wcao9zf/0xZvLtYKEGgB2ay?=
 =?us-ascii?Q?SzuryHeqzTLnOLW3NDtWdEhz7P9GIaj9ePKFreZycdwr7qdKi5McrNXcTAvl?=
 =?us-ascii?Q?spkV70COyroEWm9Yc5BZtdYP/AV61756tidRl7HlNxxe2Zdv8X9EVnWHFmKG?=
 =?us-ascii?Q?+bd48+9x5jxXbK3q98jLfqNUr/JrfYiI57+r/hBAY49Hwo7sXx1EryQFuawT?=
 =?us-ascii?Q?lzJAI0e3hfyLyTdZ3avY1HaHlSuY5OxCnhs2hq8429KOBHWCPwCfmJES43Zn?=
 =?us-ascii?Q?R/3xowBikdbU+zRVowJEqz4SrLsTBvSXihndDkA7GsESYvsF2aviF9sB9nqe?=
 =?us-ascii?Q?h1dHgCeEGpiC+l/tdNw4C1hI2X752TP8rXwp7pmjFCgqpjUN3hRawZtGsp8i?=
 =?us-ascii?Q?6+2RcRXflp/Meawy3HTb5+5/cu3a9vZXvUXmFNNvl1EuGsUZBCgl+L+XGM9N?=
 =?us-ascii?Q?/nsbBU9952+qEKytufxWXNB06rfkHqxrDT2tr4aw2HVDv6ZHSxMDwZjZLC/c?=
 =?us-ascii?Q?fAoN9yCyCZ23cN2VLaTdQNcTL9Z14pBk8hbLUVTA4tSQZUPvqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:08:42.3349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b8e38-e5c4-46eb-112e-08dc950f8e55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

Most network drivers has 1:1 mapping between netdevice and event queues,
so then each page pool is used by only one netdevice. This is not the case
in mlxsw driver.

Currently, the netlink message is filled with 'pool->slow.netdev->ifindex',
which should be NULL in case that several netdevices use the same pool.
Adjust page pool netlink filling to use the netdevice which the pool is
stored in its list. See more info in commit messages.

Without this set, mlxsw driver cannot dump all page pools:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--dump page-pool-stats-get --output-json | jq
[]

With this set, "dump" command prints all the page pools for all the
netdevices:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--dump page-pool-get --output-json | \
	jq -e ".[] | select(.ifindex == 64)" | grep "napi-id" | wc -l
56

From driver POV, such queries are supported by associating the pools with
an unregistered netdevice (dummy netdevice). The following limitations
are caused by such implementation:
1. The get command output specifies the 'ifindex' as 0, which is
meaningless. `iproute2` will print this as "*", but there might be other
tools which fail in such case.
2. get command does not work when devlink instance is reloaded to namespace
which is not the initial one, as the dummy device associated with the pools
belongs to the initial namespace.
See examples in commit messages.

We would like to expose page pool stats and info via the standard
interface, but such implementation is not perfect. An additional option
is to use debugfs, but we prefer to avoid it, if it is possible. Any
suggestions for better implementation in case of pool for several
netdevices will be welcomed.

Patch set overview:
Patch #1 makes netlink filling code more flex
Patch #2 changes the 'ifindex' which is used for dump
Patch #3 sets netdevice for page pools in mlxsw driver, to allow "do"
commands
Patch #4 sets page pools list for netdevices in mlxsw driver, to allow
"dump" commands

Amit Cohen (4):
  net: core: page_pool_user: Allow flexibility of 'ifindex' value
  net: core: page_pool_user: Change 'ifindex' for page pool dump
  mlxsw: pci: Allow get page pool info/stats via netlink
  mlxsw: Set page pools list for netdevices

 drivers/net/ethernet/mellanox/mlxsw/core.c    |  6 +++++
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  9 ++++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  2 ++
 net/core/page_pool_user.c                     | 22 +++++++++----------
 5 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.45.1


