Return-Path: <netdev+bounces-142661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A929BFE8D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF3AB220ED
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0B195985;
	Thu,  7 Nov 2024 06:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45157194A53;
	Thu,  7 Nov 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961423; cv=fail; b=uuxBMpRxeTT0Lai7ZuEpEqRh+SScJJ1ODuX9vARjwvZsfynC75UPfebCqJfZlPl6tF1O3qPx0BRuJWcmZt94EaVwf9nayWXbF8cTk+uVT3uJ7pjw+fmOXO2m+n3dn5bTBalZV5NlVoUxWPYkQQ8wqAhpDCzPsL3KW1WQIGMnZS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961423; c=relaxed/simple;
	bh=whheL9CMxZNUd0z/ksyOmYNckj8CWIZ7tSJogSfI0kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ck3//4vFqJTkxBh2Zf3vGyJTqk28bn8n3xmC2FnM+gR0NwJQZXszDtzbojfbJjwGhSNUXD3ApRskgo0mgaoLW/Qhg5WMl55fpWpWAQrSHXMw//9kkTQqY5Am8MpYgYlkIxdqZ34ByO2+X0v/DbJRn9ryqRuStqQouZTLTvrgDCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfS71PvoBQnm7TdULqCk7TuaqRT2/NcJtx/0KPk/VPQokdEgsOx/9X6v3quUYfdmGyzriJPRrF/QObPucbklz+jv796BIytIbO1jB7UvQ0+u0QZqJb67uwNMrvdt2BhLE9C2q3gyJpr2JUPZX2BKoJLhxI/tohY9rwIuM7IFLjCynV7+W23eGQRpdpxu4u3qaCTrVI0jR0NkrjO4iWbYKw0QTjwXAvPykqV0ZImCAH8FQOOUwVjFuowWWmvrjtS/1qVjW+5h8nyzahVo6dwKaZvbdB5/W6FfA9auZ26/7pHibJEIa8DzB7cvobXSUK+JNP9OwxqC6l1/WS99Vys5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH2vjZ2thek7RGOfUwjm1+5ZY5YuD6+EHAhHxSadIk0=;
 b=MVDp1KZySV+uGepbyDxchv9wAZmmgeKNRveEC++Ra5aArqh4Nnwfyu0k6j/S1QYU+xJUPLwI/BqwYxuKtjBldS99VEyMFp6fKTZtvoNa/ZFb+Y+lOVsh/McvwNOqxvT1kth7psuZ1WfT0Z0rNzYsODbPZtUqPkv97C16nffvILxDZxznKRm3AtKOeqQAaaHjkfQSga6HdbVaIXoPGgDyp9MCJwSj4gBlr56rgvIn8wfrFD4S6SvK+CHttl5+Qr1j1IYo5Ml/5mCD7Ci4Kmb+R5UBdG67Gap5Ow2K5SGFm8wZ/8wqyuo34lzU2rQEOqC2dmydD/c+smK9fs7jkmZT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0963.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Thu, 7 Nov
 2024 06:37:05 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%5])
 with mapi id 15.20.8114.023; Thu, 7 Nov 2024 06:37:05 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next v3 1/3] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
Date: Thu,  7 Nov 2024 14:36:34 +0800
Message-ID: <20241107063637.2122726-2-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
References: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::11) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0963:EE_
X-MS-Office365-Filtering-Correlation-Id: e779b874-5d27-4fce-e928-08dcfef69850
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	E6aS3eSaZfMyJjqJWNCqISacKnX9Mh1bjTApX42f7LZqUdINn9u01xGuJb2jMBVHuyOrOuTdh2rpToKdQrxHd6oMAG5ZSGisAhnlnT2CkMIolDU2gYKNpYmvKiGwkgMB47OIL+OwkBsm9BTTwya8ewUmk0YzJOxmogkD6+oyuZ7j0qABiMX7OcTmjf1nn7yMzsqSa5Sj8bTuHvUgnC9lRt8Q3KtR1i3EjaV2kOIUYufyfLcBXTDsRcxxIo78X+5CJmLY5jtE6WorNbjXbPTGee140XLIGhwX1oNLP7WBuyZzMqSUMafkbZwsZRLK5t5G3vWhSS5HDFRS58uq76Nb595HNX588xSl9pboEQOF0jpsJ5ysGVkMHFv5KMHO/qzwenC+9DuyOaFQSOVzu0h5JEay+8EDXHMafLsjZ/1bHhfj9nxvDUmbroWC7y9LadKMNcIyMbVd9IfC6/artUXw3Rln3E9i5Jt/1J8/yt6oUsBZJm+0i0vJz0aoAmUNW99y4k+My2iM3l/TnI/CdPYoLVQBs9+C9T03zR/zJ4t0Sk0S/gs1xFruN3cRiYb4yfdbfx4R+pjSWvggk87+Xll34f0O2cqYqyMkg0LdimnitkMFcD4sALmxC6/7oLDIh46e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/GZMCGKsbZTgjJe3G4/TM80jWYPo8yC9w3XKmBEVZrLX+ytXl8cwrpJV/nmi?=
 =?us-ascii?Q?l/CUioSzhYGcGnrmpsTZtKz9rfCwh5xOz/di3Lw0oexOq1cwyQJeg6yakqHi?=
 =?us-ascii?Q?ExKQNuq+LkhdaFi2ywNx8ytcPtyxCf+6A2PMfV/kcgDuAslTHv/JqGSm8SUS?=
 =?us-ascii?Q?F3+JoDY4xlpE9pkKrGX0Nl5Ly+zLgZsAD/6xoPVIdViPZ/DnpFhb5qEwnuiq?=
 =?us-ascii?Q?EOl+tiWju9YGJlkjCa+dxXsF+vcqfBDIkUJjXtsTwTHWteXiXcIStLzDgUeU?=
 =?us-ascii?Q?/UzwpKRv3fi2FCcKTKD+o95LXsV2GTrY2vYkMx/uwSgauueeTRvpsUK0h803?=
 =?us-ascii?Q?WjFdYS25rlCpyW4+DGFGgxRbZx65xauNxsFbvmDvztOZ0ORGaoKNA+X9f3Ke?=
 =?us-ascii?Q?Q1rOcBIbhK//XPIWHqpynkaKKxmqdkKQw//tp9pDXRJ43emHUbYknSY22axD?=
 =?us-ascii?Q?Z1yxf+nCZZFj5EWz88vI4ZzvmTth9cKH3B5XeZ5MW9FaOFJi0rPRE1OHT9np?=
 =?us-ascii?Q?9ejAQFq4EfYFY0IRg2furlYKHvscitAZ2bz/kvzejMaqmNLlFGdrzQNM6k4r?=
 =?us-ascii?Q?Oza5pZ69E9tdhsypxLEDUwyeRgstlLQ8tqSaegtlLlpmcHHmS0cPEOTTWB5U?=
 =?us-ascii?Q?Vvq8D/spCTSqexOsPFrMLSvKgRwrwg1oB4HnOGbnR5x0CmWGM5dzHinctfWB?=
 =?us-ascii?Q?+nFtkqX9jJt0HhHDcW3NzrEnZLv9Rg1sUumuxmvtkf9ZjziCT9+J8ANssQM4?=
 =?us-ascii?Q?BB3SomNh10VbLDnjEtPUbIZOpFUdT6i6foeGRtdadlo3e3GoEtw3DcDWNk1H?=
 =?us-ascii?Q?Mt7Wjl8I6WCn5LHqJNLBiWR8jydOJ5PrW46Q0yTVyYpRpVA6wkPbG7XKXYPF?=
 =?us-ascii?Q?L8apz63FBz6XpyWVeEydELDVFdlmzvB6sqTmdTWiLpHVSb/4f1QanEvq2zDJ?=
 =?us-ascii?Q?PxuUOiq7HnWl2ewlMeYwFIHJzut/nWz+/ffoeo1xbd3ySiBU+I3AGzX3srIC?=
 =?us-ascii?Q?ZuBn56hVVUWexdWbMaqB9k3ks+2Hs1Z3DvCRaKuVRjVoDU2l5Aw8TNtWAgaP?=
 =?us-ascii?Q?d32LjvQO1tUNGFCH0JjjnhtgsPu6eD8qRYm/6PxefMzWuIo3gl4+Xt1cojxs?=
 =?us-ascii?Q?d5GBj9RbXvJ8hZH2Z4S67DbgsGowCPXdIl2Z37wfwMqV51s4qGLlMo5y9VDB?=
 =?us-ascii?Q?EEmzvpRnUwkG5K5vvAU9M12Ptgorzb9Hv3IAFRvO1cvVKSCR7AGXMSO1eoQQ?=
 =?us-ascii?Q?0dLneGDuJ0brC4hWjElSB89irlgoS4vlpqo5qlmkEyKT8q5jPGvLogj6nFaZ?=
 =?us-ascii?Q?tZEWziIt4bNiYsdIGsSza96V8w3UW0Y3A34Kt414raOAKvK1GyHeXwY7u503?=
 =?us-ascii?Q?QqV5njg+LTRMEVRgrvVO+ApIPMej0seOCN1cEby3M5EAkJoxxlpYFrKir2Pj?=
 =?us-ascii?Q?5orbIVMG6+Faq716I5+m83Gyk4vgugB0lxMtKUZfzp6LI4//4GvlSHOTC1Hc?=
 =?us-ascii?Q?neYLiWeWGJvO2S7GwJkNkEioa78uK5ojFc9WjPO1RcOfdOAYmjXYyJ3Hr4Dl?=
 =?us-ascii?Q?PNXVza+Q02yEs1eaiQ6uLqSWTzbGOkK6ikJ5bWnHTuxqfoJb077LIkVjBUcW?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e779b874-5d27-4fce-e928-08dcfef69850
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:37:05.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NZ1o0phO+j7kXAAY8L4d4nub1S838IuEiJ9DdMPYS1LXTiTl158Ve4AFEChzpPq7Wh1j//KdykhBpRFjg8VIAhzh86nN8qPkS8nCiOdOsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0963

RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
macros to use the appropriate mask and shift.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 0c050324997a..184d41a306af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -393,8 +393,8 @@ static inline u32 mtl_chanx_base_addr(const struct dwmac4_addrs *addrs,
 
 #define MTL_OP_MODE_EHFC		BIT(7)
 
-#define MTL_OP_MODE_RTC_MASK		0x18
-#define MTL_OP_MODE_RTC_SHIFT		3
+#define MTL_OP_MODE_RTC_MASK		GENMASK(1, 0)
+#define MTL_OP_MODE_RTC_SHIFT		0
 
 #define MTL_OP_MODE_RTC_32		(1 << MTL_OP_MODE_RTC_SHIFT)
 #define MTL_OP_MODE_RTC_64		0
-- 
2.34.1


