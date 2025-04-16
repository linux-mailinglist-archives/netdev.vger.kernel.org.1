Return-Path: <netdev+bounces-183493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED1A90D63
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7B73B938F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94F2253EE;
	Wed, 16 Apr 2025 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MVkffQNR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB022069F;
	Wed, 16 Apr 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744836579; cv=fail; b=feegG2GDAUwcgaerJl0MUMLWOIOPa20scGPe4MQCw7JVsPNJopsh7aEWzVtptsmfrmwC/rSXWzQ9bcXuFr79bB3qKmlA3LXunBl56ugmtOQ6fa7nZnfIgyhzt/wthKc0sE4ySE5ZbI9JwMEFTFug+c7jmVXr89i5Cw3o77fnIzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744836579; c=relaxed/simple;
	bh=/Kf6/mL/RaojqW7xxzTX8dxXbrFCffMOvvKvxR3Ed3o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jb7qk4C/zFKnGg0SLM/vPnvsj8Q4s3Lm5+Y4ejw/7iDF6VMnLIyyujOaa+ghpncwQ+z0Vh+mkAxEZeMBsarsRJkyeIjB2G9HUWj1EZLvymhMGKbVjBPgGpt6qUJycqHf4jkv0FXWtr5WxTNKgcACiABUHbUO410L2tadGG9iJ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MVkffQNR; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTNu8VEvFu2VUu1VEsm757oJ6ucXC8pGoe2lQiBDp//WUU8SI1i0lEE+3Kr/ZX6Wj+uKZs1fxoxhGWcDtvLUeVQ3VyFhp7Prdi2NIFD1KGL2nd25FnGsQkInr+GuaRnHZXvQrYVolkg2I2f9YAtNhj0CHqeFlnCFXiW1CajXvInFVbtet0F6tFREIq/yQ91E+vrtRj+7PcPyBYJPgcyxPLA8E/ex3eFNz66dnrf9+/kYMtgozVlPqcX/DxqsobJ65VUYGhdQwTolLWbGFSpBztXI+nxuMLsAvt4n5s+dibpVmLk2UO3Nx4BVjmM1ummgVjgCtkvhHtsKiEjLzu4gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO3BILJIFj+yNiPDNdX+5Dza4AHlXyDdTNP4X5szabI=;
 b=mMDcFRJejqMEAO8M5KfVDX1v/KRyScYqupwAsr/rjaatw5DHCmU4D65uRO2hT/w7njNHnyOFplqShuA7faezjWceo+2EdHtU+8RsnwiARSC61ymrfBjtAQ92YpquN9iGSwxQc44dZq9e3yJa4B9dY03KaIrhLfYIcLV5LZtjm+wtxU8fSX6Yd88DJS7DTvm8q62izduYOI+hKcDTcHJVBJW2PVi1PR9Lp9fFLgN3tBJuFdyC41sXeMaCx5yiyttnmNErIgRbkx4y6HAHuN6lpHPg+IHsMUgI3z0jhnpipYVZFHzevMf5jYfhzoXXZC6GbZPxYS84rv188dMKcx6NSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO3BILJIFj+yNiPDNdX+5Dza4AHlXyDdTNP4X5szabI=;
 b=MVkffQNRTitgWt7fyuBSDqet0hLRHXY6Ki1L4FDgJ+dV3Q8z0/tmJ1AIpuWaVT8Xn+wvE6JdGu4AeVtCAsy5sHvCucP53BKH8hf31hSicLSPUQhey6ga72pfPqid7Pxpq2dDc1uOONPZ2GxzJpViN27ZElSq3h2PhB8wgN/HDD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Wed, 16 Apr 2025 20:49:34 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 20:49:33 +0000
Message-ID: <ac965836-ee8f-4b0f-8a69-8a76aec7835f@amd.com>
Date: Wed, 16 Apr 2025 13:49:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 1/4] pds_core: Prevent possible adminq
 overflow/stuck condition
To: Jacob Keller <jacob.e.keller@intel.com>, andrew+netdev@lunn.ch,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-2-shannon.nelson@amd.com>
 <61b952ee-d4e4-4e1a-bee6-4bde45ec1025@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <61b952ee-d4e4-4e1a-bee6-4bde45ec1025@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:510:339::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f820673-3aca-49d0-f54a-08dd7d283148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0x0bWFMSWRPNDBzZ21KSi9XQlBLSWFycmJ3ZFk3aXVHRzI4K3BqS0F2UVNZ?=
 =?utf-8?B?NCt3aGQ3ZzB3MTVodS9QVW5yT0U0L2IxYzVZQTRreDJGUzN3ZXlGbVppVkcw?=
 =?utf-8?B?dmR2YVU1TWtaNzdVMzZFNGViOElxZ3FYdGtqeGNtd1NUOWhTQjBKMmhuMTJQ?=
 =?utf-8?B?VitNY1Z3MHd4NUNFOVVWTkp5MlRITUZvSGN0U2xBNUVkVGZ6ejFoazJoZ25J?=
 =?utf-8?B?MmtEWWhXTzROV09CbmVmbklaYzNBaGVwY0R1ZkZTaEhwR3lFbDVZWjdKU3Qr?=
 =?utf-8?B?djdSUjF2UU9MSmNTQTR6d2hZSDZQQVRGN1VMZWxIbU04K0lFY2l2djVLOHhp?=
 =?utf-8?B?SER5VXBsK3pMa0JITWo0dzByMWFsQjM5WnQ4RDBOd0FiVUcwbmR2TllNNFZ0?=
 =?utf-8?B?TmpwNC8vbkJyaTd6ZVJXYXhRY3EwMEV3VEZFYmwvOFJXYkNYTDlZdWhGTTRo?=
 =?utf-8?B?Zk0xeTlxZnpPT1Zma2FyRU9iakVYQzlhYTB6RE0xN2kzdTNwR2RvWkRKajVK?=
 =?utf-8?B?MTRMVHJWUDBHeWIxa1Arb0NxZmtRdlozU1JQbUkrK3pwWFAxSFU0QnlVWUI3?=
 =?utf-8?B?TnJYYnVBaTdxcUxmRnM2dk8zMFNDeFYrY2owYlpUR2pSWnZadFVwQkI0MjFR?=
 =?utf-8?B?aU9JYWZuRkVTb3pyWmx5eFhsQnJOWmNvTEJLSWJodjJQSy84Q0trUjBMSXkx?=
 =?utf-8?B?WVBBSnpTSG9KK2Rvc091bDJ3WEh5UWhnTDZNUlRscXJKWXJWaWpWa3RyRUJS?=
 =?utf-8?B?YXhIZWFNR3IwUmZGRHI0dEdXbVJldW9hNWpwL04wTC9OUHRJb09RUS92Qi9I?=
 =?utf-8?B?WUY0ajJsVk5JanhGN25ZZVpIMW1BL1Y3STBYZFJzQzhGNUNpRlgrWFhIVTBU?=
 =?utf-8?B?QWxFL29UeHRmNGtGS1gvQk1oRXpseXF1cDY1cU0xeGtpOVRNQzdsZkxOUTZ5?=
 =?utf-8?B?L1ZjN0wzYXNDWEV6V1V6d1g4K2M4NW1CNjNNeGY0VTRJT3lJV28yZXVhTmwy?=
 =?utf-8?B?NkZyUjJ0WUZmenVGcDI2RFVjV25YcldLWWN3R00vd2pVdy9YNmtUZzNlUkt5?=
 =?utf-8?B?eHZVVXhxUWF2OXhMMmRIaDZpTHpxcXZnaXcrYlNBK3YxYm5ha2tHWnpyNjNY?=
 =?utf-8?B?Zm00d1dYSDU5ZHNpTW1WbWdScTdHVjUrR29zY2VQZDFFZC9oNHpFZkFFbTJS?=
 =?utf-8?B?dVFLNnA2YkFiV2ttaW95bkdXMXJqRjhoeWlFaW9BcnFNMEdSekE0dEh4dlRT?=
 =?utf-8?B?ZDNZSXJYSlB1SUtzWTR2RWhFVE5IUHBNaERYaGxzeDZ4Y2hCdkl6dkd3c3VH?=
 =?utf-8?B?WG9POWZDdFI5WUoyQmd2SGZ1Ylp1aVlDeEdhUzQ2OTd0d1h0ODRFbmt2a3Bp?=
 =?utf-8?B?SFBPUjh5L1l2NklXeVo2WkNweW00blZRU1lpODEyUHpLYjd1ZGxZQm0wTXI4?=
 =?utf-8?B?ZHE3aTAyLzhuVGRLWXNXUzVqbWw0VEs0alJwNFNtWlB6Q1ZMeU54eVB4N0RL?=
 =?utf-8?B?NVkva0YyWE5QQUY0V0hKVDF1TkNiZ3BNMlRqTDhkVDFJZUJNQkd5MDIyQ3Vp?=
 =?utf-8?B?cWpHVmdwNzJxb3gzemJRK3pZNExLWmlEODRxdmhjQ042aVFKcHFER0VzT29D?=
 =?utf-8?B?bkU5RjlDdENLR1N6UkJjbDltaStVNXF4clZtL3NxcVZWOTNERzZZN0o4QnIz?=
 =?utf-8?B?NXdWYm1vSml5aGM0TFFGRWt1VE9OMUc4YjJsR3BPNjJVU3I0dUpCc3FSSnhX?=
 =?utf-8?B?b0xaNkNZN3cxSTI4UTRNczNCNDFzOVJPSVF5em1wTVdqSWhVSnhNTURZczYx?=
 =?utf-8?B?ZW1wZmFsOGt2WFRrVkZLTDZoVndOZWI2VjU2cUQ2eitXVmJ3Z3hwcUcvWkdn?=
 =?utf-8?B?K29TMFhzL0Nqa3h0alBQS2V3TCtaODZITExBZE1ZOEovc2JObmtjVlg0WkpK?=
 =?utf-8?B?aVpIMzRQazlOVHFVcGFqUnU3K3dMZEhHU1JtNTVESklFWTYwb29xd216ZmZy?=
 =?utf-8?B?MW1OdWJpTWl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFleXJQeUx3QVZ0RHg4M25wZ3NNS2Rwa1ZzZ3JLTlZyc0NmOEcxMkNnUHV0?=
 =?utf-8?B?R3N3R0dEeisxc1dLS2JXUXF2NVgzMWRXT25YSnRmMXJKRkhaYjhUMGtTdVc5?=
 =?utf-8?B?VDlud3NoYzNqQ0h1R1ZRSXppTlVWT09MYUFoVFJnMWd0ZU1saDIxQU5oRkZz?=
 =?utf-8?B?cmFYbFVNdXlJSVc2VVR2azBNYm9Wbk9XV2pmaEkrL3dSdGRXZ29scGlFYksr?=
 =?utf-8?B?Qkt0MzliSStNNlBVOEtxa0hYTk00Q05RQUc5QnFueFFKV0U4akhDS1NURksr?=
 =?utf-8?B?cUxOakhWTTArTUNacUJpdENUajFFdmI4cW9XUTBNc2dlMElIL2NVNjM0RHNy?=
 =?utf-8?B?WTNMd3IzS1kyOUNSRXhwQUlLZC84b2ZKWEFTYWZpV0pmV0UvOEJWcmdHYXNk?=
 =?utf-8?B?K0dVYW85K3Z3RW1kcHNaRDVQcy9BQkduNkk5dkEzeW1UdCtBZEFidVhkL2FO?=
 =?utf-8?B?ZEtHNHV1Q2ZOV2IzWU5BOVV3ZUJRSGZQenRxYVN3STB2UithOHBrTTN5cTZH?=
 =?utf-8?B?MU5JSWdyaTIzVjZLdUlqV0Nwdkl2MnJoN0RxTHc1TEJRZnR4UnAyQTI4QzJr?=
 =?utf-8?B?NVhmSDJIZWl4Z0x2bkU0QmJEYVE2Q2ExQ3pmd0tpNWhHSFVGZCtELytBNXF0?=
 =?utf-8?B?VmhRdm4vajZuL0lQUDUvOGZyTkJheDI2Yk9yWGlzK0NtcHkrNTYwZUFmQmE1?=
 =?utf-8?B?VWtMNFpGL2VJKzltZDExalVUSVBmL09Wc3JLcXB0eWZ3dS91dTkxb3VvODVt?=
 =?utf-8?B?YytSTnVyU04zbzkvM2FKZzBvaktLeEcvRmQrcnRSVXRYUExoMEMzRUs4MDE3?=
 =?utf-8?B?RHRkemhWa04rRzg4cXVKWmNOcUkzOVMycTJ1VGpiT3lzTlhOZmFnbnZ5Vlow?=
 =?utf-8?B?MHN4bHpZQ2kyeUNacENIRGVOOGE2cjV5UDVhUklPbXRKTzRoeXNWUVV6SkdV?=
 =?utf-8?B?R3dxNEhlTW9vUVpuTGRBeU0rUmo1eVZ6RDlFWERBU0ljZGZFbGM5bWU0WHUy?=
 =?utf-8?B?L2ZLNHV1YmMyalZpZElTSExlZ0l1R0J3cG5EeFNlSlU3MXNsQkxWaVRuTTZK?=
 =?utf-8?B?UVpuSTdOK2hYUHVpS0RLejBLYTZGbGd4NDBhZDBXbEgzR0cxMHdPNWljRUsr?=
 =?utf-8?B?N09BQmp5Z0VtVUU0Qjg5eFhSdXBzUSt2UWt3QUFzTEpoQjNnWW15V2hQdlo2?=
 =?utf-8?B?RnorZ21zeXEzeTE0WlBENmJ3ZWJxQTBOSDVyZFFYQVE4TTE3a1E1V3RrQXpy?=
 =?utf-8?B?Y1doaVh1L2pHYW5OTy9FS1JITitUdEd3Vzh2N2htMGhieHovS3kxS1ZFUDFm?=
 =?utf-8?B?NjE0MmhvUlhFcTdZblF0VTFJUWFKV3JjYkZ6ZFFZcVpWWG1iazJNNEdUOWRj?=
 =?utf-8?B?N1Q0aGdKYlNzamxIZG1iNFg1MXlOZnJoL2d4MlB4dEh1blF6NThRL29yQVVp?=
 =?utf-8?B?dHFhYjNJUHlncXdROFJTU0lwRnpsaGZTNld1ZDIzZE93TXhMdGI4T3FxaHJn?=
 =?utf-8?B?UkxQL0pvcERnU00xSUFzTlg5Y3BNK0hobjhGaWtiTkJTQWhjeEhUWHdtYXB4?=
 =?utf-8?B?SWFNT0VNK0lyTkxJTm5KWDdMSlBrUHh0NmJlQ2sxako5SFpsa1NEbnB2U2dz?=
 =?utf-8?B?NkhqTVZXdzZSdVp0cVpNS2llbGlpS09ndzdoWFE3aW8veWVjT01RQ0Q1WWlF?=
 =?utf-8?B?U3JBY1pzclpnUXl5N1ZjOVR2YklNOHhTSExpS3NqNFhyZVgra0NSWFJKOW9R?=
 =?utf-8?B?SjFZWmFpbXZaSE5Ja2xzQTR0a01yUDd4b3N5VkMvOUpUbUQ4SnY0ekljMWFi?=
 =?utf-8?B?ZEVMUGtJYWw2cEoyQ1NPTC9ZY2FuZmJxQzdsUXg5Y0VRWFVQZzZtYVBvQ0Z3?=
 =?utf-8?B?ZGlFR1NHancyMVlrcTBLRllXOUR0OWYrM21zencwMGxZZmxDL2gxNS9rZkZC?=
 =?utf-8?B?c3VrOE5kcjdtRnU0UlVYQnhSWnZiTEs2THdtYzRaWUE0TU9iRXB1bUJxRXNw?=
 =?utf-8?B?enl4ZnFxK29Kakk3VFUweWt2eFQzRkJKalF0VDN0S0ZJU29JV1R6UHdEY2hP?=
 =?utf-8?B?NXg2b3YxT3pFWUt6UGlEREhjL2h2MzhCZHBzOFZwVXNqWFVBZXdBdjMwbUxY?=
 =?utf-8?Q?hRS4OaoNTmgR9TEpd+Cqp0cnU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f820673-3aca-49d0-f54a-08dd7d283148
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:49:33.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvOHhfXorfy/v7shNniiZPI7Lyr7KyR+tj10RkA3zgBqHfYqvzKOv8L5hX8VjzBZLJaerWE1psXhYPcXDcwnCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123

On 4/16/2025 1:13 PM, Jacob Keller wrote:
> 
> On 4/15/2025 4:29 PM, Shannon Nelson wrote:
>> From: Brett Creeley <brett.creeley@amd.com>
>>
>> The pds_core's adminq is protected by the adminq_lock, which prevents
>> more than 1 command to be posted onto it at any one time. This makes it
>> so the client drivers cannot simultaneously post adminq commands.
>> However, the completions happen in a different context, which means
>> multiple adminq commands can be posted sequentially and all waiting
>> on completion.
>>
>> On the FW side, the backing adminq request queue is only 16 entries
>> long and the retry mechanism and/or overflow/stuck prevention is
>> lacking. This can cause the adminq to get stuck, so commands are no
>> longer processed and completions are no longer sent by the FW.
>>
>> As an initial fix, prevent more than 16 outstanding adminq commands so
>> there's no way to cause the adminq from getting stuck. This works
>> because the backing adminq request queue will never have more than 16
>> pending adminq commands, so it will never overflow. This is done by
>> reducing the adminq depth to 16.
>>
> 
> What happens if a client driver tries to enqueue a request when the
> adminq is full? Does it just block until there is space, presumably
> holding the adminq_lock the entire time to prevent someone else from
> inserting?

Right now we will return -ENOSPC and it is up to the client to decide 
whether or not it wants to do a retry.

We have another patch that has pdsc_adminq_post() doing a limited retry 
loop which was part of the original posting [1], but Kuba suggested 
using a semaphore instead.  That sent us down a redesign branch that we 
haven't been able to spend time on.  We'd like to have kept the retry 
loop patch until then to at least mitigate the situation, but the 
discussion got dropped.

sln

[1] 
https://lore.kernel.org/netdev/20250129004337.36898-3-shannon.nelson@amd.com/

