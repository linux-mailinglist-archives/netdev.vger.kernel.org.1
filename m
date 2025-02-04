Return-Path: <netdev+bounces-162506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE54A271DA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47AE18802CB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11A20C478;
	Tue,  4 Feb 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D9XWzs4K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A725A620;
	Tue,  4 Feb 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672278; cv=fail; b=Z+lJPBueyRZNJc81GVxbEuf2LVTxUNkBRkigq/q9r04VegLPtUgdPsIdKDuksWxpREfYCVoM1RRh7Uy9lLWA2HPkGfbMXsRwDKvIYKytBmzT0bdOH21+dquJ+S2heBCtQq1CUlbGTRgeIhXvbRxHAEI0b7llSZa46FQLrjFR7vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672278; c=relaxed/simple;
	bh=Fy2JKX4GKtw4yu4RLoEJmX2GHRLsU+WTintWg4DUWtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrZ5h9hrNUEnFPNLGMVgH5Sc2BmO2CnzUsm8lQeYMnU/+UbpUCvmeB/OAuyqoabNfA6JmwTzEBmFyyYZ9yGMfw2h9QuALFjrUgwRjCn5/seU9xxaa4dwwQUR/zr9yRfLKEHKr651pDZfmlWAQxKoiJY3z1X600KARNiGIi0x3U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D9XWzs4K; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQt8Ysw5bb7vz76ui86AkiypS3aasirr5x0KMZySwwAyWOUHdKtpQ6VYgxOvCu1bSzva30qTw+eMZuho7FbbcCekG7lCVbv/BuBoCtvpMq3tGXyxa0m8FOkaxCxlOKJ+13G5WjjxAQjY03A7KiS34a2ahZJ3fFPWLFrDme+6HZPjxSKuAdw5d3SxQaZXEy7YIhuSawFgZ0SPq2YUh6ClmBMpY35Zz4g4m25CcJFlVXGA6NrmfjsjEj1o6rwIg19cdcPian3HXtx1vS6iCuOZW0OqOX7P+j56LKVKOPHx/cJq3qXht4h/i82s9CSL+Sqqkjs468QrpZpb/xRmQD0yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNZDpgJF9EdgitXFEVFLyD0D3RjrAaj9uMOVnPJpOcY=;
 b=a4VeO1I60Gs/dcTF7iUBt0pO22uALhQfBAcJinc5RYkzV2aE6a16HtS6JGLNpYSSWOokCQTOXyyg4BhG0XQnPqi2CW3BIMVLZ2xuLHzD08q+w8jh5dMdnPlCxY3rhDy1n4TF+UFAW3hRI0fUN/S+IoY2Rf+3E0VpiGA76PNEXA/7tgn4ALOq57pjH01eI2/339vHYwziu0xfEQcsIGuhtUvGCYw3ktWvuOYSrYfkUl8CD8hssT7iDDItFNZp5qK1Cb3imZLL/d0n5HWPx3HC1PiJvA0KsrT3jR0c2Ls9WNmDTe/ZC+27YVGsFZnBri/Jtyg3OmNJ7KDdKYkoaOHB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNZDpgJF9EdgitXFEVFLyD0D3RjrAaj9uMOVnPJpOcY=;
 b=D9XWzs4KZMWPG8GbtTEB8y6yEXmduAe25QVczL6E69sQz/5PHDJiNv3IlxMipiyhoTgKWpYbqzXdZKMILRxuZQthHA5fe+Q0UfBCyqYzYDdntudkfBEsdPfAvIoB0V2LE2NCLIxw8GfFSSoqv+k5G9FKzu9PLzq17Js6PlYHZP31SXzZ3u8r3R9f4gbGh5QhSba+oPZSi8O+5GoOnv3J3P3HO11QKaQ1o/Z6u6XMVAAIZOp5jsK1qfVezcGSD4r7FjUh315mlsE9j/X7NMYYLVh8z2VdNjEgjAnNJCcRZBQP5hAu4gcoZDqIMKCAVjH9lm3Cds6ZatQ2oC0InRSgHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:31:13 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:31:13 +0000
Message-ID: <13711836-257c-4183-a3d3-5fd04a23411e@nvidia.com>
Date: Tue, 4 Feb 2025 14:31:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ethtool: Symmetric OR-XOR RSS hash
To: Edward Cree <ecree.xilinx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20250203150039.519301-1-gal@nvidia.com>
 <20250203150039.519301-2-gal@nvidia.com>
 <08135b32-c516-7f6b-f7a1-e5179840281c@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <08135b32-c516-7f6b-f7a1-e5179840281c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8a1738-e79e-4625-9e13-08dd4517cfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDVpRS9KUWMwM05hNVlLNnhLOXJDMHp5MXJJeHJOZDVQVWFLeXUyc0Zxemcr?=
 =?utf-8?B?eHgxTmFMcDRHK2taUDZiQjZhVm9IYVVaTVg2UHFRT25DbGFGNzdpSEszYjB2?=
 =?utf-8?B?Z0JtSUl4MjBDd0MweFp1WGhMcE12cTFuY1lrWWFHOE14TGt0eVVPb3ZTb0Ju?=
 =?utf-8?B?WW5qMzZ0QjV1UUNLQ2lQOENRTXQxUFFGZ2haMHRydEtoMzdWc3NSdkF4Vkpz?=
 =?utf-8?B?WGxyNi9YbU9GYlN6VEI4MzE3Zy9jN1dkalNOY3BPU3lEbWVpR000aHE2OGNP?=
 =?utf-8?B?Wm5jcFZJMm5TQUxNU2xNbzUxd1gzdzRFK0RjemtQUDZUVG1TSEIyNjRWSGV6?=
 =?utf-8?B?a2xwcjhQUE5mWW1aL1ZWRjRDckFwNjBXSFNpYjNMNlVVUDNtNnlXamlzSzFK?=
 =?utf-8?B?Rmp3Y0l3ZGdEaEtzNDJBR0V5MDEyeS9PeVRPQllZcXdUVlVudjNLRWhRQzM4?=
 =?utf-8?B?RklWMnVuWGtZelpqZkFXOFVLM2Zmb2ttOEJOU0M0RldJaTMwb0t6NDRxS3ZV?=
 =?utf-8?B?UVhocnJBMGRIR3VWQUlHYUQ3WFB3V1JaYlh0SzlrQVZNb0dKOWtWMTllTG53?=
 =?utf-8?B?cW9CWVB3enJwV2xyZ0lTYlpMdVFxdFVwKytpa2lYNFJWM2U3ODhFUXIvQnh6?=
 =?utf-8?B?VDcyaXlEanl5YnhGcmgrQ1pkamhDVFZ3MkE0YTJaUXcrTnZ4MTRIZndyN200?=
 =?utf-8?B?VklzQWk5VXR2emhSSmtlU1k2ODFCcmlpVXpna08xYXl5VUNtOTFPckhKMXdT?=
 =?utf-8?B?M0RHUmR6MjEwL0hxK25IS2RkK2RZd2tDVGJNOXlJRWNzQzRxSS85VjBZc2Yz?=
 =?utf-8?B?eno0cWM3ZkE2QStsekJuekFmVGZudDg0bnZESXoxYWlPbGd1enpIZ1ZiNUNL?=
 =?utf-8?B?bXpMTmQ0TkNuUE05OVMweWNIZ2VNL2t2amZaM0ZnU2p3T1AzM1ZnS2ZYando?=
 =?utf-8?B?Qjgya0x5OU1uUW43ZEhXd25LaDl3Tjk1dGJWd0RLd3ZaSVFEaEpMSzAybE1j?=
 =?utf-8?B?L1ZaVWJzVHBSc0ZVK2J4UjhMall6QlA0N0xGeWZuVHF0VFhPTmVRUmtzcGJa?=
 =?utf-8?B?OWRxSDYwVFJOcTFON2hLVm1iTjZTOUk3cFBERm55VFFVK05kajhYejc3d29B?=
 =?utf-8?B?WVJha0U5MjVWRlJqWEJObnV2WFMzM2ZGQU1MS2ovR2htY3JIbFN6NmJmbFlw?=
 =?utf-8?B?RDFxL1djU0htTU1DWTcyQWdKRC82OFFaRVJka0R0UXl0WGtLZWF6Y1NuZWRr?=
 =?utf-8?B?TTVHTWk4SzlGZW05UGF3Z3IrSlB2dCtvQWdMdmhWQXZoMEVMTHhrLzBDUGt5?=
 =?utf-8?B?UjdKTVprTmtBLzFLdStwSWVGbmdJa01taFczZ0UxeDBWdnZvTEhybmI2OWx1?=
 =?utf-8?B?NG02VjFCUDd4cmwzL2pjWkdLcXdvQkN0ODM3ZjJHenlhWGdYTzJaSWh4UWpB?=
 =?utf-8?B?MnBSaHZMYVF0V0xDdnlRQkd3UGZZUlg0RnBJYU1hNUdRT1g0Nno1eWV4bkdn?=
 =?utf-8?B?TjVZZVhrQzNxQkVzRXRXblNZYURjVmlaTGRGWGxKZUFxcnZLbFAwK3NIMkVU?=
 =?utf-8?B?bVpxcnpHYmhLSmUzNFpXSExtMncxUHpzTFA1RVBwbk4vbXNxait0Ykg3YWxy?=
 =?utf-8?B?RmhhNDQ3ZzlFeHBxVXJ1M3B1NGFPTy84NjVNTWlJTkZTRXhPWm9DRGVBRndo?=
 =?utf-8?B?TjdzNVlURlIxdE0vRDB3VEVnSis2MWtBRlRiZ1BhUzkzS2lBMGQyaS8zTnM1?=
 =?utf-8?B?b0VWRzNVTENoZ1ovdXpVSlFoMTRVTTlBbkF2WjVaU21wNlEwc1BjMkxBSllu?=
 =?utf-8?B?M2p4S0NMc01CWFRWZE1FT21NTUplY0gvd2JmU1VidzFxc1VmdzJUQUJvOUVx?=
 =?utf-8?Q?f2NXbAAEjYaSR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNkTVhLUTN4TzMya3NBM3FLVXE0VDZPRzE5NDRVZkxTeFFQYzZ5dGZ0UVZD?=
 =?utf-8?B?bDVtNGhBcTZreUE3V0RPOHFXQzAxc1ZNMTk0TUxlN1JjWWcwUWJuTmJkVmJN?=
 =?utf-8?B?Y0ZPRlA5Z01sV0tmMmZsQ1FKQ3VVU1R6MUJDWHBFUEJxZTcrZU41c3ErWXpt?=
 =?utf-8?B?SHR3MjhiOTEzUXVwOWFDemkrak9GU09yT2h6TEl0c1R5cXZqbjhEWG4xZ1Fz?=
 =?utf-8?B?SVYrcW1vTUJxUEZQZ0RLSUQ3bDNtbEF5ZXlsTzFqWFd3b0V0dURFd3huNVdS?=
 =?utf-8?B?ekI1WWJpUWxpODJudHJSNTlRNTdmYnNEVUFKalNqRmllUUhTTnJvdnMvRFBl?=
 =?utf-8?B?MytGUC91b0FVUUltZ2JxNlJUT2MxSVArVEc5ZnZyYUVIeENCMVFCUXRRSFFL?=
 =?utf-8?B?MUdBYWRKQmR4RmpJRE5CRVVmeVlwSkFZdlpBbFl3L01UWEhsMGtPaUVBbVVV?=
 =?utf-8?B?ZkVoZWFNR0NnZlNFUUxmYzFYZ2JwVmQ5Szk2ZzRidC9heXJIdEE5S1piY251?=
 =?utf-8?B?SmI1N1hmZHNMUitlQkNDaFhjYWdib2lGNjArRGRUWm1tRmpvZHhRcVpBb21l?=
 =?utf-8?B?ZytJTEVWc2k4NUJOc2R4UVRIR1VNamlrZEd2U0hYR0taeHFiNHpSSzg2MCsr?=
 =?utf-8?B?cnNKZmY3d25TZDFVZ2FnQ3NVTFhuTjdMNCtnemNDdGwxdWtyaFVMQ1NtY2I1?=
 =?utf-8?B?aEhuQXBsSEdWUTVDYXVxalcyVmxXQVFkUHNGZ2J6dloyeFJQVng0MlJnR2N5?=
 =?utf-8?B?SVY1UndhYW9kckg4ZlJQYnNNTVhWaDFDRlVjUzhRdGw4TWRoZ2duam5XYjU3?=
 =?utf-8?B?ZENrbms4bUx5bXM3akJzdHlVdTNHSkJUVkZpRUp3SHhSbC9TQWpDUE1CZSsy?=
 =?utf-8?B?TmRjNlM2Z3h1WkEyTFhZaUhUdnMwK1BnWnlSamIrZ0xxRGNNRitYdlRoenFu?=
 =?utf-8?B?eUNlN3BzYjhpZjhmN2VpM0dlOEg2aitYNFV6WndFaDBldGltZlZmb1FibG4r?=
 =?utf-8?B?TFkvNitaVkt4UWRPRllya0tCRXY4NmxHekZJZnJmTUhuTGJEajFvREpxK2pm?=
 =?utf-8?B?VEZGVXdsQVJwcElRVWtjbDhQRmU5dDJDTGZSN2Q0cXA0VzZSaUxjRDRVQ1Fs?=
 =?utf-8?B?bStuYWI3dEQ2VzdzYjZOR1BNaXlySXFTV0ludCt5eTZENzlCQVdvaE83OWtQ?=
 =?utf-8?B?aXp3QktUbkloUjB2YTEvNnVGa0x5eDJSTXluQk8zWVVMd013dzdob3JTTDF0?=
 =?utf-8?B?SEZsK3pwL05tcVN5MHM0bEJ1d3VkTmNRNkdGeVFObHByS2hONzFHNWVGYXc2?=
 =?utf-8?B?em4vWWt5dXRkNXpNc21OU0F6RmIxM0FJZE9OMnZNOWhHcjRJcUNaY25hMFRn?=
 =?utf-8?B?c3ZiUmxSQnZMN3R4cnNhN0RHSWlrL0xRM0lJcTNreGJ6ZGFxZjB6Y0ZwSGJa?=
 =?utf-8?B?T2dVRW9IVmt5amtFSTVHTDBIa2lxNi8yT1RLVEtVNFJlTndyaC9WdkppR1BZ?=
 =?utf-8?B?Nkd5WEZ2U2NtK1d1TUJ0ZW9adDJiTEZHNFBCRVB3S29iZktXTkxISzdrMjZr?=
 =?utf-8?B?Uy9MMDNGSmhEc3VNRVRQTy9vMjhyOXg3SnNBc3hGRFltLzBMU0svZ1dxell3?=
 =?utf-8?B?dUFqVEZwd2l1bUR4OUlYWnltSkFDR29SMGtheGN4YUpBZmJRMS91ZXdHdC9G?=
 =?utf-8?B?NHpqbGczbUdaSThIT1ZnbzV3RzlEY3FCMFhzZjcxckNtNGRZemtodGhOL2FH?=
 =?utf-8?B?V2tqcU44V2RGZ0RQVEkxY2N4eG82b2hWNXlBcW5TblFWTlVVR0FZbk1yNW5r?=
 =?utf-8?B?NC9rYytLLzdGdE40U1kxZ05wZmVnc2REZzdmWGg1UlFjUUpXblFsb0VYNldM?=
 =?utf-8?B?OWFkajlXS1lNZk9GbDc5U0tQSzZGVFBFcGdpeis4bzZ6a2E4OVhhdk1EMzJj?=
 =?utf-8?B?ZktOWE9ndWtjTkVKTXBOczU5dWhQbS9SYm1VSEgxZjR0c3pDOE9lUzlHNTJT?=
 =?utf-8?B?YUp3TVdoTHA4WlFiOFVaeHpzSC9tcll5VUdQQzh4amFsV1kyeDhtcjZpbjNl?=
 =?utf-8?B?WXk0eEgwL3R5cXFBdEYyeXFkSXp3OStnZW5weFJhb2svQ0cyZWl6ZWJITHZx?=
 =?utf-8?Q?ek9RR5rDm5Jg3zgTDnvvh0Vmm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8a1738-e79e-4625-9e13-08dd4517cfc9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:31:13.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba9U6k2HHHzx05zLI8FfHvOR+m1YUzH3XFkJxCUx+dgnquLidUzqyFnPDTaS4jFh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

On 03/02/2025 21:15, Edward Cree wrote:
> On 03/02/2025 15:00, Gal Pressman wrote:
>> Add an additional type of symmetric RSS hash type: OR-XOR.
>> The "Symmetric-OR-XOR" algorithm transforms the input as follows:
>>
>> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
>>
>> Change 'cap_rss_sym_xor_supported' to 'supported_input_xfrm', a bitmap
>> of supported RXH_XFRM_* types.
>>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>> ---
>>  Documentation/networking/ethtool-netlink.rst   |  2 +-
>>  Documentation/networking/scaling.rst           | 14 ++++++++++----
>>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
>>  drivers/net/ethernet/intel/ice/ice_ethtool.c   |  2 +-
>>  include/linux/ethtool.h                        |  5 ++---
>>  include/uapi/linux/ethtool.h                   |  7 ++++---
>>  net/ethtool/ioctl.c                            |  8 ++++----
>>  7 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
>> index 3770a2294509..aba83d97ff90 100644
>> --- a/Documentation/networking/ethtool-netlink.rst
>> +++ b/Documentation/networking/ethtool-netlink.rst
>> @@ -1934,7 +1934,7 @@ ETHTOOL_A_RSS_INDIR attribute returns RSS indirection table where each byte
>>  indicates queue number.
>>  ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
>>  transformation applied to the input protocol fields before given to the RSS
>> -hfunc. Current supported option is symmetric-xor.
>> +hfunc. Current supported option is symmetric-xor and symmetric-or-xor.
> 
> "options are"?

Yes.

> 
>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>> index d1089b88efc7..b10ecc503b26 100644
>> --- a/include/uapi/linux/ethtool.h
>> +++ b/include/uapi/linux/ethtool.h
>> @@ -2263,12 +2263,13 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>>  #define WOL_MODE_COUNT		8
>>  
>>  /* RSS hash function data
>> - * XOR the corresponding source and destination fields of each specified
>> - * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
>> - * calculation. Note that this XORing reduces the input set entropy and could
>> + * XOR/OR the corresponding source and destination fields of each specified
>> + * protocol. Both copies of the XOR/OR'ed fields are fed into the RSS and RXHASH
>> + * calculation. Note that this operation reduces the input set entropy and could
>>   * be exploited to reduce the RSS queue spread.
>>   */
>>  #define	RXH_XFRM_SYM_XOR	(1 << 0)
>> +#define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
>>  #define	RXH_XFRM_NO_CHANGE	0xff
> 
> I think this should be two separate comments, one on RXH_XFRM_SYM_XOR and
>  one on RXH_XFRM_SYM_OR_XOR, so that you can untangle the phrasing a bit.
> E.g. there isn't such a thing as "Both copies of the XOR/OR'ed fields"; one
>  has two copies of XOR and the other has a XOR and an OR.
> Second comment could be something like "Similar to SYM_XOR except that one
>  copy of the XOR'ed fields is replaced by an OR of the same fields."

Will change.

> 
> Apart from this, patch LGTM.

Thanks for the review!

