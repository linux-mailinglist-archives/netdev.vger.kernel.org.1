Return-Path: <netdev+bounces-205227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2DAFDD5B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A3D483129
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33911A315C;
	Wed,  9 Jul 2025 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YprumrtZ"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7D1459F7;
	Wed,  9 Jul 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027791; cv=fail; b=anNRdSpMlDjL+1j502oCf1Tl+uJzYfNs7qzth0l+dTv0O+8UThqTDdj0D/5Hoqxyo0pzrNThy7lw5jJ5v9WI7Na5cK0DQ71LOgyp5eqIGW9S4O+T6Y/ZL24PdDapbnZiGBFFVcmR7nQ3ddw2VXtmoTiPdOd5yvWpdmWpcE3z7Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027791; c=relaxed/simple;
	bh=DCtbAYIX3k6QrAohZKrBo1Azk3mNrF6nT+KIWRn91l0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/Gc4cqF15kQwY2oxM1NtMADiijlKUwfvUHAyFwik9psmAUtxO6H1UcqboIANdnR3eDLroerc2VhaVe6eYi6QSqXtSJRxYvyqTWmKLpuGNaHBFC7VYpIIt5X/Zd5kwx1ozF/HUtrXVCkdsS1Pvfwd5uaYiebVU1zj/IZnocCaEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YprumrtZ; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpngbVbX+FY7P0ubgwxKSPuXX+EyzQ7DL58eoAYrf8uYckeJvXju7XiocDyR/wEXy2EtJLJ1kqP4wHJXi/ynD9DzqT021qCjieNLIstsQ/BuDTZDADZAlECC4Z3AP1trLtqlUVXdbgIgpD1xAROkcwoyQsU/+u5LiTt+UcXqua/Zy6NpsKU2BiPUe0jJNxmUwOv6vkGl5n5E86gvXw33E07cFaAUu5+eoShcFEQ0n+fQOlCJY10KZNeiOSa5vngxTWnUit0/QGJxqzlVBxgiAt4FrA6qh7PS8IC0Wu1FhWBdLcTrydKgsL2HnWLVftnLaXKOuQlkbOoHK9/EXF4CyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDvRZI7FiZUef8yGxvBz/DryHRdkjQMM2mKFAaeeQmE=;
 b=wsutLINT7q30ofN0uAfcHQD/NHDCCAbSVB2KgQc6kpKKyOgsaYYTVK65ZrqyBmXmcll/s0D0EQwcZ/NXHXjGmeTh/ItpvkVuEf9Rml7+fG+x3q03iy9f21pCrLAMH/Rc7vgRzkbyBqTeda7++1fq+XPM0WLYhJDZyR+btbxQSvAbq9svC5+GuGP5jkgZ9S7Gbdp3EgaM1+cd/rz+VUYMdVo//QeIBp5UjOLcmdw2nHR0hEKcYPh2ZMchrqdDQBiQOJ6C4YrJqrFH1eT49uSyQm6uwxVJmGcwPMPFA6lh73oxFXDuHwu1j0eF/FvUxoJ0rvW+lgCKbTHcPLWZw/12Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDvRZI7FiZUef8yGxvBz/DryHRdkjQMM2mKFAaeeQmE=;
 b=YprumrtZnjRqjP6kdIA4ODs9Fx/Sobf0QHRKQcwRXyrK3/TSA1HMVdY7eJB5r23A/9S/wo5+3H7YeVE/Sh+/KhKOyRF68Q3ZK9CmXpYLUrjRpYap0Y5aMHX3mXqNEMLiI5/xtveXypAWhprAgp+bPf6nFfq+W9kdelw2pstb2tu6EotyGhB6+L1mr1O8fbwwbzrvxg/POhVKrQuGVui4cb5Vu4Yl3vYif9PIPjvnN8ccz2yxszX05ZUjQWyBGGqmzkdnOOGg22gl75ERTdXQLzZY6NIVU/m6aCpuWCuwXWzi7rQE3QaEnq8DZCftquN4XS6uP8fqdXKMDg6NiOw8sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:06 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:06 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	netdev@vger.kernel.org (open list:CAVIUM LIQUIDIO NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/12] ethernet: liquidio: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:29 +0800
Message-Id: <20250709022210.304030-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e679f9-1ce0-45ce-b147-08ddbe8f89ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkNPC8Lg6hTyrwwCJ6u27RifDVPXmHYteMvCdKvmcnFlU+gzOptdJ05EVEEK?=
 =?us-ascii?Q?1gYwI4Xlg1/hXt+bTzhtQd4sGGQ+OJSl+Oo5BRWxFpprrTqNgO0E/Z+C+Jg7?=
 =?us-ascii?Q?0wfC8+b93sf/3p6kA1YQIGcX5wrGpXyH5c1NMXEehvTbEjcsJ5jcnYnpDYl7?=
 =?us-ascii?Q?8wuoioT8Y2m3j9LKiA0Qef9BQbv2eDPLalbI+vppr5Z1yHj3q1NImhhTo00y?=
 =?us-ascii?Q?Ken42cB6o/ZE7yHuAClyshlY6s1B0+ofkH3UL9jmViOJ8oiYWTqfGcshuGBc?=
 =?us-ascii?Q?LBBDALou08QdfB8caVsvsAkbco/Jpbhld8pNbhxZrrpHMHUXdPJzs2Z6kn3M?=
 =?us-ascii?Q?5WwgwBSLfL/dg15D5WxSV3OiqDMR7R2QmzFvqZsV//z6JgCzIz8BcC+rUMFt?=
 =?us-ascii?Q?C/+iN/vzIF7XKStpLzt3SlZimjy6yWXAk3ia3hRmgfEtHNUrpYMHfnOi0v9v?=
 =?us-ascii?Q?w0a819Gqf8kvrL9pmORFUlv7Pci3tDXTpNOHGpEQ0Md5gxTs5tJ5yqNFtNXc?=
 =?us-ascii?Q?Lj8EgOCTK0sHpyg9op4kMX04sdtvh10K41ZjGY9uKzGh+MriohnG9QBXw50y?=
 =?us-ascii?Q?9BCA2qEUMLyxCzBMkYgGClHGwzk+mesZvCidAfQRE8F+SlQzIVKUkFvfJdBM?=
 =?us-ascii?Q?Sq7FeCKaZNupsA5za0rbi/y9DvGyJfoBzePOl3BWQDfLn+4j2neaVs0AeYIs?=
 =?us-ascii?Q?xOlr1ZHdixT4FhlgCVX2NEAbF4iNAznTiwtuRP5a3A1978rhJjhVV3gLmMAg?=
 =?us-ascii?Q?E+wCFEYlf/eVaflauubpoQxGizgj2zDAPcu934KQRmWCB8ipKL7vVI2UD6rI?=
 =?us-ascii?Q?Ctt2dYFzR53rRHfUc7C9aD5vqre3cgL27tZeglI0LiBI06ScU5XCVEX8fW9w?=
 =?us-ascii?Q?r5EEysYyiq9Kkzdu1Rcz6CJWnNNyHyjBkk+eGI0CnDZ6qNmm8T2i3h+OsCty?=
 =?us-ascii?Q?IDWEM9kHRiKb7T8zYTbPhh/8ibR2Fjvt9oayyuF8Lvku0NdpYdfHTQ18DYoH?=
 =?us-ascii?Q?3P8wVPdoL6OA7o72oITg0cLszZ/jlmu/YMWrs2e/1yFg8uzPDlwV6KXAiHIN?=
 =?us-ascii?Q?2fXot/lifZYzDqblLBX/ij4fVPpeTEZeQ8ExHt+YZl8F1ji4fEHJdzFizd5l?=
 =?us-ascii?Q?wQutge/M8QjyppdQs3y6Gn44QzKJ9if45LsSNhEXow/jlownyXtS2K8DLkg6?=
 =?us-ascii?Q?x5aG60vIg5ACxVxzkR76yctKaB9xhN7HLSZsZf33uP7x8QJGKXBTph0ODMQj?=
 =?us-ascii?Q?+zsyuKmEH1GUVZv/r4F4fF/PKF15POOiZ4Xv2rxyjhSC3qKiKArXNuXjAeyg?=
 =?us-ascii?Q?xcNoDnF/o8E7kgtwgZD5etbuFupMz11uCqu+E0RsBN10KeCFSU57KpKtQADB?=
 =?us-ascii?Q?RRPVjeIaAnoFFQME35xA1DJ/KedQhAMaJ7EhRqUv+u+KH+lySLqntSmeb+4c?=
 =?us-ascii?Q?1L7xiJPn1ZHCzKdxrCAM1JVzDtjgP+g6oDt7oKiliJ/1N4rD7g0Hxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPymS6n63kjzxyYNTPe0nzsh0Si+SIaebCQFegiSDd68VVFQ/FXcK3JpL5f7?=
 =?us-ascii?Q?HEz4GMRKO5hdvQWym6JBa//Mx7DjqN123mH6XqAGog0FcY3i1eFNPSCFK2D7?=
 =?us-ascii?Q?cfiWlnRJvXrd4tFcdvAyM1jOTb3CYkZ+3Z1wDUNeq1i0SX+sCe9mvKzOjpel?=
 =?us-ascii?Q?oTm4DYzAX11KRoEG29LxxhC2SWFxleh/51vwtHOQe0Ce1hh4DWExy1vpP3zb?=
 =?us-ascii?Q?dkoHgGL98coXxW0zbANK8aFAh2Pyx/0FK1LvGnLenHj+gYHanFCqQhAeg08W?=
 =?us-ascii?Q?3sWmwe7I2VJjNA7EHUAh4uX0MFortAyKrY1uJVbv5+XUDqpXTxqb9L1m0kHv?=
 =?us-ascii?Q?ZtiaiUUAl1pQvZ1iVOeCZR9WgFaXEM6Nv1Za4ZhA8ytjlfmlXu6r1mI5iSp2?=
 =?us-ascii?Q?CqyRNEgxGqpE0m3N0trs5WOuSb1Q/bqMb+tw8S3Zqpb6yq30Aa9O2iC3aCO/?=
 =?us-ascii?Q?SxTkr+cn2l/zbPuEUgmdxonvX/Ipm5APVk6cvviyvgHqOu7GONDaWQtuGRLG?=
 =?us-ascii?Q?UtiJEW9e96ebtPTjWGeYf46l1GECWZOPIAUViZtGQp29VljYsJvV4oeD3hqr?=
 =?us-ascii?Q?BZGxd3eyBxyWJ54tFD5fUh7t0MTGu6hxdPdqxl7zxrfXLQb5QUW3v1/FIRsq?=
 =?us-ascii?Q?DjMSmmJXuLZQAk7kO72bMme+ZGiiP4j79Q6+0sPezM4U8wKeUvwoAHxeW6HA?=
 =?us-ascii?Q?fk2/JVAA1vr/GYkVSxDsrJsdw7mYdICIGCHXhYPBBPG1trrYLf5HR9XH5Nqx?=
 =?us-ascii?Q?qnfUc68FBcHhmg1G4j4adH6toNuvxHVjEjuO8pm8Ib+DDrzlCxApHSmRvFE9?=
 =?us-ascii?Q?5KE+KYZusmYAC66mVbDgfkNcLGNxIXDBVxOHAnW8UVmII9c2VdQJh5QBpSRV?=
 =?us-ascii?Q?RufKKp96+YSEpmXKfOrCP3h8TA0QZgXTYLIChqjzEYNue0+X3NR3lIRuFH/6?=
 =?us-ascii?Q?osxWhdYznGYMQbC5cgxKrJkz8mgoVHGGt/phn2Rre1v+LeCiVTte9h+5CnPV?=
 =?us-ascii?Q?P7RWQoleDh0lbCcqY+igHpWctclR9bxR6/yCS2WRZJs+27bkN0bcsevjOpxY?=
 =?us-ascii?Q?vAIZoNxcfR9sTeHDBBoGe9sZUTiOHCmCfUTy/8O3oYp7yaMbeP3sciXKKMp7?=
 =?us-ascii?Q?GQo8SGCx2TuTuWhwLkvE4+hnmOWFJGhsXOUosUtU2kMFBJ6J0hBhENk9AFS5?=
 =?us-ascii?Q?uxBPy/tk+nnTGozVvROMW/INDeozKh7I5ZZosVazmUfl4Fx0fMSU78n/l1nB?=
 =?us-ascii?Q?xfesritgjlDMZ9gWqxHjo25GjyAwMUbY6ekF+vsZHZ8VD0tK499oUGRXCvK/?=
 =?us-ascii?Q?QWnwQsfyckO61hJIDi7Mf25Wobarb0Sb52tu/KA1bQjH9oceeFophddpeAW/?=
 =?us-ascii?Q?e0D2yVQBpS6GGZM2uCCD/gM/JnZZS4D4zWqMAOHlrN9q8n7mTDP71z4kOw0E?=
 =?us-ascii?Q?agf1cOARrHwxSPuxamJS/dhIdhBsSD91WaMN6GVAsLKLKifb/q9TtFKwdYoT?=
 =?us-ascii?Q?bKdz46+k5zZaA7YShzlfUE/MpM0+B10cZBtci4EJVetU5hhKa1fOzvlJtewF?=
 =?us-ascii?Q?ZMGskSGT+yzWVII0Pg1r+huoCq11gdavCpqWFa7F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e679f9-1ce0-45ce-b147-08ddbe8f89ed
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:06.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSU71D84o8W/sSJglIdKHyYnEknEUWEmYm9DTiTkdWUqmknnWVIaMcFI5XE+13bRn5QnFxPqoYpsS19tCxGRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index 67c3570f875f..526cbe2c2a21 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -873,10 +873,7 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 		rem = image_len;
 
 		while (rem) {
-			if (rem < FBUF_SIZE)
-				size = rem;
-			else
-				size = FBUF_SIZE;
+			size = min(rem, FBUF_SIZE);
 
 			/* download the image */
 			octeon_pci_write_core_mem(oct, load_addr, data, (u32)size);
-- 
2.34.1


