Return-Path: <netdev+bounces-204557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B052AFB24F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71BD1AA122A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE27202C45;
	Mon,  7 Jul 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="quy+94tu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8321FF36;
	Mon,  7 Jul 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887928; cv=fail; b=tAvRj0ZFj7N/8vFmUe3an7mcaow7iELuzZpvC3XRXPknfSNvfIAS0KOM4BEKI8C4kpvul2FYpQKuK3k2SRshE716DdKJcR4u5xMWyIG+7ZSxfjQ3bOV/qWrA4e3h6fb5GjQ+wkKFJw6bZToTNeXeRNkAVX/mxMX67XSfxg6ghHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887928; c=relaxed/simple;
	bh=rud/QC3WGsO8cQpTml4oK+l5UdOM9RDs8S1ak9LXh/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTqlAIrhMjhDWsDEAkwfSskTYlkT0cNrABmuGScz6ft1+/fvWUynh758eRxGXPMaucxr8orTKZ6K+ifq1h07/s+ilDYbExuk87wReViW5PNgBbIjyD31gMXj4RAsDSEIV3rgwjeM+plCm80If1Hn4KlyBYlQisy5kGmf7jSl7AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=quy+94tu; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP8tMrtnao56zXj5gzbpIYpXr/Zcy8p4qDeOuwy+HKlAYu+HqoQiICioU9tRATdu6sGu1XLZWAVQbmBlHXWcEKwxPp+YSRdeOm7WEM5iKTwoO5ZqIVEKG7phpq0zMM95orDXecm7r7lWFf4glegIQMp+kszgLB2TdWrpPrqsVkWEWkQwb0Bnare7cyAbuxKNS73Hxpi+6iVVJztykCkPBQ93V7ZKFnbwspyvp6rDh2Z+vAAeqZUHzH4IFF2d8HhxCRhc4bzteLb/a04U+ssrCUZd5JDftce7zx/Y4k5+FDbWwJnoqpdyQSGb97TLX/LzaZpGRfAS5amsaj5n7oFiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF15IEqDptEyEMUq0qPd3HmZHMUI7GgfUk/Ek3HP0pQ=;
 b=yor/hEnpKWDWdaTkRJE37m4x+TupL80VL/tHAhOI1ND4mZFeGhTD5z1pkEgcHQIJjo3C+D7kmg8jmULqrh1GIhtrPVyG4+FGc4w7Ee6KAcPSa/0Uxbmwb+8YN55iF1h0othKbsnRfu2piJUJpDCODH7MjWv+mDBYtvr35sOWT2GP06kEcUNCaJOe60E3QINJ6xuh0GemSbdOmZs9/Nxe9TjKaCIl6oUAwu4JjWp0nJojljR/EDIM4AoWVIcZZpp0ojFy+YGwDGku05UP4LwY9WMnIvQW9J6doidCdfzE5tcswgm9/nGnwwfy5NYlYb053v+9MjQTLQjCdbKzH6EKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF15IEqDptEyEMUq0qPd3HmZHMUI7GgfUk/Ek3HP0pQ=;
 b=quy+94tu+pTHSzC++sLt/lbXgCaVOUXto09AJYrFGDPybzm6EcQ54IIj/VUP+okoLzp90yhtuowjvYBUKpEmuS0V+PMUUZ1qvUTJsFJDwm7MZ5UbGuN7/tdJy1MoSVz33d9p+uVC1bj1AfNmJbOfI6y5vcEHgSXnUZgC+sVsbp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 11:32:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 11:32:02 +0000
Message-ID: <e60819d6-3ba3-4a6e-a7d2-b014ee51994b@amd.com>
Date: Mon, 7 Jul 2025 12:31:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-19-alejandro.lucero-palau@amd.com>
 <20250627103223.00007e43@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627103223.00007e43@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:10:234::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 672bfc27-5596-4889-8725-08ddbd49e4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEs0Ynh4VFZOWWUxNjR3emR2WXlUOHptOGZxVHFoTkh5NkZRUWhwRjVyRTZN?=
 =?utf-8?B?VjhVUUo5ZTlUMGNkMHNVOXhLS1FGbklZWFZwSGYrZG5zSDNnbE1UYUVIdWhI?=
 =?utf-8?B?eUlJaUNVb0FvdkNSc0JKWEtjMkxVN0V5RS9BalppRTZxZXZPZFgrNnljZ2Vr?=
 =?utf-8?B?VzdkUHBHZmd6dW8rZWI0T3dLTFZHZGxoS2Y4d0tKRDVtYzhYcVNlVXVEMUtR?=
 =?utf-8?B?SC9najBqWXZjSDNPYUtKNm9YTjQreHlORkIxZlV5VkV1dkhoZ091MWlxcDJv?=
 =?utf-8?B?Wks2V3VjdmFzdm9nRHlBU3pTNVN5dVBNZ256M09Ub2Jsd2lmQ0pRMlB2Z3JS?=
 =?utf-8?B?Mnd3LzNacy9GWkFxZUJVQUUvT0I5bFU3Z0pjbHdNQm81dS94RTFrQS9wN0Mv?=
 =?utf-8?B?eVFsSkxvbUI1TUNjaFJZcjhjL3U2R3BJTWhlUGNac3pqTzFZSlJvbmlWb3NW?=
 =?utf-8?B?MGxZWXRPd2xRK1FXZmJqbDRsb0hDMjdzYlV2Mm1KdHZiNXVQRXc2U0RyV2lQ?=
 =?utf-8?B?cEtFOUVhQXhneWZDU09UaVdIR3kxVkFIb0dUVEN3bVQ3K29XNng3YlNZczhY?=
 =?utf-8?B?OTVJTTNZRDhFZ1h6b3lrR2lvWG9PdXJSVGlFTTFEMDF5Wk5KbTExcUtYUFdk?=
 =?utf-8?B?V0RYU1UzQ2hlWlc1VjNUcEU4RlNzTUdwVDFWcFNTZnZWOXpZd2N6VEhoeVZZ?=
 =?utf-8?B?eGJ0Q2xLRTJCejkraHpzUUJaakY2ajB3VDFwcTJjS0JabVpuSnFVUE93Zmxj?=
 =?utf-8?B?SEJ3azRydWE4NnhkblkzN1BlNzhUVGhhT25yRWN4dzRMM0VlYUVmYnpKcGRE?=
 =?utf-8?B?VnVwWU5RSlRwMVBMcGlHZ1dWS0F1ZzFOZlJqN0lTelkvVWpBU1JRcE5Sc2hr?=
 =?utf-8?B?cnBnOXlTYXZDaHAxaTkvL3JIanVRSmdnODloMi9YQ1NvaUpITkVWdkZWb3d0?=
 =?utf-8?B?anFCSGd1SXhIcmh2M3VuY2h6TUFmTVN0cjNaTnZpMEh6aFl6Z1JsSFg0TTJ5?=
 =?utf-8?B?ZC9LdFFjVlIxcWR5dnpLREs5dUR4Y2Y0QkNIRCttT05kMlB3RXZPaXNzbUlT?=
 =?utf-8?B?bkZMS1hzbUZya0FsK1hwNVRyRXh4ZXB4eGtQbGk3VW9kalVHMFpTWG1NSVpV?=
 =?utf-8?B?UEkrUURDSS9CM2c5My9ORHUzYnlkeTFLKzA4VCtmZ2ZaNFlCSXdnN1FFd0ZJ?=
 =?utf-8?B?Sk0vT2JDVlRIRnRqdDAxVW8yWkNqa2doQXl3VjR5SnNNYUJHU0RCK0h5djRu?=
 =?utf-8?B?MUxEN1FDNytFNDl0Y2crRjB0eFYwWCt5b3NzOHVsNVcvQWw2NVg2VllIaUlD?=
 =?utf-8?B?aE5sSTVHNklTYlR5aXd2bFpBNkU0TGhOTmNSWTZNNnEwakppWmhLQVhHWnJL?=
 =?utf-8?B?d0FjamtRK2pXLzdhUkFEV0NUWmhsRUpjKytKdjlOcE1YbnplQXkzNEdzaG9a?=
 =?utf-8?B?UjhLeTZ4NG9WT0tzNEVZZWFBNTFBc1IxaEQybTEzZ2pubHZ5eGtySDBsdVNi?=
 =?utf-8?B?RnF3UHlJK1pPd2w2SksvS1EzNGZqa1YrbVR0M2dYWnc1WHdxTTRvNHpMOUhl?=
 =?utf-8?B?MFhZdEttMlhEeXA4S29uUEgraVc2VWhCUzB4bmEvQ0R0dmpjUDV0SCtUNEpu?=
 =?utf-8?B?VVpXMEl1a0cxeE1lanU3MXIxc2FIdzZFZ0FKSEhZbi9YUU9ocmlTSHgrWmti?=
 =?utf-8?B?ODFKbSsybmh3TU95bU5kZ3AwTzhTRzVoeTlpZTVtV3B6UEhvcUZKYUhlWENP?=
 =?utf-8?B?RXBLak9wUVBlVVJ3Mmd2d3Q5ZVFmR2NBeWthTUZkK2FvRFNpaVdzVGNSRjRs?=
 =?utf-8?B?SWRoY2U3N2w3cERwOWFrWVpycVFTSnFwVHphSTZ1cmRUMHFHcUh5REowS3Rw?=
 =?utf-8?B?R3NyMlZ0a1dadDB6SmRXTG9uU2ZQRkF5aHByTUxhNCtKTUJCRU1NT25vOHZk?=
 =?utf-8?Q?9PGr6es/KgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjAwSHVjSmFHc2RQREhMN05oUHVGVmRsNHVtT3Bubzgzcnk2WlZKTGRLNVJB?=
 =?utf-8?B?RjdWS0d2VWYvbUlGWDRKOWFvT0RKRHVUZVRwVTBCaCs2NjJGSlVQUWdQUCtu?=
 =?utf-8?B?UGY1SFk4cGg1UzNiYU9oMTdmOEg5bVhyaSthV3lUc21xUVgyenBod1pJREhB?=
 =?utf-8?B?b3MwaDVwNlUyRWF3dGY2S0J4eWJTWCs2RXloaEYrMU1qRnBJQW9FSW5MN0V0?=
 =?utf-8?B?L3VwVzZCV2o3c2JhdWp2TVJPd0NoUWRqNFdQVG14N2tVclFGaVQ1M3NzTE5m?=
 =?utf-8?B?cEZDS2xYbUxLZGRpNXdlLzJJVFdrVnY5QnROWkZFU3FMRmZ2SGVvTnBzT2hP?=
 =?utf-8?B?OVhxZ2p5WTV3MjBLWUxqMnRNMVFrSTVjb2RCL1FqNFpNRm5ydDNGZkF5em0v?=
 =?utf-8?B?UnlRUm1nN1Y0a2NOQ01LY3p0MERyZFIxcVlIR0VZM3Z5OVhnK0VjcHAvbkts?=
 =?utf-8?B?YWhJRnZFakdCeXJSaGNvbEVRZ01iallzdmhYRnZHTmZBUFF2K3Nnd0xxTEtQ?=
 =?utf-8?B?T29PNG5XL0NvU09VS25teGtzWGN5Z3l6QW9YK2hIQVBadTc5OUIzZVAyZWVL?=
 =?utf-8?B?NEYxdDNIVnBCRXRiOFhsbWJtaThJOTQ4UzRGOWZOdkYxVnBiRTFTSHFJS3Z3?=
 =?utf-8?B?M21GaS95SkRjU1hWd0FGV2xidE1qcFJhblZkam1RMlI5TkV1a1hIZW85LzJ0?=
 =?utf-8?B?dmpOT2RVazNlbEFieTdpbGFNZm41TngyT0oxWW1scWhpdGQ0MVpuQ1duekFI?=
 =?utf-8?B?UWR4TjNIdUJYYjdMRXJMMTFWU3A2L2xnblRlcEhhcTB5Z3dFenJ5YlBwRzVa?=
 =?utf-8?B?RGhTdXNEU0V4RzdFaVp4a0U2VGF1Wm5rOU02dmVrdVBDNG9Bc0RQY0RQTVpq?=
 =?utf-8?B?T0gwQ0xGVjlwTXRxRElGTTd2UTdtNDF1MnhTVnZNRTVwUmZXN05sYjYzTExy?=
 =?utf-8?B?cG9RUkluS1FSNmVCcVE1Ymo3dWplOUlWeFBIQkp6amdoaGNtejNPK1MxZDIw?=
 =?utf-8?B?VUNvMWZsSFdjZnZzaEdxR3RmSW9hVm1SYytVVXd4TTN3RlFYbUFhMG1oam9j?=
 =?utf-8?B?M2IxNUVoRGtsMElPb3RHajl0QjdxbXMxbko5SHVlRFd4WmlOcmJQelkveHIx?=
 =?utf-8?B?U2VYK2RWbElCWnYrWDlWVnB0TndWcEhzSWRlNjlQazAvcDhTZWRtQW9qOExi?=
 =?utf-8?B?U3NYQksrenBOM2VZQXhQYWJ2WlNVTzVrRWlqQTN6cC9kSEN6MGdnMktlOGZB?=
 =?utf-8?B?VVdNdUpyZEt0cE4zbDNyM3QyQStGRk1QN2tWclhWby9tR1pDZWNmenl5eHhS?=
 =?utf-8?B?c3h0a0VEV0JDQ3A5KzY0MkJIZjBFcHU0aDhWbTdlVHd4MUdkU2dYdmRMRVFK?=
 =?utf-8?B?ZW5FNUlJQmlsZXJ5ejhaMFRYaTIwSHRVamwvZ2dpa0tETThQR0FTUFVod1V5?=
 =?utf-8?B?a2ZQWnA3cmUvZE0rVGtVZTk5U0xlSVBaeEdqeHV2aTF4M2UzcWhLQjFqZEMz?=
 =?utf-8?B?YUJFWE5sNk5wUXc0U0IyM3hEWklEUmZ4WklINElRbmlNeTBZcFlZcytaOVVw?=
 =?utf-8?B?L3VQRVRydkk1WDAzK2xpUnNxVlIxRXg5cjlzMkEzZTFhM2hkVFd4cDN0d0U3?=
 =?utf-8?B?SEVJd3ArNG9FTXE3ekZ3YTVVQjJGZzhEVW5XRlZXaXlaekgrUkxPK2xNbFJL?=
 =?utf-8?B?b1ZiTEdJdjRRYm5ta1dJVkdJNVhZVUtBNW5zRk12b0ZLMklvK3V2aVc3TjNQ?=
 =?utf-8?B?YkRCWFpHSE1GQlkxNnJBTHdlZjN1R2EwOFhRL1IzbUJiditiaW1Yb09TMFdJ?=
 =?utf-8?B?UUMycng5Sm8zUUQ1SkJYM2NHeGJiS3RNQ2c1b25iWGYxTEhCUWVHcTc4ZHc2?=
 =?utf-8?B?Z0RwU3NGcGFualNTY1FpSWl3dU8ybkhSMkZ2MVBBa1hvQnpzakd4UW1XVkV6?=
 =?utf-8?B?a2JOSTIrNTRIRFM0MFZsUzg1UjZKeEViM3l1eUxKYTFmMEZuZklBV21GTnVi?=
 =?utf-8?B?K2pCMm9rekdBMHh3YUE3VG84eWNDb3BVcERPSUNiRWFFbXlUU09CdFI4VzFj?=
 =?utf-8?B?b0YxNjlVU0wzdi82aWtURXpjekFzVTZUVTJHOTRIYzNaZVl6MVhwWURsMEVw?=
 =?utf-8?Q?siLbRR3X5tRimSGHQKnzum91L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672bfc27-5596-4889-8725-08ddbd49e4d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 11:32:02.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vosOidEBfz/RbBcK/pGlt0t0BS/uNF1cEu7dgd71fkSZnT5jBmpCllLg1a5MF9AI7V3TUrVTAuB+tovMv+Xl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154


On 6/27/25 10:32, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:51 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> One question in here for others (probably Dan). When does it makes sense to
> manually request devm region cleanup and when should we let if flow out
> as we are failing the CXL creation anyway and it's one of many things to
> clean up if that happens.
>
>> ---
>>   drivers/cxl/core/region.c | 152 ++++++++++++++++++++++++++++++++++++--
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |   5 ++
>>   3 files changed, 153 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21cf8c11efe3..4ca5ade54ad9 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2319,6 +2319,12 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   	return rc;
>>   }
>>   
>> +/**
>> + * cxl_decoder_kill_region - detach a region from device
>> + *
>> + * @cxled: endpoint decoder to detach the region from.
>> + *
> Stray blank line.


I'll fix it.


>> + */
>>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	down_write(&cxl_region_rwsem);
>> @@ -2326,6 +2332,7 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>   	cxl_region_detach(cxled);
>>   	up_write(&cxl_region_rwsem);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_kill_region, "CXL");
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoder with reserved DPA capacity
>> + * @ways: interleave ways required
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways, void (*action)(void *),
>> +				     void *data)
>> +{
>> +	struct cxl_region *cxlr;
>> +
>> +	scoped_guard(mutex, &cxlrd->range_lock) {
>> +		cxlr = __construct_new_region(cxlrd, cxled, ways);
>> +		if (IS_ERR(cxlr))
>> +			return cxlr;
>> +	}
>> +
>> +	if (device_attach(&cxlr->dev) <= 0) {
>> +		dev_err(&cxlr->dev, "failed to create region\n");
>> +		drop_region(cxlr);
> I'm in two minds about this.  If we were to have wrapped the whole thing
> up in a devres group and on failure (so carrying  on without cxl support)
> we tidy that group up, then we'd not need to clean this up here.
> However we do some local devm cleanup in construct_region today so maybe
> keeping this local makes sense...  Dan, maybe you have a better view of
> whether cleaning up here is sensible or not?
>
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	if (action)
>> +		devm_add_action_or_reset(&cxlr->dev, action, data);
> This is a little odd looking (and can fail so should be error checkeD)
> I'd push the devm registration to the caller.
>

I'll add the result check. The caller can not access the region struct 
right now, so that would imply to "export" more CXL core to drivers.


>> +
>> +	return cxlr;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>> +
>>   int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);

