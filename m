Return-Path: <netdev+bounces-161638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D052BA22D35
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0783A24B6
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE751BC9F0;
	Thu, 30 Jan 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5WMhCfA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD47483
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242197; cv=fail; b=Gi36X6CcYm9DDOOAkKFcsf0AMvRIt2c2IwvlLwx11D75TY9rbV+Jrcf1yDcyNvQvect3p7acBY1KnzVBy8uZARKx+bWC97j0LqPbOGcUKRQj7sDMk8g2DHvSeUoJK/yfGACgght9rCCTz4xw0md066beZw2yVtT3wYb+AdLoSqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242197; c=relaxed/simple;
	bh=L0LQAD5eBPLXDhRzEFtDZ5mrsR1lGKdmtwqHFK60LNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bmLaEjwX2eTH3q6ZfA9NyxGjf4gPZ7iTkRrRbJ5PNtLRGYDsXfCqM4WhZg4/9wGR3a0yz7OzkPJi4RBNwx/z/gPLUPcF9BthAPPDbANFQRJUwabLCXzdO3lvLsD+1w+yCnwlMk/ALgbViAehEsEN07wDf8dAK1Dpiw4OEpaRZyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5WMhCfA; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxyTZbJz/0XgVl+QSuUinbDMd9JEhHp53xXCsUl0ftJNWm2Ei3R1RYHN1CIU7/5cDlLF5WvDCQbFGEA0x6Q+tavVAkJtGCAPEfj60YUZgZN7Uj0tMYXO443p6j43ANsFztTeV6bUmcyDi0E2BTkCs7CX2GW4EtpgiwafgcDLO8mMyWstVUdI9sJFF/ljUt4xLya3PJina6toMt/WwBINzzvGIqnBaXEMLG5z4KmzYA/owzIkoRnWSdfOqA9ZVFq/xnA0X3JdLoQRmYXJgy2RgVe5gBpPqmSFI7zSYakLVkXJ4cZVeankkw1FBYzUjByuWdse11b4TfXWH7DiTcaAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0LQAD5eBPLXDhRzEFtDZ5mrsR1lGKdmtwqHFK60LNU=;
 b=CX/5KypgxwqiJpWswvzHWleYy5fZOiI/eexkwXLQQ9G04Jh0rd4IEXWQfkn8mcnD4BgTSQKP08uQmn9+dmB/9gdG+5JenBjRnnRvUFFSkKHxB3UxuB0du2clBD4hoyhdGf/mc1coBLOKCcCBk4QDTfYB8gFOmNtNDJrT1uwcIicF3quxT/yNh8OVl0MmCG/SeuSYL4bYJRIZESezN0l+bSIadg+yaWjNPyOPcuuPwfrFLnBJkTVmblKytOVIV/t3VCnwG33YoacpJg1dBjMYXtWU5kSkpOI1pZ0pBoCBrwLqhOvWk8jFPgDrEPsOUAYRLGqJJaY16rJUluZPJwVnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0LQAD5eBPLXDhRzEFtDZ5mrsR1lGKdmtwqHFK60LNU=;
 b=N5WMhCfApElli0BBm4y9Q1cOvctEQRdji8xJrWpD5EoDzLHAYg38h5dZlyMmg5uuOVsGMQj1q5fKfLg7y2a9+9pVtLQsRorj77ad+1I8OvA6iybkKGFFgZzJc6LLGnc7ZtFeYztt+SgKwZkqJ0pmbkWeMVotoQm/sEsNKK9Om4vZv1MtwQm4HPF4LHaQBDLLPPUAfMae9OJf6vVGADCcaTpUWYs4feL1byT77+zC50j9Vg+INfjkS10VWYK53MMq8hRCLvVsL3i43v2EnJQ9u8cNARir3TCAGU6MirupygfzzOBqAdiBn7kKJq2+KK4ue5q/E537ZvmI4PzBsjKkyw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 13:03:12 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 13:03:12 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mkubecek@suse.cz" <mkubecek@suse.cz>, "matt@traverse.com.au"
	<matt@traverse.com.au>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next v2 05/14] qsfp: Refactor sff8636_show_dom()
 by moving code into separate functions
Thread-Topic: [PATCH ethtool-next v2 05/14] qsfp: Refactor sff8636_show_dom()
 by moving code into separate functions
Thread-Index: AQHbclAE4VZtILLiZEiDnR/NrMdzrbMvP6WAgAAF0nA=
Date: Thu, 30 Jan 2025 13:03:12 +0000
Message-ID:
 <DM6PR12MB451658A7F33CE79514DA1662D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250129131547.964711-1-danieller@nvidia.com>
 <20250129131547.964711-6-danieller@nvidia.com>
 <4aa25d98-4df2-4950-89a4-e749d60116be@linux.dev>
In-Reply-To: <4aa25d98-4df2-4950-89a4-e749d60116be@linux.dev>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SN7PR12MB7420:EE_
x-ms-office365-filtering-correlation-id: 9648e26d-189f-47d0-b235-08dd412e73b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajZYemxzc1FuTTJzRFRwbzJ5MjBqLytxbVdUakowWHczZmhJYVROREdiWFM3?=
 =?utf-8?B?YXJwRDFzYWphYmhjb0Z0RDl2alltbFJxUWs3andnbDgyR051Q3JyZlBsMDNW?=
 =?utf-8?B?UTBsUStkUndaeHhpYU9VMlJWcjZOUloxTlBMMlZJV09NOEFFN2Q0WGgxUy8r?=
 =?utf-8?B?V0dLTHJmd05ndXhXNjhmOEFmaGRscWhXVzFGbnZURDBTWFRWMzJZc2lVdEF4?=
 =?utf-8?B?L2k0YlQ1UlFvYnprQ01ERU9NNUt3VWF5azVuRzV6dklDR0V6WlFZNURKZkZD?=
 =?utf-8?B?bmpIK3RMUmR5VjRkbWZRYW9IQkp4V1dIVnIyYVNyWG5JNUpJc2t0enpPYWt4?=
 =?utf-8?B?OWtzSnk5MUhjRFFMNFlBMDVKeVdGaWFhMzJMM2ZoOWNUZTVwcGVuUWlzNzRQ?=
 =?utf-8?B?Nlo5NHZkL0tGVmVaYVZIdnFZZzcvZDFzMWgyVWlGdFc3cUdhakVIYnpWc2ps?=
 =?utf-8?B?QmtrYW9adXIyclNwTmY1bStYbGJOZUVDL00xQVFla0hRTjFETWo3RWppanho?=
 =?utf-8?B?ZXBTUnJIamRQNVNQbXkrU1dFb3BUK2Z1RTYzcVB0YkJwNzVxNUpDNnJTSm81?=
 =?utf-8?B?QWZQTnVhd2wydG9JM0g1c0N3TmZCQ2hIb2w0T2xHV28rUS9ZNmgyZE9zS1RC?=
 =?utf-8?B?eUlFYTFkY05nOCt1QmxRK0wzZUh2dVFvU3pNWXFYQVVQRGc0TGZhUVIxRVJh?=
 =?utf-8?B?SnZKSHZMWHhLQjFrU3dtMThOUkVOUWFQVFlHSnJqRjNETDdOcnA4S3ZpUS9w?=
 =?utf-8?B?VmU0TmVIZzNCN1I5TmdRRllNR2wrQ2JSYmEwUkJNNTVKV3VCaTZiekE0d2hT?=
 =?utf-8?B?SWlINk81ZDgrUWErMEhhVHZlUHArL1RENkdrZVlhZHJiVnNLcmMwanZ4YzJ1?=
 =?utf-8?B?THBhZ0RnTmV1S2NOdGpQZk12YUNxSnJwOUlSRGU1L0t2YS8xNFBKV3BKN2w5?=
 =?utf-8?B?NGMwSXFVKzcyWmdUaUZ6ZmhGbzJkOXlnZEEzV01SOTErS0hMWGxKOVc1VmxK?=
 =?utf-8?B?VkEweVY5RUp6THc5M21TbDFHOEdFbS9OcHg3TUZKeDFjeUluNmJBWitFV25V?=
 =?utf-8?B?MVp6YlZQK0lwY0VKOExhZVVVNURwTEhHTVc0cnpRaHBDMUFQVVZEVVIrdlZJ?=
 =?utf-8?B?OUZCRW5xM3JYMCszN3BtTlZhMlNCL0t2bEhHdnJ6T1BkVEVCOVVEdzUwSDJR?=
 =?utf-8?B?UVJVN0xSaUNWVHAxU0U3UWtDSEpzZkZzOEtMaWVNajdyQnV1cld3bnJjUGtB?=
 =?utf-8?B?ZUIzVkFpenNRamF4akcrTVFQSHFnditnSCtkWWVJdUNHamMyVGM2VlVuLzEr?=
 =?utf-8?B?OEc3azJtWlBpQVJqTUdoQisvNzJCbmM2TFZOU29WcVVzaERVemx2Q0lqT1E4?=
 =?utf-8?B?NER2SGcvNlJpa1kxK3lDdjcrVFRVRWJEbnBaZjAyZXNiNFNXNzI5ZlBaaGhp?=
 =?utf-8?B?OExrVTQwMFlpQVlUR01jTkVPK0w2L2hWVGhMZTVybjVOTVZoZ1FVQlpNb2Zk?=
 =?utf-8?B?UjZHRWphVFJhbUNIQWV3bGZXbmxTZ3Fsb2syZkJydTRWeUEyZENPTFNzNng1?=
 =?utf-8?B?eFdTNERVSk5sSmwrNFlMbVlHVk1uNzhvWG54VC8vTUZiS05CR1dpWUhZM2pz?=
 =?utf-8?B?aWJoWWlzRGR3UWw0M2FUc2RjdzIwcHBnZGIycytDNGE1eHMwdnMydW56T1VD?=
 =?utf-8?B?aU4rOTduMlZyQzF6QlZsV2pUakF2OUZYOEJvbUJqeEt5S20wZzV6eW90SU1m?=
 =?utf-8?B?WS8xeHd1cjNSYlBQQ3NCSHlJMUtWMUdGMU9aNEo0S1ZKcVBsVGJ0cUFTRzVQ?=
 =?utf-8?B?eUR4ZFV4aUJ3YzVPb0YrRGw2cmpGZEU5RnFIQ2ZpSW01WnExL1ZGYkFEb3Zy?=
 =?utf-8?B?M2Q1YlNVUXVKNHpuTkxCWmJlYXM2Y2MyUGRmS3lORHFjYk5kcnRFYTJueENW?=
 =?utf-8?Q?mwtP3xl5nJe+tkyVk1vSN+ZGR51F6uWu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTNCcmsyek85ZTZXcmlUZzErU2RIdTRkWXAyeHFJZmRBRXo0ZDVJN0VZK3lN?=
 =?utf-8?B?OC9iU3dlOUFFWWNibEFGWDlYYitGVlhZZmhaa0xSVmVKVTFtRkhldGpJRDdv?=
 =?utf-8?B?YnNuTGJON1o0aXd4ZHVMc3BmbzJIM1R6NjRRQ2p0dkxkdFcxZjVjaVdRTDRp?=
 =?utf-8?B?VEV3QWtNOVQ5SnZBRWMxeW1pRytGMlRHVnEyVzdWZS9ucjhnZ3JsckxkRFhr?=
 =?utf-8?B?MHBjaTlPdW5KdXpJYXpudXBncjhlWk5hQjZQa2xVb3BIT0gzS2tvb2ZFa3lu?=
 =?utf-8?B?SWRQSlpQUFBlemEyLzNSd2JXZ1o5YVh6d3FMSFhlbmdSYUVvS1pFSmRrMXo0?=
 =?utf-8?B?WWk2MlpNc3FLb3BxeHI3S0lSaDcwNjc3amJRWlpLYUIvdFZBeWcwWXFTS250?=
 =?utf-8?B?K0ZTVVRkWUpZYnlRbWJnNDVQL0VCbkxMRkxxRllQejYxSEQ2VkdYV0RXMWRE?=
 =?utf-8?B?WlVzekFGQW9NbE9CbjBicVh1RTlHaDY4SThBd3RtSWkwbDM4TUFKTFVDcDN6?=
 =?utf-8?B?ck5KYjloelZ1TGMvUDBvWXFyNHF5WVFwYU9kdTh0V1NqbVplVlVCeFpkc2dm?=
 =?utf-8?B?cmQzWE9uMXFEaG5DcE1QVXkvQ3lzQk1BZFdYRXQ5aU50OXkxWkpZOWNydUhn?=
 =?utf-8?B?K1QrMVJtVW1QcmhPWVpjUi9lTHRJMFVIcis1SG5ycjFmOW1VcTBrUUVRV1JZ?=
 =?utf-8?B?ck9JOEhMMHYyNlV2azRPMFRYMmd3cXYzRnpvbVpiQ1dRSjZCcm0yODAvR01H?=
 =?utf-8?B?V1VMOWVMQm9xMlZQK01uaTI5dndoUDkrYmtrK1BXYjgwSWZFTWc3S2VhTEls?=
 =?utf-8?B?V1JWaHZTZ1pqN2ZLRkVFL3NvMmp3eC8xaGxtSU1oS2tnNGE2Y1NQZmR1NjRz?=
 =?utf-8?B?VU5vTi9PeEw3cmZKQmtrN1JYTHZLcEFRSlJyeSsxMEMxWnJuTFVleGJPbHBP?=
 =?utf-8?B?YmI2TU44d2pXT2xnZlFmNWRiejVBVlMrNDJKWmh4clhsTEczN0hTSXFYM252?=
 =?utf-8?B?UE9OSUxPR0ZENVk3cFNmNmNtcUt1NVF5Uy9kbU03T1dyeWhhVFQ0SVpabDA3?=
 =?utf-8?B?SEorSGJreWc3cHRCblBlOHlaWm5QY0EwTmJhUy9KWk9tQTI0dWRxaG15Tktj?=
 =?utf-8?B?a1F4Y3ZCY2RQN082YjhSS3VIRGZkd0VDTjRGb3I5NWM4NjNqVkNkbzdrTm5J?=
 =?utf-8?B?SFVLWnJYS21LZzNMd01XMnZLSDhLMHJld3lIUWIxcTduZ0tHTGs1TGc3Z1Bh?=
 =?utf-8?B?MHFpUFpXQmFuS3F5UEJ0ZFNCSDgySUhyWmpJYVBxQUN4SnoxbDlBTW43N09z?=
 =?utf-8?B?VituUG9yR1pCT2lSTDFjQnpXeHc4cXNTZTZMUTdFWXJCQVZlQVNJblg1UWN6?=
 =?utf-8?B?RUNWeWdNYmRlN3k1Y3g3M0dzUVMzb1FCQy9lR0NkRmdZU2syYU5aL0txWldL?=
 =?utf-8?B?QUFscHRKUXY2U2Q4RkZrNGxSZTNwSDdSNmN6ZGN1U0I5WmtOQTMyaWhmOUhO?=
 =?utf-8?B?TGd6U2ZTR1YzTU9iZjBFZ09SZHg1K3N2bDQ1em5pQTlUQnRiOHFIYWUrRE5B?=
 =?utf-8?B?WGpXUVdYZGdhWmVMbDl6ZXU0aGlGN2wzMHhuTE9uVU5zaW9rQkR2L29NRU5l?=
 =?utf-8?B?TzdlQmNib1dyVnBWQW9lWFAwMy9vVTlRNmY3djVlY0s0YUs1Njc1L0pQbUlj?=
 =?utf-8?B?UHBTeFdxelNxenRwYyszeERjeml1aG5qTGxjRVNvVG1kdjgwWkdYZXNDcTV3?=
 =?utf-8?B?dHZtcVVuVHNuNEJ6cDZmaWhSTVQ3bjR0MTQ5cldPbDk5UHk3NGJodUJFVXJB?=
 =?utf-8?B?RVJjbE12dzNERHpKcVRibFpkSDZSajkzY002WVBOMUtxR3lXbTZYOHFtTmk5?=
 =?utf-8?B?aG5yYzA0Tk5kL1VSMVd2bnpKK3JZaWIvNW5CYUhWaGt1L0V1aTRqdXk1ZVhX?=
 =?utf-8?B?bTdxWVVFVVJPWmVGai9vYmhySDNwMnNkNklvU3dCeE5wNDNsQlRpL282cXFw?=
 =?utf-8?B?ZGNyL2FhVi9wMzJBaFc3VHVXSDRoSTNjTFQ4OEpDTXRFUkJqZ3AyY0lmZmEx?=
 =?utf-8?B?ck9HZ1N0N1FwdHZGQmlqUFFMejVWb2xyZ3VqcmZrc2RwdVk4VzhEblZVUG1o?=
 =?utf-8?Q?TgDCjeFZ0bQIATI95hbeU7o47?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9648e26d-189f-47d0-b235-08dd412e73b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 13:03:12.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VhOBefwSnng8qtgnNRyVotGrcwp6AAE9HRV37T4fjVWciJ9xlUItUEiXBYrQZ4k0DUK9oUzkQl7gVdflRaEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420

PiBGcm9tOiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IFNl
bnQ6IFRodXJzZGF5LCAzMCBKYW51YXJ5IDIwMjUgMTQ6MjYNCj4gVG86IERhbmllbGxlIFJhdHNv
biA8ZGFuaWVsbGVyQG52aWRpYS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBt
a3ViZWNla0BzdXNlLmN6OyBtYXR0QHRyYXZlcnNlLmNvbS5hdTsgZGFuaWVsLnphaGthQGdtYWls
LmNvbTsNCj4gQW1pdCBDb2hlbiA8YW1jb2hlbkBudmlkaWEuY29tPjsgTkJVLW1seHN3IDxuYnUt
DQo+IG1seHN3QGV4Y2hhbmdlLm52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggZXRo
dG9vbC1uZXh0IHYyIDA1LzE0XSBxc2ZwOiBSZWZhY3Rvcg0KPiBzZmY4NjM2X3Nob3dfZG9tKCkg
YnkgbW92aW5nIGNvZGUgaW50byBzZXBhcmF0ZSBmdW5jdGlvbnMNCj4gDQo+IE9uIDI5LzAxLzIw
MjUgMDU6MTUsIERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4gPiBUaGUgc2ZmODYzNl9zaG93X2Rv
bSgpIGZ1bmN0aW9uIGlzIHF1aXRlIGxlbmd0aHksIGFuZCB3aXRoIHRoZSBwbGFubmVkDQo+ID4g
YWRkaXRpb24gb2YgSlNPTiBzdXBwb3J0LCBpdCB3aWxsIGJlY29tZSBldmVuIGxvbmdlciBhbmQg
bW9yZSBjb21wbGV4Lg0KPiA+DQo+ID4gVG8gaW1wcm92ZSByZWFkYWJpbGl0eSBhbmQgbWFpbnRh
aW5hYmlsaXR5LCByZWZhY3RvciB0aGUgZnVuY3Rpb24gYnkNCj4gPiBtb3ZpbmcgcG9ydGlvbnMg
b2YgdGhlIGNvZGUgaW50byBzZXBhcmF0ZSBmdW5jdGlvbnMsIGZvbGxvd2luZyB0aGUNCj4gPiBh
cHByb2FjaCB1c2VkIGluIHRoZSBjbWlzLmMgbW9kdWxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IHFzZnAuYyB8IDEyNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0NCj4gLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygr
KSwgNDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvcXNmcC5jIGIvcXNmcC5j
DQo+ID4gaW5kZXggZDI3MmRiZi4uOTk0YWQ1ZiAxMDA2NDQNCj4gPiAtLS0gYS9xc2ZwLmMNCj4g
PiArKysgYi9xc2ZwLmMNCj4gPiBAQCAtNjQ5LDEzICs2NDksODUgQEAgb3V0Og0KPiA+ICAgCX0N
Cj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBzZmY4NjM2X3Nob3dfZG9tKGNvbnN0IHN0
cnVjdCBzZmY4NjM2X21lbW9yeV9tYXAgKm1hcCkNCj4gPiArc3RhdGljIHZvaWQgc2ZmODYzNl9z
aG93X2RvbV9jaGFuX2x2bF90eF9iaWFzKGNvbnN0IHN0cnVjdCBzZmZfZGlhZ3MNCj4gPiArKnNk
KQ0KPiA+ICAgew0KPiA+IC0Jc3RydWN0IHNmZl9kaWFncyBzZCA9IHswfTsNCj4gPiAtCWNoYXIg
KnJ4X3Bvd2VyX3N0cmluZyA9IE5VTEw7DQo+ID4gICAJY2hhciBwb3dlcl9zdHJpbmdbTUFYX0RF
U0NfU0laRV07DQo+ID4gICAJaW50IGk7DQo+ID4NCj4gPiArCWZvciAoaSA9IDA7IGkgPCBTRkY4
NjM2X01BWF9DSEFOTkVMX05VTTsgaSsrKSB7DQo+ID4gKwkJc25wcmludGYocG93ZXJfc3RyaW5n
LCBNQVhfREVTQ19TSVpFLCAiJXMgKENoYW5uZWwgJWQpIiwNCj4gPiArCQkJICJMYXNlciB0eCBi
aWFzIGN1cnJlbnQiLCBpKzEpOw0KPiA+ICsJCVBSSU5UX0JJQVMocG93ZXJfc3RyaW5nLCBzZC0+
c2NkW2ldLmJpYXNfY3VyKTsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQgc2ZmODYzNl9zaG93X2RvbV9jaGFuX2x2bF90eF9wb3dlcihjb25zdCBzdHJ1Y3Qgc2ZmX2Rp
YWdzDQo+ID4gKypzZCkgew0KPiA+ICsJY2hhciBwb3dlcl9zdHJpbmdbTUFYX0RFU0NfU0laRV07
DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgU0ZGODYzNl9NQVhf
Q0hBTk5FTF9OVU07IGkrKykgew0KPiA+ICsJCXNucHJpbnRmKHBvd2VyX3N0cmluZywgTUFYX0RF
U0NfU0laRSwgIiVzIChDaGFubmVsICVkKSIsDQo+ID4gKwkJCSAiVHJhbnNtaXQgYXZnIG9wdGlj
YWwgcG93ZXIiLCBpKzEpOw0KPiA+ICsJCVBSSU5UX3hYX1BXUihwb3dlcl9zdHJpbmcsIHNkLT5z
Y2RbaV0udHhfcG93ZXIpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCBzZmY4NjM2X3Nob3dfZG9tX2NoYW5fbHZsX3J4X3Bvd2VyKGNvbnN0IHN0cnVjdCBzZmZfZGlh
Z3MNCj4gPiArKnNkKSB7DQo+ID4gKwljaGFyIHBvd2VyX3N0cmluZ1tNQVhfREVTQ19TSVpFXTsN
Cj4gPiArCWNoYXIgKnJ4X3Bvd2VyX3N0cmluZyA9IE5VTEw7DQo+ID4gKwlpbnQgaTsNCj4gPiAr
DQo+ID4gKwlpZiAoIXNkLT5yeF9wb3dlcl90eXBlKQ0KPiA+ICsJCXJ4X3Bvd2VyX3N0cmluZyA9
ICJSZWNlaXZlciBzaWduYWwgT01BIjsNCj4gPiArCWVsc2UNCj4gPiArCQlyeF9wb3dlcl9zdHJp
bmcgPSAiUmN2ciBzaWduYWwgYXZnIG9wdGljYWwgcG93ZXIiOw0KPiA+ICsNCj4gPiArCWZvciAo
aSA9IDA7IGkgPCBTRkY4NjM2X01BWF9DSEFOTkVMX05VTTsgaSsrKSB7DQo+ID4gKwkJc25wcmlu
dGYocG93ZXJfc3RyaW5nLCBNQVhfREVTQ19TSVpFLCAiJXMgKENoYW5uZWwgJWQpIiwNCj4gPiAr
CQkJIHJ4X3Bvd2VyX3N0cmluZywgaSsxKTsNCj4gPiArCQlQUklOVF94WF9QV1IocG93ZXJfc3Ry
aW5nLCBzZC0+c2NkW2ldLnJ4X3Bvd2VyKTsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIHZvaWQNCj4gPiArc2ZmODYzNl9zaG93X2RvbV9jaGFuX2x2bF9mbGFncyhjb25zdCBz
dHJ1Y3Qgc2ZmODYzNl9tZW1vcnlfbWFwDQo+ICptYXApDQo+ID4gK3sNCj4gPiArCWJvb2wgdmFs
dWU7DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBtb2R1bGVfYXdfY2hh
bl9mbGFnc1tpXS5mbXRfc3RyOyArK2kpIHsNCj4gPiArCQlpZiAobW9kdWxlX2F3X2NoYW5fZmxh
Z3NbaV0udHlwZSAhPQ0KPiBNT0RVTEVfVFlQRV9TRkY4NjM2KQ0KPiA+ICsJCQljb250aW51ZTsN
Cj4gPiArDQo+ID4gKwkJdmFsdWUgPSBtYXAtDQo+ID5sb3dlcl9tZW1vcnlbbW9kdWxlX2F3X2No
YW5fZmxhZ3NbaV0ub2Zmc2V0XSAmDQo+ID4gKwkJCW1vZHVsZV9hd19jaGFuX2ZsYWdzW2ldLmFk
dmVyX3ZhbHVlOw0KPiA+ICsJCXByaW50ZigiXHQlLTQxcyAoQ2hhbiAlZCkgOiAlc1xuIiwNCj4g
PiArCQkgICAgICAgbW9kdWxlX2F3X2NoYW5fZmxhZ3NbaV0uZm10X3N0ciwNCj4gPiArCQkgICAg
ICAgKGkgJSBTRkY4NjM2X01BWF9DSEFOTkVMX05VTSkgKyAxLA0KPiANCj4gTG9va3MgbGlrZSB0
aGlzIHdheSB3aWxsIG9ubHkgd29yayB3aGVuIE1PRFVMRV9UWVBFX1NGRjg2MzYgcHJvcGVydGll
cw0KPiBzdGFydHMgYXQgKG9mZnNldCAlIFNGRjg2MzZfTUFYX0NIQU5ORUxfTlVNKSA9PSAwLiBN
YXliZSB3ZSBoYXZlIHRvDQo+IHNhdmUgdGhlIG9mZnNldCBvZiB0aGUgZmlyc3QgU0ZGODYzNiBp
dGVtIGluIG1vZHVsZV9hd19jaGFuX2ZsYWdzW10gPw0KDQpZb3UgYXJlIGJhc2ljYWxseSByaWdo
dCwgYnV0IG5vdCBzdXJlIGlmIGl0IGlzIHJlbGV2YW50IGluIHRoaXMgY2FzZS4NClNpbmNlIGlm
IHRoZSBudW1iZXIgb2YgY2hhbm5lbHMgY2hhbmdlcywgdGhlbiBhbGwgdGhlIGNoYW5uZWxzIGZp
ZWxkIHdpbGwgYmUgY2hhbmdlZCBhY2NvcmRpbmdseS4gU28gaXQgc2hvdWxkIHN0YXkgaW4gbXVs
dGlwbGVzIG9mIFNGRjg2MzZfTUFYX0NIQU5ORUxfTlVNLg0KDQo+IA0KPiA+ICsJCSAgICAgICB2
YWx1ZSA/ICJPbiIgOiAiT2ZmIik7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyB2b2lkDQo+ID4gK3NmZjg2MzZfc2hvd19kb21fbW9kX2x2bF9mbGFncyhjb25zdCBzdHJ1Y3Qg
c2ZmODYzNl9tZW1vcnlfbWFwDQo+ICptYXApDQo+ID4gK3sNCj4gPiArCWludCBpOw0KPiA+ICsN
Cj4gPiArCWZvciAoaSA9IDA7IG1vZHVsZV9hd19tb2RfZmxhZ3NbaV0uc3RyOyArK2kpIHsNCj4g
PiArCQlpZiAobW9kdWxlX2F3X21vZF9mbGFnc1tpXS50eXBlID09DQo+IE1PRFVMRV9UWVBFX1NG
Rjg2MzYpDQo+ID4gKwkJCXByaW50ZigiXHQlLTQxcyA6ICVzXG4iLA0KPiA+ICsJCQkgICAgICAg
bW9kdWxlX2F3X21vZF9mbGFnc1tpXS5zdHIsDQo+ID4gKwkJCSAgICAgICBPTk9GRihtYXAtDQo+
ID5sb3dlcl9tZW1vcnlbbW9kdWxlX2F3X21vZF9mbGFnc1tpXS5vZmZzZXRdDQo+ID4gKwkJCQkg
ICAgICYgbW9kdWxlX2F3X21vZF9mbGFnc1tpXS52YWx1ZSkpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBzZmY4NjM2X3Nob3dfZG9tKGNvbnN0IHN0cnVjdCBzZmY4
NjM2X21lbW9yeV9tYXAgKm1hcCkNCj4gew0KPiA+ICsJc3RydWN0IHNmZl9kaWFncyBzZCA9IHsw
fTsNCj4gPiArDQo+ID4gICAJLyoNCj4gPiAgIAkgKiBUaGVyZSBpcyBubyBjbGVhciBpZGVudGlm
aWVyIHRvIHNpZ25pZnkgdGhlIGV4aXN0ZW5jZSBvZg0KPiA+ICAgCSAqIG9wdGljYWwgZGlhZ25v
c3RpY3Mgc2ltaWxhciB0byBTRkYtODQ3Mi4gU28gY2hlY2tpbmcgZXhpc3RlbmNlDQo+ID4gQEAg
LTY4Nyw1MSArNzU5LDEzIEBAIHN0YXRpYyB2b2lkIHNmZjg2MzZfc2hvd19kb20oY29uc3Qgc3Ry
dWN0DQo+IHNmZjg2MzZfbWVtb3J5X21hcCAqbWFwKQ0KPiA+ICAgCXByaW50ZigiXHQlLTQxcyA6
ICVzXG4iLCAiQWxhcm0vd2FybmluZyBmbGFncyBpbXBsZW1lbnRlZCIsDQo+ID4gICAJCShzZC5z
dXBwb3J0c19hbGFybXMgPyAiWWVzIiA6ICJObyIpKTsNCj4gPg0KPiA+IC0JZm9yIChpID0gMDsg
aSA8IFNGRjg2MzZfTUFYX0NIQU5ORUxfTlVNOyBpKyspIHsNCj4gPiAtCQlzbnByaW50Zihwb3dl
cl9zdHJpbmcsIE1BWF9ERVNDX1NJWkUsICIlcyAoQ2hhbm5lbCAlZCkiLA0KPiA+IC0JCQkJCSJM
YXNlciB0eCBiaWFzIGN1cnJlbnQiLCBpKzEpOw0KPiA+IC0JCVBSSU5UX0JJQVMocG93ZXJfc3Ry
aW5nLCBzZC5zY2RbaV0uYmlhc19jdXIpOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCWZvciAoaSA9
IDA7IGkgPCBTRkY4NjM2X01BWF9DSEFOTkVMX05VTTsgaSsrKSB7DQo+ID4gLQkJc25wcmludGYo
cG93ZXJfc3RyaW5nLCBNQVhfREVTQ19TSVpFLCAiJXMgKENoYW5uZWwgJWQpIiwNCj4gPiAtCQkJ
CQkiVHJhbnNtaXQgYXZnIG9wdGljYWwgcG93ZXIiLCBpKzEpOw0KPiA+IC0JCVBSSU5UX3hYX1BX
Uihwb3dlcl9zdHJpbmcsIHNkLnNjZFtpXS50eF9wb3dlcik7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+
IC0JaWYgKCFzZC5yeF9wb3dlcl90eXBlKQ0KPiA+IC0JCXJ4X3Bvd2VyX3N0cmluZyA9ICJSZWNl
aXZlciBzaWduYWwgT01BIjsNCj4gPiAtCWVsc2UNCj4gPiAtCQlyeF9wb3dlcl9zdHJpbmcgPSAi
UmN2ciBzaWduYWwgYXZnIG9wdGljYWwgcG93ZXIiOw0KPiA+IC0NCj4gPiAtCWZvciAoaSA9IDA7
IGkgPCBTRkY4NjM2X01BWF9DSEFOTkVMX05VTTsgaSsrKSB7DQo+ID4gLQkJc25wcmludGYocG93
ZXJfc3RyaW5nLCBNQVhfREVTQ19TSVpFLCAiJXMoQ2hhbm5lbCAlZCkiLA0KPiA+IC0JCQkJCXJ4
X3Bvd2VyX3N0cmluZywgaSsxKTsNCj4gPiAtCQlQUklOVF94WF9QV1IocG93ZXJfc3RyaW5nLCBz
ZC5zY2RbaV0ucnhfcG93ZXIpOw0KPiA+IC0JfQ0KPiA+ICsJc2ZmODYzNl9zaG93X2RvbV9jaGFu
X2x2bF90eF9iaWFzKCZzZCk7DQo+ID4gKwlzZmY4NjM2X3Nob3dfZG9tX2NoYW5fbHZsX3R4X3Bv
d2VyKCZzZCk7DQo+ID4gKwlzZmY4NjM2X3Nob3dfZG9tX2NoYW5fbHZsX3J4X3Bvd2VyKCZzZCk7
DQo+ID4NCj4gPiAgIAlpZiAoc2Quc3VwcG9ydHNfYWxhcm1zKSB7DQo+ID4gLQkJYm9vbCB2YWx1
ZTsNCj4gPiAtDQo+ID4gLQkJZm9yIChpID0gMDsgbW9kdWxlX2F3X2NoYW5fZmxhZ3NbaV0uZm10
X3N0cjsgKytpKSB7DQo+ID4gLQkJCWlmIChtb2R1bGVfYXdfY2hhbl9mbGFnc1tpXS50eXBlICE9
DQo+IE1PRFVMRV9UWVBFX1NGRjg2MzYpDQo+ID4gLQkJCQljb250aW51ZTsNCj4gPiAtDQo+ID4g
LQkJCXZhbHVlID0gbWFwLQ0KPiA+bG93ZXJfbWVtb3J5W21vZHVsZV9hd19jaGFuX2ZsYWdzW2ld
Lm9mZnNldF0gJg0KPiA+IC0JCQkJbW9kdWxlX2F3X2NoYW5fZmxhZ3NbaV0uYWR2ZXJfdmFsdWU7
DQo+ID4gLQkJCXByaW50ZigiXHQlLTQxcyAoQ2hhbiAlZCkgOiAlc1xuIiwNCj4gPiAtCQkJICAg
ICAgIG1vZHVsZV9hd19jaGFuX2ZsYWdzW2ldLmZtdF9zdHIsDQo+ID4gLQkJCSAgICAgICAoaSAl
IFNGRjg2MzZfTUFYX0NIQU5ORUxfTlVNKSArIDEsDQo+ID4gLQkJCSAgICAgICB2YWx1ZSA/ICJP
biIgOiAiT2ZmIik7DQo+ID4gLQkJfQ0KPiA+IC0JCWZvciAoaSA9IDA7IG1vZHVsZV9hd19tb2Rf
ZmxhZ3NbaV0uc3RyOyArK2kpIHsNCj4gPiAtCQkJaWYgKG1vZHVsZV9hd19tb2RfZmxhZ3NbaV0u
dHlwZSA9PQ0KPiBNT0RVTEVfVFlQRV9TRkY4NjM2KQ0KPiA+IC0JCQkJcHJpbnRmKCJcdCUtNDFz
IDogJXNcbiIsDQo+ID4gLQkJCQkgICAgICAgbW9kdWxlX2F3X21vZF9mbGFnc1tpXS5zdHIsDQo+
ID4gLQkJCQkgICAgICAgKG1hcC0NCj4gPmxvd2VyX21lbW9yeVttb2R1bGVfYXdfbW9kX2ZsYWdz
W2ldLm9mZnNldF0NCj4gPiAtCQkJCSAgICAgICAmIG1vZHVsZV9hd19tb2RfZmxhZ3NbaV0udmFs
dWUpID8NCj4gPiAtCQkJCSAgICAgICAiT24iIDogIk9mZiIpOw0KPiA+IC0JCX0NCj4gPiArCQlz
ZmY4NjM2X3Nob3dfZG9tX2NoYW5fbHZsX2ZsYWdzKG1hcCk7DQo+ID4gKwkJc2ZmODYzNl9zaG93
X2RvbV9tb2RfbHZsX2ZsYWdzKG1hcCk7DQo+ID4NCj4gPiAgIAkJc2ZmX3Nob3dfdGhyZXNob2xk
cyhzZCk7DQo+ID4gICAJfQ0KDQo=

