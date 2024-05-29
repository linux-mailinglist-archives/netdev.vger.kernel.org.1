Return-Path: <netdev+bounces-98829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805678D293A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ABE1F2617F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A352184;
	Wed, 29 May 2024 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2eJ4lb07"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD1320E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941019; cv=fail; b=pEg4raYwtzqDgXLoVn8C4SqmIXJu2lqqLJ9d+elm4qT4BtQCcbjS6s9m2unQKMtTfva5RtwvJSB2TyjBEZBUO8iCaLiMtVw42WrA04pbttku5A3sxAd3n0hCukTVnVF3yqcADsE/CSR0wcdcP55lj/42UwSow8HcXq+NAfkzZqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941019; c=relaxed/simple;
	bh=tanndi1pw5nqWT2ss945bZtdtDxWSfOrCcFyoGl/r14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG3KqH2Ai+ydqYEm4x5v0qY1a+3CReUa/1q8NVahrG9UvSRZVll4epXrxuHwt3XZUGN368EpOQgRFOB7OvJhXSgnE4MLV8HCz8XmjWVssDBtWyyCOwpkWoEkYZStFPshql3fvv+yhs1aPPrMrbNpI9vpEL1aT4AE0x7plXRRAZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2eJ4lb07; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK+WEgrqnIG00aO4RR1O/6d31wGKHyIRSbjH8xOfTluNc2Grm0NnKlepzCjyS1xLLOAPKtPDdq9irJxBqngdU8fLQb3j2HxPaohFq09BQcT8S0WH35u3Uxh/U8/ibdaU/u8/XJ8Jc/+rB0jPXuvVI/ujUtVnf2NgJaHH8zZ7TkFghtD1hm8nAwcVF94BueAysBCxFKxaBAAFz7ejr/D9hPF92PGrQDoIlqaLBfCwLnI+bYmSOY0q3VA+GWoW285NVxqPmgCvl56x2lnsQMJkclaPV9vwSHB+cejIXwOVR8hjDVnoHfVtAGKMSVTLIsc9d+Yh7+G/2GRnI1vUN6FbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAG816PkrmuRC35ejKpLqFNb3Wvjnq1NvL819BXGASs=;
 b=aeiASsvN+lxN6qbsbAsNvJ7E/pM6q3dlslAqqXAREVJNlH7PGSewU4HXuZ50xGCfRXCK4lCR5s02UHRseU2ytmAtOYyKwmFcx7h7Xl/++FLU7DX5vU9M4/ag/P7BY4vIjm7uzxy3kmxuc6WAmGG0nBoR4JyaMyu2JGa72w2Dvj44vYZP7u47QrSmDJo0+qYDs/jKqwCk0r/JgNTigyme5P0yv4ZVfJ+z7uZJHwyR9JnkkyFXT3l1wYe9BrE+EJVfcWf3bR+AcHHoDShxGEfZ0HGHF40ncIViIOd9CelbVe6/nOuGt4sJvuuqfjNprAGL8KFQ2h+om8dFk3uINhw2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAG816PkrmuRC35ejKpLqFNb3Wvjnq1NvL819BXGASs=;
 b=2eJ4lb077LyorXLvHdO+o8MDf+2y4wk/1obqmZdWfR+EKBy/y+qraiZXhz1RxVdRppDchc1bOC+CPaV0MCPs3sEXTrCBxBNWAwDaHdU1SJD2uT7iVGZ39r0LeEJBLXi21bVVu33waJKrwrAEHnTv4EtLUjMKZUfxsqRofsgJ9Bg=
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 00:03:34 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::ad) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 00:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 3/7] ionic: Pass ionic_txq_desc to ionic_tx_tso_post
Date: Tue, 28 May 2024 17:02:55 -0700
Message-ID: <20240529000259.25775-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a0ccc3-8295-40e9-4be6-08dc7f72c84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHbaVIQqOySz3lXXP/sjHA9kHBujOaKEHjyEaJkKDxXGycbYw1dnku+4ktR/?=
 =?us-ascii?Q?xVt/sgnfQLAr21dNogrPE5tGFu65i0IB5dO+lH6eFp+UINtn4d22QcFUCJus?=
 =?us-ascii?Q?TjHvcafAMU37jIY2nLRubIBgm2P2OIx023qFhFvBEPsdeGe4wqmzIARmaeVw?=
 =?us-ascii?Q?Cg5GvIgkNT5ipB8JyjsZiFhnph0N1KkR0z8bUyGA4CueL9YhuuBh31JZeC53?=
 =?us-ascii?Q?bJX73czZzyyiqh4GbSA+SVEXL5sBLZzzkWo9zxXttcE1ANWnv77wrVN40ujD?=
 =?us-ascii?Q?fysy1MERF74kh1cCwnC2heuCzj3Q3xG4cQjWR21ztozhAHhpuO+5Rz2vJeY0?=
 =?us-ascii?Q?pU+1WYvOUbVBHHvHJ+X8TDhHr75eeYiTvx1E/KUBJHt3Ihk+LqrAHLz96x3A?=
 =?us-ascii?Q?zKJ53F2qoWOa6kvT4dTDjqVy8yjMA00cfyMoL94dF2zKQeAIqZgv6wwLCE2v?=
 =?us-ascii?Q?uUX/Ueq2Iv1Gfgss+lSFryA1K91Ho3EqtmZyXvwucisDwlTqMKgnk83/RuWw?=
 =?us-ascii?Q?1oNgk4KeK8VChIkqlgh1BkMUkY+2sGiii1Z2sdP6m/SBkk9Xmw/12vXTi9Zc?=
 =?us-ascii?Q?H8uTacO56f8MiREVmOR6OnOIWfsb9PpRAYiYpC4LBOBKs6+Yo5i4KMQl31DX?=
 =?us-ascii?Q?tkfGobjWpZvROEyvf2jaWsGYw/dWZCnryG5drvrxED0DAp+hBWQgzHs5JswF?=
 =?us-ascii?Q?wjxIyba/oet7c4ZEH6hmzObPk2K+H3P8IYUsI1kxFzj6eEfoxbGYZbyxA48U?=
 =?us-ascii?Q?CF6ILZgxpPSmDtURpW7KPXEyGrs6pU/IVTTyr7Jf1waBrFwZw+4og3YkMf32?=
 =?us-ascii?Q?xcHcH64aypN/jnI1TJBB9DcXKWSkY8anGumFCQ/LYMxmJnB+qG3fUdohJOgG?=
 =?us-ascii?Q?dWmqu6g1/JgnVMVtcQZaRxwCEExjQ9Cbc2604h77A/WL5sLlKWnPZh47fydj?=
 =?us-ascii?Q?QxiE+51quwqj75x7TvLhq4vCi/ouf5FiauEBGTqTxD52WhcNq2jMoBWRAVje?=
 =?us-ascii?Q?riEQui5L020UR7Zm5Jwu2NlrFc+KJOm0njdWGH7P3q9ZeRrD0Ig2oaYBdvCo?=
 =?us-ascii?Q?BF1/IMC8gyHXjvVKAtEscSuNUNqYvzzLE0aWDE+5mwMB1nL6N15uS2h7Leax?=
 =?us-ascii?Q?nLqQCrF6MCHt8/KtndQntaDgiyPmSNjRvTQvQE3Btgz5WXTuwF/QOH//6TIF?=
 =?us-ascii?Q?0NMf4EGGYcCAepwM/ool2FZn+CfXuszhEcfTDaNUXNtbdQ6kVWSODxxSg8jl?=
 =?us-ascii?Q?5dO+w3t3gX9/0OHZ+mes351lhd/+nTDUGLYWWrHhS0cxslh+8EkPmgEQcQep?=
 =?us-ascii?Q?4oHXWhBWu7dnPialvThizx1Km9s14Yu63IWJi8NtDu1D9KCcXoPJ3RhtbsGy?=
 =?us-ascii?Q?CqRco9pLaTbxems1yAudyHG7hQ2I?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:34.1869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a0ccc3-8295-40e9-4be6-08dc7f72c84d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

From: Brett Creeley <brett.creeley@amd.com>

Pass the ionic_txq_desc instead of re-referencing it from the q->txq
array since the caller to ionic_tx_tso_post will always have the
current ionic_txq_desc pointer already.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 5dba6d2d633c..c6aa8fb743be 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1357,7 +1357,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
 }
 
 static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
-			      struct ionic_tx_desc_info *desc_info,
+			      struct ionic_txq_desc *desc,
 			      struct sk_buff *skb,
 			      dma_addr_t addr, u8 nsge, u16 len,
 			      unsigned int hdrlen, unsigned int mss,
@@ -1365,7 +1365,6 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 			      u16 vlan_tci, bool has_vlan,
 			      bool start, bool done)
 {
-	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	u8 flags = 0;
 	u64 cmd;
 
@@ -1503,10 +1502,9 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 		seg_rem = min(tso_rem, mss);
 		done = (tso_rem == 0);
 		/* post descriptor */
-		ionic_tx_tso_post(netdev, q, desc_info, skb,
-				  desc_addr, desc_nsge, desc_len,
-				  hdrlen, mss, outer_csum, vlan_tci, has_vlan,
-				  start, done);
+		ionic_tx_tso_post(netdev, q, desc, skb, desc_addr, desc_nsge,
+				  desc_len, hdrlen, mss, outer_csum, vlan_tci,
+				  has_vlan, start, done);
 		start = false;
 		/* Buffer information is stored with the first tso descriptor */
 		desc_info = &q->tx_info[q->head_idx];
-- 
2.17.1


