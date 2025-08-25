Return-Path: <netdev+bounces-216535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8421B3454C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B93D7ABD0D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC82797AC;
	Mon, 25 Aug 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dF7a2pa9"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013041.outbound.protection.outlook.com [40.107.44.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A1275B01;
	Mon, 25 Aug 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134747; cv=fail; b=Br+vieoONkHZMQCCHTR3zTXOMA9X68ocQVN6nrE1p5wX7dlfI91H09SJU462diwWuPf/c4+MzqR46CpS9GySTWQDLzVkw9Dc/DwnAdUH6RjlUnrMHhqvovCqAFVh+S8ShDuxox8gtfggjOO0BJCCyUn4B92dnr9aGv3Ke8PdD5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134747; c=relaxed/simple;
	bh=FCQ06FShO/K+CFmKG6s6tdUCtY1x8ha42bTU5DjYNmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A3vZiWSBdGirInxJYSsS9HtT6gdhg9I114MKZbhi/w3WAiZqV5xMk+6mR89+q02AcSKJ1fPBeyyMXB3JRXVX+VW9j0KU36uYR4NLvn33nqlgA+zdTF49opyqMda6sos5C5yGm91BDle0vmyyCh/eqYVZ0EbPqgiGQGiljSpd/Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dF7a2pa9; arc=fail smtp.client-ip=40.107.44.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=indC7nFAvIkSzcMfbldpOUO41Xr+wFoNo7Mm5BqcyWLt3acp0JhtQcj34VD1RYXGV+SVY25cCU7QWhFQ/cDHmUH519D90pNmd690dT6KxhUJh0BTZxD6KaCedtPuyAwKNWU3WQqjrBGeFWrISBc16Lhj/oWAVRfBfvMrHXR5i6ZNpeMeY9iWMVUGCTEB0N+/5TB0QeOVqzlR41juZLe559pQA83NyEszYQWKVWNgcUFCC30w3pr/ONIoOBBYtFDysE24oWHCWzJ0lhJXMtjseQxuXi7si2oU1nlk020vK92tPAsMKomXzn/tgzym+zudIP3rdNAzyZq+Uly0ZwZRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gscexQTbsPVgQbIYquLi2QC1MCH5VtA0sxzWmO2Tqec=;
 b=BS/rEdzU+77+KpgFLdHfu8j84sV0Q9ooNA8hSmkDf2ly+oTifsyhsLX8E1wUw45KMj+D3j5duC81sA9L9gl4WqPV9A98dMYXkYNn5FuWb506PLR7+cMek5fnZYxQUhmkGSb7r6CCqjXBfVSZ7NGBESV+1Y58rti9KOsYZYIpVnXZMUGT6Gr02jAjO5xfR1FX5M/lU2CPAcI04d+89bvxEFr08N+o/oamJ1bMlMhQB1dWEo6i7bT3QKmPiqWA4Z5rhjxEAzNBL/3YNnwwr7d/XdqaAi8/Vo7lcBYeqD6f09x8S62BDjXqUDkAK6L+2UN9Vnh9Vyf+RAiUJhOwQI6dOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gscexQTbsPVgQbIYquLi2QC1MCH5VtA0sxzWmO2Tqec=;
 b=dF7a2pa9wFmuH8VL5p9hDlOQ8eQnmR+Pg/6Etk6AyWMyA3lc1zoDmQFhGbY2RbuEHi+FT8j1VhKA66nKWtVP1Szii9XZg5N/DVdQTQda+YLQMzRdau8xrBRp9PsN9vAgg4moxgg68jWrqfmmdv9cDsNwRP4qDwi7P7t46TNaGyTI2disORXD6Nx6d73Wyui8zgjvsU1jgn+qhDp5Cx2/tu7pSB6Lj8jnLaALdbXkETXYSl2/1gQiKB/qdGR9RSYxwr0YtTkjy2c/BftCnRP5s+MV0fhLy5bM+GhypNRivQwgBBFheye+6S0UWvVfx/vQfAS5Z8S7HB7q0D3e74eCwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB7160.apcprd06.prod.outlook.com (2603:1096:405:89::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Mon, 25 Aug 2025 15:12:21 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 15:12:21 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] sfc: use kmalloc_array() instead of kmalloc()
Date: Mon, 25 Aug 2025 23:12:09 +0800
Message-Id: <20250825151209.555490-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb03565-020a-4bdf-e52d-08dde3e9c9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HmXuXbD8ePoZYbLmHGh6oiugDxyFit3LUVVCTnKK5m0LLUx2bpM3/hLzUkf?=
 =?us-ascii?Q?fiBtGwI90nkq1W+af8PuEwZpZwC+eb2VEWaYFXN3gE9RN9SMQon3j1WuPPCe?=
 =?us-ascii?Q?oSwUY0doTqk+Ppd/tSHjWa1E3g3GOZPzYpLb9hW1r1CzFoBoOGqjPgZn8rBc?=
 =?us-ascii?Q?AOiuXHbN4qbPQXzr7IjfVpU//vDavlB0qQk6HXXsRMWF+rLUZyxAPWfqy0UF?=
 =?us-ascii?Q?GcwZY6U9+kMNN2U5YCWUlb/G80nC6H7jWhEfoUx3iWrlKNbNHyKu1ZM6DJBo?=
 =?us-ascii?Q?KLjn6rNVPyoDcru7e464v5EpCK0HTn4Zur3PQ/IAHQeR5Ltj4CboNPY3Vs30?=
 =?us-ascii?Q?pdrA2v1DddjO5f2+FTzbl1/vA6ABjylRybDEdXpfJsv2Ew1hgoMmebo5GzWf?=
 =?us-ascii?Q?4nfgi3IAxBVyCraEfW9bDrXCHRn5R4YlR4ybWQN1u6pZabL/83IZxw+kZT46?=
 =?us-ascii?Q?Ub50EZz70R+UaIRDT68I6neZ01DGRLbeNk1UnfUT7bMw3F+EyeqvUbKE/8cx?=
 =?us-ascii?Q?Mm2NfrgHJTlb/yK9IGizuwqtIqMBEfKAfL14+qMAeV6ezl+PkvoaT7EcH+pw?=
 =?us-ascii?Q?7BIYpx6iPM00tF3IgoaQ2m1BCPltoU4BdfCZQU8Cms24qYXBspzd3a+iTXs4?=
 =?us-ascii?Q?6BECMHQBsfSUD3IXSSZEfswZpDsBZ5zzJdO07+M3P09cEyPKpLfxAN0lFNGm?=
 =?us-ascii?Q?aEUXXiPs91jOkqJadewddSuqOrhmFSjxGu3kIQ18nIprtVoJLKXKYgrJcELX?=
 =?us-ascii?Q?nIOzi00g2NFkby8TnFSfEvGJMKFUZL66VVLkQZnZG4Lm9lR/yJIX3mDqtm5O?=
 =?us-ascii?Q?5ffROvkrYl3WYOYX9B6AAl5iqfqwE8wxXWuQT6yLQ8beBv1ml7xJUqCyonFp?=
 =?us-ascii?Q?CjGryoC9+Lqyp7PMviWTo5DQqK5zyfh5NCJt0l/5ic/TlvdVHf3MtHSxRgs6?=
 =?us-ascii?Q?8HTlpNiBx6DWU5YAXKfkgD+F2Q+6s9IAgpVtg1FBSWH3dKX61zAEkPPCHuvt?=
 =?us-ascii?Q?YNE7UupFC0f4CSwlzZP3Tj1bHkCF/HGNyZd8ULsjf49Cu5k81CMLeKGtIGWT?=
 =?us-ascii?Q?dnUMBa1c7v9QMFWbOnz3QCHRga91TWMUsH6WvjrzsXV20TvCoC0r8rN7YjQq?=
 =?us-ascii?Q?cY2uZ+s5FtZM6Hxok9VQjhhnRJYEKOQ9CNqCdqHqqXjV4MiwJ4FM1HWuD4Wn?=
 =?us-ascii?Q?YYrhJb6wLrCSBd/AkjrWtTOsqmX/s5FKvbkbPL9gePBWWJC6eHV3Bhz5xy1b?=
 =?us-ascii?Q?D/2mE5KT3yQJ1nGw3/NXgXu5nqpt2yTZus1cbUkfvg2rr+iuEqnXNJ2segTu?=
 =?us-ascii?Q?6q9Sd45M/ntyKNVM/yOZrnJpc7fgEzzhMpZ363Pkuu443ubZrIeHFaW9IAp8?=
 =?us-ascii?Q?tZvmVuojO3YN/xLANwanhblf8n8rfQCSKMc7rY1iSUpXJh6iapZp1AN00zw1?=
 =?us-ascii?Q?vFmwiRpaNvBN2HCXVbuNWawQFOO2eDX5hgwA7oEG5GX2v+z4pKJprvdHz0JU?=
 =?us-ascii?Q?YsrA/YJNfLR0uPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f26vPSnJtvdWhZCCyL196zfa8QFqCBmap1xDZBLW7xQ6gFoW8FOlX7xuTG4B?=
 =?us-ascii?Q?enD0Yku/tmynWboUn7bnx2WuJCrIwAZXVKrr4e0ccOLwi7zyoFi5Bj0Qao1O?=
 =?us-ascii?Q?3IdN9RF//5+rQH5Cn828r2TukQZYdqzBhoDFmkVQQvPdivKRKcob+ZM6kZhg?=
 =?us-ascii?Q?g9CgfCSyzjxpfsptd/8I6ADIXIP4jU9jLto4OamWiHGYnKGtscgt0tOWyz3G?=
 =?us-ascii?Q?mZRc4cnC8kt+XmKvINSFo0MgepaNTesZ9sHLMe2D0vJvyDaxsnfHPaGJthus?=
 =?us-ascii?Q?P2Ic7yYkp6hUFjIsY6zrcSLM6rtd5wJrW8CvXmKbnqxpsGPLRm5QJgmbHcdO?=
 =?us-ascii?Q?yvA/nGp1Yx7vSDbMSVsL/XIX+/bPAaW5rKM+gKHBfhCDnZv3ij8Frvcth06q?=
 =?us-ascii?Q?UcDe91P3ON9SPYCvLH26L+XqqQwPpCULsAgaonC37gl8CHSpxTXe0f3Kyx0W?=
 =?us-ascii?Q?w4aMnPWOP58znlBqzs/nz8t0AHDwcgZwXrY5u/ssy2DhJqmIAgdSTha+kmxJ?=
 =?us-ascii?Q?xkq7DxqyZei/sbThKRqFO63X+4QIXYX4+G0QrM1zrrLkzv9Dn1Ic0MtmEVqu?=
 =?us-ascii?Q?kjiJ77eeAlIOv1EJ/XvhLimluV3W/QZecWqpd3gOdU0C5mwQ0zqEle/TEak3?=
 =?us-ascii?Q?W0Z79PoQ0WRqvfZBq0UURo/8CIeStZUx7T+m+wsWzbddWCoWe+aK4jonGkVp?=
 =?us-ascii?Q?OvxDHN3vBnkItnROVjqbb2g7IbOojJV6gLQcIzd0MU/U14eJoaREAsptrl1W?=
 =?us-ascii?Q?tWMYdhBEGtwUkymh9Ia3yJgVkNdD34wKmihoAKuuSbG+YTTsbfwt8d5vJeln?=
 =?us-ascii?Q?J84AeYBv4/4Awbr4JYG1D4AcAqy8zBLyPWmEq42Ic13CuqvSmMmq6Xny9ala?=
 =?us-ascii?Q?lZP/qMtwqOVmm+z/mQiylFnBl/q2gpRh/Dlr4BcYTGYQ+ryLX0jH8ib41nZS?=
 =?us-ascii?Q?MAx0dUjdAqGs42ITqJvGUzR3kKhTpLV+r/LR1U+hm1Pf5rS3v5MYeQBlWiCp?=
 =?us-ascii?Q?4jQZdGUV9S5frkBK0myKZosIS+/r675eKdEaXpwtdn6PE9aohfoY99wfPHGZ?=
 =?us-ascii?Q?PPOyBfNdiKODAmvlFSQrR6VuCJFuV+/SJgU7J3D1p/ulU8d6HCht2MdvZFpf?=
 =?us-ascii?Q?BfFuMvYkamnUW4I+jL7/DavGm13Ep+MHy7QPWIVYfgS8be24unL6I7HfpQLT?=
 =?us-ascii?Q?RRBGrOrfcjrqcNa07vm8xwtFwW6mOd0znnwlqP26+jQYwORZPZ937My/3BgR?=
 =?us-ascii?Q?KhU6ed+3xhwfFJoW6m9p9EuNrbg8m6DuTKhLBD2myQ+s1tHFJmhtYpqecPWQ?=
 =?us-ascii?Q?7pPyfTzlLJHJdwx359Y00Z85F4lD514L194rur+L+kf0QA2DkDwUtLaYCCfn?=
 =?us-ascii?Q?cU1yHFrKI+z9E7/p6+2OzmOc0sJRkc2Wghb6ifNmNNMjZDG/pF3lCw65HS0V?=
 =?us-ascii?Q?0Bl+suH57/64Osg1mcIUtxx4WHoPo7VK4YKDh9cjwRQDL0qzS8b/QQUhROHs?=
 =?us-ascii?Q?eO7h7bmN2oMtimvl04Nw/Fb7xZYH3VWlqIi5TXQtimNvWooBpwOwnJfOY0Yp?=
 =?us-ascii?Q?pqhX8LtDaWkh3xcJhmWj2e/cdbZLxnYWmAnpGqC8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb03565-020a-4bdf-e52d-08dde3e9c9e7
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:12:21.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQ9UqZcwsQrcgUXh5q+XWqkm8YtoRCs+veJ2Na7nAt5ZZ5ANsAPMZQAh/PSi5x7rycO7kOAtxG57/GUnJ94+hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7160

As noted in the kernel documentation [1], open-coded multiplication in
allocator arguments is discouraged because it can lead to integer overflow.

Use kmalloc_array() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/sfc/ef10.c      | 4 ++--
 drivers/net/ethernet/sfc/ef100_nic.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index fcec81f862ec..311df5467c4a 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1326,8 +1326,8 @@ static int efx_ef10_init_nic(struct efx_nic *efx)
 		efx->must_realloc_vis = false;
 	}
 
-	nic_data->mc_stats = kmalloc(efx->num_mac_stats * sizeof(__le64),
-				     GFP_KERNEL);
+	nic_data->mc_stats = kmalloc_array(efx->num_mac_stats, sizeof(__le64),
+					   GFP_KERNEL);
 	if (!nic_data->mc_stats)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 3ad95a4c8af2..f4b74381831f 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -640,7 +640,8 @@ static size_t ef100_update_stats(struct efx_nic *efx,
 				 u64 *full_stats,
 				 struct rtnl_link_stats64 *core_stats)
 {
-	__le64 *mc_stats = kmalloc(array_size(efx->num_mac_stats, sizeof(__le64)), GFP_ATOMIC);
+	__le64 *mc_stats = kmalloc_array(efx->num_mac_stats, sizeof(__le64),
+					 GFP_ATOMIC);
 	struct ef100_nic_data *nic_data = efx->nic_data;
 	DECLARE_BITMAP(mask, EF100_STAT_COUNT) = {};
 	u64 *stats = nic_data->stats;
-- 
2.34.1


