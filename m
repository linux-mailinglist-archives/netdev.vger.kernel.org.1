Return-Path: <netdev+bounces-160762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB84A1B3A4
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812311889E99
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFC1D47A6;
	Fri, 24 Jan 2025 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gwWoYzXE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2042.outbound.protection.outlook.com [40.92.91.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269871CDA01;
	Fri, 24 Jan 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715274; cv=fail; b=c5pLIAVxqFT6j+IEsfqaZdBsYSEcWJN2RHZHPd0c5c1tUow5WXdMbKomWvkiwPHJ0GhdshkYggNLLMUpFGbOBQmU2SRbq+fkehXbUawlFQCZP2K8B4J5sK268SpFVGqN0b9JlU6Azath1ZRV2iGhRXgI8ddVxpL1bamPfFtR+2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715274; c=relaxed/simple;
	bh=2kQpHvk0QrauXZYU42VS8oUbHDomEW/8gcisH/qb17E=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PRsrJ9AgMNHmTKctQu7tcqWX5Fk20hvBH3iWR+huecllha0RMj3G/EjMij7qSaOTYJCQNU6n2Q6IRkvM5D88jL1BKVYrELGKcKYibOJNcCwASb9YFbLF5PxMuvxGQiiD3/pWBbsCBNsPp0kYe6BRk7ZeXuWXzrH9BMdQ4wjo3ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gwWoYzXE; arc=fail smtp.client-ip=40.92.91.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLjDftY/GDUhOB/LV2nNqvGai7xoLMtLag1CdWliqcKm4uD+4pagcYp57UPtM+yPldigc+jpX1CTS5lSAMTLMlnfFuxhfhMPFZqtdfctRS3RFdxNIAChrD9sosqhr1ecKKUCoNvcLbF2BMqD06Kz/519SG1jnBau6o7rVsm5axvRvNjb6oskUlZwe8DT6J+ryPMtQDYF+MT9otcvhMrihvPi9IyFdZTwygLd/uk9pCCN6rDDTIBqmq7NzxAd5UJdgbaNJ2w5934eFATk9+ImhoBMbIHj+Lp+29yBmz5huu33UmZNd5Jm39cUiTYTB+A60lxnOHoNBcil6bZ5WZoCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BN/88GvPhYSUjoJaer0aByGNz9ftWswAjgooKyhdC0=;
 b=f3JB+GIVfDNJyAtbGwgs7DPolmtqD4qd/o7gygdoRBIoVZXMfUh5RNE4u04I0ATDkxCZ2FLU/4CPQAdMj/8YDjBmy7iCbnhyXGJVrQ6MFTD/nZdWOcSn7KsulxUyGxF5SAqPu/vn1xE6EXYtMO/qCVZ3suuYBYRquY0GurqXKGyW5AkWKbt6R12+J9FWau5Gx/l+tCTLtnHeLLggsTXaozP+UBCeuFuqod1l9C4pA43n61HcNhy1gFIKCTIPfl7ObRnXbS3asWA4vgRdonIwin9Mnt8d04sa17YceKEZFVmo5jZxdlLa7t2YF6USOyE3QwpS6u5u2C21ktOzVMj/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BN/88GvPhYSUjoJaer0aByGNz9ftWswAjgooKyhdC0=;
 b=gwWoYzXERQXdAei787h6f7hyjPFzmvtLAggxp0hgxChkJfRXiLnmX1tPYwPhOHRXmrlFTvbrcYVHO9teJAGc4OA9TDyRVOnSdLDXAKTSwAjLo73Ih7j5lH4XmhlDoEBkPP2j2sx/7hgvWX3twRmsNXEqurc29Klx+R631HCciqGrB3weHBFkuianWAOOxuUs7AudXbt5FQBiq0JqWmDkiPYX30cEn+igGKuE+bDPyqQA2qgeUAbXMGdqGI/0KSzT0Q9Vw/eM2jYgOqvWUTaClgvf/YC/gTzTzQDiyCtw+X7WD1gKgKMfsP7WJJr88qjYij9RFN6lHAgQUdw9oHkOLw==
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36f::20)
 by GV2P250MB0730.EURP250.PROD.OUTLOOK.COM (2603:10a6:150:ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 10:41:10 +0000
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046]) by AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 10:41:10 +0000
Date: Fri, 24 Jan 2025 10:41:02 +0000
From: Milos Reljin <milos_reljin@outlook.com>
To: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: milos.reljin@rt-rk.com
Subject: [PATCH net v3] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID:
 <AM8P250MB0124D258E5A71041AF2CC322E1E32@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: VI1PR06CA0148.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::41) To AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:36f::20)
X-Microsoft-Original-Message-ID: <Z5NuPnBatVSbXIdP@e9415978754d>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P250MB0124:EE_|GV2P250MB0730:EE_
X-MS-Office365-Filtering-Correlation-Id: 006dc9e2-b748-4fce-4705-08dd3c639d95
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|6090799003|37102599003|15080799006|5072599009|5062599005|8060799006|3412199025|440099028|21061999003|41001999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GAoYb6PoqkldxR33duGsNyFuw0ph+jGDPei0V/X9O9uuKU9tRNXw909SOKgq?=
 =?us-ascii?Q?pZV2y3O6eI1qNUIK3lLcKk5gdevlOYfjppSFJ2oJDIJvF62FFnRLMbdfK09G?=
 =?us-ascii?Q?q/TMFMXfbC/ZL+XhRds5E5e9JGXlQY9nxO51X535wXOtaO6GywlZHhrDg7j6?=
 =?us-ascii?Q?xd7HqmtH/SKWXg7j4CInSnxzTQYddqgZUGGnM79+FhuRQOBePRZbPmrCbR9m?=
 =?us-ascii?Q?yyXoQ9XAgQOq2g7uZGJGS3Zts/cvpmbV4OerJXCP1NWQwX/dO2K8ykQqDhC5?=
 =?us-ascii?Q?iEY1F30vG05gb3DAY0wgPd8sLEKJBwKCn+OUzykMjl//I3MBjdnAkWqvhnUD?=
 =?us-ascii?Q?53o6oroY0iFfYFdLeK3/9xB+N9+RHXwx13bYH0If9px/EviZdRAzYdf4/6YC?=
 =?us-ascii?Q?WPKoquWOXUGdEAYsdbpdD4mSc1ce5HXi7oyThW013gizuRLSroJlJr6PRK+M?=
 =?us-ascii?Q?kH8gMrc3VLjWv2sUoeM3VWekTE8JHS/FOJAuZvZhl351Y3wpH8uP1dAZBZUu?=
 =?us-ascii?Q?Vh0xgUzor3IYeDZYe70wXSe0or5mdIN4o2cgGUlEsLLiEmWVze0AC9E3yha3?=
 =?us-ascii?Q?YsxzHF1Yq4txxSx1TumGHIwyQSg/odZS/aZZr9pLpzbAVNCoAjBP9qew6nsc?=
 =?us-ascii?Q?NeCgznSeb9WhP2WAaiRQyD2r9GsvxO8/Tndu2Y1sM3A3JCvmaMwmijHKK/5D?=
 =?us-ascii?Q?IKeuWxn9OaGZ4oryk7DMgKcmaRjIWd0T9VcmJDcOQ5FWdcpBTHdMMtdIvXiL?=
 =?us-ascii?Q?bVgp+O9h8iVEJm5o2U9q773w/5OQrnt3VbxuKk1vnkbAr/HrZ7neMN6Lklcz?=
 =?us-ascii?Q?bz7GtSwz/Cg431vm5kgXnYAaJrhszAEAzEpp4mCmwarZLBF0tfWW1y7d2gcc?=
 =?us-ascii?Q?FD5K9oqCxJ1SW1EoglleYeYaFhhdgO4vaaWaTsfnNQ64iWW4w/MM+hs191EA?=
 =?us-ascii?Q?DNlxEd4O/J02KnIaOGyxc3E9eLti0iEwcwmpYM1G7Mcpc7VXm24k7aem3rUx?=
 =?us-ascii?Q?USsLu5IoLdfXfWYYGSbUmTRZgmKDcxCSEOQyPASOQOaBL9AHYpYGzHbxtyUh?=
 =?us-ascii?Q?SI5hKOswTOLxDnNRFtvm1SBakoH3q1RWFS13iilqn3tM/sqhy67cCnAzcQG0?=
 =?us-ascii?Q?NxpvZ65pLm6EmE5fIhPkPncARlD5WSznauhH3LJSqBYnZlPECo9gR9FJS8Ty?=
 =?us-ascii?Q?FOdQtyuDBRhaoPmKrL7shf8TbmeqgUNo5+8yVFZLUxaw5naXWNV/Pye1WB4?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJXy9h5GLn/t6swP2T8NyAa4dLoaWUoYF6WXuK3o3kKA6Ci1K7uMqX4K89Y7?=
 =?us-ascii?Q?5bfnr1L5u3BSosfFOHVkNSdI7e3vpXv5+FzTKEKOk7oVudBx0HYiNv0o1NaA?=
 =?us-ascii?Q?rO6sWRtN3OyzztHlhbjxEg7koESC/0G74lyNPreCcA9SRbGUe+0PTM0zzi4V?=
 =?us-ascii?Q?q2b8VT4usQZ4EQiURtZWRRRKLZEjhgqjIBaKwaBbxkSXxmInu8cv0WUQIuoN?=
 =?us-ascii?Q?MObnhPWhgWnXdzdeQdyu3BbrkHJ2Wzz49zJzO2idOJDCI0fpzD38pnhcjAhm?=
 =?us-ascii?Q?zYGgrSyt0Wqpu8UT6VABh1n8C64iax3L2GCDEPH+hYFztJJQCosAUGPHMeDD?=
 =?us-ascii?Q?D3SVGDz+CWYFxTcbNzZnf5YwaJeijhPkSAjK50ZC9ITYPJajhJv3p4ebGkyc?=
 =?us-ascii?Q?f77evQtkmzSMPltThQt+GT3iTM4n9hhVqmL7ElQ31k+bzmEhjqoNu93/hobW?=
 =?us-ascii?Q?7FmooYtXu1OoTQLmQidgyRQihB+NIhi77kVkviFcwQ7H8/Nomkpv4QNj8ixN?=
 =?us-ascii?Q?sZnXuMoVn7vG2IXzQmITBHbuSvcOg34M6OG44vjmZvh2+md1aW9PIjEU4Uvz?=
 =?us-ascii?Q?X4aB9KACZsw7suf5Tm9K6LcphVGEJQjW/wmCcxMkzircw6HVjo8kk+z1GZcP?=
 =?us-ascii?Q?4wP5Qr5h9SaKT2/i1r5Qxfi0yRqabrR7Fdcb/5wWTmXwfs4KDCQzDjW5u4vh?=
 =?us-ascii?Q?PqPx5FpsotJdR8FUqG7t/MsYywJrX8mmUtf0bq/R9Yvh1FtMUvsFgiSbepIr?=
 =?us-ascii?Q?epmPVCIapmzmM1YevZ3O6FmCG1noJ4MGgk6AhYPx4Gap0jVd97/izt+huuDF?=
 =?us-ascii?Q?c4PKOhaUfjfO4cY4zV88+cuj+0t9B1b7uNQo1Qq9zgMOlpuLYO1mzdOtq35i?=
 =?us-ascii?Q?lI+QLpvCYjMN/eo1tSVAsj8y5qmx12huDLCpivAu1Kx7dtN40Bg9US5zI9Pg?=
 =?us-ascii?Q?wAlGkfrSlRQEN8wtCuhol1mDvDIkQZ/syEsnOYTBDaS33yR3oSGY+AYGMsuW?=
 =?us-ascii?Q?Q2tBYBfpUxgeXkkjH60FKXzkZcbtcSzzOXy/aAxD5n4HK+IFjsQfPJE5VF/4?=
 =?us-ascii?Q?lB0rW5fbUUqnxnmN2UoTAWFqcobIpHHe8sLIfy0GbjXFjm0youUCkhzOUD6z?=
 =?us-ascii?Q?cWe1w3JRB36FWTRxNd2flyZeh6eziD25+6qw5rsSlTpmI6Q2unt3Pv6brMk3?=
 =?us-ascii?Q?x0K334Iykun+hOuCdzNdTjJ2uyTqb+tr1a3ZTK8xG348Rap4LLbgfUAw4q/p?=
 =?us-ascii?Q?SkPSawOiNApOx92J3kdI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006dc9e2-b748-4fce-4705-08dd3c639d95
X-MS-Exchange-CrossTenant-AuthSource: AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 10:41:10.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P250MB0730

In application note (AN13663) for TJA1120, on page 30, there's a figure
with average PHY startup timing values following software reset.
The time it takes for SMI to become operational after software reset
ranges roughly from 500 us to 1500 us.

This commit adds 2000 us delay after MDIO write which triggers software
reset. Without this delay, soft_reset function returns an error and
prevents successful PHY init.

Cc: stable@vger.kernel.org
Fixes: b050f2f15e04 ("phy: nxp-c45: add driver for tja1103")
Signed-off-by: Milos Reljin <milos_reljin@outlook.com>
---
Changes in v3:
 - Added Fixes and Cc tags, net tree indicator in Subject.

Changes in v2:
 - Updated commit message to clear up where the delay value comes from.
 - Delay added with usleep_range instead of changing sleep_before_read
   parameter of phy_read_mmd_poll_timeout to avoid excessive delay.
---
 drivers/net/phy/nxp-c45-tja11xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index ade544bc007d..872e582b7e83 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1297,6 +1297,8 @@ static int nxp_c45_soft_reset(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	usleep_range(2000, 2050);
+
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
 					 VEND1_DEVICE_CONTROL, ret,
 					 !(ret & DEVICE_CONTROL_RESET), 20000,
-- 
2.34.1


