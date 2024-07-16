Return-Path: <netdev+bounces-111750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBE93272E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA29284512
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519519AD51;
	Tue, 16 Jul 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8iRyz2K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF619AA7B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135508; cv=fail; b=MtyUpNuWX2BJIcWRX2wcILd8QlRGqsGhkj/SaEQX/vFMcxq7sTA7V26exR4+f9s7oyhL/8dx0dfC79XvdypDLD9SC9dMXkrTUDIxsbZNJ5ymKX6neqHp8JdYUw+HpANXkcivVE4TEm0KWX2XGxEp+5Sw1W0n5DLSk9GQUlA+yzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135508; c=relaxed/simple;
	bh=wweLP5BFgAuJyUTTsg5wBG0gcodn3/opRIrD8PqTNNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUSuXPLp5w+c7Lk92PI5nz4jFrKs42CpFxaKBsUfs3snGnBNu9keOs5aiVoieU0bsv/gzz4G7wbsTbn34s4VQ0NeXK/d6AY3ZPwRIDScF3+m83lrYP6A/fDIpELcvLf3cceNvJnGMAZsuj2T7j/KeI4EZmTnvmlV+22hhgCpL8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8iRyz2K; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfGXAL87J8g1yEr/yG+rn0v9cSLhyBiKIaZnMrZJ1VZnRQKhpZhDCx6sYOY8t74OKZB2mUp7T7qMKIH5LYmspLK+c9kSessV9X8AafRF96J80Ed1moDV9zWFAZ6JdklcZomb3DYjt6OOK5RrreHL7noJuO3Tr74bE9xnLTRuY9adYxl06WVTIHptQewgbH3T3vV6ylp/ZceKkzNFk8D/nh9yy9TTSNr0QBnhILKvPrma8MOU+qycANYITUVNM/nq+a+TBtHmbj0SlAv2nzy7n/5EbrFM1nJOW6lmtwsnjIjrCG2F8M40KnH4rBV9rTha0QM8/80Y/oisdVpZsKF/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8KUgp5V1TPD/Hjt8UvZOQvxMUFMmI2hrdjkF8B+C4w=;
 b=veS0MdrGZf+4j7n8/9tUmaLF77q9pgXfRPtWLi5NhZTMrrAPrItziio4M2IA+4/pCRBIvvZzM21N/A9OyWFJK9h2yRzut+nV2YLA4xWQJPfBEVvuyWV/U8vZDG76Mac9zZFsYNM9VHPjHKY8BSCuPXMP37yHpbIgDijhhFFOVGgTEYsXUcytIHYY6lA9IZIQcVV8O/2qaXgibmQ9p9a6jrisBeDNf3PuZrDmR0ubRSn2ySrHS6tSaqlZhoMwb47Tlh9+Dij7VbcfN091EyjcmSW6zA2XH/hkJqbbVwmgj/+jjXkx2958esGB7u3dIGj8DuF+g2PVlI+n8zOTyqfKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8KUgp5V1TPD/Hjt8UvZOQvxMUFMmI2hrdjkF8B+C4w=;
 b=r8iRyz2K1JzyiREWUmdbVMg2Uj9v+hMVOO1ytjZyiY55D6/fcQsesKiLnKz0lMJSU4V1ZtmW3B5MXHm7wJTqwp3dDUq4YKzoeakqXJJdkgz07pv3Uj4LbARagD9pkOehhTcwGNxleXq79AHtcZX9qOvlyj0ql7FB23EmSvSKbbFDBzZNp49NHkYZ6ZpAJD4HojsoqI5fxidqTjI3MhzcjdziTuO2GGjF7VZ1fIbhDCN4rFbxr/C65SgxuTL4HaUnCpdlkVAm4hX3p9loaDEuUjGKUK9JBePpIph8xWqEjFqb4GxFiPMjThOjfmR/H4JkhZ3ZuVVb1SbsOdAWHv63oA==
Received: from PH7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:510:339::9)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 13:11:40 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::7) by PH7PR03CA0007.outlook.office365.com
 (2603:10b6:510:339::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 13:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:11:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Jul
 2024 06:11:26 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 06:11:24 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 0/4] Add ability to flash modules' firmware
Date: Tue, 16 Jul 2024 16:11:08 +0300
Message-ID: <20240716131112.2634572-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: db24902c-9cac-45fa-fbfb-08dca598d4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bSVPB16OMJ5yFc6cmEnCMxrXR2WXIKk/mFqd6P2b5UKpuC8hvX6z50/NXgaf?=
 =?us-ascii?Q?DvStd+y2ISc8FKrv3ojSYjE+pwUhcfIHJNtW1ViS+Ci0Ylm4OqrOWlMDeU6O?=
 =?us-ascii?Q?NC7UvnOSD1uGxSRgqfakjjtmcBwekoDhjfQa+G90gS9d/3vPJfK+2XkJQ8Xt?=
 =?us-ascii?Q?33gTlgfWCcMtpZBnH2sSPaS44Pa0fvoiDy1KNmZQ6LlhQNb4xWgIZ0pYeRIa?=
 =?us-ascii?Q?Iz5kphdxLz01gKXZW+0W2Lf+8mtzz9kE6+0Xp/aN3EGs0hhIRtO2Av73ez8o?=
 =?us-ascii?Q?BysGRGITG1CI2rs/wfkPmwXoUdFXXfpPMsndZ4hKX7VNU+7GFLs1mSjX47dM?=
 =?us-ascii?Q?aNfOmjFTNq4YGpoTOh4NSWEaDU2PEqyHW5iJWSY+PKa667CZcPe/bQz/IJYd?=
 =?us-ascii?Q?mOHRAwPzAbiFKy6oqFR8G0EenmmZOjAtZLUYn0QCFl1fnsm4UvN7KZK/C0ia?=
 =?us-ascii?Q?pzWQIAUiT4euBNYV7txe48as0sazY81mcbRN/eY8sKcVxS1TkdFeP3g3nHkA?=
 =?us-ascii?Q?0y4Y45vV9a5BoljFSqWUUMV18PporzWY63Pv/PSzDQGxJKD0lLBm8YaR9pCz?=
 =?us-ascii?Q?Av1pS6Yni4IEsG7/6LRJoP44eHvV6V5VrqHOH3J5f3esUYKIPGkvMbhP3x/e?=
 =?us-ascii?Q?zYWLRYsGtEyF5xzsq09C+dIIloxUfGs0ZtZmV4JVIGGUKraxA6NCZCLnuLw+?=
 =?us-ascii?Q?TQ7OtM4blpXuXOOsjyCdCuS/faV5Bb849D2zJgp4tuGqixnyB2InjgqDQXBd?=
 =?us-ascii?Q?TmPrT+PM3IDxLYh712doME1wVJ9dAPmsen0jL3aJKIA4wr0MY5EUhYpb9+tG?=
 =?us-ascii?Q?IWQrC32t+91VG12dpDeXVPBSBSyM3Fmr44zYaf+2xj/RrLFZuJMpqfOi4pwL?=
 =?us-ascii?Q?4kVYLxr7EbCk/M77G0w6KDGXRHP7kFaOaxhqHrvuKRwKPubE7cVjrECbOi/o?=
 =?us-ascii?Q?CkPFuI4WOOXL9HlOZxEU+IjmHXMxINchP1JgRwzjSO1FLOqUtD1PJ70TkSj1?=
 =?us-ascii?Q?XHjdh75hAy/Fh9lDl05zUCS1szqGvBGvnrS3UfpOsi8zSwPdNqLnIoIpUEa+?=
 =?us-ascii?Q?xDWVyBxQWY7Ti5kfe1XcKiml8seHsRza3atynQSbVrQX9jWZwJSrlRPzhUPh?=
 =?us-ascii?Q?nvkcz0/zDknSY4L1myGzpCuwZXxkHvy53tAIVJ2+WnvTwBfdXAGMhkACP6kW?=
 =?us-ascii?Q?2OAC7I+feTXUNAcZZiv9YCgIrjs6y54+TtizSEQ2WjQqTxNq8ZrQKvNtXFtX?=
 =?us-ascii?Q?V0CUpYoz14WoCjk5LegbX4ZhpARQwrBz4QOW/3AuyS7DhcwZUaJfCpZS0TCw?=
 =?us-ascii?Q?WYH9P/LSYBGqpeRXTkvLI3i84WCAW7yiappTpCP6aIQ+vmUIf3IdISFtYjJs?=
 =?us-ascii?Q?yYzbnIdeeruC0h7lCz4bdF90m0yDsguX3xXbqYtcwNo+m7wU+ToLfcfHUoiv?=
 =?us-ascii?Q?MTRmambdWX3WVQqVr+KlH+2k32HPHRzm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:11:40.5095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db24902c-9cac-45fa-fbfb-08dca598d4ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

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
Patch #3: updates headers.
Patch #4: adds ability to flash modules' firmware.

Danielle Ratson (2):
  Update UAPI header copies
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
 uapi/linux/ethtool.h          |  18 ++++
 uapi/linux/ethtool_netlink.h  |  19 ++++
 13 files changed, 465 insertions(+)

-- 
2.45.0


