Return-Path: <netdev+bounces-133456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D3995FAC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C6A1C21EA0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04B2176AC5;
	Wed,  9 Oct 2024 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwWIattw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084015FD01
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454905; cv=fail; b=cJeHlJp+9r/e5mXEkjVwKqi3qAlueUdZZ9kVVtHhDjlIxmXcgzmYveVubzXKHoGUc4t5iOcxTTSxGnsICRn2p8ja8MH4NXDpcAcNcKusuf9SvPKY+XHrUa1oXNLVY/Hr96iHKS0i245+/NE+bE6aRwXTsAK6rH9E37L+2btfdzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454905; c=relaxed/simple;
	bh=amzduGTaBUnHc/5RlO0zjr1Hp88xfHUzH/LXacvAQ4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brGLBUBQN/HBIO242P5uz3cIGq8ZlvlMVbaWyjRdyX0G9AKWZJDGB8Lxocw/cTXiEvsQKpGm0bnpsTcK+UqWWcYOCylPHUBCQXhQKCHgIVwdOBIh3Zz7SR6f8Fclp65gdykwG7wpJW+m65oByIwu+svUBVR9BMliIfHqwcM7uxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwWIattw; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAoeBDmdRvMahFbvwXFQjaM9yOXcy5RH4d1QyhU5Ra1PfVdaCn4aIxssXWXjkQFQxhZbmCuhBGd2SWJd59I6VBKF9yeeW0guk+ShM2tyzDCYt9Olw/Qw1FPDfx7e4AoANs2iWXnARqKo/RYx3gDihUMO6o+wKytwXrDm1dFqsOPdjhk5g9cTWtS2mMbtUozNIuIN8Z2owfScngJu+BsMpMdECzjgNq1g/w1FMx00xz2oNws2gvNdf6x9DSuPmGn4ja5/YtfeXf2uX6jcXQX0sYkUce3Cj8+5WehFEi9k4/SGL8X9UKBD3WViELno5QYC7X2eIcY/dcuQgElkaycP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxihI4kFrKlYMhIYJXzXA80jICeocdhSVDmrXD5XIBA=;
 b=gSqn9/zS9qCZAF6zzE+Wpv5VULT0fl2TgK4zazfkVz+A2ccii8mCFUMlYbK2BJVBoVZ2RiSm9LSS3FCVHou4o6+i/nAx12HymkHqUydcWDUi8Yl6AaRiLkeIgxNS1dbgD/WR2GxPKy0ZIpH6QPZ5x5g1fo0WhUcJpLqZKO4Gv8dKET6vQsiqt1g0k0t4/S3iZz9vNEsru9Vd5ubB3iGLJgKu+XeCYYChZFa0defCxtJ0LOEszjUdOBLmA+4bUlftYW2rmWwGgg6GiJopSMwx2P3RM2PVIHmrzeuM1EKlmdMUcvx8f+RiarOrASbKTBjj0yfziYog/tzSOOUIFPuMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxihI4kFrKlYMhIYJXzXA80jICeocdhSVDmrXD5XIBA=;
 b=hwWIattwfrY64CUHFDLgZEa1dZNKxnr4WdSC7oWiATKa+HM0Bs//tl0OWDA+bn4DL2UwzNTJHRZn0hXB6rYS/tk1U6+iiTijLZLMPMBokmy6c2zufcoZB/Kxxu5YeQ6MB/XN81mzIBi43nsXCkzwARaHtYXgIT6QuYTFTqircrlt7ikGnO2+bhqOv27kgRwKjkR8k4gBCVEAfDTimlF+2YkZrMsJFsh1D3uDGM7Lur9j2/ybfbPxg355fzRmShmyTbZRloK72eHBsUKekIuYSaN7Oc3ayHGjJIziSk5RWnmc5tliUci4H0B5/qFMsSr2wXU/D/H+9U9w33PBRC2iOg==
Received: from BL1PR13CA0170.namprd13.prod.outlook.com (2603:10b6:208:2bd::25)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 06:21:39 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::3) by BL1PR13CA0170.outlook.office365.com
 (2603:10b6:208:2bd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 06:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 06:21:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 23:21:19 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 23:21:16 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 1/2] man: Add ip-rule(8) as generation target
Date: Wed, 9 Oct 2024 09:20:53 +0300
Message-ID: <20241009062054.526485-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009062054.526485-1-idosch@nvidia.com>
References: <20241009062054.526485-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 6457aa28-232f-4bc2-41e5-08dce82aa2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ku+SNc7Off3sHeaimgPzCcZzkkU1wiYr/ZFB3+Mi9XjFBbu4iea0oANoaYA?=
 =?us-ascii?Q?z/JXJ2mY7oAoiX6ha+hKwPWVFWU3GwAXJ1B6iK6SuopLukOoYgAS8zeBfK0c?=
 =?us-ascii?Q?J4fGwjbKNdifaWaJWE2DBUjqE86cefH1jIKiAMvE5q6KyiCzrVKBBg43aEmm?=
 =?us-ascii?Q?D9ASVIWqLfXVdU4WeOMdo9LVPN+pn1podCRNFmsGUoZpxIPvaC294pfre1vQ?=
 =?us-ascii?Q?jtqZJ1sdHhAM1iE0ieMrQ/fCIM9ypePqaFA+JhMlcvhvv7TL2IJI6t9Xi2RU?=
 =?us-ascii?Q?DwtcHeF1judjnLR5NpXHVrsZnMpztzdRVcad1+QWlT4DmML+O0kAK5Oty4KI?=
 =?us-ascii?Q?oHSnUFyvP0rSpSlRNVZpY9B8vlWcr1zMW5aiqMniNuqFL0Z74gIGRXedfczq?=
 =?us-ascii?Q?RLia7FUJOuaOb9orwHByw3S+I3/sHxs4X0+cTHLwkb2Ede8KwFshTzin32iA?=
 =?us-ascii?Q?06yVUd5nro1Aw7uhIeTGs1jdj6of7ZQiJkM110rxiw5JRxkxtT645SpLglKm?=
 =?us-ascii?Q?APbcDEjTVK8SekuI/3ToQS6UF9bEXGELAuj0dH/1RYt4k3GGSrWqSBeyauv2?=
 =?us-ascii?Q?u7oxsmZHlYN69qAr6cTeBXkafu3PL9P5MbmgxHrFX4bsjMW36vS5nWGQW33P?=
 =?us-ascii?Q?JndPf0WOYv2ulseWkvqhh5yCp4/AyIkOW5hWedvTAWEOw2Id6umi04h70Mid?=
 =?us-ascii?Q?KwkUYLO5wMeVbAqJe+UmhtsengGBpRXFlvuPJ5OAdP5azhCtL98tlTSoASG3?=
 =?us-ascii?Q?AGbcf7CxVel4ujf8nhvFRSKVu9ucnKei53VpeQIEYdRZ6b7JZ6iDZg1rX+SD?=
 =?us-ascii?Q?A+lc5bwb1G4EfKrRIqqK/AjaN0HNT/G1oiXxwX6z6DLcnisGWraM+7oMBpiL?=
 =?us-ascii?Q?IkXHxoSz3AkH0jvrtCXPUf94gf8D0hLN86Q1IVnXAakghMagmGw3gojXEHZt?=
 =?us-ascii?Q?nX2cZGwDa6+VxuQVw6COxM95gWN3rL6RT1iTMM6rabWKbpPrt1q60ItLi9Y6?=
 =?us-ascii?Q?sD95GHmCmfoweYrbSG9rzjbw2D2D3anCbO8KOhzX78knXgSlgc2qzoF51JIQ?=
 =?us-ascii?Q?I23GqAhmUeVVhvW7tIj7wlzHCdJlaE1+WqPfv/Wx5XLEFKn0xn0lilCRuXKh?=
 =?us-ascii?Q?BJ2MeCr/7JErffcRPur7BrhNzWFgmSrDRA4tNEdNxzhEj9DwqOxd2rx7UOtw?=
 =?us-ascii?Q?OaiBrYzfUi9REUyB7H9Az9IcKj1X6s2mrbnSBu3yVWfpiKvAGDSzjU7M6rja?=
 =?us-ascii?Q?27u2KnkGtAqrDuSPZSq4Y3gpPTjABx14dOqgZcquSKZZaCAxVSEQmRbG62zu?=
 =?us-ascii?Q?VJsZ0APNNQSbEcUi1Z2HKFLRX/8+N+Aek3HNfVhi7SVvZUzE7M7qs0Xj5BOB?=
 =?us-ascii?Q?9ZZZhW0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:21:39.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6457aa28-232f-4bc2-41e5-08dce82aa2c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568

In a similar fashion to other man pages, add ip-rule(8) as generation
target so that we could use variable substitutions there in a subsequent
patch.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 man/man8/.gitignore                  | 1 +
 man/man8/Makefile                    | 2 +-
 man/man8/{ip-rule.8 => ip-rule.8.in} | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename man/man8/{ip-rule.8 => ip-rule.8.in} (100%)

diff --git a/man/man8/.gitignore b/man/man8/.gitignore
index 7b08e9114455..08098a2fb588 100644
--- a/man/man8/.gitignore
+++ b/man/man8/.gitignore
@@ -3,3 +3,4 @@ ip-address.8
 ip-link.8
 ip-netns.8
 ip-route.8
+ip-rule.8
diff --git a/man/man8/Makefile b/man/man8/Makefile
index 6dab182fa8e3..82cbe89f7ce0 100644
--- a/man/man8/Makefile
+++ b/man/man8/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TARGETS = ip-address.8 ip-link.8 ip-netns.8 ip-route.8
+TARGETS = ip-address.8 ip-link.8 ip-netns.8 ip-route.8 ip-rule.8
 
 MAN8PAGES = $(TARGETS) $(filter-out $(TARGETS),$(wildcard *.8))
 
diff --git a/man/man8/ip-rule.8 b/man/man8/ip-rule.8.in
similarity index 100%
rename from man/man8/ip-rule.8
rename to man/man8/ip-rule.8.in
-- 
2.46.2


