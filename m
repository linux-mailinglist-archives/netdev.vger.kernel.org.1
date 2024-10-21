Return-Path: <netdev+bounces-137373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40C9A5A1F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0839A1C20F05
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556E1CF5FD;
	Mon, 21 Oct 2024 06:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C49194158;
	Mon, 21 Oct 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490718; cv=fail; b=A7By3uTiOagmJP/0kXbi7F5kT4mg9IfFEeM9XQDnr+GjByXS6R+cNvC24J5lmPVwObgkLNCWgr/+pF2EibPrqxm2F18H2Rd63NvotV1foEJ1q/yWMDYP+ALrTZ3+WWv48KNZu0sr2xQnFACdm17cxQ+v0RrbXPQUFpg7cKNXuIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490718; c=relaxed/simple;
	bh=5/eQkq1wqu2C/1CuF2zkx3pNQVk6A2SmTaf0uJ+MFsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnZN1QMqlkhRIXv0nE61jkuA/tMAWDQqq26Zbm9g4zgYG154rm5dNg9tsEQvJz+cre+irttlmQ5UdSaTcd8e4vJG+4Yp4doTB4T+rev7ZyzbZTsqd9xl/QLfUhAZ0ksqfg9DhGgqoJLIoHD/Sq9X7tQ/wjoF3YXiS4MQlv5eTAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUv3v8fOgqINFGoXI6+S0lRCfCTF1NeYSWYhxlv21cDsaF8JHuCvrRFbyTr/UiMz51il05PsMtjIouc9Ilw3qKCq8bHL3U6lzNwlI1wWoHF3TyVc9xw11TFDRupwlMI7qdgawRg5oe2FPNyGp6iWdXcThyAs+JN4Vqbj22iBv8bGLop4mcl3jhgZklMtRWNalOI7NEX6rz0BnvH8o9ihhIdT054JAFP5iE1Bjih4nd9ap/kv0T708h1d5L9Tg3RO+BCveMbAErG9DT19SjDpvTs8qqN08xO1em16P/lrbrh9OUYhUYJkcGHzuMy4oT4UqT39pv0svd0+Nqd8iUzIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WahXJcbGM8ulZVxAjtg3xSlDTBK4O7kf1zmBe6FFoAw=;
 b=RHhWwxQ4em3NuqYwvv1HQqOJ1BrjjBI7NUat8gK0vp+UmG74KNjlOKqOGt2+XXDUXTLBnKWH0O5i3djmQ7s+ohmAQoy0pnls5qHeMo9Gdgo4vPGt2JLe8wuxmpo2ftChWld0xfhRrSh0WTMnaKfZgMNV8Qytr4azMcD7MCADJqa9DfcKWQap8kcfKMm6E83jg8z/4nu4s0p+UySj7jo5yP0rYNEe7flMq0sELn6p04ZOPu0x7Po8huz7RzZEhdAh4udzrUrYihZmTkdyKIDnN+kdxBc8MJoQKDxBAKsbGbUdLPVdFc7aiI/r5/2O5q9ECWbqDR8wvlRkFiisxtTJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0996.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Mon, 21 Oct
 2024 05:49:12 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Mon, 21 Oct 2024 05:49:12 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next, v1 1/3] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
Date: Mon, 21 Oct 2024 13:48:46 +0800
Message-ID: <20241021054849.1801838-2-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
References: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::15) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2c93d1-2ded-4e0a-cbfc-08dcf1941711
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	QvB6JeAGXI1HRAWmrSMlhMT/nCnzTeFstCnbfcwBb/vBxy2pa/ndDM9aplYHw0EmKEksgmdHWz0KCRx7HiTwqWh77Ly/hX+p1ST48cSx5h0BeTHt3S2aRTxTa6EIp5aeYDIb62A1HzZOAUu4Bf7XX8tfG1kTw9kx0Pvlc5s6Twaw4b9Kif14Mk2DZXyJBKS0tlvoPXNM4BGzdNWMik3dkuLJcepGoQJ8j9PqmxV/C1uGWSrV0RP2/LxvQ5XhycBnm7hZIt58QN8o70Jf0xYy8IoSTiBsLDczsUztT7aIRANd5iyV70QmVD2pRHHBavSKVxRgDSC95uEJOUdXal7PCX8upNDnY0/Zx6tc9FregdXnwAbZmen8p+lMgehCsjdkX13XgOTzm3/SZQrMLPcJIF3x4j63EVI3St9B+l07UKOd37FUIlk7bn8NcgEvOB9GIgPUFq9ky3YbDz+psKjwYsJzMmpmKVFugZwnzdquNDoOpH3EEok4Ia30fNNoug/Jq8yKXBNEKPxKFgT3OYulI3XgCaeYVnBuyCzmWkR0oD1vaUVYfbK06XsefoSx8bnTTzH2FWtDKVmJKWptshewT8SgQcXzMTO7Of7ZXqPC1O1s2S1uG6V6iVDo9E4MqUfz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ak/BwnkfFTI+at90pnPEpH+Oqh9eIy2pjoXvcLzX9aQK5PGONmoMbe50Ks5i?=
 =?us-ascii?Q?QK7sSRLXGW0VdmFkLb7T6FsTSM4wwspl1DJYUGS7QbFll/AXR1Hx/6Eg0XJQ?=
 =?us-ascii?Q?6C7v4qr+RpIa0Pch+6XUlqRItZcnkijB2t00mKqZf+uIewNm7+5UeXOwwuyP?=
 =?us-ascii?Q?NG9fOr7UOVcK3JnVz2T+2mzyOINbWg1eH+Sf4wd7O4M8pe5wrsRxA6aiEWIC?=
 =?us-ascii?Q?7pQhXkjFKHaqKuUZsPdfYuQgMpUMg5blsHGrEzSlXL9YSVriB0dY80Xxnd34?=
 =?us-ascii?Q?1UhDtMN1HhZ13qF9HE+SSPEkGDJU7gl2g6S5Edw61SbEXkZRM8gd0GjQrwaL?=
 =?us-ascii?Q?Cig5h6WtdiqEp2KEQZ9bnGD6B9A34OksWraDAs4AwzSxgeERqz/Hdw8mD9ah?=
 =?us-ascii?Q?WoNUiV29Vk3ohE/wp/2cfcAgS+EVDgEJ6BitIGGe9yFD0rdvJZB7l1NchAoA?=
 =?us-ascii?Q?DpJUG74Mq5DNQ0Y8r24unbfvMuhEKfHY4MeGxYZO1flYtrGhZSHnq0o5Ouhk?=
 =?us-ascii?Q?yqEDSNQJg4urVzhTWIlwS+d+IGRVC2ACU1p2uHBZ2RwG+Z3o4aZiOL5sk2y/?=
 =?us-ascii?Q?cTLP2b9xVhaB14DCN2BBwfS221Jv7WPp02YdmY+bEJcImHnLAv6WysaotjFK?=
 =?us-ascii?Q?lMJ7KcDiRz4vYxnketVvTL5KEogx5zANScsgXvRw1FP10G8BaWW7e8I4AXAq?=
 =?us-ascii?Q?8KabwNHXGWZaqDEh2twGnQA7wBR5SzJEW4o3gbiSdwrrwOvK1B3W6scah5LR?=
 =?us-ascii?Q?3FxoRagmj4OnkO41aKhsYCYEeevsuzECwu527znPeH0uODi0XetfQRH/eCQ9?=
 =?us-ascii?Q?OLi9F+l14IlFecTiJgu3VHc2JDaBcLEh/zqIR9kqwHzSK2wpbSXgJjerWeJq?=
 =?us-ascii?Q?zc9cSRMG7p55qyxQqoodZGcCJG3XyoYF6m+iQIrOD/+TitSkyLpo7QsxOkjW?=
 =?us-ascii?Q?TquUlLlVyPUi0KRB8Y1/f49fzjLAUInnB53ophfFlIk5F2vSQIe8RqjjbEoy?=
 =?us-ascii?Q?/D2vxjkpw7tfwQ3MGBj2oKfsCBNQO1j0ny+1r3fi1GpbcdHdx1pti0PSMh0D?=
 =?us-ascii?Q?QD2JRLV2uHk3PqCV9+3+WMUThYWaQGxALmZ0f/uOXaXQw62m0Tr9klJcf34E?=
 =?us-ascii?Q?emytf0wUFlsMKuf4+KZb1kMh5cn4NT2xDq93lL0NTbJOIX0bUhQscJKC141D?=
 =?us-ascii?Q?Kl2WNDCvW5g+5cOZkSo13dFFIcQE1jPRhk+zdxsIXfrNggZ9r65cfo7tUI5h?=
 =?us-ascii?Q?1folYWU/zd8jofRYChEiGI/NEXfXum+yqlSR1wH3Nz1jV7ZJUXU3U0mthoZR?=
 =?us-ascii?Q?bjcAQuC49rTE76R2z1N7KbFtsVrpbg9QlWxmGNZjlggEY85ABiQEX0LP5Dhh?=
 =?us-ascii?Q?8i9jquGuWSFkvGethK+MX7L91ulybr9TmLvAgfCxlXoF6Pc1hi/9XQcRGcNT?=
 =?us-ascii?Q?Pa1cqHUW5ZqXn2N2SK9Dk0UTU8uvb8LOQiKYha4gBJ6DOcWicBvWGPeBD8w8?=
 =?us-ascii?Q?MYwxS20dDfWm0yDTA+vtECcfASXieXNuMS0O3uFwdBlZVFJhmCU4t7W8/pvS?=
 =?us-ascii?Q?U7yyVwVCMRJN4GUgXFTSMLMZ0oa44Qft8h/IZC01LbmDBtzgKNBivYtj5AJV?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2c93d1-2ded-4e0a-cbfc-08dcf1941711
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:49:12.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru/TNdP0Ga3FypIsYg0gnZeSaZFpYRd3o+0qE8wFoG0Ab14CcxlIxu6vJUTFKmMkZzTMj503Gh15NwXfVWNad7KVRKMsfEJXO6nk9WRQWAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0996

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


