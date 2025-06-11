Return-Path: <netdev+bounces-196594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22BAD5859
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96A53A2C1D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBAD265608;
	Wed, 11 Jun 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lG2EtsFY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F92E6108
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651428; cv=fail; b=ZlEmaYeSe7vSpo5j47l8YlmhOmGKXqgHbzqY7R2nCGvfDQZbIG9yP1W/DK5CoGOxJEAB88wS8muIYeMxt1jW+TKOHDdGC9XSySWUsCDQoQ1jGriopMsbKFQ6R4JB7lJwK0Oj04pXf8iaAPeqO7mlcDVhRGwkL5HhNmvXGGSzfX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651428; c=relaxed/simple;
	bh=SSwFo3cKJNHBFud/AHYb0D6VtSdCG9BuHXzdW6PqTqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1Nhd3V12cDRhNBpPs6WC3eAIp9vweuOOnaU4dokjTcArNlMt3jL+YDUM5UhNqB++iQ/UX/2f/theYW0z9NennrN5jEGf05gEcGSt8mWbl0a5+OzWDuYwu89Iy7ZVUWMZhvxpySiF6PXj5yFdeMS3RngGiOfxQ6Mg77D6Ly3Lno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lG2EtsFY; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6IT0Mso/nGAgRqBqiBVNymHq7AtY2B9iHTkYWyt23iV+uwdLEELWi66kPVS2gbrsoaJOzDukoIia6cGZL4pshLFrAa81cm5OCcfoZhIwYgWWQNQLuH+2gVAjhVUjLmEWxmUiZc70oUImN8tifsnVsoUZFungHTPPRSoOPxi5n4cE6gLfhZW0ONqkdHkpMrrITRDR74HKI9LNNlt9Chmz1e8zpfK/P9zqGPvqwe2uIrLp+fN7ZlFvKsIv560Rk2Wi1pR7Co0E1gTfAxycfRPwL+g+eVZF62g5nryLEGimLGp7J6YYsv0x5f0Hc3P+1UpVR2Jac3ff+O7vBvRjhQKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yb4ewLl72e6kBDMBE3ayaZJ4NLoW280QeBrjaqorBM=;
 b=w2gpZSTtyCiH1WfRPtKN+fFTDiAjJFBOm2vEirN+iWyZ8/1etyTdPw7sIN1jOnsv+O/RUFj8C8Az8pVBm6iFBY71djZcuzJcLsrBBDpTjwR2uC49i9XZoYlBYaBSbjZxLiizHA9njcVt9aVBABXnuJRq5AGj0Z5gNfVPG5ibo3n7Al5bXbRHBlPsBQtKvlu57c7QewQybdEB8v46WZZu/Yqnlzb0i5ne3LgUFyXZBzFgxr9ubyiy6zNPvj7KyrEaNVyugYJSgTLCWFLC5HScomkvgIAm3kVjfYX1XfsHQk+yUjUV9fdaopYN9VcBmHtpqD+cXAPyHj7nsH1tCHnEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yb4ewLl72e6kBDMBE3ayaZJ4NLoW280QeBrjaqorBM=;
 b=lG2EtsFY7zy2KOrNybdfTgBf7F78Yjoa3g1GrJcA4F1r9Gu4NcfgyXUTvIJsCct+f/eT6uZYAFvoIq8ouazT5M81ZM5TYYrDOXZda/2qeDGzd5jdHUOMjj6hNlpQaMeg2Um0wNpMesyZxM7dBUixHjLUFBOCDN20IcxFialCFgeHlVAQVWUAckxx9sUpCcJqySzjGPEaQf1k1bEsMSZQzMsLmUGatBZk3HoAmwx7GyOH8Fq+7kYLnw7bArcSz9+iChdF5m0MjJ+HtYJyfl2hXALIuD0b7I/GEOV350xvi4wDPf/B6L0vvV8BEXkPC5bX1xTSuEIpIyNJDOsrq4zpWQ==
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 14:17:01 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::a5) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 14:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Wed, 11 Jun 2025 14:17:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 07:16:44 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 07:16:40 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 0/2] Add support for externally validated neighbor entries
Date: Wed, 11 Jun 2025 17:15:49 +0300
Message-ID: <20250611141551.462569-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4549e2e7-ee91-4135-97ef-08dda8f2a1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7u1BqKxg2NcnmIYLidxsa4R/idpYiph1zxfxT9exxcmWVGiUjIJNl6zXeTuB?=
 =?us-ascii?Q?SOxsrfZkruzG+mrgBLE/vYhQatIDVCHWZdttWGmVgUXhWgJ+n/QdE/PpS7ja?=
 =?us-ascii?Q?3tuagZOBKE1HCURaD+Z7sWFxMV1ZKAqf2+C3bVIAPpeHq5/Oh0j+bOZXGtII?=
 =?us-ascii?Q?rS4LmwULXIbPeRyrz0j3gDLsTGdUbfV2Vq2xBlSe4YPSPPDTMBPw/3e/DP4V?=
 =?us-ascii?Q?48wlgkllvRfSsdtedjwJ9BGw0Ps9ag/CJO0arj3iPBvh6RARyg4HPKUqFhND?=
 =?us-ascii?Q?C6a3QqKmh2CUcjBv2aaWKDfCYgomBuuRZKA4HD+Xq0SBn/lCwvvSJBCg0a2K?=
 =?us-ascii?Q?oLWav2BAwh48ATwlkefW8JbTjo7JiSg5Gp2NhtX5KgSo1U1ugtUrvlSV87H3?=
 =?us-ascii?Q?dKZaYqwEyUgLxi57+UQ7U3tIMxHofdBr2CdLu3rZAm4q1YGDxv6W25rz5ZGH?=
 =?us-ascii?Q?ZrZrNY70FwEbkultw35OWl1zEvvKeHDn3HIxxAZTmMdIRG1GrehI0idLy6fb?=
 =?us-ascii?Q?NrBmq3aQiO35qj2yMZa51CsbuQTcARmuuv5LMWGVSkO5Uhs9oe6fqXMGIKQE?=
 =?us-ascii?Q?v301kkMBsT2zyioZpjuKfGifd9gDoMXZnvczh+G0TI3q++ujMNt6NmEVoLs5?=
 =?us-ascii?Q?Bo3fK9ETfPK+b7skAxCQE/VPfjbv67rbWKA4y4k9lMre5+/dGaAIoKfVur5V?=
 =?us-ascii?Q?mwYAoGjVcGSXJ5OR5DTbNzjo60LhHYYsePlRY1TYF8Hk3pwbHnCryxUvpmtq?=
 =?us-ascii?Q?oZnZraR0rw5g8REC3lgOvE6S34YPNptP9bzBa4l2aelB2oJgpZP94Hphmj9+?=
 =?us-ascii?Q?pJa3FSIEnsRbDaPswLDfvl3tTqIMujKjyrlQUcW5jTLfsvq1c4I9ZdihJiL5?=
 =?us-ascii?Q?PD/ecCPMkKGPqq/KUk8jKBUSfMH9HCWdmRDCjSEx/RTYir2C0v2wewgSWsWG?=
 =?us-ascii?Q?G0p20owPKq+qxc1XMfovlPPMgzDxvOlCkzxBc39j3D/+ATx+PvlcC3dJQ2km?=
 =?us-ascii?Q?U673ktFGuAY3uxMDXpk9h2QIXxkbEt+nLORkAUlPxJNg5sMaMUbZB1M9QkkJ?=
 =?us-ascii?Q?IkV3frx7z739jqo09mzYHWssUjoVG+67bhVRQaxMgUBO0T+LieZSBJRLyt/P?=
 =?us-ascii?Q?pMps9DmnKoZ/+swTtCh4x9xXmG7Rv+mx2il9KxE5QIIO0L9LQ3EUVAiRUatb?=
 =?us-ascii?Q?L1nx1aNgjxcbPwFYeIm2XQg8NsWyncHhQKnevf8yeRekQmFlxrHd1L+JoO6c?=
 =?us-ascii?Q?1Wkpe0NK49XBeDm0DuMWThnyqkj7EzP6oBniUAkYS3/AavjejsmtHRm/V34r?=
 =?us-ascii?Q?nz9P8GkqUdZs+O2I6kvpXIvyVaXTqeTIU4LMEqCvIldDfNtMeZ0/Z1mpwk9z?=
 =?us-ascii?Q?crp/y0GFnRy/9U5NbHJo6d5gpkNqiyoGDG6c3N/8KW0F+NY/NogE6hemZTZe?=
 =?us-ascii?Q?y1Ccp7q5GUqOWixCwBMuEphTINeR2D4nsYJWKUNuTQUFg9wnX5wsb+uFgh/g?=
 =?us-ascii?Q?3mbqsluPHtYj5eg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:17:00.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4549e2e7-ee91-4135-97ef-08dda8f2a1f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

Patch #1 adds a new neighbor flag ("extern_valid") that prevents the
kernel from invalidating or removing a neighbor entry, while allowing
the kernel to notify user space when the entry becomes reachable. See
motivation and implementation details in the commit message.

Patch #2 adds a selftest.

Ido Schimmel (2):
  neighbor: Add NTF_EXT_VALIDATED flag for externally validated entries
  selftests: net: Add a selftest for externally validated neighbor
    entries

 Documentation/netlink/specs/rt-neigh.yaml |   1 +
 include/net/neighbour.h                   |   4 +-
 include/uapi/linux/neighbour.h            |   5 +
 net/core/neighbour.c                      |  75 ++++-
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/test_neigh.sh | 337 ++++++++++++++++++++++
 6 files changed, 413 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_neigh.sh

-- 
2.49.0


