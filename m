Return-Path: <netdev+bounces-162599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA316A274EF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626081646C6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7CA21422F;
	Tue,  4 Feb 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lhu44r3M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E213E93
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681002; cv=fail; b=j1yEc446+1OoZ4gYy/5GHz8hajiT9iXnvZ+c3THc4xQ7WFNQ6G3C8k0h2/5D9y/P3p6XCTASxiH5BPsL2dYBBtyvudou3ZD/3GW4XQpY8xjVcBflDek8x7TBf3YQ6AxQQIkx844pXdkFlmab4Q2rgj2UwrnCTw3fDmtEagjdANo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681002; c=relaxed/simple;
	bh=+krwwr9dQo4AKkodO0sEHk51ZhtS9g/ol+wU0rTafy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itHyy7EULM8M7fnBR7ypen+PFJD3CaTsBGliv8QyVOMp54S/QbJOlLx/TOfz87WnSXWp381XWm3blu4TZ8iN/Wudua2W7VT+OyHKYaYhv8AOnue4FWg464ghyUnWAR7t67Fxi/pDbMur4ih0B1TVJwvSHlF8VR+9W00npRzhFE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhu44r3M; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ+2ogpykxGfIXTyB+KArttCHoDdo4GFKtXMPNUr81HZ4iNCzl0hv+QwKCdKwqKMUGQJ2jmeUhifU/bXxXs45IWLX28NsMPdzhLZsgJe1YMkc0NNM914svdExEGjHjkEOlMQoWsVkHFceP08zRH6FlPt/oOEf64GGXNzZma02I+x9ZCkXVkuyQsx9aJhivK81+7wctxZSJQ8t5isacU8KXisN0jDnpFtEjOWpbyT7Yd54ohxsQwhv9P9jIiGt+LWarNieBd3k4DA+HUeanJz4RjsvshSNRbKcm33PTjHik4z7ZWwNi/kPwuG/D0f6QBb4+mdwUJ/HMRnFHTIXmKTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owb6/SPja6g/rrUCtNGbPG7QitmibSkv3zSN+2V2j6M=;
 b=nSl2AAT2lIVkOn+Nwe56v801/Ry1DCZSTzOO3ZC+Kbyy9xy/1msHeFSrcHdg/LYIczJ86HAoHtCJ1A6hyIXrtkXAKbnVTA7QKD/XeGkhIJeyuymgWwtyuyuXqEPUEUHMGWu7q1le88EvHWr6IFtmLUqdKP2k/CFj/z9oN2LSdgKESsJkjN67oYxsR3FRuI+qDzfV6Xj2Eies7nbYKrxc1bqQF6QSrwvgmpqEqlymRLXH4m+Oxl5N/KE/5jvKrHad+aQY6wOR9dZwofnlicl6e2oYFd5xvmYJz7mntTubFVEcVkiFJlX6d3yLwtloHEtdod8GoJ/L9dxk8N8MVnPAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Owb6/SPja6g/rrUCtNGbPG7QitmibSkv3zSN+2V2j6M=;
 b=lhu44r3M6VGbkTKi3auGCzt8iCq0b47971yiIsHDLd0d3hgWhYxvj8mmlN5NU2wX8rtdjS3YYg7dJbAgVoYXlMT6+gKfJ15EbR5yal+SWTsBZwLxImVJIHQJFDZKswLqw51oDKZ4Cwr1alxQsuIDcffnp0JfoO7UU4M7UFt1ylW2DsqRYkL7EEK/S8y1sdNElEQMuEZ2/sQajcIY2m168ZU8NwxzT2+Sh/EAlgpR3hMArkgM7VU6Qt+5BTqfcZ1C3M2/xrOVLt3TdwK3WIIx+GOM1U42kV+qcFN1m/9YifA8beA7PV0IUl44gCyoEXlQPPLNv4UyWq8XZmJ31e/L2g==
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 14:56:37 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 14:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 14:56:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:19 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:15 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/8] vxlan: Read jiffies once when updating FDB 'used' time
Date: Tue, 4 Feb 2025 16:55:43 +0200
Message-ID: <20250204145549.1216254-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fde0ba-3a5f-4ca7-7c18-08dd452c1fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ng5ZWTGgTFwm0wujUItUMC65Yya/TwNmIwIrdQ2FfT6nRzOsmE9nnemnJcIU?=
 =?us-ascii?Q?6Z8Dr56I2/ywQe3GrlGHydQPU1oOoakOxHN8W7/8MaNH1vhbx5dP3WlEadxk?=
 =?us-ascii?Q?vXK/sK257YpdLtTzSPbehtqif/0Urjn6uJaQGtFbhFu3PLc5JHxDMu+HsmUo?=
 =?us-ascii?Q?3/BfOPqFqxXjcNPfsr591HXhFVw/Q1+zVaD8Mvda36AZuzPDYMi0Q/eB8zuX?=
 =?us-ascii?Q?T7CfBw9QiBoSCutQH+mRm/pvwOekt7uqLG0Pp7RMNp6z04niaB2nU05GNXsC?=
 =?us-ascii?Q?LNezTq3zFM2eDgy1GiPXyBnEuYLkwVchd8WQAyaYax1jzPL29C2wsCVCXU9w?=
 =?us-ascii?Q?dJHe2ol/zYU7j6XKObxfm8e9Wb2ucRxIY+ZMqgxsQxfRVjHflxauV5vj6+k7?=
 =?us-ascii?Q?JKN9cgOEA5aemjNjsYFgsVCoU5+DBjnjvkD3XSIPkO2w60bldqHbEdEd+ypk?=
 =?us-ascii?Q?E3/fyYuqbYur0iiwh4f3ikhfO2vZezTqkd3sCxjJTJfULngeyV/PS2/qbart?=
 =?us-ascii?Q?3mTY/DtZ9nKpNc2V/6/RRAtrPpGp2faukE7Hp6GFiPJMqHtgqnVsPDKNFOv9?=
 =?us-ascii?Q?1umXNmeCrDgkuwtLiolbfklRHqH8YPVg6qjyVoqyq2FGxCQ87UKkWr1kaQaE?=
 =?us-ascii?Q?aeaVFvne5EHYuaR06cJpfSjAkYYex9NJmwGWesJXmnkbX4owaKZPhc5SdoVu?=
 =?us-ascii?Q?Ck8jEHQW4HnMw94IC2pmUurwy6UOFXfanr0bCJqzw7xjBhKFgORFEDCgBDRe?=
 =?us-ascii?Q?OStpC2RrkE5r4eYnM3AQZKc6U1UoQITLhh0NwsrHAPsUEyWUru4zkfCiuc6+?=
 =?us-ascii?Q?T53i1Y+ABLe9Ad6O3jygxE3KmqQJPeaXBT5GQxqMvcdP5jt6u6AicWBIzqmE?=
 =?us-ascii?Q?CE/Yt8GXZuR/9IFNiO7wlRXC06qb44izWi/8UXTwf3xYFI3iNZMaJB0hpppi?=
 =?us-ascii?Q?qLn5tKGWdMD6ZnBznFj1vrG3wEdDpCIQJWWOn+KrlBLyyXYBX1bYY4ANoxKJ?=
 =?us-ascii?Q?5Q1tVRhQSqjjcivE3wMmFRvmIX4/tVN7FwEc9p5uRZIQdoCMwhR2J1wusifq?=
 =?us-ascii?Q?UVnvUjFHa0QmjqksrKdSiT7aZOzHlpDzbFlCmmc3gNkXWMD0jbKi85f6zcRg?=
 =?us-ascii?Q?xTejdvwmOzrdxYs7ybxVdT7hHybGhYkWSQl5oAKVPOhPkw9IzPLPyEm4700w?=
 =?us-ascii?Q?nsHTKlu+CVXSpmlPYni1g6utq4HR7nanFeJtNSraOtbJjetzOwhEUt8VR+l7?=
 =?us-ascii?Q?B7mazYvMaPznpAr8LbQGZ2IIV9Lycy8woYry4sb2lo/ksivet4EhQni3unNY?=
 =?us-ascii?Q?C6fnsd1I7MQC7TqbFvrdG33XHNLAMD21Ae915Rf49O8zaAa/p8oJ7jsj4pBY?=
 =?us-ascii?Q?FkmPuOk9GzAsWgFUfPn/pJxxQ6ZlWxSngcyaVwETgcMRsZ3hOkpn6hTR86rW?=
 =?us-ascii?Q?B8lCj3Ju+RZHqmxvTw2qG4uQ5BMQ8ZxtzHMCv41LGc8fANkFcS/Mk3HS/DPe?=
 =?us-ascii?Q?A9z+7eOaa6thyK0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:37.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fde0ba-3a5f-4ca7-7c18-08dd452c1fd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435

Avoid two volatile reads in the data path. Instead, read jiffies once
and only if an FDB entry was found.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2f2c6606f719..676a93ce3a19 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -434,8 +434,12 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && READ_ONCE(f->used) != jiffies)
-		WRITE_ONCE(f->used, jiffies);
+	if (f) {
+		unsigned long now = jiffies;
+
+		if (READ_ONCE(f->used) != now)
+			WRITE_ONCE(f->used, now);
+	}
 
 	return f;
 }
-- 
2.48.1


