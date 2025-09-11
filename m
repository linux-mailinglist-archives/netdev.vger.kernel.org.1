Return-Path: <netdev+bounces-222009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12475B529EA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2BEA03028
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535026C38D;
	Thu, 11 Sep 2025 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AfxRKfPg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C226B098;
	Thu, 11 Sep 2025 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575713; cv=fail; b=NZGLbyEq8ELpLi1J5y5xS/fwou5gMOneDXJrnGzw7CIZP5Eu7GahbG4ASevMkwLCB/YUBMDTY94AHr2X0J5O6DzzN9Pakh/T+Axs0+orSnAEYaFPWo8Q9G+B3x5PDkWEGMXtxw7o46CHjxd/A3m9Ky5NsEo8hDQmreVfCFeC+9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575713; c=relaxed/simple;
	bh=UBEnLb2cOPVPvycaWNKWjhm4v69QY+Yhfg+0OW/4kq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW8FrHKr7GgC/afzuXmGOBt2xTZJPb542+yUBfWq2pYOE2clBVkIKnIZwcvuNes26KqVWy7oiXs4YA6eHBRChZ80U5Jp/3nGM5fiBoGfnG6Fd3Mbmy+C01i/tG1eSaLe7Otxs3Uc2PA4HbIw/0rTXgPEe1W/nV18Z+KEIWD5k5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AfxRKfPg; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D76NKuLUpqnc56USjwsSyfpThfz4Denh65yXpVz4bYTeFAdWXJPpKAKHeMls6VtHBaVd1ex6rsiQFuEtbWBYtT3Q6MvjlZRe03I3isS/e6PDGp92lrB8dXHcTm0/Gt4bDRaJWOS6jD/jDJ3/p9jZaHQn09DTwnLpMTxDmLpFnOqqDhxEXSbxiF933ER4d1xOZLBFSGI6+idOEKWSnNSsaI4LzxH/ZFb0NEcWZKmYQx3XQFVi22E6aj+IAGSmP5tn7nZHYcWT+u+Tk8cXkkssRnILqnFSq4lW9Xz6jGTnUW0yAdfz6QuHY09FNCCa7cQ4Q2nPBpZKu+6UQoaxrmcVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhzabJiWvRjiHm9xJQuROgBhVykrRwm0XAI8rVytfDY=;
 b=UzmLXQA84gml+q99Dy7NXLQ6Gr3jJHhX20ZpM3exN/307DRVLczCcuVxqxjkSrUwK4UkzMbPjFj9zQdKwsMfHr4t5NWAG78X/LkSsf6w6bo27o0pfjtFbuIsOHk4h2/sHC9VPKaQ+JiUYTvVkoyFsFyoxkpP+xPKwaO+Vef7IWTcKCGGb0xCPPzaln9OuusyM3UootofyrJM16/iEv6uZtRoIPwizuWAwWTiNwgZwsg1FZioxeNfYdXIdGPTmfUPwF+xRDPLRHvzpRuk4r0xSsisU+FdYvRFNfOxKXrzQZtadBlQdIznI4I2onvetgr4jZYVGsge2LW5dXfy7UKBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhzabJiWvRjiHm9xJQuROgBhVykrRwm0XAI8rVytfDY=;
 b=AfxRKfPgEPlzm7K1LbhRrvxuXmvLV2gz2/emVtf2lLtmlmWScQ2LMVkD/N0jLKqzOKS5LbOp9UvUh7hPW/1uLUhpJ/hznLUIhIBLR3rgrl1YdgPw6LJAluNVt0BlD7bWneDieKfL26oz7yhWCh8J6llNOOZgoUy6Kka3uLgyAiA=
Received: from BYAPR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:40::16)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:28:28 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::14) by BYAPR04CA0003.outlook.office365.com
 (2603:10b6:a03:40::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 07:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:28:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 00:28:25 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 00:28:20 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net-next 1/2] net: xilinx: axienet: Fix kernel-doc warning for axienet_free_tx_chain return value
Date: Thu, 11 Sep 2025 12:58:14 +0530
Message-ID: <20250911072815.3119843-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250911072815.3119843-1-suraj.gupta2@amd.com>
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c234af3-52be-4bde-707e-08ddf104cd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qDHSA4TI2IKIG+llhMzOti7p8luhet1Kc3arfF6KtIEYlptQdm1V997qWnLp?=
 =?us-ascii?Q?6a/B7lM2UGbnzltH1DMWZMX3M0mAd/RluScOpJMzbIciF9ArZh5EMkOYZl8o?=
 =?us-ascii?Q?8L8onxStn+sc+NCKYBN+TxUqLBHg4PwujQ/2YdGYRoTBSw64cm6h2uF4KIgt?=
 =?us-ascii?Q?NlrFlWhHzlBrwvYNja2Wl2+LwOKf7aSNw6kg5qiPd/xoZhnMVYH0XsfIiSTB?=
 =?us-ascii?Q?GegtDZiqCDhoZl3imoz2gU/0FnE4/CSdPP1Lv/Bm5ejX/31czcgi28YpZ+ey?=
 =?us-ascii?Q?ATJxCzw/u9T4UcqAcGTi4xMXLau7VJSaLQ11AWPLgVYjx6G3SDO3LPizUysi?=
 =?us-ascii?Q?t0cl6lyZ55+uXkk6wm4NPD8AkVjp3ordQ078Anut7BrvEGVYd2mnIqh+d0uo?=
 =?us-ascii?Q?da8qVaICAx0fChTua3lN4XjO8R+UwkYpJKRSzw/vRNDvLuz/X9cz8IBu6Fb1?=
 =?us-ascii?Q?RM8kIwM0/hU423NAk5mfJpibq6Ebk60lQvatxzNs45D386M2PB+XYgdV+MZU?=
 =?us-ascii?Q?+LQxoVXR+KLO7lS8QGFFnTV8447a84TOsOsItaVlCrpJgfk4wwbnZrxvAMuM?=
 =?us-ascii?Q?BJiMrF46YvfXSjsHRMh1BIQMskbu7+J1NGgD267Z/4cr10P4YeFUITqYyTEL?=
 =?us-ascii?Q?ngm7yeidXkSot++ROQKM1Z8khhczu42+o/HeUZvM8LmItWzdXMidtkLTSxLX?=
 =?us-ascii?Q?n88ye5QUSK+YxPA1flTQcACZZrsU3S2DnNtRkYOZ6IK4EJ7PVg69+sOyMdcX?=
 =?us-ascii?Q?CuOJCTpiMjR7UwGIfdMkEyvesgVz6DtMRyBiGxj+NhnhDbfqZaXwcS7pgaQN?=
 =?us-ascii?Q?bOazHKQvLcD3xHr+V9lm17Efx98b2EJmA4p7f8ZXwzzuKPdg3iWfqnibBnAG?=
 =?us-ascii?Q?ieSQTDMkrg33S33sEQirxF3s8aBKX6M49mRkiimwbop1uWkt7e77R+HV6ENc?=
 =?us-ascii?Q?C4DFrtKqHc06xvpKfagCFJy2mRdKe4TotbHAelf9L28CirucfepuT8H7HTwK?=
 =?us-ascii?Q?F4O2q7GTI6DYAwfAVM+6tL0qmjYOcpHiPtnihW7giB4Zf5QCocrn90gg5TNH?=
 =?us-ascii?Q?RuxaPeAhu7gP1RT6YZLJUS4vG6QKeGHUdkhux8Yc20OqUFYxqLAmpKPKLK/i?=
 =?us-ascii?Q?Xs9ygapBHpbZ2prZtP1BpEfvD5VoYcUYEinIMw6+nAknkeWFukFwFgU6gdv1?=
 =?us-ascii?Q?/d1moZbmowalQTZ9EayiBrxhzXlGrwyTAF8dnW1DWOT9cQwoi/43zcajb67h?=
 =?us-ascii?Q?9/MDkvCLXpdrZpQW62JaXKS004Qbjx50UDNG6/45Ovb51twenZbk6q50qNZ8?=
 =?us-ascii?Q?xF+6ABBSkGTKokJ9tndDrtziWgnDzg3tDzsHAlutftlKEW3MrRNnKG02Z4JS?=
 =?us-ascii?Q?hTSukQXI9og/qZ9U32cPz1abHTxSLK0EaCfQDZrG4z6COmnAvhXR7GRP1Pxy?=
 =?us-ascii?Q?sazPYw29MgePjYx2/9YdxajII7jtgFrJW4R3sH1D8dHxafIxHHNM+Yb0pIQR?=
 =?us-ascii?Q?tSDqpYnQMAKFuCWc23zeCzQrF82ihwIejA6L?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:28:27.8803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c234af3-52be-4bde-707e-08ddf104cd21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

Add proper "Return:" section in axienet_free_tx_chain() description.
The return value description was present in the function description
but not in the standardized format.
Move the return value description from the main description to a separate
"Return:" section to follow Linux kernel documentation standards.

Fixes below kernel-doc warning:
warning: No description found for return value of 'axienet_free_tx_chain'

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ec6d47dc984a..0cf776153508 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -773,7 +773,8 @@ static int axienet_device_reset(struct net_device *ndev)
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
- * Returns the number of packets handled.
+ *
+ * Return: The number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 int nr_bds, bool force, u32 *sizep, int budget)
-- 
2.25.1


