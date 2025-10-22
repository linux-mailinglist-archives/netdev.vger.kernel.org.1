Return-Path: <netdev+bounces-231787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861BBFD72B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE73BB2E5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E227E7F0;
	Wed, 22 Oct 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XqtUifwR"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C87275111;
	Wed, 22 Oct 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151850; cv=fail; b=IMer4n7l6OcchNH5M4UAv0A0PIn0Gp/jcGG7Ggoi2IKz0IDuGSRT/UxsOVQ4p6jcrn7GFkKIZ6+95V/8Phlpi8DwHGuMdEoqR35CSyXLb0JbPQDON3lSlg1MUlilcuM5YgXSgg542/rKQe7jJuQlz/ItUFgMSS6dlIh5VyOWHK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151850; c=relaxed/simple;
	bh=1dejpJRhvL+N2Ra6N0F/abbEj0KetztRiK4NHebhuCg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SHJs3WcWjRBeW+w63ZDzMIy92bwEqHenvrpoHOj/QSjitGv3zjQqvJ0tl9pQlg2AR5WQNnyfIJa0okJbrGpB5Zwah6aUPVvwHAQRwqOWxgzW7cKRq1031UsRwF9OqgMjdRnbvozYFYR1XGIlTRaZ63dZrPRlxgBjr0p6azUvZQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XqtUifwR; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9Mp9vrbT1BC0wwUsXoppMQRKzSJG8PC2h9ERalZKigPheESre/O8EGhXBuajAnAS1jgC51a6b0nySUMMg5FxWOuxZ8eiLjmMaVbcCVg1DUddIZ5bdi7BM7+bXQ09g5Pr7kO8+uhkGDMMO5WWqbisJp5zqpFO/dFx4HXPZaZ++XijzD45M8g4tGtLYhWDypl/XqqguboS+QXptKrJPbzyEVds808AW0YSVXRCWAWWWGpbnh/nKAmJkzVy+7uTpITuxUkOlSLxsCFGyeekc196td9PKwfhMszkY9IOe94ZhaLVsXnSVM8PQQWIavmy2yl9giWzX0Mft5CrtAWyWk9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmjnR4w44wlEY3rjPPTuMJjOlZ8iDr6zwQPRsRzxDv8=;
 b=PbRq244/VwL7pHTjgoZZUWP7i66eSY/iuOAcM8uVAJYdluI3xUpPSZWsUrzDW5IGeOGQj5875qyFNaMnvH5adqLMlzMl/zMSNZwO0spPVhvulARwJHLnvCFREBY96gyDsbu1htiCKo7K4/F10oALzc1M0DJ5FB0dOHqpzZz7j6FZOxs7q/EKRd8iwWLjtx7jpwpD6IGu/JgRohnF7L1rBzM54McOMlTznY5xOp6NlczFVtgZ9F52x3W5twAfUieImnkKxBIWO6Ov6XBSrOvFrgyxjDvdi3inTEdZMzoxD0PEE8WNqsu6dkCbg8bKQBx3CEFXugOu8lzlH9liskBrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmjnR4w44wlEY3rjPPTuMJjOlZ8iDr6zwQPRsRzxDv8=;
 b=XqtUifwRfYxAUvalSheTh/VSHH3JNWgYOps1koGK26yIdjWq2HVg+C49w+Kof6bfCZRMfvjLyVMx2rPE8edvqFrs1ROYMKrQqDJfA9RXlAAWW94aWoRkkLzs59LhOyswBiUQebXnkYbJUnH0ITKwLpNFDiQpv+/EY/8P9H0yc7wvZqqKLoHBqjjptkPFcCxW1xyYyeFxfzQww8JzrhKT7XQ2oXiS31/88BpKIQXAojRzx09iQ3OWs21/XRDUVmgr5EXC2cVJnPoBitCGtJaVv7ogvOhOJPsHRlMRUEQZAfigg5FSHdNwBddSq/ilBAeeL3sKtmZC+GwKjsnl/JQCnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:22 -0400
Subject: [PATCH 2/8] arm64: dts: imx8dxl-ss-conn: swap interrupts number of
 eqos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-2-8159dfdef8c5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=1318;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1dejpJRhvL+N2Ra6N0F/abbEj0KetztRiK4NHebhuCg=;
 b=M0yFTsy9TtVPthIOth/1ll1HwC66KekSKbp63pYTxaRMx7n3jGy40FF099K7kewZ4DdT8CkIo
 EIYjU7/4bc7BaBvpoOwe+9y3YpJbEq3b9FF56+C4Kgdovfo1jGuaVtn
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
X-MS-Office365-Filtering-Correlation-Id: 98a09449-612f-463d-a493-08de118b246f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmpDVU5NUFAwOW4xSlptckZObHpvd3krYVo5NjJ1aWJVVDBZVVV3elJaWEt0?=
 =?utf-8?B?RE9tMGFQRjRuSUw2Ymx1VDNHREVRMk5QRFVMWXVrV3licE4xUitNWkR3blFQ?=
 =?utf-8?B?NFdBYXRndXBjWkMxTTZvWm1SSHR3eGR5TFRRazVhVUEwSFpYTFVZVUhNWkxj?=
 =?utf-8?B?MjcybkIrSFY1bEtjeitCazZwZk44RTRmY2ZabFBDbXNqblk3QmhUN2tCazBH?=
 =?utf-8?B?NUNPbmE3dis2R0dVYXJoRmM4NEdmV3NINEN5UU0rTjNUbURia1hVYldKcWdk?=
 =?utf-8?B?YThMd2ZleU5ZcWtTNklRcTJSWFRNTE9pbGw1NlFNczJVSHNhNStqaXArNENa?=
 =?utf-8?B?V0xyRHdISGJ0ZlB6MUpyb2JEdzdPYW1aeDA3bmhmN1BmTTZrT1FyS0E4eG5G?=
 =?utf-8?B?ZlNJc3NtRkYvRFhma1RlOTJiRll6UlRCNy9LUnE2Q2NNL3hKQ0Y5aUNITnJG?=
 =?utf-8?B?cFdJTUlhdkE4WnYwa0E3NlBzNnhtNGI3cUJJQWhlZUlObDF5VkdZM2tSV0Y3?=
 =?utf-8?B?TDRMVnV1bTZvMWNRa1hnVVZDajhiZzNZY01SREpXMlVvL0xiUHEwWktjV01o?=
 =?utf-8?B?RnNVazdoZUFzcGlzZDBPTjZ5RWxpVU5sZDE5TUg1TDU0blpJWi9TL1JETkdW?=
 =?utf-8?B?YUcyU3FPcW1iZzEva0lVZHNJMnNwSjhUVW1GNUJ3ZW5NdStjNTc3MFgzK2NC?=
 =?utf-8?B?TlU2QTBjWGplZXJjbGE0ajBTNWYxOXRpR2dEaExzRDFHaDVXcytwTkI1eFFZ?=
 =?utf-8?B?OXMwbDU1TVlOWUNqUUoxbDZRN2g1ZFZFYkE0dWdVK3F0OXd0Y0JkL3dHTFRE?=
 =?utf-8?B?TUtzdXA0VXloWGkzZ1dKMGl4TmNWclRFbm9vdTFHOUgyVENuS3ZWelg4K3JC?=
 =?utf-8?B?Z3NKZmhZemw5ekxnZ2xhUG92dVpTU0hQSGUvdFpZeDhZaUdzVVNtY0t6SW80?=
 =?utf-8?B?WHg4SWo5SzNYczRrUlh4b2toc25yeERNUkpMZlI0MTlMSGJWMU5oVWpyYzdP?=
 =?utf-8?B?bFlaN01MS3A5cEl6UE1DbHhqK1F6VVVKdHZBZlZwcjJaOS9sWmhXMit1ck14?=
 =?utf-8?B?VlhZQkNnY0hMZjh4Y3IxTWpSTjdnTTlHSUY4NzRiOG92S2FwbG1KL0RqVldK?=
 =?utf-8?B?YzQ3b2x4MjhWM21RYW0xNlpiWlFmalg3ZUQvOHpTKzJUY0NFeUFFUVozM1VX?=
 =?utf-8?B?QzdVbG8xajZYREFGeUlRSW53RSsvT1FDZnZ6NkJOZCtRNFM5aG84ZXE0MzJS?=
 =?utf-8?B?Y2tPa2Z6WVVqVGxTZi9WUFZSY1IzSHFjL2UzeE1sWno4Y3VsMU1EcEZ2UzRj?=
 =?utf-8?B?MDVENDNLcEk5N3RnL3hIQU1iZkFGUHNMN0E0dFowK1ZmVXRXSXdBTnRLNmFi?=
 =?utf-8?B?OXNpSmYzS2hPeFREN0pJUDdmN3pRL1NzSEVGaldtZnRKcGxlWDR6SFdpZlR2?=
 =?utf-8?B?TTloSnNROWNxTE1raTVBV1B0bjNFVkF6MUpDS0VUNW5jcTgwOElsL0c0TnJh?=
 =?utf-8?B?QmRvNGFRcm4wMk1Ia25RVFdNcnBmUWlvTzV1UXZic3c5QlF3Mi9uZVYvRzIy?=
 =?utf-8?B?cC9iajNNekJ1VTFlNW1JMG9Pc3FJMTJXa1dwZU5uVE5KaC9GUzhkRnFuaVA4?=
 =?utf-8?B?eUdYc1BZMEpNYlp2TkZwNWk0ajU1RnRGUXRUb3d5YW8zNTlONlJMRCtCVmN3?=
 =?utf-8?B?dWVZWVIwckY2OW85dlUxald2Tzc4YUFOaXpobkJQQXJpeHNnb01yOFN0U3VI?=
 =?utf-8?B?MmZFbDcvTlRqWjNiaFMxd3RXWWZwWmphdmdWb3B6TjgwMXJMaDZGVXRpTnE0?=
 =?utf-8?B?ZmNkZllKYXpmY0hxbStVYSthV1ZtcDgxbWc5Szl0MzAvWndDV0RLb0hCUTZD?=
 =?utf-8?B?ZkZGeWlrMXNUV0dpRm8xYkwxQTE3OU1oc3U3NVN0Y3RWbG0rc1VRQlZtcmxZ?=
 =?utf-8?B?NkpMTmRLM0VSUW1rL1QwRHlJSDNSd3hBM015bWJBZDJzTEYzbnRrUUd5TUQ1?=
 =?utf-8?B?ZWtlbEl4YzUwYWFkSmxsK1M5Yk1wMHVZVnA5VzdsY05DUkdGd2xHaDZGSGxK?=
 =?utf-8?Q?XwM2JQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWNqM0dxdk9uMlNxaVkwRHYzbmdMZEpOWFJPODlDVUNrL1JDQlZ6K3l1Zm9T?=
 =?utf-8?B?TFdJSWp3eWtwbk5yYlBLeGpTc0Y5ZjBFbUtHM1g5WnBxNG0vSG40cEkybEF5?=
 =?utf-8?B?TzZwNng3NWdzNXVXeVc0cEY1ZEd6akNTMlE1bUJsWGhiVkpDT1VuYzlkejkv?=
 =?utf-8?B?RlZza3ljM3llcWk2VTNLaU1waGJkOElvYXBFcUI0bVlkelI4SlB6WGkxWDBa?=
 =?utf-8?B?bjdNMDd3MFBHZEV2VlU4UFN1aXRNTjltZnN4UXNrTHl4cENhZE55ZHg3N2lr?=
 =?utf-8?B?ZkFYOHZienJKTFFYVFltd093U091bFdEcUk3d1U0eGJvaG4vYUloR29mRGFk?=
 =?utf-8?B?V3N5eGVpQU9McHhoOUhkVnVucmM1NjNlQi92ZkpQVVZVblRNSHAwaXUwV3pR?=
 =?utf-8?B?WEtpSHd3ZlZJWVdBVUpabk5SeGZoaFFQTExlMEdDdXgvT3d5aCtpMGR1NW05?=
 =?utf-8?B?NjVwcHFvVkRqdUlPeXFzeGhZbUtNcE5VV3BxSDFidlQ5bGZFOXFNNWkvRmFW?=
 =?utf-8?B?NFMwZVZ1NlZpNW9wSDJBcGM3SFZqQXBUU2RVaDFJZlA5c1hvM1laUFMzNmQ5?=
 =?utf-8?B?V1BzU3F3V3Z4SkVYVEJLaE1MVnZIODRwOHhmeU50WkpMZWpnR0JrRlFLZjFE?=
 =?utf-8?B?VWtFSW1YU1ZuWkdJUkpBQUFmRkVkMEx3aE0reGkvNHArSXZQTytrQkI5eEs5?=
 =?utf-8?B?M1FSWktCMExqN3hTemdCSlNPOTFRWHFyaUEwdHhjZGVYMjlNZ21qNDNoQUVT?=
 =?utf-8?B?RHdkMkpLRGNGRSsrUytOS0tNYVgyR3IvdFMxNVhIbDRPUkhGU2h3b09tRGp5?=
 =?utf-8?B?dUd3V3gyQUpFdW45Mm5FTzBuZU8xT1l6UGVEY1ZxRm1PN2EwTkVORURIQ0pF?=
 =?utf-8?B?WU51QXdSbGRwVko0MFl2cXFUVTc4OHpQeFhORnVlc0RKc2FNY00wYmZ3ekNX?=
 =?utf-8?B?cXQ2QkE4cEdhc3lZRytDa1hUM3FyR3ptaUNCRkgxT29KaGJaZEZqNjIvK29F?=
 =?utf-8?B?c0xsYXg0RXM4Ymx2Vjd2Mm16RDQrZ1N3SWF2dXFqQ21HOGVXL2JoQjhRTit3?=
 =?utf-8?B?T2ZWZnpYRHpCYWFMNlJpSnZZV1RlWkJZMzF5eG5BU0p1OS9QWVB0ZzdmeVIy?=
 =?utf-8?B?Y1VCaTVaN0NHMjgxa3ZENXN1Mm5tcWRCanN3SjVjVmlSRVUybnM5WHB4YlBk?=
 =?utf-8?B?ZGtkVnlCZnZ1eEtLOHc0cDR5a0xMOEkvNTFrNjFBVnltZlpEYlFlRUJqZjN1?=
 =?utf-8?B?T1JVN1lRNWVtRlZTcHN5SDFRV2JFeWFKRW9CVytzdzBPbis1ZVE4eUFWd0xJ?=
 =?utf-8?B?TlpDWWJOaGdRM2wveFk4WGhIdnNYV0VwK3h2MWxuUkZkWXZnSGxsb0l0ZVRN?=
 =?utf-8?B?S1NkVDZXdmhkNGk2UVZqWTFUUExpYWljQ0RLMGU5Lyt2SE43RGRVR2JwTmFp?=
 =?utf-8?B?RFJWUWlXZU5OcFJITVlrMWs0SlN1dXkxVVEwanF3SHdhZWYvcjNHRjRUV3c0?=
 =?utf-8?B?V1NaSGYyY1RkTlZ6S05JU0RGNjNncExUSDU3T3lpaVJvOUZGSlhOSXNGMER3?=
 =?utf-8?B?bEZ6S0xhMzdxQ1czQWFIaGRsTGlPaVhwQVorSmFtRVdncURMNGN2dW9HdXhQ?=
 =?utf-8?B?T3FGaHRBdWtTN1NFZHc0KzQzMlYxcHo5QVo4YUxUb0M3cHJZSkJnVnZYWGg4?=
 =?utf-8?B?QnIyTGt3MDh1cmhpV1A0YWZRWTY3QUFxem9mK2t5SVIydkNXMnZCSG9ndHk5?=
 =?utf-8?B?NGRhVXhOekFac01vMlpDSytTaTZtSURyZDZ1c0t3RG9MamZCQTNzWkNSRXJV?=
 =?utf-8?B?M0F4SllVQWVqWkdEbXJBMkI5bEZERHhVZFF3SFdRNG1ST29WcXI1SVEyWmdK?=
 =?utf-8?B?WndUNDR4NGdTQzA0TC9LbWtUZFJNeWFJRXNmdW1zMUIxT3dobllzSlBvRjho?=
 =?utf-8?B?NWEyWXBDNWNmejY3WTM0eTZWeFA5a1llNXhBa2xRRTExS2RUYkd6bFducHNC?=
 =?utf-8?B?eGozelBONytHVE4zV2RjWjRMNUtheVpwZ0xvNnQxQUNtbVVnd3NMd0JySzB4?=
 =?utf-8?B?Yi9rWWdvdythTDJSdnVRVUxEcHhjUC9YWHc2TEtYTk85eldjQ0VEUHM2K3U1?=
 =?utf-8?Q?/W297/r1xYNyeZaueJIQx/PBE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a09449-612f-463d-a493-08de118b246f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:44.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqVoPR5LtndjcBOHxeOH2EPBOJfrp5Wj+bK3gFFrCufAud7W9+6LNn6ZoUk8BB6CLtWC31O8gDB7tCW8aZGgjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Swap interrupt numbers of eqos because the below commit just swap
interrupt-names and missed swap interrupts also.

The driver (drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c) use
interrupt-names to get irq numbers.

Fixes: f29c19a6e488 ("arm64: dts: imx8dxl-ss-conn: Fix Ethernet interrupt-names order")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index a66ba6d0a8c05646320dc45e460662ab0ae2aa3b..da33a35c6d4660ebf0fa3f7afcf7f7a289c3c419 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -29,8 +29,8 @@ eqos: ethernet@5b050000 {
 		compatible = "nxp,imx8dxl-dwmac-eqos", "snps,dwmac-5.10a";
 		reg = <0x5b050000 0x10000>;
 		interrupt-parent = <&gic>;
-		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "macirq", "eth_wake_irq";
 		clocks = <&eqos_lpcg IMX_LPCG_CLK_4>,
 			 <&eqos_lpcg IMX_LPCG_CLK_6>,

-- 
2.34.1


