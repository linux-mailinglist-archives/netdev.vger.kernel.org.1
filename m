Return-Path: <netdev+bounces-167761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA15A3C244
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21533AB308
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7E1F1538;
	Wed, 19 Feb 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AahImyHF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C31EFFAF;
	Wed, 19 Feb 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975624; cv=fail; b=gJoYN2CyKsUPE+ZCJ6KpaXR2jDH5YfHBrur5twdCE1rFoo5hrTICA41fidNcE4XqM24lNoMg0PgAUFQlM5P2LW13PoDVz77ZiklZXq7h1MSxjcw2HDOxsWz0f5tAa+Q2Lj9B1x9mSxeYBL2CDgMdBSaSbSU3FfKYGKf8pRSoLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975624; c=relaxed/simple;
	bh=ElRNKU09QWVHOohR1o6nwrFALbloe5GdaMwIz53zQSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KXq60cjikhqb0bTlcXSQX/NbUHyqtXMJALsJ9gocMtb9ecQiKrAEF3IBMius0qLrdTefiJU63P/jLsFAOdW8TDZdxOflw6MIdr+tudFEeekUMBpvCgioK5O8IRc7d3mX73qJWFF6cYqh5ELpaw6joJ1CC3cYwrjZWRzhXBQV6yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AahImyHF; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQlpHx01CNh68s9Fv+DjA+rLsB0u/vlHTlUTTE1p/VX2KGPyEYv1KYmHtF/Dz98QpmGAv90JvQtJTF9O2E6njiatXiFOGCGkNsbHnDHUx03vWLe6x60o3uc0onrVMy0PFL+v5YiMCb+1XdBlWanVQLxNw+eiUMeMDfkDGz1p1fQAhT78vbCyOlj3yE6QZtbtk3luUnDCC1xK8TaaFBRjyjeyG7obz+cLFIaUGzxbOxJVgVYmQKf4sFKcNACUX3X/GfKf0eBxwovTqHDpo06aI0iSQ62rkpBs36thkFZjgKs5B2jzLiCKScP1EjX4+55LVHh3hQR93RhXkw4N6lJm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p6FmL4yD6x5cvVVvBE7+PyN8EvUAYasoA1jh7787Jw=;
 b=tBfM92Z237pdpMpxGWOBUwD/huGorPML9P0Wi+6QPrkHW3SLNvXFTLE3SiVUQd4mM6LS6tKqFxUzzCoRcYfsDbR4C0udTuXd8BbKnS2hGXWtOd70Io5YjRc8IuAdm7TY9O1MKXwaNtzHNrD/nZZwjzq5EK1c/wRBz3ibLZLtl0D1KRQYM5f3bGYXwmSQ9cwdnT+sEGqCU2b1yolWc+DvKoOSB4ArbNqlWTt3y2zB2fVvfpowJkJ8/zXEZdgrsUgAyrvyPeo9JdigQNxDpwTnUzM8pIiBcBTktPDHMEkCEC07hKW3OVCaY5HagrTB9MqFayv6ZvYWuU8aBoFICFtOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p6FmL4yD6x5cvVVvBE7+PyN8EvUAYasoA1jh7787Jw=;
 b=AahImyHFFsNEFhg+vuJcsFJdfHtM89ZNOvO6NaXL1fSc0dSRMVsHIXbDzk1rk+IyvCVcOS1dBd+BYkd5DFHNto6vy82LmiZ8SAJ266kcfve7zESvOKh6eEezxCyTLpdbYBtasEKfrzjYKar3G9we5PmhvrCV4ALbcv0zCGhLFa7YHvhnwl9zTCza7mUGILFr7ApTShvqv9Jq4Ool6+hoXSrkmrw/w/92Gcm7dn/88frnDLBqe7KXhgg62cXPbrIcdjcjEwwiF9Ggo7aqNpyuQg0T+H8Obhk5LM7qPy3xZxwKq4DBAdJ7Mu0cCuQdPqW4GIDvNzgstNS39wV9rYPqbA==
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 14:33:38 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::49) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Wed,
 19 Feb 2025 14:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 14:33:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 06:33:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 06:33:05 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 06:33:00 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Pravin B
 Shelar" <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <dev@openvswitch.org>,
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v4 0/2] Flexible array for ip tunnel options
Date: Wed, 19 Feb 2025 16:32:54 +0200
Message-ID: <20250219143256.370277-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb972a1-379c-474b-6a85-08dd50f2664c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7i33WaXJPkzqE5UxrUHm5BdXmLwJB3aVl4DuEMrZd+tSGe2+rKOp0oIaw6er?=
 =?us-ascii?Q?nOT2bmTvfo28KytiWcUynZcFp+8q6jTz3sSIjPekeNZROZoNAU0lMdmErrsE?=
 =?us-ascii?Q?SrNjOm7auxsK5XfFNEe+5az3YVZgYc38nNO+70eZXYfhHksNJIxl18Lsj/MM?=
 =?us-ascii?Q?SFkKUb7NoNHMk8AnfJ2iUQsOhL731Wg3C+MGa+5QK7lLVvRpRFIBUanWCq5Z?=
 =?us-ascii?Q?8qslDmxNZK6iVovm4a2cidP7/Mqg6B81TRhHYxl5hCSea2GGUVenKraKT3h/?=
 =?us-ascii?Q?QwChj8ueP6bv6RIK3dQZxOTghF2gZNlNb5cQn+/JTpgPSxcrJaVPhEISPhcJ?=
 =?us-ascii?Q?ah3j+jVkWHdB6S+VJT/HnVJkXhBVwqXjFEWonZESDd1FgSEILzUsI98zy0wC?=
 =?us-ascii?Q?q5EfmsjKRHocOUqZ9CLCYMG/Zghbl8NI/xTzmOBUA1IA4Uj2zhrvfHrxNtB5?=
 =?us-ascii?Q?teIvx4LtL37HLNeNBm0b+3haN9q+HIKRQs/gtOyag5mcrGhCcJnw7iXBnYre?=
 =?us-ascii?Q?cmKflHph0I3VlQhHaRH/JrsrAhDN4Nl+wbNjBKLDxaulTEQAYKdKW+qRvU1H?=
 =?us-ascii?Q?8hMWfYzq0w3hXTtS6N4wNpakTFs6FxCfGujyjAzCew2DCDqF6WTVWHAMPb3F?=
 =?us-ascii?Q?uZnyhOiKceb6XQ1Y3v/1vTizeM5si/BSTj9nCCYK5Xt/dKt5jeFaiNRNwf4N?=
 =?us-ascii?Q?0pgSDZvE1y31ljYDwSlnJnE1pgDcGw8//rX+xnqw0MLR//1XgCnw09ZvJW9A?=
 =?us-ascii?Q?mDtxnQsQskJjNGek5m8lJUsyqKMndldgsqEOzC/o4JDdS5txrsFdXl1v4kQ0?=
 =?us-ascii?Q?ripGv5EalZN5797QkS2s1lI8407Axd2xHuT/b2A7foBq95T2tiyPweqmIMwz?=
 =?us-ascii?Q?s2MOp6+8DfcMF6jlTuIvzy12xUcWKTHI2Sm5RotxWj35DZs5lEmxR9/AJ8sB?=
 =?us-ascii?Q?1hMFYtbgE+QURGtLxlU1yW+s5FllBDLFL4nk/OWr0/7irtV+cWgURN7oGbch?=
 =?us-ascii?Q?mFXgvP3MRDKDi3dPlunk991TxFrpZNjtlSMh5qgVzDyisg83rvGrj49/a2qY?=
 =?us-ascii?Q?Zj1GLp/RD14nDOysW/AMUkIWUh48vjq1faOuXfNnM4sLH1XRVdVrKsyXBz+D?=
 =?us-ascii?Q?yGLCJ8eGy63ZeDjDeQB9HsPSdshpaoSXfwsjClVTpqMix9DAPRku0vKZwYZu?=
 =?us-ascii?Q?KxUhLc1PqRgmk4ID4MkSKlDIX5Kdn4Y07jgEra1X6+aRyJqcfct7re2fSPTA?=
 =?us-ascii?Q?x3K/TOiSFsKsOJOAc2xC78IMLL2IXIaIErToyB6IrEIFyCunH7t5THQDDvjZ?=
 =?us-ascii?Q?zvCwyY7xmqQBPNMJ4SIoCWwkIAjbaS3n1mkYL9u7hnXzsAYouzM8++Dq1L9A?=
 =?us-ascii?Q?xUYwKUr1ci8WXHG09wdQeI8psxhzHEP0oI5aqR1Y9au9R5mIkVP6QuT0GiiB?=
 =?us-ascii?Q?RnK75PEcw4nUdDXyuEN+ottsihwZx/tFC3jb8juoGeytS3cLKarw2Lx3Ivx9?=
 =?us-ascii?Q?IDLVlW1P18vTXkE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:33:38.3351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb972a1-379c-474b-6a85-08dd50f2664c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

Remove the hidden assumption that options are allocated at the end of
the struct, and teach the compiler about them using a flexible array.

First patch is converting hard-coded 'info + 1' to use ip_tunnel_info()
helper.
Second patch adds the 'options' flexible array and changes the helper to
use it.

Changelog -
v3=>v4: https://lore.kernel.org/netdev/20250217202503.265318-1-gal@nvidia.com/
* Remove the casts in first patch (Jakub).

v2->v3: https://lore.kernel.org/netdev/20250212140953.107533-1-gal@nvidia.com/
* Add a precursory patch to convert hard-coded user of options.
* Keep ip_tunnel_info() macro (Alexander).
* Use __aligned_largest (Alexander).

v1->v2: https://lore.kernel.org/netdev/20250209101853.15828-1-gal@nvidia.com/
* Remove change in struct layout, align 'options' field explicitly (Ilya, Kees, Jakub).
* Change allocation I missed in v1 in metadata_dst_alloc_percpu().

Thanks,
Gal

Gal Pressman (2):
  ip_tunnel: Use ip_tunnel_info() helper instead of 'info + 1'
  net: Add options as a flexible array to struct ip_tunnel_info

 include/net/dst_metadata.h | 7 ++-----
 include/net/ip_tunnels.h   | 7 ++++---
 net/core/dst.c             | 6 ++++--
 net/sched/act_tunnel_key.c | 8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.40.1


