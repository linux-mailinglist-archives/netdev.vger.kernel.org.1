Return-Path: <netdev+bounces-231791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E25BFD74F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAD560E55
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9D2C027C;
	Wed, 22 Oct 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fSLyN11c"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124B2BDC28;
	Wed, 22 Oct 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151859; cv=fail; b=Cgnr2qb+fum8IOZDpSYp/yqsd1YJV/jDddn7bskeIR9QyuH3JZ1HJMLTKyXYlm5jtvK0gqgl+e8lxzzVS1yk1DntIHacAIH1IqJD3aYH9Gsizi5TVHUkz0+XZpW3o5XSDCFpKlENSSyBkQdUm18VOPIf1dm8uYDSv1AaB4t3Lfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151859; c=relaxed/simple;
	bh=BP0olt2dDH5MfXMNeP6vdbGGy/BFZ5hp4Fq8FOQ6wJ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y2PyqK/vQifKkzO+tBGhHJ8CUoS4GL6DyL3J195ximRuKXH0CI5fPL5o6OJH4ybf2AIS98PrB7HvIO/EtsjsLzT1VxYFpPWr/UPo7IGtwTZl/hg936mf4eLX9STyfm/XZ28xpn+mta0sNQW6K4Uiq4xdFxXzj2kPhkA9WXB0vxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fSLyN11c; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVClFjnfUALFe54FOghGGXxvlA/cF9xS35PyAukApt/nba4Peg89QiL2gCGqFvn7g0PgA6BkLlwPk9k7uMejiBmDf8h5/8OAvXDGPsHqg+8fPWXSkP8OudeRcEuT1F2qx6TCc1NOawd5sYg2XQTnDJoDQuYMvNHKKUpyOXm/LGBCELGwWHd5uLNll4XPmH0ftuNLDAChRc+ep63LBQ2HyrD6BgqdwtarXYWfTi49OwZ33RuqbcoA45/O4yEuntHZPn3FkeI0+rGAHED3FnwbEsBGVjNq3ZbyJck8gNiXKYyONo7c6dgVNVJ9nvqYIgHt/vmN92lRDUYooGsGyok3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wng2x4WZmbD/MTTplyD466WVMOTX7ooGs+JEprpsVYM=;
 b=Xb/P4hDQpfPF5zZNmcF+j8CFUrquEYkvmE9ZTZD+uTgDoVI4yMHoNpfD/livKvzZNWkypBYO13Ez/WFxpBSsZsWo29C47KL3ktRZEhf0M1YOBRwotxfdjofkOUeO+m24wfE20HpM9ii3PqCV1ls/T2IAx9OQmG++y6pMm3BD/h9eE83ol99YeLq6N2pWFp/gWux9q9fnd2RJCRRK7eGDdCaI9sOqDV1NdFKAVSQX/GaZju/DPSS8ypSrcs8B5kPssOZjmEx4bCQxmkOJAKgIcaxI2czd1kFv7f/2gdnq/+8P8ibcxdjnOiNmT3s+fNnIDa0PwXBsSUV/PMzlmKPtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wng2x4WZmbD/MTTplyD466WVMOTX7ooGs+JEprpsVYM=;
 b=fSLyN11cCPqEfYEPLpKYKRx3PzLXuZaOXwNsOOCktUnOkjh8x1HOikO0QSJc2SmnGR6qqSvy8s3M3JpTKnc6l6rlH4L3uXdiATn1dOouAnNUGOY3L2Nbul7xsY1hvzVNNqmIIP5UKfnZzbPwtJ74omyMIkO/2Jt1dwDR+7c97Olu3eR2uXucfrh82kL8JaL+HtAx2tIFxkhj7XQ+wn+OannuROy46hRKkmBGx1bzJRktCMDh0KtSJWbYt2oKwCEpJGzLNqXkDiP8OFtd1iuYtXEDV+lrOV3Hat5El7ReJx5zWa21XkUGKgr/2yA5qkzYrC1cYhQdhtbktS0DUHTeLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:56 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:26 -0400
Subject: [PATCH 6/8] arm64: dts: imx8-ss-conn: add fsl,tuning-step for
 usdhc1 and usdhc2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-6-8159dfdef8c5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=1122;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BP0olt2dDH5MfXMNeP6vdbGGy/BFZ5hp4Fq8FOQ6wJ8=;
 b=PXG8sJkH6AvOauDnIcBJj6iKHpKy6jG+l+01/iunszWpJgVvoFMR0N9Tlu1zGOUV2dcEo5sE2
 82T6W2lNaQbAuMb3nOwClT8k6jDGx3ydaZqSB1QbZPsbxHU81C6z4Hj
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
X-MS-Office365-Filtering-Correlation-Id: a062fa96-6767-4d5e-75ed-08de118b2b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm9SbjYxWlVJSUNrakl5aEZEM3BIQXBGV1VGWUNXMHdVUkgwalF6OUtkWDY5?=
 =?utf-8?B?NzZNU29UblZobWNGdHZxbG9MeTlEdDV1d0xUMFRQUm5uNWdRdlRUd1JQS0pQ?=
 =?utf-8?B?Z1orR2NlL0tudUNVUkRDOEw1ekFKVExUNHYyQmJHYzhVNlJYTlVtQjI5RGtG?=
 =?utf-8?B?cHRTbjU5VlNFb1V0RzRtcWNqOTFBQ2NlQW5DRVZ6U2JSeUgyeFhKUmxxZjNE?=
 =?utf-8?B?NzhNanBrWHZlcWlhNjBrbDNOUWxubXVxYk0renhGMUpzMlBmOGZsdjhOTktJ?=
 =?utf-8?B?a3JsWGFHc1lnUlBjNVN3ZVdYQ3pUQitJQmN1NVNUVytxbG1iKzgxOWtHTkdV?=
 =?utf-8?B?TXhPSncrRXZVYi9SMjF4UUp4Rm9RMmwxWGYvNCtBVC94MXQvOVlDUzcrVkcv?=
 =?utf-8?B?QmtJbi9DbG5DN05HemlIZlVIaU1MUUxHT2gyOFdwMXNRaFRJV28xOGFMSDZr?=
 =?utf-8?B?a3ZieDFDK3N0K2FROU5xbWFYN21FOWZjTTJFYUlSZ0pySnMrVkZEQUt4d1hZ?=
 =?utf-8?B?RmtvVUlWQnVvVGc4akhjV0Z1ejl5aWdTU0VxQllKNUk4ODJRVTFVL0U2QUpD?=
 =?utf-8?B?NHUzVzkyM2dHZUdKVDhUU21IVDVLWmFmN1gyWkFsd3pxTyt0U2tVNWxqMUlS?=
 =?utf-8?B?VVZCaVNmT29aVEFYOTZMQ05ORGZmMUZTTUdpUVdrY3dxdjM4T1ZFWmRQbUZF?=
 =?utf-8?B?SlFHN2lmQ3lFQlZqVWs0NlNUdUlYNHVvQ2s5TnN1VWNaUmlIS0ZnakRCb3RX?=
 =?utf-8?B?S2dyUzQzQUU3RDRleStpSlBzdlFoazFTZ3pIamxnQ2xtenVyS1p1dHViWitG?=
 =?utf-8?B?SU5YQnA3YWNNYXBoZkJYOFBxWVA3ZW1yZ0xoTjc5VGpNdEEzMmxHSXEyamFF?=
 =?utf-8?B?dW5XOXRWL1VZWHVIeHQwWSt5L25rVVJrdUpsSlk1QzNCM0JvSzZ0UXlhRjRD?=
 =?utf-8?B?aTJGcisrdmFzOHFicHI1N3V0ODRlWlRIblA3ZFY5cVkxdHBCbzZPMFd2RkZR?=
 =?utf-8?B?LzBpcFd2VkhyNUtQZmJPUnorbHhvL3Bqb0RubDNucVRiQW1VRkJ1OWZFV3VE?=
 =?utf-8?B?bWZRc3F3T0VEN0pQMlJUOTl2TENoVGdLd21NV002TkgxNGdhWnJDa2lLTDVR?=
 =?utf-8?B?WTFnWHZxRndpUnp6cXFCK01jdGdVSVdLZVRiTUhNdjM1eEtNa3oxb3laS0Fk?=
 =?utf-8?B?VXd6SVpVZHVibURRMUpKcmtvSTcvWTFhNnFIblhmQkhVdU5SdkJqSTVkbjFD?=
 =?utf-8?B?QnhlNWRNWk5PRE1MeUJoLzM1OTNRanUwV2lZM01QOHVuQzVIZDdDTWdhVnBi?=
 =?utf-8?B?cWFza0RFNmxRalpYQi9FL1NlVWZqQVU2a3ZPNjFtT2picC9Mb0RESHJCNkN4?=
 =?utf-8?B?ZDdkMW1VUU00VXErZFZZbVErMUgyUzB3UVhMeElWU01STEZ0RUE0SVM5cGwr?=
 =?utf-8?B?UG9CcWJjZTNPQXRKbzA0RkliaUlVU01icjArRU1TQUdPZmhLRTk4R2J0Rk5v?=
 =?utf-8?B?NEkrUXVuQzdjWnZ4MEtCKzhmQktGaWpPZ1Z1Yk5HL2FuL0xaVGREbVo0TmVH?=
 =?utf-8?B?a3pLc1hrWXdGeFVMUS9LdHVTSmg0V0NaOU1BakNETkVzQkpDblBpTEcvTUFk?=
 =?utf-8?B?eUo0ZmtzdUZoeFFiWUQzSlJSWWtKY01EbXh4Tk1xamRxTkNNVG4zcTl6dUsy?=
 =?utf-8?B?U29TNWF1bTJ0T1NIVW1wdWhoR1ppSEFFL0p2TDRwL0hOeE55cE55cElwRm1m?=
 =?utf-8?B?TVU2LzdxRWdVeEIreXlkRWNOWFYzUkJsVDZ2a2R0UVg2TmxlNG1KZ0tuUEdT?=
 =?utf-8?B?UlJjeHVHK25iNEkxUVIxKzNsSnlXUSs5eGpJNERQOUZKZUJRdXdKR3VEaE1N?=
 =?utf-8?B?Ym9TUEdrUEtqQ1pHL2EvOVoyKzZUN2NNVWQzV3NyRzFQZGJRY1RjeHNDdVFv?=
 =?utf-8?B?VllIYmhjNXg0WTF0S1lOem1jOWF4OEdybTBIQ3FFUGwyTk44UXpCQWRUcEFk?=
 =?utf-8?B?b2xheXMzMlJxZXI1Z2RYRzZQK1g1ekYwV0x1UXlyNTYvM1hCQkloR3BoS1ps?=
 =?utf-8?Q?uyCUGj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5HYlRNUXcreWIxeHh5aUdqWmRLbEh6clV5ODBKdmthSEk0M2NYZENjS0I4?=
 =?utf-8?B?Y1F4dDZKTHRvT1M2WXRxVXdOOUttSDV2aDVXREd2anBJaEo2TC9JU2swbDJ4?=
 =?utf-8?B?aGJZUlM1L2wvVG01THZDSU5VcmtTdFQweGZJYVhKMGw5SS9xb1BmSHArNGFJ?=
 =?utf-8?B?cUU0Q0RaVnNERS83TVFDcmtiU2dEMkFWc0c0YzRpWERyQzU0VHhzcTZoSTNk?=
 =?utf-8?B?QXdYQW1KQUlGVTFiUFBXelg1TTZSUUxpYjZuY1BRRm03QXRkR3kvNjdwaHkv?=
 =?utf-8?B?Q1BlK3lYT0wxVjNHekpGVk1Xc2xHa0pFWnJSTUxURWJhdHhpL3hTOVhMUk10?=
 =?utf-8?B?ZmlKY2x2U0hST3RHUlk4SjMyYUZraGgycDRnVG0vZ1lQVmZZSmxMZkFNRitk?=
 =?utf-8?B?WFlUN1BUK1BXa3FYZGJ6UFQ1dVlWR2FPVmZJZE9Hb0RXSEpoM0dLamZGY01a?=
 =?utf-8?B?R2FXY0RxME9uOU9USEZnM1pBTURuKys1UWd3SWcrZUZkam9aWWdXUU5GUSs2?=
 =?utf-8?B?bU1tWnJRSFRabVpOcDhTeGp6RitjUm14N0ZzYzZhWm52cmFEZnlHN1pFcCtF?=
 =?utf-8?B?eEZGVVJMTDVJTDhQelBSNnVGMlY2VnJpTXJodnJJRmNTTU0vVFVER2pFeHJZ?=
 =?utf-8?B?ODZyNzVURFRlNWNEanYwUTNtZUVEMWtoL3pOUUFLS3RmSU5EZG1VMkZrckR6?=
 =?utf-8?B?cFVlNHhVakd5RmZTQThwZS9wSkQvWXRRdmU5dTQ1YXg1UFdCY3IzTkg5V25h?=
 =?utf-8?B?L1QvZ2g3Mlp2djVLSElESmxTTTR2SWRabTZMeHRHQ2JQRVJsMzJ0WmJFelNL?=
 =?utf-8?B?eFpxeW5OaGdvZGZLb0R4M2VmdjB0WjBDQ3pFa0ZZc01NT1ZJSlQvd0hDQm9T?=
 =?utf-8?B?aGNxUnI3NjdXRHJrWk9SZGxKMjlydTc3elhrb0VkMnU2L3hyTzJDVjJRVUdv?=
 =?utf-8?B?T3Eydnh1MUtKbWVRazhiTG9abXVHcUFlc0l6aG1ETHpTR3NZdHN1UUpYUUM1?=
 =?utf-8?B?eXZKWW1qY1U4dlpTdU5lQkxRb01LTmROQkJpNkJZclBPeU9wTm9acUNNMzNQ?=
 =?utf-8?B?dHhvREFUS1BteWhNWHdYZmZRZTM4aUlRZVg1ZlJDNEJWeWJCeVlaVEVYOTUv?=
 =?utf-8?B?QXYyYUswaU5yTXFrVHVtNkw3bFNHdTByRU83WGVmd29nazhGOFpkVDJFbXZz?=
 =?utf-8?B?MzZBREx0OFJKb3dWVWppWllZVkF1d2txbkNod09GK2NoN1hTdk1KeEFBQ2Qx?=
 =?utf-8?B?WU9ZVkk0elErc2thbVZiL2JuMUhBemZCckNzWmFxUUtPbE9ubkhhME1ncnhO?=
 =?utf-8?B?OTkwSVJOS1czbDNubUxFd1pMWGlkMk4wVmN5U09vOGhUS1lGQnVpWG1CQ1Y2?=
 =?utf-8?B?ZVRUeXM1bnhGRXh4bUYvTGNDaS9SWU5RVGJHM2JxV3BaRDJ6WUFvUTZ5T2Mz?=
 =?utf-8?B?Nm1PQjFkM2QxMXl0dks3endQUDlmWW1iUU1QM1ZRUUZNYWxlOEJhaCt5MTE4?=
 =?utf-8?B?NDJvcUpNRS9yRDZ5RG44SUhsWFVQdmNUSzBPS2VFWXA0VTZBVG1LSWVCQytR?=
 =?utf-8?B?TTJJUEErREF3OExkcXhQamd1NFhpUXVXK0tjVjB3TjI3eGR1UFdnaWdxU3h3?=
 =?utf-8?B?b010bXpRNjM2SGd3TEJFa1RudE9wVGZESTF1b0VMd1ZBS1FEdHY5WkZVWGhv?=
 =?utf-8?B?Wkg4aWR2QjZBb05SVGgwaS9obEF2QnFQUlEyeEZVRHFzdngvNjQ4dCtZRDB1?=
 =?utf-8?B?SDkremk1SWREQVhLZmxhQ2hnQ1lRbytBWlUyK203dk5Wd1U3UzZaV01reVZD?=
 =?utf-8?B?SDAxelZ3K0FwRDlFRGN1cTlMUTlCUmZ5OVgrdS9QdmxoMWVMS1YyYzZqOTRT?=
 =?utf-8?B?cmV4aWkzekNITlNUMk9tRDlvamx5WjdvdkthYVZGcUJkU1VBKzRWMVZjYVE2?=
 =?utf-8?B?M2c5Zkc0OW5xVCtReWxKWVZhNCtMNWg0Q3JxSDNJdmpKdXhGMTlKc2Y3UXFi?=
 =?utf-8?B?ZGIwK1pvVmtyaCt6bU9QOFR1Rm0xNkttaHZST3VlNGVFV24wQ2U5UmFhc2hy?=
 =?utf-8?B?dGc3K2RLSXhSQ200b3prL1VSanRWcXFwMEt4VHV4Qm5xVmZiaUUvNlE3K0dv?=
 =?utf-8?Q?9MKU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a062fa96-6767-4d5e-75ed-08de118b2b80
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:56.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY4w17N8waJhcpu0pOBKqLis7565jp5jFvCmvMf/C60kLODnwzSnPRXVCJtTKGqoO3EV8iGAWUwR5FY9qznykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Add fsl,tuning-step for usdhc1 and usdhc2 to improve card compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 0b8b32f6976813515bc8d9dce5486074d0ec8b7e..f99b9ce5f6540a1219fa25646208b4d61ec69efc 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -80,6 +80,8 @@ usdhc1: mmc@5b010000 {
 		assigned-clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <400000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
+		fsl,tuning-start-tap = <20>;
+		fsl,tuning-step = <2>;
 		status = "disabled";
 	};
 
@@ -108,6 +110,8 @@ usdhc3: mmc@5b030000 {
 		assigned-clocks = <&clk IMX_SC_R_SDHC_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <200000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
+		fsl,tuning-start-tap = <20>;
+		fsl,tuning-step = <2>;
 		status = "disabled";
 	};
 

-- 
2.34.1


