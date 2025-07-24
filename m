Return-Path: <netdev+bounces-209802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228DB10EE9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B95D1D0141C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B573921D584;
	Thu, 24 Jul 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Dznx95Hq"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01606279917;
	Thu, 24 Jul 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371772; cv=fail; b=tUK+TC8aaJ1z19FVu3IPTqfqzlCY6Bny7UVu97gT7YcUgBpPTWt5JhYWgOhFeAqr7H1KA7G8Hg80JtmY/tdadzpwkS1Nnf1iYqwXdWn6OcawOCOlsYab+46cBX0RewLC26s0e4vmyGEOZ9P2OX02/Esq32y87rH4Ey0xn7SbHJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371772; c=relaxed/simple;
	bh=KllwJGZ4fCt/vfYUydFfArgniD6edYj93oGNVYxZGjo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PR0S84+kJSAfuh3X8AE+hGLRngg31JvB+tyjyY4xpfPZbWp//Wqs4QzxMG7goo0TWMiO/ClByjS4h2s36L8LfyrTUWMC21l70hCJzdLq14Kef/r/hHCFqD1Jvs9ERBcHrNdv9fkP41KUihxOSgl4kBnLUI+0lmXOG596SfwrDz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Dznx95Hq; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5/EoQrxl8y1yogpSaEx/1ERYj3LZtmnPtFgK00zkQuJnO2jPNtf6Pt60kqBImb6hOHvHBnsvozawcDJahlqL9pDuOoJ27OHpj+ix3ik6+U5ucq2rqmvbuJ7Uf9U/IAXaUZIOj2u84uBF/bXrDcmY1SKhW8RgNnE3N7VX8kMuzRaXzxFd1LrrKaexVdgmw340XEwG0VMJoOTJlnpObIf7mTqvxd0s+GOIckM5HEhrkG5QJ7J3AWq3e/lrYxgVWN4A4Bj44OHhN3O3F2jYojGfgUUJ1Wm3/qMHl4/KuxnOQL/VzGbX2mdwBNj5UhgSKSEeb0dA8oRYVLXotfFy5xTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2D2qRlu7+nzVUuCmx1L1Sd66h6oIYWFXi5tUkc4Ok4=;
 b=DFMFHbNCFp3HlNNa23ikhL8dVfM0t3cuhHoVTAvtvx/VoSuBRQlQqtQyrcUqMFTOFaRWi1TvJg4mNG570aNm/ufsGOYgXTXjDPbvu4fsk77jZcKegRrQ7Gysh3Vt5H32sQM8NyIl073MBKebKFvdKJFLDrSsKMJ6NlD8qhVFgYmfw8vTZLFYA6Lp8qvWIRMCTGHp9J9YuuULAK5ymYWNOvG9+s2Kw3MZq+5aWZL0qtHtb/PvLgh/sbimlH0Ca7ecTTEBTPGjk5z8t3oYcXw/DxjztQP+mKVZ54YztXDpnV5DJclO0tM0M90rgg2lWIuj6P874D3arRHUI81w+Czdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2D2qRlu7+nzVUuCmx1L1Sd66h6oIYWFXi5tUkc4Ok4=;
 b=Dznx95HqwibDLo/7LLEP1ziufDiDLh9l8nhNcmHIRGNpcFqZn+cjxdmJJWytaQ3eOvAJXHgL/wDdeoWiPRRbIirSaD9TgNN1BJnTnIWzv+Q715ehqAxBHX/qTWYewkFdjGJrxD1zWaNAzSUuW9YECMopYmLVnHB3R8STWTKmcM+xc973Ly4q1sQeIzN/Ubsbhqm9r0uO6AaSJnl/9egadN9kbdaYYCf/RjFolbSsPZqgDMOZoF0eP/7VnRCL1nCJaenX50LWykiFkUmXGIgKUbjo1T0xpYOdVFoysVKcNrIvsGfBPpORMoOlLR/ZpcuvH7mbz2/ZpmXBCmNr4fM+6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA6PR03MB7735.namprd03.prod.outlook.com (2603:10b6:806:43c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 15:42:47 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 15:42:47 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 0/4] arm64: dts: socfpga: enable ethernet support for Agilex5
Date: Thu, 24 Jul 2025 08:40:47 -0700
Message-ID: <20250724154052.205706-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA6PR03MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0537b6d0-0927-47c6-e8d2-08ddcac8bd1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MktB2gteBBp1OG4/HyPJKcV0mX/dPMKsAhqcDVNM/o5gS0MO/g99MmSj+91+?=
 =?us-ascii?Q?9doH++xUexwFGvkiPxK31FJjxBdwDBXNX3nxxoxZV2q/gbvLLcWlsy/WTSM+?=
 =?us-ascii?Q?HPW/0ZCkNEfJK5/ynUequNXIQXXN5s9ui8hbcyZAMwVmEZ29YONiKWUptaoG?=
 =?us-ascii?Q?h3rGA6RTxrqj7L70YpjvD4ZMYdPL9KJgWpqjcsNoJcmtJFZv9W0No67fqFkv?=
 =?us-ascii?Q?kwyLIzzG/zt/zImM+giKZo05GVIAvmvOrjsMyWKDqxpKfdJbsR1leeyJWeGx?=
 =?us-ascii?Q?ameC+BAaguqcyPvPnLl2/dKQ5myMF64nJgcE6m0Iy71D/RnySk3fg28sDMzt?=
 =?us-ascii?Q?BoDuFPdyIQqUpdsMb24rAo4mTXDTbx7P4RRMrYO03ICrPBjwO3zqmK0ExNXp?=
 =?us-ascii?Q?9ia6YseqmQurVm60jyFMwUFPue1odbC582sJbzjtKuPxof2xzfgST55NfyEE?=
 =?us-ascii?Q?hL/cQjOVh9gbdZ36gUqmJzWUp9LO+A2mn3Oe8ub5seI9pSxjmhdG2niIU8Jw?=
 =?us-ascii?Q?4hSSX6qPJDv4nXOrA2hja1pRJ0iZBM4IngrX8jVBnF+xKBQkyHc1XLtlsLOD?=
 =?us-ascii?Q?vu0SXmynLWpfOLCC397+dzehzwHmq+4Br6XCc9ocWGW9qUMs/C6GbAvLDOSY?=
 =?us-ascii?Q?5iLoXtskGj8hNJWYMOVzQviHBd9n5UP/d87+GrWzHcaCO0Ilk/eXlnnii5zU?=
 =?us-ascii?Q?CN+sxTqJ5jJGLPraiN79qdc5uKfJt5nmPeyIlrTQYTbM4d9xafYPNWbV8IFM?=
 =?us-ascii?Q?s98R/32kmwmQbZEUeF8BtIa3oPqhxFOdTEb417A+m7KJkhOK+3NgNE8iOXlX?=
 =?us-ascii?Q?fL+Tk7kHD991fCPnynzhLXNYl4aHwThwABg5ZXSuTNQFqVZp6kZqHgvm2u4c?=
 =?us-ascii?Q?4jChcfLPb1X0xdtPByCk9z/E37HSex2ySI56wOdT3heBmDn8czBg8if8pwJJ?=
 =?us-ascii?Q?enqf8HYdA276uhVnpqTgsf8bxBkHydI1MDo42CwuTRGnAcGUB6FH6IH2D8Td?=
 =?us-ascii?Q?fvxl7VQxb/g7968xb3TjJ8N5AgTYq9y+JH0FU2TW965ukyE/9ESyogVT/ewp?=
 =?us-ascii?Q?KsDeKNFN5rbCrwQFoRSOJpsMCHiTk8FBdfzidUDmfK8iM107jftF37MFVjph?=
 =?us-ascii?Q?Sulu/SSpP17LnbI2Tjd8+v5zcqk73usq9q5Vb1eVAbk4AQuu6e5eMTSbj/86?=
 =?us-ascii?Q?xVR9Vz5Iw4lGuQu43Wju6dLiRy1FHxWje2pKOzAUeqWk64YgR1+SXMJXQuYJ?=
 =?us-ascii?Q?xeKnXOsDYoTIK+B7i1qtkxXyprORylJ63E67iFFSozoGAIqSh0gxGP9dt4ff?=
 =?us-ascii?Q?L+3lhe6gSFRv3Az/nzS6ifOBM7ITz5He8Odvv54NAt9ce+Hcv/H9DTuPFu1Y?=
 =?us-ascii?Q?rH4/xLMf8PbzRSguI2J4gWYwgvAci98+hDpB4oLueM3QV0Ev2jXVSDLCPf4q?=
 =?us-ascii?Q?7yXGr4LPlFbITiww/ec1A7wEtDfBUhsJt+TNizDV2137G7ttFxDRhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeaO0Ten8Izxb03pSxqGQRVNiZ1TKKmwfi56ML/MQbdJYZpJxUUKIgbCZy6w?=
 =?us-ascii?Q?jP8/WJoca6pTnzOiy447m4rZuTOSj3YixHG+WVMafn6xFAucNpSGuQioYHA1?=
 =?us-ascii?Q?qKsynxZ9DBi9dl8g9dFJDfh5sKnZvzca9BtOeAXNw7o6TMzh1BcK//ns4WC+?=
 =?us-ascii?Q?VS8frfZNnvv3CRh5ZLn8RuFIjJH4DlnUGwHmKgWeyGUJYQXQCnvUEPu0+OA9?=
 =?us-ascii?Q?Om8+L8Z9O69g9RCKn+xEiz/78U8KibRXHW7ah51XwsO5RNOGWziXyv/pzf1y?=
 =?us-ascii?Q?+OiZ4l3W0u1M255vYTJhxbqrlRcwRV+FLZFhNDf3+1sclLN5rdbB23m78lj+?=
 =?us-ascii?Q?CiSK4BdKYxBRIX+mCYbZm4Rrt/C3jOyHuJo66aaq3eDLHVcvHqpnHy6Wi5Gk?=
 =?us-ascii?Q?jfkIxN/lB9P/0viLnl0hY7kdowz1TixWBgsITNbWaNViH0dDgCQSTe96brB/?=
 =?us-ascii?Q?XKt1YGtanB26S++DsVMHX9wVTTgvLGdh2OcTwTbm4QDFq/5BnKKC2youazdm?=
 =?us-ascii?Q?XmkG1Zpb+D92YURb38D+NgO7jQz4L6RNjsI4DozhsB62AhfIC7ZckIvGNtOx?=
 =?us-ascii?Q?kLxQwc93X5N3q2O3EmW+yVS7TApzaImYjkMTcK+7p6ewz4yvhdb6nynletZ4?=
 =?us-ascii?Q?tFMfwvUD7bACXWuBlEckfuCtqbS1G2tKsRmSQ9I7+44YIgbr1aM3vZnRICet?=
 =?us-ascii?Q?cEIuafzBVBuliqvWhqaYe0XCSWv5OXhw0E6rsrx0j3q7TRv+LVkWzqlqkwZ2?=
 =?us-ascii?Q?du/Az0po6UAZkQ/SFN1/RlTGFHNoNG1VErKikHBmznUKVk4sgBKycuoXzz/S?=
 =?us-ascii?Q?UFWM+RMdsY8Jidf3fP5JpBblVPxS8aZx5a67Hi8iigdN8scDJf7gRovkYyw7?=
 =?us-ascii?Q?03/EvaiEZtsaukeAgoiyDnRVibhq+K+GUJXTynvcTX+Hlg7dSpE56/zK/yfp?=
 =?us-ascii?Q?MRzp9712EBnSyTzPUOFhQLRFzbXjQA+G7I7v1x7MyHlkOFLDPqYX/x+AjnBx?=
 =?us-ascii?Q?SPcxR4r0KOzaVcF3gi1wo522F8NUCUlA9J4DAJXvbVtmwEPkGrXxH+P8BYVz?=
 =?us-ascii?Q?BLyEUzmUFVibtiirGSV6x63CWMvlPS575qr7GfO+aDHnV7yVYtj97IGopXqW?=
 =?us-ascii?Q?K2O8NhBiAPUQn6WetnavsaRXS79IAWgohpaXZKAALHnq6cQ4oh2iXlwIMC0t?=
 =?us-ascii?Q?91JyZU5Y+ydK7wS6mRsdiWZi+xQkwpRL4o1lQBnV/gJxI4aEZn4GOcs7SWxg?=
 =?us-ascii?Q?vif9PDpQ6AYl6z2gJw59s2+n/iBfcmiRZULPWCBvsng2PB/Z5kIUmmt2clPY?=
 =?us-ascii?Q?VXdNiLe99aI5K2111CYDqm6ER9SDzCCdF6dIo3s+Wmt8EKJwftr5ppy9OZ+X?=
 =?us-ascii?Q?y9jbWJ6QNBWwRIep0+KZ4OGRvnKVPWxRFxAorILq47Q759dXfBVKpPXCApNj?=
 =?us-ascii?Q?vH3MlKViu517cDbXPg/FMaHUCVSuMkw6g7/umgQhErYWUDw55gMwGkvy0i0U?=
 =?us-ascii?Q?Y0CPW5jADFMx1cEGPSzpHBa+6MMavlmV0WdcgaIB35dFaZN1EFZtUSPZN1y1?=
 =?us-ascii?Q?+OxOOUDUvcNp9xY/tj0gpjIZfrcx4TS4hacLsFb8qk0e6RafGfXo10RAOidB?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0537b6d0-0927-47c6-e8d2-08ddcac8bd1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:42:47.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCljc4Frc4QgiB8IFV9oayp8wX42hb1/wyHjKrOfNsK7Q+RjTVHaRajK5SdOX2xDmhUnMVooY54+AxEVHYJteD/0wdn52eR7pugdhBtNuxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7735

This patch set enables ethernet support for the Agilex5 family of SOCFPGAs,
and specifically enables gmac2 on the Agilex5 SOCFPGA Premium Development
Kit.

Patch 1 defines Agilex5 compatibility string in the device tree bindings.

Patch 2 defines the base gmac nodes it the Agilex5 DTSI.

Patch 3 enables gmac2 on the Agilex5 SOCFPGA Premium Development Kit.

Patch 4 add the new compatibility string to dwmac-socfpga.c.

Matthew Gerlach (2):
  dt-bindings: net: altr,socfpga-stmmac: Add compatible string for
    Agilex5
  arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit

Mun Yew Tham (2):
  arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5
  net: stmmac: dwmac-socfpga: Add xgmac support for Agilex5

 .../bindings/net/altr,socfpga-stmmac.yaml     |   8 +-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 ++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  20 ++
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   1 +
 4 files changed, 363 insertions(+), 2 deletions(-)

-- 
2.35.3


