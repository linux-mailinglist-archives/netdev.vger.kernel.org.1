Return-Path: <netdev+bounces-161828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D6A24335
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399537A3A7F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A711F0E4B;
	Fri, 31 Jan 2025 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FC1GsIZm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDA28373
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351530; cv=fail; b=T9VPc41y4Pve7Sv3DA1RU0j6iDRmql2XSLEb2gJDzqGIK/wOpeAGoS5z9+rMnF24dXYjCTofCFx8iBeRe+eig5vJu85wnFyvBKHKYYhBN6tatDxCsQiStQn2NU4syouaeuC/idWZx1eC+HaJgPqJvOpcPbeU3YcfgalxG/mRysE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351530; c=relaxed/simple;
	bh=83fiNspIceiEXnpLNfW17FeulcMmQfmu1vMwYIfIx1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+sOulTPWoqWMKxBTISdwGc/8ynfvTgpFtp3F7k2g/G2K1J02IgtlLeIzyZByVP/FRSYUzMDfZgsx7B4gVmNgP86aVFMQ4dbmD6usg055wFKZ41DqRiHjjVT95WFp8payGmNWl1f9SUiJdMg8BAhY+fdx+kwfeZ62bjVdnLB+Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FC1GsIZm; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANGlu1PeLYsKOuf+KqZBk5lNeA3QGZKIybdktnvOm2hN82BsiP8MwZTcHY9NdyVsV3gSsOCWjXkOZ+pxs1UcoYszJWg6vnsznniXN8txEiwE7Rv5J3Sv78S0s2qaGwku7/13s9Jq1GbGkA1TgA1mdU2hmXKJziNRYpx68LC0DWUKgIF3uzXL6k72tDktH3FmJ6GQ/XZyUwq4sQfs6PzTt8oZWhoFp8QYbGhU++MkWV48jXB15u2lpaBZU6W/PftoUoVFDNEKWINgm++FEG2RdyV/EQ+mXB9EZwzfUVzWvnM2gh0c5YE5RkVpuz94XswL5N90soREsDN2W1jLAQwRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oVZ6yuI49rndUI7m3SE2f7QPREqw0KoEREczRjlFBs=;
 b=SMFnzU2wCnLj02QrZi3hOPN4lwgCD16Tmg8+ulhNmB1e36ERnrZviw+h4uZXiIKHDuBhseATLYARX3n5KfOGrrgyolTr96wjr+hVbCRaIvotNJppSXdDXiRpuFhyYQTGR68KsdzPoQ2RyYZ51aleuJk+0ysbKAOyI2f0CjDy8fqIltJaavubGouGyW2fix2pOlBd9zu9dLhb043JVt4yJsE0si5HrbDlKHSHmIg2yPnRL5jzwhBvBhuqvyn+6SLTGTZFzcF21Eja4ATiLBofO1/bZVEHFP6eZhz4ZbkJtr2gH/z/h/XUEU4ZOR7C0d8mDRzegdi1CPTR+uXOSFMI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oVZ6yuI49rndUI7m3SE2f7QPREqw0KoEREczRjlFBs=;
 b=FC1GsIZmghcdYdTcs7vTGRrSd/It7P8sqCGgpGAPdqN7aZNNlabeypEWPRTRJuhCBsl1q6Mni5c74yyyHdL+ux7UC+okMMecwGLYKc+MqWVrtC6BwjkK/YnG5iahbDRHsN+X+TSCxysUyeQXNBb1Q2RE0ZuWg0EWxhcJWKzHjv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 19:25:26 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 19:25:26 +0000
Message-ID: <fb796fb9-90d9-4618-a228-e4a8aee8bde6@amd.com>
Date: Fri, 31 Jan 2025 11:25:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] pds_core: Add a retry mechanism when the adminq
 is full
To: Jakub Kicinski <kuba@kernel.org>, Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com
References: <20250129004337.36898-1-shannon.nelson@amd.com>
 <20250129004337.36898-3-shannon.nelson@amd.com>
 <20250129190326.456680c8@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250129190326.456680c8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9fe308-c6c7-450e-bc94-08dd422d03e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2d3TlJSVHVUUWw1bnFMY0xYbEc0MHRlY1gybXdKR2doV2cvTXdsZzdZYitO?=
 =?utf-8?B?WGhHYVgvc2IzT0xDOU5UVmp2OTY0cEZYNXU3eWh2NmwrdDFmZU04L1dxRkts?=
 =?utf-8?B?MFpMZXVuNS9xQ3NINTNFTnozcHRCOGNjMW1nZ0dHWWtBUkhObk9nUmJkRzQr?=
 =?utf-8?B?SDZTR2lEbUFpK2Z3TDVVWHhYQkl6c1pySnc4NDZRNTRCOElYdU00Z3FXTVpQ?=
 =?utf-8?B?UzRDSFdhcnZtSGRvL1RzSTFvc2VaM3ZlSGcwdlBCUW04RVRMcTBLMVRxZlRR?=
 =?utf-8?B?ZUI2bWNSc3pDQXdpV3ZMY2RNdXBTbmlUdmZkYW9CZXp2S0NDVUlnSGFCaGd4?=
 =?utf-8?B?TlZBS2g5OUZ1YUxnaGZDTmJlOTZkVWJQYi9rcWRHaWxwSWRmSUI2eTIyWUwr?=
 =?utf-8?B?dm04WmVzaFBmUm1CWlNmNW5RcFdXdWZQZmlLMm9CZnpxSXppWjh2eUpDeVlJ?=
 =?utf-8?B?OEF2STZudVNtOWt5dm1kdnN2VHJDRWsrZm16WjM2U1VMQVNoUnVMR0xhSGdo?=
 =?utf-8?B?WUtZclVwSlJYb2lUQnlGZ2JFL1ZXSjRPRW84YWt1YU9RVW1PbDBTVG15RjNx?=
 =?utf-8?B?REI5SlpGTHlPYzBmaXpxdm00NkFsSkZoODB0Q2U2S0hTSzNKbDlNS1g0b0po?=
 =?utf-8?B?YzZvamZiTDlRaFNVWDhFMXJ2QlI4cVUvMEFhYWI4d3Q0TGNNZ0tzWlgyeko3?=
 =?utf-8?B?OUxNNzFVai9WeGtsbWFwN1BSWHlOSndKcm1SMjNVSmlJU0pWRXFWdzRjOUth?=
 =?utf-8?B?U1VnMDdYNEFjT2VCOXVlVlFnajVVMlJYK29OZjlhV256ZDVjM04zbnh5TG9Y?=
 =?utf-8?B?QlJXNjhZYWtGaE4vVnpCUmxMeE45L2tkenF0RUcvZFFCMDh0TEZzb2tORFBr?=
 =?utf-8?B?L3JBbXl4NGZpKzM2NkVZQy8xV0h5eGo0NlQ4SGU3a28wSWExZlQ0TDFqbVNY?=
 =?utf-8?B?a2IzM2VZR0JRMk1qWFdQb0pvb0dXRVlsb1Y1YzNsaHhxUG1MeWJLWUI5YXR4?=
 =?utf-8?B?cm5iUHlVVUlXRWtIN0ZZWEllSXY0NDM1NURPN1p3V0piT0IyN0VyQmhmSVlk?=
 =?utf-8?B?c3Z0UGVtZWJrM0lHQzVCWWNyb1NPZytTcUlMVzZxbVBzTzF0TXdBSjl4S3My?=
 =?utf-8?B?S25GMy9FV1ZCSmt1WWxUMk9kREFyRUxaVXFpOGhUakRuTWd6OXQxZDJuNEZ4?=
 =?utf-8?B?Sm9XdE54ODZRK3Jrb1B6a2UxcklLWUlCYW5EOXNIb09INE5CWGtWTXFzOHUv?=
 =?utf-8?B?clVzUXBONnJOSmljK3g4d1ZpY011VTJYZkVUNC9JdEI3bHFpRGFjeWxGdWlW?=
 =?utf-8?B?a0tQbXBsVEdZcFFLVHpwbVJFVHFVeEM5OEJOQi8xMjFHcnFIVllQV1dIbHFv?=
 =?utf-8?B?dlVUQW1VRUJ2NXhEUjJkdTI4ZElVVXlPVDh6MTZKSktyNHMycDJ3VE5YdmNu?=
 =?utf-8?B?Q0lLS21wWEVzZlk0S2E3QVZXaVhoNTdnREFlY1M3SldnSjdiSVRGdU5oRjFD?=
 =?utf-8?B?TUZ1Z1I4QTlBbHl4YWtqNE11Ym5YZHF6MmFRZzEwSkNnc0IxRVY1cVlqWEtk?=
 =?utf-8?B?dTRJQXF3VDZWRmRRM1VKK2dEdkJaTS92V3VIbHltcDdIT3lGVW1WdVA1UE9R?=
 =?utf-8?B?d0xLLzUxV1lpWXdWZ1hJRWVjeHNoZEJwZFpqdEtROCtSUDhSWHQxSXRLcWtN?=
 =?utf-8?B?N1lGcFlTRDdpNjJlM2NGbGs2UGR4cEx4OTdmOEVGbTc5Sys4U2JNZFVyT01q?=
 =?utf-8?B?MjVYOVVTUEYzUytCOFNGT2ZDRFloZ0pRZHFNYjVBVkhaNjlRTFg1L2RxV0w0?=
 =?utf-8?B?RzBuNzc3eUpJaU5YbEs1M0psbFJuTEE2eG80UXBlM1lIMzlsS2pvUTdVSnNv?=
 =?utf-8?Q?T3m0sfxCxkB/5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZFSDBZZWdidmZseW9YRnAzVWJBdWtiSVNkT1k5YXZjNUlaU2xvYWNtMVg4?=
 =?utf-8?B?MlhVL3d6VTVsVFZBcWx4SDF5NlJCOGg0TlVQdk85NGJlTU5BQ0NoWklYcHR6?=
 =?utf-8?B?RlFWMVpVbWYrSDRFTmxEVWd3Sk1sZElzcXA2bGIweWRoQ2sydGxJYnQ1WW5J?=
 =?utf-8?B?U0h1ZFlZckhNeGkveWI3ZDdOZ2JjUytWak44aS9VM1NhVmpwMDZoUTN2K2Rn?=
 =?utf-8?B?cDFEZXdrTXFPQlZlUVlaeGhyVENyeWkrMFpjNncxdHVQUlIxYjlyeWJnQ2lD?=
 =?utf-8?B?QTZobTA5MVVmWTR2amlVYXV5OXZFRWl5OFVJMDFCVEJxTWk0OFBvUExWRHRh?=
 =?utf-8?B?Nk9XYmpZRGsvU0lFR29hMWI4TkU0S0pEZExOa1dPRDdiUVc0ckVKUGlSOFNY?=
 =?utf-8?B?UlJON1ZjbldaS1lHK3h6dlpPdjRiZTlYVjFob2dVZmI0V0ZrRXZEc0lOMTN2?=
 =?utf-8?B?VnNDV1lydU9VcTBQZU9SSnhzWW9oMmQ4b0l3R0k0aVpQODExSjY0MjlHVk9G?=
 =?utf-8?B?Rm4zT0Rzc0pJRWhTTmZoeUF1Qk40VEZZMWVtRkFvRTl5bDdNZWZ4NXc2OE90?=
 =?utf-8?B?bUM2M3QwZVoxbGVZZGRwZGxqeENqbG9wamd4MDZYeVY1MVA4bG1acnV0alhO?=
 =?utf-8?B?Yi9CbU4rdndPY0RDWDZVMFN2VTJhQUl2cmlVUmFoS3NuUWFTVmsxSmhnKysr?=
 =?utf-8?B?QXRVSjM3V0VRNHZpVm91dG9qQVlrNWpaNUwxdXVmVG1TZFZ4bFF3NlplL2hI?=
 =?utf-8?B?clFseE45WXBpY1VzS3JZWE9HenBhU24rL2QyRk5IeXZ2ZXZJamNBZ0huVm5j?=
 =?utf-8?B?Q1JON3ExejYxV3hLNnduRjl2ZWNpV0Y5K2RPZzRURE1WNm8zMWM3SDdoNDFj?=
 =?utf-8?B?dFo3dkU3TmEvY2k4YU9lZGU4NWVubTFDK0pDdzVtVGQycElxL2ovTFFqYmFv?=
 =?utf-8?B?eTdOL1lWaW1JSjQyN1RhaHdEdUI1aGs0dUIwMGdTc0pIV1RVc2hKekJwbU9P?=
 =?utf-8?B?enhucVZRa1lXRWpKOTNjYk9MMzVQc0RiUjNUeGdKMWJ5blovMUhWK3Y2RjVX?=
 =?utf-8?B?NGhvZE1hNFJWYlVNa2YxY3pjdStmNUxCbHB5OXR5bWNlWXJxYllOcjNDQ1Nq?=
 =?utf-8?B?Z3VpcG9JdFFkblNZcWxrWUF5alArdmt5elZEeXlsMWM2WEhUQUkwcjVOUFVr?=
 =?utf-8?B?aGZUaWpoYkRac1RXTFJwVjUzYzNSSEZsdTdnV0Y5T1RhSGxLZU9pWTAxT0cx?=
 =?utf-8?B?ZDNqVDRiZ2dTZlNFaHduRVNLak5Yb3pPc2hEUkhORkxmQkJjVkNyMjBqZFZC?=
 =?utf-8?B?RXM1azBrWEZkZ3BMN2pXeG1kZDhnYzFCV1l5VFh3RWNUK2ZEczBoUVBTRjBO?=
 =?utf-8?B?NWZPOGNOSE1iTVk4bFJTcUpNNWdzMStadWVTcG94WW90aGFLZHBtdzBUd0Fp?=
 =?utf-8?B?QWJFb0w0NGx3QkcxM1VDN01LVEFZeG1IcS9JSHN5ZmNYa3owTkFPbndxZkF0?=
 =?utf-8?B?MFR1NzBicklTUzZjVWdNZ0xkVTJHc21FOVpuRjRzRUZIRXR5dnJleUhzK3Vs?=
 =?utf-8?B?NDVpRmlJSWRLMzZoRmpsbW1qV2FrdTBoTzNRcUQ2V1VlTmVpZExOZ3k5b0ZE?=
 =?utf-8?B?TFFRYkJhRi8yNTVWQ2c2SnVDbHV5MnMyb3ZIaFNiTDdMV1Zjby9FMUI0QWJV?=
 =?utf-8?B?VUpmNUU3RmxaVXlmQzZidEdBbS9weEtxdlBmTWNzVUVxWmFuem5TUjdJeEo1?=
 =?utf-8?B?VzJTM1p1K0Q3cHMxRFU5WlkzWjE1c0h1dFdGaldobUtjOE5ELzdiY0tVd2hs?=
 =?utf-8?B?ZUJBYkV4OUQwTUo5TkFGNTJIMmFjS0pBZ0JmaVFhT2RiZjI4MWErQXE1RDNp?=
 =?utf-8?B?UW84RE01Z1hIeVFEeFVUTTVwaTVtY3VNOWZyd01IaVdseUNsMHVMc3R5aHFa?=
 =?utf-8?B?bk9WODQ3eTVralpvamNWYWtqNnFEaFVKOWtOM1dqSEZCOFp4VkhIclNkTG1X?=
 =?utf-8?B?MUx2QTdaNE1rMVVWQUxqRW9DSFV4MWZ4U1p4bCtMTDRiQ203WnNwRWFqL2U1?=
 =?utf-8?B?L2s0bUZEcDYzQ0VHNzg2TU5JNXdRT0dGZGNiUGRGRFIzVmpuekEwTytrd1M3?=
 =?utf-8?Q?rEmyNUyQXqQRGPNXlpy2xU4X7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9fe308-c6c7-450e-bc94-08dd422d03e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 19:25:26.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmgB8z+1EHQ5y18pjcaXgdnk4Ehg8NXRGjsubfpAtYnV71RBUFY5tLvXz4unepXSGAXmQWR62AINNQfNezoFcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918



On 1/29/2025 7:03 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 28 Jan 2025 16:43:37 -0800 Shannon Nelson wrote:
>> If the adminq is full, the driver reports failure when trying to post
>> new adminq commands. This is a bit aggressive and unexpected because
>> technically the adminq post didn't fail in this case, it was just full.
>> To harden this path add support for a bounded retry mechanism.
>>
>> It's possible some commands take longer than expected, maybe hundreds
>> of milliseconds or seconds due to other processing on the device side,
>> so to further reduce the chance of failure due to adminq full increase
>> the PDS_CORE_DEVCMD_TIMEOUT from 5 to 10 seconds.
>>
>> The caller of pdsc_adminq_post() may still see -EAGAIN reported if the
>> space in the adminq never freed up. In this case they can choose to
>> call the function again or fail. For now, no callers will retry.
> 
> How about a semaphore? You can initialize it to the number of slots
> in the queue, and use down_timeout() if you want the 10 sec timeout?

After spending time digging into it a bit more, I think that this is 
probably the best long term solution.

It seems like we could refactor and replace the pds_core's adminq_refcnt 
that was originally introduced to resolve race conditions related to the 
adminq use/teardown between various client drivers (i.e. vfio/vdpa) with 
a semaphore(). This would solve both the race condition issues mentioned 
above and also the adminq overflow issue in this series.

However, I'm hoping you can accept this v1 solution as the fix for net 
because it does solve a problem and is a simple solution.
In the meantime we can commit to working on a refactor to use a 
semaphore/down_timeout() instead of the adminq_refcnt and this 
sleep/-EAGAIN mechanism for the long term solution that gets pushed to 
net-next. Ideally we do this right now, but it's a bit more of a 
refactor than we feel comfortable with for net.

Thanks,

Brett


