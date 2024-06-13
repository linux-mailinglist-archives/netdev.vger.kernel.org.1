Return-Path: <netdev+bounces-103390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D23907D84
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3791C238E8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251513B588;
	Thu, 13 Jun 2024 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dhlilfi6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E513B2B4
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311112; cv=fail; b=Sx7Zh+jO+6OnxZxPoUuxdDcPkDkRMziCHW29h0ChOOJHB/3SdvXf9qD0BuMLOxC3lbot1IajPSpyX/nHv7U4Y8HvD7k5w0IHqFLWm9cjFhL+s0Fe6sN7cHCa/d9o1n3RHCNj1fRpeG84NyT1SagoyPJIIzNWiQndY9QjaXt7CrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311112; c=relaxed/simple;
	bh=AAGwwhG4bkyM+M179AdhvSFV6PcW0T/TegzIaoxuEHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7BYCTfAXzAGq1bVl6sEFnbfDXzuymf38hseMG745s3hWDz7+EoRX4ZQ5bvCM/ltdVQPeCTfQdGVBq2yXvscJKdTxseU2NUadR6BNDKYQLiUGNQs3hv4JRkL3pfApfJobRMDRbYQMffG/sEY4A2x6v93ted+G+s+Tt/9Hw7tGlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dhlilfi6; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py/LWKCzgTycJjXTWoZwicGYnrdtvmmS+9twIIebJITdt0g39tGww9gF2lsRJPj/vpXWucBkD8v+Y2ps46zigdoMMCxfRwFNaBeYgch1gC14s5kutZlw0HRVzL+Y25w30YT+/xySslY+P23Yk/vmgEA971FZMocEZUBGhp8T0LgY3D9E4LOX7DTaJUoSLbASCVpPiSNuL0T5uAP0Js3slWMjGI3AI2CWnD8yy72DCAOSr4ZtMWtQH1ACSfWDefBkoH+VcsDAfYig7EDKLfAay9BsLLq7KhPE+ApHaH0fVcriXG5UZ0bka/SEHMjbQl07YtBghfH4Ipuum32Oj+yHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV98U/aBu82oxzmyRdIm649PdvafJ9wErustr7aDh4c=;
 b=aBkUv28Ryf8483rv02U/xZTn3HP4k3JzkYCsn6+cpT9r+X9IvMy9KL4pmZOeCZ/Yfx80GlhqtNVdiHf26LvmlDayrtsfLft0MaHdPFhYepIcQSofJAxzro+BvGvDjcpJOb6czbO7dpJBIGVh9WP5G1yGF7J03aNLRjp+AlOxoTA2w8wqplOlQKGQT2DSePaQKhIqQxA24I0cDGDJz7YjGbrpczWONhzvSJEyThLc04MFVNgf6x7kwfN4qt/yXvgTHj8fU3r9/9ZCbfWa194V8naFXZQwpTtGYQUlTdT2702jMqL2zO9spgxaVuL75JjhmtwbTt7nVA7qfUSCVjQ3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV98U/aBu82oxzmyRdIm649PdvafJ9wErustr7aDh4c=;
 b=Dhlilfi666pJy9EmWdSTDSI/WmN5tR7qUbYhpwBORW4EUvXV7Kq7ocfTAz5yqRXlkAtVe+f7tDLWPVvZ+tyy7iW5DsBir2oeLCZhSUJN0Gen2n9TOGH425X1DmE0NG1/LyhsxxYDdysVHiBFDelrWitKqEcyV1gCjh7sk9cWMIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Thu, 13 Jun 2024 20:38:25 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 20:38:25 +0000
Message-ID: <1533a043-56ef-4846-b61f-837312a90b3e@amd.com>
Date: Thu, 13 Jun 2024 13:38:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] ionic: add work item for missed-doorbell
 check
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-5-shannon.nelson@amd.com>
 <20240612181900.4d9d18d0@kernel.org>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240612181900.4d9d18d0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e0a9c0-b213-4aee-c6a3-08dc8be8c5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEdSbm5IS2JwK2hOek1Hb05UamNrRVFreUUvNERXeDBBMWlOd2o3bk1pRitp?=
 =?utf-8?B?M24rT0svdWVvb0d5S0c0cjRsNmNid2l4MXFtbWtUbVVMN3cweE9DUTdON3hm?=
 =?utf-8?B?ZUVFZ3ZJdTFtT1A3NVdYNXVXTEV2aWtDN1UzK0RGdTg3NEVWUmRvZ21yV0xU?=
 =?utf-8?B?OWk4Zk5tSlMxam1tQWtqRzdrcHJ1dEppUzJnaHBKYU9zaFdlVVBUaW80RFhS?=
 =?utf-8?B?anEyVVUwN05odklWdE1JeHZ3dVNWeHVGYW1RdDRWYTEzZ1dnc2hjQVdrSG9o?=
 =?utf-8?B?RERVVFdIbG1RdDVMb2IvN2wwM2NKZGswWHBIWjVRbzZJTkU3V1ZFUXJtRGZ3?=
 =?utf-8?B?WUVNakdrMGNnd1ZKbHQyWkRuL3lGSFhlTFNKcmhFK0szb3EvUGpad2hyQlRW?=
 =?utf-8?B?YkUzNEJUUWxHbGRlTzFEeWUvbVlmR1lWUVpZZGxsQTJzUzN6N09jOElQQk14?=
 =?utf-8?B?TjNxV1QwMS94OVhDeHVjcDBPdzNERWhSZVYrWHAwVFlSUzk2c1hUeW1Idkpp?=
 =?utf-8?B?YUFveEUyYTlGVndIOXE1bU15TUFTdzVobDVTNjNWcEh6QVBOYnlxSlJydHVw?=
 =?utf-8?B?Y1h0WWlsVjBqSlRWSXdRNVRZTzkxMWNZZEwvU283cjQ3YVp2aW9PL1BMTDB2?=
 =?utf-8?B?OUtKSjAzTnJNcG9uQU5kc2VMMXJ6SGR6SzFKdEd1TTFSTFlhQlBOeFBwUDJ6?=
 =?utf-8?B?N0FwWGJ6dTRpOEhDMGd3dHBSUUpWVEFqQ0s1REgvUFB6QVZUUWNIdmtBOE8x?=
 =?utf-8?B?dVFsdEs3VDR0eHR4VlpMeWFqNnlOVTAxcXRDZFNLWFRQSWtZMEM2V0h6T2dl?=
 =?utf-8?B?TytSTVpUTlltMW4reXA4YXN6OHM1a1lPeTRiSENoaFVROFREWUdkNk5rbzBV?=
 =?utf-8?B?SWFQdWNqTUljOHZtMHY4ek81NXZKaVp3VGt2U3IzNkN5ZHRyaHB4VkRQalhV?=
 =?utf-8?B?ZzV3SjVvYVlla2luZHRnbU1PeXVNOVF0RnNacXdXRlVMZ3FRb3Jla2FQK093?=
 =?utf-8?B?dGlNc25kRUFvWkxrblkxdmx1ZmRZdlZxekNRZFZQV28rTDJDSGxXYlN2cEF6?=
 =?utf-8?B?Wk9idkFuUmg4Q3FUUlF6VThmLytUbmFZa1hNUEN6UlEwVjUwaUJoVGRsOGtp?=
 =?utf-8?B?bEhDV1UzMElMZ0pRTlBnc01YVWNCWkMzc1IrZ2Z5a3puUVJqc0NxYUp0SlVs?=
 =?utf-8?B?dk9DbFZRN1NDemNVT3pWNW51ZEFVbHpjZEQ0YWVXVUZWbnd2TVBzT1lJU3lx?=
 =?utf-8?B?a1FJQU5LSkhqNURvKzJrNHlJSElpU3FZaFNLUmkwQUp0M2d4UjF1OUJNZjlr?=
 =?utf-8?B?ZWxqNm9tcWVYOERJcE5YZzZtTTJ2dEh5MlJwalFYMzlQRElzOHBjOStjeGt1?=
 =?utf-8?B?cFEwdUZYVko2NDJ1UE5xS1JMUmdXbUVURE0wTFBFY0NyeTVUWkxPbnVaZTZ0?=
 =?utf-8?B?S01iamZreFlQOEdhd21sR1h1RVZadWtIOS9XVzk3dVZ2YWdkQ2xzT3ZkdWVm?=
 =?utf-8?B?aHhnMkRTN2tSVTBXMWJudi80Z2lsVHdDYm5XMHo0V1FydW5BM1E4U0ZLMkNM?=
 =?utf-8?B?TTRMN2s5TTRGYXU3TGkrVGtOV3htQXBybzBvM3Rud3pKbklmODk3dU5oYU9w?=
 =?utf-8?B?Q0FoMHlIeWFMUERSeGNBcU5OL09GZ0dmbEFMelk5SWhQdG1leno4SFVYNHhE?=
 =?utf-8?B?MWh3ZWtNWmlnOUxIMHBaQlpyZ0V2NG1KeENVeDlUc3NReWlCMUVWSVYrNDYx?=
 =?utf-8?Q?cOs1qvxidchbd67RAozyEtS0Ao0L7SsQ+yXKHFo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajZTcFlSNGFLZ3pzaVhhUi8vdjJRVC9xbkNlSXNPNnUvaVV6aXZxTUFTSVc5?=
 =?utf-8?B?elUybU9nMFZUc0lpVGFkNWRlK2xRbkd2TVFLUXplY1ZPejVUSndkRnBXRm42?=
 =?utf-8?B?aTJDOTdTbFVGS2UyZnBKTnNGS3ExK2FZelU1UFFzMEU5MGpGb2pVMCs4c2F5?=
 =?utf-8?B?dDdtMndZUE01SUE0REEwUFg3U051QTNEWlFCV2RaVXN0S0tKb1pUWXllOWV2?=
 =?utf-8?B?SndYWFJaVlZhY1dQY0lyRTVxcGlKN2pNNXdEUGRMYTBHOExBNW1wUHF0OUNk?=
 =?utf-8?B?Zm05K29GQkpMTGpPNVpxMW9Cbm9STkdXWmkvbHEyQmVaQkJKT2ZlVnFCemtK?=
 =?utf-8?B?blRFdHJkVjNYWDdpZjF3NjBRSVpYNFU5WEdWM2VpVjJnYmVia25idktkbTk1?=
 =?utf-8?B?YWVwN3IwcGJkdVNLZTBwbzI3UVJaRDBuZHNtVys4dDAvcjZpbk16Um9PZEIr?=
 =?utf-8?B?NGFnMk9jRE9KN2oxWVduWGxnVG03eWRJUmhLTEZWeXpBNStsempwL24rZFI3?=
 =?utf-8?B?OWN5WE9ia0c5MzZXbHprbFIrOGllYnM3aGg3b0ZkZEgxZFdPWXN5KzNMYlgr?=
 =?utf-8?B?R2w5UkJta2JpT09WdHE2dEZSQlhpMzJLR0dmcG9nS1REZzhkUGJpeHBMQ0hC?=
 =?utf-8?B?bnh4ZEtDdEMzQ2s5N0xPaGw0ditLVnBPU24wNlFWVFEzQXBncWZQZ1NlZkl5?=
 =?utf-8?B?RGNFZ21wUkVJei9ZdGxUOG1HMWJsMFkvQlRTVXBaNUtEN2hnalJDbER0TnI0?=
 =?utf-8?B?eUtYY2VuWk10RHhLYzhJRTd5dVF0cUF0Zm42VkQrQUdGQjFDYk5zMmJVY3NE?=
 =?utf-8?B?WHlJS29iVjFySzF0SVF3VlBSeUU0ODhMbVZ4QjluZmxQMlRpSHNKSzFDUFY2?=
 =?utf-8?B?OFlsZGNWaTAxL2kybVA1aUFZUjFWTzNMc2tuNlQ5ZHhJSktXaFRqQkJ4MEpZ?=
 =?utf-8?B?TjdKY0tac0l2dHFJNVJEUmZCdUxMSDhEQ0Zvdm84Z2sycjBManByUHQwN2px?=
 =?utf-8?B?TWRyS0cwY3BTd2JNT0R3OWdPZHdCZnNUY1N0NThPem1IU0FBWnBxVHBLTGJ2?=
 =?utf-8?B?b0JyZUt5UFV1WjJ6eVdtR09zYUJNTGt0STVxdmJORUNrU2ZzdmNoMEduRlVt?=
 =?utf-8?B?MUJpZ3JzQjlKTXg3VGc4NnlWWU44Wjh4Q1VQMDJveTdsanRHalFiakZER25I?=
 =?utf-8?B?cTZiQjZ5OUkyTmloREpOL2FndTBTOWMwM0pJK3dmdVdHZ1p4cDE3UFFZbUxz?=
 =?utf-8?B?RmkxUWhobW1BNVVDTi83eGNYa0xnejdoaWFRNWFOVFBaOW5DVW1qSlA2cE9x?=
 =?utf-8?B?ME9FWExlazRNcHdJTEZCUnRMWGJ4eW5kUlJMRVdpb0EvSEhBdFQ5eThPcXZi?=
 =?utf-8?B?bjBrdWhqbkdsUEFFMzlJRjgxN3pOMmdVTTA4andGUVk3S01USEg1UVhlVmFt?=
 =?utf-8?B?TXMrS3ZCaHpHYlFQdys3U2pBQWlzazRpUXFQd3R6M3RPT05HRzB0TEtxNlM0?=
 =?utf-8?B?b3dzZys4ZkwwcnJ5UU1kWTlkRS9zckFIV1crUGVHeUJnVzBiZUlXL0p1aHNl?=
 =?utf-8?B?WHZjVGx1TmttNHpUTWFRM2syeXB4TnpBNzZObzd1Y3p3TVlic2RJcVNFSFda?=
 =?utf-8?B?a0JtVi8zdk1NTy9MSUkwMXhpWXlYZEtrcDJSQ0JTbWxqY2VCK3dEMXdlTCt1?=
 =?utf-8?B?MXZQcHFpTEdNdVFLczZWcGMwL1dwa1BPOSswSldrN3BEaElWRkVPNUpvbU51?=
 =?utf-8?B?RWpVK3ZTdG1ZUU5ES1RNdElVVk9iVk42UkFDVmc1NzIwRFU3M0QvV0Jzbk9R?=
 =?utf-8?B?U0czSE9URkd1YThzNWNVS0VOcnFKT3NXMktFY0pGN2N3b3dtOHdTMzVSMFJm?=
 =?utf-8?B?cVM1cnVudG9nb2pDM0lkek91YUFnWlBjRUc3VFZPRXNwem4rTW5hVGFpNFBz?=
 =?utf-8?B?c2FRN21VVUg2MlEyamNaVzdXV2ZoZndFK3BXYUFFb3ZsRkdGazhBeWtybkJ2?=
 =?utf-8?B?eG1RRGNtUzM3d29tU3J4OXlFRmdhSHMxSGE3c1A4Y2VXVXozdm5vaWU1Q2NN?=
 =?utf-8?B?RjVJRmRZc3M0aTQ0TzBUc1Fsb1dadUhVVEg3VEQrcEg0b2k1NVpoUVRya0Er?=
 =?utf-8?Q?0VH3OBuYiGyJx5XifpRtQLw6K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e0a9c0-b213-4aee-c6a3-08dc8be8c5f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 20:38:25.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XosYSedhyQ1uUe3t6+fH3a0UqQWj+yrAME3SNB1RxL5aJpXCPUw3PjnHXoI0PnZM/rqrzcMY/bV5PpOpb5U+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193



On 6/12/2024 6:19 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, 10 Jun 2024 16:07:02 -0700 Shannon Nelson wrote:
>> +static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
>> +{
>> +     if (napi_schedule_prep(napi)) {
>> +             local_bh_disable();
>> +             __napi_schedule(napi);
>> +             local_bh_enable();
> 
> No need to open code napi_schedule()
> 
>          local_bh_disable();
>          napi_schedule(napi);
>          local_bh_enable();
> 
> is a fairly well-established pattern

Sure, we can do that.

> 
>> +     }
>> +}
> 
>> +static void ionic_doorbell_check_dwork(struct work_struct *work)
>> +{
>> +     struct ionic *ionic = container_of(work, struct ionic,
>> +                                        doorbell_check_dwork.work);
>> +     struct ionic_lif *lif = ionic->lif;
>> +
>> +     if (test_bit(IONIC_LIF_F_FW_STOPPING, lif->state) ||
>> +         test_bit(IONIC_LIF_F_FW_RESET, lif->state))
>> +             return;
>> +
>> +     mutex_lock(&lif->queue_lock);
> 
> This will deadlock under very inopportune circumstances, no?
> 
> The best way of implementing periodic checks using a workqueue is to
> only cancel it sync from the .remove callback, before you free the
> netdev. Otherwise cancel it non-sync or don't cancel at all, and once
> it takes the lock double check the device is still actually running.

Hmmm... we'll dig a little more on this.

Thanks,
sln




