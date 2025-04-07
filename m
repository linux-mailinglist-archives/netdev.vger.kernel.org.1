Return-Path: <netdev+bounces-179650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D510A7DFC2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68AD188FFDE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E716F8F5;
	Mon,  7 Apr 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x+eoogz6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C5156880;
	Mon,  7 Apr 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033209; cv=fail; b=GjeVD+vNaneNZGLa3xykEQzjUspJFPdoN8H2k9YdBxD3KkQtYiOeGdTAEeljs/WVJPtWAVds2/4rjQSGPpVUzmn6HKeAf7X41xvGBKgFnn1uQilF1T85kwIlQzhgsZMPemlRcjde1YMKKvwi0BYkUjdi+QfugAUuWGmGf3TV1pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033209; c=relaxed/simple;
	bh=WUu/fRF8LRaC874OTw595rz2OBK160VIvcNDQ8bW0AM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUg5ixvWeMxyXxedsITa7l8R4jrxyg+SDwUiwim7TRpZy948qSDD8OuHFVGESUCtPVgqtiR/fDAuFsnTrSOm3cN7CE/xQEd+joDbgNy4O9E3hAHHnanedGgn4SVqxsH0qH1p7lY+APxQurhxKjQK3NwwkZ8tQ5x7ootXii6F6rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x+eoogz6; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFzbWWjRE+pHKSTTVur0aslVPUJ+hooHWX3ARlrqIZzwfCqTR7a7P98W/KiYaPxGKRONn6Bt9l+kTTKgjqXGmvBhIRo77KflVKW/5r2iyEcB9+1anUj7tgaKap5JdVpOKJ3IHrgdum/ikVNnuz/VjBNVhNeJrLL2opRlBmDFRI3xW9hUDvbxLZXrgxVnH9L/bIPShLvLDE3Sl/pLYGeHRStP/+zYHf/Tz4YI0MyQtCVhKfPKUnh/CgC/QcR1tMpXDX8uz26xl2YbSHlp13aVg/ABnytdnHdm7nRvXLFdb0Fp3/wHtBIBJovjCJMscKVJV7Gn2MlBndM9YESTqlripw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYhK0hBehtrzUbAY9udbwq2DGe5D7q/0UlkvGQAKOu4=;
 b=KAi8LkySp4DHoXI8wRTL92I7V25DzAdG7ZCB+qmXelB4QDw7bivInD5vT9ZkPWYGdevwfkHoMmluaxNvKjiN0ytJXp+QRBk+cE03sZPEEZK+mE9dhogq1ux8B+Bq8P8926pljmkA7ffcTmvI5e4p315odBvZQz2TYzfCmln/mNRqN/WC8nbjyMU614fW3Qi8aNgvoaa3SxzZ0jjHj4ZMhngEhot/sSH8aFI7kSClxzTcwCmX2eAg3EhZxMVpn59Adn6HB6ffLDPfHFmach+989P4XOp3cBi3d1l4VxIXQlCLyZprsm8awy+OUGVGbLN+Jw3L4ICZR1x9nj6lEX8LWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYhK0hBehtrzUbAY9udbwq2DGe5D7q/0UlkvGQAKOu4=;
 b=x+eoogz6OAnHVk2ytWNcuNj/AwtEtqv3H/J3y7NZWpJRxDmS0xy7+iFsqDDOJezqhpOVNoO4kngdMGC+ik8UZhpSEAzu2GR9Ojku7sVcDh3DgmDnkLtYPK4KVuD2FCf0JukekyqrrN0F9sTPHAEYbzvGOWbiVfRG9tLGcsXk0bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 13:40:05 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:40:05 +0000
Message-ID: <39f58b48-91f6-4ac6-81a1-83ab0b689d95@amd.com>
Date: Mon, 7 Apr 2025 14:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/23] cxl: move register/capability check to driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-5-alejandro.lucero-palau@amd.com>
 <20250404164744.00004b34@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404164744.00004b34@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0636.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::14) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d0272a-3b4e-4e78-32bf-08dd75d9b479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmdINDR1ZjA0RWtibW1MK3hId2lnSHB6WnZBOTZaYU51WlAvVUYya3FoYVZj?=
 =?utf-8?B?cnZudmwrZ0JneDVEL1RLNFlja0xOU3FyMTNmNU9sV3d3ZEZFV3dzR3p6RUdr?=
 =?utf-8?B?a1U0TXB0NHc0Rm1KYWlSZ08veGJwb2hZRGZCc2xHalpPZ2dvREJRa0N4OXU4?=
 =?utf-8?B?ZW53T3dqakhSVWtTQzJvRzd3Z2lZWTZtR2hwajJJTExRK1hDQy9vVkZpMFBG?=
 =?utf-8?B?cE1VT1kvM3pQZXJrOWVWV3VkbEU2eU1wazRkMUlIWDBHLzU5L3IvbVU3SkRk?=
 =?utf-8?B?YWRmWTRNMGV5ZStDT2VYcUlEeW1jL2J6Z0lySkUvQlFMdVdzaCtwdG12Sm5m?=
 =?utf-8?B?NWxFNjZpZEtkMnZuVklPUjZ2cXU0SGdPUTY2RFlQMEFWdUh0NTBZeWFuTVZP?=
 =?utf-8?B?NTEwVnBvTGp2a0d1a0JIWStnbVFaM25GWkJwa2ltS2FOKytxd0U3YTFjTDhQ?=
 =?utf-8?B?dHRURzJnZVZUeWYvWXJVK2tSMytDWFlkSHQwOXJSRzQrdUV5S3RxZ2xrQURw?=
 =?utf-8?B?NkUxenFRdk56OFdUdFl4V1kyK1Q3RmE1dEVGdC91RWR3RGhBOE5UU055KzJO?=
 =?utf-8?B?M3lWMjhSREoxWmROR1JuMnQrTnBZZ0t6MnZsZkF5NjY3ZFpQTjVvR0NvR1Bw?=
 =?utf-8?B?STBLWlZ3bisvQzZQcnpjdHpZNDIyNE5tZzhTbmtaenJ2bDY4QlhxTThZM0dM?=
 =?utf-8?B?dm9XK1FRamdld0hYN1ZzcFh0d3pJNHVBZzNGZ242REJjVC9ORHhvZXFndXh3?=
 =?utf-8?B?cjdadjR3MGR0dUhHV1dNelM4VXd2bzZVWUo4WTJFTFFlY0p1cnMwSkhxdlJB?=
 =?utf-8?B?R2JpZ3p5d0FYTGdBVnZRY2Z1b1QzckpsK2RVYW01U084b0ZnTGVSOEkybXpQ?=
 =?utf-8?B?di9VSTBYZjdEYnV3OW1zSkVFSWdRYWVQdW90VTA4Q3hLenRRTVBxTUpIK2h5?=
 =?utf-8?B?YlJ5VStoaHBDTDlFMmw3d2NKMjY2blZyU0l2NkJCc3lqMzN4clBvVVVFdmg3?=
 =?utf-8?B?Vzl5K2lUQ29XZzJtTXZrVzFUWW5ncjFyT1dOMS9LTFdjVWw1czIxbkh5Ykt0?=
 =?utf-8?B?QWY0NWJzalJrMmswcXhzZDlOR0hIMGZndVZCSlNnV3BIb29qSjZHbzBrOGl2?=
 =?utf-8?B?ZFQwWGxBOGtaTXBxbEp3RDRhcnhaZXpkLy85Y1ZWVFlWMEhWWDduRW05aHhN?=
 =?utf-8?B?THJWeTd1ZC9UaCtsWnloT3F0Zm55R1FpVFNVNlFIcmIvVmU4NUNLdzVhMXpP?=
 =?utf-8?B?N25DbXhxSGRHcU5VNFg5VEN3Ym9VbFhJSkNjeFQrK2dIWmxEcnYwcjR6c0Iy?=
 =?utf-8?B?cEh4R3JDZjNYMm1kTmQxMDJPejB2UktIR0xKdWxsZWpQdTlYRWNUWHRIOGtD?=
 =?utf-8?B?cGdnTkhzOWFqU0p4UVFMbkNDQ3M2ZVMwYml2cm5KOFVLRXZ0UDJBZDBkN0pv?=
 =?utf-8?B?WVZ2dTA2Mnp5RFN0aDZ6d0NZYnJub1pvMTdQUDZCRWdwRU5rd0Y3MXgzV29l?=
 =?utf-8?B?YXlYY0c1bHgxMUdjdXJoOERoSEl5cjkrTWl5MkFBMFEwTEtOTXBZczFoZGlY?=
 =?utf-8?B?SWlhRkE4WGlLQU1nanpadGdHSEpnUk1ZR0hXRTVTejRsam9IVkNLOFNTRmVM?=
 =?utf-8?B?Q2NIaWRzMEo0a0tWTllvckxKYXBINldDNThpOTA0TEJFMVNFZ3Z5YnA3K01i?=
 =?utf-8?B?YlU3Yk5KazZzb0UrT3B5bnVmMUw1NkZLbm9WOGZuOG1ueVhDUVhQRXVFcnBn?=
 =?utf-8?B?T2JyNng5RjRYWlk4VU5nU0FoSXUxbllqSFlJdmx4RnVKOTY1c25FdE5JMUQ4?=
 =?utf-8?B?U1JIYmk2WDdjR2szTDZhd0VRdExhdEJhN3lhNGN4b1kvUHNwTktBQkFGR0hU?=
 =?utf-8?Q?N5oVx/6O7CS2q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZTakV4alRtRkJnV2FOWUFlRGxmMHIzaVZqT3RNQWRRcW9USWpRVEdKL2Fw?=
 =?utf-8?B?QVc5Yy9RMDZZNW81TkRCVUVaMVlYYlpoTkpVM25venhSeEcxTjJaVFQxMmF0?=
 =?utf-8?B?bEtKYndYcUdCNXNRZnFpTDJvRVFnenhwQzJFQUQ4VnZtdkpwMGZnL1JTZGo3?=
 =?utf-8?B?UlhWUkU0eUdwRWZrNnhIY0NjMUlHdjJyTHJmY1ZpeDU2eEd6VXh5MzQxOHVR?=
 =?utf-8?B?LzZZRVp1UkIyVFlXQlJXdlNaWTEvWStZb0s0SnQyK0t4amE2YkZhbnlRTEdK?=
 =?utf-8?B?bWZBVk9nQzEvN1VOb0tHdWEvbXlLNTg4VHpsYkxoL2xsNjhlaDlNeXFwRzdU?=
 =?utf-8?B?MlBhVHpoY2ZPSnZlcGFDQURmVjlvdUpmd1RXZVo5SzFEK1BhdFNiejQwU0Fh?=
 =?utf-8?B?bTZ1N2p3ZTNoNzFiaUQ4RStIS3N1eG96N3EydlY1dzNsUDlreERXUksrUE0z?=
 =?utf-8?B?STlxSFR6N3B5WkY1SnFsOTB5SHpGVWJvRmRuVlFVM2lKY2NjSHdzZGJNNlYx?=
 =?utf-8?B?S1hDb0FHRGp6OEpMc3pkV0hHWVpmd2ZGcnhFL0E3UVhsV1hoaXE4ajE0ZlFy?=
 =?utf-8?B?YnNNM0FuODdDbEo2NzVFdW9kTERsRFhMUjlEY2N1N2FGYVF3ZUxkelBPdk5h?=
 =?utf-8?B?blc0NU82NTVSczhWNFZHaE1aM3pNUFRrNEdya0pSTmlybHI4VkFpYm8xNWJG?=
 =?utf-8?B?WHQ1RUEyYXFqREV3cnQwQXIxalM3dHR6VHVZQkxlUTFyVGZ5WTVTK0p1OFIv?=
 =?utf-8?B?RkQzRmpHbXhXTHdGTFc0Sy9TK3lJbHhra2doN0VoZEJNM3dYSWZZbVd2b1BU?=
 =?utf-8?B?OWlSUGdJdDVPNElsdjdCOWFRNTlSRGJwK3NuMmtESUlRcmRKcDZzcm5TQm9s?=
 =?utf-8?B?c2hZVzUwTE5qTmNOSU9GUVY5WHMrT2lvNSt5R0V1U01nck5XN1F4bEh0bmMz?=
 =?utf-8?B?V1p2VEROR0c3MmpkaVorK2ZvdnR0Kzl0d3hDcUI4Sk4wWDhKcWNOd2dkNjBE?=
 =?utf-8?B?cG1CbFBWaWI5RXM4TXlDMHowQ2kzRSt3T1NtM04yOUVjb0VJUzdiMzZQeVR4?=
 =?utf-8?B?RjI2V2dtTFVYR2x4aGVwY3h1UzJCUzNaeFlQdVp0aHVTN2RqaTVvYmpmTTUy?=
 =?utf-8?B?aGtBN1F4UEJKQVBvTm5BNE5SNS96UHBiSDkxL3BmSkRpWTJKNnc2UVBWRFlE?=
 =?utf-8?B?bDF2b09wanJkUUNyWFU0c0gwUnFuV0JzL0FpOFY4Q0pBM253OEVoS0lvVUFs?=
 =?utf-8?B?RlBxWm5FZnRRdTlOcFhGMVdGSmpBWHRGM2U4WHRPbjlaSndnUWpURmhaUVc4?=
 =?utf-8?B?ZklBQ1pIUWFNM2tPZENQRXBnUVlYQlBROTdJSnptYm9XYzdTMUhsT3RCN2tr?=
 =?utf-8?B?WnVWUGgySHBFSTVJS1JsNnNwUEhXNlhIc3pmbE1tWklySFpjZjJhejBVQ09s?=
 =?utf-8?B?bk8xdWZiM0pEcVFyenV1VjJyUXBkUUl1R2xJeW1meTdyQzY5citJVFNNN2dH?=
 =?utf-8?B?dmxqK2JXY095OHpjU0dPNXRJa2p2cUVJVHpZOFNWZ3ExU1lraTRTaGpCa2pX?=
 =?utf-8?B?ZzVnUjRNTENSbXQ1S29ScXhVYURSMU1wRlpwaElTSWkwWkplcmhQRStzNWEx?=
 =?utf-8?B?TzkyTkp1ZHZZYy9OZmZQSWYrd2Q1eUU4Z3VLeExpU2FXOG50UTltTDkrTXFi?=
 =?utf-8?B?amlIQkM3Q3VlVk1BdVhUMEgzbDFKRDIwZldSaUlDb3ZuSXkrL3dwbnBkcVgy?=
 =?utf-8?B?K0RtUmdibU9QUFV5RnFJMVg4UFZoRWxaUWdWVDE4OU9DWU9VVzhNZUtiSzc2?=
 =?utf-8?B?SmRqdHU1eFdjcm9NSTNOY3Y5bm80NFRxV3hHVCtZdVlCT1RQc3c4MmZRU3dP?=
 =?utf-8?B?a20zOXlNencwV3lHcE5WWU9qTzdvalhISEdSVnplK29mS0t1dVp4c3ErTGJ2?=
 =?utf-8?B?MHdudUNWNmM4clZkc1FiSzQ4T2JMMTlNdkl2d0tQWEVDc2J2ZXNYeXdIMGpn?=
 =?utf-8?B?bEw4WENXN0hFQUw3Tzd5TFJaUURwZVlRNk5iT3htVE9kVlNEVmNHTHlha2U4?=
 =?utf-8?B?RXZ6b3l1NnY3aXFsamQzcHM4K1B4TURVUDZsaC84MjJxNFpWcmljUDZDU0RX?=
 =?utf-8?Q?VSAd5lVsej/XWpC2BjC9/1R9u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d0272a-3b4e-4e78-32bf-08dd75d9b479
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:40:05.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsqU6iRXfwPncnuokYHEaB+W56t82IoJDkNZID9/1/DFmqTVBcdReH1AUR0UZ6Tl6ZN910lFigCOVpF/gFLoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659


On 4/4/25 16:47, Jonathan Cameron wrote:
>
>>   {
>>   	int cap, cap_count;
>>   	u32 cap_array;
>> @@ -85,6 +88,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>   			decoder_cnt = cxl_hdm_decoder_count(hdr);
>>   			length = 0x20 * decoder_cnt + 0x10;
>>   			rmap = &map->hdm_decoder;
>> +			if (caps)
>> +				set_bit(CXL_DEV_CAP_HDM, caps);
> Maybe it's worth a local helper?
> 			cxl_set_cap_bit() that checks for NULL cap
>
> #define cxl_set_cap_bit(bit, caps) if (caps) { set_bit((bit), (caps)); }
>
> Or just always provide caps.  Do we have use cases where we really don't
> care about what is found?


The helper seems cleaner than current code.


There are just two cases, Type3 pci driver and sfc, with both using the 
caps for visibility of potential problems with the capabilities expected.


I guess even always providing caps would imply some sanity check to be 
added, so I think the helper is better.


>> +		dev_err(&pdev->dev,
>> +			"Found capabilities (%pb) not containing mandatory expected: (%pb)\n",
> The only obvious reason I can see for an expected bitmap is this print and this isn't
> that helpful as requires anyone seeing it to dig into what the bitmap means.  Maybe
>
> 	if (!test_bit(CXL_DEV_CAP_HDM, found))
> 		return dev_err_probe(&pdev->dev, -ENXIO "HDM decoder capability not found\n");
> 	etc.
>
> That will only print the first once not found though and avoiding that adds complexity we
> probably don't want here.


Uhmm. I think you are probably right. And I think I could somehow merge 
the expected capabilities bitmap initialization with the potential error 
reported.

I'll try to do so.


>
>> +			found, expected);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_pci_type3_init_mailbox(cxlds);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 1383fd724cf6..b9cd98950a38 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -25,6 +25,26 @@ enum cxl_devtype {
>>   
>>   struct device;
>>   
>> +
>> +/* Capabilities as defined for:
> CXL code so
> /*
>   * Capabilities...


Yes.


>
>> + *
>> + *	Component Registers (Table 8-22 CXL 3.2 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.2 specification)
>> + *
>> + * and currently being used for kernel CXL support.
>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_HDM,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS,
> No comma as this is at terminating entry. Seems unlikely to make
> sense to ever have anything after it so let us make that harder /
> more obvious in future patches, but not having the comma.
>

Right. I'll fix it.


Thanks!


