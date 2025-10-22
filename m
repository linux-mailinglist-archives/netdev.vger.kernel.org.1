Return-Path: <netdev+bounces-231789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E49BFD6DA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9EF5845EA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52275298CC9;
	Wed, 22 Oct 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kbvlXFMo"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099842882D6;
	Wed, 22 Oct 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151855; cv=fail; b=T7EgWxBM3bXJKrjOB0ZRESUQnV8A33bzOBrWvSp9FocRVWri2E1VXxeRh1vCr8AZuSOI4hhRacvLhjPBno8hJURndW1FziaSLTDh1uN7JCEW1WsZ9N+Tl4VQ0uqrqrskkmJeJSW+cJE66SxtOXPQHsEy6+qHP6pFrfYiKayHKZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151855; c=relaxed/simple;
	bh=j/ArfTRVZlm6LjG7hTPCCqQpf/Yx49eUUZ9zAwLt5M0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fjhlPRZjZ45fJ21/HlxSJaJQTJPOW5NAjz56mnlusg4Jfn31r2Sy2GA2E8IrjpQf/r8dRaqf7R44Dajp1s1jxXOMxUJAha48IChcVH3Slnmq33hBGVnztKPqFOTzKaeCdriq2y91QQHn6GqLBBt9CWblRo8EJZjZ3gboiC68u4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kbvlXFMo; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK7P6i/A1ZbLCBPmCp569HcNWXO2wS5M6l8KYSqQUeEYwnWSZMjBReKlQE80RYQrUhIu6RVA1y+kCfbVa8eNeG2kYBKPYt+fbf4OGuHzDo4Hmu44cybItEgbmf7qqhNE41NwXg87MkRwND94iO/GBLnINkFaYTHmM75Qjbq1sd+8timakzpaPgw2mrGwP/45q64oBqdslYJ+Esf//8QBqsz/A+DxvBvXbXPK+t8De4SN10EVeT7j3JCx6fLld0UX5E6y05HsU6spfimU6Ar/2sozQAJabuLZ3Xc3XQMGRigb+CtM9omcLZraWwUGDe2XHZYpkvwxL+BZ2JzRE/M2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CAe2lJwb1Nl2KA9/Dd0kzmubmbfM/r3zbFB+Rsk0b4=;
 b=TiuYdPLJF7tz+DNusPQ2j79rtG3zYURcn1bX4jeCPKWJ44Z985ELDX4baWcrbJKfNdQ3Aa7/7yvR2bsA/bbkfci2JtdTAO4Ez971iqIgcjw7056lg/NQLk3MzoUnuLcYiNSQKThmlI0pjUXmCXYrUNIGYpbheQIdxTpYufx/anWLyncrK4wLRgurg3MOkz6lFub0Zcb1tHhI5qGAtnsvBgb4HDin6VMqypRlVqbQrMGr3X2DEYrHEoBCWHig8Ig6TmUk6g6EwmQB3P5g7pMpZ6DAuDYE8M6DCSnP4m/ao9W8CvinXNUubSKOWbFLeO+gRxCGhidxsaz9XhE2EehVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CAe2lJwb1Nl2KA9/Dd0kzmubmbfM/r3zbFB+Rsk0b4=;
 b=kbvlXFMorjJpSkYR7zOxajaIcodFh4p7dz/jHGnEacFPJDr5JfLkIYe+mN7UghmeKYNgyHeF3KezmzpcKCPoxMIgi/rWXr3rnp90AxTrMK0YdbgwePlm3b67PWdWKb16n6xBDu+fVmclkGtxLr1tasjUNu0Ha5ESj9oWonshQDw/yrplSjmXhIi6UsxKEcixYyfTh22R7jWMxHbFUV+BgxpCPqZsTCgVrzvoF/wZP7OW+AJOYvbsh+f2dF+SKlR06DqnMCuo+CFJ9+GhynMIBjiMe5meVLFJQP0C4swlYvDZCIbgntKCs5Z3+KiwrKPxpwnAJx48qEi28lB1Y01I6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:24 -0400
Subject: [PATCH 4/8] arm64: dts: imx8dxl-evk: add state_100mhz and
 state_200mhz for usdhc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-4-8159dfdef8c5@nxp.com>
References: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
In-Reply-To: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=1506;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j/ArfTRVZlm6LjG7hTPCCqQpf/Yx49eUUZ9zAwLt5M0=;
 b=LBDWPVR8NMNeBc+MFxBai/HIOstlZTIvpWrou0vz0ZOyHKAjfHsyI1iDOASp3P87ik1HgbrOa
 k4vYlRJi7HgAIP+ZUPOYieyxOFzDJvDcuGmf/TAO/wJ0yVpGkrRL/od
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: e0654d1b-3172-4439-07f8-08de118b2812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVBEelhsall3STJkTlpMQStxQUh5OTg5MXN1TlFSTi9OZ1pYcnVUOXZ5U2xO?=
 =?utf-8?B?OERtQWFuTmlnc3l4V0k3a2xQdVNCRlVyQXJhTWJrR21Vb2w3MHIrU1Z6R1Vl?=
 =?utf-8?B?bjhHSTQvUE1RZjB6cXh2bng5M05VcllYamNJOHY0NVhUdFFZeVRUVy9TZG5M?=
 =?utf-8?B?aWRWQnZPKzlFL2lheElOTjVFR0NxNVlDeE80eTlCOFhuUVA5VldXcEE4UDFY?=
 =?utf-8?B?SHh2MW9oYTBRM0RGQWlmLzJkMlptQi9Ub2p2dG0wU2FTVGgzRlllUi9zTEZY?=
 =?utf-8?B?QVI0NWoyclhwNHVxaVBjT2NLaS9GSG1HVngxY05SMFZocU5sZXJ5TG94bzg3?=
 =?utf-8?B?VkxnSnRtQXhzQndFaWhWbWxXZEFoVG9pcXhCMEp0dlA5alM3L1JRTklxbmpY?=
 =?utf-8?B?T2tEbmhGWExSeUNaQ3JpK29BVzQyVHBrNnI3dGY4QVVWUC9HeE05Yk5vdWJR?=
 =?utf-8?B?K1I5NjZhZjNGenhFaXdicUYwcWpyb2JvVGdFWjQvR1NmRC9UczFIUDhJRW82?=
 =?utf-8?B?UlBMOVpYSnZKNll2Y09CK3FKclRyOWFpMWkwMXpYMEt5YmwvWVE4RTdaNksx?=
 =?utf-8?B?cklVMFhmNnR0S3JtR1k3YTl6SzZOVzRCUDhCeEU1QnBoWnVHWGxQYzIzZkdl?=
 =?utf-8?B?S0duNEYzOTQwdlc3VURId1hmMVBiRG1QRndBbFVIRDlSN2wrcjg3bWw5QVk2?=
 =?utf-8?B?Y3JiSWNoMWljeHlUZTJnZi9SUEVkVFdGckJlM0J1Z2dzWXFBUkVHMkJZZXA0?=
 =?utf-8?B?Mjg2am5Nb3lzdkRTRnN2ay9rVnY3QjQ2T1ZBcXV0S2pER2FVVVNtNU1UUVhM?=
 =?utf-8?B?cHpydzcwYVZWZ1lacWEwMnlYTGpXR3ZrV2tXdk8yS2hUa0lBQ3hqNWxlRStU?=
 =?utf-8?B?L25zYm1iR3c0Q2ZRYmRkVGFWKzFYVnNnTXNUeXFvRWpaNDV0ckxhdlpERkxq?=
 =?utf-8?B?RVg5SS9kL0crbm9WS2Zxb2pSTWxDWHlYbFF6YnhBb3l1M0tzUzJmWXlUV04z?=
 =?utf-8?B?QWwvM2kwYmtzYkNPSHBZZW5yMy82MEl6cEtzUml5K25rcFFtN3NITVFqSWVV?=
 =?utf-8?B?WGM1SStGREpzR0ZnVkZuU29rOElKWTJReE9FZGpwdG4wd0tXbHNCcFlTNFVv?=
 =?utf-8?B?UFp3dkR5eU91eGw5b3lwdWM4TEFVaFJ1UDh3ckhQRjVGUzFMWndhZjZjd1pk?=
 =?utf-8?B?cWJwYXFhSHZvaCtEbmZPMzV3TnNjYUpzcW40K2F6YVkvUUVRYStyRTBmWkZu?=
 =?utf-8?B?VCsxeGMrWHZVdTFnQlJkdXJsQVlyNWdpVTdsTmdBYS9IN3crTnNybFRxM1dM?=
 =?utf-8?B?ZWVqRVY2d0E4NXhyMFFVU3JxaTcrMFlROW5ncXFuSm5lakRXWmhGV2tqSEx3?=
 =?utf-8?B?Zitxb0tOaEZXc0xTYkFsQ0xsRi9mbS9oTUNob2hBM1hpa1hWK011eGZtMVdh?=
 =?utf-8?B?eWRpTExkT1J4VEdldmtDNVNGaUlUMmRHbDBGS1ZNNCs0ek40TlhvdXI1UzYx?=
 =?utf-8?B?YVdha2VDU1Z1UzZHeTh4N0ZmdUE2Nm5wbitVdmkwRHZkSGtZZ3BzYWxvSDda?=
 =?utf-8?B?UE1GRUVDZkM3Tm9ncUFjREdOeXJyZzB1RkRoSHpYb29xc3dTb0UxcWczVk9j?=
 =?utf-8?B?c0pYYUZLSEVNUU9NdmQya1p4aGkvRjNrc1BpRkRVRlJsamhjb3c4UHE4L095?=
 =?utf-8?B?dXI1NWMxRmNaZmFIK0djZC9tNkxYc2w2QTNYcGtRb3NYcGpzVmpmM2IwZXZL?=
 =?utf-8?B?TFdBNjJNenFiTW5SbGc2eTBLMjJEZ2d4eEV6cVlxTnQrUE5QRGpnZVA1T1Yz?=
 =?utf-8?B?YUZTYnFNcFo5V0twbEhsKzhsdC9jbXNseVFlUjZKdGh3ZjA2UDdKbU0rL1lv?=
 =?utf-8?B?R0FJTnpXOFl4elJjV0NXUVFlLzIycThHVVRZaEVUOU5iK1RVSHBnR1V4cXlu?=
 =?utf-8?B?N2xlejI2bCtzMk4vd0dDVnBDZ0x3NG96djJVei9MQWNHa21MZDdBeGNJOXlG?=
 =?utf-8?B?aXUxVDkyZ2N1dC9XeG9Kb3dnRC9FQ0hkdjlFeTRaT3F6REtBekpCeEFHblBJ?=
 =?utf-8?Q?MXAAt2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blIxWkM0bHV0UlY5S1dOMWozbFpGbFJ1OUNhNFhMcDBYWm85eGUvSGM5ZDNO?=
 =?utf-8?B?UkVjVUxVa21aaW0zV0dRcGFSeVp2bU1VekpSWHZ4M3Z5YnRxYUpLSmJRS003?=
 =?utf-8?B?SnVnTVBOZWllNG0xVENxSHNDcTlRdE0vdW5LNzlhNk1BbzdJN08xY1VCczl3?=
 =?utf-8?B?N3dEY0grdzBuMEhFNDFYSTBQV1VwdGREMEsveFZjd0VFRCsrZ0YvbDdqYzF2?=
 =?utf-8?B?eTBqZDFpRCt3K2Fadm5SL211bUpuMk51SElINXhUMVZ6MW1MeG9sZGhTZER4?=
 =?utf-8?B?eGFnbXlRbENPT1kyelZ2VWVnVWxvcjRVNFRkOElSc2p6VTJ2b0tsV1JuYk9Z?=
 =?utf-8?B?c1FpOVBJMlBMdnkvb3Q1cytiWnAxTnFPSEU3YXFVQ29WSnJWZGxsZmhMVWtL?=
 =?utf-8?B?VUlOYW9IR29teEZLbWJMbnlsTUI4WGQ4aDM2TTdLT3NObUl5UDNHMXpMeTBC?=
 =?utf-8?B?Q1grSlJCWEdGZndyeTk0SnY4c3o4VUJObG1XZGJaYTQ5L2JRSVEwWEZWdTds?=
 =?utf-8?B?N1BoYW9FVWJreXVMS0Uyd3FkWmFxQzNQc1FSK2lSNGQvSW8vUUw1cDVCVVo3?=
 =?utf-8?B?NlR5L0tmcGFOanlyMDlBOG9iY2lWLzNZb1AwRlFveUZOaUVQYnFmU0pLQ3RJ?=
 =?utf-8?B?NTluSTZ4bDNQVXgzVjltMG5BSCtBMHRoSnYxODRxNHpoTlAycy9tQmpQdUpn?=
 =?utf-8?B?K256alEvSlBRM2NqTVpGcVBEYnZoeHpXSERNNTE3REhWNnpsQ1I2YS9pQlBP?=
 =?utf-8?B?QlZmRDFUUFQ3Nnc1SXcyTWxKeStUc2ZyMGlpaG9CVmltZTJGa3cxM1huVDVi?=
 =?utf-8?B?MWFvYnJuMEg1RytDOHdvOURNaG5CcFNZVHdWR1l3K0htdkE5SUM2MEhQTnZW?=
 =?utf-8?B?a3RYWWdHd25FZUo5Tm82UTNySWZsVG5ZYURWdE1ndnBhdkgrNFVVK3VGTEhy?=
 =?utf-8?B?SFpCekF2RllXTExoeVc4RmF0eGcxcm5ZMGVSQ1dPMTQrUDlzdTFsVGZWWHNk?=
 =?utf-8?B?dUtqenBjN1hFMG1QNHpFYVQ2V21jdWFVNW05NjBUSXBobTA3VEJmeXhvNGh4?=
 =?utf-8?B?N2k2bFF3dG02dGRvS0FzcS94cG9tN0VqZEhNU3o0aXFVUkpYby9NcVBPL2lW?=
 =?utf-8?B?dm9kVjI3T0orSUxKZjBNeGNxbjN2UU9lYmxESUoxUnlOY01McFBkc2EzcWtz?=
 =?utf-8?B?Q0ZOVndzWGtHbTJyMmZHMk9ZQjFpc2NTVC9tczcwb3dqR3dIUExmVytKdjBt?=
 =?utf-8?B?RUk5Rld2ckk4aXdaOUhvdG85ZE5GMEZuamxLSkNMcTQxNnFzaUllbzBNNXU3?=
 =?utf-8?B?L2RqR3M2aDk1NlJGS2xLQTdDelJyUmxSZllEM1FycVh0cThSOXV6UFZzQnJq?=
 =?utf-8?B?TkNRRk01SWZpK1RnYlNONksva05kSzJSbVBBblZZZlIvcHRXbVAvRWN3U0di?=
 =?utf-8?B?cWdvVnFEWTlrRk9FOHk5ZTFYMkdPbUxjN3J1U0pERWtEMzNscG5EWEtIVGJC?=
 =?utf-8?B?OTl6Zm9KbWlhZXBFQ2ZnRDJELzBaL2pqZHBoeG03YjZjeU4vM0NZaXJzNUdl?=
 =?utf-8?B?eGxFcU83a21DZ2EyT3RIQXJsTTdDQTdWSWt3bjRUdlcxSW5lL0hYSkV0aHJj?=
 =?utf-8?B?dWJvazdXNDhibEVubmVVK3picmhQaVc3ZmNIbWZBQkJUdTVVemdReUtraFhQ?=
 =?utf-8?B?d0JsajBVTTFyS1NXV24xaWFkbU1OK3Y2aVhiQSs5N1loMWJ1allSSDcvbVVm?=
 =?utf-8?B?c0hoajZEYzVHQkVqOVJ0WVorZUNKQjZIdzNyYjFzOVErbFEwd1kwOFlCK0w4?=
 =?utf-8?B?SXZja0RsZG1tWUxuTWZBNXFZNEIyS0RFTDdFdngrVWR4cTRkcnZyRk9HMldi?=
 =?utf-8?B?VitLZlhlUS9VaXIyanJqdGNZM2FZUGNCaklheEhTRCt0Wk96SWxrT2tDVWF6?=
 =?utf-8?B?eXJzNko1aVJ4d2I3YjN0T0R3QXc4SmpMeFBMbzlydDJxVkZsc2h2UDdZZE9P?=
 =?utf-8?B?ck4wS0hPR1NrOXRZck95VmR0dnpHYTFNb1Q5dUo0MDVNenBZLy84TFc3UWd2?=
 =?utf-8?B?eFRYaGxwRCtLbmQ4enc3YW5mYUpPcFYxc0U1ZXZEaEdDS2RqQ1lYdHp4TVla?=
 =?utf-8?Q?uKZeDBtfErgitT+PgozyLkVy6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0654d1b-3172-4439-07f8-08de118b2812
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:50.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXK5xfXkl+L301nRuuibr41wb8pK5nGaeJWuBj8yNogIBaChN9CZjpAOmVH44dE41dO6jt0Hs19wh01T1zbtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Default, state_100mhz and state_200mhz use the same settings. But current
kernel driver use these to indicate if sd3.0 support.

Add max-frequency for usdhc2 because board design limitation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index bd58fa54fea8922327393a47d9060ad33e38cac7..4a070bc0c4db713987ebc038f2189b3fbcdc91ad 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -779,8 +779,10 @@ &usbotg2 {
 };
 
 &usdhc1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
 	bus-width = <8>;
 	no-sd;
 	no-sdio;
@@ -789,12 +791,15 @@ &usdhc1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	cd-gpios = <&lsio_gpio5 1 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>;
+	max-frequency = <100000000>;
 	status = "okay";
 };
 

-- 
2.34.1


