Return-Path: <netdev+bounces-106403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6F91618C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6FF286C6E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537EC149C7F;
	Tue, 25 Jun 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="pdWtEZ3p"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2184.outbound.protection.outlook.com [40.92.62.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63655149C6A;
	Tue, 25 Jun 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305150; cv=fail; b=pSGXUnYdGIcDYU1lYSCTIPKnSfBqlKx1N96xhYS9vnlYOP9q9ukVdkLxedw+v6XTBE2KJ6MDzfO0td6IdK48kJReUU6ABf6brE3IOYfncUvpAOU5VVzjM0ik8E4N/BunfellhmkPzUuCLkfzUPlLdTFRgDVj2E2DOiAcQtRW/zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305150; c=relaxed/simple;
	bh=fzKX4CuHYN0JPd4peO5nGGvUz0sGVYuorFav/iN8lJI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iZ1MvhgHJwB6/wDQJN6XPaAfc3g/XVL+Dt2+9u4eYXGFZ+/XQce5nCm2Dd5j80GCY67yWZnSJUewGZDBNbKZYv0pvedlbO6K/vbZuWgy1bkg42fGF+j8Xf812eUtV+GwVbhjkH79cfupRtaTMmLvbx0RnGhrBvCygWJy88DliKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=pdWtEZ3p; arc=fail smtp.client-ip=40.92.62.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK/bqbzzmKgg5wmmSuoPU6wiisbUFz06IboauDwiMfcoM7gT9hAxdjmStNteAGqXs5kOYCQgxrcBLDoB3TN203JPCqZaK49RlN37ec0N0WHXcELpbu7rSW7hlFQxTujCxQRJ+mOWnuYOV6G+I1fWeFUUBECAQwkxq60wE0r2j2TMojXxAQMI/tFz/mPFNyv7JpKlpW9Th86jYYkJ+csuv/x9MlbMKf3nR4sAhSKhMyt4sJaw4NDk8oTm176JDX6he3creF8OIwpC766XJb0Cr1NQVDLQgIBbl1mwqfg8Pvy44GNoTV26EHXuClJxnwVI5ksbBEK+HBlDO7bx1tgUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAWv36f0yK9ESFbHAyi0azGBJWZ2yTxKwk2cDS68RRg=;
 b=OY8WuteqK32Ght9+WwozjXmsi5SGxRio+brs870vxe23xuu3kwUuIotCR9w7XU9RZZkMg3wkPd+7Oi6znZzWjk7fphjx9PSOBqc/9O+/RpzqOe19BzNr4qsYhnGgHb7/pw2Jz/Y+JxdkI/6zqFo4dyFFubp0hWCPe+/LPZ/RSblwNFwppART2rXXH+RgTEQX+5dUUvswCgjdFfknE10+84oeKgT12Gikn6kUmUWxENLtGM6/7/U4QbPVqgwWItUjRlho5nBlV+KRb5x9CerEj+ehu1F+pJUUcUv6gj9s9tH7rLEIP5W+chjE3qyjn5FmVznIIs6okDruSsMZWWMibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAWv36f0yK9ESFbHAyi0azGBJWZ2yTxKwk2cDS68RRg=;
 b=pdWtEZ3pX+vRtEB8cvE3bMqtOcjWG5/Yz5gHnc4vMgkrosoXjUsl0dECwUe6an54lJsTmeWlHxx4PA5moPk7ENdSlC5MsWdymflYvhIGdFzNffxi7vGbifU0Uxu+svCECCSrJDtS2iIfHMiAPznXZjFxO4+r3gZrf0z7XySpN6Ur25dw25ygbJDZ0B+9t80MehU+jYvIi8C/MrOXKAly161d3/tADoS89e+kgUv2lZS58/nHicLMDfDwQ7Ip3jF50zIVFIDYDtdv383Q4OyEQTaKcpOs37XCulguQtcJFUwmxV45idsOwpogY5I0XJpgLYnfKJu2H2RrP/KNbKwiuA==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY7P282MB4874.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:27c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Tue, 25 Jun 2024 08:45:42 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 08:45:42 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jinjian Song <songjinjian@hotmail.com>
Subject: [net-next v2 0/2] net: wwan: t7xx: Add t7xx debug port
Date: Tue, 25 Jun 2024 16:45:16 +0800
Message-ID:
 <SYBP282MB35285822CB2270DAC2533DF0BBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2j316tD8sXLtd/m6zyLY/PGLGQeKt++6]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240625084518.10041-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY7P282MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 690827fc-21a2-4428-6ef7-08dc94f3326e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	BwdFMIhcAD4xzcS79DzJnHd5PInuWeLXyygC5Ct/rD3q9BDFkhZ1XR97NblqXTmeRupDyfuQss4o2i8KicQ+h4ErtcBcL4gdJjA2x83L01DkdzPyUWUtxFWIrckpQP2iVGWM/8NUMim0wxGSGF43T+h61F2Gm09cCfoqO26ipyut+oxXi480UT185gCVrcni5QPU/WBwk9oCc/aAekleddid+loECaHWdC6ML6w5tMbKc5ECOhFtkl3wMfyGY9OomnrFAUNb5DW6jZxp4KoADPEqZbJPxUyizpY+e0yp7OrBDhWGrQcSFWh9kDiOco4b08jH/8n8zWpp/1675H1FYWm4u9+TEiwUh63x1vssHDonH7570/7Z/Clc14TqfMd2AQqiUO2sBuGr3b6doReDJADx2XBi1VVLbPzC8HbWJVaRZ67ZN03Q5FDd9JXb6QRTfeIrJrVgQKg7Gt6bVAVCRT2XkFEx1PMssYoEAs9mMN3lXe5qKQm5xEvwLArVAC8UtiQZ3d54ixeLyFreEy+ZCdwdH0MnRG2ASyG+ZU+jhcYbjnXQUM3Z5H76mG+utVzYt4fmaByxaLj0/lkF5co3bTJKjVT43gmCkMTLeloB1nKX9zYGhiPyLAquFPQ8r9eb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCTv3bilCZunXPebwrfZNOzHRhfCJs1pLcksNc5Ryft0zx7dWKdfEsAXrv1w?=
 =?us-ascii?Q?gD7QmoUu8SCRF9wT0SlfNhtVJx46VY/bLo2KMdYWrt63SR4vF6THCeM/gY/f?=
 =?us-ascii?Q?92ow2GSjLmLtnkBNow89nA4ZFEQmOSqDINnwIfv0PTepNmF4zLrqUq4cLUwr?=
 =?us-ascii?Q?z6uyx9xjvScs8CuG3wJqSrTOTa5OlbfeUdubTiTRtRSIPvehZbrvtm83z0qf?=
 =?us-ascii?Q?ZPSaYnM8HdgIOcIr6fNFVu+i8rJ1SNq/t1yn7wLfdGA/gvKrdSDuNOHIopwQ?=
 =?us-ascii?Q?WmmAyVoHS+20+8cpbCo2Htvpp9mBBE2dA/TYkdPQvcsJHCScflXEX0p6Bx7z?=
 =?us-ascii?Q?UFiJwXOjRM3s8ho7L77IOLw+LYX21xJcmFRRO4NzuKdviysEuNnFLjC1sUy1?=
 =?us-ascii?Q?WV2q1H2CVG/XRMMjFFA0U/4SXjJ3FLqMZX6EnRpJ8n9bMjdincSWG6k81A9P?=
 =?us-ascii?Q?0AHyr4o/xDMdNEl6P8Bn8BzamRs1WkcFKpnu7lu882u6KC4dKyJMbFRq2GNf?=
 =?us-ascii?Q?uraoKukwig0/Mt1s4z8TCtx1CcqqHXiF3UhxUejDX8LgMKDQ53hcCbLfxocs?=
 =?us-ascii?Q?9ASemxl4pmFfpmYJ25TtypEQl8TzUH3kasfH7zDVmPRH69/TidMZBKPkUy/+?=
 =?us-ascii?Q?iyjb0p81KuHwuXMe2AYGvaiaVNvkw+FxdGw+n1PL5z2T9wWELYrJg60Iswct?=
 =?us-ascii?Q?n9ChHT/VucYcalXQYKIa294Q96JTKWaNdk/JQaYJFwysx8zWi5BFLWlUTaXR?=
 =?us-ascii?Q?C0p/bV46Fc0ZsB5flh6I/O7EJ9tLuuCgO1dXy1etLPYtV4qq0yHYdNnZcsFu?=
 =?us-ascii?Q?hjQlis+X7e4HwtjQzyQPGL7Txk0zLamWT7QEvZewewD8a3PA8D99I/hsyGr+?=
 =?us-ascii?Q?i1dhlPneSA6u0j5+iqsHi+PZmMji41GlUZlEEJSbdBdP3SQjMXaBFopwPkzX?=
 =?us-ascii?Q?FHcQp+be2OxQ+AWolM8jyfWMYDwr/FV98/nK7ZsoYgkBhCF0K6ZoXKM6mjZo?=
 =?us-ascii?Q?mrddWVqlOGPZ9umBhTI4uS8m5C4O66bHkc9S03N6X9t9nF1o3cTiAR8KMFQ3?=
 =?us-ascii?Q?6w103lvaHWossEIP3sAOxHv/+rkQIkRhVJzO1XafPBsQ2JpR8qdIy0iJ4Ut1?=
 =?us-ascii?Q?A44e+kJUkmYJNfWzY2sNhZXIOJ0xdSjOBQNS/iC2HrzSiImGLe29qe0bjYs+?=
 =?us-ascii?Q?dybbNXyHrXBhyj7drdJjQdmhQH8cT0qhHDCn32f6DhULC5XpvbY61fxs6Q3Z?=
 =?us-ascii?Q?E8Xps62WGlcFXVTsVTJ4?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 690827fc-21a2-4428-6ef7-08dc94f3326e
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 08:45:42.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4874

Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
port and MTK MIPCi (Modem Information Process Center) port. 

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

Jinjian Song (2):
  wwan: core: Add WWAN ADB and MIPC port type
  net: wwan: t7xx: Add debug port

 .../networking/device_drivers/wwan/t7xx.rst   | 29 ++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              |  7 +++
 drivers/net/wwan/t7xx/t7xx_pci.h              |  2 +
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 45 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 +++-
 drivers/net/wwan/wwan_core.c                  |  8 ++++
 include/linux/wwan.h                          |  4 ++
 9 files changed, 103 insertions(+), 4 deletions(-)

-- 
2.34.1


