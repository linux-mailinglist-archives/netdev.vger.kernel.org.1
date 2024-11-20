Return-Path: <netdev+bounces-146502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6C9D3CA5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1601F210AC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00C1AA7A4;
	Wed, 20 Nov 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMzHAS0h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95519D060;
	Wed, 20 Nov 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110026; cv=fail; b=Kct3tj8Hbgh4JE0WajoWPJLJm8Z/5cdWX1NkuVTdsnepcq2GOBjV1/Sh45lw8B+08n1d7Lw5luKApvk2huxxhXeAEqz/3JchFWS6rTZMMQlE8F5cLcwK9F/AkNr/DN8txNJfAMFRvlhi81ergdcapAmxXmWfog5oQNjeNfr5CO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110026; c=relaxed/simple;
	bh=eqNuj3P/xu9M/ko33mVsKeJDjovHYKpIGZiN3unaqac=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R0hnlf3tWM2A+wnjtn8p1Yxo7uNSj5LtrJuGrqQi+7oFzkAWDQsiZYUZ5LOd/SKNN+nw3ezRU6rxNjfgrUB/bSYyIjDL3llO8gfiFYPa1ndXg/Ux5mKs8a1irvJCqwBxlOcYsZNXbn8/kqBDgscClKNTmkPwwyJYCtONwQpJ6c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMzHAS0h; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc9I0Zb+SMCQmNPd68aFtm4xq9Fy4PE4SvyZmWQldDxgTNeSoOvjJoSHrGXJy07vDE2WRv3ab1tegukrlLxyTDJop29q6PxCJ3wDaDJpIpTCG+zi5Z0Ad1DM+rcXjo0KTpqN6IaCXoog1z/cweADX7ma11vuQ37tzzBndHUFrgAmm7e96yCLginSHSXwqFV0/loDmvQssbgw7oLi8JqqYx8MIl0KvUplrjkwP6fHPc5UO2bx7q1hsaxuSyiA612VrlnK6RApaTdhCPw2itr7jijgDP8wDLfQmHqvJ8TeMVfaEDi4lxPSAtxd/wnqgG7pCkKAAnshAvmSsVcW4sJUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OprV0wO0/oK47tFksKK6yQW0b/xkNBx1j2lqAaYyxfw=;
 b=h6fr9ZXhab6Z8kEdTTESbV16b6LYY45C6Bc8Darw5SsO6d3PUA76Hnc6H7bP8+QVYTan2wrO7fWMr2wRF6YioC4ylYJOXpgGXONOPGMW7w/L+1yOrMtjhXU60Y9yB1cwgMxWiDqi0GLkT3usOu19Q4b57ujXa/jLTycPFbCy1O4tzr/NoTVSiLNnQ6WpTLMiwsidylm/1UUTZxqYFCVZit3NEfmYXz/rxM1Vlbu5f4E6QuxmayWL7+Bs6qxuoiDi5NgGnRkjs0uXcQekMOlytG9ZEWoxdbEKJLDM7Oc1YKItcIyLmH1pbQMf8xn0RH2oaEriTFznQA8Zu48+1hE5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OprV0wO0/oK47tFksKK6yQW0b/xkNBx1j2lqAaYyxfw=;
 b=BMzHAS0hVBs8c6/ggWaup8evR49hgC+6nst3mPb1GhHmlWtheM9NLN57yJPsF/Q0+OPJIFZvnBnIcWbQLGqJ1IZhaH0MkEnQy5jNQzhBThVYv+qanWmDYEpmY7t2So25CuGBOX+ogQtIi/YEKai58Pf4BAf+rOO4ywKF75hpowk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:40:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:40:20 +0000
Message-ID: <939f28ba-6a24-0174-e42d-59e4ba78c262@amd.com>
Date: Wed, 20 Nov 2024 13:40:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
 <41e259fe-0947-4366-bd06-a9c67a5a6e73@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <41e259fe-0947-4366-bd06-a9c67a5a6e73@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 177c20d0-ab60-477e-3c95-08dd0968e051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzhtZUN5ZVhkdDc4dTBld01haXdwdndvc0Z4OHNsTzBYYVZEL0tTM3dwUXYy?=
 =?utf-8?B?QnJTSFFESXNpdnBtZmlHUlNkZUpYdlA1Qm9tSm1TY2RUbHg5dDhIS3Y1UjdJ?=
 =?utf-8?B?Q01uOHJadWRxVEFUS1VsRzRlV05MM20yMVdqaUgzeFRqc1NuL2JLT3VKcVR2?=
 =?utf-8?B?QjNOd3pBM3RhWFJZWDhnSngxbmc3TlVMYXJ6UWxmc2V6VnRaNWFjYTNWVmtT?=
 =?utf-8?B?Skp0RmUzdFMvaXVUTGtQOUhudXp3dGlaWmNYREtPcDlRUVpiQnd0N3VoQ2dp?=
 =?utf-8?B?empRYmo2WnlCcWg2bmdZZ3BJU2pJSWQ5S1FDVkFFQVRyQXpiem1VVWc4Uk9G?=
 =?utf-8?B?elF6Qkpvdm5uNkdvaTB2Q0FpRWkxUXU3MTQ5bzVDd1JROHhJMSs1engxQk9O?=
 =?utf-8?B?dWt1aUpPZzJESUlJdldNcWlJM0RRejJJd05PUXdwbWlyeEQrL1FzVDNQZmlu?=
 =?utf-8?B?S2JYZW1WaDNkZVpwWDVIdVBDbms3T1pyS0oxYXRpT0tTd09LOFZnTlJsby9y?=
 =?utf-8?B?dVlPV2Rud2o5MUMyTStwQ1A3K0JWTTdDZUx2OXozLzlRMEc5Mm1yRHBBOVJ0?=
 =?utf-8?B?OFR3NDFVdDRjSlNTcklLUzN1WkhBaEJoT0xMRVlRZkNpUTgxSnZmSVIrWFcx?=
 =?utf-8?B?QXdybFo5aURDS29BY3J5ZzN3THZwNGdHckpyS3pFNHdtYStTSUYwMVNmM2x4?=
 =?utf-8?B?N1lxSll1Q01SUHY2SklXVUlheWpFWDRYczB4Vm5tczJmMnA2SEpiM3ZpSmpG?=
 =?utf-8?B?NkJTMkhKOXZEeTFzQ2NoQXNPTEVyaUlTN2ZnMnh4Q0Z3ZmM4UHlzV0dqeExz?=
 =?utf-8?B?UW5qc1VpbTcrRnlkRG1WMTUxTDNPa0t2eGpNNDFKam1SSElEVnllZjN3UE5G?=
 =?utf-8?B?c0F4RDFuc2RXVE5tMnAzakpseTNuSlVCNUhBV1lQTzc5QW1vS0hwVFFISGNV?=
 =?utf-8?B?OHJEM3QwWGcySmRUZHBEQUxSM04zS2dZdHdKMjFqUWZyeE9TWDZDdmJlRlhp?=
 =?utf-8?B?WEh6cmpRK3ZMNGhjMCtVNDNaVXl6aXpxQWNuVWl3a1IzWDZwVTNEVHJsNUFY?=
 =?utf-8?B?M2pEOUF3ZTF6SWh0ckZkc1RtcW5Nc1pCNEY0UzNUbmU1SVlJWHE1MU9GSVJs?=
 =?utf-8?B?VzNTTEY1bjIreFowcTJMLzhyd05VV3VxUmRjWFRwbml0dDg0dThxN0hkclhJ?=
 =?utf-8?B?cjlQSnhhbk1QcHBnOHRLNFNrVDd3cTBPYmF4elpFNnZyOGh6S0tiUVBsOXdK?=
 =?utf-8?B?NXVrQUtLcksxWnlhUnZOVm9lMTE2NXpjaEwvSjl4VWZiSFdoeXJZaFpyZnRh?=
 =?utf-8?B?ZStlQ2Fha0UrUy90UGV0TEJLMDNlRW5UODJFcTJPdFhnaDV2RDZmNHBrYmxz?=
 =?utf-8?B?WEpsQlZUSEFMcG83U1JJbTFua3plSUtidzhkbmZYRkFFbGxGOVdxL2o2R211?=
 =?utf-8?B?a3JycitZcXJGL3VzeGVGVDNscnRqZnJKZUx2YWtBU1Zib0RVTjhiUmpyczE3?=
 =?utf-8?B?RW5TSDBCZVlnYm9MdUlWdDk3YVlweHdISzJZOXZTRXg4amU4SENROWx5b0po?=
 =?utf-8?B?cDE0UzIxSmpNTDIxNXR4aFZkcFdzQ0tNREhCR2FoeEVseUtRTXBnQjhUcGIy?=
 =?utf-8?B?ZCsxbzJrVWIzR1RDQ0ROSXd1dzc0bXhUV0NMVm5JeHRlcjlyZ29CSHVnYUpy?=
 =?utf-8?B?TkxZdndtOUMycFI4SjlOVWxUQllLM3owNHBFQ1k2eUVKaHEwcW9QM1BwZkpD?=
 =?utf-8?Q?iY718YRgnkdW5yYvg0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1pvUVh4dVhpWlNTM3pMNWFleEtNWFR2VjhYMW5jWGorTlNLbnIzNTJEYmlr?=
 =?utf-8?B?M3RCTjVQUHJtbXdQcDJxblNObk5UdlpGSlhReGVHbVJBT3c0NWhoa3pvQ0tR?=
 =?utf-8?B?dFRWUkc2VmpIYW44MUx0L255eU9aMEhSUEpQZkFqMUFRblFyK0tuNER6U3h2?=
 =?utf-8?B?cU0rb2Z4bVFMZTNvaEQxWjYyOWFYTmRVbHJ3ZHN4c3llNVJUTnRrQUYzWlp0?=
 =?utf-8?B?YWkxNzJ2ZFBIYkRrOVhOekh5RmxVUzY0aE8rdEQ0eElyRnZZWkR5Q1VIYWoz?=
 =?utf-8?B?ZmJqQmVMQjlxMTR3VWQ1K3pMMTBKczJoUWZuYUxUSEhwcGF1aXl4eUh4NTk5?=
 =?utf-8?B?Yjh6V2l1eWZGMW9saUNDV2c1YlppeTJWcFBCaVdxZzMzV3grWDVhSEdwQ29Z?=
 =?utf-8?B?TXpSVkZGRzJNZTRPdGN4d2t0dGQ2M014bmNYdlM5YXU4ZEhNUVdQekNMcVEz?=
 =?utf-8?B?ZkYrc0VzaWw3Y3N1ZnFlQmJ6R3p0Mml5M2pNQlVqL0JVSTg2OHlBL2IyckFY?=
 =?utf-8?B?TWoyZ3U0R0FtZUZZanBWdm14RHZpSHdYWmdjU3dVWS9OUk5qM09kMjE3OE0x?=
 =?utf-8?B?SUVGOGl3SDNraGF6OUN1aUZScDM3eldLK0h1dlFreDlwWnhXbEhzek51akp4?=
 =?utf-8?B?UVhPV1V5Z0pYbkJ1NU5GK1UrSTVOcjlMckhyMUhWWXdPNVBBdXQycGRHaDJw?=
 =?utf-8?B?QjVtKzcvRkpvUVRFNy83YllGVnIyZnI5MGNEMHBocE0xTTBIVC9CSk5WeDhh?=
 =?utf-8?B?NnA5bU03c25RcUFVOVZUNlNrbUkycVRTNUFFbi9TWXgycTF0MC81TGVlN1pp?=
 =?utf-8?B?bHgrUGpSakRYRUc3THJnOUFTQkx0aFJQSVF3YThCYVhERTRNTnJtTnRjTm9o?=
 =?utf-8?B?ZW92SVV3T0s5TUMxcEVYaEEvWnRjYTZBTU0vR3JMcGVjdXhsVEc1Y3BXL3N6?=
 =?utf-8?B?ZU5LMDBHQWFXRVloZXRyaXJwbHZjK2tnZTBHM0lLcy91VEdBcjJITGhJMzRy?=
 =?utf-8?B?UklDNnllWXh2ZVErM1laQlpWclNxeEdvblcwOXZ4WFUrcXhwWmJlM2pLZ2tO?=
 =?utf-8?B?MWpEVHBFeTAwRzVVc1Y3d3VmY1h6VnNSOHVObEhIclBCUkdoRXE0MzYrQktm?=
 =?utf-8?B?Y2ErMlViazlkSFQxZ2JpV1U0Y1BheWh4U2R5ZkFMckxkUERFdGsvN3NOOVFp?=
 =?utf-8?B?a3VFNFpXOVFZV2VmWDViWEFaTU9GWk0xZTUyR0hZMFFNQmpVM3FvV3pmK1Bk?=
 =?utf-8?B?WHdwMHdzSTlTNXh6Rm4rZHVGdTBycnJBUVkyWTIxcStEV21RcXV2TTlVUjFt?=
 =?utf-8?B?MkJRL3Fwei9KY3NQOUNFSTNGYlBxcDlQMFQ3YzdlSDRQMjdhNkFKeW1sSjJk?=
 =?utf-8?B?NDE2OXZMQkZjcGM4UXZYV3k3S1V3MkJGSTdwVTZaRFVjMU9FbmNIQ2NwMUIw?=
 =?utf-8?B?NEpqZUFvYndDaVJ6ZDhyUnRyb3pDejZCaFV3RlF3dXFPM0J0b2M1dFlNVnhH?=
 =?utf-8?B?NEhkaThma3JzUWZ2YlVaU2JrSkczOFJoaEFlZ3dTQUc3Y1NGd2kxOHQ1V00v?=
 =?utf-8?B?a0lndHNTVmEwcG8xU0Z3NFp1dlVkWlBTZWFvbmlPazhhODk0WUVuYTJVMDRi?=
 =?utf-8?B?ajNKSGt0clhwVHkvaHpyYTNFcVBReWxUR3l3cUpEd3ViT2grekVFVFdXVkt4?=
 =?utf-8?B?OHluOUtwbFY0Zno1cmMzV01TSXNRVEU2aElJM1IwR0lEQVJNOE9DWUg1YW5N?=
 =?utf-8?B?V2ZERjVkd1p3MXVXdm1iVFloNmJQUXdvc2tlSjhDeUcxc3pQQkNuY3RWZG4r?=
 =?utf-8?B?S0hqY09udGtCWnZHSXRzRWJhTTF4TGViZE1DOVBGRXY2cDNTcmdWVmdQbHgw?=
 =?utf-8?B?QWJpRW00eDRJNWtQQVNVdnljU0pkLzd0VHVOQ1M2QkdGQ1kvcUZZd0NTRUNS?=
 =?utf-8?B?aW4xRTlmditCKzF1YU5HY3A5Y3hNc0wvcGV5aUVOV3FlWjNlOHUrN3RTTlhN?=
 =?utf-8?B?OE9XZnNWeEFKTXJVUThhd1B0dGVxWGtsWllCaFRQNXdZaStpcVpSRktKQ1NM?=
 =?utf-8?B?RU9wMnpaN0dCWkdVTWt1cnJGNzZsSmFVTittVFJoYmlZb1E5d2w4QlBtaUJy?=
 =?utf-8?Q?J1FCVBdxy7tAgyud7qD04EVoK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177c20d0-ab60-477e-3c95-08dd0968e051
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:40:20.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMrxaVjKBBiDGPLv2XPE+tC6y7OC2wTkq+TE3sUGCUhCT8JC+zMMUNGxFmseskuOFCYoWhlHccG+8d0vQ64dWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026


On 11/18/24 21:55, Dave Jiang wrote:
>
> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
> Please consider:
> Differentiate CXL memory expanders (type 3) from CXL device
> accelerators (type 2) with a new ...


I'll do.


>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Based on previous work by Dan Williams [1]
>>
>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>


Thanks!


>> ---
>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c    |  1 +
>>   drivers/cxl/cxlpci.h      | 16 ------------
>>   drivers/cxl/pci.c         | 13 +++++++---
>>   include/cxl/cxl.h         | 21 ++++++++++++++++
>>   include/cxl/pci.h         | 23 ++++++++++++++++++
>>   6 files changed, 105 insertions(+), 20 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 84fefb76dafa..d083fd13a6dd 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. */
>>   
>> +#include <cxl/cxl.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops)
>>   {
>> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
>> +
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial = serial;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
>> +
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 420e4be85a1f..ff266e91ea71 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>> +#include <cxl/pci.h>
>>   #include <linux/units.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/device.h>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4da07727ab9c..eb59019fe5f3 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -14,22 +14,6 @@
>>    */
>>   #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>>   
>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE					0
>> -#define   CXL_DVSEC_CAP_OFFSET		0xA
>> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> -
>>   #define CXL_DVSEC_RANGE_MAX		2
>>   
>>   /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 188412d45e0d..0b910ef52db7 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +#include <cxl/cxl.h>
>> +#include <cxl/pci.h>
>>   #include <linux/unaligned.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/moduleparam.h>
>> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	/*
>>   	 * Double check the anonymous union trickery in struct cxl_regs
>> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	pci_set_drvdata(pdev, cxlds);
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>> -	cxlds->serial = pci_get_dsn(pdev);
>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> -	if (!cxlds->cxl_dvsec)
>> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>>   		dev_warn(&pdev->dev,
>>   			 "Device DVSEC not present, skip CXL.mem init\n");
>>   
>> +	cxl_set_dvsec(cxlds, dvsec);
>> +
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..19e5d883557a
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/ioport.h>
>> +
>> +enum cxl_resource {
>> +	CXL_RES_DPA,
>> +	CXL_RES_RAM,
>> +	CXL_RES_PMEM,
>> +};
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..ad63560caa2c
>> --- /dev/null
>> +++ b/include/cxl/pci.h
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

