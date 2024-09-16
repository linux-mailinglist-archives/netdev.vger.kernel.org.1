Return-Path: <netdev+bounces-128523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BE97A211
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C90B23841
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85D4087C;
	Mon, 16 Sep 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V4IjTzov"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DC13DBA0;
	Mon, 16 Sep 2024 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489138; cv=fail; b=d0b772AQr7HWIFyExOYzXYN9lCm9fRSLsStAxrGt2jPAi97l1D1l+UV7GObrV8fpcKybD5OhmQpnfDj2f1MHGlH9LkOe7JERk10vDr6R45b5LD0fmNCTcX6TUnHuT9esbwyzpdEDrybiH71FwvVVP5Bi0RKA9t7gOjwvMCKkA7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489138; c=relaxed/simple;
	bh=HLkD+QtJRsg/06ZkG9pB8kffGUKctdnO7UjZ2SqaRZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n34gKhljeh1TUXxBeanN2Vg7oNaPTjjVu9oVfXv5Zf1hHxhVwLpUSflwWNXowxyVA5K/cwu06lYYo0rqzDNug53vphI0QmATxMUiAdcIWx9tKLjlv1X6NxGewmaIX0onWTECpqkRSeaFXLOCe2Xq2ApSbkgt53Q+vKC2HZtVP2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V4IjTzov; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJfNxsmQUtO7ophVA/5Qic7jqpPB7eHbxUbwN9GUf1q1vd2/jWVEGV/xpvn/N56t5rHHN0966lkdI2KjfLU76O03vfiL7DcHi5doZZiYMgCpgxRgUH6qIPKtZ5JLxnEddrYCy1LM+rYMwsztfAQlMH/PzFtmiCcLEJfv1Q12GajG1nHlqWh/Pm/uzljkFftjVWSlZOx5ylkaZavHv6HXPTiEciziDHHFri0sJm/+50WPj7Gq8nPiHV8FFv9zUD+a/ezb5mD4njHxVBnNWoDullgEygflQAK4CtrokwNXpEtpxDciU6qbzDj9L5bOMf88/zcCTp0w8yLXWKpZRQ+6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF4+zwmvbewtM3qM/0D3PpTttRDjjJYwad7GGsNSrJI=;
 b=Pc+KTWLOrZQYM6W7pojW2rF17/TxjCV5vOREhLY+ttdj/j5N35ZpiYXDA9/2iAHw5wxBUDZdakXh36FnBBfgI+6BzGDN7ea+NNX3LecP7LCtTy/UsY2dugB2YlVB5Pfs3Bqmeqw3LZKMualTGTpBgBPS4JZTMALQxKxREC1rvEV/YIkEXERDrovbwa4IACHWBYjblJweQ8tnMhbZ/ru+UXPlo0S4TYEOzXI6yDQigMGnYjXCbLCNqqEQtCkBb/gjDht4pZ8zCUKzqDPfRdrSRfIzFwjudKbC25fM8aQGqcmEpXtL2zyFIh6JS0eNjR1lpnJvdVY6/0oR55Qfg0UQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF4+zwmvbewtM3qM/0D3PpTttRDjjJYwad7GGsNSrJI=;
 b=V4IjTzovWGbm58sgU5MBzR/XeIO11XUga18yZnb00mKiqQ6zH4zzPDYWK05DsKHw05ELLe2MLM1NRT20PkGkYR+xW1Y6v2Ohwkva2fVq7mxXqouzkH5cJCm1PmAYkUHNdy1nMrMsGDlKHSx55cnTsAqdqPMcOyUmVC0i+79MlT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 12:18:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:18:53 +0000
Message-ID: <1511b7e4-c098-8e1e-346e-25cdd1ba899c@amd.com>
Date: Mon, 16 Sep 2024 13:17:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com, netdev@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
 <20240913182828.0000602c@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913182828.0000602c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8c761f-dc75-45d4-3665-08dcd649baed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmJxbll6SjY3bmc3TWV3UTE0cU1EOEtRTllWSk84K2s2MUNxdE9aODNRK2NC?=
 =?utf-8?B?eWdhdE5tVVBDZkUyUVUxa2E5T0RYTThBZkVUMWpiTVFNbCtwVFlNWUR4RnRB?=
 =?utf-8?B?MHdiSmJtOVRMWUxYTmFjMHdUU1p5TEpwS1g0UFJvd1BPYW1ZYXhiYTVOSXl1?=
 =?utf-8?B?aVNjU0p4RWtPZ2dCd0lvLzAvaWhKZzdEM2xvQWZ2U2E3S0pvQ09xWEVDWEs2?=
 =?utf-8?B?Y0NLQVhEbDRYZWlIdE9aVTFTQ3h5TnQrMFBhOEVZQWJMQjJRdDJyWnpmMUJH?=
 =?utf-8?B?KzN1V2ZPeXJkYmM4MTRPbFlSQjFScVc0TFFjdS9tbkg5dlExUExtM2xONnp2?=
 =?utf-8?B?ejVaUXZSbloyaWVjTWRUbFhFcEgyNEtZb2hoeU4xVTBwdGwrdjFla0h6eTYw?=
 =?utf-8?B?N2puT0dJdkJxTExLNUlERFNNNzdFQ3dqclhBcTh6SG5KRjlJaFlROXhMZGM3?=
 =?utf-8?B?K2g4ajB0ZUpXMlhWU1hReHNPUFFtZjRoK3FVVkM2S0FOOUxIN2VsVTloaWEr?=
 =?utf-8?B?YWhHOU5HKzh6anpRRFNtVGFXOW5ud2kvUnJrN1h6TGxBU2RnZkhpdTlXRGZC?=
 =?utf-8?B?R0RFSzJ6RWR3cEY0V3VmdDI5Q0tlRk9DdjVyK3prSEZ1WXRHMGxleTNpT3ZP?=
 =?utf-8?B?NFFWcTBNN21jaytranRUZlpNdkFZbXZNbnhERW1QL3hhNmxrRDNHdklTaVgy?=
 =?utf-8?B?aFVZemRKL2tjbUFLM0tiNUlEbjJnclVIVnBJWlUxYmQ2WkNmUFdoK2xHOFJ1?=
 =?utf-8?B?UlVjWGJScW9sTkw5YlhwaExGSWdJaVVINmgydGpEbEhCWWYvdmpZWVUvaDhY?=
 =?utf-8?B?WUQ5TkI0THh6aU03T21ldzl3enBaSGdEQ0VvYndLYXdGVXZzU21mU0M4ZTlq?=
 =?utf-8?B?T3lqeGVxVmpuZTlKRlNLcElzNzNldGFzNnRnUUw3QmszaGZhWnFzeXVYSkxo?=
 =?utf-8?B?L0NYOW9SWE85aGQrS0E2ODJDVVJsZ2FYWTl3S09sM2ZlUlRIYmd2Mnk5cWty?=
 =?utf-8?B?UGtuenFLaDVONzh6Qmt2MUMzUmcyeWpsMXJISlFyVGdHak1objhiMTV4RnNp?=
 =?utf-8?B?a3FTVmRoREtVQnVlVGFYYXBwRmtXMThBcUdNYUF6cUpVcFlqOGJZWW9xN3pt?=
 =?utf-8?B?MmlQR3FEVzc4V0NGazRKWUlqR2lFbHo5YnBJM045cFIvY1lLc3VZQXlSZ09z?=
 =?utf-8?B?QzQvTHlvUjRTNUpTV1VoSytHLzQ2blIxTDRxQXhqdmo3TU9OT1hidEYzRFhi?=
 =?utf-8?B?QkVOeDREdjBodkRBUnlWeThpMW9yWGY2d21WMHltbVMzajlTZm8wdlEramc1?=
 =?utf-8?B?dUhKNkJ0bEQ2c2IrS01rRS9rdG1VbmRGcEkrY1EwZ2xWek1lTXdVQnJSOUNu?=
 =?utf-8?B?UUkxTHpVSnlwRWRqb3J2QSs5Qm0rdWJIZ0FsQkE1YlVRbUI3UFJlTWVCelZW?=
 =?utf-8?B?Rld0cjU2bjl6bmt1cTBldkg4ZW9EbCsxWlBMWG91bGRKaVRRSEJwbC9OdU83?=
 =?utf-8?B?RlhuQUh2UndCcGVsSitpaUtsNExiMlRuVFdSd0Y1V0VvZ044ZjB3REFGTFRB?=
 =?utf-8?B?YVkzSDYzbFVsYTFsbEEvUUZjSUFhbjhSR0RnZE5rQzhVNGJNWUxTN056SzNu?=
 =?utf-8?B?MHZ3SDBrNHV6N0lOTldvTXQxTUw0Y3hFZFp1V1Y1dk94VTFLOFdRZ1o4anlH?=
 =?utf-8?B?YjdHNm8ranJEWmphNkpQOTJaeHZNOWhuQlJMSEhaSWNIZ2pxMzBzOFR2SnVE?=
 =?utf-8?B?clUycnJaR2NQWGIrRmY3aXV6SnEwRFVuazNvbWNFQldHVGtocFNOYVpDSk42?=
 =?utf-8?B?TjBFKzM4THVXb3hzVGRmUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJlNmR1dm9qcDNTN2IzSmFiS3h5RllXeHB6Y2ZJRUJMbXlReHc3UkdmSEVS?=
 =?utf-8?B?NFBQYkdGMFJ5bEwyajk0d0s0MGxRUzFBZlB3WVRRN3VQKzV4Rk9McjBNbk1y?=
 =?utf-8?B?M0hscXhPTXFsTm5RdHNJNmlITEo1Si9ubENGYVdDSUw5NnJMN21MMDBMNWZV?=
 =?utf-8?B?M1JqK1R2Z2VjcG5kanM5Y3VPeTJ4RnJ2TVVMWTJHM1ZVay92YVZrd0UzekFa?=
 =?utf-8?B?UUk1dFNLemp2WSt2TUw2UWtPc2NoZzl0OUs0YnZLRW91MUJjeFVGQlRaNFBD?=
 =?utf-8?B?UDllUGE1ZnNRQVNkMXUyc2d0bWZ4Q2thTm5xQnFCV2ZmcHM2dzNhcmhNZDgy?=
 =?utf-8?B?YW9aL3YxanhrL0JBanp6OURXazB4UzQzRGZEL0VPZ0Y3UFpjTjJpQnluWTdT?=
 =?utf-8?B?UlZXSE9LcXJVQThURHZyQlc0dXU3QThoUWtNTm1WVGR5cWlwQ1ZWelVBUFBv?=
 =?utf-8?B?QkgzcmhHQU9UQ0lHcUp0Y3FTQUhNNW5JbHYrNjJnVEhSRU12VVBVVkIwcXcx?=
 =?utf-8?B?OFlLZ0l2RlBLN29nY0MzTnVSM2VmazJnMVFpSjcrOElVNWhMWW85NHQ2MzNr?=
 =?utf-8?B?UDl4V3ZUSzgwakc4MTBSK3g5ZlpDMTB5WGFncENuZ055ZHFWQi9YYUJLZmtO?=
 =?utf-8?B?MmJ6bEc0WnYxYTBrOW40VS9ZYmhKb2dESkErZGFMTldDcUFzS29zOHBsK3Vq?=
 =?utf-8?B?amc0VE1rQiszeFVmMzljWnB6dWtHYTlieS9IZStCVnA0WnN0QVlNZ3R2cUhn?=
 =?utf-8?B?RjN0OXk2VS9JWFMvUGtWRTc5OThLVU52RXppbnFOa3RWTURDRnVhRkwvVU5w?=
 =?utf-8?B?RGdpYU9FMG5idVkzcisvNkg2L0JySzZHTHhOVlZSYlM3bGJZWG41djEyNXgz?=
 =?utf-8?B?d1N2emJUbExuSmdjVlhxL0tzYk5ObWpSdFI4VmlodnZJR2phWWpIUnllTGxP?=
 =?utf-8?B?d3JxWHFlcklMdkJxbndnMGlJa0tPeEdUOURBKzFqWWR2eS9oaHhoYU9za3JW?=
 =?utf-8?B?SmsyTXdIbWw4Y2FIbFhxVVNwQnF2TFJsMzNiaTlqbEhwOTlhN0JIcTdlMmd1?=
 =?utf-8?B?NlhHdjJBTHIwZGliYVBzQ2FZR1VZVWpYMXJ4d2RkejF3alRsaFhQdlRGaVBy?=
 =?utf-8?B?eGJHTGxOVk1KSEtnTzY2cDZNR01CS2lRcEQ5dUt1UGJnbDZqZzNFb09odDhI?=
 =?utf-8?B?V1hvZjRrOElRYlp3a0RQWHlRU3VoVGVWRzNJU3hoSjBZVG82SzZvSkJKQUQ2?=
 =?utf-8?B?MmJzcUJMUXgyc1VxS3EwRzc5ZXphZDAwVmxCWHorbCtwNGQ1U2l0d3pDZVVO?=
 =?utf-8?B?bnNBWVd3VnR0dVZ0VExzS1VsVnh1V3JsRCtuUEZERnM5T0FVOE9rRTJHZFpk?=
 =?utf-8?B?ckJiZExyVlA2MnNIUTAvelZOVUNPbFk3NjVGd091U25oWGVEM0p1VWJwNEpz?=
 =?utf-8?B?eCtZMTZUSXNpbGo2cjUreEp4NmZlL1loS0xIK2F0TCtLRXNETlJZZFczUEUy?=
 =?utf-8?B?czhxZHp4aWFvYi9VamVGUW90T0ppekNGY0Qya1F5RThDcVVqMW0yeW05bjVi?=
 =?utf-8?B?eVA2QjZHMCtrZ25LR1FndVZocThCeVh0OFMzOFlHOURxNVJwcjVTbVhwdEFx?=
 =?utf-8?B?bDZOY2FzRTJIMTFMWFJ0cG1Ma3VYd2gzN3ZjbEVIMjBieEJEOC9nMUtTMmwx?=
 =?utf-8?B?ZnlIYzByTWFCcFRTd25sblpPZ0M5aHN1dmVGck1hRk4xNDlOcGJnZ2pFTm9x?=
 =?utf-8?B?M013cTYzL1J2Wm0xMi9Gdk11eEZyaFEzZjloY3hRR3RXZHpvMWJFZ3BYdzAx?=
 =?utf-8?B?ZGMxUVN2RlRFbjFMeTNSSUtZc003RTA1dEpzT3V0MFJ0cWE5a1JNazlOMTA0?=
 =?utf-8?B?dmdpN2hRNE9YQVlmWFJwQ0pBUG1jSjV5UDFpTkF2VTJDNHF5aU9pNHRLd2hZ?=
 =?utf-8?B?bEQxb1ZxamNOeFRYRGM5SHltM2ZiemY2R2x5ampKNjBCYU5aRkQyZVFET1BR?=
 =?utf-8?B?T0lrSHd5bk5wWXUyckhJOS9sT0w4U0NLemFlQjdXRzUzTWRWTFU3NWtBRVln?=
 =?utf-8?B?ZDZ4Z1ZXNzJxd28yQlY0RXdtTys1UEplVHpWMGJHMEdEZ0IxN1ArazRCRlNo?=
 =?utf-8?Q?6sY1QC4ofDLh32ZMnIwb5N589?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8c761f-dc75-45d4-3665-08dcd649baed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:18:53.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qS2DzM79IZENQCwabbplXJgb1EksB1HgvTepmQMRMHg8KiSw8xe6IHcp8+d8gb+9YHV4yNAnmKsXeOLBT+afA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806


On 9/13/24 18:28, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:19 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>>   drivers/cxl/core/regs.c |  9 ---------
>>   drivers/cxl/pci.c       | 12 ++++++++++++
>>   include/linux/cxl/cxl.h |  2 ++
>>   4 files changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3d6564dbda57..57370d9beb32 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <linux/cxl/cxl.h>
>>   #include <linux/cxl/pci.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   				     __cxl_endpoint_decoder_reset_detected);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>> +			u32 *current_caps)
>> +{
>> +	if (current_caps)
>> +		*current_caps = cxlds->capabilities;
> I'd split this up as setting a value in a 'check_caps' and comparisom with
> a list is odd.


The idea is to return the caps discovered for the accel driver to know 
which one is not there.

The other option is to print out here a message which does not seem 
right to me.


> Also bitmaps all the way would be better.
> Given you know it fits in one unsigned long you can short cut the
> assignment of the bits though. Easy to extend that later if the bitmap
> gets bigger.


Yes, I'll adapt it to using a bitmap.

Thanks


>
>> +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
>> +		cxlds->capabilities, expected_caps);
>> +
>> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 8b8abcadcb93..35f6dc97be6e 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map, caps);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> -				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " : "");
>> -			return -ENXIO;
>> -		}
>> -
>>   		dev_dbg(host, "Probing device registers...\n");
>>   		break;
>>   	default:
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 58f325019886..bec660357eec 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	struct cxl_register_map map;
>>   	struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>> +	u32 expected, found;
>>   	bool irq_avail;
>>   	u16 dvsec;
>>   
>> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>   
>> +	/* These are the mandatory capabilities for a Type3 device */
>> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
>> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
>> +
>> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
>> +			expected, found);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_await_media_ready(cxlds);
>>   	if (rc == 0)
>>   		cxlds->media_ready = true;
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 930b1b9c1d6a..4a57bf60403d 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   		     enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>> +			u32 *current_caps);
>>   #endif

