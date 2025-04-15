Return-Path: <netdev+bounces-182760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EBA89D4C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5440190056F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62C2951B4;
	Tue, 15 Apr 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HbVtkHHK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15082951B7
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719185; cv=fail; b=pSxOpw5FeYKbiBempUnenZRHXnk5ftfBrPSTrfBJ6rdjrt0l/hR1d96V68ry7nz34c9z1fBj6WuQt9neW5TW+WXJnE0s/9EQqkWkx6nJy16otBKYJXJPn1sWwLpwgzvb5rrXR7G5/slSgSdKgxVVk+mNQgyopVAqSg54XqgN9HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719185; c=relaxed/simple;
	bh=EnyGdWfmkvCbM9HIiw52Ym3rW0FVhv6EJrw8DUtppXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOQSoPyaQcjN/NywkBZUQjr5ZJ2bz2N//ZnDJ+0Usi019hpYBAT8RfAC+KVxOFPEvcZDZ5k6Kwidz8/eNrvXzFARsGyADVpPqxhhY1emVGcCAcXiGr4RiERM6eNvB2zHjkAsqK0JDfKHk8QKn3D4MtydS2XLbicwKFQUFvtH8OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HbVtkHHK; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYgiZxQ+WjB3yY+ORIeb8U90AsZwbf50b5QObUIFXRsRCVHbeiKvMy9rNfuoYOh4lHoaJQ1UYk9gAK+08bI7hYPWESER5Fbs/HUC2d/t/VXQgjPF/ramyXZPuCRhYj8l0jM1dPLWutq009bBmjheByLSP8LFqyB2IUt/kS5tgUB7pIcetrzTSnTV1FZSCse+hb6j1XTYseuuwqg4/uh2nKE7ksozgisyjN2SvYotBu2TWBVnVANpD79JiL4LHX1bTRqYUsrcefTCvd5mCXUU6hlAl4NYWsCoT7AuQj35+wmlhKy9MTusnmtCpEgkSpKZw6fV4OxWf2mr3O0NkPqqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cv695VCwDvwrZ81pUmYKSW2lCz++MiPA+PYD77yi+8=;
 b=n6rTDiuBZtN+mkU6u/lH5jwfGwQci9S/g+7kHyo57p3S1MRa7as2fDeyuhXdw/kVHwDzw7fM22TPA6wbWRBrTj2gy8tVAv04s9rxlED5NF+mVTiuBytOgn2NVqhNTpqE8e2nsGpwn5+6ZJFBDkrwAMjNSOBIxTRC7O7old2kRK8zndhCZB6bwqjE2aBr3bHeiltjiEdNSi/7esL4luoaaSq8tbcQkOTtmNhgXCk24N0wTMfbjNd03FKM3gtKZMKE9HdCqbt8vlKUvwEpgh1kmHBToy/MfzmMY1pL1dbCFJvaK6TW9C+nQf1EezNWuMqsEWgb8cUUr2nSwemEWz36jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cv695VCwDvwrZ81pUmYKSW2lCz++MiPA+PYD77yi+8=;
 b=HbVtkHHKw0iFdN2cQa5n7PDhZhhGwTh/+2Sez9UNdrvF1ouBp81aAe+5xXG8ag/+BIToV2Qgc9P1uduwewWTDs7jVQx6o6z9b9z3p3rHMxdsiBKpHmQiM/b9Z8UhrwQWm0VTsKEphVPopxBjZWSuYTtJTIwSfv27tO668FjQPctbXu5DjH1kQF+zHgpXxg2EOZ1IeXT0s8VbVkkeWx9kd6vBwgILs40hBWpu0bfxhc2KkeJs9YJ3jjfcO0kE9Tk7W1XyaUXkVQfFBttnHW73TNrcun68LDIc62RP9PxTN/z4sDcj1lH2AIqN5EoZ/S271xkJI0wpBnhS77aInw+eIw==
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:12:59 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::82) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:47 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:43 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 13/15] vxlan: Do not treat dst cache initialization errors as fatal
Date: Tue, 15 Apr 2025 15:11:41 +0300
Message-ID: <20250415121143.345227-14-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: eff30de1-c2e5-433e-aff2-08dd7c16dca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PE9lOOG/5WfqVouCIKGBgKVselVpZV6Az7UOjtNYJ8mv2ki5seVVxo+GiQLd?=
 =?us-ascii?Q?Tz0OgKIIVCvoXhyq84IEmSqrVLfhkYlzWgox0axoqn4wCJ9Rz2kkYMAh5NRH?=
 =?us-ascii?Q?hLgnooa+raQeoEDbPF4KtNdiyLVEyXmltMGHLl68Mf4kaBh3z+cM5vbmdhLL?=
 =?us-ascii?Q?ouYYMBEK0m2ZLJi4LZG1oNPyhtfr2gk4586jc/5M1FVnWoo8Y1knTZN16HYS?=
 =?us-ascii?Q?uccmKDcZOUaPpx8t07me0W/gReVKq5RZ0Vndny02COxOSGC7NkSiWAByu6xQ?=
 =?us-ascii?Q?DGQ+iFRktGqgVG9iFv0khlgZOvhiElzur1+F7NT8BTfQ1naL9kKsNIuUeCQP?=
 =?us-ascii?Q?88IjcN/T4t8YsvlQR2KvHD9vu9CApyJWdt0F3h6/5kXVH0DzJQQXfZriBXna?=
 =?us-ascii?Q?pWVvsLGb9FNbSEKmUAEEwmnJzDLNKWvgmZ6PqAjY6b638DD1/b2fYNoZBn7o?=
 =?us-ascii?Q?UWMypHACL10/7fAkkJyqokcNwI89HlarJoxBd+0HvXBo9N4dgEi664DuXopx?=
 =?us-ascii?Q?DIXN9LvD1r3Gv/dYJZpoj2L58FPzNRjZa+nLrILE9REuO6YlBbh/l2XbyR/6?=
 =?us-ascii?Q?Qx2kir9SiU2rA95Gg0rCwJR57AA4jClkS2p7fDU29uZvn9/Gzv/a3HG15x3a?=
 =?us-ascii?Q?jaunb56qqCAaZtW36OYgwPyXQLdS5AxRAA5fdHqm/0HvbSbZgUPAj+60UUlV?=
 =?us-ascii?Q?Gt6EG0ZW85NWaWFrL8fHuOBu9m6ZH2eAF1YbZkyUu7RM0kBJYKdWSf1jtBp2?=
 =?us-ascii?Q?gJVOVmgghCMdVG0aBKEGYiTZlwHM9soZVKkIqkL4IqhX1emZ+pEYX2oddYAa?=
 =?us-ascii?Q?ig8KhGYyahM2ZYdHOrTWnKPD41Ttfs6VK7iGGJv7G6ZH/7Vixdb5NmYZGCxT?=
 =?us-ascii?Q?Wtj5VebbqCPKcmh2fpHSeV4FGGif+5MBf0qAs0L9qQ6vJj08A/WKReAvHxTp?=
 =?us-ascii?Q?wxu38XJtDtuDfSN6CFS7VjTGIZMVPFgVZJcHdjRaYgiw5Qzbo+LDV2PmJLdy?=
 =?us-ascii?Q?v9ITP+dtktCKkDf1Qn2q7iU+Iu0Wyt9V/n2Fl6pzFrdhJFLhB0rVvpEjRxwk?=
 =?us-ascii?Q?bMXm2H1AwmQWR4NdkWwjbh0LRYKAnt15G6OnFnMt/ysccKwciCnnN8T7b8LL?=
 =?us-ascii?Q?9o23YBHyrlX2etD44VQeMitb2qFcDtfmcABVpoDoxFeSZh/IhKb6Wuj5idJN?=
 =?us-ascii?Q?BNLtN4a+qhm+CyiGnES0SYvJjD/y93BeKiUvRbPyiBBPYaJfqKInUDUr0eXe?=
 =?us-ascii?Q?T4mhHMF1FbTKvmAedRxFBCv+5f3qarzXZv0G4NdF9sTEW2BJo9MMDDL0XPjW?=
 =?us-ascii?Q?WEYuAxoqZnTlye8YNPsGqqehWuCBr7rGEGbz7xgvu5p6leVyN1ImkBllKozE?=
 =?us-ascii?Q?NXM1uVcTLBvYLVGfMuN+avSlUjTEG6+oXbRnLyRjfAUizDnhA7ZpSF/F+e5n?=
 =?us-ascii?Q?7zzewtlERANkmPFRszT0klVhZSrgwmxoGDii+ZemuDYkPkC2LBSKu4ibr7y8?=
 =?us-ascii?Q?oSg9VFEA7z35ZDLBoYqoFfKydItWTER4v+/u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:58.7614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff30de1-c2e5-433e-aff2-08dd7c16dca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238

FDB entries are allocated in an atomic context as they can be added from
the data path when learning is enabled.

After converting the FDB hash table to rhashtable, the insertion rate
will be much higher (*) which will entail a much higher rate of per-CPU
allocations via dst_cache_init().

When adding a large number of entries (e.g., 256k) in a batch, a small
percentage (< 0.02%) of these per-CPU allocations will fail [1]. This
does not happen with the current code since the insertion rate is low
enough to give the per-CPU allocator a chance to asynchronously create
new chunks of per-CPU memory.

Given that:

a. Only a small percentage of these per-CPU allocations fail.

b. The scenario where this happens might not be the most realistic one.

c. The driver can work correctly without dst caches. The dst_cache_*()
APIs first check that the dst cache was properly initialized.

d. The dst caches are not always used (e.g., 'tos inherit').

It seems reasonable to not treat these allocation failures as fatal.

Therefore, do not bail when dst_cache_init() fails and suppress warnings
by specifying '__GFP_NOWARN'.

[1] percpu: allocation failed, size=40 align=8 atomic=1, atomic alloc failed, no space left

(*) 97% reduction in average latency of vxlan_fdb_update() when adding
256k entries in a batch.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2846c8c5234e..5c0752161529 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -619,10 +619,10 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	if (rd == NULL)
 		return -ENOMEM;
 
-	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
-		kfree(rd);
-		return -ENOMEM;
-	}
+	/* The driver can work correctly without a dst cache, so do not treat
+	 * dst cache initialization errors as fatal.
+	 */
+	dst_cache_init(&rd->dst_cache, GFP_ATOMIC | __GFP_NOWARN);
 
 	rd->remote_ip = *ip;
 	rd->remote_port = port;
-- 
2.49.0


