Return-Path: <netdev+bounces-105855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A998913358
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD731C21A76
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2540D15250F;
	Sat, 22 Jun 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G7cpXO/n"
X-Original-To: netdev@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2058.outbound.protection.outlook.com [40.92.99.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DF4C8A;
	Sat, 22 Jun 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719055468; cv=fail; b=gyRH5hTL7K8oc2r7ZQ9i6Xg5Ypo+jpKpmQ9KhuR/8Dexrpbrzt3gV4YEo+Yr6Q/s1Fin3DC7w75IV/Rgb4+5FcYcBLx7k8Qydad4v9bbd7k34AGS0MIwtSLuDf7gtNZ7mhUlpyuPoXGzyU8e6y6hH9Ydz5JfleuPlj1s2pwjgFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719055468; c=relaxed/simple;
	bh=4lkQBpma7R/nXahZdpJ9N05R5HwCZucBxi4LWhi6il8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZsfXordEUcQHklPIPlc0fh488z6NxdMDtOG3qcacV0rMJgoIS87vp/qownykc7EgME5Fg/Om/OtJ/+yphhWJTORJw6m/izpxJGRIaOhyhzMI0+lwwXDjX8NYUwCCngGFZpFrDAezEpgGAH5l8+TBmA75rPaCWtiGwme9+2uucf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G7cpXO/n; arc=fail smtp.client-ip=40.92.99.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNtgPP6sDotfjJ8fLOuy2dnEc1lBdJgqCCOs2/zKKrREe21PVQwQdMuLttlKRG8x/V2jB2IMAq8/qZ5YgUP/nnYoU4vDSUYzF8tmdBgboR8FX0+07/DqFAVzSC43EEneu/rTt7C32BHlix2etf3jvUV/Sp8hQPsgCZG7Z8vrlXweqPetyc6Fx9ezSvAxzHh7cJgbc2JLbmJJNqY1XR6v5MAqt+aPAqvnKJBgTl5WxFSTjUK4hXEMOdVQ+zPzfBh8u7yMHk/e+lqm+lwsTuzg1OOddP5X+84H5f7KyEo9fOMySDKk6ad/kqfyc0Y3FZHl7VLBiqPOaf/7AESwPs2gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Ou3XU/r2FCL/064EuYVlzcKrl8jpJs3XlGf4f1DTg=;
 b=ixpKD2IdEDGXcv9ozCaiaMM6h6rNKNcwDHXiCjfj7Y4SzwbQLlqin+oBQmwhhwxtj6oCoOGrF2pdl55J9m0raVvP01Gcp5nrvXtay9/oQn/C128ticzD+rYpy82Ghd7nLnobWYAFfr6a4iDETCpbwRnrMnT/nfMXO6kLw0/38Q4SSS0npwN1UuT0lmXR/hb/2No8A5Svro4n/fto97Unyd9CLfCWwMx9i+RfpxvCuIw9srprICGSVPyHfqvYpa8sd6/fEkVrzG0Lv2WRlGKs5J4WofLvghVA4myRK+43onbacZonx+GcQ8DINJKHcwdDKA0KD2L8ym1+F2W/DDEvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Ou3XU/r2FCL/064EuYVlzcKrl8jpJs3XlGf4f1DTg=;
 b=G7cpXO/nagEk79AqmbUVhEnT0OBIaToHf+pjwRcpDHRbW70+AL+Aq+w8i0GinGKAZWIQM+0TBd5QV2p2gyTh+sUzXrbHb07m6ksrnzSkkHq5TgbQU9giFZsYfnA9AkRTqEiyMn5IC/jN2ZfVe6NBht9LwK0MgN/tfNub/DtsdayVgZ5PepZjor0WCF6T4vI3AoI6r3jvTywTavADh2s1bi2dpD/7pejkGb0+cKH8zwKPSOpROlXCxcwwVKgnvn4y2E5MguHU3dad4j1NjPEpRU2OKa2X4Inpk1KBcCFwQmVwUTPUfEhx/wfRUSAd4Z2fH5+1HVI6tiHsZomjgyngbw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB2732.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Sat, 22 Jun
 2024 11:24:22 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7698.020; Sat, 22 Jun 2024
 11:24:22 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Elad Yifee <eladwf@gmail.com>
Subject: [PATCH RFC v1] net: ethernet: mtk_ppe: Change PPE entries number to 32K
Date: Sat, 22 Jun 2024 19:23:35 +0800
Message-ID:
 <TY3P286MB2611CC17BC0A189DB15620EA98CA2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jqsQlCcneTcWQQbAMU0D17XP0S32gX8/]
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240622112335.11582-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2732:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a09f81-49d5-4107-4061-08dc92addd31
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	z2ZidqDgfbnMKDg9rVByfWA5bR4EJN5BDQ3xliZCdhP2WdkZHfhWVHoRK8eDkcKgunrQgBmBXuymuC1DXtto7dwzoxYAzls5G2YTf1uG7PEAGq6ZZtHjDaBsV0MshJSdPGOK8XHZNDF/WLa/Hen4UV7oqfpqTpA1SYF6Fgug6IzM/uhkNztxP310pgTrXvOZgPQ/ZRKhvE6q9b9lA72GSW4ImPY8hVpBONmfapMqG7THA34Z5yrPxs1kqkfJrgAxosCdNgZ26fTuDSuz0gzUCpbKjmKXjeTEP+FadNS1NUlJs7krNESrovRpan0keDdRcGaOswyQE/fztux2rTpZ0rjMvUl4kiRpYPintuMvNKH6pmCyzNDKzSydrg35NO86oXOZzcU+roZVuiM5yiEQJMsIRZaRAb3oriakKq8GliBRWNavoFAmkipXTIddFJVDKMBV/FceAVXNxAt0H3/zPmI9j1aLPVACrzHTcEoeLUvmHn70BTV8sftkDeDvjpcfDpFJ8NDwbG47RwG1y8VXPI+K9/DAwiAJ8hC15eKlyK4I/8BujXnIBu4du+N3/w4RvIg7zGTpXF2/Ax9OUBzczgBSbzgeDsRX5nHfKAZUmIg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLthdH5EwZLSqYFRJmeLW8r76+hpZSAz31VNU39ZlC0FbGJQpPApYjOaIhC5?=
 =?us-ascii?Q?NzCUrFDzlal3C1aZGgp4LnpgxK0syeWz9pLU2V+5kjns2lXhPjDeY+Tth/5X?=
 =?us-ascii?Q?bmi9Y7CrmMlDnyhicSk0pyiM4UZ4j2MNnkgQzBZSdoOvTwtmawHCwxNFlvCz?=
 =?us-ascii?Q?hMqwiO5cG/u1MdfOrvqCmrpV1lUPwef62oezZtE5ITWmy+VatlknC/jnY0ML?=
 =?us-ascii?Q?AwHTPPT8M8ptKQHClCaEcCmg+It10f7Xqfx9tCuF9/5t9D38qDSALnNVRiHG?=
 =?us-ascii?Q?oLkFgEWztogqDXeV5ISqa6BjJbtd/gvXaFBFTTr5QDW5ROPGhx/pwZXl8EWe?=
 =?us-ascii?Q?efT6C7kUrlV/5jy9YPtHIqhfRoenCEeDDoTQ/2bqNYVti2XNyeGHdqyh6U8q?=
 =?us-ascii?Q?3DcWkzGKdlVFIqdyGlJgexgGjtKSoJPgSflhFv3KXumWHslTuE7yABT3FJ1D?=
 =?us-ascii?Q?I6zJ0rvyJgrK/pNkWNp1SzGCilfJUoZT2foySP59FIoCupjowu9X3kR2K+EF?=
 =?us-ascii?Q?4rSSrLabsWTVibVi4ephuH5JT3W07nUesZZCOF+2agAgi9LPwl0yudWmEWGw?=
 =?us-ascii?Q?uvVsB9sxp4bq8iZvYUa1gN0eBwVALm0wKJUqSkKGvn0dCNZUDeg5WbAdtzTk?=
 =?us-ascii?Q?PQN016Ffvi0k/9iHsYiguILmEoAiYoxb+f7IWHAxAEnBbowuA6ZMjzlFLa3h?=
 =?us-ascii?Q?kRmIHM/+kA/dMh1BnhJ7jcb8ItsLsoJW3ulGANbJ1xReRlvpgU3E1pHDRreq?=
 =?us-ascii?Q?oDGydtQr/ubO3TamDyxUFLYqNUu9s/G++pT4BGf2PGAYA+xTIiRND+aIwH+W?=
 =?us-ascii?Q?rfeujsVKWdFrOoagU9U+b+ad4F6h34txe1M9zyT9rxs/n2ZpakZb+PH+Vjnl?=
 =?us-ascii?Q?gyZkTWShuETxAHOA+FY30+2laP7+t5o0MMdiDsx0S7RcFTnUg2vYeNfwgLlq?=
 =?us-ascii?Q?7oWpcBIN3ksMHxJfUXn4kgFrKdVwhz6JVNTXG0/iUoGzlFdTDnw2INIPMqkT?=
 =?us-ascii?Q?Lc+DehzLkc8T9rkEUcjvIyp5MhMm8CRxJHNI+g9BSqje3lepCWmaiCeoHsIk?=
 =?us-ascii?Q?WWoN6ol1az9ps7GN0mV0Ss2Fs8FLQMshJOlejn+I2nJ8jaoAQsmNEndXNV4B?=
 =?us-ascii?Q?A9qPKTRjhzfibq7i0N1vNlSaYekWZO9mR+r0iq+K1wvgo4iArgzLkCq6eGC6?=
 =?us-ascii?Q?xjfEeEg1FyzNkVbtqA0DORmwUZQAhdcae7W46tUzV24ukOISwwpTeBDNfeM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a09f81-49d5-4107-4061-08dc92addd31
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 11:24:22.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2732

MT7981,7986 and 7988 all supports 32768 PPE entries, but only set to
8192 entries in driver. So incrase max entries to 12768 instead.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
This patch is set to RFC because I cannot find any documentation for
earlier devices like MT7621 that describes their max entries, and need
more information or testing to find out whether this patch would work on
those devices.
---
 drivers/net/ethernet/mediatek/mtk_ppe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
index 691806bca372..6db85d897fa9 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
@@ -8,7 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/rhashtable.h>
 
-#define MTK_PPE_ENTRIES_SHIFT		3
+#define MTK_PPE_ENTRIES_SHIFT		5
 #define MTK_PPE_ENTRIES			(1024 << MTK_PPE_ENTRIES_SHIFT)
 #define MTK_PPE_HASH_MASK		(MTK_PPE_ENTRIES - 1)
 #define MTK_PPE_WAIT_TIMEOUT_US		1000000
-- 
2.34.1


