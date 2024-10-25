Return-Path: <netdev+bounces-139133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83B9B05C4
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFB21C22BA9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA61FB8A2;
	Fri, 25 Oct 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MUy9Qhjb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B81FB8B9
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866434; cv=fail; b=GkqfvA04Fs/ermYeUm1zxx1GrVrzvZeJoYHpEC3KtXPy5Rv5c/emDXgF1nvzPdiBtUEPCIuNWeHYbIR5rCFEFCU1LUKfQI6pd0d5b3SZAMUfY/ECRnTjqMgmoEzJ33S2ZiLz18ab5JgU0AEH4PRDom+QDWCWJizGnNeMo7v6dpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866434; c=relaxed/simple;
	bh=UWQFpNS6o4StIw/0M7qsNrSZp0Rlchhc4OlNocJSZgs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVQK0/I9MlnS2m5ugCxVn8CzarR3dX0IvzJ9pcJwJ7U+XAgk69Gk3E54Co1uSvfPG1A3xIiafwayH8B3WfmvAIOeg0NPCt959cGG8uED+i/tcgqDXrDHRwtE+brneD3eiwNtHpHOSy7a3+tFTyG9S3DjS29/VwmYtpUd9CcuddQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MUy9Qhjb; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH9TBecEUBnpuR6eFlY3JR3oolyUyfhZGTUmHTG4RIODeRyDpgOR8r+TiNZROl/1VCXOib7x5I45dtuyIvNAQRpOzGAwloQ/HWRTrV4vXdka3omKoJQeK9UwkX/UlGI2PdK6YIwwJ5Xp1fXkqhI5a4bW8a+OpT+fwsCnO0Xo2ySd81Ev+nFCuOFh6OGq6QRQWyHdHBN5uh+szvxEGa7Gh/j7ouq4H+8JzQjYpwx0C9TxRRN+gkRCJwIhejhkTDulYFQYKeKvpB6dA9khw6ir3FHOQdQii7zbK2A7lMn+obIVB5XePznWD7KEqCQYsmQ1JLMjBB3EgvLe0ujkURyaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUa67D3cq6QEsT9SNA8bXigYLoHRdO3xoAAh87Ot040=;
 b=sxqn+hKt/u5zRogITj2kyc1w+RFqoienxdNKMZMWknbw05v2Dp+ixGoFJqXvHD4aceVUL0LnPWTPEzJLN3Y6iKqLNkrT53Q8P1wkXD79S6mNdWpRzrH59aTR1hgkfYLNhpU0bpKkGJexYdheyirNnJxdBQUQZst7DWw+mj8GYDSDqZvQx0WjSJftzOV7641Z8fCBk5miEQ11W7iyYiDpS1reRIS8FHYu6keULuFhCSnLgcGjjUbrhEEQW6oOmWcCDPRtQfTqM9HjFtJdmo4tDCEqe76kRi07eVLOF2z9vsijnInmUng14puxEZkJznwFvFVvTTcqKq7Yq/qFCCe+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUa67D3cq6QEsT9SNA8bXigYLoHRdO3xoAAh87Ot040=;
 b=MUy9QhjbnvE+V6RYQBsT7c8GH9d+HU+LystoSeGE1p3dEotig9OXtl73gcdGKNzpFp04Zh602KngpIUlnfuKTkhuegT/YdtH0YRjGfV+Dj/fXKo15DI3E38p6zEqR8oKV7h/0ZPzUzvkcvj7xcYrhwFjMXkuRNlzyQoOw09kTHjuW7FXfkqfKGvxb1r1Pkm98gPg+9b+hVQIdPQw+kNDaLx0U+9+dUdo5V4d9FlSjARC7yd4PUbId8dnbqySgdjMT4dNN4pkDNfEEjO8MqEyEYrt7zPBXo0eQW42Jw/59N9Vr2utfgwnHTFUNrAEH0Lk5sWfkiWUjQPA7NQ7WaBptw==
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 14:27:09 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::f2) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 14:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:27:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:26:52 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:26:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net 0/5] mlxsw: Fixes
Date: Fri, 25 Oct 2024 16:26:24 +0200
Message-ID: <cover.1729866134.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: effb21e7-e48c-45cc-a56d-08dcf5011bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XyAXwrUPH4RYKsBdkJW+bJkW0nBuqUtBu8NNA9zj0utJsAKwKl3JH5gy5tzE?=
 =?us-ascii?Q?NaOlM/MJpFlIBOZvdhn3+rgpqdJKqV8JeQk+k5/QpPNFd7VVb0UYHgK9/yDW?=
 =?us-ascii?Q?d4uwWlBmZM3BtF0yCbW4n8gqM+W69donwU3BImk0RckynYLgSXJmPFzsaol/?=
 =?us-ascii?Q?On4gtBeuy8cnxAYeBstgAqxAlEW+Fe2mhmvXuytJOyQxpxQehEeuvBNLPMv5?=
 =?us-ascii?Q?+d+/I7O4IefctcqSMMhAKUIV59T4mPnOhjYVE6u6PLTpC80/wjlUBqMmGnCi?=
 =?us-ascii?Q?Ft3svVVOyFdT8pL2xmpJb+vexyC7WhFNJ2wkJe5imOy1+feYULDg3qaQxRId?=
 =?us-ascii?Q?qpjVeQ4Oa0UEHMoae5b7M4SZw7p5PXDD9ObgsAzZ8A/fyNTIYROZH9KJXGiB?=
 =?us-ascii?Q?3S8w2PSiIz9gwdRVtLsLnddoqmxj+CunamFbLgEMqlsIN48LeFkzMckL4AF1?=
 =?us-ascii?Q?9gCLmtnFdvyKkRfItiUyMaxg6AGr7UrM8Lce9d7+8ZGrgTh4BTDw9qzxXd19?=
 =?us-ascii?Q?CupYXqsE8RWssv5btsyUADX4pKpM22RBtpCXejoHxyJr+DfZoUEx5yZl+Whc?=
 =?us-ascii?Q?rPaibOc/bFRYNEoa8HmCiPZuocb/OUHjSg+eY8rdPlyjQEWKfTb7lbNxJscZ?=
 =?us-ascii?Q?8XMknepUX8GU61QGBPdFbbvjyWvH82m64r7JU78iJepfaheE4BmCgjSZk/hH?=
 =?us-ascii?Q?9de6Bgn+AFoF8uUMkqwGpXQvZyMsJ7EBmanhwhLife0CI938jprdsMloZjQM?=
 =?us-ascii?Q?UOtRNXoko9Ti3Ctr/5iDXhj9Mv6WoZkEhbnx4yKksENiRorcJLuQ5znabnhG?=
 =?us-ascii?Q?s4h4+qqSZ4yUuLu1Xc60UnhZS+UCIn0wPndttLKJI8ORUupMboRuujL7oV3t?=
 =?us-ascii?Q?U4YRdyqrc7wPM+cmGO819VcRWos3RDq/7znlM2ZanczzeySfhE7y34TRq23V?=
 =?us-ascii?Q?WHTsFo7amjBxnbmn0YU1BL5X5Xuq/+t0Bewe7aYhW45fwUAaFa9dCeWT2W6f?=
 =?us-ascii?Q?mL0aw4nrS0+vuxzP6nJae1J+CybCEoFzq9FA671JsQypE0eLGth31CjHxQgx?=
 =?us-ascii?Q?7Kb8bqe2vyowNd68+93kCt485rHsP+ZWl5bzCRQ3KV1xynVrQ5UQnqPOHvXf?=
 =?us-ascii?Q?yL7oyGBy9heGcr9vn6m1vkj26DFY9/6xGkku8GWC6d/f09un8eFTiNpCsua5?=
 =?us-ascii?Q?Ih1yOCaiqfqeYUOmX/L5QcErmbAGxv8gfey39CDoMGFAgZGmZuPKc2fA4OCU?=
 =?us-ascii?Q?2gwh10j7KZWX+wRGfxZpz1vJu1NGkHDbLYPWMHPPtjjpW9R8fJvu6oWhsUW4?=
 =?us-ascii?Q?4OBieJewy2OkvtSHB+jBim/XDdt29wtG3i1TwXEg49tMWtvVkEBJwUTcuRuu?=
 =?us-ascii?Q?7xKp3trWSC0TPzFZgckVlNFghapB8aTyeM4dH9W112/XhgZJSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:27:09.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: effb21e7-e48c-45cc-a56d-08dcf5011bec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

In this patchset:

- Tx header should be pushed for each packet which is transmitted via
  Spectrum ASICs. Patch #1 adds a missing call to skb_cow_head() to make
  sure that there is both enough room to push the Tx header and that the
  SKB header is not cloned and can be modified.

- Commit b5b60bb491b2 ("mlxsw: pci: Use page pool for Rx buffers
  allocation") converted mlxsw to use page pool for Rx buffers allocation.
  Sync for CPU and for device should be done for Rx pages. In patches #2
  and #3, add the missing calls to sync pages for, respectively, CPU and
  the device.

- Patch #4 then fixes a bug to IPv6 GRE forwarding offload. Patch #5 adds
  a generic forwarding test that fails with mlxsw ports prior to the fix.

Amit Cohen (3):
  mlxsw: spectrum_ptp: Add missing verification before pushing Tx header
  mlxsw: pci: Sync Rx buffers for CPU
  mlxsw: pci: Sync Rx buffers for device

Ido Schimmel (2):
  mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6
    address
  selftests: forwarding: Add IPv6 GRE remote change tests

 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 25 ++++--
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   | 26 +++++-
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  7 ++
 .../selftests/net/forwarding/ip6gre_flat.sh   | 14 ++++
 .../net/forwarding/ip6gre_flat_key.sh         | 14 ++++
 .../net/forwarding/ip6gre_flat_keys.sh        | 14 ++++
 .../selftests/net/forwarding/ip6gre_hier.sh   | 14 ++++
 .../net/forwarding/ip6gre_hier_key.sh         | 14 ++++
 .../net/forwarding/ip6gre_hier_keys.sh        | 14 ++++
 .../selftests/net/forwarding/ip6gre_lib.sh    | 80 +++++++++++++++++++
 10 files changed, 212 insertions(+), 10 deletions(-)

-- 
2.45.0


