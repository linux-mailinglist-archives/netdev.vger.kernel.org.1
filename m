Return-Path: <netdev+bounces-209804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C807B10EF3
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF25A165990
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF852EAD06;
	Thu, 24 Jul 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="SY8ab35p"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6392EA754;
	Thu, 24 Jul 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371776; cv=fail; b=k/DSmSj32cE69hY6+n78i6m0KlR2DrgWBt8NeQrjLcFWbyRxYOWX9x1RG4/M0D4vpjTjd60TsZOQsW/s5k/xplTjLz+4tQKLljoXXo7zqgkUbTcOBFwy3U4Dr9uzo0T1cur+MYbIl33eIv/4uVBzJKZNEV4KQlh6/E1+UbXE+BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371776; c=relaxed/simple;
	bh=Ib1H/Ry4qfOJAKOA54MrRD3I8y/XYkTE+T+Gs/jp5SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nr3ew8p1y1H+1lWReEtkKJLNhCDnwWCwbOFlQRfQGuQ5iM0KDPEq4fyDJjy4zYg9jbyLVuFjHqVxW+OuhmnjTHMBsDuCAkbnpP27fRaIupgIBtDQM1RCu5LT1BwviOXC6HssuNLEPbVxX2kMdCkV+X2xg/AsKkEqJBr4WvQrVQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=SY8ab35p; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlNkOO7I4Zg8kBhyc5whVM/x2AoIJ+qGskhr3xGbgZ+HsDO3ul8K9zSNUKFMNoqmBCtJT/w+0kDvxVxNDutuIusF4I7S45/TH5Fw5zY/BJdW//1J9qV4BotgcJvtyOom1N7ANA9eGGchHC1FS5xkEOa55CiDTB0If3ZOAVGzfG0FwjK6iPu0OyIcXJr2P6jILPwh4vS0TwNpkNKYbC7wEMUDWXwXdsxKKtxusln8MWFOb9xdVy56Rk9HS0hd0q/iYbLxij/YXB2r8PW47iAtdkstiYgWDCzAcJ1uzmO8awffosBJ2rEdrRmlukpISzxxw2XRXcNwPbpU2g910uV8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzGyEhUdtsA33qrC1/OtAG6Khtbfqjs1CP93tP70VJY=;
 b=ZC+1xt7Feu0+qhrg9mn2R/tZidWdHE3KRmrxNwvdo1ONx0RVs8xRypCUNl/ek2OZOR4SkAohGtHjPx64Go/reIYUERxPIgc3FXWmGa4kmj9CPlUpi9L9TZWj2+d5BodXFy8JvHFfcc/4sOIfiE++VtI6p1R4Sd2Dyrdx6UQ6h90unWxRAsHf5kZohpObhSXgAHp8wv94UaHng5ka3W7gBtLYA3qLPXxYnHiAFc4PsP7OOpdFOXmcQN6Nu5hQp5Ss/VDyKX/RyovUc0OOUdrYwKbjZnTd6Pam80iScwUMKTBBBK7JXChBWSaYUgks7nRkRXEvfMeBm+rSkg/8A8bjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzGyEhUdtsA33qrC1/OtAG6Khtbfqjs1CP93tP70VJY=;
 b=SY8ab35pniwfGJr1s5V/xagFV7TrHiu9JTKUrIvCvitaT3miJBTF6NwYGQjuJwTCbiBiNvqEQVI+vWXTl5uNzovVbdOPg77TDPoGUzV3H9ZhYroVMC0+TvPZnP+iPNRrZT7aiRpzQNpq9pG+vKg/tO6+7brJKZ9rVgAFAVy65mnyI0bwgcbIpTrI50vnxj0SWVCabzqXWTl4b+Sk5bD/cpq9xAyp7xOflJSJAnlLqBlnnucIUf3yxGuqK1RQPbXKEcYohJijnFNww53PK7Ls0v4S4hgmZQxK5XGE2B20+bkaryNmbqj2nzlfXZ4uYIEaYdBTVCskNpCret7pcCzJzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA6PR03MB7735.namprd03.prod.outlook.com (2603:10b6:806:43c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 15:42:50 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 15:42:49 +0000
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
Cc: Mun Yew Tham <mun.yew.tham@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 2/4] arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5
Date: Thu, 24 Jul 2025 08:40:49 -0700
Message-ID: <20250724154052.205706-3-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724154052.205706-1-matthew.gerlach@altera.com>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: e511c696-d84e-448a-d14c-08ddcac8be85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V+Dwlp6BaA+ceOgQYIz+KkbXhJQ8QlsscoIlFWM0x38hYRHXlHhNWkLX6for?=
 =?us-ascii?Q?/94QXQm4pTIBtYKRf/jiDed1fdnbw2FudeBt7uagLcF0aAepV3hEKKw9W2rC?=
 =?us-ascii?Q?QpZ++qs6+O5Xl0bZDAqLcFDxRY4GThM7+yERHm9EA/iLbIGyr5Q5hocCypfL?=
 =?us-ascii?Q?0isSOSqAI4DNMZxGOORr9FvQIJl2XW7c006N8HMMDKwEic664NQzCHyePvUL?=
 =?us-ascii?Q?z7STagj49pyumwVnZxV4oO3wQulpm7XWaUFJOcnEqRwY7dLqKtvcpQi0g/71?=
 =?us-ascii?Q?g13ffHMxSF6f+mV4qswvINqBW8HRjcA0Ly6Wc1ck335SotvGH7Xmo2zjeair?=
 =?us-ascii?Q?reDWsyEQJ0REBhwxiMmXxDsAfvYDyJ4Ap/ZjawMwjLqhwkQzl6GfPEtWkEdo?=
 =?us-ascii?Q?zQ3F8waZgr5zlHJdSTcMMr9/OLB57rIDlxGq2Uo3LlgTvJ5eoSEi8D99ktDZ?=
 =?us-ascii?Q?mG3pg406kF1tita7/0XxnlXe670clKMd1qhewkKMILGftn9glmUU/7tnfJ7t?=
 =?us-ascii?Q?OAZlPGMU/ZjQ0tIygMJpTUF5YWKB/HWsY0jU1gmlh63DMdkWyvBiF1XSxiYS?=
 =?us-ascii?Q?Xo0ofTuy5XB6ri5SN71+An/BNccsowgV/4EiOYG0ki6FnzuCJsK5ztrFldnY?=
 =?us-ascii?Q?O8OurtpKER77Sk5Bsk0vamopHlSzLFZecSnz+yMoOrxQoIGdsXXRRe1jRr8I?=
 =?us-ascii?Q?49btb7wUoX4/6khutKlZizCg71DuUJKkuraybWUzqm66R0RS5mdH198rJ50B?=
 =?us-ascii?Q?GM5SQIC7OxeF6Uw/M3t7eOcP8sDYm0+F6oEkLsWiu5l/tS1vQRbir1cOobZq?=
 =?us-ascii?Q?41hp7312vRXRcC5vYgTsbWxME4WXhglgvEGm6xoX6xzU0U2g/estCIm9R2c3?=
 =?us-ascii?Q?cX+qXi2d28leH0uRYLDBfN0fMRlcAibtXvFtCzcRXVhdPgBRRqkqaxKfhPD6?=
 =?us-ascii?Q?F/3YYtH2ENMHdeYnC3Rs2vyUwOZIgSMj0jVCbvGeRg8xc0kbkOSgfAesUCSE?=
 =?us-ascii?Q?7IJiuYt1A/JY9/7H4W++366yjSzbhhEnc/sEEThs8Nc6E6/nmodIeemNPtUQ?=
 =?us-ascii?Q?zujAjA04Cl1t+NSl0eEmrICBsGbYvKdsWxYlNZyH/HUv6mDEsDlxNWyk+02y?=
 =?us-ascii?Q?9pv1OKpAgodUvI6WSeZI2XeerSvuh1slD0kFMgScFqN0Xu2aJfLOJVT2AAwA?=
 =?us-ascii?Q?pdW8dAlQosfyK1EFUkK9cyipGV+xb+1qMbmRetkiNIxx+0f6XvTa4I/1LmHe?=
 =?us-ascii?Q?taO6XrtgW0P/tCX7ko+uaG5T2+nwRopIyNEmS90JRcOe3IJE8aSViBUD7AYC?=
 =?us-ascii?Q?h6jOrXMYusX7VHTb+s0iMsU1UUVGJUaO6yW4hlEIM4npxS/ZbFXdIiAbRVZc?=
 =?us-ascii?Q?ZhhpavL9h4nCkf6XoZWn2IoFOJwjF0+Bt6pskJF6wCpZN0XoPOC4Mnp5wrsl?=
 =?us-ascii?Q?7w0++8tpYe3epHKMCo/a99qLQUIDxqYhwhk8hBhPh6FsWTNIQbWS8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OSJuUIcIwT/j4VAAYuurnmxo5apKNqxgYJy2id5U+sZI+XlixW4v+A2mCsOq?=
 =?us-ascii?Q?ZI+/FzvzRSwUkfyfD4naGP1caQt8OUcmX1I2I3wCoNCKx6eXFOPXZl1kGAko?=
 =?us-ascii?Q?PFu44XaWGY1wzrOwVv3B1FB2jJ1zsI3zSFdq/AaMG05zxFabGeLELDYkKWq+?=
 =?us-ascii?Q?fWcWpGX/MH4EXVoSbbWDCk1vzpc5LAhurk9sXwmfGKXcLKK4SkvlEt4NUUmR?=
 =?us-ascii?Q?vMoN4yNwYPmPB2yO5ffu9iJ1AtZ/onJGBXq526/C1ysqu3AEh3iQlBPFZKpy?=
 =?us-ascii?Q?LLAIoX4Jr8zQijigi02POgzGin42gfSsD4j9a6I6RjIh5s4dSU7mJyKpOzdM?=
 =?us-ascii?Q?9FdKisKz9Po83INEUrqZxjC8qnt5rKqDWyLTq6DyhvhA+P/D6GnKefOTK5r4?=
 =?us-ascii?Q?2BKkRqRPvk5BouEhV7IchYNm8ZBGGgERBpNpqqD3h5CkM+FkXS7Im2ldLuW1?=
 =?us-ascii?Q?9Ogd/2c/9RZUwq+ltfVVFOaWyGT5MZZkSOUerFEn0NKZGvV8q+yzcfXUHBhp?=
 =?us-ascii?Q?9Cf96apT7mJXVG6JojtkZKoWrnsw4JXsaJq5sgeUnd+mMg/Dl21vh6AoGBVh?=
 =?us-ascii?Q?fCf95y918OBYbnXcFdhmkDc1QHIJriRV+TIfJ0GACGZP7wnFQ1hyHpO74Uz1?=
 =?us-ascii?Q?4Sx1Cena/fDxuihSDQ+ZDjAnvXuxcHliApcOizhcOJGs/083tmh/DTW9dFzT?=
 =?us-ascii?Q?IFUuhh7Tk2xPP+c6schtK9cJGndFp6PBBGINcOLXieZz9Ar+Z9iUV0BD/VBt?=
 =?us-ascii?Q?E05L0CffUrnZpfvQ/o+1OHu0VkUvlRFvgR9F7TcEC3RAZOGBfz2vyS6ZbX2V?=
 =?us-ascii?Q?m4mnW+tF3V459xpaRskmKBmNJ7V4Y8WLwYoLcKSpJoG9Mj94VP/TaK7TeFzb?=
 =?us-ascii?Q?U5IwMeBTOoWbby64HiLAAsYXj66qg8NniBnzW0iU+1OFvzOTP5DAhkpeSPWx?=
 =?us-ascii?Q?8f2vKQ0E5xZXKGIy7kR8dIYGD7VCw3jcVV9kb4sKUtdgfcJ3LJqouwt3qfo1?=
 =?us-ascii?Q?paJq3ll7V0y2xdzkfxfz4hpV8Q04VNA8QqibaDZ6TT+HD3lWEL2Tepai5kS1?=
 =?us-ascii?Q?SZPtOFy8lnBrlUV19asHq7szTZkeoVxY+ANiCqfywYW2WvHfMkcyON1r7Hks?=
 =?us-ascii?Q?qmXJHUiaFKwYE2VqnO9874yGZPdIpex1HDuC6l4YSoABGsJJiqagh6SQIiB7?=
 =?us-ascii?Q?a/In0/udrCH4YYmFhwKD0ixzk6FU/7LZ8VFQv6zulQDsYJHPIoLIhRm5j35m?=
 =?us-ascii?Q?Npw333ylY9PD3iTB9WM7RmrCzmd/NpKRUNNHo4/SnKVN5+A6xnocRAIEZzWG?=
 =?us-ascii?Q?a5djMYBVYg529Io/SRGgn8zsLedHOoEbMQAP5/PsXjKnymL0S3+V/8y9d03J?=
 =?us-ascii?Q?eegDdTpUookkmkx2wntFawT0/lUypjGP9caZrptdrwOPLlr4wa15tDQzxthw?=
 =?us-ascii?Q?GpSTowlglFpNY9nVRTXVvCCv/mEgW0laRuhpWfFzaT5ce3L52j0yfwSTkhZf?=
 =?us-ascii?Q?8NcWaxBN+xi4ml+ehaXuTnu02Qn3U/+kU5zITV7TZORd+tgOisCC0XpaY83Y?=
 =?us-ascii?Q?mAn3Or6zjt9N5K3Pyi7FYp4+vq7ER7DLy4MOXbIm7aFvkcmVxxMbyrecQGlH?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e511c696-d84e-448a-d14c-08ddcac8be85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:42:49.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oo75rbhAIxC57tIBIHeisLEPJGNY42jUlnU3qWRfbyPPvj/kGjQbDt1NOpDmZEFcHBX1KFXOejpLnI6VS+IqA2YHMsZszCdDsy2jqQc9oeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7735

From: Mun Yew Tham <mun.yew.tham@altera.com>

Add the base device tree nodes for gmac0, gmac1, and gmac2 to the DTSI
for the Agilex5 SOCFPGA.  Agilex5 has three Ethernet controllers based on
Synopsys DWC XGMAC IP version 2.10.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v2:
 - Remove generic compatible string for Agilex5.
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 ++++++++++++++++++
 1 file changed, 336 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 7d9394a04302..04e99cd7e74b 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -486,5 +486,341 @@ qspi: spi@108d2000 {
 			clocks = <&qspi_clk>;
 			status = "disabled";
 		};
+
+		gmac0: ethernet@10810000 {
+			compatible = "altr,socfpga-stmmac-agilex5",
+				     "snps,dwxgmac-2.10";
+			reg = <0x10810000 0x3500>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			mac-address = [00 00 00 00 00 00];
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			snps,axi-config = <&stmmac_axi_emac0_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac0_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac0_setup>;
+			snps,pbl = <32>;
+			snps,tso;
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_emac0_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac0_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac0_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x09>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+			};
+		};
+
+		gmac1: ethernet@10820000 {
+			compatible = "altr,socfpga-stmmac-agilex5",
+				     "snps,dwxgmac-2.10";
+			reg = <0x10820000 0x3500>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC1_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			mac-address = [00 00 00 00 00 00];
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			snps,axi-config = <&stmmac_axi_emac1_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac1_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac1_setup>;
+			snps,pbl = <32>;
+			snps,tso;
+			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_emac1_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac1_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac1_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x09>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+			};
+		};
+
+		gmac2: ethernet@10830000 {
+			compatible = "altr,socfpga-stmmac-agilex5",
+				     "snps,dwxgmac-2.10";
+			reg = <0x10830000 0x3500>;
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC2_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			mac-address = [00 00 00 00 00 00];
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			snps,axi-config = <&stmmac_axi_emac2_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac2_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac2_setup>;
+			snps,pbl = <32>;
+			snps,tso;
+			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_emac2_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac2_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac2_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x09>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+			};
+		};
 	};
 };
-- 
2.35.3


