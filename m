Return-Path: <netdev+bounces-154330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11299FD0B3
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C0E3A0570
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 07:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D061413C83D;
	Fri, 27 Dec 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Gmic6MR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D5524B4;
	Fri, 27 Dec 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735282866; cv=fail; b=W22St4+tuJcjmHyfCRy1fWAT4yPZEaTz1PWqNAi1PLsVCQTTthFISlBrl5hRKc5nZRFO/HSgHst7EpDJVp8lWAuU4BkcyWOI5x1WDYDfq/4i/2M5d+r81DbcgQOJihC4Qc3jOoG7sO5JAK/W7bxML6LzzCcmgescTocePoXQzZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735282866; c=relaxed/simple;
	bh=ZIIAB7A1VI5+5w4eIjH1CU0AV5rKUMLmXnnO3ePEUqM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b18PXNH80PkIPbt7nr6Ft1EYskgzWJaAQSGzjO81K9xz4EVaS41/veukkm3wLMt4Sjk8D/CW7Kl/J1S7CGs42Pm4nlVHEsN3anNyH+VpejF5l1gGRtW0qIRdtXcw62FEo9sZdSdZN1J1P3qw6TTrHOnqJiKRJu9m2lXO5Us9r2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Gmic6MR; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO7OHEMBwFA6rm6wb9b8zjXpwjALqroi4ZC7anUOCyYsJH97rIzF9zCt6lFIRkk7/KbovQRjizZVxAy3XIqVua3fWDyVUITXn4A3PqGzPtf/i4ZgA/Nt0mhw2/zG6VnM9Ii54UsY6E96sQgIo2X0qgWwwHFBhRFXu1hr/GbT8Kpwg4eAFnYyqRlTshPbayZdd/c98+BF2+GyiEcQXRkona0FeizpCLmkZkwupNwhaFH5KoqVRTlZJefr/zvRzTwgvNxDP0KVvSD+guOAcdAbcG6t9SaPlWhdUgh7GqssQlDw0VQ0KD/Xc7AN9q0s0cZPaWBzaR/jJttSRJpaUxdSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuuaRCnixpZYfeIj9SpjG+adLUmt6ZWtMrpasBKkkW0=;
 b=PcxapR3W1tjOFaBfecACeJIyFhKitm7DJyTub4zruTVvJMagvf01iELvMO/r/CfYmenghLJMQ2ZeqRW9yaEr/QMzquWZQAxSkexC3PIb/xoD1ZEgB8faVGYyRa7uM8UwV3IhDPeqrLb1e+yMdxFQp7kSO4EGKk185wj6LQE7Y6vzZCOwCBpEBEAol2NjtqbpurhQSa7zcFM4WaSPU18qSxMQJtnsonDWPr7gQfYD++m9jfhjfa6MXNxjHFcz7D1N3ymY1zDWljnR9K6JrMdbNFQp++9LtkgzCpkX59CEevd+6p35HECqcqtJUYL79/Zyvz5zxHSQL/98+aYaCF7Kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuuaRCnixpZYfeIj9SpjG+adLUmt6ZWtMrpasBKkkW0=;
 b=0Gmic6MRxuBWEsjN40JZl+0qMgy3cGkuO0XiA18XiQB9H2gYgO+hP6vw8Wee23iKDkZjRBT6cnenMkJh5sgc414bECk5p9/pGcBZFgWX+teuIDmYse8RWA/Lr193YTj/BHcywBtJM76pOy4K2WDC+bc++UyyuFUZNS+jJ8PufHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 07:00:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 07:00:55 +0000
Message-ID: <1eeea670-4599-cd13-1d2b-7989c2544338@amd.com>
Date: Fri, 27 Dec 2024 07:00:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 02/27] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-3-alejandro.lucero-palau@amd.com>
 <20241224170416.00000541@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224170416.00000541@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 123084c8-df37-4b15-336c-08dd26443582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVFpSXZlTFh3RkJpNmF4NWNIaTM0QjlmRGxCNWZRTzY2cWVTcmptdWZNb1h3?=
 =?utf-8?B?bUxqSmxvRGZRQ1hjSEJvMDlWR3lwaXpyMEQyWDJPbVNIbUR0NW53aS9rVS91?=
 =?utf-8?B?dy9UcXgwL3VXTlNlZENsT1d5QVg4WjdqSWMxd2ZHZ3p4RGJPUVRlRE9memp6?=
 =?utf-8?B?ZWVGN1BJNnE0WWZaUjViYkxsNDBKUk44VDI1T1ExTkk3LzY4QmZDd3NmQm1I?=
 =?utf-8?B?c1dxQzM5TUxrTnFMR0Y0MHpkSHE1L0RCb3p2WHR5YXVWY0YrVUpybUFha3Q1?=
 =?utf-8?B?SXlxWFFZQkZLL1JZdTRHQ0o3VVNBZ3I5YU1sNEpXM29rT0JYQ3o4NGRhWito?=
 =?utf-8?B?NlFZM25TZGJIZ3BFZnhPSTdHZVNiN1piTjVtN005SzNSL3Y4dmtiRGFMMytF?=
 =?utf-8?B?MnFMRjF2emtFaFBwNU5ZRTJwNnVRckF4V3l0MTI1ZUVRbXNVWWpxK050Skx5?=
 =?utf-8?B?SFVzSDlwb2FUajJUWmxVZndHc1hTc1R1VTJpYkYzc1FmR3ZjTjFIbHFpZ2xO?=
 =?utf-8?B?VVhoYUlXajZMdG9ZekxkOWswbE0zRWppNTBTeFFFQlhtbGNLbTdvV3RYZVVS?=
 =?utf-8?B?S1Frd1VJVnJpTFgzNk9KdjBBN3Y0cGNTL0k0aTEybkZQRlJCbVdIL2NKSWZa?=
 =?utf-8?B?TVNZeks4RU8xeTJWTG9BT1FSQ1o4N0FMR0Rna1pqL1dZaVU3RDMxOFlQb2tZ?=
 =?utf-8?B?Z255RDhabWtVbE9EcVR4WGxnbC9SSklnbTdhUklkcnVucFZDbTNRQ2pFdHhh?=
 =?utf-8?B?Ym50aWQvZ3dteDEwL2JweFkzbXdzVE1zdTl1bzhKa21vYU44K1Q1UEd2WDk2?=
 =?utf-8?B?cjVhMTJQV2Fxdys2YW9XMjJZMFBkb1laMVRuR3BUV3JXVHBEWWs5YklQM2h2?=
 =?utf-8?B?WGJtR0w5Q2kwaHMvNDNBQTE2bTgyRUFqM1hzZkZKaUEzaC9oZWVBRkYxOGZm?=
 =?utf-8?B?dDBCU2JPdy9RTjcrRDBoOXFUUHFpVGpnTE9PbC9oYm5LR2I3WWdsb2p2c3E5?=
 =?utf-8?B?U0xJNWRJNlVzYmcvdVN0QW9EZ3dybmRUNzFGUWRIdXNlTGtBNGFUV0d1c3Bn?=
 =?utf-8?B?cW9MSGQxeGk1WHhRTld4WTJpTTV3SHBiZWszenZMVk9aSTBsK2toQXk0Y1RW?=
 =?utf-8?B?dktBRStONlZLNDZ1ZjZPR0dmTmh2dTBxRDFHNUo4WmR0endWQjlrQ0NqRmtK?=
 =?utf-8?B?Wi9FOW1hUzEyUktlOWlBcVd4OVpVSi9pSnB6MFJRWkI5NC9VMXR1YmV1MlVk?=
 =?utf-8?B?VjFaVVlZVGZDNWFEaEZKRnc0ZkUvTy9NL1Raa2loUk42b1h6a2FoM3p2NjRW?=
 =?utf-8?B?RlhwOVp1UEJKWERNcldxcExmUTJScHpBWDRjZS9aMG54SkgrcDlkQms3N1BO?=
 =?utf-8?B?b1czeGxOL2RYaVVEUzg4cldXU2ZyQ1BKby81QnhsbHhrQm9RZTUvNk9hZ2V6?=
 =?utf-8?B?TU9YMGI0cG1NUjdqS2xqN2VoNG8wTkovMjZJZWpqak9EcWZ0MzNsOTl0VzBn?=
 =?utf-8?B?NDZ1TzhXYWNiMTNwTUZVSFR3R0F0V05ES3RxYmRJOCtVUm44Tmx5bVNiWFd0?=
 =?utf-8?B?TnNWQTliamFZMEpuSW9kcnM2aEtRb1NQZEkrMUhGaWhiOGdhQ3Z6U0VkVlly?=
 =?utf-8?B?QVUzQ0FyRkpKbnIydnRWWFNsUk5iZ242ODNFL3RGaUVNalQ2UTNHOVJGb0s1?=
 =?utf-8?B?Y2ZHZFA5V2lJOEJ1N0F2Q3pQL0JMejExSVpKNUFwaFdEL1oyL1diYUdyZHpV?=
 =?utf-8?B?Nk9La011bXFxUFhRMTYzaVR6czdiWFIzM3c2WnhValM0emdDU1lVcFQ1dkFa?=
 =?utf-8?B?NVp4eWVibTB2SWtyRVpYNG43Y2s2dUF4TkdvUkJxbVdLcW1jZ0hSTXhia05T?=
 =?utf-8?Q?1Qy6/Jn7oc1Uz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHEyc2dhODZHbU1VVVV3aUVVUnl5RjU3cWREa3lwd1V0YlN3U1ovSlo3a0JH?=
 =?utf-8?B?eWRTUytQRGNZRkJ6VWUxQW16RmtnSiswS3hNLzQzblJReDdWbEp0ZkNTTm16?=
 =?utf-8?B?VlBjQVhaZnQxNVhMRERablByUjA2dDJLazRlaTZZd0JEMHYvdnBFMUd0L3Np?=
 =?utf-8?B?VEw5a0xWWDRWVmZJeExHVHhrd0lWbTNOSWRiL09XSWdTcEwxa3hZZGpaZlJ5?=
 =?utf-8?B?QlJPWUFzUjhnbFMxOU5iWmdMazd3a1J6UENuR1pyRTRxRXZCdnB6eXhBbFl3?=
 =?utf-8?B?OVhJN3VuMU5NS0d6Zk1uWEVxUS9vcGZXbktNbmNFWDhkbDJjWFRpMTRPRmFS?=
 =?utf-8?B?OUh2UXdMWFM3d3ZzM2E3WkpNTVZpcTJHd002aFJ4MThNVGlzZlpmZ0hDVmg4?=
 =?utf-8?B?UHE5cHl2QXVCcXRiVURZYjI4OFJxOU9WeWNGNm9SSlhmZldNdGxjVUVTTEll?=
 =?utf-8?B?M0dMMndsdE1LZUd0WHlVMmxHZGptcTVHK0M5Wi9ISlA3WDZNcmZ6QkNBTW9M?=
 =?utf-8?B?Q2pYc1hWbVhZNVF6TTQ0OHplUkFabVloL1J5YVNSYllubUtFZG9VYWpaVmor?=
 =?utf-8?B?N255MTVWTjFWWmQ5Q0NLOVVjQ3hBY0k1K3ZOendjczdBei9QQWQrU2Jhbk9o?=
 =?utf-8?B?blNOd0dHRnlOdFFIelVlMmFPNmo2bmg1Y0h0cjlQbmhNdzhycGk3MTZWSVFJ?=
 =?utf-8?B?V3hseG9xK1hhd21vM1hqbU5SZ1poMW1SR0duNE1yZEdLRFVBenV1WE53WCt5?=
 =?utf-8?B?M3phUlF1V0RNY3FtM0VRU09Oa09KaEpWdzFFSlVwN0EvY2ZvMzIrdGgvZ3VN?=
 =?utf-8?B?dzlSbHNvSlBXS2tLKzBpWEgzR3ZPclI1SDFmMFIrZ3huQkx6OTZ0RzB6bUha?=
 =?utf-8?B?TmtqSlZoVjBnTUxTWnUrcmZ6cGhpVnFubWd0NVpIMUs2SWswZjVYcWhaeVVi?=
 =?utf-8?B?UmkwNW5SM2N3SEZkK1dCL2FVWGZsZVhZRTB1eWhYaDUxVzdiUDVKNjVXTGs2?=
 =?utf-8?B?MGxGR1hobWxvZnlTZzBoelZYSlZQT1VxNkVBTit1Wldnby9wdG1JVkI5RmNM?=
 =?utf-8?B?dHVEdHVwZUFacUY3VEdraHhKdzBONGFzNVl1R3pIZEVicHNLZ0lZMmJIZmcv?=
 =?utf-8?B?ZzJpZlZ3c1FQcFk2anc2cnBZSzc2K2xnaUZNZFJRcmhmeURQZWVON1c2MGp1?=
 =?utf-8?B?V2lsd1h1UmNPOTNURmtHdVRCK2tUS05sajVpVkN5YnRPYTZVUHczWHJmNzRK?=
 =?utf-8?B?VWo1dDhIUFhCNndycjExdGNaNEZtN296R3o5UUczbzAzeTZPR1dkeDNydXUx?=
 =?utf-8?B?d3p2VkVCTndnWnlmMWdqZmhyM045VVY2L3N3Y1dDa3VYNU9vaHVkM0xiSXB4?=
 =?utf-8?B?V2hmblByV25XRkxJbWt6L2JNUk5LeFhMbDVSbGhjOGZRQ2hWQjQ0MGRTTEJq?=
 =?utf-8?B?WlJzM1E3YW1OV3M0UWpueXpXNjFrMmtMQUhlQjV3UlE5TFBQai96d1h3b3Mz?=
 =?utf-8?B?RmVkWU1sTEpEdW4rblJ6RFRwS2NzNndlZjRjbmt4R2Fpd2dSR2FOQ05mdEo2?=
 =?utf-8?B?RXdORjVqVkZjRlQrNDk4WnVPWndib0pFTDZJMkpkQVlNYUVybnV3U3NWNVEz?=
 =?utf-8?B?MjdnTFAzOFVHeFVMWFJjOTZXRFRxdEkyVVBUUkJ0OVp4R2cxNDJtTkZrdUF4?=
 =?utf-8?B?ZUJTU0JhK1l0cTJnUTYyZGN1aGgzN0lzcHVwb2IzNXhJU3ZiSGpPM2pHTGRv?=
 =?utf-8?B?RC9xelF1b3hRUG9GeTFCOTZBc3hYMElzdTFPbWZuWWpLNXRlWXhsc0JIWERS?=
 =?utf-8?B?S3ZEYjRCR2d4Tk1OL1NTdUd6Y3FKSGVKU3hhSloxcEJrZ3F5WkNSY1Q5bi9W?=
 =?utf-8?B?dkVJWG9BMXRJRCtRQkgwY2xINitGKzl3dEZmRmt0ZzFLV2t3dVhkaWdvcHh6?=
 =?utf-8?B?d2pHY29JbUJ6SnAvQkxDQ3BSaUZidDQzUDVibjEzdDNhTytLTE1vMW1tdlBx?=
 =?utf-8?B?WGF6VEdiWTdUWHFKVG1SWWZGZnBpSHBrOWdqUjBpZjd1QjdURHpTdEN5dVJX?=
 =?utf-8?B?WHlpdkdsRFZORVRWT2VreDhJS3ZWekRUQ0lESTB0ZmJMMTd5Z0IyYnN3RUh5?=
 =?utf-8?Q?+aO9o+pfH34dyELkrsSl26jga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123084c8-df37-4b15-336c-08dd26443582
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 07:00:55.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBg9TzzF9y0fjz9+b6q86Zg4ntdnt8bDLmOk192sbVqew7u/0kTfFfinb052v1CEhm5vGOR1KRzY0xTRSjwC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286


On 12/24/24 17:04, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:17 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Hi Alejandro
>
> A few minor comments inline. Assuming those are tidied up.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..356d7a977e1c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <cxl/cxl.h>
>> +#include <cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev;
>> +	struct efx_cxl *cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +	int rc;
>> +
>> +	pci_dev = efx->pci_dev;

> Trivial, but maybe put that one inline at the declaration above.


Sure.


>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_err(pci_dev, "CXL accel device state failed");
>> +		rc = -ENOMEM;
>> +		goto err_state;
>> +	}
>> +
>> +	cxl_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
>> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
>> +		rc = -EINVAL;
>> +		goto err_resource_set;
>> +	}
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err_resource_set;
>> +	}
>> +
>> +	probe_data->cxl = cxl;
>> +
>> +	return 0;
>> +
>> +err_resource_set:
>> +	kfree(cxl->cxlds);
>> +err_state:
>> +	kfree(cxl);
>> +	return rc;
>> +}
>> +
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
>> +	if (probe_data->cxl) {
>> +		kfree(probe_data->cxl->cxlds);
>> +		kfree(probe_data->cxl);
>> +	}
>> +}
>> +
>> +MODULE_IMPORT_NS("CXL");
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..90fa46bc94db
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +struct efx_nic;
> Not sure why you need this one, but...


I forgot to remove it after using efx_probe_data instead of efx_nic.

Good catch. I'll remove it.


> struct efx_probe_data;
> struct cxl_dev_state;
> struct cxl_memdev;
>
> etc.
>
> are probably a good idea to avoid potential issues with
> include reorderings in the future.


Yes.

Thanks


>
>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data);
>> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>> +#endif

