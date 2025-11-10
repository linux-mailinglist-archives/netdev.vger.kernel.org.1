Return-Path: <netdev+bounces-237144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CBC46068
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186F518917B7
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804B3054E8;
	Mon, 10 Nov 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UbQOn2LH"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF559305977;
	Mon, 10 Nov 2025 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771405; cv=fail; b=Y8gLungLqLRs7ihUrTV5CdyjS9jvlnWG/H9Jfk79vpt5e9lUHBA8HlOthe+HuBhjnd0VSQu6ubqFnltGE6ew36+PsuFEyhGEyQcpg4fCTpXJrQq2Lc+qyFbDKdC4V5lo8pVmwUxqrQBBr1DP8U4yNswI4Zp7l361km+YPLJaHZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771405; c=relaxed/simple;
	bh=tlNurxHLVp5U3Jo/hiU3WJs7ivMfaB7Q71432EvhPzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FhNDpAXCd/IK9QF3pv1rRz/MQu4EDan9ONBVos8A3AZatEiFy4Q89Qx3wJEfsKILhbqzCARZygWpeefhWDn3/2OF34OpokbBTqbLMlUUsxVbJ8eihf4LxDMLG6bjI3hlHJfRk9TinOmMCYzmEo3Sk2igQ03WbKiDZzZHlgeRVHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UbQOn2LH; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMQQLS1eKnJ2BYf56z5dVxPEvzVmXd5kRjWjA06uVpR3y9JQnbSvBftmIL3Kwrncq6JhsF1wTyp58ZtNC243OgncJuEi8enrHo3gtVOGfDls5wPPNmYQO1QiL66oIfT5EwMNq0CXxTJ6dK1i8cRA58DRgTXSLcRbUh/W5RBIBWAqpkUHRfEJPEQxHl0SoCgelK9pPILXXD+HVYnDbCJWUrJ18RT4h/q4pYiFiDoKFiPc5FIktaPCbWS/H0pCYHTHHGJ6/hPFuVb37WrPQUVDIFdTqeg1xhoA6GoJ4fpQcQQcgffAJaPaRHLOe1z+8o/PrhEgcJz1BJry27WxupN6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2tOB5gfXT3cDgClfUWx5fK7AhPqd/3RaG0Jvdc5H+Y=;
 b=MYj7JTatl4E+ziQ1mmwvln6TzWeXuv6YDT8WQgcc1FacmI9qI1o/HQRUmVAnZLPCVO59yDr/P4QydvTuOch1uFsa36n1HjqkGLOJdgggu1YBV9r/wR4sSlkoPsTF1HgbXD/U3VTj0zahoIKSOVJwOJ2Gr6YlnJwr4cAEXpzpyZ+EmFLzocFkGhIzwLQFJZJlh+k4OhTcsw34Ze4UNNw0E8yBoa2GObTe4tcZF1PgiAByCT4d4E1v5mbBvNeTExhS6rLMvfRurMPDQ4V9JmP/MbkizxpbJQGxhDWEiCI5x84NHjlEmXJS/Oa8kXEUG0Tn2FdyjjrEIKYNpCRcMLw7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2tOB5gfXT3cDgClfUWx5fK7AhPqd/3RaG0Jvdc5H+Y=;
 b=UbQOn2LHdiKr52v7vJvwFgKJbmo0kWx4DdcjoaGbxddnCaYjHsbmJYhWcwq6LvuBk7hiEOXhR83e8pouP8fDmkdLfU9oaJ0BoGW5tEg8dCpjMitBocvOEpDq9e56WVMctKdvMnDyRlRhqDWMtIcOLDDHdHrdLW0Emhs/PvfGAI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 10:43:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 10:43:20 +0000
Message-ID: <f94420fc-0b06-4d55-8178-b5eb07bc4bcd@amd.com>
Date: Mon, 10 Nov 2025 10:43:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/22] cxl/mem: Arrange for always-synchronous memdev
 attach
Content-Language: en-US
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
 <20251007134053.00000dd3@huawei.com>
 <801f4bcb-e12e-4fe2-a6d4-a46ca96a15f6@amd.com>
 <030a36b6-0ade-4ee1-a535-9f01b15581a6@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <030a36b6-0ade-4ee1-a535-9f01b15581a6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P250CA0004.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db48195-0125-4bfb-ea7e-08de2045f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UThHNlMxZHlvNW5adEl4NHgyZDEvaW1KbjN2R0thbmZLOGJFT3N0N2pMZitu?=
 =?utf-8?B?YmFyam9hSEgrbTlCelVVSXZ1ZzNURjRDdkdldndBMlVqWHRFdVM2bkpjV1Z3?=
 =?utf-8?B?SGgvNWxES3djeWZicS81NCtKSzMrWGxXOGgyNjdyY3dDemZZR3hzL3l3MEc2?=
 =?utf-8?B?aEdobXcxZGZtRDVoM2g2dVZ4N045clVkWU45anA4b1ljQmZBNTk5S3RlZnIy?=
 =?utf-8?B?VndzNmRLVEZ4aFMrVzJBUitQRVdodk9nbHU1eUh5d2Y4NjJQYnNKczVQeUly?=
 =?utf-8?B?aGJCSVU5UmpPUzRwSjlvY3d0d25lRi9UcTB6Ym12ZCsrSUFxekF1ZmlMQmla?=
 =?utf-8?B?alEzL0w2TlNUVkJwaithQmJkMjRjcDY5N2RhMnh0NEk2Sm9HSDJkczVRM09k?=
 =?utf-8?B?SmU0MWlBWUFOcjlxSFZHOWNrM1RHRUsrZnl2azIwSGVBV3g1Ynh5Q2V4eURU?=
 =?utf-8?B?L2t2d0pCSnRML1k5V0dLK0tHanE5UXhNTm95dWNvQ1FiYWtSU01LaGxuN3gy?=
 =?utf-8?B?Qkp3RWZweFpMYW9Pb1Z6NGZSVDh0YXczbUN5SUpLTUVybVhxVksyYmhYdUhi?=
 =?utf-8?B?WnRnS1RVdmNrRnk3dUJibHVDdDdZblg3clpIRHRxMkZFU2MxM3Bkb1J1Q3hz?=
 =?utf-8?B?SzZFeDFqZk9kSmdyYnZBRzY3Yi9wLzdVazJRUGlBVDFqL3haaTVNRVJPNnkz?=
 =?utf-8?B?ZGptV2lMbFpZdTIyWGFKbTlPQnB6SHR1c3VxRzlpSUE0R1hsWGZpdDRGaXEx?=
 =?utf-8?B?VGZHMkZJVXJTd3JadDJ1QmY4clkwVDBZU1BXcDFlU3pmL1dRVzIrNDBicG9r?=
 =?utf-8?B?NHBpNDArazdKNDEyYnJEcmlxMmhVV0k4ei91T2ZvNHlaWUp2UWZXM1BLaFRO?=
 =?utf-8?B?ZkxNZ1UrK2JQVTNhZVc1ZXc4VWN5R25mREpJUENrVS9uQS9qQ09PRWJnc2Zt?=
 =?utf-8?B?S0VjamludzB6VllOdG4xcUx0Q3VPdm5zR3VqUThVK0RtKzIyTTZjcnJvZVE5?=
 =?utf-8?B?VXZMUThqSVFOL1VtYWxSOG5HZGtScUxDbEtYSGIyOENEWmV1MXF0eVBFdmh6?=
 =?utf-8?B?cHQxUWM0Smhad1dzeXFYb09iaHVNT2RZVVVxeUpKc2lwTmhzdVFxNnhwcGRH?=
 =?utf-8?B?aWtFR2JXbFpzWHlmaTIwSXcrMzY5ZHlDNUtybHF6czhBblo2RUJwRUFiV0FX?=
 =?utf-8?B?QUFsNWJOY0ZweUxsZTV3K0lGQUVQSnB6b0wvNnJVcjlkd0tHa1lWeGlzalNu?=
 =?utf-8?B?KzRsTjhuU0NlUndjeS9uOW54UGkwVVhXNG5VeUovcThDb1l3T1FGcVRJbkc3?=
 =?utf-8?B?SkVsNjRyYU5CSVlrSy8yT1ZFbVltUDk2V2RXcjJnQ2ZnVHVheWlYbmdnOGtJ?=
 =?utf-8?B?S05HcEtrV2ExYkRGbmVicEQ3WXo4WFI2ZVZZeDNVY2NKeWtHeDdKUXVJWGtL?=
 =?utf-8?B?Y0FrU0h6UzB4ZmQvU1NhNFFnaEVIb09lUEJvQlB0Z0FMbmJmRE4xTDJRR29r?=
 =?utf-8?B?MjlWVGI4Qkt3MzBVeld5LzB0U0NPeDAwaXRJQ0h3aWJrQ0tCNk9WV3ZlNFQ2?=
 =?utf-8?B?N0tUTlI0czRYRDJ5K3NSTFZ6TkxiZWV4U1lGSklTVWlkTHNUTkVaTUEreER3?=
 =?utf-8?B?cnQxbGR5NXhmZzFhU1NaSU5vaThYZ3lSaXFBa1FhU1M2dnp0LzVjOURqcDcv?=
 =?utf-8?B?UnJ6c09hNzVhMGZBbGlISGlmejZPcEV5MUgzNCtQd3oxcGhXRU95VUZZaU91?=
 =?utf-8?B?RWJ0OUVVL1ovK0NKYXo5LytOU1BhYlNMV2RSd3JMYjA1Tko2NW1oYVpreGt0?=
 =?utf-8?B?NENzWWRRWkVreHNhSWZjYVBxb1dCaEJBT2hXOFRtWE1rK0hiekJHNVJDZDIx?=
 =?utf-8?B?ZXRHRXptdlhZVjdJMnlnbjVSU3FNclJKZERiak91d0E5OFZSOCtGbkROL0hU?=
 =?utf-8?B?ZXl4TGw2M3pwTmpYa0VzS24ySTA0aG1ZWnl4Rzd6TjF0Mm00QlRnS2t5V1Nr?=
 =?utf-8?B?Y21HNWlRS2F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlJNejdIRmRaZlhqeGpKVmZ0K3dKRTFXczh6b0FGb0tUMW1kVi9tbER2aUVu?=
 =?utf-8?B?enFDNGtTNThLTk9SdGd6TEdSOURTM2k0eTdDTXFHdGZGc1hrMHd5QnlqRDhF?=
 =?utf-8?B?ZVAxYlpWcFRKdzNhMmlKQlpYalMzUS9wUlhCalo3NzIveDJiUXV2ZXNPWXM3?=
 =?utf-8?B?WC9HZW5CYXNHTjRsUGthSkRRUVBVTzFiUThQWm8vNG1qK25CaUhlM1FrVTBW?=
 =?utf-8?B?TW9CMWN1WlUvbHl2aGo3TkhmRG9tamtrVzdVQmpBbnFzRkVIby9ST0NOY3hj?=
 =?utf-8?B?Y2VXR2JYUVZoMGVpUDFuWHJ1UUFXdE92YnZzc0FJa2NQK2l5TnFnQVd3b1RW?=
 =?utf-8?B?THY0bnJBQk1YMmlPa0VNWFdmTm0zTjVuMjg2VVlMbFFBNGlGSFI2UTFqS0g3?=
 =?utf-8?B?VEVTRXhtSjMxcTlaYVdUN0g3Zk9IeFFEeUNiWG1wRzYxaGVuT2Q4c1czUFMw?=
 =?utf-8?B?VDBabS9kMzRLekxTK3NsS1ZoKzlTL3VjVVRid3ZDMVdhanZVSDg1Uy9ON1kv?=
 =?utf-8?B?SmFUS0dnSk56aDhtZkZuNXZlM1RmbEx0b0FKRXZxSFg3a3JKaFRtWCtYUjYx?=
 =?utf-8?B?QVI5dzREWkhRNnZscmRPaVgrTjRoQXlia0NjWFFIM2UxQVlKTHJUc2hlekQw?=
 =?utf-8?B?anZadkptMXdKMko5MEZxTmtOZStiMW9YK1B4V1VkS0N4T0Fad3lQRkJkcDRC?=
 =?utf-8?B?KzRiRk1FMHNoN2RzTVI0R0NQNUYrN1FsTWpGQXBIUjlGZ0M3b2tPZ1kvYldw?=
 =?utf-8?B?WDZNbVE3YkF6TGZrL0U3Zml6QzNWTEQ2YlJoRHZhalZnS2k0dlJ4ek43aHZF?=
 =?utf-8?B?Yks3cHdCZUxpUnZZVm1LKzFMRWVrNDhnd0pZZllwU3NyVG1xcFBEM0R0TDhw?=
 =?utf-8?B?UVF5a0I2cm02VjduYjJ1RnowTGZCN1Ryd1l2dlk1eHhaVWpnNXRoT3B5OXlh?=
 =?utf-8?B?SnM3NDlHVVlrcWl0NDE4T1d6QW41ZExTQ1I0ejhRWDBnQ1E5RTFjaG9nbUZl?=
 =?utf-8?B?WlpHWEhVOVY0SjBHdTBnbFZ0RnVnVnh6bzFPVmZsL21PZndlMFQrNGs2blpW?=
 =?utf-8?B?dXpCZU1hSmZsYk95WGFQOGdwcG42bGRhaFVtajR6cGlzTW51bEs1Z1RaRGdu?=
 =?utf-8?B?VnpTWENlOHZvLzJhZ2t0OWdSRTF6bFRVZURoWHV6TnZ3WmhzV21XN2NPRlEw?=
 =?utf-8?B?aVBHTElPWmVnd0dtSGVPM3Y2NGt3aldvMm91RUlvMENUTjRqR0d0WmNLY0ho?=
 =?utf-8?B?Z09aYVVvbkQwYjdxT29QeE1qREY0NCtYWjR2ZVFRNnR0QUFoU2E3Ny9ocnFo?=
 =?utf-8?B?aHN6WUFPcGlsSGFiUTZsenl3YXJOWllRQ1g3ZHNBWjMvbHFEWUFVbDFoVllZ?=
 =?utf-8?B?UXJQYUUrbFJ1dlVPd0dDZ0hjc2hKRzh4cXl6TC9lOHB3Z0lKZUpWYWJWczVw?=
 =?utf-8?B?MVlNSEpFSUJHMXNrUlgrWENDTkZrV0R6MGFlQlFSTm9XcE15MVVqcVdCMTE1?=
 =?utf-8?B?bTRLSTBUSUNUbHFRMEkwSUlhSExoMzN0QUVJS1didmNaL3FTOVRVWHRWRVVC?=
 =?utf-8?B?NTRySUU3UDlpc2kwSlVXRTR0bTVaK2l0bzNDalpxaW1zekQ1MGIycmhsK3cr?=
 =?utf-8?B?NTkyOWppdGQ2YkQ4SWhpbms4VkVESGlFdTVTUnV1QVBaaGgzZVY1UHdOTFJw?=
 =?utf-8?B?bFNVZjdkeHd6aGZsNUFpM1RKQVo5QnJ1VHRRaFRON2g0Sm5Vb2diYTRyNW0y?=
 =?utf-8?B?dm9GUDhMMkQxenliU2ZKckJuUW1DcWhJY1BjTi9VaXpmcURBRFo3d1cwaFFY?=
 =?utf-8?B?NGJhKzBjTUZGZzZaUFFoamdiL25Hc2xuRWtNRFV1UG9zYkFJYnp3L0dWa1A2?=
 =?utf-8?B?NEZIWUJvVFdxdXVLdFNxNVZ6RFBIWlUxSzBuVlZ0OXN1MDByQyszT0IyejAr?=
 =?utf-8?B?UTlkUlpQNzNFWWpwWHZsNlV3S2RJQ25LV1V1c2tsRTdOZ1l5SERZL0xJd3FJ?=
 =?utf-8?B?dFdUV1YxYnRqR1VLejc2cERoRWtEUVYvMnNHV1hhMmZoUGNNcFowd0RYNmZ5?=
 =?utf-8?B?RklwYmw3VWY4d01tdTR4VjNoV1d6YS93Vy83NTdWb21LangwbXVET1NsQXBB?=
 =?utf-8?Q?0/gq+O2sSeZ7h+KDHytPluHgE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db48195-0125-4bfb-ea7e-08de2045f6d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 10:43:20.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hMe+y8fe11vTNSbPi02Q85YSHetIYYTTG/Hsgs1y3KmXAemaZ56T+UjkgR0drbFZTs7pRM5UjhnhvuPlgf7RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

Hi Smita,


On 10/30/25 19:57, Koralahalli Channabasappa, Smita wrote:
> Hi Alejandro,
>
> I need patches 1–3 from this series as prerequisites for the 
> Soft-Reserved coordination work, so I wanted to check in on your plans 
> for the next revision.
>
> Link to the discussion: 
> https://lore.kernel.org/all/aPbOfFPIhtu5npaG@aschofie-mobl2.lan/
>
> Are patches 1–3 already being updated as part of your v20 work?
> If so, I can wait and pick them up from v20 directly.


Yes, I'm sending v20 later today. This patch has some changes for fixing 
the reported problems.


>
> If v20 is still in progress and may take some time, I can probably 
> carry patches 1–3 at the start of my series, and if that helps, I can 
> fold in the review comments by Jonathan while keeping authorship as 
> is. I would only adjust wording in the commit descriptions to reflect 
> the Soft-Reserved coordination context.
>
> Alternatively, if you prefer to continue carrying them in the Type-2 
> series, I can simply reference them as prerequisites instead.
>
> I’m fine with either approach just trying to avoid duplicated effort 
> and keep review in one place.


Let's see how v20 is received regarding the potential merge. If not 
impending, you could take those patches.


Thanks


>
> Thanks
> Smita
>
> On 10/29/2025 4:20 AM, Alejandro Lucero Palau wrote:
>>
>> On 10/7/25 13:40, Jonathan Cameron wrote:
>>> On Mon, 6 Oct 2025 11:01:09 +0100
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> In preparation for CXL accelerator drivers that have a hard 
>>>> dependency on
>>>> CXL capability initialization, arrange for the endpoint probe 
>>>> result to be
>>>> conveyed to the caller of devm_cxl_add_memdev().
>>>>
>>>> As it stands cxl_pci does not care about the attach state of the 
>>>> cxl_memdev
>>>> because all generic memory expansion functionality can be handled 
>>>> by the
>>>> cxl_core. For accelerators, that driver needs to know perform driver
>>>> specific initialization if CXL is available, or exectute a fallback 
>>>> to PCIe
>>>> only operation.
>>>>
>>>> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
>>>> loading as one reason that a memdev may not be attached upon return 
>>>> from
>>>> devm_cxl_add_memdev().
>>>>
>>>> The diff is busy as this moves cxl_memdev_alloc() down below the 
>>>> definition
>>>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>>>> preclude needing to export more symbols from the cxl_core.
>>>>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Alejandro, SoB chain broken here which makes this currently 
>>> unmergeable.
>>>
>>> Should definitely have your SoB as you sent the patch to the list 
>>> and need
>>> to make a statement that you believe it to be fine to do so (see the 
>>> Certificate
>>> of origin stuff in the docs).  Also, From should always be one of 
>>> the authors.
>>> If Dan wrote this as the SoB suggests then From should be set to him..
>>>
>>> git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"
>>>
>>> Will fix that up.  Then either you add your SoB on basis you just 
>>> 'handled'
>>> the patch but didn't make substantial changes, or your SoB and a 
>>> Codeveloped-by
>>> if you did make major changes.  If it is minor stuff you can an
>>> a sign off with # what changed
>>> comment next to it.
>>
>>
>> Understood. I'll ask Dan what he prefers.
>>
>>
>>>
>>> A few minor comments inline.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>>
>>>> ---
>>>>   drivers/cxl/Kconfig       |  2 +-
>>>>   drivers/cxl/core/memdev.c | 97 
>>>> ++++++++++++++++-----------------------
>>>>   drivers/cxl/mem.c         | 30 ++++++++++++
>>>>   drivers/cxl/private.h     | 11 +++++
>>>>   4 files changed, 82 insertions(+), 58 deletions(-)
>>>>   create mode 100644 drivers/cxl/private.h
>>>>
>>>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>>>> index 028201e24523..111e05615f09 100644
>>>> --- a/drivers/cxl/Kconfig
>>>> +++ b/drivers/cxl/Kconfig
>>>> @@ -22,6 +22,7 @@ if CXL_BUS
>>>>   config CXL_PCI
>>>>       tristate "PCI manageability"
>>>>       default CXL_BUS
>>>> +    select CXL_MEM
>>>>       help
>>>>         The CXL specification defines a "CXL memory device" 
>>>> sub-class in the
>>>>         PCI "memory controller" base class of devices. Device's 
>>>> identified by
>>>> @@ -89,7 +90,6 @@ config CXL_PMEM
>>>>   config CXL_MEM
>>>>       tristate "CXL: Memory Expansion"
>>>> -    depends on CXL_PCI
>>>>       default CXL_BUS
>>>>       help
>>>>         The CXL.mem protocol allows a device to act as a provider 
>>>> of "System
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index c569e00a511f..2bef231008df 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> -
>>>> -err:
>>>> -    kfree(cxlmd);
>>>> -    return ERR_PTR(rc);
>>>>   }
>>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>>>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned 
>>>> int cmd,
>>>>                      unsigned long arg)
>>>> @@ -1023,50 +1012,44 @@ static const struct file_operations 
>>>> cxl_memdev_fops = {
>>>>       .llseek = noop_llseek,
>>>>   };
>>>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>> -                       struct cxl_dev_state *cxlds)
>>>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>>>>   {
>>>>       struct cxl_memdev *cxlmd;
>>>>       struct device *dev;
>>>>       struct cdev *cdev;
>>>>       int rc;
>>>> -    cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>>>> -    if (IS_ERR(cxlmd))
>>>> -        return cxlmd;
>>>> +    cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>>> It's a little bit non obvious due to the device initialize mid way
>>> through this, but given there are no error paths after that you can
>>> currently just do.
>>>     struct cxl_memdev *cxlmd __free(kfree) =
>>>         cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>>> and
>>>     return_ptr(cxlmd);
>>>
>>> in the good path.  That lets you then just return rather than having
>>> the goto err: handling for the error case that currently frees this
>>> manually.
>>>
>>> Unlike the change below, this one I think is definitely worth making.
>>
>>
>> I agree so I'll do it. The below suggestion is also needed ...
>>
>>
>>>
>>>> +    if (!cxlmd)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> -    dev = &cxlmd->dev;
>>>> -    rc = dev_set_name(dev, "mem%d", cxlmd->id);
>>>> -    if (rc)
>>>> +    rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, 
>>>> GFP_KERNEL);
>>>> +    if (rc < 0)
>>>>           goto err;
>>>> -
>>>> -    /*
>>>> -     * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>>>> -     * needed as this is ordered with cdev_add() publishing the 
>>>> device.
>>>> -     */
>>>> +    cxlmd->id = rc;
>>>> +    cxlmd->depth = -1;
>>>>       cxlmd->cxlds = cxlds;
>>>>       cxlds->cxlmd = cxlmd;
>>>> -    cdev = &cxlmd->cdev;
>>>> -    rc = cdev_device_add(cdev, dev);
>>>> -    if (rc)
>>>> -        goto err;
>>>> +    dev = &cxlmd->dev;
>>>> +    device_initialize(dev);
>>>> +    lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>>>> +    dev->parent = cxlds->dev;
>>>> +    dev->bus = &cxl_bus_type;
>>>> +    dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>>> +    dev->type = &cxl_memdev_type;
>>>> +    device_set_pm_not_required(dev);
>>>> +    INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>>> -    rc = devm_add_action_or_reset(host, cxl_memdev_unregister, 
>>>> cxlmd);
>>>> -    if (rc)
>>>> -        return ERR_PTR(rc);
>>>> +    cdev = &cxlmd->cdev;
>>>> +    cdev_init(cdev, &cxl_memdev_fops);
>>>>       return cxlmd;
>>>>   err:
>>>> -    /*
>>>> -     * The cdev was briefly live, shutdown any ioctl operations that
>>>> -     * saw that state.
>>>> -     */
>>>> -    cxl_memdev_shutdown(dev);
>>>> -    put_device(dev);
>>>> +    kfree(cxlmd);
>>>>       return ERR_PTR(rc);
>>>>   }
>>>> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>>>   static void sanitize_teardown_notifier(void *data)
>>>>   {
>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>> index f7dc0ba8905d..144749b9c818 100644
>>>> --- a/drivers/cxl/mem.c
>>>> +++ b/drivers/cxl/mem.c
>>>> @@ -7,6 +7,7 @@
>>>>   #include "cxlmem.h"
>>>>   #include "cxlpci.h"
>>>> +#include "private.h"
>>>>   #include "core/core.h"
>>>>   /**
>>>> @@ -203,6 +204,34 @@ static int cxl_mem_probe(struct device *dev)
>>>>       return devm_add_action_or_reset(dev, enable_suspend, NULL);
>>>>   }
>>>> +/**
>>>> + * devm_cxl_add_memdev - Add a CXL memory device
>>>> + * @host: devres alloc/release context and parent for the memdev
>>>> + * @cxlds: CXL device state to associate with the memdev
>>>> + *
>>>> + * Upon return the device will have had a chance to attach to the
>>>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>>>> + * (hardware CXL link down, or software platform CXL root not 
>>>> attached)
>>>> + */
>>>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>> +                       struct cxl_dev_state *cxlds)
>>>> +{
>>>> +    struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);
>>> Bit marginal but you could do a DEFINE_FREE() for cxlmd
>>> similar to the one that exists for put_cxl_port
>>>
>>> You would then need to steal the pointer for the devm_ call at the
>>> end of this function.
>>
>>
>> We are not freeing cxlmd in case of errors after we got the 
>> allocation, so I think it makes sense.
>>
>>
>> Thank you.
>>
>>
>>>
>>>> +    int rc;
>>>> +
>>>> +    if (IS_ERR(cxlmd))
>>>> +        return cxlmd;
>>>> +
>>>> +    rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>>>> +    if (rc) {
>>>> +        put_device(&cxlmd->dev);
>>>> +        return ERR_PTR(rc);
>>>> +    }
>>>> +
>>>> +    return devm_cxl_memdev_add_or_reset(host, cxlmd);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>>
>

