Return-Path: <netdev+bounces-231792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C965BFD713
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF230582F30
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E772C21D0;
	Wed, 22 Oct 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/E1xBZ7"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1E2C11F7;
	Wed, 22 Oct 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151864; cv=fail; b=uMqbGVmz072snCbzJEF1X8Fkc+htSrxRAPsHIj/hrpgrTX7FYhiUxbwBYxgzgH16QpAq28U6pZ6M5WVmDZ0mngURX9lErJkuXUio6Ok1On/PwZy9SOv4zdZ6wTrVFozCFXtF14Pi5UwZvnwfZ5KI47c86UkaJAV91ECs/cZZ/3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151864; c=relaxed/simple;
	bh=7RJ/qV8L4+qgRqPPIXZdyx1QiTt7p/jH1V+QO1kRW+g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TxG1LJII6qYx2UYx/SrnUmdwHmO2j8pZXIyYnC8sQph3n/UjgwG3Rq0OZgvt7JdIdOQ9xpSGVN98MBkj+hAMHXpKlOjPMuaVAwPRMUTeMuGt70qD8Dp6Na6VJdbdm8HT6DcU825hTqZeMehDr9ShCZXIImotx7tus9+UV32FnK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J/E1xBZ7; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=athAIo7/zWV731igWVzVewl6Fp8ETUZALhz6yNoLXNTF0FuOVBSHMRtgi0v27rYlKeSpUtFjCrmimrPPjBrxleJLgjGSH7DldLynxNaMuY1kD8ua1+E1PchKwDJa60a+O6zT7f0ph7hgYpgAe3M3AkpZfHyOzc66bOkOKox3mo24anAbktVzvu/pne4zJkrXC1ABrVofX53S7QpgHNj0BHCEJo3pwL4aL23hS9146RPGdUHWA3utMllR5vtXJVDl8YeMrn9xP/rRLgSsNn4lrmXPg0P3crDEf1UgUICdS0PcWHFwd9fVGuGFEAHFA9wddrdGu5+k5DPWOaLNcquDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/ckRgQQtfWDOY9IE7sdf8U12ieKy/g5BLDD+0nSdBg=;
 b=yN3RiW6+VwSREOv2/dSeg3KhseAExaPFNSS03ZR9n10nH6HIB1/Ypt5S/8NjmgN80g6QPOODklpVqRB4wyHHHp09Ghs8wbPx5R+4F6eDZNzGhcN3fl5MxDNZ0+p7Zf+RqekPJu61L5UZFcB9/r0sAumSUkLEcQtUUlj1hkk3DaLzIrAIY+Y2X3fYVwH+CkEcvLiyzZnrZU7j5sWEK0KjbnHumbYcNzeJ6wCL/TjQ4G7JD+wT0dr3yKlnFAfYyj+g9njc1kTy1XpyoZFXhYp+R/FPmbw6JpJkb5s5O7OLYUPNqtFgurVBCEjZiLNpg8Z1ZRQ2uBlNYUMoTbD9ntcLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/ckRgQQtfWDOY9IE7sdf8U12ieKy/g5BLDD+0nSdBg=;
 b=J/E1xBZ7oTgUh5czw27zEhNciO0i4o4ZGzOIQrfb5HpfMAH3DlsBdo7rre4dZxkD4nwGaPVnZ0N1z62F9bJh2JGw8A2goI5Zi/znmLRMRe3kElbK9TtUbxscze0VFc324/ebN7mAGpU7rjiMlm5NvSx/M5eVCSTk4qqnK1aN6vBaJu8OengGZygE51oAr4akJV7m/rbTJHC7GDAaYBYV+l+VEJS/jCE29Nb0K6RZgwH5TGSo//GGrpEG66N59XaPEHNENtq/wzOUzTEDmu48YGbGBLJo80Ksw1JyL57zDr2wvPfbS/0HUgWhhhZSfL2ARPDj86NBQ1OW+S/XKFJrog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:59 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:27 -0400
Subject: [PATCH 7/8] arm64: dts: imx8-ss-conn: add missed clock
 enet_2x_txclk for fec[1,2]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-7-8159dfdef8c5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=1673;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7RJ/qV8L4+qgRqPPIXZdyx1QiTt7p/jH1V+QO1kRW+g=;
 b=chAaOfvL3kw7qfb3oeUQcStbeI4bfHo4t25GJ7LJXnS4Evcx3ongLMiRqONPnbxZYEQNffMfB
 +9gbBrAmTOUBXNAw1cMw4hjJVrxgPVs0p1RvPXx0VZROWPob/NxFain
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
X-MS-Office365-Filtering-Correlation-Id: 75581e8d-065e-457f-94d9-08de118b2d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1pScEV1V3lublZyV1RMRGJMSjlJNGhTclEwYlE1aFhHZXc5SlNPb1p3dVMy?=
 =?utf-8?B?SGpWZVJBc2xQUm9ZcUNCNy9DQ051enVsc2hLSnNyK1M1Yk9UUDROOHhGYW5V?=
 =?utf-8?B?d1ZBLzZIN002cHJOdDlDcHVobm42bWpkVk15T2VyWUdWOVpoNWN5a2hzOU95?=
 =?utf-8?B?NHVnUGwwcFQ2N0hyOCtHZGw4UXkvMUExVURnRXpmQXcrUThTajdzK3JNWXY2?=
 =?utf-8?B?RXhDVzNLOTBxczlKWjkvVURkY0lNWm0zZ2JPczRUS2R0cENZSkdYa1RKSTRr?=
 =?utf-8?B?ZC9rYk9tSitmWnJuNzR5aFpQTTI4a0V3dDdMWUIyZC9hUFZhTk11Tmw0K29T?=
 =?utf-8?B?Z285Z1J3SkpxZnlMQlRIbnJwWXFKSkNyVFNPYmt1MGdoQnNkSjB6WVlUSDZn?=
 =?utf-8?B?czFicE1sMEpJRnE2RWUrWDIyWHpwVmV2WGRYZFU0c2NDM29WcHVQZ01LVkVj?=
 =?utf-8?B?dUxvZjBMcXBnallBQ3BjVHRrbjcxQitHTUFnT1dpNjZsa2NnSHJja1gzNFlL?=
 =?utf-8?B?a3hwVTVRZk5ET1VtdFQ5TkNPSENqaUwxY0lTSXNsTUhzcS9hUHVMcjZGMzVv?=
 =?utf-8?B?WkNqUzNTbGZPL1ZHUHNDeFFPWENPNDh2SWNTczBBUTlvY1pod0Rka0ljanBs?=
 =?utf-8?B?Tmg1dHVGaytYR3YrbHZFVzhpN1dwZCtjR0J1L3ppbm1pajFJV1hzWCtaalBt?=
 =?utf-8?B?MGhwaUVrblZhRzZrZURSVjA0VklPZUNsSnJjSE9Nc3U1Qm9GQmkxWGJFWld2?=
 =?utf-8?B?ZEVlVUUzeUpldzNWU21wMFhReWl5UTlTYWU5UUN3TEpyZzUrQzRkVjdNdXds?=
 =?utf-8?B?YVlldlhJZExHcGFURUJXTzFSVkhBc0MxRnNGbXdSSFhRWGxsTTJxNzNTVGNK?=
 =?utf-8?B?RDJLZG9mbjVjSDVvdGlKeTlabFdRelJMNTB0SXBYekN2WnFYZyt3cVM5WTFk?=
 =?utf-8?B?SXlFYmdzUGRMaWt2NERNRVBlaHVyNW9EbHJlVHVQenFCZ1dWZm5ra0RtdjJX?=
 =?utf-8?B?L21lZFhFSXh5MFZESEVUYzIzc1BYMEt0N3lndWhIK0d1eFNGVWZsNXNTME5U?=
 =?utf-8?B?cjlqY0QydCtQKzA2RGM3M3RMdUtpVzJCMzBNRnpocHk0K0F0bllnUjlFU3Ns?=
 =?utf-8?B?VVFKTWwvMEFFSU5KVmFKaVpuc012d1k5SEFpSlhYR1M3WW5YUmliVGtxYnM1?=
 =?utf-8?B?MGdDUWpXNlNDbkwrOHBuVlYxOHZiZmlhU1lOdzBEUWpNWUcwL3ZhK0tEVi9y?=
 =?utf-8?B?SjZpUGNDNVF0MDVNdkM0YUh1ZTNZbnUyTWRVTkFNWjVYMzFLT0VmUHZXeGNu?=
 =?utf-8?B?YVJSbkQ2UkZUclhTdkcwamRZWkkzZmNrcUNRbFVhcEh1MXZ0Z1AvNm9DWVhR?=
 =?utf-8?B?Y2pwVUZWc1JzbVhXZzZ2TFVvcnVTV2wyMFdud0VwdkZNR3dzRXlrcnQ3dUZi?=
 =?utf-8?B?N293VVJYUnRraHo0NkNuREJaaVJGV2QyOW1xNUZhRWpUbmN0NmJsT3djM1I4?=
 =?utf-8?B?QXR3QjFrVlhiRjZZaUt1cmxGL3pZazZWVUo0V0ZZMzVFRHBZQkZ2MDdpbGtz?=
 =?utf-8?B?V0dSejZUQzJKU2daVUpBL20yNzN1VWFnV0l5OGZ6S0FkcEJOVkh0WG0zSEJI?=
 =?utf-8?B?RjFwYldqOGNiTXpORi9CYjRMSGhOYzVuU0syK1hVL1pXc3pIZlJSNENaSmxx?=
 =?utf-8?B?dUgyRzg1NTFwaGJna0UvNnExcXNFSm1DREd6NERXNE5KaFlZUitQQW8zck1J?=
 =?utf-8?B?aEFuNkVyQktMSE15bzdhdkNtMGZYaGRLYVN6T0F6cHUxVXlxWGI1SG1TSkFJ?=
 =?utf-8?B?dUFSWURleUFscW9XelFiSjZydUlPL00wVWtaZGdCY2djKy9mekRRMFRLZEtz?=
 =?utf-8?B?RTVTQWs0bGZSVkFXSGFCcGZCOFNvVTRHN0gvanNHN2NwRGNuT3FiY2wwcFZS?=
 =?utf-8?B?ai8vem8zbHRMUDBxTFU5Ni90ckFwSGxpSUhPZGhQUVpzMEFFVWhXazJvU1V5?=
 =?utf-8?B?REgyN2FsQXEvdHovbjdWZDllZFJDTDg2Nkt1YVV5L0MvcXFXbDJEcm5nRUdJ?=
 =?utf-8?Q?g4bL8F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWhTQzhMUEg2MVdSQ2lTL2ZITktqU1lJN1ZKYm12RlpWNHErRFJpY0RlVGdo?=
 =?utf-8?B?ODFaRWdBeDl0SGQ0ODVuaUp1RURHdEdpd1ZLQzVsTVN4TW5QZndBb3hyaGVs?=
 =?utf-8?B?STVKWXpiUjJvSUNSV20yTllwNFFKY2RQTzFuVVJDUkVPZWxnMnFqOFdVU09F?=
 =?utf-8?B?YWZyNG5tbVhRQTh2ZFdEVmJVS3dKYVJrTDcySG5EZkJlbWR5YlRjeXIveXJi?=
 =?utf-8?B?YkVRcDFYZzg0WTNtZVVraHFSUWpreFpBT2VLTjRNRU1hSHlBZDJSMlBuOHFp?=
 =?utf-8?B?aWJiRDBMSjNHTU9KMEQrMTUzd29FMEZhd2ZRa0RRZFZCUkJwNGgyN2hRZTE1?=
 =?utf-8?B?YmFieVdUTWRSSlhVcTdlUktXOXVEQTVKWFQ4YWJPUnM5eEZVZjg3d3VScTNu?=
 =?utf-8?B?NUJrZkNwTjlhRGd4ZnpkVXBGRVMweXg4WGxlOUs5clFVcjhpSlF3Vmx3YWwr?=
 =?utf-8?B?RWRMd29yd21rYXVTczhyemlYdGtWcFlVSTVZOWh6MGxZeGZyNmZyL1ZCdEVH?=
 =?utf-8?B?ZGVwcGF5VHdVZjY2MC8xNUsvVWVHbjAzU3lCTWlYV0xGUVZVZ1g2RXZMQzJo?=
 =?utf-8?B?aWhqRVY3aVcwSTZVYVU0aWxxR2VDNDEyN29uWGpnYW5xZlN3d08xNWtYWEpV?=
 =?utf-8?B?bnNJYzQxN25GMHovaXdHQVdxZ2lqWmN5akM2L0c3ekFQK25rcjBtdVpJcGVD?=
 =?utf-8?B?ZFoxczhhY3NXRmhQRk01RTA4QzQzSlpTdmVVRG15L3U3YWxXR0xNYnd1STBK?=
 =?utf-8?B?MVBtUlJ1Wmg3K09sa2NzTk9tVitSd0hFbXZOeVMxd0RkQml5SDZrVFVVSUxn?=
 =?utf-8?B?aUo3TXVoS0N1WjhQTnh1Vlk4eXFtZ3FXSEU1cWZBd0JkNEp3QnBac3dLQXV4?=
 =?utf-8?B?STcvRjlqK21uaDJVREh0TXo4Nkg4clIraWczUHhWQVczRS9DTnZCcGhHM1Bo?=
 =?utf-8?B?aEFGRG1MaHJUdGJPbWVZbkgwVWJLZTFLK1RaUmUrcFA3Y1JsdTRaZjE2OWVr?=
 =?utf-8?B?N2dueGNQREJHei9sRXJGR1owRnRZd0RjT2NMZ3RWVzEya1Y5c3dJOTZScjRn?=
 =?utf-8?B?UGpVaVBHN1NaTS9WRGZDbnYrWjBYWE1mNUo1eUY5MXRFV3E3M25IcVpzN3pT?=
 =?utf-8?B?TnZxb240RkhhTTRkdzYrSDREY0ErVkZla2l2OXYyUW9WNzRzVWcrYm9lQisw?=
 =?utf-8?B?K0Z2RnNnZVNOZDdTNVFJTmVzSlBSWk1aZEF6VVJsb2J5Vyt6V2VZNm5ONVM3?=
 =?utf-8?B?UTQ0VkRjY2w1SWxUd2dnNHhPNDBRS1hIOGdrNUtMQlo0OGdQRHFDY0NTeGdz?=
 =?utf-8?B?cDR2MisvMlVyR3EvYlVWUzd6ZlArdXpFRlRzdWlIQnl2V1VuWW9oQ3JYWVN2?=
 =?utf-8?B?VnNlUWl0NHJkbXg0NE93ZUN4S0J4alZxTytMTGI5dHNWUjl5a0FkcW5KL3dF?=
 =?utf-8?B?TC9OUDRLd2hvVlFpa2Q2ZHRSdFVrU0E2aXRrK21QUGcwQ1lIVHZqVFlRSmJw?=
 =?utf-8?B?SU16bnoyOUtYK0Y0YXJyN2MxQmVhM1NHYVpuSC9SQkFucDlxc2VQNmJHZllj?=
 =?utf-8?B?NHA2WG9OUlVucjNPclhVZHpNQUgwZEw3WGJobGIwYmd3bU5uWUFzSUpkN2dY?=
 =?utf-8?B?Q1ZUU2xBS0tvWEdKOC9EU0orbGxIelI5NmVnemRzQkxWaElsSVU1dFduWUpq?=
 =?utf-8?B?N0k3TVY3d3lydkFqUEdoTjhuOTQ0MnRTNnV4enN6VTlTL2RVbDBJdlNVcHRP?=
 =?utf-8?B?Q2h0Y3cwSUxkYVRyL3AwamYzQjFMVmhIdEtjSjRsMUhZSWJnekxJUm5HMHJU?=
 =?utf-8?B?QXAvekdYL21pdXVxd2NQVlpEQURFc2JsZXNvR3d5WmNqVERNZVZ6VWc1M1ZH?=
 =?utf-8?B?ZVpDNUo3TXJ2WDRRMkJFY2dqVW1QckRna2F0OElSTkVCTG5uY1k5aDhsZFZR?=
 =?utf-8?B?L0FTSWNxSnk5UTY0SjVKVk14UDU4VGJHTlFYelZHSlhjeW1rejFKbGdqTHhK?=
 =?utf-8?B?bDVmY2F0VjJWcDVTV2srbXNDaVp1UVliK0I5RUNXdlZOTVk3UUJwZDVPbTdJ?=
 =?utf-8?B?U0gwSUVkdk9WUDRUS2hPaGdyMmJJa0wvMTkvRkJWTDRMbFB6N3dUcGpOSGpM?=
 =?utf-8?Q?uqyo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75581e8d-065e-457f-94d9-08de118b2d5b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:59.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq48XpCvCNRdKSIyjjXz1Bj6Tx/LJxE3JJ6pki21JuufC48ObNzTvZ7bRRae0t0lxRE2EfB4ulcysuibU4ug7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Add missed clock enet_2x_txclk for fec[1,2].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index f99b9ce5f6540a1219fa25646208b4d61ec69efc..176e2e332f87c5444ca4457e3af653a87351b434 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -124,8 +124,9 @@ fec1: ethernet@5b040000 {
 		clocks = <&enet0_lpcg IMX_LPCG_CLK_4>,
 			 <&enet0_lpcg IMX_LPCG_CLK_2>,
 			 <&enet0_lpcg IMX_LPCG_CLK_3>,
-			 <&enet0_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+			 <&enet0_lpcg IMX_LPCG_CLK_0>,
+			 <&enet0_lpcg IMX_LPCG_CLK_1>;
+		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp", "enet_2x_txclk";
 		assigned-clocks = <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
 				  <&clk IMX_SC_R_ENET_0 IMX_SC_C_CLKDIV>;
 		assigned-clock-rates = <250000000>, <125000000>;
@@ -144,8 +145,9 @@ fec2: ethernet@5b050000 {
 		clocks = <&enet1_lpcg IMX_LPCG_CLK_4>,
 			 <&enet1_lpcg IMX_LPCG_CLK_2>,
 			 <&enet1_lpcg IMX_LPCG_CLK_3>,
-			 <&enet1_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+			 <&enet1_lpcg IMX_LPCG_CLK_0>,
+			 <&enet0_lpcg IMX_LPCG_CLK_1>;
+		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp", "enet_2x_txclk";
 		assigned-clocks = <&clk IMX_SC_R_ENET_1 IMX_SC_PM_CLK_PER>,
 				  <&clk IMX_SC_R_ENET_1 IMX_SC_C_CLKDIV>;
 		assigned-clock-rates = <250000000>, <125000000>;

-- 
2.34.1


