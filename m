Return-Path: <netdev+bounces-168440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D0A3F0F7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C4E3B23D4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA531EF0B7;
	Fri, 21 Feb 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TR8xF2SS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2A1E5B78
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131582; cv=fail; b=nI3UfpdQdgL4L+DECH07rJ4Muy2Tn3HUp3pZEwncRR4ll/h86eUbtmwKHzLJRv2WVQ/rPspMN44U/iIiQXDGZjK4MVwBw/QJImIVNzjuBatJvqxB70+rM2NM+i3moBknI7dRMl9h9r0D0NcE7sxCLoiz+3i27FGK6vV8UXM5jF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131582; c=relaxed/simple;
	bh=JnTvG4lGKFCf2CE9B37UjpXW+rAEPdJ01gYb0YTsMKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hcgtq4/X78SGeL4dVy5j34ssZC7BsnF0spqWo/njHTPuSWRmzhJhbsb8WbGHTxJU7ZVG7gY5DYcXRQY/3kNSuL+swLPALw+yTG+FOXwAFRi7UBkQILjxsWbE6XXeTjl0ECWsvEy6+DROb9NFuAySxGXQpCp0RaCB3aTKByUetrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TR8xF2SS; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY8VoUP17eC8CAXsAS62qK2wJft8Jg2OL6DTL5bDENiLEQpJi9eFHmy0mlWmKjT61XWKKaW/YDjTvtZgi6LXnv2v3Ws5CqnH62H8eL8KASNh8hFdI5ft70Dig9oVGrhnfQyNDyzHAXQa7FbMmrhyWk7j/LLvbUvPHY/F/lHrT+FoyML6kPJ6YSw8f9S2RnAne8AwU8bfuGMMwKdOYztKrGurqdVP3mYzd0cjr9hqFH9tlxh2PvMhassqxBnNSJqoHSOSS+AEKRT47uckTa32c2lfzkH+xDX6FYAL3it/B3zAprrk4Up4NkY0WLOt/ZWX/xhf0Emrl9rOkeR1pyQjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAEKFJLf27fCnDg9rrVpubiCcunAQxeBKoacHMwl9io=;
 b=OuC9Ucw517J/3bKuVabNadhUNYWVUPqbwkh8TNSY5rcxxHEQMyh1TuOxJzuaKJAEPJGiKah6P1PEoqE7sHg8UjLRIu9Kz4K0L1bezlakquehKwPyuiGmtHAYHyKIPo2Gyz6jBX2TMvqGQ0CAuqXPVbdOJzymFsKgz2/QfuJn/Y/VXnG4VqHzxFi9ngaz/bXggpf9dd1v+J5yiYrCs2mkFP0GLmnxzFtbECOy2FsbK6NiVOZf1rKSbIXCsRfFZR2DasS5p01CCejGqa5TxNISp9vPpFgguywcp2AWQB+DrSTVmMVsthqpjR9bxy4QIMhCgVL8OqsgS8/GkJzSiP07iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAEKFJLf27fCnDg9rrVpubiCcunAQxeBKoacHMwl9io=;
 b=TR8xF2SSdRaitELFeZM0d7beTCe1tq/ufye/vedoDWsNaBiFgCQIZ4yWkdR1pfdHOFRvF7JlEsotRNBjvZ9KjTIQPVTBts/HnIVhx0ORdSO32EPvDjDdOiNyb/JkAH/0YuT1lloWvYGPfYxvYie5NbhHWDItGVsWdNDmUUhxa+QUXkXU1SkiNMAh1vCjdaz2U3dOJ98d/WWKeFcPCj4X7L5syHTrU4XZzrdibaj1UtA28rn0gHGHz1HIfl7+zib3a5wQxeKKDdgVt6o3hOIMRsfxXXgk1tE7EXpHZ/soh/mEioK24JovM4LbGEbvaWR/6mMZzTvG3fiA0CQQFrwlFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:52:56 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:52:56 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com
Subject: [PATCH v26 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Fri, 21 Feb 2025 09:52:07 +0000
Message-Id: <20250221095225.2159-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 19619030-2750-4633-dc99-08dd525d844a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2BW/IhiX5makUPaV3ubjfXNG/3trAg7J4dszIBfMoxTafrr8nJDJNmX1+CF?=
 =?us-ascii?Q?80dBbHGmFnJRsm+z0P6PQ1glcmnMZ8QE9uDZfxDgvbKRkt18A3aY1UgpD3Cc?=
 =?us-ascii?Q?gtmEmq9YYjY0f9GgxOywZzuzG1X9xtiXQ49D2UctmtPsuUiLbTJrSBzPpkFE?=
 =?us-ascii?Q?OsHRENCqFfopeLU2GUkUAmGiYE0L/V/WFCFkhrbeqbkqO5YJ7qrXSIDSsALO?=
 =?us-ascii?Q?3b76ZPPNmBXODqLv7t6uWPn8SInYwMEt7zNxuxQtPgYHh5MT+SVBe2+FQwzr?=
 =?us-ascii?Q?WKaskc/6TBhVLKU+YNNg2TTcv+pIpNUfEoNgG7xxJ377fGIYOEY8emH6opa2?=
 =?us-ascii?Q?K8qRl4R9ZV/ayv3GY3bWtUQCjweRLPC7zny2YTyBzh/fR8DSTQSfXCGZVibx?=
 =?us-ascii?Q?E58WdI8dXwRkZCwn7RADw50DXtKnt7gNUrEiMTr1WzgLisUOKpMnqysqUHvH?=
 =?us-ascii?Q?R20H595J6Sf924tOqOmXCuq1am0RtKhc8h18Ucxp/9QxTbtPESqmejxWQKJa?=
 =?us-ascii?Q?ywwE9T3MgCvHJlbpoPQGEaYGk+ZsDljqF/XDC5zeGpzqpveo2cEnm0BO/3db?=
 =?us-ascii?Q?0nj+ET/Lyn+EBc4zHRykBtfCGU8SW2l59+HPL420X4lYn6YZXyNsfUO24Xmt?=
 =?us-ascii?Q?NDw6qmo1Z0syqVWp1oh0LRxRYc97It6ZVTb86ivyVKcpsjQYcjmD0XQbeUSW?=
 =?us-ascii?Q?dsjMTDyaN8vaweoPYIVxLsHiEafkG8dXLKyZG2FRxfZDPMy8x48oP4/USRs2?=
 =?us-ascii?Q?lE++WidACnhWGKNy53THTMmKvxNaXf7Y30CrgW8KlWESRV1H9kbWwXPGRkZ7?=
 =?us-ascii?Q?UVrfTBDXfSxRQfuJ3xVbFOMZ5hHtbXhYzM4VddZdYhX9Ir2dMF6rn5jcDWIQ?=
 =?us-ascii?Q?DzN/DPUzJJsxgsGdyIaOrW+hi22DO3Ey3iCqgNeGLXLkY9jRU8PunJqbYKTm?=
 =?us-ascii?Q?8MA31dIRH3meXWU29DKXGZWFmm0NmTxEd3jaXXJELqur79aEWZTTk6hqG06K?=
 =?us-ascii?Q?mZiHnuucrPWW4IhmEGk4FMEPCuQnbeRNSYuIpai5cA6skCKfw1swKBFxwXY3?=
 =?us-ascii?Q?83pgjR4Zl3OI84WHllkbHP7/KCM8CTGHFDnYnjJuq/blyCuefVsYQE2mmUXF?=
 =?us-ascii?Q?9JyJNYjFViC5YD0+T0GCYRx1cCp7DdMtejgJreEnluwJHreo86a/GafLsyvI?=
 =?us-ascii?Q?5U7bOSo54P/XQgXT7A0nLMF/0PRgo70YWUIZU678TyA11o6DXn0w79U/g2jX?=
 =?us-ascii?Q?bkV7NaAl1fBIfMpBoEAObFv0XaU/uFHSqKoZdE/tXGJz6S8f8JctpedNOHRs?=
 =?us-ascii?Q?DqFtnvx6KVT402BGJkSkI/FuDos5SK23CsR/yZnl0FCLzqSSVIMW/S1xP1mA?=
 =?us-ascii?Q?w3I7ezk3FJAmtzwuU2oRK7qwcSGR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SG7P5S5eLQTPNphsmx4mhe6ZmmqO9Kov8/XcHNIvyFuENQj2Bu3iHvGBM7ed?=
 =?us-ascii?Q?3yTNUnzgiWg4WeS2DOAJ3qsLpouGPSFML7tNejQ2al9oKQNSQ6FxdMagtXoD?=
 =?us-ascii?Q?aDopEcf7ENSiNBLvUBtCH73kMp6maPVtdqHHG9PjzuNL86o6jalUts38619M?=
 =?us-ascii?Q?LF+JLGUXdrUS5KT/0b813gXgQrOENDLGJnGZ7b4nUObCVaKcQA6fD2/Q1gLW?=
 =?us-ascii?Q?dvAk1Dx19jc8Y1Z0J0YBxaKtVLqHc431yTR810480pNVvWOneomCBk1tsJAc?=
 =?us-ascii?Q?SW+DEg+l1AYARNRcEQRgdfKT4aZkSbpR8JgU6Gz3IpoCY7czX8NRIJz8GBZQ?=
 =?us-ascii?Q?T0ytWdMHS61WX46XVALldnCCEo6rKgZXh+qv7zjAwsNH3c82vIQpsdOm6JDP?=
 =?us-ascii?Q?+co1uKKcghpYxOGSXSW4DSa5IETtbMQ0AIMAQpYpRlzWhXiqQclAXbua8tu5?=
 =?us-ascii?Q?YbYVmQodV9M8jV5Grf1+AD/bcb6bRF5NBff+waNjbrZ0xq8tTgDVWQy4dJmq?=
 =?us-ascii?Q?nkfmmEgGU2WNgxcbvYcqh0m+RI7cd5hWTkjetJdv1Y3JVzyIA5bR8BPA4432?=
 =?us-ascii?Q?blXhvgHCQLUbYlLyEvIk/nC2Xtr2BdlgAALHHxgv11ceOTofLEkBGGm+porY?=
 =?us-ascii?Q?umxLQOaXFJlvPTs0sI52lb2FYoTM7+UWTuxyHt2j6N68E51DVvUASIqH+gxo?=
 =?us-ascii?Q?E/MoHWaT20oT1mLbxoIRxUAo5Wu7Yl0jcltBrY4C8/U9jUG2rvjvvhbSP3re?=
 =?us-ascii?Q?g424CHDU1gGNGYKlJLOpJniMPE4H1jBD+XyvGhurW/hR/VLyCbOiglo0sD+0?=
 =?us-ascii?Q?INxzK1Got5aWGNt7oZH9H06xfJfm9sc7RasmbzcuMtAH5z+ciPC/g1X4RDtt?=
 =?us-ascii?Q?Jt9rhb/wpE8YiTsp8m9dEZXmIG2rwX5cP0Lu7slEDu3lUpYm3E2j304gWFa9?=
 =?us-ascii?Q?CEx4qJnVh/opbNCe9WazArduCJ2hFbkbBkLwv1WsezHq2feyTRONWNGoqCEe?=
 =?us-ascii?Q?Ns/1MjKhvSjasL3gah78pjIpl4jEz09adkxEim6wG/3bCsbM89NW3jhQhH6/?=
 =?us-ascii?Q?Xj3VK/wKKaifzvc4vLdRj0SiYG5BHPY2uoKb/lgnGGv+zML6R2w2II2VdnMn?=
 =?us-ascii?Q?F6/pQh9rNiCmo/jWcCU3g2VgKgfImvLRDTjp4RB0WfHhL3PwCledsPij7jMJ?=
 =?us-ascii?Q?oNUG0CeZg/Wp8jRt4iGmOzlZ9A6MbZ645ozBxTIDPu8fSzVMGVCgaNXA2ixD?=
 =?us-ascii?Q?6PnQDa5RmeZlDoSSmQgir+SY6u3nsdTBawgx29fi8O7+tBGn5njdRm0krWAe?=
 =?us-ascii?Q?nKS80kcjoh/nfuMB4qgpg1zViy2dAI3LPEuVDDdDaH2vi+0aWVuMxsD5ZWFt?=
 =?us-ascii?Q?EKs/J+K9AaMO3swUdOXDqS+pbC7t5DeBo1Xab6SjQdbU055V24FdasGhkF78?=
 =?us-ascii?Q?zDAlj/pDiHGplbmK5I434WXtpeCM8YbQdCtQEECN9z73Qrufj9A8UhZ3TEMa?=
 =?us-ascii?Q?hTi/noFI1/NSHXqDhn1qCiutKIw6vLXmPVrRJVWXLIp/UfRbVqfQfH3ApHzu?=
 =?us-ascii?Q?49eAOM7susdAM0l82KU9hS0fNPnjzPqmtPo4HWG5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19619030-2750-4633-dc99-08dd525d844a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:52:56.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUmNHzYMfWb1was7VkDMMY61zHVLZN4+ZX7ACukPBveaC8g8gJU8r3AIu46g+AZC6P3O25P7kOBL9vLgw0cvQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

Add a new netlink family to get/set ULP DDP capabilities on a network
device and to retrieve statistics.

The messages use the genetlink infrastructure and are specified in a
YAML file which was used to generate some of the files in this commit:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    -o net/core/ulp_ddp_gen_nl.h
./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
    -o net/core/ulp_ddp_gen_nl.c
./tools/net/ynl/ynl-gen-c.py --mode uapi \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    > include/uapi/linux/ulp_ddp.h

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/ulp_ddp.yaml | 172 ++++++++++++
 include/net/ulp_ddp.h                    |   3 +-
 include/uapi/linux/ulp_ddp.h             |  61 ++++
 net/core/Makefile                        |   2 +-
 net/core/ulp_ddp_gen_nl.c                |  75 +++++
 net/core/ulp_ddp_gen_nl.h                |  30 ++
 net/core/ulp_ddp_nl.c                    | 344 +++++++++++++++++++++++
 7 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..27a0b905ec28
--- /dev/null
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Aurelien Aptel <aaptel@nvidia.com>
+#
+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+#
+
+name: ulp_ddp
+
+protocol: genetlink
+
+doc: Netlink protocol to manage ULP DPP on network devices.
+
+definitions:
+  -
+    type: enum
+    name: cap
+    render-max: true
+    entries:
+      - nvme-tcp
+      - nvme-tcp-ddgst-rx
+
+attribute-sets:
+  -
+    name: stats
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: rx-nvme-tcp-sk-add
+        doc: Sockets successfully configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-add-fail
+        doc: Sockets failed to be configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-del
+        doc: Sockets with NVMeTCP offloading configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup
+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup-fail
+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-teardown
+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-drop
+        doc: Packets failed the NVMeTCP offload validation.
+        type: uint
+      -
+        name: rx-nvme-tcp-resync
+        doc: >
+          NVMe-TCP resync operations were processed due to Rx TCP packets
+          re-ordering.
+        type: uint
+      -
+        name: rx-nvme-tcp-packets
+        doc: TCP packets successfully processed by the NVMeTCP offload.
+        type: uint
+      -
+        name: rx-nvme-tcp-bytes
+        doc: Bytes were successfully processed by the NVMeTCP offload.
+        type: uint
+  -
+    name: caps
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: hw
+        doc: Bitmask of the capabilities supported by the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: active
+        doc: Bitmask of the capabilities currently enabled on the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted
+        doc: >
+          New active bit values of the capabilities we want to set on the
+          device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted_mask
+        doc: Bitmask of the meaningful bits in the wanted field.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+
+operations:
+  list:
+    -
+      name: caps-get
+      doc: Get ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: stats-get
+      doc: Get ULP DDP stats.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - rx-nvme-tcp-sk-add
+            - rx-nvme-tcp-sk-add-fail
+            - rx-nvme-tcp-sk-del
+            - rx-nvme-tcp-setup
+            - rx-nvme-tcp-setup-fail
+            - rx-nvme-tcp-teardown
+            - rx-nvme-tcp-drop
+            - rx-nvme-tcp-resync
+            - rx-nvme-tcp-packets
+            - rx-nvme-tcp-bytes
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set
+      doc: Set ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+            - wanted
+            - wanted_mask
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set-ntf
+      doc: Notification for change in ULP DDP capabilities.
+      notify: caps-get
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
index 9f2d14998cb3..f7538a5d73eb 100644
--- a/include/net/ulp_ddp.h
+++ b/include/net/ulp_ddp.h
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <net/inet_connection_sock.h>
 #include <net/sock.h>
+#include <uapi/linux/ulp_ddp.h>
 
 enum ulp_ddp_type {
 	ULP_DDP_NVME = 1,
@@ -126,7 +127,7 @@ struct ulp_ddp_stats {
 	 */
 };
 
-#define ULP_DDP_CAP_COUNT 1
+#define ULP_DDP_CAP_COUNT (ULP_DDP_CAP_MAX + 1)
 
 struct ulp_ddp_dev_caps {
 	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
diff --git a/include/uapi/linux/ulp_ddp.h b/include/uapi/linux/ulp_ddp.h
new file mode 100644
index 000000000000..dbf6399d3aef
--- /dev/null
+++ b/include/uapi/linux/ulp_ddp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ULP_DDP_H
+#define _UAPI_LINUX_ULP_DDP_H
+
+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
+#define ULP_DDP_FAMILY_VERSION	1
+
+enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+
+	/* private: */
+	__ULP_DDP_CAP_MAX,
+	ULP_DDP_CAP_MAX = (__ULP_DDP_CAP_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_STATS_IFINDEX = 1,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+	ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+	ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+	ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+
+	__ULP_DDP_A_STATS_MAX,
+	ULP_DDP_A_STATS_MAX = (__ULP_DDP_A_STATS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_CAPS_IFINDEX = 1,
+	ULP_DDP_A_CAPS_HW,
+	ULP_DDP_A_CAPS_ACTIVE,
+	ULP_DDP_A_CAPS_WANTED,
+	ULP_DDP_A_CAPS_WANTED_MASK,
+
+	__ULP_DDP_A_CAPS_MAX,
+	ULP_DDP_A_CAPS_MAX = (__ULP_DDP_A_CAPS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_CMD_CAPS_GET = 1,
+	ULP_DDP_CMD_STATS_GET,
+	ULP_DDP_CMD_CAPS_SET,
+	ULP_DDP_CMD_CAPS_SET_NTF,
+
+	__ULP_DDP_CMD_MAX,
+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
+};
+
+#define ULP_DDP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_ULP_DDP_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index 767ed5186d4d..7b040d36cf94 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
new file mode 100644
index 000000000000..5675193ad8ca
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "ulp_ddp_gen_nl.h"
+
+#include <uapi/linux/ulp_ddp.h>
+
+/* ULP_DDP_CMD_CAPS_GET - do */
+static const struct nla_policy ulp_ddp_caps_get_nl_policy[ULP_DDP_A_CAPS_IFINDEX + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_STATS_GET - do */
+static const struct nla_policy ulp_ddp_stats_get_nl_policy[ULP_DDP_A_STATS_IFINDEX + 1] = {
+	[ULP_DDP_A_STATS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_CAPS_SET - do */
+static const struct nla_policy ulp_ddp_caps_set_nl_policy[ULP_DDP_A_CAPS_WANTED_MASK + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+	[ULP_DDP_A_CAPS_WANTED] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+	[ULP_DDP_A_CAPS_WANTED_MASK] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+};
+
+/* Ops table for ulp_ddp */
+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_get_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_STATS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_stats_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_stats_get_nl_policy,
+		.maxattr	= ULP_DDP_A_STATS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_SET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_set_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_set_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_WANTED_MASK,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family ulp_ddp_nl_family __ro_after_init = {
+	.name		= ULP_DDP_FAMILY_NAME,
+	.version	= ULP_DDP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ulp_ddp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
+	.mcgrps		= ulp_ddp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
+};
diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
new file mode 100644
index 000000000000..368433cfa867
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_ULP_DDP_GEN_H
+#define _LINUX_ULP_DDP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ulp_ddp.h>
+
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info);
+void
+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	ULP_DDP_NLGRP_MGMT,
+};
+
+extern struct genl_family ulp_ddp_nl_family;
+
+#endif /* _LINUX_ULP_DDP_GEN_H */
diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
new file mode 100644
index 000000000000..04feefce23c2
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ulp_ddp_nl.c
+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <net/ulp_ddp.h>
+#include "ulp_ddp_gen_nl.h"
+
+#define ULP_DDP_STATS_CNT (sizeof(struct ulp_ddp_stats) / sizeof(u64))
+
+struct ulp_ddp_reply_context {
+	struct net_device *dev;
+	netdevice_tracker tracker;
+	struct ulp_ddp_dev_caps caps;
+	struct ulp_ddp_stats stats;
+};
+
+static size_t ulp_ddp_reply_size(int cmd)
+{
+	size_t len = 0;
+
+	BUILD_BUG_ON(ULP_DDP_CAP_COUNT > 64);
+
+	/* ifindex */
+	len += nla_total_size(sizeof(u32));
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		/* hw */
+		len += nla_total_size_64bit(sizeof(u64));
+
+		/* active */
+		len += nla_total_size_64bit(sizeof(u64));
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		/* stats */
+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
+		break;
+	}
+
+	return len;
+}
+
+/* pre_doit */
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
+		       struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx;
+	u32 ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_IFINDEX))
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ifindex = nla_get_u32(info->attrs[ULP_DDP_A_CAPS_IFINDEX]);
+	ctx->dev = netdev_get_by_index(genl_info_net(info),
+				       ifindex,
+				       &ctx->tracker,
+				       GFP_KERNEL);
+	if (!ctx->dev) {
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not exist");
+		return -ENODEV;
+	}
+
+	if (!ctx->dev->netdev_ops->ulp_ddp_ops) {
+		netdev_put(ctx->dev, &ctx->tracker);
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not support ULP DDP");
+		return -EOPNOTSUPP;
+	}
+
+	info->user_ptr[0] = ctx;
+	return 0;
+}
+
+/* post_doit */
+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+
+	netdev_put(ctx->dev, &ctx->tracker);
+	kfree(ctx);
+}
+
+static int ulp_ddp_prepare_context(struct ulp_ddp_reply_context *ctx, int cmd)
+{
+	const struct ulp_ddp_dev_ops *ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		ops->get_caps(ctx->dev, &ctx->caps);
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		ops->get_stats(ctx->dev, &ctx->stats);
+		break;
+	}
+
+	return 0;
+}
+
+static int ulp_ddp_write_reply(struct sk_buff *rsp,
+			       struct ulp_ddp_reply_context *ctx,
+			       int cmd,
+			       const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		if (nla_put_u32(rsp, ULP_DDP_A_CAPS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_HW, ctx->caps.hw[0]) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_ACTIVE,
+				 ctx->caps.active[0]))
+			goto err_cancel_msg;
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		if (nla_put_u32(rsp, ULP_DDP_A_STATS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+				 ctx->stats.rx_nvmeotcp_sk_add) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+				 ctx->stats.rx_nvmeotcp_sk_add_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+				 ctx->stats.rx_nvmeotcp_sk_del) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+				 ctx->stats.rx_nvmeotcp_ddp_setup) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+				 ctx->stats.rx_nvmeotcp_ddp_setup_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+				 ctx->stats.rx_nvmeotcp_ddp_teardown) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+				 ctx->stats.rx_nvmeotcp_drop) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+				 ctx->stats.rx_nvmeotcp_resync) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+				 ctx->stats.rx_nvmeotcp_packets) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+				 ctx->stats.rx_nvmeotcp_bytes))
+			goto err_cancel_msg;
+	}
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+
+	return -EMSGSIZE;
+}
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static void ulp_ddp_nl_notify_dev(struct ulp_ddp_reply_context *ctx)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+	int ret;
+
+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(ctx->dev),
+				ULP_DDP_NLGRP_MGMT))
+		return;
+
+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_CAPS_SET_NTF);
+	ntf = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET_NTF), GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	ret = ulp_ddp_write_reply(ntf, ctx, ULP_DDP_CMD_CAPS_SET_NTF, &info);
+	if (ret) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(ctx->dev), ntf,
+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+static int ulp_ddp_apply_bits(struct ulp_ddp_reply_context *ctx,
+			      unsigned long *req_wanted,
+			      unsigned long *req_mask,
+			      struct genl_info *info,
+			      bool *notify)
+{
+	DECLARE_BITMAP(old_active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(new_active, ULP_DDP_CAP_COUNT);
+	const struct ulp_ddp_dev_ops *ops;
+	struct ulp_ddp_dev_caps caps;
+	int ret;
+
+	ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+	ops->get_caps(ctx->dev, &caps);
+
+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
+	 * new_active &= caps_hw
+	 */
+	bitmap_copy(old_active, caps.active, ULP_DDP_CAP_COUNT);
+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_CAP_COUNT);
+	bitmap_and(new_active, new_active, caps.hw, ULP_DDP_CAP_COUNT);
+	if (!bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT)) {
+		ret = ops->set_caps(ctx->dev, new_active, info->extack);
+		if (ret)
+			return ret;
+		ops->get_caps(ctx->dev, &caps);
+		bitmap_copy(new_active, caps.active, ULP_DDP_CAP_COUNT);
+	}
+
+	/* notify if capabilities were changed */
+	*notify = !bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT);
+
+	return 0;
+}
+
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	unsigned long wanted, wanted_mask;
+	struct sk_buff *rsp;
+	bool notify = false;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED) ||
+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED_MASK))
+		return -EINVAL;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	wanted = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED]);
+	wanted_mask = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED_MASK]);
+
+	rtnl_lock();
+	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info, &notify);
+	rtnl_unlock();
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_SET);
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_SET, info);
+	if (ret)
+		goto err_rsp;
+
+	ret = genlmsg_reply(rsp, info);
+	if (notify)
+		ulp_ddp_nl_notify_dev(ctx);
+
+	return ret;
+
+err_rsp:
+	nlmsg_free(rsp);
+
+	return ret;
+}
+
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_STATS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_STATS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static int __init ulp_ddp_init(void)
+{
+	return genl_register_family(&ulp_ddp_nl_family);
+}
+
+subsys_initcall(ulp_ddp_init);
-- 
2.34.1


