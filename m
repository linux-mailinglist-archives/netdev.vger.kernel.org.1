Return-Path: <netdev+bounces-230645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08478BEC3FB
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF8754E33DA
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF41DE3DC;
	Sat, 18 Oct 2025 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Jmk1Iirf"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA18189B84;
	Sat, 18 Oct 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752221; cv=fail; b=dfYGrcC1NCH7UESD7zi0x4pgMbWqJV+q2v53NKFU5KEVgETd7LV1n3ocfYYQq1jxv7zx4TeLxiLKtZRo3KfD+7vl0SGA2kGklayGMHxU6VxXqybwG5ju4M/Z9C+bMTOiLZ4xsUqTRjzMgRAuvmp+8kNOQvxDoQM5K8+7oCL7mTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752221; c=relaxed/simple;
	bh=rYts1WmQ+u6qi3Q+ameJjPLTfNFMcw65paWgUqT52OY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NjJ8Um4fjszftnyvcayAAOk9TVCxyvZ67/mWbJlNCZOeZHbcQgivTtXPAhJGHiNg00D8O1UW++iL/7DDXTozqDtGukqBahRUDY3FvJQI6+dOzBhSFcDATWyTKgUbRmmU8BkGKLHTxmoJGNVH3Nmsqy3us1yIv8IdLzuUHAq9x00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Jmk1Iirf; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpYOR9cQl7OWBhOBUW8tCrZ6Tnqrx9lnNdZBXTrdxgnCnX+VsnkcruFmI+rGhYafxLmuv/IHVK2RxCFV6hS+KbnDzrHUsvoU8IMVaUL4dMNw72pehbsAvCtd4Q4qKgXrxYuJAYJIm8GvEmd9W6/aORqfNsTK6QQa0+CUPUfjF3hLLp74G0BX11PaHPmjhDeVEtir3e7kUT/2mi+sYxaOy+v9w6iCkVTytit6ecwVvFEhGI6J+fdiJFcMeUpvV/9bU+aky4nNqreSxOxyVJbn0fRuBOhlfBaNwmFo92eIW+JbGEjNShygyeBtUOGnHusm0ARpGNNC7ZcYJNGF3CQc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8trn3mjKp2KZ4mfeSO5GuFeNFaaB/rmFX2nUUUSeFfE=;
 b=WiRR5gnoZlcqnkYG3eVtTZ2U6lvuk9d/snLl6sVE5ZocEvH2Z+YLuF1vtcgbrHZNycgTa0LioFBCRHCxkbdCSvB5YF8/8YuUPQ+BKWTqYB3Pcacfthhw/rUudI6//5U2Luv5KtfGZdFBM9Y/lrPUZ5V0fV+LDOPELraoot+vcpSMs67qF1BmnXbWzlH5HJQFNfzLVx4IZ4uocekbbs7yydTup3tSU2YbPeaE59iPHsNuTFOty8Ltcw6GuIMv+oouCpbgfP8SVZI4v+c1lZXe3bcCyj7Pigy+8c19kpJ3HwVy1GVJQu0MZOClqv7PrAA+2h0D9ImC5D0zhJjV6nDeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8trn3mjKp2KZ4mfeSO5GuFeNFaaB/rmFX2nUUUSeFfE=;
 b=Jmk1IirfwewSAhASdxHrZ+FPi7iDbnJWJdlXEgYln4GY4u/1jJhbfwCpvXlVEx3ryg1doulatduG7z4AnomYwQ4C8aPnNxRBhHFrHa7viyR2+GX1wa4mRDjOE5VHac423gOWSw0tniaDUtROqCfst/rkoWLHpzT/pwfvF2vlEOawb+BBx4WK3yzUN9O5Cy+BmaPuDdSZFJgwxOWiUTINaqEgi8z4IHdctNH1qSkjtFBXUxsM63V4BlJDlJonf9AqvQF+ce302sRRvhxlFO8j5L4WBxRQilL/a+/6wfmMlZtmwBudVEHtn6avxR1hYrGWIvKhWChejXZfqizkZ65RBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DM4PR03MB6142.namprd03.prod.outlook.com (2603:10b6:5:395::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 01:50:16 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9228.009; Sat, 18 Oct 2025
 01:50:15 +0000
Message-ID: <0d3a8abe-773c-4859-9d6f-d08c118ce610@altera.com>
Date: Sat, 18 Oct 2025 07:20:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
 <83ffc316-6711-4ae4-ad10-917f678de331@linux.dev>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <83ffc316-6711-4ae4-ad10-917f678de331@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DM4PR03MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f3c203-99af-4657-2237-08de0de8af13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm1NTHFUQ0l3cmd5NVlTR1F1aTZORnlvY1Arb1h0NG43b2hSSU5VeUE2N0hq?=
 =?utf-8?B?S2hXR0JXS0VQYmRDakdueFRxZ1ViZEwrM09OTjBYTGhrMGhETXFtUzQ2Z3RS?=
 =?utf-8?B?VjR2RzUxQ1VuWHVMN2JtTGEzN096ajRZcC9JT003Y0hGanFZd3JlalNZMG9H?=
 =?utf-8?B?S1FNSC94VW51LzVnSllTamhVSzVsbFUrV0tYWlVpMGF2em9IaE4wTkIzaUxo?=
 =?utf-8?B?UkprQkNsZUYyelZoUVQvYWpPOWlOVXIxbEhrRjJna3NGcFlWRzdWdzdwd29t?=
 =?utf-8?B?c3RsWDNOYjJHSU9kcEdXTjI3dTB1bVFuaXlueEhick1jWWRDajdYKzRIK1Va?=
 =?utf-8?B?Ujg4WmJodktvNFZIUVg4UldOcFAwaXpxUEFsUnJ6eUorMm16MnRMUWJDWFRJ?=
 =?utf-8?B?ZFVUTDJGbitRS2Q4TmNiRWgvN2cxV3R6K0ZlakJXb2s2dWRpclU4Mjd0bU5R?=
 =?utf-8?B?ZCtSdzYrNHVhQ3UwZ0JQZTFXWDJMU0pmSExPTFlZWnNXZVBEYmtmWTQzbi90?=
 =?utf-8?B?TEVkWnA3UmZyWG9rcncwWi9wdzFFcW1KVEFheGlvTytiSC90WW1DbG44U2x0?=
 =?utf-8?B?UGZtRE1uTzVvRHJrVlhyR2I1UDRnTzkrQmlkSk9YODRsb1hwUGZsa2M4RGlu?=
 =?utf-8?B?M1ZXdTJscTZkakc3dU92VnkyTlIyK0prbFZ0SlhBd3JOZjN4OUgzb2lRV2lJ?=
 =?utf-8?B?c3dTclhyUmg1N3NrblRhcEdLMDIvdG1mQmVUSG1YdDh4SEE2SGdrbktCV1Z4?=
 =?utf-8?B?eWtDQ00wQ0ppU2Z1QjBhb25WeE5KaUVTb3grbTVLbGFCVVR5MGZlNCtva1k1?=
 =?utf-8?B?V2FJTlgvMDlPZkdvb0FFcUVXczdYQmY3OERvZmdRK2ROS0JaM0x1VmJpczE5?=
 =?utf-8?B?VjNLalRyTms1MkdrZDhDTTZjRlJHR0c0d2xnRkN2RHRHbkFuKysrN1RVbnJM?=
 =?utf-8?B?SkxIckdLQWJUK0Zsc3hjTnh2bkt6RXN3TkRoSEMxQnBuTWJHZkJWc3d0UEtB?=
 =?utf-8?B?UmtsUEdNVzZQMkZMcXNQeVlUdHhzRmswRlRuYkFMMHFBZFRadTFkekxQUkJM?=
 =?utf-8?B?L2VhQ3dIZ1RJL1d1TWZIVVQzbkNXbFdEZHlWSURoNW5wUTRuMGQzK1lZTkdm?=
 =?utf-8?B?UzAyVDdBS295czB3bkZPOWdDSzMyR0tiYURtRFlqTUlValp4RHhpRnIyT1F1?=
 =?utf-8?B?SUcyRjlWSlZMRGFjSkk3NldPYVBkdjdGR1VGaGo4VVVpMDJEZHRJRUVRRGxS?=
 =?utf-8?B?c0tWelJhTStGeCthcHBlWDVBRGFuMjloa0o3U2ZZWXlHalRYQ29EYWt1ZG51?=
 =?utf-8?B?ZDhVT1gxTWRnZzdoRmFLckNnei9vR1YwS0E2UUFwcGdhTWNGczkwSkIyNS8v?=
 =?utf-8?B?TnU2UHNFV3l0eTcxWjFpQWNxcTViTkRoNHplMkpGSE4zUHZ5OEtiZ2p4UjY5?=
 =?utf-8?B?bnM2aTZhZ2RXWC9HODVvZ0wrZWNEM1VUZ1hRVVRBZ1lpQXRmY0Z5UnplQlJB?=
 =?utf-8?B?T3VUR3JjbEM3cnJOSWZNWWhnTDlOZWY5ZlVINGR0VHM2Yk1QSHpJYjgvd0Jk?=
 =?utf-8?B?VHhXSHFIRG9na1dKUnVFVHduYmFVL2d1UytvYnNRVVpidzZqN1FWeGk0Vktr?=
 =?utf-8?B?eDdyVlUyQzkvL0xaUmZ0ZnRTbi9yelZEamZSUDArZ0Z1U1R6K3M1SUUrMVZW?=
 =?utf-8?B?TCtQWXVvcFJheXpFVlVvaU42R1kyNVhXbDVHZHdRTENoQm5pOE5WbWR1d2dY?=
 =?utf-8?B?T3prQyszdUNSZWVxRWo3Yk1wS2R3RlJlaEhjUS9yR1FuY2hiSVJSY2cvS25v?=
 =?utf-8?B?MkJ2RVhEVGtBWWZjMHo5RTNDbFlQTWQ3bkdrTm5VK1F3MkEvaGRLMlFpbHZI?=
 =?utf-8?B?YTRxd3haMlMxeW9Zb3lkOHNSU0M2WHV2TU9jME1LL01EZzFiU3B2bjJ5U1Bu?=
 =?utf-8?B?UjNJSW0zV1cxMTRuNEQ2eTA3NHNFZmJPOWhqL3RQdXIxV2xNSHdobE1DRnhS?=
 =?utf-8?Q?7riz9eCTjLS/pcwyypVXXLvLTRceS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjJhdXNpd2U2enZsb2p2cXVaYzdzcXY0S0lUOHlSNkMyR2s0NGs3b2VCZTFZ?=
 =?utf-8?B?emJ0bERubGZWcUZqdG5xRVhlbFhNL0tNMERPZUhzSjd2YXAwUEU5cjNoaU1G?=
 =?utf-8?B?TnZtVHZDSHVpRi9rejNlN25hWVZ6ZVBoQWthL25KejNqcU1UQU13QURSSzZk?=
 =?utf-8?B?YjR2eCt3UDA5c2hMYldpd2k1aXVPNVRKQ3BaZVhxVS95WmtQNE4zMC9YSTBN?=
 =?utf-8?B?NHIxQUNtVjlDdWVDb3RTaDAzVWduYXNtS2hUdFd3OU96QXlSU3VoNXBrcjNK?=
 =?utf-8?B?SnhDU0ZQazZYUkRrV0FteWpXbnV1UThZbFBqYVQ0eTJGMFZlVEtqYURTbmFm?=
 =?utf-8?B?ZHlmc0ZWLytyTzRLODViNERmOGhraE5DKzhkQytxZ0F1L2YzUzFvVjlMZlRB?=
 =?utf-8?B?WjhGLys0U3hEdDFwSHJjVG4xMUg0UlZjUi9qdXRYOERSdXVmU3hoVVNVUGgz?=
 =?utf-8?B?Vm9ILzVwUHlmTktIZXJUMHBKcTJaMVBmRTJUSmlFYXJacWlHbUZoV01OU3lH?=
 =?utf-8?B?dXB6QXZFSmdKWW5HVmJhTDBCQWVuVy9KQThzZEg2MFhrQ0o0d2NNd2dEbng5?=
 =?utf-8?B?WmR3RWYwbzhuRHROUzliT1RtK2g2UXBPVUpXTUFDalNCV0V2RU0zYllRV2lV?=
 =?utf-8?B?Q0lwQ3AzZllvVjFHYVp1eXpCdVFla084VjczMm4xdFAzcDNwbG1VT0xpcGFD?=
 =?utf-8?B?Qll6a2VSYlp5UlR3ZmtKWHAyUlVQbkhVRkNReGs3YXpZNWYycUQra281bEVa?=
 =?utf-8?B?cjdVazlDL1hRbnhOVHFqaGhtMDhIeC9LZzNhcVVIUTN6WHhCcXdET3JLckp1?=
 =?utf-8?B?Ui9HTklKb1RNM2UxWkVLcUdkQ08zUEdrQkNQSmhwL3d3c1JtZHVEWFZLbHQy?=
 =?utf-8?B?OTd0aUgxN1JIQmE3M3VEZFhIRXBLQ3pkak5LakVnN2ZzMVdnR1planB1T2Fw?=
 =?utf-8?B?YTMreUpwWDFwUmZpeGRzbllqMXgySjI5RXRqSVo2ZTlmbjdMTk1wbHNkb3N1?=
 =?utf-8?B?TjJGQjVDbkpCU2xBcU85Q2F2cTI0V1paOUM2QkNoNi8zRWhvR0pTRzVWandU?=
 =?utf-8?B?c1dudzdScjFBT1ZjeC8rU21LOFQ2Q25ZODhaaFpoa0ZHa0s1bDVxNVYxRDUr?=
 =?utf-8?B?SllSVFZLQXpOTEJOMDhka2xkWG1uYlVjTGpmMlNNYkpqa21XM1UwUEl5eXpk?=
 =?utf-8?B?aElhbERxUjRGcjhYZEJDRlVkU2ZEUkR3SFVnTkdZajZhdXJ4Szh4N0VlU1VX?=
 =?utf-8?B?Nzk0NnpmQUpkYkVYL3dmR0Y0VGdjSUJ2SEs4VWhrdURmaFJiTDNYZmNBQW85?=
 =?utf-8?B?YnNhdGQ5SGk1aVZwbjNoeU1nZEY5elZ3MFZ6dHRnNHdYY2xvTjBMdWdpVk1K?=
 =?utf-8?B?KzFwTHR3VkhtbFZaK1o1dDcyaTlkK2lGYk5tbGtDOGszNmhJR1hoN25uUlNH?=
 =?utf-8?B?dGV1SGxpNnBCbDVhYUlMOGV2MHlHZm90WW9ORFQ5WWtWUUhtQVNjQzBxallZ?=
 =?utf-8?B?NHpWR1Q1a0JhaWtSdFFsY3lhMWdNL0NFYm5scUUvbjRLWmk2VDhZSk1OejlB?=
 =?utf-8?B?Y2FTRXVEbEpyU0dZZUVpbWQvaXZlY1dKYTJaWDhoU0dnOXlMVDJiUGgrTE9D?=
 =?utf-8?B?MnhxVm1QRmtvMG9QYjlWa3ZQdFNDRGlldnBKWGFtQXk2WDRwMUdRd0R1elRp?=
 =?utf-8?B?ZEpyVmxudDJ5WTNOY1FuZzJrRG82cG5aNWdZZ25MWGIvcGRoajZvcTFHTVkr?=
 =?utf-8?B?UGxGR1ZCdzB3V2xuTHRsT3ZUSlhmczB5OTNwRGxsVFo5bzhCQzQ3Ny9nWUZR?=
 =?utf-8?B?TlFjN0QrRmtwQ3NtUUV5MGFhd0NPZ2pzY3B1clpzNFRNbnFRSG5HaENYd3lR?=
 =?utf-8?B?U2JxMUJPOVBpd0l6WHNDRTIvNnpiVUlOUEpGUS9CWk03M2c4dkFnS3M3Smht?=
 =?utf-8?B?ZDBwS3ZYYVhKNllaT1kzdTBUZVhHbW5OdlUzV3pyenNVbEUyTVVsRHNGd1dB?=
 =?utf-8?B?KzBMZ3FSazBENVIzMlFDTE5yRnZFd1lkNnEzb1pNV2tOWW1kQ2h5N1ZGaGZD?=
 =?utf-8?B?SWRKZlh5ZEp6RWRtT2M1d3NobERNTkhzSCtlV296TUVQdUNTTXZ1RkltbnpH?=
 =?utf-8?B?VVJCaVBTMTN3TVdhM3laNE1Xdk50dWc4OWJUY1d0c2VxcFIyQlErbFZiRkNZ?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f3c203-99af-4657-2237-08de0de8af13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 01:50:15.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1a7cfXBwdqs7HecQUMgECeZfeF7u+v6AAvg8I7GtoZ57URGpJvSrmo+/raI9J1Dfnv64qEaz9qUgRZnDLwWbaIHaKbmG3/IE9u38m/GlzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6142

Hi Vadim,

On 10/17/2025 5:51 PM, Vadim Fedorenko wrote:
> On 17/10/2025 08:36, G Thomas, Rohan wrote:
>> Hi All,
>>
>> On 10/17/2025 11:41 AM, Rohan G Thomas via B4 Relay wrote:
>>> +    sdu_len = skb->len;
>>>       /* Check if VLAN can be inserted by HW */
>>>       has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
>>> +    if (has_vlan)
>>> +        sdu_len += VLAN_HLEN;
>>> +
>>> +    if (priv->est && priv->est->enable &&
>>> +        priv->est->max_sdu[queue] &&
>>> +        skb->len > priv->est->max_sdu[queue]){
>>
>> I just noticed an issue with the reworked fix after sending the patch.
>> The condition should be: sdu_len > priv->est->max_sdu[queue]
>>
>> I’ll send a corrected version, and will wait for any additional comments
>> in the meantime.
> 
> Well, even though it's a copy of original code, it would be good to
> improve some formatting and add a space at the end of if statement to
> make it look like 'if () {'>

Thanks for pointing this out. I'll fix the formatting in the next version.

>>> +        priv->xstats.max_sdu_txq_drop[queue]++;
>>> +        goto max_sdu_err;
>>> +    }
>>>       entry = tx_q->cur_tx;
>>>       first_entry = entry;
>>>
>>
>> Best Regards,
>> Rohan
>>
> 

Best Regards,
Rohan


