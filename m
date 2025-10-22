Return-Path: <netdev+bounces-231788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8207BFD60B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 653ED358C1E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73312877D5;
	Wed, 22 Oct 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2vpttDN"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDD27FD51;
	Wed, 22 Oct 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151852; cv=fail; b=gMThrbf/4nJdqTjCLequaMz5xeTy/5Wu8J6dRQAxAqZ+9AQ4CMMKvPKYikEiJmYvURaSesAebegguFD8fmmFjPNMD57qTYzJV586UkzVceiiV1DIHC9sShCewNLePGUgHGT2ZX5KUcSlcWafwcZhaSEUyXVAgFteRM4IpQa+/7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151852; c=relaxed/simple;
	bh=xG/fbB2TwtzXstW6gG4Lnxbc1CKYhYViQk30Ly8wIV8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u5ORUC1VBLMGdZmKsqj+hg/B2QD0wr+5sFa48BWSkrdx+LFPUxGiaDK7jrX9vQVyqtYMp0hLJXfxTTgf0Y9u1U4RXf4EeIKqu9LI55AuFC3ma6eNCALxoNuVidSJXOWBftirLzRVYy/JJYFr8l4R09ip0dNqhKjAzx1KHv0b4d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f2vpttDN; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECzSKdHtyyLWqrhR9DB+79F9c0DjTMO4hP6uwKAArukXWpNiBsOlPK3/b1XnahL4OyIMoud8azOXne2JlUYAS6FLWoh1LGmWSC9ECjVbLo8vXwIzNh2HJQWtp/cZOfmm+p9pr8TUEVOd0vZu5tEsF5lblt+osiGI9ZhjwZ71uktp0Vd1kG0iVV9YO1g7O7fZUjzileUqIFlbeQUcjkqbV3ExN4dP0cByn6k+Ex70uWm1hIC2sgRYTxkUmRXY7ezXLTz6CmOEIAGfGhdU7/9k6zThioeZ4GkLOKH+naMDcLBKNdARuhBTId4meDjGghMFeddqvAIF6tnS5quLX/Ncjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6mv14zDK9rj6qRyz6Y/8SlHAzb06AEl/d8SHhyVYXo=;
 b=uyXnv3av3JfjkPmkCyajPNf3K5uqfOP3ZSOw8BRag7psXRapLadPkDxTWVu2o1vCcekjr9p7aHHbg8E3WdKmgkqw7UlnQ3aSHR/r59i4fcCAvmKIIvKFbaLj6Kxji0Th52XbFQDTxqBeFX4RYMAC0Wjd4YEwwvMImsUq66sRf4tQz5OzSRAx3FW5bJJtLOwSWdkGM5oCXjSDRwDP0AKuFOaaEWCyCUDdXtO303rkQXAAYdXKLvSpfhe0G6f80EjcFQ7itgAKjqNqW9plj5kVKWw7QEvL9ReReWoQztNladd6lJQQVwKs4oFgsNbCRLaTcfYG49wEWcyE5+uNlvjABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6mv14zDK9rj6qRyz6Y/8SlHAzb06AEl/d8SHhyVYXo=;
 b=f2vpttDNhY2kFo2cr4Xumf8QS1e12piNbkmZl9EUNTaRcpJwq0RwzZAgMDUDQl/vhY/Ias8El4mHRdhBb1vdRrsLj02eJLDgYpDC87EENmFeRdubQl9lgAO13zKps8D+VHWfGy2DiAHZ88BhRSN37zyGsD1S5rv5obPCIbz8DKg8rhMznXOPSdNHMowbs11Gtg4qg2TEAx26VIglSmmx7dtJ5ALWNAuMVqYiNfPizZMYYlFKCe6YtO7CvOVMHb+RzrC3My/YRfZoZ2qq8ZmeFKZcw6GDrJjcJbj5x0hO5ulqQyWsbhA5zJ0cGCKLzT2UfTNYba//Jdp93uU3BbPbFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:47 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:23 -0400
Subject: [PATCH 3/8] arm64: dts: imx8dxl-evk: add bt information for
 lpuart1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-3-8159dfdef8c5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=702;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xG/fbB2TwtzXstW6gG4Lnxbc1CKYhYViQk30Ly8wIV8=;
 b=ekfjlJv8GemGzkAQWS4oas2e90yyPdaMpPupsKT0C4Xon8GWAHlWczV9bcQCvtAGhuNmrpQKI
 pi+ypKO/D4XBcp+/BcHj3ui1lKsYZKUBlIMrtHcOEkp1WRR5eM+ktU5
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
X-MS-Office365-Filtering-Correlation-Id: f8635374-fccd-4f4d-c437-08de118b265e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFlBMm5kZmpZdVNTOE1LanR3YTZSWVI1NWxsY1I3MnIwZVpaTWJyZUowYisz?=
 =?utf-8?B?eFcxMFN2ZkgrZHYrQnlRZVYyV1FjaStGcUJ4NEZWVFd5OEt1OWU4eEg5Um52?=
 =?utf-8?B?U1orWXNNTjZJOHhlSW1sSmNTc1JzV1h5TlZ1YW9MVnZPamhzNVJVanBkWWlk?=
 =?utf-8?B?c21oUU9SMkNPZlJ6WUVIcTd1MEJYQloyR1Y3dzdLdFdta0J0VWxNeXg1OGQy?=
 =?utf-8?B?RVVQcGgzeUFWY0lWK0hOL1BHdllJSHRJdERVb2NzRWJGNGhlbjljaExBVE1J?=
 =?utf-8?B?MGQ5OGl3dEpRMDVtd3RNOVl3Z3hhN1pyNjNQSmFNWmFpN1pGeFYxTkI3eHlM?=
 =?utf-8?B?Y1d6OXB5cVBaWVV4Tmh3VE9NT0VQWWhiTnl6ZTdlRjhVdGljSDNMcG02QUtw?=
 =?utf-8?B?RTdGcy8ycjhXeUQrZlIwdlNVNXRlWmh4YnljZHBuZXNzUkJtczh4aDcvMWZW?=
 =?utf-8?B?eGtLRlM2TkVEOXh2SEhXVHZMbkJLdHVRYUYrb25ReUtiNlIyRXl2WURtN3ll?=
 =?utf-8?B?TG5EUHgyVTRSdkpYZ1pyb0NoRmJtUXh4SnV3b0srS3E5UVdFZWVDMWd3VFYy?=
 =?utf-8?B?cjZ6YkxBelBxQXRWSVorR05GRmpLVTdBbHRRUk44Q3dZdDA2dTZoM0wyVDRY?=
 =?utf-8?B?RDE5aEh3OGl5QjFXYUtLUFgxN0xkYzIwS25wb2J2bUlhMkovNXl5bXo0N3Ew?=
 =?utf-8?B?WUx6YVlic2VwVjdSK3QrYXZFQXZidGhKMC9KTVM1MVRvczlFaWZ0dXRJUnFT?=
 =?utf-8?B?KzAvR2s5T1IyS1pRZkpZSklQN3E5am5MeEZjTE1iOGtHN1ZDZjdLdGdVdFlq?=
 =?utf-8?B?MVdmbUNOd1l4dW1QODZQVWs0Qkh6a1N2WUU5UkR3Zkpya0VYdWpDQVI2VlNB?=
 =?utf-8?B?QkZac3MrYngwaUJvTDRkYXVHcTZjSlh4aWpuYUR5bzJBMVJoeXRMSUlrV2hL?=
 =?utf-8?B?bnhNenZxUTYrQ3FRUGVUNStMamdiWXBkbElwVktWUjJLa282eWpGVmxLUlhU?=
 =?utf-8?B?OUtKRHRaRFB4TVZMc3hXa0tzT0ZJaXpDUzI5UE5Ua0hSdllCeG5JTTBocWlQ?=
 =?utf-8?B?d0oxRmpIZzM5UG1yb0pYS3NYWUF4UkdVRkxlcGo5NjdCOVdLTlBwRlRRSnJG?=
 =?utf-8?B?N3J5NkJBM2Joa25wOHFiSXFNZ1FOajN3UUh2MmR3RVBkWmc4bkk4NHNJSWNR?=
 =?utf-8?B?Undxa2xKelZFSlBEcWpuQUFURTZBQjU5a1lhTUVaYXpocEV2TEE5ZFlhbVpF?=
 =?utf-8?B?a0VFZ29PR2JTaVZTRWtXZzJqUXFpQjBOMEdyM2hQa1ZIc3MxM2xhYXNxRXht?=
 =?utf-8?B?Vnp4VVFoYmpKYTBjTW5ieVlhK1FKcUZaTjRmMHFuSWE3MFN2dmRocGxlWnNN?=
 =?utf-8?B?S1dsNTF6YVlsOFFGMkFpNm1DaEphdHVBaTlVSDJWSnUyZ3NnMTUrLzFlVEx4?=
 =?utf-8?B?RnhzMXk5Z2F3bDVXWktKSmdleHpXeUpxYzRwcmVlNkhaMDBIUFgveFZWR3NL?=
 =?utf-8?B?RkpqZ2lwNGpBLy8zYklWR1VYT0U4S1Y4WXVPWDhUVGF6aDFqWnAzb3JUS1d1?=
 =?utf-8?B?cTlNYzNlbnpTVUV3b2xOdEJHRE1kdmk1MDNNcDQ2NjB2eHBmUjB4V01EaWY0?=
 =?utf-8?B?YkRTQUV3SzlQaGhLNlhvYWthRUdLejFzK3NVd0lKcTBmZHVoeEdBbjA5V1Z2?=
 =?utf-8?B?RTlsaldrQkE1aVNRWU44dC9KbmtpRG5LUkUxVDdNTURrdGo2NEpTa0RRVnND?=
 =?utf-8?B?akFod0lIc3pRNWtWZ1pNcHk5REw5aWRHcGlCWkJLMXpEVnVTNDlWcHYraFl5?=
 =?utf-8?B?TERWelIzL3dKelhGKy9BK2thaHdjWmNEcnFIaXUrVFVwSktxZy9YQnhvc1FN?=
 =?utf-8?B?RUNvbGt2dWZuOUIxbDQwYmFxWk5IRTBZL2lCN251NDBJb3dRR1FxOExZM3dy?=
 =?utf-8?B?VEJRK1dWWVFnWHcySGl0cEFNbzJjQXFVdE4ya291a2RVMi9VbllFM0VhcU1I?=
 =?utf-8?B?SmNubWk0TzJaSlFOSVZnYlV1RGlISno5ajZuSUxDYmRJVVk1ejA0Z1ZYMTVp?=
 =?utf-8?Q?LEp3HX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGdKTVkwdE9FQWorYlFORW9BekNmcjVONDRwR0x0SFV0aE95cUY0cVZMSXBK?=
 =?utf-8?B?YkVhWWRsb0c1dTZQWnVCQmJKVHhkM1BXNWxBR3MxUW9ycmY3WXYyTEpWcGlW?=
 =?utf-8?B?VkJNaStBOVcyazJMeDdHWm1nQkFjNlVXYkJFYzJyMFBrVHgyWHdCMDJQTloz?=
 =?utf-8?B?dGM5L2FMcHZjbkU3cmVENTVxc3Mrc0JSMWhNNElVdDZIZDVHeG4zYjBITnhJ?=
 =?utf-8?B?OWtxRmx4N3dSaGp3ZzlDSWFmR1BySnZ3d0JZcXAwU3BkdWtUVm83WTBRMGVt?=
 =?utf-8?B?b3grMGphUE8wOVhna2NBODF4THVoVkFtNlQwVkNhYk03UzFhemh4aHdBOEJV?=
 =?utf-8?B?MTlRTTZDQlVkOTNNWUtOQVlMSWNMK2syRWdxZjFadCtNbFlTVnJBY2UweEth?=
 =?utf-8?B?OUVTalVHblp5c3hKYU5rR3RLUzF6b05BdDVMSWUvYVl5TFRTRm9zeXZtTlFy?=
 =?utf-8?B?Q1FwTTZ5SzVvMFZabi9xY2FZNml0NUx0U1JrZkRaV0R6YXRGbjVWdGp2Zm1v?=
 =?utf-8?B?R2cyVW5NUHVSSGpvazEvREZ1ZnFsWlhhanVhd0Mvb3l5MnFVKzV4V0pEWUha?=
 =?utf-8?B?NDN4R2JnL09aZGo0U29hNERPUWQ1cVF0eTgrWFAybkJsbmY5VU1oMWRsays3?=
 =?utf-8?B?REZrZzd5S0xaM09HcC8xYmttbE44cXh4YnFaRnBFd2ZQRDdjUjdYODJhU3I5?=
 =?utf-8?B?RHZLdWt3NTBwZE5NUHlYRDc4WWFkU0piRGNLY2NaNjg4N0JxRGMxaktkSE02?=
 =?utf-8?B?YzJMdHoveWY2b256VVRuMVVQM3QvQUd2MzZBb3JQdVRaV0hpRUUraHJSWWt4?=
 =?utf-8?B?WStOeHVZWUt2SGw0MG5mdy9IZXhrbnVUdUxOQXNXdGJHbkYzS2lod3h3aXJ3?=
 =?utf-8?B?QytWbURnYTVwUEZFU0NIdHgrSTFsWC8zNDZsUVV4N0ZjajY1Mit5SnhNMFRU?=
 =?utf-8?B?d1FPZ2loRFN6bCsxSDd0enYrRm5hZzREMHdNaFovem1VbVZsVU83RWZtRlJ2?=
 =?utf-8?B?akVtUDVmeDVLTkJEQXpiVUNJYjBGWllYSm9jaHMvT09zRDJlQTE2WVQxb2Ju?=
 =?utf-8?B?NlBISGlTWGtuRGR1TGhybGxsZFAvNFpWWTdMZldlZXVPSjBkclJaaHlwWGZx?=
 =?utf-8?B?NE85aGhXaFprUUtITlZJb2VxRUd2bE1USmZCNmNJQzQ3dkJwdi9EREE3TUEz?=
 =?utf-8?B?Um1QSTZ4VUEwbmNSczc3WG9iVlRDMVI0MEt2OVZzYysxQ2xhbmhVRkg3MEcr?=
 =?utf-8?B?VVlkZ252ZmtyY0RGM3VWcXdkekhsNVdEalNCRmVENmc0OGU3RWplSHdhcXdG?=
 =?utf-8?B?ajRiUGZNNnNQQzdUclVWMUhVakVVZGQ3ZzZTSTYwZGRIMklhN2dGWWRreVB3?=
 =?utf-8?B?SmllaFRXcCt1cXNYZktSZVlUa1VUd294c01LOFFkWDBEZ3c5OXBEYkc0Z0pW?=
 =?utf-8?B?Ti9ZVzcyb0xjK3lnN3lVQmJpSEgydTJjcGxncjM4ZHhkZ29kbzFxOFZ2WnJ2?=
 =?utf-8?B?aXBzQ01NU0FLNlhVVjYrVkxhejUza2ZWQUpzNmtCWU9LMHFRUnQ0cEIvWXNW?=
 =?utf-8?B?dStidEZ5a05EaGN4bTBSWTBRTUk2RlJXUWErcnV6aTMrYUJGckFxL1cvZitn?=
 =?utf-8?B?VW9od2JBaEZFamhRM2VNTnloZk1JUFpqZTB6VjEyVFlUL3QyTnQ5Y3JCRXh3?=
 =?utf-8?B?OHNrcE5KeEhqRGxGaXEzQlZWT1UxL2hhR0lQREJwNSs0Z0phT0lGNUVMNmRh?=
 =?utf-8?B?aUhTeW4yMHRJeXhxMnBDcHRwelNzeUFEUXlTeGhHUk5DdUUvaXl3Y29FQ3Z3?=
 =?utf-8?B?dnBWQWh5OHYvQnk3QXFieXg3dkJXM2ZiUDFDaDFTNkNmTFZHOWNqK3l5Y1VG?=
 =?utf-8?B?VlRyN0NYT1ErbVZFRFZOVTdkMjRtTTE3QUhZS01HSmk1T3B4QXVSOVNub0hS?=
 =?utf-8?B?YlpNVG9mNjhNei9ta1JVdzA5R3pZS2dib2hCZ2E1U2p6S2hXR1hjMXVqd2VF?=
 =?utf-8?B?bE80eFBPMUY0YnMwZTAwZlN4MFNqTlZFa1ppZ3RUMFR6aWpiQUplVnIvRGlS?=
 =?utf-8?B?VUgwVXhRVk9SYkVLOWtsN1hiMGtQcUVKTUxxZ3JZUlZTa2VzNDBONFZra0pt?=
 =?utf-8?Q?xf7cqzspYK0iQVBzQonr1jeNI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8635374-fccd-4f4d-c437-08de118b265e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:47.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2fOGQUGHARErHtz7uryWMp+aSSnMaloK7vsjsEOoSujnpaKQXaDSvD0lni4m04RUlBahK4/KY1pMONyNWaLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Add BT information for lpuart1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 25a77cac6f0b5f71603933e75a6930956ac7239c..bd58fa54fea8922327393a47d9060ad33e38cac7 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -598,6 +598,10 @@ &lpuart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart1>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
 };
 
 &lsio_mu5 {

-- 
2.34.1


