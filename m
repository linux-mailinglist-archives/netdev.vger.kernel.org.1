Return-Path: <netdev+bounces-129117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E897D8DC
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 19:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D73B284599
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670D17DFF1;
	Fri, 20 Sep 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rRPzyrfF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD1171D2
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852084; cv=fail; b=HGmydnpejFT6djvbS6swKAbojafG1Ui7G0D1piRRpt38Z6vvNCbRJDYxog3L/0iM2ykS/qmaKOseCuviNgZe588VbKytbMv2f+T/PFEje8alJWXLubAfA0jvv+jVVXnalYZvr5SabRZZIcGe17HsvikjIX6G1DlHBSPGffca8mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852084; c=relaxed/simple;
	bh=HwkwgyizqQJiHtzl+EVqOcc8dW5xTCUlOU+FgoJ+BnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekw5UBmQB0cGULgiqFZ3ZleQxV5iqrXAr+YDTXhqQ8MxWEQlgCd102ATGyMya4xk7KGU3+lEIwoiRjZ9jOoaj8bZv+PfBkugIg/iee3/LjBw9pz/77j6GfnQEQFQDZKJsyI/zY9h+h828f1NNXAaRJT1lTefttpt1SAg+Ce0rkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rRPzyrfF; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3g9NDbmPbw3f98vQANoVR6aYdStiJti2GeBsYCB6TmNoFEzIMugYIgCVw/vh9xWYgEJiSbJyfrB5eWWiucdOzY5wLzxBjVw9muB+0k7Gb6jfzmQtP2cBYtta3YLzkJisyqHPzj9+EMHw04W6tSwShpnJ0z9SizGPGo7hpuj+0ylxkgpzIb+KiN1vSX8jahbXGpPKpNwLZF0vmWNK5gFzFUKgmcq2Q4l6nEOBB5WMl4zXW3BXetjeReWV8gR9FtBBp4CnpufcljiOCP+58JDiBSEVJBilLC3uC1nIhza7yHzTuDOlNFrmDa3bzw/3z85mYOjk5UGOAhzsh1WHBzpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETcL3EvVT8AsT+w5+MoFYd7rZhbJ0A0MKX6l0a+f1LM=;
 b=ue5MQYbMvFzq1yVZ7B15mYeYYW1Uek3GUK9PNu7Lczp3Ubi3HhuYxU/A3/O/RVs4HtbmgAAbGU6Ke4otBj4DxuOI4uef0OX5ONR9ClomDcYPVjHTPKWExlEauK7WG10x6aiWXIAqQSu6VfmGhYmiNPdga0SmZmsqXLp0ag3VezjTFu3Hr7EV99AAiojC4qryHozAR4hB/C9eExvyqMJSoClWcvEW6kHZOzSxSVaEl18i+4suUcNQLA2l2n9FLwwEYfm15Bct1t0AyQcKwKoUpKoG191pvHbwLiiVVpHr8jAut5X9Gbla0FnUc17xRWrt4i4RTEiMEp3/0VrrYgMKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETcL3EvVT8AsT+w5+MoFYd7rZhbJ0A0MKX6l0a+f1LM=;
 b=rRPzyrfF1eId0+/VRy6Yj8+8RG5iGGl3k6dPlSOonibbc+NNxQo0D0Mvim/YoLk9KPx8M1R7NNjh/gzrHj9RaJerffzjlGxn+0R4uidLn+BUM5HblFcap6MwJpltocqz295Q+AXq+m7dH1l4W660Kc7VQfSNFIkhk8DEORmoNGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 17:07:59 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 17:07:59 +0000
Message-ID: <6523231f-0500-44f2-a6be-6020cec5e83c@amd.com>
Date: Fri, 20 Sep 2024 10:07:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] ice: Fix entering Safe Mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 mateusz.polchlopek@intel.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240920115508.3168-3-marcin.szycik@linux.intel.com>
 <Zu1kelo0Wd20pyjf@boxer>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <Zu1kelo0Wd20pyjf@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f62cc7-cdfd-4395-ecbb-08dcd996c76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmMxOTB0MkpMMHlORjFyZkxMdThRc2ZUSmRnakhEdVE3VjhCVzE2Tlh3VC9T?=
 =?utf-8?B?QStvaW9aaFNHTDRYZFg5NGY2bEJ2YlY4c1pSVnh6SG9jSGZBMGcyVWtSVW9W?=
 =?utf-8?B?U0lIRkxKeXYwNTFyOGxWNys5SCtWWXUxVmI2b2VaZlJqQXRReHlKN1FRUEpN?=
 =?utf-8?B?aDhuVGlEbzVnTTlIM25xQ3pHRkdCeDB2bnJkdzB4dE5nejVUdlNZaVFnWE80?=
 =?utf-8?B?dTFxdzEybTR3aXlqbnpQUHhKSHFaMnpLSjF3MjQwbzNHWjZMc2FDc2hmWGw4?=
 =?utf-8?B?WFpwZGZ6Qnp3RE50QWxpc2tESCtoaHlPalNueWU4U3kwSGNwMGdKYXI2T3dt?=
 =?utf-8?B?eGFyRytqNzdSeHRyZzA0K1BJL3ZhV3lFU3V3VktrME5zYjJSTGMyUDV5MnlD?=
 =?utf-8?B?NTNyOU5kSFBxalI5cTdPelAvYm1IcnRLeXBpelFYcUlBcEtUL3Irem9nOG9S?=
 =?utf-8?B?R1NYZDV0TjZZZVhxcXFOVHF1ZW9pT0lIdERzaUcvNE0vNzRXNVAzc25aVEph?=
 =?utf-8?B?QnAvcW14a0w1UllLQ09HUVdTN0VKYkM2QzhxY2hvQlM1L1ltdXlaamQyNjRj?=
 =?utf-8?B?bWoxSTV4QUxpZXdzOVpWbGNhQ25MMW5JakV0ZzlXeE5IeTBwckJhaHZ4WFlp?=
 =?utf-8?B?dG9YbzhnTlZVdTRHUS9RWlRpSm1RUEZ0T1pJVno0emMxMFlDbklQQTZOTzVl?=
 =?utf-8?B?dWt2VkxjSlVSd3hWQWFSb1NIVXI2S1I3NDhmL2tGdmtTcUpKaW5PK1hZMDlz?=
 =?utf-8?B?YkZKMElqYTBLUjlHakJqdnU2SVhOVXVKN0d1ZGE5dWpSNDhrZDBYZnlvYnlP?=
 =?utf-8?B?TEsxL3oybFlLZHU5Y1RLS09Xend5KzlWNmxxVTk4dFdYY1loOEs1anRFSlJq?=
 =?utf-8?B?bXBFbWRLYVdqR2crSi81T2VCUEExZktXTE5FM0lyOWk4N08rZFRmWVhmbGQw?=
 =?utf-8?B?KytTdlA4Y29ZUmFHN3prWXN6TE5nMjNIMURJMjVMZVBJVDFsTzY2dldGZFdG?=
 =?utf-8?B?TTl6aktyUGV1QlZsUTN3ck1SSTZxSW1KeDBrOFJCRndqSmVpbGJ4cTFvcWJt?=
 =?utf-8?B?TDl3Y3cxbitmbVpsS2tTYUozRG9zVEFGOWJRYjgwRkJ1OVZMc1JLM0xsOThC?=
 =?utf-8?B?OTlpMndFOFFHN0k2clJGR3A5aVhETUw0NnpFWmp1bVkzQ3B6Zys0ZzlnaEor?=
 =?utf-8?B?a05XTTBBb2JCUTluSXREWmNmOWUzYVV5cVpJYjg5eXFJYWdKNEtBT2pDV1pU?=
 =?utf-8?B?WGdjVWZvaWlybStZdWMvOVBnSGw3alBieW4vcUg2RlZWS3lrMk1zaXRlM3ll?=
 =?utf-8?B?cUFjYkpoNlZ1M3FEWWNqdFZpaUtpdmNYK3RlRUkrU0h0bHpKejdQVkFzNmR6?=
 =?utf-8?B?Q2EyYjBDRitybkE3aXRvUEhqMENIUXNudXpaTVdRVlBtYUdUbmYzNE94SE93?=
 =?utf-8?B?MlhmWXN6cGwwb0o4VktwQW5mU3AxTUVRbkl1UUl2blRCa05hSFRjcFRrZ21R?=
 =?utf-8?B?RkszOFFiSTNOS2FkOXNIelhpNHRaYTVpOUY0U0kyR1JiRXpuK1czcE1QQnhz?=
 =?utf-8?B?NFhZaVNmY0d3ZTgzaDdQdXZmVVBFSHE1R2NFcTlnYzlEYmEzSEJGTEdpN1E0?=
 =?utf-8?B?NTFPdmRrdlBkL3hNWVhvb3h5U1lIL2Fwb0RoRzlqUmx1L3k3WVVYeW5UNHlL?=
 =?utf-8?B?WUs0b3JzRUFLUUFnR0JFSXZCRmgvY2xPYTZoR0k0dTFpT3dod3NPc0R4bXFE?=
 =?utf-8?B?MjA1RUQyZG52b29ESmRlZXpiUktYT1R5ZHJkVGJoVlN5SWIxbFUrVm1Ud0di?=
 =?utf-8?B?QnRwaVFNeFh4VWxjRXQ4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnlMN0Z6R0E5NU9nb2gxU01QOGt1U1E5Mkc4T0t3SlBSbXpIb1NyQmQ2RkpC?=
 =?utf-8?B?Ymd3T2VkYzN2ZFpvRmJpMUhtUmJFNDliREF4SG9TdFJUTXFOMFZRVWQvOFFv?=
 =?utf-8?B?bmsvU0c4UjBHYkh6Q25XNWowcFh2VVl3bFd1VGdpM2RvN0lkMWtuV2Ewc3VY?=
 =?utf-8?B?YS9uN2VndGFjeUs5YnFuYWY0QzUvcVZvbCtSVzEzWXR6RitEVlAwZnVmY3ZZ?=
 =?utf-8?B?Rlp3WWtUcytVdW4xc1Jwd3czWkljMGhkaE9yN2o1Wmx2Y25jQVJNWldIbGlu?=
 =?utf-8?B?MnJuNWQwbFA4WklzZm1zbzArSnVpblNlQ2gva3JTNk1zd0pNNFhmS0dxa3Bo?=
 =?utf-8?B?TVF3cHdBTHlvd0gvSFFuWWFkVzdFOS9yUThPandPUFJHRytJSjBkU1ZaZ0dP?=
 =?utf-8?B?UEYvTTRQR1hHL0U5UTJyZ2QzYWpCQ29qNVlzQmg5ODZBSjZvamh6bUZjSzBl?=
 =?utf-8?B?VkRzbDRpWTFOWkpENDRBYjN1MFl0N0FBS3JmMUY4b21zSUp0aWQ3VFJ0QzRm?=
 =?utf-8?B?ei95UXpYQ1pHZUFTek5iOE05U2l5R3pvT3dnbEdIQ2lqMlBkelhvMWNMcnJ2?=
 =?utf-8?B?d2prbytiemN2ZWhXQjVaUURwZ0tuTFVXWUNORzhDT3pZOFZXbnBpMEQybDN1?=
 =?utf-8?B?ZjlmSmVUemdxaFdkNnZCS1hvbFBILzNoczA5K1FkNTZLc0JJUTBHWDNmQTQ3?=
 =?utf-8?B?cTdvMUkrTTFNYVRMcVk4MHMvOGhKa0dXYUNxMmVzbmYrRFZ5NTF2TVhsT3lE?=
 =?utf-8?B?d0wzVFBxakNxOW1OU3lBamNNK0NtWTFMQVhCUUJhbU9vdS9KbUFScWFSM1o0?=
 =?utf-8?B?cWp4QzczM1h3elhnTGpJdndHK3ZNNTR6N093UlFYSURGQnZBY0xzeFEzd3NJ?=
 =?utf-8?B?dUM4M0xTdWtiSnZFdjBFcHNUUDJEelE3V09WWk02d3I2bWpPRGxEWnVOVTlT?=
 =?utf-8?B?TGRiQk4rK3M1YzI2dDBiSXJ3cTB6b0IyUFpWbkdLbUtKVG4rMnNReWRscFQ0?=
 =?utf-8?B?a1dHVm1iOWNnRHlFcWVrWGJKdmc1bEpJM2dTWlNlNHZOMTVWZWVVUGptQjk2?=
 =?utf-8?B?RUdSYURLZDEvaFcxdzJ6ZWlUbmkzRVloNWxiUkgzbVJhRHRSUlNncE11NUdY?=
 =?utf-8?B?bGlyNGVsemZNeWxCM3I2VmVLMWVOMXIwU0RRWSsxVVVuNk9CU25LZU95ajdl?=
 =?utf-8?B?ZDlIQXk4MnBUMnM1QXg5Ym9CRnh3eVZRVElVNS92NGl3L0dSRVVIODdXa2Yy?=
 =?utf-8?B?UGt2Z3hSU2V5WVFTWWRDa2grMlc4eW1GdVlrK29YYXlMa3BiMXJTU0tza3la?=
 =?utf-8?B?UzJVd2lMRDJ4K2pQVWVCdmRVZFhpTTdreTVQNVdnQWVpYW85TkZUaXlTRldr?=
 =?utf-8?B?Qk1hU2QvUDRtbzhxMktPNVpZNWZsS2tvNFdzZFdIcm5rUmlPSlozL0VieGFn?=
 =?utf-8?B?RkF6Ry9FRXA1M2lSQnZnbWQ2ZFo0Nmh4V2MyZEhBN0c5aWd4RTNVZjhCYlpS?=
 =?utf-8?B?c2hDYTFYRTlCQkdSTHdjU0hxK2p1dVlJZXBZQkhRZUFuL2JxZXhhSDNFL3V0?=
 =?utf-8?B?ZzRPUXNHRTdTQTk2SVhxcStqRVRTWEVYdEpFT3R3WjFrUjFYSXRqNnljSEcx?=
 =?utf-8?B?aEt5UTdqU213K2VDOTdmMExhNzlsaTJzeGVlMnQzQ3pUTEdldE1taVZBL1k1?=
 =?utf-8?B?aG1aR1pTQVpMd1A0KzBxWC8zNWlRZU8rd2wvdUlEamtHMzFvTy9qc1plcmZF?=
 =?utf-8?B?WG5uV1g3ME5rUm12bHZNYWFuaVNJa0NLRmtMN3pyaUcwNGtaRzFkanZVUlRw?=
 =?utf-8?B?TEorWDhMa3ljMHJNTHBDM2N4aHl3dXNlMlh5eC93OGhJWnBDWHcxdC92WTZy?=
 =?utf-8?B?NUVXZ2RyVVUrQkdGTDJnb0JsV3RNb0lvclF6R1lab2Rkb3NKMmMzeFdiNHll?=
 =?utf-8?B?K1dpTVFZWHR0Wk5VSzFLZi9uTEtlOUVid0xCK1V3MkJIcFFtZEVRT21Dc2d4?=
 =?utf-8?B?RmxyazhodjRJOXdJd0xGb29sL3FEYWRSbTFjaUhJdjNrRlhMazRkTGVleHJu?=
 =?utf-8?B?RmVoQ1F5ZDJ4VUh0aC9zYjJYa1o2OFIva1lrSVZDZDFLZDBNWGpRMWRIeXRG?=
 =?utf-8?Q?AmcCU/Sg9W0gQ62cCXEbgzwHo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f62cc7-cdfd-4395-ecbb-08dcd996c76d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 17:07:59.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67wYituN8PIw32/Zls0pXUg8SLFQJ54a+hYcyOorkSBG1tMnVtGM8SHLZ5hvE6bS6UpF8T6ET/W3bdX1XsWfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342



On 9/20/2024 5:03 AM, Maciej Fijalkowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, Sep 20, 2024 at 01:55:09PM +0200, Marcin Szycik wrote:
>> If DDP package is missing or corrupted, the driver should enter Safe Mode.
>> Instead, an error is returned and probe fails.
>>
>> Don't check return value of ice_init_ddp_config() to fix this.
> 
> no one else checks the retval after your fix so adjust it to return void.
> 
>>
>> Repro:
>> * Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
>> * Load ice
>>
>> Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 0f5c9d347806..7b6725d652e1 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -4748,9 +4748,7 @@ int ice_init_dev(struct ice_pf *pf)
>>
>>        ice_init_feature_support(pf);
>>
>> -     err = ice_init_ddp_config(hw, pf);
>> -     if (err)
>> -             return err;
>> +     ice_init_ddp_config(hw, pf);

As an alternative solution you could potentially do the following, which 
would make the flow more readable:

err = ice_init_ddp_config(hw, pf);
if (err || ice_is_safe_mode(pf))
	ice_set_safe_mode_caps(hw);

Also, should there be some sort of messaging if the device goes into 
safe mode? I wonder if a dev_dbg() would be better than nothing.

>>
>>        /* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
>>         * set in pf->state, which will cause ice_is_safe_mode to return >> --
>> 2.45.0
>>
>>
> 

