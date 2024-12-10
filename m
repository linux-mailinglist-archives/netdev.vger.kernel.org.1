Return-Path: <netdev+bounces-150848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDC9EBC0F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90BC167A19
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14952397A3;
	Tue, 10 Dec 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="osurqn79"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454481A9B4C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867076; cv=fail; b=l02tqnaAzb+TGh2sjfHnYh0j+d/HFMMZxO+J/AHvPWRQuH9J9juwlImOrgAN5p2TSInCBaZgP/NI9V+E++0nbOjsxXLgB9fKBr5PHsbjWpg3cjoB8MN0DE+sEwXTxbReXguOnf5sqkv8EVZLBhgi5dOwFB9BrCF+ONyjG1n2stg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867076; c=relaxed/simple;
	bh=YOCYLOM11H4lLvI9bDQk+RgLGcVnk6+GTu3hXOk/9JQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i3+AFzV8F4xk1P2G9vrkWJvWQ4PbiYG6aHmX5SBClR2NWzdlsmJUThTssOGGRq4vxR2UQUXo/Esp6nspNIBWiUHwMqGLs2RgrJbFTM3Nxt/fqNt2W5RIA9YQaPRyYgti4Yj3rlYOeGs3YiICirxhgcDRIdlATnXqjJW+KlvvK+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=osurqn79; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfMmtBxFbj84L7oliSFGEzd0920VU+COvQilBqKxeYYWu/cO4FfBrj4FGMJ9548ftqJ3qoEJpXlZK3KPK9xgXr5mEbNZrhETiyDwaHV2u8Wm16MW3SJisMiHzAG/e3MING3FSYXMEmB3Ur23Oe938Un9emVgvIKbzdqe9DL69Lru6XyTgNvKrdGim+9isu0RVivmOVxn56Rv+haMbv9XRVuiy48povAJMn9MNIVnXCEbdXAieTdruR03JueLhyvCqjrDKY1DfAL8YHkcokcDVlkh2Q9PCB26Q5hQ9XJYLrNoedVAU3TjqyN8xvY6Qgc49osOfWGxBevfHnUvjlmdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8m0xq/7Fje87xPgyWr9f0sgikkjE5+BsNuWmw27qBY=;
 b=SQRnUsghQCynxg+81z6Q8Dam4whDyKxdbjBWYM8aopgeebajUsT23iw3AOyWRosdv8qkRkplJbJyw1J88zqIcMqDgvkx10m4PxU4vnbXx8ajscE0IqHZabwaynfKXJeEfBV5vW9myRnQg6V4hhkmf4nFARbJcak74RJ2Z1qoQZ/k3oKceW5ELVfTpoADsa9MQJSMQFb+U0iumK+JSqruMY5LzuQteYqg1297vm1bv0c7PqKxmI/EmHl1F5eoIAry+FoMHD6TkHwQscQ+CaMYSoKjlYMaOL+5bHJI8Ve/FPhsEXjwUBfZGdXzM/i/ZA54J+mAs2sV/FpuajcgPEVB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8m0xq/7Fje87xPgyWr9f0sgikkjE5+BsNuWmw27qBY=;
 b=osurqn79MnFMPpirXUYCq1IVGzgxvk5ziKFyQLBaToeXbPR4IgtLMSdw+v80aNDnC2WTKoZQ2xe8vKcApeHiI/xX157B5HkZVmXLoFta9kDDzVZeDem42TPy7IEkIDBubecEQA/ErCmDvJ6lxiKh23yDKiUtRVfLlCD8MeEOiiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 21:44:32 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 21:44:32 +0000
Message-ID: <a8faf111-281a-450e-b595-ba35a7ccc66d@amd.com>
Date: Tue, 10 Dec 2024 13:44:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ionic: no double destroy workqueue
To: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
Cc: brett.creeley@amd.com
References: <20241210174828.69525-1-shannon.nelson@amd.com>
 <20241210174828.69525-3-shannon.nelson@amd.com>
 <a4f1acf7-6bdd-4865-a13d-945791917afb@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <a4f1acf7-6bdd-4865-a13d-945791917afb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ad95c9-18ec-4e39-5c6e-08dd1963d4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MThYMDU3dEZ5OWFvZVV4cjB0YTc3L2U5MmYzTDB6Z1MxbFpqN2I4b2FFWEpT?=
 =?utf-8?B?NjI5UDZWV1VUY1pXL0NKRytTVmh2ejE1ZGtIY1pPNlV1alBhWnFkVzNBOTVF?=
 =?utf-8?B?Zy9KT0lLTzhaMmZjMUwvbzlKK0UydXppUWs3WFpJNWd4aUxwTUsvMkNyeHhi?=
 =?utf-8?B?ME1OZVIyazFzRGU3NEZ5cWJZRy8xeFZNNWFWMmVCUENsWkpXWHRMVjdFM3pF?=
 =?utf-8?B?Z0s0ZXhxU2dGWVd5dzZqRGZTaUZybGZWbG84bmFHL1NGYVNYb2lxVnNrdjFO?=
 =?utf-8?B?K1JqYjhoalp4UTVaaGlCY2VpQitjNU02TXZoZk5PWWhSVlBmZDlnUk8xMUdQ?=
 =?utf-8?B?SUVxUkRNMmIrQUs2REpNY29NT0pkMiszVUI4Yytnam43MGtScytmemxVNU5E?=
 =?utf-8?B?c08wRFgwa1grNXhHNzV0YUYvbjJ2VFJuUlJEbGpwMWxsejN3RFcxb0pnUzVn?=
 =?utf-8?B?Zmt3TFpYUVB1ZXlWZFlRcU1xb054SUFIYUg0MmJZUk9Zd0J5VTY1aUgyRE14?=
 =?utf-8?B?MTlhMlpXcUpiWHlVNDhnWWZQeitKSm9ZWlVWbUJnaTB5eWQ4UFk0Q0l3dW5X?=
 =?utf-8?B?RGJNdFF2TGkzLytLaFlRMXlvOEZ4MjdoazZqZzZtOVJKamo1R056M2NCYnY4?=
 =?utf-8?B?MVU0UnFnQVJnODY4T0FuMTBUcUFnTkdEelc3RlMzRG93ZjBjZEo2TkwwNXRG?=
 =?utf-8?B?Rm1VK3J0ZHF2cXlnbEtQb09KaytlT0FuMm5mdzNZZlpwSGpxVU8waUtUMFhX?=
 =?utf-8?B?a1JaK2E2aFZHVExkWlBCaVhBM1p5YlhsVVladU1sTDRSdkYzWXZSOGJtYy96?=
 =?utf-8?B?dXpaUHlmZ01rVkgzUnN6UjNKQk5QYXpWYmJNRGZBTTYwVHdtU0VPeDQ2YUF6?=
 =?utf-8?B?OTFuWnFQUjFDYktFaXdvVmhFMWs3RWdPRmtMOGRVTDEzdWhjMzAyeHBvSlpZ?=
 =?utf-8?B?Z1IxbU11VEJZdjUvaVh4U0N5aGVrWUFSUVJzVVRuZDJzLytjWlY2dlN1L0Y4?=
 =?utf-8?B?bHdoSEJCaTdqcjYvZDFHcnRPOHJHMEdBSnh1cHhSa0YrYXBSalg5TGlIajE3?=
 =?utf-8?B?UVN6b3dLK0Z5ME1RSkN1NDFGV1JpREdyMXpPZWxEQjR5Wkp1NWxRY2FpVkwy?=
 =?utf-8?B?R0QrWWl6UDRFOE1CQ2E4ZEszeE9CWGsyU3pEbEYzcTVkWlFxOWQzWTNLMFVX?=
 =?utf-8?B?UE0wZEZYeFdKUzhVTXVOZ2hVeERiRDI3dGRwNVpSTDNVSlk1ZUNiK3ZaNlZ5?=
 =?utf-8?B?akYzeTdGMXBkUFprSWdkbUpzaTVkamFLR1JET2NzSzBpQmdNODV5UU9sOGx5?=
 =?utf-8?B?eGt0WnVUWVVUNFkyQXh0d0tkZ1h5NlBjdnl0cmxPNnIxZ043QlBvaEx3ZkZL?=
 =?utf-8?B?QjBSVnFQLy8wR09PajUyZ1YzREZJdmd5SEVCdUFQL0FqcllKcFk2eVhWSmhG?=
 =?utf-8?B?eTUwRk9hRFJkbCs2c0pkQTV2WFpiL01UQzQxWWZMV2cwNUpDdVpEZko5SnJG?=
 =?utf-8?B?Y0g1M0ROSjN5WXBUQUM3QUhDcjlvUUNtK2RPUjJNMDZtbFdkQ2xYSUpzKzVX?=
 =?utf-8?B?clQzc2FRRzNmVjRhUWt0bWxSdCsvRG1nY0NwUW9XWkpROGtLQXYvaWdwN3FR?=
 =?utf-8?B?SjVHZjRRMis1UytXRENKVlNhTTR4T3JrWlVuSklXT3R0YVE5RXJpTHBMclNE?=
 =?utf-8?B?U2phNjNNZlY4bTNNOTAzR2dNR3UrcUFRUjF1dHZ3b1lNSWd4R3ptaW8zZVla?=
 =?utf-8?B?U1htOFJEbTNsR1RDNFgveVJnNTBHODQ5U216MmZTSWV5aXF5a2d4SnU2VHRT?=
 =?utf-8?B?VitMdGVFUzc5QVVzcG5pUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDNxWHRCWU1QVThuSnpKZmFSOWpNVGxFakFhSklneGNyMnppNmk1VkJvdjU3?=
 =?utf-8?B?cy9ibCtobTYzVXhYeUVBSC9mSGxJWnkwSmJxS24xQlJ4RmJSLzFXdlE3UnRG?=
 =?utf-8?B?eDhLak1pY2dQdXF6aVV5WWFyRWE5eHNaTHNBbFU5NEkvUnA1aiswK3BjMlRq?=
 =?utf-8?B?NXZVZDhEWHJkQjZRRnREMGtLR1loTHJtd0tLMHZpZGVielMrNGVtYVpTeVln?=
 =?utf-8?B?cXpZSkIwRFkvSWt1ZFF3bkhxQkJqaTVaMTZzYlVKVHRBM0ZLanE3dlg3TVo4?=
 =?utf-8?B?UXpJaU5NcWlFWGI4c1NOTDBNL2VDaUp1Y3ZQQ3lKTFNCOVFCaTE5elJiRFFR?=
 =?utf-8?B?ZmpaVFg2aVJjWnhXK1phd2pocGFlSXdORlB1VkoxMFVqZnpqTVNzc2U4Z0lX?=
 =?utf-8?B?ZFEwT3JBWE5sVE1sSll6UEY4U2lTRXh2N0RJdU9oUXZzQTZmN28vNUVURi9i?=
 =?utf-8?B?WlV2eG9neE0xOTR1cmdKeVdHV1JaamszQ1VzekFJNUlNSkF4Nkx4Q0VUSFE3?=
 =?utf-8?B?Wkt5a2cxSzVSTXVnYnhLMFcyK1l4YThMT0hXRlNJR1VDb2E1SmxtYy9ldVo0?=
 =?utf-8?B?SnJXWHlLcEJIdlpXWFAwVFJxaUpLdVNSMTErc0tMeTNCYzZjQUdwL3grS1Ux?=
 =?utf-8?B?aVdjb2FvQXU4UUtkZE8rOS9ib0kwc2pKYkdKNnI2WmY1djNCVDcyNUEvZnk4?=
 =?utf-8?B?Z0YyYkVlaG9yYTFaWjkzSTdpNlpXTnlvME80MDlmdEJ4K2E2TzR3eXJUVmFP?=
 =?utf-8?B?b2Y4QVUvOEtXNXVOUHU2WGE4ZTlaVGN3QUx2dHo1bXhBOSs3ZzRWL2VhRUpw?=
 =?utf-8?B?OWpxbUJLb3ZMaHNEeTc5VnlPZTl3Y2VPalFrQ3V6WmVKeklEWHREN2R6NnUr?=
 =?utf-8?B?eDJTa3RNbDNZS21mTlNiMWtYdkNUYXJNQVdFKzhXMzhMSnRKOUExczFGVUYy?=
 =?utf-8?B?T0p5RzhFeCtad0NvaTg4UGNBanQ3QVRLTDR3a0RNUnp6TXMrQ1RPSHNkbGw3?=
 =?utf-8?B?a0FWd3NvMWNjMCtWaFlNaEN6WHlUR1NWYmxMWFhGSkdpOGZya1JNSEJpa25y?=
 =?utf-8?B?cDMzRjZCVzZuYkhkeVZ3N2kyMWxobG9QQkk0Q2RtSHI0citudmczamJrZXZr?=
 =?utf-8?B?NjVlbUd5dkVlczJvdHkxcTdLVzEvVUd3c2M0SG93Z3B4aFJLMllNYVhVYmFS?=
 =?utf-8?B?N2paMWlsbHNvRkJZM0ZZYnJSKzNPQmdJTndHd3F3SzlVNnZFRDBqZFZWZzNt?=
 =?utf-8?B?TnZqb1BaVDNNS3h3MXJtakNhdGR3UjZzYjUycExTVVpxdTFPa0JWaVhPY3ZX?=
 =?utf-8?B?MCtuanVxZ2pXbVhFZXJIbjdRUFNPZVNyZnU0ck0xcy9VZ0g4S2ZXSWFVU3I3?=
 =?utf-8?B?bVZnVGhQRmtXNnk5ZHplM21MajFNSVFGMWlJcHlQQjNoam8va1pQemtodTRj?=
 =?utf-8?B?eWZzcE0vR2VCemEyUGVWWTJCUW1NSmdiSG1FYnJ5MXVZOGpLMHNmajl5L0FT?=
 =?utf-8?B?dU96WDFJWVp5UnBXSUpNazcxZk1YSmJwLzZiWDQzdDNMUlRCbFg2MjJaN1lz?=
 =?utf-8?B?RXVhc1JIOGlQRzBpWjF3bktJZGxBZ0hUSkpCS2hnOWJJZXhhdDF5OWxzN1d0?=
 =?utf-8?B?aGEzWUswekVYRXBIT2lVNm5objkvZ1VXalExWXRseDFtL3VzUFdwNEM4UVN1?=
 =?utf-8?B?OFRvRG5ZVEcwUEZwNEp2VUVhZE9iOW9kZEUwUlBWVUEzb1pRcHFSTXorVWk0?=
 =?utf-8?B?ejNyOXJqa0JqdEo0c3VBUGZtTzZ0TjdoZjJ6TnhvQTFmQlpVZnk1NHhYQzl0?=
 =?utf-8?B?d3ZoOVhsalVOQjVYKzNEZFR1Si9UbW1BNmJrdy9pcnVaOHZTYTRrcldGdVFr?=
 =?utf-8?B?aWg4a0sxYXFpbWtjQnR6c0Z4TEk0b3JxRW51emVtdWJoSDhiSU9zbDQvWDZL?=
 =?utf-8?B?TlNIWm9YVFBVNEVjZjM0Q1lIaUo5ZjhjQnZmWlFPTXFERjNqNy9BYXFWVFJU?=
 =?utf-8?B?U0F0SVJQQ3FxQS8rUFZIM3d5M2RGbzZCdmFEdHUxWVNVcXNFem5VQlkzcm4w?=
 =?utf-8?B?bmJGMlRhUnc3b3JlQndZMDlsdzRqZ1o1K1BJRGJDQU5FM2MzN2ZDSmNLY09k?=
 =?utf-8?Q?XZPGid/qFB3ZuSSo2HMz2851r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ad95c9-18ec-4e39-5c6e-08dd1963d4c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:44:31.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKcsTxv/2L18H9ag5kjY2JHULFMSshTm/9Syvj7rYeWrTnLP51VLu0yWXaxe9mouN0OxGJzY5vM0n5iJBGhCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

On 12/10/2024 1:02 PM, Jacob Keller wrote:
> On 12/10/2024 9:48 AM, Shannon Nelson wrote:
>> There are some FW error handling paths that can cause us to
>> try to destroy the workqueue more than once, so let's be sure
>> we're checking for that.
>>
>> The case where this popped up was in an AER event where the
>> handlers got called in such a way that ionic_reset_prepare()
>> and thus ionic_dev_teardown() got called twice in a row.
>> The second time through the workqueue was already destroyed,
>> and destroy_workqueue() choked on the bad wq pointer.
>>
>> We didn't hit this in AER handler testing before because at
>> that time we weren't using a private workqueue.  Later we
>> replaced the use of the system workqueue with our own private
>> workqueue but hadn't rerun the AER handler testing since then.
>>
>> Fixes: 9e25450da700 ("ionic: add private workqueue per-device")
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_dev.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
>> index 9e42d599840d..57edcde9e6f8 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
>> @@ -277,7 +277,10 @@ void ionic_dev_teardown(struct ionic *ionic)
>>        idev->phy_cmb_pages = 0;
>>        idev->cmb_npages = 0;
>>
>> -     destroy_workqueue(ionic->wq);
>> +     if (ionic->wq) {
>> +             destroy_workqueue(ionic->wq);
>> +             ionic->wq = NULL;
>> +     }
> 
> This seems like you still could race if two threads call
> ionic_dev_teardown twice. Is that not possible due to some other
> synchronization mechanism?

Good question.  Thanks for looking at this and the other patches.

This is not a race thing so much as an already-been-here thing.  This 
function is only called by the probe, remove, and reset_prepare threads, 
all driven as PCI calls.  I'm reasonably sure that they won't be called 
my simultaneous threads, so we just need to be sure that we don't break 
if reset_prepare and remove get called one after the other because some 
PCI bus element got removed by surprise.

sln


> 
> Thanks,
> Jake
> 
>>        mutex_destroy(&idev->cmb_inuse_lock);
>>   }
>>
> 


