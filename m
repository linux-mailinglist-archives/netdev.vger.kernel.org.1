Return-Path: <netdev+bounces-136012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4E99FF4B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA63B24619
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122818732B;
	Wed, 16 Oct 2024 03:18:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565017C9E8;
	Wed, 16 Oct 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048738; cv=fail; b=UXgyPyh9FQ1jKoA8JZLIE4gtMVPauMGJL/E0PtZ4PA6sak+kNtpccnL/Id5g/8ziY/hQwh2wF1e0fKVgRWftn+Vuls5CR7bv7t8Axe2Q4gUuUxN3SGdT2GqaJzU+WM5t8JfNonpc47AMQwk7CGr5u9w4eMTiOC3BcXcnL7jxK9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048738; c=relaxed/simple;
	bh=5/eQkq1wqu2C/1CuF2zkx3pNQVk6A2SmTaf0uJ+MFsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uoyobKhax5wS+Splwfhw+pjfSZR7RZqAAeX50oHw0lD7A6qVhIpp3O2R2zY9VVMg8XGs+0S5p6E4d5pqXZuXcycJYKpmaNDk5oT1g2MWrMfDI6qPOBa0IrNtsdCwbNdxKivwc+jyS14uJjWgdCKqJIJ83nsdSD5w7l9bdPb1ou4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT9pOpDCjNpt8kJNmOXoV8AjuzxkyP1ysOGlQx27ieNamQQts85DDrybputzYMxA1MElQqO9XYgt/pS0icQqdr0pgkwJEpC9YKIowCDYwkL/eoNXP1o9zk8IwQddIHPnWg8LH25vdUUsP7/kSWTt8WD0F4Z71U64DKZ2sUv7hhZxsseec4h/liJVy/1vzzxwnKGZn5ZzjOrHT9wbxfSm4wEPgd/OLRsJmyFD8//DA2OA85xzI4Pfm3MDMXwA7hWQD4K8+VVEIOeOGf0XuIyMs1LY6v/vmqqfTwUGuUyRHJCmqAAJGg+ViOkhCUVgDBVJgpX437zeC10nwX5E0yIfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WahXJcbGM8ulZVxAjtg3xSlDTBK4O7kf1zmBe6FFoAw=;
 b=nJqoAQWkAE2Oy83zCSTNnlUqJqeeRuCRocbTz0CFHS9fAkeoVtnxfqHNZt/4Zu2fHz1cvdbdxUizCyWDGnK76VQdRoZufPxlyk57YYoba9IINotk9D9T1Co6830S5zjQZHJ3WOvj0Z5Hyss4aN9+6z5QiM0t7kJyuGeJv9RC2khaPw3zj3+I40un+ZAR0lNUsxHAfty4R/RKsgA4Mqc0Gyuy4UKunPmnIu4bpL77vF3HDgvaUqwdcgcLq3qfDO2og6xpcbuqFoewpJ7kZ7cjuTZvD/Qie+vExlXJPPyir96ojyRAceg1hMMHS4GcMjb67WIRGrpK4vblobqVoJ397A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0961.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Wed, 16 Oct
 2024 03:18:54 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Wed, 16 Oct 2024 03:18:54 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: [PATCH net v2 1/4] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
Date: Wed, 16 Oct 2024 11:18:29 +0800
Message-ID: <20241016031832.3701260-2-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>
References: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0053.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::20) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 13855ebe-503f-449b-46f0-08dced9143f1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	bbAwPSCCMvkurmwJZrx1rB/epi87OWLOydommTqXVNR0fWECIJo7JAc6+KZzrDjYOs3ohjp3xizOfvD3gAJGnioZb5FrGqWhnF1n9mLFqjqxD7W+0XNFWebuMTtMlzQjECs4m++7zc+BtwzkeNIJKAYwPUuJ83w3wVQMYbWVr6NFLcCkVK1Q/q1MLwMZHRrqJsi0LAMhNaYDgvrO1uecXHGGekUz2izoXO3jNL28lVjE/PhFXGhGPfRaFvgPa0CTzcidc5B21w7N1w8F4ZrI4fIzA5T9UFqW9zSMcq9rgflVherEb6oGRAHnCCCwN5R/Ft+RAF6GK0GMKitZZ+ZTgFXd58+fvgqoXp8ycPBiQEJ7QZOrROiv7YPlK1CUGOIA1bAaEyc34DzPu3Dzt2GDHQ5TSHlUnd9JkM3wftHypx2J5sOlD0A9ErMK3UB5g6HM3gm+G7ZBdphLSF2j3lqlOCu9m0veBxP1JSdYnD5hObWyH/Eux+yPaz6M81HhV8sAGjqV06lC7c8Z61XrQOzdQu3AwOujNfgOBDsske+pRSu9ucjjDlj3dgsEPCh2lyMqWbkSXfufUI1SLlGfxhwD7aT9lcg//LZLXa7OJpu4KU3wwVjhf0BsLtfoDoNJgC5s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qgblyZiSRFryvGOF2Swgpx6kuI9hLDtX4W9LKrzdjJgRtBAdalveX4sBLIbG?=
 =?us-ascii?Q?BN4wEx9lvjszxHjO/gjHIBot94sdXErCW8CQ3KSM3CKweN5lvBWVZsmZ4Z4s?=
 =?us-ascii?Q?Unwrjogp7lyn4ZyFOXjxnYlzZpsVdCIqIuha18f8Z2OguorL1wHtiesZrjWX?=
 =?us-ascii?Q?wyzVp8rlgHS/HkmvbIhCXqe9mQ/5GDh6E5TTi0S9jNBtIDX6tpd0TOTgjW88?=
 =?us-ascii?Q?Q87vIuWrJeUVopBVUhEge5bYhsaZ6Abj1qOrS/V3UeFqjAbN3C2HIHRY2LqH?=
 =?us-ascii?Q?xFRTlz9rHPEV+HM5WBJ+SA8LIB3V8F1OwXfcR4zGHExSDIS/rz/6d3MylEKR?=
 =?us-ascii?Q?OSglkWlOtJb24shotJEZChaVK/4ea8Yi1ztKUdOGc/mrCD2PvE0EFP6UkB9f?=
 =?us-ascii?Q?hVE0bDnK0EpmBhuN/WGVjWVmU+B/KJLh6SFKNQyzCc6O6+trCBZYjjOQBbNM?=
 =?us-ascii?Q?+VuJ8ziqDES28lBD0XGdYEIi+JslO1eZc1uvYsABhdK8pWh0efJDIkaBGvbh?=
 =?us-ascii?Q?7gAllwAfeFxbOIqXwhWmTtGY+D2k2M52MJHvV3DjRbtPZ7BbO5OHEgRyKaCI?=
 =?us-ascii?Q?EpG31VbMHJctMWwcOluy+3LXzRSgrckC00M6r7slRtii73ml0ajOH1haQ0RU?=
 =?us-ascii?Q?UtxF0QCIFgq3waExqQUzpWfKR4eiCGBiD8/9qqIAlGR29RJznVf6vU0qWKhZ?=
 =?us-ascii?Q?IkhLDCaH1Qug8RA44Gx70S5DFt4OBPHGTAcKNC0IzcS9Gk20wPLDgqMM+KRJ?=
 =?us-ascii?Q?FXmmLHVBbB8mHVdYN5ylEHagQDDhVi0k5gdLd+uoIeOsKsxQnWnNbVeRQndL?=
 =?us-ascii?Q?tqDtRvbuy/9TtmV+y4g49a0deVISg9pkXI7kLRbJ+v8QkHpSFRjPTmbGJK1x?=
 =?us-ascii?Q?T6PkrZa+jvEAQxgdW236enaiep5t+Fl2jODI7KOW+huh+QtUZouwrjHxzZXF?=
 =?us-ascii?Q?lH9rU4+JReRpOpViIRAlxHvnD/nDu7Rub/7FI3NJELxUSKR4EUsOQJLVpTnC?=
 =?us-ascii?Q?3OdRqZUrD6hmBI9SxOTxxwBllkCLe/fWsJru4A8s1ooGO2WFOUXXcqHKFg5p?=
 =?us-ascii?Q?akb8da1gc1JcZrW+1UwKHipMRujh+WL+jHDpImrQiBQtqF1w/4tYgND8L9yB?=
 =?us-ascii?Q?aBU9kbBvtHuEnd+iFBm6VHXzpgpMVZoijIkBAuLcsBDY5mBhGVVllQvweRek?=
 =?us-ascii?Q?von8Zq2Fj9nAz6WsHtehfVN2hCxT/YGFRxz/VwY3Ij0ue1t52R8zBx4gpaTX?=
 =?us-ascii?Q?yR3FGyyH43rFMRJv7HTiN6CeVeuswO6Nr9cvn+usxAaryfrQaR/Hletqznqs?=
 =?us-ascii?Q?xLkakb2XsJK8/QYjTzZyoZX2pfB93A+Ptqv+gYskxZ53vF8sfCRfK9DK5fD8?=
 =?us-ascii?Q?nc1E6wf1T49Bc7hcxRhMZcdcHyYF3A4BbfBGYEx9AP2EUv1c4BBdG6sPhsUN?=
 =?us-ascii?Q?uaUS2izfj1SFg1h73GlETY0O1e+le77HFbkH6qCSRL1dSqe6eP8hukywrCN5?=
 =?us-ascii?Q?/QPeMh2rtl4a27pbIe0beENtGut5FK4W/Wkabkmlf8+GKuF4mbU+DMr+UJXV?=
 =?us-ascii?Q?xVk1637FGBTf9kyjIXnDikhWgAzjGRJvWUgCbw+Sle6GpSFLeAXJGqu8oq0b?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13855ebe-503f-449b-46f0-08dced9143f1
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:18:54.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zXi/XzoGKBCZfIV+HnDElNrgOnOfQP/U+jhUbOqh7Rp4mRksBdOzCCkApIXhPQ/MmJ7YUOVxzcl/c6tg5GrJsGbGITSCl09HdFIORO/pU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0961

RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
macros to use the appropriate mask and shift.

Fixes: 35f74c0c5dce ("stmmac: add GMAC4 DMA/CORE Header File")
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 93a78fd0737b..acbe5a027c85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -389,8 +389,8 @@ static inline u32 mtl_chanx_base_addr(const struct dwmac4_addrs *addrs,
 
 #define MTL_OP_MODE_EHFC		BIT(7)
 
-#define MTL_OP_MODE_RTC_MASK		0x18
-#define MTL_OP_MODE_RTC_SHIFT		3
+#define MTL_OP_MODE_RTC_MASK		GENMASK(1, 0)
+#define MTL_OP_MODE_RTC_SHIFT		0
 
 #define MTL_OP_MODE_RTC_32		(1 << MTL_OP_MODE_RTC_SHIFT)
 #define MTL_OP_MODE_RTC_64		0
-- 
2.34.1


