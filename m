Return-Path: <netdev+bounces-245332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF854CCBAFD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E453230053D0
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602482522A7;
	Thu, 18 Dec 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FxNxv9l4"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01A326929;
	Thu, 18 Dec 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058790; cv=fail; b=QdNj4+sKlGLGoGp+57GLwjU2/JHniIXQMJ+MNj03VCmo+rpta7RZ4JJk826L7guMs//YSTLQPKmet/pdqTrBf6FiGC9MW3/1ahbRAHnpVsVHj577ixCSqDlxOKn5jF5vuawF39cfbW2BT/yTe49JmR9y/Bzjx832mrxIUpg0SGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058790; c=relaxed/simple;
	bh=zWhdGwZ5ZZv8OUvMbyIS8P5DPMrK3lmG0CMqXvBnVFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpIgz9kcpO32cKBsAI2ik6VHB999d72vhTCqCVV3vgv0FkX18IQal5W6CqgMo5CvZcEn5Vocg/2OT44rOlDvLU/kw/N6cb5H/iYOxyCxyIv3ib3HtaKm71KvYoRD4pd86s0nsQqs8RHAj/HlEjWvNmf3FvkwIZ8ETOsv9St+lUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FxNxv9l4; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdxIDdPK4yEaq4lwjD/37GJagqmxVgIz+hr/5a/TCgA8uswdGyD5+2o0X1WvY8idsYFO5Zg0mERXtWd6V3Iykmr5D9RH5ibYuTLKlLGQP96oPwB4P812qmH024419Q3sty2p/TyiE+CjMrO5JtcJSnqgy1itcpZso1WJuBdhOY4J/FxInHiqFJ1E48Ya+8WX8AZo/s+kYOcBAl/pucuV2QgPwSg+RjivlE0FzWCp9iObURzZy9Zag2ZraT7wYSbVF0mihimtirRCq7OOMO3Oe693V3pVYygxzgmngJSCyKGrJORsUl7LeAEWEfZKWH/TXtbaMQ1d3R358mNkrJeVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9T841fxVzbmBApeSyMnZLp+uoUQBCtH51aCS/wOgsA=;
 b=mAV7LGOwSVlChDeQSnc8QWwvshGfbWjcIL9cDvG9ZQV9E3jwRAHpiHO7z8umEbCLFEmbMbheHpYCwwyP/+/E1CBt4y7l8xCfTw8blmFxku2/VYdMCcvq3orCCfru8Na9SzBO4OxpQXr0NBECaHAaayMdjZKTYkwOROYVqZ2OzjDX+dbKRkCPBKz4pMlr20oxgA34Q1n8p7a8WEwc60mKnffh6J4vDmTo9SKX/d/Sm8LvR5+UCZWfDB8scCJnc1SLXTKo8tk5J79RmjQjUzI3YWmJBRKoVlXU+qzh3YGxH5oIcI4ci75OiuBQpQJqmUYeJ3BwIMcbwF/1xDYB0EeHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9T841fxVzbmBApeSyMnZLp+uoUQBCtH51aCS/wOgsA=;
 b=FxNxv9l4ILMy/8GxiQdXa2Uvt03kHVWemW7oyxi3zRTScogbVL+NK/H9+GATDJd4s0S/AGeW4ZshJVYVxNqsuZ5BGEOsGZ+bekD/lzYQUErrpMn59hlGdTC/wWFUcwSK+6FmzCHBjGV5/2p665WpOQSxtf3xXWbl74RFwC4G9zE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 11:53:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 11:53:04 +0000
Message-ID: <f56f7a6b-7931-4264-8d42-50603ce81cba@amd.com>
Date: Thu, 18 Dec 2025 11:52:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 11/25] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
 <20251205115248.772945-12-alejandro.lucero-palau@amd.com>
 <20251215135047.000018f7@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251215135047.000018f7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0562.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 17927245-b21e-43bd-c0ca-08de3e2c0065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alAzSFl2bDJXeVhWcnFmY3dDb1FYNjNUTjJUWkh0aFgyNk9ZdExVNTROUXln?=
 =?utf-8?B?bENrazhoUXBUQlYyeWxYdEJoYnhrYStWWDNQQzREd1hWZVVoMEg3R0JwOWNk?=
 =?utf-8?B?aTNVMGZWSE92TFcyRzNpMjNHdFM5RnVKd3h4RUdIelVEWWx1a1Zlb3NVN25q?=
 =?utf-8?B?VHhnYzZSZmJPanE3eStaMEY1TWlma0RkbE43aGo1ZHNKZG1OL2h0bVBUSkp5?=
 =?utf-8?B?S1NYWjd3Mk5vVzR5Mk15bUszTERueUFiQVdjNTRpSjQ0bzdKMkNJdjJuU0k5?=
 =?utf-8?B?R1FSUG1KUFFtcGNxb21lSTRXTkwraWFqRUNZaFhLaS9EQUVSaTk5ME9LV3Fo?=
 =?utf-8?B?cmxNY2pzallrNTliUDF6SnlyMGNWR2pXYm14dHU3UlRXYktnSlAybXF0dlVJ?=
 =?utf-8?B?eEVYeDd2dTYvV2RzbEZtSG4vQ3phTEVFUklYSVk2VWh3elkyL0x3STQ2MkJo?=
 =?utf-8?B?MFJvWXR1RlJ1ZmVQcDhsZDBvNjlZU2FhdHh2blJ4NDFGSjRjck9YTzlGbFpl?=
 =?utf-8?B?d052bXhocGZuVFF4amVINVk4UDEvUFR4Tnc4cTJ1a2xuVzc0RklTMS84Z1BE?=
 =?utf-8?B?TXFGQjlVVjJZajk3endYd0p1UE1ONUxOKzRIaWJZNnc4bmNKZEIxR0pmOTF5?=
 =?utf-8?B?MlRmNHZZTUUvVHFpTjdGRnlvcHRIMUxMMnpJT0VjMmV0LzJQWjRQcm9xbjZz?=
 =?utf-8?B?ZjlheEFUUlMzd0N6TnJ1MmhYMzlSN1AxVDI0Mmw5eHZoclAxOUxpY0x5bmF4?=
 =?utf-8?B?SjVRdGl3eE1JR3RFR2p6WDFpOExQTzV4bjBEKzRVNmpKbSttYmVaUFhBNklY?=
 =?utf-8?B?cnd4dkNkbC9kMXplUjFCWGZ5YmFRaVpHRVk4UFlJR2l6RlljTjZmVXJzc09P?=
 =?utf-8?B?Sk44bTJkVU5YK1k2T2lmRExsZCs4UWpLR2RjalFZQnV0QlRYT2doVE9FWFhD?=
 =?utf-8?B?TGlEZ2RPK21ZSnBCWC9iN1Y3em04OXBJd0VuNlpqNy9nVFcrK2dKVUREQkFm?=
 =?utf-8?B?VEtjUjRheTlUMU9mL3BORUVYVThYcWM5K2FlUndlWVZuRlZMNEI0QlBRcGlk?=
 =?utf-8?B?R01oVTdIMkZ2R0pKUUhkdjBVTU1SQ2g1QlUwTVVrMExPTWZ5WGxIaDFNc1lv?=
 =?utf-8?B?YkRWWW5abzFvU3M3K05BTUhad28rUG55L2tpemh3NThyeTFKb2k3VXlxU2tM?=
 =?utf-8?B?T2Ezejh4MFJIL2FnTm1TaS9Mbzd6eHVLbk01Ny84M2ZvWFhWRHM2eDJSSGly?=
 =?utf-8?B?TllmWUR5M2NpbFRzZFFlUzBOV1lwZ0thRXBxdVJKelBKR29hTkdtbzVkY3RC?=
 =?utf-8?B?YkRoLzhtWEIrOXczeEM3U2VMNzhjQTluOWlEekt4b21XMC9TT0NFRGNGNE1M?=
 =?utf-8?B?TXpZd3FJSEJPYmkxVVM0WlNPY0J1cElpRHFBNThOd2VlU0tLR29PR2FnVXg1?=
 =?utf-8?B?c01FZTRhbG1oMmVSS3cydndkaitlaDUxdXpQYXZpZHhoNCtaRW53ak5yT1Yy?=
 =?utf-8?B?NHRaRWhTTy9WTEZLbnlXdkxWMUVhWERGTW81d09OZlNsdXhoRzhWWHFxRURx?=
 =?utf-8?B?OGhldUIwazMzL2tyZDRDdU9xRm9UbXB0Qk9Nd2dZN1cxK0ttaXM2VVB0U2NZ?=
 =?utf-8?B?S3hRYzlGQ0x4TXFJMGRCQ3Z1MWhoMU0vdVhJRm9DNkdKbXNFcWc0SXVST0hw?=
 =?utf-8?B?c2NiOGtLVFJzdGlwc3VjSDk3VUZUcmdOQWdqbDVBYUZjczFMblRlVlpSWm5s?=
 =?utf-8?B?QXlvbWZrWVJSSGdZc2dFNlpFZlg1aXMxV2tFT1R3RjMxOGJRZzJYZWNUL0dn?=
 =?utf-8?B?c2xKREhKdHV3SGxFc21yYXZKa05xVFIwWGdzbXp2ZkloZ0NQMHREZE5TR01q?=
 =?utf-8?B?WVJ6bmcyWUZ6dTN3MjlxRGZFcTBMbWVxT3hncjRQVE5UMEszZGVSa1hTNUk0?=
 =?utf-8?Q?jFEoUTH5p6V8JMAlccRE5MvMdWIY3Dlp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2tidUxtMElYQ3o5VVJtczA3dGdEeDRtYzlPRHZ0ZDJ0US92U0t2S0E0Tnhu?=
 =?utf-8?B?aGszVUQ1Q1VNRk05dmRFMVhTY2NJVXIvR2ZSUVNPZlJlMHhBNEhmQUxia1lV?=
 =?utf-8?B?NkVSRCtqKytvOWhLVS91T3JPT1pIM1pmMHZSaytsbWZxTjJENzhWWXhEOHM5?=
 =?utf-8?B?NDl4ekY3UXpuRW5YdHlmVW9NOStsOXJxaXRhVHVod2RiUFFIM09YY25BcnBB?=
 =?utf-8?B?bGQrVXZQd3NISVBMRHV0blFiK29XMkZPSWkxek5zOE1NbXZ6VWtVYTZmNXpU?=
 =?utf-8?B?Vjh5Q0d5T3B5OEFHWW04UklLWXozTlZNUnFiZVgrT2dmS1VST2cvMURmbDA4?=
 =?utf-8?B?ajRBYjRNazlKYU9nRy9yRHJhZ0NyNUdtSVN4MElRTFdUQzdDcmEwc090cmlS?=
 =?utf-8?B?M1I3U25EUE5BMUkxaUM5b2hrUVNOM3Z6VUVkWnpPY3ZGUXZvVmloaDExa0pz?=
 =?utf-8?B?YzZXOW5BN1lBWlZyQ05tYkVOU1NHL1BJRVlGdVlKYy9HL2ZablFkRjFmdnhC?=
 =?utf-8?B?WmVDbkgxcDlSS3RVNkhHQUxLTFY4K1Z0RGowdWJTd1V4Qmdjb2ZhYThxNVZF?=
 =?utf-8?B?V0J5MTd3VEZiMSs4Z2RtUVBPaktSVWZKYmpxRHJ6RUhPejRDRjZMVzFtOUtn?=
 =?utf-8?B?bUtBM1pOdnA5a2NYVGc2UFdxMm9JUmZ0cTM4TWxocTFoN1pJQ1hlcGFmQ0lS?=
 =?utf-8?B?OGp5RVMxYWMvRTRqZXZaK2h2QndtdkVUYXhIWk4vbkJBWk5NVTJlY01yZ3VQ?=
 =?utf-8?B?MHpDL0tVNDVKUU5XdTdiOTdjSXBRSWNpbVcwOE5yQkVjdmZiQ0M3YlRTbVk0?=
 =?utf-8?B?eDNhTW04dmFnY1NmaEVVcWQxRko2c2ppSWlMMFZQaU5FK0N5dkZpUE1JSjZF?=
 =?utf-8?B?NkVuaktBV3NmYVVSZll4R20xNWY1UzNwN2hFNlVFWkdOQkFhWXM0SFZLNk9k?=
 =?utf-8?B?aFRFd0ZSc3d0RDZNOSthV3JqaVRBWXBXRFlKNjFmMzlvQzhpVTgrVGRHVTJV?=
 =?utf-8?B?cDdaQlNZU1Q0ZXJKRXFQZzV2N1FkMGhhR1pXR1VocE9XeXNqOVdlaEllai9u?=
 =?utf-8?B?Qmw0ek9tdE1lb2tBQXRrUHdOTUNVZmRtV05CYmh5NVZNcmVvT2svTHFLRlky?=
 =?utf-8?B?M0l1aFIxem56WUhINWphSW11LzROZkxsL011alRyWVlNbHhhM2JSNFVXN2hW?=
 =?utf-8?B?VWVEZUx6bTR3RXVzNFpzS3VQRXhVSkdPemlrTW00LytDK2xLL1Y2eFh1YTFj?=
 =?utf-8?B?T3hOTllVVmZkVUxJeC9Cd2ltMWN0SGhWcmMxZi95VncvUjcvdklqWTl1cGM2?=
 =?utf-8?B?R1VtTXo5cVpTWHNmeUFva0hRMXJZcjYxN2tGczJwWUxqM2NtL2RWeDZwK3gw?=
 =?utf-8?B?K21vTUNQWnZGRTJxbE8wVWdhbWRwTGFnOUVOWk9yN3ZEQll2Q3U0enBvTml0?=
 =?utf-8?B?ckZUdHE3eitLTGVUK2RSZHFYa2hkbTFtdk5LZDYrM1RWQS9YMlJWLy9oeVhq?=
 =?utf-8?B?bmo3VVVIQ256SUZ3YktLUkFJNmlyZDY5VnJDV2I3VDBBcjFSZ3R6dzZvaUVC?=
 =?utf-8?B?RkpvMDAyampNTlY5V2NSQ0dSMXlDWkE3NW0zam9EWTNzMVJxNVNOMFFyc3RQ?=
 =?utf-8?B?UThLR0p3OVpRSkxFSmZVS0VuellmVlZ0czI0bldSdFpmd0RaUFRnLzhJRmVz?=
 =?utf-8?B?cEFqcjB1WWgrT0xjMkFoZmM4Mjl1OVlwbjZaczNYODBISUxEMlNVNzVVcXhw?=
 =?utf-8?B?MUk0eFFyRzZ4bmNJNS8rNW5OcTdsNWtPMmVnb1k2eGFpS2VWY1ZqaEM2eU13?=
 =?utf-8?B?dERWL1dTcFUyYldGRXUvOXlNTjVvc3l0elVwUFd2ZzVuMWhOWGpyeFVKWkRi?=
 =?utf-8?B?T2ZsMkc3RE9NK0N3TmJ3bFJnMHRSbWNERGJ2bVk1dkpSam5XNVVoc2ZRYkRM?=
 =?utf-8?B?SVRqNmhhaFBDSTVRYi9aRG1oU09VQWZtckVoZ0NCV3pmbzF4OVRQVTNRZXND?=
 =?utf-8?B?ZVNrTUNXRXU3djdsby96Zm9pV3JMVFU5WXdWNHVDVTFOOGp3djk1cE5BUmRz?=
 =?utf-8?B?RVRVZ1RpRmVqbVdWVEQ4LzhObWxSamE0M1FmSEN4SEFVN1BZcE1LMHpOaDN4?=
 =?utf-8?Q?b0m5cfOdrLPt6KXIMYxjqAaSq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17927245-b21e-43bd-c0ca-08de3e2c0065
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 11:53:04.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFGfX0LzeLPDNGo0Lx6ZgWD53rZO5KEysoVYkOijqTSp3RZFZMKjLNtny7mbv+tM9FeffMY7Hp9qu5SHtx4hFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

Hi Jonathan,


On 12/15/25 13:50, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 11:52:34 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type2 device configured by the BIOS can already have its HDM
>> committed. Add a cxl_get_committed_decoder() function for cheking
> checking if this is so after memdev creation.
>
>> so after memdev creation. A CXL region should have been created
>> during memdev initialization, therefore a Type2 driver can ask for
>> such a region for working with the HPA. If the HDM is not committed,
>> a Type2 driver will create the region after obtaining proper HPA
>> and DPA space.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Hi Alejandro,
>
> I'm in two minds about this.  In general there are devices that have
> been configured by the BIOS because they are already in use. I'm not sure
> the driver you are working with here is necessarily set up to survive
> that sort of live setup without interrupting data flows.


This is not mainly about my driver/device but something PJ and Dan agree 
on support along this type2 patchset.

You can see the v21 discussions, but basically PJ can not have his 
driver using the committed decoders from BIOS. So this change addresses 
that situation which my driver/device can also benefit from as current 
BIOS available is committing decoders regardless of UEFI flags like 
EFI_RESERVED_TYPE.


Neither in my case nor in PJ case the device will be in use before 
kernel is executing, although PJ should confirm this.


>
> If it is fair enough to support this, otherwise my inclination is tear
> down whatever the bios did and start again (unless locked - in which
> case go grumble at your BIOS folk). Reasoning being that we then only
> have to handle the equivalent of the hotplug flow in both cases rather
> than having to handle 2.


Well, the automatic discovery region used for Type3 can be reused for 
Type2 in this scenario, so we do not need to tear down what the BIOS 
did. However, the argument is what we should do when the driver exits 
which the current functionality added with the patchset being tearing 
down the device and CXL bridge decoders. Dan seems to be keen on not 
doing this tear down even if the HDMs are not locked.


What I can say is I have tested this patchset with an AMD system and 
with the BIOS committing the HDM decoders for my device, and the first 
time the driver loads it gets the region from the automatic discovery 
while creating memdev, and the driver does tear down the HDMs when 
exiting. Subsequent driver loads do the HDM configuration as this 
patchset had been doing from day one. So all works as expected.


I'm inclined to leave the functionality as it is now, and your 
suggestion or Dan's one for keeping the HDMs, as they were configured by 
the BIOS, when driver exits should require, IMO, a good reason behind it.


> There are also the TSP / encrypted link cases where we need to be careful.
> I have no idea if that applies here.


I would say, let's wait until this support is completed, but as far as I 
know, this is not a requirement for current Type2 clients (sfc and jump 
trading).


> So I'm not against this in general, just not sure there is an argument
> for this approach 'yet'. If there is, give more breadcrumbs to it in this
> commit message.
>
> A few comments inline.
>
>> ---
>>   drivers/cxl/core/hdm.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  3 +++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d3a094ca01ad..fa99657440d1 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -92,6 +92,7 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>   static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>   {
>>   	struct cxl_hdm *cxlhdm;
>> +	struct cxl_port *port;
>>   	void __iomem *hdm;
>>   	u32 ctrl;
>>   	int i;
>> @@ -105,6 +106,10 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>   	if (!hdm)
>>   		return true;
>>   
>> +	port = cxlhdm->port;
>> +	if (is_cxl_endpoint(port))
>> +		return false;
> Why this change?  If it was valid before this patch as an early exit
> then do it in a patch that justifies that not buried in here.


Good catch. I needed this hack for the functionality described, because 
the second time the driver loads this check turns to be positive because 
the memory state. I think I understand the reason behind this decoders 
emulation, but being honest, I do not understand what such emulation 
depends on. I would say once the device advertises HDM, it should never 
depend on other things, what seems to be the case now. I will explain 
more about the problem in the following days.


>> +
>>   	/*
>>   	 * If HDM decoders are present and the driver is in control of
>>   	 * Mem_Enable skip DVSEC based emulation
>> @@ -686,6 +691,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_committed_decoder(struct device *dev, const void *data)
> Function name rather suggests it finds committed decoders on 'whatever'
> but it only works for the endpoint decoders.  Rename it to avoid this
> confusion.


OK


>
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == (port->hdm_end);
> Drop the ()


Sure.


>
>> +}
>> +
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct device *cxled_dev;
>> +
>> +	if (!endpoint)
>> +		return NULL;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
>> +				      find_committed_decoder);
>> +
>> +	if (!cxled_dev)
>> +		return NULL;
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +	*cxlr = cxled->cxld.region;
>> +
>> +	put_device(cxled_dev);
> Probably use a __free() for this.


I'll think about it.


Thanks!


>> +	return cxled;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
>> +
>>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>   {
>>   	u16 eig;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 043fc31c764e..2ff3c19c684c 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -250,4 +250,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_ops *ops);
>> +struct cxl_region;
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr);
>>   #endif /* __CXL_CXL_H__ */

