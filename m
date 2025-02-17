Return-Path: <netdev+bounces-166993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC66A38417
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2887E172867
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8053621C186;
	Mon, 17 Feb 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHGL1egJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646F21CFEC;
	Mon, 17 Feb 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797740; cv=fail; b=adgSR13EbHYmqwgHkq9FT/htWiauwY42BmOCqSd9Wc1ByJNvqLwXVHFRSyGg9JKF09fACnlPjtB6l9OoT7Ebf1UnBrx0uCfjEJFNHA0P7s5yVBCm87geEs+rEdKJb0nJXVSWQOdyVUoMeKJyhOViXcgcWHQPeVqOyOnoPaB1BtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797740; c=relaxed/simple;
	bh=3+3MPF+1/ZuJENi1JjE2M2h5P96SMVnmV4Eona+mT78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toDVDFA6ucfgPbSzauB/uQf3s/CWelKWFJ8nKXCnFFOY7TaT7UU+ne+ClaUOOqEql85/kHLe7MYBRcApqwxRtfH48wBXuf146SgJj7MLFr5gUPpxpOsRJLvMwinHyPFuASx9IYcKTg6CGmhLt8O8L4sIPcHyh58pt1dbrahL2Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHGL1egJ; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXkeJmSobMy1dG4OL14UPSjitUYgU42A7ldPBPPW16bhNuQFQ3uMicnMy+cLe30T4deqC69dNatUQeZh2DaWY2jTkoHuv9bpeD6ZEvVC+W9biLfwL1vGnMcyqAEVzjdUtrce3Jttcj5Ct5WAACQ2aj1XLDDbMW2ERsm+/Qp+7vP9vauqep7+As/MiwJtfeTdnlYE8eNbQzO5n62D30hcyDQL1ioTcVQk4XrDLk4GXZ5HSeLHJ6kAA+KjFX2uTuLYqD78jx38ptBoRPWOiCBCgmZuToF6XmhooAqtxbh+Lq70CaiaXlIxNzWcP9Qka8Tsexx5oNyN9T3lbp6cG/ryXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/rLGo42yxezvpO+m/p19l06J5HP7mdngOZu1LqMAZ8=;
 b=PquLGM8blV45jIZUdzRhnMXst/tnPGAvEuwCER8lNeddkTHsXqhRHnbNRT/F6PHXPopAtTPlHPcAE49h2J+/nPqbp7howMSYLcNZS1xKpoWX+7+1APrf0+AhQzFFjXfdCxP+2li9JwrFRUdz8M+/HlmUEQ3qx48ehLpLAe6KGCrLqy1bkmqx9SVovZNMlfW93J9bXWSknTFYSlHaSwbgv31Jc3In5XUEjT+9yZ1gYi+b5U0EymXoQ0ISnQbj842u1q+9uIUc2sDTj1KNWIpZJn5QXZ4rhY/D0/wA4kUIJCFvZM6ybMSDaGZe/R/hRDoDbhVFVobtTBKbhcDCAGLFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/rLGo42yxezvpO+m/p19l06J5HP7mdngOZu1LqMAZ8=;
 b=HHGL1egJ8nWu6wO8/wPOTFpbz9pJlrXjaMAEj6qWrQ8VXdiNqpOhKwc/iC/wI/LSOvaohhKg1BGJGpBz8kHw3ZI9N+vYdG/Cl0RQXaC9LusipFyVFRhZASIzR2f/L/mL00AaM/FC9Boz31hA3YYROMO19+MTpbDfHn1iw5t8q4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Mon, 17 Feb
 2025 13:08:56 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:08:56 +0000
Message-ID: <53febc56-b131-43b5-a47a-9477e32cad66@amd.com>
Date: Mon, 17 Feb 2025 13:08:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <20250214170223.00003362@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250214170223.00003362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:10:100::49) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: a32901c8-a221-456d-538e-08dd4f543c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEtPanR3WTJHamVwSjhMVmp3azd0TE1RNy8vSTNPVnczdUNWUXVCUjdvY05o?=
 =?utf-8?B?aU8yYTcyWkJkdDVMUU5IZ1I1WExSYVVuS0ZwWjNzOW5NdDZyRHU5ZURrOTJ0?=
 =?utf-8?B?TW9LR1pCclFMVFZiUUxyU3VqeUtmdnpacWNBM2wwQ1BNRjN2VVdWVi9rMVIy?=
 =?utf-8?B?Ky9JN3pIQkM0RGlXZGhneGVjaVBaNzJlVm5YWjJkcHNaeDhUeHYxRlI3WTZO?=
 =?utf-8?B?WWpPYzdTZ0VRMTV0MC9CUlhkY2JzV2dPeUlhUm50UXo0ZjAwUTcxaDVvc3hU?=
 =?utf-8?B?SVAxc2dFVStFaGRnR2xSM1haL0JaRGcyYWdVTlNSR3lrdkFRN0JzdVFZSUVm?=
 =?utf-8?B?VSs5NXhxQTdVVGFNNkdLaXlaVUw5ZnRLdDA2MlZaM01nSXZ1Y3VDWnVvY0x0?=
 =?utf-8?B?QnZoTVgyREpEb3VKRFNHUm81cU9DUXV2bXZpVG5ma3FOWlN4UjFTcDMzc1h0?=
 =?utf-8?B?TGkwNjNnTTFvejlxUVRMemh4UHFvUVlUR0xQNjJXTFdQU3V2S0hiVVE4bE9T?=
 =?utf-8?B?cVJrdGYxaGpKc3lkRXhsMGJKRmpodlNvdFZrVE9YVDI4Q2hhVEE0TlVCTkh6?=
 =?utf-8?B?cnpJbEFGck53RWRYWnhxbXRPYVg1dkxHeE91dUVQVlFWWTdwQUl5dkZTQWR0?=
 =?utf-8?B?dEdabDdwbjQrTmk4MU5EUHhQbGUwUUhwT3NQSVEyamJoTWgzU0l5cHBEZnA3?=
 =?utf-8?B?WHllcUZlMUxVVGJnZURPZE5ZTHlmRU9LRm5EWGRwdnQwM05ZYURrVW9qU2FO?=
 =?utf-8?B?Y3V0WGhwZGM3NVprMkJoSmFBaWgyd3hhSEtXMTZMQW03dlVDWHV0OWg2U1Fr?=
 =?utf-8?B?dkJGOTQ4bGRmQnVBeVREeE1BT0JZR2xpaFQ1OG95dVBJVGJEUjlJUXV1K1JY?=
 =?utf-8?B?VHlOcWxnT2RjTmtxYVFSUFk4SnhrOXM1WjVYcSt5a0xVOW01WmpqQXY0NTQ0?=
 =?utf-8?B?VGF2Z0NYckZLdjJ5V25aR1FXTlFpbytIMjVDSmUwVXZKbWIxYmxlSURQVUZ6?=
 =?utf-8?B?MzJvNnNSN2JqMzZSazg0MTJwbVI5Y3RuQ1ZkUnVMN3U2WGFCM3loR3c1SXUy?=
 =?utf-8?B?STUrQTRVNDFDYkZwRDRiS0ZJWjg0OGUwZTNXQ0xZR29iYTdXdFJqUmo2V2dH?=
 =?utf-8?B?N0kzWlZQaVRhSE5hQndsRDRwYVB2SjZWRlBBRldqWUVIRWo5L2NoM3JoMzVR?=
 =?utf-8?B?REdBV0txTzhIRS84QS9XcUJPVkZxZTcvS2NkL1BWRmc2RU55OFBvUG5xdW4r?=
 =?utf-8?B?Smtvd1hRS3FFUFdFaFc2NlBGZ1Mwd0NxMGRqbmdCb09HaHZOQkg3a1ZoTWpo?=
 =?utf-8?B?TXpsOFpDaVc0dndrQ2xPVHlFMkRXZEFvczR4OTIzMjBqNVBieGdseDFYMlZ5?=
 =?utf-8?B?S08rSFR3dzQzRDBzRmtYNDJpK1FUN2NuQ3RvZDZlYnlpZzA1RzlHc3dLdElE?=
 =?utf-8?B?WTg3elNuaEVwUDYvcHVQNXpOK0xvemJYRmlxM1F4RVIwM2J0V00wMmM4U0Rs?=
 =?utf-8?B?bUJ0L2VXZ1RTYzlSSEtac2w1eDFmT3pvRjg3Q25pK3RZWHFmMnMzOEpFWWhk?=
 =?utf-8?B?eVYwSEdQaFoyTHV6RlJYa3pWdXlGZldqR3pDQ3d2Rkx5bS9Rb0tDaFJDV1Ft?=
 =?utf-8?B?bytLQWtsK21JZzI0SVQ5MXJDcE8wazNZN3F0KzEyVHhCdmV3WTVadFRIeGti?=
 =?utf-8?B?YW1KTzVnT0JKL2twcDkyUHJybUUrdVh5LzNHSXJpcVFkNHE5Qk1lbEZSRm9j?=
 =?utf-8?B?ajEyRkU0aHFTU3lXRElSWk1CVnlyMGFnZVZZOUIwUmkxWkgyWEpzVjI5VDNO?=
 =?utf-8?B?M2hWNzBtM2dLbGNhL3o0UjE4RU0zbTJuQkloc0NNV0ZsQXppV0NMUXp4RE02?=
 =?utf-8?Q?VzuJx6cVsFjyX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE5CU0xxeFFPcm5RNS91TXdxZVM4OHRtU1JBUXJBUnJCRDg5WEZpK0FwV2dH?=
 =?utf-8?B?VkdOM0VrU2VzVWxCWnpSamI5ZFErVmd2TmI2ckc1a3Z3ZVlUeHpQMCtyTTlp?=
 =?utf-8?B?dlB1TTdGdUxtTVRoZVRkZVgvbGdjNUI0cXIzc2xyb2FaT1crOVFIVGtrOW56?=
 =?utf-8?B?U0F5bkNLai9FYnZDZ2VsVjR4cXNOOE5QZndZZHZOZ3ZrTit4NWFtVGZxS2ZO?=
 =?utf-8?B?ZGZza3NadEdNWUNVMGZLdDYvSThHRzJKTFFvaTVRc0ZGVkNOOHpLZExZNW0v?=
 =?utf-8?B?dlZkdW82YmNHTDBhWFJERnMzTUZPRzF3dUJEK09Zd3pYWk8zSUdhNmRmdzIw?=
 =?utf-8?B?RzdGSFZHbk1Dc2o1TFRvREZUWGJYd2FiL1B1TlNIRXYrUnc2TC9ScG9CTi9a?=
 =?utf-8?B?eGk0TEVKY1crdGluaTlwL3FJQlMyYkc3MTZyVFZ1QzNqTHFVUnExNktkM2My?=
 =?utf-8?B?MnZmN2pPcjViSEppR3lZQm5oQkt2ME1jWVVwQk4renVyanpLWWd2YVVMcTVZ?=
 =?utf-8?B?cHpaZ3hXcEdzRWozOTdEa01EQmpqWEpITHhUU3hkd2ZDMmo5L2pOQ3orS1Jr?=
 =?utf-8?B?Y0F6RkNUdEM2MytlYUZMcng0RjRkWm4xUXRzbXljUXFseFJhMEl6aVdQY3pz?=
 =?utf-8?B?SnhmTk80bHBEMGFSRGlVUjZuSFpEVVpPRG1na0dzZmZhSFdVR3J2Z0swbmRT?=
 =?utf-8?B?SldjOTl4bTNVRzhIYVAyMHlReFVQWldkUXYrdFMydmpiL1hiSURVdzVGUXov?=
 =?utf-8?B?RWQ0QXJYUlN3K21GREpTYXNCNFdIdVh6U1R5WUh0bEpLTG0vNEtrdyt1YzA2?=
 =?utf-8?B?dmpKV1BEcUVUMzdQa0lxVmN6MHQwN0tSQkxrVG1zRU1wSlp5MmF2Wm9wU2tk?=
 =?utf-8?B?N3l3STVWYmxkN1F4ZExpd2ZidmhFY0owM0MyQ3FjbW9KTjhZMlJqSmVlaW53?=
 =?utf-8?B?V2Z6MWNxaDdwMzBNclM4NlpoYjIydkRmaXBMSWxmZERwTW5Ccm1NYk12aFVZ?=
 =?utf-8?B?MG02Mk1URGdMY2JwQmhFTkthUmhkc1N1NFMyb0RFWUlFRzZjRDhwQkc2VUV2?=
 =?utf-8?B?SmpCYStNZDB5VHF3SDA5RDlySHNsODEzU09tZkd6WUUxRFVxMHllbGYvTE1R?=
 =?utf-8?B?ZE9NNzRiNEp6a25wcnhjMjBIWE5EeWp4SHRaY3Vob2dCR09LUitRT3U1Zmdw?=
 =?utf-8?B?ejdHZVBFaW9jNVl1MEppTVhNV3Y3TVRxb1Y4YlJ5ZHBrT01GSGVaaSt1V1d4?=
 =?utf-8?B?eHJSRWJVTjhqOExYT2FDTXViWnVuTlFRZk9ldWxqM1l1VVczUks1RmZpMVFh?=
 =?utf-8?B?eWM5WTFhZVVObDBxdWpaRG1RZ01hL1NOM2Z2UWlYUkhPTVZYN2pNQTBwdVJF?=
 =?utf-8?B?UjJFUDcxTlQ5bkFJbG0vWHF6VjRjQTVXcmxveFZ0bTNsR3ozTFNwMld2Rmlm?=
 =?utf-8?B?cTAvNFpTc3VwWlV2M2lHdW9XcEtlRm5SeGpscEQrN3dCT0tndkR0ZCtnWUtp?=
 =?utf-8?B?UGQyZTJUc3lPbWY5YS9ZYUR3RnZWZE8vdWx5ZTI4YVdMUkpVbTA5dWNTT2Np?=
 =?utf-8?B?TCtoT3lTQk9WVEhsUWRyQnZJQnkrcS9hcjJ4UVo0TkdpYVhROGVUTGdtenNh?=
 =?utf-8?B?SWJLQno5WHRmTkR4Tjlwei9KM3VTL2NaNHk2SnpQUzlSejAySmV2ZlppVi95?=
 =?utf-8?B?VUxIUXFLYXVUU3BGbHBDODR6bmN4c2FNbWlLQ2dkbW5jRWJsd1Z4YWxTRlZp?=
 =?utf-8?B?WHU4NWdRWFFDc2dEb3hzc2tmcDBFTXB2VmdRWjYzZFlhMDB5Z0JuWHk5S3NZ?=
 =?utf-8?B?cUI1bUtBRllQcUFUdndzREJseUdXVEZPZzhiRDVENWdmSzRWN3JtWDVhRlU3?=
 =?utf-8?B?K1RBeWhNV1BqYlREV0Q5RFd1c0JHUWpjSjc2NlZsYnpxTFZ0ZkVrRmY4ZEww?=
 =?utf-8?B?OGNXVTRnZHMvYTNiZzhJQkxaMm9Pb1ZiYzEraEFULzlSeXliajhPVC9pTGEr?=
 =?utf-8?B?VGhBazBoK200VmNobTZZbTdDNmp4TUNqOG1CWmQxT0NjWFloVlVIRW05aXhx?=
 =?utf-8?B?UlRmZnM1U1NyOVJ4VURKeVVhNjduellLQUsyYnltS1FjSW1ydHh3dUhucGdV?=
 =?utf-8?Q?3hkPlfQqBQFLOQ+wo6Sh59CX/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32901c8-a221-456d-538e-08dd4f543c21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:08:56.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN05wApxQiBefKalF+BFVL9es3+cKiqHzjYAgwearBGePTlUEYfdP4Xie/axs61V66LbEfTrohZ+VRGld91Fog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031


On 2/14/25 17:02, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 15:19:25 +0000
> alucerop@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for Type2 support, change memdev creation making
>> type based on argument.
>>
>> Integrate initialization of dvsec and serial fields in the related
>> cxl_dev_state within same function creating the memdev.
>>
>> Move the code from mbox file to memdev file.
>>
>> Add new header files with type2 required definitions for memdev
>> state creation.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> One passing comment.
>
>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 536cbe521d16..62a459078ec3 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>>   /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index b2c943a4de0a..bd69dc07f387 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -911,6 +911,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	int rc, pmu_count;
>>   	unsigned int i;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	/*
>>   	 * Double check the anonymous union trickery in struct cxl_regs
>> @@ -924,19 +925,20 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   		return rc;
>>   	pci_set_master(pdev);
>>   
>> -	mds = cxl_memdev_state_create(&pdev->dev);
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		dev_warn(&pdev->dev,
>> +			 "Device DVSEC not present, skip CXL.mem init\n");
>> +
>> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec,
>> +				      CXL_DEVTYPE_CLASSMEM);
>>   	if (IS_ERR(mds))
>>   		return PTR_ERR(mds);
>>   	cxlds = &mds->cxlds;
>>   	pci_set_drvdata(pdev, cxlds);
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>> -	cxlds->serial = pci_get_dsn(pdev);
>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> -	if (!cxlds->cxl_dvsec)
>> -		dev_warn(&pdev->dev,
>> -			 "Device DVSEC not present, skip CXL.mem init\n");
>>   
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..ad63560caa2c
>> --- /dev/null
>> +++ b/include/cxl/pci.h
> Clashes with the cxl reset patch (or should anyway as current version
> of that just duplicates these defines) That will move
> these into uapi/linux/pci_regs.h.
>
> No idea on order things will land, but thought I'd mention it at least
> so no one gets a surprise!
>

Good to know.

Thanks


>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif

