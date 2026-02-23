Return-Path: <netdev+bounces-259953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IEAO/QcnGkZ/wMAu9opvQ
	(envelope-from <netdev+bounces-259953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:25:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA7173DB0
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B498D3003510
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7B1DD0EF;
	Mon, 23 Feb 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ip61FNNA"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055582405E1;
	Mon, 23 Feb 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838674; cv=fail; b=jOhOPF+FIsmUPGn4WKkv0Wb1r7spPv9y0eBIm8+SRuAl5um17SdDFvziij2CXpr6dvfQedLzIH3KS/qp7EYubINnIr1f1eY5uB7VOrcW3h+LCZySkZD7E1BPG5MqLwNyuqLUKvDy0zEMFb37zALj/o++R+fm+ZekY7jQjGgH9+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838674; c=relaxed/simple;
	bh=TyUQnLeuhsxV6dNdHKET2WBxA+zeXIIz29mQ+agaDUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNvXsCLTI/HGKHf2PYWQOvD0qxSxZjlTgrJT4EhxKSxkEiaH9kUuLJ1lw1Qd9Aq9zfGbbwKh1oKUUsQzQnck9JKlEHTQEWMlvTcxSNudmnr0tR4bbYaCWFN01IrGrGruCOJpN8RLsCyrGyAFM9hmkChT6l0V3aUq9ZIEby/LBY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ip61FNNA; arc=fail smtp.client-ip=40.93.198.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FykGVXJ/9vnMjOpI7UT6vs4qk+v29AXlOHdx8qnLfgqYSIpIFrk1qKd3tnIkGcOI6KaX6y9j3GplgCOq+9HUexAEHhR+UlZCVKik6wWYSjnnMAKP5cnfIh/wli/PB0cRxHgMLa7Lmt17PHm1XEfeFiOAL1Q8LtfZakPU5MUt13AmDDYutDVKoqwUHfVZtAyFidlAQcNCkDjnSJVIC1aze5whpRQylukUs/cMdKKnGoASiDKZoZr+FqAmoFtBHfbwj1STmCXjimUcLUv73/ngeO53EyoMMqkgyhVCswqnmqpdLPdvr2EPyZ3r+jtWMvA5R4ZDZ9XJE2N/VFyN0AA9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNPo8QGJAIxt1go8VE1Yde3N9znhv4i/HZKL5V12GRk=;
 b=jHHRNM5Dab9Akjljoby6faDMv/25f8kOjksiNpMEwcYKQ3IweERI68pS/E+oATkUkJzdrzop3xXm7bDoWYMN/wbAqLFm2CRvX7Ad/Yn41NISNST4aJ214QgjnXXAUs7JiKKVXEGrwrYT8X3PDN7bwyMiu3pZqf+rTOSMjIogcYKR7V8P3PYoCTnqEQmL0r9LjWi+A+W0wiIek75OoUCpjMv7bkDDcHwn4IK89wJCfE/ugTdVjkWuefGZ+K5VZuWWum2i2vgCDBYi6Of/K+ydJsbrMYNCzw9tQx37Lsn0kcKzdmEKVYbSKEGvF/6ByEsGw7xHpzClrMOiTixaqSFC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNPo8QGJAIxt1go8VE1Yde3N9znhv4i/HZKL5V12GRk=;
 b=Ip61FNNAUvkTJmxoSL3+jFmxLXYjg5tvmkqfio3CZaORdlnJA0GqxTNGBXvCckwY+Ri7n/mkJEY7cbZbuVGLGfce/otHs9F0oLvTWIY1NpZBF5wy/tKhTfrA20A62wAMSo/Y+k74Nexm+mlc2tckvA5TMY+cpAoJdpXUNGoYtmTdesb241yR6UuowQoIV7U5V/xcybCRI+Kre//WzZwKB7hbsotzbWGeM9+DVQ8iZA1pGBUC8ZyMSg5+Hf2SRIJl37ZWocIwZVJgDkQfu3RyBPJ6wR8CQvkhJB71+K5zdhbp9UgtvxzTnoKQSduJCPT3zT3GiTyjnpGEXlYHZAwhHA==
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 09:24:28 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8f) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 09:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 09:24:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 01:24:20 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 01:24:19 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 01:24:16 -0800
From: Nimrod Oren <noren@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [RFC net-next] net: page_pool: cap alloc cache size and refill by pool ring size
Date: Mon, 23 Feb 2026 11:24:10 +0200
Message-ID: <20260223092410.2149014-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 836b151a-b34a-4707-87e9-08de72bd57a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sr7OSc2DOFCG5suMyNU9n7qUHXdcXJ9EwKAg66g5h63N+Hrvm3gy8C03dSTN?=
 =?us-ascii?Q?fVBgR3JJRuyiaHX4JQoOdg5zVZxbRadUSmByboqLFi4PjG/i6ObB+Ztc/1QZ?=
 =?us-ascii?Q?cPoq3TfF0rjUTQXjwzanthnG7g6Ihveq16axCTAy3fK1dli9MQTt28LG+73X?=
 =?us-ascii?Q?KVeRrMguTh9cwTdIoSCrYP65f4GC2hWo46Romnf0XpNdoom96hfB6S1gkv2H?=
 =?us-ascii?Q?Q5y+vk+sVUDt2PBJ9p4RkfQsllwNG0EVgUFdNw5HZtJ3N4QrPpuMbayIq60q?=
 =?us-ascii?Q?C/KclwRlKhUfF6QiZQTAAZ5hcO6FXHOw7yiQ+L3Sg/WRcBQVse/2dUpVcaB7?=
 =?us-ascii?Q?2DOuo5NvVEkFvWl5aNeJSpoGTPgxL23cRdWqSZnSiTKeFrmQxI1xzt8H9NjS?=
 =?us-ascii?Q?FdYCw0ZXVDtTytP1dMjbNgmhmaZitHhZkHhP2o6Uk0D/lcm7WsveCHnC8tno?=
 =?us-ascii?Q?JareGkF8gNmz/Djb3BW7yoVshB2OiL5dnf0Kn8I7m7iriNCUi+1DYUtfWXqb?=
 =?us-ascii?Q?U8G947IvodZaHM1M0ExNuBvF73rab0aRqQHfTqCJATixL8DBQeXzJTt4Rk/H?=
 =?us-ascii?Q?fRK8nKMxYEmGWT3xKAkrjxR0AvSLy7btGNyVh7A4JSqaA00MseM/i7/cu4Zr?=
 =?us-ascii?Q?FopXmgEVwqgBj8BrnnyaZxRr7qIL7MOIeQcl0w05zc6DXTNEyfUAtOkHbiV8?=
 =?us-ascii?Q?XVdyzqApn8fm2EhuPVUKtN3d7uTDxLMvfL0rSTkmPW5RuRt4JUvM0BsnGFVe?=
 =?us-ascii?Q?ill1fu5OhBS6GG4SKRx15160INK2plvxWVxy6fPK4ZW0ziNWNroFkthSQ2d6?=
 =?us-ascii?Q?9rnVeSDgdRH5fUJrIg3VdAH6Ud7ytS8EW3RXx0yorFxIc8hktiAOpbmxfJ3Q?=
 =?us-ascii?Q?Mms8Dwie/QFrSmBvhMWR4aM4GCaaDSSJxSgJie+1buA/jXIUjRcygJE7WE6r?=
 =?us-ascii?Q?Tm0vzidpUl2BVYT35aLwi/w8xgHeQyT05OvIXdi1Rp5tk88l0ggwzgO/g/yY?=
 =?us-ascii?Q?F+jYitIXMp0azl5PakLaHBgUX6QHr3RYy2Zofasg735vzJNNgLwlt0312MjC?=
 =?us-ascii?Q?se33yYADzC/lyt2H56/ZhAvaScNzC6OEjQkA4X3bjCkUKZfZlEft6OuH8H/S?=
 =?us-ascii?Q?jx83oNmHmrE5GXw2np82rpR0kTt16sJ1Z1TH3Kp1G3KMOTHSco1SdPrZAnfb?=
 =?us-ascii?Q?OaCPfcsyLhRtthq/7xcux8X+S2loJHK2wxLPgOvhnje4qV++1r2rbHh8pxaU?=
 =?us-ascii?Q?Px/0zrrKjIn6E257oPZ2GvciqDpJG6jJBYGAfiQjcCRT/3Vnienx3onLx9Fy?=
 =?us-ascii?Q?a9pcevED7O9dC+p5PFdUWjEks/fl4iQezO2bQexDlM000pM7WHy4UegTcVMP?=
 =?us-ascii?Q?mE8BVImVx82oP20UjMP5GRKJSIyXI2QmoK7S1UVGZ1IH60ZHp1R7Z5CvODyb?=
 =?us-ascii?Q?5mO6ud89mG5PRw/0QIJ1vJfqepHGkF7tS6zKUkNL9mnMv23R7QE9x+7Vndzb?=
 =?us-ascii?Q?lrwoFm7i1JCSnZBRKX6QFByK8D3/bwpJVbssY4lquQq0HZGD1Odez1cHUjzj?=
 =?us-ascii?Q?tJA1HAO4kZmf7sFJbrkjbNo5X4j+5/sRRPx+eWlobnhEVnHkrwxXBCcwESVm?=
 =?us-ascii?Q?CvH69DHcuJScR/H17YUEOLDtQPU6WOjX0j7E4Zib+FcYMp3ygla6irjH6FXD?=
 =?us-ascii?Q?0WXr9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nX2U4dO8UM3PGotcVTDYC/x5OoZqH2MTmYgtyGcRTw6EysVgoi1QjWfuqOLMaA2JY20Rd77SjuY3IjZOSdLK9tszxchuzgTt4/1L3b9K0d4cfpad7NXdVOCXCCLfGJEPhogNk2GrE39giQiIu/BpWfNWRhfbABH4aLiBcG8C/gWvrZMO13YJQ2PRUqzPm9OlwhPD8huVsYk+UgBkbLoRiOz+XmyhqGB76fiXSD5931K2n5RAL4p64gFnT8pi7WSuPXjTbL4aM6ADXC/x6BTwjb7cGN7TUnkQFn1kRnxFJykY+z6rowPhC6Hg7tbWvGfiCKNrpEIp8a2idQoM45DKtbAqdUI3hLoIuwsoCB/ooJzyhHxo1rNLrHIoWVd++DnPnNjdcEUvkZjphQNFGaeknrwzga5UdZbvdVK1rGHqNDbKdJxajEsXAkIXrspcMMJQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 09:24:27.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836b151a-b34a-4707-87e9-08de72bd57a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6DBA7173DB0
X-Rspamd-Action: no action

Hi all,

The current page_pool alloc cache constants were chosen to match the NAPI
budget and to leave headroom for XDP_DROP recycling, hence the current
defaults PP_ALLOC_CACHE_REFILL (64) and PP_ALLOC_CACHE_SIZE (128).

This logic implicitly assumes a reasonably large backing ring. However, on
systems with 64K page size, these values may exceed the number of pages
actually managed by a pool instance. In practice this means we can
bulk-allocate or cache significantly more pages than a given pool can ever
meaningfully use. This becomes particularly problematic when scaling to
many interfaces/channels, where the total amount of memory tied up in
per-pool alloc caches becomes significant.

I'm proposing to cap the alloc cache size and refill values by the pool
ring size, while preserving the existing behavior as much as possible.

The implementation I have right now is:

pool->alloc.refill = min_t(unsigned int, PP_ALLOC_CACHE_REFILL, ring_qsize);
pool->alloc.size   = pool->alloc.refill * 2;

This keeps the existing relationship "cache size = 2 x refill" and ensures
that refill never exceeds ring_qsize.

I am also considering a couple of alternatives and would like feedback on
which shape makes most sense:

Option B:

pool->alloc.size   = min_t(unsigned int, PP_ALLOC_CACHE_SIZE, ring_qsize);
pool->alloc.refill = pool->alloc.size / 2;

Option C:

pool->alloc.size   = min_t(unsigned int, PP_ALLOC_CACHE_SIZE, ring_qsize);
pool->alloc.refill = min_t(unsigned int, PP_ALLOC_CACHE_REFILL, ring_qsize);

Option A keeps refill as the primary parameter and derives size from it,
preserving the current "refill == NAPI budget" motivation as long as the
ring is large enough. Options B and C instead cap size directly by
ring_qsize and then either derive refill from size (B) or cap both
independently (C).

Looking forward, it might be useful to allow drivers to configure these
values explicitly, so they can tune the cache and refill based on their
specific use case and hardware characteristics. Even if such an option is
added later, the logic above would still define the default behavior.

I'd appreciate feedback on:
* Whether this per-pool cache capping approach makes sense
* If so, which option is preferable
* Any alternative suggestions to better cap/scale the page_pool cache
  parameters for large pages

Thanks,
Nimrod Oren

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 include/net/page_pool/types.h |  2 ++
 net/core/page_pool.c          | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 0d453484a585..521d0ca587dd 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -55,6 +55,8 @@
 #define PP_ALLOC_CACHE_REFILL	64
 struct pp_alloc_cache {
 	u32 count;
+	u8 refill;
+	u8 size;
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 265a729431bb..07474ff201d5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -213,6 +213,10 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->p.pool_size)
 		ring_qsize = min(pool->p.pool_size, 16384);
 
+	pool->alloc.refill = min_t(unsigned int, PP_ALLOC_CACHE_REFILL,
+				   ring_qsize);
+	pool->alloc.size = pool->alloc.refill * 2;
+
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
 	 * which is the XDP_TX use-case.
@@ -416,7 +420,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			netmem = 0;
 			break;
 		}
-	} while (pool->alloc.count < PP_ALLOC_CACHE_REFILL);
+	} while (pool->alloc.count < pool->alloc.refill);
 
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
@@ -590,7 +594,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
 							  gfp_t gfp)
 {
-	const int bulk = PP_ALLOC_CACHE_REFILL;
+	const int bulk = pool->alloc.refill;
 	unsigned int pp_order = pool->p.order;
 	bool dma_map = pool->dma_map;
 	netmem_ref netmem;
@@ -799,7 +803,7 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 static bool page_pool_recycle_in_cache(netmem_ref netmem,
 				       struct page_pool *pool)
 {
-	if (unlikely(pool->alloc.count == PP_ALLOC_CACHE_SIZE)) {
+	if (unlikely(pool->alloc.count == pool->alloc.size)) {
 		recycle_stat_inc(pool, cache_full);
 		return false;
 	}
-- 
2.45.0


