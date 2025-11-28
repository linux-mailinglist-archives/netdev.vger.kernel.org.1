Return-Path: <netdev+bounces-242501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC73C90E5C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 06:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B65F3A8442
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 05:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5224466C;
	Fri, 28 Nov 2025 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kV2G0d4C"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835653B1B3
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764309022; cv=fail; b=Tm9npkWDCV5q4QHjPBO7+odgwGfDz9tGCp4JXjjEZBtejghPM5dOgLfki62xF9GrzcoRYIlFl//4WDfxSgpybD2C5E3BU05gFmxRk1kKl2SDyzqF2gvISi3Tk/PbCBknVs7/2/fsNmi1CugFe+uiqInMecRMITZqaq1+PuvBxWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764309022; c=relaxed/simple;
	bh=KAtfMzoGXWBZF7JgjC4VG8PioFcXJBPs2333zq7ay08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFq+AbDtc7cE3CJrSXn4Zs+N+hCsUXk+WXqRxnLarRl2EZA9xMY/zXkOArzszy2ompCxGKavqxlk44HUcF7UVNXi0l2N4K0JJuq7yGGZ0UK0tJnwE1Xbhtj66SWqhCN43WiRzMwULud/UCqn/Ag2oF9383bmYmlL1kZz5G66UHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kV2G0d4C; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2tYIFcPbjmZyVxDLOmfyRDHXd+vPTEZn4S1YfKOUzxA9YjxTr6sDl2yRXKKP+XcBwQjaFqUz0i0AL9tn7YnxSlomgfot0GIqyaZtgCGZ7sW5F3j1shicVmsnxngfEyeL7JaUh/3lqxURprnZohIc2ttmzrGs2t32mz+aYLJAaWcjwZIA25MFBg25DYmJ0TtQZfZLO6L8Y/thyFIxklZYSySlNe7tiC4theZVTdWnOiErzJjQENE/8kcN/Kkbe5beEUUjT3JoOFDZKkSHRnDbacAuGryq1wMxKuQxxna/UAy0DG/DK91M0C43lr8q4eeTFBGvq0XpQu7wUftBhXz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3alaSvhgSE+O2jKiTvkgSnhAXmSMJHoJvWKUO2F2UnU=;
 b=ZWruT3ssyiUZK5kFr3t0JbNyU5eAQl0BL+w7uHpRNQavnIKjBAyBAto0fIV19uxsMHgx4ts/1HCwuRk8NNDHhUHIELGPevr62oMDjhiQIcouOfK13c3ATSFmUGjbK43G5w323dpz0h4PFokqxr4PiPhuC4dHd8wVeOZtQTMBp50M+SqMG8GGF8lG68x9as/uoTtetQRBmGTqm8ylxzAIWidDH9fAkPyoHlGVq6ypb2Uhn0HA9MmLAZSQgPW7zDk+HvGtM68rVvJxaEMOuRkzwCUe0XuwG/rSX5nran+5MI4msgAdq3wkmNQgjoG1sOjoQfSeDgyo4LV8qBFuFFNoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3alaSvhgSE+O2jKiTvkgSnhAXmSMJHoJvWKUO2F2UnU=;
 b=kV2G0d4CGPfW9f8UTYqyP/hq+SKf2N30ziqlv6h6GbvPfdHQzr5MmiunvopPDzz1c+DKNGaWDsBveKhjsonwBJ/2d20Tyi9M6q8AusOAHkF2hL/4rFAvLmwskwlhSuQP4qtAmqruZnzPr3HiPMleSZyljuxxPtHMqUwPooHH2Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 05:50:17 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 05:50:17 +0000
Message-ID: <f288dbe8-d897-4c12-a866-fd70f259ebe4@amd.com>
Date: Fri, 28 Nov 2025 11:20:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: schedule NAPI on Rx Buffer Unavailable
 to prevent RX stalls
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251124101111.1268731-1-Raju.Rangoju@amd.com>
 <20251126191342.6728250d@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20251126191342.6728250d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::17) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: a95f763f-1281-4305-4fa8-08de2e420224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTBLSkpHMlRuSU9yT2Vxemh3cFR0Q1ZpaGNRWGtaUFVGdFhCclZFcll2b3dW?=
 =?utf-8?B?Q3cwUVZ2UTBqQUlVbEFQVnphcFpRSFBpbm4xQ3lrZ2tpOVNYMGxPNHVsckZR?=
 =?utf-8?B?UWhiSThhRkZZeUZ6NUpVM29Lb2lpdGJEQjBFL1AvL040WHdON29oZVJpR1hj?=
 =?utf-8?B?Y1FrY0lBTkJ1WXI3Ui9YYlZHYlFDOHNLTGc4N3FUN0IyenF5TC9oKzBsT2Rw?=
 =?utf-8?B?ZXBTUmREZHFUdFlrMnluUTJkVDN1V1ZTbEZadTQ1MVhSVG1iQ1I2aS95TUx5?=
 =?utf-8?B?NGpDUEtWeUJ5OE4vaDVyNDM5TXJacWEwWDdmTHVqd3lyS1V0YmdZdndFNGc2?=
 =?utf-8?B?aWhCVHJJVk5UQnJPQVM3ZG1UOVdQUU1kcExDZW5wNG0yTnZpY1hPV3NFbCs3?=
 =?utf-8?B?TmFhRXZXMjJOTGxkOHI1N21wSG8zWjdxWWN4SmRLdkhUbkxxNHlFV1Y1aUVy?=
 =?utf-8?B?b1FUN2l2RGxJUU1DVERKRUxSdi9iZ0hOQ1dtYjMvM1JnUVZCN3IwUEtKdmdj?=
 =?utf-8?B?RUR4amd3S3ptaDJzWU83VUZTNExPN0VyMDVlck1WS0JVaENTc1Q2dGxXbWx3?=
 =?utf-8?B?U0MzMHBDVFN6SWZoaHdYekFGa1FjM0JRTzlJdXI0WDBhc2F1WlowWDRENk1j?=
 =?utf-8?B?NjVrOUVLdzRpRWZyZjRsd2ZMb3ZrMDJ6RU5EQStOUEpsblMyUU01WU5GSTZH?=
 =?utf-8?B?bER5amgyVk9Rb3FLTTVmaVVGL3VtZDVWMitBaVFmN0NJR2NZT2ErWW9UVzNB?=
 =?utf-8?B?aUNQc0lpaytjSHExRGpXT0M5UFp6amk1djI2cjU5MlArV29RbWl4VmRpekVt?=
 =?utf-8?B?OG51ZXVJeXFYNlRqOGN5TWF1Q1JQN002U290Nm9oYWdmNzQ5eGRKeFNqM0Zu?=
 =?utf-8?B?cDQ1S3JVZ0c0MGM4NU5HR2ZwN1g5ZlBzaWhuSFNpcjZZY0pzQkZUSm9BeXV6?=
 =?utf-8?B?ditBNm9GTmpYUC94MkNpY3FPVUh4ZzRWODZybkdMMzhPc1VKU01EcmpYYTIx?=
 =?utf-8?B?eXV0WGNZbkg5cURCZzVEdlFXYmNDVHJ1UDlpbUw2NUJYS0p4UVBKNW9TMnpP?=
 =?utf-8?B?Vy9VbloxUjhVVUFzMFp4K0VZS1dtdlVRZjU5UzIrWXU5V1dpQU01QXhMS2Jt?=
 =?utf-8?B?MFJhMWorZ1UrbHJOKzFuZGM2dWpCRmtnM2xiSUcyTmc3QjRrR1lpbUJNbllB?=
 =?utf-8?B?Ym5vczNxaExKa3R6Ym9kMnY0VFVsZnJIU2NMZ0t3R3VKa21tUllSRzh0RlJY?=
 =?utf-8?B?OFRSWWVGNFZ4di9ySldKRUlOWGxtMHZuWWxTRXI4aml1NGM0N3pNdzJyK3Y1?=
 =?utf-8?B?ZjhJdnVPUE15R05VZDRLbWk0blZZaVBkMlk4NDRKTnd4TStUL2w0Y1FUVndX?=
 =?utf-8?B?ZUw0YTZoOUx1cnFDYnlCRWRHUXlHTnZBZTBCZ2pobVZ4TU9KTkY3ODErWi9w?=
 =?utf-8?B?MEFzMThhY1FuNmlCWG9WNU8vTkc4eDVnbFJrd245WWxUcHd5OGN2aWd3RzQ4?=
 =?utf-8?B?ZUE1dmVJVGVrem9WVER5YVN2U3lzYmVSK0I3RUs3RTN4MTZGeVJQUERLN3FJ?=
 =?utf-8?B?aGVXOGQyaHhrTEZOckRDQkkxOG9kSDFGdG1hUlZpN2pQRWI5UTI3eHVaVWx1?=
 =?utf-8?B?Q2xKdEIyNFRTZlpJTW1XYU8vRFRML1ZKcDZ0V2s1UmlSNkhGY0pvT3lpZVdq?=
 =?utf-8?B?c3FkeU1vYWs2SElWQUJSczFHK0xiS3dUdTFOS0ZpZ3RKNGFqaHU5VCtVbGZy?=
 =?utf-8?B?VTU3YjBQaktzVUpyV2VWaklpUjNGQXQ1OFpxanNhL3RtWkxDZld6citMNDAx?=
 =?utf-8?B?RFBFNjBJUSs2YnNtOU9aN3RpTU9DZ2xCV1pmRC85Q3ZFN1RKNG5zMk03di9s?=
 =?utf-8?B?N0xiWjFtb1gvaVF5alhlM1pvQWZaQlNneFFTd2g0eXJ0bG94aWNIejI5VlhW?=
 =?utf-8?Q?DnucXa2mWq4ifHinBoPTJvjRWDjr1T0m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JhWC9XMEdIRXlvTFA4YU5oRUsveUtpbVJjNTJqR2tXZnpxU3NQM2R0SU03?=
 =?utf-8?B?UTd6NHdSeXBXb0ZUM3BCNFZmZS9hUnYyZWNtQkY4RjNWY0VYL3ArWE1zTmJi?=
 =?utf-8?B?L3NLN2xyajRLR0pOYUc2ejNjZGJickp3cldueWtVZ2V6YmdaSXJLUzhWN3lZ?=
 =?utf-8?B?d2praUZlWjNhd1JFbkx2Sy9yY2tudUJ4c1NmYnQ5U3Zib2JsZE5LZ21lOVpX?=
 =?utf-8?B?SkRGTWxxK2JUN3lZSnZSVkhoVDgxd0JPRFlnQnZoSXlvNnVwb21qTmxxM092?=
 =?utf-8?B?L0pvcFRBSHlVS0txZHhDU0plVkxSZzVMb2ZQSm9mTzhRNWdGWFdvdnpFMG1Y?=
 =?utf-8?B?TXVUaCttRzJIdUtGY0NNNFRoelg4L3Q4Q1FtYytqWVord0dLeDNjT3Q0S1NT?=
 =?utf-8?B?K0xndVE2dUhZeE9zbFRidDRJekJyMTNiWmU1V1hKSUxDNGdvdVhKcWNkdzQ0?=
 =?utf-8?B?MUZ5ZlRkNFpOT080V3hTZG9QMWhkemdPbFp5RFYwZU1CSDRiNW5JTEM0eHJW?=
 =?utf-8?B?UFhieDdEY1VpcGNJcHdRMWpOcE1veVRMVHFOdTFSOVhlSVNNVVJCdHhZWDA3?=
 =?utf-8?B?V0R5WFpnQU9hazJHN3hXVVdHZElOTTczM0FSTGNLTWloaUtYUHhSTjhvMnNk?=
 =?utf-8?B?dXZPckhTUzFGbW9lRVRlRmhjSkxaaFVWR2F5ZW1PeFQ4SXZsU3NybWdTVkdQ?=
 =?utf-8?B?NTkvNE94R0NWTnpMQnQwcmk2aU9DdXR2SjV4RklRTm1ZY20wMW9iTVZWSVVD?=
 =?utf-8?B?YzNzSURJS0JUeGtoZVE0OE50ZWtsSUdlbWFIOHZRcE5JS21UUThrdXBwQ1o0?=
 =?utf-8?B?MVcwSm5MMTN6dkVGa3c1dEJXZmdreW90SzVxWDBvam9RMjRZcjRJYVpTc0pS?=
 =?utf-8?B?RkhocDVUcUtWTjlzR1JzUUhOUmhjWm5TMExnSFRGeW91aDhGZTgzcU8yNE91?=
 =?utf-8?B?Skt4NTZEZHQvNUg1ZkpqZU9LT20zLzhOdE1SZE4vNU50bFc3cDMvUmRSUUlm?=
 =?utf-8?B?L05mMW5BMVh0NmV5QWFLdHFUTFh6bE8xeUYweEUvTTlvNUVsUlk2NElicFl0?=
 =?utf-8?B?dTNzTnBvRXJHUm04U2J0R1AzNG5ndStpaTZvQkpNU0lYc1QycEpsci8rWklv?=
 =?utf-8?B?d2c1NmVhOVRpQ1FxMFlYOGREa0hRbFZvZTI1MjVLLzVwTTBYQ3JENnZFQWJB?=
 =?utf-8?B?SHE0YTgrVGJ3RFNCcHAyeGIySVE0TmQ5V0hHRHF2d01XZWROMHEyS1NnT3R6?=
 =?utf-8?B?VkE4QnBIczNyWG9VQjAxL3RGdXI3VExTdUZqK0FyTjhpMEZmZGhCUm1kSkVP?=
 =?utf-8?B?ckxhSGJPNWZsZ2pkYUh6eTlaNFNGemUweGdJTmlUNHdqUnViSzIwSW4zam5K?=
 =?utf-8?B?MENpdC9lazJubkN2dVJYaUFhenBzZHBwbGtOcHJlMkd0eTJ4eVdKY29Eek5C?=
 =?utf-8?B?bFNkdkpGZnJhRVNLRnByTnVjdWdlWjZkYVlQZWhOalY0a2pzRGE0ajAvemM5?=
 =?utf-8?B?azlyQjFJU1pTTkJkVGthMnFocFF4QlhlaDl6bm05NTJVcmZ3S3JtdVVlaFp2?=
 =?utf-8?B?NHJ3bWpVVm9OSnc5c3Q1aytlOEo1TXZnNzFIM1I2bGEzNkptRWo3ZzF3Wkdy?=
 =?utf-8?B?N3lvdlprcXVoRUpzM1VzVWF5L2thcWw3b0pkWE51akN5VjlhQWtlaTQvRlM2?=
 =?utf-8?B?RXdYWklQSmZaSXl2ZHFqWnNOb1o3QzRYVlVVOFFlZDR2M01wZW1GK05qeTFB?=
 =?utf-8?B?dkdTeHpJTk9WcmIvVU5sK1VMYU5oY2dkSkFuelNvRW4zY2RFVTBWa2graTVU?=
 =?utf-8?B?T1VoYXFxazhObDVOaFRkSHhLSnN3M3lPdS8yOGt1aGxJVEYyY3lBdlV0L25U?=
 =?utf-8?B?VGtxb1p0MjRrTzdVdEtmR01CZWdGUWVQZFhOY1lVTmdvU3hXQm9wUHRKNk9y?=
 =?utf-8?B?N01zc0tCMjFPZHNxY1FPK2QrK3o3dE4rOTBXZGNOaDJQNVVHWTlxOVIxTmpP?=
 =?utf-8?B?ZytmV1FyU2s1dUNPNVJFNjdRTjdpZXZhbnJUaW1CVjdMSnhLeTVpUmkramVL?=
 =?utf-8?B?MWt4WE1vWnc2QU9seSsrb0l3ZG9oSE5qanBiNXJsVUNtL3RsTlRjUEM2a1d4?=
 =?utf-8?Q?CmIlBYvRdxxHppjJz7bdQM+Sx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f763f-1281-4305-4fa8-08de2e420224
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 05:50:17.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzLF/pBj8rR0WZvxwptrXY8aA5aMx7SLyjlBTRfeEBIXnPQTETE+HOjJ4DQzbILvLM0DNcMfMgkGjr0RDKzxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346



On 11/27/2025 8:43 AM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, 24 Nov 2025 15:41:11 +0530 Raju Rangoju wrote:
>> When Rx Buffer Unavailable (RBU) interrupt is asserted, the device can
>> stall under load and suffer prolonged receive starvation if polling is
>> not initiated. Treat RBU as a wakeup source and schedule the appropriate
>> NAPI instance (per-channel or global) to promptly recover from buffer
>> shortages and refill descriptors.
> 
> You need to say more.. Under heavy load network devices will routinely
> run out of Rx buffers, it's expected if Rx processing is slower than
> the network. What hw condition and scenario exactly are you describing
> here?

During the bi-directional traffic device is running out of RX buffers, 
it could be because of slower rx processing. HW notifies this via Rx 
Buffer Unavailable (RBU) interrupt. What is being described above is 
that, driver should treat RBU interrupt as source to trigger the NAPI 
poll immediately, rather than waiting for regular rx interrupts to 
process the rx buffers.

> 
>>                dma_ch_isr = XGMAC_DMA_IOREAD(channel, DMA_CH_SR);
>> +             /* Precompute flags once */
>> +             ti  = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, TI);
>> +             ri  = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RI);
>> +             rbu = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RBU);
>> +             fbe = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, FBE);
> 
> Please split this into two patches, one pure refactoring with no
> functional changes and second one changing RBU handling.

Sure, that makes sense.

> 
>> +             if (rbu) {
>> +                     schedule_napi = true;
>> +                     pdata->ext_stats.rx_buffer_unavailable++;
>> +                     netif_dbg(pdata, intr, pdata->netdev,
>> +                               "RBU on DMA_CH %u, scheduling %s NAPI\n",
>> +                               i, per_ch_irq ? "per-channel" : "global");
> 
> I guess it's just _dbg() but as a general rule when the system is under
> overload printing stuff (potentially over UART) is the last thing you
> should be doing. How is this print useful to you?

Wanted to let the user know about RBU. But this can be dropped to avoid 
additional load on the UART.

> --
> pw-bot: cr


