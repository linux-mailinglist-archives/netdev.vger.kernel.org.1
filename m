Return-Path: <netdev+bounces-226750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C993BA4B4C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C661B273ED
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC73064B9;
	Fri, 26 Sep 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ASM74b+F"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAA30649E;
	Fri, 26 Sep 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905269; cv=fail; b=spQ6iT2CJ3Wt4dUoBSNLxRChUMVsJLkHfcdkz8v9xx8oIvlvhyNPs34uA6SlTVOZ/2Z3mzzEds3eZNoDkzUb7dJrFXxXUJ19Z1SdZ+m+drUowLtQkE7q56/A60xOuMTQHEbvS1ZNMhUQMZFIFNk56JWgcaYytg4wEYJV1lp0VEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905269; c=relaxed/simple;
	bh=WUs7rE0Agf77eoBg34lVDN+LGyvuAYiEcfB+2qWsU2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P9hZ+Db0eIojb9VT7vKXEHFcctf76WBdSpVbhLvCXGjQx3pJYcX3FdEY9Vs5EhpbVRFNMutqoG3wdbqZ8a15y1q2iCBWz3tGLqBBhUNuDP6XeBvGIuv4Nnu2Cn0CpDUjJ5CotckUP0BW3Ma7AeuHX09B2SMnZrPmOWaWXxqiOBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ASM74b+F; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMw2+ihVJx8axcgEZF5McRrTHw+GA5VU0rHTdqsmnusVGwDBmOXphcoDHPCNjgkSBntv2kZOl6C1hWQKqrNP8JUsZTK4811YkUQ/SyAycedzMcWtv26IAS570Z0TnRih3G6ndW41HFNEN+JX5Urzx+PyorgvW2CLakbPxdIxyXLmAteYhS0ZKWmQ5vzIWPru8i7dw+jkOr2KkoJ4mer46f2ufmaSRNflCF4TdCkWWjfyyh2e9tMBGwhMd8s8tMAwn7jiaF3S0dmAsFCeTIN0hPF+V+opFSVs4NXCMOFNX2R7cNp0/VXqXecnUoxssVlrLivN2IJPIRvKkzaezKp0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut1Uv7e/hO5bPmHa+B9rNjrEa0C0obWESBpOH/MnuWo=;
 b=ODp5vifhL17fuLoaszTPCA6YL2DwkU+1sXVmHaY0aH5EcNkVm1HUFGGOROuJtq5UvnpQ/8to0PHf83YC/S1JJMxS+fXH19SLSvPxztcJACQaJBTVrASo+dQACKekMEwevmidu+mO3YZ/CJtL7cjLOlckQgMqyeDQSk7LyefUAdTavKkJrIBeWT7h7zfaPXaYd5kqtHd4MR/OxYxNyaFk2vx2hzhQDeRGX3huJzzgwp5L1jX3NYuXpVQjvuzORFMDaQoAd77lEmhdES/Cm6VWP1OFUPtYL+sadLBCb8WaMDrcAyNJDkUlLAdcLNLNysrkglsmed/yqqbQIJtLOPhdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut1Uv7e/hO5bPmHa+B9rNjrEa0C0obWESBpOH/MnuWo=;
 b=ASM74b+FaL2Nr/0gx0vAbw3bZYj+vw9tqatmUhqk9C/MvOR0RCGg9aCU0NeEUAHbjDuSwp1ptZIUEFh3YU82HzL3GTc2wsKkdqO0ASMg5CHnp3R0aojWrA2qffgNkGWwbyQT50RaSAAuTx2lby0I2mjEbWnvhBXli3t6AfEAewK74azIuiKSwMTESbQTw0UJq0Tzz0PUBOrx/WLdYKGrur+YqiYzdWOEdboPAfSoWhk/WxerbkcK4GBfIgxU6O754ra6uR4tmnnmFvYT5L0L39i++SGNzr3gYIHq+6fEqnfQeBbpkxWB4J0/+81OWKQji0/K+NcM/FG4j2RF5r3rBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by LV3PR03MB7753.namprd03.prod.outlook.com (2603:10b6:408:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 16:47:44 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 16:47:43 +0000
Message-ID: <1e82455f-5668-41fd-bebb-0a0f7139cc3f@altera.com>
Date: Fri, 26 Sep 2025 22:17:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
 <20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
 <20250917154920.7925a20d@kernel.org> <20250917155412.7b2af4f1@kernel.org>
 <a914f668-95b2-4e6d-bd04-01932fe0fe48@altera.com>
 <20250924160535.12c14ae9@kernel.org>
 <157d21fc-4745-4fa3-b7b1-b9f33e2e926e@altera.com>
 <20250925185230.62b4e2a5@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250925185230.62b4e2a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|LV3PR03MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 559d73b5-1685-4ff2-7ebf-08ddfd1c69c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXBpTEErRkZrOVp3L2wzcC9QTVFsWjJXUW1uZ0kvNTFNUk9tZ2ViY2Q5c0JU?=
 =?utf-8?B?K2pUN2xsUERTL3F4WEQ3cm9QWHBvRVh0eUY0Y2JVd3ZHaXpROU5MWGUxMkp3?=
 =?utf-8?B?Sk1LWUROVlhFWGN3WEc0YVVJS3RnVmhrT1RPbVhwbFJsREFibVFreWE0U2p1?=
 =?utf-8?B?WlhmKzhYR3hMRFB3YnpmUEhucU5HYVdNUFJNLzVJMGkvVzJ5dC94ZU4rUFp6?=
 =?utf-8?B?L2ZZY3c5bGtRQmlGNnRnamdrM0gxenY5YTRWQ1IvWlRYNCtnc1BMalFZaWVT?=
 =?utf-8?B?OWphTE5EOFFMU3RDZjh5VC9ZeGt1WEs2WmhPRldRVmFMMUREcm01UkM3azlF?=
 =?utf-8?B?SHhNNEhzUys3NlBjTGVVcFBVMTNBOFdmR0RQcVNpOFNEZUk3eDIrK21rTWlH?=
 =?utf-8?B?ZU5kREhiVFRlc00xYWl1VG1pU1NKUGc2VStLWExOdXEwT2UzT3BhRTdJYTh3?=
 =?utf-8?B?a2x4aDN1a1ljRnQ3dFU4UGdEVHdkVEVmcFV3QWtZM0lqS2ZnV1Y1U0RPZ2Vz?=
 =?utf-8?B?ejlQOFM2RzdVS0lkWFQ0WWZKRnNFSlVobStIQ2JqbW9mK3I0M1V2c2JyZGIr?=
 =?utf-8?B?VEVWVEVCT3hTaHRRTUZKTEZ6dDIvS2VCVDIzSTdndDNXKzZZQUFrWFdnUzVL?=
 =?utf-8?B?S0NDaEZlMjEybVk3U2JPSmF2NXpEOWhCSW1PUmFFd1FEMTgxdXFiTlpLZHBB?=
 =?utf-8?B?dEM2K2ZJelNjTEo0NGhjQU80dmxIUW5WNFE4VFlUL1c2OWR1M20vb0ZjVGwv?=
 =?utf-8?B?SndyNzdsUjJlbWNGZm9DMWRIbUJWb1hpcXN4TkxhUmFJenR0K1ZLbnNUQ2xr?=
 =?utf-8?B?a282WHFrNDJNR3ZObGttV1llNzE5RTJ4cUxBQnEwYlFpNm84RjhESDVRY3Fy?=
 =?utf-8?B?Ym5WcjcxaXd1TTdCOExtTmJXeTJnNzhRSzhIMXQycTNzRjZnWWtSd1IyNEVK?=
 =?utf-8?B?MjJLNEk2d2piZi9IUkd0N1ZtOTZ6SmxqQllGWDViQ0xKRUpUMTlaWGgvM0pu?=
 =?utf-8?B?WG13VytKWlF6S3U0dUlnMyt0L2V6d3hxa0NVUGZ1VkRuVENPQ3hRZG9jcU9U?=
 =?utf-8?B?dzR5bkRtbEs0Z2Z3TnRkUHJwRXIxMnArcGVNUTVqOE9sVXhoOExKNnRxeG5N?=
 =?utf-8?B?Vm9OZGVCaUxaYTZ1OVdUNmRFakliNmVuR0xSR2dUNVV1Z3lFb3BlV1A0VW5z?=
 =?utf-8?B?WGdPR3FjUnZaRlNHMVpIQkhoSy9RK2l0VUJDVGYrV3FNZDZWbzJHQ3ZQMFUr?=
 =?utf-8?B?cDYvTStVcXBVOUN3ZW1SMWw1UGtlMkxpVTY5dlVKM1pORGVISFFiNjhweG5q?=
 =?utf-8?B?cndGR2FxWTBhWmlnYWZyZ2VQeWEzWGMyaVZmV3RNVEY0TVRCVmN4SWkvMG9i?=
 =?utf-8?B?ajVINW1SSFFGeGszS2tWT2ZGdnJaUGp6L05XNXdlUUVTdGs2RXhSTHJmWTA1?=
 =?utf-8?B?Z3Q5d0N5M3ptTHAxTytXdndvbEhhTGlmd0tiRFRIclgxYjA5TXlDaXRjUVQv?=
 =?utf-8?B?SVkzcFhlL3orcnF5NmhZODZVYStZZDRLWlFDSTMyWjlIUXF1bXNBdmVFS2s3?=
 =?utf-8?B?MmVzdkRFRGkyL1hidFB2UjVOUHg1MlByUStFVHA1b0hzcmNrZlkzdWc2Zmxy?=
 =?utf-8?B?akUzb2N6Y2tRY3lnK1VHVlVIQ1pjV2FYaHIzMml2ZTUwTlJsdGgvWlYyd0RJ?=
 =?utf-8?B?SVVkMGc3eHlDRnBZdFdUcnViVUF0M1JQb1Y4WUZLYWFscUFyTWwvekFudzlN?=
 =?utf-8?B?TTFiVXhYeDNEdEJBV0xTOGVEdElCYVJ5L3NkdGFQRU5WYUtLOHJKbVp1Tklx?=
 =?utf-8?B?YVVQWjY4VzBuRkQ2cTQ1clhzWEN1d0tuS0IrTzd4ZlUzbk0yaGZOUVRFakpI?=
 =?utf-8?B?cngvb2RKQ2FOYlQrSk4wcEdURVpRY1pqZGZmcnFRT1Y0cmEvMFMwTHhZM2JS?=
 =?utf-8?Q?cU57qh3UqyFs38Sv1OxUodzeYILnUgCe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm9qWUVKcWRqbFFrSkFaVGtKcVE1U1o1VUZjby9RZ1JaMnJNQ1N2TWJhT0Fj?=
 =?utf-8?B?UG9OeXBnd1dzWjl5RnpzRGxOdFAzT1R2Z1dudUxMSnJoMU1ncDRYbzVIVDlI?=
 =?utf-8?B?Nm9BZ0dJdTJsVU5VR2J2bDBVSkthT3pWWC9IOXRTR2tZNlV1eVNVS1RUMERM?=
 =?utf-8?B?a3g2WEt6c1lKNDNBdG1WSlJobk96cncxSVZiR1V2cG14Y0tZUWMyUUxSUmRW?=
 =?utf-8?B?MVhiVTBBU245NzdzNWVWMDVnMUpJNEZYejJKM0hYaW9JdXMxVzhaVkdZMU9K?=
 =?utf-8?B?K2RiQ1Q0UFlRZ1pKaXB4cEd3RXVKY0NxNEc3RHg3bThWaDhoTkVPa0hyL1Jq?=
 =?utf-8?B?UDJjNFJDSk1yWGlXNldJcEtoQTY2RzFQb2IwSTQ1YmxRayt4QzRlR2tSL0xj?=
 =?utf-8?B?OFdmMW04bHdLcUZsQjN4OVEreWFBUllYQSthZ3k2bTRTZDBpeGpmMkdoNTgx?=
 =?utf-8?B?WE84eXBlQW9WMUJBSGRDN0ZMTkdOUmQvNlZvYy9Kd2ZKU3J3dERKZVNSUGN1?=
 =?utf-8?B?OHNVcHowSnlUWHU1RGNBWWlOWU5WQTA4WFRkejdrcVJrVWtTN2RMK3hvTnh5?=
 =?utf-8?B?ZFphdGdXL1pqRk5jY2gvSTlhWmFIV1FYSXJyNFU1TVVGNzZTSFFkVTVvMCtl?=
 =?utf-8?B?a0Yxa045TDU0K2FlQm9BL2wzajg4bjhjV2plTWNGK3ZsRDJGRlVtaVNXajkr?=
 =?utf-8?B?RjVIR1RHdzZOVlN4WGdpam85OFpXSktxeEN1NU9Ca25FbG9hd1VyUGVQWWVL?=
 =?utf-8?B?Q3ViQ0lkNmlRdUZUMm9IQzNjc3RqU0Z3SFhSVExLOVZIREdtY09qOXBrNUM5?=
 =?utf-8?B?blU5MmVuN0dDMWhGQUVwekVOSWdNblAyVEFEWVE2bWE0MnlwbHRBZ3hOK25B?=
 =?utf-8?B?dGNvMFJ0cXdIZVVpTVFFVkFjWlVkTlR5alR5Nk1zSnhWd0pZWHNLcWcvUTdq?=
 =?utf-8?B?c2kwRUt6VmpQY1o5ZC81UHRWa090dmNpZ0FMc3UwOU0zZW5Wcm1ZVmhGamEy?=
 =?utf-8?B?Q2d2cnA1OVlkUFNpOU5QdnhDV2xiSmY4WTUrWkk1bjlDZnlrZmw2eUhOVjVE?=
 =?utf-8?B?L2hDSVY1RkZsWHJyd2dmMHlYc0NCZVRPdFRzWEl2UC9xVzVFS0EwblVoaVZ1?=
 =?utf-8?B?WHhCbG9TNzkxVDNsMndSbGhDdENWVk1XeGxqTDNEK05wRUJoL21tSXBDMDBN?=
 =?utf-8?B?eTRnTm4rcFpSTzltaHdTZCtxUWlkb1V0RE9RdVYxQnRENjBkQ0JlbnVrVWVW?=
 =?utf-8?B?V2hVODl6MG5rVTNWeXNXcXN4OGN2VGhnTjN5VlBHK3B4dXlMVkI0Vm1mQlor?=
 =?utf-8?B?Q0h6Vk1aZXc2NG4zYkx1QTZHNEZlNjYxYVY4ZXFnZ3l1cG9NNGd5MzFEQmJY?=
 =?utf-8?B?RlBVeWZmNElnd2pUSHNQS2taOGhjSWJXWWpFT2ZIQ1dQU3hrZHVqWXZLUFBo?=
 =?utf-8?B?QzFYZnd0dys5Q3BFL3ZZdXc3WVpNMi9FSVI5U051bk82MCtYU2NwY2M0cHM4?=
 =?utf-8?B?ZEpPZlNFMGRHUmFCbHRXTzR2WUlyYlVrV2NkTGRTRFN0cldFVGgvQk5nbm9E?=
 =?utf-8?B?cEdPcTlQa3h0eUZuQmhodDlJZWtoeXpuNzJPVUd4aVdYWHNwRmxYK29wMHBk?=
 =?utf-8?B?RW1aL3ZQM280bkMvQ2NpOGd0SDJObzlKODN2N2Q1T1JuOVRHdGJneTVPak1m?=
 =?utf-8?B?Z0RnbDF0WmhoMU9GeHo0REV4Y3FKcEpwNWFFVElZN0xMdGdtbnpxMEI3amFY?=
 =?utf-8?B?bGpJTUNydkg1eFFEWWErQ2lqYk80VEozM0w0dkR1YTNKZTBrSisyR0Y2MWFN?=
 =?utf-8?B?c2lIcktNaExWQ2dna1ovVTU4ODRRNXd6V0REMWxaQWZaSVo2MGRaalk0VG51?=
 =?utf-8?B?bG5tREsvdUs0b0daOWJYSVg5bzV3RTBINHd4SkcyVlJ1YTlFd3BsdnJEanAv?=
 =?utf-8?B?eE1LVHRad1NLTXNxSGVhYnlkWTVxNTdRdkx5SXd2alJkaTVicGRRSmtKRWs5?=
 =?utf-8?B?aWU0Q0VXZjNwVGtIaE5IaEY3Q25nYWpVOUdHTXpKZm1VRzBYdUF1b3BXVThl?=
 =?utf-8?B?ODI1NEp6ZTlaMkNaaHN4M3R2ZkxOMWlBU0pSSkpCVnBZQVlGWWEvYythM3Ri?=
 =?utf-8?B?V0Q4VEN4VjRsR1lqdG5zbm1xUzFHNGYraDREZm5IUzBKQ1B2a0VHa3AzYjd2?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559d73b5-1685-4ff2-7ebf-08ddfd1c69c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:47:43.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJh3r3jG6zHA5ckryx7s564Ttf/1rJTnWQHpmF9D7w19iZceN0TUwleA3FqIPg201XRY/YYu2vR4geDdV3SpjkbikAEVhKYDmOsIn8sD+jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7753

Hi Jakub,

On 9/26/2025 7:22 AM, Jakub Kicinski wrote:
> On Thu, 25 Sep 2025 16:33:21 +0530 G Thomas, Rohan wrote:
>> While testing 802.1AD with XGMAC hardware using a simple ping test, I
>> observed an unexpected behavior: the hardware appears to insert an
>> additional 802.1Q CTAG with VLAN ID 0. Despite this, the ping test
>> functions correctly.
>>
>> Here’s a snapshot from the pcap captured at the remote end. Outer VLAN
>> tag used is 100 and inner VLAN tag used is 200.
>>
>> Frame 1: 110 bytes on wire (880 bits), 110 bytes captured (880 bits)
>> Ethernet II, Src: <src> (<src>), Dst: <dst> (<dst>)
>> IEEE 802.1ad, ID: 100
>> 802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 0(unexpected)
>> 802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 200
>> Internet Protocol Version 4, Src: 192.168.4.10, Dst: 192.168.4.11
>> Internet Control Message Protocol
> 
> And the packet arrives at the driver with only the .1Q ID 200 pushed?
>

Yes, the packet arrives the driver with only 802.1Q ID.

[  210.192912] stmmaceth 10830000.ethernet eth0: >>> frame to be 
transmitted:
[  210.192917] len = 46 byte, buf addr: 0x0000000067c78222
[  210.192923] 00000000: xx xx xx xx xx xx xx xx xx xx xx xx 81 00 00 c8
[  210.192928] 00000010: 08 06 00 01 08 00 06 04 00 02 46 9b 06 1b 5b b6
[  210.192931] 00000020: c0 a8 04 0a c8 a3 62 0e d7 04 c0 a8 04 0b
> Indeed, that looks like a problem with the driver+HW interaction.
> IDK what the right terminology is but IIRC VLAN 0 is not a real VLAN,
> just an ID reserved for frames that don't have a VLAN ID but want to
> use the priority field. Which explains why it "works", receiver just
> ignores that tag. But it's definitely not correct because switches
> on the network will no see the real C-TAG after the S-TAG is stripped.

Yes, we are trying to figure out the right configuration for the driver
so that the right tag is inserted by the driver for double and single
VLANs. Based on the register configuration options for MAC_VLAN_Incl and
MAC_Inner_VLAN_Incl registers and descriptor configuration options
available, the hardware may not support simultaneous offloading of STAG
for 802.1AD double-tagged packets and CTAG for 802.1Q single-tagged
packets. If that is the case disable STAG insertion offloading may be
the right approach.

Best Regards,
Rohan

