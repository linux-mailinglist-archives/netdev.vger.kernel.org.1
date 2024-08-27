Return-Path: <netdev+bounces-122539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE65961A07
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 00:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62D01F2462B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FD176AD8;
	Tue, 27 Aug 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUFhlk1C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81491552ED
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797953; cv=fail; b=DbLNCRqU31pYImQ8krlYqa+2KMJUp5uF5eERUClDRp/tHqc/8eUjjnwLfglRvQq+CWbnR3TjkMHrx/JiNL0iENqai4Fs5IElmsjTmtMTgypJUn36YobkAHl5/rAQIRmfUuvDSRMmKy9egRSRihTREt4KXM6D7NIha7XautuBjJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797953; c=relaxed/simple;
	bh=CGYkqUiPzmYuQhSayR5ZfxNOmr+wGltRv6Wep5510eI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lgkf+zPgSWiXKDr4s8sNotmp0o7/gjVkh6o0c7+kZG+udlq9F9Vy8GOWRXlRvUo/2mUMa5tIrZyieksT2KPM4Jvw6WpAcz6i9helxR4uuXhgNlD0CtnFP8fTf91yxoLuL5kd/gdqRJ1t6nq0nwoeQ4M2UXPQno5qMtTKgBq5qzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUFhlk1C; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvWu7CgRF9Gy6ZkRq2bNucQrLhlASQOcoprTVa92i4qkR2J+9frrDDkRWEdNZpKkKogeyh+6n4sdISComPcIyabbSc7AlgpAmb4zzzOh2C/f8sVteiM6V+qz2+U9xniOR99YLMGiCAI9DQGlYvGNjUGUWVzonG257JH3V8glI0PXDR+Ui3WRpj8FrOZnxdurIRBPhA7VRaMyl54i9jioYai0BOd12vJAaokBcAYI46DX/NNgfRmkWyZe3vYZD2AxVqTQZezm5KnPBuipKiLrZUBS0tGxckejaMMHVJ9BYJFQRf8GGY2VWUV1Q8ffVj+5R317OSA23FiDbEweYEPZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJpsx1W7SAcc+k/PkZ1mDo8Hwu1+ymmc94t1xfHemk8=;
 b=KV5Ni3wnjglVroKj2USGP42l9cEteS/KvAqJ82kCOmWae8LfRifaFBDdQpVNqH5gO+7PYaQn6atqwDyva1QsUlx2lkhObtr3fglKxfrgYnbrG0CoO+hgOyiSV29cv5GsPqqJcn8HQu+2cwgQdYhv2GLQolP0ZmFgWbu7o74BB3pehn8oTaM+WQuqGyYGTw178JCsbgCcD/I2Gk07codVMdAqnzmeIdVpPsi0kGSprPImsanXSCbnw0iOnQ+vWzJVkAQgDdnbPbnuyRhg54ecB21X5rlumZ1KR1HO+lcH84ZoNamnYjWcTM8Bsuk6cjtie1wBPgZk8CAkLuxZSddhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJpsx1W7SAcc+k/PkZ1mDo8Hwu1+ymmc94t1xfHemk8=;
 b=pUFhlk1CFHgWaAfBBDJkA6Bf5QF4EZRurKKErYD+/DG0SVI7s9LA/3AyCK7WVB1O4pd+PzS9vRuodtc8uwqOJlBRCWsVbIDqpBwXhXMCKB2ur/VJgi250qKIxtG2mfs72lcuawMmT3VarPT+adkWNO52xGvMYNo7+PMbES1Dtn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 22:32:29 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 22:32:29 +0000
Message-ID: <7b42df93-75d4-4c57-95e2-92404c8187e4@amd.com>
Date: Tue, 27 Aug 2024 15:32:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/5] ionic: always use rxq_info
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com
References: <20240826184422.21895-1-brett.creeley@amd.com>
 <20240826184422.21895-5-brett.creeley@amd.com>
 <Zs3BxMCNEeuBrooo@lzaremba-mobl.ger.corp.intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <Zs3BxMCNEeuBrooo@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f1f982-3bb2-4b8b-737e-08dcc6e82238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVZTYXZLUmlCOEZOMFF5ZkVLUDNCb2t0WjNxSXFEY3NJVzZhSHFQOGM3Vjhz?=
 =?utf-8?B?K0s5U2h3bUZZS0ZwMjVPWGt3UUdJdDFULytlUytmbHQ2THN2WU1kdFZZRlVh?=
 =?utf-8?B?K3BCNXo2RHdyQUVDeGs4b2piUFJNbXpHZ2V2RmFZeWxhOGVTYXVhaTNKUDdX?=
 =?utf-8?B?WnMvR1RQSTlUaWVOMEhMVk9hVmx6NVpGT2V0UlEvVVorUXRqVGtzdGY3ZkNX?=
 =?utf-8?B?UXJxd0VVU2dIV09nckZ2ZStzY2lUL0p4ZFgwUC9xbmlac3loQ2RsUC91Ui9G?=
 =?utf-8?B?dFZTMk1YU2VLN2doejE4cy9vTnBwZHRDWXpwaTRoSG1oRHd6MEF1UDRtVjlT?=
 =?utf-8?B?NmpuckUvN29SMktXMlNOU2FaaEw2TDdaMHcyd1VlMlJ4YllpZEswS25UUldR?=
 =?utf-8?B?YS84RTFsRnZsUkhVWlFmT1JOK2Q5TTRoT2RGeHFqZWpQNEdsdlJTQklrVFcr?=
 =?utf-8?B?aDdzSHluVXF5UjljK2hJQkU2bVlZYVZUTndrL2VjSXJPbzVVajVVT3g5WlMy?=
 =?utf-8?B?TTJyZElnT2lTYUhlZU1vbm5rQ0RpaW5iaGdiNXhJRGpzRTRub2dhR1dlV3Jr?=
 =?utf-8?B?ZDgwY2gycGVEbmxkV3BBb2l6dnF6bmlZUnh2ZXpPQ1pZdVVjWmNhNHkxbDc5?=
 =?utf-8?B?S080TG1UTnZTWFlOcmE0cXlmNU92Y0xDTU1kT2UvdzZJMTIycE0yb3FGSjdU?=
 =?utf-8?B?ZTJkOVZJVC94Z0Zyck1Fc1ZoZkw4aGdrQ0FDWWg5L0VWb0NjamVQeDBNc0da?=
 =?utf-8?B?T2N3SzFUK3FZbWNxd1FkM09pWmFXWnZGY1NaNDlTVXdyTnJsbmtHb3gxNkZo?=
 =?utf-8?B?RHQ0VUcyeVBBNTlEdzFDd2FxKy9uK01FUVpVbFFCL1RlYnc0Yk9hdyt1TXND?=
 =?utf-8?B?aXpybERMQjFCVy96blgxb05FSzhFNC81Z09FL3E4THp5QlByK24xTU1LRVFn?=
 =?utf-8?B?M2dBVmlkeThmRGNod0Y4ZldsMzhBa2RrSy91V1ZzTUFheDhtak9kOUFTbHVQ?=
 =?utf-8?B?ejdKMDI2Qkp0KzV6WkdsQUVSMUlBR0F4blpVcGZ0QUEzNm9IQWZBcEpTWlho?=
 =?utf-8?B?MTVRUTlacVlMcTVCTzJnNXMwSlAzSG10WXgvUG0xeitXbUVRR3VkbXZCeG5y?=
 =?utf-8?B?NTJHVGE4V2NUOEJzOFJuTFVlMDFGMG1hT3RkaG45NEp3dGxaRFlQRGFUbUE2?=
 =?utf-8?B?cVZISU9UM0QwZjNVN1ZxMnRCQ2syNVROVkhkbEFyZ0FXN0JmVWhYM21UakEz?=
 =?utf-8?B?QjVPaU1VZlpIZS9TNzR5c2xvR2gwMVBMTHJITkRkZ0Z5UFFBRTR6RUZqZUlk?=
 =?utf-8?B?b1ZXYmttNHBhV0dPdWxJWE9JMVhPV25MTHU5ZGZ6ME5SbWNvZTQ1SXp2Mzcr?=
 =?utf-8?B?QUhvZ1RXTllZNHB1Y21KcmhVZVNBMU1NZGpDQUlFUlU0TUdqNWdoQjhiaXYw?=
 =?utf-8?B?TG85ZXlGbHVKdEJSRFVOekVJa3g3VWR6TDdhc09QNVA1WjNWbzVWdUFSd01I?=
 =?utf-8?B?a1NFVlQwZStiNzFGYWlEQkQ2VUg3UDhVa1lPdUNhT2tIRnVBT05YUTlvTU9C?=
 =?utf-8?B?NStQZkV0M2NaSDRYRHd2Q2VKWnQ0YWhST0FLTE5hS3gxTnN6OXhkVmpCVzAv?=
 =?utf-8?B?NXlqTWFBaW5PeEZiQjNSOUx6MUp6b3NMOHQ5WE1NUzUyVVNkdTRaNXovUFQz?=
 =?utf-8?B?YjVqdXM2eXlMVmZrY1p3VlpWM1dBMVpJWnZNU0ZzYk1lbjhiVWc0QnVmT2Vi?=
 =?utf-8?B?VDVjNFBhR0hVNENSQlE5OW4zSEVYZnVtdWJ0VklwYnlrMTFZZitnbEV1eG1Z?=
 =?utf-8?B?SnFYTm1veHZwMDFpTE1JUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzdYOXYvYit6SlhZT28zUTVzQW9idnVzWlR0TnFoVUZ1bEU3VXNrblVzK2pB?=
 =?utf-8?B?TExWdit5WnN5VzhaUUZYNVZYWlIwVER3bU5nNmNnaE5NZ0ZYcWk2VmJZa1lM?=
 =?utf-8?B?TmRwczFIQmlZKzBVTEE1RVFPUVRJSStiblZ6dUpxYVdRdDhmY3lUWUQzUnV0?=
 =?utf-8?B?a0xKeVZJNXlxSm5tNjhEYTBCUTlhc1BRRkp4akJ4SkN5Ym9LbVRYaTVTZGVn?=
 =?utf-8?B?SXhnNFZRVERyczdEdXRhWk42QitIdkljUmNCSkVMbzFkemJISEtBS01rTm8z?=
 =?utf-8?B?ZUQ3K2NMTHFIYmdBK253OTdjbVV4aTlidm9sTGpoR3pUb3hPTHQ0ZE5qTWJr?=
 =?utf-8?B?REpPc3pnakRyNFNZTFZzeVJCU1lWeFJ5ZGF2ZmtWUVhZUy9VNUZlTjNNQUNi?=
 =?utf-8?B?VzJRNlM0MmxDR2xaQkxJTE5aM1FlSlF4bFB1MXdNd3hpSEpzN2laeS9XZ2dC?=
 =?utf-8?B?dHZ6bXAwc29OWm9UTGtDZ2hxU3ZpNXF4ZEVxU1grTUhDSnYyN0x3cDNHek9q?=
 =?utf-8?B?Nk1XZTVUSm0zcVljUEs0MDJycFRRTlZXaWhscXJkTDhJRURTU0l1VC90aEFm?=
 =?utf-8?B?OExCQ3lPNGNFbjVlUzVYcGx5RVowcFl6KzBZNUtOUVkrcFFrTTd3alBmcU5B?=
 =?utf-8?B?UUtkOXIvSlJPR1JLQVJ3bTBva1lONkI4Z2JlUzR1WEJGQzhkbld5L3gxbmtM?=
 =?utf-8?B?amlUbEVKMTRvRTNFdUgyNFhXdU5pRGJSdE0wT0pNM281RUdYK3o5cmQvYVZt?=
 =?utf-8?B?NU1GWHhQbGZ3dzZ6V3FiUVNtZlFrUWJZcVFua1pTVG95Z2QxMmNEdFE5eW9i?=
 =?utf-8?B?WjZGeUhQbmc3Z2t3UlJYTlFzQmVHOFhrQkg0aW1RM1BsR0dJM0c4dDFVd0FS?=
 =?utf-8?B?eGZUNVVhYXhOWURhU0F1QXAwWHdEdVovWDZHRHRnTUp5TjFuSENmNE10Q1F0?=
 =?utf-8?B?ZHM5RlN1U2diakhENDVZUU1xZVArRE1qaFUzUHZUaU96T0JqTkFhb2lJV3Mw?=
 =?utf-8?B?N3JGeXFWZXJsR1dYZGNxbTQyV0hNWjZlZW55TmNCcFdXQ21wR2U0R2VxVXlm?=
 =?utf-8?B?QVBhWnZLNk0wZElJcUxkWDlNcEV6UkY4eTlRYldrMFdCVTM1cm5KT0NoaDYr?=
 =?utf-8?B?aHIzem1CT0dPMjMwOFg2SFRUakZKcXNhd0IrZGlrV2NMRXpSV3NoWEhnWTNv?=
 =?utf-8?B?aDlucS9hNDgxQXlUeDJ6Mmg0bmwwbDBEZ3RHUzBqMjROeVhZUjVweFhsSkp5?=
 =?utf-8?B?MmlLZGxyTzVLQ1U4ZTJUazNSdmtrd21WRWNCWGp0WmdCeFhudDl6ZU1LS2F6?=
 =?utf-8?B?VUo3cGdhQU0vWkUrNGxJVkJYVnh6cVhOSzVKZEFwOW5OYkFXSmJweUg0Ylll?=
 =?utf-8?B?Zlp6U1hkaXdvaXc2bFFaT1p6czUvWVoxTmV3RHdzTFViYkk1RFNoanAyNWtH?=
 =?utf-8?B?dXNpakdveFREdGpxSGRUNHg0c2IwQjNwTW95VCtzZWYzMUlzZTVzdDFUTmU1?=
 =?utf-8?B?bFJzcHFORExiR2tIWnVmT1JIM3Jra1dVNmh4dVRHRkZha3NRK2ZIUS9hMFc1?=
 =?utf-8?B?c3REckdtSllhNmlMQ3p5MFQ4bUdRZmo4SW5sNk1lZ0dGUENQaFZvaVozODlu?=
 =?utf-8?B?RDNSMHpUMlNJbFJxaGZkQ01rL1VYcFZnSDBWNEQ1dEtvMm81TVpSYVNockJR?=
 =?utf-8?B?Y3NMdWZtWUdCMzdFSzRaNUlkOUp3bC96dDcyRnAxNkFqaHV5RXovcUhnc2E4?=
 =?utf-8?B?Nm9YWTVxYlNSS2JFdmdBWFZRWjg0b3l2QTNzWG1KaXRtYVNVQ0FQV0JKVUY4?=
 =?utf-8?B?YjhZTzlaSUxCSGZNeTVxU1pRNS81bEFUQjhQL1pxc1F2NGJIbFRMNUV4cG84?=
 =?utf-8?B?d3dMaDdoYmg2d2lkMWJtSWpuTmRvQ05WaWtZcHowazJQak16QnVEZmNYMFhX?=
 =?utf-8?B?aHZaTko2Wk5uRGZWNExZcjFvTmhRUC9UaEx1TWI1U3RYNDhWcWVQa0pPQXQ0?=
 =?utf-8?B?aTZManZuSklaQzQya2QwNVN0Y0JuVnhodEd0ZmpFQnIxeGVRejkxT1NDMFdK?=
 =?utf-8?B?eGZPRmRPdTlwNTRyZVdWZ2dhM2ozYmtzc3ZBUTYweVM4K3hKTm1CWnZIR0dX?=
 =?utf-8?Q?P2Pl4cGIT38i2PE6ZvPDQNa2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f1f982-3bb2-4b8b-737e-08dcc6e82238
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 22:32:28.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Vd/6Gc4TtT8PJsy4BKxmk7bpupi2k8HInvc2ZZ/pnMoVQT8PLzJhuALU4SUKHSi9kN3KRRLWvUBtwoFXRCXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070



On 8/27/2024 5:08 AM, Larysa Zaremba wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Aug 26, 2024 at 11:44:21AM -0700, Brett Creeley wrote:
>> From: Shannon Nelson <shannon.nelson@amd.com>
>>
>> Instead of setting up and tearing down the rxq_info only when the XDP
>> program is loaded or unloaded, we will build the rxq_info whether or not
>> XDP is in use.  This is the more common use pattern and better supports
>> future conversion to page_pool.  Since the rxq_info wants the napi_id
>> we re-order things slightly to tie this into the queue init and deinit
>> functions where we do the add and delete of napi.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>   .../net/ethernet/pensando/ionic/ionic_lif.c   | 55 +++++++------------
>>   1 file changed, 19 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c

<snip>

>> -static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
>> +static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
>>   {
>>        struct xdp_rxq_info *rxq_info;
>>        int err;
>> @@ -2698,45 +2699,27 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
>>        return err;
>>   }
>>
>> -static int ionic_xdp_queues_config(struct ionic_lif *lif)
>> +static void ionic_xdp_queues_config(struct ionic_lif *lif)
> 
> I think this function should also get a new name that would reflect the fact
> that it is just updating the XDP prog on rings. Also, ionic_xdp_queues_config
> sounds a little bit like configuring XDP_TX/xdp_xmit queues, but here we have rx
> queues only.

Yeah that makes sense. We can rename it to something closer to the 
function's contents/purpose.

Thanks,

Brett
> 
>>   {
>>        struct bpf_prog *xdp_prog;
>>        unsigned int i;
>> -     int err;
>>
>>        if (!lif->rxqcqs)
>> -             return 0;
>> +             return;
>>
>> -     /* There's no need to rework memory if not going to/from NULL program.  */
>> +     /* Nothing to do if not going to/from NULL program.  */
>>        xdp_prog = READ_ONCE(lif->xdp_prog);
>>        if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
>> -             return 0;
>> +             return;
>>
>>        for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
>>                struct ionic_queue *q = &lif->rxqcqs[i]->q;
>>
>> -             if (q->xdp_prog) {
>> -                     ionic_xdp_unregister_rxq_info(q);
>> +             if (q->xdp_prog)
>>                        q->xdp_prog = NULL;
>> -                     continue;
>> -             }
>> -
>> -             err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
>> -             if (err) {
>> -                     dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
>> -                             i, err);
>> -                     goto err_out;
>> -             }
>> -             q->xdp_prog = xdp_prog;
>> +             else
>> +                     q->xdp_prog = xdp_prog;
>>        }
>> -
>> -     return 0;
>> -
>> -err_out:
>> -     for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++)
>> -             ionic_xdp_unregister_rxq_info(&lif->rxqcqs[i]->q);
>> -
>> -     return err;
>>   }
>>
>>   static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
>> --
>> 2.17.1
>>
>>

